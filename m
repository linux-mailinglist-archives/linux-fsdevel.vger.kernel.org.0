Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD84627095
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiKMQ3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 11:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiKMQ3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:29:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4539FE1;
        Sun, 13 Nov 2022 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JwXtoXGkop9hD0FEm0hcYM7qnY+377I44KCoQqxQtJQ=; b=wUYRXq26nhv9xpe10rc5HsZITE
        lyn4MpFMto7QmgQTl2vzV7N0OM3s3fH/vVK2gc5+nQAg7RUdFqAQIHC9tXpykqfwdb/4vzmPQh+lH
        2t+TwS1cXGwjpc8wmOruGdig1C1L6zUH3SJ6XYsmuv5SWrNO1SMwly55DS7CPWsvX0ZmHGGzQ+89Z
        O6uLnzEwgb9YwWHpR4qlN46nYLU9yI9eGZneYZOVFIVUHbMKNmX+cpGz/I3PZP1/4xb+KrGPBkfEY
        nzGNfI87UnslNJ6EK4QHPF6dLHI30feek9fYrI1OIbxl3VX/SF5ap3Hw14YmVPSAqOAuXL/6kRnxF
        jvSsVVYg==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFrZ-00CK21-8R; Sun, 13 Nov 2022 16:29:42 +0000
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
Subject: [PATCH 8/9] omfs: remove ->writepage
Date:   Sun, 13 Nov 2022 17:29:01 +0100
Message-Id: <20221113162902.883850-9-hch@lst.de>
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
 fs/omfs/file.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index fa7fe2393ff68..3a5b4b88a5838 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -294,11 +294,6 @@ static void omfs_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, omfs_get_block);
 }
 
-static int omfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, omfs_get_block, wbc);
-}
-
 static int
 omfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
@@ -375,10 +370,10 @@ const struct address_space_operations omfs_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio = omfs_read_folio,
 	.readahead = omfs_readahead,
-	.writepage = omfs_writepage,
 	.writepages = omfs_writepages,
 	.write_begin = omfs_write_begin,
 	.write_end = generic_write_end,
 	.bmap = omfs_bmap,
+	.migrate_folio = buffer_migrate_folio,
 };
 
-- 
2.30.2

