Return-Path: <linux-fsdevel+bounces-47952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF21AA7AB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 22:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D54D1BA2846
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02C11F873E;
	Fri,  2 May 2025 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAEcku5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B81EBFFF;
	Fri,  2 May 2025 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216802; cv=none; b=A3LNT2VER0yxE6v9y9MPAqoZKlj9K2hDPKB5HYj5pycyZEli2Yq9QhcBpQqBVyYLVTZTwtEZdD/7hcYjpW4nVh+e7K9yIVq15+wVVwthU7IQb9f8WqqyhSIL6f+YcKffXgtKJnqrZKWEHB/LVbHKUAHZkZveZ+8hW0ZDX4ps3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216802; c=relaxed/simple;
	bh=ud5kPFd0X0qVPSg4fD5da0mFAuqP+3DF97NZsjzX95U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiZO8+Nk5CVgNOT7cDxNw92XZiQDQ7Cr0ljxXRmGzQ+41BcvQXA5E26eMPxL4//FdHtWlpGeYJiEeBhl/XhV0tKesdk946lDJWf0m8HwPOyW4GrKhY1NgmGOs52Mb5UsqomFfjIm5nEKpmocEbaCa2ec73ufa1uGBTs2PcoysuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAEcku5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5360BC4CEE4;
	Fri,  2 May 2025 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746216801;
	bh=ud5kPFd0X0qVPSg4fD5da0mFAuqP+3DF97NZsjzX95U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAEcku5Nxv9GRrH+L3Iv16BNKPw2uuy+IMAMt90iPCt+ePynUTiSzPsznqzxwQD/9
	 C17Lj0STrmFVoPn7ELJh55vaiGisuowphWqqPYV4yq7kmQIy/pkL/yvdYvTMAi/hV0
	 dgD/jTpX77cq13Br+NwbHwqvWk3/4S5SzA+28kp0zHzmcp5yUC19esm7Ym07ZOgBHS
	 xk/fufQrNpRoG3j5hH4MuoVrzW8GaHK2yMUTKCcV8kBk0VTpm7Cs+yb7EwXWSWRgv7
	 kR8TacvlojjWGanqW01wpH6leNdoQsaImm1eJlQetuMQqjq8hDVLhZ9AJjdcr5BS3n
	 +N3I3zez2Wg6Q==
Date: Fri, 2 May 2025 13:13:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: [PATCH v10.1 05/15] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250502201320.GV25675@frogsfrogsfrogs>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
 <20250501165733.1025207-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501165733.1025207-6-john.g.garry@oracle.com>

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
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
v10.1: rename xfs_getsize_buftarg and rebase on previous changes to
xfs_getsize_buftarg
---
 fs/xfs/xfs_buf.h   |    4 ++--
 fs/xfs/xfs_inode.h |   14 ++------------
 fs/xfs/xfs_buf.c   |   44 ++++++++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_super.c |    6 +++---
 4 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 132210705602b4..7759fe35d93ea7 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -112,7 +112,7 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_readahead_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
-	/* Atomic write unit values */
+	/* Atomic write unit values, bytes */
 	unsigned int		bt_bdev_awu_min;
 	unsigned int		bt_bdev_awu_max;
 
@@ -374,7 +374,7 @@ struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
 extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
-extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
+extern int xfs_configure_buftarg(struct xfs_buftarg *, unsigned int);
 
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
index 292891d6ff69ac..770dc4ca79e4c4 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1714,13 +1714,45 @@ xfs_free_buftarg(
 	kfree(btp);
 }
 
+/*
+ * Configure this buffer target for hardware-assisted atomic writes if the
+ * underlying block device supports is congruent with the filesystem geometry.
+ */
+static inline void
+xfs_configure_buftarg_atomic_writes(
+	struct xfs_buftarg	*btp)
+{
+	struct xfs_mount	*mp = btp->bt_mount;
+	unsigned int		min_bytes, max_bytes;
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
+/* Configure a buffer target that abstracts a block device. */
 int
-xfs_setsize_buftarg(
+xfs_configure_buftarg(
 	struct xfs_buftarg	*btp,
 	unsigned int		sectorsize)
 {
 	int			error;
 
+	ASSERT(btp->bt_bdev != NULL);
+
 	/* Set up metadata sector size info */
 	btp->bt_meta_sectorsize = sectorsize;
 	btp->bt_meta_sectormask = sectorsize - 1;
@@ -1733,6 +1765,9 @@ xfs_setsize_buftarg(
 		return -EINVAL;
 	}
 
+	if (bdev_can_atomic_write(btp->bt_bdev))
+		xfs_configure_buftarg_atomic_writes(btp);
+
 	return 0;
 }
 
@@ -1795,13 +1830,6 @@ xfs_alloc_buftarg(
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
index 83de3ac39ae53b..ed23e6ffe644b6 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -557,7 +557,7 @@ xfs_setup_devices(
 {
 	int			error;
 
-	error = xfs_setsize_buftarg(mp->m_ddev_targp, mp->m_sb.sb_sectsize);
+	error = xfs_configure_buftarg(mp->m_ddev_targp, mp->m_sb.sb_sectsize);
 	if (error)
 		return error;
 
@@ -566,7 +566,7 @@ xfs_setup_devices(
 
 		if (xfs_has_sector(mp))
 			log_sector_size = mp->m_sb.sb_logsectsize;
-		error = xfs_setsize_buftarg(mp->m_logdev_targp,
+		error = xfs_configure_buftarg(mp->m_logdev_targp,
 					    log_sector_size);
 		if (error)
 			return error;
@@ -580,7 +580,7 @@ xfs_setup_devices(
 		}
 		mp->m_rtdev_targp = mp->m_ddev_targp;
 	} else if (mp->m_rtname) {
-		error = xfs_setsize_buftarg(mp->m_rtdev_targp,
+		error = xfs_configure_buftarg(mp->m_rtdev_targp,
 					    mp->m_sb.sb_sectsize);
 		if (error)
 			return error;

