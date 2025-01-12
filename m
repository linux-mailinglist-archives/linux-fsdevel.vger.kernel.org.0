Return-Path: <linux-fsdevel+bounces-38960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CE8A0A78C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DEA3A89FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB6E1885B8;
	Sun, 12 Jan 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gCQAvGjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A544155C97
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669229; cv=none; b=ca5ySty0cVfiPHeVf7p048TyktCAQKBt9agneS3bJF30w0D9HJggh9xxHBXRHXRuNSGINSwBoOL416djl/BDERW2Zuy5oyUL/GAZhgB+rI6TPZO9LQ0JeFSgRFF3wAYwKdVJcJt3twumPmAMzlKmhCInLhZSHrSywAiprgkLQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669229; c=relaxed/simple;
	bh=nUJ8k0IHtzm8uCBxixJtpFIaQUYpar563XVAZi2hFKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4idh2V2574f23PE3C54fRuAmcXPsOIQ0J/mLzLW+IDDmdPVxMk6SVq2r7sm4TEkCZlKXXAWxJsnWJLsQ6ug5nhbQJjlCcdcf7gZYpn7M/+xR7hHFqzFQZMbhnMK+mEwVLnE2vVwJVQCYbaLdy/pS4rwWQ8d9/rks5rLlhQ67Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gCQAvGjK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aYrRWSch3vVOyaXWHl939PIZVRf55TeFQTH2RnY15nM=; b=gCQAvGjKPFADWrEEGCwYY7EK4F
	jgQ5ISflWaiclZJCKRgUuuXLoZnd7h2T5Xgr4L5fSAVZEx/sn794qClmSoW9XYhhaLppN9Q47bFuS
	tMbdwhp6M3+vkl4U4l9VLf0DUNVxsqXtRUZIJE4SpbumO1cHSgNQXA3rTZF2QmVDpiEqkEQJTOv/K
	4XYHS/+pwlD+uKDJvzEmwsP1aED8GRYtLWTUYJL/2+I8hAEz1TRHULjTy1Nys8p93TzrDL2omONHE
	yxkD5sNWeT3Ip0quZo27KKgionAPhyon/5eEuUHX1CNpXPp+Gl0hT8uSxpI1KfaHky4kVBfO6HUg3
	HUeplpUA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszx-00000000ajA-3LsV;
	Sun, 12 Jan 2025 08:07:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 04/21] debugfs: don't mess with bits in ->d_fsdata
Date: Sun, 12 Jan 2025 08:06:48 +0000
Message-ID: <20250112080705.141166-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

The reason we need that crap is the dual use ->d_fsdata has there -
it's both holding a debugfs_fsdata reference after the first
debugfs_file_get() (actually, after the call of proxy ->open())
*and* it serves as a place to stash a reference to real file_operations
from object creation to the first open.  Oh, and it's triple use,
actually - that stashed reference might be to debugfs_short_fops.

Bugger that for a game of solidiers - just put the operations
reference into debugfs-private augmentation of inode.  And split
debugfs_full_file_operations into full and short cases, so that
debugfs_get_file() could tell one from another.

