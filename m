Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8025244E6C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 13:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhKLMsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 07:48:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4090 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhKLMsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:48:54 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HrJBm5xPgz67bN5;
        Fri, 12 Nov 2021 20:42:24 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 13:46:00 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ebiggers@kernel.org>, <tytso@mit.edu>, <corbet@lwn.net>,
        <viro@zeniv.linux.org.uk>, <hughd@google.com>,
        <akpm@linux-foundation.org>
CC:     <linux-fscrypt@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 5/5] shmem: Add fsverity support
Date:   Fri, 12 Nov 2021 13:44:11 +0100
Message-ID: <20211112124411.1948809-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112124411.1948809-1-roberto.sassu@huawei.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the necessary modifications to support fsverity in tmpfs.

First, implement the fsverity operations (in a similar way of f2fs). These
operations make use of shmem_read_mapping_page() instead of
read_mapping_page() to handle the case where the page has been swapped out.
The fsverity descriptor is placed at the end of the file and its location
is stored in an xattr.

Second, implement the ioctl operations to enable, measure and read fsverity
metadata.

Lastly, add calls to fsverity functions, to ensure that fsverity-relevant
operations are checked and handled by fsverity (file open, attr set, inode
evict).

Fsverity support can be enabled through the kernel configuration and
remains enabled by default for every tmpfs filesystem instantiated (there
should be no overhead, unless fsverity is enabled for a file).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/filesystems/fsverity.rst |  18 ++
 MAINTAINERS                            |   1 +
 fs/Kconfig                             |   7 +
 fs/verity/enable.c                     |   6 +-
 include/linux/shmem_fs.h               |  27 +++
 mm/Makefile                            |   2 +
 mm/shmem.c                             |  69 ++++++-
 mm/shmem_verity.c                      | 267 +++++++++++++++++++++++++
 8 files changed, 394 insertions(+), 3 deletions(-)
 create mode 100644 mm/shmem_verity.c

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 1d831e3cbcb3..71186cebf15d 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -533,6 +533,24 @@ Currently, f2fs verity only supports a Merkle tree block size of 4096.
 Also, f2fs doesn't support enabling verity on files that currently
 have atomic or volatile writes pending.
 
+tmpfs
+-----
+
+tmpfs supports fsverity since Linux v5.17.
+
+Fsverity support for tmpfs can be enabled at build time through the kernel
+configuration option ``CONFIG_TMPFS_VERITY``. If enabled, it is also
+automatically enabled at mount time for every tmpfs filesystem
+instantiated.
+
+Like f2fs, tmpfs stores the verity metadata (Merkle tree and
+fsverity_descriptor) past the end of the file, starting at the first
+64K boundary beyond i_size. Also, like f2fs, it stores the fsverity
+descriptor location in an xattr.
+
+Currently, tmpfs verity only supports the case where the Merkle tree
+block size and page size are the same.
+
 Implementation details
 ======================
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 9096c64d8d09..118cf9d58601 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19137,6 +19137,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/shmem_fs.h
 F:	mm/shmem.c
+F:	mm/shmem_verity.c
 
 TOMOYO SECURITY MODULE
 M:	Kentaro Takeda <takedakn@nttdata.co.jp>
diff --git a/fs/Kconfig b/fs/Kconfig
index a6313a969bc5..d67f7a1cdcb6 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -229,6 +229,13 @@ config TMPFS_INODE64
 
 	  If unsure, say N.
 
+config TMPFS_VERITY
+	bool "fsverity support for tmpfs (EXPERIMENTAL)"
+	depends on FS_VERITY && TMPFS && TMPFS_XATTR
+
+	help
+	  Enable fsverity protection for files in the tmpfs filesystem.
+
 config ARCH_SUPPORTS_HUGETLBFS
 	def_bool n
 
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 60a4372aa4d7..9cd64cbe3579 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
+#include <linux/shmem_fs.h>
 
 /*
  * Read a file data page for Merkle tree construction.  Do aggressive readahead,
@@ -31,7 +32,10 @@ static struct page *read_file_data_page(struct file *filp, pgoff_t index,
 		else
 			page_cache_sync_readahead(filp->f_mapping, ra, filp,
 						  index, remaining_pages);
-		page = read_mapping_page(filp->f_mapping, index, NULL);
+		if (shmem_file(filp))
+			page = shmem_read_mapping_page(filp->f_mapping, index);
+		else
+			page = read_mapping_page(filp->f_mapping, index, NULL);
 		if (IS_ERR(page))
 			return page;
 	}
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 166158b6e917..07b9a142c7d3 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -10,6 +10,9 @@
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
 
+#define SHMEM_VERITY_IN_PROGRESS 0x00000001
+#define SHMEM_XATTR_NAME_VERITY "v"
+
 /* inode in-kernel data */
 
 struct shmem_inode_info {
@@ -44,6 +47,7 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+	bool verity;		      /* Fsverity enabled or not */
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
@@ -51,10 +55,33 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
 	return container_of(inode, struct shmem_inode_info, vfs_inode);
 }
 
