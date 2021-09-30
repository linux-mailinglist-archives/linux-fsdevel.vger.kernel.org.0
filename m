Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21041E388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 23:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbhI3VzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346766AbhI3VzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:55:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046CFC06176D;
        Thu, 30 Sep 2021 14:53:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m26so6208467pff.3;
        Thu, 30 Sep 2021 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8Io/l9XN5d+My1zgLHEsMOIQE36whO468vLIFQxbEE=;
        b=ANoJfsQGyxPOv21Ujus8FInXNyo9gJKRfdN9mHZYYMspzN9e+u4HZTFKb8Mr5xb8m5
         DrBbPXDmQBDTGo45qi7mcEQuzzy6GWU96fbeby9IczZUGrFMmTG7R6qr9bzE3yvesSvH
         w1yT3aryV4lCcSw+vpo693h07Dp1X0qgh2qPndaC8ZYZfIBMSp5VlTLVeAFKuTHbqwi4
         b0R2Cy2Z9QjwGAf8s3Ul0463UmU3zCIGeNhz5zlvzydbvHIBCD89IIl3BqUG+s3Og+FY
         KqLqzA/Bl0rL+Cr6UiOuNK/h5POJNxvZc+ZPASqsnn6XQRgFA8jPy3j5fDAeohbpwIb9
         3N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8Io/l9XN5d+My1zgLHEsMOIQE36whO468vLIFQxbEE=;
        b=sqJykvWPZO6DLsliXXAN44RJu2b6dQwul4Tp4csnjihPgzCw2gCoLbVspbR3axHQaO
         LpkiaN0WIo6PnM0AkxPBl1O1R7aRKmz9C+Dt/s9Zw58VRjdwIQqYb0cKZb9KxV9quqIa
         dmqs/pmxjmEe/uWmuse2p7CaA3rKqciXGLs0WpO8Dk3+LFuCidPAqIxlOWtliXCbtU07
         MTw3vGzgPSDKRb7DzhgbVApmm34YDWGMPksbc7Y4KL2fjWbdeoGw1eOMDtUGfcBaym76
         LGVrH78EAXy1VwZhMWBJ100onBu6Qy86IJcbY0pmOzhsuGkkKjz4z+iIjYuKV15X/EU0
         X6Zg==
X-Gm-Message-State: AOAM531389GSolIHw4X0bf1xvoSflRwgfNg+PVZfoednX0AyoKq/dwas
        T6Z6TmqPGOrpKYh3FzUepdE=
X-Google-Smtp-Source: ABdhPJzmhdjDnYdU4WOSRyEbQBjz17y/lhOpbsBtQ/Uw538tEKw0Phs73G6Y9DttpgyF5zbMMrGyKQ==
X-Received: by 2002:a62:6544:0:b0:44b:508b:d05c with SMTP id z65-20020a626544000000b0044b508bd05cmr6698352pfb.56.1633038806584;
        Thu, 30 Sep 2021 14:53:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id p17sm5647535pjg.54.2021.09.30.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 14:53:25 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 5/5] mm: hwpoison: handle non-anonymous THP correctly
Date:   Thu, 30 Sep 2021 14:53:11 -0700
Message-Id: <20210930215311.240774-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210930215311.240774-1-shy828301@gmail.com>
References: <20210930215311.240774-1-shy828301@gmail.com>
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
index 176883cd080f..88866bf4f4a9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1447,14 +1447,11 @@ static int identify_page_state(unsigned long pfn, struct page *p,
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

