Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597064AFE50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiBIUXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C9EE040DC4
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y+DtiLkCyZdYasu76utFATrFxKI5/Wwzoyk8RsH4DE8=; b=uIJ/gpHlw7WxRJFb1kxAM5m2Xw
        xiLKV4zNfyiO/EbIuIPWNc7ShwuuYCHRWRVS6W1yc/sqb/Fe58pnOt2rWtdri6stTQzu35y27fqny
        jeXiAZv2ufaPnlC7bLy8ebnkjDiW7moYqvIrscA3OxTCN/T9s78BsAzs0FtOfPw58ZPPdgcBnMrEZ
        DRXy6n8kJGHBjNqvg0mKvce5KU5bX4ujA/m8pc5Tky5XsMtLhemLha6rqHJPUVV7Q2JaHt90qB614
        Fo5I0qwA8DXnNQHZmruO7vUNVzW2DT+CbXViZK1TcC9didVrM2dbeWETTBQwbrTF3fWqLUawB9q7a
        vm2+KUYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTv-008cs1-5O; Wed, 09 Feb 2022 20:22:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 36/56] cifs: Convert from launder_page to launder_folio
Date:   Wed,  9 Feb 2022 20:21:55 +0000
Message-Id: <20220209202215.2055748-37-willy@infradead.org>
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

Straightforward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 076094e79170..3fe3c5552b39 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4760,11 +4760,11 @@ static void cifs_invalidate_folio(struct folio *folio, size_t offset,
 	folio_wait_fscache(folio);
 }
 
-static int cifs_launder_page(struct page *page)
+static int cifs_launder_folio(struct folio *folio)
 {
 	int rc = 0;
-	loff_t range_start = page_offset(page);
-	loff_t range_end = range_start + (loff_t)(PAGE_SIZE - 1);
+	loff_t range_start = folio_pos(folio);
+	loff_t range_end = range_start + folio_size(folio);
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = 0,
@@ -4772,12 +4772,12 @@ static int cifs_launder_page(struct page *page)
 		.range_end = range_end,
 	};
 
-	cifs_dbg(FYI, "Launder page: %p\n", page);
+	cifs_dbg(FYI, "Launder page: %lu\n", folio->index);
 
-	if (clear_page_dirty_for_io(page))
-		rc = cifs_writepage_locked(page, &wbc);
+	if (folio_clear_dirty_for_io(folio))
+		rc = cifs_writepage_locked(&folio->page, &wbc);
 
-	wait_on_page_fscache(page);
+	folio_wait_fscache(folio);
 	return rc;
 }
 
@@ -4958,7 +4958,7 @@ const struct address_space_operations cifs_addr_ops = {
 	.releasepage = cifs_release_page,
 	.direct_IO = cifs_direct_io,
 	.invalidate_folio = cifs_invalidate_folio,
-	.launder_page = cifs_launder_page,
+	.launder_folio = cifs_launder_folio,
 	/*
 	 * TODO: investigate and if useful we could add an cifs_migratePage
 	 * helper (under an CONFIG_MIGRATION) in the future, and also
@@ -4982,5 +4982,5 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.set_page_dirty = cifs_set_page_dirty,
 	.releasepage = cifs_release_page,
 	.invalidate_folio = cifs_invalidate_folio,
-	.launder_page = cifs_launder_page,
+	.launder_folio = cifs_launder_folio,
 };
-- 
2.34.1

