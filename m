Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3F51F149
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiEHUfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiEHUfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4A410DA
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vhj5dyAvBi2vnnYXBQVdBQQ6HBrdGJDWlN4F5I/avk8=; b=SCxSBMVkNJbAyvY7QxW1rmJYmd
        WBr4gf0gpsMQl3O9kPRnxDXmqpwNAfflGBtrSvlx1VYgAr/ixN+KRCnuCuI2s1WOi7AUT8iw0sPO/
        rAPu7k2kF2biI8loVdnO6WzVeApkgoCqmNYxfeSfRwydbrVBF4HgJEux2jBnlRpaNqSxsHRqIreb9
        a7I9/c+mvmh4PqWiQ+0NbNQSG2iMVpS7ayR9LXxTxz9FyebyUvZ9boiPQhhxVpI5no68yyC4TX2ej
        PcyO8+TXsEA6gx8QGSEe/5ndc7KY8IrlS5y02WsZaRyJEs4v35RwBWUan5pPq/zfM8AjoIaGPcnM0
        fQ8Je40Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ2-002nn3-Sa; Sun, 08 May 2022 20:31:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/37] fs: Add read_folio documentation
Date:   Sun,  8 May 2022 21:30:56 +0100
Message-Id: <20220508203131.667959-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

Convert all the ->readpage documentation to ->read_folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/fscrypt.rst       |  2 +-
 Documentation/filesystems/fsverity.rst      |  2 +-
 Documentation/filesystems/locking.rst       | 10 +++++-----
 Documentation/filesystems/netfs_library.rst |  8 ++++----
 Documentation/filesystems/vfs.rst           | 20 ++++++++++----------
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 6ccd5efb25b7..2e9aaa295125 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1256,7 +1256,7 @@ inline encryption hardware will encrypt/decrypt the file contents.
 When inline encryption isn't used, filesystems must encrypt/decrypt
 the file contents themselves, as described below:
 
-For the read path (->readpage()) of regular files, filesystems can
+For the read path (->read_folio()) of regular files, filesystems can
 read the ciphertext into the page cache and decrypt it in-place.  The
 page lock must be held until decryption has finished, to prevent the
 page from becoming visible to userspace prematurely.
diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 8cc536d08f51..36290530e194 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -548,7 +548,7 @@ already verified).  Below, we describe how filesystems implement this.
 Pagecache
 ~~~~~~~~~
 
-For filesystems using Linux's pagecache, the ``->readpage()`` and
+For filesystems using Linux's pagecache, the ``->read_folio()`` and
 ``->readahead()`` methods must be modified to verify pages before they
 are marked Uptodate.  Merely hooking ``->read_iter()`` would be
 insufficient, since ``->read_iter()`` is not used for memory maps.
diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index fd9d9caf09ab..aeba2475a53c 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -237,7 +237,7 @@ address_space_operations
 prototypes::
 
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
+	int (*read_folio)(struct file *, struct folio *);
 	int (*writepages)(struct address_space *, struct writeback_control *);
 	bool (*dirty_folio)(struct address_space *, struct folio *folio);
 	void (*readahead)(struct readahead_control *);
@@ -268,7 +268,7 @@ locking rules:
 ops			PageLocked(page)	 i_rwsem	invalidate_lock
 ======================	======================== =========	===============
 writepage:		yes, unlocks (see below)
-readpage:		yes, unlocks				shared
+read_folio:		yes, unlocks				shared
 writepages:
 dirty_folio		maybe
 readahead:		yes, unlocks				shared
@@ -289,13 +289,13 @@ swap_activate:		no
 swap_deactivate:	no
 ======================	======================== =========	===============
 
-->write_begin(), ->write_end() and ->readpage() may be called from
+->write_begin(), ->write_end() and ->read_folio() may be called from
 the request handler (/dev/loop).
 
-->readpage() unlocks the page, either synchronously or via I/O
+->read_folio() unlocks the folio, either synchronously or via I/O
 completion.
 
-->readahead() unlocks the pages that I/O is attempted on like ->readpage().
+->readahead() unlocks the folios that I/O is attempted on like ->read_folio().
 
 ->writepage() is used for two purposes: for "memory cleansing" and for
 "sync".  These are quite different operations and the behaviour may differ
diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index d51c2a5ccf57..a80a59941d2f 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -96,7 +96,7 @@ attached to an inode (or NULL if fscache is disabled)::
 Buffered Read Helpers
 =====================
 
-The library provides a set of read helpers that handle the ->readpage(),
+The library provides a set of read helpers that handle the ->read_folio(),
 ->readahead() and much of the ->write_begin() VM operations and translate them
 into a common call framework.
 
@@ -136,8 +136,8 @@ Read Helper Functions
 Three read helpers are provided::
 
 	void netfs_readahead(struct readahead_control *ractl);
-	int netfs_readpage(struct file *file,
-			   struct page *page);
+	int netfs_read_folio(struct file *file,
+			   struct folio *folio);
 	int netfs_write_begin(struct file *file,
 			      struct address_space *mapping,
 			      loff_t pos,
@@ -148,7 +148,7 @@ Three read helpers are provided::
 Each corresponds to a VM address space operation.  These operations use the
 state in the per-inode context.
 
-For ->readahead() and ->readpage(), the network filesystem just point directly
+For ->readahead() and ->read_folio(), the network filesystem just point directly
 at the corresponding read helper; whereas for ->write_begin(), it may be a
 little more complicated as the network filesystem might want to flush
 conflicting writes or track dirty data and needs to put the acquired folio if
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 469882f72fc1..0919a4ad973a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -656,7 +656,7 @@ by memory-mapping the page.  Data is written into the address space by
 the application, and then written-back to storage typically in whole
 pages, however the address_space has finer control of write sizes.
 
-The read process essentially only requires 'readpage'.  The write
+The read process essentially only requires 'read_folio'.  The write
 process is more complicated and uses write_begin/write_end or
 dirty_folio to write data into the address_space, and writepage and
 writepages to writeback data to storage.
@@ -722,7 +722,7 @@ cache in your filesystem.  The following members are defined:
 
 	struct address_space_operations {
 		int (*writepage)(struct page *page, struct writeback_control *wbc);
-		int (*readpage)(struct file *, struct page *);
+		int (*read_folio)(struct file *, struct folio *);
 		int (*writepages)(struct address_space *, struct writeback_control *);
 		bool (*dirty_folio)(struct address_space *, struct folio *);
 		void (*readahead)(struct readahead_control *);
@@ -772,14 +772,14 @@ cache in your filesystem.  The following members are defined:
 
 	See the file "Locking" for more details.
 
-``readpage``
-	called by the VM to read a page from backing store.  The page
-	will be Locked when readpage is called, and should be unlocked
-	and marked uptodate once the read completes.  If ->readpage
-	discovers that it needs to unlock the page for some reason, it
-	can do so, and then return AOP_TRUNCATED_PAGE.  In this case,
-	the page will be relocated, relocked and if that all succeeds,
-	->readpage will be called again.
+``read_folio``
+	called by the VM to read a folio from backing store.  The folio
+	will be locked when read_folio is called, and should be unlocked
+	and marked uptodate once the read completes.  If ->read_folio
+	discovers that it cannot perform the I/O at this time, it can
+        unlock the folio and return AOP_TRUNCATED_PAGE.  In this case,
+	the folio will be looked up again, relocked and if that all succeeds,
+	->read_folio will be called again.
 
 ``writepages``
 	called by the VM to write out pages associated with the
-- 
2.34.1

