Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5F1B2879
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgDUNvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 09:51:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56426 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728963AbgDUNvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587477109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEO79FtubqXMahKIwTgMnvnxLKfl/MCXROyTj0OBoJ0=;
        b=O5wzQD2Y5gIzc3ZEv9tbfnjuKSpCcQXH0r2Or4EpTLIgYb/VWCNHoaoSEhGuAyJijDa6gl
        m0DeOp7VSjyRZhZvdh7Aq2vFK32g8AWbbfxEQJcixT0MgIEeYqcuTQ21ajrRxo0YpwwRjn
        5/JIhf9rcIXcwdH/zYtMQRDDW2eI8+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-Y_K1clwUM2K9yVRDCs2zew-1; Tue, 21 Apr 2020 09:51:47 -0400
X-MC-Unique: Y_K1clwUM2K9yVRDCs2zew-1
Received: by mail-wm1-f70.google.com with SMTP id h184so1471559wmf.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 06:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEO79FtubqXMahKIwTgMnvnxLKfl/MCXROyTj0OBoJ0=;
        b=OqbRBQEETTkR1xeiZaluNCh9MAE4a62o+CSgUt28wssYJKenJMw9z31x77vCh11T/Q
         wfHDWYhD6s4XYggce+BPcxw1LdZPCjYkP0PjaV9R1cgUyiuyPdnaZhDu15+YK3s3wByW
         59psIaVHdI7lMM9/Xo43ZatpPgN+DnAT85Dd9nHGakX7IogZ3TRlO6sknJLNLgwvFcVF
         IrEVDNW2gCXAjcPQnIV65mjp9fYIB4Vqiu7XQ8IKmEhdvkzGvFo5R23+w+wJXx9BT9kJ
         nb80jo01akTqyooakd0PO78ZDWvYsq8PCVNDG2PCfu9qKOVu+BeN3yNMaCvzEL/ejT7o
         j/iA==
X-Gm-Message-State: AGi0Pubk9vf2RZJiENC9wrMKeGBYIUli70m2kkB2+TAoHR6P4EpsKz25
        UmswdZji+JSfzqPpDNd4cWWdOQDCj+rnitJlYcaPltkyaE+tofWtL3EACwPoqs272onTGzvc35V
        CH/O5WvOaYzuykwdLolm65YVrkQ==
X-Received: by 2002:a05:6000:114b:: with SMTP id d11mr11202391wrx.138.1587477104840;
        Tue, 21 Apr 2020 06:51:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypJsZggx2G3tX02r+CIpkhG0GKbStWvZ8dzSX+QBPAQPkgkEDhh7nt3yzU3c0QsyRLr3LyQW5w==
X-Received: by 2002:a05:6000:114b:: with SMTP id d11mr11202330wrx.138.1587477104368;
        Tue, 21 Apr 2020 06:51:44 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.194])
        by smtp.gmail.com with ESMTPSA id a187sm3565830wmh.40.2020.04.21.06.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:51:43 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 2/7] libfs: wrap simple_pin_fs/simple_release_fs arguments in a struct
Date:   Tue, 21 Apr 2020 15:51:14 +0200
Message-Id: <20200421135119.30007-3-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200421135119.30007-1-eesposit@redhat.com>
References: <20200421135119.30007-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify passing the count and mount to simple_pin_fs and
simple_release_fs by wrapping them in the simple_fs struct,
in preparation for adding more high level operations to
fs/libfs.c

There is no functional change intended.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 drivers/gpu/drm/drm_drv.c       | 11 ++++----
 drivers/misc/cxl/api.c          | 13 +++++-----
 drivers/scsi/cxlflash/ocxl_hw.c | 14 +++++-----
 fs/binfmt_misc.c                |  9 +++----
 fs/configfs/mount.c             | 10 +++-----
 fs/debugfs/inode.c              | 22 ++++++++--------
 fs/libfs.c                      | 45 +++++++++++++++++++++++++--------
 fs/tracefs/inode.c              | 18 ++++++-------
 include/linux/fs.h              | 10 ++++++--
 security/apparmor/apparmorfs.c  | 25 +++++++++---------
 security/inode.c                | 11 ++++----
 11 files changed, 103 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 7b1a628d1f6e..e29424d64874 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -514,8 +514,7 @@ EXPORT_SYMBOL(drm_dev_unplug);
  * iput(), but this way you'd end up with a new vfsmount for each inode.
  */
 
