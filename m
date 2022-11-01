Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3D615118
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiKARyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 13:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKARx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:53:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769591CB05;
        Tue,  1 Nov 2022 10:53:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so1679826pjh.1;
        Tue, 01 Nov 2022 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mi0cqN3i/1HTIqi69x1uNrDe0uDt2K2zNDb9Z1HfPw=;
        b=RBxiYbfjpDwRWt/D6+w2v3Jo18Lh+RXCLXAOGnov4hDYGZVFU+xSvqhrVh7fhuJeq2
         kN7vs3xuzmdU41BaE57uYw1KeMK7Brdl1q/LIisxF2YTer9d9gb01l5P9mg6ztt8ZlHJ
         FxT8H+EhTW+FcC62q64HDNZDSjsy0hsnR6EfWlTMhFK9ol8LYlk6AkNUJ1EQyw/O1AQy
         6AGz2HBSGHbYmqEIG++A+uA2wSymWLBgrnpHUEAdMXxAzxaGTCmGSiKk49vZ+JGWUytd
         J6Qnxgq7ulgG+7lrvlSLx+XWUFiLqkZm41cvpDeTzB+Bm139Arc1de4J38auPaIICKEy
         Gujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mi0cqN3i/1HTIqi69x1uNrDe0uDt2K2zNDb9Z1HfPw=;
        b=NySVJuze/bXrdkE6ZQXZeyL6aUn3qfGpOHRkAPmKs2cB6pfu3I+nSY4EZ51DkozgW2
         ir1kkq7qs1WwaMi6bENo72mkeU1Y2zyDqmsSjAPl0cepRHV+351Nxrqk8KiLdMzaI7kx
         vIL+wNyJ97e3IxdaOHcteqvCi94kxxat790wd8KLfO+TwqayL1HiL+hvx/HEpwN2oHc6
         Y9FNq0E27FtuZTTD3oQAnjVJAdfXaLYtXfdDk1GZyMNw57XlJvAQ40wgXKQOFsMIFQct
         x3rc//yta6JskRgUr3UYvyz2Bm3lVE0DULwchbKBsxf4VwOGh77V+wMGI5+uh9sHRhBX
         PMGw==
X-Gm-Message-State: ACrzQf2mHlZpeL9ILZwFCoBT45lthadHK5klI+Tw1/0MNI6bUxtTXjs+
        D/aB4LO5m6huDffIGkRLMWc=
X-Google-Smtp-Source: AMsMyM7/EQi6vdSoH4+shOGY8XE1Z+NZy/JCQ0R8kX0/zqHOOQtYC7myzSBOz691gq6Q7sVSEU8Gxg==
X-Received: by 2002:a17:902:ed53:b0:186:6ad3:c155 with SMTP id y19-20020a170902ed5300b001866ad3c155mr20007129plb.43.1667325235913;
        Tue, 01 Nov 2022 10:53:55 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id e26-20020a056a0000da00b0056b9124d441sm6797987pfj.218.2022.11.01.10.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:53:55 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, miklos@szeredi.hu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/5] userfualtfd: Replace lru_cache functions with folio_add functions
Date:   Tue,  1 Nov 2022 10:53:24 -0700
Message-Id: <20221101175326.13265-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101175326.13265-1-vishal.moola@gmail.com>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replaces lru_cache_add() and lru_cache_add_inactive_or_unevictable()
with folio_add_lru() and folio_add_lru_vma(). This is in preparation for
the removal of lru_cache_add().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/userfaultfd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e24e8a47ce8a..2560973b00d8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -66,6 +66,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
 	bool page_in_cache = page->mapping;
 	spinlock_t *ptl;
+	struct folio *folio;
 	struct inode *inode;
 	pgoff_t offset, max_off;
 
@@ -113,14 +114,15 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	if (!pte_none_mostly(*dst_pte))
 		goto out_unlock;
 
+	folio = page_folio(page);
 	if (page_in_cache) {
 		/* Usually, cache pages are already added to LRU */
 		if (newly_allocated)
-			lru_cache_add(page);
+			folio_add_lru(folio);
 		page_add_file_rmap(page, dst_vma, false);
 	} else {
 		page_add_new_anon_rmap(page, dst_vma, dst_addr);
-		lru_cache_add_inactive_or_unevictable(page, dst_vma);
+		folio_add_lru_vma(folio, dst_vma);
 	}
 
 	/*
-- 
2.38.1

