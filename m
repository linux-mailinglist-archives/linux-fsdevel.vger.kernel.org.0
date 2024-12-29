Return-Path: <linux-fsdevel+bounces-38222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF69FDDF2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FCA1882663
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505CC8634F;
	Sun, 29 Dec 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AZM+WA+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BA33062
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459948; cv=none; b=Il/xaGQGTmLLZuxWNetTDbYNbvFPnEkrzA+c2KtNUj3xntmFhXGvIUGGTZOFRiaFT5YRJUyidMtn5FPTzGtUpcM3j+r7KZXOurgdLNtUvQRmiFQRGfU291WiKHq0/gUC5wjYog7UljwhBU70UqJWEzqgk/Wwyb4T3RerqMB75Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459948; c=relaxed/simple;
	bh=47PRUswGbQy2it053omrgbPH6Y+zRxCtRkS+7OiiGNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obOEUCSmg+3FKG0o40OUwzr76X0O6M5+aw4YVbv6xl4MPCT/iMD4aK3kwx0GJM2qusS4xpEWaVt//Oq10B7MJGm7ekGP5fEdTRjUZ0ck7AAICAEoKYKHytZc+ON87jlXZ+2GtZlBC6QaulVTFk4mZkU52SKmrGygHa2H0suV+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AZM+WA+F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=i6pHq6c34Iq9MEbCwr23FfwRrgGR96aOdQhbsWKzlow=; b=AZM+WA+Fx7ZzdKOUofq8x8XXrP
	K0p3gMq87kePHxJv9K/45xCYbbv6XxG1CQSFbdSRgq6UiEOa3e3FP1pRdAkkg1OGIohefyZ6iit6b
	VNdowjv/YO0jYdOH7UVfIYkbovVFjDT/86OGRZiZHz7+oN5KV5glSPVvbTVxmPrl1nkH6DrXN1nUa
	EQsMGNQexmfoDlHbD/Y2hP8e1ETcpgZj5Ao9jETQLS/fM4Ek4uRVirh1+t8aJ+0m5NHXFMfl5tgSZ
	GI7RvTWI0eOw1iaay/3i7FynO8etmWPkb5ObzPMOV8rXwHJh4rvfohFynkrj9na/EGb2GpOCs2lGB
	nHnhkykQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPP-0000000DOi4-3zA0;
	Sun, 29 Dec 2024 08:12:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 05/20] debugfs: don't mess with bits in ->d_fsdata
Date: Sun, 29 Dec 2024 08:12:08 +0000
Message-ID: <20241229081223.3193228-5-viro@zeniv.linux.org.uk>
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
 fs/debugfs/file.c     | 61 ++++++++++++++++++++++++++-----------------
 fs/debugfs/inode.c    | 34 ++++++------------------
 fs/debugfs/internal.h | 17 +++---------
 3 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 71e359f5f587..cb65ebc1a992 100644
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
@@ -93,19 +93,16 @@ int debugfs_file_get(struct dentry *dentry)
 		return -EINVAL;
 
 	d_fsd = READ_ONCE(dentry->d_fsdata);
