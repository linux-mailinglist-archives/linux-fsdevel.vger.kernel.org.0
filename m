Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83D4AFE34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiBIUWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiBIUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F49BE039E17
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SWrzrd8H2xG04b3/8TLrMsFsdg5ZoJo6lO32Tt5jO6A=; b=gM2ZryizEX+LuUZUYTMhV7CoNd
        K2izjZ6CmQZN0q1XvM1bRP0348y3+i0Sz6Bx3dpNxd7j6lxyaDDviVFDZz3HlgEBAPB8LQvk8PyOi
        FbsKaYBfZLZpC1Gr6qA9j2Nty6FKUzdXcbt5Z9oHMBPERGQymRIL0o/uRbfSqMOlhOPlLJRD3yRhT
        AsKv3jtgbJGLGRIMCUP3U8v6SUuybBmd4IYoAgyuMeRCIeJ2CdAPT9in0vShXKYo4pkClVS21TrAJ
        nYDzs5dF4MVuMbkslMmGtjHaSVtZRiVeGcrYJLDazhqD51wXWAkdqgU5gFaitmt8OKkECabCkcGuS
        g4Q/agbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTt-008cqi-DN; Wed, 09 Feb 2022 20:22:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 22/56] cifs: Convert from invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:41 +0000
Message-Id: <20220209202215.2055748-23-willy@infradead.org>
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

A straightforward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index e7af802dcfa6..076094e79170 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4754,10 +4754,10 @@ static int cifs_release_page(struct page *page, gfp_t gfp)
 	return true;
 }
 
-static void cifs_invalidate_page(struct page *page, unsigned int offset,
-				 unsigned int length)
+static void cifs_invalidate_folio(struct folio *folio, size_t offset,
+				 size_t length)
 {
-	wait_on_page_fscache(page);
+	folio_wait_fscache(folio);
 }
 
 static int cifs_launder_page(struct page *page)
@@ -4957,7 +4957,7 @@ const struct address_space_operations cifs_addr_ops = {
 	.set_page_dirty = cifs_set_page_dirty,
 	.releasepage = cifs_release_page,
 	.direct_IO = cifs_direct_io,
-	.invalidatepage = cifs_invalidate_page,
+	.invalidate_folio = cifs_invalidate_folio,
 	.launder_page = cifs_launder_page,
 	/*
 	 * TODO: investigate and if useful we could add an cifs_migratePage
@@ -4981,6 +4981,6 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.write_end = cifs_write_end,
 	.set_page_dirty = cifs_set_page_dirty,
 	.releasepage = cifs_release_page,
-	.invalidatepage = cifs_invalidate_page,
+	.invalidate_folio = cifs_invalidate_folio,
 	.launder_page = cifs_launder_page,
 };
-- 
2.34.1

