Return-Path: <linux-fsdevel+bounces-71867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F40CD75AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0492230B4D67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC9734BA21;
	Mon, 22 Dec 2025 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0PXMgvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABA34C137
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442688; cv=none; b=CPGfZaTAcT0P6+4JsH7fA4kNaHwfH0NMAs8LnA6Omr8xEPA8XEzLJXVz/qSjqrpNbF6ioEh84jYL7O1uj8MgWZ+wHslUQwv9nGyj/ju2SvDFDMqICn3jlTW1yst45LzV9kTklUhmGovc0KltdhBJn7pQKBQh0GMuj9JFQD5PU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442688; c=relaxed/simple;
	bh=LeLIq/QHZ44uBDvxiluuFK7hS2uE1G1QrRz3KH3gEvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnZ4Hm7B+rGrv9HO6zsQH4UHDyj2SPypWnqd4Yrh8PvM2GM9+4sXKx7GFLGkjQsf5GvoTjop2hi6VQIjNNZxXS63LD/BY3lNLObqJGUwJadxPUeHlKMY4Y1XOALDUCSOBCNo/4E7f7vrxzED9tIymCg2YQQ25Nr4MS6rS0s/g8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0PXMgvz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGZgtxmqftJyuRzKpmrt1rXSK3SeIWsuV+CAaik6rSI=;
	b=O0PXMgvz3qFBiFMmOU9OHNMuaztZExnQz6vhfnExx8z2hpNtM13Q/kFnspSNeMPSUTfeRm
	U86OWMWAtPeFM2NcuIRufCoxpXXpHC4qERQ+emOMIYfMBqdXKDChL9sIA8hhpA/zdl2/S4
	JeOIMPgt52B6jO85xEtkVzDRUJtRB6g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-IQPp_qo7PkaVJ6D2it_zNQ-1; Mon,
 22 Dec 2025 17:31:18 -0500
X-MC-Unique: IQPp_qo7PkaVJ6D2it_zNQ-1
X-Mimecast-MFC-AGG-ID: IQPp_qo7PkaVJ6D2it_zNQ_1766442677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58EA318002C1;
	Mon, 22 Dec 2025 22:31:17 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42177180049F;
	Mon, 22 Dec 2025 22:31:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/37] cifs: SMB1 split: Separate out SMB1 decls into smb1proto.h