-static int drm_fs_cnt;
-static struct vfsmount *drm_fs_mnt;
+static struct simple_fs drm_fs;
 
 static int drm_fs_init_fs_context(struct fs_context *fc)
 {
@@ -534,15 +533,15 @@ static struct inode *drm_fs_inode_new(void)
 	struct inode *inode;
 	int r;
 
-	r = simple_pin_fs(&drm_fs_type, &drm_fs_mnt, &drm_fs_cnt);
+	r = simple_pin_fs(&drm_fs, &drm_fs_type);
 	if (r < 0) {
 		DRM_ERROR("Cannot mount pseudo fs: %d\n", r);
 		return ERR_PTR(r);
 	}
 
-	inode = alloc_anon_inode(drm_fs_mnt->mnt_sb);
+	inode = alloc_anon_inode(drm_fs.mount->mnt_sb);
 	if (IS_ERR(inode))
-		simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
+		simple_release_fs(&drm_fs);
 
 	return inode;
 }
@@ -551,7 +550,7 @@ static void drm_fs_inode_free(struct inode *inode)
 {
 	if (inode) {
 		iput(inode);
-		simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
+		simple_release_fs(&drm_fs);
 	}
 }
 
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index b493de962153..67e4808bce49 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -31,8 +31,7 @@
 
 #define CXL_PSEUDO_FS_MAGIC	0x1697697f
 
