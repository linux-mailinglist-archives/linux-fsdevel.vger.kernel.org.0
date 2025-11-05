Return-Path: <linux-fsdevel+bounces-67032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8441C33863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4467E3AB797
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F3B23BCF7;
	Wed,  5 Nov 2025 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/JtbNCr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F482367B3;
	Wed,  5 Nov 2025 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303849; cv=none; b=WaoTiHQekt5eHzHoCcORCuBtTL52eT7b1rRQOAQAhmTlu4iJM/OWKKXMVAkel+SWkseNS5PGz8k6bd9weCIm+njsTcJ9wauuGOU5nyaJxd4nXMUQslKVMoTJUCEvfypswzrleEKvWeOXPH1I9lbMHXXEM6fGTesf68ajiYDqXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303849; c=relaxed/simple;
	bh=R1zkR1jey4d4rx3G7j+htBDEjMt84KlTRr54x07qpWY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpkRXHNIoHCMtO+cTAytP+jUr3m6zvsWJ5pYOrP0VZrxh4wsDMfNZjbcACYDVJr3ApUSwo/Z007IunlCi7auRkpZLbwc/8GyJj9B9QGkUe5XDPHsKTKIzMfO7JO9cz0iA2dCDhuTIwKCAs1/YReygw54qwd6/nBwuV6zPbJqIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/JtbNCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1FDC4CEF7;
	Wed,  5 Nov 2025 00:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303846;
	bh=R1zkR1jey4d4rx3G7j+htBDEjMt84KlTRr54x07qpWY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=u/JtbNCrzTbSMea8mGey2tnjJ6/4CjqpHDv+EnLl0XykfHLqdkZoXfq6CvKkaNmPM
	 q7RhAi5lNCzxBtNvkDlRG/YoN8bK2Si/MiXSkJpMrn2+Vz539efsntFrC8Bzpi0HMU
	 W/PQLvm3r4B+WUvL6344CM9QRFhAbk4Kd3ztxOawWNr9DGNk2JlV1pNUDj39ztI6tn
	 BawdUw+hDjTtSvxQf8FXoY5VGbaTcXw24T82deyNLwBobwtZy0zvDJfeSlt+rUiqyM
	 1h+yGCBY1qx4+I0BkGTVpbMrljp37+aJke0cSduVNU9mY17MiaXmvgyR0XcQNkdALd
	 YVJm6b4395t0w==
Date: Tue, 04 Nov 2025 16:50:46 -0800
Subject: [PATCH 09/22] xfs: create file io error hooks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230365884.1647136.542908210799575148.stgit@frogsfrogsfrogs>
In-Reply-To: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create hooks within XFS to deliver IO errors to callers.  File I/O
errors are usually rare, so we don't employ a static key here.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.h           |   37 +++++++++
 fs/xfs/xfs_mount.h          |    3 +
 fs/xfs/xfs_aops.c           |    2 
 fs/xfs/xfs_file.c           |  174 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.c |    5 +
 fs/xfs/xfs_super.c          |    1 
 6 files changed, 221 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_file.h b/fs/xfs/xfs_file.h
index 2ad91f755caf35..441f8a693bb884 100644
--- a/fs/xfs/xfs_file.h
+++ b/fs/xfs/xfs_file.h
@@ -12,4 +12,41 @@ extern const struct file_operations xfs_dir_file_operations;
 bool xfs_is_falloc_aligned(struct xfs_inode *ip, loff_t pos,
 		long long int len);
 
+enum xfs_file_ioerror_type {
+	XFS_FILE_IOERROR_BUFFERED_READ,
+	XFS_FILE_IOERROR_BUFFERED_WRITE,
+	XFS_FILE_IOERROR_DIRECT_READ,
+	XFS_FILE_IOERROR_DIRECT_WRITE,
+	XFS_FILE_IOERROR_DATA_LOST,
+};
+
+struct xfs_file_ioerror_params {
+	xfs_ino_t		ino;
+	loff_t			pos;
+	u64			len;
+	u32			gen;
+	int			error;
+};
+
+#ifdef CONFIG_XFS_LIVE_HOOKS
+struct xfs_file_ioerror_hook {
+	struct xfs_hook			ioerror_hook;
+};
+
+int xfs_file_ioerror_hook_add(struct xfs_mount *mp,
+		struct xfs_file_ioerror_hook *hook);
+void xfs_file_ioerror_hook_del(struct xfs_mount *mp,
+		struct xfs_file_ioerror_hook *hook);
+void xfs_file_ioerror_hook_setup(struct xfs_file_ioerror_hook *hook,
+		notifier_fn_t mod_fn);
+
+void xfs_vm_ioerror(struct address_space *mapping, int direction, loff_t pos,
+		u64 len, int error);
+
+void xfs_inode_media_error(struct xfs_inode *ip, loff_t pos, u64 len);
+#else
+# define xfs_vm_ioerror			NULL
+# define xfs_inode_media_error(...)	((void)0)
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 #endif /* __XFS_FILE_H__ */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 0feb0fb685f51f..2d7f9ccba5287e 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -352,6 +352,9 @@ typedef struct xfs_mount {
 
 	/* Hook to feed media error events to a daemon. */
 	struct xfs_hooks	m_media_error_hooks;
