Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE851F180
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiEHUhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiEHUgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D562F1
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HqjpKMxjjZ+y206JJMkEPSg+DwiSA7ipZ07Q6PD4D84=; b=BzqGGPxMqalY2iYYS/CtzymxjM
        4FOGNFdnVv2A5VIOz9KzXhkxGY8IivUaEQTgbOh0NOZZJn2nfdW/+nhNp2DjfDWlJdOu1JYxRkqcN
        hWZKghXKkWeFI/ypDdqBgDU38vhPJKrb+GVPoRl/+wT8/MP3Jn65wK1i17X1/CI03FrEGhaf+CKpZ
        K5R3Trg5EGEzauVtqfWC5QlhqskSu6JsKh9kWsAW8UZe01PA2/RVdpT+7mPESkrwRO4ZyRDai9Dk1
        parCYbrP4mHdZ7e0X1dBU7cDbQDWarDOoOg4rTB5i9PIqHuNo4sqBBfDnjnUFSVYyGRrxlrjwYV4K
        c3YnckDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnna0-002nyC-QR; Sun, 08 May 2022 20:32:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4/4] mm/filemap: Hoist filler_t decision to the top of do_read_cache_folio()
Date:   Sun,  8 May 2022 21:32:34 +0100
Message-Id: <20220508203234.668623-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203234.668623-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203234.668623-1-willy@infradead.org>
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

Now that filler_t and aops->read_folio() have the same type, we can decide
which one to use at the top of the function, and cache ->read_folio in
the filler parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 81a0ed08a82c..9b7fa47feb5e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3487,6 +3487,9 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 {
 	struct folio *folio;
 	int err;
+
+	if (!filler)
+		filler = mapping->a_ops->read_folio;
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (!folio) {
@@ -3503,11 +3506,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		}
 
 filler:
-		if (filler)
-			err = filler(file, folio);
-		else
-			err = mapping->a_ops->read_folio(file, folio);
-
+		err = filler(file, folio);
 		if (err < 0) {
 			folio_put(folio);
 			return ERR_PTR(err);
-- 
2.34.1

