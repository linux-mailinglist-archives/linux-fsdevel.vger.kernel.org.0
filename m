Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABFC64048F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 11:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiLBK1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 05:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiLBK1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:27:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442D1CCEE7;
        Fri,  2 Dec 2022 02:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y8Lak3cqHWQ+dnfyhXDbmC5RGlFrgzaazzdLBDYGtZQ=; b=XcSze6yIF5L/Kmd8YUIv94LZPC
        WzH1nM4w+yQHudWoL9X1McNCpmKkrfOOG/ybs6VEgRXDnhtzvFFxgF2K+DRRZs4rgwFwlL1IUYb0k
        GD2FywGv16g5FhymEprpfNUd6SH8P47C11uUX/kneFiXVwoksI8Pewz+dE9CejlFM3PqFw+Uo/hEK
        EVbR8rGTHIwXSRM3s9uHqMr05/dPb9LZP1W1w7y76Odxbvyt8owe45cylBT3x2ZFd2uwXCyfeYAfU
        qbd/2u8s94Xp6wtw3UJdMXQdpbplxOqWjnoMs2IR9BvBIGrSlqgK8NhU9/ARmvkeJON4bYlzq2qqQ
        Yv6ZzMhQ==;
Received: from [2001:4bb8:192:26e7:bcd3:7e81:e7de:56fd] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p13Fs-00FQxO-F4; Fri, 02 Dec 2022 10:26:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 2/7] fat: remove ->writepage
Date:   Fri,  2 Dec 2022 11:26:39 +0100
Message-Id: <20221202102644.770505-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202102644.770505-1-hch@lst.de>
References: <20221202102644.770505-1-hch@lst.de>
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/fat/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 1cbcc4608dc78f..d99b8549ec8f91 100644
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

