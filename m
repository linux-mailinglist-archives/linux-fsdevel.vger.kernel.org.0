Return-Path: <linux-fsdevel+bounces-14576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD6387DE4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FF11C2109B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6B1CD13;
	Sun, 17 Mar 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT9E9Myg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67B1CAB3;
	Sun, 17 Mar 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692589; cv=none; b=s4A3oYub5AiW29q386hw5K2CZLPHMSdO0NajQvLSFUdiOxCgNzdi0+Ih8BKMfUHj8t8018tkrHuUMHMYmf7y+sgf9j6hLnsR5F3KPyxDa7nsM2lp/TA4FQDh84KELsFwPZos1xzdYddr0ix7PucMEcVPJFk2frMQZUtHdhZwsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692589; c=relaxed/simple;
	bh=/2dFN733qu7qzNoBsznoLw9tk5hSEO4bN6XbL+i67L4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ml7+0TKTL3n5B5uoEOuzA/FRpAzA/FcisEMMfgUw9dQq4GMgMjjbcwdJ+rWozPjOa7G/N6whGXrxkvdNyxTIhOuZUCRi16mYyh62d19fTx4XgBvDzpbVxURg8iFlbz+pbmwmyibdHf3H8UIOnIFd93TpkNp1qXoVOKpC31LAD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT9E9Myg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C03C433F1;
	Sun, 17 Mar 2024 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692588;
	bh=/2dFN733qu7qzNoBsznoLw9tk5hSEO4bN6XbL+i67L4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qT9E9MygjQkSAVPG525/EAJAS2e8g58qP8tXpUPf2phHuOkI6hp6Fy5nE4AqkscnL
	 JNjTWxIiV56xKdb9wBmlSuJhpR3UrPtKmp/BbQZlyudjoX1rcraaAfn5J2jqwOo6SL
	 PJ52ZIjEQmwImjxoq6PU6ryABI2Feb5VpZ8ffkdSq6gPb4vxexEwvJMGSXuNDIGYbq
	 oFgHc25P2iqOdSaxETX13gCstSgff8ubqOsZQnTeodcCx3vl6fd4Mx2qhKXz6uv4Q4
	 h3k2sjAQqp+4yXaZaoOplGfoOxGs7IHbC4b4j121yt8KCG4UYvj5Dmt21HSDmfHvUE
	 79p07kL9hz/rA==
Date: Sun, 17 Mar 2024 09:23:07 -0700
Subject: [PATCHSET v5.3] fs-verity support for XFS
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: Mark Tinguely <tinguely@sgi.com>, "Darrick J. Wong" <djwong@djwong.org>,
 Dave Chinner <dchinner@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
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
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-xfs

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity-xfs
---
Commits in this patchset:
 * xfsprogs: add parent pointer support to attribute code
 * xfsprogs: define parent pointer xattr format
 * xfsprogs: Add xfs_verify_pptr
 * fs: add FS_XFLAG_VERITY for verity files
 * xfs: add attribute type for fs-verity
 * xfs: add fs-verity ro-compat flag
 * xfs: add inode on-disk VERITY flag
 * xfs: add fs-verity support
 * xfs: advertise fs-verity being available on filesystem
 * xfs: create separate name hash function for xattrs
 * xfs: use merkle tree offset as attr hash
 * xfs: enable ro-compat fs-verity flag
 * libfrog: add fsverity to xfs_report_geom output
 * xfs_db: introduce attr_modify command
 * xfs_db: make attr_set/remove/modify be able to handle fs-verity attrs
 * man: document attr_modify command
 * xfs_db: dump verity features and metadata
 * xfs_db: dump merkle tree data
 * xfs_repair: junk fsverity xattrs when unnecessary
 * mkfs.xfs: add verity parameter
---
 db/attr.c                |   94 +++++++++++++++++++
 db/attrset.c             |  226 +++++++++++++++++++++++++++++++++++++++++++++-
 db/attrshort.c           |   22 ++++
 db/hash.c                |    4 -
 db/metadump.c            |   26 +++--
 db/sb.c                  |    2 
 db/write.c               |    2 
 db/write.h               |    1 
 include/linux.h          |    4 +
 include/xfs_mount.h      |    2 
 libfrog/fsgeom.c         |    4 +
 libxfs/libxfs_api_defs.h |    2 
 libxfs/xfs_attr.c        |   86 ++++++++++++++++--
 libxfs/xfs_attr.h        |    6 +
 libxfs/xfs_attr_leaf.c   |    4 -
 libxfs/xfs_da_format.h   |   80 ++++++++++++++++
 libxfs/xfs_format.h      |   14 ++-
 libxfs/xfs_fs.h          |    1 
 libxfs/xfs_log_format.h  |    2 
 libxfs/xfs_ondisk.h      |    4 +
 libxfs/xfs_sb.c          |    4 +
 man/man8/mkfs.xfs.8.in   |    4 +
 man/man8/xfs_db.8        |   34 +++++++
 mkfs/xfs_mkfs.c          |   19 +++-
 repair/attr_repair.c     |   52 +++++++++--
 25 files changed, 651 insertions(+), 48 deletions(-)


