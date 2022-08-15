Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EBD593C81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 22:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiHOUNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 16:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242724AbiHOUJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EF91CD;
        Mon, 15 Aug 2022 11:56:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d20so7329816pfq.5;
        Mon, 15 Aug 2022 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EVNfKk5ZAzp2gPep1Yofo/UzU1m6EYLq8voCf56STj8=;
        b=M8IZIk7Jp8250xvZqGSMpvSUeZ3dvuFn3bLOlwIQycHml+YrzlnYk0wuRdVtsm8HzU
         bvV65mni8k2mo/XT9hYMsHRILCfrChluFWNGS/L4GOgJ3HhjZGjaAydrW7Z+ztq40Egv
         3wDl0SMEYJ2Fy/s4RzU0l1aGaYxJMmiBfcHn4FhsVr4s7NJVUw6ov8jHJZrpyd8vArg0
         c7Ko09i20UU7E/MjJRaWpiaq4u0vVa0I+rSEomiRhlwa/sFcyD/BE093QgNiriTA2ki7
         vz5yVxU4u1BU6qGKeJnATjpNPSjpB+ezcTUrbIiPkqD4tjBgq9e+1Ui3xXrJ+vmpSBN6
         LlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EVNfKk5ZAzp2gPep1Yofo/UzU1m6EYLq8voCf56STj8=;
        b=4CXbDqVaZZyiteYFp/i602MEn5osqbbEz6iAAHd+CPe1vxLFEHssENYTMT+uoKewVq
         43x0+R1r8psPWO1FI9y36H/23jyZFaDorQSze+gn7acHkfupc4gqmGuVEt9G2jGWqe21
         B1XddHbAQ2BDvHp1mDP4KuPEuAAX/aFgaRTAyuMoKUsod4YKOI3aFoCTxU7gtiIJKWIP
         E+xvPKaL3ue9eNyy5nGNhqw/cEG/vZ7ABHZ3P2XJdGw9lg1ToUDpBpgVp8HSWgCViOCw
         wnyZ07fRt1Nn1E2542tSl/2FkAZnBUtJlghKysDnpWrCDE3roWJj8+Y33Yjr7hnOBaEN
         viUQ==
X-Gm-Message-State: ACgBeo20xx/bWTgtusV6nGzk8qN/JmbDXb4GI4auhxOeoFadDhVizp6z
        7lZo3VP8I9gLiUtRPO4g/6xae28mh4ZeVS/g
X-Google-Smtp-Source: AA6agR5AZjMZG0XiC1/OQks2+/viJeEXuejuN52kw77RNDFEYI4CLvS7tEmJitupYm81daGL/6HH6A==
X-Received: by 2002:a63:1342:0:b0:422:5e7a:2a8f with SMTP id 2-20020a631342000000b004225e7a2a8fmr13035811pgt.425.1660589762829;
        Mon, 15 Aug 2022 11:56:02 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x190-20020a6231c7000000b0052def2e20dasm6858174pfx.167.2022.08.15.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:56:02 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 5/7] nilfs2: Convert nilfs_find_uncommited_extent() to use filemap_get_folios_contig()
Date:   Mon, 15 Aug 2022 11:54:50 -0700
Message-Id: <20220815185452.37447-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220815185452.37447-1-vishal.moola@gmail.com>
References: <20220815185452.37447-1-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_contig(). Now also supports large folios.

Also cleaned up an unnecessary if statement - pvec.pages[0]->index > index
will always evaluate to false, and filemap_get_folios_contig() returns 0 if
there is no folio found at index.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/nilfs2/page.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 3267e96c256c..40cc8eb0bc8e 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -480,13 +480,13 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
 					    sector_t *blkoff)
 {
-	unsigned int i;
+	unsigned int i, nr;
 	pgoff_t index;
 	unsigned int nblocks_in_page;
 	unsigned long length = 0;
 	sector_t b;
-	struct pagevec pvec;
-	struct page *page;
+	struct folio_batch fbatch;
+	struct folio *folio;
 
 	if (inode->i_mapping->nrpages == 0)
 		return 0;
@@ -494,27 +494,24 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 	index = start_blk >> (PAGE_SHIFT - inode->i_blkbits);
 	nblocks_in_page = 1U << (PAGE_SHIFT - inode->i_blkbits);
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 repeat:
-	pvec.nr = find_get_pages_contig(inode->i_mapping, index, PAGEVEC_SIZE,
-					pvec.pages);
-	if (pvec.nr == 0)
+	nr = filemap_get_folios_contig(inode->i_mapping, &index, ULONG_MAX,
+			&fbatch);
+	if (nr == 0)
 		return length;
 
-	if (length > 0 && pvec.pages[0]->index > index)
-		goto out;
-
-	b = pvec.pages[0]->index << (PAGE_SHIFT - inode->i_blkbits);
+	b = fbatch.folios[0]->index << (PAGE_SHIFT - inode->i_blkbits);
 	i = 0;
 	do {
-		page = pvec.pages[i];
+		folio = fbatch.folios[i];
 
-		lock_page(page);
-		if (page_has_buffers(page)) {
+		folio_lock(folio);
+		if (folio_buffers(folio)) {
 			struct buffer_head *bh, *head;
 
-			bh = head = page_buffers(page);
+			bh = head = folio_buffers(folio);
 			do {
 				if (b < start_blk)
 					continue;
@@ -532,18 +529,17 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 
 			b += nblocks_in_page;
 		}
-		unlock_page(page);
+		folio_unlock(folio);
 
-	} while (++i < pagevec_count(&pvec));
+	} while (++i < nr);
 
-	index = page->index + 1;
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 	goto repeat;
 
 out_locked:
-	unlock_page(page);
+	folio_unlock(folio);
 out:
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	return length;
 }
-- 
2.36.1

