Return-Path: <linux-fsdevel+bounces-42887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1A9A4ACDB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 17:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3523A61BF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E061E503C;
	Sat,  1 Mar 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="RzjYuhup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D431B3927;
	Sat,  1 Mar 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740846431; cv=none; b=Ac74ZQ75XJ5lWGbKO58+Qp2CwCNmMrZrGvVAkwhwVJYkwCXtQMBrERdH7MBDvMHUS/eERXgiBIYT7S2Zesnx+QKCW1OvSiA2tDFf8Fe7lUyq5W+SyKp7sCHHM0jQUmVuJyeKpHYVWeM0J3KOKIp9vVOPqYhPTEWwdSc7NkYkKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740846431; c=relaxed/simple;
	bh=3p6spdndWB5QUzuG2nF0HeZeukZDLlCbvgCZBAqnvxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVFIlgEIcslAPmMUxHPTGvhzAudMMlNDcurA8mWZSDQNQt9UX+OdwS/o8x2BMQPVDJL2b+tK5BxKtic8U7vl85Z4iL8QJYhjD5LMBJeQELWZN0qzvFMRxysuhX013b0JO/84B4ZemNVlK66hYWSbvzIz/esh1D/O0PtBg/pFJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=RzjYuhup; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z4r7j51pwz9sQX;
	Sat,  1 Mar 2025 17:26:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740846417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQ6VZJ96+5ONhxBr0qPheWB+caC3iiIT6CZBfYHPT/c=;
	b=RzjYuhupVbR44B8xHJIb7Ak/MP8DPOKVrCCF+QIdO72LcmSJIxeKrlgqAYFDXgX3uBx9eY
	RBmBoeziZRbhzfDGSHt7qGHG4b7Ij3eMlH8FAQ5Jpl3AafPGW3rIR9OLBMybbDoxxBQz0U
	2JZShRcqSMNxXp8zBqST9h481XI7ek3OTsdTxv1l99bA1375BdQGusEj2do5O/BRomkRc+
	TvS9zK0nagzZ39b0iEx2gTA/Qfe8MDSC/GWVyZTicQ5D4/5uPk8KvjD7OKlv3Ay9YUTjE+
	TsDyOT1Q661ceKB7JcoJT5QJs3J86s0W8GYSJkt6ty2dk6tBc7obR9vXk2/6qw==
Date: Sat, 1 Mar 2025 11:26:53 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-staging@lists.linux.dev, asahi@lists.linux.dev
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Message-ID: <vrkh3khgrj5pls3shlvbp5j4lanubeps5nl3aq5r2e5ielq37j@fzofjj22kgwp>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
 <20250228125542.GA15240@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228125542.GA15240@mit.edu>
X-Rspamd-Queue-Id: 4Z4r7j51pwz9sQX

On 25/02/28 07:55AM, Theodore Ts'o wrote:
> On Thu, Feb 27, 2025 at 08:53:56PM -0500, Ethan Carter Edwards wrote:
> > Lately, I have been thinking a lot about the lack of APFS support on
> > Linux. I was wondering what I could do about that. APFS support is not 
> > in-tree, but there is a proprietary module sold by Paragon software [0].
> > Obviously, this could not be used in-tree. However, there is also an 
> > open source driver that, from what I can tell, was once planned to be 
> > upstreamed [1] with associated filesystem progs [2]. I think I would 
> > base most of my work off of the existing FOSS tree.
> > 
> > The biggest barrier I see currently is the driver's use of bufferheads.
> > I realize that there has been a lot of work to move existing filesystem
> > implementations to iomap/folios, and adding a filesystem that uses
> > bufferheads would be antithetical to the purpose of that effort.
> > Additionally, there is a lot of ifndefs/C preprocessor magic littered
> > throughout the codebase that fixes functionality with various different
> > versions of Linux.
> 
> I don't see the use of bufferheads as a fundamental barrier to the
> mainline kernel; certainly not for staging.  First of all, there are a
> huge number of file systems which still use buffer heads, including:
> 
>    adfs affs befs bfs ecryptfs efs exfat ext2 ext4 fat
>    freevxfs gfs2 hfs hfsplus hpfs isofs jfs minix nilfs2
>    ntfs3 ocfs2 omfs pstore qnx4 qnx6 romfs sysv udf ufs
> 

