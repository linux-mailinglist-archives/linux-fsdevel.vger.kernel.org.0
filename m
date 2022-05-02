Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EAE516A77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383366AbiEBF7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 01:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357907AbiEBF7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:59:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A11FA45
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NH2eGenjXj1rlaDJW/FLfeLdWqYbzYTliIRehd8wui4=; b=VuDiCwmZlYw7L445T3isKBmzfC
        utVHDSvhTp8vc/yiNem0GkWN6Y9ymutsHEkRRFu7Ct6MWz8rwSk30U1imWhbDLUMmURb6FTX+SweL
        +pnIN9AH/YL0Lvw7+7CqqCihooe8a4YIfLKYauITLcT1hitZSUqi+BqBZJuY/nquJLMH+uY8Q8iAj
        2qkh2Dfvymn1ihhTTCrmoKcPshu00dimh8tvzMff2J8BgNSIJ6TncOh+rLwlrb3YEL8Tphv6P46BS
        by27F4WdEkGbFJnosTj0DaEJZmdPi6pHR2Jc5jeMxE4RthJlkdVz/YZZeeuJ0EhorB0Gk/zWCkYiT
        dxPEvd3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2e-00EZVR-UL; Mon, 02 May 2022 05:56:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/26] fs: Add aops->release_folio
Date:   Mon,  2 May 2022 06:55:49 +0100
Message-Id: <20220502055614.3473032-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

This replaces aops->releasepage.  Update the documentation, and call it
if it exists.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 .../filesystems/caching/netfs-api.rst         |  4 +-
 Documentation/filesystems/locking.rst         | 14 +++---
 Documentation/filesystems/vfs.rst             | 45 +++++++++----------
 include/linux/fs.h                            |  1 +
 mm/filemap.c                                  |  2 +
 5 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/Documentation/filesystems/caching/netfs-api.rst b/Documentation/filesystems/caching/netfs-api.rst
index 7308d76a29dc..1d18e9def183 100644
--- a/Documentation/filesystems/caching/netfs-api.rst
+++ b/Documentation/filesystems/caching/netfs-api.rst
@@ -433,11 +433,11 @@ has done a write and then the page it wrote from has been released by the VM,
 after which it *has* to look in the cache.
 
 To inform fscache that a page might now be in the cache, the following function
-should be called from the ``releasepage`` address space op::
+should be called from the ``release_folio`` address space op::
 
 	void fscache_note_page_release(struct fscache_cookie *cookie);
 
-if the page has been released (ie. releasepage returned true).
+if the page has been released (ie. release_folio returned true).
 
 Page release and page invalidation should also wait for any mark left on the
 page to say that a DIO write is underway from that page::
diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index aeba2475a53c..2a295bb72dbc 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -249,7 +249,7 @@ prototypes::
 				struct page *page, void *fsdata);
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
-	int (*releasepage) (struct page *, int);
+	int (*release_folio)(struct folio *, gfp_t);
 	void (*freepage)(struct page *);
 	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	bool (*isolate_page) (struct page *, isolate_mode_t);
@@ -270,13 +270,13 @@ ops			PageLocked(page)	 i_rwsem	invalidate_lock
 writepage:		yes, unlocks (see below)
 read_folio:		yes, unlocks				shared
 writepages:
-dirty_folio		maybe
+dirty_folio:		maybe
 readahead:		yes, unlocks				shared
 write_begin:		locks the page		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
 invalidate_folio:	yes					exclusive
-releasepage:		yes
+release_folio:		yes
 freepage:		yes
 direct_IO:
 isolate_page:		yes
@@ -372,10 +372,10 @@ invalidate_lock before invalidating page cache in truncate / hole punch
 path (and thus calling into ->invalidate_folio) to block races between page
 cache invalidation and page cache filling functions (fault, read, ...).
 
-->releasepage() is called when the kernel is about to try to drop the
-buffers from the page in preparation for freeing it.  It returns zero to
-indicate that the buffers are (or may be) freeable.  If ->releasepage is zero,
-the kernel assumes that the fs has no private interest in the buffers.
+->release_folio() is called when the kernel is about to try to drop the
+buffers from the folio in preparation for freeing it.  It returns false to
+indicate that the buffers are (or may be) freeable.  If ->release_folio is
+NULL, the kernel assumes that the fs has no private interest in the buffers.
 
 ->freepage() is called when the kernel is done dropping the page
 from the page cache.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 0919a4ad973a..679887b5c8fc 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -620,9 +620,9 @@ Writeback.
 The first can be used independently to the others.  The VM can try to
 either write dirty pages in order to clean them, or release clean pages
 in order to reuse them.  To do this it can call the ->writepage method
