Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F64C9F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 09:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiCBIaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 03:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiCBIaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:30:04 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D527DAA2
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 00:29:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z11so948454pla.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 00:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiCDiO7SeVqlcAe7b/JTkNhJRMnMslj9oR2/HG6e9n8=;
        b=cYJLK58sIMtE77DATtQlxH9dtPyPDOawr2Hs9P06tVu2j6KUemAg7S9UEgucud0DdX
         4h/Uh/mP0MROdl00Wa/vvnYHaH6Ya6dm/OxjneqryKBM8Gp6v7zc8BhA27iNEPG1yHH2
         Eojft7GBt8tz5GmBW/hk0eB/lgf+Hbk5vSPzs7SU8EZS8jxOTz8PGvLJ6crgihfH37PS
         nXcScKKh2ZkdzeEMqPdHtVBCvj2or8wIA4avGEhSTLrskKUn6QAREUoUwwRZk01wFFti
         xXOkL2PqQ9YVw97HrnKwed0fGb91eHchAYlq83PZW206GlgUEgKY4mhHqxy1QcA26b4q
         Powg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiCDiO7SeVqlcAe7b/JTkNhJRMnMslj9oR2/HG6e9n8=;
        b=kmncLRt4qwjfv7KkKUk86ha6moQHv1s2WJ7aPOiS4/qJ2uXsQvCDPUht8FiQOcAQJV
         heFuKS6k8rp1x2Bi2axFdD/JO5RPTmnNfA3pfJ7XiFvNT0wPvU+HYwCEcgDicyLXgmxt
         r7yA3RyuX57g5MDmFea6g/6vQipMmgJ55kEKdmW3saHxo9hOAcvjVOioeoinV9CTPcYG
         LZp6RNTR/INTA+w7MlHpkXyjspvP+rLsNO8/cwPebBnKQlIyJF4jIBDETHB5OuKO4khl
         f0fDKeJgqUgw0Uce3YseXq4xzOMykFe7T37CYSLCtuz7Rr4W9Gt4WlBaDz2mtJXZPN5a
         A8/w==
X-Gm-Message-State: AOAM532gvFRi4SLPaH1MxVcDvtKQZnTEZqNQCJtogec72+5hngXB3SOx
        zxDYp7EufhZ1VGybV00YYypaQg==
X-Google-Smtp-Source: ABdhPJzHW21CrBKiP5Br3BMc/q1Bt4vTHDEYHfTZ2tmAwLrCBHaS+KABg8tBrpmlUqjiIhOiEwMJWw==
X-Received: by 2002:a17:90a:550b:b0:1bd:1e3a:a407 with SMTP id b11-20020a17090a550b00b001bd1e3aa407mr19607925pji.112.1646209760828;
        Wed, 02 Mar 2022 00:29:20 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm20922228pfv.49.2022.03.02.00.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:29:20 -0800 (PST)
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
Subject: [PATCH v4 2/6] dax: fix cache flush on PMD-mapped pages
Date:   Wed,  2 Mar 2022 16:27:14 +0800
Message-Id: <20220302082718.32268-3-songmuchun@bytedance.com>
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
Replace it with flush_cache_range() to fix this issue.

Fixes: f729c8c9b24f ("dax: wrprotect pmd_t in dax_mapping_entry_mkclean")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dax.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 67a08a32fccb..a372304c9695 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,7 +845,8 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 			if (!pmd_dirty(*pmdp) && !pmd_write(*pmdp))
 				goto unlock_pmd;
 
-			flush_cache_page(vma, address, pfn);
+			flush_cache_range(vma, address,
+					  address + HPAGE_PMD_SIZE);
 			pmd = pmdp_invalidate(vma, address, pmdp);
 			pmd = pmd_wrprotect(pmd);
 			pmd = pmd_mkclean(pmd);
-- 
2.11.0

