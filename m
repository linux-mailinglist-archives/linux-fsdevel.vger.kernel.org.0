Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B275353F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348762AbiEZT3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347417AbiEZT30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 15:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E8CDFF5E
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1fhVscOW1QMOtBJ4MYUro8V0mlGs9LMeYL9nu8qXYo8=; b=PlCc04kb97cOIq5Cf9I+WzLb4y
        oBWpTrQHbjyjGcJScgjtxGMTxxgLsd+cG0TmNOtyMiziU0Z5x8NqFu5LreDVeZrO5BpTmBrXXkRop
        L1kl8RI5YnNtRpxmZLYiT/DTy3jXniIlNauKk8dhcv0MEG6QzNYG4auWZI9u2gI89RFewJ7OwMiOX
        rvmIY25KUFXK8VMvu96zXGow2DIOyOMZtXCAjh2wnBfhm20oxH6eCYl/6ZBLHYAQ84awbOImpWHjr
        EKv2vZRC7lUbkYrGoj7aIYR5uBDKeE2Lfzr16i2+SiRLgMD21ze2QZQ2rPZPo9HY3m9H0wGMFYoEo
        xwTQL6tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJAb-001Uuf-4E; Thu, 26 May 2022 19:29:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 6/9] jfs: Handle bmap with iomap
Date:   Thu, 26 May 2022 20:29:07 +0100
Message-Id: <20220526192910.357055-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220526192910.357055-1-willy@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
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

Use the new iomap support to implement bmap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 63690020cc46..19c091d9c20e 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -365,7 +365,7 @@ static int jfs_write_begin(struct file *file, struct address_space *mapping,
 
 static sector_t jfs_bmap(struct address_space *mapping, sector_t block)
 {
-	return generic_block_bmap(mapping, block, jfs_get_block);
+	return iomap_bmap(mapping, block, &jfs_iomap_ops);
 }
 
 const struct address_space_operations jfs_aops = {
-- 
2.34.1

