Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D47F4AFE31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiBIUWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiBIUWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E938FE040C91
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SRYoqvrIpSg9s+ghn0K+5wl96YKSFh7gcWFosoSSqLo=; b=ceApqczwQQDkIeqJtIdnhoD8o4
        99Ns3wzEJRyjvoaG6jlr64ZFe7+nwYdUZKazMdxZLixbxoRq9dUaPvy7erxUE/nnehKygHY6BvPn9
        QQZql2s/dng/pKVbk8OH6ycbRTOvAs/m8OsUgic/urCVj/Gos6LKYL3eiTSCddn4SJg0f7Nuqg/gv
        e/RYc29eUklJAbgFSUv/UdIttrf+8rMorpjRk9mAp7R4CR3IFPgiytW1NqdWH/SHqAbnSZJG5rK42
        f3708Prv0esBUt4e6tuQMLn7zu3D73vXliqrtaJ7y4FJRZrizjdb+SZyCg/EOV/TRrgaGNjl8pvN8
        QJKxLlSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTs-008cpt-90; Wed, 09 Feb 2022 20:22:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 13/56] fs: Add invalidate_folio() aops method
Date:   Wed,  9 Feb 2022 20:21:32 +0000
Message-Id: <20220209202215.2055748-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is used in preference to invalidatepage, if defined.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst | 13 +++++++------
 Documentation/filesystems/vfs.rst     | 11 ++++++-----
 include/linux/fs.h                    |  1 +
 mm/truncate.c                         |  8 +++++++-
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 88b33524687f..29a045fd3860 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -250,6 +250,7 @@ prototypes::
 				loff_t pos, unsigned len, unsigned copied,
 				struct page *page, void *fsdata);
 	sector_t (*bmap)(struct address_space *, sector_t);
+	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
 	int (*releasepage) (struct page *, int);
 	void (*freepage)(struct page *);
@@ -278,6 +279,7 @@ readpages:		no					shared
 write_begin:		locks the page		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
+invalidate_folio:	yes					exclusive
 invalidatepage:		yes					exclusive
 releasepage:		yes
 freepage:		yes
@@ -370,13 +372,12 @@ not locked.
 filesystems and by the swapper. The latter will eventually go away.  Please,
 keep it that way and don't breed new callers.
 
-->invalidatepage() is called when the filesystem must attempt to drop
+->invalidate_folio() is called when the filesystem must attempt to drop
 some or all of the buffers from the page when it is being truncated. It
-returns zero on success. If ->invalidatepage is zero, the kernel uses
-block_invalidatepage() instead. The filesystem must exclusively acquire
-invalidate_lock before invalidating page cache in truncate / hole punch path
-(and thus calling into ->invalidatepage) to block races between page cache
-invalidation and page cache filling functions (fault, read, ...).
+returns zero on success.  The filesystem must exclusively acquire
+invalidate_lock before invalidating page cache in truncate / hole punch
+path (and thus calling into ->invalidate_folio) to block races between page
+cache invalidation and page cache filling functions (fault, read, ...).
 
 ->releasepage() is called when the kernel is about to try to drop the
 buffers from the page in preparation for freeing it.  It returns zero to
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index da3e7b470f0a..26c090cd8cf5 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -735,6 +735,7 @@ cache in your filesystem.  The following members are defined:
 				 loff_t pos, unsigned len, unsigned copied,
 				 struct page *page, void *fsdata);
 		sector_t (*bmap)(struct address_space *, sector_t);
+		void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 		void (*invalidatepage) (struct page *, unsigned int, unsigned int);
 		int (*releasepage) (struct page *, int);
 		void (*freepage)(struct page *);
@@ -868,15 +869,15 @@ cache in your filesystem.  The following members are defined:
 	to find out where the blocks in the file are and uses those
 	addresses directly.
 
-``invalidatepage``
-	If a page has PagePrivate set, then invalidatepage will be
-	called when part or all of the page is to be removed from the
+``invalidate_folio``
+	If a folio has private data, then invalidate_folio will be
+	called when part or all of the folio is to be removed from the
 	address space.  This generally corresponds to either a
 	truncation, punch hole or a complete invalidation of the address
 	space (in the latter case 'offset' will always be 0 and 'length'
-	will be PAGE_SIZE).  Any private data associated with the page
+	will be folio_size()).  Any private data associated with the page
 	should be updated to reflect this truncation.  If offset is 0
-	and length is PAGE_SIZE, then the private data should be
+	and length is folio_size(), then the private data should be
 	released, because the page must be able to be completely
 	discarded.  This may be done by calling the ->releasepage
 	function, but in this case the release MUST succeed.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5939e6694ada..bcdb613cd652 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -387,6 +387,7 @@ struct address_space_operations {
 
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
+	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
 	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
 	int (*releasepage) (struct page *, gfp_t);
 	void (*freepage)(struct page *);
diff --git a/mm/truncate.c b/mm/truncate.c
index aa0ed373789d..b9ad298e6ce7 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -154,9 +154,15 @@ static int invalidate_exceptional_entry2(struct address_space *mapping,
  */
 void folio_invalidate(struct folio *folio, size_t offset, size_t length)
 {
+	const struct address_space_operations *aops = folio->mapping->a_ops;
 	void (*invalidatepage)(struct page *, unsigned int, unsigned int);
 
-	invalidatepage = folio->mapping->a_ops->invalidatepage;
+	if (aops->invalidate_folio) {
+		aops->invalidate_folio(folio, offset, length);
+		return;
+	}
+
+	invalidatepage = aops->invalidatepage;
 #ifdef CONFIG_BLOCK
 	if (!invalidatepage)
 		invalidatepage = block_invalidatepage;
-- 
2.34.1

