Return-Path: <linux-fsdevel+bounces-30195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972FA98784C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBAF28A179
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8F161901;
	Thu, 26 Sep 2024 17:29:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549515DBC1;
	Thu, 26 Sep 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371794; cv=none; b=WL/yrtsUfka3dL2iIs8rr3bLnEnAWZqdpT15LM9XK2RPnVjAiLHyhK46p+qLpaVpFvlwVZch5thmwVkCQsBjyCX8i2ADhB+ix1n729JjsrUNjro4rijkOQITIweoolRmwXzo5wH8OuhAh4FMAhaTgxdtxzxbxkAMpzzH4Wl95E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371794; c=relaxed/simple;
	bh=lljwcdBryAFpSL8DNu0QvRYEbpgZQZFozLuueB2OLIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMIt3vuXrdrOOeM00nQT875C7OxqDAQqHdefilHBFObQ2+67tVQjgWUIHht0I8mCUfQ12ZW/95xsgKMt84cTO+Jj29kWce4l8F2F6jB0rOrwP34uOQHrOf8IOT8Rt5Y+8u4YCQROgaUEReV5/oAwORE55E2eSuC0uJlCUHQB1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f66423686bso12893571fa.3;
        Thu, 26 Sep 2024 10:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727371790; x=1727976590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uh5VcWX6XVNjxZ0G2QghwWk3gmLuGFWmazxAIrTMtUY=;
        b=tRRGUcwgC4icV4IoIeZpwpgCB2nPP1OnXs7KXBoiBM05qpnTI3YgpVFU6/q2IHeWmu
         ejF87xFJTXs/5zYMQDxELmrJNjVnqbrqxLd5QmUi5tpnWrFY3GZcKE1wMm4gI34SAGPV
         diE/4jeEpHrK1HhBTWwLs5vQj62mFQPXYGRFYsLLibWts4luVwpqIoFLmtiCjqWpv4k4
         gsZERT5cPJB0npSkE9yz7Dj4Y/SoLSfMPU8RCMQpx9GNi7ECm7Ri13B8xgd+UkUASK4X
         cucRYEQ1B5L6rl7e2+VJc+Qbd+PDEIDYmkqT3FBgIUvlpNYeT0XcFyH4GEdMrZvAgcOY
         Y76g==
X-Forwarded-Encrypted: i=1; AJvYcCUqo+KQ+iewiWINBVvnqVgg4huM9oWVrAHxmno8h1sJiyGLvWRDwi/gULdXq59VgbxY5wI6gpiwC2z/7NQ7mN71OpE0ciNd@vger.kernel.org, AJvYcCV+qoNbhQN78Rd6PtX9ni8KJOIPPYvhkobNmvrFSa0+RVQx84pdzo54zoemr2v26SDn26ugIh804PcsegHv@vger.kernel.org, AJvYcCX5nXs4Abp4qffI5IhiKtcfO+5sDpByXSJl76HEfzmkqQ/Xt3c4EAm1DEGXu0jwaHvQny7cY5yPeqcpO11Tog==@vger.kernel.org, AJvYcCXN/dGWjmRR4oLYdn35rZ3BXc9teIa6UH6zgSmrV1qGM2puMg6Fd2+Qus5IfqAg8wgUpyw8ofbS5sT1FQFrsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCJqsKAN+iQm+MQ2gW7iyoXfHfGjTHZwWQ8/+kltwNq5Uclc2
	s31rmwJTGKnD6NAQwBljrdwg+RFhHmv5YHp6LYhca3Kp2fBALcAD
X-Google-Smtp-Source: AGHT+IE3aKb6s4PhYQSBb3iLsM1tDswQY0GD3K53dwSMyDvXCbEiaOa9yfIg/3I3/G+UKXBq0781pA==
X-Received: by 2002:a2e:a58b:0:b0:2f7:90b8:644e with SMTP id 38308e7fff4ca-2f9d3e3b954mr3349051fa.1.1727371790034;
        Thu, 26 Sep 2024 10:29:50 -0700 (PDT)
Received: from localhost.localdomain (109-81-81-255.rct.o2.cz. [109.81.81.255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245eb15sm145336a12.49.2024.09.26.10.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 10:29:49 -0700 (PDT)
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Date: Thu, 26 Sep 2024 19:11:50 +0200
Message-ID: <20240926172940.167084-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240926172940.167084-1-mhocko@kernel.org>
References: <20240926172940.167084-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Hocko <mhocko@suse.com>

bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
inode to achieve GFP_NOWAIT semantic while holding locks. If this
allocation fails it will drop locks and use GFP_NOFS allocation context.

We would like to drop PF_MEMALLOC_NORECLAIM because it is really
dangerous to use if the caller doesn't control the full call chain with
this flag set. E.g. if any of the function down the chain needed
GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
cause unexpected failure.

While this is not the case in this particular case using the scoped gfp
semantic is not really needed bacause we can easily pus the allocation
context down the chain without too much clutter.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz> # For vfs changes
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 fs/bcachefs/fs.c         | 14 ++++++--------
 fs/inode.c               | 10 ++++++----
 include/linux/fs.h       |  7 ++++++-
 include/linux/security.h |  4 ++--
 security/security.c      |  9 +++++----
 5 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 4a1bb07a2574..14f50490825f 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -291,10 +291,10 @@ static struct inode *bch2_alloc_inode(struct super_block *sb)
 	BUG();
 }
 
-static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
+static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c, gfp_t gfp)
 {
 	struct bch_inode_info *inode = alloc_inode_sb(c->vfs_sb,
-						bch2_inode_cache, GFP_NOFS);
+						bch2_inode_cache, gfp);
 	if (!inode)
 		return NULL;
 
