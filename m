Return-Path: <linux-fsdevel+bounces-47697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE4AAA4229
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 07:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF82464A45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 05:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F71DF98D;
	Wed, 30 Apr 2025 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcxCoyOZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F43A921;
	Wed, 30 Apr 2025 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745990304; cv=none; b=H+3uHe5ARlV4Lqf2PZOyS4I06bbQpJZxAdX4PAhuY7XqItbD9qzaEfwS/PQWi3+5Cf6TtUY0Ze7BfrbxKz8D9EoA9gNYVxr21tAaaHwvHyHRaiy2jb5mQEYdRI09FNwVXbZ7Exm87gx9j9hZYKmGjEGfudGHzWZHM44LAiNnci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745990304; c=relaxed/simple;
	bh=gArsuC6TY1f02PCoxGsHqNCpkz9m/aoI+JRflmC5Afo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHMosoO3RW4p97gDw/zJ2Q8asuvCW4CrPy01u5xCnj2eW6YzMBQwmcXuyg7FEmmhX6zTFpjRunqN9ZhJ6Rw4Xkg9KdJa8eaDkWda7UIc0PLxCRAgmvq7VNnxFV3StNVENi9aAuBowqOm+w5H40ZTaGrcMNZM9AbvNHwHSB0TNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcxCoyOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DA4C4CEE9;
	Wed, 30 Apr 2025 05:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745990303;
	bh=gArsuC6TY1f02PCoxGsHqNCpkz9m/aoI+JRflmC5Afo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcxCoyOZy84JGHyzBchpGoalQsA7G6SL9C15Exjb3Yo2eGQU8lUdDyGZVMjbdMstZ
	 gMu3W4jJTsc5uiXoBPTafp4O5dWi1Be/53uUGtbn29FnzCTJD+DktnWNPGamPKo+o0
	 r6wAEvEM3NdCNt8TCI9HrXi8vT+qcH+yALlz+t7sq+YssnpQDkNqoc7zAwFz7k6dwS
	 bIT7nZD+XxOnm+Nh2LNVE7cRoAoOhUi98ABhbzqBcYaXmM11c4Aq9pF0tgpdIZCEHE
	 vWOFTR5+IX9FUOYSRc253YOa94QQm5+aUUQ/vznu7bkH+hWY5mVrlZi+cVvTlN00ZN
	 qgMC19Rb86m5g==
Date: Tue, 29 Apr 2025 22:18:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: [PATCH v9.1 05/15] xfs: ignore HW which cannot atomic write a single
 block
Message-ID: <20250430051822.GY25675@frogsfrogsfrogs>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <20250425164504.3263637-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425164504.3263637-6-john.g.garry@oracle.com>

From: Darrick J. Wong <djwong@kernel.org>

Currently only HW which can write at least 1x block is supported.

For supporting atomic writes > 1x block, a CoW-based method will also be
used and this will not be resticted to using HW which can write >= 1x
block.

However for deciding if HW-based atomic writes can be used, we need to
start adding checks for write length < HW min, which complicates the
code.  Indeed, a statx field similar to unit_max_opt should also be
added for this minimum, which is undesirable.

HW which can only write > 1x blocks would be uncommon and quite weird,
so let's just not support it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
v9.1: move the atomic hw geometry calls to xfs_setup_devices
---
 fs/xfs/xfs_buf.h   |    3 ++-
 fs/xfs/xfs_inode.h |   14 ++------------
 fs/xfs/xfs_buf.c   |   41 ++++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_super.c |    6 +++++-
 4 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index d0b065a9a9f0d2..6f691779887f77 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -112,7 +112,7 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_readahead_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
-	/* Atomic write unit values */
+	/* Atomic write unit values, bytes */
 	unsigned int		bt_bdev_awu_min;
 	unsigned int		bt_bdev_awu_max;
 
@@ -375,6 +375,7 @@ extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
 extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
+void xfs_buftarg_config_atomic_writes(struct xfs_buftarg *btp);
 
 #define xfs_getsize_buftarg(buftarg)	block_size((buftarg)->bt_bdev)
 #define xfs_readonly_buftarg(buftarg)	bdev_read_only((buftarg)->bt_bdev)
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bdbbff0d8d9920..d7e2b902ef5c97 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -356,19 +356,9 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
-static inline bool
-xfs_inode_can_hw_atomic_write(
-	struct xfs_inode	*ip)
+static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
-
-	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
-		return false;
-	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
-		return false;
-
-	return true;
+	return xfs_inode_buftarg(ip)->bt_bdev_awu_max > 0;
 }
 
 /*
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 5ae77ffdc947b1..c1bd5654c3afa8 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1779,6 +1779,40 @@ xfs_init_buftarg(
 	return -ENOMEM;
 }
 
+/*
+ * Configure this buffer target for hardware-assisted atomic writes if the
+ * underlying block device supports is congruent with the filesystem geometry.
+ */
+void
+xfs_buftarg_config_atomic_writes(
+	struct xfs_buftarg	*btp)
+{
+	struct xfs_mount	*mp = btp->bt_mount;
+	unsigned int		min_bytes, max_bytes;
+
+	ASSERT(btp->bt_bdev != NULL);
+
+	if (!bdev_can_atomic_write(btp->bt_bdev))
+		return;
+
+	min_bytes = bdev_atomic_write_unit_min_bytes(btp->bt_bdev);
+	max_bytes = bdev_atomic_write_unit_max_bytes(btp->bt_bdev);
+
+	/*
+	 * Ignore atomic write geometry that is nonsense or doesn't even cover
+	 * a single fsblock.
+	 */
+	if (min_bytes > max_bytes ||
+	    min_bytes > mp->m_sb.sb_blocksize ||
+	    max_bytes < mp->m_sb.sb_blocksize) {
+		min_bytes = 0;
+		max_bytes = 0;
+	}
+
+	btp->bt_bdev_awu_min = min_bytes;
+	btp->bt_bdev_awu_max = max_bytes;
+}
+
 struct xfs_buftarg *
 xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
@@ -1799,13 +1833,6 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
-	if (bdev_can_atomic_write(btp->bt_bdev)) {
-		btp->bt_bdev_awu_min = bdev_atomic_write_unit_min_bytes(
-						btp->bt_bdev);
-		btp->bt_bdev_awu_max = bdev_atomic_write_unit_max_bytes(
-						btp->bt_bdev);
-	}
-
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf50979..af4c541251d859 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -520,7 +520,8 @@ xfs_open_devices(
 }
 
 /*
- * Setup xfs_mount buffer target pointers based on superblock
+ * Setup xfs_mount buffer target pointers based on superblock, and configure
+ * the atomic write capabilities now that we've validated the blocksize.
  */
 STATIC int
 xfs_setup_devices(
@@ -531,6 +532,7 @@ xfs_setup_devices(
 	error = xfs_setsize_buftarg(mp->m_ddev_targp, mp->m_sb.sb_sectsize);
 	if (error)
 		return error;
+	xfs_buftarg_config_atomic_writes(mp->m_ddev_targp);
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
 		unsigned int	log_sector_size = BBSIZE;
@@ -541,6 +543,7 @@ xfs_setup_devices(
 					    log_sector_size);
 		if (error)
 			return error;
+		xfs_buftarg_config_atomic_writes(mp->m_logdev_targp);
 	}
 
 	if (mp->m_sb.sb_rtstart) {
@@ -555,6 +558,7 @@ xfs_setup_devices(
 					    mp->m_sb.sb_sectsize);
 		if (error)
 			return error;
+		xfs_buftarg_config_atomic_writes(mp->m_rtdev_targp);
 	}
 
 	return 0;

