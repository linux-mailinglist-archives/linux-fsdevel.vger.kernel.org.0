Return-Path: <linux-fsdevel+bounces-27338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1579605BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E441F23398
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6D819EEA6;
	Tue, 27 Aug 2024 09:36:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993B19DF68;
	Tue, 27 Aug 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751365; cv=none; b=ej+HnagEp8+yjKqMTBtXtUmE7gTq7sZThlWEloXxOekcuT52ObQOyQCi+2zSPy/5T9N3JlX5GTh9DQcGG7Ymn9PPul7B8fi7xb2meRTfdyUlcGRsFRQ27hPBuD0Zp4W/hMU48/Xl8Mgl2HyR+lsXlXxfPGKfCWs3Qb1Bk7nwl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751365; c=relaxed/simple;
	bh=UKUT/e0oqRfWxV+jsjzmtFBvnIGKU9JLgLs3/DXdaAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9+IgzVkgiaZ1K/5a+Yk6kPzTLc/A9QUf/5yIK6txTFZ94Z2irMvA3UvLn4buA0AN4ZbL3Cq1Q61JzuhP4Xkrg1UavGNLzprxNIryi4xWrQN805/s7Bf+8ifS5K67dAqPXTUWanORmGQ5Cls9kf8KDyxOqbVZrFEYxt3NS7CMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtMpS65HGzyQYV;
	Tue, 27 Aug 2024 17:35:12 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id E3F13140137;
	Tue, 27 Aug 2024 17:35:59 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 17:35:59 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lixiaokeng@huawei.com>
Subject: [PATCH v3 2/2] fuse: add support for no forget requests
Date: Tue, 27 Aug 2024 17:35:03 +0800
Message-ID: <20240827093503.3397562-3-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240827093503.3397562-1-yangyun50@huawei.com>
References: <20240827093503.3397562-1-yangyun50@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100024.china.huawei.com (7.221.188.41)

FUSE_FORGET requests are not used if the fuse file system does not
implement the forget operation in userspace (e.g., fuse file system
does not cache any inodes).

However, the kernel is invisible to the userspace implementation and
always sends FUSE_FORGET requests, which can lead to performance
degradation because of useless contex switch and memory copy in some
cases (e.g., many inodes are evicted from icache which was described
in commit 07e77dca8a1f ("fuse: separate queue for FORGET requests")).

Just like 'no_interrupt' in 'struct fuse_conn', we add 'no_forget'.
But since FUSE_FORGET request does not have a reply from userspce,
we can not use ENOSYS to reflect the 'no_forget' assignment. So add
the FUSE_NO_FORGET_SUPPORT init flag.

Besides, if no_forget is enabled, 'nlookup' in 'struct fuse_inode'
does not used and its value change can be disabled which are protected
by spin_lock to reduce lock contention.

Signed-off-by: yangyun <yangyun50@huawei.com>
---
 fs/fuse/dev.c             |  3 +++
 fs/fuse/dir.c             |  4 +---
 fs/fuse/fuse_i.h          | 23 ++++++++++++++++++++
 fs/fuse/inode.c           | 46 +++++++++++++++++++++++----------------
 fs/fuse/readdir.c         |  8 ++-----
 include/uapi/linux/fuse.h |  3 +++
 6 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 31ca97b1b32c..7832f70baf65 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -238,6 +238,9 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
+	if (fc->no_forget)
+		return;
+
 	/*
 	 * The nullptr means that fuse_queue_forget() is used in error cases.
 	 * Avoid preallocating this structure because it is unlikely used.
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 583362492ce0..afc56c8ed7d6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -236,9 +236,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 				fuse_queue_forget(fm->fc, NULL, outarg.nodeid, 1);
 				goto invalid;
 			}
-			spin_lock(&fi->lock);
-			fi->nlookup++;
-			spin_unlock(&fi->lock);
+			fuse_inc_nlookup(fm->fc, fi);
 		}
 		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0b9a02b3155f..857357be5c8a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -859,6 +859,9 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/** Is forget not implemented by fs? */
+	unsigned int no_forget:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -1028,6 +1031,26 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
 	rcu_read_unlock();
 }
 
+static inline void fuse_inc_nlookup(struct fuse_conn *fc, struct fuse_inode *fi)
+{
+	if (fc->no_forget)
+		return;
+
+	spin_lock(&fi->lock);
+	fi->nlookup++;
+	spin_lock(&fi->lock);
+}
+
+static inline void fuse_dec_nlookup(struct fuse_conn *fc, struct fuse_inode *fi)
+{
+	if (fc->no_forget)
+		return;
+
+	spin_lock(&fi->lock);
+	fi->nlookup--;
+	spin_lock(&fi->lock);
+}
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ecc867e21acd..d2771ae515ea 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -84,6 +84,7 @@ static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
 static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
 	struct fuse_inode *fi;
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
 	fi = alloc_inode_sb(sb, fuse_inode_cachep, GFP_KERNEL);
 	if (!fi)
