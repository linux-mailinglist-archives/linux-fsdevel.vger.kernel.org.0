Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812896A2622
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBYBQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBYBPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:15:48 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A912879
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:43 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bh20so790927oib.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJeCP+vkx/2cukvN/pudKoUMgczTWCAc5n5AhbJ5q7o=;
        b=dNkZ1CA6bgXEKJZkiam1no3GQOLE7ObvK31HbQ/7MyBWiMefgUooUqzeNOCvp3Yg81
         L/zOQWRghIvv5elPOHqrGR7YRtZU3Hymv1Co8rt8yYVDYaRPvM+VQw5EqR2Ke+b7+Xos
         jYSpO1GigKLoY9OH7aaCeHJMqQgv0E3YP/umxPrC3+qPXBDaOYKX+TJ7iy2umCIVirjo
         2E/vtiejK5hc3b1/zfacKWUH6omtzeyY+2iy5ANIMW9gxqaN8TM8mtlGKKBhhNPBvKxT
         Zdi28vjMGqaLvNh3c+MNJmqMOjp0vb72BCal/jUMc/gcdMA40vftOpp7jkJTjYkmvumq
         5ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJeCP+vkx/2cukvN/pudKoUMgczTWCAc5n5AhbJ5q7o=;
        b=1RMZYEiGyuR43LGcj6sjfUAE/PpYgFRjhWXuCffeUKBjKqtSf0+W3GMCHzbSPPPg6Q
         hC3BcA937N3J2dZXCDN8DvGgoWvLsxUthOLJ8iviT9FMY+tGtmydktEqHqhNETzJ1LU9
         Y0rsSMukNvDVR4tpQ7C3F+/ilQdwEeNAMsmNkZZVoxMDYf2B/bzaShM81zmqnkz0qtt/
         OKxwrnmMHArWE5Q3jI7P8LF0rKc7vU38QFXS2eAIAThoEdcdFxP2g8UfjzWOdhdWrsJH
         A3rkZ049krucVmZ897yRSE8bchOMxb98RVRNmdp8XL3GJph3PYa1gFPxDKcor6mKFmQl
         NfSA==
X-Gm-Message-State: AO0yUKWgSVlH/803lhB30kjYQXyc5MLjpF1P/i9ZiTjnOukH2igXWhnb
        6gqR4LFoW190APO7S3VnceYW8VJnGlZ4w7EI
X-Google-Smtp-Source: AK7set9j8lt23Vg87LduYgMB/p+f6XWX+i3pOLqVkLQLr6uh/m6JgUcRFVFuKDvmFOjyUdIHxCsGzw==
X-Received: by 2002:aca:654c:0:b0:35b:e81d:285b with SMTP id j12-20020aca654c000000b0035be81d285bmr4018684oiw.28.1677287740961;
        Fri, 24 Feb 2023 17:15:40 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:39 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 03/76] ssdfs: implement raw device operations
Date:   Fri, 24 Feb 2023 17:08:14 -0800
Message-Id: <20230225010927.813929-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement raw device operations:
(1) device_name: get device name
(2) device_size: get device size in bytes
(3) open_zone: open zone
(4) reopen_zone: reopen closed zone
(5) close_zone: close zone
(6) read: read from device
(7) readpage: read page
(8) readpages: read sequence of pages
(9) can_write_page: can we write into page?
(10) writepage: write page to device
(11) writepages: write sequence of pages to device
(12) erase: erase block
(13) trim: support of background erase operation
(14) sync: synchronize page cache with device

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/dev_bdev.c | 1187 +++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/dev_mtd.c  |  641 ++++++++++++++++++++++
 fs/ssdfs/dev_zns.c  | 1281 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 3109 insertions(+)
 create mode 100644 fs/ssdfs/dev_bdev.c
 create mode 100644 fs/ssdfs/dev_mtd.c
 create mode 100644 fs/ssdfs/dev_zns.c

