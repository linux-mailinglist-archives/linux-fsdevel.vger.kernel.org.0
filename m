Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B4362B116
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 03:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiKPCKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 21:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiKPCKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:10:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780BA31DC8;
        Tue, 15 Nov 2022 18:10:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso993037pjc.2;
        Tue, 15 Nov 2022 18:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CejbmJMt8knLZkp2jnt3nSDaW2/iqvwuj8SHKIZ6DVU=;
        b=G/lcM5PwZ0+Ib/Xb9y7OrQjWRddNdmXLywgQSv385sHaURx8IljbeuN/Sbp+vTAI7e
         J+GBm0Oio9YIM/KXtdA9WGU19Y/4E+/6K1dfkB7Q3+K3PrsXhvC3Z6tROjHkkEaa7Y7v
         cZgHG2WtjhEhsZnB6nySPb+qXRk4Yo8a+pM/vwOZlgkcecKcsrnbJXxVv0J7htNHaMoK
         x52qgRJ/chHlnbyPgH/sb7ZdIZLoT/4WnOh6fHNX17pWc93N/x9YWGB0IbnlYTfH/VMa
         oN/sDsoKLLnSaAfbWJ9CAluV8Ep3aJdG0byCQ7rm3WvDxsWsS/GnsDEmjhs66e7EF9dH
         Ur7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CejbmJMt8knLZkp2jnt3nSDaW2/iqvwuj8SHKIZ6DVU=;
        b=D2GGuQJiRh/I/Ef/yEuokcMEA6ycNlQfY1sWbNtNJXHl3sidBvt1S4/8DYSXlF6l/3
         b0jSfiGMUdyK861+xakg5RdtMxg3r9ycGSShr1eALudyUMJnyuswUNBrkFFT12qssWg7
         s2o1s3vsXfFECBRrynpbfli9W51Zv7gpE/47zjPYMnE8duZifUCft+pcvhGMk8sHUk4p
         etoh/a+WvQOEiqYux6xRM+6oHloDIp9BwdEfeVUtkKlRX0vmjBIyoau1qYLTe61LhDlz
         Qw/NAZMPP160K7tE4xL66dkzlR8QAYdhAJM+k0NW97st3mqUXfAGEjYhiA5stNNr8FXJ
         1cxQ==
X-Gm-Message-State: ANoB5pkl2YYh+zFytzxjXypdgWy8WmTCiTf0+TuChZbhYB4+nRDFphCE
        aFVs36FkEA3HPWxpusk6VwE=
X-Google-Smtp-Source: AA0mqf7uKcISWh7p7npTkea6Y8R0mC2+ZIlMKnRY0p+5XL9R9S9v5F0yJTMB8XVfcjk+yqVakExTKg==
X-Received: by 2002:a17:90a:1a12:b0:20a:6ffc:f0c6 with SMTP id 18-20020a17090a1a1200b0020a6ffcf0c6mr1371340pjk.49.1668564620886;
        Tue, 15 Nov 2022 18:10:20 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id e18-20020a17090301d200b0018691ce1696sm10782926plh.131.2022.11.15.18.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:10:20 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 4/4] folio-compat: Remove try_to_release_page()
Date:   Tue, 15 Nov 2022 18:10:11 -0800
Message-Id: <20221116021011.54164-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116021011.54164-1-vishal.moola@gmail.com>
References: <20221116021011.54164-1-vishal.moola@gmail.com>
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

