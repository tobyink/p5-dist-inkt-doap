use 5.010001;
use strict;
use warnings;

package Dist::Inkt::Role::Test::Changes;

our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.020';

use Moose::Role;
with qw(
	Dist::Inkt::Role::Test
	Dist::Inkt::Role::RDFModel
);

after BUILD => sub {
	my $self = shift;
	
	$self->setup_prebuild_test(sub {
		my $self = shift;
		
		my ($latest_in_meta) = $self->doap_project->sorted_releases;
		$latest_in_meta = $latest_in_meta->revision;
		
		my $current_version = $self->version;
		
		unless ($self->version eq $latest_in_meta)
		{
			$self->log("Latest version according to DOAP metadata is $latest_in_meta, but this is $current_version");
			die "Please update DOAP changelog";
		}
	});
};

1;
