Return-Path: <linux-fsdevel+bounces-71943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FEFCD7D2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 03:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 147DA3027172
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B55F24A046;
	Tue, 23 Dec 2025 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NQdpYIp+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664AB267B90;
	Tue, 23 Dec 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766455753; cv=none; b=oqG0m5ABi/VUl+2nZPGYR2OLHfUYo5vg7utqOtleLgOHcb8PdyjxrKEuBloixKOKA/jy9IoNdkhT4x2VQVoOszCBhwszSSEGvao8aeczfAIvLm165BEkYDn07YvZOwxDEigR0ewpVQnlWucarvZF9/XR0GqiFeDvuqyGLSJ7tPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766455753; c=relaxed/simple;
	bh=w1R23FUQgNA0zcP58l1IeiPPYAxd4sB7UOx2UugsVtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiC9W/VDC6ynxS5K6pwJ32DFi8QdzFsU4CACMaXsVQx8Vh4DIo/a40EF3ToAOgczGAC4p2ONCQqOti02Gbu7N4odlJ43t+Mes3pdIoDHR1ZYYiHI+Fu9Ihn9A7l//HQQoXXd8P0qLibbjmy/LCEdjYWFooaOSr0q3IWGm/VXULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NQdpYIp+; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q+Sim06CkmeGt3uxKKvRBLi8sRFwSfC5CRcH06hSP/I=;
	b=NQdpYIp+OVtBSGyWaHdiL9cmPCiU0sXsmOIKyiNm7ItHtpUVCg7uYBLA0/rPT3kt7SHLKyRVh
	y+VkhxLot48oRyn0IZJ+W7uFvmA7AyvOtgno78WkMfuECmSQXxDVJWChTF2gbbCRXFO5V6LqUFV
	6y0q9coLGLVdeeDSQhnM6HA=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dZyzV0pm2zpT0F;
	Tue, 23 Dec 2025 10:06:14 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E5C04036C;
	Tue, 23 Dec 2025 10:09:08 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Dec
 2025 10:09:07 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v10 07/10] erofs: introduce the page cache share feature
Date: Tue, 23 Dec 2025 01:56:16 +0000
Message-ID: <20251223015618.485626-8-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251223015618.485626-1-lihongbo22@huawei.com>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Currently, reading files with different paths (or names) but the same
content will consume multiple copies of the page cache, even if the
content of these page caches is the same. For example, reading
identical files (e.g., *.so files) from two different minor versions of
container images will cost multiple copies of the same page cache,
since different containers have different mount points. Therefore,
sharing the page cache for files with the same content can save memory.

This introduces the page cache share feature in erofs. It allocate a
deduplicated inode and use its page cache as shared. Reads for files
with identical content will ultimately be routed to the page cache of
the deduplicated inode. In this way, a single page cache satisfies
multiple read requests for different files with the same contents.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/Makefile   |   1 +
 fs/erofs/internal.h |  29 ++++++
 fs/erofs/ishare.c   | 211 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c    |  34 ++++++-
 4 files changed, 272 insertions(+), 3 deletions(-)
 create mode 100644 fs/erofs/ishare.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 549abc424763..a80e1762b607 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 99e2857173c3..ae9560434324 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -304,6 +304,22 @@ struct erofs_inode {
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	union {
+		/* internal dedup inode */
+		struct {
+			char *fingerprint;
+			spinlock_t lock;
+			/* all backing inodes */
+			struct list_head backing_head;
+		};
+
+		struct {
+			struct inode *ishare;
+			struct list_head backing_link;
+		};
+	};
+#endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -410,6 +426,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations erofs_ishare_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
@@ -541,6 +558,18 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
 static inline void erofs_fscache_submit_bio(struct bio *bio) {}
 #endif
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+int __init erofs_init_ishare(void);
+void erofs_exit_ishare(void);
+bool erofs_ishare_fill_inode(struct inode *inode);
+void erofs_ishare_free_inode(struct inode *inode);
+#else
+static inline int erofs_init_ishare(void) { return 0; }
+static inline void erofs_exit_ishare(void) {}
+static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
+static inline void erofs_ishare_free_inode(struct inode *inode) {}
+#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+
 long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
 			unsigned long arg);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
