Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA974AFE35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiBIUWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiBIUWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7937CE039C4D
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=41YIuKeU9LRgi9Ayppr+Gvnjx13Aszh1NfSFp/5uGMg=; b=OVB5921kWtKpn5k4+pWS+YgjEi
        GAcNj/XpSF9tz9YvMNYECc4/vgQ9U6sc9npT7GR47QiVLNNLqVLWPoQMEo+fxqbrnhMsaB6yAhAIs
        Qhkfv3m23Owhr9nPNCPFbkAXNNvsG2vchNRQoW/Nr1WICXLNGhqUPVmDd8qRkaCrs2KCghhHVg5IY
        dAPVhBU98OjwYLTQYhmD2QsP51YAUIGnD9uUfLm6Q+1HUfCKTWePVRFgweK7XtF7LUtOwmc7tw7WS
        k26dlLx/105EDf3DHuaSMpoNHqGlCI/JGOft8x/Ii35smhp5MnyEdqaVnHEJDPvL262rsjcvu8cmT
        Oz6y/k6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTs-008cqD-Ok; Wed, 09 Feb 2022 20:22:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 17/56] 9p: Convert to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:36 +0000
Message-Id: <20220209202215.2055748-18-willy@infradead.org>
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

This is a trivial conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/9p/vfs_addr.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 9a10e68c5f30..339882493c02 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -158,18 +158,9 @@ static int v9fs_release_page(struct page *page, gfp_t gfp)
 	return 1;
 }
 
-/**
- * v9fs_invalidate_page - Invalidate a page completely or partially
- * @page: The page to be invalidated
- * @offset: offset of the invalidated region
- * @length: length of the invalidated region
- */
-
-static void v9fs_invalidate_page(struct page *page, unsigned int offset,
-				 unsigned int length)
+static void v9fs_invalidate_folio(struct folio *folio, size_t offset,
+				 size_t length)
 {
-	struct folio *folio = page_folio(page);
-
 	folio_wait_fscache(folio);
 }
 
@@ -394,7 +385,7 @@ const struct address_space_operations v9fs_addr_operations = {
 	.write_begin = v9fs_write_begin,
 	.write_end = v9fs_write_end,
 	.releasepage = v9fs_release_page,
-	.invalidatepage = v9fs_invalidate_page,
+	.invalidate_folio = v9fs_invalidate_folio,
 	.launder_page = v9fs_launder_page,
 	.direct_IO = v9fs_direct_IO,
 };
-- 
2.34.1

