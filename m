Return-Path: <linux-fsdevel+bounces-7188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A78C822DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9612E1F21519
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5F91A594;
	Wed,  3 Jan 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaMMUeLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B661A58B;
	Wed,  3 Jan 2024 12:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD90C43397;
	Wed,  3 Jan 2024 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286543;
	bh=SUWQhrFleGuumt8/1sW8NuFvQDVTinRTMZf3WP5XVts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kaMMUeLYYbZ78IpD3F7jMhKX+z+KvLH5HDY/nqkFdFOhaxSylfPnKhZUTRh+j4azH
	 pofD4Tudko5IplARBFSBPg/2+PgpxPzI0AKFBzvStvB3Pg+CThQ3+jcE8sSQ2Hb1Ip
	 ioXhx8BLFEAYguKt3BZaeEs8hmtyGzxAKw5yMM2Vr00nhlGBzEMxdf6d/T6Q7lNcFR
	 22ALwPCWQ8YZMO66ntbWeD7+YER4Sz/AjAu5/lzpTnt3ToQCfvJGRLlwKedHPzGErK
	 pDvVcAZIrZxpwjOqJDHxYXvLqRb7fIAWmCwQm2OzioutOFemL2c0I1F3QdGHPsLfCp
	 PogC6gpewChvQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:05 +0100
Subject: [PATCH RFC 07/34] xfs: port block device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-7-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5349; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SUWQhrFleGuumt8/1sW8NuFvQDVTinRTMZf3WP5XVts=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTZMX/qS8Ffbmv/7qhSXq6y4M7Byek67MYL9Dh65
 tj07vn+oKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiSV2MDD9908/YWmm2Vzl/
 P/PFYrtJvpdRNrN36ErWfR857v8pW8DI8ED50vIks4o4NZv0f3W96TVyS0OWXzTNyro6c9NpC69
 QZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xfs/xfs_buf.c   | 10 +++++-----
 fs/xfs/xfs_buf.h   |  4 ++--
 fs/xfs/xfs_super.c | 43 +++++++++++++++++++++----------------------
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 545c7991b9b5..685eb2a9f9d2 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1951,7 +1951,7 @@ xfs_free_buftarg(
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
 	/* the main block device is closed by kill_block_super */
 	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
-		bdev_release(btp->bt_bdev_handle);
+		fput(btp->bt_f_bdev);
 
 	kmem_free(btp);
 }
@@ -1994,7 +1994,7 @@ xfs_setsize_buftarg_early(
 struct xfs_buftarg *
 xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
-	struct bdev_handle	*bdev_handle)
+	struct file		*f_bdev)
 {
 	xfs_buftarg_t		*btp;
 	const struct dax_holder_operations *ops = NULL;
@@ -2005,9 +2005,9 @@ xfs_alloc_buftarg(
 	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
 
 	btp->bt_mount = mp;
-	btp->bt_bdev_handle = bdev_handle;
-	btp->bt_dev = bdev_handle->bdev->bd_dev;
-	btp->bt_bdev = bdev_handle->bdev;
+	btp->bt_f_bdev = f_bdev;
+	btp->bt_bdev = F_BDEV(f_bdev);
+	btp->bt_dev = btp->bt_bdev->bd_dev;
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index c86e16419656..4005dcffb792 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -98,7 +98,7 @@ typedef unsigned int xfs_buf_flags_t;
  */
 typedef struct xfs_buftarg {
 	dev_t			bt_dev;
-	struct bdev_handle	*bt_bdev_handle;
+	struct file		*bt_f_bdev;
 	struct block_device	*bt_bdev;
 	struct dax_device	*bt_daxdev;
 	u64			bt_dax_part_off;
@@ -365,7 +365,7 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
  *	Handling of buftargs.
  */
 struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
-		struct bdev_handle *bdev_handle);
+		struct file *f_bdev);
 extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 0e64220bffdc..01ef0ef83c41 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -362,16 +362,16 @@ STATIC int
 xfs_blkdev_get(
 	xfs_mount_t		*mp,
 	const char		*name,
-	struct bdev_handle	**handlep)
+	struct file		**f_bdevp)
 {
 	int			error = 0;
 
-	*handlep = bdev_open_by_path(name,
+	*f_bdevp = bdev_file_open_by_path(name,
 		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
 		mp->m_super, &fs_holder_ops);
-	if (IS_ERR(*handlep)) {
-		error = PTR_ERR(*handlep);
-		*handlep = NULL;
+	if (IS_ERR(*f_bdevp)) {
+		error = PTR_ERR(*f_bdevp);
+		*f_bdevp = NULL;
 		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
 	}
 
@@ -436,26 +436,25 @@ xfs_open_devices(
 {
 	struct super_block	*sb = mp->m_super;
 	struct block_device	*ddev = sb->s_bdev;
-	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
+	struct file		*f_logdev = NULL, *f_rtdev = NULL;
 	int			error;
 
 	/*
 	 * Open real time and log devices - order is important.
 	 */
 	if (mp->m_logname) {
-		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_handle);
+		error = xfs_blkdev_get(mp, mp->m_logname, &f_logdev);
 		if (error)
 			return error;
 	}
 
 	if (mp->m_rtname) {
-		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_handle);
+		error = xfs_blkdev_get(mp, mp->m_rtname, &f_rtdev);
 		if (error)
 			goto out_close_logdev;
 
-		if (rtdev_handle->bdev == ddev ||
-		    (logdev_handle &&
-		     rtdev_handle->bdev == logdev_handle->bdev)) {
+		if (F_BDEV(f_rtdev) == ddev ||
+		    (f_logdev && F_BDEV(f_rtdev) == F_BDEV(f_logdev))) {
 			xfs_warn(mp,
 	"Cannot mount filesystem with identical rtdev and ddev/logdev.");
 			error = -EINVAL;
@@ -467,25 +466,25 @@ xfs_open_devices(
 	 * Setup xfs_mount buffer target pointers
 	 */
 	error = -ENOMEM;
-	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb_bdev_handle(sb));
+	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_f_bdev);
 	if (!mp->m_ddev_targp)
 		goto out_close_rtdev;
 
-	if (rtdev_handle) {
-		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_handle);
+	if (f_rtdev) {
+		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, f_rtdev);
 		if (!mp->m_rtdev_targp)
 			goto out_free_ddev_targ;
 	}
 
-	if (logdev_handle && logdev_handle->bdev != ddev) {
-		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_handle);
+	if (f_logdev && F_BDEV(f_logdev) != ddev) {
+		mp->m_logdev_targp = xfs_alloc_buftarg(mp, f_logdev);
 		if (!mp->m_logdev_targp)
 			goto out_free_rtdev_targ;
 	} else {
 		mp->m_logdev_targp = mp->m_ddev_targp;
 		/* Handle won't be used, drop it */
-		if (logdev_handle)
-			bdev_release(logdev_handle);
+		if (f_logdev)
+			fput(f_logdev);
 	}
 
 	return 0;
@@ -496,11 +495,11 @@ xfs_open_devices(
  out_free_ddev_targ:
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
-	 if (rtdev_handle)
-		bdev_release(rtdev_handle);
+	 if (f_rtdev)
+		fput(f_rtdev);
  out_close_logdev:
-	if (logdev_handle)
-		bdev_release(logdev_handle);
+	if (f_logdev)
+		fput(f_logdev);
 	return error;
 }
 

-- 
2.42.0


