Return-Path: <linux-fsdevel+bounces-27124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5595EC6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EDA281560
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337741411F9;
	Mon, 26 Aug 2024 08:54:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BA13AD13;
	Mon, 26 Aug 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662439; cv=none; b=myJlGIWwpusd2DQcWZEyFW6hEe47k+1N8wgOVMD7Z6IQa6HRxVWmZwkrH+iFcvh5ej3CZH5j2e037X3gEyRIGs/ppufTsmrgHLQoZKlG50YeVUHfGc0DEIbw6+eRMMwDE7I0LLmIhBEpX0sXLuCZDv99W2bR328piHeWPSB506M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662439; c=relaxed/simple;
	bh=sI1qCOoTtmbLhdXjKls33+2XCU+q9RMlolYdMr6xePI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8eehV7L5mqUWNPGG50LgMxArBb+OU/gG3Exl+apI1amobUZUeGgX7isYg8bS84J6rESruVpLrhgk+jPltPu8GE34usE0aTTL6ZLKOdwZmEma1gx/vGqGWqbv/0N78uKoO4eNr2iJEx3cKjEuUQBvMqcBolRXJB7SxtxmcJyWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86c476f679so132801866b.1;
        Mon, 26 Aug 2024 01:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662436; x=1725267236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRehPbKKjFe/0bKTvYhCt52a7lrFhafkYozCw3nsWtY=;
        b=H0s9UWRM1au+LzwBlGbFrsklUH2ijEkETy2nSE8saL+8uPgaN4Y1Pmf1OIXiENXjJ+
         ptTHZ/Y9nDOGShExkh5wAFgjvVssCpLTRIyuJ5A3oWw7t1I+bxjX6UzyOA8yCcbA2KFk
         l0elyzwt6Xd9/xmI6Otr7OmYHZW2WOIZJSl+mOAa+bfbE0AuumPQj2/adJl3xOVFpFrE
         67UylSaG3B6WzkDnGwpJSCC9VDVbytsSVYngqSOnlApwlnesR3HjxetrYpxpJkrT4iB+
         Yhe5EDZZUpvPsgoxgM081raqfJQTO/Pzl4N7DsoyoWdqiLDRodaU4pzwOOnSKghNij5P
         1EvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKjsa/+jnc64u8eNxOhnFr0VQRUloJLEIem7YN1zmEXgL4IJYKLSj/uBbDYOcVbZoZSuDFPCBW0NP55o4MeA==@vger.kernel.org, AJvYcCVC6y2Q6s2zl1VEEpdeZu3P7CxfTMliORbbxXXdgHrYXmtrdrg9hWYuBIvZzoMQhvD7sT0LTdtddLqqbF1Y@vger.kernel.org, AJvYcCVjRRHov8BOoh0vY+9ACWwm8+c4WhOEj4OdVpbAnIcObaAG6vIq4fZSsXM2rFsypmrtQuIZPaIhUzWAF1KsHA==@vger.kernel.org, AJvYcCWiE9+SH2gYy0RAk0g5Y5vxYuMbcdyzZjbcxPyqNDX076W61KZP5Gi0cA0lOoxsmLdEe6BGd+j382n/3ALDiIx2M/xdlPNh@vger.kernel.org
X-Gm-Message-State: AOJu0YyigfUQ3PFrMfqD9xJUWFhBTeMB+H8VAVYE+u5YyeJQ3a/kCaWI
	jB/ZPoezkMHR6VKdrIKrwZx6yDVmQ7BQs13xK1FnmIOiN7PeRqx0/GNAjA==
X-Google-Smtp-Source: AGHT+IGg5DoRJLSlZ94fHIOZSVb3g7d20TrxkPLrpdD4iqZWcJSQeFk2/3ANrR2USPAvHF2BHuzCrg==
X-Received: by 2002:a17:906:6a0d:b0:a86:80ef:4fe5 with SMTP id a640c23a62f3a-a86a54b024dmr679657766b.47.1724662435694;
        Mon, 26 Aug 2024 01:53:55 -0700 (PDT)
