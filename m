Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1897E4EAEC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 15:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiC2Nv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 09:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiC2NvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:51:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D68898F69
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:49:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so2958873pjm.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xp6qCxwTnE0C1FxChih956SdBv3W6L+dQXT7C0J3Dts=;
        b=7dvqFGIZamDh6z2A7HqI+S0QNO4F3ZMglCOrx6y5hhx5QhuJeI8ofBVTiND7e6IZ2V
         m3lUYzObTIB/gdTZFA4KQD4DVsVBtwZ8tSMWVw+36xNQvtuPiVUrYb0u+Y3+2lro1C/F
         zPYEz7Vt8YKGhinn+4PXZ3dukjN0B1MbiKgtAlv1rGMO4ZQpvr71RTKO76fB44QtchOm
         abY0vvsDPKb/HSm86BzJ17VHR5e2mrLwsVZuC/1Ttk6sY1o74EUfeVjNCyd0bQ7PiVCl
         3BXyud3hnwNvDSI2kGuWLZy+j235vtliI5g0/WHD/uaa16qqBriGcKHkz9VNYKXowtrs
         NR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xp6qCxwTnE0C1FxChih956SdBv3W6L+dQXT7C0J3Dts=;
        b=2l3OSFZanVqm8lc5jPYTl1ktTLdHnd1PsuWnyHb7qRpzQXxpd+zy5B1olyfEf0Rsdn
         N+hPlHVxrS2q3F+7NTzWl3VFcBVnm7XzOR4qqVpWYimwSoNTqwG/qDFYGBRWMKYZrYDr
         65kvZvwgW4qkCVZ9rFdrwDLihk0JDx98Knj7XfGWNdLThujqsRy+W9VpHNgHvCbc3HlD
         OcpChJnhyT29zxlb7bkOkMlQcE+tlVEBdwz9iZhUnZWMqYTTqaVvfZjthBsDnyjzlB7Z
         6t4h5gQHnUF5mrE9xE4x3vqzJT1L2PDZoBaJlWwZSNpF1w0wBxqDeZpoOnH5fqOcOdHy
         Th+g==
X-Gm-Message-State: AOAM532CrEGjwOljvb7pWwqT3jlQt6C2o1C6GL+uVs+p/SOKviqS5pRH
        yO0zpYxkI0ihCv74c9YRZkZFWA==
X-Google-Smtp-Source: ABdhPJzL1DT1WGANxca1cudkBoNvw0RQh0wE19/V2uhTvOrIsqwOC1l/X6irJPErT8PhUYtRlg0EqQ==
X-Received: by 2002:a17:903:32c7:b0:154:19dd:fd43 with SMTP id i7-20020a17090332c700b0015419ddfd43mr31879012plr.150.1648561782107;
        Tue, 29 Mar 2022 06:49:42 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a0015ce00b004fab49cd65csm20911293pfu.205.2022.03.29.06.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:49:41 -0700 (PDT)
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
Subject: [PATCH v6 1/6] mm: rmap: fix cache flush on THP pages
Date:   Tue, 29 Mar 2022 21:48:48 +0800
Message-Id: <20220329134853.68403-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220329134853.68403-1-songmuchun@bytedance.com>
References: <20220329134853.68403-1-songmuchun@bytedance.com>
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

