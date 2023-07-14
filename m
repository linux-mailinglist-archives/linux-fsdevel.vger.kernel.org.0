Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8D775429D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbjGNSeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjGNSet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:34:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646661BEB
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/mbfV42adcCNsmrpnUzTe+kmiVP1VEoUiHLrgEiMB8k=; b=TpHOc7/hNTxrp1PAp1Q+Y87Ru4
        QjOL5TlIzfPAaG4Zv0/V3ufRZaugjMYsR3QXG9Ruwg5ulLARc1tpDYGIVBGo1vVJQrk9GgSXgvgld
        nAn+MOIoe6YzrnCalJZJ/Ext9OlenJLDVpIB13F0IVSHY8zoflPEPQX62T6bU3NuqoDIxLWFg6OvV
        ay1VSWZzeMBkgvJ72cuLP+SAUH3FHE2GAuqxWSO1hKhePswHwYSflhI/xN6PIqu3lSMceu8zUnixm
        kL2Xq0t/Lk0uRApLGif7GQjvzA/WWCAC7YWL0C6wIpc7zTxR09iWU4QwAeLPagJSL/1ma1D4cxcd3
        2Oy++xBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKNcq-001I0E-UH; Fri, 14 Jul 2023 18:34:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] affs: Remove writepage implementation
Date:   Fri, 14 Jul 2023 19:34:40 +0100
Message-Id: <20230714183440.307525-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the filesystem implements migrate_folio and writepages, there is
no need for a writepage implementation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/affs/file.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 705e227ff63d..aa38674d2978 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -15,6 +15,7 @@
 
 #include <linux/uio.h>
 #include <linux/blkdev.h>
+#include <linux/mpage.h>
 #include "affs.h"
 
 static struct buffer_head *affs_get_extblock_slow(struct inode *inode, u32 ext);
@@ -370,9 +371,10 @@ affs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh_resul
 	return -ENOSPC;
 }
 
-static int affs_writepage(struct page *page, struct writeback_control *wbc)
+static int affs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	return block_write_full_page(page, affs_get_block, wbc);
+	return mpage_writepages(mapping, wbc, affs_get_block);
 }
 
 static int affs_read_folio(struct file *file, struct folio *folio)
@@ -456,10 +458,11 @@ const struct address_space_operations affs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio = affs_read_folio,
-	.writepage = affs_writepage,
+	.writepages = affs_writepages,
 	.write_begin = affs_write_begin,
 	.write_end = affs_write_end,
 	.direct_IO = affs_direct_IO,
+	.migrate_folio = buffer_migrate_folio,
 	.bmap = _affs_bmap
 };
 
@@ -834,9 +837,10 @@ const struct address_space_operations affs_aops_ofs = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio = affs_read_folio_ofs,
-	//.writepage = affs_writepage_ofs,
+	//.writepages = affs_writepages_ofs,
 	.write_begin = affs_write_begin_ofs,
-	.write_end = affs_write_end_ofs
+	.write_end = affs_write_end_ofs,
+	.migrate_folio = filemap_migrate_folio,
 };
 
 /* Free any preallocated blocks. */
-- 
2.39.2

