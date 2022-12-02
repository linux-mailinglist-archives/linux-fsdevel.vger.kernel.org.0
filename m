Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884CC640499
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 11:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiLBK1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 05:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiLBK1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:27:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAF126AC0;
        Fri,  2 Dec 2022 02:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mbvlyXxWhO9WFxugvmMSJQGn9fzMBZ852OGR/GsDnBQ=; b=INC7W8kcASEs2+FQI6tK+fkYe7
        FVLv5J6Yt9ZchoTmC3IrWcFjNI8P8nW/kfVnPT8z4afsigc0DyzXO/8jHJO4Lb+ZG3fJnolV4DQRY
        IAUlwenbG5qLTeP0d/+f+FXyW/PFBt2gXZ6V7In4xC82yItOO63+eSh9MshNuHBeHLlaZoxr2Wtg7
        h0UuhIkcrY6s4liyPpdjMHfpFvKmXU3TZC0Z8kursgybQFsK42q7alrWlDNMR9loGPNZPTlr5PC3X
        0N2gBn0iRz0FtIqvqeAeyX0/yD7W1p+duoifLZEIOu0sc7+LbZHHQjXMm8l5LgxIqc7RrHLLYUWvZ
        YtODIeZA==;
Received: from [2001:4bb8:192:26e7:bcd3:7e81:e7de:56fd] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p13G1-00FR1N-A5; Fri, 02 Dec 2022 10:27:01 +0000
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
Subject: [PATCH 5/7] hpfs: remove ->writepage
Date:   Fri,  2 Dec 2022 11:26:42 +0100
Message-Id: <20221202102644.770505-6-hch@lst.de>
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
 fs/hpfs/file.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index f7547a62c81f6a..88952d4a631e6c 100644
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