Date: Mon, 22 Dec 2025 22:29:46 +0000
Message-ID: <20251222223006.1075635-22-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Separate out SMB1 declarations scriptedly into smb1proto.h.  Script below:

	#!/usr/bin/perl -w
	use strict;
	unless (@ARGV) {
	    die "Usage: $0 <c_file1> [<c_file2> ...]\n";
	}

	# Data tracking
	my %funcs = ();		# Func name => { func prototype }
	my %headers = ();	# Header filename => { header content }
	my %c_files = ();	# C filename => { ordered func list, header pref }
	my %cmarkers = ();	# C filename marker => { header filename it's in }

	# Parse state
	my $pathname = "-";
	my $lineno = 0;

	sub error(@) {
	    print STDERR $pathname, ":", $lineno, ": ", @_, "\n";
	    exit(1);
	}

	sub pad($) {
	    # Reindent the function arguments to line the arguments up with the char
	    # after the opening bracket on the func argument list
	    my ($lines) = @_;
	    return $lines if ($#{$lines} <= 0);
	    my $has_empty = 0;
	    for (my $i = 0; $i <= $#{$lines}; $i++) {
		$lines->[$i] =~ s/^[ \t]+//;
		$has_empty = 1 if ($lines->[$i] eq "");
	    }

	    if ($has_empty) {
		my @clean = grep /.+/, @{$lines};
		$lines = \@clean;
	    }

	    my $indlen = index($lines->[0], "(");
	    return $lines if ($indlen < 0);
	    my $indent = "";
	    $indlen++;
	    $indent .= "\t" x ($indlen / 8);
	    $indent .= " " x ($indlen % 8);

	    my @padded = ();
	    my $acc = "";
	    my $len = -$indlen;
	    for (my $i = 0; $i <= $#{$lines}; $i++) {
		my $argument = $lines->[$i];
		my $arglen = length($argument);
		my $last = ($i == $#{$lines} ? 1 : 0);

		if ($i == 0 ||
		    $i == 1) {
		    $acc .= $argument;
		    $acc .= ";" if ($last);
		    $len += $arglen + $last;
		    next;
		}
		if (!$acc) {
		    $acc = $indent . $argument;
		    $acc .= ";" if ($last);
		    $len += $arglen + $last;
		    next;
		}
		if ($indlen + $len + 1 + $arglen + $last > 79) {
		    push @padded, $acc;
		    $acc = $indent . $argument;
		    $acc .= ";" if ($last);
		    $len = $arglen + $last;
		    next;
		}

		$acc .= " " . $argument;
		$acc .= ";" if ($last);
		$len += 1 + $arglen + $last;
	    }
	    push @padded, $acc if ($acc);
	    return \@padded;
	}

	sub earliest(@) {
	    my $ret = -1;
	    foreach (@_) {
		$ret = $_ if ($ret < 0 || ($_ >= 0 && $_ < $ret));
	    }
	    return $ret;
	}

	foreach my $file (@ARGV) {
	    # Open the file for reading.
	    next if $file =~ /trace[.]h$/;
	    next if $file =~ /smbdirect[.][ch]$/;
	    open my $fh, "<$file"
		or die "Could not open file '$file'";
	    $pathname = $file;
	    $lineno = 0;

	    my $filename;
	    my @file_content = ();
	    my @copy = ();

	    my $state = 0;
	    my $qual = "";
	    my $type = "";
	    my $funcname = "";
	    my @funcdef = ();
	    my $bracket = 0;
	    my $comment = 0;
	    my $smb1 = 0;
	    my $header = 0;
	    my $inline = 0;
	    my $file_marker = "";
	    my $config = "";
	    my $c_file = 0;

	    $filename = $pathname;
	    $filename =~ s!.*/!!;

	    if ($file =~ m!.h$!) {
		my %new_h_file = (
		    path    => $pathname,
		    fname   => $filename,
		    content => [],
		    );
		$header = \%new_h_file;
		$headers{$filename} = \%new_h_file;
	    } elsif ($file =~ m!.c$!) {
		my %new_c_file = (
		    path  => $pathname,
		    fname => $filename,
		    funcs => [],
		    );
		$c_file = \%new_c_file;
		$c_files{$filename} = \%new_c_file;
	    } else {
		warn("Ignoring unexpected file $file\n");
		next;
	    }

	    $smb1 = 1 if ($file =~ m!/smb1ops.c|/cifssmb.c|/cifstransport.c!);

	    foreach my $line (<$fh>) {
		$lineno++;
		chomp($line);
		push @copy, $line;
		if (!$line) {
		    # Blank line
		    push @file_content, @copy;
		    @copy = ();
		    next;
		}

		# Handle continuation or end of block comment.  Look for C file
		# prototype insertion point markers.
		if ($comment) {
		    if ($line =~ m![*]/!) {
			if ($comment == 2 && $file_marker) {
			    $cmarkers{$file_marker} = $file_marker;
			    push @copy, "#C_MARKER " . $file_marker;
			    $file_marker = 0;
			}
			$comment = 0;
		    } else {
			$comment++;
			if ($comment == 2 && $line =~ m! [*] ([a-z][a-z_0-9]*[.][c])$!) {
			    $file_marker = $1;
			    print("Found file marker ", $file_marker, " in ", $filename, "\n");
			}
		    }
		    push @file_content, @copy;
		    @copy = ();
		    next;
		}

		# Check cpp directives, particularly looking for SMB1 bits
		if ($line =~ /^[#]/) {
		    if ($header) {
			if ($line =~ /ifdef.*(CONFIG_[A-Z0-9_])/) {
			    error("multiconfig") if $config;
			    $config = $1;
			    $smb1++ if ($config eq "CONFIG_CIFS_ALLOW_INSECURE_LEGACY");
			} elsif ($line =~ /endif/) {
			    $smb1-- if ($config eq "CONFIG_CIFS_ALLOW_INSECURE_LEGACY");
			    $config = "";
			}
		    }
		    push @file_content, @copy;
		    @copy = ();
		    next;
		}

		# Exclude interference in finding func names and return types
		if ($line =~ /^[{]/ ||
		    $line =~ /##/ ||
		    $line =~ /^[_a-z0-9A-Z]+:$/ || # goto label
		    $line =~ /^do [{]/ ||
		    $line =~ m!^//!) {
		    push @file_content, @copy;
		    @copy = ();
		    next;
		}

		# Start of a block comment
		if ($line =~ m!^/[*]!) {
		    $comment = 1 unless ($line =~ m![*]/!);
		    push @file_content, @copy;
		    @copy = ();
		    next;
		}

		# End of a braced section, such as a function implementation
		if ($line =~ /^[}]/) {
			$type = "";
			$qual = "";
			$funcname = "";
			@funcdef = ();
			push @file_content, @copy;
			@copy = ();
			next;
		}

		if ($line =~ /^typedef/) {
		    $type = "";
		    $qual = "";
		    $funcname = "";
		    @funcdef = ();
		    push @file_content, @copy;
		    @copy = ();
		    next;
		}

		# Extract function qualifiers.  There may be multiple of these in more
		# or less any order.  Some of them cause the func to be skipped (e.g. inline).

		if ($line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)\W/ ||
		    $line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)$/) {
		    error("Unexpected qualifier '$1'") if ($state != 0);
		    while ($line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)\W/ ||
			   $line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)$/) {
			$qual .= " " if ($qual);
			$qual .= $1;
			$inline = 1 if ($1 eq "inline");
			$inline = 1 if ($1 eq "__always_inline");
			$line = substr($line, length($1));
			$line =~ s/^\s+//;
		    }
		}

		if ($state == 0) {
		    # Extract what we assume to be the return type
		    if ($line =~ /^\s/) {
			push @file_content, @copy;
			@copy = ();
			next;
		    }
		    while ($line =~ /^(unsigned|signed|bool|char|short|int|long|void|const|volatile|(struct|union|enum)\s+[_a-zA-Z][_a-zA-Z0-9]*|[*]|__init|__exit|__le16|__le32|__le64|__be16|__be32|__be64)/) {
			$type .= " " if $type;
			$type .= $1;
			$line = substr($line, length($1));
			$line =~ s/^\s+//;
		    }
		    if ($line =~ /^struct [{]/) {
			# Ignore structure definitions
			$type = "";
			$qual = "";
			$funcname = "";
			@funcdef = ();
			push @file_content, @copy;
			@copy = ();
			next;
		    }
		    if (index($line, "=") >= 0) {
			# Ignore assignments
			$type = "";
			$qual = "";
			$funcname = "";
			@funcdef = "";
			push @file_content, @copy;
			@copy = ();
			next;
		    }

		    # Try and extract a function's type and name
		    while ($line =~ /(^[_a-zA-Z][_a-zA-Z0-9]*)/) {
			my $name = $1;
			$line = substr($line, length($name));
			next if ($line =~ /^[{]/);
			$line =~ s/^\s+//;

			my $ch = substr($line, 0, 1);
			last if ($ch eq "[" || $ch eq ";"); # Global variables

			if ($ch eq "(") {
			    # Found the function name
			    $state = 1;
			    $line = substr($line, 1);
			    $funcname = $name;
			    my $tmp = $qual . $type . " " . $funcname . "(";
			    $tmp =~ s/[*] /*/;
			    push @funcdef, $tmp;
			    $bracket = 1;
			    last;
			}

			if ($type) {
			    last if (index($line, ";") >= 0 && index($line, "(") == -1);
			    error("Unexpected name '$name' after '$type'");
			}

			$type .= " " if $type;
			$type .= $name;
			if ($line =~ /^(\s*[*]+)/) {
			    my $ptr = $1;
			    $type .= $ptr;
			    $line = substr($line, length($ptr));
			}
		    }
		}

		# Try and extract a function's argument list
		my $from = 0;
		if ($state == 1) {
		    while (1) {
			my $o = index($line, "(", $from);
			my $c = index($line, ")", $from);
			my $m = index($line, ",", $from);

			my $b = earliest($o, $c, $m);
			if ($b < 0) {
			    push @funcdef, $line
				unless ($line eq "");
			    last;
			}
			my $ch = substr($line, $b, 1);

			# Push the arguments separately on to the list
			if ($ch eq ",") {
			    push @funcdef, substr($line, 0, $b + 1);
			    $line = substr($line, $b + 1);
			    $from = 0;
			} elsif ($ch eq "(") {
			    # Handle brackets in the argument list (e.g. function
			    # pointers)
			    $bracket++;
			    $from = $b + 1;
			} elsif ($ch eq ")") {
			    $bracket--;
			    if ($bracket == 0) {
				push @funcdef, substr($line, 0, $b + 1);
				$line = substr($line, $b + 1);
				$state = 2;
				last;
			    }
			    $from = $b + 1;
			}
		    }
		}

		if ($state == 2) {
		    $inline = 1 if ($qual =~ /inline/);
		    #print("QUAL $qual $type $funcname $inline ", $#funcdef, "\n");
		    if (!$header &&
			$qual !~ /static/ &&
			$funcname ne "__acquires" &&
			$funcname ne "__releases" &&
			$funcname ne "module_init" &&
			$funcname ne "module_exit" &&
			$funcname ne "module_param" &&
			$funcname ne "module_param_call" &&
			$funcname ne "PROC_FILE_DEFINE" &&
			$funcname !~ /MODULE_/ &&
			$funcname !~ /DEFINE_/) {

			# Okay, we appear to have a function implementation
			my $func;
			my $dup = 0;

			if (exists($funcs{$funcname})) {
			    $func = $funcs{$funcname};
			    if (exists $func->{body}) {
				print("dup $funcname\n");
				$dup = 1;
			    }
			} else {
			    my %new_func = (
				name => $funcname,
				cond => "",
				legacy => 0,
				);
			    $func = \%new_func;
			    $funcs{$funcname} = $func;
			    $func->{body} = pad(\@funcdef);
			}
			$func->{body} = pad(\@funcdef);
			$func->{legacy} = 1 if $smb1;

			if ($funcname eq "cifs_inval_name_dfs_link_error") {
			    $func->{cond} = "#ifdef CONFIG_CIFS_DFS_UPCALL";
			} elsif ($funcname eq "cifs_listxattr") {
			    $func->{cond} = "#ifdef CONFIG_CIFS_XATTR";
			}

			push @{$c_file->{funcs}}, $func
			    unless $dup;
		    } elsif (!$header || $inline) {
			# Ignore inline function implementations and other weirdies
			push @file_content, @copy;
		    } elsif ($header && !$inline) {
			push @file_content, "#FUNCPROTO " . $funcname;

			my $func;

			if (exists($funcs{$funcname})) {
			    $func = $funcs{$funcname};
			    $func->{lineno} = $lineno;
			    $func->{pathname} = $pathname;
			} else {
			    my %new_func = (
				name => $funcname,
				cond => "",
				lineno => $lineno,
				pathname => $pathname,
				legacy => 0,
				);
			    $func = \%new_func;
			    $funcs{$funcname} = $func;
			}

			$func->{legacy} = 1 if $smb1;
		    }

		    @funcdef = ();
		    $type = "";
		    $qual = "";
		    $funcname = "";
		    $inline = 0;
		    $state = 0;
		    @copy = ();
		}
		if ($line =~ /;/) {
		    $type = "";
		    $qual = "";
		    $funcname = "";
		    @funcdef = ();
		    $state = 0;
		    push @file_content, @copy;
		    @copy = ();
		}
	    }
	    close($fh);

	    if ($header) {
		$header->{content} = \@file_content;
	    }
	}

	sub write_header($)
	{
	    my ($header) = @_;
	    my $path = $header->{path};
	    my $legacy = 0;

	    $legacy = 1 if ($path =~ m!smb1proto[.]h!);

	    my @output = ();

	    foreach my $line (@{$header->{content}}) {
		if ($line =~ "^[#]C_MARKER (.*)") {
		    my $file_marker = $cmarkers{$1};
		    my $c_file = $c_files{$file_marker};
		    print("Found $line\n");
		    foreach my $func (@{$c_file->{funcs}}) {
			print("func ", $func->{name}, "\n");
			push @output, @{$func->{body}};
		    }
		    next;
		} elsif ($line =~ "^[#]FUNCPROTO ([_a-zA-Z0-9]+)") {
		    my $funcname = $1;
		    my $func = $funcs{$funcname};
		    if (!$func->{body}) {
			print($func->{pathname}, ":", $func->{lineno}, ": '", $funcname,
			      "' dead prototype\n");
			next;
		    }
		    if ($func->{legacy} == $legacy) {
			#push @output, $line;
			push @output, @{$func->{body}};
		    }
		} else {
		    push @output, $line;
		}
	    }

	    open my $fh, ">$path"
		or die "Could not open file '$path' for writing";
	    foreach my $f (@output) {
		print($fh $f, "\n") or die $path;
	    }
	    close($fh) or die $path;
	}

	foreach my $h (keys(%headers)) {
	    write_header($headers{$h});
	}

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifsproto.h | 226 +++-----------------------------------
 fs/smb/client/fscache.h   |   5 +
 fs/smb/client/smb1proto.h | 201 +++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+), 213 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 6454c5847724..b151796b3ba5 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -105,23 +105,10 @@ int compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		       struct TCP_Server_Info *server, const int flags,
 		       const int num_rqst, struct smb_rqst *rqst,
 		       int *resp_buf_type, struct kvec *resp_iov);
-int SendReceive(const unsigned int xid, struct cifs_ses *ses,
-		struct smb_hdr *in_buf, unsigned int in_len,
-		struct smb_hdr *out_buf, int *pbytes_returned,
-		const int flags);
-int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
-		     char *in_buf, unsigned int in_len, int flags);
 int cifs_sync_mid_result(struct mid_q_entry *mid,
 			 struct TCP_Server_Info *server);
-struct mid_q_entry *cifs_setup_request(struct cifs_ses *ses,
-				       struct TCP_Server_Info *server,
-				       struct smb_rqst *rqst);
-struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *server,
-					     struct smb_rqst *rqst);
 int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 		    struct smb_rqst *rqst);
-int cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
-		       bool log_error);
 int wait_for_free_request(struct TCP_Server_Info *server, const int flags,
 			  unsigned int *instance);
 int cifs_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
@@ -137,9 +124,6 @@ send_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
 }
 
 int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *mid);
-int SendReceive2(const unsigned int xid, struct cifs_ses *ses,
-		 struct kvec *iov, int n_vec, int *resp_buf_type /* ret */,
-		 const int flags, struct kvec *resp_iov);
 
 void smb2_query_server_interfaces(struct work_struct *work);
 void cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
@@ -178,8 +162,6 @@ int map_and_check_smb_error(struct TCP_Server_Info *server,
 unsigned int header_assemble(struct smb_hdr *buffer, char smb_command,
 			     const struct cifs_tcon *treeCon, int word_count
 			     /* length of fixed section (word count) in two byte units  */);
-int small_smb_init_no_tc(const int smb_command, const int wct,
-			 struct cifs_ses *ses, void **request_buf);
 int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
 		   struct TCP_Server_Info *server,
 		   const struct nls_table *nls_cp);
@@ -321,46 +303,15 @@ int cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
 		       struct nls_table *nls_info);
 int cifs_enable_signing(struct TCP_Server_Info *server,
 			bool mnt_sign_required);
-int CIFSSMBNegotiate(const unsigned int xid, struct cifs_ses *ses,
-		     struct TCP_Server_Info *server);
 
 int CIFSTCon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	     struct cifs_tcon *tcon, const struct nls_table *nls_codepage);
 
-int CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
-		  const char *searchName, struct cifs_sb_info *cifs_sb,
-		  __u16 *pnetfid, __u16 search_flags,
-		  struct cifs_search_info *psrch_inf, bool msearch);
-
-int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
-		 __u16 searchHandle, __u16 search_flags,
-		 struct cifs_search_info *psrch_inf);
-
-int CIFSFindClose(const unsigned int xid, struct cifs_tcon *tcon,
-		  const __u16 searchHandle);
-
-int CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-		     u16 netfid, FILE_ALL_INFO *pFindData);
-int CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
-		     const char *search_name, FILE_ALL_INFO *data,
-		     int legacy /* old style infolevel */,
-		     const struct nls_table *nls_codepage, int remap);
-int SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
-			const char *search_name, FILE_ALL_INFO *data,
-			const struct nls_table *nls_codepage, int remap);
-
-int CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			 u16 netfid, FILE_UNIX_BASIC_INFO *pFindData);
-int CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			 const unsigned char *searchName,
-			 FILE_UNIX_BASIC_INFO *pFindData,
-			 const struct nls_table *nls_codepage, int remap);
-
-int CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
-		    const char *search_name,
-		    struct dfs_info3_param **target_nodes,
-		    unsigned int *num_of_nodes,
-		    const struct nls_table *nls_codepage, int remap);
+
+
+
+
+
 
 int parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 			unsigned int *num_of_nodes,