+static inline bool shmem_verity_in_progress(struct inode *inode)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	return IS_ENABLED(CONFIG_FS_VERITY) &&
+	       (info->flags & SHMEM_VERITY_IN_PROGRESS);
+}
+
+static inline void shmem_verity_set_in_progress(struct inode *inode)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	info->flags |= SHMEM_VERITY_IN_PROGRESS;
+}
+
+static inline void shmem_verity_clear_in_progress(struct inode *inode)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	info->flags &= ~SHMEM_VERITY_IN_PROGRESS;
+}
+
 /*
  * Functions in mm/shmem.c called directly from elsewhere:
  */
 extern const struct fs_parameter_spec shmem_fs_parameters[];
+extern const struct fsverity_operations shmem_verityops;
 extern int shmem_init(void);
 extern int shmem_init_fs_context(struct fs_context *fc);
 extern struct file *shmem_file_setup(const char *name,
diff --git a/mm/Makefile b/mm/Makefile
index d6c0042e3aa0..f15b48dbd235 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -54,6 +54,8 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
 
+obj-$(CONFIG_TMPFS_VERITY)	+= shmem_verity.o
+
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
 page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
diff --git a/mm/shmem.c b/mm/shmem.c
index 427863cbf0dc..f36e1a493610 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -78,6 +78,7 @@ static struct vfsmount *shm_mnt;
 #include <linux/userfaultfd_k.h>
 #include <linux/rmap.h>
 #include <linux/uuid.h>
+#include <linux/fsverity.h>
 
 #include <linux/uaccess.h>
 
@@ -1089,6 +1090,10 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 	if (error)
 		return error;
 
+	error = fsverity_prepare_setattr(dentry, attr);
+	if (error)
+		return error;
+
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
@@ -1156,6 +1161,7 @@ static void shmem_evict_inode(struct inode *inode)
 		}
 	}
 
+	fsverity_cleanup_inode(inode);
 	simple_xattrs_free(&info->xattrs);
 	WARN_ON(inode->i_blocks);
 	shmem_free_inode(inode->i_sb);
@@ -1827,7 +1833,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		return -EFBIG;
 repeat:
 	if (sgp <= SGP_CACHE &&
-	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode)) {
+	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode) &&
+	    !fsverity_active(inode) && !shmem_verity_in_progress(inode)) {
 		return -EINVAL;
 	}
 
@@ -2485,7 +2492,7 @@ shmem_write_end(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 
-	if (pos + copied > inode->i_size)
+	if (pos + copied > inode->i_size && !shmem_verity_in_progress(inode))
 		i_size_write(inode, pos + copied);
 
 	if (!PageUptodate(page)) {
@@ -2805,6 +2812,56 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	return error;
 }
 
+static bool shmem_sb_has_verity(struct inode *inode)
+{
+	return SHMEM_SB(inode->i_sb)->verity;
+}
+
+static int shmem_ioc_enable_verity(struct file *filp, unsigned long arg)
+{
+	if (!shmem_sb_has_verity(file_inode(filp)))
+		return -EOPNOTSUPP;
+
+	return fsverity_ioctl_enable(filp, (const void __user *)arg);
+}
+
+static int shmem_ioc_measure_verity(struct file *filp, unsigned long arg)
+{
+	if (!shmem_sb_has_verity(file_inode(filp)))
+		return -EOPNOTSUPP;
+
+	return fsverity_ioctl_measure(filp, (void __user *)arg);
+}
+
+static int shmem_ioc_read_verity_metadata(struct file *filp, unsigned long arg)
+{
+	if (!shmem_sb_has_verity(file_inode(filp)))
+		return -EOPNOTSUPP;
+
+	return fsverity_ioctl_read_metadata(filp, (const void __user *)arg);
+}
+
+static long shmem_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case FS_IOC_ENABLE_VERITY:
+		return shmem_ioc_enable_verity(filp, arg);
+	case FS_IOC_MEASURE_VERITY:
+		return shmem_ioc_measure_verity(filp, arg);
+	case FS_IOC_READ_VERITY_METADATA:
+		return shmem_ioc_read_verity_metadata(filp, arg);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+#ifdef CONFIG_TMPFS_VERITY
+static int shmem_file_open(struct inode *inode, struct file *filp)
+{
+	return fsverity_file_open(inode, filp);
+}
+#endif
+
 static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(dentry->d_sb);
@@ -3673,6 +3730,10 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_export_op = &shmem_export_ops;
 	sb->s_flags |= SB_NOSEC;
+#ifdef CONFIG_TMPFS_VERITY
+	sb->s_vop = &shmem_verityops;
+	sbinfo->verity = true;
+#endif
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
@@ -3825,6 +3886,10 @@ static const struct file_operations shmem_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.unlocked_ioctl	= shmem_ioctl,
+#ifdef CONFIG_TMPFS_VERITY
+	.open		= shmem_file_open,
+#endif
 #endif
 };
 