-static int cxl_fs_cnt;
-static struct vfsmount *cxl_vfs_mount;
+static struct simple_fs cxl_fs;
 
 static int cxl_fs_init_fs_context(struct fs_context *fc)
 {
@@ -50,7 +49,7 @@ static struct file_system_type cxl_fs_type = {
 void cxl_release_mapping(struct cxl_context *ctx)
 {
 	if (ctx->kernelapi && ctx->mapping)
-		simple_release_fs(&cxl_vfs_mount, &cxl_fs_cnt);
+		simple_release_fs(&cxl_fs);
 }
 
 static struct file *cxl_getfile(const char *name,
@@ -66,20 +65,20 @@ static struct file *cxl_getfile(const char *name,
 	if (fops->owner && !try_module_get(fops->owner))
 		return ERR_PTR(-ENOENT);
 
-	rc = simple_pin_fs(&cxl_fs_type, &cxl_vfs_mount, &cxl_fs_cnt);
+	rc = simple_pin_fs(&cxl_fs, &cxl_fs_type);
 	if (rc < 0) {
 		pr_err("Cannot mount cxl pseudo filesystem: %d\n", rc);
 		file = ERR_PTR(rc);
 		goto err_module;
 	}
 
-	inode = alloc_anon_inode(cxl_vfs_mount->mnt_sb);
+	inode = alloc_anon_inode(cxl_fs.mount->mnt_sb);
 	if (IS_ERR(inode)) {
 		file = ERR_CAST(inode);
 		goto err_fs;
 	}
 
-	file = alloc_file_pseudo(inode, cxl_vfs_mount, name,
+	file = alloc_file_pseudo(inode, cxl_fs.mount, name,
 				 flags & (O_ACCMODE | O_NONBLOCK), fops);
 	if (IS_ERR(file))
 		goto err_inode;
@@ -91,7 +90,7 @@ static struct file *cxl_getfile(const char *name,
 err_inode:
 	iput(inode);
 err_fs:
-	simple_release_fs(&cxl_vfs_mount, &cxl_fs_cnt);
+	simple_release_fs(&cxl_fs);
 err_module:
 	module_put(fops->owner);
 	return file;
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 7018cd802569..7fa98dd4fa28 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -29,8 +29,7 @@
 
 #define OCXLFLASH_FS_MAGIC      0x1697698f
 
-static int ocxlflash_fs_cnt;
-static struct vfsmount *ocxlflash_vfs_mount;
+static struct simple_fs ocxlflash_fs;
 
 static int ocxlflash_fs_init_fs_context(struct fs_context *fc)
 {
@@ -51,7 +50,7 @@ static struct file_system_type ocxlflash_fs_type = {
 static void ocxlflash_release_mapping(struct ocxlflash_context *ctx)
 {
 	if (ctx->mapping)
-		simple_release_fs(&ocxlflash_vfs_mount, &ocxlflash_fs_cnt);
+		simple_release_fs(&ocxlflash_fs);
 	ctx->mapping = NULL;
 }
 
@@ -79,15 +78,14 @@ static struct file *ocxlflash_getfile(struct device *dev, const char *name,
 		goto err1;
 	}
 
-	rc = simple_pin_fs(&ocxlflash_fs_type, &ocxlflash_vfs_mount,
-			   &ocxlflash_fs_cnt);
+	rc = simple_pin_fs(&ocxlflash_fs, &ocxlflash_fs_type);
 	if (unlikely(rc < 0)) {
 		dev_err(dev, "%s: Cannot mount ocxlflash pseudofs rc=%d\n",
 			__func__, rc);
 		goto err2;
 	}
 
-	inode = alloc_anon_inode(ocxlflash_vfs_mount->mnt_sb);
+	inode = alloc_anon_inode(ocxlflash_fs.mount->mnt_sb);
 	if (IS_ERR(inode)) {
 		rc = PTR_ERR(inode);
 		dev_err(dev, "%s: alloc_anon_inode failed rc=%d\n",
@@ -95,7 +93,7 @@ static struct file *ocxlflash_getfile(struct device *dev, const char *name,
 		goto err3;
 	}
 
-	file = alloc_file_pseudo(inode, ocxlflash_vfs_mount, name,
+	file = alloc_file_pseudo(inode, ocxlflash_fs.mount, name,
 				 flags & (O_ACCMODE | O_NONBLOCK), fops);
 	if (IS_ERR(file)) {
 		rc = PTR_ERR(file);
@@ -110,7 +108,7 @@ static struct file *ocxlflash_getfile(struct device *dev, const char *name,
 err4:
 	iput(inode);
 err3:
-	simple_release_fs(&ocxlflash_vfs_mount, &ocxlflash_fs_cnt);
+	simple_release_fs(&ocxlflash_fs);
 err2:
 	module_put(fops->owner);
 err1:
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index cdb45829354d..3cff446f222b 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -64,8 +64,7 @@ typedef struct {
 
 static DEFINE_RWLOCK(entries_lock);
 static struct file_system_type bm_fs_type;
-static struct vfsmount *bm_mnt;
-static int entry_count;
+static struct simple_fs bm_fs;
 
 /*
  * Max length of the register string.  Determined by:
@@ -623,7 +622,7 @@ static void kill_node(Node *e)
 	drop_nlink(d_inode(dentry));
 	d_drop(dentry);
 	dput(dentry);
-	simple_release_fs(&bm_mnt, &entry_count);
+	simple_release_fs(&bm_fs);
 }
 
 /* /<entry> */
@@ -718,7 +717,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	if (!inode)
 		goto out2;
 
-	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
+	err = simple_pin_fs(&bm_fs, &bm_fs_type);
 	if (err) {
 		iput(inode);
 		inode = NULL;
@@ -732,7 +731,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		if (IS_ERR(f)) {
 			err = PTR_ERR(f);
 			pr_notice("register: failed to install interpreter file %s\n", e->interpreter);
-			simple_release_fs(&bm_mnt, &entry_count);
+			simple_release_fs(&bm_fs);
 			iput(inode);
 			inode = NULL;
 			goto out2;
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 0c6e8cf61953..9fb2791e5eed 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -24,9 +24,8 @@
 /* Random magic number */
 #define CONFIGFS_MAGIC 0x62656570
 
-static struct vfsmount *configfs_mount = NULL;
+static struct simple_fs configfs_fs;
 struct kmem_cache *configfs_dir_cachep;
-static int configfs_mnt_count = 0;
 
 
 static void configfs_free_inode(struct inode *inode)
@@ -123,14 +122,13 @@ MODULE_ALIAS_FS("configfs");
 
 struct dentry *configfs_pin_fs(void)
 {
-	int err = simple_pin_fs(&configfs_fs_type, &configfs_mount,
-			     &configfs_mnt_count);
-	return err ? ERR_PTR(err) : configfs_mount->mnt_root;
+	int err = simple_pin_fs(&configfs_fs, &configfs_fs_type);
+	return err ? ERR_PTR(err) : configfs_fs.mount->mnt_root;
 }
 
 void configfs_release_fs(void)
 {
-	simple_release_fs(&configfs_mount, &configfs_mnt_count);
+	simple_release_fs(&configfs_fs);
 }
 
 
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index b7f2e971ecbc..5dbb74a23e7c 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -32,8 +32,7 @@
 
 #define DEBUGFS_DEFAULT_MODE	0700
 
-static struct vfsmount *debugfs_mount;
-static int debugfs_mount_count;
+static struct simple_fs debugfs;
 static bool debugfs_registered;
 
 /*
@@ -297,7 +296,7 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 		return NULL;
 
 	if (!parent)
-		parent = debugfs_mount->mnt_root;
+		parent = debugfs.mount->mnt_root;
 
 	dentry = lookup_positive_unlocked(name, parent, strlen(name));
 	if (IS_ERR(dentry))
@@ -316,8 +315,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	if (IS_ERR(parent))
 		return parent;
 
-	error = simple_pin_fs(&debug_fs_type, &debugfs_mount,
-			      &debugfs_mount_count);
+	error = simple_pin_fs(&debugfs, &debug_fs_type);
 	if (error) {
 		pr_err("Unable to pin filesystem for file '%s'\n", name);
 		return ERR_PTR(error);
@@ -329,7 +327,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	 * have around.
 	 */
 	if (!parent)
-		parent = debugfs_mount->mnt_root;
+		parent = debugfs.mount->mnt_root;
 
 	inode_lock(d_inode(parent));
 	if (unlikely(IS_DEADDIR(d_inode(parent))))
@@ -349,7 +347,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 
 	if (IS_ERR(dentry)) {
 		inode_unlock(d_inode(parent));
-		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
+		simple_release_fs(&debugfs);
 	}
 
 	return dentry;
@@ -359,7 +357,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
-	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
+	simple_release_fs(&debugfs);
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -676,9 +674,9 @@ static void __debugfs_file_removed(struct dentry *dentry)
 
 static void remove_one(struct dentry *victim)
 {
-        if (d_is_reg(victim))
+	if (d_is_reg(victim))
 		__debugfs_file_removed(victim);
-	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
+	simple_release_fs(&debugfs);
 }
 
 /**
@@ -699,9 +697,9 @@ void debugfs_remove(struct dentry *dentry)
 	if (IS_ERR_OR_NULL(dentry))
 		return;
 
-	simple_pin_fs(&debug_fs_type, &debugfs_mount, &debugfs_mount_count);
+	simple_pin_fs(&debugfs, &debug_fs_type);
 	simple_recursive_removal(dentry, remove_one);
-	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
+	simple_release_fs(&debugfs);
 }
 EXPORT_SYMBOL_GPL(debugfs_remove);
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 3759fbacf522..54e07ae986ca 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -665,39 +665,64 @@ EXPORT_SYMBOL(simple_fill_super);
 
 static DEFINE_SPINLOCK(pin_fs_lock);
 
-int simple_pin_fs(struct file_system_type *type, struct vfsmount **mount, int *count)
+/**
+ * simple_pin_fs - generic function to pin (mount if needed,
+ *                otherwise add a reference to the mount) a filesystem
+ * @fs: a pointer to a the simple_fs struct containing a struct vfs_mount
+ *      pointer (that can be NULL) and a counter.
+ * @type: a pointer to the file system type used by vfs_kern_mount.
+ *
+ * This function sets fs->mount if NULL, by calling vfs_kern_mount
+ * on @type.
+ * It also takes care of incrementing the reference counter.
+ *
+ * This function will return 0 in case of success, and PTR_ERR(-ERROR)
+ * if vfs_kern_mount fails.
+ **/
+int simple_pin_fs(struct simple_fs *fs, struct file_system_type *type)
 {
 	struct vfsmount *mnt = NULL;
 	spin_lock(&pin_fs_lock);
-	if (unlikely(!*mount)) {
+	if (unlikely(!fs->mount)) {
 		spin_unlock(&pin_fs_lock);
 		mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
 		if (IS_ERR(mnt))
 			return PTR_ERR(mnt);
 		spin_lock(&pin_fs_lock);
-		if (!*mount)
-			*mount = mnt;
+		if (!fs->mount)
+			fs->mount = mnt;
 	}
-	mntget(*mount);
-	++*count;
+	mntget(fs->mount);
+	++fs->count;
 	spin_unlock(&pin_fs_lock);
 	mntput(mnt);
 	return 0;
 }
 EXPORT_SYMBOL(simple_pin_fs);
 
-void simple_release_fs(struct vfsmount **mount, int *count)
+/**
+ * simple_release_fs - decrements the reference counter and unmounts the
+ *                    file system.
+ * @fs: a pointer to a struct simple_fs containing the reference counter
+ *      and vfs_mount pointer
+ *
+ * This function decrements the refcount of the given file system and
+ * if 0 sets the mount pointer to NULL.
+ **/
+void simple_release_fs(struct simple_fs *fs)
 {
 	struct vfsmount *mnt;
 	spin_lock(&pin_fs_lock);
-	mnt = *mount;
-	if (!--*count)
-		*mount = NULL;
+	mnt = fs->mount;
+	if (!--fs->count)
+		fs->mount = NULL;
 	spin_unlock(&pin_fs_lock);
 	mntput(mnt);
 }
 EXPORT_SYMBOL(simple_release_fs);
 
+
+
 /**
  * simple_read_from_buffer - copy data from the buffer to user space
  * @to: the user space buffer to read to
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 0ee8c6dfb036..370eb38ff1ad 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -24,8 +24,7 @@
 
 #define TRACEFS_DEFAULT_MODE	0700
 
-static struct vfsmount *tracefs_mount;
-static int tracefs_mount_count;
+static struct simple_fs tracefs;
 static bool tracefs_registered;
 
 static ssize_t default_read_file(struct file *file, char __user *buf,
@@ -316,8 +315,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 
 	pr_debug("tracefs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
-			      &tracefs_mount_count);
+	error = simple_pin_fs(&tracefs, &trace_fs_type);
 	if (error)
 		return ERR_PTR(error);
 
@@ -327,7 +325,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	 * have around.
 	 */
 	if (!parent)
-		parent = tracefs_mount->mnt_root;
+		parent = tracefs.mount->mnt_root;
 
 	inode_lock(parent->d_inode);
 	if (unlikely(IS_DEADDIR(parent->d_inode)))
@@ -341,7 +339,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 
 	if (IS_ERR(dentry)) {
 		inode_unlock(parent->d_inode);
-		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+		simple_release_fs(&tracefs);
 	}
 
 	return dentry;
@@ -351,7 +349,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 {
 	inode_unlock(dentry->d_parent->d_inode);
 	dput(dentry);
-	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	simple_release_fs(&tracefs);
 	return NULL;
 }
 
@@ -504,7 +502,7 @@ __init struct dentry *tracefs_create_instance_dir(const char *name,
 
 static void remove_one(struct dentry *victim)
 {
-	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	simple_release_fs(&tracefs);
 }
 
 /**
@@ -520,9 +518,9 @@ void tracefs_remove(struct dentry *dentry)
 	if (IS_ERR_OR_NULL(dentry))
 		return;
 
-	simple_pin_fs(&trace_fs_type, &tracefs_mount, &tracefs_mount_count);
+	simple_pin_fs(&tracefs, &trace_fs_type);
 	simple_recursive_removal(dentry, remove_one);
-	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	simple_release_fs(&tracefs);
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..a3691c132b3a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3363,8 +3363,14 @@ struct tree_descr { const char *name; const struct file_operations *ops; int mod
 struct dentry *d_alloc_name(struct dentry *, const char *);
 extern int simple_fill_super(struct super_block *, unsigned long,
 			     const struct tree_descr *);
-extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int *count);
-extern void simple_release_fs(struct vfsmount **mount, int *count);
+
+struct simple_fs {
+	struct vfsmount *mount;
+	int count;
+};
+
+extern int simple_pin_fs(struct simple_fs *, struct file_system_type *);
+extern void simple_release_fs(struct simple_fs *);
 
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 36f848734902..00f0158fb1e1 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -140,8 +140,7 @@ static int mangle_name(const char *name, char *target)
  */
 
 #define AAFS_NAME		"apparmorfs"
-static struct vfsmount *aafs_mnt;
-static int aafs_count;
+static struct simple_fs aafs;
 
 
 static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
@@ -273,7 +272,7 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
 	if (!(mode & S_IFMT))
 		mode = (mode & S_IALLUGO) | S_IFREG;
 
-	error = simple_pin_fs(&aafs_ops, &aafs_mnt, &aafs_count);
+	error = simple_pin_fs(&aafs, &aafs_ops);
 	if (error)
 		return ERR_PTR(error);
 
@@ -303,7 +302,7 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
 
 fail_lock:
 	inode_unlock(dir);
-	simple_release_fs(&aafs_mnt, &aafs_count);
+	simple_release_fs(&aafs);
 
 	return ERR_PTR(error);
 }
@@ -395,7 +394,7 @@ static void aafs_remove(struct dentry *dentry)
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&aafs_mnt, &aafs_count);
+	simple_release_fs(&aafs);
 }
 
 
@@ -1824,7 +1823,7 @@ static int ns_mkdir_op(struct inode *dir, struct dentry *dentry, umode_t mode)
 	 * for pin_fs
 	 */
 	inode_unlock(dir);
-	error = simple_pin_fs(&aafs_ops, &aafs_mnt, &aafs_count);
+	error = simple_pin_fs(&aafs, &aafs_ops);
 	mutex_lock_nested(&parent->lock, parent->level);
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 	if (error)
@@ -1845,7 +1844,7 @@ static int ns_mkdir_op(struct inode *dir, struct dentry *dentry, umode_t mode)
 	aa_put_ns(ns);		/* list ref remains */
 out_pin:
 	if (error)
-		simple_release_fs(&aafs_mnt, &aafs_count);
+		simple_release_fs(&aafs);
 out:
 	mutex_unlock(&parent->lock);
 	aa_put_ns(parent);
@@ -2580,7 +2579,7 @@ static const char *policy_get_link(struct dentry *dentry,
 		return ERR_PTR(-ECHILD);
 
 	ns = aa_get_current_ns();
-	path.mnt = mntget(aafs_mnt);
+	path.mnt = mntget(aafs.mount);
 	path.dentry = dget(ns_dir(ns));
 	error = nd_jump_link(&path);
 	aa_put_ns(ns);
@@ -2631,10 +2630,10 @@ static int __init aa_create_aafs(void)
 	}
 
 	/* setup apparmorfs used to virtualize policy/ */
-	aafs_mnt = kern_mount(&aafs_ops);
-	if (IS_ERR(aafs_mnt))
+	aafs.mount = kern_mount(&aafs_ops);
+	if (IS_ERR(aafs.mount))
 		panic("can't set apparmorfs up\n");
-	aafs_mnt->mnt_sb->s_flags &= ~SB_NOUSER;
+	aafs.mount->mnt_sb->s_flags &= ~SB_NOUSER;
 
 	/* Populate fs tree. */
 	error = entry_create_dir(&aa_sfs_entry, NULL);
@@ -2667,8 +2666,8 @@ static int __init aa_create_aafs(void)
 
 	/* policy tree referenced by magic policy symlink */
 	mutex_lock_nested(&root_ns->lock, root_ns->level);
-	error = __aafs_ns_mkdir(root_ns, aafs_mnt->mnt_root, ".policy",
-				aafs_mnt->mnt_root);
+	error = __aafs_ns_mkdir(root_ns, aafs.mount->mnt_root, ".policy",
+				aafs.mount->mnt_root);
 	mutex_unlock(&root_ns->lock);
 	if (error)
 		goto error;
diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..8a1bee35470a 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,8 +22,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 
-static struct vfsmount *mount;
-static int mount_count;
+static struct simple_fs securityfs;
 
 static void securityfs_free_inode(struct inode *inode)
 {
@@ -118,12 +117,12 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
+	error = simple_pin_fs(&securityfs, &fs_type);
 	if (error)
 		return ERR_PTR(error);
 
 	if (!parent)
-		parent = mount->mnt_root;
+		parent = securityfs.mount->mnt_root;
 
 	dir = d_inode(parent);
 
@@ -168,7 +167,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	simple_release_fs(&securityfs);
 	return dentry;
 }
 
@@ -309,7 +308,7 @@ void securityfs_remove(struct dentry *dentry)
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	simple_release_fs(&securityfs);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
-- 
2.25.2

