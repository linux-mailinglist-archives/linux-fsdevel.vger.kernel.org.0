Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC9B4AFE3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiBIUW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiBIUWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0BE01CC92
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pevXkBlxMwx1c4FoZDsYjg5V3nLbnqnFPWu3WqRHTlI=; b=qfQqmOpjLlz94H9BIPzIUJToDj
        9lwP4zCrTAUromzWQgIR6yL9kdND9/A9uBDj1scEBabD4xgcx7Rn/ZQik+V8qpcOVeHGR/H8WV8BT
        kwr0J+ukyY5CZWSYSn27IRznH2EBCmecNWj5+NrMNGnhmmV1fVtsHAe5Ez45DeRnyY19pfg1AT4zT
        Ly7FxS2/O3aMpHt2bqqLYECbaSVpHKSFlhYir1DBeHdMy5O+Xq+iluxKmQmm1JtYNGV1TIVKdv4/t
        9QhrB6+rIjRkK9Lxja3D9ytgCRi2aahxEeuKMulZuiW8Q9WMLsRg0AoGdIDaTdYg0ey7rfZiDajAm
        7emUYPzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTq-008cp6-Pq; Wed, 09 Feb 2022 20:22:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/56] fs: read_mapping_page() should take a struct file argument
Date:   Wed,  9 Feb 2022 20:21:23 +0000
Message-Id: <20220209202215.2055748-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While read_cache_page() takes a void *, because you can pass a
pointer to anything as the first argument of filler_t, if we
are calling read_mapping_page(), it will be passed as the first
argument of ->readpage, so we know this must be a struct file
pointer, and we should let the compiler enforce that for us.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 34682f001344..2a4a46ff890c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -634,15 +634,15 @@ extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
-				pgoff_t index, void *data)
+				pgoff_t index, struct file *file)
 {
-	return read_cache_page(mapping, index, NULL, data);
+	return read_cache_page(mapping, index, NULL, file);
 }
 
 static inline struct folio *read_mapping_folio(struct address_space *mapping,
-				pgoff_t index, void *data)
+				pgoff_t index, struct file *file)
 {
-	return read_cache_folio(mapping, index, NULL, data);
+	return read_cache_folio(mapping, index, NULL, file);
 }
 
 /*
-- 
2.34.1

