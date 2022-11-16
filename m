Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6B62BF9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 14:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiKPNfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 08:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiKPNfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:35:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01809419B8
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 05:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Zag+6/enXwde3eWhMAOCjMcOmKTqqnmLsG33PU84gFE=; b=uHakE/msiTUl0sVLLXC1rwBlON
        EmB/9u9tFdCrrw4qLfaCnkB6W+N8fcOjOAqYimr/JvtSv8hElfaIX43LjfXibeTrUuKUygcS6rtgG
        WY7DLVV+Di2PlE7ZBaN6ya6QtBF4dPCk5B3+uCrh/+jDP5y2iJ7ZpRH/8nZ6pIVH7IguzY3fy83FP
        FLObc+ptTLPE3FJva+RcgAIHtiXQtW0/LqYPad0cs4r7nN1CKmp9RvW8GZsWHG8RJh41aiWRWLCmE
        ZnFjN/wswrEv2IRy9PmMRmTIMHqBtGf5xOR4OI1eknzTeaAMSCBaTmHlRCg51ufUXHZw5j45bYMqb
        DqFCAl8A==;
Received: from [2001:4bb8:191:2606:427:bb47:a3d:e0b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovIZC-003zis-Iw; Wed, 16 Nov 2022 13:35:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ntfs3: remove ->writepage
Date:   Wed, 16 Nov 2022 14:34:52 +0100
Message-Id: <20221116133452.2196640-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116133452.2196640-1-hch@lst.de>
References: <20221116133452.2196640-1-hch@lst.de>
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
 fs/ntfs3/inode.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 7a869e2a98620..65035e3e34b15 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -826,26 +826,6 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 	return err;
 }
 
-static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct address_space *mapping = page->mapping;
-	struct inode *inode = mapping->host;
-	struct ntfs_inode *ni = ntfs_i(inode);
-	int err;
-
-	if (is_resident(ni)) {
-		ni_lock(ni);
-		err = attr_data_write_resident(ni, page);
-		ni_unlock(ni);
-		if (err != E_NTFS_NONRESIDENT) {
-			unlock_page(page);
-			return err;
-		}
-	}
-
-	return block_write_full_page(page, ntfs_get_block, wbc);
-}
-
 static int ntfs_resident_writepage(struct page *page,
 		struct writeback_control *wbc, void *data)
 {
@@ -1946,13 +1926,13 @@ const struct inode_operations ntfs_link_inode_operations = {
 const struct address_space_operations ntfs_aops = {
 	.read_folio	= ntfs_read_folio,
 	.readahead	= ntfs_readahead,
-	.writepage	= ntfs_writepage,
 	.writepages	= ntfs_writepages,
 	.write_begin	= ntfs_write_begin,
 	.write_end	= ntfs_write_end,
 	.direct_IO	= ntfs_direct_IO,
 	.bmap		= ntfs_bmap,
 	.dirty_folio	= block_dirty_folio,
+	.migrate_folio	= buffer_migrate_folio,
 	.invalidate_folio = block_invalidate_folio,
 };
 
-- 
2.30.2

