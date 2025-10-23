Return-Path: <linux-fsdevel+bounces-65255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D66BFEA6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 716E94F3B03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0F29A2;
	Thu, 23 Oct 2025 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhNtu4C6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39582A927;
	Thu, 23 Oct 2025 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177777; cv=none; b=nus8ClLKGiLjvnbrKC80XqspVIas86zLK2elPw04qEar751ky5YYndVnkur6bzZUutZFuNxlBvsfLYsp7G4tCFwbP1epC5r8GIQuox7TLcDKldaZBqk1orzMAOmTbQeaXOyGT1mU2nhcxURCvedsPcRsrhs6rmj0lFxfwA0aZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177777; c=relaxed/simple;
	bh=FUny+UeViYtPhEdqx6UxVnar2mxnxMHSCcr6uUb88F8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGetYw0a+MpP4Uls148iGWrV1PCSOiAPoqswmi/jUrVysZ31pQoDjhePN1ilWgK2OGLDFj5s+83zXG0/jLdOTLiBJ9OtGBIaBs0pt4cO9sOMxUF7vAz3V9mjfBEU8mbWTEFXsE1MBIh9m0J6blVjb32WOhfIAlJyN6uCPH8IEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhNtu4C6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E117EC4CEE7;
	Thu, 23 Oct 2025 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177776;
	bh=FUny+UeViYtPhEdqx6UxVnar2mxnxMHSCcr6uUb88F8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dhNtu4C6f2angwEd1+ZYQdTLxyTXHF2j77mdouh+/k7MHzyZtpdH+jyEbOUxT8JBi
	 cBCLABk4PE96PRFnWfbE5bOkrLCfvnT6CFnCdLVqILZVVQbkGTlCZ/uS8+Z4XXEAkJ
	 wPLR9sasU2/F5fVP+itKfOhZO7ktvxtV4JvcIOl8rsrrROwykpRJibLVP2C5hrS5we
	 Zb9HDMnUbvZJK/rN3ZRC9I+VQzjgWyu5xH7k8py5R2t2l9t1QX10EZnlR2ufmo6D0m
	 2Pgjyhg18rEThm3BdttnusTrnfYuAXh8224Q1kbrdYg+c8ubvG6E0r6WMniXZswmNA
	 l8v9uiLFsF1sg==
Date: Wed, 22 Oct 2025 17:02:56 -0700
Subject: [PATCH 09/19] xfs: create file io error hooks
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744694.1025409.13962056603210966268.stgit@frogsfrogsfrogs>
In-Reply-To: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create hooks within XFS to deliver IO errors to callers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.h  |   36 +++++++++++
 fs/xfs/xfs_mount.h |    3 +
 fs/xfs/xfs_aops.c  |    2 +
 fs/xfs/xfs_file.c  |  167 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_super.c |    1 
 5 files changed, 208 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_file.h b/fs/xfs/xfs_file.h
index 2ad91f755caf35..2b4e02efefb7b1 100644
--- a/fs/xfs/xfs_file.h
+++ b/fs/xfs/xfs_file.h
@@ -12,4 +12,40 @@ extern const struct file_operations xfs_dir_file_operations;
 bool xfs_is_falloc_aligned(struct xfs_inode *ip, loff_t pos,
 		long long int len);
 
