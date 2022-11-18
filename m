Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE5662EE63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 08:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbiKRHbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 02:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241180AbiKRHbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:31:02 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F4E7EBCD;
        Thu, 17 Nov 2022 23:31:02 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g62so4111161pfb.10;
        Thu, 17 Nov 2022 23:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YDT/XAgh5QSXlyod86SZaadrvntYw6ff/cmVDaxdzo=;
        b=hj4sZ/oWS0i8ScGh0vbYAIusnjEYl4+v/V1w1lie+penPK+3QNfEw3e9lA2YvJY2vR
         6U/s2favaWtrdVTN7ZxQYN3TNv3Gzmpp604WxQwf07cMv2V49N2eaV7INf9Mr/Fka3YI
         xDOXnWXwgetOrVE/PlHzDoVG1SMMD4hoFkHh/oQNMdcDaEpRuTgXjAO9bddr37OTQA9S
         ktOJf5nHzqLSna/GQtVnkHo4D6L/QgA1XlGFW6vtKLEvNOd3QZJfPnrf0ZJ6H9hrmP42
         2o4Oyky8msMLDuOQ8ogXe9MjRO0eSJ3lurHDvLvpnWxaXJlo2L20CeupZWrVkRx6b2tf
         oYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YDT/XAgh5QSXlyod86SZaadrvntYw6ff/cmVDaxdzo=;
        b=NSkxy0zpHpj8XCqSBDQ8eSGvSCt8q1QUxAqk3Yo4TYPe7C2lp4QoeiHf0CgmWbhJ1K
         3MamBtCrYV7LKZJud0GXw2OPqewHhLhSu78kOUXTI11zo6da6nbsV7ZD09pEE92O+tjN
         ifcbGWaNXP+ubbSJGeJOoTc70j/G3d6187Osx1E0H0idrjVEcupbRbUzZl8R1dtatdhF
         0puz2olOmbbWtLwxjd8DnuHDhiiS1wx2yr3ycoCdWk/XJbwag29ya+KyydseotnSl9Jq
         MNS24gwhyHxS5fjQZg88HoxsOZF+tF0p174uA2HJOwbaru4k5FEPNacY5wx0RE704V/9
         E2Aw==
X-Gm-Message-State: ANoB5pnsIkBO0aJ3IWESFTGgZz32mST/X7Kb5oYTMiyJjAKOs3kaRUtN
        9OBDDQeYM1Kqh9UEiDEsuAANe32IzzBCyw==
X-Google-Smtp-Source: AA0mqf6Qwaa+ZZgNht+Axt+loxkyuK9nKvCzY0zbAE/3kovjQkyD7Ab088QV4MqOyd52TwsU9j43RQ==
X-Received: by 2002:a63:1c66:0:b0:476:c782:e5d1 with SMTP id c38-20020a631c66000000b00476c782e5d1mr5496113pgm.261.1668756661587;
        Thu, 17 Nov 2022 23:31:01 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f7-20020a625107000000b0056b818142a2sm2424325pfb.109.2022.11.17.23.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:31:01 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 2/4] khugepage: Replace try_to_release_page() with filemap_release_folio()
Date:   Thu, 17 Nov 2022 23:30:53 -0800
Message-Id: <20221118073055.55694-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118073055.55694-1-vishal.moola@gmail.com>
References: <20221118073055.55694-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replaces some calls with their folio equivalents. This change removes
4 calls to compound_head() and is in preparation for the removal of the
try_to_release_page() wrapper.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..3f21c010d2bd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1747,6 +1747,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	xas_set(&xas, start);
 	for (index = start; index < end; index++) {
 		struct page *page = xas_next(&xas);
+		struct folio *folio;
 
 		VM_BUG_ON(index != xas.xa_index);
 		if (is_shmem) {
@@ -1773,8 +1774,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			}
 
 			if (xa_is_value(page) || !PageUptodate(page)) {
-				struct folio *folio;
-
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_get_folio(mapping->host, index,
@@ -1862,13 +1861,15 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			goto out_unlock;
 		}
 
-		if (page_mapping(page) != mapping) {
+		folio = page_folio(page);
+
+		if (folio_mapping(folio) != mapping) {
 			result = SCAN_TRUNCATED;
 			goto out_unlock;
 		}
 
-		if (!is_shmem && (PageDirty(page) ||
-				  PageWriteback(page))) {
+		if (!is_shmem && (folio_test_dirty(folio) ||
+				  folio_test_writeback(folio))) {
 			/*
 			 * khugepaged only works on read-only fd, so this
 			 * page is dirty because it hasn't been flushed
@@ -1878,20 +1879,20 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			goto out_unlock;
 		}
 
-		if (isolate_lru_page(page)) {
+		if (folio_isolate_lru(folio)) {
 			result = SCAN_DEL_PAGE_LRU;
 			goto out_unlock;
 		}
 
-		if (page_has_private(page) &&
-		    !try_to_release_page(page, GFP_KERNEL)) {
+		if (folio_has_private(folio) &&
+		    !filemap_release_folio(folio, GFP_KERNEL)) {
 			result = SCAN_PAGE_HAS_PRIVATE;
-			putback_lru_page(page);
+			folio_putback_lru(folio);
 			goto out_unlock;
 		}
 
-		if (page_mapped(page))
-			try_to_unmap(page_folio(page),
+		if (folio_mapped(folio))
+			try_to_unmap(folio,
 					TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
 
 		xas_lock_irq(&xas);
-- 
2.38.1

