Return-Path: <linux-fsdevel+bounces-14577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05987DE4F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF39A1C2112F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EE1CD16;
	Sun, 17 Mar 2024 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agFV64D5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689C1CA96;
	Sun, 17 Mar 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692604; cv=none; b=RWu/L7cyYf87ZHw3utVzqvbpTNCS40iqSDFgPahydxaxAhmA1nBr6g9IppFQnqpE+k1HwbxzBKOxuxbPyH2rr1JC9PKlomqQZO25mUMAFSWHU2UnY7GltnOBifxKoMFDwYgqNcC3vHlM+h6wsbL4YHWAjct2dbFbES35ABskqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692604; c=relaxed/simple;
	bh=KI16EBOhLwH6waiRsWWAx3GpeEy4DbKP9iRPEORBXrQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdjxYL+0I6Jc8Bq73Iq2UmLKoDSyvlmVz/YLB8H516uNUcpXNJUQB439TOV7MEfP98QD2Og8l9H6FkRlQjNXLxPntk6rFbKgHxmvTGCe0VJ8j37MTL2RsHj91U9P95R49iKP2acuL3w4bBX8Vx6YOLI28V4Jy+fHJhsWGqrCTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agFV64D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271DDC433F1;
	Sun, 17 Mar 2024 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692604;
	bh=KI16EBOhLwH6waiRsWWAx3GpeEy4DbKP9iRPEORBXrQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=agFV64D5BwWEax4CgHngeHOvx1cfz7dovhsCK6DxCwqvSMACldB6DbLYIWHmS3BRZ
	 hXIfwTgUbK/fc+XeDMDW+4PmWhXbpnuy6Mc4Tcb6UgdtcqapNQ61Tg49WrryMh6pRB
	 RL+ZG6JO3VIzMEfnVJtXWH7GsxM+NGSCWboByEL3psU2aHpNy56Fe1VvpuP0q/dSU8
	 rMVX0uDMTEZq+Y3Y7VSE9LnEJPUlSlHmo2T+PLzGRQP4xKEVSNOvBUl6wk7b4ifHbW
	 nRXn4B4fxs+/IPOF1rfQdOIYWZdtYBqEBNZT0AHIivcnGauyw18eeqDidwv2y1H6h0
	 z53lP0CjX0mTA==
Date: Sun, 17 Mar 2024 09:23:23 -0700
Subject: [PATCHSET v5.3] fstests: fs-verity support for XFS
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org,
 zlang@redhat.com
Cc: Andrey Albershteyn <andrey.albershteyn@gmail.com>,
 fsverity@lists.linux.dev, fstests@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org
Message-ID: <171069248832.2687004.7611830288449050659.stgit@frogsfrogsfrogs>
In-Reply-To: <20240317161954.GC1927156@frogsfrogsfrogs>
References: <20240317161954.GC1927156@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

From Darrick J. Wong:

This v5.3 patchset builds upon v5.2 of Andrey's patchset to implement
fsverity for XFS.

The biggest thing that I didn't like in the v5 patchset is the abuse of
the data device's buffer cache to store the incore version of the merkle
tree blocks.  Not only do verity state flags end up in xfs_buf, but the
double-alloc flag wastes memory and doesn't remain internally consistent
if the xattrs shift around.

I replaced all of that with a per-inode xarray that indexes incore
merkle tree blocks.  For cache hits, this dramatically reduces the
amount of work that xfs has to do to feed fsverity.  The per-block
overhead is much lower (8 bytes instead of ~300 for xfs_bufs), and we no
longer have to entertain layering violations in the buffer cache.  I
also added a per-filesystem shrinker so that reclaim can cull cached
merkle tree blocks, starting with the leaf tree nodes.

I've also rolled in some changes recommended by the fsverity maintainer,
fixed some organization and naming problems in the xfs code, fixed a
collision in the xfs_inode iflags, and improved dead merkle tree cleanup
per the discussion of the v5 series.  At this point I'm happy enough
with this code to start integrating and testing it in my trees, so it's
time to send it out a coherent patchset for comments.

