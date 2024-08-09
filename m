Return-Path: <linux-fsdevel+bounces-25508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7894CED4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39E2B21E8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48187192B69;
	Fri,  9 Aug 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAP8EjRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23E1922DB
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199946; cv=none; b=puI7KVLuZy5iP/ROSvc/lQeUlNLNIOE48YPwwssajd+Q4mUz81QWWE+x+IiT0drL/06+f1FPj2i1xEERI2h9Qa3URUHAat9q7awZumEZXv4x3kPGWrqFsZGzlAGqA18TVebZtwd7eAbRLZL8nVSOakKv2sKGNakBz2YuwhofZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199946; c=relaxed/simple;
	bh=AIOq5jHV/80Hs+BUH/I7dz1tkC99Ooev+lzR9sw0d+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JctMWybxT0IRyZzOJ8PR+/e5sz6vXWzjG5PCIgcGtp51kkzhL7J8rFqaFEuMlT3MTR7lpwQwSJU3pcevQ2jOyF2MtytWZHvMgMG8/oaOfA9O4ZfamUHPARVRE28JTnPYVKuwlWHxMqx611Y+H5hEripBCxisaaw4JLvaYWpffPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAP8EjRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAA4C32782;
	Fri,  9 Aug 2024 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723199946;
	bh=AIOq5jHV/80Hs+BUH/I7dz1tkC99Ooev+lzR9sw0d+k=;
	h=From:Date:Subject:To:Cc:From;
	b=GAP8EjRGUNI8wxzcHlltB+xbDcNfB6CQFqTNtk8Pbm4/JeVEksPVP6/KdLQw56jXa
	 Wf03Bw9HWHxdPa2uf0nNE87SnigGyWcNMfezAn+hpl2M0pSP5R2jMZ1P0zuB9GHpZg
	 zwyO2cY41C5KugnMQWXy4S5Uq4noGkM4RM3GHSLMBv8JqXJIetpjXXm3zUqQgDKYSY
	 YyRxI0YjuNthrSqgo2ypp1vbhLWQIIwQzHufjwXIZj36mYMaiTxPsgPP3NyRxsqQyM
	 74eSzGXv1uhfmWBixCamrC48h2cFkvMkQKW10E7kzl5oxLRAzCRHhCjzxU0A2UXyfg
	 LWWGykyUZrkxA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 09 Aug 2024 12:38:56 +0200
Subject: [PATCH] fs: move FMODE_UNSIGNED_OFFSET to fop_flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-work-fop_unsigned-v1-1-658e054d893e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL/xtWYC/x3MQQ6CMBBA0auQWTukRQT1KsaYtkxhYmzJjKIJ4
 e5Wl2/x/wpKwqRwrlYQWlg5pwK7qyBMLo2EPBRDY5rWHM0J31nuGPN8eyXlMdGAh9jFvt+3wfc
 eSjcLRf78n5drsXdK6MWlMP1OD6dPknrpamtRgoVt+wIwzme0hgAAAA==
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Josef Bacik <josef@toxicpanda.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=12244; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AIOq5jHV/80Hs+BUH/I7dz1tkC99Ooev+lzR9sw0d+k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt/XiicoK8q83lf63zLt4Ld/q+7dAe0RLfneZGbKyvy
 zv2ea6d1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARv2eMDAuWaN/St1TUll2o
 dPbLBg6zxYYd9hrvzGOidXSvN99lP8nwP0ShONlxwye/hy8f/ZdXOCbvvMVd/3S5xsVUqexsi5m
 1zAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This is another flag that is statically set and doesn't need to use up
an FMODE_* bit. Move it to ->fop_flags and free up another FMODE_* bit.

(1) mem_open() used from proc_mem_operations
(2) adi_open() used from adi_fops
(3) drm_open_helper():
    (3.1) accel_open() used from DRM_ACCEL_FOPS
    (3.2) drm_open() used from
    (3.2.1) amdgpu_driver_kms_fops
    (3.2.2) psb_gem_fops
    (3.2.3) i915_driver_fops
    (3.2.4) nouveau_driver_fops
    (3.2.5) panthor_drm_driver_fops
    (3.2.6) radeon_driver_kms_fops
    (3.2.7) tegra_drm_fops
    (3.2.8) vmwgfx_driver_fops
    (3.2.9) xe_driver_fops
    (3.2.10) DRM_GEM_FOPS
    (3.2.11) DEFINE_DRM_GEM_DMA_FOPS
(4) struct memdev sets fmode flags based on type of device opened. For
    devices using struct mem_fops unsigned offset is used.

