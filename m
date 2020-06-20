Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE6202239
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgFTHRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgFTHRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:17:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F02C06174E;
        Sat, 20 Jun 2020 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TqmbBd7dwuqGjumJRX50l0lFnn1rKVRRBCHPPMmkIoI=; b=eQHCx46FmylXF2ePARsM0Lz0cV
        sklgbx88qgJNr2G3j59RMoWZve+NSAiN/cCOH9DomIr8aNfJYMniiWhiVGpyE/26+TCLhOUW0s58i
        ZedSSW6WjkBntL2LfXBJm/xz22e0lrbKH6GWJjxP2oaLEWWs/BCjoBa8GegfwVNwy8nrxm1zcO3G2
        vsWUC3uLdl6EZt+cjjQ3AVxXNm2cg3t7rFHTc6KdJz0gOGl/mUF/nR2jfWFqBGDWHpwYB/OWkD0TA
        A/+paOMV7iOBWhblyJ0PRkCSg0VIjaa6we5ar1kBjRczbqptmpBAGdgWFX08rb7a4TYjyOwrN6niX
        FfRADfxw==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXkR-0003tC-2v; Sat, 20 Jun 2020 07:17:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] block: move block-related definitions out of fs.h
Date:   Sat, 20 Jun 2020 09:16:41 +0200
Message-Id: <20200620071644.463185-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620071644.463185-1-hch@lst.de>
References: <20200620071644.463185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move most of the block related definition out of fs.h into more suitable
headers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/affs/file.c             |  1 +
 fs/hfs/inode.c             |  1 +
 fs/internal.h              | 17 ++++++-
 fs/ntfs/dir.c              |  1 +
 fs/proc/devices.c          |  1 +
 fs/quota/dquot.c           |  1 +
 fs/reiserfs/procfs.c       |  1 +
 include/linux/blkdev.h     | 46 +++++++++++++++++++
 include/linux/fs.h         | 92 --------------------------------------
 include/linux/genhd.h      | 27 +++++++++++
 include/linux/jbd2.h       |  1 +
 security/loadpin/loadpin.c |  1 +
 12 files changed, 96 insertions(+), 94 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index a85817f54483f7..a26a0f96c1197a 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/uio.h>
+#include <linux/blkdev.h>
 #include "affs.h"
 
 static struct buffer_head *affs_get_extblock_slow(struct inode *inode, u32 ext);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2f224b98ee94a6..f35a37c65e5fff 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -17,6 +17,7 @@
 #include <linux/cred.h>
 #include <linux/uio.h>
 #include <linux/xattr.h>
+#include <linux/blkdev.h>
 
 #include "hfs_fs.h"
 #include "btree.h"
diff --git a/fs/internal.h b/fs/internal.h
index 9b863a7bd70892..969988d3d39732 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -23,7 +23,9 @@ struct user_namespace;
 extern void __init bdev_cache_init(void);
 
 extern int __sync_blockdev(struct block_device *bdev, int wait);