For v5.3, I've added bits and pieces of online and offline repair
support, reduced the size of partially filled merkle tree blocks by
removing trailing zeroes, changed the xattr hash function to better
avoid collisions between merkle tree keys, made the fsverity
invalidation bitmap unnecessary, and made it so that we can save space
on sparse verity files by not storing merkle tree blocks that hash
totally zeroed data blocks.

From Andrey Albershteyn:

Here's v5 of my patchset of adding fs-verity support to XFS.

This implementation uses extended attributes to store fs-verity
metadata. The Merkle tree blocks are stored in the remote extended
attributes. The names are offsets into the tree.

A few key points of this patchset:
- fs-verity can work with Merkle tree blocks based caching (xfs) and
  PAGE caching (ext4, f2fs, btrfs)
- iomap does fs-verity verification
- In XFS, fs-verity metadata is stored in extended attributes
- per-sb workqueue for verification processing
- Inodes with fs-verity have new on-disk diflag
- xfs_attr_get() can return a buffer with an extended attribute
- xfs_buf can allocate double space for Merkle tree blocks. Part of
  the space is used to store  the extended attribute data without
  leaf headers
- xfs_buf tracks verified status of merkle tree blocks

The patchset consists of five parts:
- [1]: fs-verity spinlock removal pending in fsverity/for-next
- [2..4]: Parent pointers adding binary xattr names
- [5]: Expose FS_XFLAG_VERITY for fs-verity files
- [6..9]: Changes to fs-verity core
- [10]: Integrate fs-verity to iomap
- [11-24]: Add fs-verity support to XFS

Testing:
The patchset is tested with xfstests -g verity on xfs_1k, xfs_4k,
xfs_1k_quota, xfs_4k_quota, ext4_4k, and ext4_4k_quota. With
KMEMLEAK and KASAN enabled. More testing on the way.

Changes from V4:
- Mainly fs-verity changes; removed unnecessary functions
- Replace XFS workqueue with per-sb workqueue created in
  fsverity_set_ops()
- Drop patch with readahead calculation in bytes
Changes from V3:
- redone changes to fs-verity core as previous version had an issue
  on ext4
- add blocks invalidation interface to fs-verity
- move memory ordering primitives out of block status check to fs
  read block function
- add fs-verity verification to iomap instead of general post read
  processing
Changes from V2:
- FS_XFLAG_VERITY extended attribute flag
- Change fs-verity to use Merkle tree blocks instead of expecting
  PAGE references from filesystem
- Change approach in iomap to filesystem provided bio_set and
  submit_io instead of just callouts to filesystem
- Add possibility for xfs_buf allocate more space for fs-verity
  extended attributes
- Make xfs_attr module to copy fs-verity blocks inside the xfs_buf,
  so XFS can get data without leaf headers
- Add Merkle tree removal for error path
- Makae scrub aware of new dinode flag
Changes from V1:
- Added parent pointer patches for easier testing
- Many issues and refactoring points fixed from the V1 review
- Adjusted for recent changes in fs-verity core (folios, non-4k)
- Dropped disabling of large folios
- Completely new fsverity patches (fix, callout, log_blocksize)
- Change approach to verification in iomap to the same one as in
  write path. Callouts to fs instead of direct fs-verity use.
- New XFS workqueue for post read folio verification
- xfs_attr_get() can return underlying xfs_buf
- xfs_bufs are marked with XBF_VERITY_CHECKED to track verified
  blocks

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fsverity
---
Commits in this patchset:
 * common/verity: enable fsverity for XFS
 * xfs/{021,122}: adapt to fsverity xattrs
 * common/populate: add verity files to populate xfs images
---
 common/populate   |   21 +++++++++++++++++++++
 common/verity     |   29 ++++++++++++++++++++++++++++-
 tests/xfs/021     |    3 +++
 tests/xfs/122.out |    1 +
 4 files changed, 53 insertions(+), 1 deletion(-)


