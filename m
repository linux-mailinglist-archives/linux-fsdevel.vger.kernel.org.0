Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C324354F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhJTVKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 17:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhJTVKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:10:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC9C06161C;
        Wed, 20 Oct 2021 14:08:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i1so415448plr.13;
        Wed, 20 Oct 2021 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YY4rRYrBdBk9JxylDDW+2MAnqVHDh/g91wQSCjGEN3A=;
        b=OSTKM/8ENI2Vrjms0RwHS0lb7YTvIGp+fuXdcepf9PwoX/X6lDtdcI/3u0xImDro9C
         M/FuWwpv+d8D++3ZxWN54YWrm5HkuekFOPbCpTkzCO0fdK4r0tOQu1o0B6jY+kst6py8
         TNllZEKCAMZJGjuZGVFlKO4sjib/D6/nHxqmBKrP6EvjTHtLlGQo48HfEHus+YJlUU86
         6cfADR4HQJG2MTmgShTiJTkzu7NWm4+2xQk+L35yHcGcBwzMQQD/ad5txGLzIqiHedQx
         +FTgaFLNh1hh2X/lMWy2t0OtGt5RTMuFkPaig9W9DDhYW2muKMH8Osr2pF5CB1p3+3Ni
         w8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YY4rRYrBdBk9JxylDDW+2MAnqVHDh/g91wQSCjGEN3A=;
        b=c6PKMHf3UUTPkR6zhVr05CmoWLgYvdlgij4x3oMHM2xWTpJgzcS+pDhjsz/RBfdWpj
         Om5H7dbpVf48TaKwz8IlgfsWQ8DDlk9W0AiMopRCR5Fxquu3hfdZp20ZvfbXOr9R4SEh
         imK23acoRyXhbwpr7Fh9PWUYMA29awZo+yrxqJFg+J8Z5QnWjJELTRdgq7thxlNVU49C
         31GHvHN8nt2ffXZbr6fIuS3AlAl1PjRoyf15MakNKTg5RBCcJ10LPzwWsj8iHBAR5LLd
         kKJ6CR2IFAycGy48vZlXN6rUu8BEHFROInjTxOL4Qa228yEavU3OLX+Czoy87iBfqzYq
         +81g==
X-Gm-Message-State: AOAM5300qag88AeISGL42dz5rKrV6Fr/Xsp5gKqgT/+OE4UgjAS8yU2n
        vLUo3FagOkGahFkTSyDzwnc=
X-Google-Smtp-Source: ABdhPJzc3KspH4ZB0okwrRVGixRXsTVfHp1xrC+0xaV0LCp6se+ciHgv2NcQtUdJEOO+YeJiN/4xZA==
X-Received: by 2002:a17:90a:df8f:: with SMTP id p15mr1087750pjv.209.1634764081184;
        Wed, 20 Oct 2021 14:08:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id i8sm3403143pfo.117.2021.10.20.14.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:08:00 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 1/6] mm: hwpoison: remove the unnecessary THP check
Date:   Wed, 20 Oct 2021 14:07:50 -0700
Message-Id: <20211020210755.23964-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211020210755.23964-1-shy828301@gmail.com>
References: <20211020210755.23964-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When handling THP hwpoison checked if the THP is in allocation or free
stage since hwpoison may mistreat it as hugetlb page.  After
commit 415c64c1453a ("mm/memory-failure: split thp earlier in memory error
handling") the problem has been fixed, so this check is no longer
needed.  Remove it.  The side effect of the removal is hwpoison may
report unsplit THP instead of unknown error for shmem THP.  It seems not
like a big deal.

The following patch depends on this, which fixes shmem THP with
hwpoisoned subpage(s) are mapped PMD wrongly.  So this patch needs to be
backported to -stable as well.

Cc: <stable@vger.kernel.org>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3e6449f2102a..73f68699e7ab 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1147,20 +1147,6 @@ static int __get_hwpoison_page(struct page *page)
 	if (!HWPoisonHandlable(head))
 		return -EBUSY;
 
-	if (PageTransHuge(head)) {
-		/*
-		 * Non anonymous thp exists only in allocation/free time. We
-		 * can't handle such a case correctly, so let's give it up.
-		 * This should be better than triggering BUG_ON when kernel
-		 * tries to touch the "partially handled" page.
-		 */
-		if (!PageAnon(head)) {
-			pr_err("Memory failure: %#lx: non anonymous thp\n",
-				page_to_pfn(page));
-			return 0;
-		}
-	}
-
 	if (get_page_unless_zero(head)) {
 		if (head == compound_head(page))
 			return 1;
-- 
2.26.2

