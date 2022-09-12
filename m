Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427795B60DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiILS3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiILS2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:28:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346C45987;
        Mon, 12 Sep 2022 11:26:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f24so9394588plr.1;
        Mon, 12 Sep 2022 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BDjCowA00FLyTw2IZ0c6KLYAlD0lJWdoqS+0xSa08wc=;
        b=YdCS4mb2VUuuI+vH3RFZFwtKJ7x4FizIRVDEtIMof7eBdc2xa204LEqFJKqjq36AD4
         wZaqM9AjOqNCZQbY6Fpfnt72m7ehsWxTnn4nx8xNUn+X9K9pUFZz4D5QM7Ts62mkjRKy
         pGraHvdMM1hijVJEZbFlxwdqS8JEfBLK9FvHhW23Z3E31ZL7pa+2eYT3UHNOfRSu+99q
         cjZnUPeaDQ9zelAE/mkEUSEU2Q1iW6YawaZ8vZOuo+tKw+WBDT7EcWDlSWJb6EvY/hcU
         EjmvnoT+9nJTwSHk1SyaClmJtJu89VKBjT7TP0Z55JrSAnflKDsBPRRkfILl/JjbkXEm
         WSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BDjCowA00FLyTw2IZ0c6KLYAlD0lJWdoqS+0xSa08wc=;
        b=1Oz7dcxCgD0v42Oq35o7tZJeF+DsjYC2MHggglKiF6Hun0kcq2j67Gi4rSEXpMWqxI
         sOIx7ohCB4ITtiesfxAY8H+gT2LyOHEItGle3M4Ot46RQyY3nMVV3MaKzroDN2oEpQcG
         rCdhgCCwQmsTPA2gBr8qIsHkq1NG5QzRBUhuHPJ3qDPcDidxN2X4O4fy1BiXTDMJo93Q
         dnQeLNGb+57HuBLk06IkBXsiOSkzNON6+tNu5tgp3Hk0YsWSB7YEJUcVMVYfLQyqf3z4
         zpFjJlEZOjK/yML5Nbfr9PVySPX8BlvpNSC16G3Dd1zt86S/eaM8/GNGLteC2cF5mCOF
         /MVw==
X-Gm-Message-State: ACgBeo2emtnv/pMgiFrA1zGKizy13h42X4+ZLYy0whdjjM0PK603Ltrs
        l2/AdkGEfN2Cn0wR1MPZWWriTR4VbIlEhw==
X-Google-Smtp-Source: AA6agR7UKj1n3Ku5QzSvYbuBiePM1904QkRm9obfKEPcnQW6FL+0WBcOg4ndj2Z3wIamBQ2w8m5PpA==
X-Received: by 2002:a17:90a:9f96:b0:1fa:b4fb:6297 with SMTP id o22-20020a17090a9f9600b001fab4fb6297mr25133060pjp.80.1663007156873;
        Mon, 12 Sep 2022 11:25:56 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:56 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 21/23] nilfs2: Convert nilfs_copy_dirty_pages() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:22 -0700
Message-Id: <20220912182224.514561-22-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 3267e96c256c..5c96084e829f 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -240,42 +240,43 @@ static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
 int nilfs_copy_dirty_pages(struct address_space *dmap,
 			   struct address_space *smap)
 {
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	unsigned int i;
 	pgoff_t index = 0;
 	int err = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 repeat:
-	if (!pagevec_lookup_tag(&pvec, smap, &index, PAGECACHE_TAG_DIRTY))
+	if (!filemap_get_folios_tag(smap, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch))
 		return 0;
 
-	for (i = 0; i < pagevec_count(&pvec); i++) {
-		struct page *page = pvec.pages[i], *dpage;
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		struct folio *folio = fbatch.folios[i], *dfolio;
 
-		lock_page(page);
-		if (unlikely(!PageDirty(page)))
-			NILFS_PAGE_BUG(page, "inconsistent dirty state");
+		folio_lock(folio);
+		if (unlikely(!folio_test_dirty(folio)))
+			NILFS_PAGE_BUG(&folio->page, "inconsistent dirty state");
 
-		dpage = grab_cache_page(dmap, page->index);
-		if (unlikely(!dpage)) {
+		dfolio = filemap_grab_folio(dmap, folio->index);
+		if (unlikely(!dfolio)) {
 			/* No empty page is added to the page cache */
 			err = -ENOMEM;
-			unlock_page(page);
+			folio_unlock(folio);
 			break;
 		}
-		if (unlikely(!page_has_buffers(page)))
-			NILFS_PAGE_BUG(page,
+		if (unlikely(!folio_buffers(folio)))
+			NILFS_PAGE_BUG(&folio->page,
 				       "found empty page in dat page cache");
 
-		nilfs_copy_page(dpage, page, 1);
-		__set_page_dirty_nobuffers(dpage);
+		nilfs_copy_page(&dfolio->page, &folio->page, 1);
+		filemap_dirty_folio(folio_mapping(dfolio), dfolio);
 
-		unlock_page(dpage);
-		put_page(dpage);
-		unlock_page(page);
+		folio_unlock(dfolio);
+		folio_put(dfolio);
+		folio_unlock(folio);
 	}
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 
 	if (likely(!err))
-- 
2.36.1

