Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4A7A0858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbjINPAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbjINPAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:00:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B871A8;
        Thu, 14 Sep 2023 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OkvF4ibs8RYRTwhzX/gINZM+M0b9L03r2KeyEbf3tjw=; b=qzhJ9VdWPwU+NmQlxOCDeRFyI/
        W20vlX37LdzlW7N1hktpq3bw7XEHK6Omb2OUkS8KzJ3XZ4JwUjOxLaav+C2GS6wcOrDWFg3N9kYOq
        zGTZ+/bZCiOFDSqKclvO7wr5HzppZJGnOI4G/o1tGQj+7bf01+N7/roIXUP1ZWDag0YHZYPs7PX3W
        mWPqFNNFROlXC7SYllL4nokIN9aKlIKzRM877lXLR/RuX699OJx9cSnqnaRmQVyHzlkpfj8jqNVM1
        XW89jmdLJ2fZMey8v/YlzJsP2wjOyhJtBBpTp6cCQGYfldUfrbvZ4hChNGV4Wqf+rjyrJj/arr+g4
        5asHMvjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgnpF-003XOO-Tc; Thu, 14 Sep 2023 15:00:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 3/8] ext4: Use bdev_getblk() to avoid memory reclaim in readahead path
Date:   Thu, 14 Sep 2023 16:00:06 +0100
Message-Id: <20230914150011.843330-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230914150011.843330-1-willy@infradead.org>
References: <20230914150011.843330-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sb_getblk_gfp adds __GFP_NOFAIL, which is unnecessary for readahead;
we're quite comfortable with the possibility that we may not get a bh
back.  Switch to bdev_getblk() which does not include __GFP_NOFAIL.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Hui Zhu <teawater@antgroup.com>
Link: https://lore.kernel.org/linux-fsdevel/20230811035705.3296-1-teawaterz@linux.alibaba.com/
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 38217422f938..8d6c82239368 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -255,7 +255,8 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = sb_getblk_gfp(sb, block, 0);
+	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
+			sb->s_blocksize, GFP_NOWAIT);
 
 	if (likely(bh)) {
 		if (trylock_buffer(bh))
-- 
2.40.1

