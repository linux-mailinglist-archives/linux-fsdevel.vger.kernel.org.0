Return-Path: <linux-fsdevel+bounces-53729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F0FAF63EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7361189EBC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3877723BCEF;
	Wed,  2 Jul 2025 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dhKK/wSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57362DE705
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491463; cv=none; b=UsOyL8P0svgVrsne7HfsOQA53Lz9BqMwBsZnZOKHypWTZi9OmTyIu+NuwG4zlFydsYZAgtG9OHuFzLSqH2Bu0Cq3IDSmUbHRzUkd+dqEKZ6Jwsb1lfEJOOZnYhJKytqSyGiyeEOZtuH80yWdmjQ6TaLCVXSUsiTNsmuI5DVUHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491463; c=relaxed/simple;
	bh=a+KBPQUU5faM1sjcyGgLo0QbTrSpcELS2W7S/cBpMB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbA6KXqg106445Oh8OOYvAqbvE0tVx/L4gFkDVvhr5jYWp1FuF9II+NNc4vYAbha40j4kgbAaw9kHjliCVXj03DLPbMoDZRmieEKHsoHRdq9kq7uKURMEPxnP1/3m+E4RP9lpFe2R9hnugfguG984RHy+tiRmtkzdMDbRyVGcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dhKK/wSU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y8ufYvnFKlvMBKH3ampxBq2Cte3209CH1adVUOP+4Ss=; b=dhKK/wSUVT5k036WERpx727MLX
	O6uCwc1CrQ947/ph0HGOIyPraAZFAz8f7WnsZu1t8Y15vSC1U+wN7GqzsdarqmmhNeMNBKh8lwF2p
	Ol6nrYTBDaGTH/suL/Uc4veVehdsGwdCLZmlaeUXfa3ORQyLACDXa2P1ZYAyiiwolWyO/UTGOBkxw
	6tVztj1xfOr9gK3d7jx5pf818acP+3NG8cjp5NmZQ7bmOBkhsyslWMYzTSDohj6cTqLvKCW3AM8ya
	FRedps5TfXqD3KyxPSLBHY10jWGK9D8wgZtOLDoK7+Vz0Bz0nK/OAlYRj7pQVZazS9qY72NQW1D+H
	L+v8fLYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4wF-0000000ENfv-3YZk;
	Wed, 02 Jul 2025 21:24:19 +0000
Date: Wed, 2 Jul 2025 22:24:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 07/11] debugfs: split short and full proxy wrappers, kill
 debugfs_real_fops()
Message-ID: <20250702212419.GG3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

All users outside of fs/debugfs/file.c are gone, in there we can just
fully split the wrappers for full and short cases and be done with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/file.c       | 87 ++++++++++++++++++-----------------------
 include/linux/debugfs.h |  2 -
 2 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 69e9ddcb113d..77784091a10f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -53,23 +53,6 @@ const void *debugfs_get_aux(const struct file *file)
 }
 EXPORT_SYMBOL_GPL(debugfs_get_aux);
 