-
+void iterate_bdevs(void (*)(struct block_device *, void *), void *);
+void emergency_thaw_bdev(struct super_block *sb);
+void bd_forget(struct inode *inode);
 #else
 static inline void bdev_cache_init(void)
 {
@@ -33,7 +35,18 @@ static inline int __sync_blockdev(struct block_device *bdev, int wait)
 {
 	return 0;
 }
-#endif
+static inline void iterate_bdevs(void (*f)(struct block_device *, void *),
+		void *arg)
+{
+}
+static inline int emergency_thaw_bdev(struct super_block *sb)
+{
+	return 0;
+}
+static inline void bd_forget(struct inode *inode)
+{
+}
+#endif /* CONFIG_BLOCK */
 
 /*
  * buffer.c
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 3c4811469ae863..a87d4391e6b55d 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -8,6 +8,7 @@
 
 #include <linux/buffer_head.h>
 #include <linux/slab.h>
+#include <linux/blkdev.h>
 
 #include "dir.h"
 #include "aops.h"
diff --git a/fs/proc/devices.c b/fs/proc/devices.c
index 37d38697eaf876..837971e7410978 100644
--- a/fs/proc/devices.c
+++ b/fs/proc/devices.c
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/blkdev.h>
 
 static int devinfo_show(struct seq_file *f, void *v)
 {
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 7b4bac91146b51..bb02989d92b618 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -78,6 +78,7 @@
 #include <linux/namei.h>
 #include <linux/capability.h>
 #include <linux/quotaops.h>
+#include <linux/blkdev.h>
 #include "../internal.h" /* ugh */
 
 #include <linux/uaccess.h>
diff --git a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
index ff336513c2544c..155b8287033361 100644
--- a/fs/reiserfs/procfs.c
+++ b/fs/reiserfs/procfs.c
@@ -15,6 +15,7 @@
 #include "reiserfs.h"
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/blkdev.h>
 
 /*
  * LOCKING:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e2e..50fccb121b876e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1920,4 +1920,50 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 }
 #endif /* CONFIG_BLOCK */
 
+int bdev_read_only(struct block_device *bdev);
+int set_blocksize(struct block_device *bdev, int size);
+
+const char *bdevname(struct block_device *bdev, char *buffer);
+struct block_device *lookup_bdev(const char *);
+
+void blkdev_show(struct seq_file *seqf, off_t offset);
+
+#define BDEVNAME_SIZE	32	/* Largest string for a blockdev identifier */
+#define BDEVT_SIZE	10	/* Largest string for MAJ:MIN for blkdev */
+#ifdef CONFIG_BLOCK
+#define BLKDEV_MAJOR_MAX	512
+#else
+#define BLKDEV_MAJOR_MAX	0
+#endif
+
+int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder);
+struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
+		void *holder);
+struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder);
+struct block_device *bd_start_claiming(struct block_device *bdev, void *holder);
+void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
+		void *holder);
+void blkdev_put(struct block_device *bdev, fmode_t mode);
+
+struct block_device *bdget(dev_t);
+struct block_device *bdgrab(struct block_device *bdev);
+void bdput(struct block_device *);
+
+#ifdef CONFIG_BLOCK
+void invalidate_bdev(struct block_device *bdev);
+int sync_blockdev(struct block_device *bdev);
+#else
+static inline void invalidate_bdev(struct block_device *bdev)
+{
+}
+static inline int sync_blockdev(struct block_device *bdev)
+{
+	return 0;
+}
 #endif
+int fsync_bdev(struct block_device *bdev);
+
+struct super_block *freeze_bdev(struct block_device *bdev);
+int thaw_bdev(struct block_device *bdev, struct super_block *sb);
+
+#endif /* _LINUX_BLKDEV_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7f3ae38335d4b3..add30c3bdf9a28 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2563,79 +2563,10 @@ static inline bool sb_is_blkdev_sb(struct super_block *sb)
 	return IS_ENABLED(CONFIG_BLOCK) && sb == blockdev_superblock;
 }
 
-#ifdef CONFIG_BLOCK
-extern int register_blkdev(unsigned int, const char *);
-extern void unregister_blkdev(unsigned int, const char *);
-extern struct block_device *bdget(dev_t);
-extern struct block_device *bdgrab(struct block_device *bdev);
-extern void bd_set_size(struct block_device *, loff_t size);
-extern void bd_forget(struct inode *inode);
-extern void bdput(struct block_device *);
-extern void invalidate_bdev(struct block_device *);
-extern void iterate_bdevs(void (*)(struct block_device *, void *), void *);
-extern int sync_blockdev(struct block_device *bdev);
-extern struct super_block *freeze_bdev(struct block_device *);
-extern void emergency_thaw_bdev(struct super_block *sb);
-extern int thaw_bdev(struct block_device *bdev, struct super_block *sb);
-extern int fsync_bdev(struct block_device *);
-#else
-static inline void bd_forget(struct inode *inode) {}
-static inline int sync_blockdev(struct block_device *bdev) { return 0; }
-static inline void invalidate_bdev(struct block_device *bdev) {}
-
-static inline struct super_block *freeze_bdev(struct block_device *sb)
-{
-	return NULL;
-}
-
-static inline int thaw_bdev(struct block_device *bdev, struct super_block *sb)
-{
-	return 0;
-}
-
-static inline int emergency_thaw_bdev(struct super_block *sb)
-{
-	return 0;
-}
-
-static inline void iterate_bdevs(void (*f)(struct block_device *, void *), void *arg)
-{
-}
-#endif
 void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
