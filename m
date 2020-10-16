Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5CE290934
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410577AbgJPQE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410463AbgJPQEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0ADC0613D6;
        Fri, 16 Oct 2020 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VHGCzY+zyCWWjVcv6siBV92jVoQcsM9E4a8vC6aIBTc=; b=MI6xY9bDRm+D4tdW1gmmyPtkcK
        RxvvUnh9Tc7U/OoRmlYjW/gxKSNkE9t137Y7XbY/fEoRPlxlopzS8BRAktfMv6nXePSWuEszBYVQl
        Ps2w8TlSiQB+NjcAIo2VDu3SlwN4089i4UQBsLPBjiRQsFk78JrgvGt0m8omZ0geDkX3JodVJ3xuJ
        suvJFve0LNxCQv6/b6hLwQI3poM4A+eGkBvRg74cSRHcRcKA/ASmsdTO+0ZcGApLKfVlgb6HEQDph
        LJ/x+/g6Qmomcuu6JYmLq7YadbgFTds/JhTSiWQ8oeCwxEdxx62PFGCRkqZQHukcblzMp8wKssjK8
        dE2EBSIw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDo-0004tc-4W; Fri, 16 Oct 2020 16:04:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v3 12/18] ext4: Return error from ext4_readpage
Date:   Fri, 16 Oct 2020 17:04:37 +0100
Message-Id: <20201016160443.18685-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The error returned from ext4_map_blocks() was being discarded, leading
to the generic -EIO being returned to userspace.  Now ext4 can return
more precise errors.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/readpage.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index f014c5e473a9..00a024f3a954 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -237,7 +237,7 @@ int ext4_mpage_readpages(struct inode *inode,
 	sector_t blocks[MAX_BUF_PER_PAGE];
 	unsigned page_block;
 	struct block_device *bdev = inode->i_sb->s_bdev;
-	int length;
+	int length, err = 0;
 	unsigned relative_block = 0;
 	struct ext4_map_blocks map;
 	unsigned int nr_pages = rac ? readahead_count(rac) : 1;
@@ -301,14 +301,9 @@ int ext4_mpage_readpages(struct inode *inode,
 				map.m_lblk = block_in_file;
 				map.m_len = last_block - block_in_file;
 
-				if (ext4_map_blocks(NULL, inode, &map, 0) < 0) {
-				set_error_page:
-					SetPageError(page);
-					zero_user_segment(page, 0,
-							  PAGE_SIZE);
-					unlock_page(page);
-					goto next_page;
-				}
+				err = ext4_map_blocks(NULL, inode, &map, 0);
+				if (err < 0)
+					goto err;
 			}
 			if ((map.m_flags & EXT4_MAP_MAPPED) == 0) {
 				fully_mapped = 0;
@@ -395,6 +390,15 @@ int ext4_mpage_readpages(struct inode *inode,
 		} else
 			last_block_in_bio = blocks[blocks_per_page - 1];
 		goto next_page;
+	set_error_page:
+		err = -EIO;
+	err:
+		if (rac) {
+			SetPageError(page);
+			zero_user_segment(page, 0, PAGE_SIZE);
+		}
+		unlock_page(page);
+		goto next_page;
 	confused:
 		if (bio) {
 			submit_bio(bio);
@@ -410,7 +414,7 @@ int ext4_mpage_readpages(struct inode *inode,
 	}
 	if (bio)
 		submit_bio(bio);
-	return 0;
+	return err;
 }
 
 int __init ext4_init_post_read_processing(void)
-- 
2.28.0

