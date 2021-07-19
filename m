Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF13CD380
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhGSKaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhGSKaX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B71B5610FB;
        Mon, 19 Jul 2021 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693063;
        bh=B5eoBNW0x4lkDFlY32IvAsrLNWgNmdCuphxwahLGoE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgnWWfD/+CnweO6UQlJ09ikGdFHQq6jzBLa9Jso72l9XAVK95PTwaoUZf1UvZKC9t
         xR/vV0Uqp5VAsGyAZ5sybywKlZZ+CGu+5h1+yMPrcPP+MenizEpm+jYnuP0LDX44n9
         XPPUgJvHTMdDHpD0tJrJ3MdPHO7OnvHxF34278JODasN2ZdClShKtKAiiwrUZ1IR7S
         D8rM5dfBGVJMW5bKBJsGitk5exdmOTzFrxgJvGBSSQkBJaP71du0Wbqn2ONe76N0Ja
         6pN6dUmKr05f8pxCa5T0HInsRS7iIUWJxhPUZYFLz/VMuh1xAMq5SihepTKCF7kO0u
         0afy5XznQ6Ilg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/21] namei: add mapping aware lookup helper
Date:   Mon, 19 Jul 2021 13:10:32 +0200
Message-Id: <20210719111052.1626299-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4582; h=from:subject; bh=7bSgb7NEdlPbHqjtamXABcS39sKzhqLV9+DKcg49aY0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd08afEalcecs/c/PHvu/Yw/4jfdGb5fPdJ0yPjvqfJE 7yyjjI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJhNYz/DN+fqwmqtB4R5rQhtls7Y z5YgkvP/E1fdOZ/f/jPctuhTWMDH8Fs77PfvP03nKu2n0J9T4pE2QTGG8vVrtQ/viOxpbJhrwA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Various filesystems rely on the lookup_one_len() helper to lookup a single path
component relative to a well-known starting point. Allow such filesystems to
support idmapped mounts by adding a version of this helper to take the idmap
into account when calling inode_permission(). This change is a required to let
btrfs (and other filesystems) support idmapped mounts.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Al Viro <viro@zeniv.linux.org.uk>:
  - Add a new lookup helper instead of changing the old ones.
---
 fs/namei.c            | 44 +++++++++++++++++++++++++++++++++++++------
 include/linux/namei.h |  2 ++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf6d8a738c59..8f416698ee34 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2575,8 +2575,9 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_one_len_common(const char *name, struct dentry *base,
-				 int len, struct qstr *this)
+static int lookup_one_len_common(struct user_namespace *mnt_userns,
+				 const char *name, struct dentry *base, int len,
+				 struct qstr *this)
 {
 	this->name = name;
 	this->len = len;
@@ -2604,7 +2605,7 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
 			return err;
 	}
 
-	return inode_permission(&init_user_ns, base->d_inode, MAY_EXEC);
+	return inode_permission(mnt_userns, base->d_inode, MAY_EXEC);
 }
 
 /**
@@ -2628,7 +2629,7 @@ struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_len_common(name, base, len, &this);
+	err = lookup_one_len_common(&init_user_ns, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2655,7 +2656,7 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_len_common(name, base, len, &this);
+	err = lookup_one_len_common(&init_user_ns, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2664,6 +2665,37 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
 }
 EXPORT_SYMBOL(lookup_one_len);
 
+/**
+ * lookup_mapped_one_len - filesystem helper to lookup single pathname component
+ * @mnt_userns:	user namespace of the mount the lookup is performed from
+ * @name:	pathname component to lookup
+ * @base:	base directory to lookup from
+ * @len:	maximum length @len should be interpreted to
+ *
+ * Note that this routine is purely a helper for filesystem usage and should
+ * not be called by generic code.
+ *
+ * The caller must hold base->i_mutex.
+ */
+struct dentry *lookup_mapped_one_len(struct user_namespace *mnt_userns,
+				     const char *name, struct dentry *base,
+				     int len)
+{
+	struct dentry *dentry;
+	struct qstr this;
+	int err;
+
+	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
+
+	err = lookup_one_len_common(mnt_userns, name, base, len, &this);
+	if (err)
+		return ERR_PTR(err);
+
+	dentry = lookup_dcache(&this, base, 0);
+	return dentry ? dentry : __lookup_slow(&this, base, 0);
+}
+EXPORT_SYMBOL(lookup_mapped_one_len);
+
 /**
  * lookup_one_len_unlocked - filesystem helper to lookup single pathname component
  * @name:	pathname component to lookup
@@ -2683,7 +2715,7 @@ struct dentry *lookup_one_len_unlocked(const char *name,
 	int err;
 	struct dentry *ret;
 
-	err = lookup_one_len_common(name, base, len, &this);
+	err = lookup_one_len_common(&init_user_ns, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index be9a2b349ca7..fd9d22128df6 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -68,6 +68,8 @@ extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
+extern struct dentry *lookup_mapped_one_len(struct user_namespace *,
+					    const char *, struct dentry *, int);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);
-- 
2.30.2

