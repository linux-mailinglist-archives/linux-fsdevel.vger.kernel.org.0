Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A342172C8A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjFLOeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbjFLOdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:33:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8910D9;
        Mon, 12 Jun 2023 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PwbnNapXRdevBF0hfE35KqBRaBpKqJIqHALduY4qOvE=; b=C7wViTvphkn9dIMtH5VQREhMUv
        1+E8O8JuhmHiYk+T16MMJqF/5v+zETwS4qWgZQ13Iy3fitgN+Qsx70hNBOJcF3Z1ZrUcIS/ol7AHQ
        E+wgpI0JDDsTgpeu07A5zlWT36Z2dhcbYcdjJMxUfz7cDnpognXwMNZmGzpoz1KO9VejzqKFfAxyS
        AjqgPBwN1pR1bBUcDcvUSNZ4xL37g4gTaCk3BT6JU3ZTLCFXz6E2K7PmKBczz+eDYrBC596zadpdL
        HNHKxVCFSCamSO+JSQsLkfdHzUYpwRIPqioTTKT8BKG1tlR/drnQiKyK2ajJ1DH+LA+ttEJeAM8Lb
        KkA/wExw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8ib4-004JET-0R;
        Mon, 12 Jun 2023 14:32:42 +0000
Date:   Mon, 12 Jun 2023 07:32:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org,
        linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] blksnap - block devices snapshots module
Message-ID: <ZIcsijGWeyk/FjHs@infradead.org>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612135228.10702-1-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm of course a little byassed by having spent a lot of my own time
on this, but this version now looks ready to merge to me:

Acked-by: Christoph Hellwig <hch@lst.de>

But as Jens just merged my series to reopen the open flag we'll also
need to fold this in:

diff --git a/drivers/block/blksnap/diff_area.c b/drivers/block/blksnap/diff_area.c
index 169fa003b6d66d..0848c947591508 100644
--- a/drivers/block/blksnap/diff_area.c
+++ b/drivers/block/blksnap/diff_area.c
@@ -128,7 +128,7 @@ void diff_area_free(struct kref *kref)
 	xa_destroy(&diff_area->chunk_map);
 
 	if (diff_area->orig_bdev) {
-		blkdev_put(diff_area->orig_bdev, FMODE_READ | FMODE_WRITE);
+		blkdev_put(diff_area->orig_bdev, NULL);
 		diff_area->orig_bdev = NULL;
 	}
 
@@ -214,7 +214,8 @@ struct diff_area *diff_area_new(dev_t dev_id, struct diff_storage *diff_storage)
 
 	pr_debug("Open device [%u:%u]\n", MAJOR(dev_id), MINOR(dev_id));
 
-	bdev = blkdev_get_by_dev(dev_id, FMODE_READ | FMODE_WRITE, NULL, NULL);
+	bdev = blkdev_get_by_dev(dev_id, BLK_OPEN_READ | BLK_OPEN_WRITE, NULL,
+				 NULL);
 	if (IS_ERR(bdev)) {
 		int err = PTR_ERR(bdev);
 
@@ -224,7 +225,7 @@ struct diff_area *diff_area_new(dev_t dev_id, struct diff_storage *diff_storage)
 
 	diff_area = kzalloc(sizeof(struct diff_area), GFP_KERNEL);
 	if (!diff_area) {
-		blkdev_put(bdev, FMODE_READ | FMODE_WRITE);
+		blkdev_put(bdev, NULL);
 		return ERR_PTR(-ENOMEM);
 	}
 
diff --git a/drivers/block/blksnap/diff_storage.c b/drivers/block/blksnap/diff_storage.c
index 1787fa6931a816..f3814474b9804a 100644
--- a/drivers/block/blksnap/diff_storage.c
+++ b/drivers/block/blksnap/diff_storage.c
@@ -123,7 +123,7 @@ void diff_storage_free(struct kref *kref)
 	}
 
 	while ((storage_bdev = first_storage_bdev(diff_storage))) {
-		blkdev_put(storage_bdev->bdev, FMODE_READ | FMODE_WRITE);
+		blkdev_put(storage_bdev->bdev, NULL);
 		list_del(&storage_bdev->link);
 		kfree(storage_bdev);
 	}
@@ -138,7 +138,7 @@ static struct block_device *diff_storage_add_storage_bdev(
 	struct storage_bdev *storage_bdev, *existing_bdev = NULL;
 	struct block_device *bdev;
 
-	bdev = blkdev_get_by_path(bdev_path, FMODE_READ | FMODE_WRITE,
+	bdev = blkdev_get_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
 				  NULL, NULL);
 	if (IS_ERR(bdev)) {
 		pr_err("Failed to open device. errno=%ld\n", PTR_ERR(bdev));
@@ -153,14 +153,14 @@ static struct block_device *diff_storage_add_storage_bdev(
 	spin_unlock(&diff_storage->lock);
 
 	if (existing_bdev->bdev == bdev) {
-		blkdev_put(bdev, FMODE_READ | FMODE_WRITE);
+		blkdev_put(bdev, NULL);
 		return existing_bdev->bdev;
 	}
 
 	storage_bdev = kzalloc(sizeof(struct storage_bdev) +
 			       strlen(bdev_path) + 1, GFP_KERNEL);
 	if (!storage_bdev) {
-		blkdev_put(bdev, FMODE_READ | FMODE_WRITE);
+		blkdev_put(bdev, NULL);
 		return ERR_PTR(-ENOMEM);
 	}
 
