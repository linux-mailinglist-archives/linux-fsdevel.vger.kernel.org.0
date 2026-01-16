Return-Path: <linux-fsdevel+bounces-74039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB854D2A5D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 03:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14D9630365AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897D433D517;
	Fri, 16 Jan 2026 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsKgfW2a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0D331A40
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531866; cv=pass; b=Zax4p4Sw5yOgvmM27kytGHewGcbLuu7S8tf4zHrJQNb2iRcYVrcpsPQuUBWkITC6I6P1Ru6+tEuabUqzoaBftdnEZKoTh1CTxXbX/up3PF/O9ZUBjShiuF00lYM+72m7t9KGncAFZrCoR0BdbcW3Ag7YuzdbWfKD5eSIa5gRE1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531866; c=relaxed/simple;
	bh=uzHDNfAXhOBzZYb+R5ucRHComZA/77WUsZtUhZ1eWjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKA7Rfbji41Ub/dj8YNFaYorTPtEGxMxmRPl3LMgAcHsIKJARJMrc7E404r8LyBYUVcqrMuJL44W8UBHgI+6YbFDwk23ZI/UR53EZsNPs06XZRIwnMrFM9c9kCbJsbqjvsdxYKdjhVTdE0l0lU4imToHaepPGotbqC3A/63qnqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsKgfW2a; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88888d80590so21654266d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 18:51:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768531862; cv=none;
        d=google.com; s=arc-20240605;
        b=iw8DFH4vFeHxU4MEcHdmws2al5iJWpdU1WZsCKE8CYfIk2ESXaFJnzI56mswNCyIYg
         zFYgXu1lPXtlxKevqdchRDMlk3vvyHciA+VtHdICrrRLuemGeTUn/G9qU5pOGCnal8Gc
         RCiLklvmRD2qMqiqtTFjTkeWmLz1M4OWfb0BYBsQYjRve7XuE1qCZXpBWEYi1e7aKrgo
         SpU5wL03OL3SoJarHqlTIDB4zPWJXPBKByJUEAulde8vfgbCvh9fq9vUg1JhEUAQuKOa
         qtXVKu68dppTcaRAV7kMQwu+9Sg6JycABRKgqaTuzTwGoVVh5p+SnzvJZwBY8+JGbvpX
         Uiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3dDH+HMLLi4eGtoB1oe4dH+r+6ADX383KGvVkXI3pJ4=;
        fh=qj7+Hrk38oJYlA6UvwjMtBYX9nOAQKBMWqCss2RxtZo=;
        b=KxZSNeVTf7tdKBOFcFi+RrNKSjvJRFNY2wwsGT/c0d3g2nYl980kZaUSvIxocLUPhb
         fOvWkuUccmKPHlajeX84Xtr0YMsIFPV8Sw18zsP/Pmi/Qx/bd1ekihcbF4sKMZkM6AOw
         U8hmD8WVZa1x8Zz5QUNdEmNnMNOLspWch3Qg8tUKAZSu1UtegKnNM8lHaaLliYbLrxUn
         g0TkPMc1YjdeV6toAZRoJ2nQq2IfbciRwmPm0rim8vhw/788B9xuSl2UL/R1uRa9FZxe
         UJFQ3gejgIs1lPlPPsZrRoi3vPMJCLTOH9RFql5gnsGbJStUw1t0EL7GhY0wiojm6YRe
         jqgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768531862; x=1769136662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dDH+HMLLi4eGtoB1oe4dH+r+6ADX383KGvVkXI3pJ4=;
        b=VsKgfW2a2VsxFg2uKlUEPd7ZmLNNR9pBwAY9N2HbgXNEclehdrpoqsdLbmUBLW+ce4
         +o9qOSEyQMqNEFJS3mJdGFGc9IuAH0DBGV3P2YuJQX0bLm5sNeLuH7TMPRq4tjZvXfYO
         jebogXLXy/YQLRn3/RHX4XFYzT2LwQbLFvNvzUyBRjtqsi1rdzKfq7rkjrYtY/NItvH8
         7YFzFWExOoY3CcTK6rB/1rI1w3pf2B/pZOZQc/oZLvikK+IxdO782YKNL50AsFZ1U1Pz
         nNnMBuywsySvyYc/NfEbS5yGQvIBp/pKjrB9E7NBiiH4XXOOB2ZHWvMGWuqbilxIai6s
         zKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768531862; x=1769136662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dDH+HMLLi4eGtoB1oe4dH+r+6ADX383KGvVkXI3pJ4=;
        b=Pp0Hl1zP4CzLAGhEnPaNpbaVdAT3NH422x/wBtHOI8aHdz8Q5uMTA6W7RFK55/hJkh
         6ZYFABQ11sTxHHfwnm7M1E2uPEMU0mKBpot87D0PDu/0m3rfWNHlVsPk03b9N8rlgck7
         F/nHu0bt+s+Ve+M6KdFhZ1L54+GR/Ii9djuOaM2/Oyxwvv0WQy0ChBSPPGc0gVI/r++M
         eShl3U/HQh5t2nHH7Pcc1E581h/IZZFUJByzajp7Ri/3SkLnfAIMv5Pl4sZMS7VSd9lD
         wV+slhysyMj9Fi2xL6EFJQD1A22UAkstjS/hw7SYdBHQTimQ0cN807TRC5kGzANikIfj
         7u4w==
