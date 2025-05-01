Return-Path: <linux-fsdevel+bounces-47870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13748AA6470
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 21:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BD11BC6689
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92A23716B;
	Thu,  1 May 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmAGrwew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A314BFA2;
	Thu,  1 May 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129187; cv=none; b=W/Zr8NS5N5T9blvU9ytcc+n/gOa2hExO//dNqym4by/NpU0L6m3nizs9v0SYOdN60hLvHz+QjNpE1zbFrdLgM+PX5jldVWryZ5L8A4P3T2BzTjPrqVdfQEYxhEt6nRbV5CNxJn99RUxYnfW7OfS/siB1CkQEX8C3PHtZDwKupCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129187; c=relaxed/simple;
	bh=6ZgpGiWsh3Y2wCfrhbFqebnjz8E6RFKeGGq3l9cd45o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWVa8nLX8E4uYCSukAp75MVKlhsDPbm41ZnQFEMnLLfQRVSSWGjLzu4q2OaLW6/zG5HqdonreoZqnw7CekavHSjJnG9b3IOtMBq4ANEOBMyQW4Ew2kWlgYv82ST6liX3I+E2QmpwclgLv/c9Hz8aj004IGs3iz7Lz0yQDay9mmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmAGrwew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D15C4CEE3;
	Thu,  1 May 2025 19:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746129186;
	bh=6ZgpGiWsh3Y2wCfrhbFqebnjz8E6RFKeGGq3l9cd45o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmAGrwewvQUtDWM68T+W8SF+megewLd/ByxUaIa6YsJG4Bz4Egpdjv/2FGZZpIZsm
	 4thjCHsW9oytvDLsmqEO1jxZ2uVJzeCFZKdGXVtV1gBqm5yCas9E+sNhJEj0csmj77
	 +r+xmk9FdGm1YjJHBlv4stPgoYZDmUuSVM8Mj0u9gjnBpHV529UWx8nTsBVOuGG69d
	 3cXvYpSpvQdwNQDc/XYNLe1jsMgj04hHV5YnG8UByAq2MaQhJ6h9K7vnQx3UeaJ9xx
	 BvcL0Wsn1iwcjq8Pw46LVH0uSsAHk1sLDBzSgAMkbkj+QARUPSl/AoVEOWRLFBFouh
	 G5GsMwT6z9HxA==
Date: Thu, 1 May 2025 12:53:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: [PATCH 17/15] xfs: move buftarg atomic write geometry config to
 setsize_buftarg
Message-ID: <20250501195305.GG25675@frogsfrogsfrogs>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>

From: Darrick J. Wong <djwong@kernel.org>

Move the xfs_buftarg_config_atomic_writes call to xfs_setsize_buftarg
now that we only call it after reading the filesystem geometry from the
primary superblock.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
hch: is this better?  patch 16 can move up, and this can be folded into
patch 5
---
 fs/xfs/xfs_buf.h   |    1 -
 fs/xfs/xfs_buf.c   |   66 +++++++++++++++++++++++++---------------------------
 fs/xfs/xfs_super.c |    3 --
 3 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 2f809e33ec66da..8267e41bdaf834 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -375,7 +375,6 @@ extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
 extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
-void xfs_buftarg_config_atomic_writes(struct xfs_buftarg *btp);
 
 #define xfs_getsize_buftarg(buftarg)	block_size((buftarg)->bt_bdev)
 #define xfs_readonly_buftarg(buftarg)	bdev_read_only((buftarg)->bt_bdev)
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 437fef08b7cf7b..62f74cb03c9783 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1714,6 +1714,35 @@ xfs_free_buftarg(
 	kfree(btp);
 }
 
+/*
+ * Configure this buffer target for hardware-assisted atomic writes if the
+ * underlying block device supports is congruent with the filesystem geometry.
+ */
+static inline void
+xfs_buftarg_config_atomic_writes(
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
 int
 xfs_setsize_buftarg(
 	struct xfs_buftarg	*btp,
@@ -1733,6 +1762,9 @@ xfs_setsize_buftarg(
 		return -EINVAL;
 	}
 
+	if (bdev_can_atomic_write(btp->bt_bdev))
+		xfs_buftarg_config_atomic_writes(btp);
+
 	/*
 	 * Flush the block device pagecache so our bios see anything dirtied
 	 * before mount.
@@ -1779,40 +1811,6 @@ xfs_init_buftarg(
 	return -ENOMEM;
 }
 
-/*
- * Configure this buffer target for hardware-assisted atomic writes if the
- * underlying block device supports is congruent with the filesystem geometry.
- */
-void
-xfs_buftarg_config_atomic_writes(
-	struct xfs_buftarg	*btp)
-{
-	struct xfs_mount	*mp = btp->bt_mount;
-	unsigned int		min_bytes, max_bytes;
-
-	ASSERT(btp->bt_bdev != NULL);
-
-	if (!bdev_can_atomic_write(btp->bt_bdev))
-		return;
-
-	min_bytes = bdev_atomic_write_unit_min_bytes(btp->bt_bdev);
-	max_bytes = bdev_atomic_write_unit_max_bytes(btp->bt_bdev);
-
-	/*
-	 * Ignore atomic write geometry that is nonsense or doesn't even cover
-	 * a single fsblock.
-	 */
-	if (min_bytes > max_bytes ||
-	    min_bytes > mp->m_sb.sb_blocksize ||
-	    max_bytes < mp->m_sb.sb_blocksize) {
-		min_bytes = 0;
-		max_bytes = 0;
-	}
-
-	btp->bt_bdev_awu_min = min_bytes;
-	btp->bt_bdev_awu_max = max_bytes;
-}
-
 struct xfs_buftarg *
 xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b6b6fb4ce8ca65..48b9c62500df4b 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -540,7 +540,6 @@ xfs_setup_devices(
 	error = xfs_setsize_buftarg(mp->m_ddev_targp, mp->m_sb.sb_sectsize);
 	if (error)
 		return error;
-	xfs_buftarg_config_atomic_writes(mp->m_ddev_targp);
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
 		unsigned int	log_sector_size = BBSIZE;
@@ -551,7 +550,6 @@ xfs_setup_devices(
 					    log_sector_size);
 		if (error)
 			return error;
-		xfs_buftarg_config_atomic_writes(mp->m_logdev_targp);
 	}
 
 	if (mp->m_sb.sb_rtstart) {
@@ -566,7 +564,6 @@ xfs_setup_devices(
 					    mp->m_sb.sb_sectsize);
 		if (error)
 			return error;
-		xfs_buftarg_config_atomic_writes(mp->m_rtdev_targp);
 	}
 
 	return 0;