-on dirty pages, and ->releasepage on clean pages with PagePrivate set.
-Clean pages without PagePrivate and with no external references will be
-released without notice being given to the address_space.
+on dirty pages, and ->release_folio on clean folios with the private
+flag set.  Clean pages without PagePrivate and with no external references
+will be released without notice being given to the address_space.
 
 To achieve this functionality, pages need to be placed on an LRU with
 lru_cache_add and mark_page_active needs to be called whenever the page
@@ -734,7 +734,7 @@ cache in your filesystem.  The following members are defined:
 				 struct page *page, void *fsdata);
 		sector_t (*bmap)(struct address_space *, sector_t);
 		void (*invalidate_folio) (struct folio *, size_t start, size_t len);
-		int (*releasepage) (struct page *, int);
+		bool (*release_folio)(struct folio *, gfp_t);
 		void (*freepage)(struct page *);
 		ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 		/* isolate a page for migration */
@@ -864,33 +864,32 @@ cache in your filesystem.  The following members are defined:
 	address space.  This generally corresponds to either a
 	truncation, punch hole or a complete invalidation of the address
 	space (in the latter case 'offset' will always be 0 and 'length'
-	will be folio_size()).  Any private data associated with the page
+	will be folio_size()).  Any private data associated with the folio
 	should be updated to reflect this truncation.  If offset is 0
 	and length is folio_size(), then the private data should be
-	released, because the page must be able to be completely
-	discarded.  This may be done by calling the ->releasepage
+	released, because the folio must be able to be completely
+	discarded.  This may be done by calling the ->release_folio
 	function, but in this case the release MUST succeed.
 
-``releasepage``
-	releasepage is called on PagePrivate pages to indicate that the
-	page should be freed if possible.  ->releasepage should remove
-	any private data from the page and clear the PagePrivate flag.
-	If releasepage() fails for some reason, it must indicate failure
-	with a 0 return value.  releasepage() is used in two distinct
-	though related cases.  The first is when the VM finds a clean
-	page with no active users and wants to make it a free page.  If
-	->releasepage succeeds, the page will be removed from the
-	address_space and become free.
+``release_folio``
+	release_folio is called on folios with private data to tell the
+	filesystem that the folio is about to be freed.  ->release_folio
+	should remove any private data from the folio and clear the
+	private flag.  If release_folio() fails, it should return false.
+	release_folio() is used in two distinct though related cases.
+	The first is when the VM wants to free a clean folio with no
+	active users.  If ->release_folio succeeds, the folio will be
+	removed from the address_space and be freed.
 
 	The second case is when a request has been made to invalidate
-	some or all pages in an address_space.  This can happen through
-	the fadvise(POSIX_FADV_DONTNEED) system call or by the
-	filesystem explicitly requesting it as nfs and 9fs do (when they
+	some or all folios in an address_space.  This can happen
+	through the fadvise(POSIX_FADV_DONTNEED) system call or by the
+	filesystem explicitly requesting it as nfs and 9p do (when they
 	believe the cache may be out of date with storage) by calling
 	invalidate_inode_pages2().  If the filesystem makes such a call,
-	and needs to be certain that all pages are invalidated, then its
-	releasepage will need to ensure this.  Possibly it can clear the
-	PageUptodate bit if it cannot free private data yet.
+	and needs to be certain that all folios are invalidated, then
+	its release_folio will need to ensure this.  Possibly it can
+	clear the uptodate flag if it cannot free private data yet.
 
 ``freepage``
 	freepage is called once the page is no longer visible in the
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f812f5aa07dd..ad768f13f485 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -355,6 +355,7 @@ struct address_space_operations {
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
+	bool (*release_folio)(struct folio *, gfp_t);
 	int (*releasepage) (struct page *, gfp_t);
 	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
diff --git a/mm/filemap.c b/mm/filemap.c
index 81a0ed08a82c..40df5704ec39 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3956,6 +3956,8 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 	if (folio_test_writeback(folio))
 		return false;
 
+	if (mapping && mapping->a_ops->release_folio)
+		return mapping->a_ops->release_folio(folio, gfp);
 	if (mapping && mapping->a_ops->releasepage)
 		return mapping->a_ops->releasepage(&folio->page, gfp);
 	return try_to_free_buffers(&folio->page);
-- 
2.34.1

