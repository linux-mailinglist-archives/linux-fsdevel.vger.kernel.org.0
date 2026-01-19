Return-Path: <linux-fsdevel+bounces-74411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EBFD3A1D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F0F9307A6BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9234166B;
	Mon, 19 Jan 2026 08:38:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89F1E32A2;
	Mon, 19 Jan 2026 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811892; cv=none; b=bAX4s3yduE7N1AxooSkOD5Lgny7c/+ygVPvX+f2KMnWYUqJ5fIVowa6wRBPbK+XczTBGVTDiTou9ySjeyzdpqjKvo8Kwe+gVHar0r6q8WQ1yYyXpL8oqdq7zblRd4IlZNOMvozpHBG00HxSmhlb+ZRUWYxaByRHvJ79k/5QOyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811892; c=relaxed/simple;
	bh=2cSfdHeedI/T42Za45EvNfauDrNmA1WD2QccVqafIMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwzgXSXJ4+sC9J/BsvpDgatk1HaauKRvzv5W2hPoDEi1OgKWWLhygFADbVbztwSmCoRTl5XG8Z8CKFRnTFt1pL7pie4FeLsHxTViKcOoIOpfKMth8AEfJyxow9g+Qfg6w8djWkNXAR8rQ0kx5pN3fSz+88m9FQLzVjtI32byk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3122c8158;
	Mon, 19 Jan 2026 16:38:06 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH v3 1/2] fuse: add ioctl to cleanup all backing files
Date: Mon, 19 Jan 2026 16:37:48 +0800
Message-ID: <20260119083750.2055-2-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119083750.2055-1-luochunsheng@ustc.edu>
References: <20260119083750.2055-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd56777bc03a2kunm42914fd4316265
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0wZVkJCShoYHh9OQhhLGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUlZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

To simplify crash recovery and reduce performance impact, backing_ids
are not persisted across daemon restarts. After crash recovery, this
may lead to resource leaks if backing file resources are not properly
cleaned up.

Add FUSE_DEV_IOC_BACKING_CLOSE_ALL ioctl to release all backing_ids
and put backing files. When the FUSE daemon restarts, it can use this
ioctl to cleanup all backing file resources.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 fs/fuse/backing.c         | 76 +++++++++++++++++++++++++++++++++++----
 fs/fuse/dev.c             | 16 +++++++++
 fs/fuse/fuse_i.h          |  5 +--
 fs/fuse/inode.c           | 11 +++---
 include/uapi/linux/fuse.h |  1 +
 5 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 4afda419dd14..31ad6a60a085 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -32,19 +32,29 @@ void fuse_backing_put(struct fuse_backing *fb)
 		fuse_backing_free(fb);
 }
 
-void fuse_backing_files_init(struct fuse_conn *fc)
+int fuse_backing_files_init(struct fuse_conn *fc)
 {
-	idr_init(&fc->backing_files_map);
+	struct idr *idr;
+
+	idr = kzalloc(sizeof(*idr), GFP_KERNEL);
+	if (!idr)
+		return -ENOMEM;
+	idr_init(idr);
+	rcu_assign_pointer(fc->backing_files_map, idr);
+	return 0;
 }
 
 static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
 {
+	struct idr *idr;
 	int id;
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&fc->lock);
+	idr = rcu_dereference_protected(fc->backing_files_map,
+					lockdep_is_held(&fc->lock));
 	/* FIXME: xarray might be space inefficient */
-	id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
+	id = idr_alloc_cyclic(idr, fb, 1, 0, GFP_ATOMIC);
 	spin_unlock(&fc->lock);
 	idr_preload_end();
 
@@ -55,10 +65,13 @@ static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
 static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
 						   int id)
 {
+	struct idr *idr;
 	struct fuse_backing *fb;
 
 	spin_lock(&fc->lock);
-	fb = idr_remove(&fc->backing_files_map, id);
+	idr = rcu_dereference_protected(fc->backing_files_map,
+					lockdep_is_held(&fc->lock));
+	fb = idr_remove(idr, id);
 	spin_unlock(&fc->lock);
 
 	return fb;
@@ -75,8 +88,13 @@ static int fuse_backing_id_free(int id, void *p, void *data)
 
 void fuse_backing_files_free(struct fuse_conn *fc)
 {
-	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
-	idr_destroy(&fc->backing_files_map);
+	struct idr *idr = rcu_dereference_protected(fc->backing_files_map, 1);
+
+	if (idr) {
+		idr_for_each(idr, fuse_backing_id_free, NULL);
+		idr_destroy(idr);
+		kfree(idr);
+	}
 }
 
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
@@ -166,12 +184,56 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 	return err;
 }
 
