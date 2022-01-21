Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA5E495B54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 08:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379269AbiAUH5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 02:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbiAUH4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:56:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155EDC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:56:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id pf13so8700954pjb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yazOhP0ZHzlY8srvqZA4aBLnRzwBUTc6naQJNmJIPto=;
        b=l4crWR5N15uNGOzFWkRqNP1rs6DtIDG8844ZqupvfUpmQECG23k+vyhFEhXsny/5xw
         fa/xQBPl/XEZfrXn6weA7s/O4oobHkUuX/789CQQV8R8YA0k+NweSnP67sj1F9yGUtnq
         lhTZBXn2zqx4wYNwYucAP7uQmKbAazKl5IbHqaYlIlDJuuHZ1SwITsVBpqVrwUwmA0MU
         buOQRB0QdA1vPqCn1sNGqJejfqaJrk98h8PnV9IioeIRqu/aPh33qRLDCuSi002egg/N
         QHkUeqChy7k5tfTqYGUL7a94JmyPPvubU4Xil9E+orA/juejflD69PJiRlrnguXM1pot
         VnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yazOhP0ZHzlY8srvqZA4aBLnRzwBUTc6naQJNmJIPto=;
        b=1jXhDIOA4KHCAVuJpkxQFPuGXLC+VvUFizCDT6N8hZHp2R3lLKS25M4uF0JTVbeQL5
         GpMtKN/gZAyDuUzc2qbblW5SrzFBe62XYZyfyYgxod3taBe+dpIw0RSFupKeqf4UCm4h
         nAFRxdUdKHOayiDdMUA0ym927lEfDBHvHUltsvUaLvSwaEWx0Z94u/MFH+ixpMTbaB0R
         UMWxHMXtxgEXEv20ZV0jaw69aH8PbPYP2OCKU9vGvgAUMIO1urv6zsgPjnFVZRhsR8hi
         rBD8F4CbeU8HdPUaDEtJL/2QeVLeJhE8YAEW9D55oPYmRXSxe4oYYcx5lHFdr4UP/lMT
         dU7A==
X-Gm-Message-State: AOAM533fwy92Wb5fFTAXo27BVQIdtFHT6yDPyoOytNqSPhuUEHjcHfoY
        mlMvNE9hbcLu+KTrC8IFSL8ZUw==
X-Google-Smtp-Source: ABdhPJzsnK6W/iuE/aijaL5gz1UJdJ5Uk7MIPGSQiG/0M5loABE5QAM8YgMpA18TTWDghqAi5SCyAA==
X-Received: by 2002:a17:902:e54d:b0:14b:1a2b:e842 with SMTP id n13-20020a170902e54d00b0014b1a2be842mr2707933plf.102.1642751789637;
        Thu, 20 Jan 2022 23:56:29 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id t15sm10778178pjy.17.2022.01.20.23.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 23:56:29 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/5] mm: rmap: fix cache flush on THP pages
Date:   Fri, 21 Jan 2022 15:55:11 +0800
Message-Id: <20220121075515.79311-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
However, it does not cover the full pages in a THP except a head page.
Replace it with flush_cache_range() to fix this issue. At least, no
problems were found due to this. Maybe because the architectures that
have virtual indexed caches is less.

Fixes: f27176cfc363 ("mm: convert page_mkclean_one() to use page_vma_mapped_walk()")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index b0fd9dc19eba..65670cb805d6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -974,7 +974,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 			if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
 				continue;
 
-			flush_cache_page(vma, address, page_to_pfn(page));
+			flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
 			entry = pmdp_invalidate(vma, address, pmd);
 			entry = pmd_wrprotect(entry);
 			entry = pmd_mkclean(entry);
-- 
2.11.0

