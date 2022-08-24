Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91659F05E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 02:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiHXAm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 20:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiHXAmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:42:54 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E8861D4;
        Tue, 23 Aug 2022 17:42:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g129so11680896pfb.8;
        Tue, 23 Aug 2022 17:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KyMLiEXuqe6oMgJlOPUNT684cH6jPO08N05OJyEa5MI=;
        b=JXzLL8UAMMTyqxQPGNwR9rod7kTLexta+9ZdxunA7mrxp0SsVejkQaJC5Bmil85eaD
         jH1a6u8Qw8HCxqsOCfUc6dXwabaWbL1o3EKqezvzeM4nqchYD0Zj+Nmw3zXtu6Ivc5f1
         EmVyKyYwbbK3AEFq5jQHeUtGYTArf4JfFOUDCmZx6nsXZ5aoClbLow/COO51EDjyteN0
         Z5h2uy3b6bEdUihA/HT+I9Z7cRXmvPNXWmft999iQHIXvE2GFKctDA5u/QCN3Gs/WtGS
         mygT/DoUY6gHw3/Bu1+ryrseK5gWZjTBlO4ZKmPq4oIHx6urSYB5Io7e8qe2QSPRV7El
         NI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KyMLiEXuqe6oMgJlOPUNT684cH6jPO08N05OJyEa5MI=;
        b=IoiTr604QBuKUqdCNQkK18I7Q83akzdtn5jq72MV0xVE98SQ5VNGYOjtd/zh+tJXKj
         4QkXFq5f+voJhQycUwCEV/fKEk74c6kdPOzSoTRq8IEmIZRZc20ElnkpCome8CpnyKNR
         2YxqXCyW6uwq8S+y9oVR45/7js6WCDSnOr9pZK7Qi3JzEZfCvZE8q4Aqxpwo1yIQTKM/
         D4bSqdIhAhdP2VeLY92IYlJWJ4fDEDn1+9asVFod2keWIBPKlL1RTZXaftObgzHJtSJq
         792Rvu65Vw/WZOVjSYG7BYOfKxpGlRRE8NoPQC0wqxJPvovboIMqXq0afcWvUryI9okJ
         hLKg==
X-Gm-Message-State: ACgBeo0rP+MD/xxTnNkKYbi+YrkxwolRLO4DgXKDb+wJskt5Pirzu5iX
        ccClrrwY7izE5vzT1voIJ57YBg9W1Hf7grmp
X-Google-Smtp-Source: AA6agR7ZhhuWt7Z3orz6dRd2bYxDUpCPJIMRmnwoYYc0vK/g3DtqDkZxoGhhEptFnPNqDJqxc/NxIg==
X-Received: by 2002:aa7:8887:0:b0:536:a411:40d0 with SMTP id z7-20020aa78887000000b00536a41140d0mr11726341pfe.46.1661301771045;
        Tue, 23 Aug 2022 17:42:51 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id ij5-20020a170902ab4500b0016dd667d511sm11063319plb.252.2022.08.23.17.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:42:50 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 5/7] nilfs2: Convert nilfs_find_uncommited_extent() to use filemap_get_folios_contig()
Date:   Tue, 23 Aug 2022 17:40:21 -0700
Message-Id: <20220824004023.77310-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824004023.77310-1-vishal.moola@gmail.com>
References: <20220824004023.77310-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 fs/nilfs2/page.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 3267e96c256c..39b7eea2642a 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -480,41 +480,36 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
 					    sector_t *blkoff)
 {
-	unsigned int i;
+	unsigned int i, nr_folios;
 	pgoff_t index;
-	unsigned int nblocks_in_page;
 	unsigned long length = 0;
-	sector_t b;
-	struct pagevec pvec;
-	struct page *page;
+	struct folio_batch fbatch;
+	struct folio *folio;
 
 	if (inode->i_mapping->nrpages == 0)
 		return 0;
 
 	index = start_blk >> (PAGE_SHIFT - inode->i_blkbits);
-	nblocks_in_page = 1U << (PAGE_SHIFT - inode->i_blkbits);
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 repeat:
-	pvec.nr = find_get_pages_contig(inode->i_mapping, index, PAGEVEC_SIZE,
-					pvec.pages);
-	if (pvec.nr == 0)
+	nr_folios = filemap_get_folios_contig(inode->i_mapping, &index, ULONG_MAX,
+			&fbatch);
+	if (nr_folios == 0)
 		return length;
 
-	if (length > 0 && pvec.pages[0]->index > index)
-		goto out;
-
-	b = pvec.pages[0]->index << (PAGE_SHIFT - inode->i_blkbits);
 	i = 0;
 	do {
-		page = pvec.pages[i];
+		folio = fbatch.folios[i];
 
-		lock_page(page);
-		if (page_has_buffers(page)) {
+		folio_lock(folio);
+		if (folio_buffers(folio)) {
 			struct buffer_head *bh, *head;
+			sector_t b;
 
-			bh = head = page_buffers(page);
+			b = folio->index << (PAGE_SHIFT - inode->i_blkbits);
+			bh = head = folio_buffers(folio);
 			do {
 				if (b < start_blk)
 					continue;
@@ -529,21 +524,17 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 		} else {
 			if (length > 0)
 				goto out_locked;
-
-			b += nblocks_in_page;
 		}
-		unlock_page(page);
+		folio_unlock(folio);
 
-	} while (++i < pagevec_count(&pvec));
+	} while (++i < nr_folios);
 
-	index = page->index + 1;
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 	goto repeat;
 
 out_locked:
-	unlock_page(page);
-out:
-	pagevec_release(&pvec);
+	folio_unlock(folio);
+	folio_batch_release(&fbatch);
 	return length;
 }
-- 
2.36.1

