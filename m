Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1631162708C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 17:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbiKMQ3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 11:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiKMQ3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:29:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4B49FE9;
        Sun, 13 Nov 2022 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/xbu9xiQdaag/9GdE14AqAfcPfZ9nZ+wREMF3PN8ikU=; b=Zdpc2dMybytlRvYwON8XlABzCT
        ZMfpsLeusVZ3QKHsCMwKWFO9Kwn7VhCbwu2g9CJFiOBfB/nzdGc+nfgQ9xpO36CHzKpU6jM0cchyh
        pbaQsfIve7JTynTdwYGSBhgPZO0FafO0tSHF9tAYmPF3i8SqE6hX8HrPpqztnI3RRCUpK9DkD4VUr
        1aj4zcLV/It6mFMhS5W+SfkPikRRlQ7xGOLE+wKOfXMk7dFIEhgNFSrOuVtOxWsgD767oZT9xMQXC
        cABDK5122PBv5+NWwmfZb9tVH4upC9nkFTq3ex30hA8xLr6rkvyv1S+XCEj+yyKm/6mT8eS+5ijTx
        pdomIdRQ==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFrD-00CJp5-7o; Sun, 13 Nov 2022 16:29:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: [PATCH 3/9] fat: remove ->writepage
Date:   Sun, 13 Nov 2022 17:28:56 +0100
Message-Id: <20221113162902.883850-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221113162902.883850-1-hch@lst.de>
References: <20221113162902.883850-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->writepage is a very inefficient method to write back data, and only
used through write_cache_pages or a a fallback when no ->migrate_folio
method is present.

Set ->migrate_folio to the generic buffer_head based helper, and remove
the ->writepage implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fat/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 1cbcc4608dc78..d99b8549ec8f9 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -194,11 +194,6 @@ static int fat_get_block(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static int fat_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, fat_get_block, wbc);
-}
-
 static int fat_writepages(struct address_space *mapping,
 			  struct writeback_control *wbc)
 {
@@ -346,12 +341,12 @@ static const struct address_space_operations fat_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= fat_read_folio,
 	.readahead	= fat_readahead,
-	.writepage	= fat_writepage,
 	.writepages	= fat_writepages,
 	.write_begin	= fat_write_begin,
 	.write_end	= fat_write_end,
 	.direct_IO	= fat_direct_IO,
-	.bmap		= _fat_bmap
+	.bmap		= _fat_bmap,
+	.migrate_folio	= buffer_migrate_folio,
 };
 
 /*
-- 
2.30.2

