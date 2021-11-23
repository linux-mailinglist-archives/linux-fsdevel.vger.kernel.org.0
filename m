Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C04745A1C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhKWLqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhKWLp5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:45:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17006604D1;
        Tue, 23 Nov 2021 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637667769;
        bh=eDYWLoacrIiYU+DdVUwtlDVC1t/o0I9tt0WGcSZinJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AggQMmn3srzih7d4BG4PUT69n4A5wdKlN/ltNksuX2nNk2MziKYXWfRyHEmpP2hxX
         JyOuYmJHU+xGOnH0A2a/7IVhhJNHYvOa9O9pyqF23SXX8VcxhF5zdVYP4ORLjzoed0
         T1Y5e5jxCGSAFKi8WsvTV/TlVOrCgxOjgW5z2Qp5Wpiy9sopfQhDmciVSlcRPhlrM5
         b5EfO0nIN/moOq+YkgCC/k9M+9299fW4JZiewRdaenp0n/y3whef63WPDnK0ShkevM
         ExFvGa3vvkpfMZXGw3j1eT9HTFBwJv1JjhizBaZmyrhI5zSiVp+d1HUBrnXkw1euhO
         jlOkob1rVpR2A==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 01/10] fs: add is_mapped_mnt() helper
Date:   Tue, 23 Nov 2021 12:42:18 +0100
Message-Id: <20211123114227.3124056-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
References: <20211123114227.3124056-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4527; h=from:subject; bh=E6Fhc1ZBU9zBbB0af/1Zb4tZRcDPCL1SiNwHEUX+rVo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOuVx8QEho5tLtx/+bqOp2PZy9t6q922nXNqPOH9Fbkrgj kwzrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaieJiR4fXP9REeDPWTL7/l1y6Zsn fKu8QbV0KPBr182sLLvfnUeTWG/0E/ox5k7vjGHCji+E5OmKdRdlH5sZYXTjs5PdPS7N9bMwMA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Multiple places open-code the same check to determine whether a given
mount is idmapped. Introduce a simple helper function that can be used
instead. This allows us to get rid of the fragile open-coding. We will
later change the check that is used to determine whether a given mount
is idmapped. Introducing a helper allows us to do this in a single
place instead of doing it for multiple places.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/cachefiles/bind.c |  2 +-
 fs/ecryptfs/main.c   |  2 +-
 fs/namespace.c       |  2 +-
 fs/nfsd/export.c     |  2 +-
 fs/overlayfs/super.c |  2 +-
 fs/proc_namespace.c  |  2 +-
 include/linux/fs.h   | 14 ++++++++++++++
 7 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index d463d89f5db8..8130142d89c2 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -117,7 +117,7 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	root = path.dentry;
 
 	ret = -EINVAL;
-	if (mnt_user_ns(path.mnt) != &init_user_ns) {
+	if (is_mapped_mnt(path.mnt)) {
 		pr_warn("File cache on idmapped mounts not supported");
 		goto error_unsupported;
 	}
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index d66bbd2df191..331ac3a59515 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -537,7 +537,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 		goto out_free;
 	}
 
-	if (mnt_user_ns(path.mnt) != &init_user_ns) {
+	if (is_mapped_mnt(path.mnt)) {
 		rc = -EINVAL;
 		printk(KERN_ERR "Mounting on idmapped mounts currently disallowed\n");
 		goto out_free;
diff --git a/fs/namespace.c b/fs/namespace.c
index 659a8f39c61a..7d7b80b375a4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3936,7 +3936,7 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	 * mapping. It makes things simpler and callers can just create
 	 * another bind-mount they can idmap if they want to.
 	 */
-	if (mnt_user_ns(m) != &init_user_ns)
+	if (is_mapped_mnt(m))
 		return -EPERM;
 
 	/* The underlying filesystem doesn't support idmapped mounts yet. */
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 9421dae22737..292bde9e1eb3 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -427,7 +427,7 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
 		return -EINVAL;
 	}
 
-	if (mnt_user_ns(path->mnt) != &init_user_ns) {
+	if (is_mapped_mnt(path->mnt)) {
 		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
 		return -EINVAL;
 	}
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 265181c110ae..113575fc6155 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -873,7 +873,7 @@ static int ovl_mount_dir_noesc(const char *name, struct path *path)
 		pr_err("filesystem on '%s' not supported\n", name);
 		goto out_put;
 	}
-	if (mnt_user_ns(path->mnt) != &init_user_ns) {
+	if (is_mapped_mnt(path->mnt)) {
 		pr_err("idmapped layers are currently not supported\n");
 		goto out_put;
 	}
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 392ef5162655..788c687bb052 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -80,7 +80,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 			seq_puts(m, fs_infop->str);
 	}
 
-	if (mnt_user_ns(mnt) != &init_user_ns)
+	if (is_mapped_mnt(mnt))
 		seq_puts(m, ",idmapped");
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cb616fc1105..192242476b2b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2725,6 +2725,20 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
 {
 	return mnt_user_ns(file->f_path.mnt);
 }
+
+/**
+ * is_mapped_mnt - check whether a mount is mapped
+ * @mnt: the mount to check
+ *
+ * If @mnt has an idmapping attached to it @mnt is mapped.
+ *
+ * Return: true if mount is mapped, false if not.
+ */
+static inline bool is_mapped_mnt(const struct vfsmount *mnt)
+{
+	return mnt_user_ns(mnt) != &init_user_ns;
+}
+
 extern long vfs_truncate(const struct path *, loff_t);
 int do_truncate(struct user_namespace *, struct dentry *, loff_t start,
 		unsigned int time_attrs, struct file *filp);
-- 
2.30.2

