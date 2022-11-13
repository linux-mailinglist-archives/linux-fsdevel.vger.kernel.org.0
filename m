Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC59627098
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 17:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiKMQ34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 11:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiKMQ3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:29:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A0E10B4A;
        Sun, 13 Nov 2022 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=d1VC7GrQaMZNbkdOyDmdF6TZukkUpzM8YbBGwowHmIU=; b=vR2Urw0mBBapzzTe+ueUjxIcY0
        Olt8+7T4BHw+h4YYCYE28AfjUTK6KSXgjUNvFMF/cmF0x/SDDKAKBik7JeJNB3hk5Ij/4zY/sb7gp
        yfsEo+ErnNnXsbVrPMQhy7zKjBT9bpHmYGUFOh/sFVFF0DAOWtuD+RUHdn5B80Ft2T/6v5qm15H/7
        P0+sCUGI+u4iM+v5TLUgUFyeDIh426tTZEO/p/akvkKG1E21tuVTNqVxXFnDAcvN+N7dKSZfgpHoR
        B4oxYYk8vVaZcWWkAfypcY4RCswZTj1zxhrBiOcPSXylEvUYj0wdK5RVg/QvdvkPtJbdunpGgS+gb
        b3qp9j2Q==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFrd-00CK5A-Ob; Sun, 13 Nov 2022 16:29:46 +0000
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
Subject: [PATCH 9/9] udf: remove ->writepage
Date:   Sun, 13 Nov 2022 17:29:02 +0100
Message-Id: <20221113162902.883850-10-hch@lst.de>
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
the ->writepage implementation in extfat.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/udf/inode.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index dce6ae9ae306c..0246b1b86fb91 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -182,11 +182,6 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int udf_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, udf_get_block, wbc);
-}
-
 static int udf_writepages(struct address_space *mapping,
 			struct writeback_control *wbc)
 {
@@ -239,12 +234,12 @@ const struct address_space_operations udf_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= udf_read_folio,
 	.readahead	= udf_readahead,
-	.writepage	= udf_writepage,
 	.writepages	= udf_writepages,
 	.write_begin	= udf_write_begin,
 	.write_end	= generic_write_end,
 	.direct_IO	= udf_direct_IO,
 	.bmap		= udf_bmap,
+	.migrate_folio	= buffer_migrate_folio,
 };
 
 /*
-- 
2.30.2

