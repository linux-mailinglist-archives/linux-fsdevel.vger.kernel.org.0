Return-Path: <linux-fsdevel+bounces-8552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0C838FF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBB1F22A0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746F5FF12;
	Tue, 23 Jan 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSh6v4d7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020895F56D;
	Tue, 23 Jan 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016437; cv=none; b=HFtFjX0W6Nd1WzR5oEVAmIs73aJczIxa1EPtPDifmYnSmrXhErN9bIzshTxfMfAIau+SiXFRI7a9Vd7y5Al5gkASCHQtDL55kjt5kiWx70TlfJTIpTWeXcK9ZL7P2EM8lwNzt3nMV71TPYVflsj+UPyDp5x0qbHfTFkLZasb7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016437; c=relaxed/simple;
	bh=NALkdDvFuAXZML+cRUG3w8LBXVtBKA5Udm0JjiEaNP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ej34ouCunJhr9K5zeiqjhR8ytrrHWei/W8tgaIKHL7P6lnA7C/weaeLr10agxBR0TLdW1X8psC9sJJQx9cdCWoQ9T/mkDl7z5bQU8nsYLiZrW2C/8cL6OuxHebGujUy/HsLzCAA+JEgbkHc4MsUeEFLpMYaM1Ot3G6R3xmaPqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSh6v4d7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86683C43141;
	Tue, 23 Jan 2024 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016436;
	bh=NALkdDvFuAXZML+cRUG3w8LBXVtBKA5Udm0JjiEaNP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gSh6v4d7quCQ0beuyam94eA2Rjogg1eTmLP1f/DfZ7hqI+OqMMK/giz7AcNAt4I5U
	 ik9a1k2KfSwUcnyxYfSHkIImLEGTr9DUi7W5YMsNWwvAu2AtZG7PDN4Uln9V3Fw3cr
	 6Jbql6gckusg2JQEkZanO2escc99lSDOSLXI2XtFUiSQu0oX3Y15oeDpcB3XM28srh
	 4zRXvQfMI4jeMBPubK0C0s2wObl/tOG5wKhQMLXRk2pKhstwmG5Pt5CjDH806UUyZF
	 qG294Sj5owJjFaK7ZVTccx8oU1kH8w1vGBVYZDG6lmXycQzvIBAv2tknOwe0G32R1v
	 WayxAjKdWsJfw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:24 +0100
Subject: [PATCH v2 07/34] xfs: port block device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-7-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5460; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NALkdDvFuAXZML+cRUG3w8LBXVtBKA5Udm0JjiEaNP4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zfPWvX4AzUPw7N7Nu9P2v3jwmrnIwKLoiJa04W/e
 cXGtgdXdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEW4uRYaOvrF+0jfvsaPvq
 npLPP9pvme699GtK9YeF7izyE10lyxkZ5gdX+O//+yPmuUBgbmxHyBytTnlpxrcvA500dY959P9
 mBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xfs/xfs_buf.c   | 10 +++++-----
 fs/xfs/xfs_buf.h   |  4 ++--
 fs/xfs/xfs_super.c | 43 +++++++++++++++++++++----------------------
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 8e5bd50d29fe..01b41fabbe3c 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1951,7 +1951,7 @@ xfs_free_buftarg(
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
 	/* the main block device is closed by kill_block_super */
 	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
-		bdev_release(btp->bt_bdev_handle);
+		fput(btp->bt_bdev_file);
 
 	kmem_free(btp);
 }
