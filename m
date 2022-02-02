Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA084A7335
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 15:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbiBBOee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 09:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiBBOed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:34:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036DEC061714
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Feb 2022 06:34:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso6187156pjt.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Feb 2022 06:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqTwEL7kOTcKChIBcjkLKs2qIde8K14LqGVT2DBRTU0=;
        b=QfoqDLtleFoLTKKXN2gEfiVcozG97ChIFEO+Dxb9kfB8mws46ckDiFZ0spHu+3Ckwi
         KQZam58ZAHqgcYKidzpFN3iPnYbSqMyyJG9+H9OJMKcVySUshYFShTfVPilrnyzKLSYH
         /hwxBMauDgvjBwXaDv+t8Aigdr4S4kh8m6NusA04i61YrBQTjYU+aXUCrcvJKRfVAtto
         sw938xa5LtXWuBW9vMuJyLDJ7JhQtLB6VO31Lkk4zgYI1K22xsLAs86nIFN1bdsqem9D
         b9A0oRcRgZgOiBmtV/hB8lrUnmP7ugc5phBXv7BZKIExxz7n+Io5ja4QbCqxemwNNnNZ
         LTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqTwEL7kOTcKChIBcjkLKs2qIde8K14LqGVT2DBRTU0=;
        b=LVhav4GDks5g7vPXGkmPNaiMe5DK+uc47WCo41u8D+nEv+r78qYPayAqWkSYuuBWQI
         QXlILDOXaLBIFPl9eiSEUOsUyfbjv37PP4mY0haCs59saQVlYoKj8xFYfvg1q6TiZKw8
         CIriOyxKxub46SQSdxwxeyMw9ReBUYDTUHot4gRdiuVlCIb3yNdoGfRvO2h3Vlc3VO68
         LlWSg96xXL9P5XzndgC/tg92dfXwPz4bjRebbPKJ47ftmR3IQSCkHTxvfqugR4tfE9EH
         AGnOxgBLhagQLYQAPDkuruHzbJmZi7jbhNpbl0hw9MF/nGWYMs5NleNFFomHE8X+CdTI
         g2MA==
X-Gm-Message-State: AOAM533INGjV59v2NaWcolcdbBR7/X8bTYI6cZPkeR6qo3yVJ3cBXujL
        OOX0xc3pw+PdybcCBVlYXJHNJQ==
X-Google-Smtp-Source: ABdhPJzSJUsu2k5lK4qLz9mFNP97HsqVWca02fgKwu6JP8Fe8B9Slwu6HkVpi8yiT/kqkiwV52Yk5Q==
X-Received: by 2002:a17:90a:cc07:: with SMTP id b7mr8389698pju.43.1643812472560;
        Wed, 02 Feb 2022 06:34:32 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id s9sm29079268pgm.76.2022.02.02.06.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:34:32 -0800 (PST)
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
Subject: [PATCH v2 2/6] dax: fix cache flush on PMD-mapped pages
Date:   Wed,  2 Feb 2022 22:33:03 +0800
Message-Id: <20220202143307.96282-3-songmuchun@bytedance.com>
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
Replace it with flush_cache_range() to fix this issue.

Fixes: f729c8c9b24f ("dax: wrprotect pmd_t in dax_mapping_entry_mkclean")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dax.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 88be1c02a151..e031e4b6c13c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -857,7 +857,8 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
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