Mark all these file operations as FOP_UNSIGNED_OFFSET and add asserts
into the open helper to ensure that the flag is always set.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
---
 drivers/char/adi.c                      |  8 +-------
 drivers/char/mem.c                      |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/drm_file.c              |  3 ++-
 drivers/gpu/drm/gma500/psb_drv.c        |  1 +
 drivers/gpu/drm/i915/i915_driver.c      |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  1 +
 drivers/gpu/drm/radeon/radeon_drv.c     |  1 +
 drivers/gpu/drm/tegra/drm.c             |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  1 +
 drivers/gpu/drm/xe/xe_device.c          |  1 +
 fs/proc/base.c                          | 10 ++++------
 fs/read_write.c                         |  2 +-
 include/drm/drm_accel.h                 |  3 ++-
 include/drm/drm_gem.h                   |  3 ++-
 include/drm/drm_gem_dma_helper.h        |  1 +
 include/linux/fs.h                      |  5 +++--
 mm/mmap.c                               |  2 +-
 18 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/char/adi.c b/drivers/char/adi.c
index 751d7cc0da1b..1c76c8758f0f 100644
--- a/drivers/char/adi.c
+++ b/drivers/char/adi.c
@@ -14,12 +14,6 @@
 
 #define MAX_BUF_SZ	PAGE_SIZE
 
