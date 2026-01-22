Return-Path: <linux-fsdevel+bounces-75048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHk0HPI0cmmadwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:32:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F06AF67F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6BEC6CB98E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C24735B152;
	Thu, 22 Jan 2026 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1gr9dA03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAF34B697;
	Thu, 22 Jan 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089831; cv=none; b=sFDeR4U2Ai8E+yKcMoYNFKvCNYkCpzfuHARVnsI7O2ISGQPWBpij3objIoK91DONl20UxUz0Zd1CTtcAR8l6lqVcUCyOl1mTGmz8mLEWWNUSyIGVyXUGeKWjiOSsKE0VFBNfynIjkfePgNQuh1pWxEhmCoxYK6AtcWS96oVokWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089831; c=relaxed/simple;
	bh=E8hSvarIbPdFQ1VX0JsokNX5mM2AH8u9j9YoLC4JOC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzbUUBLX6BnT3JrzPmxhnI/VShZUByq3Gcp5gOSU3s8S7flMsXc/Zg4fqrMxCV3hk1qTIyJB4Ri13M9PWg+2KGEs3s+LUjVn3AGdJsQGLqeWanqGkWIQtHpk+To6gXrnw9Iwg7NfRpB26Oz2cD0Q8waayxUbP97eg8k+8xVdz/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1gr9dA03; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JcN2hEkNb0gl8m5b/xYZvy1KxrTyvUkc3tIntK7y618=;
	b=1gr9dA03v8elOs8C81QEej9x5HgT1gK6QgivuMeBcW4TyZTVCim8i+7HZe13OHCTCwkLZ8KFi
	lca2bOcFy8tON9Da53cDJhXcB/eQKLbUMazmI6Qlhk/DFIpizevgAVazFplBwmlv/Zq9E8OwCnM
	CNDd2ZgAy15WxweMd8FTLF8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dxj5g2V3TzpTMv;
	Thu, 22 Jan 2026 21:46:31 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F5EF4056B;
	Thu, 22 Jan 2026 21:50:19 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 21:50:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v16 06/10] erofs: introduce the page cache share feature