new file mode 100644
index 000000000000..4b46016bcd03
--- /dev/null
+++ b/fs/erofs/ishare.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include <linux/xxhash.h>
+#include <linux/refcount.h>
+#include <linux/mount.h>
+#include <linux/mutex.h>
+#include <linux/ramfs.h>
+#include "internal.h"
+#include "xattr.h"
+
+#include "../internal.h"
+
+static struct vfsmount *erofs_ishare_mnt;
+
+static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	return vi->fingerprint && memcmp(vi->fingerprint, data,
+			sizeof(size_t) + *(size_t *)data) == 0;
+}
+
+static int erofs_ishare_iget5_set(struct inode *inode, void *data)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	vi->fingerprint = data;
+	INIT_LIST_HEAD(&vi->backing_head);
+	spin_lock_init(&vi->lock);
+	return 0;
+}
+
+bool erofs_ishare_fill_inode(struct inode *inode)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+	struct erofs_xattr_prefix_item *ishare_prefix;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct inode *idedup;
+	/*
+	 * fingerprint layout:
+	 * fingerprint length + fingerprint content (xattr_value + domain_id)
+	 */
+	char *ishare_key, *fingerprint;
+	ssize_t ishare_vlen;
+	unsigned long hash;
+	int key_idx;
+
+	if (!sbi->domain_id || !erofs_sb_has_ishare_xattrs(sbi))
+		return false;
+
+	ishare_prefix = sbi->xattr_prefixes + sbi->ishare_xattr_pfx;
+	ishare_key = ishare_prefix->prefix->infix;
+	key_idx = ishare_prefix->prefix->base_index;
+	ishare_vlen = erofs_getxattr(inode, key_idx, ishare_key, NULL, 0);
+	if (ishare_vlen <= 0 || ishare_vlen > (1 << sbi->blkszbits))
+		return false;
+
+	fingerprint = kmalloc(sizeof(ssize_t) + ishare_vlen +
+			      strlen(sbi->domain_id), GFP_KERNEL);
+	if (!fingerprint)
+		return false;
+
+	*(ssize_t *)fingerprint = ishare_vlen + strlen(sbi->domain_id);
+	if (ishare_vlen != erofs_getxattr(inode, key_idx, ishare_key,
+					  fingerprint + sizeof(ssize_t),
+					  ishare_vlen)) {
+		kfree(fingerprint);
+		return false;
+	}
+
+	memcpy(fingerprint + sizeof(ssize_t) + ishare_vlen,
+	       sbi->domain_id, strlen(sbi->domain_id));
+	hash = xxh32(fingerprint + sizeof(ssize_t),
+		     ishare_vlen + strlen(sbi->domain_id), hash);
+	idedup = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
+			      erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
+			      fingerprint);
+	if (!idedup) {
+		kfree(fingerprint);
+		return false;
+	}
+
+	INIT_LIST_HEAD(&vi->backing_link);
+	vi->ishare = idedup;
+	spin_lock(&EROFS_I(idedup)->lock);
+	list_add(&vi->backing_link, &EROFS_I(idedup)->backing_head);
+	spin_unlock(&EROFS_I(idedup)->lock);
+	if (!(inode_state_read_once(idedup) & I_NEW)) {
+		kfree(fingerprint);
+		return true;
+	}
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		idedup->i_mapping->a_ops = &z_erofs_aops;
+	else
+		idedup->i_mapping->a_ops = &erofs_aops;
+	idedup->i_mode = vi->vfs_inode.i_mode;
+	i_size_write(idedup, vi->vfs_inode.i_size);
+	unlock_new_inode(idedup);
+	return true;
+}
+
+void erofs_ishare_free_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct inode *idedup = vi->ishare;
+
+	if (!idedup)
+		return;
+	spin_lock(&EROFS_I(idedup)->lock);
+	list_del(&vi->backing_link);
+	spin_unlock(&EROFS_I(idedup)->lock);
+	iput(idedup);
+	vi->ishare = NULL;
+}
+
+static int erofs_ishare_file_open(struct inode *inode, struct file *file)
+{
+	struct file *realfile;
+	struct inode *dedup;
+
+	dedup = EROFS_I(inode)->ishare;
+	if (!dedup)
+		return -EINVAL;
+
+	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred());
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
+	ihold(dedup);
+	realfile->f_op = &erofs_file_fops;
+	realfile->f_inode = dedup;
+	realfile->f_mapping = dedup->i_mapping;
+	path_get(&file->f_path);
+	backing_file_set_user_path(realfile, &file->f_path);
+
+	file_ra_state_init(&realfile->f_ra, file->f_mapping);
+	realfile->private_data = EROFS_I(inode);
+	file->private_data = realfile;
+	return 0;
+}
+
+static int erofs_ishare_file_release(struct inode *inode, struct file *file)
+{
+	struct file *realfile = file->private_data;
+
+	if (!realfile)
+		return -EINVAL;
+	iput(realfile->f_inode);
+	fput(realfile);
+	file->private_data = NULL;
+	return 0;
+}
+
+static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
+						    struct iov_iter *to)
+{
+	struct file *realfile = iocb->ki_filp->private_data;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct kiocb dedup_iocb;
+	ssize_t nread;
+
+	if (!realfile)
+		return -EINVAL;
+	if (!iov_iter_count(to))
+		return 0;
+
+	/* fallback to the original file in DAX or DIRECT mode */
+	if (IS_DAX(inode) || (iocb->ki_flags & IOCB_DIRECT))
+		realfile = iocb->ki_filp;
+
+	kiocb_clone(&dedup_iocb, iocb, realfile);
+	nread = filemap_read(&dedup_iocb, to, 0);
+	iocb->ki_pos = dedup_iocb.ki_pos;
+	file_accessed(iocb->ki_filp);
+	return nread;
+}
+
+static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct file *realfile = file->private_data;
+
+	if (!realfile)
+		return -EINVAL;
+
+	vma_set_file(vma, realfile);
+	return generic_file_readonly_mmap(file, vma);
+}
+
+const struct file_operations erofs_ishare_fops = {
+	.open		= erofs_ishare_file_open,
+	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_ishare_file_read_iter,
+	.mmap		= erofs_ishare_mmap,
+	.release	= erofs_ishare_file_release,
+	.get_unmapped_area = thp_get_unmapped_area,
+	.splice_read	= filemap_splice_read,
+};
+
+int __init erofs_init_ishare(void)
+{
+	erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);
+	if (IS_ERR(erofs_ishare_mnt))
+		return PTR_ERR(erofs_ishare_mnt);
+	return 0;
+}
+
+void erofs_exit_ishare(void)
+{
+	kern_unmount(erofs_ishare_mnt);
+}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index be9f96252c6c..ecce491871af 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -942,14 +942,34 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
-#if defined(CONFIG_EROFS_FS_ONDEMAND)
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
+static void erofs_free_anon_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	kfree(vi->fingerprint);
+#endif
+	kmem_cache_free(erofs_inode_cachep, vi);
+}
+
+static const struct super_operations erofs_anon_sops = {
+	.alloc_inode = erofs_alloc_inode,
+	.free_inode = erofs_free_anon_inode,
+};
+
 static int erofs_anon_init_fs_context(struct fs_context *fc)
 {
-	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
+	struct pseudo_fs_context *ctx;
+
+	ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
+	if (ctx)
+		ctx->ops = &erofs_anon_sops;
+
+	return ctx ? 0 : -ENOMEM;
 }
 
 struct file_system_type erofs_anon_fs_type = {
-	.owner		= THIS_MODULE,
 	.name           = "pseudo_erofs",
 	.init_fs_context = erofs_anon_init_fs_context,
 	.kill_sb        = kill_anon_super,
@@ -981,6 +1001,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto sysfs_err;
 
+	err = erofs_init_ishare();
+	if (err)
+		goto ishare_err;
+
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
 		goto fs_err;
@@ -988,6 +1012,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
+	erofs_exit_ishare();
+ishare_err:
 	erofs_exit_sysfs();
 sysfs_err:
 	z_erofs_exit_subsystem();
@@ -1005,6 +1031,7 @@ static void __exit erofs_module_exit(void)
 	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
 	rcu_barrier();
 
+	erofs_exit_ishare();
 	erofs_exit_sysfs();
 	z_erofs_exit_subsystem();
 	erofs_exit_shrinker();
@@ -1071,6 +1098,7 @@ static void erofs_evict_inode(struct inode *inode)
 		dax_break_layout_final(inode);
 #endif
 
+	erofs_ishare_free_inode(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 }
-- 
2.22.0


