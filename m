Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5214C3D577A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhGZJsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 05:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhGZJsY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3577A60F22;
        Mon, 26 Jul 2021 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295333;
        bh=Q65wTxj8papDGcJgc1J3joFcMnqpS0z8nz0sG+q3sxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2Q/4Rva/RhthB6gI3WyVPrWUJVPx67RSGyIOzspJjxIpyA16Os8henvyDWoLa3Y2
         QBzOm4QDF7TAzSXNw8SCdQxAEd9KBBHqsAlkfPDv1wfo5vOK9UlpaJ2X0hXVfOSfDq
         qJ3WjZeuaYFZ10Uw4V0FceBeGRmpGw8gMBG/r3MkgLUoh8g7/z0eOXBuqkN/UtIw7R
         HVuXafM6m5J7gejBj1jQvnidifG/OMxbUn7IQGF2inOBC0AOC6gYSyYWmgYz5k09eA
         nu3/GAXtWvSCGSe9suy/OiHuwudhSi5YWkDhbt5QmPne0dzNxuAne1HBlV1CQOUic0
         wsXzJWTKthviQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 01/21] namei: add mapping aware lookup helper
Date:   Mon, 26 Jul 2021 12:27:56 +0200
Message-Id: <20210726102816.612434-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4654; h=from:subject; bh=hz8lZ5Aw+HWLOcVYddCv6SoN2CluB8W6yBJZblizz5M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zNgN5p4SPBhTaJLwYlo178b658tbfY7sW7K2fcbFwWz HxD+2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRyysZ/rv80FPc993IZ+ehXGWZfO umjTIXtuWwhLv2/HhcyNqXv53hr0QjY6f0XN7D7mqqK9M5pxqlTsnbkD/HgfnZUr3K0rit/AA=
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Al Viro <viro@zeniv.linux.org.uk>:
  - Add a new lookup helper instead of changing the old ones.

/* v3 */
unchanged
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

