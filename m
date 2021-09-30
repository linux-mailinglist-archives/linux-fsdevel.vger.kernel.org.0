Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24E41E381
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 23:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbhI3VzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343536AbhI3VzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:55:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84C3C06176A;
        Thu, 30 Sep 2021 14:53:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t4so5011763plo.0;
        Thu, 30 Sep 2021 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNfb7Z+wUBDNis53ymmcIpFweUVDBAEhTaRnY1TJVBw=;
        b=G9QLs9Qn5P/4JdctPSPNBA4PEalzsnjwlft8+Q81RMPBqVZGcv4i6y+gomgUSyMnnu
         JeeIOYnbJx+m/3ntVOiNWPjEYmAkksmDmqA1FY+ajgKAa65tACZNQ+nLrnNM+hQbqn5f
         i1gh5mbRKXaZ7whEDz6y/7MpP0yLPbCh3102O3B8espKozZHWjNnca6PsoYGxqIf695c
         GZoGLL5rsokg0Wfx2aKGLXt4NPJQar03Z9FbvCVBDdUTpyKZPkxIdBMR/oNMyTmkUd7+
         //TSqaH+4hZ92j0LPWS92+2MSaz5DD2X/F2mCLTFimOQtmvQ7Q5WAd78xxZ0j/NygBB+
         T8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNfb7Z+wUBDNis53ymmcIpFweUVDBAEhTaRnY1TJVBw=;
        b=p6jSJyVbdMyiHu3Sq0WH30QjKI6dy7teZSryt1pYZc+Lpqs17ZA/iSykNmB6zxM154
         0Zv1ryVijQV1L8qYPfWAf3WqyGJb1QgInb/nDipgFCrAblg1xm0FNd8anQh2S5psGLMu
         ePzyMDXZFT41tjVavKF7hJz4pKJzW0VbeVSz0lxVlq0b91jjAvprkttnqTK84FdLVyOK
         eyp6cbzpVi/vfHz1+R7rcfTJTY60LISlivOrD1prBkMy8HCw/z1UKX/aQzRhoMKxN/y3
         jHLZCapL2ui6UovgAlclRt1m1M3nF2xoYfXVIk/hYSnxa2kjimG+gtzk7FUFiurz5LXg
         /7vQ==
X-Gm-Message-State: AOAM53358AwudjT7C/PCmz0fF4KYimRv2wGsX+0OlGnJHdHwHS/hXYGr
        QtctxaOIazuE/zYoFidly7u+5lvV+Io=
X-Google-Smtp-Source: ABdhPJw1QT6Dh2Fy4U+xoL6nuH+kzP+CzA+JWdXmqXlj3S5NHYicwmkhVpyivlcJIlmw3AhsXXFidw==
X-Received: by 2002:a17:90a:6649:: with SMTP id f9mr8798856pjm.15.1633038798483;
        Thu, 30 Sep 2021 14:53:18 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id p17sm5647535pjg.54.2021.09.30.14.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 14:53:17 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/5] mm: hwpoison: remove the unnecessary THP check
Date:   Thu, 30 Sep 2021 14:53:07 -0700
Message-Id: <20210930215311.240774-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210930215311.240774-1-shy828301@gmail.com>
References: <20210930215311.240774-1-shy828301@gmail.com>
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
Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 54879c339024..ed28eba50f98 100644
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