-const struct file_operations *debugfs_real_fops(const struct file *filp)
-{
-	struct debugfs_fsdata *fsd = F_DENTRY(filp)->d_fsdata;
-
-	if (!fsd) {
-		/*
-		 * Urgh, we've been called w/o a protecting
-		 * debugfs_file_get().
-		 */
-		WARN_ON(1);
-		return NULL;
-	}
-
-	return fsd->real_fops;
-}
-EXPORT_SYMBOL_GPL(debugfs_real_fops);
-
 enum dbgfs_get_mode {
 	DBGFS_GET_ALREADY,
 	DBGFS_GET_REGULAR,
@@ -302,15 +285,13 @@ static int debugfs_locked_down(struct inode *inode,
 static int open_proxy_open(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = F_DENTRY(filp);
-	const struct file_operations *real_fops = NULL;
+	const struct file_operations *real_fops = DEBUGFS_I(inode)->real_fops;
 	int r;
 
 	r = __debugfs_file_get(dentry, DBGFS_GET_REGULAR);
 	if (r)
 		return r == -EIO ? -ENOENT : r;
 
-	real_fops = debugfs_real_fops(filp);
-
 	r = debugfs_locked_down(inode, filp, real_fops);
 	if (r)
 		goto out;
@@ -352,7 +333,6 @@ static ret_type full_proxy_ ## name(proto)				\
 {									\
 	struct dentry *dentry = F_DENTRY(filp);				\
 	struct debugfs_fsdata *fsd = dentry->d_fsdata;			\
-	const struct file_operations *real_fops;			\
 	ret_type r;							\
 									\
 	if (!(fsd->methods & bit))					\
@@ -360,14 +340,13 @@ static ret_type full_proxy_ ## name(proto)				\
 	r = debugfs_file_get(dentry);					\
 	if (unlikely(r))						\
 		return r;						\
-	real_fops = debugfs_real_fops(filp);				\
-	r = real_fops->name(args);					\
+	r = fsd->real_fops->name(args);					\
 	debugfs_file_put(dentry);					\
 	return r;							\
 }
 
-#define FULL_PROXY_FUNC_BOTH(name, ret_type, filp, proto, args, bit, ret)	\
-static ret_type full_proxy_ ## name(proto)				\
+#define SHORT_PROXY_FUNC(name, ret_type, filp, proto, args, bit, ret)	\
+static ret_type short_proxy_ ## name(proto)				\
 {									\
 	struct dentry *dentry = F_DENTRY(filp);				\
 	struct debugfs_fsdata *fsd = dentry->d_fsdata;			\
@@ -378,27 +357,38 @@ static ret_type full_proxy_ ## name(proto)				\
 	r = debugfs_file_get(dentry);					\
 	if (unlikely(r))						\
 		return r;						\
-	if (fsd->real_fops)						\
-		r = fsd->real_fops->name(args);				\
-	else								\
-		r = fsd->short_fops->name(args);			\
+	r = fsd->short_fops->name(args);				\
 	debugfs_file_put(dentry);					\
 	return r;							\
 }
 
-FULL_PROXY_FUNC_BOTH(llseek, loff_t, filp,
-		     PROTO(struct file *filp, loff_t offset, int whence),
-		     ARGS(filp, offset, whence), HAS_LSEEK, -ESPIPE);
+SHORT_PROXY_FUNC(llseek, loff_t, filp,
+		PROTO(struct file *filp, loff_t offset, int whence),
+		ARGS(filp, offset, whence), HAS_LSEEK, -ESPIPE);
 
-FULL_PROXY_FUNC_BOTH(read, ssize_t, filp,
-		     PROTO(struct file *filp, char __user *buf, size_t size,
-			   loff_t *ppos),
-		     ARGS(filp, buf, size, ppos), HAS_READ, -EINVAL);
+FULL_PROXY_FUNC(llseek, loff_t, filp,
+		PROTO(struct file *filp, loff_t offset, int whence),
+		ARGS(filp, offset, whence), HAS_LSEEK, -ESPIPE);
 
-FULL_PROXY_FUNC_BOTH(write, ssize_t, filp,
-		     PROTO(struct file *filp, const char __user *buf,
-			   size_t size, loff_t *ppos),
-		     ARGS(filp, buf, size, ppos), HAS_WRITE, -EINVAL);
+SHORT_PROXY_FUNC(read, ssize_t, filp,
+		PROTO(struct file *filp, char __user *buf, size_t size,
+			loff_t *ppos),
+		ARGS(filp, buf, size, ppos), HAS_READ, -EINVAL);
+
+FULL_PROXY_FUNC(read, ssize_t, filp,
+		PROTO(struct file *filp, char __user *buf, size_t size,
+			loff_t *ppos),
+		ARGS(filp, buf, size, ppos), HAS_READ, -EINVAL);
+
+SHORT_PROXY_FUNC(write, ssize_t, filp,
+		PROTO(struct file *filp, const char __user *buf,
+			size_t size, loff_t *ppos),
+		ARGS(filp, buf, size, ppos), HAS_WRITE, -EINVAL);
+
+FULL_PROXY_FUNC(write, ssize_t, filp,
+		PROTO(struct file *filp, const char __user *buf,
+			size_t size, loff_t *ppos),
+		ARGS(filp, buf, size, ppos), HAS_WRITE, -EINVAL);
 
 FULL_PROXY_FUNC(unlocked_ioctl, long, filp,
 		PROTO(struct file *filp, unsigned int cmd, unsigned long arg),
@@ -410,22 +400,21 @@ static __poll_t full_proxy_poll(struct file *filp,
 	struct dentry *dentry = F_DENTRY(filp);
 	struct debugfs_fsdata *fsd = dentry->d_fsdata;
 	__poll_t r = 0;
-	const struct file_operations *real_fops;
 
 	if (!(fsd->methods & HAS_POLL))
 		return DEFAULT_POLLMASK;
 	if (debugfs_file_get(dentry))
 		return EPOLLHUP;
 
-	real_fops = debugfs_real_fops(filp);
-	r = real_fops->poll(filp, wait);
+	r = fsd->real_fops->poll(filp, wait);
 	debugfs_file_put(dentry);
 	return r;
 }
 
-static int full_proxy_release(struct inode *inode, struct file *filp)
+static int full_proxy_release(struct inode *inode, struct file *file)
 {
-	const struct file_operations *real_fops = debugfs_real_fops(filp);
+	struct debugfs_fsdata *fsd = F_DENTRY(file)->d_fsdata;
+	const struct file_operations *real_fops = fsd->real_fops;
 	int r = 0;
 
 	/*
@@ -435,7 +424,7 @@ static int full_proxy_release(struct inode *inode, struct file *filp)
 	 * ->i_private is still being meaningful here.
 	 */
 	if (real_fops->release)
-		r = real_fops->release(inode, filp);
+		r = real_fops->release(inode, file);
 
 	fops_put(real_fops);
 	return r;
@@ -517,9 +506,9 @@ static int full_proxy_open_short(struct inode *inode, struct file *filp)
 
 const struct file_operations debugfs_full_short_proxy_file_operations = {
 	.open = full_proxy_open_short,
-	.llseek = full_proxy_llseek,
-	.read = full_proxy_read,
-	.write = full_proxy_write,
+	.llseek = short_proxy_llseek,
+	.read = short_proxy_read,
+	.write = short_proxy_write,
 };
 
 ssize_t debugfs_attr_read(struct file *file, char __user *buf,
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index fa2568b4380d..a420152105d0 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -162,7 +162,6 @@ void debugfs_remove(struct dentry *dentry);
 
 void debugfs_lookup_and_remove(const char *name, struct dentry *parent);
 
-const struct file_operations *debugfs_real_fops(const struct file *filp);
 const void *debugfs_get_aux(const struct file *file);
 
 int debugfs_file_get(struct dentry *dentry);
@@ -329,7 +328,6 @@ static inline void debugfs_lookup_and_remove(const char *name,
 					     struct dentry *parent)
 { }
 
-const struct file_operations *debugfs_real_fops(const struct file *filp);
 void *debugfs_get_aux(const struct file *file);
 
 static inline int debugfs_file_get(struct dentry *dentry)
-- 
2.39.5


