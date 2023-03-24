Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7B6C8449
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjCXSDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjCXSCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C580D1E1FE;
        Fri, 24 Mar 2023 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=S2Z9x16UPdx3I5jrV5LgIqL2E9Twqwvu5YRxbNS1slE=; b=lqitLbCOsIGhXhtRrB0cFaDU6c
        Ps7vjWVh/PJ8dEMq3/rsvhFh8BW2UDQfojFu1lmQ2w+/ewfShaxdKoqjqjBu/JUnHL/G+itqeewpP
        5MRKK2WGl7Uea0DBa4yS2uv7XK+XafGXFt014ho2HIWBftQ8fLR+RMy2ReS7J7tLoG4tc2I+2HhbA
        uOFumqKPhYuskrhgwkWP9LbipQEB4BKCJy/sCLjqkT8Zu9NPIMyKckkI1y1qC1tSiEP4tuoudSzty
        MnvXCtn0O+nj18PbiNMbeLLMc8T+/UY0UrRifXLtXncaN4y7n2bHOxgZXAj+Nj7Z7L4hf35P7UvU1
        yw6LPq+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljM-0057aE-Qe; Fri, 24 Mar 2023 18:01:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 17/29] ext4: Convert ext4_write_end() to use a folio
Date:   Fri, 24 Mar 2023 18:01:17 +0000
Message-Id: <20230324180129.1220691-18-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the incoming struct page to a folio.  Replaces two implicit
calls to compound_head() with one explicit call.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 769f6d5e0ec3..af2bfabfbd27 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1289,6 +1289,7 @@ static int ext4_write_end(struct file *file,
 			  loff_t pos, unsigned len, unsigned copied,
 			  struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -1304,7 +1305,7 @@ static int ext4_write_end(struct file *file,
 
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
 	/*
-	 * it's important to update i_size while still holding page lock:
+	 * it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 *
 	 * If FS_IOC_ENABLE_VERITY is running on this inode, then Merkle tree
@@ -1312,15 +1313,15 @@ static int ext4_write_end(struct file *file,
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
2.39.2