Date: Thu, 22 Jan 2026 13:37:14 +0000
Message-ID: <20260122133718.658056-7-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260122133718.658056-1-lihongbo22@huawei.com>
References: <20260122133718.658056-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,huawei.com];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	TAGGED_FROM(0.00)[bounces-75048-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F06AF67F8B
X-Rspamd-Action: no action

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Currently, reading files with different paths (or names) but the same
content will consume multiple copies of the page cache, even if the
content of these page caches is the same. For example, reading
identical files (e.g., *.so files) from two different minor versions of
container images will cost multiple copies of the same page cache,
since different containers have different mount points. Therefore,
sharing the page cache for files with the same content can save memory.

This introduces the page cache share feature in erofs. It allocate a
shared inode and use its page cache as shared. Reads for files
with identical content will ultimately be routed to the page cache of
the shared inode. In this way, a single page cache satisfies
multiple read requests for different files with the same contents.

We introduce new mount option `inode_share` to enable the page
sharing mode during mounting. This option is used in conjunction
with `domain_id` to share the page cache within the same trusted
domain.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 Documentation/filesystems/erofs.rst |   5 +
 fs/erofs/Makefile                   |   1 +
 fs/erofs/inode.c                    |   1 -
 fs/erofs/internal.h                 |  31 ++++++
 fs/erofs/ishare.c                   | 167 ++++++++++++++++++++++++++++
 fs/erofs/super.c                    |  62 ++++++++++-
 fs/erofs/xattr.c                    |  34 ++++++
 fs/erofs/xattr.h                    |   3 +
 8 files changed, 301 insertions(+), 3 deletions(-)
 create mode 100644 fs/erofs/ishare.c

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 40dbf3b6a35f..bfef8e87f299 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -129,7 +129,12 @@ fsid=%s                Specify a filesystem image ID for Fscache back-end.
 domain_id=%s           Specify a trusted domain ID for fscache mode so that
                        different images with the same blobs, identified by blob IDs,
                        can share storage within the same trusted domain.
+                       Also used for different filesystems with inode page sharing
+                       enabled to share page cache within the trusted domain.
 fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
+inode_share            Enable inode page sharing for this filesystem.  Inodes with
+                       identical content within the same domain ID can share the
+                       page cache.
 ===================    =========================================================
 
 Sysfs Entries
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 549abc424763..a80e1762b607 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 389632bb46c4..202cbbb4eada 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -203,7 +203,6 @@ static int erofs_read_inode(struct inode *inode)
 
 static int erofs_fill_inode(struct inode *inode)
 {
-	struct erofs_inode *vi = EROFS_I(inode);
 	int err;
 
 	trace_erofs_fill_inode(inode);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8e28c2fa8735..1061faf43868 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -179,6 +179,7 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
 #define EROFS_MOUNT_DIRECT_IO		0x00000100
+#define EROFS_MOUNT_INODE_SHARE		0x00000200
 
 #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
@@ -269,6 +270,11 @@ static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
 /* default readahead size of directories */
 #define EROFS_DIR_RA_BYTES	16384
 
+struct erofs_inode_fingerprint {
+	u8 *opaque;
+	int size;
+};
+
 struct erofs_inode {
 	erofs_nid_t nid;
 
@@ -304,6 +310,18 @@ struct erofs_inode {
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct list_head ishare_list;
+	union {
+		/* for each anon shared inode */
+		struct {
+			struct erofs_inode_fingerprint fingerprint;
+			spinlock_t ishare_lock;
+		};
+		/* for each real inode */
+		struct inode *sharedinode;
+	};
+#endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -410,6 +428,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations erofs_ishare_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
@@ -564,6 +583,18 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
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
+#endif
+
 long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
 			unsigned long arg);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
new file mode 100644
index 000000000000..3d26b2826710
--- /dev/null
+++ b/fs/erofs/ishare.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include <linux/xxhash.h>
+#include <linux/mount.h>
+#include "internal.h"
+#include "xattr.h"
+
+#include "../internal.h"
+
+static struct vfsmount *erofs_ishare_mnt;
+
+static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
+{
+	struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
+	struct erofs_inode_fingerprint *fp2 = data;
+
+	return fp1->size == fp2->size &&
+		!memcmp(fp1->opaque, fp2->opaque, fp2->size);
+}
+
+static int erofs_ishare_iget5_set(struct inode *inode, void *data)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
+	INIT_LIST_HEAD(&vi->ishare_list);
+	spin_lock_init(&vi->ishare_lock);
+	return 0;
+}
+
+bool erofs_ishare_fill_inode(struct inode *inode)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_inode_fingerprint fp;
+	struct inode *sharedinode;
+	unsigned long hash;
+
+	if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
+		return false;
+	hash = xxh32(fp.opaque, fp.size, 0);
+	sharedinode = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
+				   erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
+				   &fp);
+	if (!sharedinode) {
+		kfree(fp.opaque);
+		return false;
+	}
+
+	if (inode_state_read_once(sharedinode) & I_NEW) {
+		if (erofs_inode_set_aops(sharedinode, inode, true)) {
+			iget_failed(sharedinode);
+			kfree(fp.opaque);
+			return false;
+		}
+		sharedinode->i_size = vi->vfs_inode.i_size;
+		unlock_new_inode(sharedinode);
+	} else {
+		kfree(fp.opaque);
+		if (sharedinode->i_size != vi->vfs_inode.i_size) {
+			_erofs_printk(inode->i_sb, KERN_WARNING
+				"size(%lld:%lld) not matches for the same fingerprint\n",
+				vi->vfs_inode.i_size, sharedinode->i_size);
+			iput(sharedinode);
+			return false;
+		}
+	}
+	vi->sharedinode = sharedinode;
+	INIT_LIST_HEAD(&vi->ishare_list);
+	spin_lock(&EROFS_I(sharedinode)->ishare_lock);
+	list_add(&vi->ishare_list, &EROFS_I(sharedinode)->ishare_list);
+	spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
+	return true;
+}
+
+void erofs_ishare_free_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct inode *sharedinode = vi->sharedinode;
+
+	if (!sharedinode)
+		return;
+	spin_lock(&EROFS_I(sharedinode)->ishare_lock);
+	list_del(&vi->ishare_list);
+	spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
+	iput(sharedinode);
+	vi->sharedinode = NULL;
+}
+
+static int erofs_ishare_file_open(struct inode *inode, struct file *file)
+{
+	struct inode *sharedinode = EROFS_I(inode)->sharedinode;
+	struct file *realfile;
+
+	if (file->f_flags & O_DIRECT)
+		return -EINVAL;
+	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred());
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
+	ihold(sharedinode);
+	realfile->f_op = &erofs_file_fops;
+	realfile->f_inode = sharedinode;
+	realfile->f_mapping = sharedinode->i_mapping;
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
+	iput(realfile->f_inode);
+	fput(realfile);
+	file->private_data = NULL;
+	return 0;
+}
+
+static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
+					   struct iov_iter *to)
+{
+	struct file *realfile = iocb->ki_filp->private_data;
+	struct kiocb dedup_iocb;
+	ssize_t nread;
+
+	if (!iov_iter_count(to))
+		return 0;
+	kiocb_clone(&dedup_iocb, iocb, realfile);
+	nread = filemap_read(&dedup_iocb, to, 0);
+	iocb->ki_pos = dedup_iocb.ki_pos;
+	return nread;
+}
+
+static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct file *realfile = file->private_data;
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
+	return PTR_ERR_OR_ZERO(erofs_ishare_mnt);
+}
+
+void erofs_exit_ishare(void)
+{
+	kern_unmount(erofs_ishare_mnt);
+}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6fbe9220303a..32b57e78c9e0 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -396,6 +396,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
+	Opt_inode_share,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -423,6 +424,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("domain_id",	Opt_domain_id),
 	fsparam_flag_no("directio",	Opt_directio),
 	fsparam_u64("fsoffset",		Opt_fsoffset),
