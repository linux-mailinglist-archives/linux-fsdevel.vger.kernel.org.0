Return-Path: <linux-fsdevel+bounces-73941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7039DD25E0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7AA330060CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D651F3ACEFF;
	Thu, 15 Jan 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OTNicD5S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Rq3sSbsn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OTNicD5S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Rq3sSbsn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5F25228D
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495994; cv=none; b=A7qeN8R5YTDVf66Sx1enIBintpJPMd9GPvqgPaUu/R6l9cQcX9S5sJd2/hP4mwslvqtOiEh70LmRqohCnWkLAz1dne7R8e9+wGY158xJqrpt+J1RvugnVC8V1Jx0DheuCPVtpI461E0BU3ehB+kYieWh/CC7vqH2xq3PAYrCBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495994; c=relaxed/simple;
	bh=DlUpTgBVOZ7hdfU5MaDQtdbs1Q+/fhjP1nMdDgPBHyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP+WYnqBHmECqn6whZohSRUoj8gy5kh7bx8eQ5e1BkhrNVV0RxPH7mHJtmI85YlOl0LK3avR4Ata/+f0MuzxgsHcu11K0DpsWoh8FjKM9brfGBQuPgjmswCvqjJnvo2BMyaKXj2prrXIBLehyuLoD63vNAY6BMoIew7cCKRdgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OTNicD5S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Rq3sSbsn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OTNicD5S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Rq3sSbsn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37FA733747;
	Thu, 15 Jan 2026 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768495990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUp7vJBm5RwTWETMhegI0NKFZOuxIWgQjM+/1VZyAiY=;
	b=OTNicD5S+DnlFt+w5IcceK3Vn14l/uA40FtWy5tIg8sWyD11mfpxPgq2WL6N0mHDvd1qkR
	LR30OsKREqTv+luTdQW4EA2X510iFBHGrdARcqijSaQIrTb4iSOaTpO0Ju7q2zItXKxvgt
	NFQ4+262AFNwApEIgBL3x5Pz7HE+xfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768495990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUp7vJBm5RwTWETMhegI0NKFZOuxIWgQjM+/1VZyAiY=;
	b=Rq3sSbsn83NZPdMF10wiY3L7b1jz87k2ealxcBy+5DKXgHhR/f3iKFE3qE3b5R70peyeHg
	wE3ki/ZMwNgvcXDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OTNicD5S;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Rq3sSbsn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768495990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUp7vJBm5RwTWETMhegI0NKFZOuxIWgQjM+/1VZyAiY=;
	b=OTNicD5S+DnlFt+w5IcceK3Vn14l/uA40FtWy5tIg8sWyD11mfpxPgq2WL6N0mHDvd1qkR
	LR30OsKREqTv+luTdQW4EA2X510iFBHGrdARcqijSaQIrTb4iSOaTpO0Ju7q2zItXKxvgt
	NFQ4+262AFNwApEIgBL3x5Pz7HE+xfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768495990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUp7vJBm5RwTWETMhegI0NKFZOuxIWgQjM+/1VZyAiY=;
	b=Rq3sSbsn83NZPdMF10wiY3L7b1jz87k2ealxcBy+5DKXgHhR/f3iKFE3qE3b5R70peyeHg
	wE3ki/ZMwNgvcXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54FC43EA63;
	Thu, 15 Jan 2026 16:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PAr6BnUbaWnicAAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Thu, 15 Jan 2026 16:53:09 +0000
