Return-Path: <linux-fsdevel+bounces-24300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6DF93CFB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 10:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E961C221D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FADB178392;
	Fri, 26 Jul 2024 08:38:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8491178364;
	Fri, 26 Jul 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983089; cv=none; b=F6rDLlxaZSMCRom4REwYCo69G/8q+qjglVEQLdYBrh34NL/3MMh7ZE84Q/Ezub6Bbf2obuDi48Od9NHEKa8PM5mWAsAvtZFnowvh2/yQQuawEyDQrc426dGnJO6Twvt6fjbU5hVAQe87zFLnB+BPRDr/i6I16Bt0tOGFjP4W0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983089; c=relaxed/simple;
	bh=/hWhfMllA70pWRM2T6uiJE9KAXC26784Z2LWy9Tr0U8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEOvHZjHIx4eWA9JSe2uN4pDAugxyVX31CzpL9SzsYfnoqxDQ86F40pJ7olYi/6WnRVbWK8RRk8c7rvJi8POc6Tv9Amuh3EwcQYOL61RAAZKYoQYnlDUFvJw1obF2PllKdr8jO+MHn7Cv8eykrikK0WLR8Mv1MgZTn7JEc3sjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WVgy35N82z2ClN5;
	Fri, 26 Jul 2024 16:33:31 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 27825180042;
	Fri, 26 Jul 2024 16:37:59 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Jul
 2024 16:37:58 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] fuse: add support for no forget requests
Date: Fri, 26 Jul 2024 16:37:52 +0800
Message-ID: <20240726083752.302301-3-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240726083752.302301-1-yangyun50@huawei.com>
References: <20240726083752.302301-1-yangyun50@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 fs/fuse/dev.c             |  6 ++++++
 fs/fuse/dir.c             |  4 +---
 fs/fuse/fuse_i.h          | 24 ++++++++++++++++++++++++
 fs/fuse/inode.c           | 10 +++++-----
 fs/fuse/readdir.c         |  8 ++------
 include/uapi/linux/fuse.h |  3 +++
 6 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 932356833b0d..10890db9426b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -238,6 +238,9 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
+	if (fc->no_forget)
+		return;
+
 	forget->forget_one.nodeid = nodeid;
 	forget->forget_one.nlookup = nlookup;
 
@@ -257,6 +260,9 @@ void fuse_force_forget(struct fuse_mount *fm, u64 nodeid)
 	struct fuse_forget_in inarg;
 	FUSE_ARGS(args);
 
+	if (fm->fc->no_forget)
+		return;
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.nlookup = 1;
 	args.opcode = FUSE_FORGET;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 6bfb3a128658..833225ed1d4f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -236,9 +236,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 				fuse_force_forget(fm, outarg.nodeid);
 				goto invalid;
 			}
-			spin_lock(&fi->lock);
-			fi->nlookup++;
-			spin_unlock(&fi->lock);
+			fuse_nlookup_inc_if_enabled(fm->fc, fi);
 		}
 		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b9a5b8ec0de5..924d6b0ad700 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -860,6 +860,9 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/** Do not send FORGET request */
+	unsigned int no_forget:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -1029,6 +1032,27 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
 	rcu_read_unlock();
 }
 
+static inline void fuse_nlookup_inc_if_enabled(struct fuse_conn *fc, struct fuse_inode *fi)
+{
+	if (fc->no_forget)
+		return;
+
+	spin_lock(&fi->lock);
+	fi->nlookup++;
+	spin_unlock(&fi->lock);
+}
+
+static inline void fuse_nlookup_dec_if_enabled(struct fuse_conn *fc, struct fuse_inode *fi)
+{
+	if (fc->no_forget)
+		return;
+
+	spin_lock(&fi->lock);
+	fi->nlookup--;
+	spin_lock(&fi->lock);
+}
+
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..277dc9479505 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -483,9 +483,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		}
 	}
 	fi = get_fuse_inode(inode);
-	spin_lock(&fi->lock);
-	fi->nlookup++;
-	spin_unlock(&fi->lock);
+	fuse_nlookup_inc_if_enabled(fc, fi);
 done:
 	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
 
@@ -1331,6 +1329,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+			if (flags & FUSE_NO_FORGET_SUPPORT)
+				fc->no_forget = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1378,7 +1378,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_NO_FORGET_SUPPORT;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1593,7 +1593,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	 * that, though, so undo it here.
 	 */
 	fi = get_fuse_inode(root);
-	fi->nlookup--;
+	fuse_nlookup_dec_if_enabled(fm->fc, get_fuse_inode(root));
 
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 39f01ac31f7c..13922662e07a 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -218,9 +218,7 @@ static int fuse_direntplus_link(struct file *file,
 		}
 
 		fi = get_fuse_inode(inode);
-		spin_lock(&fi->lock);
-		fi->nlookup++;
-		spin_unlock(&fi->lock);
+		fuse_nlookup_inc_if_enabled(fc, fi);
 
 		forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &o->attr, NULL,
@@ -247,9 +245,7 @@ static int fuse_direntplus_link(struct file *file,
 			if (!IS_ERR(inode)) {
 				struct fuse_inode *fi = get_fuse_inode(inode);
 
-				spin_lock(&fi->lock);
-				fi->nlookup--;
-				spin_unlock(&fi->lock);
+				fuse_nlookup_dec_if_enabled(fc, fi);
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