-#ifdef CONFIG_BLOCK
-extern int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
-extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
-extern int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder);
-extern struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
-					       void *holder);
-extern struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode,
-					      void *holder);
-extern struct block_device *bd_start_claiming(struct block_device *bdev,
-					      void *holder);
-extern void bd_abort_claiming(struct block_device *bdev,
-			      struct block_device *whole, void *holder);
-extern void blkdev_put(struct block_device *bdev, fmode_t mode);
-
-#ifdef CONFIG_SYSFS
-extern int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
-extern void bd_unlink_disk_holder(struct block_device *bdev,
-				  struct gendisk *disk);
-#else
-static inline int bd_link_disk_holder(struct block_device *bdev,
-				      struct gendisk *disk)
-{
-	return 0;
-}
-static inline void bd_unlink_disk_holder(struct block_device *bdev,
-					 struct gendisk *disk)
-{
-}
-#endif
-#endif
 
 /* fs/char_dev.c */
 #define CHRDEV_MAJOR_MAX 512
@@ -2666,31 +2597,12 @@ static inline void unregister_chrdev(unsigned int major, const char *name)
 	__unregister_chrdev(major, 0, 256, name);
 }
 
-/* fs/block_dev.c */
-#define BDEVNAME_SIZE	32	/* Largest string for a blockdev identifier */
-#define BDEVT_SIZE	10	/* Largest string for MAJ:MIN for blkdev */
-
-#ifdef CONFIG_BLOCK
-#define BLKDEV_MAJOR_MAX	512
-extern const char *bdevname(struct block_device *bdev, char *buffer);
-extern struct block_device *lookup_bdev(const char *);
-extern void blkdev_show(struct seq_file *,off_t);
-
-#else
-#define BLKDEV_MAJOR_MAX	0
-#endif
-
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 
 /* Invalid inode operations -- fs/bad_inode.c */
 extern void make_bad_inode(struct inode *);
 extern bool is_bad_inode(struct inode *);
 
-#ifdef CONFIG_BLOCK
-extern int revalidate_disk(struct gendisk *);
-extern int check_disk_change(struct block_device *);
-extern int __invalidate_device(struct block_device *, bool);
-#endif
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
 
@@ -3090,10 +3002,6 @@ static inline void remove_inode_hash(struct inode *inode)
 
 extern void inode_sb_list_add(struct inode *inode);
 
-#ifdef CONFIG_BLOCK
-extern int bdev_read_only(struct block_device *);
-#endif
-extern int set_blocksize(struct block_device *, int);
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 392aad5e29a231..83f8e0d8322836 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -373,6 +373,33 @@ extern void blk_unregister_region(dev_t devt, unsigned long range);
 
 #define alloc_disk(minors) alloc_disk_node(minors, NUMA_NO_NODE)
 
+int register_blkdev(unsigned int major, const char *name);
+void unregister_blkdev(unsigned int major, const char *name);
+
+int revalidate_disk(struct gendisk *disk);
+int check_disk_change(struct block_device *bdev);
+int __invalidate_device(struct block_device *bdev, bool kill_dirty);
+void bd_set_size(struct block_device *bdev, loff_t size);
+
+/* for drivers/char/raw.c: */
+int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
+long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
+
+#ifdef CONFIG_SYSFS
+int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
+void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
+#else
+static inline int bd_link_disk_holder(struct block_device *bdev,
+				      struct gendisk *disk)
+{
+	return 0;
+}
+static inline void bd_unlink_disk_holder(struct block_device *bdev,
+					 struct gendisk *disk)
+{
+}
+#endif /* CONFIG_SYSFS */
+
 #else /* CONFIG_BLOCK */
 
 static inline void printk_all_partitions(void) { }
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f613d8529863f6..ef3f9e1ce8ad2d 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -27,6 +27,7 @@
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <linux/bit_spinlock.h>
+#include <linux/blkdev.h>
 #include <crypto/hash.h>
 #endif
 
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ee5cb944f4ad1b..670a1aebb8a10f 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mount.h>
+#include <linux/blkdev.h>
 #include <linux/path.h>
 #include <linux/sched.h>	/* current */
 #include <linux/string_helpers.h>
-- 
2.26.2