Good to know. I did not realized so many fs's stil used them. I will
not let that stop me from submitting a the driver to staging. I
definitely plan on moving them over as time permits.

> There are many reasons to move to folios, including better
> performance, and making it easier to make sure things are done
> correctly if you can take advantage of iomap.
> 
> For example, with ext4 we plan to work towards moving to use folios
> and iomap for the data plane operations for buffered write (we already
> use iomap for Direct I/O, FIEMAP support, etc.) and while we might
> want to move away from buffer heads for metadata blocks, we would need
> to change the jbd2 layer to use some simplified layer that looks an
> awful lot like buffer heads before we could do that.  We might try to
> fork buffer heads, and strip out everything we don't need, and then
> merge that with jbd2's journal_head structure, for example.  But
> that's a mid-term to long-term project, because using bufferheads
> doesn't actually hurt anyone.  (That being said, if anyone wants to
> help out with the project of allowing us to move jbd2 away from buffer
> heads, let me know --- patches are welcome.)
> 
> In any case, cleaning up preprocessor magic and other thigns that were
> needed because the code was designed for out of tree use would be
> something that I'd encourage you to focus on first, and then try a
> proposal to submit it to staging.

Will do.

> 
> Cheers,
> 
> 					- Ted
> 
> P.S.  Something that you might want to consider using is fstests (AKA
> xfstests), which is the gold standard for file system testing in
> Linux.  I have a test appliance VM of xfstests, which you can find
> here[1].  I test x86 and arm64 kernels using Google Cloud, and on
> local systems, using qemu/kvm.  For qemu/kvm testing, this is being
> used on Debian, Fedora, OpenSuSE, and MacOS.
> 
> [1] https://github.com/tytso/xfstests-bld
> 
> For kernel development on my Macbook Air M2, I can build arm64 kernels
> using Debian running in a Parallels VM, and then to avoid the double
> virtualization overhead, I run qemu on MacOS using the hvf
> accelerator.  It shouldn't be hard to make this work on your Ashai
> Linux development system; see more on that below.
> 
> For more details about this test infrastructure, including its use on
> Google Cloud see the presentation here[2].  I am using gce-xfstests to
> perform continuous integration testing by watching a git branch, and
> when it gets updated, the test manager (running in an e2-micro VM)
> automatically starts a 4 CPU VM to build the kernel, and then launches
> multiple 2 CPU VM's to test multiple file system configurations in
> parallel --- for example, I am currently running over two dozen fs
> kernels testing ext4, xfs, btrfs, and f2fs on a Linux-next branch
> every day).  Running a smoke test costs pennies.  A full-up test of a
> dozen ext4 configuration (a dozen VM's, running for 2 hours of wall
> clock time), costs under $2 at US retail prices.  For APFS, if you
> start with a single configuration, with many of the tests disable
> because APFS won't many of the advanced file systems of ext4 and xfs,
> I'm guessing it will cost you less than 25 cents per test run.
> 
> [2] https://thunk.org/gce-xfstests
> 
> Or of course you can use qemu-xfstests or kvm-xfstests using local
> compute.  I do love though being able to fire off a set of tests, then
> suspend my laptop, knowing that I will receive e-mail with the test
> results when they are ready.
> 
> If you are interested in trying to use this on Asahi linux, I'd
> certainly be happy help you with it.  I suspect modulo some
> instructures about which packages are needed, it shouldn't be that
> hard to run a test appliance.  Building new versions of the appliance
> does require a Debian build chroot, which might be tricker to set up
> on Asahi, but that's not necessary while you are getting started.
> 
> In any case, I strongly encourage file system developers to use
> xfstests earlier rather than later.  See the last slide of [2] for my
> opinion of "File system development without testing".  :-)

Good to know. I certainly agree with that last slide ;). Filesystems are
far too important to develop without a test suite. Tests have certainly
saved my butt in other projects, I have no doubt that it is the same for
fs devel.

Thank you for your detailed response. I was nervous that this idea would
not be well-recieved since there is an existing out-of-tree driver, but
since I am a believer in "upstream-first", I wanted to give this a try.

Thanks,
Ethan

