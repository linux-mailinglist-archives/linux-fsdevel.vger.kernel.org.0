Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3A67D62D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjAZUYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjAZUYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8834B742;
        Thu, 26 Jan 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PBBtjBBiY58Cfnr4orOrudpaRGHxJsqxIc2cgSFCcg0=; b=P7eQPsiWNouaWyX4ZsFeuNbHuJ
        WRHrkxb9zouUTtvz7iEpZ0gVP7L67w2JilfKhFCDn4tGDEBXRME38qnu/8LQIUs0aOipggFYUbI6x
        yRVa5ugxAnRyq4/oNHMYKEJhaLx9DgFpxK7WPlZ9knkpVma7kaFcFJSzPCq5mv7eLZpMXi4gKVKri
        VEUVclMjytIxpZ8EsxEzjoO4x4Q+KJfVOCFj+Wg8h7L9e5zcQm9vSnqYejCyMeqZTyElDtAmd/rps
        1u0ReBfLIAlnUU8cy+XSdg/3eCWlRrTEo+w4Ab7YNS/U2EvCmP+MHaTwek1Qy5IjeX/AiuSWmtulD
        el1c4kpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nE-0073kT-7q; Thu, 26 Jan 2023 20:24:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/31] ext4: Convert ext4_write_end() to use a folio
Date:   Thu, 26 Jan 2023 20:24:01 +0000
Message-Id: <20230126202415.1682629-18-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
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

Convert the incoming struct page to a folio.  Replaces two implicit
calls to compound_head() with one explicit call.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9233d6b68ebe..ab6eb85a9506 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1306,6 +1306,7 @@ static int ext4_write_end(struct file *file,
 			  loff_t pos, unsigned len, unsigned copied,
 			  struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -1321,7 +1322,7 @@ static int ext4_write_end(struct file *file,
 
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
 	/*
-	 * it's important to update i_size while still holding page lock:
+	 * it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 *
 	 * If FS_IOC_ENABLE_VERITY is running on this inode, then Merkle tree
@@ -1329,15 +1330,15 @@ static int ext4_write_end(struct file *file,
 	 */
 	if (!verity)
 		i_size_changed = ext4_update_inode_size(inode, pos + copied);
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (old_size < pos && !verity)
 		pagecache_isize_extended(inode, old_size, pos);
 	/*
-	 * Don't mark the inode dirty under page lock. First, it unnecessarily
-	 * makes the holding time of page lock longer. Second, it forces lock
-	 * ordering of page lock and transaction start for journaling
+	 * Don't mark the inode dirty under folio lock. First, it unnecessarily
+	 * makes the holding time of folio lock longer. Second, it forces lock
+	 * ordering of folio lock and transaction start for journaling
 	 * filesystems.
 	 */
 	if (i_size_changed)
-- 
2.35.1

