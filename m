Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E595B8B99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395097AbfITHfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 03:35:44 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:39034 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394988AbfITHfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:35:44 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id C5F672E1461;
        Fri, 20 Sep 2019 10:35:38 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id CoddOUhSFp-ZbEKFIug;
        Fri, 20 Sep 2019 10:35:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1568964938; bh=Hj95Qr+4U0tc98/OWdUgA3oRvIm+K5SYPEfdofeqSyY=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=pCsSYF8oArAGcMxaW1WuB+00ZUCoz9KM7+WRFxLF9oMod48eLZ8YimczxNfWDBDE6
         GToDlnclZ/ud2ahFvsYU4FX2d6hxd7MVJF8kTSnapMUKMX4Gi8mpKnqfmz3cVWXgHl
         fmDthuzHo1G8sukmofu9OxcpXORB3YmriS75uwFY=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:344a:8fe6:6594:f7b2])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id c7BAw2bpK5-ZbIqwOKk;
        Fri, 20 Sep 2019 10:35:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 10:35:37 +0300
Message-ID: <156896493723.4334.13340481207144634918.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Traditional writeback tries to accumulate as much dirty data as possible.
This is worth strategy for extremely short-living files and for batching
writes for saving battery power. But for workloads where disk latency is
important this policy generates periodic disk load spikes which increases
latency for concurrent operations.

Also dirty pages in file cache cannot be reclaimed and reused immediately.
This way massive I/O like file copying affects memory allocation latency.

Present writeback engine allows to tune only dirty data size or expiration
time. Such tuning cannot eliminate spikes - this just lowers and multiplies
them. Other option is switching into sync mode which flushes written data
right after each write, obviously this have significant performance impact.
Such tuning is system-wide and affects memory-mapped and randomly written
files, flusher threads handle them much better.

This patch implements write-behind policy which tracks sequential writes
and starts background writeback when file have enough dirty pages.

Global switch in sysctl vm.dirty_write_behind:
=0: disabled, default
=1: enabled for strictly sequential writes (append, copying)
=2: enabled for all sequential writes

The only parameter is window size: maximum amount of dirty pages behind
current position and maximum amount of pages in background writeback.

Setup is per-disk in sysfs in file /sys/block/$DISK/bdi/write_behind_kb.
Default: 16MiB, '0' disables write-behind for this disk.

When amount of unwritten pages exceeds window size write-behind starts
background writeback for max(excess, max_sectors_kb) and then waits for
the same amount of background writeback initiated at previously.

 |<-wait-this->|           |<-send-this->|<---pending-write-behind--->|
 |<--async-write-behind--->|<--------previous-data------>|<-new-data->|
              current head-^    new head-^              file position-^

Remaining tail pages are flushed at closing file if async write-behind was
started or this is new file and it is at least max_sectors_kb long.

Overall behavior depending on total data size:
< max_sectors_kb - no writes
> max_sectors_kb - write new files in background after close
> write_behind_kb - streaming write, write tail at close

Special cases:

* files with POSIX_FADV_RANDOM, O_DIRECT, O_[D]SYNC are ignored

* writing cursor for O_APPEND is aligned to covers previous small appends
  Append might happen via multiple files or via new file each time.

* mode vm.dirty_write_behind=1 ignores non-append writes
  This reacts only to completely sequential writes like copying files,
  writing logs with O_APPEND or rewriting files after O_TRUNC.

Note: ext4 feature "auto_da_alloc" also writes cache at closing file
after truncating it to 0 and after renaming one file over other.

Changes since v1 (2017-10-02):
* rework window management:
* change default window 1MiB -> 16MiB
* change default request 256KiB -> max_sectors_kb
* drop always-async behavior for O_NONBLOCK
* drop handling POSIX_FADV_NOREUSE (should be in separate patch)
* ignore writes with O_DIRECT, O_SYNC, O_DSYNC
* align head position for O_APPEND
* add strictly sequential mode
* write tail pages for new files
* make void, keep errors at mapping

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/patchwork/patch/836149/ (v1)
---
 Documentation/ABI/testing/sysfs-class-bdi |    5 +
 Documentation/admin-guide/sysctl/vm.rst   |   15 +++
 fs/file_table.c                           |    2 
 include/linux/backing-dev-defs.h          |    1 
 include/linux/fs.h                        |    8 +-
 include/linux/mm.h                        |    1 
 kernel/sysctl.c                           |    9 ++
 mm/backing-dev.c                          |   43 +++++----
 mm/filemap.c                              |  136 +++++++++++++++++++++++++++++
 9 files changed, 199 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-bdi b/Documentation/ABI/testing/sysfs-class-bdi