@@ -370,138 +321,14 @@ int parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
 			  struct cifs_sb_info *cifs_sb,
 			  struct smb3_fs_context *ctx);
-int CIFSSMBQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
-		   struct kstatfs *FSData);
-int SMBOldQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
-		  struct kstatfs *FSData);
-int CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			 __u64 cap);
-
-int CIFSSMBQFSAttributeInfo(const unsigned int xid, struct cifs_tcon *tcon);
-int CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon);
-int CIFSSMBQFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon);
-int CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			struct kstatfs *FSData);
-
-int SMBSetInformation(const unsigned int xid, struct cifs_tcon *tcon,
-		      const char *fileName, __le32 attributes,
-		      __le64 write_time, const struct nls_table *nls_codepage,
-		      struct cifs_sb_info *cifs_sb);
-int CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
-		       const char *fileName, const FILE_BASIC_INFO *data,
-		       const struct nls_table *nls_codepage,
-		       struct cifs_sb_info *cifs_sb);
-int CIFSSMBSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-		       const FILE_BASIC_INFO *data, __u16 fid,
-		       __u32 pid_of_opener);
-int CIFSSMBSetFileDisposition(const unsigned int xid, struct cifs_tcon *tcon,
-			      bool delete_file, __u16 fid,
-			      __u32 pid_of_opener);
-int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
-		  const char *file_name, __u64 size,
-		  struct cifs_sb_info *cifs_sb, bool set_allocation,
-		  struct dentry *dentry);
-int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
-		       struct cifsFileInfo *cfile, __u64 size,
-		       bool set_allocation);
-
-int CIFSSMBUnixSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			   const struct cifs_unix_set_info_args *args, u16 fid,
-			   u32 pid_of_opener);
-
-int CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			   const char *file_name,
-			   const struct cifs_unix_set_info_args *args,
-			   const struct nls_table *nls_codepage, int remap);
-
-int CIFSSMBMkDir(const unsigned int xid, struct inode *inode, umode_t mode,
-		 struct cifs_tcon *tcon, const char *name,
-		 struct cifs_sb_info *cifs_sb);
-int CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon,
-		 const char *name, struct cifs_sb_info *cifs_sb);
-int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
-		     const char *fileName, __u16 type,
-		     const struct nls_table *nls_codepage, int remap);
-int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon,
-		   const char *name, struct cifs_sb_info *cifs_sb,
-		   struct dentry *dentry);
-int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
-		  struct dentry *source_dentry, const char *from_name,
-		  const char *to_name, struct cifs_sb_info *cifs_sb);
-int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *pTcon,
-			  int netfid, const char *target_name,
-			  const struct nls_table *nls_codepage, int remap);
-int CIFSCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
-		       struct dentry *source_dentry, const char *from_name,
-		       const char *to_name, struct cifs_sb_info *cifs_sb);
-int CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
-			   const char *fromName, const char *toName,
-			   const struct nls_table *nls_codepage, int remap);
-int CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
-			  const char *fromName, const char *toName,
-			  const struct nls_table *nls_codepage, int remap);
-int CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
-			    const unsigned char *searchName,
-			    char **symlinkinfo,
-			    const struct nls_table *nls_codepage, int remap);
-int cifs_query_reparse_point(const unsigned int xid, struct cifs_tcon *tcon,
-			     struct cifs_sb_info *cifs_sb,
-			     const char *full_path, u32 *tag, struct kvec *rsp,
-			     int *rsp_buftype);
-struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
-					struct super_block *sb,
-					const unsigned int xid,
-					struct cifs_tcon *tcon,
-					const char *full_path, bool directory,
-					struct kvec *reparse_iov,
-					struct kvec *xattr_iov);
-int CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
-			    __u16 fid);
-int CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms,
-	      int *oplock, FILE_ALL_INFO *buf);
-int SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
-		  const char *fileName, const int openDisposition,
-		  const int access_flags, const int create_options,
-		  __u16 *netfid, int *pOplock, FILE_ALL_INFO *pfile_info,
-		  const struct nls_table *nls_codepage, int remap);
-int CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
-		    __u32 posix_flags, __u64 mode, __u16 *netfid,
-		    FILE_UNIX_BASIC_INFO *pRetData, __u32 *pOplock,
-		    const char *name, const struct nls_table *nls_codepage,
-		    int remap);
-int CIFSSMBClose(const unsigned int xid, struct cifs_tcon *tcon,
-		 int smb_file_id);
-
-int CIFSSMBFlush(const unsigned int xid, struct cifs_tcon *tcon,
-		 int smb_file_id);
-
-int CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
-		unsigned int *nbytes, char **buf, int *pbuf_type);
-int CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
-		 unsigned int *nbytes, const char *buf);
-int CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
-		  unsigned int *nbytes, struct kvec *iov, int n_vec);
-int CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
-			  const char *search_name, __u64 *inode_number,
-			  const struct nls_table *nls_codepage, int remap);
-
-int cifs_lockv(const unsigned int xid, struct cifs_tcon *tcon,
-	       const __u16 netfid, const __u8 lock_type,
-	       const __u32 num_unlock, const __u32 num_lock,
-	       LOCKING_ANDX_RANGE *buf);
-int CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
-		const __u16 smb_file_id, const __u32 netpid, const __u64 len,
-		const __u64 offset, const __u32 numUnlock, const __u32 numLock,
-		const __u8 lockType, const bool waitFlag,
-		const __u8 oplock_level);
-int CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
-		     const __u16 smb_file_id, const __u32 netpid,
-		     const loff_t start_offset, const __u64 len,
-		     struct file_lock *pLockData, const __u16 lock_type,
-		     const bool waitFlag);
-int CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon);
-int CIFSSMBEcho(struct TCP_Server_Info *server);
-int CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses);
+
+
+
+
+
+
+
+
 
 struct cifs_ses *sesInfoAlloc(void);
 void sesInfoFree(struct cifs_ses *buf_to_free);
