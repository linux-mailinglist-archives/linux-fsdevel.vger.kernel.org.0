Return-Path: <linux-fsdevel+bounces-67049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C82C338DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E4918849C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBB245012;
	Wed,  5 Nov 2025 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUGUnQdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF7243951;
	Wed,  5 Nov 2025 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304112; cv=none; b=f592M5oE1a2bAb5DtwTm0VXpv8qXRxDln9P1LfkBD1Q7neNutxSlOM7MFG/r/LDYKKSDMoILakVWjZh6x9Si7XvlrS997vrtEdGn/I27g27yuGqY2XxktLbxeJUCl5eP9tsZKPlu0ZgCKNro7bhT+uXI1Hs/4FvoK8wsqvVPIHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304112; c=relaxed/simple;
	bh=YlnasOGDdVGBLyy+cCBgkidqLFKhY765zOmeP3xLGuA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/RVQxg8CCFwm025TXQkvWgUGbz/PRJaWK9ifa/A8EOHjl9TVU8cqQ24Pew3Fb92Ya61EQy5wY/Aw7AFVIpEUL2IyM1igby50355Fn53FPL++Or59M2x48YUe2u+PVG39t+BfHSBPuebEa3bSXEUUNEK2LsRja9FH+nqEvAmqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUGUnQdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2805DC4AF09;
	Wed,  5 Nov 2025 00:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304112;
	bh=YlnasOGDdVGBLyy+cCBgkidqLFKhY765zOmeP3xLGuA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QUGUnQdWngZn83wSKF5Pfj35pBepVv2y7UX6wB/uf3XaBCKiQDrVMWnhtJZEydaLC
	 U4x2mrOBICM2ctOYlDjq8JLrp3BPNvZzyZeDpIRsXMEm+9ODrjCyBt8opIoHXyNsea
	 9CI8MludOSElSTZf5PB/GunjajI1OTA9mMb434aasBfTBeDuKzMvoS6POp37m6iU6f
	 Oh0KHnh+ZJPTBGjLf9h9o21MSVRSIwL7o7CKB3G/LwCUhNg1ROVpUSFMPiketrChrD
	 SavfmUQLKHhVY64wlG+XbVHWrdNtUJS7VJViLX60XPHpM+NLIi7SyUxYVH5qjrRhaO
	 XkY/CcKkjQskg==
Date: Tue, 04 Nov 2025 16:55:11 -0800
Subject: [PATCH 4/6] xfs: remove file I/O error hooks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 amir73il@gmail.com, jack@suse.cz, gabriel@krisman.be
Message-ID: <176230366519.1647991.10523655693204899593.stgit@frogsfrogsfrogs>
In-Reply-To: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove these hooks since iomap now does that on its own.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.h  |   37 -----------
 fs/xfs/xfs_mount.h |    3 -
 fs/xfs/xfs_aops.c  |    2 -
 fs/xfs/xfs_file.c  |  174 ----------------------------------------------------
 fs/xfs/xfs_super.c |    1 
 5 files changed, 1 insertion(+), 216 deletions(-)


diff --git a/fs/xfs/xfs_file.h b/fs/xfs/xfs_file.h
index 441f8a693bb884..2ad91f755caf35 100644
--- a/fs/xfs/xfs_file.h
+++ b/fs/xfs/xfs_file.h
@@ -12,41 +12,4 @@ extern const struct file_operations xfs_dir_file_operations;
 bool xfs_is_falloc_aligned(struct xfs_inode *ip, loff_t pos,
 		long long int len);
 
