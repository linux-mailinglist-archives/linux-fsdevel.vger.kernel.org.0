Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EB44AFE56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiBIUXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D2E040DC2
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NC7u4zHuKjM9yPrp1F9NdXA+evwoZWhPpZet6poIAB0=; b=u0BosiXC01rDUmSb0Vyj52L0LF
        7QQPLEYQ65DEdnsHxoVor6t/pylw6bZGjqjXXMYuQJTfLa/g6Gz1TG39KUQj7EYiglvt/A0AK/e9L
        8o5kzZdVdnTyav9p/oCw0WrTKwmwzVNXyZPjJ1cd1EJAV7dvkiOPxChmRwv8FQ3mgjZZx8rYGExuS
        8egavJesmoPQjo2MB/EmXtvsJTyXRpH9TYv6OVgOhNv7DbjZlKq05GDoW6plzB4QcawOAI63AqCmH
        f2y2FUEtqnZD2W7FH2JPKs9Ul0nxLSL6Y1yyEctpVpZaR/yPA+fMCEp7Gw6xhW5Ao52BKBPEI4h7n
        46cTrrNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTu-008crr-Sw; Wed, 09 Feb 2022 20:22:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 34/56] 9p: Convert from launder_page to launder_folio
Date:   Wed,  9 Feb 2022 20:21:53 +0000
Message-Id: <20220209202215.2055748-35-willy@infradead.org>
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

Trivial conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/9p/vfs_addr.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 339882493c02..a4a9075890d5 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -240,16 +240,8 @@ static int v9fs_vfs_writepage(struct page *page, struct writeback_control *wbc)
 	return retval;
 }
 
-/**
- * v9fs_launder_page - Writeback a dirty page
- * @page: The page to be cleaned up
- *
- * Returns 0 on success.
- */
-
-static int v9fs_launder_page(struct page *page)
+static int v9fs_launder_folio(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	int retval;
 
 	if (folio_clear_dirty_for_io(folio)) {
@@ -386,6 +378,6 @@ const struct address_space_operations v9fs_addr_operations = {
 	.write_end = v9fs_write_end,
 	.releasepage = v9fs_release_page,
 	.invalidate_folio = v9fs_invalidate_folio,
-	.launder_page = v9fs_launder_page,
+	.launder_folio = v9fs_launder_folio,
 	.direct_IO = v9fs_direct_IO,
 };
-- 
2.34.1