@@ -523,31 +350,6 @@ int generate_smb311signingkey(struct cifs_ses *ses,
 			      struct TCP_Server_Info *server);
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-ssize_t CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
-		       const unsigned char *searchName,
-		       const unsigned char *ea_name, char *EAData,
-		       size_t buf_size, struct cifs_sb_info *cifs_sb);
-int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
-		 const char *fileName, const char *ea_name,
-		 const void *ea_value, const __u16 ea_value_len,
-		 const struct nls_table *nls_codepage,
-		 struct cifs_sb_info *cifs_sb);
-int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
-		      __u16 fid, struct smb_ntsd **acl_inf, __u32 *pbuflen,
-		      __u32 info);
-int CIFSSMBSetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
-		      __u16 fid, struct smb_ntsd *pntsd, __u32 acllen,
-		      int aclflag);
-int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
-		    const unsigned char *searchName, struct posix_acl **acl,
-		    const int acl_type, const struct nls_table *nls_codepage,
-		    int remap);
-int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
-		    const unsigned char *fileName, const struct posix_acl *acl,
-		    const int acl_type, const struct nls_table *nls_codepage,
-		    int remap);
-int CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
-		   const int netfid, __u64 *pExtAttrBits, __u64 *pMask);
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 void cifs_autodisable_serverino(struct cifs_sb_info *cifs_sb);
 bool couldbe_mf_symlink(const struct cifs_fattr *fattr);
