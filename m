Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6650D7A58EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjISEwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjISEwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:52:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF331185;
        Mon, 18 Sep 2023 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Q2rvHiZsdLzh9BkWBreljgYK2jHDgtKfuRI348f+Xvk=; b=MVTTzmN0Fi2gnVe+AUohv2o0f6
        7yctAStcuK2DhcLE0Ga6gJ/VoUaFh8OXtwYF/lq55K3kZphTrHd/O30WbD79IwcIlGhpCuXvN8oW3
        2kjSuMSoCdzD8TGcnORMAPVBmEMaDVwYyV6u7mogoKMTEKqydGQAfprDtmiE0agygD9g+CE/zfGGN
        KmaUmB5NL7QFqTNmo/cCnvesjjJD5V5dz7XELmdKzsYUW8WaiIvppz6AxxoNsADw8+QgWOGmhYYCC
        ViTsXbnzEQ1MH5z7C+1RF5twYiK/8Jyv3u77QfWEz2LJhzbiSG+nHoaZIYdiGn5MQRKdmCQfpQPMR
        vRUsTNZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi2-00FFkH-43; Tue, 19 Sep 2023 04:51:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 01/26] buffer: Make folio_create_empty_buffers() return a buffer_head
Date:   Tue, 19 Sep 2023 05:51:10 +0100
Message-Id: <20230919045135.3635437-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
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

Almost all callers want to know the first BH that was allocated
for this folio.  We already have that handy, so return it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 24 +++++++++++++-----------
 include/linux/buffer_head.h |  4 ++--
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ad2526dd7cb4..1b9e691714bd 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1646,8 +1646,8 @@ EXPORT_SYMBOL(block_invalidate_folio);
  * block_dirty_folio() via private_lock.  try_to_free_buffers
  * is already excluded via the folio lock.
  */
-void folio_create_empty_buffers(struct folio *folio, unsigned long blocksize,
-				unsigned long b_state)
+struct buffer_head *folio_create_empty_buffers(struct folio *folio,
+		unsigned long blocksize, unsigned long b_state)
 {
 	struct buffer_head *bh, *head, *tail;
 	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT | __GFP_NOFAIL;
@@ -1674,6 +1674,8 @@ void folio_create_empty_buffers(struct folio *folio, unsigned long blocksize,
 	}
 	folio_attach_private(folio, head);
 	spin_unlock(&folio->mapping->private_lock);
+
+	return head;
 }
 EXPORT_SYMBOL(folio_create_empty_buffers);
 
@@ -1775,13 +1777,15 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
 						struct inode *inode,
 						unsigned int b_state)
 {
+	struct buffer_head *bh;
+
 	BUG_ON(!folio_test_locked(folio));
 
-	if (!folio_buffers(folio))
-		folio_create_empty_buffers(folio,
-					   1 << READ_ONCE(inode->i_blkbits),
-					   b_state);
-	return folio_buffers(folio);
+	bh = folio_buffers(folio);
+	if (!bh)
+		bh = folio_create_empty_buffers(folio,
+				1 << READ_ONCE(inode->i_blkbits), b_state);
+	return bh;
 }
 
 /*
@@ -2671,10 +2675,8 @@ int block_truncate_page(struct address_space *mapping,
 		return PTR_ERR(folio);
 
 	bh = folio_buffers(folio);
-	if (!bh) {
-		folio_create_empty_buffers(folio, blocksize, 0);
-		bh = folio_buffers(folio);
-	}
+	if (!bh)
+		bh = folio_create_empty_buffers(folio, blocksize, 0);
 
 	/* Find the buffer that contains "offset" */
 	offset = offset_in_folio(folio, from);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 3dc4720e4773..1001244a8941 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -203,8 +203,8 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
-void folio_create_empty_buffers(struct folio *folio, unsigned long blocksize,
-				unsigned long b_state);
+struct buffer_head *folio_create_empty_buffers(struct folio *folio,
+		unsigned long blocksize, unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_async_write(struct buffer_head *bh, int uptodate);
-- 
2.40.1

