Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE44EAECC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiC2Nv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbiC2Nvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:51:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EBC17ECC9
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:50:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w8so17680941pll.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWUQux1KtYb2lW/SJw8SxLz0dcCTGFUlQsH2e++z+XY=;
        b=G+yhSk66jiVLFXbnCli3qF1UuypYzD4UqkQIn1/aZOoVNQLq390i4W2QbZAC1uDbTv
         rZHDyKdUZch1cCyQwiItvCeWoFUVMPhHHNpNl1SsUHEKpGxXNeS2lnMlGl2mQyg9e6Td
         20C+VHU3kXJ7MkQD50IREG/ueYGfVheuUaQE2rss4yrmVFYh0hD6tO+E5CAfYUbjzLen
         91ZIRCLWjLARmAsFuj6larvZQL+0dmu5fCHPE+h/nGNEq6n4pFDmjJdWxd3UgmzovtfT
         KKja+3nR5tlwpLaEOr/W6RFWXi69I8Uy3nflR3wKh75PEib2MYmy8YG0yDgvkjLKI9Cm
         E7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWUQux1KtYb2lW/SJw8SxLz0dcCTGFUlQsH2e++z+XY=;
        b=OY1C4ZLiBU3hgr+mG4BjgZivjK1LxyR3ux7ZqB6Y4L0TXLenyQrJKkFHKIyC3y1MfK
         AhFWI8kY+EarWw9Vc5Lf/NSXEN9ofRc7vq4jpXZjMk0KELIjifbM2ziTNlmJYToOdraT
         wxcEWYd0DiMkIrcM/VJt/UkbIouAT4QV4hjf5ngbGQi/lLnvHLAufwFfA9d03u9MKVjY
         kZDQ2g/5hyAzNfi9/Nx9wyiIn0+Dc1zShRhFVmckK9C9z+QvkCjiv1TTkDrjRBKe+Fep
         8QqOHmR+EbOoPXQMbEdC/y4j8WV84Vgma/E0KVaBpBuTt45MulMPrtNP1ZbqRNHA1e1D
         BPdw==
X-Gm-Message-State: AOAM5316ytGkI6YqrmTw5uHqETM5vyyRzjzjYXFcowEM2yuwZipQzCjz
        tvJuLX0OB1eP4Djjfg6VH6pXzg==
X-Google-Smtp-Source: ABdhPJxdiH3g9l4QwZUkPToArdeUP0GSfrH58csPQ0KFDVI06KXDGgJnArklayTM7bVUr37Iyzttug==
X-Received: by 2002:a17:90b:3851:b0:1c7:d26:2294 with SMTP id nl17-20020a17090b385100b001c70d262294mr4598517pjb.97.1648561802997;
        Tue, 29 Mar 2022 06:50:02 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a0015ce00b004fab49cd65csm20911293pfu.205.2022.03.29.06.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:50:02 -0700 (PDT)
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
Subject: [PATCH v6 4/6] mm: pvmw: add support for walking devmap pages
Date:   Tue, 29 Mar 2022 21:48:51 +0800
Message-Id: <20220329134853.68403-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220329134853.68403-1-songmuchun@bytedance.com>
References: <20220329134853.68403-1-songmuchun@bytedance.com>
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

The devmap pages can not use page_vma_mapped_walk() to check if a huge
devmap page is mapped into a vma.  Add support for walking huge devmap
pages so that DAX can use it in the next patch.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/page_vma_mapped.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 1187f9c1ec5b..b3bf802a6435 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -210,16 +210,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = READ_ONCE(*pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+		if (pmd_leaf(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
-			if (likely(pmd_trans_huge(pmde))) {
-				if (pvmw->flags & PVMW_MIGRATION)
-					return not_found(pvmw);
-				if (!check_pmd(pmd_pfn(pmde), pvmw))
-					return not_found(pvmw);
-				return true;
-			}
 			if (!pmd_present(pmde)) {
 				swp_entry_t entry;
 
@@ -232,6 +225,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
+			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
+				if (pvmw->flags & PVMW_MIGRATION)
+					return not_found(pvmw);
+				if (!check_pmd(pmd_pfn(pmde), pvmw))
+					return not_found(pvmw);
+				return true;
+			}
 			/* THP pmd was split under us: handle on pte level */
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
-- 
2.11.0