Received: from localhost.localdomain ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f21fe18sm630636866b.29.2024.08.26.01.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:53:55 -0700 (PDT)
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
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Date: Mon, 26 Aug 2024 10:47:12 +0200
Message-ID: <20240826085347.1152675-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826085347.1152675-1-mhocko@kernel.org>
References: <20240826085347.1152675-1-mhocko@kernel.org>
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

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 fs/bcachefs/fs.c          | 14 ++++++--------
 fs/inode.c                |  6 +++---
 include/linux/fs.h        |  7 ++++++-
 include/linux/lsm_hooks.h |  2 +-
 include/linux/security.h  |  4 ++--
 security/security.c       |  8 ++++----
 6 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 15fc41e63b6c..7a55167b9133 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -231,9 +231,9 @@ static struct inode *bch2_alloc_inode(struct super_block *sb)
 	BUG();
 }
 
-static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
+static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c, gfp_t gfp)
 {
-	struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache, GFP_NOFS);
+	struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache, gfp);
 	if (!inode)
 		return NULL;
 
@@ -245,7 +245,7 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
 	mutex_init(&inode->ei_quota_lock);
 	memset(&inode->ei_devs_need_flush, 0, sizeof(inode->ei_devs_need_flush));
 
-	if (unlikely(inode_init_always(c->vfs_sb, &inode->v))) {
+	if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v), gfp)) {
 		kmem_cache_free(bch2_inode_cache, inode);
 		return NULL;
 	}
@@ -258,12 +258,10 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
  */
 static struct bch_inode_info *bch2_new_inode(struct btree_trans *trans)
 {
-	struct bch_inode_info *inode =
-		memalloc_flags_do(PF_MEMALLOC_NORECLAIM|PF_MEMALLOC_NOWARN,
-				  __bch2_new_inode(trans->c));
+	struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWARN | GFP_NOWAIT);
 
 	if (unlikely(!inode)) {
-		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c)) ? 0 : -ENOMEM);
+		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c, GFP_NOFS)) ? 0 : -ENOMEM);
 		if (ret && inode) {
 			__destroy_inode(&inode->v);
 			kmem_cache_free(bch2_inode_cache, inode);
@@ -328,7 +326,7 @@ __bch2_create(struct mnt_idmap *idmap,
 	if (ret)
 		return ERR_PTR(ret);
 #endif
-	inode = __bch2_new_inode(c);
+	inode = __bch2_new_inode(c, GFP_NOFS);
 	if (unlikely(!inode)) {
 		inode = ERR_PTR(-ENOMEM);
 		goto err;
diff --git a/fs/inode.c b/fs/inode.c
index 86670941884b..95fd67a6cac3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -153,7 +153,7 @@ static int no_open(struct inode *inode, struct file *file)
  * These are initializations that need to be done on every inode
  * allocation as the fields are not initialised by slab allocation.
  */
-int inode_init_always(struct super_block *sb, struct inode *inode)
+int inode_init_always(struct super_block *sb, struct inode *inode, gfp_t gfp)
 {
 	static const struct inode_operations empty_iops;
 	static const struct file_operations no_open_fops = {.open = no_open};
@@ -230,14 +230,14 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
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
index fd34b5755c0b..d46ca71a7855 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3027,7 +3027,12 @@ extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
 
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
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a2ade0ffe9e7..b08472d64765 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -150,6 +150,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 		__used __section(".early_lsm_info.init")		\
 		__aligned(sizeof(unsigned long))
 
-extern int lsm_inode_alloc(struct inode *inode);
+extern int lsm_inode_alloc(struct inode *inode, gfp_t gfp);
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 1390f1efb4f0..7c6b9b038a0d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -336,7 +336,7 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct cred *new);
 int security_path_notify(const struct path *path, u64 mask,
 					unsigned int obj_type);
-int security_inode_alloc(struct inode *inode);
+int security_inode_alloc(struct inode *inode, gfp_t gfp);
 void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
@@ -769,7 +769,7 @@ static inline int security_path_notify(const struct path *path, u64 mask,
 	return 0;
 }
 
-static inline int security_inode_alloc(struct inode *inode)
+static inline int security_inode_alloc(struct inode *inode, gfp_t gfp)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..3581262da5ee 100644
--- a/security/security.c
+++ b/security/security.c
@@ -660,14 +660,14 @@ static int lsm_file_alloc(struct file *file)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_inode_alloc(struct inode *inode)
+int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
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
@@ -1582,9 +1582,9 @@ int security_path_notify(const struct path *path, u64 mask,
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
2.46.0


