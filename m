Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61064722CFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjFEQux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjFEQuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:50:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2845F1
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=INGvXmo1gpJ39BTW0aMzLO0L7xz1NqirMG8wRqMY0Xg=; b=SjKnNlbbfDgSTZbjRYUuZMRFRj
        bx0VNvdKNZSBxuqJLptI/2KmEBqT++kTYyYTNR1Ohu2VxdrSjzmjMJoi8o8h16KM3H9/zqqLWe7zU
        DZx0qWHFQPGYzwwdeDXlMQ5pRAV9QSWwO8QQ4oaaEzJmoKxoqpYcO7/aV8HX0cD/8hyL5SJNkV0K2
        GXICloYAmak4djBbPC9HZh4o6fjroCJ+jOTNi9NGDSYPt4WvofkI1a8mfUdM+sRzkCxgegkNR7giB
        ccC8y0zLEXdDvLRcMnGNc6uK94CDDtNrLlwirSPsWh7oh+S+kLPQyrfREUEYS4UVcBBlMQ4kDo0Xe
        dhtds5/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6DPa-00CCar-Gy; Mon, 05 Jun 2023 16:50:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] ubifs: Convert from writepage to writepages
Date:   Mon,  5 Jun 2023 17:50:26 +0100
Message-Id: <20230605165029.2908304-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230605165029.2908304-1-willy@infradead.org>
References: <20230605165029.2908304-1-willy@infradead.org>
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

This is a simplistic conversion to separate out any effects of
no longer having a writepage method.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 979ab1d9d0c3..8bb4cb9d528f 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1003,8 +1003,10 @@ static int do_writepage(struct page *page, int len)
  * on the page lock and it would not write the truncated inode node to the
  * journal before we have finished.
  */
-static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
+static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
+		void *data)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
@@ -1076,6 +1078,12 @@ static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
+static int ubifs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	return write_cache_pages(mapping, wbc, ubifs_writepage, NULL);
+}
+
 /**
  * do_attr_changes - change inode attributes.
  * @inode: inode to change attributes for
@@ -1636,7 +1644,7 @@ static int ubifs_symlink_getattr(struct mnt_idmap *idmap,
 
 const struct address_space_operations ubifs_file_address_operations = {
 	.read_folio     = ubifs_read_folio,
-	.writepage      = ubifs_writepage,
+	.writepages     = ubifs_writepages,
 	.write_begin    = ubifs_write_begin,
 	.write_end      = ubifs_write_end,
 	.invalidate_folio = ubifs_invalidate_folio,
-- 
2.39.2

