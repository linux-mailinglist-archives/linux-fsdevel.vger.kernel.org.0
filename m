Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC0364048E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 11:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiLBK1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 05:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiLBK1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:27:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD31CCFEB;
        Fri,  2 Dec 2022 02:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tshiIOlyizQCn3wWRqEk8o+H1VcPDbPrSjSJx6S/vZI=; b=p4T0SSAwoIWZnEozmQOSV1gt/m
        MIsRDd+GQm1I/cTGz+x3lh11gl9nlIOzHMxB4vQ1meJn45PtYaDQhPY42zKL/K405lsql7KgD71Um
        2RREPX5GNnwopdJ0PXyvfmfbM8KWrMs3PkztXKT4lZxcMAKD5EavokoI5B0Ijhx/nFCu2G26xXa/0
        CpNmv0l7/fvEHrXC2Xc4LXjaIfYob5/hQ/D2RBNqs4LR7DZR+wNPRqrCxPOPftOqV+6CBciDdnS87
        blEIGvCe0Q99ktCpoqgEH7vI3DzmeKXMGnIrjgPcWRsX1zUFMOE1orH/KBqJDWv8jUnjrvv7IzQhz
        mz06UUiw==;
Received: from [2001:4bb8:192:26e7:bcd3:7e81:e7de:56fd] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p13Fp-00FQwZ-F8; Fri, 02 Dec 2022 10:26:50 +0000
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
Subject: [PATCH 1/7] extfat: remove ->writepage
Date:   Fri,  2 Dec 2022 11:26:38 +0100
Message-Id: <20221202102644.770505-2-hch@lst.de>
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
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/exfat/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 5590a1e83126c9..eac95bcd9a8aae 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -345,11 +345,6 @@ static void exfat_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, exfat_get_block);
 }
 
-static int exfat_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, exfat_get_block, wbc);
-}
-
 static int exfat_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
@@ -473,12 +468,12 @@ static const struct address_space_operations exfat_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= exfat_read_folio,
 	.readahead	= exfat_readahead,
-	.writepage	= exfat_writepage,
 	.writepages	= exfat_writepages,
 	.write_begin	= exfat_write_begin,
 	.write_end	= exfat_write_end,
 	.direct_IO	= exfat_direct_IO,
-	.bmap		= exfat_aop_bmap
+	.bmap		= exfat_aop_bmap,
+	.migrate_folio	= buffer_migrate_folio,
 };
 
 static inline unsigned long exfat_hash(loff_t i_pos)
-- 
2.30.2

