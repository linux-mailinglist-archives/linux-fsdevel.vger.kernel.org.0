Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5B415605
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 05:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbhIWDac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 23:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbhIWDaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:30:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9BC061574;
        Wed, 22 Sep 2021 20:28:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w14so4488065pfu.2;
        Wed, 22 Sep 2021 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+h8wrTzJZjjfH7tY2yFLH7NP1QBWy5O30wQKxmJymV4=;
        b=hqmEEybIRSWPPz61v24K2LWGIel7TrmOjaNcxtI5e/qHjYzx5fQUu5S3j2m3tBkf8S
         5RGK1kiA9L9skOJDUnmUm8d7qdCFa0TxUQ1eKyizQsHCBzJOsF03YTJ+IMsH643WzDTs
         f+zDMKkqCAaglYRIj8kaY+bxy51Ht2CteinUWBX5Dkg4946I4P5CYdA/hInySuupCaaE
         69sWCyO8FAprMMDVzqDHukw6mlTSZmr4bgdlULHlPjKy5ecKCEO+vlshczdwXgrSbHOB
         02zxr70/2OVkZPtKmMBDSoHMg5XbMcguhQJyLskjCQ69DQLvzE33zX6w3ZDX0R82nxVA
         lZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+h8wrTzJZjjfH7tY2yFLH7NP1QBWy5O30wQKxmJymV4=;
        b=w/Z1kA/ua6lljUrzwyLzfzh8uCDJEYcu6dLcVDD2uLCYMVx35k/rjaPneqmKFvWcJU
         w8KMTTbTrbqbOSutEz14jzDynHT0yBouiSYtr/x/WsNR4BJOw66lvYs3+Z6s3omR3BIS
         bSbAldJBm2pVfZ/vw5uj/oypXMzrbnvVwYnScyzdfvnl+dQHMB3XH9xtJeYW/fvBBZlH
         zH/Wu9fmbC4HbOJeoyeoYA72lacy5ahfZ/7MeTCAga5HxzScKmSn4CsUll9NutoVmJtp
         guGk1fzUVgct5o2jnE48WjWAIpPG4SVJNUA+yNN7BBtQbdsZ7uhdjeDCmAH8Y3qJrXFk
         2QgA==
X-Gm-Message-State: AOAM532otnLCwfOOj8v7gHy83qgHy3N1eCwIbXAyv97/NZ0BlPIFJrNq
        y2+DJsZnaVq/5SpLrZSa9mU=
X-Google-Smtp-Source: ABdhPJzRlD1d9wNX1dSsFHR58krR8pQ+R+DP9Tv6lP9bp/AFperRcrMpoeFxbYWZgtGuQ8YtnkEkRw==
X-Received: by 2002:a62:6246:0:b0:443:852a:2a2e with SMTP id w67-20020a626246000000b00443852a2a2emr2113311pfb.14.1632367733052;
        Wed, 22 Sep 2021 20:28:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x8sm3699696pfq.131.2021.09.22.20.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 20:28:52 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 3/5] mm: hwpoison: remove the unnecessary THP check
Date:   Wed, 22 Sep 2021 20:28:28 -0700
Message-Id: <20210923032830.314328-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210923032830.314328-1-shy828301@gmail.com>
References: <20210923032830.314328-1-shy828301@gmail.com>
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

Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7722197b2b9d..5c7f1c2aabd9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1182,20 +1182,6 @@ static int __get_hwpoison_page(struct page *page)
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

