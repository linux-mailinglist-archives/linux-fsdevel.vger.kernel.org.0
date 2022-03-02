Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9878E4C9F29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 09:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiCBIaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 03:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240128AbiCBIaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:30:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218F3B82ED
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 00:29:13 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso4172704pjk.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 00:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOhvmpBLieRVF+NKQPb4pdavGDEjnXCIzLlMLWWpOKA=;
        b=Eqy9IPjbLYYbIstc/J+JZ8WTf619n0h2r8uqKqJ+e6S9Uv+eWqpcul4UbryOb5p+/u
         MaSxXNwLLByowHTqGTJmAsxIcHxjSri8rtIKgWnK7dAxgThGETtK7a3vlVgTsAIso5ar
         jz6a8FaGafuyrVazLBfr548UwTAKf5gemmCc1q/mdgh/EBxhT2Wvwoij1uyTH3KARIXd
         jcdjAZ9+pZL04jxy94vLnK5/fYv2dad6VTjRS0mMTD7NNmpGZHjiGq1JUbhrnPSfBT1F
         4WAiWLScu72rwaHUnfiXZdJgAL3fWS9Qcg6grtWwG0Zxwea9ard9epbbCH3a5Is0pfue
         VlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOhvmpBLieRVF+NKQPb4pdavGDEjnXCIzLlMLWWpOKA=;
        b=m1ia9RjlvWhI17kpYxAV1NkO8nwHyHJGmufs/dmbbhuBj5zN4GQnEKoGVZT1CfcjR2
         11YADLWHSeFa18uk11JJEQWJiA1sGYKe18sRoxLaEQcm4Pf9fSOLCmu1HXJKH2oE3JB8
         7VZ6oOCJeWESU+OdgKr27gXiWHSkIO7ecmv7sVX+jAa3jnVJyO2AUnJ1mij14l4bK+Wt
         J+a2y8FX5fd7RjZZe7/bUn/eSnzdGJ7VkIrfSo6tA+27WueAN1zz12f2lj0GOBp1js1/
         C7SwKo+Qaw4ZnljkyOI7kRM+w2mQsHtmOO3aL1L47JtpAJqOzPmdRbm8JMCp6I1ZrIZE
         L/EQ==
X-Gm-Message-State: AOAM5300pFmfrbiFs5f0lxkg30EeqjYwzg8aaXGSznS6trBo/sV+Rui9
        XHIguQ21L/rJ5dE/mphm/KoVoA==
X-Google-Smtp-Source: ABdhPJy4/KlcXCarIW7Ivk1JNvCCmPY83Lz2efEDwfG2djMlcALEZNHFvUurWjFDAawaZRfirDGOSw==
X-Received: by 2002:a17:90a:ec09:b0:1bc:d7c2:b2d5 with SMTP id l9-20020a17090aec0900b001bcd7c2b2d5mr25500689pjy.22.1646209752693;
        Wed, 02 Mar 2022 00:29:12 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm20922228pfv.49.2022.03.02.00.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:29:12 -0800 (PST)
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
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 1/6] mm: rmap: fix cache flush on THP pages
Date:   Wed,  2 Mar 2022 16:27:13 +0800
Message-Id: <20220302082718.32268-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220302082718.32268-1-songmuchun@bytedance.com>
References: <20220302082718.32268-1-songmuchun@bytedance.com>
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

