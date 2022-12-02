Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E404F64049A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 11:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiLBK1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 05:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiLBK1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:27:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F926AC0;
        Fri,  2 Dec 2022 02:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fqr9TW+rT8ValeXLVFOQSDtrNHXsSl7u56JKe2jXztI=; b=TWvEKxe1hgaqaar0S3SdimrN6x
        CCDVFmRGCM1ggNXnG5FjJDcpDBjli7i4LD/ks900zzcj1gTmSm5Gec8vrJIJc0FAdbCn/oPYdx6Zt
        T05aBcXid3fSpkehDIgr1ssY1DY7NeoCM6NTgkF8Vti6BYts/hcAO9azLBFkGAkL3ItNAnApvXXyu
        BZ5KwzzO58NFGMAbVIIZUWGmHki7aOK6zFx1KMBI5NFt2H8SHg5srWFPDo3CeaHU/T3xDokLMAjJ4
        ueFDVhrzFEEHXF9JZhYku8gRMyvySJf07CcRonjhN0xseuAoTI2jGFX2ZwGLSf2ZqyQh893fl2rar
        sG+xo6dA==;
Received: from [2001:4bb8:192:26e7:bcd3:7e81:e7de:56fd] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p13G4-00FR2o-7h; Fri, 02 Dec 2022 10:27:04 +0000
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
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 6/7] jfs: remove ->writepage
Date:   Fri,  2 Dec 2022 11:26:43 +0100
Message-Id: <20221202102644.770505-7-hch@lst.de>
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
Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/jfs/inode.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index d1ec920aa030a8..8ac10e39605081 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -264,11 +264,6 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 	return rc;
 }
 
-static int jfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, jfs_get_block, wbc);
-}
-
 static int jfs_writepages(struct address_space *mapping,
 			struct writeback_control *wbc)
 {
@@ -355,12 +350,12 @@ const struct address_space_operations jfs_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= jfs_read_folio,
 	.readahead	= jfs_readahead,
-	.writepage	= jfs_writepage,
 	.writepages	= jfs_writepages,
 	.write_begin	= jfs_write_begin,
 	.write_end	= jfs_write_end,
 	.bmap		= jfs_bmap,
 	.direct_IO	= jfs_direct_IO,
+	.migrate_folio	= buffer_migrate_folio,
 };
 
 /*
-- 
2.30.2

