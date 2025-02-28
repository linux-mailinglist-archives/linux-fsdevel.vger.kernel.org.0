Return-Path: <linux-fsdevel+bounces-42854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C19A49A06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD403B3D2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21C26B2D7;
	Fri, 28 Feb 2025 12:56:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667EA26B0BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747367; cv=none; b=BxBeH4o9lPnskDw6pzxsjNKAoYH/xLPeK65rBKW2xup19pVI3YeAoo4RYBi9ts0pwSA45cuJDecqJB2LfcVFP79TkxM0ZNwVTfLHNrTlIpdoyXYo4nm4nnnuU7caRpn8nsjOdh4lQofrWAIUBmCjsk9pfEUs6tKgsf1SUpjSYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747367; c=relaxed/simple;
	bh=dzZoHI9rMddSbHvJRJirHefyns5NJEYPlg5bQ0h6LgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBdjeid50KtG66XYdyknKa2d0zWoNz7WEfd19JwxB+H0CBu4znhwRPnzP4jidVe3rawkxGSaSfaAo3J+c5YZd4f01ehWpV5ufgewqS0RRYbe/ub716ImrHXnSkchmsPS8CjV78LNcWKmeUWbUnxahriN2ZCzIRQx+GEAJhLzKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-92.bstnma.fios.verizon.net [173.48.112.92])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51SCtgrI031380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 07:55:43 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 78D4B2E010B; Fri, 28 Feb 2025 07:55:42 -0500 (EST)
Date: Fri, 28 Feb 2025 07:55:42 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-staging@lists.linux.dev, asahi@lists.linux.dev
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Message-ID: <20250228125542.GA15240@mit.edu>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>

On Thu, Feb 27, 2025 at 08:53:56PM -0500, Ethan Carter Edwards wrote:
> Lately, I have been thinking a lot about the lack of APFS support on
> Linux. I was wondering what I could do about that. APFS support is not 
> in-tree, but there is a proprietary module sold by Paragon software [0].
> Obviously, this could not be used in-tree. However, there is also an 
> open source driver that, from what I can tell, was once planned to be 
> upstreamed [1] with associated filesystem progs [2]. I think I would 
> base most of my work off of the existing FOSS tree.
> 
> The biggest barrier I see currently is the driver's use of bufferheads.
> I realize that there has been a lot of work to move existing filesystem
> implementations to iomap/folios, and adding a filesystem that uses
> bufferheads would be antithetical to the purpose of that effort.
> Additionally, there is a lot of ifndefs/C preprocessor magic littered
> throughout the codebase that fixes functionality with various different
> versions of Linux.

I don't see the use of bufferheads as a fundamental barrier to the
mainline kernel; certainly not for staging.  First of all, there are a
huge number of file systems which still use buffer heads, including:

   adfs affs befs bfs ecryptfs efs exfat ext2 ext4 fat
   freevxfs gfs2 hfs hfsplus hpfs isofs jfs minix nilfs2
   ntfs3 ocfs2 omfs pstore qnx4 qnx6 romfs sysv udf ufs

There are many reasons to move to folios, including better
performance, and making it easier to make sure things are done
correctly if you can take advantage of iomap.

For example, with ext4 we plan to work towards moving to use folios
and iomap for the data plane operations for buffered write (we already
use iomap for Direct I/O, FIEMAP support, etc.) and while we might
want to move away from buffer heads for metadata blocks, we would need
to change the jbd2 layer to use some simplified layer that looks an
awful lot like buffer heads before we could do that.  We might try to
fork buffer heads, and strip out everything we don't need, and then
merge that with jbd2's journal_head structure, for example.  But
that's a mid-term to long-term project, because using bufferheads
doesn't actually hurt anyone.  (That being said, if anyone wants to
help out with the project of allowing us to move jbd2 away from buffer
heads, let me know --- patches are welcome.)

In any case, cleaning up preprocessor magic and other thigns that were
needed because the code was designed for out of tree use would be
something that I'd encourage you to focus on first, and then try a
proposal to submit it to staging.

Cheers,

					- Ted

P.S.  Something that you might want to consider using is fstests (AKA
xfstests), which is the gold standard for file system testing in
Linux.  I have a test appliance VM of xfstests, which you can find
here[1].  I test x86 and arm64 kernels using Google Cloud, and on
local systems, using qemu/kvm.  For qemu/kvm testing, this is being
used on Debian, Fedora, OpenSuSE, and MacOS.

[1] https://github.com/tytso/xfstests-bld

For kernel development on my Macbook Air M2, I can build arm64 kernels
using Debian running in a Parallels VM, and then to avoid the double
virtualization overhead, I run qemu on MacOS using the hvf
accelerator.  It shouldn't be hard to make this work on your Ashai
Linux development system; see more on that below.

For more details about this test infrastructure, including its use on
Google Cloud see the presentation here[2].  I am using gce-xfstests to
perform continuous integration testing by watching a git branch, and
when it gets updated, the test manager (running in an e2-micro VM)
automatically starts a 4 CPU VM to build the kernel, and then launches
multiple 2 CPU VM's to test multiple file system configurations in
parallel --- for example, I am currently running over two dozen fs
kernels testing ext4, xfs, btrfs, and f2fs on a Linux-next branch
every day).  Running a smoke test costs pennies.  A full-up test of a
dozen ext4 configuration (a dozen VM's, running for 2 hours of wall
clock time), costs under $2 at US retail prices.  For APFS, if you
start with a single configuration, with many of the tests disable
because APFS won't many of the advanced file systems of ext4 and xfs,
I'm guessing it will cost you less than 25 cents per test run.

[2] https://thunk.org/gce-xfstests

Or of course you can use qemu-xfstests or kvm-xfstests using local
compute.  I do love though being able to fire off a set of tests, then
suspend my laptop, knowing that I will receive e-mail with the test
results when they are ready.

If you are interested in trying to use this on Asahi linux, I'd
certainly be happy help you with it.  I suspect modulo some
instructures about which packages are needed, it shouldn't be that
hard to run a test appliance.  Building new versions of the appliance
does require a Debian build chroot, which might be tricker to set up
on Asahi, but that's not necessary while you are getting started.

In any case, I strongly encourage file system developers to use
xfstests earlier rather than later.  See the last slide of [2] for my
opinion of "File system development without testing".  :-)

