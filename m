Return-Path: <linux-fsdevel+bounces-48134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED9AA9E39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 23:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F171796ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272D270555;
	Mon,  5 May 2025 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SxxMvqRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE816D9C2;
	Mon,  5 May 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746481114; cv=none; b=QfK0l4atABJ0oiikdjc/HxUX7gqX96V02+zs5YyKzcSJAedHIzwWXNzEGVZH/b/Zbu1k0cQg0BkAZ33H488dXlTl7ic0jG5ISGN8z6XANw+3Lx3DHvmd/1Jfwd7L07lIlUxxXKjbr4ogH7efoPIvT3A/QRcDPMtxcBtbsM2d47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746481114; c=relaxed/simple;
	bh=CzrcoT0LxNGl0mFzCjqyGjQWe/eLknJLoU/y9dVRFBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPmzeRbigp26S0PfLBdGGQCLWZnObdlJnnE9qUfnP0i9SroICuc9GBmhTXMf8LdifpyCApceuorzYgknjGcXX8WBVhX6DjSaOKvumolZoW+jSAlIYuAYj1596gdvt8RAHdq/cgWoKxI75DNtkaIoLk+/yRc3D7NesrfLWha2Mow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SxxMvqRq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ia3+UmbmCn3a/XxQF41qW8DIGKkmVOq4Hrgy62+iyHo=; b=SxxMvqRqmQ2CJk/LQPFMpeTfxJ
	7AMe/oLzXA6MY5iIgmxank0mG3ZAzGs55YxwUnKgwTgjo2e3WrJzExZyd7NgwdXfF/6ickC0f5Dc/
	lyvFXpK9X2Z7hm38o8wH3rBQzTdQDy3W75CisGxTJA963zbwug6tIcuUvsKq/5SSyNRm+MzN+0aAU
	LX9/TUdS2GDQe0kK6xdL7DTz27n3p8AGV8SXvSnpgJp8sXI2IHpGV25yI3vJj3/wlkPc6HXwqX5ES
	A4oTYyJW/9KalOFvzKrmoZlRkoj2+0tPxtUatbQfh0w4dRS7Mh2GuPB2j/t5MuSfa6TkaEezk8pD3
	3jXbPRIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC3W9-00000006lt0-1knh;
	Mon, 05 May 2025 21:38:29 +0000
Date: Mon, 5 May 2025 22:38:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2] kill vfs_submount()
Message-ID: <20250505213829.GI2023217@ZenIV>
References: <20250503212925.GZ2023217@ZenIV>
 <utebik76wcdgaspk7sjzb3aedmlcwbmwj3olur45zuycbpapjc@pd5rhnudxb35>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <utebik76wcdgaspk7sjzb3aedmlcwbmwj3olur45zuycbpapjc@pd5rhnudxb35>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 05, 2025 at 12:55:34PM +0200, Jan Kara wrote:
> >  	if (!type)
> >  		return NULL;
> > -	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
> > +
> > +	fc = fs_context_for_submount(type, mntpt);
> > +	if (IS_ERR(fc))
> > +		return ERR_CAST(fc);
> 
> Missing put_filesystem() here?

Actually, I'd rather have it done unconditionally right after
fc_context_for_submount() - fs_context allocation grabs
a reference and it's held until put_fs_context, so...

[PATCH] kill vfs_submount()
    
The last remaining user of vfs_submount() (tracefs) is easy to convert
to fs_context_for_submount(); do that and bury that thing, along with
SB_SUBMOUNT

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 018e95fe5459..0577a9fb6050 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1329,21 +1329,6 @@ struct vfsmount *vfs_kern_mount(struct file_system_type *type,
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
diff --git a/include/linux/mount.h b/include/linux/mount.h
index dcc17ce8a959..d4eb90a367af 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -98,9 +98,6 @@ extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
 extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				      int flags, const char *name,
 				      void *data);
-extern struct vfsmount *vfs_submount(const struct dentry *mountpoint,
-				     struct file_system_type *type,
-				     const char *name, void *data);
 
 extern void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list);
 extern void mark_mounts_for_expiry(struct list_head *mounts);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e22aacb0028a..936a615e8c56 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -51,6 +51,7 @@
 #include <linux/workqueue.h>
 #include <linux/sort.h>
 #include <linux/io.h> /* vmap_page_range() */
+#include <linux/fs_context.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE */
 
@@ -10075,6 +10076,8 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 {
 	struct vfsmount *mnt;
 	struct file_system_type *type;
+	struct fs_context *fc;
+	int ret;
 
 	/*
 	 * To maintain backward compatibility for tools that mount
@@ -10084,10 +10087,20 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	type = get_fs_type("tracefs");
 	if (!type)
 		return NULL;
-	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
+
+	fc = fs_context_for_submount(type, mntpt);
 	put_filesystem(type);
-	if (IS_ERR(mnt))
-		return NULL;
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
 	return mnt;
 }
 