-static int adi_open(struct inode *inode, struct file *file)
-{
-	file->f_mode |= FMODE_UNSIGNED_OFFSET;
-	return 0;
-}
-
 static int read_mcd_tag(unsigned long addr)
 {
 	long err;
@@ -206,9 +200,9 @@ static loff_t adi_llseek(struct file *file, loff_t offset, int whence)
 static const struct file_operations adi_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= adi_llseek,
-	.open		= adi_open,
 	.read		= adi_read,
 	.write		= adi_write,
+	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
 
 static struct miscdevice adi_miscdev = {
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 7c359cc406d5..169eed162a7f 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -643,6 +643,7 @@ static const struct file_operations __maybe_unused mem_fops = {
 	.get_unmapped_area = get_unmapped_area_mem,
 	.mmap_capabilities = memory_mmap_capabilities,
 #endif
+	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
 
 static const struct file_operations null_fops = {
@@ -693,7 +694,7 @@ static const struct memdev {
 	umode_t mode;
 } devlist[] = {
 #ifdef CONFIG_DEVMEM
-	[DEVMEM_MINOR] = { "mem", &mem_fops, FMODE_UNSIGNED_OFFSET, 0 },
+	[DEVMEM_MINOR] = { "mem", &mem_fops, 0, 0 },
 #endif
 	[3] = { "null", &null_fops, FMODE_NOWAIT, 0666 },
 #ifdef CONFIG_DEVPORT
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 094498a0964b..d7ef8cbecf6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2908,6 +2908,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = drm_show_fdinfo,
 #endif
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 714e42b05108..f8de3cba1a08 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -318,6 +318,8 @@ int drm_open_helper(struct file *filp, struct drm_minor *minor)
 	if (dev->switch_power_state != DRM_SWITCH_POWER_ON &&
 	    dev->switch_power_state != DRM_SWITCH_POWER_DYNAMIC_OFF)
 		return -EINVAL;
+	if (WARN_ON_ONCE(!(filp->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
+		return -EINVAL;
 
 	drm_dbg_core(dev, "comm=\"%s\", pid=%d, minor=%d\n",
 		     current->comm, task_pid_nr(current), minor->index);
@@ -335,7 +337,6 @@ int drm_open_helper(struct file *filp, struct drm_minor *minor)
 	}
 
 	filp->private_data = priv;
-	filp->f_mode |= FMODE_UNSIGNED_OFFSET;
 	priv->filp = filp;
 
 	mutex_lock(&dev->filelist_mutex);
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 8b64f61ffaf9..d67c2b3ad901 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -498,6 +498,7 @@ static const struct file_operations psb_gem_fops = {
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
 	.read = drm_read,
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 static const struct drm_driver driver = {
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index fb8e9c2fcea5..cf276299bccb 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1671,6 +1671,7 @@ static const struct file_operations i915_driver_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = drm_show_fdinfo,
 #endif
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 static int
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index a58c31089613..e243b42f8582 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1274,6 +1274,7 @@ nouveau_driver_fops = {
 	.compat_ioctl = nouveau_compat_ioctl,
 #endif
 	.llseek = noop_llseek,
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 static struct drm_driver
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7bf08164140e..ac49779ed03d 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -520,6 +520,7 @@ static const struct file_operations radeon_driver_kms_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = radeon_kms_compat_ioctl,
 #endif
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 static const struct drm_ioctl_desc radeon_ioctls_kms[] = {
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 03d1c76aec2d..108c26a33edb 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -801,6 +801,7 @@ static const struct file_operations tegra_drm_fops = {
 	.read = drm_read,
 	.compat_ioctl = drm_compat_ioctl,
 	.llseek = noop_llseek,
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 static int tegra_drm_context_cleanup(int id, void *p, void *data)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 50ad3105c16e..2825dd3149ed 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1609,6 +1609,7 @@ static const struct file_operations vmwgfx_driver_fops = {
 	.compat_ioctl = vmw_compat_ioctl,
 #endif
 	.llseek = noop_llseek,
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 static const struct drm_driver driver = {
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 76109415eba6..ea7e3ff6feba 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -197,6 +197,7 @@ static const struct file_operations xe_driver_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = drm_show_fdinfo,
 #endif
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 static struct drm_driver driver = {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..1409d1003101 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -827,12 +827,9 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 
 static int mem_open(struct inode *inode, struct file *file)
 {
-	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
-
-	/* OK to pass negative loff_t, we can catch out-of-range */
-	file->f_mode |= FMODE_UNSIGNED_OFFSET;
-
-	return ret;
+	if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
+		return -EINVAL;
+	return __mem_open(inode, file, PTRACE_MODE_ATTACH);
 }
 
 static ssize_t mem_rw(struct file *file, char __user *buf,
@@ -932,6 +929,7 @@ static const struct file_operations proc_mem_operations = {
 	.write		= mem_write,
 	.open		= mem_open,
 	.release	= mem_release,
+	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
 
 static int environ_open(struct inode *inode, struct file *file)
diff --git a/fs/read_write.c b/fs/read_write.c
index 90e283b31ca1..89d4af0e3b93 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL(generic_ro_fops);
 
 static inline bool unsigned_offsets(struct file *file)
 {
-	return file->f_mode & FMODE_UNSIGNED_OFFSET;
+	return file->f_op->fop_flags & FOP_UNSIGNED_OFFSET;
 }
 
 /**
diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
index f4d3784b1dce..41c78b7d712c 100644
--- a/include/drm/drm_accel.h
+++ b/include/drm/drm_accel.h
@@ -28,7 +28,8 @@
 	.poll		= drm_poll,\
 	.read		= drm_read,\
 	.llseek		= noop_llseek, \
-	.mmap		= drm_gem_mmap
+	.mmap		= drm_gem_mmap, \
+	.fop_flags	= FOP_UNSIGNED_OFFSET
 
 /**
  * DEFINE_DRM_ACCEL_FOPS() - macro to generate file operations for accelerators drivers
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index bae4865b2101..d8b86df2ec0d 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -447,7 +447,8 @@ struct drm_gem_object {
 	.poll		= drm_poll,\
 	.read		= drm_read,\
 	.llseek		= noop_llseek,\
-	.mmap		= drm_gem_mmap
+	.mmap		= drm_gem_mmap, \
+	.fop_flags	= FOP_UNSIGNED_OFFSET
 
 /**
  * DEFINE_DRM_GEM_FOPS() - macro to generate file operations for GEM drivers
diff --git a/include/drm/drm_gem_dma_helper.h b/include/drm/drm_gem_dma_helper.h
index a827bde494f6..f2678e7ecb98 100644
--- a/include/drm/drm_gem_dma_helper.h
+++ b/include/drm/drm_gem_dma_helper.h
@@ -267,6 +267,7 @@ unsigned long drm_gem_dma_get_unmapped_area(struct file *filp,
 		.read		= drm_read,\
 		.llseek		= noop_llseek,\
 		.mmap		= drm_gem_mmap,\
+		.fop_flags = FOP_UNSIGNED_OFFSET, \
 		DRM_GEM_DMA_UNMAPPED_AREA_FOPS \
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..40ebfa09112c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -146,8 +146,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* Expect random access pattern */
 #define FMODE_RANDOM		((__force fmode_t)(1 << 12))
 
-/* File is huge (eg. /dev/mem): treat loff_t as unsigned */
-#define FMODE_UNSIGNED_OFFSET	((__force fmode_t)(1 << 13))
+/* FMODE_* bit 13 */
 
 /* File is opened with O_PATH; almost nothing can be done with it */
 #define FMODE_PATH		((__force fmode_t)(1 << 14))
@@ -2073,6 +2072,8 @@ struct file_operations {
 #define FOP_DIO_PARALLEL_WRITE	((__force fop_flags_t)(1 << 3))
 /* Contains huge pages */
 #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
+/* Treat loff_t as unsigned (e.g., /dev/mem) */
+#define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
diff --git a/mm/mmap.c b/mm/mmap.c
index d0dfc85b209b..6ddb278a5ee8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1229,7 +1229,7 @@ static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
 		return MAX_LFS_FILESIZE;
 
 	/* Special "we do even unsigned file positions" case */
-	if (file->f_mode & FMODE_UNSIGNED_OFFSET)
+	if (file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)
 		return 0;
 
 	/* Yes, random drivers might want more. But I'm tired of buggy drivers */

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240809-work-fop_unsigned-5f6f7734cb7b


