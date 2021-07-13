Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104983C6F3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhGMLSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235390AbhGMLSU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:18:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B4AB61284;
        Tue, 13 Jul 2021 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174930;
        bh=jfbIbTyMezX9eUfQmSzLH7TeEwmPEjP7Oxepa+6yAcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrkR9p8KNVc6cu7AY2H4b//CGNZIwin1Kye2UNeV2aZFi/aFNba2k6AghwnGIllxx
         aK/kaIyzs0EMii7zHX2ZLFyW/KrWv2405FQi9ogNMF66QNmMjAEnWQA6eAJzP6Ec5h
         81zN6hC8Xc651KvmARFaEhQ7Tab5Nj6GSBd+U/KXYVEf6ZhffyAgRS+AWeUQ0hgDwP
         TriNXARbt/XowijAyA65CPjxyxytkXdRAzlPOWUdy9pCVPUfXPVypPBPoc8quUtTkO
         AvpTAqHttmjtJ7JfgjVwGplQoP0POC95y9t6ANCBwQlkYL/mTQY0rXiTwWMJK0G78/
         DL/bZDywi6ztw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 02/24] namei: handle mappings in lookup_one_len_unlocked()
Date:   Tue, 13 Jul 2021 13:13:22 +0200
Message-Id: <20210713111344.1149376-3-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4542; h=from:subject; bh=ecm/BrL4GCunvk1nKO2IhmCgiKCJ9C8BgEZE8gY2tgc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LQ2f0qVwU03t0zPhmfuzL+3amf90zdwFe3+sDryszRy/ bveVQx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATcfRn+F++yH9P15ryaIawuxINHX f9Hm5elNW6JVLrlFuMldyHiw0M/0wvOf71fT1R0CrN/HvWQZ9wZ5eLfNNbvc95BlnMaHXawAUA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Various filesystems use the lookup_one_len_unlocked() helper to lookup a single
path component relative to a well-known starting point. Allow such filesystems
to support idmapped mounts by enabling lookup_one_len_unlocked() to take the
idmap into account when calling inode_permission().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ecryptfs/inode.c   | 3 ++-
 fs/exportfs/expfs.c   | 3 ++-
 fs/namei.c            | 9 +++++----
 fs/overlayfs/namei.c  | 3 ++-
 include/linux/namei.h | 3 ++-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 16d50dface59..755975a214a9 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -405,7 +405,8 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 		name = encrypted_and_encoded_name;
 	}
 
-	lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len);
+	lower_dentry = lookup_one_len_unlocked(&init_user_ns, name,
+					       lower_dir_dentry, len);
 	if (IS_ERR(lower_dentry)) {
 		ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
 				"[%ld] on lower_dentry = [%s]\n", __func__,
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 9ba408594094..0e35efba2bc5 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -145,7 +145,8 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	if (err)
 		goto out_err;
 	dprintk("%s: found name: %s\n", __func__, nbuf);
-	tmp = lookup_one_len_unlocked(nbuf, parent, strlen(nbuf));
+	tmp = lookup_one_len_unlocked(&init_user_ns, nbuf,
+				      parent, strlen(nbuf));
 	if (IS_ERR(tmp)) {
 		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
 		err = PTR_ERR(tmp);
diff --git a/fs/namei.c b/fs/namei.c
index 5a3e8188585e..53561311b492 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2679,14 +2679,15 @@ EXPORT_SYMBOL(lookup_one_len);
  * Unlike lookup_one_len, it should be called without the parent
  * i_mutex held, and will take the i_mutex itself if necessary.
  */
-struct dentry *lookup_one_len_unlocked(const char *name,
-				       struct dentry *base, int len)
+struct dentry *lookup_one_len_unlocked(struct user_namespace *mnt_userns,
+				       const char *name, struct dentry *base,
+				       int len)
 {
 	struct qstr this;
 	int err;
 	struct dentry *ret;
 
-	err = lookup_one_len_common(&init_user_ns, name, base, len, &this);
+	err = lookup_one_len_common(mnt_userns, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2708,7 +2709,7 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
 struct dentry *lookup_positive_unlocked(const char *name,
 				       struct dentry *base, int len)
 {
-	struct dentry *ret = lookup_one_len_unlocked(name, base, len);
+	struct dentry *ret = lookup_one_len_unlocked(&init_user_ns, name, base, len);
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		dput(ret);
 		ret = ERR_PTR(-ENOENT);
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 210cd6f66e28..291985b79a6d 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -202,7 +202,8 @@ static struct dentry *ovl_lookup_positive_unlocked(const char *name,
 						   struct dentry *base, int len,
 						   bool drop_negative)
 {
-	struct dentry *ret = lookup_one_len_unlocked(name, base, len);
+	struct dentry *ret = lookup_one_len_unlocked(&init_user_ns, name,
+						     base, len);
 
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		if (drop_negative && ret->d_lockref.count == 1) {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 7f8b58b43075..b4073e36450a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -67,7 +67,8 @@ extern struct dentry *kern_path_locked(const char *, struct path *);
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(struct user_namespace *mnt_userns,
 				     const char *, struct dentry *, int);
-extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
+extern struct dentry *lookup_one_len_unlocked(struct user_namespace *,
+					      const char *, struct dentry *, int);
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
 
 extern int follow_down_one(struct path *);
-- 
2.30.2

