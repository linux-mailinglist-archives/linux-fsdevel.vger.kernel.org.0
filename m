Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC33F51E3EB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 06:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445489AbiEGEOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 00:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445488AbiEGEOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 00:14:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938ED2B26F
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 21:10:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x52so7791149pfu.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 May 2022 21:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sb6v0Ma3s2HntuUN/ThPmA/eaERXutHBVpI8yu6W+v4=;
        b=JzfcNd/1aY2Rb6OrxqXcvOlXysihVad4WPbiQUZGFJgeeUM4XOdTRB0a29i94aWYUK
         wi4pmFQulSiemNE/AuaKTM8KpJrN9GsqKsD68pKpMVUrsWzruY4KllFhrwxsZoFpEmdF
         e/vNUrhwXAn8n4ObZ2U+5c7RLcAG9UQ9mbjR5jl5kQZXBHv382PSuLMvWrARThtaeZjJ
         6G8WNfYFvuYS/LWaBfERb01jAxNb58tJbCtUf3iqDp2dpt8rK1dNG0KwPgwK+hstIs5N
         uGoOZ+jxhFOQ10gkJlDyKD/6HHq3qlUcseO/qge3p1VWQ9nei3+YEyBzBH5TVdhjmPgm
         9Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sb6v0Ma3s2HntuUN/ThPmA/eaERXutHBVpI8yu6W+v4=;
        b=Hcxyu7QNC9vGmJRaNn1adPxD/ckS8PwWMxIlhVdZ6Nzlj08qzEiJ+Pd2f9ZrcCkaUR
         XWd+xtRcM+zS8yVbPbpKriD3KidtWS+r5ZdfnMLF8XOqXmmw0iFSKtagCQFPUrYBI5Ke
         sOcktLhxmT76d8+shDLKNhxUWqv+U8ZVWu4CWIVWbQgtCUUuvsZodCBGSRQNIdIRtqUE
         JvRFyZ3zdcnIydzKiBqxDC/0B1/YJ6CYdL+Uyvqk1mMoDXYSJEpbplHywd8/+HaTFejm
         q7ejpBKl1ZoYmOsH8kJwfqmvtcnTC1PHL94eu/MVPBoJHpUz+v9RU9T7FsrTSfIayKIJ
         tFzQ==
X-Gm-Message-State: AOAM533ZSkdrr1rVyCagNWFfGZqhQjexOmroGauy7DpJ5R+T3Sp0siKI
        4Lmhlurlqce7tQXJPJf/K8hcDvkJgA7OlQ==
X-Google-Smtp-Source: ABdhPJwv2Y+jMbSVXH8L59irNHUYbEoGwdRryd9AF75CVsqMWMqRl6i9r47B6tpfgjMro4XZ6+IiiQ==
X-Received: by 2002:a63:d07:0:b0:3c2:7317:24c8 with SMTP id c7-20020a630d07000000b003c2731724c8mr5375015pgl.109.1651896650012;
        Fri, 06 May 2022 21:10:50 -0700 (PDT)
Received: from localhost.localdomain ([50.7.159.34])
        by smtp.gmail.com with ESMTPSA id kb8-20020a17090ae7c800b001d8abe4bb17sm4511952pjb.32.2022.05.06.21.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 21:10:49 -0700 (PDT)
From:   Liang Chen <liangchen.linux@gmail.com>
X-Google-Original-From: Liang Chen <lchen@localhost.localdomain>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@infradead.org, jmoyer@redhat.com, jack@suse.cz,
        lczerner@redhat.com, Liang Chen <liangchen.linux@gmail.com>
Subject: [PATCH v2] fs: Fix page cache inconsistency when mixing buffered and AIO DIO for bdev
Date:   Sat,  7 May 2022 12:10:33 +0800
Message-Id: <20220507041033.9588-1-lchen@localhost.localdomain>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Liang Chen <liangchen.linux@gmail.com>

As pointed out in commit 332391a, mixing buffered reads and asynchronous
direct writes risks ending up with a situation where stale data is left
in page cache while new data is already written to disk. The same problem
hits block dev fs too. A similar approach needs to be taken here.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
V2: declare blkdev_sb_init_dio_done_wq static
---
 block/fops.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 9f2ecec406b0..d3ae5eddc11b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -136,11 +136,51 @@ struct blkdev_dio {
 	size_t			size;
 	atomic_t		ref;
 	unsigned int		flags;
+	struct work_struct	complete_work;
 	struct bio		bio ____cacheline_aligned_in_smp;
 };
 
 static struct bio_set blkdev_dio_pool;
 
