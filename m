Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF634C631B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 07:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiB1GhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 01:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiB1GhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:37:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6666F89
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v4so10252247pjh.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6i31CSY3Duk9LeOLZiT7NizPvWf1K5PHZdMP52ume4=;
        b=2ZOfoGu1/MFgeEOp7l9nzx855BOTpf6KmEjvuBGsADCtnylUZoSMJkf7HBr0NUjbQ9
         FlhYhNEd4W5SrEIiQ7jg9pl2rVCIkXOJKHRwFeG3u/8LgbAMoYAh2GVHOzyKc/+4/1Pe
         AcKWPJSazVveDRPEU7EgvojmP1Zm0cKZ0d6u8ilffoSTMBoRW7RIPHu52Y/4AUNV8yYj
         hO2CjE3SbcHqQODlmF4mfEv3grvZmXIeChJBgAFFy8elF3DSzVmcs7AN2G3pduRvj9eR
         WS0/wAt6k2rcLiw6rPhq36STduyHRutBHeIuwRZDbZQbqtgw3ZqKOIiJEQmN5M7MF9JW
         aRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6i31CSY3Duk9LeOLZiT7NizPvWf1K5PHZdMP52ume4=;
        b=Rgqlj0y3pSzZvZVcgZYOyu21WSMJ8na4XCv2938Pssp1SZvLlckX61Ol77EuCjInyY
         kJa29hldHsnQK9+OX+TMX0TZvRsXHzmP/G1nhq0V3n1XWihsN0GcXJMEZbVasgatIIML
         j57xUWnJlbL22WUgMd9hlGNG+CbunYAAnQlOXM6JQaYbgnX4VCSP5XzZk9MWNA4ZCzTh
         5a8ERB/OnSH1wnd4Ils9K108B0prW9YseAJGY4l/EE+H9eT/wAEqgjkM/KBtQ1gI1rrp
         Id2fD0IVE+HO9oR51J6Y0TYgDI2lxg7XeAlDiTQCi8Xd7dM7DQ8DOYZHU9kLbI0sRQYO
         szyQ==
X-Gm-Message-State: AOAM532d/tbNlh4NmaEpIsRP1N2Z239zOhD0D9yxMC5TfSZeLVhMDnc7
        KyY/gZyfkuFXibj348CXc9LbZA==
X-Google-Smtp-Source: ABdhPJxsMZqyRAFflkcZZDVJv843JKnWfi3iHw1GFs0mIeO4WlE4MNK7MLekTr+M8I6YkaLXWVfsNA==
X-Received: by 2002:a17:902:c944:b0:151:3829:a917 with SMTP id i4-20020a170902c94400b001513829a917mr13578398pla.144.1646030183943;
        Sun, 27 Feb 2022 22:36:23 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm11126472pfg.165.2022.02.27.22.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:36:23 -0800 (PST)
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
Subject: [PATCH v3 4/6] mm: pvmw: add support for walking devmap pages
Date:   Mon, 28 Feb 2022 14:35:34 +0800
Message-Id: <20220228063536.24911-5-songmuchun@bytedance.com>
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

The devmap pages can not use page_vma_mapped_walk() to check if a huge
devmap page is mapped into a vma.  Add support for walking huge devmap
pages so that DAX can use it in the next patch.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/page_vma_mapped.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 1187f9c1ec5b..3f337e4e7f5f 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -210,10 +210,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = READ_ONCE(*pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+		if (pmd_leaf(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
-			if (likely(pmd_trans_huge(pmde))) {
+			if (likely(pmd_leaf(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
-- 
2.11.0

