Return-Path: <linux-fsdevel+bounces-38216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3781A9FDDEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86C01881EA2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B5E7082F;
	Sun, 29 Dec 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uFpouZWs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E92C182
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459947; cv=none; b=leYxiLh3hROHgiSS/l33G5iesflx3uNJQuK8E/j5SJ46h28gMPjXC9W8WIMu+ypxmskm7I+/7zy/il0tBKCOT2yKQkH7J4f5X91hwdULSpyzOCVALADO939xVyhLd/2TBuBTnmTjDy1YbzoR2kukTMY/bfrpzn9/SV6vwAfDczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459947; c=relaxed/simple;
	bh=yvebndEsYgjYQ9nyOJLYqwC9TNaYQYrVJCTsOJ3qJ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeWU388ArfoqZJ/+OI0vSSEyUDJ8llQfKOZWlg0+mwnDzs4GI52CcuNvoGrCIZGKdrqCYJ0EcGOL+GOoYsRPYLxLUiSZFSMhhxpCgUdGLYQV7/xZ45L7hqRJtHUpx/0KclLqZfTNOb8ALJvMjCWfTtqaSlrzTC0c579473fYeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uFpouZWs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Y5sxRoDrtsMHtS/H3tfzhJ/R8BFfMaYQspB72WMecLE=; b=uFpouZWsjR5LQyp6ymqOR/KATJ
	WW0YTIyXbrK/5JkGnl4jn6hB/+yUk6luAM57i2OmMqnnfkkLgbTrTgdD4JrwkjEJ9SkAh40fGeObA
	siKfZIAHPLwATc3MLOL//3XMGOiY/grRKr7jLXlY1FtxTv4eQd18+U43TZnSgA/Re/yoR9ztwD1tm
	hQfNOyZ27sdoQn2j3azOk2d//vyNBYAmxV6uYxNxB7JYaN2knCclhyFb2Zqi6Kx2AQISEIpms6PCU
	fB6ydWwogMlAjvRiDJ63XVj/F8/FWT8wm5nT5OfWU47Snlu7OFKqpIXZH/3Ho6PFsS7vv4Xlz3SwC
	PdjVRFeA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPP-0000000DOhz-3LE6;
	Sun, 29 Dec 2024 08:12:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 04/20] debugfs: get rid of dynamically allocation proxy_ops
Date: Sun, 29 Dec 2024 08:12:07 +0000
Message-ID: <20241229081223.3193228-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

All it takes is having full_proxy_open() collect the information
about available methods and store it in debugfs_fsdata.

Wrappers are called only after full_proxy_open() has succeeded
calling debugfs_get_file(), so they are guaranteed to have
->d_fsdata already pointing to debugfs_fsdata.

