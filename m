Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DB41FACA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfEOT1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbfEOT1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAA2285A04;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 859F05D723;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DC60A225487; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 19/30] fuse: Keep a list of free dax memory ranges
Date:   Wed, 15 May 2019 15:27:04 -0400
Message-Id: <20190515192715.18000-20-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 15 May 2019 19:27:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Divide the dax memory range into fixed size ranges (2MB for now) and put
them in a list. This will track free ranges. Once an inode requires a
free range, we will take one from here and put it in interval-tree
of ranges assigned to inode.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 fs/fuse/fuse_i.h    | 23 ++++++++++++
 fs/fuse/inode.c     | 86 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/virtio_fs.c |  2 ++
 3 files changed, 111 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 840c88af711c..5439e4628362 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -46,6 +46,10 @@
 /** Number of page pointers embedded in fuse_req */
 #define FUSE_REQ_INLINE_PAGES 1
 
+/* Default memory range size, 2MB */
+#define FUSE_DAX_MEM_RANGE_SZ	(2*1024*1024)
+#define FUSE_DAX_MEM_RANGE_PAGES	(FUSE_DAX_MEM_RANGE_SZ/PAGE_SIZE)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
@@ -94,6 +98,18 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/** Translation information for file offsets to DAX window offsets */
+struct fuse_dax_mapping {
+	/* Will connect in fc->free_ranges to keep track of free memory */
+	struct list_head list;
+
+       /** Position in DAX window */
+       u64 window_offset;
+
+       /** Length of mapping, in bytes */
+       loff_t length;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -829,6 +845,13 @@ struct fuse_conn {
 
 	/** DAX device, non-NULL if DAX is supported */
 	struct dax_device *dax_dev;
+
+	/*
+	 * DAX Window Free Ranges. TODO: This might not be best place to store
+	 * this free list
+	 */
+	long nr_free_ranges;
+	struct list_head free_ranges;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 97d218a7daa8..8a3dd72f9843 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -22,6 +22,8 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/dax.h>
+#include <linux/pfn_t.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -610,6 +612,76 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 	fpq->connected = 1;
 }
 
+static void fuse_free_dax_mem_ranges(struct list_head *mem_list)
+{
+	struct fuse_dax_mapping *range, *temp;
+
+	/* Free All allocated elements */
+	list_for_each_entry_safe(range, temp, mem_list, list) {
+		list_del(&range->list);
+		kfree(range);
+	}
+}
+
+#ifdef CONFIG_FS_DAX
+static int fuse_dax_mem_range_init(struct fuse_conn *fc,
+				   struct dax_device *dax_dev)
+{
+	long nr_pages, nr_ranges;
+	void *kaddr;
+	pfn_t pfn;
+	struct fuse_dax_mapping *range;
+	LIST_HEAD(mem_ranges);
+	phys_addr_t phys_addr;
+	int ret = 0, id;
+	size_t dax_size = -1;
+	unsigned long i;
+
+	id = dax_read_lock();
+	nr_pages = dax_direct_access(dax_dev, 0, PHYS_PFN(dax_size), &kaddr,
+					&pfn);
+	dax_read_unlock(id);
+	if (nr_pages < 0) {
+		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
+		return nr_pages;
+	}
+
+	phys_addr = pfn_t_to_phys(pfn);
+	nr_ranges = nr_pages/FUSE_DAX_MEM_RANGE_PAGES;
+	printk("fuse_dax_mem_range_init(): dax mapped %ld pages. nr_ranges=%ld\n", nr_pages, nr_ranges);
+
+	for (i = 0; i < nr_ranges; i++) {
+		range = kzalloc(sizeof(struct fuse_dax_mapping), GFP_KERNEL);
+		if (!range) {
+			pr_debug("memory allocation for mem_range failed.\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
+		/* TODO: This offset only works if virtio-fs driver is not
+		 * having some memory hidden at the beginning. This needs
+		 * better handling
+		 */
+		range->window_offset = i * FUSE_DAX_MEM_RANGE_SZ;
+		range->length = FUSE_DAX_MEM_RANGE_SZ;
+		list_add_tail(&range->list, &mem_ranges);
+	}
+
+	list_replace_init(&mem_ranges, &fc->free_ranges);
+	fc->nr_free_ranges = nr_ranges;
+	return 0;
+out_err:
+	/* Free All allocated elements */
+	fuse_free_dax_mem_ranges(&mem_ranges);
+	return ret;
+}
+#else /* !CONFIG_FS_DAX */
+static inline int fuse_dax_mem_range_init(struct fuse_conn *fc,
+					  struct dax_device *dax_dev)
+{
+	return 0;
+}
+#endif /* CONFIG_FS_DAX */
+
 void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 			struct dax_device *dax_dev,
 			const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
@@ -640,6 +712,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->dax_dev = dax_dev;
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
+	INIT_LIST_HEAD(&fc->free_ranges);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -648,6 +721,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (refcount_dec_and_test(&fc->count)) {
 		if (fc->destroy_req)
 			fuse_request_free(fc->destroy_req);
+		if (fc->dax_dev)
+			fuse_free_dax_mem_ranges(&fc->free_ranges);
 		put_pid_ns(fc->pid_ns);
 		put_user_ns(fc->user_ns);
 		fc->release(fc);
@@ -1154,6 +1229,14 @@ int fuse_fill_super_common(struct super_block *sb,
 		       mount_data->fiq_ops, mount_data->fiq_priv);
 	fc->release = fuse_free_conn;
 
+	if (mount_data->dax_dev) {
+		err = fuse_dax_mem_range_init(fc, mount_data->dax_dev);
+		if (err) {
+			pr_debug("fuse_dax_mem_range_init() returned %d\n", err);
+			goto err_free_ranges;
+		}
+	}
+
 	fud = fuse_dev_alloc_install(fc);
 	if (!fud)
 		goto err_put_conn;
@@ -1214,6 +1297,9 @@ int fuse_fill_super_common(struct super_block *sb,
 	dput(root_dentry);
  err_dev_free:
 	fuse_dev_free(fud);
+ err_free_ranges:
+	if (mount_data->dax_dev)
+		fuse_free_dax_mem_ranges(&fc->free_ranges);
  err_put_conn:
 	fuse_conn_put(fc);
 	sb->s_fs_info = NULL;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2b790865dc21..76c46edcc8ac 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -453,6 +453,8 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	phys_addr_t offset = PFN_PHYS(pgoff);
 	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
 
+	pr_debug("virtio_fs_direct_access(): called. nr_pages=%ld max_nr_pages=%zu\n", nr_pages, max_nr_pages);
+
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-- 
2.20.1

