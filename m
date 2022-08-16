Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2B596188
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbiHPRxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiHPRx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:53:26 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B641D5E564;
        Tue, 16 Aug 2022 10:53:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so9886296pgb.4;
        Tue, 16 Aug 2022 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jx5etBacOfgeXw8OAxR7RH5xH7gasMcsy/7VBjftCKo=;
        b=H4w5e03AG8w22x3dkX4OcAQ/fXJPEqBuxomQqu935pHvx9qnv6UXB89C7TehiRczmJ
         +FQpqijjHerlPV7QgbLD9Svk01RL23Cq8zB1agtQdTKICezXQlLztKbYqQG1U9PrYB3F
         zyWqZ6RrPzRD3dLiMvI5ykjFnKfybBoCI8pBmmEXw98ZnWN2weK8bBLgA5U9I2Z+eIUM
         QKiR22gp7i+ANjq/+XdN02Ns7oj11Mwz8KxmhJOAHV0Heca0OEqx2IZI7t82b/W2MAFn
         2iMRbdUPNsHr/ID8+Wt6iBOyBWHr7BuWOnifm62JTx2pKAaCJskWB35TDHj4rVoHTHoq
         ts3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jx5etBacOfgeXw8OAxR7RH5xH7gasMcsy/7VBjftCKo=;
        b=cU397TXA2E6k13bAon8w4X8RxezYIs9KFVB+J7LxC45SkbBt3dSaPM41wtNnIzEbS7
         pM/q5Hu/gYga7D4hsozjTg7M98+MsGjNJ2IiVEjxLwkoMuYPxSW6KIt/TB9eN+4u4cNH
         c5cAZ4/eoogblvBm8ld/5mHJVtALiRuoBNqjZkqoAB7FkBu1QWf0Q3rbp4CIBcaI2pE3
         qXH5virCJ1/zLRCqIEqSly9Q9DxFabL7lRiyIouiChp/9op+05uj/o26PvIbjILPPV/O
         CyAFB5EVeW5kBCm7jQZc6NpuVtrxBHGoH5gt+eOZU6OcmQTseMVUPYRyXEFK/9Y/l3ab
         k3jg==
X-Gm-Message-State: ACgBeo3bEHsJfNFqLFE2YKutUHzKVzqf/JrQywhXETDpdRqC/vdcxL7A
        ibP15+ebRP+QIJ10ajGNUFluEh9mrfjmH4HW
X-Google-Smtp-Source: AA6agR6fqGrcGUuroXDXIutzhUk7sX/MVDFC98kOSRnE68zQD+oXaXUzXcwPc80r4Tb7267OZ3uaaw==
X-Received: by 2002:a65:5382:0:b0:41c:7021:6fe9 with SMTP id x2-20020a655382000000b0041c70216fe9mr19185825pgq.191.1660672404947;
        Tue, 16 Aug 2022 10:53:24 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id mi4-20020a17090b4b4400b001f52fa1704csm3379963pjb.3.2022.08.16.10.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:53:24 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/7] btrfs: Convert __process_pages_contig() to use filemap_get_folios_contig()
Date:   Tue, 16 Aug 2022 10:52:41 -0700
Message-Id: <20220816175246.42401-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220816175246.42401-1-vishal.moola@gmail.com>
References: <20220816175246.42401-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to use folios throughout. This is in preparation for the removal of
find_get_pages_contig(). Now also supports large folios.

Since we may receive more than nr_pages pages, nr_pages may underflow.
Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
with this check instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/extent_io.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8f6b544ae616..f16929bc531b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1882,9 +1882,8 @@ static int __process_pages_contig(struct address_space *mapping,
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
-	unsigned long nr_pages = end_index - start_index + 1;
 	unsigned long pages_processed = 0;
-	struct page *pages[16];
+	struct folio_batch fbatch;
 	int err = 0;
 	int i;
 
@@ -1893,16 +1892,17 @@ static int __process_pages_contig(struct address_space *mapping,
 		ASSERT(processed_end && *processed_end == start);
 	}
 
-	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
+	if ((page_ops & PAGE_SET_ERROR) && start_index <= end_index)
 		mapping_set_error(mapping, -EIO);
 
-	while (nr_pages > 0) {
-		int found_pages;
+	folio_batch_init(&fbatch);
+	while (index <= end_index) {
+		int found_folios;
+
+		found_folios = filemap_get_folios_contig(mapping, &index,
+				end_index, &fbatch);
 
-		found_pages = find_get_pages_contig(mapping, index,
-				     min_t(unsigned long,
-				     nr_pages, ARRAY_SIZE(pages)), pages);
-		if (found_pages == 0) {
+		if (found_folios == 0) {
 			/*
 			 * Only if we're going to lock these pages, we can find
 			 * nothing at @index.
@@ -1912,23 +1912,20 @@ static int __process_pages_contig(struct address_space *mapping,
 			goto out;
 		}
 
-		for (i = 0; i < found_pages; i++) {
+		for (i = 0; i < found_folios; i++) {
 			int process_ret;
-
+			struct folio *folio = fbatch.folios[i];
 			process_ret = process_one_page(fs_info, mapping,
-					pages[i], locked_page, page_ops,
+					&folio->page, locked_page, page_ops,
 					start, end);
 			if (process_ret < 0) {
-				for (; i < found_pages; i++)
-					put_page(pages[i]);
 				err = -EAGAIN;
+				folio_batch_release(&fbatch);
 				goto out;
 			}
-			put_page(pages[i]);
-			pages_processed++;
+			pages_processed += folio_nr_pages(folio);
 		}
-		nr_pages -= found_pages;
-		index += found_pages;
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 out:
-- 
2.36.1