-	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
+	if (d_fsd) {
 		fsd = d_fsd;
 	} else {
+		struct inode *inode = dentry->d_inode;
 		fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
 		if (!fsd)
 			return -ENOMEM;
-
-		if ((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT) {
+		if (dentry->d_inode->i_fop == &debugfs_short_proxy_file_operations) {
 			const struct debugfs_short_fops *ops;
-			ops = (void *)((unsigned long)d_fsd &
-					~(DEBUGFS_FSDATA_IS_REAL_FOPS_BIT |
-					  DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
-			fsd->short_fops = ops;
+			ops = fsd->short_fops = DEBUGFS_I(inode)->short_fops;
 			if (ops->llseek)
 				fsd->methods |= HAS_LSEEK;
 			if (ops->read)
@@ -114,9 +111,7 @@ int debugfs_file_get(struct dentry *dentry)
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
@@ -133,10 +128,11 @@ int debugfs_file_get(struct dentry *dentry)
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
 
@@ -213,8 +209,7 @@ void debugfs_enter_cancellation(struct file *file,
 		return;
 
 	fsd = READ_ONCE(dentry->d_fsdata);
-	if (WARN_ON(!fsd ||
-		    ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+	if (WARN_ON(!fsd))
 		return;
 
 	mutex_lock(&fsd->cancellations_mtx);
@@ -245,8 +240,7 @@ void debugfs_leave_cancellation(struct file *file,
 		return;
 
 	fsd = READ_ONCE(dentry->d_fsdata);
-	if (WARN_ON(!fsd ||
-		    ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+	if (WARN_ON(!fsd))
 		return;
 
 	mutex_lock(&fsd->cancellations_mtx);
@@ -414,7 +408,7 @@ static int full_proxy_release(struct inode *inode, struct file *filp)
 	 * not to leak any resources. Releasers must not assume that
 	 * ->i_private is still being meaningful here.
 	 */
-	if (real_fops && real_fops->release)
+	if (real_fops->release)
 		r = real_fops->release(inode, filp);
 
 	fops_put(real_fops);
@@ -438,7 +432,7 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 	if (r)
 		goto out;
 
-	if (real_fops && !fops_get(real_fops)) {
+	if (!fops_get(real_fops)) {
 #ifdef CONFIG_MODULES
 		if (real_fops->owner &&
 		    real_fops->owner->state == MODULE_STATE_GOING) {
@@ -454,11 +448,8 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
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
@@ -483,6 +474,28 @@ const struct file_operations debugfs_full_proxy_file_operations = {
 	.unlocked_ioctl = full_proxy_unlocked_ioctl
 };
 
+static int short_proxy_open(struct inode *inode, struct file *filp)
+{
+	struct dentry *dentry = F_DENTRY(filp);
+	int r;
+
+	r = debugfs_file_get(dentry);
+	if (r)
+		return r == -EIO ? -ENOENT : r;
+	r = debugfs_locked_down(inode, filp, NULL);
+	if (!r)
+		r = simple_open(inode, filp);
+	debugfs_file_put(dentry);
+	return r;
+}
+
+const struct file_operations debugfs_short_proxy_file_operations = {
+	.open = short_proxy_open,
+	.llseek = full_proxy_llseek,
+	.read = full_proxy_read,
+	.write = full_proxy_write,
+};
+
 ssize_t debugfs_attr_read(struct file *file, char __user *buf,
 			size_t len, loff_t *ppos)
 {
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 82155dc0bff3..590d77757c92 100644
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
@@ -472,14 +468,8 @@ struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const struct file_operations *fops)
 {
-	if (WARN_ON((unsigned long)fops &
-		    (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
-		     DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
-		return ERR_PTR(-EINVAL);
-
 	return __debugfs_create_file(name, mode, parent, data,
-				fops ? &debugfs_full_proxy_file_operations :
-					&debugfs_noop_file_operations,
+				&debugfs_full_proxy_file_operations,
 				fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_full);
@@ -488,16 +478,9 @@ struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
 					 struct dentry *parent, void *data,
 					 const struct debugfs_short_fops *fops)
 {
-	if (WARN_ON((unsigned long)fops &
-		    (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
-		     DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
-		return ERR_PTR(-EINVAL);
-
 	return __debugfs_create_file(name, mode, parent, data,
-				fops ? &debugfs_full_proxy_file_operations :
-					&debugfs_noop_file_operations,
-				(const void *)((unsigned long)fops |
-					       DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
+				&debugfs_short_proxy_file_operations,
+				fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_short);
 
@@ -534,8 +517,7 @@ struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
 {
 
 	return __debugfs_create_file(name, mode, parent, data,
-				fops ? &debugfs_open_proxy_file_operations :
-					&debugfs_noop_file_operations,
+				&debugfs_open_proxy_file_operations,
 				fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
@@ -740,7 +722,7 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	 */
 	smp_mb();
 	fsd = READ_ONCE(dentry->d_fsdata);
-	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
+	if (!fsd)
 		return;
 
 	/* if this was the last reference, we're done */
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 72f0034953b5..a168951a751a 100644
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
@@ -27,6 +30,7 @@ static inline struct debugfs_inode_info *DEBUGFS_I(struct inode *inode)
 extern const struct file_operations debugfs_noop_file_operations;
 extern const struct file_operations debugfs_open_proxy_file_operations;
 extern const struct file_operations debugfs_full_proxy_file_operations;
+extern const struct file_operations debugfs_short_proxy_file_operations;
 
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
@@ -50,19 +54,6 @@ enum {
 	HAS_IOCTL = 16
 };
 
-/*
- * A dentry's ->d_fsdata either points to the real fops or to a
- * dynamically allocated debugfs_fsdata instance.
- * In order to distinguish between these two cases, a real fops
- * pointer gets its lowest bit set.
- */
-#define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
-/*
- * A dentry's ->d_fsdata, when pointing to real fops, is with
- * short fops instead of full fops.
- */
-#define DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT BIT(1)
-
 /* Access BITS */
 #define DEBUGFS_ALLOW_API	BIT(0)
 #define DEBUGFS_ALLOW_MOUNT	BIT(1)
-- 
2.39.5


