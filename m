Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D744C6310
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 07:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiB1Ggx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 01:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiB1Ggv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:36:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443AF66CBE
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so13892844pjb.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiCDiO7SeVqlcAe7b/JTkNhJRMnMslj9oR2/HG6e9n8=;
        b=hNvJJ0ezpU6tq5crtKQjZkvHgC7+HknHsNaTEEdgZR8JxxtwLFGoDAyD7x5IwET35y
         ZPRng5dZP2a5eK9ia13pSI2xguMnF9Za8S99u0xgEEo87HHYB2P4Xej2LVHL7eH+AKct
         xrxdslSfTa0qiPzYYh9Uj7RiCdwmZhmN4QcvdcS4l0U5en87upCMi2dRj4MX+zYpyYdE
         9bx2sftxHiohg9+NFs058WNmeoDpjma0q+zV41eABj5OLtmklp0RsU+byN9O8I5+y/Bh
         tS+HxIBYiIWT8UFKIb4XxBS4fOT1yRMgLmmi9yUSb3Xpk4yxR/XN6G6R+JLCWfBCibNi
         H5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiCDiO7SeVqlcAe7b/JTkNhJRMnMslj9oR2/HG6e9n8=;
        b=e3f+LbkNFdfULGbxokPQwv165PcAZDuThLMil8jSgZAnqY9ppET6voi5+GTTGo+d01
         /ouMCTxOWY9uY36Ux5dT46bK2IqiHMHlGnNOxAiQN+HINo+cyA6WDaEyZXWyx87Et/Vr
         5G4otJ3/6UVGwTHmNpnqmbDh6C9zrjUygRb4xzga9GTgl7pOHRS8HH42jpE5U+CMI4rv
         WRGrI1IQpFFb6sIkCfOsQk9wWlc77Wp5wF4elfsiH//S4Q3tUKMNhBeLtSPCzrC6J3CU
         eO+pIseaQqdtCsWJDnNSZlfZwwY+dJKgsMd+2FExsCC9J3u3lOQSjrsOyZcMRpR4jmHE
         4ggA==
X-Gm-Message-State: AOAM530SrrTcOIHm+EA9H6n1Sm59oioM0tBtN2MQoPcidfgwjdG6oS6/
        AI0TVxO5uALkDbmySHQRA+BSwA==
X-Google-Smtp-Source: ABdhPJzWNg+jqXhXX9lmsTizHuYtvGyPT0fg3+W582PsfWEVtMonxYeOPpLeTi3y6GAcOQpWl4KCZw==
X-Received: by 2002:a17:902:ce8d:b0:150:1d25:694 with SMTP id f13-20020a170902ce8d00b001501d250694mr17105506plg.36.1646030170821;
        Sun, 27 Feb 2022 22:36:10 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm11126472pfg.165.2022.02.27.22.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:36:10 -0800 (PST)
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
Subject: [PATCH v3 2/6] dax: fix cache flush on PMD-mapped pages
Date:   Mon, 28 Feb 2022 14:35:32 +0800
Message-Id: <20220228063536.24911-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228063536.24911-1-songmuchun@bytedance.com>
References: <20220228063536.24911-1-songmuchun@bytedance.com>
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

