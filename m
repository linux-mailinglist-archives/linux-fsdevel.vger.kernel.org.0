Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F5D62B111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 03:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiKPCKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 21:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiKPCKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:10:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6631DC2;
        Tue, 15 Nov 2022 18:10:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso894065pjg.5;
        Tue, 15 Nov 2022 18:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YDT/XAgh5QSXlyod86SZaadrvntYw6ff/cmVDaxdzo=;
        b=KUWjlw9wAvu8gqDJAwg6cHtHVqa2W7DdXEB14CWlGXOWQBL05awe9s9dxYdOmOMil7
         RyOWv3MuMr+ShlBwAHzlInZpf9WXU4IuK1fknZkWVuLUhQ8t3qI15l9MkRSO5n+vHcVT
         0G/GLoFUHkDLpMMPVn8nqBWlDH6Pk7924RR3Nv4EkBqE4naN+P+eE3gMl2w3L5JfiBO9
         uLiInO8eB3pLYu1bfB9Et5ttZNn5/mdao/zMfopzKv6CaouWP5zWjCj25OIgmti1dk+O
         nFEpT78cOIq9/Ga/a+rQlgFiHnQYnpeeq5IQMaBWKdhVLtzfU4MlOuZxq9iWJZ0LgthU
         2gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YDT/XAgh5QSXlyod86SZaadrvntYw6ff/cmVDaxdzo=;
        b=0HjtuypNrqWhH+TLyWbucaZWeevOkgJvxMr1JFBVOJlsIj8B8RVqsHh1Q7s1xfsu1P
         zos2soldcB9HUaV+tKllCsETu5G+DkOIQNB6VSVg6tzh3brU+m7MJJIhDlEsG/4gXcuP
         nT/Y8Db+q6yowUUuxZymd4BQyKoyAUMHxToSruROREEZ24ViW8jfhF3J1YS04CiDeUzP
         Rlgcwh9ys1c++0GiOdsxWPc+JtYzOhUIt1GOJKcl1C2qGxeZN3RcQ9U79ifWH2P/yMb9
         bcWF6fYgnvUpMXCjTs1945rGVoRIJnik8iR4k22vA1fFEQK0wRtMjkoK0H/M8fVc5x4L
         oXfw==
X-Gm-Message-State: ANoB5pmuqnuCBH6b/7jEfQu+M68gyWxIvwoDTJr8/UA0+adbmEUmiILQ
        0Xp+8zf01vvhFuTJAF2LLuY=
X-Google-Smtp-Source: AA0mqf6ilXQxf7UfCBN93r79wPL21N0NY2osSPVfxzyouO00iRPUQVv81FYoeZnvWALfNK4uiq506A==
X-Received: by 2002:a17:90a:c7c1:b0:213:1f29:2d0a with SMTP id gf1-20020a17090ac7c100b002131f292d0amr1334082pjb.154.1668564618296;
        Tue, 15 Nov 2022 18:10:18 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id e18-20020a17090301d200b0018691ce1696sm10782926plh.131.2022.11.15.18.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:10:17 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/4] khugepage: Replace try_to_release_page() with filemap_release_folio()
Date:   Tue, 15 Nov 2022 18:10:09 -0800
Message-Id: <20221116021011.54164-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116021011.54164-1-vishal.moola@gmail.com>
References: <20221116021011.54164-1-vishal.moola@gmail.com>
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

