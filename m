Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B9D4DD57F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 08:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiCRHtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 03:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiCRHtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:49:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E70A21B6
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 00:47:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d19so8798364pfv.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWUQux1KtYb2lW/SJw8SxLz0dcCTGFUlQsH2e++z+XY=;
        b=5bzBbr1D4egu3YxUjV6NU5rP+tmRTfoCbQCHzoz5dOiFVKlrS0cw7ippuefsHKLsCE
         fo2HvaJglETK9wm68r8dOlew9nAPqA9sQV27lJoQ/riPuNKVaTkiLydUSvyY34v/4Szx
         k2dwX1GB3beaot9LSmk0kJilr/Wox9GEY6UR+NAqpsr8eEAaPXoO62fSz6cfSarCvKXY
         9PsV2xjPoa0/pke7OOwVOG768pLYDkFnAjWM8MrCHQWxTr8R8BqWDVB6TXE2OxVtxxmv
         S2p74U/apcotkbr8QzaAIeNAWsiOhvvfleiiDpIjzQhmtA6v39V4Pp/Goz4/EHviNis0
         f85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWUQux1KtYb2lW/SJw8SxLz0dcCTGFUlQsH2e++z+XY=;
        b=w+Onv+45YLA+knw88Mizkx4RighAbm8CL0Hrlcv7qtLNBupUowUyKScSOGtBhy40o6
         aEdRKmYXtHDOclTxp4P2IbATD4th1f8CPdBUz5E0crRYO2EU/J27Ri3Occ7U5to9qxJj
         D5iLuyoFNmHF4ciHhRbuYgkc4qzWqPrpGt/8JVsTCSDkkBFd/MA9R+vXrikcLAKMu889
         U6BNrBY3AbtUf7X6Or7jXJvgFt160EWXbpfWqQ4+aitcRm6157+Dsbnja+0ClnBv6ctm
         m8Bjn3cA7N1JJX0AtS+h25Wj2qYWgZt5ZuHkj5sbkGoiS4p+sh1iamp/V8JsYFZICVOc
         LYJg==
X-Gm-Message-State: AOAM531swLwnxFqOZR964jdu9gWyJcwEQ0O+anA2uwUXhf2bymKjrEo5
        +C5A7Ma0eF1EP2ZUoGsTjqfp9g==
X-Google-Smtp-Source: ABdhPJxOutWrAfVqkjylZCN0QPCTtjilyzjelgGeLWhCr1Nvt3WOGLzbIbbupSf5LNvps9BtFMZI4A==
X-Received: by 2002:a63:1758:0:b0:381:effc:b48f with SMTP id 24-20020a631758000000b00381effcb48fmr6973156pgx.124.1647589673409;
        Fri, 18 Mar 2022 00:47:53 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm8770941pfx.81.2022.03.18.00.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 00:47:53 -0700 (PDT)
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
Subject: [PATCH v5 4/6] mm: pvmw: add support for walking devmap pages
Date:   Fri, 18 Mar 2022 15:45:27 +0800
Message-Id: <20220318074529.5261-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220318074529.5261-1-songmuchun@bytedance.com>
References: <20220318074529.5261-1-songmuchun@bytedance.com>
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

