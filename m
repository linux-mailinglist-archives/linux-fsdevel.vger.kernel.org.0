Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E6751250
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjGLVMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjGLVLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:11:43 -0400
Received: from out-62.mta1.migadu.com (out-62.mta1.migadu.com [IPv6:2001:41d0:203:375::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED77212E
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8R8a1McseA9yHEzYOxyXGPVlvlW3Oa2+9zEDFiMSek=;
        b=RDJY9becWM6dp5APPe+W3+AhHdTbbxSheD0BdlQawbutc1QKgpGpErxhWourqz2W7amicS
        WJCuzEQEwd4JC+IWugS9xG/53kT6/mGiN+z6NXn9BRb98AaQoFAnpkW6neybyy/w9YpJ41
        9JHr1hZHa7hMbqYWmdClwFy3NRwx89g=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 05/20] block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
Date:   Wed, 12 Jul 2023 17:11:00 -0400
Message-Id: <20230712211115.2174650-6-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bio_iov_iter_get_pages() trims the IO based on the block size of the
block device the IO will be issued to.

However, bcachefs is a multi device filesystem; when we're creating the
bio we don't yet know which block device the bio will be submitted to -
we have to handle the alignment checks elsewhere.

Thus this is needed to avoid a null ptr deref.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/bio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1e75840d17..e74a04ea14 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1245,7 +1245,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
 	unsigned len, i = 0;
-	size_t offset, trim;
+	size_t offset;
 	int ret = 0;
 
 	/*
@@ -1274,10 +1274,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 
-	trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
-	iov_iter_revert(iter, trim);
+	if (bio->bi_bdev) {
+		size_t trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
+		iov_iter_revert(iter, trim);
+		size -= trim;
+	}
 
-	size -= trim;
 	if (unlikely(!size)) {
 		ret = -EFAULT;
 		goto out;
-- 
2.40.1

