Return-Path: <linux-fsdevel+bounces-43433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B373A56994
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C4C189A621
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F1A21C9F3;
	Fri,  7 Mar 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A+/9m6Uf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE82721ADCC
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355660; cv=none; b=FbQXGDlKDLhGh22rMSlqMC3woNIKnKv3Vrfqor/tTCAJ8Hv3SuH9VDPMSLwN69txjOusVMrN2fDd2RqKExOEfVvUFKTNr7orDc+404BovQ7elMLcharIqOq37L4tyRdtFe6UtJv2bh3AlPywAnXIAjUzL4Gba8uPe8MPUNKAT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355660; c=relaxed/simple;
	bh=WqoaqK2220wbPMR0PQQxeQPvHneXugzNLcOobGh4Hdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3Z3JgoagvrTsogPNIs8CFhW8PpyDSD+5B4z8BIfRdvqyFjWRUGNuQyMh2pHuVRYdDncafpmTlCjw8pMQvgdPmSyJqr0XO3plGnQz9sH1rkTc5tojp37LXfe7qjYiqWO0MhncBhd1XmL2Ev8A6ckkDmipWU+zzsr68hH/n9p5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A+/9m6Uf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pdDoc31AYz0Km57d074XqJjBHjWG/S2bDrTdZj34V7Q=; b=A+/9m6Uf/a+/tD6ztG/rZziHTP
	1IhO34O6I+2P9dHhsoJUSaiFTqJvVQErwuOhcDXs7smfJSUIAOygBiQnmSES621ruuCzYVJxtGcNt
	otnKlNBCo7ctzuILAzwBysZMP3EdKPP6NURSiBiRnUhttHxO+wFmtI/oc5J3DDOQKsAZVkcniQsT9
	4YqNtJciRDA+t9qcI7yJIqppkvig2G5Lfi40TYXscb/abn1sQbuVUQua+NpFFVIAlg1bC5eZ2kRhs
	BF1z/shsY8506ppED+xZwWSwNZS9iVcjAch9aDECHL00YohPBTYLFduomT3iilEYAQtT04Gck63oq
	V6kKqb1A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9Y-0000000CXGv-3vgY;
	Fri, 07 Mar 2025 13:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] fs: Remove aops->writepage
Date: Fri,  7 Mar 2025 13:54:11 +0000
Message-ID: <20250307135414.2987755-12-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers and implementations are now removed, so remove the operation
and update the documentation to match.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  2 +-
 Documentation/filesystems/fscrypt.rst   |  2 +-
 Documentation/filesystems/locking.rst   | 54 +------------------------
 Documentation/filesystems/vfs.rst       | 39 +++++-------------
 fs/buffer.c                             |  4 +-
 include/linux/fs.h                      |  1 -
 mm/vmscan.c                             |  1 -
 7 files changed, 15 insertions(+), 88 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 77d80a7e975b..4e10b4084381 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -3028,7 +3028,7 @@ Filesystem Support for Writeback
 --------------------------------
 
 A filesystem can support cgroup writeback by updating
-address_space_operations->writepage[s]() to annotate bio's using the
+address_space_operations->writepages() to annotate bio's using the
 following two functions.
 
   wbc_init_bio(@wbc, @bio)
diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index e80329908549..3d22e2db732d 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1409,7 +1409,7 @@ read the ciphertext into the page cache and decrypt it in-place.  The
 folio lock must be held until decryption has finished, to prevent the
 folio from becoming visible to userspace prematurely.
 
-For the write path (->writepage()) of regular files, filesystems
+For the write path (->writepages()) of regular files, filesystems
 cannot encrypt data in-place in the page cache, since the cached
 plaintext must be preserved.  Instead, filesystems must encrypt into a
 temporary buffer or "bounce page", then write out the temporary
diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 0ec0bb6eb0fb..2e567e341c3b 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -249,7 +249,6 @@ address_space_operations
 ========================
 prototypes::
 
-	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*read_folio)(struct file *, struct folio *);
 	int (*writepages)(struct address_space *, struct writeback_control *);
 	bool (*dirty_folio)(struct address_space *, struct folio *folio);
@@ -280,7 +279,6 @@ locking rules:
 ======================	======================== =========	===============
 ops			folio locked		 i_rwsem	invalidate_lock
 ======================	======================== =========	===============
-writepage:		yes, unlocks (see below)
 read_folio:		yes, unlocks				shared
 writepages:
 dirty_folio:		maybe
