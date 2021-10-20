Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C3E4354FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 23:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhJTVKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhJTVK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:10:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691DC061769;
        Wed, 20 Oct 2021 14:08:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id t184so4054267pfd.0;
        Wed, 20 Oct 2021 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPxj7lozeCH0kLnc2/lpe544PLDdIaniV+hAq9jcw3Y=;
        b=aaoRyUUDHzIFQzxjETUplwQaxR1W3mqUn0GOKalk/y0EBM61QVOu8EKmRkgltZW3vM
         BoeTTpuQvgdYas3IWbRYAABxsDMDMxC/BXdKsvuzhRHBTIqTQxrUP1Ri0qxhCihWAeBc
         ypu7SxlFkJI2950Of9Dp2oDnTKlCDWPIK9V9tuox4tvKmpLaPnXn8ceg/rx6H2qY9I7P
         X1rTheWtyz54X4mRRcB33yKDNrrxAuRdDJ3C3W9A2ymI9uzF7peyhDvMgfCscYcraBxY
         /wRoXXLnefUy1RLK60ri7D1bkZ+mMXP/ps9TGn3fZaxjFPBLTnqvdzAnV8oLFHIEfehI
         GmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPxj7lozeCH0kLnc2/lpe544PLDdIaniV+hAq9jcw3Y=;
        b=1B510YasJIutODm9vEMlKFHyu6lWFDu2YZ5hw5ofiIdgLvF+z3yySRSP2R0lSk8iBn
         KBY2V2B/ibVuWVT3wHSld858nVzIWgUBpQXRILIDpmhhuvn8ZRpNOjKxMTkvXyKGRZer
         QkAMEoMOU7U9Jq/SeDsThqlqOmEHKRdXDHHPBzNsGg9eB1MNR+5kKevTpoaC9ZyTz367
         PsDAOVkTd0JCmrKkKhc1FCyYkTXYi6+yfBm3RkItuYTDb/M+L7OSneZ4lElM6DyrEMWo
         3AqpOIfEZoGUBrotg4wWUeRLrTkouHgVjHvl9NYa0Xm//oNa4tlHe9GsgM3ZfOrXu25+
         wJ+A==
X-Gm-Message-State: AOAM5303EQw0MjLlhUNA7NfDt95SNYiYh/1clC8hrhtAZxeSPX0Zqt6t
        fDiYt3WZYjM25ylW18MeEbmUoBk0Fe4=
X-Google-Smtp-Source: ABdhPJwJ1bfMEfa0N+uUR9T0CIwfVbfdxBvEBHjDdo9xVZtBYc3GO+RIreIvr1CvuOaFZ8Byfi/9ig==
X-Received: by 2002:a63:340c:: with SMTP id b12mr1227283pga.241.1634764091084;
        Wed, 20 Oct 2021 14:08:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id i8sm3403143pfo.117.2021.10.20.14.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:08:10 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 6/6] mm: hwpoison: handle non-anonymous THP correctly
Date:   Wed, 20 Oct 2021 14:07:55 -0700
Message-Id: <20211020210755.23964-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211020210755.23964-1-shy828301@gmail.com>
References: <20211020210755.23964-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently hwpoison doesn't handle non-anonymous THP, but since v4.8 THP
support for tmpfs and read-only file cache has been added.  They could
be offlined by split THP, just like anonymous THP.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3603a3acf7b3..bd697c64e973 100644
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

