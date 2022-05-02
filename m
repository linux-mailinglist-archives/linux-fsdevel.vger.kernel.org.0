Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716A9516A80
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383403AbiEBGAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 02:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383373AbiEBF7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:59:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1011FCCC
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IuaDtuBdgHhMI+I3GGlIesMesfKFnTZwtEO6lEC7Slg=; b=rQgTYDVWoPSlZG35cZL1RwZ15F
        f8jOjc3SDtEWgqUq1dIxDwreix+hmkrNRfVd9kOg0gwWZz4avQJAI3Ui5P/h0EqFUH2uJ+BHeDW6P
        c1bL0dH4xkCRQPszCkCdJzjYxDwut3fbqGsAtF+zI7PhHEL0AEh+KAirUZmuScMm17K4JZsiLBXkH
        tNJk76kfui0YiQG3P1+DRLgk1S9qqSUAQTF9aQaoWcZyoaEyBx5fIr3XAXX/MowQDd2Lvkcf2ut/0
        eKRpd0MnMv4XRj0z7LjzH7iFtyyrOcz7mhzFfsOjA8DvTgdVqWFoDy3Lu52r2QAgwnZ/26iHFqquF
        G5zqzhdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2f-00EZVv-NX; Mon, 02 May 2022 05:56:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/26] cifs: Convert to release_folio
Date:   Mon,  2 May 2022 06:55:55 +0100
Message-Id: <20220502055614.3473032-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

Use a folio throughout cifs_release_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index bc6d88e2e672..06003bb9cbe9 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4758,16 +4758,16 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
 	return rc;
 }
 
-static int cifs_release_page(struct page *page, gfp_t gfp)
+static bool cifs_release_folio(struct folio *folio, gfp_t gfp)
 {
-	if (PagePrivate(page))
+	if (folio_test_private(folio))
 		return 0;
-	if (PageFsCache(page)) {
+	if (folio_test_fscache(folio)) {
 		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
-		wait_on_page_fscache(page);
+		folio_wait_fscache(folio);
 	}
-	fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
+	fscache_note_page_release(cifs_inode_cookie(folio->mapping->host));
 	return true;
 }
 
@@ -4973,7 +4973,7 @@ const struct address_space_operations cifs_addr_ops = {
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
 	.dirty_folio = cifs_dirty_folio,
-	.releasepage = cifs_release_page,
+	.release_folio = cifs_release_folio,
 	.direct_IO = cifs_direct_io,
 	.invalidate_folio = cifs_invalidate_folio,
 	.launder_folio = cifs_launder_folio,
@@ -4998,7 +4998,7 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
 	.dirty_folio = cifs_dirty_folio,
-	.releasepage = cifs_release_page,
+	.release_folio = cifs_release_folio,
 	.invalidate_folio = cifs_invalidate_folio,
 	.launder_folio = cifs_launder_folio,
 };
-- 
2.34.1

