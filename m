Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73B8779416
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjHKQPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjHKQPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:15:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554542694;
        Fri, 11 Aug 2023 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TtnsL4i1WDoruwjihR7ho5E4T0YVgEIZCD8hWU4Po38=; b=Hk9/6EzKfW6Tas2SkqzCYnGlqY
        iIwVxlAicMgGum0LcucsvrJ2hXGVeC9GSLJLx//IoSjl3dd9G6O7DBlNCtMxUMj6x/TrYlCy7IApx
        FApal6jU0O0dDTmmHkH4Wb8E+lFP25+jLGpCJxAJ6Ow8Yd/A3rTxDVOxkUCeGQVgwOf1Y0rE3958G
        2p8lgRV2Ivbq/xKQWVvp0zEj1RfF2kLrGz+2UZ/iTda59lqiAUidk+cpPLDgU2H43VLJWtN7oIy/X
        KdTvxVjwfJDUz58OWvcffBaXV+LzLGfns3lTAPPMIN1ZxVBmFhKV5aczuafCdnlYq7bQ/7wOEIQJS
        MjmNlqPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUUnT-0027ka-6Y; Fri, 11 Aug 2023 16:15:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH 3/3] ext4: Use bdev_getblk() to avoid memory reclaim in readahead path
Date:   Fri, 11 Aug 2023 17:15:28 +0100
Message-Id: <20230811161528.506437-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230811161528.506437-1-willy@infradead.org>
References: <20230811161528.506437-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index c94ebf704616..48524314be97 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -254,7 +254,8 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = sb_getblk_gfp(sb, block, 0);
+	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
+			sb->s_blocksize, GFP_NOWAIT);
 
 	if (likely(bh)) {
 		if (trylock_buffer(bh))
-- 
2.40.1

