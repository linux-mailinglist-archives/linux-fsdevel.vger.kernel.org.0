Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2951520B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379683AbiD2Rax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379640AbiD2R3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A725A76C3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nfgdyrwqFh++TrxoSevQeO/+ZnIqinu9pA/W/va2zkw=; b=JhGMxC4D0GlKIl5yfvAF8i4MxH
        rG+fY3D25vsM9pqqkv9u6jz/vKWhKrwvBQFZqAOPi8E+dLZedi0Xvx4oNYyobpem7IVDWGaZVBgzr
        xF5SMaRYYq4m5aTUdvTgWDz/YSzG6GNfu5D6sVrG8Xhvew1cvC5aBkhBBKUTOHLO9yStg+mYAmVvq
        LGqd9u2zoyI9Kn7Ob8AILgVv3/bKInnO3VqSMobH4mtSZDcoMn6cxqNOPLnhMzgJhHEBBbG939gNw
        akda0oE0RRJzXBy4iAp9/4shzbVjuew4S8pv8pD+ifeaewuZCwbAbnESkobXtbk/N9EV6B3A60nN7
        3kRJQzFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNf-00Cddt-DI; Fri, 29 Apr 2022 17:26:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 68/69] mm: Convert swap_readpage to call read_folio instead of readpage
Date:   Fri, 29 Apr 2022 18:25:55 +0100
Message-Id: <20220429172556.3011843-69-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

