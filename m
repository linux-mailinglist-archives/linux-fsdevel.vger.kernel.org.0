Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB3627089
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 17:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiKMQ3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 11:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiKMQ3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:29:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B663AE4C;
        Sun, 13 Nov 2022 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=scMCwkPRF8Nb8DbgWIgHz66Xl/jY6KIfqEEGjQf+P/U=; b=dZaZtRFdFNTJOY1FQNyijDu7jO
        H93jBvSdtSrsZP6OEyZrMhY1VbI0CUpwlTsPpjDi+4lMAIL+Y4nj9p0RfOwK76YPLCYCt/1KwRRC3
        mZ48JB/P7VnrTuDpgyoQX0CkNGnijcfT9NIM+zn4TAFb9MK+otp7w8IWEAt5belywKsJadLtrTwKC
        5ogGIWtuIUx0hXNZbzkIc8f1O4z0MBzf1hvb0ROX8Xe+CQDlO7RbLOBqjH5j1gQ19+z+Zpat9BGDr
        FQac6xjD5NdZXpmfjfrNsG6sAx+Sj2tz3i+V05uvUNmWDZI7+6l9AoSFZwsUufAKr3RT/N5rfcils
        92Ydrxtw==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFr8-00CJnt-Dv; Sun, 13 Nov 2022 16:29:15 +0000
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
Subject: [PATCH 2/9] ext2: remove ->writepage
Date:   Sun, 13 Nov 2022 17:28:55 +0100
Message-Id: <20221113162902.883850-3-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext2/inode.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 918ab2f9e4c05..3b2e3e1e0fa25 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -869,11 +869,6 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return ret;
 }
 
-static int ext2_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, ext2_get_block, wbc);
-}
-
 static int ext2_read_folio(struct file *file, struct folio *folio)
 {
 	return mpage_read_folio(folio, ext2_get_block);
@@ -948,7 +943,6 @@ const struct address_space_operations ext2_aops = {
 	.invalidate_folio	= block_invalidate_folio,
 	.read_folio		= ext2_read_folio,
 	.readahead		= ext2_readahead,
-	.writepage		= ext2_writepage,
 	.write_begin		= ext2_write_begin,
 	.write_end		= ext2_write_end,
 	.bmap			= ext2_bmap,
-- 
2.30.2