diff --git a/fs/ssdfs/dev_bdev.c b/fs/ssdfs/dev_bdev.c
new file mode 100644
index 000000000000..b6cfb7d79c8c
--- /dev/null
+++ b/fs/ssdfs/dev_bdev.c
@@ -0,0 +1,1187 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/dev_bdev.c - Block device access code.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/pagevec.h>
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/backing-dev.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_dev_bdev_page_leaks;
+atomic64_t ssdfs_dev_bdev_memory_leaks;
+atomic64_t ssdfs_dev_bdev_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_dev_bdev_cache_leaks_increment(void *kaddr)
+ * void ssdfs_dev_bdev_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_dev_bdev_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dev_bdev_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dev_bdev_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_dev_bdev_kfree(void *kaddr)
+ * struct page *ssdfs_dev_bdev_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_dev_bdev_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_dev_bdev_free_page(struct page *page)
+ * void ssdfs_dev_bdev_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(dev_bdev)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(dev_bdev)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_dev_bdev_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_dev_bdev_page_leaks, 0);
+	atomic64_set(&ssdfs_dev_bdev_memory_leaks, 0);
+	atomic64_set(&ssdfs_dev_bdev_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_dev_bdev_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_dev_bdev_page_leaks) != 0) {
+		SSDFS_ERR("BLOCK DEV: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_dev_bdev_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dev_bdev_memory_leaks) != 0) {
+		SSDFS_ERR("BLOCK DEV: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dev_bdev_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dev_bdev_cache_leaks) != 0) {
+		SSDFS_ERR("BLOCK DEV: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dev_bdev_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static DECLARE_WAIT_QUEUE_HEAD(wq);
+
+/*
+ * ssdfs_bdev_device_name() - get device name
+ * @sb: superblock object
+ */
+static const char *ssdfs_bdev_device_name(struct super_block *sb)
+{
+	return sb->s_id;
+}
+
+/*
+ * ssdfs_bdev_device_size() - get partition size in bytes
+ * @sb: superblock object
+ */
+static __u64 ssdfs_bdev_device_size(struct super_block *sb)
+{
+	return i_size_read(sb->s_bdev->bd_inode);
+}
+
+static int ssdfs_bdev_open_zone(struct super_block *sb, loff_t offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ssdfs_bdev_reopen_zone(struct super_block *sb, loff_t offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ssdfs_bdev_close_zone(struct super_block *sb, loff_t offset)
+{
+	return -EOPNOTSUPP;
+}
+
+/*
+ * ssdfs_bdev_bio_alloc() - allocate bio object
+ * @bdev: block device
+ * @nr_iovecs: number of items in biovec
+ * @op: direction of I/O
+ * @gfp_mask: mask of creation flags
+ */
+struct bio *ssdfs_bdev_bio_alloc(struct block_device *bdev,
+				 unsigned int nr_iovecs,
+				 unsigned int op,
+				 gfp_t gfp_mask)
+{
+	struct bio *bio;
+
+	bio = bio_alloc(bdev, nr_iovecs, op, gfp_mask);
+	if (!bio) {
+		SSDFS_ERR("fail to allocate bio\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return bio;
+}
+
+/*
+ * ssdfs_bdev_bio_put() - free bio object
+ */
+void ssdfs_bdev_bio_put(struct bio *bio)
+{
+	if (!bio)
+		return;
+
+	bio_put(bio);
+}
+
+/*
+ * ssdfs_bdev_bio_add_page() - add page into bio
+ * @bio: pointer on bio object
+ * @page: memory page
+ * @len: size of data into memory page
+ * @offset: vec entry offset
+ */
+int ssdfs_bdev_bio_add_page(struct bio *bio, struct page *page,
+			    unsigned int len, unsigned int offset)
+{
+	int res;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bio || !page);
+
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	res = bio_add_page(bio, page, len, offset);
+	if (res != len) {
+		SSDFS_ERR("res %d != len %u\n",
+			  res, len);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_bdev_sync_page_request() - submit page request
+ * @sb: superblock object
+ * @page: memory page
+ * @offset: offset in bytes from partition's begin
+ * @op: direction of I/O
+ * @op_flags: request op flags
+ */
+static int ssdfs_bdev_sync_page_request(struct super_block *sb,
+					struct page *page,
+					loff_t offset,
+					unsigned int op, int op_flags)
+{
+	struct bio *bio;
+	pgoff_t index = (pgoff_t)(offset >> PAGE_SHIFT);
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bio = ssdfs_bdev_bio_alloc(sb->s_bdev, 1, op, GFP_NOIO);
+	if (IS_ERR_OR_NULL(bio)) {
+		err = !bio ? -ERANGE : PTR_ERR(bio);
+		SSDFS_ERR("fail to allocate bio: err %d\n",
+			  err);
+		return err;
+	}
+
+	bio->bi_iter.bi_sector = index * (PAGE_SIZE >> 9);
+	bio_set_dev(bio, sb->s_bdev);
+	bio->bi_opf = op | op_flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_bdev_bio_add_page(bio, page, PAGE_SIZE, 0);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add page into bio: "
+			  "err %d\n",
+			  err);
+		goto finish_sync_page_request;
+	}
+
+	err = submit_bio_wait(bio);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to process request: "
+			  "err %d\n",
+			  err);
+		goto finish_sync_page_request;
+	}
+
+finish_sync_page_request:
+	ssdfs_bdev_bio_put(bio);
+
+	return err;
+}
+
+/*
+ * ssdfs_bdev_sync_pvec_request() - submit pagevec request
+ * @sb: superblock object
+ * @pvec: pagevec
+ * @offset: offset in bytes from partition's begin
+ * @op: direction of I/O
+ * @op_flags: request op flags
+ */
+static int ssdfs_bdev_sync_pvec_request(struct super_block *sb,
+					struct pagevec *pvec,
+					loff_t offset,
+					unsigned int op, int op_flags)
+{
+	struct bio *bio;
+	pgoff_t index = (pgoff_t)(offset >> PAGE_SHIFT);
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec);
+
+	SSDFS_DBG("offset %llu, op %#x, op_flags %#x\n",
+		  offset, op, op_flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(pvec) == 0) {
+		SSDFS_WARN("empty page vector\n");
+		return 0;
+	}
+
+	bio = ssdfs_bdev_bio_alloc(sb->s_bdev, pagevec_count(pvec),
+				   op, GFP_NOIO);
+	if (IS_ERR_OR_NULL(bio)) {
+		err = !bio ? -ERANGE : PTR_ERR(bio);
+		SSDFS_ERR("fail to allocate bio: err %d\n",
+			  err);
+		return err;
+	}
+
+	bio->bi_iter.bi_sector = index * (PAGE_SIZE >> 9);
+	bio_set_dev(bio, sb->s_bdev);
+	bio->bi_opf = op | op_flags;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_bdev_bio_add_page(bio, page,
+					      PAGE_SIZE,
+					      0);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add page %d into bio: "
+				  "err %d\n",
+				  i, err);
+			goto finish_sync_pvec_request;
+		}
+	}
+
+	err = submit_bio_wait(bio);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to process request: "
+			  "err %d\n",
+			  err);
+		goto finish_sync_pvec_request;
+	}
+
+finish_sync_pvec_request:
+	ssdfs_bdev_bio_put(bio);
+
+	return err;
+}
+
+/*
+ * ssdfs_bdev_readpage() - read page from the volume
+ * @sb: superblock object
+ * @page: memory page
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to read data on @offset
+ * from partition's begin in memory page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+int ssdfs_bdev_readpage(struct super_block *sb, struct page *page,
+			loff_t offset)
+{
+	int err;
+
+	err = ssdfs_bdev_sync_page_request(sb, page, offset,
+					   REQ_OP_READ, REQ_SYNC);
+	if (err) {
+		ClearPageUptodate(page);
+		ssdfs_clear_page_private(page, 0);
+		SetPageError(page);
+	} else {
+		SetPageUptodate(page);
+		ClearPageError(page);
+		flush_dcache_page(page);
+	}
+
+	ssdfs_unlock_page(page);
+
+	return err;
+}
+
+/*
+ * ssdfs_bdev_readpages() - read pages from the volume
+ * @sb: superblock object
+ * @pvec: pagevec
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to read data on @offset
+ * from partition's begin in memory page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+int ssdfs_bdev_readpages(struct super_block *sb, struct pagevec *pvec,
+			 loff_t offset)
+{
+	int i;
+	int err = 0;
+
+	err = ssdfs_bdev_sync_pvec_request(sb, pvec, offset,
+					   REQ_OP_READ, REQ_RAHEAD);
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err) {
+			ClearPageUptodate(page);
+			ssdfs_clear_page_private(page, 0);
+			SetPageError(page);
+		} else {
+			SetPageUptodate(page);
+			ClearPageError(page);
+			flush_dcache_page(page);
+		}
+
+		ssdfs_unlock_page(page);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_bdev_read_pvec() - read from volume into buffer
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @len: size of buffer in bytes
+ * @buf: buffer
+ * @read_bytes: pointer on read bytes [out]
+ *
+ * This function tries to read data on @offset
+ * from partition's begin with @len bytes in size
+ * from the volume into @buf.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+static int ssdfs_bdev_read_pvec(struct super_block *sb,
+				loff_t offset, size_t len,
+				void *buf, size_t *read_bytes)
+{
+	struct pagevec pvec;
+	struct page *page;
+	loff_t page_start, page_end;
+	u32 pages_count;
+	u32 read_len;
+	loff_t cur_offset = offset;
+	u32 page_off;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, len %zu, buf %p\n",
+		  sb, (unsigned long long)offset, len, buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*read_bytes = 0;
+
+	page_start = offset >> PAGE_SHIFT;
+	page_end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pages_count = (u32)(page_end - page_start);
+
+	if (pages_count > PAGEVEC_SIZE) {
+		SSDFS_ERR("pages_count %u > pvec_capacity %u\n",
+			  pages_count, PAGEVEC_SIZE);
+		return -ERANGE;
+	}
+
+	pagevec_init(&pvec);
+
+	for (i = 0; i < pages_count; i++) {
+		page = ssdfs_dev_bdev_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (IS_ERR_OR_NULL(page)) {
+			err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+			SSDFS_ERR("unable to allocate memory page\n");
+			goto finish_bdev_read_pvec;
+		}
+
+		ssdfs_get_page(page);
+		ssdfs_lock_page(page);
+		pagevec_add(&pvec, page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	err = ssdfs_bdev_sync_pvec_request(sb, &pvec, offset,
+					   REQ_OP_READ, REQ_SYNC);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read pagevec: err %d\n",
+			  err);
+		goto finish_bdev_read_pvec;
+	}
+
+	for (i = 0; i < pagevec_count(&pvec); i++) {
+		page = pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (*read_bytes >= len) {
+			err = -ERANGE;
+			SSDFS_ERR("read_bytes %zu >= len %zu\n",
+				  *read_bytes, len);
+			goto finish_bdev_read_pvec;
+		}
+
+		div_u64_rem(cur_offset, PAGE_SIZE, &page_off);
+		read_len = min_t(size_t, (size_t)(PAGE_SIZE - page_off),
+					  (size_t)(len - *read_bytes));
+
+		err = ssdfs_memcpy_from_page(buf, *read_bytes, len,
+					     page, page_off, PAGE_SIZE,
+					     read_len);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			goto finish_bdev_read_pvec;
+		}
+
+		*read_bytes += read_len;
+		cur_offset += read_len;
+	}
+
+finish_bdev_read_pvec:
+	for (i = pagevec_count(&pvec) - 1; i >= 0; i--) {
+		page = pvec.pages[i];
+
+		if (page) {
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_dev_bdev_free_page(page);
+			pvec.pages[i] = NULL;
+		}
+	}
+
+	pagevec_reinit(&pvec);
+
+	if (*read_bytes != len) {
+		err = -EIO;
+		SSDFS_ERR("read_bytes (%zu) != len (%zu)\n",
+			  *read_bytes, len);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_bdev_read() - read from volume into buffer
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @len: size of buffer in bytes
+ * @buf: buffer
+ *
+ * This function tries to read data on @offset
+ * from partition's begin with @len bytes in size
+ * from the volume into @buf.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+int ssdfs_bdev_read(struct super_block *sb, loff_t offset,
+		    size_t len, void *buf)
+{
+	size_t read_bytes = 0;
+	loff_t cur_offset = offset;
+	u8 *ptr = (u8 *)buf;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, len %zu, buf %p\n",
+		  sb, (unsigned long long)offset, len, buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (len == 0) {
+		SSDFS_WARN("len is zero\n");
+		return 0;
+	}
+
+	while (read_bytes < len) {
+		size_t iter_read;
+
+		err = ssdfs_bdev_read_pvec(sb, cur_offset,
+					   len - read_bytes,
+					   ptr,
+					   &iter_read);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read pvec: "
+				  "cur_offset %llu, read_bytes %zu, "
+				  "err %d\n",
+				  cur_offset, read_bytes, err);
+			return err;
+		}
+
+		cur_offset += iter_read;
+		ptr += iter_read;
+		read_bytes += iter_read;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_bdev_can_write_page() - check that page can be written
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @need_check: make check or not?
+ *
+ * This function checks that page can be written.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-ENOMEM      - fail to allocate memory.
+ * %-EIO         - I/O error.
+ */
+int ssdfs_bdev_can_write_page(struct super_block *sb, loff_t offset,
+			      bool need_check)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	void *buf;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, need_check %d\n",
+		  sb, (unsigned long long)offset, (int)need_check);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!need_check)
+		return 0;
+
+	buf = ssdfs_dev_bdev_kzalloc(fsi->pagesize, GFP_KERNEL);
+	if (!buf) {
+		SSDFS_ERR("unable to allocate %d bytes\n", fsi->pagesize);
+		return -ENOMEM;
+	}
+
+	err = ssdfs_bdev_read(sb, offset, fsi->pagesize, buf);
+	if (err)
+		goto free_buf;
+
+	if (memchr_inv(buf, 0xff, fsi->pagesize)) {
+		if (memchr_inv(buf, 0x00, fsi->pagesize)) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("area with offset %llu contains data\n",
+				  (unsigned long long)offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+			err = -EIO;
+		}
+	}
+
+free_buf:
+	ssdfs_dev_bdev_kfree(buf);
+	return err;
+}
+
+/*
+ * ssdfs_bdev_writepage() - write memory page on volume
+ * @sb: superblock object
+ * @to_off: offset in bytes from partition's begin
+ * @page: memory page
+ * @from_off: offset in bytes from page's begin
+ * @len: size of data in bytes
+ *
+ * This function tries to write from @page data of @len size
+ * on @offset from partition's begin in memory page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EIO         - I/O error.
+ */
+int ssdfs_bdev_writepage(struct super_block *sb, loff_t to_off,
+			 struct page *page, u32 from_off, size_t len)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+#ifdef CONFIG_SSDFS_DEBUG
+	u32 remainder;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, to_off %llu, page %p, from_off %u, len %zu\n",
+		  sb, to_off, page, from_off, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY) {
+		SSDFS_WARN("unable to write on RO file system\n");
+		return -EROFS;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+	BUG_ON((to_off >= ssdfs_bdev_device_size(sb)) ||
+		(len > (ssdfs_bdev_device_size(sb) - to_off)));
+	BUG_ON(len == 0);
+	div_u64_rem((u64)to_off, (u64)fsi->pagesize, &remainder);
+	BUG_ON(remainder);
+	BUG_ON((from_off + len) > PAGE_SIZE);
+	BUG_ON(!PageDirty(page));
+	BUG_ON(PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_lock_page(page);
+	atomic_inc(&fsi->pending_bios);
+
+	err = ssdfs_bdev_sync_page_request(sb, page, to_off,
+					   REQ_OP_WRITE, REQ_SYNC);
+	if (err) {
+		SetPageError(page);
+		SSDFS_ERR("failed to write (err %d): offset %llu\n",
+			  err, (unsigned long long)to_off);
+	} else {
+		ssdfs_clear_dirty_page(page);
+		SetPageUptodate(page);
+		ClearPageError(page);
+	}
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_dec_and_test(&fsi->pending_bios))
+		wake_up_all(&wq);
+
+	return err;
+}
+
+/*
+ * ssdfs_bdev_writepages() - write pagevec on volume
+ * @sb: superblock object
+ * @to_off: offset in bytes from partition's begin
+ * @pvec: memory pages vector
+ * @from_off: offset in bytes from page's begin
+ * @len: size of data in bytes
+ *
+ * This function tries to write from @pvec data of @len size
+ * on @offset from partition's begin.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EIO         - I/O error.
+ */
+int ssdfs_bdev_writepages(struct super_block *sb, loff_t to_off,
+			  struct pagevec *pvec,
+			  u32 from_off, size_t len)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct page *page;
+	int i;
+#ifdef CONFIG_SSDFS_DEBUG
+	u32 remainder;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, to_off %llu, pvec %p, from_off %u, len %zu\n",
+		  sb, to_off, pvec, from_off, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY) {
+		SSDFS_WARN("unable to write on RO file system\n");
+		return -EROFS;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec);
+	BUG_ON((to_off >= ssdfs_bdev_device_size(sb)) ||
+		(len > (ssdfs_bdev_device_size(sb) - to_off)));
+	BUG_ON(len == 0);
+	div_u64_rem((u64)to_off, (u64)fsi->pagesize, &remainder);
+	BUG_ON(remainder);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(pvec) == 0) {
+		SSDFS_WARN("empty pagevec\n");
+		return 0;
+	}
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+		BUG_ON(!PageDirty(page));
+		BUG_ON(PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+	}
+
+	atomic_inc(&fsi->pending_bios);
+
+	err = ssdfs_bdev_sync_pvec_request(sb, pvec, to_off,
+					   REQ_OP_WRITE, REQ_SYNC);
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+
+		if (err) {
+			SetPageError(page);
+			SSDFS_ERR("failed to write (err %d): "
+				  "page_index %llu\n",
+				  err,
+				  (unsigned long long)page_index(page));
+		} else {
+			ssdfs_clear_dirty_page(page);
+			SetPageUptodate(page);
+			ClearPageError(page);
+		}
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	if (atomic_dec_and_test(&fsi->pending_bios))
+		wake_up_all(&wq);
+
+	return err;
+}
+
+/*
+ * ssdfs_bdev_erase_end_io() - callback for erase operation end
+ */
+static void ssdfs_bdev_erase_end_io(struct bio *bio)
+{
+	struct super_block *sb = bio->bi_private;
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+
+	BUG_ON(bio->bi_vcnt == 0);
+
+	ssdfs_bdev_bio_put(bio);
+	if (atomic_dec_and_test(&fsi->pending_bios))
+		wake_up_all(&wq);
+}
+
+/*
+ * ssdfs_bdev_support_discard() - check that block device supports discard
+ */
+static inline bool ssdfs_bdev_support_discard(struct block_device *bdev)
+{
+	return bdev_max_discard_sectors(bdev) ||
+		bdev_is_zoned(bdev);
+}
+
+/*
+ * ssdfs_bdev_erase_request() - initiate erase request
+ * @sb: superblock object
+ * @nr_iovecs: number of pages for erase
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to make erase operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT      - erase operation error.
+ */
+static int ssdfs_bdev_erase_request(struct super_block *sb,
+				    unsigned int nr_iovecs,
+				    loff_t offset)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct page *erase_page = fsi->erase_page;
+	struct bio *bio;
+	unsigned int max_pages;
+	pgoff_t index = (pgoff_t)(offset >> PAGE_SHIFT);
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!erase_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (nr_iovecs == 0) {
+		SSDFS_WARN("empty vector\n");
+		return 0;
+	}
+
+	max_pages = min_t(unsigned int, nr_iovecs, BIO_MAX_VECS);
+
+	bio = ssdfs_bdev_bio_alloc(sb->s_bdev, max_pages,
+				   REQ_OP_DISCARD, GFP_NOFS);
+	if (IS_ERR_OR_NULL(bio)) {
+		err = !bio ? -ERANGE : PTR_ERR(bio);
+		SSDFS_ERR("fail to allocate bio: err %d\n",
+			  err);
+		return err;
+	}
+
+	for (i = 0; i < nr_iovecs; i++) {
+		if (i >= max_pages) {
+			bio_set_dev(bio, sb->s_bdev);
+			bio->bi_opf = REQ_OP_DISCARD | REQ_BACKGROUND;
+			bio->bi_iter.bi_sector = index * (PAGE_SIZE >> 9);
+			bio->bi_private = sb;
+			bio->bi_end_io = ssdfs_bdev_erase_end_io;
+			atomic_inc(&fsi->pending_bios);
+			submit_bio(bio);
+
+			index += i;
+			nr_iovecs -= i;
+			i = 0;
+
+			bio = ssdfs_bdev_bio_alloc(sb->s_bdev, max_pages,
+						   REQ_OP_DISCARD, GFP_NOFS);
+			if (IS_ERR_OR_NULL(bio)) {
+				err = !bio ? -ERANGE : PTR_ERR(bio);
+				SSDFS_ERR("fail to allocate bio: err %d\n",
+					  err);
+				return err;
+			}
+		}
+
+		err = ssdfs_bdev_bio_add_page(bio, erase_page,
+					      PAGE_SIZE,
+					      0);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add page %d into bio: "
+				  "err %d\n",
+				  i, err);
+			goto finish_erase_request;
+		}
+	}
+
+	bio_set_dev(bio, sb->s_bdev);
+	bio->bi_opf = REQ_OP_DISCARD | REQ_BACKGROUND;
+	bio->bi_iter.bi_sector = index * (PAGE_SIZE >> 9);
+	bio->bi_private = sb;
+	bio->bi_end_io = ssdfs_bdev_erase_end_io;
+	atomic_inc(&fsi->pending_bios);
+	submit_bio(bio);
+
+	return 0;
+
+finish_erase_request:
+	ssdfs_bdev_bio_put(bio);
+
+	return err;
+}
+
+/*
+ * ssdfs_bdev_erase() - make erase operation
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @len: size in bytes
+ *
+ * This function tries to make erase operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EFAULT      - erase operation error.
+ */
+static int ssdfs_bdev_erase(struct super_block *sb, loff_t offset, size_t len)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	u32 erase_size = fsi->erasesize;
+	loff_t page_start, page_end;
+	u32 pages_count;
+	sector_t start_sector;
+	sector_t sectors_count;
+	u32 remainder;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, len %zu\n",
+		  sb, (unsigned long long)offset, len);
+
+	div_u64_rem((u64)len, (u64)erase_size, &remainder);
+	BUG_ON(remainder);
+	div_u64_rem((u64)offset, (u64)erase_size, &remainder);
+	BUG_ON(remainder);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY)
+		return -EROFS;
+
+	div_u64_rem((u64)len, (u64)erase_size, &remainder);
+	if (remainder) {
+		SSDFS_WARN("len %llu, erase_size %u, remainder %u\n",
+			   (unsigned long long)len,
+			   erase_size, remainder);
+		return -ERANGE;
+	}
+
+	page_start = offset >> PAGE_SHIFT;
+	page_end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pages_count = (u32)(page_end - page_start);
+
+	if (pages_count == 0) {
+		SSDFS_WARN("pages_count equals to zero\n");
+		return -ERANGE;
+	}
+
+	if (ssdfs_bdev_support_discard(sb->s_bdev)) {
+		err = ssdfs_bdev_erase_request(sb, pages_count, offset);
+		if (unlikely(err))
+			goto try_zeroout;
+	} else {
+try_zeroout:
+		start_sector = page_start <<
+					(PAGE_SHIFT - SSDFS_SECTOR_SHIFT);
+		sectors_count = pages_count <<
+					(PAGE_SHIFT - SSDFS_SECTOR_SHIFT);
+
+		err = blkdev_issue_zeroout(sb->s_bdev,
+					   start_sector, sectors_count,
+					   GFP_NOFS, 0);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to erase: "
+			  "offset %llu, len %zu, err %d\n",
+			  (unsigned long long)offset,
+			  len, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_bdev_trim() - initiate background erase operation
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @len: size in bytes
+ *
+ * This function tries to initiate background erase operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EFAULT      - erase operation error.
+ */
+static int ssdfs_bdev_trim(struct super_block *sb, loff_t offset, size_t len)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	u32 erase_size = fsi->erasesize;
+	loff_t page_start, page_end;
+	u32 pages_count;
+	u32 remainder;
+	sector_t start_sector;
+	sector_t sectors_count;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, len %zu\n",
+		  sb, (unsigned long long)offset, len);
+
+	div_u64_rem((u64)len, (u64)erase_size, &remainder);
+	BUG_ON(remainder);
+	div_u64_rem((u64)offset, (u64)erase_size, &remainder);
+	BUG_ON(remainder);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY)
+		return -EROFS;
+
+	div_u64_rem((u64)len, (u64)erase_size, &remainder);
+	if (remainder) {
+		SSDFS_WARN("len %llu, erase_size %u, remainder %u\n",
+			   (unsigned long long)len,
+			   erase_size, remainder);
+		return -ERANGE;
+	}
+
+	page_start = offset >> PAGE_SHIFT;
+	page_end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pages_count = (u32)(page_end - page_start);
+
+	if (pages_count == 0) {
+		SSDFS_WARN("pages_count equals to zero\n");
+		return -ERANGE;
+	}
+
+	start_sector = page_start << (PAGE_SHIFT - SSDFS_SECTOR_SHIFT);
+	sectors_count = pages_count << (PAGE_SHIFT - SSDFS_SECTOR_SHIFT);
+
+	if (ssdfs_bdev_support_discard(sb->s_bdev)) {
+		err = blkdev_issue_discard(sb->s_bdev,
+					   start_sector, sectors_count,
+					   GFP_NOFS);
+		if (unlikely(err))
+			goto try_zeroout;
+	} else {
+try_zeroout:
+		err = blkdev_issue_zeroout(sb->s_bdev,
+					   start_sector, sectors_count,
+					   GFP_NOFS, 0);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to discard: "
+			  "start_sector %llu, sectors_count %llu, "
+			  "err %d\n",
+			  start_sector, sectors_count, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_bdev_peb_isbad() - check that PEB is bad
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to detect that PEB is bad or not.
+ */
+static int ssdfs_bdev_peb_isbad(struct super_block *sb, loff_t offset)
+{
+	/* do nothing */
+	return 0;
+}
+
+/*
+ * ssdfs_bdev_mark_peb_bad() - mark PEB as bad
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to mark PEB as bad.
+ */
+int ssdfs_bdev_mark_peb_bad(struct super_block *sb, loff_t offset)
+{
+	/* do nothing */
+	return 0;
+}
+
+/*
+ * ssdfs_bdev_sync() - make sync operation
+ * @sb: superblock object
+ */
+static void ssdfs_bdev_sync(struct super_block *sb)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("device %s\n", sb->s_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	wait_event(wq, atomic_read(&fsi->pending_bios) == 0);
+}
+
+const struct ssdfs_device_ops ssdfs_bdev_devops = {
+	.device_name		= ssdfs_bdev_device_name,
+	.device_size		= ssdfs_bdev_device_size,
+	.open_zone		= ssdfs_bdev_open_zone,
+	.reopen_zone		= ssdfs_bdev_reopen_zone,
+	.close_zone		= ssdfs_bdev_close_zone,
+	.read			= ssdfs_bdev_read,
+	.readpage		= ssdfs_bdev_readpage,
+	.readpages		= ssdfs_bdev_readpages,
+	.can_write_page		= ssdfs_bdev_can_write_page,
+	.writepage		= ssdfs_bdev_writepage,
+	.writepages		= ssdfs_bdev_writepages,
+	.erase			= ssdfs_bdev_erase,
+	.trim			= ssdfs_bdev_trim,
+	.peb_isbad		= ssdfs_bdev_peb_isbad,
+	.mark_peb_bad		= ssdfs_bdev_mark_peb_bad,
+	.sync			= ssdfs_bdev_sync,
+};
diff --git a/fs/ssdfs/dev_mtd.c b/fs/ssdfs/dev_mtd.c
new file mode 100644
index 000000000000..6c092ea863bd
--- /dev/null
+++ b/fs/ssdfs/dev_mtd.c
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/dev_mtd.c - MTD device access code.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/super.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_dev_mtd_page_leaks;
+atomic64_t ssdfs_dev_mtd_memory_leaks;
+atomic64_t ssdfs_dev_mtd_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_dev_mtd_cache_leaks_increment(void *kaddr)
+ * void ssdfs_dev_mtd_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_dev_mtd_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dev_mtd_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dev_mtd_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_dev_mtd_kfree(void *kaddr)
+ * struct page *ssdfs_dev_mtd_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_dev_mtd_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_dev_mtd_free_page(struct page *page)
+ * void ssdfs_dev_mtd_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(dev_mtd)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(dev_mtd)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_dev_mtd_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_dev_mtd_page_leaks, 0);
+	atomic64_set(&ssdfs_dev_mtd_memory_leaks, 0);
+	atomic64_set(&ssdfs_dev_mtd_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_dev_mtd_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_dev_mtd_page_leaks) != 0) {
+		SSDFS_ERR("MTD DEV: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_dev_mtd_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dev_mtd_memory_leaks) != 0) {
+		SSDFS_ERR("MTD DEV: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dev_mtd_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dev_mtd_cache_leaks) != 0) {
+		SSDFS_ERR("MTD DEV: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dev_mtd_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_mtd_device_name() - get device name
+ * @sb: superblock object
+ */
+static const char *ssdfs_mtd_device_name(struct super_block *sb)
+{
+	return sb->s_mtd->name;
+}
+
+/*
+ * ssdfs_mtd_device_size() - get partition size in bytes
+ * @sb: superblock object
+ */
+static __u64 ssdfs_mtd_device_size(struct super_block *sb)
+{
+	return SSDFS_FS_I(sb)->mtd->size;
+}
+
+static int ssdfs_mtd_open_zone(struct super_block *sb, loff_t offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ssdfs_mtd_reopen_zone(struct super_block *sb, loff_t offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ssdfs_mtd_close_zone(struct super_block *sb, loff_t offset)
+{
+	return -EOPNOTSUPP;
+}
+
+/*
+ * ssdfs_mtd_read() - read from volume into buffer
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @len: size of buffer in bytes
+ * @buf: buffer
+ *
+ * This function tries to read data on @offset
+ * from partition's begin with @len bytes in size
+ * from the volume into @buf.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+static int ssdfs_mtd_read(struct super_block *sb, loff_t offset, size_t len,
+			  void *buf)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct mtd_info *mtd = fsi->mtd;
+	size_t retlen;
+	int ret;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, len %zu, buf %p\n",
+		  sb, (unsigned long long)offset, len, buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ret = mtd_read(mtd, offset, len, &retlen, buf);
+	if (ret) {
+		SSDFS_ERR("failed to read (err %d): offset %llu, len %zu\n",
+			  ret, (unsigned long long)offset, len);
+		return ret;
+	}
+
+	if (retlen != len) {
+		SSDFS_ERR("retlen (%zu) != len (%zu)\n", retlen, len);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_mtd_readpage() - read page from the volume
+ * @sb: superblock object
+ * @page: memory page
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to read data on @offset
+ * from partition's begin in memory page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+static int ssdfs_mtd_readpage(struct super_block *sb, struct page *page,
+				loff_t offset)
+{
+	void *kaddr;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, page %p, page_index %llu\n",
+		  sb, (unsigned long long)offset, page,
+		  (unsigned long long)page_index(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	kaddr = kmap_local_page(page);
+	err = ssdfs_mtd_read(sb, offset, PAGE_SIZE, kaddr);
+	flush_dcache_page(page);
+	kunmap_local(kaddr);
+
+	if (err) {
+		ClearPageUptodate(page);
+		ssdfs_clear_page_private(page, 0);
+		SetPageError(page);
+	} else {
+		SetPageUptodate(page);
+		ClearPageError(page);
+		flush_dcache_page(page);
+	}
+
+	ssdfs_unlock_page(page);
+
+	return err;
+}
+
+/*
+ * ssdfs_mtd_readpages() - read pages from the volume
+ * @sb: superblock object
+ * @pvec: vector of memory pages
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to read data on @offset
+ * from partition's begin in memory pages.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+static int ssdfs_mtd_readpages(struct super_block *sb, struct pagevec *pvec,
+				loff_t offset)
+{
+	struct page *page;
+	loff_t cur_offset = offset;
+	u32 page_off;
+	u32 read_bytes = 0;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, pvec %p\n",
+		  sb, (unsigned long long)offset, pvec);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(pvec) == 0) {
+		SSDFS_WARN("empty page vector\n");
+		return 0;
+	}
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_mtd_readpage(sb, page, cur_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read page: "
+				  "cur_offset %llu, err %d\n",
+				  cur_offset, err);
+			return err;
+		}
+
+		div_u64_rem(cur_offset, PAGE_SIZE, &page_off);
+		read_bytes = PAGE_SIZE - page_off;
+		cur_offset += read_bytes;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_mtd_can_write_page() - check that page can be written
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @need_check: make check or not?
+ *
+ * This function checks that page can be written.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-ENOMEM      - fail to allocate memory.
+ * %-EIO         - I/O error.
+ */
+static int ssdfs_mtd_can_write_page(struct super_block *sb, loff_t offset,
+				    bool need_check)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	void *buf;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, need_check %d\n",
+		  sb, (unsigned long long)offset, (int)need_check);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!need_check)
+		return 0;
+
+	buf = ssdfs_dev_mtd_kzalloc(fsi->pagesize, GFP_KERNEL);
+	if (!buf) {
+		SSDFS_ERR("unable to allocate %d bytes\n", fsi->pagesize);
+		return -ENOMEM;
+	}
+
+	err = ssdfs_mtd_read(sb, offset, fsi->pagesize, buf);
+	if (err)
+		goto free_buf;
+
+	if (memchr_inv(buf, 0xff, fsi->pagesize)) {
+		SSDFS_ERR("area with offset %llu contains unmatching char\n",
+			  (unsigned long long)offset);
+		err = -EIO;
+	}
+
+free_buf:
+	ssdfs_dev_mtd_kfree(buf);
+	return err;
+}
+
+/*
+ * ssdfs_mtd_writepage() - write memory page on volume
+ * @sb: superblock object
+ * @to_off: offset in bytes from partition's begin
+ * @page: memory page
+ * @from_off: offset in bytes from page's begin
+ * @len: size of data in bytes
+ *
+ * This function tries to write from @page data of @len size
+ * on @offset from partition's begin in memory page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EIO         - I/O error.
+ */
+static int ssdfs_mtd_writepage(struct super_block *sb, loff_t to_off,
+				struct page *page, u32 from_off, size_t len)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct mtd_info *mtd = fsi->mtd;
+	size_t retlen;
+	unsigned char *kaddr;
+	int ret;
+#ifdef CONFIG_SSDFS_DEBUG
+	u32 remainder;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, to_off %llu, page %p, from_off %u, len %zu\n",
+		  sb, to_off, page, from_off, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY) {
+		SSDFS_WARN("unable to write on RO file system\n");
+		return -EROFS;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+	BUG_ON((to_off >= mtd->size) || (len > (mtd->size - to_off)));
+	BUG_ON(len == 0);
+	div_u64_rem((u64)to_off, (u64)fsi->pagesize, &remainder);
+	BUG_ON(remainder);
+	BUG_ON((from_off + len) > PAGE_SIZE);
+	BUG_ON(!PageDirty(page));
+	BUG_ON(PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+	ret = mtd_write(mtd, to_off, len, &retlen, kaddr + from_off);
+	kunmap_local(kaddr);
+
+	if (ret || (retlen != len)) {
+		SetPageError(page);
+		SSDFS_ERR("failed to write (err %d): offset %llu, "
+			  "len %zu, retlen %zu\n",
+			  ret, (unsigned long long)to_off, len, retlen);
+		err = -EIO;
+	} else {
+		ssdfs_clear_dirty_page(page);
+		SetPageUptodate(page);
+		ClearPageError(page);
+	}
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_mtd_writepages() - write memory pages on volume
+ * @sb: superblock object
+ * @to_off: offset in bytes from partition's begin
+ * @pvec: vector of memory pages
+ * @from_off: offset in bytes from page's begin
+ * @len: size of data in bytes
+ *
+ * This function tries to write from @pvec data of @len size
+ * on @offset from partition's begin in memory page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EIO         - I/O error.
+ */
+static int ssdfs_mtd_writepages(struct super_block *sb, loff_t to_off,
+				struct pagevec *pvec, u32 from_off, size_t len)
+{
+	struct page *page;
+	loff_t cur_to_off = to_off;
+	u32 page_off = from_off;
+	u32 written_bytes = 0;
+	size_t write_len;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, to_off %llu, pvec %p, from_off %u, len %zu\n",
+		  sb, to_off, pvec, from_off, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY) {
+		SSDFS_WARN("unable to write on RO file system\n");
+		return -EROFS;
+	}
+
+	if (pagevec_count(pvec) == 0) {
+		SSDFS_WARN("empty page vector\n");
+		return 0;
+	}
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (written_bytes >= len) {
+			SSDFS_ERR("written_bytes %u >= len %zu\n",
+				  written_bytes, len);
+			return -ERANGE;
+		}
+
+		write_len = min_t(size_t, (size_t)(PAGE_SIZE - page_off),
+					  (size_t)(len - written_bytes));
+
+		err = ssdfs_mtd_writepage(sb, cur_to_off, page, page_off, write_len);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to write page: "
+				  "cur_to_off %llu, page_off %u, "
+				  "write_len %zu, err %d\n",
+				  cur_to_off, page_off, write_len, err);
+			return err;
+		}
+
+		div_u64_rem(cur_to_off, PAGE_SIZE, &page_off);
+		written_bytes += write_len;
+		cur_to_off += write_len;
+	}
+
+	return 0;
+}
+
+static void ssdfs_erase_callback(struct erase_info *ei)
+{
+	complete((struct completion *)ei->priv);
+}
+
+/*
+ * ssdfs_mtd_erase() - make erase operation
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @len: size in bytes
+ *
+ * This function tries to make erase operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EFAULT      - erase operation error.
+ */
+static int ssdfs_mtd_erase(struct super_block *sb, loff_t offset, size_t len)
+{
+	struct mtd_info *mtd = SSDFS_FS_I(sb)->mtd;
+	struct erase_info ei;
+	DECLARE_COMPLETION_ONSTACK(complete);
+	u32 remainder;
+	int ret;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, len %zu\n",
+		  sb, (unsigned long long)offset, len);
+
+	div_u64_rem((u64)len, (u64)mtd->erasesize, &remainder);
+	BUG_ON(remainder);
+	div_u64_rem((u64)offset, (u64)mtd->erasesize, &remainder);
+	BUG_ON(remainder);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY)
+		return -EROFS;
+
+	div_u64_rem((u64)len, (u64)mtd->erasesize, &remainder);
+	if (remainder) {
+		SSDFS_WARN("len %llu, erase_size %u, remainder %u\n",
+			   (unsigned long long)len,
+			   mtd->erasesize, remainder);
+		return -ERANGE;
+	}
+
+	memset(&ei, 0, sizeof(ei));
+	ei.mtd = mtd;
+	ei.addr = offset;
+	ei.len = len;
+	ei.callback = ssdfs_erase_callback;
+	ei.priv = (long)&complete;
+
+	ret = mtd_erase(mtd, &ei);
+	if (ret) {
+		SSDFS_ERR("failed to erase (err %d): offset %llu, len %zu\n",
+			  ret, (unsigned long long)offset, len);
+		return ret;
+	}
+
+	err = SSDFS_WAIT_COMPLETION(&complete);
+	if (unlikely(err)) {
+		SSDFS_ERR("timeout is out: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (ei.state != MTD_ERASE_DONE) {
+		SSDFS_ERR("ei.state %#x, offset %llu, len %zu\n",
+			  ei.state, (unsigned long long)offset, len);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_mtd_trim() - initiate background erase operation
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @len: size in bytes
+ *
+ * This function tries to initiate background erase operation.
+ * Currently, it is the same operation as foreground erase.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EFAULT      - erase operation error.
+ */
+static int ssdfs_mtd_trim(struct super_block *sb, loff_t offset, size_t len)
+{
+	return ssdfs_mtd_erase(sb, offset, len);
+}
+
+/*
+ * ssdfs_mtd_peb_isbad() - check that PEB is bad
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to detect that PEB is bad or not.
+ */
+static int ssdfs_mtd_peb_isbad(struct super_block *sb, loff_t offset)
+{
+	return mtd_block_isbad(SSDFS_FS_I(sb)->mtd, offset);
+}
+
+/*
+ * ssdfs_mtd_mark_peb_bad() - mark PEB as bad
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to mark PEB as bad.
+ */
+int ssdfs_mtd_mark_peb_bad(struct super_block *sb, loff_t offset)
+{
+	return mtd_block_markbad(SSDFS_FS_I(sb)->mtd, offset);
+}
+
+/*
+ * ssdfs_mtd_sync() - make sync operation
+ * @sb: superblock object
+ */
+static void ssdfs_mtd_sync(struct super_block *sb)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("device %d (\"%s\")\n",
+		  fsi->mtd->index, fsi->mtd->name);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	mtd_sync(fsi->mtd);
+}
+
+const struct ssdfs_device_ops ssdfs_mtd_devops = {
+	.device_name		= ssdfs_mtd_device_name,
+	.device_size		= ssdfs_mtd_device_size,
+	.open_zone		= ssdfs_mtd_open_zone,
+	.reopen_zone		= ssdfs_mtd_reopen_zone,
+	.close_zone		= ssdfs_mtd_close_zone,
+	.read			= ssdfs_mtd_read,
+	.readpage		= ssdfs_mtd_readpage,
+	.readpages		= ssdfs_mtd_readpages,
+	.can_write_page		= ssdfs_mtd_can_write_page,
+	.writepage		= ssdfs_mtd_writepage,
+	.writepages		= ssdfs_mtd_writepages,
+	.erase			= ssdfs_mtd_erase,
+	.trim			= ssdfs_mtd_trim,
+	.peb_isbad		= ssdfs_mtd_peb_isbad,
+	.mark_peb_bad		= ssdfs_mtd_mark_peb_bad,
+	.sync			= ssdfs_mtd_sync,
+};
diff --git a/fs/ssdfs/dev_zns.c b/fs/ssdfs/dev_zns.c
new file mode 100644
index 000000000000..2b45f3b1632c
--- /dev/null
+++ b/fs/ssdfs/dev_zns.c
@@ -0,0 +1,1281 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/dev_zns.c - ZNS SSD support.
+ *
+ * Copyright (c) 2022-2023 Bytedance Ltd. and/or its affiliates.
+ *              https://www.bytedance.com/
+ * Copyright (c) 2022-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cong Wang
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/pagevec.h>
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/backing-dev.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_dev_zns_page_leaks;
+atomic64_t ssdfs_dev_zns_memory_leaks;
+atomic64_t ssdfs_dev_zns_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_dev_zns_cache_leaks_increment(void *kaddr)
+ * void ssdfs_dev_zns_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_dev_zns_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dev_zns_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dev_zns_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_dev_zns_kfree(void *kaddr)
+ * struct page *ssdfs_dev_zns_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_dev_zns_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_dev_zns_free_page(struct page *page)
+ * void ssdfs_dev_zns_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(dev_zns)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(dev_zns)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_dev_zns_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_dev_zns_page_leaks, 0);
+	atomic64_set(&ssdfs_dev_zns_memory_leaks, 0);
+	atomic64_set(&ssdfs_dev_zns_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_dev_zns_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_dev_zns_page_leaks) != 0) {
+		SSDFS_ERR("ZNS DEV: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_dev_zns_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dev_zns_memory_leaks) != 0) {
+		SSDFS_ERR("ZNS DEV: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dev_zns_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dev_zns_cache_leaks) != 0) {
+		SSDFS_ERR("ZNS DEV: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dev_zns_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static DECLARE_WAIT_QUEUE_HEAD(zns_wq);
+
+/*
+ * ssdfs_zns_device_name() - get device name
+ * @sb: superblock object
+ */
+static const char *ssdfs_zns_device_name(struct super_block *sb)
+{
+	return sb->s_id;
+}
+
+/*
+ * ssdfs_zns_device_size() - get partition size in bytes
+ * @sb: superblock object
+ */
+static __u64 ssdfs_zns_device_size(struct super_block *sb)
+{
+	return i_size_read(sb->s_bdev->bd_inode);
+}
+
+static int ssdfs_report_zone(struct blk_zone *zone,
+			     unsigned int index, void *data)
+{
+	ssdfs_memcpy(data, 0, sizeof(struct blk_zone),
+		     zone, 0, sizeof(struct blk_zone),
+		     sizeof(struct blk_zone));
+	return 0;
+}
+
+/*
+ * ssdfs_zns_open_zone() - open zone
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ */
+static int ssdfs_zns_open_zone(struct super_block *sb, loff_t offset)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	sector_t zone_size = fsi->erasesize >> SECTOR_SHIFT;
+	u32 open_zones;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu\n",
+		  sb, (unsigned long long)offset);
+	SSDFS_DBG("BEFORE: open_zones %d\n",
+		  atomic_read(&fsi->open_zones));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	open_zones = atomic_inc_return(&fsi->open_zones);
+	if (open_zones > fsi->max_open_zones) {
+		atomic_dec(&fsi->open_zones);
+
+		SSDFS_WARN("open zones limit achieved: "
+			   "open_zones %u\n", open_zones);
+		return -EBUSY;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("AFTER: open_zones %d\n",
+		   atomic_read(&fsi->open_zones));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = blkdev_zone_mgmt(sb->s_bdev, REQ_OP_ZONE_OPEN,
+				zone_sector, zone_size, GFP_NOFS);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to open zone: "
+			  "zone_sector %llu, zone_size %llu, "
+			  "open_zones %u, max_open_zones %u, "
+			  "err %d\n",
+			  zone_sector, zone_size,
+			  open_zones, fsi->max_open_zones,
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_zns_reopen_zone() - reopen closed zone
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ */
+static int ssdfs_zns_reopen_zone(struct super_block *sb, loff_t offset)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct blk_zone zone;
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	sector_t zone_size = fsi->erasesize >> SECTOR_SHIFT;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu\n",
+		  sb, (unsigned long long)offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (err != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("zone before: start %llu, len %llu, wp %llu, "
+		  "type %#x, cond %#x, non_seq %#x, "
+		  "reset %#x, capacity %llu\n",
+		  zone.start, zone.len, zone.wp,
+		  zone.type, zone.cond, zone.non_seq,
+		  zone.reset, zone.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (zone.cond) {
+	case BLK_ZONE_COND_CLOSED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is closed: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		/* continue logic */
+		break;
+
+	case BLK_ZONE_COND_READONLY:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is READ-ONLY: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	case BLK_ZONE_COND_FULL:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is full: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	case BLK_ZONE_COND_OFFLINE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is offline: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	err = blkdev_zone_mgmt(sb->s_bdev, REQ_OP_ZONE_OPEN,
+				zone_sector, zone_size, GFP_NOFS);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to open zone: "
+			  "zone_sector %llu, zone_size %llu, "
+			  "err %d\n",
+			  zone_sector, zone_size,
+			  err);
+		return err;
+	}
+
+	err = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (err != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("zone after: start %llu, len %llu, wp %llu, "
+		  "type %#x, cond %#x, non_seq %#x, "
+		  "reset %#x, capacity %llu\n",
+		  zone.start, zone.len, zone.wp,
+		  zone.type, zone.cond, zone.non_seq,
+		  zone.reset, zone.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (zone.cond) {
+	case BLK_ZONE_COND_CLOSED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is closed: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	case BLK_ZONE_COND_READONLY:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is READ-ONLY: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	case BLK_ZONE_COND_FULL:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is full: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	case BLK_ZONE_COND_OFFLINE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is offline: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_zns_close_zone() - close zone
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ */
+static int ssdfs_zns_close_zone(struct super_block *sb, loff_t offset)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	sector_t zone_size = fsi->erasesize >> SECTOR_SHIFT;
+	u32 open_zones;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu\n",
+		  sb, (unsigned long long)offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = blkdev_zone_mgmt(sb->s_bdev, REQ_OP_ZONE_FINISH,
+				zone_sector, zone_size, GFP_NOFS);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to open zone: "
+			  "zone_sector %llu, zone_size %llu, err %d\n",
+			  zone_sector, zone_size, err);
+		return err;
+	}
+
+	open_zones = atomic_dec_return(&fsi->open_zones);
+	if (open_zones > fsi->max_open_zones) {
+		SSDFS_WARN("open zones limit exhausted: "
+			   "open_zones %u\n", open_zones);
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_zns_zone_size() - retrieve zone size
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to retrieve zone size.
+ */
+u64 ssdfs_zns_zone_size(struct super_block *sb, loff_t offset)
+{
+	struct blk_zone zone;
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	int res;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu\n",
+		  sb, (unsigned long long)offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+		return U64_MAX;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("zone: start %llu, len %llu, wp %llu, "
+		  "type %#x, cond %#x, non_seq %#x, "
+		  "reset %#x, capacity %llu\n",
+		  zone.start, zone.len, zone.wp,
+		  zone.type, zone.cond, zone.non_seq,
+		  zone.reset, zone.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u64)zone.len << SECTOR_SHIFT;
+}
+
+/*
+ * ssdfs_zns_zone_capacity() - retrieve zone capacity
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to retrieve zone capacity.
+ */
+u64 ssdfs_zns_zone_capacity(struct super_block *sb, loff_t offset)
+{
+	struct blk_zone zone;
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	int res;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu\n",
+		  sb, (unsigned long long)offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+		return U64_MAX;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("zone: start %llu, len %llu, wp %llu, "
+		  "type %#x, cond %#x, non_seq %#x, "
+		  "reset %#x, capacity %llu\n",
+		  zone.start, zone.len, zone.wp,
+		  zone.type, zone.cond, zone.non_seq,
+		  zone.reset, zone.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u64)zone.capacity << SECTOR_SHIFT;
+}
+
+/*
+ * ssdfs_zns_sync_page_request() - submit page request
+ * @sb: superblock object
+ * @page: memory page
+ * @zone_start: first sector of zone
+ * @offset: offset in bytes from partition's begin
+ * @op: direction of I/O
+ * @op_flags: request op flags
+ */
+static int ssdfs_zns_sync_page_request(struct super_block *sb,
+					struct page *page,
+					sector_t zone_start,
+					loff_t offset,
+					unsigned int op, int op_flags)
+{
+	struct bio *bio;
+#ifdef CONFIG_SSDFS_DEBUG
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	struct blk_zone zone;
+	int res;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+	op |= REQ_OP_ZONE_APPEND | REQ_IDLE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+
+	SSDFS_DBG("offset %llu, zone_start %llu, "
+		  "op %#x, op_flags %#x\n",
+		  offset, zone_start, op, op_flags);
+
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+	} else {
+		SSDFS_DBG("zone: start %llu, len %llu, wp %llu, "
+			  "type %#x, cond %#x, non_seq %#x, "
+			  "reset %#x, capacity %llu\n",
+			  zone.start, zone.len, zone.wp,
+			  zone.type, zone.cond, zone.non_seq,
+			  zone.reset, zone.capacity);
+	}
+
+	BUG_ON(zone_start != zone.start);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bio = ssdfs_bdev_bio_alloc(sb->s_bdev, 1, op, GFP_NOFS);
+	if (IS_ERR_OR_NULL(bio)) {
+		err = !bio ? -ERANGE : PTR_ERR(bio);
+		SSDFS_ERR("fail to allocate bio: err %d\n",
+			  err);
+		return err;
+	}
+
+	bio->bi_iter.bi_sector = zone_start;
+	bio_set_dev(bio, sb->s_bdev);
+	bio->bi_opf = op | op_flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_bdev_bio_add_page(bio, page, PAGE_SIZE, 0);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add page into bio: "
+			  "err %d\n",
+			  err);
+		goto finish_sync_page_request;
+	}
+
+	err = submit_bio_wait(bio);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to process request: "
+			  "err %d\n",
+			  err);
+		goto finish_sync_page_request;
+	}
+
+finish_sync_page_request:
+	ssdfs_bdev_bio_put(bio);
+
+	return err;
+}
+
+/*
+ * ssdfs_zns_sync_pvec_request() - submit pagevec request
+ * @sb: superblock object
+ * @pvec: pagevec
+ * @zone_start: first sector of zone
+ * @offset: offset in bytes from partition's begin
+ * @op: direction of I/O
+ * @op_flags: request op flags
+ */
+static int ssdfs_zns_sync_pvec_request(struct super_block *sb,
+					struct pagevec *pvec,
+					sector_t zone_start,
+					loff_t offset,
+					unsigned int op, int op_flags)
+{
+	struct bio *bio;
+	int i;
+#ifdef CONFIG_SSDFS_DEBUG
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	struct blk_zone zone;
+	int res;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+	op |= REQ_OP_ZONE_APPEND | REQ_IDLE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec);
+
+	SSDFS_DBG("offset %llu, zone_start %llu, "
+		  "op %#x, op_flags %#x\n",
+		  offset, zone_start, op, op_flags);
+
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+	} else {
+		SSDFS_DBG("zone: start %llu, len %llu, wp %llu, "
+			  "type %#x, cond %#x, non_seq %#x, "
+			  "reset %#x, capacity %llu\n",
+			  zone.start, zone.len, zone.wp,
+			  zone.type, zone.cond, zone.non_seq,
+			  zone.reset, zone.capacity);
+	}
+
+	BUG_ON(zone_start != zone.start);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(pvec) == 0) {
+		SSDFS_WARN("empty page vector\n");
+		return 0;
+	}
+
+	bio = ssdfs_bdev_bio_alloc(sb->s_bdev, pagevec_count(pvec),
+				   op, GFP_NOFS);
+	if (IS_ERR_OR_NULL(bio)) {
+		err = !bio ? -ERANGE : PTR_ERR(bio);
+		SSDFS_ERR("fail to allocate bio: err %d\n",
+			  err);
+		return err;
+	}
+
+	bio->bi_iter.bi_sector = zone_start;
+	bio_set_dev(bio, sb->s_bdev);
+	bio->bi_opf = op | op_flags;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_bdev_bio_add_page(bio, page,
+					      PAGE_SIZE,
+					      0);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add page %d into bio: "
+				  "err %d\n",
+				  i, err);
+			goto finish_sync_pvec_request;
+		}
+	}
+
+	err = submit_bio_wait(bio);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to process request: "
+			  "err %d\n",
+			  err);
+		goto finish_sync_pvec_request;
+	}
+
+finish_sync_pvec_request:
+	ssdfs_bdev_bio_put(bio);
+
+	return err;
+}
+
+/*
+ * ssdfs_zns_readpage() - read page from the volume
+ * @sb: superblock object
+ * @page: memory page
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to read data on @offset
+ * from partition's begin in memory page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+int ssdfs_zns_readpage(struct super_block *sb, struct page *page,
+			loff_t offset)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct blk_zone zone;
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	int res;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu\n",
+		  sb, (unsigned long long)offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_bdev_readpage(sb, page, offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+	} else {
+		SSDFS_DBG("zone: start %llu, len %llu, wp %llu, "
+			  "type %#x, cond %#x, non_seq %#x, "
+			  "reset %#x, capacity %llu\n",
+			  zone.start, zone.len, zone.wp,
+			  zone.type, zone.cond, zone.non_seq,
+			  zone.reset, zone.capacity);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_zns_readpages() - read pages from the volume
+ * @sb: superblock object
+ * @pvec: pagevec
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to read data on @offset
+ * from partition's begin in memory page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+int ssdfs_zns_readpages(struct super_block *sb, struct pagevec *pvec,
+			 loff_t offset)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct blk_zone zone;
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	int res;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu\n",
+		  sb, (unsigned long long)offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_bdev_readpages(sb, pvec, offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+	} else {
+		SSDFS_DBG("zone: start %llu, len %llu, wp %llu, "
+			  "type %#x, cond %#x, non_seq %#x, "
+			  "reset %#x, capacity %llu\n",
+			  zone.start, zone.len, zone.wp,
+			  zone.type, zone.cond, zone.non_seq,
+			  zone.reset, zone.capacity);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_zns_read() - read from volume into buffer
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @len: size of buffer in bytes
+ * @buf: buffer
+ *
+ * This function tries to read data on @offset
+ * from partition's begin with @len bytes in size
+ * from the volume into @buf.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO         - I/O error.
+ */
+int ssdfs_zns_read(struct super_block *sb, loff_t offset,
+		   size_t len, void *buf)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct blk_zone zone;
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	int res;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, len %zu, buf %p\n",
+		  sb, (unsigned long long)offset, len, buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_bdev_read(sb, offset, len, buf);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+	} else {
+		SSDFS_DBG("zone: start %llu, len %llu, wp %llu, "
+			  "type %#x, cond %#x, non_seq %#x, "
+			  "reset %#x, capacity %llu\n",
+			  zone.start, zone.len, zone.wp,
+			  zone.type, zone.cond, zone.non_seq,
+			  zone.reset, zone.capacity);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_zns_can_write_page() - check that page can be written
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @need_check: make check or not?
+ *
+ * This function checks that page can be written.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-ENOMEM      - fail to allocate memory.
+ * %-EIO         - I/O error.
+ */
+static int ssdfs_zns_can_write_page(struct super_block *sb, loff_t offset,
+				    bool need_check)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct blk_zone zone;
+	sector_t zone_sector = offset >> SECTOR_SHIFT;
+	sector_t zone_size = fsi->erasesize >> SECTOR_SHIFT;
+	u64 peb_id;
+	loff_t zone_offset;
+	int res;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, need_check %d\n",
+		  sb, (unsigned long long)offset, (int)need_check);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!need_check)
+		return 0;
+
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+		return res;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("zone before: start %llu, len %llu, wp %llu, "
+		  "type %#x, cond %#x, non_seq %#x, "
+		  "reset %#x, capacity %llu\n",
+		  zone.start, zone.len, zone.wp,
+		  zone.type, zone.cond, zone.non_seq,
+		  zone.reset, zone.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (zone.type) {
+	case BLK_ZONE_TYPE_CONVENTIONAL:
+		return ssdfs_bdev_can_write_page(sb, offset, need_check);
+
+	default:
+		/*
+		 * BLK_ZONE_TYPE_SEQWRITE_REQ
+		 * BLK_ZONE_TYPE_SEQWRITE_PREF
+		 *
+		 * continue logic
+		 */
+		break;
+	}
+
+	switch (zone.cond) {
+	case BLK_ZONE_COND_NOT_WP:
+		return ssdfs_bdev_can_write_page(sb, offset, need_check);
+
+	case BLK_ZONE_COND_EMPTY:
+		/* can write */
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is empty: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+
+	case BLK_ZONE_COND_CLOSED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is closed: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		peb_id = offset / fsi->erasesize;
+		zone_offset = peb_id * fsi->erasesize;
+
+		err = ssdfs_zns_reopen_zone(sb, zone_offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to reopen zone: "
+				  "zone_offset %llu, zone_size %llu, "
+				  "err %d\n",
+				  zone_offset, zone_size, err);
+			return err;
+		}
+
+		return 0;
+
+	case BLK_ZONE_COND_READONLY:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is READ-ONLY: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	case BLK_ZONE_COND_FULL:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is full: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	case BLK_ZONE_COND_OFFLINE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("zone is offline: offset %llu\n",
+			  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	if (zone_sector < zone.wp) {
+		err = -EIO;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cannot be written: "
+			  "zone_sector %llu, zone.wp %llu\n",
+			  zone_sector, zone.wp);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+	} else {
+		SSDFS_DBG("zone after: start %llu, len %llu, wp %llu, "
+			  "type %#x, cond %#x, non_seq %#x, "
+			  "reset %#x, capacity %llu\n",
+			  zone.start, zone.len, zone.wp,
+			  zone.type, zone.cond, zone.non_seq,
+			  zone.reset, zone.capacity);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_zns_writepage() - write memory page on volume
+ * @sb: superblock object
+ * @to_off: offset in bytes from partition's begin
+ * @page: memory page
+ * @from_off: offset in bytes from page's begin
+ * @len: size of data in bytes
+ *
+ * This function tries to write from @page data of @len size
+ * on @offset from partition's begin in memory page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EIO         - I/O error.
+ */
+int ssdfs_zns_writepage(struct super_block *sb, loff_t to_off,
+			struct page *page, u32 from_off, size_t len)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	loff_t zone_start;
+#ifdef CONFIG_SSDFS_DEBUG
+	struct blk_zone zone;
+	sector_t zone_sector = to_off >> SECTOR_SHIFT;
+	u32 remainder;
+	int res;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, to_off %llu, page %p, from_off %u, len %zu\n",
+		  sb, to_off, page, from_off, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY) {
+		SSDFS_WARN("unable to write on RO file system\n");
+		return -EROFS;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+	BUG_ON((to_off >= ssdfs_zns_device_size(sb)) ||
+		(len > (ssdfs_zns_device_size(sb) - to_off)));
+	BUG_ON(len == 0);
+	div_u64_rem((u64)to_off, (u64)fsi->pagesize, &remainder);
+	BUG_ON(remainder);
+	BUG_ON((from_off + len) > PAGE_SIZE);
+	BUG_ON(!PageDirty(page));
+	BUG_ON(PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_lock_page(page);
+	atomic_inc(&fsi->pending_bios);
+
+	zone_start = (to_off / fsi->erasesize) * fsi->erasesize;
+	zone_start >>= SECTOR_SHIFT;
+
+	err = ssdfs_zns_sync_page_request(sb, page, zone_start, to_off,
+					  REQ_OP_WRITE, REQ_SYNC);
+	if (err) {
+		SetPageError(page);
+		SSDFS_ERR("failed to write (err %d): offset %llu\n",
+			  err, (unsigned long long)to_off);
+	} else {
+		ssdfs_clear_dirty_page(page);
+		SetPageUptodate(page);
+		ClearPageError(page);
+	}
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_dec_and_test(&fsi->pending_bios))
+		wake_up_all(&zns_wq);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+	} else {
+		SSDFS_DBG("zone: start %llu, len %llu, wp %llu, "
+			  "type %#x, cond %#x, non_seq %#x, "
+			  "reset %#x, capacity %llu\n",
+			  zone.start, zone.len, zone.wp,
+			  zone.type, zone.cond, zone.non_seq,
+			  zone.reset, zone.capacity);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_zns_writepages() - write pagevec on volume
+ * @sb: superblock object
+ * @to_off: offset in bytes from partition's begin
+ * @pvec: memory pages vector
+ * @from_off: offset in bytes from page's begin
+ * @len: size of data in bytes
+ *
+ * This function tries to write from @pvec data of @len size
+ * on @offset from partition's begin.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EIO         - I/O error.
+ */
+int ssdfs_zns_writepages(struct super_block *sb, loff_t to_off,
+			 struct pagevec *pvec,
+			 u32 from_off, size_t len)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct page *page;
+	loff_t zone_start;
+	int i;
+#ifdef CONFIG_SSDFS_DEBUG
+	struct blk_zone zone;
+	sector_t zone_sector = to_off >> SECTOR_SHIFT;
+	u32 remainder;
+	int res;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, to_off %llu, pvec %p, from_off %u, len %zu\n",
+		  sb, to_off, pvec, from_off, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY) {
+		SSDFS_WARN("unable to write on RO file system\n");
+		return -EROFS;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec);
+	BUG_ON((to_off >= ssdfs_zns_device_size(sb)) ||
+		(len > (ssdfs_zns_device_size(sb) - to_off)));
+	BUG_ON(len == 0);
+	div_u64_rem((u64)to_off, (u64)fsi->pagesize, &remainder);
+	BUG_ON(remainder);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(pvec) == 0) {
+		SSDFS_WARN("empty pagevec\n");
+		return 0;
+	}
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+		BUG_ON(!PageDirty(page));
+		BUG_ON(PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+	}
+
+	atomic_inc(&fsi->pending_bios);
+
+	zone_start = (to_off / fsi->erasesize) * fsi->erasesize;
+	zone_start >>= SECTOR_SHIFT;
+
+	err = ssdfs_zns_sync_pvec_request(sb, pvec, zone_start, to_off,
+					  REQ_OP_WRITE, REQ_SYNC);
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+
+		if (err) {
+			SetPageError(page);
+			SSDFS_ERR("failed to write (err %d): "
+				  "page_index %llu\n",
+				  err,
+				  (unsigned long long)page_index(page));
+		} else {
+			ssdfs_clear_dirty_page(page);
+			SetPageUptodate(page);
+			ClearPageError(page);
+		}
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	if (atomic_dec_and_test(&fsi->pending_bios))
+		wake_up_all(&zns_wq);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	res = blkdev_report_zones(sb->s_bdev, zone_sector, 1,
+				  ssdfs_report_zone, &zone);
+	if (res != 1) {
+		SSDFS_ERR("fail to take report zone: "
+			  "zone_sector %llu, err %d\n",
+			  zone_sector, res);
+	} else {
+		SSDFS_DBG("zone: start %llu, len %llu, wp %llu, "
+			  "type %#x, cond %#x, non_seq %#x, "
+			  "reset %#x, capacity %llu\n",
+			  zone.start, zone.len, zone.wp,
+			  zone.type, zone.cond, zone.non_seq,
+			  zone.reset, zone.capacity);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_zns_trim() - initiate background erase operation
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ * @len: size in bytes
+ *
+ * This function tries to initiate background erase operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EROFS       - file system in RO mode.
+ * %-EFAULT      - erase operation error.
+ */
+static int ssdfs_zns_trim(struct super_block *sb, loff_t offset, size_t len)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	u32 erase_size = fsi->erasesize;
+	loff_t page_start, page_end;
+	u32 pages_count;
+	u32 remainder;
+	sector_t start_sector;
+	sector_t sectors_count;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sb %p, offset %llu, len %zu\n",
+		  sb, (unsigned long long)offset, len);
+
+	div_u64_rem((u64)len, (u64)erase_size, &remainder);
+	BUG_ON(remainder);
+	div_u64_rem((u64)offset, (u64)erase_size, &remainder);
+	BUG_ON(remainder);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (sb->s_flags & SB_RDONLY)
+		return -EROFS;
+
+	div_u64_rem((u64)len, (u64)erase_size, &remainder);
+	if (remainder) {
+		SSDFS_WARN("len %llu, erase_size %u, remainder %u\n",
+			   (unsigned long long)len,
+			   erase_size, remainder);
+		return -ERANGE;
+	}
+
+	page_start = offset >> PAGE_SHIFT;
+	page_end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pages_count = (u32)(page_end - page_start);
+
+	if (pages_count == 0) {
+		SSDFS_WARN("pages_count equals to zero\n");
+		return -ERANGE;
+	}
+
+	start_sector = offset >> SECTOR_SHIFT;
+	sectors_count = fsi->erasesize >> SECTOR_SHIFT;
+
+	err = blkdev_zone_mgmt(sb->s_bdev, REQ_OP_ZONE_RESET,
+				start_sector, sectors_count, GFP_NOFS);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to reset zone: "
+			  "zone_sector %llu, zone_size %llu, err %d\n",
+			  start_sector, sectors_count, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_zns_peb_isbad() - check that PEB is bad
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to detect that PEB is bad or not.
+ */
+static int ssdfs_zns_peb_isbad(struct super_block *sb, loff_t offset)
+{
+	/* do nothing */
+	return 0;
+}
+
+/*
+ * ssdfs_zns_mark_peb_bad() - mark PEB as bad
+ * @sb: superblock object
+ * @offset: offset in bytes from partition's begin
+ *
+ * This function tries to mark PEB as bad.
+ */
+int ssdfs_zns_mark_peb_bad(struct super_block *sb, loff_t offset)
+{
+	/* do nothing */
+	return 0;
+}
+
+/*
+ * ssdfs_zns_sync() - make sync operation
+ * @sb: superblock object
+ */
+static void ssdfs_zns_sync(struct super_block *sb)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("device %s\n", sb->s_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	wait_event(zns_wq, atomic_read(&fsi->pending_bios) == 0);
+}
+
+const struct ssdfs_device_ops ssdfs_zns_devops = {
+	.device_name		= ssdfs_zns_device_name,
+	.device_size		= ssdfs_zns_device_size,
+	.open_zone		= ssdfs_zns_open_zone,
+	.reopen_zone		= ssdfs_zns_reopen_zone,
+	.close_zone		= ssdfs_zns_close_zone,
+	.read			= ssdfs_zns_read,
+	.readpage		= ssdfs_zns_readpage,
+	.readpages		= ssdfs_zns_readpages,
+	.can_write_page		= ssdfs_zns_can_write_page,
+	.writepage		= ssdfs_zns_writepage,
+	.writepages		= ssdfs_zns_writepages,
+	.erase			= ssdfs_zns_trim,
+	.trim			= ssdfs_zns_trim,
+	.peb_isbad		= ssdfs_zns_peb_isbad,
+	.mark_peb_bad		= ssdfs_zns_mark_peb_bad,
+	.sync			= ssdfs_zns_sync,
+};
-- 
2.34.1

