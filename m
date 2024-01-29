Return-Path: <linux-fsdevel+bounces-9350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F58F84034E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4D2B22BBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8795A7A6;
	Mon, 29 Jan 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD9QLC3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE58556B67;
	Mon, 29 Jan 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525834; cv=none; b=CjUE30n0CcN7VVq48c0wQKutJJuOexZtShkLCalPGV3TVaRROxCgZZXuOA1AIoL5qXDDI0AYnId3SwZEZNxD71HHox1aBakwaVGcB35R2iZJzC1szr6FK/3DtJDgdb5kKL6I4iNezfCIJ1/LQ9YbOw4JJwhAErWWkds/nqB+hZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525834; c=relaxed/simple;
	bh=XaZjOqms5tdY9qBXq6Kngtiw3gLfhdMm+zt5sMnUq3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEOqJ3aAb6DM26uGxULg+SYbAw/pJ1vBC7Y1U/79QihmmP2+hdYLN0GjUYS3ivnsKYDkxnfIcIpoAjI5cWAAVmpDoeo6qSUG6Fj17ghdgGltf0PNekqDXz8nY2HUO1G1I+5BxTatIAK5bMSDuY3rgjV9fBWKZJV58lZKvU4QtKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD9QLC3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70190C433C7;
	Mon, 29 Jan 2024 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706525833;
	bh=XaZjOqms5tdY9qBXq6Kngtiw3gLfhdMm+zt5sMnUq3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VD9QLC3FzH1sJCk7VE4bHxdAqO/k7tmNW/GbMVbLp/A3ZOsVs3egJsMDfiKfxQavC
	 RoNXK/9HFvnObxNvwYo6KLM1mBppm7WiNNgF3DqGSIbWKmueDsZL006SYAe2p73taj
	 3fcNS7+/1JPo08r1ujNTK974paTVWg3GzS/cCGGap2uTa6GhCm8JXnkQHk6JnsXKik
	 M5vuuVr5cYDobawZvbZob1osz0FppovfZNIES//YBFu3QaJ4sF8ks1/yCqa/cRoct4
	 2QD8R+HFiArXv68uANRgMS/cNQ9bzCaIuOFpv/zOFZR2oSzvCWt5c0WUUNNzngVlG+
	 WBqvwF2oNC/3Q==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH RFC 0/2] fs & block: remove bd_inode
Date: Mon, 29 Jan 2024 11:56:40 +0100
Message-ID: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=4889; i=brauner@kernel.org; h=from:subject:message-id; bh=XaZjOqms5tdY9qBXq6Kngtiw3gLfhdMm+zt5sMnUq3I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRub8k/fffr3M8L+lmSbmia6t/NyvtU7lItJbTifO2yh S3W5axOHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJZGT4zepc0By6LHnKmfDj km9YDi2//c5y0+ntfTXKRkfPmHfZrGBkuGYW9Ey1z6I5LvG5lWOZs/7pqlDWHR9WBM9X1OGJsD7 HCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Christoph,
Hey Jan,

