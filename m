Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E558A518
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 05:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiHEDja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 23:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHEDj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:39:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F952DFD;
        Thu,  4 Aug 2022 20:39:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a8so1549079pjg.5;
        Thu, 04 Aug 2022 20:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8sfhr26tDeV/L6Ozp357rvkDwH/uFe9BTr+eNIF+xXU=;
        b=X1hd/w3YEpI3L9ZDpSiZE2PikM1J7Pe3b8stV716zhBQWlz5e/jFp5EH4iS8/6rGkk
         TKOdqWCPnjrkfyLSGL5pvtbR3/A2S+XuCZ+urLJfRtlj599saXjaXOlWWHvnxRpWNd/b
         QZLzHt9z5becYsv0gERZb+yxWXpU2B954h/wAUSJ08jYBNg2lJ8cdVQ2RCD+u/LflDVE
         PE8t4Zn6TnS0BM99pdboDpgOC62MN9l+nJqRbVoR3P80Nqr15VlGnHEy1d02qmr0zGyw
         Z6oZ/B6G60t/z4fwAmgRk9PhXW4VUNyiDBeVjA7vmHbEQo5MutdenqAGulC9XBaH0AQi
         kxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8sfhr26tDeV/L6Ozp357rvkDwH/uFe9BTr+eNIF+xXU=;
        b=XcPsSmfk9dHebbX4wxiKpBc/zTKZKqUOESEqTg8eZuOZebWkUIrzOo27LL33HR+LjW
         lJzqeAGIiNkGYaa3eGrk4QgmztoeCpq+qovz5O9Zv/ODnSb7kYpUsDhQizm80n1gOVuP
         NckhgzCTq/3fQAAIIyC1c7Hyu4ujPWa2UZ3h847Fw4wwkJlJIfkJnXJuiBva4XqefXv/
         xoVtat1Lxb2iOglVCbeH0mv9PyfaGIl60RASX/xEZFSjge7CkTZqCRabhFruydQOGkm3
         P41iYOe73BT3ZgweVfetMvYG+6ydA5GWSbOODvC+amLSOM35YMMAFPuzKTup/1TfWtz4
         1PYA==
X-Gm-Message-State: ACgBeo2PgWbja+sE5oOge+Lin4rBtdNMNeNwK2eGEnVi9GPFTKItNUgu
        r8wNhCBobNHwt3S6SonP07o=
X-Google-Smtp-Source: AA6agR5923Jd70u1CMa/1BKAWCZxfqiG1OIy0Fvu624VKXl6nFsBzl39y13ZzjHWnaJxGJnh1AsWbA==
X-Received: by 2002:a17:902:8693:b0:16c:db86:1c86 with SMTP id g19-20020a170902869300b0016cdb861c86mr4805594plo.9.1659670766619;
        Thu, 04 Aug 2022 20:39:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n15-20020a170903110f00b0016ef1e058e5sm1683706plh.295.2022.08.04.20.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:39:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, bsingharora@gmail.com
Cc:     corbet@lwn.net, willy@infradead.org, yang.yang29@zte.com.cn,
        david@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] filemap: Make the accounting of thrashing more consistent
Date:   Fri,  5 Aug 2022 03:38:39 +0000
Message-Id: <20220805033838.1714674-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Yang Yang <yang.yang29@zte.com.cn>

Once upon a time, we only support accounting thrashing of page cache.
Then Joonsoo introduced workingset detection for anonymous pages and
we gained the ability to account thrashing of them[1].

So let delayacct account both the thrashing of page cache and anonymous
pages, this could make the codes more consistent and simpler.

[1] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 Documentation/accounting/delay-accounting.rst |  2 +-
 mm/filemap.c                                  | 18 ++++--------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 241d1a87f2cd..7103b62ba6d7 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -13,7 +13,7 @@ a) waiting for a CPU (while being runnable)
 b) completion of synchronous block I/O initiated by the task
 c) swapping in pages
 d) memory reclaim
-e) thrashing page cache
+e) thrashing
 f) direct compact
 g) write-protect copy
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..cfe15e89b3c2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1221,15 +1221,11 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
 	bool thrashing = false;
-	bool delayacct = false;
 	unsigned long pflags;
 
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
-		if (!folio_test_swapbacked(folio)) {
-			delayacct_thrashing_start();
-			delayacct = true;
-		}
+		delayacct_thrashing_start();
 		psi_memstall_enter(&pflags);
 		thrashing = true;
 	}
@@ -1329,8 +1325,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	finish_wait(q, wait);
 
 	if (thrashing) {
-		if (delayacct)
-			delayacct_thrashing_end();
+		delayacct_thrashing_end();
 		psi_memstall_leave(&pflags);
 	}
 
@@ -1378,17 +1373,13 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
 	bool thrashing = false;
-	bool delayacct = false;
 	unsigned long pflags;
 	wait_queue_head_t *q;
 	struct folio *folio = page_folio(pfn_swap_entry_to_page(entry));
 
 	q = folio_waitqueue(folio);
 	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
-		if (!folio_test_swapbacked(folio)) {
-			delayacct_thrashing_start();
-			delayacct = true;
-		}
+		delayacct_thrashing_start();
 		psi_memstall_enter(&pflags);
 		thrashing = true;
 	}
@@ -1435,8 +1426,7 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
 	finish_wait(q, wait);
 
 	if (thrashing) {
-		if (delayacct)
-			delayacct_thrashing_end();
+		delayacct_thrashing_end();
 		psi_memstall_leave(&pflags);
 	}
 }
-- 
2.25.1