+static void blkdev_aio_complete_work(struct work_struct *work)
+{
+	struct blkdev_dio *dio = container_of(work, struct blkdev_dio, complete_work);
+	struct kiocb *iocb = dio->iocb;
+	int err;
+	struct inode *inode = bdev_file_inode(iocb->ki_filp);
+	loff_t offset = iocb->ki_pos;
+	ssize_t ret;
+
+	WRITE_ONCE(iocb->private, NULL);
+
+	if (likely(!dio->bio.bi_status)) {
+		ret = dio->size;
+		iocb->ki_pos += ret;
+	} else {
+		ret = blk_status_to_errno(dio->bio.bi_status);
+	}
+
+	/*
+	 * Try again to invalidate clean pages which might have been cached by
+	 * non-direct readahead, or faulted in by get_user_pages() if the source
+	 * of the write was an mmap'ed region of the file we're writing.  Either
+	 * one is a pretty crazy thing to do, so we don't support it 100%.  If
+	 * this invalidation fails, tough, the write still worked...
+	 */
+	if (iocb->ki_flags & IOCB_WRITE && ret > 0 &&
+	    inode->i_mapping->nrpages) {
+		err = invalidate_inode_pages2_range(inode->i_mapping,
+				offset >> PAGE_SHIFT,
+				(offset + ret - 1) >> PAGE_SHIFT);
+		if (err)
+			dio_warn_stale_pagecache(iocb->ki_filp);
+	}
+
+	iocb->ki_complete(iocb, ret);
+
+	bio_put(&dio->bio);
+}
+
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -153,6 +193,14 @@ static void blkdev_bio_end_io(struct bio *bio)
 		if (!(dio->flags & DIO_IS_SYNC)) {
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
+			struct inode *inode = bdev_file_inode(iocb->ki_filp);
+
+			if (iocb->ki_flags & IOCB_WRITE){
+				INIT_WORK(&dio->complete_work, blkdev_aio_complete_work);
+				queue_work(inode->i_sb->s_dio_done_wq,
+						&dio->complete_work);
+				goto out;
+			}
 
 			WRITE_ONCE(iocb->private, NULL);
 
@@ -173,6 +221,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 		}
 	}
 
+out:
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
@@ -284,6 +333,20 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 	struct blkdev_dio *dio = container_of(bio, struct blkdev_dio, bio);
 	struct kiocb *iocb = dio->iocb;
 	ssize_t ret;
+	struct inode *inode = bdev_file_inode(iocb->ki_filp);
+
+	if (iocb->ki_flags & IOCB_WRITE){
+		INIT_WORK(&dio->complete_work, blkdev_aio_complete_work);
+		/*
+		 * Grab an extra reference to ensure the dio structure
+		 * which the bio embeds in stays around for complete_work
+		 * to access.
+		 */
+		bio_get(bio);
+		queue_work(inode->i_sb->s_dio_done_wq,
+				&dio->complete_work);
+		goto out;
+	}
 
 	WRITE_ONCE(iocb->private, NULL);
 
@@ -296,6 +359,7 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 
 	iocb->ki_complete(iocb, ret);
 
+out:
 	if (dio->flags & DIO_SHOULD_DIRTY) {
 		bio_check_pages_dirty(bio);
 	} else {
@@ -366,14 +430,37 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	return -EIOCBQUEUED;
 }
 
+static int blkdev_sb_init_dio_done_wq(struct super_block *sb)
+{
+	struct workqueue_struct *old;
+	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
+						     WQ_MEM_RECLAIM, 0,
+						     sb->s_id);
+	if (!wq)
+	       return -ENOMEM;
+	/*
+	 * This has to be atomic as more DIOs can race to create the workqueue
+	 */
+	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
+	/* Someone created workqueue before us? Free ours... */
+	if (old)
+		destroy_workqueue(wq);
+       return 0;
+}
+
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	unsigned int nr_pages;
+	struct inode *inode = bdev_file_inode(iocb->ki_filp);
 
 	if (!iov_iter_count(iter))
 		return 0;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
+
+	if(!inode->i_sb->s_dio_done_wq && blkdev_sb_init_dio_done_wq(inode->i_sb))
+		return -ENOMEM;
+
 	if (likely(nr_pages <= BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
 			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
-- 
2.31.1