-enum xfs_file_ioerror_type {
-	XFS_FILE_IOERROR_BUFFERED_READ,
-	XFS_FILE_IOERROR_BUFFERED_WRITE,
-	XFS_FILE_IOERROR_DIRECT_READ,
-	XFS_FILE_IOERROR_DIRECT_WRITE,
-	XFS_FILE_IOERROR_DATA_LOST,
-};
-
-struct xfs_file_ioerror_params {
-	xfs_ino_t		ino;
-	loff_t			pos;
-	u64			len;
-	u32			gen;
-	int			error;
-};
-
-#ifdef CONFIG_XFS_LIVE_HOOKS
-struct xfs_file_ioerror_hook {
-	struct xfs_hook			ioerror_hook;
-};
-
-int xfs_file_ioerror_hook_add(struct xfs_mount *mp,
-		struct xfs_file_ioerror_hook *hook);
-void xfs_file_ioerror_hook_del(struct xfs_mount *mp,
-		struct xfs_file_ioerror_hook *hook);
-void xfs_file_ioerror_hook_setup(struct xfs_file_ioerror_hook *hook,
-		notifier_fn_t mod_fn);
-
-void xfs_vm_ioerror(struct address_space *mapping, int direction, loff_t pos,
-		u64 len, int error);
-
-void xfs_inode_media_error(struct xfs_inode *ip, loff_t pos, u64 len);
-#else
-# define xfs_vm_ioerror			NULL
-# define xfs_inode_media_error(...)	((void)0)
-#endif /* CONFIG_XFS_LIVE_HOOKS */
-
 #endif /* __XFS_FILE_H__ */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 2d7f9ccba5287e..0feb0fb685f51f 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -352,9 +352,6 @@ typedef struct xfs_mount {
 
 	/* Hook to feed media error events to a daemon. */
 	struct xfs_hooks	m_media_error_hooks;
-
-	/* Hook to feed file io error events to a daemon. */
-	struct xfs_hooks	m_file_ioerror_hooks;
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index f3f28b9ae0f70e..a26f798155331f 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -22,7 +22,6 @@
 #include "xfs_icache.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_rtgroup.h"
