Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB00A415607
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 05:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbhIWDah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 23:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbhIWDa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:30:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBBC061764;
        Wed, 22 Sep 2021 20:28:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v19so3504129pjh.2;
        Wed, 22 Sep 2021 20:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mufzV1rPs7RSEi7IGGVM9toNzAQChP8eST1zCDl+0j0=;
        b=a3H/PjnC3mHIrU/Dz1HjgLY8ZABe/dn5M0rM4dKdgaq8xHbRoQbRVN4Y+/prn4VQ6G
         bziLsmnaZCxzFY//q7wpnL6BHO4KtLQ/DO26CDOfbGir8Ujr9jy31E+1xBesSpGk9f/U
         Hy8K5PF5FuAPn4RHdvQY35SZexZ7NBWMhNtb+N+5QAckXNd8/a0QIewQ5SObeTSqOEH7
         zC41oz2uvZRBDKZSbaRLuu/ygh+DcjXqpWP2bq9UeYdR1UDctpUeoIn945q+jOMDN9+3
         +ObIc+P7IAslbSVK4+dFUXY/GcdoA+JOLNDwIhVj3PxBh6fmk4Tt1vNT0hqA4j0Ckc7v
         F7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mufzV1rPs7RSEi7IGGVM9toNzAQChP8eST1zCDl+0j0=;
        b=0h4H8oxbzohnU9Y0GUQywgxa23DdoSe07UGbRXNA4YNK4i5vFwCCimixSmE47rwuJa
         tgwXRen9k2ytZYt1OkpxEzD3UU9OYg9/2XC1zxWOsntwczp79+bGhTkKr2kjlUYjBycp
         DYGL8TIkETIh0UnzGiY6LGkWMFLtyqUwXWCbiOvt+kLHNZaCz/qlFSJuj5hsmvRc/nOy
         p6MB8QL4vzYtD2+YH2lwUq8MWLETWdpAisTyNmIVwvIYI3Q/vvYLYE5a1T9ain/W/zRL
         +wwKKGWacFwiekTD9K9wjM9ROA+qXJVQ7Gf+lvz27MPr1mOqXPoqjrama6IJCE5fcZbZ
         i3Ow==
X-Gm-Message-State: AOAM53199EmiEaCyBvnyo2nmfX2TklNoFm6XNI5Px716YnXutVS+5SSu
        mCoN7s4nUT7u8f9Zv7IxlPf88a+GXnJApQ==
X-Google-Smtp-Source: ABdhPJxE/7FYG7IJ37yN6cBJHRQo7cXfobkaQIfJsJ6JoHQKPSdWaAqhKADJ29U4rK2ujWoua3VnuA==
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr15334262pjq.205.1632367737057;
        Wed, 22 Sep 2021 20:28:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x8sm3699696pfq.131.2021.09.22.20.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 20:28:56 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 5/5] mm: hwpoison: handle non-anonymous THP correctly
Date:   Wed, 22 Sep 2021 20:28:30 -0700
Message-Id: <20210923032830.314328-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210923032830.314328-1-shy828301@gmail.com>
References: <20210923032830.314328-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently hwpoison doesn't handle non-anonymous THP, but since v4.8 THP
support for tmpfs and read-only file cache has been added.  They could
be offlined by split THP, just like anonymous THP.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3824bc708e55..e60224b3a315 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1443,14 +1443,11 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 static int try_to_split_thp_page(struct page *page, const char *msg)
 {
 	lock_page(page);
-	if (!PageAnon(page) || unlikely(split_huge_page(page))) {
+	if (unlikely(split_huge_page(page))) {
 		unsigned long pfn = page_to_pfn(page);
 
 		unlock_page(page);
-		if (!PageAnon(page))
-			pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
-		else
-			pr_info("%s: %#lx: thp split failed\n", msg, pfn);
+		pr_info("%s: %#lx: thp split failed\n", msg, pfn);
 		put_page(page);
 		return -EBUSY;
 	}
-- 
2.26.2

