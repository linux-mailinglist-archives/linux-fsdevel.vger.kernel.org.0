Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF451F174
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiEHUgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiEHUfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9360E7
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nfgdyrwqFh++TrxoSevQeO/+ZnIqinu9pA/W/va2zkw=; b=E546uTt3DRI+JpaVFd01F2BVLc
        whiBz38Hp1+Yrix+/eQOYs850Gdmc7NqIVj58ugMjDf7nE+llUGhyHcAmpu4G46XaELWM7KhahxAA
        wR3qkQLfkC+4EhYCOrVk/RtTXjP+T6VSUuTJCbpE9SLRa9v891jfbvwNQCp8bV6NyQKuxasQn1Iri
        DJBEcZ0M5x5UL0x5OFHBh3zcSkkEOfXguDWiwrTwULlpWpkK4fif/+VII2uxDqoFhnKVg0pNU20wD
        VRZJyZmchj0vse95VaQh/RgCgtQVouOLzQ4J4ldR95gNU5Mu7aYdz+Hp745SRTKTxfmzJ49iYQWM4
        mv1x+NkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ7-002nqJ-II; Sun, 08 May 2022 20:31:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 36/37] mm: Convert swap_readpage to call read_folio instead of readpage
Date:   Sun,  8 May 2022 21:31:30 +0100
Message-Id: <20220508203131.667959-37-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

This commit is split out so it can be dropped when resolving
conflicts with Neil Brown's series to stop calling ->readpage in
the swap code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 89fbf3cae30f..1ae4be14f9d3 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -336,7 +336,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
 
-		ret = mapping->a_ops->readpage(swap_file, page);
+		ret = mapping->a_ops->read_folio(swap_file, page_folio(page));
 		if (!ret)
 			count_vm_event(PSWPIN);
 		goto out;
-- 
2.34.1

