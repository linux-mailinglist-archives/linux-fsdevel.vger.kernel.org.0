Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E4627093
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 17:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiKMQ3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 11:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiKMQ3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:29:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DE79FE1;
        Sun, 13 Nov 2022 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=w51Gvl8Pnmlo1SbhqS+2F9D21dBv4WKLApDvNFY66GQ=; b=12jZrKibqe1Nhuji9ZkFAX7X7U
        zZRaAN35VMESX41fHQaIN3Y8uy3rvUKp558Q1qTZy7IH6vjy/+JY1DG/SyqYz0x7Vb/uNvgwuO58f
        CvLCcoK8mV/d7Iaqx80ikp/fP+MZy5kDdVxF3CQ3y5IXhBeY05lW4tc3Bg6CaHRfR2F5y5YJBeWwB
        wuYNoNFXOP2q3Vg6lbNRCrmU+s50dJFkLl6DHMkzRi/4sMhcDsupdlw/VCMKtF6w0vEbDsbfJ+QAc
        mK0uM1NdinJqK8frxy1ZOfQgGsg5ywHowa4wlWgn7MO53yUPZnSbKo/HQef/TmbMWXA3HCQX3kyrk
        CV+B6PAQ==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFrU-00CJz6-4l; Sun, 13 Nov 2022 16:29:37 +0000
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
Subject: [PATCH 7/9] jfs: remove ->writepage
Date:   Sun, 13 Nov 2022 17:29:00 +0100
Message-Id: <20221113162902.883850-8-hch@lst.de>
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
 fs/jfs/inode.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index d1ec920aa030a..8ac10e3960508 100644
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

