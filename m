Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A963862EBC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 03:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbiKRCOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 21:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiKRCOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:14:22 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20516716F6;
        Thu, 17 Nov 2022 18:14:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y203so3564590pfb.4;
        Thu, 17 Nov 2022 18:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CejbmJMt8knLZkp2jnt3nSDaW2/iqvwuj8SHKIZ6DVU=;
        b=b82Ya60EgEzBmglfPyBteCPU9obmCFXipeevVnQGfYhF7131nPzLpFPp43Ttx1rvn2
         aK+X7i1nofdutJEjCXfng2R3bMAfiY8qfs7ydF8u46qloqksHIzzoixx409rSQ45wRef
         UDiKfwPyx0xH1yEaX3rdOhR/9wlEjtKQAlEI+0dEwWXnjA3UuV60+YQD+MbBUTZk70p8
         NJgnsSHd7EoDzmnJH74gRQmfqrFDd0q9Lq0Pn82ss0Y3nD2dH4kG97VKWRdmHzft0eDc
         3oapbuXhA7sOvAUDp7vWMjpLtAN5ZvHjjq20fwg/DQ8LUe1NzbQuiv448aHx0g7t5Exo
         F+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CejbmJMt8knLZkp2jnt3nSDaW2/iqvwuj8SHKIZ6DVU=;
        b=R2Hqlml+ah6gzp/3q9mZDb5qJnu8grWOuhPc6jvIgoFJOYD4qgqTxTTUVgBqbNErJh
         KAvw3Szl/KMlUGQ/Qm1CQz7rLF8DPTge7cImG8easvCc24LZUS3Js/lAiidZ5+WxsFOS
         xCOEHlFCKnVGIsLEExQsBmECkkSfRvqmgh4AEQoMkkfMCrcmR+EcUNLOQcgJPvrZMn9a
         W4CbfsgKVg70d/H3cnPk1rLWFkoCkQGPkjfKfomJTccFwPGlf7JJsyUJ40ibdnURk2UB
         H4icVP8yeVBKWjPBT5c+6uk0iixmXveD2WcHKuHr8VdP8Ag6AMcLuOC2lmfUDpjV6GQb
         JsCg==
X-Gm-Message-State: ANoB5pkdPjkf1qNS2tM0J6Wd7GSIxwbOb2TB9eOLPecsNyIx25i/zjKU
        xfF3EOcYc+2hfKchkzU5XsU=
X-Google-Smtp-Source: AA0mqf7S9erhu0bgdFYN18UsmwY31ELzskD/pg44k2C37qZCuH5QiKU6nJz4HrcQB7qDLTx4MBSezw==
X-Received: by 2002:a05:6a00:21c2:b0:56b:bba4:650a with SMTP id t2-20020a056a0021c200b0056bbba4650amr5861219pfj.4.1668737661580;
        Thu, 17 Nov 2022 18:14:21 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id ip13-20020a17090b314d00b00212cf2fe8c3sm10678445pjb.1.2022.11.17.18.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 18:14:21 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 4/4] folio-compat: Remove try_to_release_page()
Date:   Thu, 17 Nov 2022 18:14:10 -0800
Message-Id: <20221118021410.24420-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118021410.24420-1-vishal.moola@gmail.com>
References: <20221118021410.24420-1-vishal.moola@gmail.com>
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

There are no more callers of try_to_release_page(), so remove it. This
saves 149 bytes of kernel text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bbccb4044222..daf5e1a1d313 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1107,7 +1107,6 @@ void __filemap_remove_folio(struct folio *folio, void *shadow);
 void replace_page_cache_page(struct page *old, struct page *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct folio_batch *fbatch);
-int try_to_release_page(struct page *page, gfp_t gfp);
 bool filemap_release_folio(struct folio *folio, gfp_t gfp);
 loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
 		int whence);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index e1e23b4947d7..9318a0bd9155 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -129,12 +129,6 @@ void delete_from_page_cache(struct page *page)
 	return filemap_remove_folio(page_folio(page));
 }
 
-int try_to_release_page(struct page *page, gfp_t gfp)
-{
-	return filemap_release_folio(page_folio(page), gfp);
-}
-EXPORT_SYMBOL(try_to_release_page);
-
 int isolate_lru_page(struct page *page)
 {
 	if (WARN_RATELIMIT(PageTail(page), "trying to isolate tail page"))
-- 
2.38.1

