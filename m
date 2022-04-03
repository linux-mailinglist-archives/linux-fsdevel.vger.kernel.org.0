Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411984F07D3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Apr 2022 07:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiDCFnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Apr 2022 01:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbiDCFnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:43:11 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2249733E9E
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Apr 2022 22:41:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y10so6115173pfa.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Apr 2022 22:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xp6qCxwTnE0C1FxChih956SdBv3W6L+dQXT7C0J3Dts=;
        b=2ABETFqdsMhesFHDHhEUmJyVsW7RZ5Js5waMUtu7AgAnw7NQJE9KF6VPHqmSdvMej+
         2OJl2yUuMkKlsJntBOzaVw6h3FbkNTEtAUb7NgwTf/4KS8Unjkp0AkIDihqOM4AQy0E9
         b0D1cmPFHN/ZT3IC0qJD0E+WI024G3g/JHnvtyGmSNaBRaaNOf62Cjctp4an9NRZ9b6z
         vPzjHQqLtX8FSAzX5BdZbUx0QSmSsl5esFSgUJJfPkwZ9OBGd+Ki5S02q7b/3idXLY9Q
         v3WBGcPbhY5PtafSU0qiWng1lLj8uoWDT3H3wd0bwa2IQYzXzlExfT+r6ROb2/HljUOo
         gBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xp6qCxwTnE0C1FxChih956SdBv3W6L+dQXT7C0J3Dts=;
        b=dPypXq3AsgG/USZOrTc3JV/uXUYZu2AI/PvT0zZqRZuVEvdmPhUS/BrTWe/DTZI2Hp
         PZx4YXHuAbtakc1mJPsFVwy09OxuxPvmXcGbbYqFrZLGLXB5z0PZ5PnkC0KiG+vFKR37
         xRFU/enzZ2Dx1SRcWRmCqbo9FjGQvD51aGC6OyUt8EnUHIdQ82prDdY2ZHr29ppCRuZy
         5fBbjJOTEMk5ziFjIki4OlT+Oq1iyyZYrGdYnvRbJXt0+obpdyrlAEuqPAatLI579uMJ
         jp7D5RqD7Jb3DovVXT7NerMq2Wa3oJrLtqqENr9W9+d94JMcpqLtX7akAzpkEGs3F3Le
         JspQ==
X-Gm-Message-State: AOAM533ilwcBD+Az9BHFrRh7DCSgOPKmTWp26Y6819biVlCsWXsOKjZ9
        Lj/0fcAaRppx5qdEzhlvCRSiBQ==
X-Google-Smtp-Source: ABdhPJyZBSv2yEKXE7ELYRPowq8GlcSVl+mBvyh+Dr/+2j3dfmhbMmgifEOf+lzxBO7utJytI2ZQWA==
X-Received: by 2002:a05:6a00:b95:b0:4fa:ec15:7eb7 with SMTP id g21-20020a056a000b9500b004faec157eb7mr18416062pfj.74.1648964477478;
        Sat, 02 Apr 2022 22:41:17 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm8262479pfx.34.2022.04.02.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 22:41:17 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 1/6] mm: rmap: fix cache flush on THP pages
Date:   Sun,  3 Apr 2022 13:39:52 +0800
Message-Id: <20220403053957.10770-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220403053957.10770-1-songmuchun@bytedance.com>
References: <20220403053957.10770-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/rmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index fc46a3d7b704..723682ddb9e8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -970,7 +970,8 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 			if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
 				continue;
 
-			flush_cache_page(vma, address, folio_pfn(folio));
+			flush_cache_range(vma, address,
+					  address + HPAGE_PMD_SIZE);
 			entry = pmdp_invalidate(vma, address, pmd);
 			entry = pmd_wrprotect(entry);
 			entry = pmd_mkclean(entry);
-- 
2.11.0

