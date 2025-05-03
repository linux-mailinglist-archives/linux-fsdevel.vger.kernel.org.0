Return-Path: <linux-fsdevel+bounces-47987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20980AA8306
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F8E189F68B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8811C6FF3;
	Sat,  3 May 2025 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kOKJAfNn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04A2EAE5;
	Sat,  3 May 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746307772; cv=none; b=nMz4AT+bGk5qACpzSzWJ8XBw/G1jrwOhplASZis2IBll69KqFeTO7R1W20gxRrAf91UN/OwzLg21CKDWD9dm1O8RIvgZ2GMmNt1wm4fCtNSSfQ2YFC1WbygTZ83bn1e8nwd31RCwgXpn/DskS9ZgBw+rCuEF4XlFStb5zY9nN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746307772; c=relaxed/simple;
	bh=TaQvfmHQxwrRvVqDAjeeuCyW45oBEKJERXy9wLq2nxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e8UoalLfn9vXCs+WzijOyp87Qd3aGvWqsoXevXrembtwXF+lDXvkXntuhynUcRrkcW8Uzo8eRB60T1PBacs3kUMHCejic7Y8IT6MOCB17fXOHZO4gZ+nxcBdqz5xcCTv0HI7FgsNgpBCDipR6sHdQxNngrXAXUoca/g0pDwhVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kOKJAfNn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VQQwrXtjpf9TPDvI+hA5QXL2oknjqrYftWujqXQXEL4=; b=kOKJAfNnva/e2rtboiHAQv0bUs
	Do63TsOwYnJFjsyJ7+UzE5SMSDUHb3O89J5/c5nWl+kdpsQ6s7KTw7dAk3kB4yPYg2gKQ/pIMxYqh
	nMQkQXqHDdPl0u36nZhgkmtoC9NAPXU2OpxtSgNNC+lTJL1mI6MNfDCOv863At/jjsXhoFaFDxiso
	J8Bff+7bsi0+Ztl3Hlth1gpuGM+jrusTmevr60UxAqHZi2zRtROkV3JHGPgOCAAqcEJX7zb2EwtLN
	MIHrttAjs7wRf7Y0M91EFlbFBh5UlEVfiVaxYPi2unLgLF1GeIMTp+tgFYN50v9zODkU/fAdRaRHc
	qLu1zkuA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBKQH-0000000A4I9-3dJ8;
	Sat, 03 May 2025 21:29:25 +0000
Date: Sat, 3 May 2025 22:29:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH][RFC][CFT] kill vfs_submount(), already
Message-ID: <20250503212925.GZ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The last remaining user of vfs_submount() (tracefs) is easy to convert
to fs_context_for_submount(); do that and bury that thing, along with
SB_SUBMOUNT

If nobody objects, I'm going to throw that into the mount-related pile;
alternatively, that could be split into kernel/trace.c part (in invariant
branch, to be pulled by tracefs folks and into the mount pile before
the rest of the patch).  Preferences?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 07f636036b86..293e6f925eff 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1297,21 +1297,6 @@ struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 }
 EXPORT_SYMBOL_GPL(vfs_kern_mount);
 
-struct vfsmount *
-vfs_submount(const struct dentry *mountpoint, struct file_system_type *type,
-	     const char *name, void *data)
-{
-	/* Until it is worked out how to pass the user namespace
-	 * through from the parent mount to the submount don't support
-	 * unprivileged mounts with submounts.
-	 */
-	if (mountpoint->d_sb->s_user_ns != &init_user_ns)
-		return ERR_PTR(-EPERM);
-
-	return vfs_kern_mount(type, SB_SUBMOUNT, name, data);
-}
-EXPORT_SYMBOL_GPL(vfs_submount);
-
 static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 					int flag)
 {
diff --git a/fs/super.c b/fs/super.c
index 97a17f9d9023..1886e4c930e0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -823,13 +823,6 @@ struct super_block *sget(struct file_system_type *type,
 	struct super_block *old;
 	int err;
 
-	/* We don't yet pass the user namespace of the parent
-	 * mount through to here so always use &init_user_ns
-	 * until that changes.
-	 */
-	if (flags & SB_SUBMOUNT)
-		user_ns = &init_user_ns;
-
 retry:
 	spin_lock(&sb_lock);
 	if (test) {
@@ -849,7 +842,7 @@ struct super_block *sget(struct file_system_type *type,
 	}
 	if (!s) {
 		spin_unlock(&sb_lock);
-		s = alloc_super(type, (flags & ~SB_SUBMOUNT), user_ns);
+		s = alloc_super(type, flags, user_ns);
 		if (!s)
 			return ERR_PTR(-ENOMEM);
 		goto retry;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..515e702d98ae 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1240,7 +1240,6 @@ extern int send_sigurg(struct file *file);
 /* These sb flags are internal to the kernel */
 #define SB_DEAD         BIT(21)
 #define SB_DYING        BIT(24)
-#define SB_SUBMOUNT     BIT(26)
 #define SB_FORCE        BIT(27)
 #define SB_NOSEC        BIT(28)
 #define SB_BORN         BIT(29)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fa488721019f..7b6248ba4428 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -51,6 +51,7 @@
 #include <linux/workqueue.h>
 #include <linux/sort.h>
 #include <linux/io.h> /* vmap_page_range() */
+#include <linux/fs_context.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE */
 
@@ -10072,6 +10073,8 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 {
 	struct vfsmount *mnt;
 	struct file_system_type *type;
+	struct fs_context *fc;
+	int ret;
 
 	/*
 	 * To maintain backward compatibility for tools that mount
@@ -10081,10 +10084,20 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	type = get_fs_type("tracefs");
 	if (!type)
 		return NULL;
-	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
+
+	fc = fs_context_for_submount(type, mntpt);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	ret = vfs_parse_fs_string(fc, "source",
+				  "tracefs", strlen("tracefs"));
+	if (!ret)
+		mnt = fc_mount(fc);
+	else
+		mnt = ERR_PTR(ret);
+
+	put_fs_context(fc);
 	put_filesystem(type);
-	if (IS_ERR(mnt))
-		return NULL;
 	return mnt;
 }
 

