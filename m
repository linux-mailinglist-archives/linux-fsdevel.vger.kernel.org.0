Return-Path: <linux-fsdevel+bounces-14575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059387DE4B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090801C21004
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F901CD16;
	Sun, 17 Mar 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY9q0fQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7E1CAB7;
	Sun, 17 Mar 2024 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692573; cv=none; b=DYbaWlnMZpbEMUcUDOdw2VzTBNiXI9fX14lQBMuhgA+7QqXtXGHuIFzXMSJu/gmLwTwzxZmysH3vmlBx0g7G+PUq5BGNHfNNqn0LTyDLokhNiiSp88zC2zD8fmkF4ThjXQUeCjuGPKUn/vwlG+SIlh5L8mk0OpvFnzvVdunBbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692573; c=relaxed/simple;
	bh=CidIp3ynZQ2+qv6Li+6yBuULp6dDKBrJCbtyfB6S6Dk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SROS1Po/joAZ+OTrHurZyPcThxAKMVwhRNYhF4/bWZpbOT+uwNcMCCAh2Y6/sON0DnahUzmLqp9nT/8x9oEr6su5QjA3VYWVo9+PU/LSoy6SdlclOXg0ZF9hf+6TLp5wDSOIQLQSr/mN7usqy45ZCcpFaF2L/VYKiEKjb/Mn70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY9q0fQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70CFC433C7;
	Sun, 17 Mar 2024 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692572;
	bh=CidIp3ynZQ2+qv6Li+6yBuULp6dDKBrJCbtyfB6S6Dk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MY9q0fQ0Nrszc7o2IqHz9X0pFDQ+5LIWWakG/+p1m2xy22LrqqLKNMw61sxFFq/9j
	 oozJUQNw6fMq8dqWEXfIdH7CZz3jWlm23EwhhQa/AVxo1LUF5IHeZ/hOeihOB+bwVl
	 T0xe+qE/8aHoCUH7vZDRS/vU5wgq7668bHIsQm1nfD3F/MeZEqI8ZuwfyRECINA3mL
	 yihRBCebdQ4Q1sIJ+WIIccWrENiIWLG6/vyKTBdkZyFfg1CebB4mRKh6tLFG+DGftA
	 SL8NJ0M9itW4Bw9o3FzAXssNagyilL59xbKo/xanK8rK+xBZurX18tM3R9jhTXEdzc
	 euw3TbL2JXcqg==
Date: Sun, 17 Mar 2024 09:22:52 -0700
Subject: [PATCHSET v5.3] fs-verity support for XFS
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: Eric Biggers <ebiggers@google.com>, Mark Tinguely <tinguely@sgi.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
 linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-xfs

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity-xfs
---
Commits in this patchset:
 * fsverity: remove hash page spin lock
 * xfs: add parent pointer support to attribute code
 * xfs: define parent pointer ondisk extended attribute format
 * xfs: add parent pointer validator functions
 * fs: add FS_XFLAG_VERITY for verity files
 * fsverity: pass tree_blocksize to end_enable_verity()
 * fsverity: support block-based Merkle tree caching
 * fsverity: add per-sb workqueue for post read processing
 * fsverity: add tracepoints
 * fsverity: fix "support block-based Merkle tree caching"
 * fsverity: send the level of the merkle tree block to ->read_merkle_tree_block
 * fsverity: pass the new tree size and block size to ->begin_enable_verity
 * fsverity: expose merkle tree geometry to callers
 * fsverity: rely on cached block callers to retain verified state
 * fsverity: box up the write_merkle_tree_block parameters too
 * fsverity: pass the zero-hash value to the implementation
 * fsverity: report validation errors back to the filesystem
 * iomap: integrate fs-verity verification into iomap's read path
 * xfs: add attribute type for fs-verity
 * xfs: add fs-verity ro-compat flag
 * xfs: add inode on-disk VERITY flag
 * xfs: initialize fs-verity on file open and cleanup on inode destruction
 * xfs: don't allow to enable DAX on fs-verity sealed inode
 * xfs: disable direct read path for fs-verity files
 * xfs: widen flags argument to the xfs_iflags_* helpers
 * xfs: add fs-verity support
 * xfs: create a per-mount shrinker for verity inodes merkle tree blocks
 * xfs: create an icache tag for files with cached merkle tree blocks
 * xfs: shrink verity blob cache
 * xfs: clean up stale fsverity metadata before starting
 * xfs: better reporting and error handling in xfs_drop_merkle_tree
 * xfs: make scrub aware of verity dinode flag
 * xfs: add fs-verity ioctls
 * xfs: advertise fs-verity being available on filesystem
 * xfs: teach online repair to evaluate fsverity xattrs
 * xfs: don't store trailing zeroes of merkle tree blocks
 * xfs: create separate name hash function for xattrs
 * xfs: use merkle tree offset as attr hash
 * xfs: don't bother storing merkle tree blocks for zeroed data blocks
 * xfs: enable ro-compat fs-verity flag