X-Forwarded-Encrypted: i=1; AJvYcCUrDDG8unshAFrhCPlGBuCRxf1GCuai9xwMryBIiCUIJAqkClndw72DX3nmkUn32mk48yysi+70LA5UbySk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyop9dwe0NRr7HX1zF3oeP/w1OPRylIyl6HC2O/A1D36KjaHNok
	k102HVjz4umjCrOMijxu7pno8XXqKNd4Ew0L2x5oKnMcviOKnigqaqw+udYfVXAXKTftvu8V6Gv
	GUXN8chTJeEkZ7X1g2b7KhUcz7A2eV3I=
X-Gm-Gg: AY/fxX7COu8ZLTr7BSGpTk5TksIn2a+kQ2ryNJxsrlE9YehSLTGVz9RP7pJGwnwRfef
	8p95VESezium/UMIZlvrUXotMKqju9HTcuTOD5bn9c2XmC0775JXXB0dOA25cxU3z1v+u+UYRc5
	jdgkkfm0/rE/xECWfPoY8iKufIkogxym5JOVKTcgGP6yoq7mJY0akNkfM6aMlpmsXORRkLur0my
	r3YxxTdSKYDcnAduZgNNEBV322Y2D0XZW7ndDaY7+26xLKzwcn1OtDpEGd+Mv72jAUzq1ZyJKWh
	/66eY3/S17q5k8oRlRKJZ9NMn54WWSjbBwgc6RpY9WS5SgWi33N/ahT1Hd4BKHB9zCfuSzSIdua
	3CbOmr7XHZ0/kBI6Af/H5tgA+9quE/wW+6JCP1FjSlU0Aj4ALDnw/FN/FyJht3M9d8Z/cpK8igF
	ElBrmt1kwuww==
X-Received: by 2002:a05:6214:2484:b0:890:754b:4db0 with SMTP id
 6a1803df08f44-8942e421c8dmr23525766d6.8.1768531862397; Thu, 15 Jan 2026
 18:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222223006.1075635-1-dhowells@redhat.com> <sijmvmcozfmtp3rkamjbgr6xk7ola2wlxc2wvs4t4lcanjsaza@w4bcxcxkmyfc>
In-Reply-To: <sijmvmcozfmtp3rkamjbgr6xk7ola2wlxc2wvs4t4lcanjsaza@w4bcxcxkmyfc>
From: Steve French <smfrench@gmail.com>
Date: Thu, 15 Jan 2026 20:50:49 -0600
X-Gm-Features: AZwV_QjQXSIe_foAwiaxEng9t2K2miPbSa_o1GqLNFfxL7L7f3kfzAGfPnK6rUo
Message-ID: <CAH2r5mtgC_s2J9g0smr5NDxSp1TO7d+dtZ7=afnuw9hMxQ4TYQ@mail.gmail.com>
Subject: Re: [PATCH 00/37] cifs: Scripted header file cleanup and SMB1 split
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	henrique.carvalho@suse.com, ChenXiaoSong <chenxiaosong@kylinos.cn>, 
	ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have tentatively merged the first 24 of this series to cifs-2.6.git
for-next (pending testing etc) but had merge conflicts with the
remainder on current mainline.  I also added Enzo's Acked-by

David,
Do you have a newer/rebased version of this series that applies to
current mainline? Also are there other patches you would like in
for-next?

Chen,
Will we need to rebase your patch series as well? Let me know your
current cifs.ko patches for 6.20-rc