index d773d5697cf5..f16be656cbd5 100644
--- a/Documentation/ABI/testing/sysfs-class-bdi
+++ b/Documentation/ABI/testing/sysfs-class-bdi
@@ -30,6 +30,11 @@ read_ahead_kb (read-write)
 
 	Size of the read-ahead window in kilobytes
 
+write_behind_kb (read-write)
+
+	Size of the write-behind window in kilobytes.
+	0 -> disable write-behind for this disk.
+
 min_ratio (read-write)
 
 	Under normal circumstances each device is given a part of the
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 64aeee1009ca..a275fa42579f 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -35,6 +35,7 @@ Currently, these files are in /proc/sys/vm:
 - dirty_ratio
 - dirtytime_expire_seconds
 - dirty_writeback_centisecs
+- dirty_write_behind
 - drop_caches
 - extfrag_threshold
 - hugetlb_shm_group
@@ -210,6 +211,20 @@ out to disk.  This tunable expresses the interval between those wakeups, in
 Setting this to zero disables periodic writeback altogether.
 
 
+dirty_write_behind
+==================
+
+This controls write-behind writeback policy - automatic background writeback
+for sequentially written data behind current writing position.
+
+=0: disabled, default
+=1: enabled for strictly sequential writes (append, copying)
+=2: enabled for all sequential writes
+
+Write-behind window size configured in sysfs for each block device:
+/sys/block/$DEV/bdi/write_behind_kb
+
+
 drop_caches
 ===========
 
diff --git a/fs/file_table.c b/fs/file_table.c
index b07b53f24ff5..bb40b45f27d3 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -276,6 +276,8 @@ static void __fput(struct file *file)
 		if (file->f_op->fasync)
 			file->f_op->fasync(-1, file, 0);
 	}
+	if ((mode & FMODE_WRITE) && vm_dirty_write_behind)
+		generic_write_behind_close(file);
 	if (file->f_op->release)
 		file->f_op->release(inode, file);
 	if (unlikely(S_ISCHR(inode->i_mode) && inode->i_cdev != NULL &&
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 4fc87dee005a..4f1abd1d64a7 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -191,6 +191,7 @@ struct backing_dev_info {
 	struct list_head bdi_list;
 	unsigned long ra_pages;	/* max readahead in PAGE_SIZE units */
 	unsigned long io_pages;	/* max allowed IO size */
+	unsigned long write_behind_pages; /* write-behind window in pages */
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
 	void *congested_data;	/* Pointer to aux data for congested func */
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 997a530ff4e9..42cad18aaec7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -942,6 +942,7 @@ struct file {
 	struct fown_struct	f_owner;
 	const struct cred	*f_cred;
 	struct file_ra_state	f_ra;
+	pgoff_t			f_write_behind;
 
 	u64			f_version;
 #ifdef CONFIG_SECURITY
@@ -2788,6 +2789,10 @@ extern int vfs_fsync(struct file *file, int datasync);
 extern int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 				unsigned int flags);
 
+extern int vm_dirty_write_behind;
+extern void generic_write_behind(struct kiocb *iocb, ssize_t count);
+extern void generic_write_behind_close(struct file *file);
+
 /*
  * Sync the bytes written if this was a synchronous write.  Expect ki_pos
  * to already be updated for the write, and will return either the amount
@@ -2801,7 +2806,8 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
 		if (ret)
 			return ret;
-	}
+	} else if (vm_dirty_write_behind)
+		generic_write_behind(iocb, count);
 
 	return count;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0334ca97c584..1b47a6e06ef2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2443,6 +2443,7 @@ void task_dirty_inc(struct task_struct *tsk);
 
 /* readahead.c */
 #define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
+#define VM_WRITE_BEHIND_PAGES	(SZ_16M / PAGE_SIZE)
 
 int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			pgoff_t offset, unsigned long nr_to_read);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 078950d9605b..74b6b66ee8da 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1404,6 +1404,15 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= dirtytime_interval_handler,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "dirty_write_behind",
+		.data		= &vm_dirty_write_behind,
+		.maxlen		= sizeof(vm_dirty_write_behind),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &two,
+	},
 	{
 		.procname	= "swappiness",
 		.data		= &vm_swappiness,
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index d9daa3e422d0..7fee95c02862 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -131,25 +131,6 @@ static inline void bdi_debug_unregister(struct backing_dev_info *bdi)
 }
 #endif
 
-static ssize_t read_ahead_kb_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct backing_dev_info *bdi = dev_get_drvdata(dev);
-	unsigned long read_ahead_kb;
-	ssize_t ret;
-
-	ret = kstrtoul(buf, 10, &read_ahead_kb);
-	if (ret < 0)
-		return ret;
-
-	bdi->ra_pages = read_ahead_kb >> (PAGE_SHIFT - 10);
-
-	return count;
-}
-
-#define K(pages) ((pages) << (PAGE_SHIFT - 10))
-
 #define BDI_SHOW(name, expr)						\
 static ssize_t name##_show(struct device *dev,				\
 			   struct device_attribute *attr, char *page)	\
