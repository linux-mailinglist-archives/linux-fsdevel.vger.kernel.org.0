Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C507A58E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjISEwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjISEvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3344E13A;
        Mon, 18 Sep 2023 21:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KTqAHAx4qqR4Q7lC+S6uqhCRiwzNekbkPxfVngkIgDU=; b=AU5Z4AMyf6mpWfFk9NA31PWFC5
        Tk+/Pyt5xDRXP/Taop02KykNz9y2fANjDGQo+2O8yWE8MAlmRELgS+f0CfR/jYdYHN6NFURRAjeEH
        GQiTWmhg2dqfIdmIkTNlegKupk6QYJ/p0ivqAScVOihZ3z28I/rpbKUSRIRcCXRrHrSVNbWSP4Vts
        aihO5zsN3wRKtWQ3wK6HJL9ILP9rJEGPKa9xdpxVX2PtUg+V+AWMMHTnIH0UFZOOLV8qG73SsoHCo
        +lnV6FSOsmKOFtEcGrNE1rYEosO3mtftsKn0BM3GTJWT+O452u3k6tbWzyBBZR103V2BXE2ZHodbY
        /frRETPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi5-00FFme-Eb; Tue, 19 Sep 2023 04:51:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 25/26] ufs: Remove ufs_get_locked_page()
Date:   Tue, 19 Sep 2023 05:51:34 +0100
Message-Id: <20230919045135.3635437-26-willy@infradead.org>
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

Both callers are now converted to ufs_get_locked_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/util.c | 9 ---------
 fs/ufs/util.h | 7 -------
 2 files changed, 16 deletions(-)

diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 151b400cb3b6..d32de30009a0 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -229,15 +229,6 @@ ufs_set_inode_dev(struct super_block *sb, struct ufs_inode_info *ufsi, dev_t dev
 		ufsi->i_u1.i_data[0] = cpu_to_fs32(sb, fs32);
 }
 
-struct page *ufs_get_locked_page(struct address_space *mapping, pgoff_t index)
-{
-	struct folio *folio = ufs_get_locked_folio(mapping, index);
-
-	if (folio)
-		return folio_file_page(folio, index);
-	return NULL;
-}
-
 /**
  * ufs_get_locked_folio() - locate, pin and lock a pagecache folio, if not exist
  * read it from disk.
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 62542561d150..0ecd2ed792f5 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -273,7 +273,6 @@ extern void _ubh_ubhcpymem_(struct ufs_sb_private_info *, unsigned char *, struc
 extern void _ubh_memcpyubh_(struct ufs_sb_private_info *, struct ufs_buffer_head *, unsigned char *, unsigned);
 
 /* This functions works with cache pages*/
-struct page *ufs_get_locked_page(struct address_space *mapping, pgoff_t index);
 struct folio *ufs_get_locked_folio(struct address_space *mapping, pgoff_t index);
 static inline void ufs_put_locked_folio(struct folio *folio)
 {
@@ -281,12 +280,6 @@ static inline void ufs_put_locked_folio(struct folio *folio)
        folio_put(folio);
 }
 
-static inline void ufs_put_locked_page(struct page *page)
-{
-	ufs_put_locked_folio(page_folio(page));
-}
-
-
 /*
  * macros and inline function to get important structures from ufs_sb_private_info
  */
-- 
2.40.1

