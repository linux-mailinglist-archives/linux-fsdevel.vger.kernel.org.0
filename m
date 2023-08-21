Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DCE782B4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjHUOPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjHUOPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:15:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F40E3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=J3iDp8E0tbzTbGkQutZgb5uaihMQQsVBO5TXxgtYrzg=; b=DGmSt91gI+3s1CRuwAxTqvJGcQ
        8iCLLWGXIRlhJhLkHAHFw7QEpK7g5IKZ4o6sA3nbXtXLzWaWcULqzon2X1SdleFvFwIsGT05cKK5B
        cUMR4ykGYTNl0W5bpjfeWV06iKZL4EPbp5IfRqrCqWCRTNSxVMgSd6HOOxMxPnDpc+vJesQqjX//g
        8j7O8oH4hcERrYi3DQdp13dEw/dnMDpnOuoGr9Vr7c+lZhtp7xjbxl/aRxnSpw+V7IE8enw9dQfv4
        fkRtiNaDKjrYx1I7sG8w/v4RJIAO4l+fnm/1swgXQYI9e43DoSeszoWru6ODJbGawVBslRl0Pa2IP
        LK56mcCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY5h1-00AdjC-S9; Mon, 21 Aug 2023 14:15:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] splice: Convert page_cache_pipe_buf_confirm() to use a folio
Date:   Mon, 21 Aug 2023 15:15:41 +0100
Message-Id: <20230821141541.2535953-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
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

Convert buf->page to a folio once instead of five times.  There's only
one uptodate bit per folio, not per page, so we lose nothing here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/splice.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 5c7c8c636b2c..d983d375ff11 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -119,17 +119,17 @@ static void page_cache_pipe_buf_release(struct pipe_inode_info *pipe,
 static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
 				       struct pipe_buffer *buf)
 {
-	struct page *page = buf->page;
+	struct folio *folio = page_folio(buf->page);
 	int err;
 
-	if (!PageUptodate(page)) {
-		lock_page(page);
+	if (!folio_test_uptodate(folio)) {
+		folio_lock(folio);
 
 		/*
-		 * Page got truncated/unhashed. This will cause a 0-byte
+		 * Folio got truncated/unhashed. This will cause a 0-byte
 		 * splice, if this is the first page.
 		 */
-		if (!page->mapping) {
+		if (!folio->mapping) {
 			err = -ENODATA;
 			goto error;
 		}
@@ -137,20 +137,18 @@ static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
 		/*
 		 * Uh oh, read-error from disk.
 		 */
-		if (!PageUptodate(page)) {
+		if (!folio_test_uptodate(folio)) {
 			err = -EIO;
 			goto error;
 		}
 
-		/*
-		 * Page is ok afterall, we are done.
-		 */
-		unlock_page(page);
+		/* Folio is ok after all, we are done */
+		folio_unlock(folio);
 	}
 
 	return 0;
 error:
-	unlock_page(page);
+	folio_unlock(folio);
 	return err;
 }
 
-- 
2.40.1

