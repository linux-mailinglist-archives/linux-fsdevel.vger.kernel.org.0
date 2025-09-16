Return-Path: <linux-fsdevel+bounces-61470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDC2B588EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6E854E01E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92151CD0C;
	Tue, 16 Sep 2025 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhI01icK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1651C6A3;
	Tue, 16 Sep 2025 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981280; cv=none; b=J3LF4TLTptcmCp2uhRfKxKqVuT1fuKvEXXRs+9/YHcpMSaVrrKcjwNBBHxr07SoauFuJorBBlZRxKqFtayUG9t1fmrpr5iXM3suYbyeQ4ldz2IyNOSTfXDKr2Eyw0BNvjaht0p9exPNTgUAVbRjx43QWQfTUx018wbuSLTGwtOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981280; c=relaxed/simple;
	bh=3GTC66K0tyurN4jAxGs+ql5VrQkDZxY1v+/YAkrTFkg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SeMLXyouR3nALVSZ92u64r9ES1Cn2t6bIitq4viijKhco5nj6FWOrP/Pa6Pdm42n0WLiMfnmAr2M7luoSv1ynGIgPA3eTdabTF3yabj0SXGaTix8Egld/ip6VdUciJiE6F3EA8xOa4YFe8CtM31HX5ljaNUd2fBnIOj9fQ2gi64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhI01icK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3242C4CEF1;
	Tue, 16 Sep 2025 00:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981279;
	bh=3GTC66K0tyurN4jAxGs+ql5VrQkDZxY1v+/YAkrTFkg=;
	h=Date:From:To:Cc:Subject:From;
	b=jhI01icKpW2w89yih4AX9MmtlPhetXTwhwlE0Q5AE9O6hhJd8jQT4SdTHpfLKmfYT
	 xnFQ5B0rKjLPDgPYweII+zqsgy4v1jAgPcvE5wQ+dKJre2ujylovU8SJ3/rQ+rSJIc
	 0DSZZnbdvTcAWzhWU8RQGaSyiioSgwFAO09IAbVgo/VpDEtBytBMqve41LbwKpQVoA
	 SkMEY9iTvbdP14rZPVywD7TlanyCtMNAbhqW0NwuFPVEGhpmiiCQ2caimmcrr38jsc
	 ALn63nX8bkqq6a2DJkVxl9YxG3I1M3N9qpvYPKbKYGAbtmfnzFxB1qMzlLEEfEIEk8
	 hBigp/nK/qMKA==
Date: Mon, 15 Sep 2025 17:07:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>, Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [RFC v5] fuse: containerize ext4 for safer operation
Message-ID: <20250916000759.GA8080@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

[Ok maybe it's time to merge some of this stuff.  I'm removing the RFC
tag, but most likely the only patches that should get merged at this
point are the bugfixes at the start.  Don't merge the rest until after
the 2025 LTS kernel merge window closes, please.]

This is the fifth public draft of a prototype to connect the Linux fuse
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

These items have been addressed since the fourth RFC:

1. After six months, I have achieved my primary goal: a containerized
   filesystem server!  We can now run fuse4fs as a completely
   unprivileged and namespace-restricted systemd service on behalf of
   anyone who can open a file and mount it.  Many thanks again to
   Christian (and Miklos and Bernd and Amir) for their help!

   Someone who knows how to design socket-based protocols ought to have
   a look at the libfuse changes.  The mount helper and the fuse server
   communicate via a AF_UNIX socket, which enables the mount helper to
   pass resources into the service container.

2. I took a stab at implementing fsdax.  I then encountered the horror
   that is dax_writeback_mapping_range and abandoned that work.
   Writeback needs to iterate the file mappings and not make assumptions
   about the backing device ... but that's not a problem that anyone
   here needs to solve.

3. struct fuse_inode shrank after I verified that the iomap fileio paths
   never have to venture into the regular or wb cache paths.

4. fstests passes 99% of the tests that run, when iomap is enabled!
   96% pass when iomap is disabled, and I think that's due to some
   bugs in fstests.

5. Some VFS iflags (sync/immutable/append) now work.

6. iomap and passthrough share the backing file management code.  They
   are not expected to share backing files.

There are some major warts remaining:

a. I would like to start a discussion about how the design review of
   this code should be structured, and how might I go about creating new
   userspace filesystem servers -- lightweight new ones based off the
   existing userspace tools?  Or by merging lklfuse?

b. No design review document yet.

c. Why aren't we at 100% fstests passing?  Even with the kernel ext4?

d. I'm not 100% certain that the code that handles EOF zeroing actually
   works correctly.  Does fuse+iomap need to track both the server's
   and the VFS' notion of EOF the same way that XFS does?

e. ext4 doesn't support out of place writes so I don't know if that
   actually works correctly.

f. fuse2fs doesn't support the ext4 journal.  Urk.

g. There's a VERY large quantity of fuse2fs improvements that need to be
   applied before we get to the fuse-iomap parts.  I'm not sending these
   (or the fstests changes) to keep the size of the patchbomb at
   "unreasonably large". :P

I'll work on these in October, but now you all have an alpha-complete
demonstration to take a look at.

--Darrick




