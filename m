Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8662EE68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 08:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbiKRHbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 02:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241063AbiKRHbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:31:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76D57DEDD;
        Thu, 17 Nov 2022 23:31:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so1948148pji.4;
        Thu, 17 Nov 2022 23:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CejbmJMt8knLZkp2jnt3nSDaW2/iqvwuj8SHKIZ6DVU=;
        b=e28sylLlQZUiBvoVF9tPYbPyjfnV4i6SeO/H+EXMvftssRjI+reFA4qMGgM5yDcDPw
         iuHW6cApXuI55771oVrwJmic63Uelq3yaeLZ7tQHhypfuc99pqDHg5C1hqlTZ14qKTQd
         2D9MC/BqCBLie09z4RZ/9ewSv68efJQc0B8gSz0Nnz4BvLtr4LIXj8aeoZO7fOc5jSQC
         G/3ZLlmqFGfU2VlFaXy+wKBwsMDO+r3CwnrqryV45PVQ26JdwVg3r+I9Ta6QVvi6F7oi
         pkPax989JPanp1uEe3vWC5ZAANTFOsyggZLQKbgOVlz7G0KJzrCiNnodIUbMl2Oy5DZ8
         Qvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CejbmJMt8knLZkp2jnt3nSDaW2/iqvwuj8SHKIZ6DVU=;
        b=b3MZ7ka37bP6rf3rOlw7Ot4Ys1HNeUMi+t5Xz4nrfnHngXcFToZmsWyZEEyCZmhA+C
         SHH5j5SlfbYVdE9w78D0RzUlVMk9hk/CyZ24MUu1qG/rjR7NauE1fpLv+0YrjBoecC2W
         REwQwufVEUD0O4uED2/VGckkAHBFIL71CAycIEW/VJTWKP2DD0c8RuYa2NjbyC2HKisI
         /VtcB3ndG5+XhZYIKuBatqFC8r0E4eHJjLQDKmSOTNAIP67VuCIAssGBL2n+Sg2/Hx2U
         lHMLP/K5B+m2YQuj26nQOhwulbjsYmbuyh//mTF6nmlONdT+dcM6BH/LJEGLcQleLvz0
         ys+g==
X-Gm-Message-State: ANoB5pkN6hBr0tQzibRCVtEhGMlXd5UlVcUndnZ2gTTgxYeSojs15uKs
        8onO03slfdSkguKlpDno+Ew=
X-Google-Smtp-Source: AA0mqf7ZECbq0Am2Wul1fzK1qGNPncRAHISQHFCEqviSEGgaCjJZBMDKZ9VwhWGiv4XU+wtL9oWIUQ==
X-Received: by 2002:a17:90a:d3d5:b0:218:845f:36a1 with SMTP id d21-20020a17090ad3d500b00218845f36a1mr2283406pjw.117.1668756664181;
        Thu, 17 Nov 2022 23:31:04 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f7-20020a625107000000b0056b818142a2sm2424325pfb.109.2022.11.17.23.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:31:03 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 4/4] folio-compat: Remove try_to_release_page()
Date:   Thu, 17 Nov 2022 23:30:55 -0800
Message-Id: <20221118073055.55694-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118073055.55694-1-vishal.moola@gmail.com>
References: <20221118073055.55694-1-vishal.moola@gmail.com>
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