@@ -566,11 +368,9 @@ void __cifs_put_smb_ses(struct cifs_ses *ses);
 struct cifs_ses *cifs_get_smb_ses(struct TCP_Server_Info *server,
 				  struct smb3_fs_context *ctx);
 
-int cifs_async_readv(struct cifs_io_subrequest *rdata);
 int cifs_readv_receive(struct TCP_Server_Info *server,
 		       struct mid_q_entry *mid);
 
-void cifs_async_writev(struct cifs_io_subrequest *wdata);
 int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 			  struct cifs_sb_info *cifs_sb,
 			  const unsigned char *path, char *pbuf,
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index b6c94db5edb9..3521222886c1 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -40,6 +40,11 @@ struct cifs_fscache_inode_coherency_data {
  */
 int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon);
 void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon);
+void cifs_fscache_get_inode_cookie(struct inode *inode);
+void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update);
+void cifs_fscache_release_inode_cookie(struct inode *inode);
+int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon);
+void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon);
 
 void cifs_fscache_get_inode_cookie(struct inode *inode);
 void cifs_fscache_release_inode_cookie(struct inode *inode);
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index 0088edbcc73f..1fd4fd0bbb7a 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -23,6 +23,190 @@ struct cifs_unix_set_info_args {
 /*
  * cifssmb.c
  */
+int small_smb_init_no_tc(const int smb_command, const int wct,
+			 struct cifs_ses *ses, void **request_buf);
+int CIFSSMBNegotiate(const unsigned int xid, struct cifs_ses *ses,
+		     struct TCP_Server_Info *server);
+int CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBEcho(struct TCP_Server_Info *server);
+int CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses);
+int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
+		     const char *fileName, __u16 type,
+		     const struct nls_table *nls_codepage, int remap);
+int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon,
+		   const char *name, struct cifs_sb_info *cifs_sb,
+		   struct dentry *dentry);
+int CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon,
+		 const char *name, struct cifs_sb_info *cifs_sb);
+int CIFSSMBMkDir(const unsigned int xid, struct inode *inode, umode_t mode,
+		 struct cifs_tcon *tcon, const char *name,
+		 struct cifs_sb_info *cifs_sb);
+int CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
+		    __u32 posix_flags, __u64 mode, __u16 *netfid,
+		    FILE_UNIX_BASIC_INFO *pRetData, __u32 *pOplock,
+		    const char *name, const struct nls_table *nls_codepage,
+		    int remap);
+int SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
+		  const char *fileName, const int openDisposition,
+		  const int access_flags, const int create_options,
+		  __u16 *netfid, int *pOplock, FILE_ALL_INFO *pfile_info,
+		  const struct nls_table *nls_codepage, int remap);
+int CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms,
+	      int *oplock, FILE_ALL_INFO *buf);
+int cifs_async_readv(struct cifs_io_subrequest *rdata);
+int CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
+		unsigned int *nbytes, char **buf, int *pbuf_type);
+int CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
+		 unsigned int *nbytes, const char *buf);
+void cifs_async_writev(struct cifs_io_subrequest *wdata);
+int CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
+		  unsigned int *nbytes, struct kvec *iov, int n_vec);
+int cifs_lockv(const unsigned int xid, struct cifs_tcon *tcon,
+	       const __u16 netfid, const __u8 lock_type,
+	       const __u32 num_unlock, const __u32 num_lock,
+	       LOCKING_ANDX_RANGE *buf);
+int CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
+		const __u16 smb_file_id, const __u32 netpid, const __u64 len,
+		const __u64 offset, const __u32 numUnlock, const __u32 numLock,
+		const __u8 lockType, const bool waitFlag,
+		const __u8 oplock_level);
+int CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
+		     const __u16 smb_file_id, const __u32 netpid,
+		     const loff_t start_offset, const __u64 len,
+		     struct file_lock *pLockData, const __u16 lock_type,
+		     const bool waitFlag);
+int CIFSSMBClose(const unsigned int xid, struct cifs_tcon *tcon,
+		 int smb_file_id);
+int CIFSSMBFlush(const unsigned int xid, struct cifs_tcon *tcon,
+		 int smb_file_id);
+int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
+		  struct dentry *source_dentry, const char *from_name,
+		  const char *to_name, struct cifs_sb_info *cifs_sb);
+int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *pTcon,
+			  int netfid, const char *target_name,
+			  const struct nls_table *nls_codepage, int remap);
+int CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
+			  const char *fromName, const char *toName,
+			  const struct nls_table *nls_codepage, int remap);
+int CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
+			   const char *fromName, const char *toName,
+			   const struct nls_table *nls_codepage, int remap);
+int CIFSCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
+		       struct dentry *source_dentry, const char *from_name,
+		       const char *to_name, struct cifs_sb_info *cifs_sb);
+int CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
+			    const unsigned char *searchName,
+			    char **symlinkinfo,
+			    const struct nls_table *nls_codepage, int remap);
+int cifs_query_reparse_point(const unsigned int xid, struct cifs_tcon *tcon,
+			     struct cifs_sb_info *cifs_sb,
+			     const char *full_path, u32 *tag, struct kvec *rsp,
+			     int *rsp_buftype);
+struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
+					struct super_block *sb,
+					const unsigned int xid,
+					struct cifs_tcon *tcon,
+					const char *full_path, bool directory,
+					struct kvec *reparse_iov,
+					struct kvec *xattr_iov);
+int CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
+			    __u16 fid);
+int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *searchName, struct posix_acl **acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap);
+int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *fileName, const struct posix_acl *acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap);
+int CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
+		   const int netfid, __u64 *pExtAttrBits, __u64 *pMask);
+int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
+		      __u16 fid, struct smb_ntsd **acl_inf, __u32 *pbuflen,
+		      __u32 info);
+int CIFSSMBSetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
+		      __u16 fid, struct smb_ntsd *pntsd, __u32 acllen,
+		      int aclflag);
+int SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
+			const char *search_name, FILE_ALL_INFO *data,
+			const struct nls_table *nls_codepage, int remap);
+int CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		     u16 netfid, FILE_ALL_INFO *pFindData);
+int CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		     const char *search_name, FILE_ALL_INFO *data,
+		     int legacy /* old style infolevel */,
+		     const struct nls_table *nls_codepage, int remap);
+int CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			 u16 netfid, FILE_UNIX_BASIC_INFO *pFindData);
+int CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			 const unsigned char *searchName,
+			 FILE_UNIX_BASIC_INFO *pFindData,
+			 const struct nls_table *nls_codepage, int remap);
+int CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
+		  const char *searchName, struct cifs_sb_info *cifs_sb,
+		  __u16 *pnetfid, __u16 search_flags,
+		  struct cifs_search_info *psrch_inf, bool msearch);
+int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
+		 __u16 searchHandle, __u16 search_flags,
+		 struct cifs_search_info *psrch_inf);
+int CIFSFindClose(const unsigned int xid, struct cifs_tcon *tcon,
+		  const __u16 searchHandle);
+int CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
+			  const char *search_name, __u64 *inode_number,
+			  const struct nls_table *nls_codepage, int remap);
+int CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
+		    const char *search_name,
+		    struct dfs_info3_param **target_nodes,
+		    unsigned int *num_of_nodes,
+		    const struct nls_table *nls_codepage, int remap);
+int SMBOldQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		  struct kstatfs *FSData);
+int CIFSSMBQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		   struct kstatfs *FSData);
+int CIFSSMBQFSAttributeInfo(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBQFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			 __u64 cap);
+int CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			struct kstatfs *FSData);
+int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
+		  const char *file_name, __u64 size,
+		  struct cifs_sb_info *cifs_sb, bool set_allocation,
+		  struct dentry *dentry);
+int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
+		       struct cifsFileInfo *cfile, __u64 size,
+		       bool set_allocation);
+int SMBSetInformation(const unsigned int xid, struct cifs_tcon *tcon,
+		      const char *fileName, __le32 attributes,
+		      __le64 write_time, const struct nls_table *nls_codepage,
+		      struct cifs_sb_info *cifs_sb);
+int CIFSSMBSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		       const FILE_BASIC_INFO *data, __u16 fid,
+		       __u32 pid_of_opener);
+int CIFSSMBSetFileDisposition(const unsigned int xid, struct cifs_tcon *tcon,
+			      bool delete_file, __u16 fid,
+			      __u32 pid_of_opener);
+int CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		       const char *fileName, const FILE_BASIC_INFO *data,
+		       const struct nls_table *nls_codepage,
+		       struct cifs_sb_info *cifs_sb);
+int CIFSSMBUnixSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			   const struct cifs_unix_set_info_args *args, u16 fid,
+			   u32 pid_of_opener);
+int CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			   const char *file_name,
+			   const struct cifs_unix_set_info_args *args,
+			   const struct nls_table *nls_codepage, int remap);
+ssize_t CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
+		       const unsigned char *searchName,
+		       const unsigned char *ea_name, char *EAData,
+		       size_t buf_size, struct cifs_sb_info *cifs_sb);
+int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
+		 const char *fileName, const char *ea_name,
+		 const void *ea_value, const __u16 ea_value_len,
+		 const struct nls_table *nls_codepage,
+		 struct cifs_sb_info *cifs_sb);
 
 /*
  * smb1ops.c
@@ -33,6 +217,23 @@ extern struct smb_version_values smb1_values;
 /*
  * smb1transport.c
  */
+struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *server,
+					     struct smb_rqst *rqst);
+int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
+		     char *in_buf, unsigned int in_len, int flags);
+int cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+		       bool log_error);
+struct mid_q_entry *cifs_setup_request(struct cifs_ses *ses,
+				       struct TCP_Server_Info *server,
+				       struct smb_rqst *rqst);
+int SendReceive2(const unsigned int xid, struct cifs_ses *ses,
+		 struct kvec *iov, int n_vec, int *resp_buf_type /* ret */,
+		 const int flags, struct kvec *resp_iov);
+int SendReceive(const unsigned int xid, struct cifs_ses *ses,
+		struct smb_hdr *in_buf, unsigned int in_len,
+		struct smb_hdr *out_buf, int *pbytes_returned,
+		const int flags);
+
 
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 #endif /* _SMB1PROTO_H */


