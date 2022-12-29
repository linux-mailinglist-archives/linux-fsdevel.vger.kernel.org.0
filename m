Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7015E658EC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiL2QLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 11:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiL2QKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:10:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D6FF3;
        Thu, 29 Dec 2022 08:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eT+sezI7d2puBXhZ4YXeV63r+1dsBpxvT2Biv2ttQVQ=; b=CjvMuzxosYlfRlZyUreZne6XPB
        dsdBq4zBXheihbIMeS2ElpPTfep1aHkMTppG3M9VXX4j+hrA3xvtALTE1dKDVbJgRn/XvkK/3Msrn
        eRjanXTfUV2tQLntyRky0Y45cs55uEBTGho1aZPsQTGJpBqr2gp8OczZvzIPd7cAKsgsAgklZY9FQ
        FEEuCyiJxEnEmUr/V2rgzMmvgzew8LKBMJNo7Oyt/vdAD0gMTeR9itSequwor3zkWmBFvviZhw2/L
        3RcxZFmAbPj3p5oC0BZZeevS6/3SpWkUk7D8U9SkyP0scecn/DuasxSAYYvxJaL3SKNKWGwJwUZD5
        VE++S3Bg==;
Received: from rrcs-67-53-201-206.west.biz.rr.com ([67.53.201.206] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAvUM-00HKMX-JM; Thu, 29 Dec 2022 16:10:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: [PATCH 3/6] ntfs3: remove ->writepage
Date:   Thu, 29 Dec 2022 06:10:28 -1000
Message-Id: <20221229161031.391878-4-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229161031.391878-1-hch@lst.de>
References: <20221229161031.391878-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
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
index b6dad2da59501b..6b50b6e3237876 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -832,26 +832,6 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
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
@@ -2083,13 +2063,13 @@ const struct inode_operations ntfs_link_inode_operations = {
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
2.35.1

