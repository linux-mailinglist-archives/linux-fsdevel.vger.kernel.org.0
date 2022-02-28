Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099EC4C630B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 07:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiB1Ggm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 01:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiB1Ggm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:36:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667A566CA0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so10516660pjb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOhvmpBLieRVF+NKQPb4pdavGDEjnXCIzLlMLWWpOKA=;
        b=GLedueKeHKRO2HkdYcdfxC2EEpOAVOh+ibI1MzEf9M9KEnYukSMBeJqZ6sb5fecmh9
         R8NyktTgdG0x5Z8DW9eNTXhARk8wE61mQcydrkh0HLuj7P7SeO0WwM/sBC8K98q6OP8p
         IERc1o2vniYjYyIE4NkC+baW8ic1VU7rpHUmGU5X0QD3luAibl2XNs9c4D80ydzqjHWn
         CNW9quMGgyhAf8u7OKUuHd1KuzjLgHeLvTZVSUX8Gy0+kfVcWJG0BWoIhvOQtOdv6srh
         0mxLOeOYimflwRkRO1fDCadVjMJE3S4xQwk2h0AlhCmAyM7v6XyS7tsYSsMRtXgj2QsO
         WnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOhvmpBLieRVF+NKQPb4pdavGDEjnXCIzLlMLWWpOKA=;
        b=EVq0gTMumGnrEuJPlUpoxchkpkTXvPL5FoWxI8xTtjUX5tGOryxZPD28FOhLzY2+3F
         o80N7OTgCGqmw6Yrw4RTnK6h7hLPFQEuCyt4A0UIqADgD/7E4sKoZzNNnpN9MHrvs5Qk
         EkkhzvMfCzBCm19XlV1NMk9/JjxkFPStZGAxLy9UGqouvCEEphwrf8ZlRQhruASAmE5Y
         6J0tuK9rYogrPcy4DztuoAKcsJWP7mj0St5tTKdGZpzQllqI5TiU2CbNZS2xQjtN1RNb
         wuDuu70kiT26S+RviJDyrk/kXeud8bbOyxOPjcURlhSRGnPSlR+8BhOCm7InYJ5I+FyT
         Fjeg==
X-Gm-Message-State: AOAM531f3JVYgK/ImcQPbTWIL/7V27k73rVHFozozMk9LiClVJ/x/ytU
        lopwKcbtj8Q8gm301FE8QLpAyQ==
X-Google-Smtp-Source: ABdhPJwToVZOj3y/qJS6gPvMQ/JUzaojXn+cxmZ3XptNaVSIvdrv3PQbOne/2kTWhsRv6czal7dTHw==
X-Received: by 2002:a17:902:d882:b0:14f:efee:6de0 with SMTP id b2-20020a170902d88200b0014fefee6de0mr19598400plz.116.1646030163867;
        Sun, 27 Feb 2022 22:36:03 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm11126472pfg.165.2022.02.27.22.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:36:03 -0800 (PST)
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
Subject: [PATCH v3 1/6] mm: rmap: fix cache flush on THP pages
Date:   Mon, 28 Feb 2022 14:35:31 +0800
Message-Id: <20220228063536.24911-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228063536.24911-1-songmuchun@bytedance.com>
References: <20220228063536.24911-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