@@ -1994,7 +1994,7 @@ xfs_setsize_buftarg_early(
 struct xfs_buftarg *
 xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
-	struct bdev_handle	*bdev_handle)
+	struct file		*bdev_file)
 {
 	xfs_buftarg_t		*btp;
 	const struct dax_holder_operations *ops = NULL;
@@ -2005,9 +2005,9 @@ xfs_alloc_buftarg(
 	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
 
 	btp->bt_mount = mp;
-	btp->bt_bdev_handle = bdev_handle;
-	btp->bt_dev = bdev_handle->bdev->bd_dev;
-	btp->bt_bdev = bdev_handle->bdev;
+	btp->bt_bdev_file = bdev_file;
+	btp->bt_bdev = file_bdev(bdev_file);
+	btp->bt_dev = btp->bt_bdev->bd_dev;
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b470de08a46c..304e858d04fb 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -98,7 +98,7 @@ typedef unsigned int xfs_buf_flags_t;
  */
 typedef struct xfs_buftarg {
 	dev_t			bt_dev;
-	struct bdev_handle	*bt_bdev_handle;
+	struct file		*bt_bdev_file;
 	struct block_device	*bt_bdev;
 	struct dax_device	*bt_daxdev;
 	u64			bt_dax_part_off;
@@ -366,7 +366,7 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
  *	Handling of buftargs.
  */
 struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
-		struct bdev_handle *bdev_handle);
+		struct file *bdev_file);
 extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e5ac0e59ede9..4a076c464177 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -362,16 +362,16 @@ STATIC int
 xfs_blkdev_get(
 	xfs_mount_t		*mp,
 	const char		*name,
-	struct bdev_handle	**handlep)
+	struct file		**bdev_filep)
 {
 	int			error = 0;
 
-	*handlep = bdev_open_by_path(name,
+	*bdev_filep = bdev_file_open_by_path(name,
 		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
 		mp->m_super, &fs_holder_ops);
-	if (IS_ERR(*handlep)) {
-		error = PTR_ERR(*handlep);
-		*handlep = NULL;
+	if (IS_ERR(*bdev_filep)) {
+		error = PTR_ERR(*bdev_filep);
+		*bdev_filep = NULL;
 		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
 	}
 
@@ -436,26 +436,25 @@ xfs_open_devices(
 {
 	struct super_block	*sb = mp->m_super;
 	struct block_device	*ddev = sb->s_bdev;
-	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
+	struct file		*logdev_file = NULL, *rtdev_file = NULL;
 	int			error;
 
 	/*
 	 * Open real time and log devices - order is important.
 	 */
 	if (mp->m_logname) {
-		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_handle);
+		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_file);
 		if (error)
 			return error;
 	}
 
 	if (mp->m_rtname) {
-		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_handle);
+		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_file);
 		if (error)
 			goto out_close_logdev;
 
-		if (rtdev_handle->bdev == ddev ||
-		    (logdev_handle &&
-		     rtdev_handle->bdev == logdev_handle->bdev)) {
+		if (file_bdev(rtdev_file) == ddev ||
+		    (logdev_file && file_bdev(rtdev_file) == file_bdev(logdev_file))) {
 			xfs_warn(mp,
 	"Cannot mount filesystem with identical rtdev and ddev/logdev.");
 			error = -EINVAL;
@@ -467,25 +466,25 @@ xfs_open_devices(
 	 * Setup xfs_mount buffer target pointers
 	 */
 	error = -ENOMEM;
-	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb_bdev_handle(sb));
+	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_bdev_file);
 	if (!mp->m_ddev_targp)
 		goto out_close_rtdev;
 
-	if (rtdev_handle) {
-		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_handle);
+	if (rtdev_file) {
+		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_file);
 		if (!mp->m_rtdev_targp)
 			goto out_free_ddev_targ;
 	}
 
-	if (logdev_handle && logdev_handle->bdev != ddev) {
-		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_handle);
+	if (logdev_file && file_bdev(logdev_file) != ddev) {
+		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_file);
 		if (!mp->m_logdev_targp)
 			goto out_free_rtdev_targ;
 	} else {
 		mp->m_logdev_targp = mp->m_ddev_targp;
 		/* Handle won't be used, drop it */
-		if (logdev_handle)
-			bdev_release(logdev_handle);
+		if (logdev_file)
+			fput(logdev_file);
 	}
 
 	return 0;
@@ -496,11 +495,11 @@ xfs_open_devices(
  out_free_ddev_targ:
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
-	 if (rtdev_handle)
-		bdev_release(rtdev_handle);
+	 if (rtdev_file)
+		fput(rtdev_file);
  out_close_logdev:
-	if (logdev_handle)
-		bdev_release(logdev_handle);
+	if (logdev_file)
+		fput(logdev_file);
 	return error;
 }
 

-- 
2.43.0


