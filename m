Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A67A58DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjISEwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjISEvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB47B123;
        Mon, 18 Sep 2023 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eD9qeqLIAE6j0vOOrRLuvTWmaHXtpk57wthTjNsTMno=; b=peOzT/gXR0NZxtHy2NkqTZ6cwi
        hGA3cJ8jI4qvkbcPnElLxuoeNequmIu2zB71bwHg/qaef83CY7m8fXsuDyn+oQLiRVgDxn4217aRW
        CIrDiW30qHHbVOi6M4kEbNFvqsRqcoYdKEMD6VBI39VtCVzyXYtiz72xA5AKoYY+vV+6w85WHt4ud
        u8h1C/+GwMPuQSed+I+Oh6uqLL/OO/Y4AAgFEtH8kH8zRdegjle7H+nodil+0STSKwqWjvXVzG7+P
        WLUViJHG4uIiGDRfvqPS/AVCsnrxW5Px77OfJvxBDw+7kgZLMpWVBsXOkmVgL7ZleAtSbPm36zPJ5
        DQ4VZt5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi5-00FFmO-7E; Tue, 19 Sep 2023 04:51:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 23/26] ufs: Use ufs_get_locked_folio() in ufs_alloc_lastblock()
Date:   Tue, 19 Sep 2023 05:51:32 +0100
Message-Id: <20230919045135.3635437-24-willy@infradead.org>
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

Switch to the folio APIs, saving one folio->page->folio conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/inode.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 21a4779a2de5..5b289374d4fd 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1057,7 +1057,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	unsigned i, end;
 	sector_t lastfrag;
-	struct page *lastpage;
+	struct folio *folio;
 	struct buffer_head *bh;
 	u64 phys64;
 
@@ -1068,18 +1068,17 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 
 	lastfrag--;
 
-	lastpage = ufs_get_locked_page(mapping, lastfrag >>
+	folio = ufs_get_locked_folio(mapping, lastfrag >>
 				       (PAGE_SHIFT - inode->i_blkbits));
-       if (IS_ERR(lastpage)) {
-               err = -EIO;
-               goto out;
-       }
-
-       end = lastfrag & ((1 << (PAGE_SHIFT - inode->i_blkbits)) - 1);
-       bh = page_buffers(lastpage);
-       for (i = 0; i < end; ++i)
-               bh = bh->b_this_page;
+	if (IS_ERR(folio)) {
+		err = -EIO;
+		goto out;
+	}
 
+	end = lastfrag & ((1 << (PAGE_SHIFT - inode->i_blkbits)) - 1);
+	bh = folio_buffers(folio);
+	for (i = 0; i < end; ++i)
+		bh = bh->b_this_page;
 
        err = ufs_getfrag_block(inode, lastfrag, bh, 1);
 
@@ -1095,7 +1094,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 		*/
 	       set_buffer_uptodate(bh);
 	       mark_buffer_dirty(bh);
-	       set_page_dirty(lastpage);
+		folio_mark_dirty(folio);
        }
 
        if (lastfrag >= UFS_IND_FRAGMENT) {
@@ -1113,7 +1112,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 	       }
        }
 out_unlock:
-       ufs_put_locked_page(lastpage);
+       ufs_put_locked_folio(folio);
 out:
        return err;
 }
-- 
2.40.1

