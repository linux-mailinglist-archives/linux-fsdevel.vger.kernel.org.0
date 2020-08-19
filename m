Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821D924A926
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 00:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHSWV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 18:21:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47237 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727921AbgHSWVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMhOF+k1edyeR4oYNKlbfW2WPgxeeF4vZAc5IsohktU=;
        b=PHji1kQ3+Rkw044fapExEvVnz9ZG1ML5jaB57eDxSSaQuM/uS1UwgDdTobNXDYWGA1pv9o
        /o6XLG7Q/1FmyS8zwOOgyZal1n72Xf77FNyb7oit655sCzMzoh4oaO0Ro8aacYTf21UtNA
        svxLYvKXGhi8EBXix/agIERmlNM5+k4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-v5CBb6C2Ofygo78UxL75Zw-1; Wed, 19 Aug 2020 18:21:09 -0400
X-MC-Unique: v5CBb6C2Ofygo78UxL75Zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5722B1014DFE;
        Wed, 19 Aug 2020 22:21:08 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 752161001901;
        Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 073AC2256E8; Wed, 19 Aug 2020 18:20:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: [PATCH v3 10/18] fuse,virtiofs: Keep a list of free dax memory ranges
Date:   Wed, 19 Aug 2020 18:19:48 -0400
Message-Id: <20200819221956.845195-11-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 fs/fuse/inode.c     | 88 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/virtio_fs.c |  2 ++
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 04fdd7c41bd1..478c940b05b4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -47,6 +47,11 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/* Default memory range size, 2MB */
+#define FUSE_DAX_SZ	(2*1024*1024)
+#define FUSE_DAX_SHIFT	(21)
+#define FUSE_DAX_PAGES	(FUSE_DAX_SZ/PAGE_SIZE)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
@@ -63,6 +68,18 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/** Translation information for file offsets to DAX window offsets */
+struct fuse_dax_mapping {
+	/* Will connect in fc->free_ranges to keep track of free memory */
+	struct list_head list;
+
+	/** Position in DAX window */
+	u64 window_offset;
+
+	/** Length of mapping, in bytes */
+	loff_t length;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -768,6 +785,12 @@ struct fuse_conn {
 
 	/** DAX device, non-NULL if DAX is supported */
 	struct dax_device *dax_dev;
+
+	/*
+	 * DAX Window Free Ranges
+	 */
+	long nr_free_ranges;
+	struct list_head free_ranges;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index beac337ccc10..b82eb61d63cc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,6 +23,8 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/dax.h>
+#include <linux/pfn_t.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -620,6 +622,76 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
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
+	nr_ranges = nr_pages/FUSE_DAX_PAGES;
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
+		range->window_offset = i * FUSE_DAX_SZ;
+		range->length = FUSE_DAX_SZ;
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
 		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
 {
@@ -647,6 +719,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
+	INIT_LIST_HEAD(&fc->free_ranges);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -655,6 +728,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (refcount_dec_and_test(&fc->count)) {
 		struct fuse_iqueue *fiq = &fc->iq;
 
+		if (fc->dax_dev)
+			fuse_free_dax_mem_ranges(&fc->free_ranges);
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
@@ -1179,11 +1254,19 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_xattr = fuse_no_acl_xattr_handlers;
 
+	if (ctx->dax_dev) {
+		err = fuse_dax_mem_range_init(fc, ctx->dax_dev);
+		if (err) {
+			pr_debug("fuse_dax_mem_range_init() returned %d\n", err);
+			goto err_free_ranges;
+		}
+	}
+
 	if (ctx->fudptr) {
 		err = -ENOMEM;
 		fud = fuse_dev_alloc_install(fc);
 		if (!fud)
-			goto err;
+			goto err_free_ranges;
 	}
 
 	fc->dev = sb->s_dev;
@@ -1242,6 +1325,9 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
  err_dev_free:
 	if (fud)
 		fuse_dev_free(fud);
+ err_free_ranges:
+	if (ctx->dax_dev)
+		fuse_free_dax_mem_ranges(&fc->free_ranges);
  err:
 	return err;
 }
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 741cad4abad8..fb31c9dbc0b8 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -747,6 +747,8 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	phys_addr_t offset = PFN_PHYS(pgoff);
 	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
 
+	pr_debug("virtio_fs_direct_access(): called. nr_pages=%ld max_nr_pages=%zu\n", nr_pages, max_nr_pages);
+
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-- 
2.25.4

