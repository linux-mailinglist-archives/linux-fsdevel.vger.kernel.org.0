Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A94963ABE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 16:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiK1PDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 10:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiK1PDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:03:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ECB1BE84
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 07:03:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FACF6120A
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 15:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3391AC433D7;
        Mon, 28 Nov 2022 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669647784;
        bh=Zw3AHzM5rLYDzRv8oGZn+up7iRMawP6pGUjRt/hnqsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBY/sEYH8drfZh0Foz6cQ7JM2KBmRdIWdPk3+NnXDbfdSU3GFAY+HeFtmsQswT/a1
         g0nAaTJbtMrKKiadrEV7YX4mJh08PvQUEY1YvbJPAHDVqE2AwRgoR3AfbdCfFwMjv1
         I/okYQZmMeFX988L7Vk+25uRjasuku6BRetuElQprbZqTl/Oj4l3sf2p2YIdst0+x2
         a6S06kj/bHZqz/ZHNQJezFiykWWeETkJOaEVWh3lOgDMKYVZDnCs9W7ssH6RkAvgIb
         2KKn366rOBzSu9wanoDUlUSjT7QWGW8Pr2OtLpoDDDlkxsemqTvPt4YZaXrWa4O2TW
         ret6WAboXplKg==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH] fs: drop the fl_owner_t argument from ->flush
Date:   Mon, 28 Nov 2022 10:03:01 -0500
Message-Id: <20221128150301.1168324-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128150301.1168324-1-jlayton@kernel.org>
References: <20221128150301.1168324-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have a long-term goal to deprecate use the fl_owner_t, and instead
use something like an unsigned long to represent a filelock owner.

None of flush file_operations for kernel-based filesystems do anything
with their fl_owner_t argument. ecryptfs and overlayfs just pass the
argument through to the lower filesystem, and most just ignore it.

The exception here is FUSE, which coverts and passes this value to
userland. For now, this patch just universally sets the lock_owner field
to 0.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/file.c | 4 ++--
 drivers/android/binder.c                 | 2 +-
 drivers/char/ps3flash.c                  | 2 +-
 drivers/char/xillybus/xillybus_core.c    | 2 +-
 drivers/char/xillybus/xillyusb.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 2 +-
 drivers/scsi/st.c                        | 2 +-
 drivers/usb/class/cdc-wdm.c              | 2 +-
 drivers/usb/class/usbtmc.c               | 2 +-
 drivers/usb/usb-skeleton.c               | 2 +-
 fs/cifs/cifsfs.h                         | 2 +-
 fs/cifs/file.c                           | 2 +-
 fs/ecryptfs/file.c                       | 4 ++--
 fs/f2fs/file.c                           | 2 +-
 fs/fuse/file.c                           | 4 ++--
 fs/nfs/file.c                            | 2 +-
 fs/nfs/nfs4file.c                        | 2 +-
 fs/open.c                                | 2 +-
 fs/orangefs/file.c                       | 2 +-
 fs/overlayfs/file.c                      | 4 ++--
 include/linux/fs.h                       | 2 +-
 ipc/mqueue.c                             | 2 +-
 kernel/acct.c                            | 2 +-
 23 files changed, 27 insertions(+), 27 deletions(-)

It would be nice to do this, but the FUSE thing may make it impossible.

Is there a way to audit the various flush operations in userland FUSE
filesystems and see whether they do anything with the lock_owner? I did
take a peek at ceph-fuse and it doesn't care about the lock_owner in its
flush op. I'm at a loss as to how to check this more broadly.

If we can't do this right away, then perhaps we could try to change this
as part of the FUSE userland API first, and follow up with a change like
this later.

Thoughts?

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 62d90a5e23d1..cf11d1eea401 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1697,7 +1697,7 @@ static __poll_t spufs_mfc_poll(struct file *file,poll_table *wait)
 	return mask;
 }
 
