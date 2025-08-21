Return-Path: <linux-fsdevel+bounces-58420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9237B2E981
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD77A3A682A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F431D435F;
	Thu, 21 Aug 2025 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqQWu5dE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E581139D;
	Thu, 21 Aug 2025 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736641; cv=none; b=a3Sjv6IchVdV3g8DOmzq1CIYziOLMQ9fGocFtplkoLPdkNQhW10FRYxORm9BszYtSEvs80Mhbokd/poB1Tq4f7F9RLIrETkLtcn1ORrHLfFKmZpOURGXyTGwSYKd5Tbr/9Ay6TS6XvMEJlRbJZC+DxgyPF1kQamuNIw7h7SzbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736641; c=relaxed/simple;
	bh=Pvyd3elgZ98Xcsl8o5Td78mWaKXnrxRSspr5wRPGVSI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T1I16vh3mBjTJqgY7igaadOSgphdLQMNE1LxXwvnapSZNz8v2nPEkiWIS6HQbEUpxY7ebRsbA/RhstodLoam9OVYem56LxASNM2KUah/sfRs2bfq+wFvgXQAVdpOXQqFJ823UU2m9F5d2ARTlau5UJ11RgxKaebQqVOb7SCEAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqQWu5dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA91C4CEE7;
	Thu, 21 Aug 2025 00:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755736640;
	bh=Pvyd3elgZ98Xcsl8o5Td78mWaKXnrxRSspr5wRPGVSI=;
	h=Date:From:To:Cc:Subject:From;
	b=HqQWu5dERme2D6wO0c6DekYJcgKzEGQkb1UyPdT5FKMzcj3uAHPgPDyuenFCxVHxw
	 1T+snqdioXBpVprmFI9h2PkLENz65zOE+S0apqB5OWUlgEz0WeccftE4P474ZjDTwR
	 YsL+JY9qhm4DmGR65AONqmhjY6OLdK4/AH0WHKrQAqW3JcMSbDZITmquT1J/FGPyrz
	 TQ8bzAfMljBzx/6gwV8UVYDQa2Xnw2fBhxJy1+PL8zz6lezP0at/+T6v8uKvbRkYqs
	 aB30FZ/LvK+vOP9D1y1WD8SgriktLp0CDUvfqwMu+ybi+m3sVK7RHnftLGgyeK5WQE
	 9AuFoffwAp+Vg==
Date: Wed, 20 Aug 2025 17:37:20 -0700
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
Subject: [RFC v4] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250821003720.GA4194186@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

Do not merge this, still!!

This is the fourth request for comments of a prototype to connect the
Linux fuse driver to fs-iomap for regular file IO operations to and from
files whose contents persist to locally attached storage devices.

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

With this RFC, I am able to show that it's possible to build a fuse
server for a real filesystem (ext4) that runs entirely in userspace yet
maintains most of its performance.  At this stage I still get about 95%
of the kernel ext4 driver's streaming directio performance on streaming
IO, and 110% of its streaming buffered IO performance.  Random buffered
IO is about 85% as fast as the kernel.  Random direct IO is about 80% as
fast as the kernel; see the cover letter for the fuse2fs iomap changes
for more details.  Unwritten extent conversions on random direct writes
are especially painful for fuse+iomap (~90% more overhead) due to upcall
overhead.  And that's with (now dynamic) debugging turned on!

These items have been addressed since the third RFC:

1. fuse2fs has been forked into fuse4fs, which now talks to the low
   level fuse interface.  This avoids all the path walking that the
   high level fuse library provides, which dramatically improves the
   performance of fuse4fs.  fstests runs in half the time now.  Many
   thanks to Amir Goldstein for giving me a rough draft of the
   conversion!

2. I simplified the configuration protocols -- now there's a per-fs
   bit to enable any iomap, and a per-inode bit to enable iomap on a
   specific file.  Registration of iomap devices now uses the backing
   fd registration interface.

3. You can now specify the root nodeid for any fuse mount.

4. Atomic writes are working, at least for single fsblocks.

5. I've ported the cache implementation from xfsprogs to e2fsprogs
   libsupport, so the inode and buffer caches can now dynamically grow
   to support larger working sets.  No more fixed-size caches!

6. Cleaned up the kernel/libfuse ABI quite a bit.

7. fstests passes 97% of the tests that run, when iomap is enabled!
   Only 93% pass when iomap is disabled, and I think that's due to some
   bugs in the ACL and mode handling code.

There are some major warts remaining:

a. I've a /much/ clearer picture of how one might containerize a
   filesystem server, thanks to a lot of input from Christian Brauner
   in response to v3.  I think I have enough pieces to try setting up
   a fd-passing interface into a systemd service ... but I haven't
   actually written any of it yet.

b. fsdax isn't implemented.  I think I'm going to work on this for
   RFC v5 to see if we can simplify the file mapping handling in famfs.
   If not, then everyone else gets fsdax for free.

c. ext4 doesn't support out of place writes so I don't know if that
   actually works correctly.

d. I've not yet consolidated struct fuse_inode, so the iomap gunk still
   eats rather a lot of space per inode.

e. fuse2fs doesn't support the ext4 journal.  Urk.

f. There's a VERY large quantity of fuse2fs improvements that need to be
   applied before we get to the fuse-iomap parts.  I'm not sending these
   (or the fstests changes) to keep the size of the patchbomb at
   "unreasonably large". :P

I'll work on these in August/Steptember, but for now here's an
unmergeable RFC to start some discussion.

--Darrick



