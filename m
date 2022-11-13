Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D3F627092
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 17:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiKMQ3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 11:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiKMQ3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:29:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E1B7643;
        Sun, 13 Nov 2022 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MEfXNy0oYvg+oByXyXaf2fLih3PRNTBnoHWoUbGvyo0=; b=1CYlSCKTrhaufOIQITLboWc3nv
        5XP8UaQ6updySgkzvHd+U0qG7p63m8ky3bOXtD/C5Lv62v2DvM+6ycEE2NyriXXCT8GlQRzLkqwHl
        PjPioAVEb5Yi1VFqlE9lmvf0ARj8+YcM96t2AnpdL5Xial7ovi4MPfSFEzQBZMV/phYO54KwQiuAa
        jrzM3eetiPkSNibuVO6DW7XDWDELhJbeCrOOgoSz5vfvh2lTcMcq9ewYxCv8wljb/FihZUdKoZqRd
        /jeBjIMEvgKWGdgnNgGodWrmTB6NEAkqivpO9lhBFpdyHBPdRoYsNw6dKFJScAZk7eCy9QCvG7ZiI
        tKo1bOOw==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFrP-00CJu6-H9; Sun, 13 Nov 2022 16:29:32 +0000
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
Subject: [PATCH 6/9] hpfs: remove ->writepage
Date:   Sun, 13 Nov 2022 17:28:59 +0100
Message-Id: <20221113162902.883850-7-hch@lst.de>
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
 fs/hpfs/file.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index f7547a62c81f6..88952d4a631e6 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -163,11 +163,6 @@ static int hpfs_read_folio(struct file *file, struct folio *folio)
 	return mpage_read_folio(folio, hpfs_get_block);
 }
 
-static int hpfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, hpfs_get_block, wbc);
-}
-
 static void hpfs_readahead(struct readahead_control *rac)
 {
 	mpage_readahead(rac, hpfs_get_block);
@@ -248,12 +243,12 @@ const struct address_space_operations hpfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio = hpfs_read_folio,
-	.writepage = hpfs_writepage,
 	.readahead = hpfs_readahead,
 	.writepages = hpfs_writepages,
 	.write_begin = hpfs_write_begin,
 	.write_end = hpfs_write_end,
-	.bmap = _hpfs_bmap
+	.bmap = _hpfs_bmap,
+	.migrate_folio = buffer_migrate_folio,
 };
 
 const struct file_operations hpfs_file_ops =
-- 
2.30.2