@@ -309,54 +307,6 @@ completion.
 
 ->readahead() unlocks the folios that I/O is attempted on like ->read_folio().
 
-->writepage() is used for two purposes: for "memory cleansing" and for
-"sync".  These are quite different operations and the behaviour may differ
-depending upon the mode.
-
-If writepage is called for sync (wbc->sync_mode != WBC_SYNC_NONE) then
-it *must* start I/O against the page, even if that would involve
-blocking on in-progress I/O.
-
-If writepage is called for memory cleansing (sync_mode ==
-WBC_SYNC_NONE) then its role is to get as much writeout underway as
-possible.  So writepage should try to avoid blocking against
-currently-in-progress I/O.
-
-If the filesystem is not called for "sync" and it determines that it
-would need to block against in-progress I/O to be able to start new I/O
-against the page the filesystem should redirty the page with
-redirty_page_for_writepage(), then unlock the page and return zero.
-This may also be done to avoid internal deadlocks, but rarely.
-
-If the filesystem is called for sync then it must wait on any
-in-progress I/O and then start new I/O.
-
-The filesystem should unlock the page synchronously, before returning to the
-caller, unless ->writepage() returns special WRITEPAGE_ACTIVATE
-value. WRITEPAGE_ACTIVATE means that page cannot really be written out
-currently, and VM should stop calling ->writepage() on this page for some
-time. VM does this by moving page to the head of the active list, hence the
-name.
-
-Unless the filesystem is going to redirty_page_for_writepage(), unlock the page
-and return zero, writepage *must* run set_page_writeback() against the page,
-followed by unlocking it.  Once set_page_writeback() has been run against the
-page, write I/O can be submitted and the write I/O completion handler must run
-end_page_writeback() once the I/O is complete.  If no I/O is submitted, the
-filesystem must run end_page_writeback() against the page before returning from
-writepage.
-
-That is: after 2.5.12, pages which are under writeout are *not* locked.  Note,
-if the filesystem needs the page to be locked during writeout, that is ok, too,
-the page is allowed to be unlocked at any point in time between the calls to
-set_page_writeback() and end_page_writeback().
-
-Note, failure to run either redirty_page_for_writepage() or the combination of
-set_page_writeback()/end_page_writeback() on a page submitted to writepage
-will leave the page itself marked clean but it will be tagged as dirty in the
-radix tree.  This incoherency can lead to all sorts of hard-to-debug problems
-in the filesystem like having dirty inodes at umount and losing written data.
-
 ->writepages() is used for periodic writeback and for syscall-initiated
 sync operations.  The address_space should start I/O against at least
 ``*nr_to_write`` pages.  ``*nr_to_write`` must be decremented for each page
@@ -364,8 +314,8 @@ which is written.  The address_space implementation may write more (or less)
 pages than ``*nr_to_write`` asks for, but it should try to be reasonably close.
 If nr_to_write is NULL, all dirty pages must be written.
 
-writepages should _only_ write pages which are present on
-mapping->io_pages.
+writepages should _only_ write pages which are present in
+mapping->i_pages.
 
 ->dirty_folio() is called from various places in the kernel when
 the target folio is marked as needing writeback.  The folio cannot be
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ae79c30b6c0c..f66a4e706b17 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -716,9 +716,8 @@ page lookup by address, and keeping track of pages tagged as Dirty or
 Writeback.
 
 The first can be used independently to the others.  The VM can try to
-either write dirty pages in order to clean them, or release clean pages
-in order to reuse them.  To do this it can call the ->writepage method
-on dirty pages, and ->release_folio on clean folios with the private
+release clean pages in order to reuse them.  To do this it can call 
+->release_folio on clean folios with the private
 flag set.  Clean pages without PagePrivate and with no external references
 will be released without notice being given to the address_space.
 
@@ -731,8 +730,8 @@ maintains information about the PG_Dirty and PG_Writeback status of each
 page, so that pages with either of these flags can be found quickly.
 
 The Dirty tag is primarily used by mpage_writepages - the default
