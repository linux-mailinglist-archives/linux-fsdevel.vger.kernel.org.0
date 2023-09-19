Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C577A58B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjISEv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjISEvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DA12A;
        Mon, 18 Sep 2023 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PtzeHJtzB8Xd695+Qb2V5yYYQNsOpQ3Yl0mwaGuBV/4=; b=QTFrpw3bHURLE6EYb/R+wluNva
        FnBtPTD1w+5XMNC7zEhc9bao72bgXNpxKd9qDjhuUyi1OuP6S2MMpTObEptvPQkhWhifCbXvosRRU
        e8lQf84HnBxa1MgfnDbHOnH/NdKVSKXT9I1ZfvD/Yk4oywa3zMeniEGFTRzWVl47KpSohjCj0nWeQ
        KMTRaC5Exg3bFQFNKJH7wxQjQzaewJnEQmEGfJuzU4j/MZpiupUYbK/JOi51oS+Otgux4g8Yb+Qav
        1tTYnMC0HU19LUaCIHSlX1Doe6hKM9E7DF14ZicqYzh3cMxcMxgkZBmcxG54de+EwiKG/t7IMORtB
        5T5MdMFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi3-00FFki-6d; Tue, 19 Sep 2023 04:51:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 09/26] nilfs2: Convert nilfs_mdt_freeze_buffer to use a folio
Date:   Tue, 19 Sep 2023 05:51:18 +0100
Message-Id: <20230919045135.3635437-10-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a number of folio->page->folio conversions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/mdt.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 19c8158605ed..db2260d6e44d 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -560,17 +560,19 @@ int nilfs_mdt_freeze_buffer(struct inode *inode, struct buffer_head *bh)
 {
 	struct nilfs_shadow_map *shadow = NILFS_MDT(inode)->mi_shadow;
 	struct buffer_head *bh_frozen;
-	struct page *page;
+	struct folio *folio;
 	int blkbits = inode->i_blkbits;
 
-	page = grab_cache_page(shadow->inode->i_mapping, bh->b_folio->index);
-	if (!page)
-		return -ENOMEM;
+	folio = filemap_grab_folio(shadow->inode->i_mapping,
+			bh->b_folio->index);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, 1 << blkbits, 0);
+	bh_frozen = folio_buffers(folio);
+	if (!bh_frozen)
+		bh_frozen = folio_create_empty_buffers(folio, 1 << blkbits, 0);
 
-	bh_frozen = nilfs_page_get_nth_block(page, bh_offset(bh) >> blkbits);
+	bh_frozen = get_nth_bh(bh_frozen, bh_offset(bh) >> blkbits);
 
 	if (!buffer_uptodate(bh_frozen))
 		nilfs_copy_buffer(bh_frozen, bh);
@@ -582,8 +584,8 @@ int nilfs_mdt_freeze_buffer(struct inode *inode, struct buffer_head *bh)
 		brelse(bh_frozen); /* already frozen */
 	}
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return 0;
 }
 
-- 
2.40.1

