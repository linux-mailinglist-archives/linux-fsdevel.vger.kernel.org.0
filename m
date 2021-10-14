Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCA442E1E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 21:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhJNTSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhJNTS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:18:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99FC061570;
        Thu, 14 Oct 2021 12:16:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x130so6297580pfd.6;
        Thu, 14 Oct 2021 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YY4rRYrBdBk9JxylDDW+2MAnqVHDh/g91wQSCjGEN3A=;
        b=ZTatkiV+zrVwKLUnasRwkpFNpr7/o2XY28zcF67FFhF+pC/7r2ARJFUqLPtxOoPbFG
         BEksFd4gGAj6siRu5BltbiFR1izTOrNoTz0Rvd+1J9eTovkKQ3Epom44OCjZ5R90Jyqi
         I4jLrHIS1WCmrM6H1sPLNGwQvQueW4WIDqykOK3C2IjAVZ0cX8xxqozjQkYXnUySnCaP
         z6ev500+1bgIG67r+ykneaMyOM10O166SrXbR8+Ow7+SKZFTcb4oMYlZD5PK12ghW6c0
         tyKTzeTxfEKbgyRbNblUjrR8qfym56YfXGJqIx9+f4a46vukcfGB7SZA+lOA7Mf7pE6y
         +8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YY4rRYrBdBk9JxylDDW+2MAnqVHDh/g91wQSCjGEN3A=;
        b=B/qAPk5y8nmvAQCMBChmin0l1fU9giWTurZoV2GemxzAXRLbiYU51x4GH3foZ3J3jT
         f8JlV7I+62epj1j78g5xhUzaNxOp6AUapEb8Lq8Xvrb2p3ONaOI8XfyhCaZ6m+hpD+wz
         +LZNyPvYWXwvTNivZqWr8hJsG41SMuSfSlN8cRcYLdkeQ5C0DwJqzc9xHt5BgMRObB6Q
         mO9syh8wyIJD1fkKir628am9/i+uvDG8XNAZmTX4A4Kw/CHVB0vP9oZFdFpdMMXPptTO
         eJt+rcsg8S6Cd+jwgbYbXycJ73sJQAedUW/RmY65usVwnv+KhfmEg+qPP8WqtmNRcqif
         sbAg==
X-Gm-Message-State: AOAM530Y2oh/aJPxAbdGaS8lcWJCZDPcPPH/Obwq6xPgmo+51ULHTmv8
        7/DKNvOVAucD6kIEgL6nW5c=
X-Google-Smtp-Source: ABdhPJxVrYI017AWLFsYOxZJWSp64W08P8F6AE0lo9NraLydbu+Vk25cRlc2twpldnxPi+rah6UZcA==
X-Received: by 2002:aa7:88cc:0:b0:431:c124:52ba with SMTP id k12-20020aa788cc000000b00431c12452bamr7174421pff.63.1634238983964;
        Thu, 14 Oct 2021 12:16:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x129sm3253922pfc.140.2021.10.14.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:16:22 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 1/6] mm: hwpoison: remove the unnecessary THP check
Date:   Thu, 14 Oct 2021 12:16:10 -0700
Message-Id: <20211014191615.6674-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211014191615.6674-1-shy828301@gmail.com>
References: <20211014191615.6674-1-shy828301@gmail.com>
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