As the result, they can check if method is absent and bugger off
early, without any atomic operations, etc. - same effect as what
we'd have from NULL method.  Which makes the entire proxy_fops
contents unconditional, making it completely pointless - we can
just put those methods (unconditionally) into
debugfs_full_proxy_file_operations and forget about dynamic
allocation, replace_fops, etc.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/file.c     | 114 +++++++++++++++++++-----------------------
 fs/debugfs/internal.h |   9 ++++
 2 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 47dc96dfe386..71e359f5f587 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -96,19 +96,37 @@ int debugfs_file_get(struct dentry *dentry)
 	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
 		fsd = d_fsd;
 	} else {
-		fsd = kmalloc(sizeof(*fsd), GFP_KERNEL);
+		fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
 		if (!fsd)
 			return -ENOMEM;
 
 		if ((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT) {
-			fsd->real_fops = NULL;
-			fsd->short_fops = (void *)((unsigned long)d_fsd &
-						~(DEBUGFS_FSDATA_IS_REAL_FOPS_BIT |
-						  DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
+			const struct debugfs_short_fops *ops;
+			ops = (void *)((unsigned long)d_fsd &
+					~(DEBUGFS_FSDATA_IS_REAL_FOPS_BIT |
+					  DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
+			fsd->short_fops = ops;
+			if (ops->llseek)
+				fsd->methods |= HAS_LSEEK;
+			if (ops->read)
+				fsd->methods |= HAS_READ;
+			if (ops->write)
+				fsd->methods |= HAS_WRITE;
 		} else {
-			fsd->real_fops = (void *)((unsigned long)d_fsd &
-						~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
-			fsd->short_fops = NULL;
+			const struct file_operations *ops;
+			ops = (void *)((unsigned long)d_fsd &
+					~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
+			fsd->real_fops = ops;
+			if (ops->llseek)
+				fsd->methods |= HAS_LSEEK;
+			if (ops->read)
+				fsd->methods |= HAS_READ;
+			if (ops->write)
+				fsd->methods |= HAS_WRITE;
+			if (ops->unlocked_ioctl)
+				fsd->methods |= HAS_IOCTL;
+			if (ops->poll)
+				fsd->methods |= HAS_POLL;
 		}
 		refcount_set(&fsd->active_users, 1);
 		init_completion(&fsd->active_users_drained);
@@ -309,13 +327,16 @@ const struct file_operations debugfs_open_proxy_file_operations = {
 #define PROTO(args...) args
 #define ARGS(args...) args
 
-#define FULL_PROXY_FUNC(name, ret_type, filp, proto, args)		\
+#define FULL_PROXY_FUNC(name, ret_type, filp, proto, args, bit, ret)	\
 static ret_type full_proxy_ ## name(proto)				\
 {									\
-	struct dentry *dentry = F_DENTRY(filp);			\
+	struct dentry *dentry = F_DENTRY(filp);				\
+	struct debugfs_fsdata *fsd = dentry->d_fsdata;			\
 	const struct file_operations *real_fops;			\
 	ret_type r;							\
 									\
+	if (!(fsd->methods & bit))					\
+		return ret;						\
 	r = debugfs_file_get(dentry);					\
 	if (unlikely(r))						\
 		return r;						\
@@ -325,17 +346,18 @@ static ret_type full_proxy_ ## name(proto)				\
 	return r;							\
 }
 
-#define FULL_PROXY_FUNC_BOTH(name, ret_type, filp, proto, args)		\
+#define FULL_PROXY_FUNC_BOTH(name, ret_type, filp, proto, args, bit, ret)	\
 static ret_type full_proxy_ ## name(proto)				\
 {									\
 	struct dentry *dentry = F_DENTRY(filp);				\
-	struct debugfs_fsdata *fsd;					\
+	struct debugfs_fsdata *fsd = dentry->d_fsdata;			\
 	ret_type r;							\
 									\
+	if (!(fsd->methods & bit))					\
+		return ret;						\
 	r = debugfs_file_get(dentry);					\
 	if (unlikely(r))						\
 		return r;						\
-	fsd = dentry->d_fsdata;						\
 	if (fsd->real_fops)						\
 		r = fsd->real_fops->name(args);				\
 	else								\
@@ -346,29 +368,32 @@ static ret_type full_proxy_ ## name(proto)				\
 
 FULL_PROXY_FUNC_BOTH(llseek, loff_t, filp,
 		     PROTO(struct file *filp, loff_t offset, int whence),
-		     ARGS(filp, offset, whence));
+		     ARGS(filp, offset, whence), HAS_LSEEK, -ESPIPE);
 
 FULL_PROXY_FUNC_BOTH(read, ssize_t, filp,
 		     PROTO(struct file *filp, char __user *buf, size_t size,
 			   loff_t *ppos),
-		     ARGS(filp, buf, size, ppos));
+		     ARGS(filp, buf, size, ppos), HAS_READ, -EINVAL);
 
 FULL_PROXY_FUNC_BOTH(write, ssize_t, filp,
 		     PROTO(struct file *filp, const char __user *buf,
 			   size_t size, loff_t *ppos),
-		     ARGS(filp, buf, size, ppos));
+		     ARGS(filp, buf, size, ppos), HAS_WRITE, -EINVAL);
 
 FULL_PROXY_FUNC(unlocked_ioctl, long, filp,
 		PROTO(struct file *filp, unsigned int cmd, unsigned long arg),
-		ARGS(filp, cmd, arg));
+		ARGS(filp, cmd, arg), HAS_IOCTL, -ENOTTY);
 
 static __poll_t full_proxy_poll(struct file *filp,
 				struct poll_table_struct *wait)
 {
 	struct dentry *dentry = F_DENTRY(filp);
+	struct debugfs_fsdata *fsd = dentry->d_fsdata;
 	__poll_t r = 0;
 	const struct file_operations *real_fops;
 
+	if (!(fsd->methods & HAS_POLL))
+		return DEFAULT_POLLMASK;
 	if (debugfs_file_get(dentry))
 		return EPOLLHUP;
 
@@ -380,9 +405,7 @@ static __poll_t full_proxy_poll(struct file *filp,
 
 static int full_proxy_release(struct inode *inode, struct file *filp)
 {
-	const struct dentry *dentry = F_DENTRY(filp);
 	const struct file_operations *real_fops = debugfs_real_fops(filp);
-	const struct file_operations *proxy_fops = filp->f_op;
 	int r = 0;
 
 	/*
@@ -394,41 +417,14 @@ static int full_proxy_release(struct inode *inode, struct file *filp)
 	if (real_fops && real_fops->release)
 		r = real_fops->release(inode, filp);
 
-	replace_fops(filp, d_inode(dentry)->i_fop);
-	kfree(proxy_fops);
 	fops_put(real_fops);
 	return r;
 }
 
-static void __full_proxy_fops_init(struct file_operations *proxy_fops,
-				   struct debugfs_fsdata *fsd)
-{
-	proxy_fops->release = full_proxy_release;
-
-	if ((fsd->real_fops && fsd->real_fops->llseek) ||
-	    (fsd->short_fops && fsd->short_fops->llseek))
-		proxy_fops->llseek = full_proxy_llseek;
-
-	if ((fsd->real_fops && fsd->real_fops->read) ||
-	    (fsd->short_fops && fsd->short_fops->read))
-		proxy_fops->read = full_proxy_read;
-
-	if ((fsd->real_fops && fsd->real_fops->write) ||
-	    (fsd->short_fops && fsd->short_fops->write))
-		proxy_fops->write = full_proxy_write;
-
-	if (fsd->real_fops && fsd->real_fops->poll)
-		proxy_fops->poll = full_proxy_poll;
-
-	if (fsd->real_fops && fsd->real_fops->unlocked_ioctl)
-		proxy_fops->unlocked_ioctl = full_proxy_unlocked_ioctl;
-}
-
 static int full_proxy_open(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = F_DENTRY(filp);
 	const struct file_operations *real_fops;
-	struct file_operations *proxy_fops = NULL;
 	struct debugfs_fsdata *fsd;
 	int r;
 
@@ -458,34 +454,20 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 		goto out;
 	}
 
-	proxy_fops = kzalloc(sizeof(*proxy_fops), GFP_KERNEL);
-	if (!proxy_fops) {
-		r = -ENOMEM;
-		goto free_proxy;
-	}
-	__full_proxy_fops_init(proxy_fops, fsd);
-	replace_fops(filp, proxy_fops);
-
 	if (!real_fops || real_fops->open) {
 		if (real_fops)
 			r = real_fops->open(inode, filp);
 		else
 			r = simple_open(inode, filp);
 		if (r) {
-			replace_fops(filp, d_inode(dentry)->i_fop);
-			goto free_proxy;
-		} else if (filp->f_op != proxy_fops) {
+			fops_put(real_fops);
+		} else if (filp->f_op != &debugfs_full_proxy_file_operations) {
 			/* No protection against file removal anymore. */
 			WARN(1, "debugfs file owner replaced proxy fops: %pd",
 				dentry);
-			goto free_proxy;
+			fops_put(real_fops);
 		}
 	}
-
-	goto out;
-free_proxy:
-	kfree(proxy_fops);
-	fops_put(real_fops);
 out:
 	debugfs_file_put(dentry);
 	return r;
@@ -493,6 +475,12 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 
 const struct file_operations debugfs_full_proxy_file_operations = {
 	.open = full_proxy_open,
+	.release = full_proxy_release,
+	.llseek = full_proxy_llseek,
+	.read = full_proxy_read,
+	.write = full_proxy_write,
+	.poll = full_proxy_poll,
+	.unlocked_ioctl = full_proxy_unlocked_ioctl
 };
 
 ssize_t debugfs_attr_read(struct file *file, char __user *buf,
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index a0d9eb3fa67d..72f0034953b5 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -38,9 +38,18 @@ struct debugfs_fsdata {
 		/* protect cancellations */
 		struct mutex cancellations_mtx;
 		struct list_head cancellations;
+		unsigned int methods;
 	};
 };
 
+enum {
+	HAS_READ = 1,
+	HAS_WRITE = 2,
+	HAS_LSEEK = 4,
+	HAS_POLL = 8,
+	HAS_IOCTL = 16
+};
+
 /*
  * A dentry's ->d_fsdata either points to the real fops or to a
  * dynamically allocated debugfs_fsdata instance.
-- 
2.39.5