On Thu, Jan 15, 2026 at 10:53=E2=80=AFAM Enzo Matsumiya <ematsumiya@suse.de=
> wrote:
>
> On 12/22, David Howells wrote:
> >Hi Steve,
> >
> >Could you consider taking these patches?  There are two parts to the set=
.
> >
> >The first part cleans up the formatting of declarations in the header fi=
le.
> >They remove the externs, (re)name the arguments in the declarations to
> >match those in the C file and format them to wrap at 79 chars (this is
> >configurable - search for 79 in the script), aligning all the first
> >argument on each line with the char after the opening bracket.
> >
> >I've attached the script below so that you can also run it yourself.  It
> >does all the git manipulation to generate one commit per header file
> >changed.  Run as:
> >
> >       ./cifs.pl fs/smb/client/*.[ch]
> >
> >in the kernel source root dir.
> >
> >The script can be rerun later to readjust any added changes.
> >
> >Paulo has given his R-b for this subset (labelled cifs: Scripted clean u=
p).
> >
> >The second part splits the SMB1 parts of cifs protocol layer out into th=
eir
> >own files.  cifstransport.c is renamed to smb1transport.c also for
> >consistency, though cifssmb.c is left unrenamed (I could rename that to
> >smb1pdu.c).  This is pretty much all moving stuff around and few actual
> >code changes.  There is one bugfix, though, to cifs_dump_mids().
> >
> >I've left the splitting of the SMB1 parts of the cifs filesystem layer f=
or
> >a future set of patches as that's would involve removing embedded parts =
of
> >functions and is easier to get wrong.
> >
> >The patches can be found here also:
> >
> >       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dcifs-cleanup
> >
> >Thanks,
> >David
>
> Acked-by: Enzo Matsumiya <ematsumiya@suse.de>
>
>
> Cheers,
>
> Enzo
>
> >---
> >       #!/usr/bin/perl -w
> >       use strict;
> >       unless (@ARGV) {
> >           die "Usage: $0 <c_file1> [<c_file2> ...]\n";
> >       }
> >
> >       # Data tracking
> >       my %funcs =3D ();         # Func name =3D> { func prototype }
> >       my %headers =3D ();       # Header filename =3D> { header content=
 }
> >       my %c_files =3D ();       # C filename =3D> { ordered func list, =
header pref }
> >       my %cmarkers =3D ();      # C filename marker =3D> { header filen=
ame it's in }
> >
> >       # Parse state
> >       my $pathname =3D "-";
> >       my $lineno =3D 0;
> >
> >       sub error(@) {
> >           print STDERR $pathname, ":", $lineno, ": ", @_, "\n";
> >           exit(1);
> >       }
> >
> >       sub pad($) {
> >           # Reindent the function arguments to line the arguments up wi=
th the char
> >           # after the opening bracket on the func argument list
> >           my ($lines) =3D @_;
> >           return $lines if ($#{$lines} <=3D 0);
> >           my $has_empty =3D 0;
> >           for (my $i =3D 0; $i <=3D $#{$lines}; $i++) {
> >               $lines->[$i] =3D~ s/^[ \t]+//;
> >               $has_empty =3D 1 if ($lines->[$i] eq "");
> >           }
> >
> >           if ($has_empty) {
> >               my @clean =3D grep /.+/, @{$lines};
> >               $lines =3D \@clean;
> >           }
> >
> >           my $indlen =3D index($lines->[0], "(");
> >           return $lines if ($indlen < 0);
> >           my $indent =3D "";
> >           $indlen++;
> >           $indent .=3D "\t" x ($indlen / 8);
> >           $indent .=3D " " x ($indlen % 8);
> >
> >           my @padded =3D ();
> >           my $acc =3D "";
> >           my $len =3D -$indlen;
> >           for (my $i =3D 0; $i <=3D $#{$lines}; $i++) {
> >               my $argument =3D $lines->[$i];
> >               my $arglen =3D length($argument);
> >               my $last =3D ($i =3D=3D $#{$lines} ? 1 : 0);
> >
> >               if ($i =3D=3D 0 ||
> >                   $i =3D=3D 1) {
> >                   $acc .=3D $argument;
> >                   $acc .=3D ";" if ($last);
> >                   $len +=3D $arglen + $last;
> >                   next;
> >               }
> >               if (!$acc) {
> >                   $acc =3D $indent . $argument;
> >                   $acc .=3D ";" if ($last);
> >                   $len +=3D $arglen + $last;
> >                   next;
> >               }
> >               if ($indlen + $len + 1 + $arglen + $last > 79) {
> >                   push @padded, $acc;
> >                   $acc =3D $indent . $argument;
> >                   $acc .=3D ";" if ($last);
> >                   $len =3D $arglen + $last;
> >                   next;
> >               }
> >
> >               $acc .=3D " " . $argument;
> >               $acc .=3D ";" if ($last);
> >               $len +=3D 1 + $arglen + $last;
> >           }
> >           push @padded, $acc if ($acc);
> >           return \@padded;
> >       }
> >
> >       sub earliest(@) {
> >           my $ret =3D -1;
> >           foreach (@_) {
> >               $ret =3D $_ if ($ret < 0 || ($_ >=3D 0 && $_ < $ret));
> >           }
> >           return $ret;
> >       }
> >
> >       foreach my $file (@ARGV) {
> >           # Open the file for reading.
> >           next if $file =3D~ /trace[.]h$/;
> >           next if $file =3D~ /smbdirect[.][ch]$/;
> >           open my $fh, "<$file"
> >               or die "Could not open file '$file'";
> >           $pathname =3D $file;
> >           $lineno =3D 0;
> >
> >           my $filename;
> >           my @file_content =3D ();
> >           my @copy =3D ();
> >
> >           my $state =3D 0;
> >           my $qual =3D "";
> >           my $type =3D "";
> >           my $funcname =3D "";
> >           my @funcdef =3D ();
> >           my $bracket =3D 0;
> >           my $comment =3D 0;
> >           my $smb1 =3D 0;
> >           my $header =3D 0;
> >           my $inline =3D 0;
> >           my $file_marker =3D "";
> >           my $config =3D "";
> >           my $c_file =3D 0;
> >
> >           $filename =3D $pathname;
> >           $filename =3D~ s!.*/!!;
> >
> >           if ($file =3D~ m!.h$!) {
> >               my %new_h_file =3D (
> >                   path    =3D> $pathname,
> >                   fname   =3D> $filename,
> >                   content =3D> [],
> >                   );
> >               $header =3D \%new_h_file;
> >               $headers{$filename} =3D \%new_h_file;
> >           } elsif ($file =3D~ m!.c$!) {
> >               my %new_c_file =3D (
> >                   path  =3D> $pathname,
> >                   fname =3D> $filename,
> >                   funcs =3D> [],
> >                   );
> >               $c_file =3D \%new_c_file;
> >               $c_files{$filename} =3D \%new_c_file;
> >           } else {
> >               warn("Ignoring unexpected file $file\n");
> >               next;
> >           }
> >
> >           $smb1 =3D 1 if ($file =3D~ m!/smb1ops.c|/cifssmb.c|/cifstrans=
port.c!);
> >
> >           foreach my $line (<$fh>) {
> >               $lineno++;
> >               chomp($line);
> >               push @copy, $line;
> >               if (!$line) {
> >                   # Blank line
> >                   push @file_content, @copy;
> >                   @copy =3D ();
> >                   next;
> >               }
> >
> >               # Handle continuation or end of block comment.  Look for =
C file
> >               # prototype insertion point markers.
> >               if ($comment) {
> >                   if ($line =3D~ m![*]/!) {
> >                       if ($comment =3D=3D 2 && $file_marker) {
> >                           $cmarkers{$file_marker} =3D $file_marker;
> >                           push @copy, "#C_MARKER " . $filename;
> >                           $file_marker =3D 0;
> >                       }
> >                       $comment =3D 0;
> >                   } else {
> >                       $comment++;
> >                       if ($comment =3D=3D 2 && $line =3D~ m! [*] ([a-z]=
[a-z_0-9]*[.][c])$!) {
> >                           $file_marker =3D $1;
> >                           print("Found file marker ", $file_marker, " i=
n ", $filename, "\n");
> >                       }
> >                   }
> >                   push @file_content, @copy;
> >                   @copy =3D ();
> >                   next;
> >               }
> >
> >               # Check cpp directives, particularly looking for SMB1 bit=
s
> >               if ($line =3D~ /^[#]/) {
> >                   if ($header) {
> >                       if ($line =3D~ /ifdef.*(CONFIG_[A-Z0-9_])/) {
> >                           error("multiconfig") if $config;
> >                           $config =3D $1;
> >                           $smb1++ if ($config eq "CONFIG_CIFS_ALLOW_INS=
ECURE_LEGACY");
> >                       } elsif ($line =3D~ /endif/) {
> >                           $smb1-- if ($config eq "CONFIG_CIFS_ALLOW_INS=
ECURE_LEGACY");
> >                           $config =3D "";
> >                       }
> >                   }
> >                   push @file_content, @copy;
> >                   @copy =3D ();
> >                   next;
> >               }
> >
> >               # Exclude interference in finding func names and return t=
ypes
> >               if ($line =3D~ /^[{]/ ||
> >                   $line =3D~ /##/ ||
> >                   $line =3D~ /^[_a-z0-9A-Z]+:$/ || # goto label
> >                   $line =3D~ /^do [{]/ ||
> >                   $line =3D~ m!^//!) {
> >                   push @file_content, @copy;
> >                   @copy =3D ();
> >                   next;
> >               }
> >
> >               # Start of a block comment
> >               if ($line =3D~ m!^/[*]!) {
> >                   $comment =3D 1 unless ($line =3D~ m![*]/!);
> >                   push @file_content, @copy;
> >                   @copy =3D ();
> >                   next;
> >               }
> >
> >               # End of a braced section, such as a function implementat=
ion
> >               if ($line =3D~ /^[}]/) {
> >                       $type =3D "";
> >                       $qual =3D "";
> >                       $funcname =3D "";
> >                       @funcdef =3D ();
> >                       push @file_content, @copy;
> >                       @copy =3D ();
> >                       next;
> >               }
> >
> >               if ($line =3D~ /^typedef/) {
> >                   $type =3D "";
> >                   $qual =3D "";
> >                   $funcname =3D "";
> >                   @funcdef =3D ();
> >                   push @file_content, @copy;
> >                   @copy =3D ();
> >                   next;
> >               }
> >
> >               # Extract function qualifiers.  There may be multiple of =
these in more
> >               # or less any order.  Some of them cause the func to be s=
kipped (e.g. inline).
> >
> >               if ($line =3D~ /^(static|extern|inline|noinline|noinline_=
for_stack|__always_inline)\W/ ||
> >                   $line =3D~ /^(static|extern|inline|noinline|noinline_=
for_stack|__always_inline)$/) {
> >                   error("Unexpected qualifier '$1'") if ($state !=3D 0)=
;
> >                   while ($line =3D~ /^(static|extern|inline|noinline|no=
inline_for_stack|__always_inline)\W/ ||
> >                          $line =3D~ /^(static|extern|inline|noinline|no=
inline_for_stack|__always_inline)$/) {
> >                       $qual .=3D " " if ($qual);
> >                       $qual .=3D $1;
> >                       $inline =3D 1 if ($1 eq "inline");
> >                       $inline =3D 1 if ($1 eq "__always_inline");
> >                       $line =3D substr($line, length($1));
> >                       $line =3D~ s/^\s+//;
> >                   }
> >               }
> >
> >               if ($state =3D=3D 0) {
> >                   # Extract what we assume to be the return type
> >                   if ($line =3D~ /^\s/) {
> >                       push @file_content, @copy;
> >                       @copy =3D ();
> >                       next;
> >                   }
> >                   while ($line =3D~ /^(unsigned|signed|bool|char|short|=
int|long|void|const|volatile|(struct|union|enum)\s+[_a-zA-Z][_a-zA-Z0-9]*|[=
*]|__init|__exit|__le16|__le32|__le64|__be16|__be32|__be64)/) {
> >                       $type .=3D " " if $type;
> >                       $type .=3D $1;
> >                       $line =3D substr($line, length($1));
> >                       $line =3D~ s/^\s+//;
> >                   }
> >                   if ($line =3D~ /^struct [{]/) {
> >                       # Ignore structure definitions
> >                       $type =3D "";
> >                       $qual =3D "";
> >                       $funcname =3D "";
> >                       @funcdef =3D ();
> >                       push @file_content, @copy;
> >                       @copy =3D ();
> >                       next;
> >                   }
> >                   if (index($line, "=3D") >=3D 0) {
> >                       # Ignore assignments
> >                       $type =3D "";
> >                       $qual =3D "";
> >                       $funcname =3D "";
> >                       @funcdef =3D "";
> >                       push @file_content, @copy;
> >                       @copy =3D ();
> >                       next;
> >                   }
> >
> >                   # Try and extract a function's type and name
> >                   while ($line =3D~ /(^[_a-zA-Z][_a-zA-Z0-9]*)/) {
> >                       my $name =3D $1;
> >                       $line =3D substr($line, length($name));
> >                       next if ($line =3D~ /^[{]/);
> >                       $line =3D~ s/^\s+//;
> >
> >                       my $ch =3D substr($line, 0, 1);
> >                       last if ($ch eq "[" || $ch eq ";"); # Global vari=
ables
> >
> >                       if ($ch eq "(") {
> >                           # Found the function name
> >                           $state =3D 1;
> >                           $line =3D substr($line, 1);
> >                           $funcname =3D $name;
> >                           my $tmp =3D $qual . $type . " " . $funcname .=
 "(";
> >                           $tmp =3D~ s/[*] /*/;
> >                           push @funcdef, $tmp;
> >                           $bracket =3D 1;
> >                           last;
> >                       }
> >
> >                       if ($type) {
> >                           last if (index($line, ";") >=3D 0 && index($l=
ine, "(") =3D=3D -1);
> >                           error("Unexpected name '$name' after '$type'"=
);
> >                       }
> >
> >                       $type .=3D " " if $type;
> >                       $type .=3D $name;
> >                       if ($line =3D~ /^(\s*[*]+)/) {
> >                           my $ptr =3D $1;
> >                           $type .=3D $ptr;
> >                           $line =3D substr($line, length($ptr));
> >                       }
> >                   }
> >               }
> >
> >               # Try and extract a function's argument list
> >               my $from =3D 0;
> >               if ($state =3D=3D 1) {
> >                   while (1) {
> >                       my $o =3D index($line, "(", $from);
> >                       my $c =3D index($line, ")", $from);
> >                       my $m =3D index($line, ",", $from);
> >
> >                       my $b =3D earliest($o, $c, $m);
> >                       if ($b < 0) {
> >                           push @funcdef, $line
> >                               unless ($line eq "");
> >                           last;
> >                       }
> >                       my $ch =3D substr($line, $b, 1);
> >
> >                       # Push the arguments separately on to the list
> >                       if ($ch eq ",") {
> >                           push @funcdef, substr($line, 0, $b + 1);
> >                           $line =3D substr($line, $b + 1);
> >                           $from =3D 0;
> >                       } elsif ($ch eq "(") {
> >                           # Handle brackets in the argument list (e.g. =
function
> >                           # pointers)
> >                           $bracket++;
> >                           $from =3D $b + 1;
> >                       } elsif ($ch eq ")") {
> >                           $bracket--;
> >                           if ($bracket =3D=3D 0) {
> >                               push @funcdef, substr($line, 0, $b + 1);
> >                               $line =3D substr($line, $b + 1);
> >                               $state =3D 2;
> >                               last;
> >                           }
> >                           $from =3D $b + 1;
> >                       }
> >                   }
> >               }
> >
> >               if ($state =3D=3D 2) {
> >                   $inline =3D 1 if ($qual =3D~ /inline/);
> >                   #print("QUAL $qual $type $funcname $inline ", $#funcd=
ef, "\n");
> >                   if (!$header &&
> >                       $qual !~ /static/ &&
> >                       $funcname ne "__acquires" &&
> >                       $funcname ne "__releases" &&
> >                       $funcname ne "module_init" &&
> >                       $funcname ne "module_exit" &&
> >                       $funcname ne "module_param" &&
> >                       $funcname ne "module_param_call" &&
> >                       $funcname ne "PROC_FILE_DEFINE" &&
> >                       $funcname !~ /MODULE_/ &&
> >                       $funcname !~ /DEFINE_/) {
> >
> >                       # Okay, we appear to have a function implementati=
on
> >                       my $func;
> >
> >                       if (exists($funcs{$funcname})) {
> >                           $func =3D $funcs{$funcname};
> >                           $func->{body} =3D pad(\@funcdef);
> >                       } else {
> >                           my %new_func =3D (
> >                               name =3D> $funcname,
> >                               cond =3D> "",
> >                               );
> >                           $func =3D \%new_func;
> >                           $funcs{$funcname} =3D $func;
> >                           $func->{body} =3D pad(\@funcdef);
> >                       }
> >                       $func->{body} =3D pad(\@funcdef);
> >
> >                       if ($funcname eq "cifs_inval_name_dfs_link_error"=
) {
> >                           $func->{cond} =3D "#ifdef CONFIG_CIFS_DFS_UPC=
ALL";
> >                       } elsif ($funcname eq "cifs_listxattr") {
> >                           $func->{cond} =3D "#ifdef CONFIG_CIFS_XATTR";
> >                       }
> >
> >                       push @{$c_file->{funcs}}, $func;
> >                   } elsif (!$header || $inline) {
> >                       # Ignore inline function implementations and othe=
r weirdies
> >                       push @file_content, @copy;
> >                   } elsif ($header && !$inline) {
> >                       push @file_content, "#FUNCPROTO " . $funcname;
> >
> >                       my $func;
> >
> >                       if (exists($funcs{$funcname})) {
> >                           $func =3D $funcs{$funcname};
> >                           $func->{lineno} =3D $lineno;
> >                           $func->{pathname} =3D $pathname;
> >                       } else {
> >                           my %new_func =3D (
> >                               name =3D> $funcname,
> >                               cond =3D> "",
> >                               lineno =3D> $lineno,
> >                               pathname =3D> $pathname,
> >                               );
> >                           $func =3D \%new_func;
> >                           $funcs{$funcname} =3D $func;
> >                       }
> >                   }
> >
> >                   @funcdef =3D ();
> >                   $type =3D "";
> >                   $qual =3D "";
> >                   $funcname =3D "";
> >                   $inline =3D 0;
> >                   $state =3D 0;
> >                   @copy =3D ();
> >               }
> >               if ($line =3D~ /;/) {
> >                   $type =3D "";
> >                   $qual =3D "";
> >                   $funcname =3D "";
> >                   @funcdef =3D ();
> >                   $state =3D 0;
> >                   push @file_content, @copy;
> >                   @copy =3D ();
> >               }
> >           }
> >           close($fh);
> >
> >           if ($header) {
> >               $header->{content} =3D \@file_content;
> >           }
> >       }
> >
> >       sub write_header($)
> >       {
> >           my ($header) =3D @_;
> >           my $path =3D $header->{path};
> >
> >           my @output =3D ();
> >
> >           foreach my $line (@{$header->{content}}) {
> >               if ($line =3D~ "^[#]C_MARKER (.*)") {
> >                   next;
> >               } elsif ($line =3D~ "^[#]FUNCPROTO ([_a-zA-Z0-9]+)") {
> >                   my $funcname =3D $1;
> >                   my $func =3D $funcs{$funcname};
> >                   if (!$func->{body}) {
> >                       print($func->{pathname}, ":", $func->{lineno}, ":=
 '", $funcname,
> >                             "' dead prototype\n");
> >                       next;
> >                   }
> >                   #push @output, $line;
> >                   push @output, @{$func->{body}};
> >               } else {
> >                   push @output, $line;
> >               }
> >           }
> >
> >           open my $fh, ">$path"
> >               or die "Could not open file '$path' for writing";
> >           foreach my $f (@output) {
> >               print($fh $f, "\n") or die $path;
> >           }
> >           close($fh) or die $path;
> >
> >           print("Git $path\n");
> >           if (system("git diff -s --exit-code $path") =3D=3D 0) {
> >               print("- no changes, skipping\n");
> >               return;
> >           }
> >
> >           if (system("git add $path") !=3D 0) {
> >               die("'git add $path' failed\n");
> >           }
> >
> >           open $fh, ">.commit_message"
> >               or die "Could not open file '.commit_message' for writing=
";
> >           print($fh
> >                 qq/
> >       cifs: Scripted clean up $path
> >
> >       Remove externs, correct argument names and reformat declarations.
> >
> >       Signed-off-by: David Howells <dhowells\@redhat.com>
> >       cc: Steve French <sfrench\@samba.org>
> >       cc: Paulo Alcantara <pc\@manguebit.org>
> >       cc: Enzo Matsumiya <ematsumiya\@suse.de>
> >       cc: linux-cifs\@vger.kernel.org
> >       cc: linux-fsdevel\@vger.kernel.org
> >       cc: linux-kernel\@vger.kernel.org
> >       /);
> >           close($fh) or die ".commit_message";
> >
> >           if (system("git commit -F .commit_message") !=3D 0) {
> >               die("'git commit $path' failed\n");
> >           }
> >       }
> >
> >       foreach my $h (keys(%headers)) {
> >           write_header($headers{$h});
> >       }
> >
> >David Howells (37):
> >  cifs: Scripted clean up fs/smb/client/cached_dir.h
> >  cifs: Scripted clean up fs/smb/client/dfs.h
> >  cifs: Scripted clean up fs/smb/client/cifsproto.h
> >  cifs: Scripted clean up fs/smb/client/cifs_unicode.h
> >  cifs: Scripted clean up fs/smb/client/netlink.h
> >  cifs: Scripted clean up fs/smb/client/cifsfs.h
> >  cifs: Scripted clean up fs/smb/client/dfs_cache.h
> >  cifs: Scripted clean up fs/smb/client/dns_resolve.h
> >  cifs: Scripted clean up fs/smb/client/cifsglob.h
> >  cifs: Scripted clean up fs/smb/client/fscache.h
> >  cifs: Scripted clean up fs/smb/client/fs_context.h
> >  cifs: Scripted clean up fs/smb/client/cifs_spnego.h
> >  cifs: Scripted clean up fs/smb/client/compress.h
> >  cifs: Scripted clean up fs/smb/client/cifs_swn.h
> >  cifs: Scripted clean up fs/smb/client/cifs_debug.h
> >  cifs: Scripted clean up fs/smb/client/smb2proto.h
> >  cifs: Scripted clean up fs/smb/client/reparse.h
> >  cifs: Scripted clean up fs/smb/client/ntlmssp.h
> >  cifs: SMB1 split: Rename cifstransport.c
> >  cifs: SMB1 split: Create smb1proto.h for SMB1 declarations
> >  cifs: SMB1 split: Separate out SMB1 decls into smb1proto.h
> >  cifs: SMB1 split: Move some SMB1 receive bits to smb1transport.c
> >  cifs: SMB1 split: Move some SMB1 received PDU checking bits to
> >    smb1transport.c
> >  cifs: SMB1 split: Add some #includes
> >  cifs: SMB1 split: Split SMB1 protocol defs into smb1pdu.h
> >  cifs: SMB1 split: Adjust #includes
> >  cifs: SMB1 split: Move BCC access functions
> >  cifs: SMB1 split: Don't return smb_hdr from cifs_{,small_}buf_get()
> >  cifs: Fix cifs_dump_mids() to call ->dump_detail
> >  cifs: SMB1 split: Move inline funcs
> >  cifs: SMB1 split: cifs_debug.c
> >  cifs: SMB1 split: misc.c
> >  cifs: SMB1 split: netmisc.c
> >  cifs: SMB1 split: cifsencrypt.c
> >  cifs: SMB1 split: sess.c
> >  cifs: SMB1 split: connect.c
> >  cifs: SMB1 split: Make BCC accessors conditional
> >
> > fs/smb/client/Makefile        |   10 +-
> > fs/smb/client/cached_dir.h    |   30 +-
> > fs/smb/client/cifs_debug.c    |   18 +-
> > fs/smb/client/cifs_debug.h    |    1 -
> > fs/smb/client/cifs_spnego.h   |    4 +-
> > fs/smb/client/cifs_swn.h      |   10 +-
> > fs/smb/client/cifs_unicode.c  |    1 -
> > fs/smb/client/cifs_unicode.h  |   17 +-
> > fs/smb/client/cifsacl.c       |    1 -
> > fs/smb/client/cifsencrypt.c   |  124 --
> > fs/smb/client/cifsfs.c        |    1 -
> > fs/smb/client/cifsfs.h        |  114 +-
> > fs/smb/client/cifsglob.h      |   29 +-
> > fs/smb/client/cifspdu.h       | 2377 +--------------------------------
> > fs/smb/client/cifsproto.h     |  780 ++++-------
> > fs/smb/client/cifssmb.c       |  147 +-
> > fs/smb/client/cifstransport.c |  263 ----
> > fs/smb/client/compress.h      |    3 +-
> > fs/smb/client/connect.c       |  252 ----
> > fs/smb/client/dfs.h           |    3 +-
> > fs/smb/client/dfs_cache.h     |   19 +-
> > fs/smb/client/dir.c           |    1 -
> > fs/smb/client/dns_resolve.h   |    4 +-
> > fs/smb/client/file.c          |    1 -
> > fs/smb/client/fs_context.c    |    1 -
> > fs/smb/client/fs_context.h    |   16 +-
> > fs/smb/client/fscache.h       |   17 +-
> > fs/smb/client/inode.c         |    1 -
> > fs/smb/client/ioctl.c         |    1 -
> > fs/smb/client/link.c          |    1 -
> > fs/smb/client/misc.c          |  302 +----
> > fs/smb/client/netlink.h       |    4 +-
> > fs/smb/client/netmisc.c       |  824 +-----------
> > fs/smb/client/ntlmssp.h       |   15 +-
> > fs/smb/client/readdir.c       |    1 -
> > fs/smb/client/reparse.h       |   14 +-
> > fs/smb/client/sess.c          |  982 --------------
> > fs/smb/client/smb1debug.c     |   25 +
> > fs/smb/client/smb1encrypt.c   |  139 ++
> > fs/smb/client/smb1maperror.c  |  825 ++++++++++++
> > fs/smb/client/smb1misc.c      |  189 +++
> > fs/smb/client/smb1ops.c       |  279 ++--
> > fs/smb/client/smb1pdu.h       | 2354 ++++++++++++++++++++++++++++++++
> > fs/smb/client/smb1proto.h     |  336 +++++
> > fs/smb/client/smb1session.c   |  995 ++++++++++++++
> > fs/smb/client/smb1transport.c |  561 ++++++++
> > fs/smb/client/smb2file.c      |    2 +-
> > fs/smb/client/smb2inode.c     |    2 +-
> > fs/smb/client/smb2pdu.c       |    2 +-
> > fs/smb/client/smb2proto.h     |  468 +++----
> > fs/smb/client/smbencrypt.c    |    1 -
> > fs/smb/client/transport.c     |    1 -
> > fs/smb/client/xattr.c         |    1 -
> > fs/smb/common/smb2pdu.h       |    3 +
> > 54 files changed, 6310 insertions(+), 6262 deletions(-)
> > delete mode 100644 fs/smb/client/cifstransport.c
> > create mode 100644 fs/smb/client/smb1debug.c
> > create mode 100644 fs/smb/client/smb1encrypt.c
> > create mode 100644 fs/smb/client/smb1maperror.c
> > create mode 100644 fs/smb/client/smb1misc.c
> > create mode 100644 fs/smb/client/smb1pdu.h
> > create mode 100644 fs/smb/client/smb1proto.h
> > create mode 100644 fs/smb/client/smb1session.c
> > create mode 100644 fs/smb/client/smb1transport.c
> >
>


--=20
Thanks,

Steve