+int fuse_backing_close_all(struct fuse_conn *fc)
+{
+	struct idr *old_idr, *new_idr;
+	struct fuse_backing *fb;
+	int id;
+
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	new_idr = kzalloc(sizeof(*new_idr), GFP_KERNEL);
+	if (!new_idr)
+		return -ENOMEM;
+
+	idr_init(new_idr);
+
+	/*
+	 * Atomically exchange the old IDR with a new empty one under lock.
+	 * This avoids long lock hold times and races with concurrent
+	 * open/close operations.
+	 */
+	spin_lock(&fc->lock);
+	old_idr = rcu_replace_pointer(fc->backing_files_map, new_idr,
+				      lockdep_is_held(&fc->lock));
+	spin_unlock(&fc->lock);
+
+	/*
+	 * Ensure all concurrent RCU readers complete before releasing backing
+	 * files, so any in-flight lookups can safely take references.
+	 */
+	synchronize_rcu();
+
+	if (old_idr) {
+		idr_for_each_entry(old_idr, fb, id)
+			fuse_backing_put(fb);
+
+		idr_destroy(old_idr);
+		kfree(old_idr);
+	}
+
+	return 0;
+}
+
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
 {
+	struct idr *idr;
 	struct fuse_backing *fb;
 
 	rcu_read_lock();
-	fb = idr_find(&fc->backing_files_map, backing_id);
+	idr = rcu_dereference(fc->backing_files_map);
+	fb = idr ? idr_find(idr, backing_id) : NULL;
 	fb = fuse_backing_get(fb);
 	rcu_read_unlock();
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6..f05d55302598 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2654,6 +2654,19 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	return fuse_backing_close(fud->fc, backing_id);
 }
 
+static long fuse_dev_ioctl_backing_close_all(struct file *file)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
+
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		return -EOPNOTSUPP;
+
+	return fuse_backing_close_all(fud->fc);
+}
+
 static long fuse_dev_ioctl_sync_init(struct file *file)
 {
 	int err = -EINVAL;
@@ -2682,6 +2695,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
+	case FUSE_DEV_IOC_BACKING_CLOSE_ALL:
+		return fuse_dev_ioctl_backing_close_all(file);
+
 	case FUSE_DEV_IOC_SYNC_INIT:
 		return fuse_dev_ioctl_sync_init(file);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..f45c5042e31a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -979,7 +979,7 @@ struct fuse_conn {
 
 #ifdef CONFIG_FUSE_PASSTHROUGH
 	/** IDR for backing files ids */
-	struct idr backing_files_map;
+	struct idr __rcu *backing_files_map;
 #endif
 
 #ifdef CONFIG_FUSE_IO_URING
@@ -1569,10 +1569,11 @@ static inline struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
 }
 #endif
 
-void fuse_backing_files_init(struct fuse_conn *fc);
+int fuse_backing_files_init(struct fuse_conn *fc);
 void fuse_backing_files_free(struct fuse_conn *fc);
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
 int fuse_backing_close(struct fuse_conn *fc, int backing_id);
+int fuse_backing_close_all(struct fuse_conn *fc);
 
 /* passthrough.c */
 static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode *fi)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d66622..b63a067d50f8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1001,9 +1001,6 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
 
-	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
-		fuse_backing_files_init(fc);
-
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
@@ -1439,9 +1436,11 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			    arg->max_stack_depth > 0 &&
 			    arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH &&
 			    !(flags & FUSE_WRITEBACK_CACHE))  {
-				fc->passthrough = 1;
-				fc->max_stack_depth = arg->max_stack_depth;
-				fm->sb->s_stack_depth = arg->max_stack_depth;
+				if (fuse_backing_files_init(fc) == 0) {
+					fc->passthrough = 1;
+					fc->max_stack_depth = arg->max_stack_depth;
+					fm->sb->s_stack_depth = arg->max_stack_depth;
+				}
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..e4ff28a4ff40 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1139,6 +1139,7 @@ struct fuse_backing_map {
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
+#define FUSE_DEV_IOC_BACKING_CLOSE_ALL	_IO(FUSE_DEV_IOC_MAGIC, 4)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.41.0


