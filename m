Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7875661E62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbjAIFSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjAIFSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF662CE16;
        Sun,  8 Jan 2023 21:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=q/yHyMldu60gOBaQs0jTxyPBD38OhQT4AJEanuofTzA=; b=iVygUdYUAJcdSPVDpeLxNQYVjX
        VZ2eUIAr5Ni+Oq6UGlvHzp4wUhACJQlG+KVRJBJsBYXc1bElntXZ9kqQZPw8xJ1uMo9SviLIzgjB/
        4osnd9cWjUDxrDgHRBs2L3rrTD3u/kTJ9kxjdg1fqA2JTvD1KaonAc6P7HxK2kpd13noRlgtZSdQs
        /6GV9vYKYJNFilnTeuY/k/DjIGsd5d3k+A24w5+VIhfm31A30b6n0A9heS7y6kXjUPEXgm42wFA6X
        PuBqeYRiNfeuoD7/Jaiv8zElM3UVQOwf1xBIJNJ7j+aRCqZlyr5dbmR8mGAHAdXVWwd7VTg+FteSH
        n5LpyBKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYD-0020wr-6J; Mon, 09 Jan 2023 05:18:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/11] f2fs: Convert f2fs_wait_on_node_pages_writeback() to errseq
Date:   Mon,  9 Jan 2023 05:18:15 +0000
Message-Id: <20230109051823.480289-4-willy@infradead.org>
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

Convert from the old filemap_check_errors() to the errseq infrastructure.
This means we will not report any previously-occurring error, and we will
not clear any previously-occurring error.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dde4c0458704..a87b5515c681 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2055,12 +2055,14 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 						unsigned int seq_id)
 {
+	struct address_space *mapping = NODE_MAPPING(sbi);
 	struct fsync_node_entry *fn;
 	struct page *page;
 	struct list_head *head = &sbi->fsync_node_list;
 	unsigned long flags;
 	unsigned int cur_seq_id = 0;
 	int ret2, ret = 0;
+	errseq_t since = filemap_sample_wb_err(mapping);
 
 	while (seq_id && cur_seq_id < seq_id) {
 		spin_lock_irqsave(&sbi->fsync_node_lock, flags);
@@ -2088,7 +2090,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 			break;
 	}
 
-	ret2 = filemap_check_errors(NODE_MAPPING(sbi));
+	ret2 = filemap_check_wb_err(mapping, since);
 	if (!ret)
 		ret = ret2;
 
-- 
2.35.1