diff --git a/mm/shmem_verity.c b/mm/shmem_verity.c
new file mode 100644
index 000000000000..f5f5c7394dda
--- /dev/null
+++ b/mm/shmem_verity.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ * Copyright 2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+/*
+ * Implementation of fsverity_operations for tmpfs.
+ *
+ * Like ext4, tmpfs stores the verity metadata (Merkle tree and
+ * fsverity_descriptor) past the end of the file, starting at the first 64K
+ * boundary beyond i_size.
+ *
+ * Using a 64K boundary rather than a 4K one keeps things ready for
+ * architectures with 64K pages, and it doesn't necessarily waste space on-disk
+ * since there can be a hole between i_size and the start of the Merkle tree.
+ */
+
+#include <linux/xattr.h>
+#include <linux/fsverity.h>
+#include <linux/shmem_fs.h>
+#include <linux/quotaops.h>
+
+#define SHMEM_VERIFY_VER	(1)
+
+static inline loff_t shmem_verity_metadata_pos(const struct inode *inode)
+{
+	return round_up(inode->i_size, 65536);
+}
+
+/*
+ * Read some verity metadata from the inode.  __vfs_read() can't be used because
+ * we need to read beyond i_size.
+ */
+static int pagecache_read(struct inode *inode, void *buf, size_t count,
+			  loff_t pos)
+{
+	while (count) {
+		size_t n = min_t(size_t, count,
+				 PAGE_SIZE - offset_in_page(pos));
+		struct page *page;
+		void *addr;
+
+		page = shmem_read_mapping_page(inode->i_mapping,
+					       pos >> PAGE_SHIFT);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		addr = kmap_atomic(page);
+		memcpy(buf, addr + offset_in_page(pos), n);
+		kunmap_atomic(addr);
+
+		put_page(page);
+
+		buf += n;
+		pos += n;
+		count -= n;
+	}
+	return 0;
+}
+
+/*
+ * Write some verity metadata to the inode for FS_IOC_ENABLE_VERITY.
+ * kernel_write() can't be used because the file descriptor is readonly.
+ */
+static int pagecache_write(struct inode *inode, const void *buf, size_t count,
+			   loff_t pos)
+{
+	if (pos + count > inode->i_sb->s_maxbytes)
+		return -EFBIG;
+
+	while (count) {
+		size_t n = min_t(size_t, count,
+				 PAGE_SIZE - offset_in_page(pos));
+		struct page *page;
+		void *fsdata;
+		void *addr;
+		int res;
+
+		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
+					    &page, &fsdata);
+		if (res)
+			return res;
+
+		addr = kmap_atomic(page);
+		memcpy(addr + offset_in_page(pos), buf, n);
+		kunmap_atomic(addr);
+
+		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
+					  page, fsdata);
+		if (res < 0)
+			return res;
+		if (res != n)
+			return -EIO;
+
+		buf += n;
+		pos += n;
+		count -= n;
+	}
+	return 0;
+}
+
+/*
+ * Format of tmpfs verity xattr.  This points to the location of the verity
+ * descriptor within the file data rather than containing it (the code was taken
+ * from fs/f2fs/verity.c).
+ */
+struct fsverity_descriptor_location {
+	__le32 version;
+	__le32 size;
+	__le64 pos;
+};
+
+static int shmem_begin_enable_verity(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+	int err;
+
+	if (shmem_verity_in_progress(inode))
+		return -EBUSY;
+
+	/*
+	 * Since the file was opened readonly, we have to initialize the quotas
+	 * here and not rely on ->open() doing it.
+	 */
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
+	shmem_verity_set_in_progress(inode);
+	return 0;
+}
+
+static int shmem_end_enable_verity(struct file *filp, const void *desc,
+				   size_t desc_size, u64 merkle_tree_size)
+{
+	struct inode *inode = file_inode(filp);
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	u64 desc_pos = shmem_verity_metadata_pos(inode) + merkle_tree_size;
+	struct fsverity_descriptor_location dloc = {
+		.version = cpu_to_le32(SHMEM_VERIFY_VER),
+		.size = cpu_to_le32(desc_size),
+		.pos = cpu_to_le64(desc_pos),
+	};
+	int err = 0;
+
+	/*
+	 * If an error already occurred (which fs/verity/ signals by passing
+	 * desc == NULL), then only clean-up is needed.
+	 */
+	if (desc == NULL)
+		goto cleanup;
+
+	/* Append the verity descriptor. */
+	err = pagecache_write(inode, desc, desc_size, desc_pos);
+	if (err)
+		goto cleanup;
+
+	/*
+	 * Write all pages (both data and verity metadata).  Note that this must
+	 * happen before clearing SHMEM_VERITY_IN_PROGRESS; otherwise pages
+	 * beyond i_size won't be written properly.
+	 */
+	err = filemap_write_and_wait(inode->i_mapping);
+	if (err)
+		goto cleanup;
+
+	/* Set the verity xattr. */
+	err = simple_xattr_set(&info->xattrs, SHMEM_XATTR_NAME_VERITY, &dloc,
+			       sizeof(dloc), XATTR_CREATE, NULL);
+	if (err)
+		goto cleanup;
+
+	/* Finally, set the verity inode flag. */
+	inode_set_flags(inode, S_VERITY, inode->i_flags | S_VERITY);
+	mark_inode_dirty_sync(inode);
+
+	shmem_verity_clear_in_progress(inode);
+	return 0;
+
+cleanup:
+	/*
+	 * Verity failed to be enabled, so clean up by truncating any verity
+	 * metadata that was written beyond i_size (both from cache and from
+	 * disk) and clearing FI_VERITY_IN_PROGRESS.
+	 */
+	shmem_truncate_range(inode, 0, inode->i_size);
+	shmem_verity_clear_in_progress(inode);
+	return err;
+}
+
+static int shmem_get_verity_descriptor(struct inode *inode, void *buf,
+				       size_t buf_size)
+{
+	struct fsverity_descriptor_location dloc;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	int res;
+	u32 size;
+	u64 pos;
+
+	/* Get the descriptor location */
+	res = simple_xattr_get(&info->xattrs, SHMEM_XATTR_NAME_VERITY, &dloc,
+			       sizeof(dloc));
+	if (res < 0 && res != -ERANGE)
+		return res;
+	if (res != sizeof(dloc) ||
+	    dloc.version != cpu_to_le32(SHMEM_VERIFY_VER)) {
+		pr_err("Unknown verity xattr format inode %lu\n", inode->i_ino);
+		return -EINVAL;
+	}
+	size = le32_to_cpu(dloc.size);
+	pos = le64_to_cpu(dloc.pos);
+
+	/* Get the descriptor */
+	if (pos + size < pos || pos + size > inode->i_sb->s_maxbytes ||
+	    pos < shmem_verity_metadata_pos(inode) || size > INT_MAX) {
+		pr_err("Invalid verity xattr for inode %lu\n", inode->i_ino);
+		return -EINVAL;
+	}
+	if (buf_size) {
+		if (size > buf_size)
+			return -ERANGE;
+		res = pagecache_read(inode, buf, size, pos);
+		if (res)
+			return res;
+	}
+	return size;
+}
+
+static struct page *shmem_read_merkle_tree_page(struct inode *inode,
+						pgoff_t index,
+						unsigned long num_ra_pages)
+{
+	DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
+	struct page *page;
+
+	index += shmem_verity_metadata_pos(inode) >> PAGE_SHIFT;
+
+	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
+	if (!page || !PageUptodate(page)) {
+		if (page)
+			put_page(page);
+		else if (num_ra_pages > 1)
+			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
+		page = shmem_read_mapping_page(inode->i_mapping, index);
+	}
+	return page;
+}
+
+static int shmem_write_merkle_tree_block(struct inode *inode, const void *buf,
+					 u64 index, int log_blocksize)
+{
+	loff_t pos = shmem_verity_metadata_pos(inode) +
+		     (index << log_blocksize);
+
+	return pagecache_write(inode, buf, 1 << log_blocksize, pos);
+}
+
+const struct fsverity_operations shmem_verityops = {
+	.begin_enable_verity	= shmem_begin_enable_verity,
+	.end_enable_verity	= shmem_end_enable_verity,
+	.get_verity_descriptor	= shmem_get_verity_descriptor,
+	.read_merkle_tree_page	= shmem_read_merkle_tree_page,
+	.write_merkle_tree_block = shmem_write_merkle_tree_block,
+};
-- 
2.32.0

