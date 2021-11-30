Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DED4633E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 13:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbhK3MOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 07:14:22 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36526 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbhK3MON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:14:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D9FCACE1870
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 12:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A9EC53FCD;
        Tue, 30 Nov 2021 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638274251;
        bh=MLiL8nGoAOq0haaFLjl21uP9MTvyXr/kKFDk7vn3T2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j15tAED1KCkG6z4/kAvpYyErfxz9K1UGQsBKNfuglVOlqcHCoZLRq1Y/3fR/AL8aH
         PiCDeymVb7witPSsB7ICmsAhjfGl4V5NcitdFUALOE6FfnOHW3DRX75BXwTXoodoAh
         ++3+gGIEVnoxleJaD9tThdav/WxumRk3k5qfVW/S7f/pGOXAZDj4lHsLbeOMnDOsa+
         kq1x4MkfoAu/WGSF8uEhYhOhsFA0g3Q4D8wict9lQ45ZqZjxL7tmtnMqmi4BhPl4w+
         kxkTJFF3DpdKHa7l4QHBdg/uPeeK6GK7AnWWBL+aznRgN9cG8G3yvQKOxe10f83pjA
         uNz+pX9TLJKzA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 01/10] fs: add is_idmapped_mnt() helper
Date:   Tue, 30 Nov 2021 13:10:23 +0100
Message-Id: <20211130121032.3753852-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130121032.3753852-1-brauner@kernel.org>
References: <20211130121032.3753852-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4760; h=from:subject; bh=Jhr19XJWOl5HFdB7VvVKH1dc2pE1uhAuVP1uatcCHdM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQuE1nh/rTnkbu1/X/jEL5DP79sFXl2nfmD6+7crQ0nND+9 e/Qms6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi57YxMmwtM966O/gv94Pq+DNcBd LrVpvs4zhsGOyRULfTOazX7CjD/xClJz3fM72PltWJ/3aUtrgcsX3RrKXJW0P3n1I6tqtVmQ8A
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

Link: https://lore.kernel.org/r/20211123114227.3124056-2-brauner@kernel.org (v1)
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Amir Goldstein <amir73il@gmail.com>:
  - s/is_mapped_mnt/is_idmapped_mnt/g
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
index d463d89f5db8..146291be6263 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -117,7 +117,7 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	root = path.dentry;
 
 	ret = -EINVAL;
-	if (mnt_user_ns(path.mnt) != &init_user_ns) {
+	if (is_idmapped_mnt(path.mnt)) {
 		pr_warn("File cache on idmapped mounts not supported");
 		goto error_unsupported;
 	}
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index d66bbd2df191..2dd23a82e0de 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -537,7 +537,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 		goto out_free;
 	}
 
-	if (mnt_user_ns(path.mnt) != &init_user_ns) {
+	if (is_idmapped_mnt(path.mnt)) {
 		rc = -EINVAL;
 		printk(KERN_ERR "Mounting on idmapped mounts currently disallowed\n");
 		goto out_free;
diff --git a/fs/namespace.c b/fs/namespace.c
index 659a8f39c61a..4994b816a74c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3936,7 +3936,7 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	 * mapping. It makes things simpler and callers can just create
 	 * another bind-mount they can idmap if they want to.
 	 */
-	if (mnt_user_ns(m) != &init_user_ns)
+	if (is_idmapped_mnt(m))
 		return -EPERM;
 
 	/* The underlying filesystem doesn't support idmapped mounts yet. */
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 9421dae22737..668c7527b17e 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -427,7 +427,7 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
 		return -EINVAL;
 	}
 
-	if (mnt_user_ns(path->mnt) != &init_user_ns) {
+	if (is_idmapped_mnt(path->mnt)) {
 		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
 		return -EINVAL;
 	}
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 265181c110ae..7bb0a47cb615 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -873,7 +873,7 @@ static int ovl_mount_dir_noesc(const char *name, struct path *path)
 		pr_err("filesystem on '%s' not supported\n", name);
 		goto out_put;
 	}
-	if (mnt_user_ns(path->mnt) != &init_user_ns) {
+	if (is_idmapped_mnt(path->mnt)) {
 		pr_err("idmapped layers are currently not supported\n");
 		goto out_put;
 	}
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 392ef5162655..49650e54d2f8 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -80,7 +80,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 			seq_puts(m, fs_infop->str);
 	}
 
-	if (mnt_user_ns(mnt) != &init_user_ns)
+	if (is_idmapped_mnt(mnt))
 		seq_puts(m, ",idmapped");
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cb616fc1105..426cc7bcbeb8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2725,6 +2725,20 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
 {
 	return mnt_user_ns(file->f_path.mnt);
 }
+
+/**
+ * is_idmapped_mnt - check whether a mount is mapped
+ * @mnt: the mount to check
+ *
+ * If @mnt has an idmapping attached to it @mnt is mapped.
+ *
+ * Return: true if mount is mapped, false if not.
+ */
+static inline bool is_idmapped_mnt(const struct vfsmount *mnt)
+{
+	return mnt_user_ns(mnt) != &init_user_ns;
+}
+
 extern long vfs_truncate(const struct path *, loff_t);
 int do_truncate(struct user_namespace *, struct dentry *, loff_t start,
 		unsigned int time_attrs, struct file *filp);
-- 
2.30.2

