Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6875364F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353662AbiE0PvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352896AbiE0Pup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF0E134E3C
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Wmftxi7ZyMXSgnSMBA2RNVuZQulAw5FzEFja1eTaYAM=; b=h63Z8iUYz6GggwqH7hdkxq8mei
        81DME2H8ys3v+gQSj+HkgDycIWcgV9raLaLBvT/gB1LcURKhHmNkWtAjYyBVFFxtJdIVi0t1uXr8m
        SIrdTZyXrQc9E9QcWCeJRR0TKvbHV3OO78/+549p4hP7LnKl0hYeiMqO7C/2MuMzX3csj4g0GUMNY
        nqKGgeGmA3x/istG2DUDxnKkDtxg0KEYNECnuYLOxiNZrJGhYqmSb1aAoTlGF9hGkI7xNOQE4ga/T
        7Ior55n3dwnMIXbiZi4ejGYHQksu6rpcP+FS4woNZdU3VFL5kNIPdvPvwA40qcBu6uxtWJ6ufJ2/u
        EGQDNLtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEc-002CY1-EI; Fri, 27 May 2022 15:50:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 24/24] ocfs2: Use filemap_write_and_wait_range() in ocfs2_cow_sync_writeback()
Date:   Fri, 27 May 2022 16:50:36 +0100
Message-Id: <20220527155036.524743-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
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

Remove the open-coding of filemap_fdatawait_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/refcounttree.c | 42 ++++++-----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index e04358a46b68..1358981e80a3 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -3146,48 +3146,18 @@ int ocfs2_cow_sync_writeback(struct super_block *sb,
 			     struct inode *inode,
 			     u32 cpos, u32 num_clusters)
 {
-	int ret = 0;
-	loff_t offset, end, map_end;
-	pgoff_t page_index;
-	struct page *page;
+	int ret;
+	loff_t start, end;
 
 	if (ocfs2_should_order_data(inode))
 		return 0;
 
-	offset = ((loff_t)cpos) << OCFS2_SB(sb)->s_clustersize_bits;
-	end = offset + (num_clusters << OCFS2_SB(sb)->s_clustersize_bits);
+	start = ((loff_t)cpos) << OCFS2_SB(sb)->s_clustersize_bits;
+	end = start + (num_clusters << OCFS2_SB(sb)->s_clustersize_bits) - 1;
 
-	ret = filemap_fdatawrite_range(inode->i_mapping,
-				       offset, end - 1);
-	if (ret < 0) {
+	ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
+	if (ret < 0)
 		mlog_errno(ret);
-		return ret;
-	}
-
-	while (offset < end) {
-		page_index = offset >> PAGE_SHIFT;
-		map_end = ((loff_t)page_index + 1) << PAGE_SHIFT;
-		if (map_end > end)
-			map_end = end;
-
-		page = find_or_create_page(inode->i_mapping,
-					   page_index, GFP_NOFS);
-		BUG_ON(!page);
-
-		wait_on_page_writeback(page);
-		if (PageError(page)) {
-			ret = -EIO;
-			mlog_errno(ret);
-		} else
-			mark_page_accessed(page);
-
-		unlock_page(page);
-		put_page(page);
-		page = NULL;
-		offset = map_end;
-		if (ret)
-			break;
-	}
 
 	return ret;
 }
-- 
2.34.1