-->writepages method.  It uses the tag to find dirty pages to call
-->writepage on.  If mpage_writepages is not used (i.e. the address
+->writepages method.  It uses the tag to find dirty pages to
+write back.  If mpage_writepages is not used (i.e. the address
 provides its own ->writepages) , the PAGECACHE_TAG_DIRTY tag is almost
 unused.  write_inode_now and sync_inode do use it (through
 __sync_single_inode) to check if ->writepages has been successful in
@@ -756,23 +755,23 @@ pages, however the address_space has finer control of write sizes.
 
 The read process essentially only requires 'read_folio'.  The write
 process is more complicated and uses write_begin/write_end or
-dirty_folio to write data into the address_space, and writepage and
+dirty_folio to write data into the address_space, and
 writepages to writeback data to storage.
 
 Adding and removing pages to/from an address_space is protected by the
 inode's i_mutex.
 
 When data is written to a page, the PG_Dirty flag should be set.  It
-typically remains set until writepage asks for it to be written.  This
+typically remains set until writepages asks for it to be written.  This
 should clear PG_Dirty and set PG_Writeback.  It can be actually written
 at any point after PG_Dirty is clear.  Once it is known to be safe,
 PG_Writeback is cleared.
 
 Writeback makes use of a writeback_control structure to direct the
-operations.  This gives the writepage and writepages operations some
+operations.  This gives the writepages operation some
 information about the nature of and reason for the writeback request,
 and the constraints under which it is being done.  It is also used to
-return information back to the caller about the result of a writepage or
+return information back to the caller about the result of a
 writepages request.
 
 
@@ -819,7 +818,6 @@ cache in your filesystem.  The following members are defined:
 .. code-block:: c
 
 	struct address_space_operations {
-		int (*writepage)(struct page *page, struct writeback_control *wbc);
 		int (*read_folio)(struct file *, struct folio *);
 		int (*writepages)(struct address_space *, struct writeback_control *);
 		bool (*dirty_folio)(struct address_space *, struct folio *);
@@ -848,25 +846,6 @@ cache in your filesystem.  The following members are defined:
 		int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 	};
 
-``writepage``
-	called by the VM to write a dirty page to backing store.  This
-	may happen for data integrity reasons (i.e. 'sync'), or to free
-	up memory (flush).  The difference can be seen in
-	wbc->sync_mode.  The PG_Dirty flag has been cleared and
-	PageLocked is true.  writepage should start writeout, should set
-	PG_Writeback, and should make sure the page is unlocked, either
-	synchronously or asynchronously when the write operation
-	completes.
-
-	If wbc->sync_mode is WB_SYNC_NONE, ->writepage doesn't have to
-	try too hard if there are problems, and may choose to write out
-	other pages from the mapping if that is easier (e.g. due to
-	internal dependencies).  If it chooses not to start writeout, it
-	should return AOP_WRITEPAGE_ACTIVATE so that the VM will not
-	keep calling ->writepage on that page.
-
-	See the file "Locking" for more details.
-
 ``read_folio``
 	Called by the page cache to read a folio from the backing store.
 	The 'file' argument supplies authentication information to network
@@ -909,7 +888,7 @@ cache in your filesystem.  The following members are defined:
 	given and that many pages should be written if possible.  If no
 	->writepages is given, then mpage_writepages is used instead.
 	This will choose pages from the address space that are tagged as
-	DIRTY and will pass them to ->writepage.
+	DIRTY and will write them back.
 
 ``dirty_folio``
 	called by the VM to mark a folio as dirty.  This is particularly
diff --git a/fs/buffer.c b/fs/buffer.c
index c7abb4a029dc..b99dc69dba37 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2695,7 +2695,7 @@ int block_truncate_page(struct address_space *mapping,
 EXPORT_SYMBOL(block_truncate_page);
 
 /*
- * The generic ->writepage function for buffer-backed address_spaces
+ * The generic write folio function for buffer-backed address_spaces
  */
 int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
 		void *get_block)
@@ -2715,7 +2715,7 @@ int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
 
 	/*
 	 * The folio straddles i_size.  It must be zeroed out on each and every
-	 * writepage invocation because it may be mmapped.  "A file is mapped
+	 * writeback invocation because it may be mmapped.  "A file is mapped
 	 * in multiples of the page size.  For a file that is not a multiple of
 	 * the page size, the remaining memory is zeroed when mapped, and
 	 * writes to that region are not written out to the file."
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 110d95d04299..26ce65c4a003 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -433,7 +433,6 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
 }
 
 struct address_space_operations {
-	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*read_folio)(struct file *, struct folio *);
 
 	/* Write back some dirty pages from this mapping. */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e9f84fa31b9a..7e79ca975c9d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -643,7 +643,6 @@ typedef enum {
 
 /*
  * pageout is called by shrink_folio_list() for each dirty folio.
- * Calls ->writepage().
  */
 static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 			 struct swap_iocb **plug, struct list_head *folio_list)
-- 
2.47.2


