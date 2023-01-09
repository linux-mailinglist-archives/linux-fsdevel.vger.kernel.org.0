Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9DE661E5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbjAIFSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjAIFSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB478DE80;
        Sun,  8 Jan 2023 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lzB774qlWOGeuLTuMSFQPkmJwRXTwSiLN6M5EhwWaoI=; b=mKbzCktscn6Jx0BP1xTRqukdZF
        nsrtNLVPeVuRjragXpmoIVeIzgGb0cnGyr1MUaySI1GDPtjn0IbSqa1+ySzdBGWA1S+PzmWo59/+f
        wH9GGe5EvRbCf1EvX6MwIPKGc6bpARRvARTX+OeC+dTWgQAsx9Pq4h2GNzhFWNOFVSkYkGn9pCgRO
        P8JFQRh+f9PZko0g5ck1IucaLmdMcqlO3ERpHcWUv0XNcctHTopQkPQOZ3QxjGmbwkUSMj0yMwp31
        HxN2gKdn3STEHlZiuf/HEmUJitZ5FijtDNFgXX/ve9HDjDPTWu7ilckbmLKnRpQcSsvi0IiYuJ+8Z
        ViBPmQCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYE-0020xW-4R; Mon, 09 Jan 2023 05:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/11] mm: Remove filemap_fdatawait_range_keep_errors()
Date:   Mon,  9 Jan 2023 05:18:22 +0000
Message-Id: <20230109051823.480289-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is now the same as filemap_fdatawait_range(), so change
both callers to use that instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jbd2/commit.c        | 12 +++++-------
 include/linux/pagemap.h |  2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 4810438b7856..36aa1b117a50 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -221,11 +221,10 @@ EXPORT_SYMBOL(jbd2_submit_inode_data);
 int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
 {
 	if (!jinode || !(jinode->i_flags & JI_WAIT_DATA) ||
-		!jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
+	    !jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
 		return 0;
-	return filemap_fdatawait_range_keep_errors(
-		jinode->i_vfs_inode->i_mapping, jinode->i_dirty_start,
-		jinode->i_dirty_end);
+	return filemap_fdatawait_range(jinode->i_vfs_inode->i_mapping,
+				jinode->i_dirty_start, jinode->i_dirty_end);
 }
 EXPORT_SYMBOL(jbd2_wait_inode_data);
 
@@ -270,9 +269,8 @@ int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
 {
 	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
 
-	return filemap_fdatawait_range_keep_errors(mapping,
-						   jinode->i_dirty_start,
-						   jinode->i_dirty_end);
+	return filemap_fdatawait_range(mapping, jinode->i_dirty_start,
+			jinode->i_dirty_end);
 }
 
 /*
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 573b8cce3a85..7fe2a5ec1c12 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -40,8 +40,6 @@ static inline int filemap_fdatawait(struct address_space *mapping)
 	return filemap_fdatawait_range(mapping, 0, LLONG_MAX);
 }
 
-#define filemap_fdatawait_range_keep_errors(mapping, start, end)	\
-	filemap_fdatawait_range(mapping, start, end)
 #define filemap_fdatawait_keep_errors(mapping)	filemap_fdatawait(mapping)
 
 bool filemap_range_has_page(struct address_space *, loff_t lstart, loff_t lend);
-- 
2.35.1

