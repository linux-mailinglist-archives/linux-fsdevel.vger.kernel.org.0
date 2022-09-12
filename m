Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668055B6084
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiILS0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiILSZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:25:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D47115A22;
        Mon, 12 Sep 2022 11:25:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so9022365pjl.0;
        Mon, 12 Sep 2022 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XBE5EAyurHlAAqUYTZRlJbn5nu+dgNY9++qJZC9HEP4=;
        b=ITM5iBctmKc+MCt2XrAt1/9sycCT8ZGtclTNNKSvX7cl27aimROEhwq8Yzjz9XtpFt
         F2M3x8FASHt0eghDrVD90g/LIDZl93/2UFcDto6MVoedm54lNnyvI6kXC5h0smVTph3X
         dkL4YrtLbtJIMDobW3mrXpv5RNC6a98F1m8Tv57EiXsmQY+gCrYPHWc6nFr9o7H2vsPz
         OJ4DI7g9bIkI2oG7scKkzWSsxJSsLP0a6JWX4LP8CLLcvHCi4kyX7omubZIXnYjxJrU+
         ndMeoUF7cNaG6gZOtcYhi1+dl/xzHLRjSSAjpOSJNWBqxTK1RhhwLMylxwORW+ARK7Fg
         HVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XBE5EAyurHlAAqUYTZRlJbn5nu+dgNY9++qJZC9HEP4=;
        b=P0sOfzbvlnYKdjRTXlPgspop1UcekeTc/r8X/HuJKd9yKADD3KiLp/WDOdgLdVx1II
         xwV44Stbfb6hj6zEWt+fB/nSDPOFSlIEjx3KP5LuHtTFfouLyVekNDaKRfc5hpbKv02a
         Fp1coV3fjsepqjJen/TCaMka3M5SlDFLkOc3E3gBrfHGWIg1M0tWrvSLzhRPPI4GyAka
         Z770HsZRlG4MRA1IPcoR8ECR/HzU8tgBxabbVxWiI5yr4jpoANCdSh3W79Lt+29PZN3/
         HMSJ1S9kU1RKLyrF441eQCNFK6lQgNtlesK6AVcqGpsdg7XCtUbjv/7CmppTOFbLc5kW
         F0Xw==
X-Gm-Message-State: ACgBeo2IJ2elQP2G6KvIX2eUjUXjnoDXHsN1nne7H7z5yeNfuwEm7y3f
        ycZoOBxo2f0GtWOVLqLHIyJeEHezpJQRzg==
X-Google-Smtp-Source: AA6agR5X97vcfNFGGVg/nuGpWsvVdpfUDmyvHgihCl2mmP8A/id5SOD27XkWcIF/Iv88lkmHeMJK7w==
X-Received: by 2002:a17:90a:a097:b0:1fb:5bc:7778 with SMTP id r23-20020a17090aa09700b001fb05bc7778mr25392630pjp.209.1663007131161;
        Mon, 12 Sep 2022 11:25:31 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:30 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2 06/23] btrfs: Convert btree_write_cache_pages() to use filemap_get_folio_tag()
Date:   Mon, 12 Sep 2022 11:22:07 -0700
Message-Id: <20220912182224.514561-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cf4f19e80e2f..d1fa072bfdd0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4844,14 +4844,14 @@ int btree_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	int scanned = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
@@ -4874,14 +4874,15 @@ int btree_write_cache_pages(struct address_space *mapping,
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
 	while (!done && !nr_to_write_done && (index <= end) &&
-	       (nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-			tag))) {
+	       (nr_folios = filemap_get_folios_tag(mapping, &index, end,
+					    tag, &fbatch))) {
 		unsigned i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(page, wbc, &epd, &eb_context);
+			ret = submit_eb_page(&folio->page, wbc, &epd,
+					&eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -4896,7 +4897,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 			 */
 			nr_to_write_done = wbc->nr_to_write <= 0;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	if (!scanned && !done) {
-- 
2.36.1