-#include "xfs_file.h"
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -811,7 +810,6 @@ const struct address_space_operations xfs_address_space_operations = {
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
 	.swap_activate		= xfs_vm_swap_activate,
-	.ioerror		= xfs_vm_ioerror,
 };
 
 const struct address_space_operations xfs_dax_aops = {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f5988904f5d44d..2702fef2c90cd2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -222,176 +222,6 @@ xfs_ilock_iocb_for_write(
 	return 0;
 }
 
-#ifdef CONFIG_XFS_LIVE_HOOKS
-struct xfs_file_ioerror {
-	struct work_struct		work;
-	struct xfs_mount		*mp;
-	xfs_ino_t			ino;
-	loff_t				pos;
-	u64				len;
-	u32				gen;
-	int				error;
-	enum xfs_file_ioerror_type	type;
-};
-
-/* Call downstream hooks for a file io error update. */
-STATIC void
-xfs_file_report_ioerror(
-	struct work_struct	*work)
-{
-	struct xfs_file_ioerror	*ioerr =
-		container_of(work, struct xfs_file_ioerror, work);
-	struct xfs_file_ioerror_params	p = {
-		.ino		= ioerr->ino,
-		.gen		= ioerr->gen,
-		.pos		= ioerr->pos,
-		.len		= ioerr->len,
-	};
-	struct xfs_mount	*mp = ioerr->mp;
-
-	xfs_hooks_call(&mp->m_file_ioerror_hooks, ioerr->type, &p);
-	kfree(ioerr);
-}
-
-/* Queue a directio io error notification. */
-STATIC void
-xfs_dio_ioerror(
-	struct inode		*inode,
-	int			direction,
-	loff_t			pos,
-	u64			len,
-	int			error)
-{
-	struct xfs_inode	*ip = XFS_I(inode);
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_file_ioerror	*ioerr;
-
-	ioerr = kzalloc(sizeof(*ioerr), GFP_ATOMIC);
-	if (!ioerr) {
-		xfs_err(mp,
- "lost ioerror report for ino 0x%llx %s pos 0x%llx len 0x%llx error %d",
-				ip->i_ino,
-				direction == WRITE ? "WRITE" : "READ",
-				pos, len, error);
-		return;
-	}
-
-	INIT_WORK(&ioerr->work, xfs_file_report_ioerror);
-	ioerr->mp = mp;
-	ioerr->ino = ip->i_ino;
-	ioerr->gen = VFS_I(ip)->i_generation;
-	ioerr->pos = pos;
-	ioerr->len = len;
-	if (direction == WRITE)
-		ioerr->type = XFS_FILE_IOERROR_DIRECT_WRITE;
-	else
-		ioerr->type = XFS_FILE_IOERROR_DIRECT_READ;
-	ioerr->error = error;
-	queue_work(mp->m_unwritten_workqueue, &ioerr->work);
-}
-
-/* Deal with a media error */
-void
-xfs_inode_media_error(
-	struct xfs_inode	*ip,
-	loff_t			pos,
-	u64			len)
-{
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_file_ioerror	*ioerr;
-
-	ioerr = kzalloc(sizeof(*ioerr), GFP_ATOMIC);
-	if (!ioerr) {
-		xfs_err(mp,
- "lost data error report for ino 0x%llx pos 0x%llx len 0x%llx",
-				ip->i_ino,
-				pos, len);
-		return;
-	}
-
-	INIT_WORK(&ioerr->work, xfs_file_report_ioerror);
-	ioerr->mp = mp;
-	ioerr->ino = ip->i_ino;
-	ioerr->gen = VFS_I(ip)->i_generation;
-	ioerr->pos = pos;
-	ioerr->len = len;
-	ioerr->type = XFS_FILE_IOERROR_DATA_LOST;
-	ioerr->error = -EIO;
-	queue_work(mp->m_unwritten_workqueue, &ioerr->work);
-}
-
-/* Queue a buffered io error notification. */
-void
-xfs_vm_ioerror(
-	struct address_space	*mapping,
-	int			direction,
-	loff_t			pos,
-	u64			len,
-	int			error)
-{
-	struct inode		*inode = mapping->host;
-	struct xfs_inode	*ip = XFS_I(inode);
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_file_ioerror	*ioerr;
-
-	ioerr = kzalloc(sizeof(*ioerr), GFP_ATOMIC);
-	if (!ioerr) {
-		xfs_err(mp,
- "lost ioerror report for ino 0x%llx %s pos 0x%llx len 0x%llx error %d",
-				ip->i_ino,
-				direction == WRITE ? "WRITE" : "READ",
-				pos, len, error);
-		return;
-	}
-
-	INIT_WORK(&ioerr->work, xfs_file_report_ioerror);
-	ioerr->mp = mp;
-	ioerr->ino = ip->i_ino;
-	ioerr->gen = VFS_I(ip)->i_generation;
-	ioerr->pos = pos;
-	ioerr->len = len;
-	if (direction == WRITE)
-		ioerr->type = XFS_FILE_IOERROR_BUFFERED_WRITE;
-	else
-		ioerr->type = XFS_FILE_IOERROR_BUFFERED_READ;
-	ioerr->error = error;
-	queue_work(mp->m_unwritten_workqueue, &ioerr->work);
-}
-
-/* Call the specified function after a file io error. */
-int
-xfs_file_ioerror_hook_add(
-	struct xfs_mount		*mp,
-	struct xfs_file_ioerror_hook	*hook)
-{
-	return xfs_hooks_add(&mp->m_file_ioerror_hooks, &hook->ioerror_hook);
-}
-
-/* Stop calling the specified function after a file io error. */
-void
-xfs_file_ioerror_hook_del(
-	struct xfs_mount		*mp,
-	struct xfs_file_ioerror_hook	*hook)
-{
-	xfs_hooks_del(&mp->m_file_ioerror_hooks, &hook->ioerror_hook);
-}
-
-/* Configure file io error update hook functions. */
-void
-xfs_file_ioerror_hook_setup(
-	struct xfs_file_ioerror_hook	*hook,
-	notifier_fn_t			mod_fn)
-{
-	xfs_hook_setup(&hook->ioerror_hook, mod_fn);
-}
-#else
-# define xfs_dio_ioerror		NULL
-#endif /* CONFIG_XFS_LIVE_HOOKS */
-
-static const struct iomap_dio_ops xfs_dio_read_ops = {
-	.ioerror	= xfs_dio_ioerror,
-};
-
 STATIC ssize_t
 xfs_file_dio_read(
 	struct kiocb		*iocb,
@@ -410,8 +240,7 @@ xfs_file_dio_read(
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, &xfs_dio_read_ops,
-			0, NULL, 0);
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, NULL, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -796,7 +625,6 @@ xfs_dio_write_end_io(
 
 static const struct iomap_dio_ops xfs_dio_write_ops = {
 	.end_io		= xfs_dio_write_end_io,
-	.ioerror	= xfs_dio_ioerror,
 };
 
 static void
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bfd12ccaa707a8..4a8d439ff57408 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2388,7 +2388,6 @@ xfs_init_fs_context(
 	xfs_hooks_init(&mp->m_shutdown_hooks);
 	xfs_hooks_init(&mp->m_health_update_hooks);
 	xfs_hooks_init(&mp->m_media_error_hooks);
-	xfs_hooks_init(&mp->m_file_ioerror_hooks);
 
 	fc->s_fs_info = mp;
 	fc->ops = &xfs_context_ops;