@@ -160,7 +141,26 @@ static ssize_t name##_show(struct device *dev,				\
 }									\
 static DEVICE_ATTR_RW(name);
 
-BDI_SHOW(read_ahead_kb, K(bdi->ra_pages))
+#define BDI_ATTR_KB(name, field)					\
+static ssize_t name##_store(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	struct backing_dev_info *bdi = dev_get_drvdata(dev);		\
+	unsigned long kb;						\
+	ssize_t ret;							\
+									\
+	ret = kstrtoul(buf, 10, &kb);					\
+	if (ret < 0)							\
+		return ret;						\
+									\
+	bdi->field = kb >> (PAGE_SHIFT - 10);				\
+	return count;							\
+}									\
+BDI_SHOW(name, ((bdi->field) << (PAGE_SHIFT - 10)))
+
+BDI_ATTR_KB(read_ahead_kb, ra_pages)
+BDI_ATTR_KB(write_behind_kb, write_behind_pages)
 
 static ssize_t min_ratio_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
@@ -213,6 +213,7 @@ static DEVICE_ATTR_RO(stable_pages_required);
 
 static struct attribute *bdi_dev_attrs[] = {
 	&dev_attr_read_ahead_kb.attr,
+	&dev_attr_write_behind_kb.attr,
 	&dev_attr_min_ratio.attr,
 	&dev_attr_max_ratio.attr,
 	&dev_attr_stable_pages_required.attr,
@@ -859,6 +860,8 @@ static int bdi_init(struct backing_dev_info *bdi)
 	INIT_LIST_HEAD(&bdi->wb_list);
 	init_waitqueue_head(&bdi->wb_waitq);
 
+	bdi->write_behind_pages = VM_WRITE_BEHIND_PAGES;
+
 	ret = cgwb_bdi_init(bdi);
 
 	return ret;
diff --git a/mm/filemap.c b/mm/filemap.c
index d0cf700bf201..5398b1bea1bf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3525,3 +3525,139 @@ int try_to_release_page(struct page *page, gfp_t gfp_mask)
 }
 
 EXPORT_SYMBOL(try_to_release_page);