+enum xfs_file_ioerror_type {
+	XFS_FILE_IOERROR_BUFFERED_READ,
+	XFS_FILE_IOERROR_BUFFERED_WRITE,
+	XFS_FILE_IOERROR_DIRECT_READ,
+	XFS_FILE_IOERROR_DIRECT_WRITE,
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
+void xfs_file_ioerror_hook_disable(void);
+void xfs_file_ioerror_hook_enable(void);
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
+#else
+# define xfs_vm_ioerror			NULL
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 #endif /* __XFS_FILE_H__ */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 0907714c9d6f21..9b17899a012fe6 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -353,6 +353,9 @@ typedef struct xfs_mount {
 
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
index 2702fef2c90cd2..1c9b21ad97d46c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -222,6 +222,169 @@ xfs_ilock_iocb_for_write(
 	return 0;
 }
 
+#ifdef CONFIG_XFS_LIVE_HOOKS
+DEFINE_STATIC_XFS_HOOK_SWITCH(xfs_file_ioerror_hooks_switch);
+
+void
+xfs_file_ioerror_hook_disable(void)
+{
+	xfs_hooks_switch_off(&xfs_file_ioerror_hooks_switch);
+}
+
+void
+xfs_file_ioerror_hook_enable(void)
+{
+	xfs_hooks_switch_on(&xfs_file_ioerror_hooks_switch);
+}
+
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
+	struct xfs_file_ioerror	*ioerr;
+
+	ioerr = container_of(work, struct xfs_file_ioerror, work);
+
+	if (xfs_hooks_switched_on(&xfs_file_ioerror_hooks_switch)) {
+		struct xfs_file_ioerror_params	p = {
+			.ino		= ioerr->ino,
+			.gen		= ioerr->gen,
+			.pos		= ioerr->pos,
+			.len		= ioerr->len,
+		};
+		struct xfs_mount	*mp = ioerr->mp;
+
+		xfs_hooks_call(&mp->m_file_ioerror_hooks, ioerr->type, &p);
+	}
+
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
+	if (xfs_hooks_switched_on(&xfs_file_ioerror_hooks_switch)) {
+		ioerr = kzalloc(sizeof(*ioerr), GFP_ATOMIC);
+		if (!ioerr) {
+			xfs_err(mp,
+ "lost ioerror report for ino 0x%llx %s pos 0x%llx len 0x%llx error %d",
+					ip->i_ino,
+					direction == WRITE ? "WRITE" : "READ",
+					pos, len, error);
+			return;
+		}
+
+		INIT_WORK(&ioerr->work, xfs_file_report_ioerror);
+		ioerr->mp = mp;
+		ioerr->ino = ip->i_ino;
+		ioerr->gen = VFS_I(ip)->i_generation;
+		ioerr->pos = pos;
+		ioerr->len = len;
+		if (direction == WRITE)
+			ioerr->type = XFS_FILE_IOERROR_DIRECT_WRITE;
+		else
+			ioerr->type = XFS_FILE_IOERROR_DIRECT_READ;
+		ioerr->error = error;
+		queue_work(mp->m_unwritten_workqueue, &ioerr->work);
+	}
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
+	if (xfs_hooks_switched_on(&xfs_file_ioerror_hooks_switch)) {
+		ioerr = kzalloc(sizeof(*ioerr), GFP_ATOMIC);
+		if (!ioerr) {
+			xfs_err(mp,
+ "lost ioerror report for ino 0x%llx %s pos 0x%llx len 0x%llx error %d",
+					ip->i_ino,
+					direction == WRITE ? "WRITE" : "READ",
+					pos, len, error);
+			return;
+		}
+
+		INIT_WORK(&ioerr->work, xfs_file_report_ioerror);
+		ioerr->mp = mp;
+		ioerr->ino = ip->i_ino;
+		ioerr->gen = VFS_I(ip)->i_generation;
+		ioerr->pos = pos;
+		ioerr->len = len;
+		if (direction == WRITE)
+			ioerr->type = XFS_FILE_IOERROR_BUFFERED_WRITE;
+		else
+			ioerr->type = XFS_FILE_IOERROR_BUFFERED_READ;
+		ioerr->error = error;
+		queue_work(mp->m_unwritten_workqueue, &ioerr->work);
+	}
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
@@ -240,7 +403,8 @@ xfs_file_dio_read(
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, NULL, 0);
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, &xfs_dio_read_ops,
+			0, NULL, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -625,6 +789,7 @@ xfs_dio_write_end_io(
 
 static const struct iomap_dio_ops xfs_dio_write_ops = {
 	.end_io		= xfs_dio_write_end_io,
+	.ioerror	= xfs_dio_ioerror,
 };
 
 static void
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 51f8db95e717a8..b6a6027b4df8d8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2288,6 +2288,7 @@ xfs_init_fs_context(
 	xfs_hooks_init(&mp->m_shutdown_hooks);
 	xfs_hooks_init(&mp->m_health_update_hooks);
 	xfs_hooks_init(&mp->m_media_error_hooks);
+	xfs_hooks_init(&mp->m_file_ioerror_hooks);
 
 	fc->s_fs_info = mp;
 	fc->ops = &xfs_context_ops;


