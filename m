Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF462708F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 17:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiKMQ3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 11:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiKMQ3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:29:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B677674;
        Sun, 13 Nov 2022 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MwWj9ekijv12iDbEn7vuZCjsvgidcmcKtSd/iPVo/3U=; b=sX+/TxS5zNNROlDDctzjyY/ZjS
        g7P6amhXAy3A8MTH2YivI6QAOzqoM4YVgs8bon154bEvl614EDxGvS2f3HDxjB7I6hMMGdMG6InpY
        xkKJw4QUdBwSO2h/Dq4l/Lrl9bljG5TKB1foSi9C6QjUZoA6e0u05s8pq5lAFvQU4f9MpKJqPc50q
        LRE4B0JVluK6OhlGeHkzpXprpb9lQag0JUEGY8odsXvbNBJuDM/Klzo6uXma3atSgB7lCPdC7eIgB
        j2kgdck8zIN/g0yA6fivbHDh17B+VYnKLv8frjkxP1MOvsOc+mjuES3PhtbINubHCyw4daLcEeNVz
        ffyH3KCg==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFrK-00CJs5-Tj; Sun, 13 Nov 2022 16:29:27 +0000
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
Subject: [PATCH 5/9] hfsplus: remove ->writepage
Date:   Sun, 13 Nov 2022 17:28:58 +0100
Message-Id: <20221113162902.883850-6-hch@lst.de>
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

Set ->migrate_folio to the generic buffer_head based helper, and stop
wiring up ->writepage for hfsplus_aops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/hfsplus/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index aeab83ed1c9c6..d6572ad2407a7 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -170,12 +170,12 @@ const struct address_space_operations hfsplus_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= hfsplus_read_folio,
-	.writepage	= hfsplus_writepage,
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
 	.bmap		= hfsplus_bmap,
 	.direct_IO	= hfsplus_direct_IO,
 	.writepages	= hfsplus_writepages,
+	.migrate_folio	= buffer_migrate_folio,
 };
 
 const struct dentry_operations hfsplus_dentry_operations = {
-- 
2.30.2