Voila - ->d_fsdata holds NULL until the first (successful) debugfs_get_file()
and a reference to struct debugfs_fsdata afterwards.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/file.c     | 58 +++++++++++++++++++++----------------------
 fs/debugfs/inode.c    | 29 ++++++----------------
 fs/debugfs/internal.h | 12 +++------
 3 files changed, 38 insertions(+), 61 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index eb59b01f5f25..ae014bd36a6f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -51,7 +51,7 @@ const struct file_operations *debugfs_real_fops(const struct file *filp)
 {
 	struct debugfs_fsdata *fsd = F_DENTRY(filp)->d_fsdata;
 
-	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT) {
+	if (!fsd) {
 		/*
 		 * Urgh, we've been called w/o a protecting
 		 * debugfs_file_get().
@@ -84,9 +84,11 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 		return -EINVAL;
 
 	d_fsd = READ_ONCE(dentry->d_fsdata);
-	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
+	if (d_fsd) {
 		fsd = d_fsd;
 	} else {
+		struct inode *inode = dentry->d_inode;
+
 		if (WARN_ON(mode == DBGFS_GET_ALREADY))
 			return -EINVAL;
 
@@ -96,9 +98,7 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 
 		if (mode == DBGFS_GET_SHORT) {
 			const struct debugfs_short_fops *ops;
-			ops = (void *)((unsigned long)d_fsd &
-					~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
-			fsd->short_fops = ops;
+			ops = fsd->short_fops = DEBUGFS_I(inode)->short_fops;
 			if (ops->llseek)
 				fsd->methods |= HAS_LSEEK;
 			if (ops->read)
@@ -107,9 +107,7 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 				fsd->methods |= HAS_WRITE;
 		} else {
 			const struct file_operations *ops;
-			ops = (void *)((unsigned long)d_fsd &
-					~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
-			fsd->real_fops = ops;
+			ops = fsd->real_fops = DEBUGFS_I(inode)->real_fops;
 			if (ops->llseek)
 				fsd->methods |= HAS_LSEEK;
 			if (ops->read)
@@ -126,10 +124,11 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 		INIT_LIST_HEAD(&fsd->cancellations);
 		mutex_init(&fsd->cancellations_mtx);
 
-		if (cmpxchg(&dentry->d_fsdata, d_fsd, fsd) != d_fsd) {
+		d_fsd = cmpxchg(&dentry->d_fsdata, NULL, fsd);
+		if (d_fsd) {
 			mutex_destroy(&fsd->cancellations_mtx);
 			kfree(fsd);
-			fsd = READ_ONCE(dentry->d_fsdata);
+			fsd = d_fsd;
 		}
 	}
 
@@ -226,8 +225,7 @@ void debugfs_enter_cancellation(struct file *file,
 		return;
 
 	fsd = READ_ONCE(dentry->d_fsdata);
-	if (WARN_ON(!fsd ||
-		    ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+	if (WARN_ON(!fsd))
 		return;
 
 	mutex_lock(&fsd->cancellations_mtx);
@@ -258,8 +256,7 @@ void debugfs_leave_cancellation(struct file *file,
 		return;
 
 	fsd = READ_ONCE(dentry->d_fsdata);
-	if (WARN_ON(!fsd ||
-		    ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+	if (WARN_ON(!fsd))
 		return;
 
 	mutex_lock(&fsd->cancellations_mtx);
@@ -427,22 +424,21 @@ static int full_proxy_release(struct inode *inode, struct file *filp)
 	 * not to leak any resources. Releasers must not assume that
 	 * ->i_private is still being meaningful here.
 	 */
-	if (real_fops && real_fops->release)
+	if (real_fops->release)
 		r = real_fops->release(inode, filp);
 
 	fops_put(real_fops);
 	return r;
 }
 
-static int full_proxy_open(struct inode *inode, struct file *filp,
-			   enum dbgfs_get_mode mode)
+static int full_proxy_open_regular(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = F_DENTRY(filp);
 	const struct file_operations *real_fops;
 	struct debugfs_fsdata *fsd;
 	int r;
 
-	r = __debugfs_file_get(dentry, mode);
+	r = __debugfs_file_get(dentry, DBGFS_GET_REGULAR);
 	if (r)
 		return r == -EIO ? -ENOENT : r;
 
@@ -452,7 +448,7 @@ static int full_proxy_open(struct inode *inode, struct file *filp,
 	if (r)
 		goto out;
 
-	if (real_fops && !fops_get(real_fops)) {
+	if (!fops_get(real_fops)) {
 #ifdef CONFIG_MODULES
 		if (real_fops->owner &&
 		    real_fops->owner->state == MODULE_STATE_GOING) {
@@ -468,11 +464,8 @@ static int full_proxy_open(struct inode *inode, struct file *filp,
 		goto out;
 	}
 
-	if (!real_fops || real_fops->open) {
-		if (real_fops)
-			r = real_fops->open(inode, filp);
-		else
-			r = simple_open(inode, filp);
+	if (real_fops->open) {
+		r = real_fops->open(inode, filp);
 		if (r) {
 			fops_put(real_fops);
 		} else if (filp->f_op != &debugfs_full_proxy_file_operations) {
@@ -487,11 +480,6 @@ static int full_proxy_open(struct inode *inode, struct file *filp,
 	return r;
 }
 
-static int full_proxy_open_regular(struct inode *inode, struct file *filp)
-{
-	return full_proxy_open(inode, filp, DBGFS_GET_REGULAR);
-}
-
 const struct file_operations debugfs_full_proxy_file_operations = {
 	.open = full_proxy_open_regular,
 	.release = full_proxy_release,
@@ -504,7 +492,17 @@ const struct file_operations debugfs_full_proxy_file_operations = {
 
 static int full_proxy_open_short(struct inode *inode, struct file *filp)
 {
-	return full_proxy_open(inode, filp, DBGFS_GET_SHORT);
+	struct dentry *dentry = F_DENTRY(filp);
+	int r;
+
+	r = __debugfs_file_get(dentry, DBGFS_GET_SHORT);
+	if (r)
+		return r == -EIO ? -ENOENT : r;
+	r = debugfs_locked_down(inode, filp, NULL);
+	if (!r)
+		r = simple_open(inode, filp);
+	debugfs_file_put(dentry);
+	return r;
 }
 
 const struct file_operations debugfs_full_short_proxy_file_operations = {
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 2f5afd7b1b94..c4e8b7f758e0 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -243,15 +243,10 @@ static void debugfs_release_dentry(struct dentry *dentry)
 {
 	struct debugfs_fsdata *fsd = dentry->d_fsdata;
 
-	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
-		return;
-
-	/* check it wasn't a dir or automount (no fsdata) */
 	if (fsd) {
 		WARN_ON(!list_empty(&fsd->cancellations));
 		mutex_destroy(&fsd->cancellations_mtx);
 	}
-
 	kfree(fsd);
 }
 
@@ -459,9 +454,10 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	inode->i_private = data;
 
 	inode->i_op = &debugfs_file_inode_operations;
+	if (!real_fops)
+		proxy_fops = &debugfs_noop_file_operations;
 	inode->i_fop = proxy_fops;
-	dentry->d_fsdata = (void *)((unsigned long)real_fops |
-				DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
+	DEBUGFS_I(inode)->raw = real_fops;
 
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
@@ -472,13 +468,8 @@ struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const struct file_operations *fops)
 {
-	if (WARN_ON((unsigned long)fops &
-		    DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
-		return ERR_PTR(-EINVAL);
-
 	return __debugfs_create_file(name, mode, parent, data,
-				fops ? &debugfs_full_proxy_file_operations :
-					&debugfs_noop_file_operations,
+				&debugfs_full_proxy_file_operations,
 				fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_full);
@@ -487,13 +478,8 @@ struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
 					 struct dentry *parent, void *data,
 					 const struct debugfs_short_fops *fops)
 {
-	if (WARN_ON((unsigned long)fops &
-		    DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
-		return ERR_PTR(-EINVAL);
-
 	return __debugfs_create_file(name, mode, parent, data,
-				fops ? &debugfs_full_short_proxy_file_operations :
-					&debugfs_noop_file_operations,
+				&debugfs_full_short_proxy_file_operations,
 				fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_short);
@@ -531,8 +517,7 @@ struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
 {
 
 	return __debugfs_create_file(name, mode, parent, data,
-				fops ? &debugfs_open_proxy_file_operations :
-					&debugfs_noop_file_operations,
+				&debugfs_open_proxy_file_operations,
 				fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
@@ -737,7 +722,7 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	 */
 	smp_mb();
 	fsd = READ_ONCE(dentry->d_fsdata);
-	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
+	if (!fsd)
 		return;
 
 	/* if this was the last reference, we're done */
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 011ef8b1a99a..8d2de647b42c 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -14,6 +14,9 @@ struct file_operations;
 struct debugfs_inode_info {
 	struct inode vfs_inode;
 	union {
+		const void *raw;
+		const struct file_operations *real_fops;
+		const struct debugfs_short_fops *short_fops;
 		debugfs_automount_t automount;
 	};
 };
@@ -51,15 +54,6 @@ enum {
 	HAS_IOCTL = 16
 };
 
-/*
- * A dentry's ->d_fsdata either points to the real fops or to a
- * dynamically allocated debugfs_fsdata instance.
- * In order to distinguish between these two cases, a real fops
- * pointer gets its lowest bit set.
- */
-#define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
-
-/* Access BITS */
 #define DEBUGFS_ALLOW_API	BIT(0)
 #define DEBUGFS_ALLOW_MOUNT	BIT(1)
 
-- 
2.39.5


