Return-Path: <linux-fsdevel+bounces-65974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B77C178A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AAA3B5AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358E285042;
	Wed, 29 Oct 2025 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTwTWK7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769E3A1CD;
	Wed, 29 Oct 2025 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697676; cv=none; b=KTjps5I6AaVx/ho1YRjMxHoMiCuZXiixOSz+la9Ff6hUFBJtAetBo6TckKvEFWGwIZKjgjmhGKe4ZpUPBV7g7eyL8HMairQnNVnTLs1H9RgVEhSh5t+0YaovUlx2mXF8yGRV7KADh0vSLxY0F8VngLP71Peaw4uwbI0rXIztqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697676; c=relaxed/simple;
	bh=zK3Uedm3CZT16mNFd3TLzP0KpphAljz+7EQ6t2r7+5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hqIkm4nYn+1NrujyenCfDCuX4YAPeBlv8s8LNOA0TQpx5xt7KtiW0G139HBqpGDwlPMybDqwO9jFV1yO3g7chhPtwZP3iwf9xXsDuzYXEW07taGShF4Ili7qPdzFGdNMfC7Cy63qWNQL4SmXgx69OtC/gs9a14B2uoYW4X6x0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTwTWK7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15BDC4CEE7;
	Wed, 29 Oct 2025 00:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761697675;
	bh=zK3Uedm3CZT16mNFd3TLzP0KpphAljz+7EQ6t2r7+5o=;
	h=Date:From:To:Cc:Subject:From;
	b=LTwTWK7KX1zpnlqe/hjz/Vdmzy2raENMMYQ1i2hul9i80oVFqxaBZzVmsGM0nfrrQ
	 pZSMlgZlNiWrpGnFgdQl53f2r81d96SOwg1QMmC0GGV0apUsAcrwolOFTE9Yv09evX
	 jauWvhpxYxDmPKwB3R8mNKaKZp0osb0QVDyOdHPbsK2bN9+MmyHg6Fsg5ePDUIJozx
	 /xJduDXU/sgFm0T59u19hsxPbUDoqePwiD0dmGY+vDqoonSgG8PMFRKczr/N16s9wJ
	 IrGSjRekAJk63zxlxkDp7lF6P0oYikagrGb07wVGVfFp5jLNkUOZEFQMDmSnHAQ5YJ
	 N4aXeAT6ydn4g==
Date: Tue, 28 Oct 2025 17:27:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCHBOMB v6] fuse: containerize ext4 for safer operation
Message-ID: <20251029002755.GK6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Look ma, no more RFC tag!

This is the sixth public draft of a prototype to connect the Linux fuse
driver to fs-iomap for regular file IO operations to and from files
whose contents persist to locally attached storage devices.  With this
release, I show that it's possible to build a fuse server for a real
filesystem (ext4) that runs entirely in userspace yet maintains most of
its performance.  Furthermore, I also show that the userspace program
runs with minimal privilege, which means that we no longer need to have
filesystem metadata parsing be a privileged (== risky) operation.

Why would you want to do that?  Most filesystem drivers are seriously
vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
over almost a decade of its existence.  Faulty code can lead to total
kernel compromise, and I think there's a very strong incentive to move
all that parsing out to userspace where we can containerize the fuse
server process.

willy's folios conversion project (and to a certain degree RH's new
mount API) have also demonstrated that treewide changes to the core
mm/pagecache/fs code are very very difficult to pull off and take years
because you have to understand every filesystem's bespoke use of that
core code.  Eeeugh.

The fuse command plumbing is very simple -- the ->iomap_begin,
->iomap_end, and iomap ->ioend calls within iomap are turned into
upcalls to the fuse server via a trio of new fuse commands.  Pagecache
writeback is now a directio write.  The fuse server is now able to
upsert mappings into the kernel for cached access (== zero upcalls for
rereads and pure overwrites!) and the iomap cache revalidation code
works.

At this stage I still get about 95% of the kernel ext4 driver's
streaming directio performance on streaming IO, and 110% of its
streaming buffered IO performance.  Random buffered IO is about 85% as
fast as the kernel.  Random direct IO is about 80% as fast as the
kernel; see the cover letter for the fuse2fs iomap changes for more
details.  Unwritten extent conversions on random direct writes are
especially painful for fuse+iomap (~90% more overhead) due to upcall
overhead.  And that's with (now dynamic) debugging turned on!

These items have been addressed since the fifth RFC:

1. After seven months of work, I can get seven of my 15 or so testing
   profiles to pass fstests, most days.  There are a few flakey tests
   like generic/347 that (I think) sometimes fail because there's no
   journalling in jbd2.  That's better than kernel ext4, which never
   gets all the way to passing here.

2. Swap files, filesystem freeze and thaw, and shutdowns now work.

3. fuse4fs can now use PSI information as a clue that it's time for it
   to flush its caches and evict them.

There are some warts remaining:

a. I would like to start a discussion about how the design review of
   this code should be structured, and how might I go about creating new
   userspace filesystem servers -- lightweight new ones based off the
   existing userspace tools?  Or by merging lklfuse?

b. ext4 doesn't support out of place writes so I don't know if that
   actually works correctly.

c. fuse2fs doesn't support the ext4 journal.  Urk.

d. There's a VERY large quantity of fuse2fs improvements that need to be
   applied before we get to the fuse-iomap parts.  I'm not sending these
   (or the fstests changes) to keep the size of the patchbomb at
   "unreasonably large". :P  As a result, the fstests and e2fsprogs
   postings are very targeted.

I'll work on these in November, but now I'm much more serious about
getting this merged for 6.19 now that the LTS is past and the coast is
clear.

--Darrick