---
 Documentation/filesystems/fsverity.rst |    8 
 MAINTAINERS                            |    1 
 fs/btrfs/verity.c                      |   13 -
 fs/ext4/verity.c                       |   13 -
 fs/f2fs/verity.c                       |   13 -
 fs/ioctl.c                             |   11 
 fs/iomap/buffered-io.c                 |   91 ++++
 fs/super.c                             |    7 
 fs/verity/enable.c                     |   19 +
 fs/verity/fsverity_private.h           |   42 ++
 fs/verity/init.c                       |    1 
 fs/verity/open.c                       |   41 ++
 fs/verity/read_metadata.c              |   63 +--
 fs/verity/signature.c                  |    2 
 fs/verity/verify.c                     |  233 +++++++---
 fs/xfs/Makefile                        |    2 
 fs/xfs/libxfs/xfs_attr.c               |   49 ++
 fs/xfs/libxfs/xfs_attr.h               |    6 
 fs/xfs/libxfs/xfs_attr_leaf.c          |    4 
 fs/xfs/libxfs/xfs_da_format.h          |   75 +++
 fs/xfs/libxfs/xfs_format.h             |   14 -
 fs/xfs/libxfs/xfs_fs.h                 |    1 
 fs/xfs/libxfs/xfs_log_format.h         |    2 
 fs/xfs/libxfs/xfs_ondisk.h             |    4 
 fs/xfs/libxfs/xfs_parent.c             |  113 +++++
 fs/xfs/libxfs/xfs_parent.h             |   19 +
 fs/xfs/libxfs/xfs_sb.c                 |    4 
 fs/xfs/scrub/attr.c                    |  114 +++++
 fs/xfs/scrub/attr.h                    |    4 
 fs/xfs/scrub/common.c                  |   27 +
 fs/xfs/xfs_attr_item.c                 |    9 
 fs/xfs/xfs_attr_list.c                 |   17 -
 fs/xfs/xfs_file.c                      |   23 +
 fs/xfs/xfs_icache.c                    |   85 ++++
 fs/xfs/xfs_icache.h                    |    8 
 fs/xfs/xfs_inode.c                     |    2 
 fs/xfs/xfs_inode.h                     |   19 +
 fs/xfs/xfs_ioctl.c                     |   21 +
 fs/xfs/xfs_iops.c                      |    4 
 fs/xfs/xfs_mount.c                     |   10 
 fs/xfs/xfs_mount.h                     |    8 
 fs/xfs/xfs_super.c                     |   14 +
 fs/xfs/xfs_trace.h                     |   80 +++
 fs/xfs/xfs_verity.c                    |  741 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_verity.h                    |   29 +
 fs/xfs/xfs_xattr.c                     |   10 
 include/linux/fs.h                     |    2 
 include/linux/fsverity.h               |  162 +++++++
 include/trace/events/fsverity.h        |  162 +++++++
 include/uapi/linux/fs.h                |    1 
 50 files changed, 2226 insertions(+), 177 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_parent.c
 create mode 100644 fs/xfs/libxfs/xfs_parent.h
 create mode 100644 fs/xfs/xfs_verity.c
 create mode 100644 fs/xfs/xfs_verity.h
 create mode 100644 include/trace/events/fsverity.h