-static int spufs_mfc_flush(struct file *file, fl_owner_t id)
+static int spufs_mfc_flush(struct file *file)
 {
 	struct spu_context *ctx = file->private_data;
 	int ret;
@@ -1729,7 +1729,7 @@ static int spufs_mfc_fsync(struct file *file, loff_t start, loff_t end, int data
 	int err = file_write_and_wait_range(file, start, end);
 	if (!err) {
 		inode_lock(inode);
-		err = spufs_mfc_flush(file, NULL);
+		err = spufs_mfc_flush(file);
 		inode_unlock(inode);
 	}
 	return err;
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 880224ec6abb..1e2874898096 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5675,7 +5675,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	return 0;
 }
 
-static int binder_flush(struct file *filp, fl_owner_t id)
+static int binder_flush(struct file *filp)
 {
 	struct binder_proc *proc = filp->private_data;
 
diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index 23871cde41fb..279f89d79625 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -269,7 +269,7 @@ static ssize_t ps3flash_kernel_write(const void *buf, size_t count,
 	return res;
 }
 
-static int ps3flash_flush(struct file *file, fl_owner_t id)
+static int ps3flash_flush(struct file *file)
 {
 	return ps3flash_writeback(ps3flash_dev);
 }
diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
index 11b7c4749274..ece69ab418f3 100644
--- a/drivers/char/xillybus/xillybus_core.c
+++ b/drivers/char/xillybus/xillybus_core.c
@@ -1174,7 +1174,7 @@ static int xillybus_myflush(struct xilly_channel *channel, long timeout)
 	return rc;
 }
 
-static int xillybus_flush(struct file *filp, fl_owner_t id)
+static int xillybus_flush(struct file *filp)
 {
 	if (!(filp->f_mode & FMODE_WRITE))
 		return 0;
diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 39bcbfd908b4..1a849b47da82 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -1592,7 +1592,7 @@ static ssize_t xillyusb_read(struct file *filp, char __user *userbuf,
 	return rc;
 }
 
-static int xillyusb_flush(struct file *filp, fl_owner_t id)
+static int xillyusb_flush(struct file *filp)
 {
 	struct xillyusb_channel *chan = filp->private_data;
 	int rc;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bf2d50c8c92a..a1d448452e0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2675,7 +2675,7 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
 	.runtime_idle = amdgpu_pmops_runtime_idle,
 };
 
-static int amdgpu_flush(struct file *f, fl_owner_t id)
+static int amdgpu_flush(struct file *f)
 {
 	struct drm_file *file_priv = f->private_data;
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index b90a440e135d..1eb11a4d3d11 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -1338,7 +1338,7 @@ static int st_open(struct inode *inode, struct file *filp)
 
 
 /* Flush the tape buffer before close */
-static int st_flush(struct file *filp, fl_owner_t id)
+static int st_flush(struct file *filp)
 {
 	int result = 0, result2;
 	unsigned char cmd[MAX_COMMAND_SIZE];
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 1f0951be15ab..89220c1c0bda 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -674,7 +674,7 @@ static int wdm_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  * malicious or defective hardware which ceased communication after close() was
  * implicitly called due to process termination.
  */
-static int wdm_flush(struct file *file, fl_owner_t id)
+static int wdm_flush(struct file *file)
 {
 	return wdm_wait_for_response(file, WDM_FLUSH_TIMEOUT);
 }
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 4bb6d304eb4b..0162083f50fe 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -212,7 +212,7 @@ static int usbtmc_open(struct inode *inode, struct file *filp)
 /*
  * usbtmc_flush - called before file handle is closed
  */
-static int usbtmc_flush(struct file *file, fl_owner_t id)
+static int usbtmc_flush(struct file *file)
 {
 	struct usbtmc_file_data *file_data;
 	struct usbtmc_device_data *data;
diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index d87deee3e26e..5aad2bc71b0d 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -133,7 +133,7 @@ static int skel_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int skel_flush(struct file *file, fl_owner_t id)
+static int skel_flush(struct file *file)
 {
 	struct usb_skel *dev;
 	int res;
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 388b745a978e..919fddc96d9b 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -104,7 +104,7 @@ extern int cifs_flock(struct file *pfile, int cmd, struct file_lock *plock);
 extern int cifs_lock(struct file *, int, struct file_lock *);
 extern int cifs_fsync(struct file *, loff_t, loff_t, int);
 extern int cifs_strict_fsync(struct file *, loff_t, loff_t, int);
-extern int cifs_flush(struct file *, fl_owner_t id);
+extern int cifs_flush(struct file *);
 extern int cifs_file_mmap(struct file * , struct vm_area_struct *);
 extern int cifs_file_strict_mmap(struct file * , struct vm_area_struct *);
 extern const struct file_operations cifs_dir_ops;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index c230e86f1e09..fdd174e7c6df 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3028,7 +3028,7 @@ int cifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  * As file closes, flush all cached write data for this inode checking
  * for write behind errors.
  */
-int cifs_flush(struct file *file, fl_owner_t id)
+int cifs_flush(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	int rc = 0;
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 268b74499c28..74d93450650e 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -281,13 +281,13 @@ static int ecryptfs_dir_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int ecryptfs_flush(struct file *file, fl_owner_t td)
+static int ecryptfs_flush(struct file *file)
 {
 	struct file *lower_file = ecryptfs_file_to_lower(file);
 
 	if (lower_file->f_op->flush) {
 		filemap_write_and_wait(file->f_mapping);
-		return lower_file->f_op->flush(lower_file, td);
+		return lower_file->f_op->flush(lower_file);
 	}
 
 	return 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82cda1258227..8a3c1c04e45e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1869,7 +1869,7 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int f2fs_file_flush(struct file *file, fl_owner_t id)
+static int f2fs_file_flush(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0e6b3b8e2f27..ec396ee93776 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -478,7 +478,7 @@ static void fuse_sync_writes(struct inode *inode)
 	fuse_release_nowrite(inode);
 }
 
-static int fuse_flush(struct file *file, fl_owner_t id)
+static int fuse_flush(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -511,7 +511,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
-	inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
+	inarg.lock_owner = fuse_lock_owner_id(fm->fc, 0);
 	args.opcode = FUSE_FLUSH;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index b0f3c9339e70..b3fa87e20f9a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -136,7 +136,7 @@ EXPORT_SYMBOL_GPL(nfs_file_llseek);
  * Flush all dirty pages, and check for write errors.
  */
 static int
-nfs_file_flush(struct file *file, fl_owner_t id)
+nfs_file_flush(struct file *file)
 {
 	struct inode	*inode = file_inode(file);
 	errseq_t since;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 9eb181287879..6f7e40a3592f 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -111,7 +111,7 @@ nfs4_file_open(struct inode *inode, struct file *filp)
  * Flush all dirty pages, and check for write errors.
  */
 static int
-nfs4_file_flush(struct file *file, fl_owner_t id)
+nfs4_file_flush(struct file *file)
 {
 	struct inode	*inode = file_inode(file);
 	errseq_t since;
diff --git a/fs/open.c b/fs/open.c
index 5b48be9a62a0..36b29158a36a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1418,7 +1418,7 @@ int filp_close(struct file *filp, fl_owner_t id)
 	}
 
 	if (filp->f_op->flush)
-		retval = filp->f_op->flush(filp, id);
+		retval = filp->f_op->flush(filp);
 
 	if (likely(!(filp->f_mode & FMODE_PATH))) {
 		dnotify_flush(filp, id);
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 12ec31a9113b..f184b0fb6125 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -531,7 +531,7 @@ static int orangefs_lock(struct file *filp, int cmd, struct file_lock *fl)
 	return rc;
 }
 
-static int orangefs_flush(struct file *file, fl_owner_t id)
+static int orangefs_flush(struct file *file)
 {
 	/*
 	 * This is vfs_fsync_range(file, 0, LLONG_MAX, 0) without the
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index a1a22f58ba18..2f771340a858 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -641,7 +641,7 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 			    remap_flags, op);
 }
 
-static int ovl_flush(struct file *file, fl_owner_t id)
+static int ovl_flush(struct file *file)
 {
 	struct fd real;
 	const struct cred *old_cred;
@@ -653,7 +653,7 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 
 	if (real.file->f_op->flush) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
-		err = real.file->f_op->flush(real.file, id);
+		err = real.file->f_op->flush(real.file);
 		revert_creds(old_cred);
 	}
 	fdput(real);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 63f355058ab5..f062fd66b60c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1793,7 +1793,7 @@ struct file_operations {
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	unsigned long mmap_supported_flags;
 	int (*open) (struct inode *, struct file *);
-	int (*flush) (struct file *, fl_owner_t id);
+	int (*flush) (struct file *);
 	int (*release) (struct inode *, struct file *);
 	int (*fsync) (struct file *, loff_t, loff_t, int datasync);
 	int (*fasync) (int, struct file *, int);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 467a194b8a2e..f5c1668914dd 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -660,7 +660,7 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
 	return ret;
 }
 
-static int mqueue_flush_file(struct file *filp, fl_owner_t id)
+static int mqueue_flush_file(struct file *filp)
 {
 	struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
 
diff --git a/kernel/acct.c b/kernel/acct.c
index 62200d799b9b..54cc7899129f 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -204,7 +204,7 @@ static void close_work(struct work_struct *work)
 	struct bsd_acct_struct *acct = container_of(work, struct bsd_acct_struct, work);
 	struct file *file = acct->file;
 	if (file->f_op->flush)
-		file->f_op->flush(file, NULL);
+		file->f_op->flush(file);
 	__fput_sync(file);
 	complete(&acct->done);
 }
-- 
2.38.1

