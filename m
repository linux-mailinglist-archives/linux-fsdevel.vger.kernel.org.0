Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFA14AFE5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiBIUXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AAAE01CC92
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v4TJv56pZi83VQdK2po5zFJ9wH0wH8Lr0k8idHXOd0g=; b=FJljF86GgFKAJeioHC6cCT8Fns
        jBTaK/to4hoBDXL4b4cVDpGYjNcgJ/TD07arA6ik9wHqVen4fm21NgNH2tOho8gmlnmuv71G+a+tA
        lp33F9RrR7YtCri57g57bp6IGly69KRpSSZwUUfIYDQEBrkYr72lG3f3CAHFgU1AtKcDOMQjFR0P7
        ooqw7QRb5HZvaMIq57tMZSdr7hw98UUFQNtipA736gjtgsB6je9CJ0OQHwFzLGcIP/m7cFKg/Mb4L
        yyXADeEo2i8LyPxetYndxHV7KyY62+X+J2B0aIcA8WAw1tvhfG9aETDSTUbdFSKqVBRi+jPOPRsgo
        fzypPUig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTw-008ct4-Fk; Wed, 09 Feb 2022 20:22:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 46/56] afs: Convert afs_dir_set_page_dirty() to afs_dir_dirty_folio()
Date:   Wed,  9 Feb 2022 20:22:05 +0000
Message-Id: <20220209202215.2055748-47-willy@infradead.org>
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

This is a trivial change.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index d30b137be476..932e61e28e5d 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -45,7 +45,8 @@ static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
 static void afs_dir_invalidate_folio(struct folio *folio, size_t offset,
 				   size_t length);
 
-static int afs_dir_set_page_dirty(struct page *page)
+static bool afs_dir_dirty_folio(struct address_space *mapping,
+		struct folio *folio)
 {
 	BUG(); /* This should never happen. */
 }
@@ -73,7 +74,7 @@ const struct inode_operations afs_dir_inode_operations = {
 };
 
 const struct address_space_operations afs_dir_aops = {
-	.set_page_dirty	= afs_dir_set_page_dirty,
+	.dirty_folio	= afs_dir_dirty_folio,
 	.releasepage	= afs_dir_releasepage,
 	.invalidate_folio = afs_dir_invalidate_folio,
 };
-- 
2.34.1