+	fsparam_flag("inode_share",	Opt_inode_share),
 	{}
 };
 
@@ -524,6 +526,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
 	case Opt_domain_id:
 		kfree_sensitive(sbi->domain_id);
 		sbi->domain_id = no_free_ptr(param->string);
@@ -549,6 +553,13 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_fsoffset:
 		sbi->dif0.fsoff = result.uint_64;
 		break;
+	case Opt_inode_share:
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		set_opt(&sbi->opt, INODE_SHARE);
+#else
+		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
+#endif
+		break;
 	}
 	return 0;
 }
@@ -647,6 +658,15 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &erofs_sops;
 
+	if (!sbi->domain_id && test_opt(&sbi->opt, INODE_SHARE)) {
+		errorfc(fc, "domain_id is needed when inode_ishare is on");
+		return -EINVAL;
+	}
+	if (test_opt(&sbi->opt, DAX_ALWAYS) && test_opt(&sbi->opt, INODE_SHARE)) {
+		errorfc(fc, "FSDAX is not allowed when inode_ishare is on");
+		return -EINVAL;
+	}
+
 	sbi->blkszbits = PAGE_SHIFT;
 	if (!sb->s_bdev) {
 		/*
@@ -717,6 +737,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		erofs_info(sb, "unsupported blocksize for DAX");
 		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
+	if (test_opt(&sbi->opt, INODE_SHARE) && !erofs_sb_has_ishare_xattrs(sbi)) {
+		erofs_info(sb, "on-disk ishare xattrs not found. Turning off inode_share.");
+		clear_opt(&sbi->opt, INODE_SHARE);
+	}
+	if (test_opt(&sbi->opt, INODE_SHARE))
+		erofs_info(sb, "EXPERIMENTAL EROFS page cache share support in use. Use at your own risk!");
 
 	sb->s_time_gran = 1;
 	sb->s_xattr = erofs_xattr_handlers;
@@ -946,10 +972,32 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
-#if defined(CONFIG_EROFS_FS_ONDEMAND)
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
+static void erofs_free_anon_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	kfree(vi->fingerprint.opaque);
+#endif
+	kmem_cache_free(erofs_inode_cachep, vi);
+}
+
+static const struct super_operations erofs_anon_sops = {
+	.alloc_inode = erofs_alloc_inode,
+	.drop_inode = inode_just_drop,
+	.free_inode = erofs_free_anon_inode,
+};
+
 static int erofs_anon_init_fs_context(struct fs_context *fc)
 {
-	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
+	struct pseudo_fs_context *ctx;
+
+	ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->ops = &erofs_anon_sops;
+	return 0;
 }
 
 struct file_system_type erofs_anon_fs_type = {
@@ -984,6 +1032,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto sysfs_err;
 
+	err = erofs_init_ishare();
+	if (err)
+		goto ishare_err;
+
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
 		goto fs_err;
@@ -991,6 +1043,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
+	erofs_exit_ishare();
+ishare_err:
 	erofs_exit_sysfs();
 sysfs_err:
 	z_erofs_exit_subsystem();
@@ -1008,6 +1062,7 @@ static void __exit erofs_module_exit(void)
 	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
 	rcu_barrier();
 
+	erofs_exit_ishare();
 	erofs_exit_sysfs();
 	z_erofs_exit_subsystem();
 	erofs_exit_shrinker();
@@ -1062,6 +1117,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #endif
 	if (sbi->dif0.fsoff)
 		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
+	if (test_opt(opt, INODE_SHARE))
+		seq_puts(seq, ",inode_share");
 	return 0;
 }
 
@@ -1072,6 +1129,7 @@ static void erofs_evict_inode(struct inode *inode)
 		dax_break_layout_final(inode);
 #endif
 
+	erofs_ishare_free_inode(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 }
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index ae61f20cb861..e1709059d3cc 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -577,3 +577,37 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 #endif
+
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+int erofs_xattr_fill_inode_fingerprint(struct erofs_inode_fingerprint *fp,
+				       struct inode *inode, const char *domain_id)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+	struct erofs_xattr_prefix_item *prefix;
+	const char *infix;
+	int valuelen, base_index;
+
+	if (!test_opt(&sbi->opt, INODE_SHARE))
+		return -EOPNOTSUPP;
+	if (!sbi->xattr_prefixes)
+		return -EINVAL;
+	prefix = sbi->xattr_prefixes + sbi->ishare_xattr_prefix_id;
+	infix = prefix->prefix->infix;
+	base_index = prefix->prefix->base_index;
+	valuelen = erofs_getxattr(inode, base_index, infix, NULL, 0);
+	if (valuelen <= 0 || valuelen > (1 << sbi->blkszbits))
+		return -EFSCORRUPTED;
+	fp->size = valuelen + (domain_id ? strlen(domain_id) : 0);
+	fp->opaque = kmalloc(fp->size, GFP_KERNEL);
+	if (!fp->opaque)
+		return -ENOMEM;
+	if (valuelen != erofs_getxattr(inode, base_index, infix,
+				       fp->opaque, valuelen)) {
+		kfree(fp->opaque);
+		fp->opaque = NULL;
+		return -EFSCORRUPTED;
+	}
+	memcpy(fp->opaque + valuelen, domain_id, fp->size - valuelen);
+	return 0;
+}
+#endif
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 6317caa8413e..bf75a580b8f1 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -67,4 +67,7 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu);
 #define erofs_get_acl	(NULL)
 #endif
 
+int erofs_xattr_fill_inode_fingerprint(struct erofs_inode_fingerprint *fp,
+				       struct inode *inode, const char *domain_id);
+
 #endif
-- 
2.22.0


