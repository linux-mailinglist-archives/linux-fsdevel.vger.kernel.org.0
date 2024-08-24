Return-Path: <linux-fsdevel+bounces-27025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A352C95DD2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD291C2140D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BA915DBBA;
	Sat, 24 Aug 2024 09:26:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3951153BD7;
	Sat, 24 Aug 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724491612; cv=none; b=QVFZ1NQ1/4J92Xf4RkHl5Nm7+gky1Onk2tIVRKR9p99xT7mOI60xr95Ij8eEnPu77oS30OvneSirhiV8Ff8HzSC9OmQFuqM9KFA7Y0znlC/2gfb8Ys2uUc+qozGQ84r4I0DPAVn26pxsjmIEHkhFHI+Mnu5nRJy4TR9h7VLSPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724491612; c=relaxed/simple;
	bh=7NGoICPxYTf1zWyf5Qgu/5OeHqKWWvm0Wiv8aeOWaqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2ri30TlXOF+bHophZMcIja6NkEOYJVjiiL6Tks8MPA8XqdjAiHaW8AnAr2PuF7SAviINex9++I29tQj8K6hyGsE4igQxiioFF9YEeQPnay8A0pt3fCVOKsqBvCNsUip+QdHM/472RqhlP8C6VWKPIP/yz3akOMwSbacCkm6wQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WrWjn3t14zhXZb;
	Sat, 24 Aug 2024 17:24:45 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D3AD140137;
	Sat, 24 Aug 2024 17:26:47 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 17:26:46 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lixiaokeng@huawei.com>
Subject: [PATCH v2 2/2] fuse: add support for no forget requests
Date: Sat, 24 Aug 2024 17:25:53 +0800
Message-ID: <20240824092553.730338-3-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240824092553.730338-1-yangyun50@huawei.com>
References: <20240824092553.730338-1-yangyun50@huawei.com>
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
But since FUSE_FORGET request does not have a reply from userspace,
we can not use ENOSYS to reflect the 'no_forget' assignment. So add
the FUSE_NO_FORGET_SUPPORT init flag.

Besides, if no_forget is enabled, 'nlookup' in 'struct fuse_inode'
does not used and its value change can be disabled which are protected
by spin_lock to reduce lock contention.

Signed-off-by: yangyun <yangyun50@huawei.com>
---
 fs/fuse/dev.c             |  6 +++++-
 fs/fuse/dir.c             |  4 +---
 fs/fuse/fuse_i.h          | 23 +++++++++++++++++++++++
 fs/fuse/inode.c           | 10 +++++-----
 fs/fuse/readdir.c         |  8 ++------
 include/uapi/linux/fuse.h |  3 +++
 6 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4b106db2f97f..449c29ef1bce 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -242,8 +242,12 @@ __releases(fiq->lock)
 void fuse_queue_forget(struct fuse_conn *fc, u64 nodeid, u64 nlookup)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
-	struct fuse_forget_link *forget = fuse_alloc_forget();
+	struct fuse_forget_link *forget;
 
+	if (fc->no_forget)
+		return;
+
+	forget = fuse_alloc_forget();
 	forget->forget_one.nodeid = nodeid;
 	forget->forget_one.nlookup = nlookup;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f070e380fd7b..2cbf96bb8022 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -236,9 +236,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 				fuse_queue_forget(fm->fc, outarg.nodeid, 1);
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
index 90176133209d..570decd4b8d6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -854,6 +854,9 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/** Is forget not implemented by fs? */
+	unsigned int no_forget:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -1023,6 +1026,26 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
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
index da3e5d4c032c..57fe1bbc9a83 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -458,9 +458,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		}
 	}
 	fi = get_fuse_inode(inode);
-	spin_lock(&fi->lock);
-	fi->nlookup++;
-	spin_unlock(&fi->lock);
+	fuse_inc_nlookup(fc, fi);
 done:
 	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
 
@@ -1306,6 +1304,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+			if (flags & FUSE_NO_FORGET_SUPPORT)
+				fc->no_forget = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1353,7 +1353,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_NO_FORGET_SUPPORT;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1568,7 +1568,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	 * that, though, so undo it here.
 	 */
 	fi = get_fuse_inode(root);
-	fi->nlookup--;
+	fuse_dec_nlookup(fm->fc, fi);
 
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 721fae563c84..6cda9b34a0e1 100644
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