@@ -306,7 +306,7 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
 	mutex_init(&inode->ei_quota_lock);
 	memset(&inode->ei_devs_need_flush, 0, sizeof(inode->ei_devs_need_flush));
 
-	if (unlikely(inode_init_always(c->vfs_sb, &inode->v))) {
+	if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v, gfp))) {
 		kmem_cache_free(bch2_inode_cache, inode);
 		return NULL;
 	}
@@ -319,12 +319,10 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
  */
 static struct bch_inode_info *bch2_new_inode(struct btree_trans *trans)
 {
-	struct bch_inode_info *inode =
-		memalloc_flags_do(PF_MEMALLOC_NORECLAIM|PF_MEMALLOC_NOWARN,
-				  __bch2_new_inode(trans->c));
+	struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWAIT);
 
 	if (unlikely(!inode)) {
-		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c)) ? 0 : -ENOMEM);
+		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c, GFP_NOFS)) ? 0 : -ENOMEM);
 		if (ret && inode) {
 			__destroy_inode(&inode->v);
 			kmem_cache_free(bch2_inode_cache, inode);
@@ -398,7 +396,7 @@ __bch2_create(struct mnt_idmap *idmap,
 	if (ret)
 		return ERR_PTR(ret);
 #endif
-	inode = __bch2_new_inode(c);
+	inode = __bch2_new_inode(c, GFP_NOFS);
 	if (unlikely(!inode)) {
 		inode = ERR_PTR(-ENOMEM);
 		goto err;
diff --git a/fs/inode.c b/fs/inode.c
index 471ae4a31549..8dabb224f941 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -146,14 +146,16 @@ static int no_open(struct inode *inode, struct file *file)
 }
 
 /**
- * inode_init_always - perform inode structure initialisation
+ * inode_init_always_gfp - perform inode structure initialisation
  * @sb: superblock inode belongs to
  * @inode: inode to initialise
+ * @gfp: allocation flags
  *
  * These are initializations that need to be done on every inode
  * allocation as the fields are not initialised by slab allocation.
+ * If there are additional allocations required @gfp is used.
  */
-int inode_init_always(struct super_block *sb, struct inode *inode)
+int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp)
 {
 	static const struct inode_operations empty_iops;
 	static const struct file_operations no_open_fops = {.open = no_open};
@@ -230,14 +232,14 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 #endif
 	inode->i_flctx = NULL;
 
-	if (unlikely(security_inode_alloc(inode)))
+	if (unlikely(security_inode_alloc(inode, gfp)))
 		return -ENOMEM;
 
 	this_cpu_inc(nr_inodes);
 
 	return 0;
 }
-EXPORT_SYMBOL(inode_init_always);
+EXPORT_SYMBOL(inode_init_always_gfp);
 
 void free_inode_nonrcu(struct inode *inode)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index eae5b67e4a15..c2d925235e6c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3082,7 +3082,12 @@ extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
 
 extern loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
 
-extern int inode_init_always(struct super_block *, struct inode *);
+extern int inode_init_always_gfp(struct super_block *, struct inode *, gfp_t);
+static inline int inode_init_always(struct super_block *sb, struct inode *inode)
+{
+	return inode_init_always_gfp(sb, inode, GFP_NOFS);
+}
+
 extern void inode_init_once(struct inode *);
 extern void address_space_init_once(struct address_space *mapping);
 extern struct inode * igrab(struct inode *);
diff --git a/include/linux/security.h b/include/linux/security.h
index b86ec2afc691..2ec8f3014757 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -348,7 +348,7 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct cred *new);
 int security_path_notify(const struct path *path, u64 mask,
 					unsigned int obj_type);
-int security_inode_alloc(struct inode *inode);
+int security_inode_alloc(struct inode *inode, gfp_t gfp);
 void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
@@ -789,7 +789,7 @@ static inline int security_path_notify(const struct path *path, u64 mask,
 	return 0;
 }
 
-static inline int security_inode_alloc(struct inode *inode)
+static inline int security_inode_alloc(struct inode *inode, gfp_t gfp)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 6875eb4a59fc..8947826cb756 100644
--- a/security/security.c
+++ b/security/security.c
@@ -745,14 +745,14 @@ static int lsm_file_alloc(struct file *file)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-static int lsm_inode_alloc(struct inode *inode)
+static int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
 {
 	if (!lsm_inode_cache) {
 		inode->i_security = NULL;
 		return 0;
 	}
 
-	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
+	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, gfp);
 	if (inode->i_security == NULL)
 		return -ENOMEM;
 	return 0;
@@ -1678,6 +1678,7 @@ int security_path_notify(const struct path *path, u64 mask,
 /**
  * security_inode_alloc() - Allocate an inode LSM blob
  * @inode: the inode
+ * #gfp: allocation flags
  *
  * Allocate and attach a security structure to @inode->i_security.  The
  * i_security field is initialized to NULL when the inode structure is
@@ -1685,9 +1686,9 @@ int security_path_notify(const struct path *path, u64 mask,
  *
  * Return: Return 0 if operation was successful.
  */
-int security_inode_alloc(struct inode *inode)
+int security_inode_alloc(struct inode *inode, gfp_t gfp)
 {
-	int rc = lsm_inode_alloc(inode);
+	int rc = lsm_inode_alloc(inode, gfp);
 
 	if (unlikely(rc))
 		return rc;
-- 
2.46.1