Date: Thu, 15 Jan 2026 13:53:06 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	henrique.carvalho@suse.com
Subject: Re: [PATCH 00/37] cifs: Scripted header file cleanup and SMB1 split
Message-ID: <sijmvmcozfmtp3rkamjbgr6xk7ola2wlxc2wvs4t4lcanjsaza@w4bcxcxkmyfc>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 37FA733747
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 12/22, David Howells wrote:
>Hi Steve,
>
>Could you consider taking these patches?  There are two parts to the set.
>
>The first part cleans up the formatting of declarations in the header file.
>They remove the externs, (re)name the arguments in the declarations to
>match those in the C file and format them to wrap at 79 chars (this is
>configurable - search for 79 in the script), aligning all the first
>argument on each line with the char after the opening bracket.
>
>I've attached the script below so that you can also run it yourself.  It
>does all the git manipulation to generate one commit per header file
>changed.  Run as:
>
>	./cifs.pl fs/smb/client/*.[ch]
>
>in the kernel source root dir.
>
>The script can be rerun later to readjust any added changes.
>
>Paulo has given his R-b for this subset (labelled cifs: Scripted clean up).
>
>The second part splits the SMB1 parts of cifs protocol layer out into their
>own files.  cifstransport.c is renamed to smb1transport.c also for
>consistency, though cifssmb.c is left unrenamed (I could rename that to
>smb1pdu.c).  This is pretty much all moving stuff around and few actual
>code changes.  There is one bugfix, though, to cifs_dump_mids().
>
>I've left the splitting of the SMB1 parts of the cifs filesystem layer for
>a future set of patches as that's would involve removing embedded parts of
>functions and is easier to get wrong.
>
>The patches can be found here also:
>
>	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-cleanup
>
>Thanks,
>David

Acked-by: Enzo Matsumiya <ematsumiya@suse.de>


Cheers,

Enzo

>---
>	#!/usr/bin/perl -w
>	use strict;
>	unless (@ARGV) {
>	    die "Usage: $0 <c_file1> [<c_file2> ...]\n";
>	}
>
>	# Data tracking
>	my %funcs = ();		# Func name => { func prototype }
>	my %headers = ();	# Header filename => { header content }
>	my %c_files = ();	# C filename => { ordered func list, header pref }
>	my %cmarkers = ();	# C filename marker => { header filename it's in }
>
>	# Parse state
>	my $pathname = "-";
>	my $lineno = 0;
>
>	sub error(@) {
>	    print STDERR $pathname, ":", $lineno, ": ", @_, "\n";
>	    exit(1);
>	}
>
>	sub pad($) {
>	    # Reindent the function arguments to line the arguments up with the char
>	    # after the opening bracket on the func argument list
>	    my ($lines) = @_;
>	    return $lines if ($#{$lines} <= 0);
>	    my $has_empty = 0;
>	    for (my $i = 0; $i <= $#{$lines}; $i++) {
>		$lines->[$i] =~ s/^[ \t]+//;
>		$has_empty = 1 if ($lines->[$i] eq "");
>	    }
>
>	    if ($has_empty) {
>		my @clean = grep /.+/, @{$lines};
>		$lines = \@clean;
>	    }
>
>	    my $indlen = index($lines->[0], "(");
>	    return $lines if ($indlen < 0);
>	    my $indent = "";
>	    $indlen++;
>	    $indent .= "\t" x ($indlen / 8);
>	    $indent .= " " x ($indlen % 8);
>
>	    my @padded = ();
>	    my $acc = "";
>	    my $len = -$indlen;
>	    for (my $i = 0; $i <= $#{$lines}; $i++) {
>		my $argument = $lines->[$i];
>		my $arglen = length($argument);
>		my $last = ($i == $#{$lines} ? 1 : 0);
>
>		if ($i == 0 ||
>		    $i == 1) {
>		    $acc .= $argument;
>		    $acc .= ";" if ($last);
>		    $len += $arglen + $last;
>		    next;
>		}
>		if (!$acc) {
>		    $acc = $indent . $argument;
>		    $acc .= ";" if ($last);
>		    $len += $arglen + $last;
>		    next;
>		}
>		if ($indlen + $len + 1 + $arglen + $last > 79) {
>		    push @padded, $acc;
>		    $acc = $indent . $argument;
>		    $acc .= ";" if ($last);
>		    $len = $arglen + $last;
>		    next;
>		}
>
>		$acc .= " " . $argument;
>		$acc .= ";" if ($last);
>		$len += 1 + $arglen + $last;
>	    }
>	    push @padded, $acc if ($acc);
>	    return \@padded;
>	}
>
>	sub earliest(@) {
>	    my $ret = -1;
>	    foreach (@_) {
>		$ret = $_ if ($ret < 0 || ($_ >= 0 && $_ < $ret));
>	    }
>	    return $ret;
>	}
>
>	foreach my $file (@ARGV) {
>	    # Open the file for reading.
>	    next if $file =~ /trace[.]h$/;
>	    next if $file =~ /smbdirect[.][ch]$/;
>	    open my $fh, "<$file"
>		or die "Could not open file '$file'";
>	    $pathname = $file;
>	    $lineno = 0;
>
>	    my $filename;
>	    my @file_content = ();
>	    my @copy = ();
>
>	    my $state = 0;
>	    my $qual = "";
>	    my $type = "";
>	    my $funcname = "";
>	    my @funcdef = ();
>	    my $bracket = 0;
>	    my $comment = 0;
>	    my $smb1 = 0;
>	    my $header = 0;
>	    my $inline = 0;
>	    my $file_marker = "";
>	    my $config = "";
>	    my $c_file = 0;
>
>	    $filename = $pathname;
>	    $filename =~ s!.*/!!;
>
>	    if ($file =~ m!.h$!) {
>		my %new_h_file = (
>		    path    => $pathname,
>		    fname   => $filename,
>		    content => [],
>		    );
>		$header = \%new_h_file;
>		$headers{$filename} = \%new_h_file;
>	    } elsif ($file =~ m!.c$!) {
>		my %new_c_file = (
>		    path  => $pathname,
>		    fname => $filename,
>		    funcs => [],
>		    );
>		$c_file = \%new_c_file;
>		$c_files{$filename} = \%new_c_file;
>	    } else {
>		warn("Ignoring unexpected file $file\n");
>		next;
>	    }
>
>	    $smb1 = 1 if ($file =~ m!/smb1ops.c|/cifssmb.c|/cifstransport.c!);
>
>	    foreach my $line (<$fh>) {
>		$lineno++;
>		chomp($line);
>		push @copy, $line;
>		if (!$line) {
>		    # Blank line
>		    push @file_content, @copy;
>		    @copy = ();
>		    next;
>		}
>
>		# Handle continuation or end of block comment.  Look for C file
>		# prototype insertion point markers.
>		if ($comment) {
>		    if ($line =~ m![*]/!) {
>			if ($comment == 2 && $file_marker) {
>			    $cmarkers{$file_marker} = $file_marker;
>			    push @copy, "#C_MARKER " . $filename;
>			    $file_marker = 0;
>			}
>			$comment = 0;
>		    } else {
>			$comment++;
>			if ($comment == 2 && $line =~ m! [*] ([a-z][a-z_0-9]*[.][c])$!) {
>			    $file_marker = $1;
>			    print("Found file marker ", $file_marker, " in ", $filename, "\n");
>			}
>		    }
>		    push @file_content, @copy;
>		    @copy = ();
>		    next;
>		}
>
>		# Check cpp directives, particularly looking for SMB1 bits
>		if ($line =~ /^[#]/) {
>		    if ($header) {
>			if ($line =~ /ifdef.*(CONFIG_[A-Z0-9_])/) {
>			    error("multiconfig") if $config;
>			    $config = $1;
>			    $smb1++ if ($config eq "CONFIG_CIFS_ALLOW_INSECURE_LEGACY");
>			} elsif ($line =~ /endif/) {
>			    $smb1-- if ($config eq "CONFIG_CIFS_ALLOW_INSECURE_LEGACY");
>			    $config = "";
>			}
>		    }
>		    push @file_content, @copy;
>		    @copy = ();
>		    next;
>		}
>
>		# Exclude interference in finding func names and return types
>		if ($line =~ /^[{]/ ||
>		    $line =~ /##/ ||
>		    $line =~ /^[_a-z0-9A-Z]+:$/ || # goto label
>		    $line =~ /^do [{]/ ||
>		    $line =~ m!^//!) {
>		    push @file_content, @copy;
>		    @copy = ();
>		    next;
>		}
>
>		# Start of a block comment
>		if ($line =~ m!^/[*]!) {
>		    $comment = 1 unless ($line =~ m![*]/!);
>		    push @file_content, @copy;
>		    @copy = ();
>		    next;
>		}
>
>		# End of a braced section, such as a function implementation
>		if ($line =~ /^[}]/) {
>			$type = "";
>			$qual = "";
>			$funcname = "";
>			@funcdef = ();
>			push @file_content, @copy;
>			@copy = ();
>			next;
>		}
>
>		if ($line =~ /^typedef/) {
>		    $type = "";
>		    $qual = "";
>		    $funcname = "";
>		    @funcdef = ();
>		    push @file_content, @copy;
>		    @copy = ();
>		    next;
>		}
>
>		# Extract function qualifiers.  There may be multiple of these in more
>		# or less any order.  Some of them cause the func to be skipped (e.g. inline).
>
>		if ($line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)\W/ ||
>		    $line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)$/) {
>		    error("Unexpected qualifier '$1'") if ($state != 0);
>		    while ($line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)\W/ ||
>			   $line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)$/) {
>			$qual .= " " if ($qual);
>			$qual .= $1;
>			$inline = 1 if ($1 eq "inline");
>			$inline = 1 if ($1 eq "__always_inline");
>			$line = substr($line, length($1));
>			$line =~ s/^\s+//;
>		    }
>		}
>
>		if ($state == 0) {
>		    # Extract what we assume to be the return type
>		    if ($line =~ /^\s/) {
>			push @file_content, @copy;
>			@copy = ();
>			next;
>		    }
>		    while ($line =~ /^(unsigned|signed|bool|char|short|int|long|void|const|volatile|(struct|union|enum)\s+[_a-zA-Z][_a-zA-Z0-9]*|[*]|__init|__exit|__le16|__le32|__le64|__be16|__be32|__be64)/) {
>			$type .= " " if $type;
>			$type .= $1;
>			$line = substr($line, length($1));
>			$line =~ s/^\s+//;
>		    }
>		    if ($line =~ /^struct [{]/) {
>			# Ignore structure definitions
>			$type = "";
>			$qual = "";
>			$funcname = "";
>			@funcdef = ();
>			push @file_content, @copy;
>			@copy = ();
>			next;
>		    }
>		    if (index($line, "=") >= 0) {
>			# Ignore assignments
>			$type = "";
>			$qual = "";
>			$funcname = "";
>			@funcdef = "";
>			push @file_content, @copy;
>			@copy = ();
>			next;
>		    }
>
>		    # Try and extract a function's type and name
>		    while ($line =~ /(^[_a-zA-Z][_a-zA-Z0-9]*)/) {
>			my $name = $1;
>			$line = substr($line, length($name));
>			next if ($line =~ /^[{]/);
>			$line =~ s/^\s+//;
>
>			my $ch = substr($line, 0, 1);
>			last if ($ch eq "[" || $ch eq ";"); # Global variables
>
>			if ($ch eq "(") {
>			    # Found the function name
>			    $state = 1;
>			    $line = substr($line, 1);
>			    $funcname = $name;
>			    my $tmp = $qual . $type . " " . $funcname . "(";
>			    $tmp =~ s/[*] /*/;
>			    push @funcdef, $tmp;
>			    $bracket = 1;
>			    last;
>			}
>
>			if ($type) {
>			    last if (index($line, ";") >= 0 && index($line, "(") == -1);
>			    error("Unexpected name '$name' after '$type'");
>			}
>
>			$type .= " " if $type;
>			$type .= $name;
>			if ($line =~ /^(\s*[*]+)/) {
>			    my $ptr = $1;
>			    $type .= $ptr;
>			    $line = substr($line, length($ptr));
>			}
>		    }
>		}
>
>		# Try and extract a function's argument list
>		my $from = 0;
>		if ($state == 1) {
>		    while (1) {
>			my $o = index($line, "(", $from);
>			my $c = index($line, ")", $from);
>			my $m = index($line, ",", $from);
>
>			my $b = earliest($o, $c, $m);
>			if ($b < 0) {
>			    push @funcdef, $line
>				unless ($line eq "");
>			    last;
>			}
>			my $ch = substr($line, $b, 1);
>
>			# Push the arguments separately on to the list
>			if ($ch eq ",") {
>			    push @funcdef, substr($line, 0, $b + 1);
>			    $line = substr($line, $b + 1);
>			    $from = 0;
>			} elsif ($ch eq "(") {
>			    # Handle brackets in the argument list (e.g. function
>			    # pointers)
>			    $bracket++;
>			    $from = $b + 1;
>			} elsif ($ch eq ")") {
>			    $bracket--;
>			    if ($bracket == 0) {
>				push @funcdef, substr($line, 0, $b + 1);
>				$line = substr($line, $b + 1);
>				$state = 2;
>				last;
>			    }
>			    $from = $b + 1;
>			}
>		    }
>		}
>
>		if ($state == 2) {
>		    $inline = 1 if ($qual =~ /inline/);
>		    #print("QUAL $qual $type $funcname $inline ", $#funcdef, "\n");
>		    if (!$header &&
>			$qual !~ /static/ &&
>			$funcname ne "__acquires" &&
>			$funcname ne "__releases" &&
>			$funcname ne "module_init" &&
>			$funcname ne "module_exit" &&
>			$funcname ne "module_param" &&
>			$funcname ne "module_param_call" &&
>			$funcname ne "PROC_FILE_DEFINE" &&
>			$funcname !~ /MODULE_/ &&
>			$funcname !~ /DEFINE_/) {
>
>			# Okay, we appear to have a function implementation
>			my $func;
>
>			if (exists($funcs{$funcname})) {
>			    $func = $funcs{$funcname};
>			    $func->{body} = pad(\@funcdef);
>			} else {
>			    my %new_func = (
>				name => $funcname,
>				cond => "",
>				);
>			    $func = \%new_func;
>			    $funcs{$funcname} = $func;
>			    $func->{body} = pad(\@funcdef);
>			}
>			$func->{body} = pad(\@funcdef);
>
>			if ($funcname eq "cifs_inval_name_dfs_link_error") {
>			    $func->{cond} = "#ifdef CONFIG_CIFS_DFS_UPCALL";
>			} elsif ($funcname eq "cifs_listxattr") {
>			    $func->{cond} = "#ifdef CONFIG_CIFS_XATTR";
>			}
>
>			push @{$c_file->{funcs}}, $func;
>		    } elsif (!$header || $inline) {
>			# Ignore inline function implementations and other weirdies
>			push @file_content, @copy;
>		    } elsif ($header && !$inline) {
>			push @file_content, "#FUNCPROTO " . $funcname;
>
>			my $func;
>
>			if (exists($funcs{$funcname})) {
>			    $func = $funcs{$funcname};
>			    $func->{lineno} = $lineno;
>			    $func->{pathname} = $pathname;
>			} else {
>			    my %new_func = (
>				name => $funcname,
>				cond => "",
>				lineno => $lineno,
>				pathname => $pathname,
>				);
>			    $func = \%new_func;
>			    $funcs{$funcname} = $func;
>			}
>		    }
>
>		    @funcdef = ();
>		    $type = "";
>		    $qual = "";
>		    $funcname = "";
>		    $inline = 0;
>		    $state = 0;
>		    @copy = ();
>		}
>		if ($line =~ /;/) {
>		    $type = "";
>		    $qual = "";
>		    $funcname = "";
>		    @funcdef = ();
>		    $state = 0;
>		    push @file_content, @copy;
>		    @copy = ();
>		}
>	    }
>	    close($fh);
>
>	    if ($header) {
>		$header->{content} = \@file_content;
>	    }
>	}
>
>	sub write_header($)
>	{
>	    my ($header) = @_;
>	    my $path = $header->{path};
>
>	    my @output = ();
>
>	    foreach my $line (@{$header->{content}}) {
>		if ($line =~ "^[#]C_MARKER (.*)") {
>		    next;
>		} elsif ($line =~ "^[#]FUNCPROTO ([_a-zA-Z0-9]+)") {
>		    my $funcname = $1;
>		    my $func = $funcs{$funcname};
>		    if (!$func->{body}) {
>			print($func->{pathname}, ":", $func->{lineno}, ": '", $funcname,
>			      "' dead prototype\n");
>			next;
>		    }
>		    #push @output, $line;
>		    push @output, @{$func->{body}};
>		} else {
>		    push @output, $line;
>		}
>	    }
>
>	    open my $fh, ">$path"
>		or die "Could not open file '$path' for writing";
>	    foreach my $f (@output) {
>		print($fh $f, "\n") or die $path;
>	    }
>	    close($fh) or die $path;
>
>	    print("Git $path\n");
>	    if (system("git diff -s --exit-code $path") == 0) {
>		print("- no changes, skipping\n");
>		return;
>	    }
>
>	    if (system("git add $path") != 0) {
>		die("'git add $path' failed\n");
>	    }
>
>	    open $fh, ">.commit_message"
>		or die "Could not open file '.commit_message' for writing";
>	    print($fh
>		  qq/
>	cifs: Scripted clean up $path
>
>	Remove externs, correct argument names and reformat declarations.
>
>	Signed-off-by: David Howells <dhowells\@redhat.com>
>	cc: Steve French <sfrench\@samba.org>
>	cc: Paulo Alcantara <pc\@manguebit.org>
>	cc: Enzo Matsumiya <ematsumiya\@suse.de>
>	cc: linux-cifs\@vger.kernel.org
>	cc: linux-fsdevel\@vger.kernel.org
>	cc: linux-kernel\@vger.kernel.org
>	/);
>	    close($fh) or die ".commit_message";
>
>	    if (system("git commit -F .commit_message") != 0) {
>		die("'git commit $path' failed\n");
>	    }
>	}
>
>	foreach my $h (keys(%headers)) {
>	    write_header($headers{$h});
>	}
>
>David Howells (37):
>  cifs: Scripted clean up fs/smb/client/cached_dir.h
>  cifs: Scripted clean up fs/smb/client/dfs.h
>  cifs: Scripted clean up fs/smb/client/cifsproto.h
>  cifs: Scripted clean up fs/smb/client/cifs_unicode.h
>  cifs: Scripted clean up fs/smb/client/netlink.h
>  cifs: Scripted clean up fs/smb/client/cifsfs.h
>  cifs: Scripted clean up fs/smb/client/dfs_cache.h
>  cifs: Scripted clean up fs/smb/client/dns_resolve.h
>  cifs: Scripted clean up fs/smb/client/cifsglob.h
>  cifs: Scripted clean up fs/smb/client/fscache.h
>  cifs: Scripted clean up fs/smb/client/fs_context.h
>  cifs: Scripted clean up fs/smb/client/cifs_spnego.h
>  cifs: Scripted clean up fs/smb/client/compress.h
>  cifs: Scripted clean up fs/smb/client/cifs_swn.h
>  cifs: Scripted clean up fs/smb/client/cifs_debug.h
>  cifs: Scripted clean up fs/smb/client/smb2proto.h
>  cifs: Scripted clean up fs/smb/client/reparse.h
>  cifs: Scripted clean up fs/smb/client/ntlmssp.h
>  cifs: SMB1 split: Rename cifstransport.c
>  cifs: SMB1 split: Create smb1proto.h for SMB1 declarations
>  cifs: SMB1 split: Separate out SMB1 decls into smb1proto.h
>  cifs: SMB1 split: Move some SMB1 receive bits to smb1transport.c
>  cifs: SMB1 split: Move some SMB1 received PDU checking bits to
>    smb1transport.c
>  cifs: SMB1 split: Add some #includes
>  cifs: SMB1 split: Split SMB1 protocol defs into smb1pdu.h
>  cifs: SMB1 split: Adjust #includes
>  cifs: SMB1 split: Move BCC access functions
>  cifs: SMB1 split: Don't return smb_hdr from cifs_{,small_}buf_get()
>  cifs: Fix cifs_dump_mids() to call ->dump_detail
>  cifs: SMB1 split: Move inline funcs
>  cifs: SMB1 split: cifs_debug.c
>  cifs: SMB1 split: misc.c
>  cifs: SMB1 split: netmisc.c
>  cifs: SMB1 split: cifsencrypt.c
>  cifs: SMB1 split: sess.c
>  cifs: SMB1 split: connect.c
>  cifs: SMB1 split: Make BCC accessors conditional
>
> fs/smb/client/Makefile        |   10 +-
> fs/smb/client/cached_dir.h    |   30 +-
> fs/smb/client/cifs_debug.c    |   18 +-
> fs/smb/client/cifs_debug.h    |    1 -
> fs/smb/client/cifs_spnego.h   |    4 +-
> fs/smb/client/cifs_swn.h      |   10 +-
> fs/smb/client/cifs_unicode.c  |    1 -
> fs/smb/client/cifs_unicode.h  |   17 +-
> fs/smb/client/cifsacl.c       |    1 -
> fs/smb/client/cifsencrypt.c   |  124 --
> fs/smb/client/cifsfs.c        |    1 -
> fs/smb/client/cifsfs.h        |  114 +-
> fs/smb/client/cifsglob.h      |   29 +-
> fs/smb/client/cifspdu.h       | 2377 +--------------------------------
> fs/smb/client/cifsproto.h     |  780 ++++-------
> fs/smb/client/cifssmb.c       |  147 +-
> fs/smb/client/cifstransport.c |  263 ----
> fs/smb/client/compress.h      |    3 +-
> fs/smb/client/connect.c       |  252 ----
> fs/smb/client/dfs.h           |    3 +-
> fs/smb/client/dfs_cache.h     |   19 +-
> fs/smb/client/dir.c           |    1 -
> fs/smb/client/dns_resolve.h   |    4 +-
> fs/smb/client/file.c          |    1 -
> fs/smb/client/fs_context.c    |    1 -
> fs/smb/client/fs_context.h    |   16 +-
> fs/smb/client/fscache.h       |   17 +-
> fs/smb/client/inode.c         |    1 -
> fs/smb/client/ioctl.c         |    1 -
> fs/smb/client/link.c          |    1 -
> fs/smb/client/misc.c          |  302 +----
> fs/smb/client/netlink.h       |    4 +-
> fs/smb/client/netmisc.c       |  824 +-----------
> fs/smb/client/ntlmssp.h       |   15 +-
> fs/smb/client/readdir.c       |    1 -
> fs/smb/client/reparse.h       |   14 +-
> fs/smb/client/sess.c          |  982 --------------
> fs/smb/client/smb1debug.c     |   25 +
> fs/smb/client/smb1encrypt.c   |  139 ++
> fs/smb/client/smb1maperror.c  |  825 ++++++++++++
> fs/smb/client/smb1misc.c      |  189 +++
> fs/smb/client/smb1ops.c       |  279 ++--
> fs/smb/client/smb1pdu.h       | 2354 ++++++++++++++++++++++++++++++++
> fs/smb/client/smb1proto.h     |  336 +++++
> fs/smb/client/smb1session.c   |  995 ++++++++++++++
> fs/smb/client/smb1transport.c |  561 ++++++++
> fs/smb/client/smb2file.c      |    2 +-
> fs/smb/client/smb2inode.c     |    2 +-
> fs/smb/client/smb2pdu.c       |    2 +-
> fs/smb/client/smb2proto.h     |  468 +++----
> fs/smb/client/smbencrypt.c    |    1 -
> fs/smb/client/transport.c     |    1 -
> fs/smb/client/xattr.c         |    1 -
> fs/smb/common/smb2pdu.h       |    3 +
> 54 files changed, 6310 insertions(+), 6262 deletions(-)
> delete mode 100644 fs/smb/client/cifstransport.c
> create mode 100644 fs/smb/client/smb1debug.c
> create mode 100644 fs/smb/client/smb1encrypt.c
> create mode 100644 fs/smb/client/smb1maperror.c
> create mode 100644 fs/smb/client/smb1misc.c
> create mode 100644 fs/smb/client/smb1pdu.h
> create mode 100644 fs/smb/client/smb1proto.h
> create mode 100644 fs/smb/client/smb1session.c
> create mode 100644 fs/smb/client/smb1transport.c
>