This is an attempt to remove bdev->bd_inode and restrict direct access
to the block layer, block drivers and few instances in fs/buffer.c where
it's needed. Suggestions to do better welcome!

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      fs & block: remove bdev->bd_inode
      fs,drivers: remove bdev_inode() usage outside of block layer and drivers

 block/bdev.c                          | 48 ++++++++++--------
 block/blk-zoned.c                     |  4 +-
 block/fops.c                          |  4 +-
 block/genhd.c                         |  8 +--
 block/ioctl.c                         |  8 +--
 block/partitions/core.c               | 11 ++--
 drivers/gpu/drm/drm_gem_vram_helper.c |  2 +-
 drivers/md/bcache/super.c             |  7 +--
 drivers/md/md-bitmap.c                |  2 +-
 drivers/mtd/devices/block2mtd.c       |  4 +-
 drivers/s390/block/dasd_ioctl.c       |  2 +-
 drivers/scsi/scsicam.c                |  2 +-
 fs/affs/file.c                        |  2 +-
 fs/bcachefs/util.h                    |  5 --
 fs/btrfs/dev-replace.c                |  2 +-
 fs/btrfs/disk-io.c                    | 17 ++++---
 fs/btrfs/disk-io.h                    |  4 +-
 fs/btrfs/inode.c                      |  2 +-
 fs/btrfs/super.c                      |  2 +-
 fs/btrfs/volumes.c                    | 26 +++++-----
 fs/btrfs/volumes.h                    |  2 +-
 fs/btrfs/zoned.c                      | 18 ++++---
 fs/btrfs/zoned.h                      |  4 +-
 fs/buffer.c                           | 95 +++++++++++++++++++----------------
 fs/cramfs/inode.c                     |  2 +-
 fs/direct-io.c                        |  7 +--
 fs/erofs/data.c                       |  5 +-
 fs/erofs/internal.h                   |  1 +
 fs/erofs/zmap.c                       |  2 +-
 fs/ext2/inode.c                       |  4 +-
 fs/ext2/xattr.c                       |  2 +-
 fs/ext4/inode.c                       |  8 +--
 fs/ext4/mmp.c                         |  2 +-
 fs/ext4/page-io.c                     |  4 +-
 fs/ext4/super.c                       |  7 ++-
 fs/ext4/xattr.c                       |  2 +-
 fs/f2fs/data.c                        |  7 ++-
 fs/f2fs/f2fs.h                        |  1 +
 fs/fuse/dax.c                         |  2 +-
 fs/gfs2/aops.c                        |  2 +-
 fs/gfs2/bmap.c                        |  2 +-
 fs/gfs2/glock.c                       |  2 +-
 fs/gfs2/meta_io.c                     |  2 +-
 fs/gfs2/ops_fstype.c                  |  2 +-
 fs/hpfs/file.c                        |  2 +-
 fs/iomap/buffered-io.c                |  8 +--
 fs/iomap/direct-io.c                  | 10 ++--
 fs/iomap/swapfile.c                   |  2 +-
 fs/iomap/trace.h                      |  2 +-
 fs/jbd2/commit.c                      |  2 +-
 fs/jbd2/journal.c                     | 29 ++++++-----
 fs/jbd2/recovery.c                    |  6 +--
 fs/jbd2/revoke.c                      | 10 ++--
 fs/jbd2/transaction.c                 |  8 +--
 fs/mpage.c                            | 26 ++++++----
 fs/nilfs2/btnode.c                    |  4 +-
 fs/nilfs2/gcinode.c                   |  2 +-
 fs/nilfs2/mdt.c                       |  2 +-
 fs/nilfs2/page.c                      |  4 +-
 fs/nilfs2/recovery.c                  | 20 ++++----
 fs/nilfs2/segment.c                   |  2 +-
 fs/nilfs2/the_nilfs.c                 |  1 +
 fs/nilfs2/the_nilfs.h                 |  1 +
 fs/ntfs/aops.c                        |  6 +--
 fs/ntfs/file.c                        |  2 +-
 fs/ntfs/mft.c                         |  4 +-
 fs/ntfs3/fsntfs.c                     |  8 +--
 fs/ntfs3/inode.c                      |  2 +-
 fs/ntfs3/super.c                      |  2 +-
 fs/ocfs2/aops.c                       |  2 +-
 fs/ocfs2/journal.c                    |  2 +-
 fs/reiserfs/fix_node.c                |  2 +-
 fs/reiserfs/journal.c                 | 10 ++--
 fs/reiserfs/prints.c                  |  4 +-
 fs/reiserfs/reiserfs.h                |  6 +--
 fs/reiserfs/stree.c                   |  2 +-
 fs/reiserfs/tail_conversion.c         |  2 +-
 fs/xfs/xfs_iomap.c                    |  4 +-
 fs/zonefs/file.c                      |  4 +-
 include/linux/blk_types.h             |  1 -
 include/linux/blkdev.h                |  6 ++-
 include/linux/buffer_head.h           | 68 ++++++++++++++++---------
 include/linux/fs.h                    |  4 +-
 include/linux/iomap.h                 | 13 ++++-
 include/linux/jbd2.h                  | 10 ++--
 include/trace/events/block.h          |  2 +-
 86 files changed, 363 insertions(+), 291 deletions(-)
---
base-commit: 0bd1bf95a554f5f877724c27dbe33d4db0af4d0c
change-id: 20240129-vfs-bdev-file-bd_inode-385a56c57a51


