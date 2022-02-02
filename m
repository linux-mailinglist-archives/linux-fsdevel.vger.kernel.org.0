Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4E4A7332
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 15:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbiBBOe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 09:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344840AbiBBOe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:34:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C572C061714
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Feb 2022 06:34:26 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b15so18461250plg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Feb 2022 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpzrZ3UL1NNnyKoM6H+wPQyBpC1NKCVMLCNYU70r2B0=;
        b=FP6uo0J+XGUKU/YjQtKSKRs4FCJsisKC/hx8Y5wk6tYiUm9x62TdWeN3eu9+XCbJ1T
         TbJ16jy2DDntW86mp/sgYUpOOoGM5nlDBwUdy22h9MAmHMjRI0elhETTyVqpGzEgkHLZ
         Amj6MaV9Qz8yIzmzZqDG+kqBaTuwIfrJgFh+n6YxIPB2UkmIVsx2Rh9lrv9c4GRca5au
         mia8XrC7PMNdb8X6VPlKHtUztzZlvGKzqqXwjAXp+wfogI4Bs/9xJRbFy6cgBidDMhNw
         SSMl2asEvsdP1oodO1jj7EY/xuSnAsGCMdXd7EfYxgPrjWGi6QUaCnO4/rnadNS6lvow
         LU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpzrZ3UL1NNnyKoM6H+wPQyBpC1NKCVMLCNYU70r2B0=;
        b=WJkk+SWGheNIjxqbxW0r+Y6V+hra+3Mk+5BJybXPvhLwxcNg7TLDlKEjVAgNVyt3sB
         /kg7UZC1OfmVI63P/TN7rGmPBllqHMiiK8jbGrRdfv3skVTjq3CmTFuYw7UGPdfZZchd
         neOOxqynDxC4GJypDC6oGr87XpEwSy6JkOQCda6Nw6DsGpTUpTW1MPsHhQNM+PqgJwY9
         wMX92CzEQX4tb4h3nV8FK1dpJcJOzgnxA5PNe/W67FPFCrvmpCgD/YRo4sjy1hePUvre
         65b+b99yv0tY2oogMrcB1IPJLm0ft88+QfdA6QfsujgNzqyaajjk1LLF3CqbkVDNak6j
         RN5w==
X-Gm-Message-State: AOAM533DwL6q20YlwURPqJT6k+Ol+LwLiYYGisJF+6W2QPOxADcNpTRi
        AlSzMr9pVI5kGekcfpO72pWDbQ==
X-Google-Smtp-Source: ABdhPJx1R74lXZlM/Cxg6cfKwxH1FD4NPDRYz154Mh+OGethIUvLeH+xKUNAPo6FkkGG3/cUrVF6pQ==
X-Received: by 2002:a17:902:c412:: with SMTP id k18mr30904459plk.142.1643812465457;
        Wed, 02 Feb 2022 06:34:25 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id s9sm29079268pgm.76.2022.02.02.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:34:25 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 1/6] mm: rmap: fix cache flush on THP pages
Date:   Wed,  2 Feb 2022 22:33:02 +0800
Message-Id: <20220202143307.96282-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220202143307.96282-1-songmuchun@bytedance.com>
References: <20220202143307.96282-1-songmuchun@bytedance.com>
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
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/rmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index b0fd9dc19eba..0ba12dc9fae3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -974,7 +974,8 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 			if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
 				continue;
 
-			flush_cache_page(vma, address, page_to_pfn(page));
+			flush_cache_range(vma, address,
+					  address + HPAGE_PMD_SIZE);
 			entry = pmdp_invalidate(vma, address, pmd);
 			entry = pmd_wrprotect(entry);
 			entry = pmd_mkclean(entry);
-- 
2.11.0

