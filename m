Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0534EAEC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbiC2Nve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiC2Nvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:51:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9658F98F69
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:49:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u22so15957044pfg.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCp2b48ULThIjDs7kZ69Cjh0BLYiJwB01qLpS62xP+w=;
        b=Jar+sTN8J6FAXOFb7BXYhLAXyRgigam+L7qPx28Z5edW3JyP3P6JHWeb2bLTRguazc
         SjpC/ypJCbFX/ajZVHDSDqni5U8ITqmnuOup25CPNWU54sPtLLF6LiZIWWYzvpzYHTgC
         k9wnNqKqGo/1GzqBqOc6VqRLxftOHupN+lmJwjQKTo0yrNNVI19TB+ENyA+aJNvEzEvC
         4kCQFtgdIRbEb7xMywi2TakGdJ5HnWvuECSJvLUuNL6T7xJIPM+veTI0gmlSGWT2iso8
         VdcBqyyuLihOgQjHs+9PwRAccmVb8/VV6SQGLGwzIL7cy5hpOdt9uiOByhluEpyB2CoO
         Catg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCp2b48ULThIjDs7kZ69Cjh0BLYiJwB01qLpS62xP+w=;
        b=GfP94IME9w0EqmDfxyq4bSpYqHC3KP5ingRCAqMmsMYaVJpoXV9T3rY4Nn1//4n6Yw
         M23gnKB4TR1CqH9Tp9v9pLtoeqfPg5tgiNY6vD8ncoFWZ/TrA8FT/gnFN7pIVy0eHwDg
         EN23AIkNUzKGFNpQG9A1JW5r2Uo/M6OI/dyZ7fgSnOGrLSC7KCSIfwcqZRB8aDBpxDgP
         2lF4J92ktswAz9dFXDz8R9eh40+H7w1GWv7FBkVySzzoWqYhix0k+lA9mjmFeebSY2Gv
         m32PETjKH9LLioY4vOEh/ske+mK1jRGq6Fx18T1Z6A6K7uQ7k8S5+jMLbDYbJVyJrfvB
         ivfQ==
X-Gm-Message-State: AOAM5337Xw2UP5lYln16xX7scQGad1VZB0NiOoBCpp9+nfnd7NbD6qLS
        LNaj7KAw0kwqeIFtNnfYEP9c2w==
X-Google-Smtp-Source: ABdhPJwIyVhxdz8+cNA2oBRKlLOaDoMyukZC+uWljQRRd5G8K+hiEQjPnAjv0Umpi70bDPH8wlP4Bw==
X-Received: by 2002:a63:5b48:0:b0:381:10:43e5 with SMTP id l8-20020a635b48000000b00381001043e5mr2093565pgm.544.1648561789075;
        Tue, 29 Mar 2022 06:49:49 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a0015ce00b004fab49cd65csm20911293pfu.205.2022.03.29.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:49:48 -0700 (PDT)
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
Subject: [PATCH v6 2/6] dax: fix cache flush on PMD-mapped pages
Date:   Tue, 29 Mar 2022 21:48:49 +0800
Message-Id: <20220329134853.68403-3-songmuchun@bytedance.com>
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
Replace it with flush_cache_range() to fix this issue.  This is just a
documentation issue with the respect to properly documenting the expected
usage of cache flushing before modifying the pmd.  However, in practice
this is not a problem due to the fact that DAX is not available on
architectures with virtually indexed caches per:

  commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")

Fixes: f729c8c9b24f ("dax: wrprotect pmd_t in dax_mapping_entry_mkclean")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

