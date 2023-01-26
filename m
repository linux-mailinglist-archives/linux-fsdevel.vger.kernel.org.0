Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C39367D633
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjAZUYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjAZUYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103C64B75A;
        Thu, 26 Jan 2023 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=C0op9GL8E8wnJM/315LimsaHG2hcURzC771kGAlL4Xg=; b=MY20wf7DlA7+6FfUrz4nLQsEXF
        CiZ6rjMn2oS6SOBwO3DoUqDlltk141AwSN5LfBhpCzZPofVrs8HQbdhkuAAxu7d/EKMMYDvI3Gd00
        +Li6sdHUF2MbOJpSHCpNND5GgKvwETOV27McLcoZLZR0QofI/vKtFH6Bqh2zChhu4W004JYde2J7e
        /XzLKn5Ijk2W15U9H0quugFyWCFhr7eNhw9CnMKv5wjWmTtCQ025BLmn8U0REdhcggDvdHeQ0mfZp
        SmgfSbc9W03eSqRVfzrBhClRKbGb2XMrzLAXdcpOQUsa1y+NJ/gGg/gNxUtSATjkfk2bo/D82BXNn
        CO+IXnyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nE-0073kZ-C8; Thu, 26 Jan 2023 20:24:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/31] ext4: Use a folio in ext4_journalled_write_end()
Date:   Thu, 26 Jan 2023 20:24:02 +0000
Message-Id: <20230126202415.1682629-19-willy@infradead.org>
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

Convert the incoming page to a folio to remove a few calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ab6eb85a9506..4f43d7434965 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1409,6 +1409,7 @@ static int ext4_journalled_write_end(struct file *file,
 				     loff_t pos, unsigned len, unsigned copied,
 				     struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -1427,25 +1428,26 @@ static int ext4_journalled_write_end(struct file *file,
 	if (ext4_has_inline_data(inode))
 		return ext4_write_inline_data_end(inode, pos, len, copied, page);
 
-	if (unlikely(copied < len) && !PageUptodate(page)) {
+	if (unlikely(copied < len) && !folio_test_uptodate(folio)) {
 		copied = 0;
 		ext4_journalled_zero_new_buffers(handle, inode, page, from, to);
 	} else {
 		if (unlikely(copied < len))
 			ext4_journalled_zero_new_buffers(handle, inode, page,
 							 from + copied, to);
-		ret = ext4_walk_page_buffers(handle, inode, page_buffers(page),
+		ret = ext4_walk_page_buffers(handle, inode,
+					     folio_buffers(folio),
 					     from, from + copied, &partial,
 					     write_end_fn);
 		if (!partial)
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 	}
 	if (!verity)
 		size_changed = ext4_update_inode_size(inode, pos + copied);
 	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (old_size < pos && !verity)
 		pagecache_isize_extended(inode, old_size, pos);
-- 
2.35.1

