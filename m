Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53151D9B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349347AbiEFOBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 10:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441942AbiEFOBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 10:01:30 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125705DBE9
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 06:57:44 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q76so6168495pgq.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 May 2022 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBpFEbihRJcYw2PVZ0Ir3bkRfFP2on1Hh677/FjVuuA=;
        b=ZwVj763v8hoF4d7BaAm9uGVTyMc483ySH7YASG1K10aEzVS0Vmk72uAd1m0+TDH1EW
         gvs2/qjZ5lHf+n7alhvxZ6LYGwBmJa8bE1vs/lheGoRWS23op2iaOapZHV2/eRpKzGUE
         tXNTNULhn2Ez4zYCkC0b3liDPqq5RENeSFJ0jACq3QzwQFo/JK0B7wd7fx7CEgAwsYO7
         EIDfuLOaHTrYgGdh+KCTPRiJCdc9jAu373DKGmEArKatYHMKtNYwEby0/s1Lr8RnOjqA
         Z3rQDjLodgh1Vc/STcd8hDkj8Xq7VCwA3fTA2DBzljsmaiTjsN7Ehd5MJnzweltVG31m
         ZdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBpFEbihRJcYw2PVZ0Ir3bkRfFP2on1Hh677/FjVuuA=;
        b=rysLW4u4D9hhi5pimdevRAi/7Ap+PXRr37ejHN4Upi9epTQLBiVgW8E4us2ss19a8K
         3tUtYGPuhgiibGhzDbtXF/M2nHXzcEnoF/0ghpBYhz+YJ1aSW8WUoRoI7+cbd9a1xVfg
         unV/2DowtPQ3XaLgTrPK9B4uz600PoJWpoY4q6LefB3nJ2l+e/EWo0QEP/Y3wMNvwao4
         s5YLPfptBh/sT5WGG2/I/DSW3x+OdHr/Xd31c4dR5G8coCnKlX3MEs5yIZJuXU6JSM/d
         u44Fqc3YN1Yk2WJqEP4oRKkr/9XG9Li4yTxI3tkOaHxxNvGaUr1hDHd5EYFKzNdU5TTv
         LsrA==
X-Gm-Message-State: AOAM531pOjyLphV5WWGtcrbDCyaKUaPYYPwPJAvStCvk00lmosB4D9eb
        iBmoJvQJjvuNGgSGpv1N6EoHUJcAKIdaHw==
X-Google-Smtp-Source: ABdhPJyvH8RJUZcUzn+WgxBBSixFUL4i/t72PK8/nTJ4dxUNHoIC8kqrvLRhsRHLLnWe9RF3xZ7Vhg==
X-Received: by 2002:a63:1b1f:0:b0:3c1:bb2a:3afb with SMTP id b31-20020a631b1f000000b003c1bb2a3afbmr2863176pgb.596.1651845463396;
        Fri, 06 May 2022 06:57:43 -0700 (PDT)
Received: from localhost.localdomain ([50.7.159.34])
        by smtp.gmail.com with ESMTPSA id ie13-20020a17090b400d00b001da3920d985sm7396931pjb.12.2022.05.06.06.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:57:42 -0700 (PDT)
From:   Liang Chen <liangchen.linux@gmail.com>
X-Google-Original-From: Liang Chen <lchen@localhost.localdomain>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@infradead.org, jmoyer@redhat.com, jack@suse.cz,
        lczerner@redhat.com, Liang Chen <liangchen.linux@gmail.com>
Subject: [PATCH] fs: Fix page cache inconsistency when mixing buffered and AIO DIO for bdev
Date:   Fri,  6 May 2022 21:57:09 +0800
Message-Id: <20220506135709.46872-1-lchen@localhost.localdomain>
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
 block/fops.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 9f2ecec406b0..8ab679814b9d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -136,11 +136,56 @@ struct blkdev_dio {
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
+	/*
+	 * For multi-bio dio dio->bio has an extra reference to ensure the
+	 * dio stays around. In the other case, an extra reference is taken
+	 * to make sure 
+	 */
+	bio_put(&dio->bio);
+}
+
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -153,6 +198,14 @@ static void blkdev_bio_end_io(struct bio *bio)
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
 
@@ -173,6 +226,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 		}
 	}
 
+out:
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
@@ -284,6 +338,20 @@ static void blkdev_bio_end_io_async(struct bio *bio)
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
 
@@ -296,6 +364,7 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 
 	iocb->ki_complete(iocb, ret);
 
+out:
 	if (dio->flags & DIO_SHOULD_DIRTY) {
 		bio_check_pages_dirty(bio);
 	} else {
@@ -366,14 +435,37 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	return -EIOCBQUEUED;
 }
 
+int blkdev_sb_init_dio_done_wq(struct super_block *sb)
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