+
+	/* Hook to feed file io error events to a daemon. */
+	struct xfs_hooks	m_file_ioerror_hooks;
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a26f798155331f..f3f28b9ae0f70e 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -22,6 +22,7 @@
 #include "xfs_icache.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_rtgroup.h"
+#include "xfs_file.h"
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -810,6 +811,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
 	.swap_activate		= xfs_vm_swap_activate,
+	.ioerror		= xfs_vm_ioerror,
 };
 
 const struct address_space_operations xfs_dax_aops = {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2702fef2c90cd2..f5988904f5d44d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -222,6 +222,176 @@ xfs_ilock_iocb_for_write(
 	return 0;
 }
 
+#ifdef CONFIG_XFS_LIVE_HOOKS
+struct xfs_file_ioerror {
+	struct work_struct		work;
+	struct xfs_mount		*mp;
+	xfs_ino_t			ino;
+	loff_t				pos;
+	u64				len;
+	u32				gen;
+	int				error;
+	enum xfs_file_ioerror_type	type;
+};
+
+/* Call downstream hooks for a file io error update. */
+STATIC void
+xfs_file_report_ioerror(
+	struct work_struct	*work)
+{
+	struct xfs_file_ioerror	*ioerr =
+		container_of(work, struct xfs_file_ioerror, work);
+	struct xfs_file_ioerror_params	p = {
+		.ino		= ioerr->ino,
+		.gen		= ioerr->gen,
+		.pos		= ioerr->pos,
+		.len		= ioerr->len,
+	};
+	struct xfs_mount	*mp = ioerr->mp;
+
+	xfs_hooks_call(&mp->m_file_ioerror_hooks, ioerr->type, &p);
+	kfree(ioerr);
+}
+
+/* Queue a directio io error notification. */
+STATIC void
+xfs_dio_ioerror(
+	struct inode		*inode,
+	int			direction,
+	loff_t			pos,
+	u64			len,
+	int			error)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_file_ioerror	*ioerr;
+
+	ioerr = kzalloc(sizeof(*ioerr), GFP_ATOMIC);
+	if (!ioerr) {
+		xfs_err(mp,
+ "lost ioerror report for ino 0x%llx %s pos 0x%llx len 0x%llx error %d",
+				ip->i_ino,
+				direction == WRITE ? "WRITE" : "READ",
+				pos, len, error);
+		return;
+	}
+
+	INIT_WORK(&ioerr->work, xfs_file_report_ioerror);
+	ioerr->mp = mp;
+	ioerr->ino = ip->i_ino;
+	ioerr->gen = VFS_I(ip)->i_generation;
+	ioerr->pos = pos;
+	ioerr->len = len;
+	if (direction == WRITE)
+		ioerr->type = XFS_FILE_IOERROR_DIRECT_WRITE;
+	else
+		ioerr->type = XFS_FILE_IOERROR_DIRECT_READ;
+	ioerr->error = error;
+	queue_work(mp->m_unwritten_workqueue, &ioerr->work);
+}
+
+/* Deal with a media error */
+void
+xfs_inode_media_error(
+	struct xfs_inode	*ip,
+	loff_t			pos,
+	u64			len)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_file_ioerror	*ioerr;
+
+	ioerr = kzalloc(sizeof(*ioerr), GFP_ATOMIC);
+	if (!ioerr) {
+		xfs_err(mp,
+ "lost data error report for ino 0x%llx pos 0x%llx len 0x%llx",
+				ip->i_ino,
+				pos, len);
+		return;
+	}
+
+	INIT_WORK(&ioerr->work, xfs_file_report_ioerror);
+	ioerr->mp = mp;
+	ioerr->ino = ip->i_ino;
+	ioerr->gen = VFS_I(ip)->i_generation;
+	ioerr->pos = pos;
+	ioerr->len = len;
+	ioerr->type = XFS_FILE_IOERROR_DATA_LOST;
+	ioerr->error = -EIO;
+	queue_work(mp->m_unwritten_workqueue, &ioerr->work);
+}
+
+/* Queue a buffered io error notification. */
+void
+xfs_vm_ioerror(
+	struct address_space	*mapping,
+	int			direction,
+	loff_t			pos,
+	u64			len,
+	int			error)
+{
+	struct inode		*inode = mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_file_ioerror	*ioerr;
+
+	ioerr = kzalloc(sizeof(*ioerr), GFP_ATOMIC);
+	if (!ioerr) {
+		xfs_err(mp,
+ "lost ioerror report for ino 0x%llx %s pos 0x%llx len 0x%llx error %d",
+				ip->i_ino,
+				direction == WRITE ? "WRITE" : "READ",
+				pos, len, error);
+		return;
+	}
+
+	INIT_WORK(&ioerr->work, xfs_file_report_ioerror);
+	ioerr->mp = mp;
+	ioerr->ino = ip->i_ino;
+	ioerr->gen = VFS_I(ip)->i_generation;
+	ioerr->pos = pos;
+	ioerr->len = len;
+	if (direction == WRITE)
+		ioerr->type = XFS_FILE_IOERROR_BUFFERED_WRITE;
+	else
+		ioerr->type = XFS_FILE_IOERROR_BUFFERED_READ;
+	ioerr->error = error;
+	queue_work(mp->m_unwritten_workqueue, &ioerr->work);
+}
+
+/* Call the specified function after a file io error. */
+int
+xfs_file_ioerror_hook_add(
+	struct xfs_mount		*mp,
+	struct xfs_file_ioerror_hook	*hook)
+{
+	return xfs_hooks_add(&mp->m_file_ioerror_hooks, &hook->ioerror_hook);
+}
+
+/* Stop calling the specified function after a file io error. */
+void
+xfs_file_ioerror_hook_del(
+	struct xfs_mount		*mp,
+	struct xfs_file_ioerror_hook	*hook)
+{
+	xfs_hooks_del(&mp->m_file_ioerror_hooks, &hook->ioerror_hook);
+}
+
+/* Configure file io error update hook functions. */
+void
+xfs_file_ioerror_hook_setup(
+	struct xfs_file_ioerror_hook	*hook,
+	notifier_fn_t			mod_fn)
+{
+	xfs_hook_setup(&hook->ioerror_hook, mod_fn);
+}
+#else
+# define xfs_dio_ioerror		NULL
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
+static const struct iomap_dio_ops xfs_dio_read_ops = {
+	.ioerror	= xfs_dio_ioerror,
+};
+
 STATIC ssize_t
 xfs_file_dio_read(
 	struct kiocb		*iocb,
@@ -240,7 +410,8 @@ xfs_file_dio_read(
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, NULL, 0);
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, &xfs_dio_read_ops,
+			0, NULL, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -625,6 +796,7 @@ xfs_dio_write_end_io(
 
 static const struct iomap_dio_ops xfs_dio_write_ops = {
 	.end_io		= xfs_dio_write_end_io,
+	.ioerror	= xfs_dio_ioerror,
 };
 
 static void
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 557f4bf3463dcb..8766d83385ddad 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -22,6 +22,7 @@
 #include "xfs_notify_failure.h"
 #include "xfs_rtgroup.h"
 #include "xfs_rtrmap_btree.h"
+#include "xfs_file.h"
 
 #include <linux/mm.h>
 #include <linux/dax.h>
@@ -167,6 +168,10 @@ xfs_dax_failure_fn(
 		invalidate_inode_pages2_range(mapping, pgoff,
 					      pgoff + pgcnt - 1);
 
+	xfs_inode_media_error(ip,
+			XFS_FSB_TO_B(mp, (u64)pgoff << PAGE_SHIFT),
+			XFS_FSB_TO_B(mp, (u64)pgcnt << PAGE_SHIFT));
+
 	xfs_irele(ip);
 	return error;
 }
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index fb72a4976e8570..54d82f5a5b8863 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2294,6 +2294,7 @@ xfs_init_fs_context(
 	xfs_hooks_init(&mp->m_shutdown_hooks);
 	xfs_hooks_init(&mp->m_health_update_hooks);
 	xfs_hooks_init(&mp->m_media_error_hooks);
+	xfs_hooks_init(&mp->m_file_ioerror_hooks);
 
 	fc->s_fs_info = mp;
 	fc->ops = &xfs_context_ops;