@@ -97,11 +98,14 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->orig_ino = 0;
 	fi->state = 0;
 	fi->submount_lookup = NULL;
+	fi->forget = NULL;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
-	fi->forget = fuse_alloc_forget(GFP_KERNEL_ACCOUNT);
-	if (!fi->forget)
-		goto out_free;
+	if (!fc->no_forget) {
+		fi->forget = fuse_alloc_forget(GFP_KERNEL_ACCOUNT);
+		if (!fi->forget)
+			goto out_free;
+	}
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX) && !fuse_dax_inode_alloc(sb, fi))
 		goto out_free_forget;
@@ -445,13 +449,15 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		fuse_init_inode(inode, attr, fc);
 		fi = get_fuse_inode(inode);
 		fi->nodeid = nodeid;
-		fi->submount_lookup = fuse_alloc_submount_lookup();
-		if (!fi->submount_lookup) {
-			iput(inode);
-			return NULL;
+		if (!fc->no_forget) {
+			fi->submount_lookup = fuse_alloc_submount_lookup();
+			if (!fi->submount_lookup) {
+				iput(inode);
+				return NULL;
+			}
+			/* Sets nlookup = 1 on fi->submount_lookup->nlookup */
+			fuse_init_submount_lookup(fi->submount_lookup, nodeid);
 		}
-		/* Sets nlookup = 1 on fi->submount_lookup->nlookup */
-		fuse_init_submount_lookup(fi->submount_lookup, nodeid);
 		inode->i_flags |= S_AUTOMOUNT;
 		goto done;
 	}
@@ -478,9 +484,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		}
 	}
 	fi = get_fuse_inode(inode);
-	spin_lock(&fi->lock);
-	fi->nlookup++;
-	spin_unlock(&fi->lock);
+	fuse_inc_nlookup(fc, fi);
 done:
 	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
 
@@ -1326,6 +1330,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+			if (flags & FUSE_NO_FORGET_SUPPORT)
+				fc->no_forget = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1373,7 +1379,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_NO_FORGET_SUPPORT;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1588,7 +1594,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	 * that, though, so undo it here.
 	 */
 	fi = get_fuse_inode(root);
-	fi->nlookup--;
+	fuse_dec_nlookup(fm->fc, fi);
 
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
@@ -1601,11 +1607,13 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	 * prevent the last forget for this nodeid from getting
 	 * triggered until all users have finished with it.
 	 */
-	sl = parent_fi->submount_lookup;
-	WARN_ON(!sl);
-	if (sl) {
-		refcount_inc(&sl->count);
-		fi->submount_lookup = sl;
+	if (!fm->fc->no_forget) {
+		sl = parent_fi->submount_lookup;
+		WARN_ON(!sl);
+		if (sl) {
+			refcount_inc(&sl->count);
+			fi->submount_lookup = sl;
+		}
 	}
 
 	return 0;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 70d161f420c6..4c8164d46409 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -218,9 +218,7 @@ static int fuse_direntplus_link(struct file *file,
 		}
 
 		fi = get_fuse_inode(inode);
-		spin_lock(&fi->lock);
-		fi->nlookup++;
-		spin_unlock(&fi->lock);
+		fuse_inc_nlookup(fc, fi);
 
 		forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &o->attr, NULL,
@@ -247,9 +245,7 @@ static int fuse_direntplus_link(struct file *file,
 			if (!IS_ERR(inode)) {
 				struct fuse_inode *fi = get_fuse_inode(inode);
 
-				spin_lock(&fi->lock);
-				fi->nlookup--;
-				spin_unlock(&fi->lock);
+				fuse_dec_nlookup(fc, fi);
 			}
 			return PTR_ERR(dentry);
 		}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..bf660880bc7a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,7 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *  - add FUSE_NO_FORGET_SUPPORT init flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -421,6 +422,7 @@ struct fuse_file_lock {
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and the high bit
  *		    of the request ID indicates resend requests
+ * FUSE_NO_FORGET_SUPPORT: disable forget requests
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -463,6 +465,7 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH	(1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
 #define FUSE_HAS_RESEND		(1ULL << 39)
+#define FUSE_NO_FORGET_SUPPORT  (1ULL << 40)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
-- 
2.33.0