+
+int vm_dirty_write_behind __read_mostly;
+EXPORT_SYMBOL(vm_dirty_write_behind);
+
+/**
+ * generic_write_behind() - writeback dirty pages behind current position.
+ *
+ * This function tracks writing position. If file has enough sequentially
+ * written data it starts background writeback and then waits for previous
+ * writeback initiated some iterations ago.
+ *
+ * Write-behind maintains per-file head cursor in file->f_write_behind and
+ * two windows around: background writeback before and pending data after.
+ *
+ * |<-wait-this->|           |<-send-this->|<---pending-write-behind--->|
+ * |<--async-write-behind--->|<--------previous-data------>|<-new-data->|
+ *              current head-^    new head-^              file position-^
+ */
+void generic_write_behind(struct kiocb *iocb, ssize_t count)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	unsigned long window = READ_ONCE(bdi->write_behind_pages);
+	pgoff_t head = file->f_write_behind;
+	pgoff_t begin = (iocb->ki_pos - count) >> PAGE_SHIFT;
+	pgoff_t end = iocb->ki_pos >> PAGE_SHIFT;
+
+	/* Skip if write is random, direct, sync or disabled for disk */
+	if ((file->f_mode & FMODE_RANDOM) || !window ||
+	    (iocb->ki_flags & (IOCB_DIRECT | IOCB_DSYNC)))
+		return;
+
+	/* Skip non-sequential writes in strictly sequential mode. */
+	if (vm_dirty_write_behind < 2 &&
+	    iocb->ki_pos != i_size_read(inode) &&
+	    !(iocb->ki_flags & IOCB_APPEND))
+		return;
+
+	/* Contigious write and still within window. */
+	if (end - head < window)
+		return;
+
+	spin_lock(&file->f_lock);
+
+	/* Re-read under lock. */
+	head = file->f_write_behind;
+
+	/* Non-contiguous, move head position. */
+	if (head > end || begin - head > window) {
+		/*
+		 * Append might happen though multiple files or via new file
+		 * every time. Align head cursor to cover previous appends.
+		 */
+		if (iocb->ki_flags & IOCB_APPEND)
+			begin = roundup(begin - min(begin, window - 1),
+					bdi->io_pages);
+
+		file->f_write_behind = head = begin;
+	}
+
+	/* Still not big enough. */
+	if (end - head < window) {
+		spin_unlock(&file->f_lock);
+		return;
+	}
+
+	/* Write excess and try at least max_sectors_kb if possible */
+	end = head + max(end - head - window, min(end - head, bdi->io_pages));
+
+	/* Set head for next iteration, everything behind will be written. */
+	file->f_write_behind = end;
+
+	spin_unlock(&file->f_lock);
+
+	/* Start background writeback. */
+	__filemap_fdatawrite_range(mapping,
+				   (loff_t)head << PAGE_SHIFT,
+				   ((loff_t)end << PAGE_SHIFT) - 1,
+				   WB_SYNC_NONE);
+
+	if (head < window)
+		return;
+
+	/* Wait for pages falling behind writeback window. */
+	head -= window;
+	end -= window;
+	__filemap_fdatawait_range(mapping,
+				  (loff_t)head << PAGE_SHIFT,
+				  ((loff_t)end << PAGE_SHIFT) - 1);
+}
+EXPORT_SYMBOL(generic_write_behind);
+
+/**
+ * generic_write_behind_close() - write tail pages
+ *
+ * This function finishes write-behind steam and writes remaining tail pages
+ * in background. It start write if write-behind stream was started before
+ * (i.e. total written size is bigger than write-behind window) or if this is
+ * new file and it is bigger than max_sectors_kb.
+ */
+void generic_write_behind_close(struct file *file)
+{
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	unsigned long window = READ_ONCE(bdi->write_behind_pages);
+	pgoff_t head = file->f_write_behind;
+	pgoff_t end = (file->f_pos + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	if ((file->f_mode & FMODE_RANDOM) ||
+	    (file->f_flags & (O_APPEND | O_DSYNC | O_DIRECT)) ||
+	    !bdi_cap_writeback_dirty(bdi) || !window)
+		return;
+
+	/* Skip non-sequential writes in strictly sequential mode. */
+	if (vm_dirty_write_behind < 2 &&
+	    file->f_pos != i_size_read(inode))
+		return;
+
+	/* Non-contiguous */
+	if (head > end || end - head > window)
+		return;
+
+	/* Start stream only for new files bigger than max_sectors_kb. */
+	if (end - head < (window - min(window, bdi->io_pages)) &&
+	    (!(file->f_mode & FMODE_CREATED) || end - head < bdi->io_pages))
+		return;
+
+	/* Write tail pages in background. */
+	__filemap_fdatawrite_range(mapping,
+				   (loff_t)head << PAGE_SHIFT,
+				   file->f_pos - 1,
+				   WB_SYNC_NONE);
+}

