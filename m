Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EA77AA91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 20:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHMS0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 14:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMS0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:26:44 -0400
Received: from out-66.mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0711708
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 11:26:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691951205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8R8a1McseA9yHEzYOxyXGPVlvlW3Oa2+9zEDFiMSek=;
        b=F1iv7o3mfAJ/lx9mGer0a7rWZ9/JVBVL1z9zqJi7whLLVhox4bPxuqQxBxnC99UIfW2UlG
        ZBKU/hkfefnNBvH6KxiJQ+wmMFbYOXa4rcqQ5U3woeEEKzg8mLb2PEO8dFVegERyng5ghw
        PkMSQN64rn8tOTAYwUCtBY0YU6sq0Mk=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 2/3] block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
Date:   Sun, 13 Aug 2023 14:26:35 -0400
Message-Id: <20230813182636.2966159-3-kent.overstreet@linux.dev>
In-Reply-To: <20230813182636.2966159-1-kent.overstreet@linux.dev>
References: <20230813182636.2966159-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

