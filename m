Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E703D3D1004
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhGUNGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238762AbhGUNFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i721gV0aIu0rvLexN0pBqMbwBbkKzEhWVB3KEf7BlKk=;
        b=fjSJTgr714BYvtBpuw/fi8+jODXPkrOa2yvTDy1xsbURRnrCGe1gCtSGPHsPP5uFe++sOM
        uQl8LlvAzuyQzEDvxrLHisPh16DS6p1xEjfFHcSA9Iz6s653BnhTjKhayeovdNvGmQYf6X
        wAaN995DfHofJUBm3OsrcPAArEd5I8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-KrkAGfI-N4-Yedd1kx3LBQ-1; Wed, 21 Jul 2021 09:46:15 -0400
X-MC-Unique: KrkAGfI-N4-Yedd1kx3LBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B59C93920;
        Wed, 21 Jul 2021 13:46:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E905A6EF4F;
        Wed, 21 Jul 2021 13:46:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 06/12] netfs: Keep lists of pending, active,
 dirty and flushed regions
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 14:46:08 +0100
Message-ID: <162687516812.276387.504081062999158040.stgit@warthog.procyon.org.uk>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This looks nice, in theory, and has the following features:

 (*) Things are managed with write records.

     (-) A WRITE is a region defined by an outer bounding box that spans
         the pages that are involved and an inner region that contains the
         actual modifications.

     (-) The bounding box must encompass all the data that will be
     	 necessary to perform a write operation to the server (for example,
     	 if we want to encrypt with a 64K block size when we have 4K
     	 pages).

 (*) There are four list of write records:

     (-) The PENDING LIST holds writes that are blocked by another active
     	 write.  This list is in order of submission to avoid starvation
     	 and may overlap.

     (-) The ACTIVE LIST holds writes that have been granted exclusive
     	 access to a patch.  This is in order of starting position and
     	 regions held therein may not overlap.

     (-) The DIRTY LIST holds a list of regions that have been modified.
     	 This is also in order of starting position and regions may not
     	 overlap, though they can be merged.

     (-) The FLUSH LIST holds a list of regions that require writing.  This
     	 is in order of grouping.

 (*) An active region acts as an exclusion zone on part of the range,
     allowing the inode sem to be dropped once the region is on a list.

     (-) A DIO write creates its own exclusive region that must not overlap
         with any other dirty region.

     (-) An active write may overlap one or more dirty regions.

     (-) A dirty region may be overlapped by one or more writes.

     (-) If an active write overlaps with an incompatible dirty region,
     	 that region gets flushed, the active write has to wait for it to
     	 complete.

 (*) When an active write completes, the region is inserted or merged into
     the dirty list.

     (-) Merging can only happen between compatible regions.

     (-) Contiguous dirty regions can be merged.

     (-) If an inode has all new content, generated locally, dirty regions
         that have contiguous/ovelapping bounding boxes can be merged,
         bridging any gaps with zeros.

     (-) O_DSYNC causes the region to be flushed immediately.

 (*) There's a queue of groups of regions and those regions must be flushed
     in order.

     (-) If a region in a group needs flushing, then all prior groups must
     	 be flushed first.


TRICKY BITS
===========

 (*) The active and dirty lists are O(n) search time.  An interval tree
     might be a better option.

 (*) Having four list_heads is a lot of memory per inode.

 (*) Activating pending writes.

     (-) The pending list can contain a bunch of writes that can overlap.

     (-) When an active write completes, it is removed from the active
     	 queue and usually added to the dirty queue (except DIO, DSYNC).
     	 This makes a hole.

     (-) One or more pending writes can then be moved over, but care has to
     	 be taken not to misorder them to avoid starvation.

     (-) When a pending write is added to the active list, it may require
     	 part of the dirty list to be flushed.

 (*) A write that has been put onto the active queue may have to wait for
     flushing to complete.

 (*) How should an active write interact with a dirty region?

     (-) A dirty region may get flushed even whilst it is being modified on
         the assumption that the active write record will get added to the
         dirty list and cause a follow up write to the server.

 (*) RAM pinning.

     (-) An active write could pin a lot of pages, thereby causing a large
     	 write to run the system out of RAM.

     (-) Allow active writes to start being flushed whilst still being
     	 modified.

     (-) Use a scheduler hook to decant the modified portion into the dirty
     	 list when the modifying task is switched away from?

 (*) Bounding box and variably-sized pages/folios.

     (-) The bounding box needs to be rounded out to the page boundaries so
     	 that DIO writes can claim exclusivity on a series of pages so that
     	 they can be invalidated.

     (-) Allocation of higher-order folios could be limited in scope so
     	 that they don't escape the requested bounding box.

     (-) Bounding boxes could be enlarged to allow for larger folios.

     (-) Overlarge bounding boxes can be shrunk later, possibly on merging
     	 into the dirty list.

     (-) Ordinary writes can have overlapping bounding boxes, even if
     	 they're otherwise incompatible.
---

 fs/afs/file.c                |   30 +
 fs/afs/internal.h            |    7 
 fs/afs/write.c               |  166 --------
 fs/netfs/Makefile            |    8 
 fs/netfs/dio_helper.c        |  140 ++++++
 fs/netfs/internal.h          |   32 +
 fs/netfs/objects.c           |  113 +++++
 fs/netfs/read_helper.c       |   94 ++++
 fs/netfs/stats.c             |    5 
 fs/netfs/write_helper.c      |  908 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h        |   98 +++++
 include/trace/events/netfs.h |  180 ++++++++
 12 files changed, 1604 insertions(+), 177 deletions(-)
 create mode 100644 fs/netfs/dio_helper.c
 create mode 100644 fs/netfs/objects.c
 create mode 100644 fs/netfs/write_helper.c

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 1861e4ecc2ce..8400cdf086b6 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -30,7 +30,7 @@ const struct file_operations afs_file_operations = {
 	.release	= afs_release,
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
-	.write_iter	= afs_file_write,
+	.write_iter	= netfs_file_write_iter,
 	.mmap		= afs_file_mmap,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
@@ -53,8 +53,6 @@ const struct address_space_operations afs_file_aops = {
 	.releasepage	= afs_releasepage,
 	.invalidatepage	= afs_invalidatepage,
 	.direct_IO	= afs_direct_IO,
-	.write_begin	= afs_write_begin,
-	.write_end	= afs_write_end,
 	.writepage	= afs_writepage,
 	.writepages	= afs_writepages,
 };
@@ -370,12 +368,38 @@ static void afs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
 	key_put(netfs_priv);
 }
 
+static void afs_init_dirty_region(struct netfs_dirty_region *region, struct file *file)
+{
+	region->netfs_priv = key_get(afs_file_key(file));
+}
+
+static void afs_free_dirty_region(struct netfs_dirty_region *region)
+{
+	key_put(region->netfs_priv);
+}
+
+static void afs_update_i_size(struct file *file, loff_t new_i_size)
+{
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
+	loff_t i_size;
+
+	write_seqlock(&vnode->cb_lock);
+	i_size = i_size_read(&vnode->vfs_inode);
+	if (new_i_size > i_size)
+		i_size_write(&vnode->vfs_inode, new_i_size);
+	write_sequnlock(&vnode->cb_lock);
+	fscache_update_cookie(afs_vnode_cache(vnode), NULL, &new_i_size);
+}
+
 const struct netfs_request_ops afs_req_ops = {
 	.init_rreq		= afs_init_rreq,
 	.begin_cache_operation	= afs_begin_cache_operation,
 	.check_write_begin	= afs_check_write_begin,
 	.issue_op		= afs_req_issue_op,
 	.cleanup		= afs_priv_cleanup,
+	.init_dirty_region	= afs_init_dirty_region,
+	.free_dirty_region	= afs_free_dirty_region,
+	.update_i_size		= afs_update_i_size,
 };
 
 int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e0204dde4b50..0d01ed2fe8fa 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1511,15 +1511,8 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
  * write.c
  */
 extern int afs_set_page_dirty(struct page *);
-extern int afs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
-			struct page **pagep, void **fsdata);
-extern int afs_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata);
 extern int afs_writepage(struct page *, struct writeback_control *);
 extern int afs_writepages(struct address_space *, struct writeback_control *);
-extern ssize_t afs_file_write(struct kiocb *, struct iov_iter *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
 extern void afs_prune_wb_keys(struct afs_vnode *);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index a244187f3503..e6e2e924c8ae 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -27,152 +27,6 @@ int afs_set_page_dirty(struct page *page)
 	return fscache_set_page_dirty(page, afs_vnode_cache(AFS_FS_I(page->mapping->host)));
 }
 
-/*
- * Prepare to perform part of a write to a page.  Note that len may extend
- * beyond the end of the page.
- */
-int afs_write_begin(struct file *file, struct address_space *mapping,
-		    loff_t pos, unsigned len, unsigned flags,
-		    struct page **_page, void **fsdata)
-{
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
-	struct page *page;
-	unsigned long priv;
-	unsigned f, from;
-	unsigned t, to;
-	int ret;
-
-	_enter("{%llx:%llu},%llx,%x",
-	       vnode->fid.vid, vnode->fid.vnode, pos, len);
-
-	/* Prefetch area to be written into the cache if we're caching this
-	 * file.  We need to do this before we get a lock on the page in case
-	 * there's more than one writer competing for the same cache block.
-	 */
-	ret = netfs_write_begin(file, mapping, pos, len, flags, &page, fsdata);
-	if (ret < 0)
-		return ret;
-
-	from = offset_in_thp(page, pos);
-	len = min_t(size_t, len, thp_size(page) - from);
-	to = from + len;
-
-try_again:
-	/* See if this page is already partially written in a way that we can
-	 * merge the new write with.
-	 */
-	if (PagePrivate(page)) {
-		priv = page_private(page);
-		f = afs_page_dirty_from(page, priv);
-		t = afs_page_dirty_to(page, priv);
-		ASSERTCMP(f, <=, t);
-
-		if (PageWriteback(page)) {
-			trace_afs_page_dirty(vnode, tracepoint_string("alrdy"), page);
-			goto flush_conflicting_write;
-		}
-		/* If the file is being filled locally, allow inter-write
-		 * spaces to be merged into writes.  If it's not, only write
-		 * back what the user gives us.
-		 */
-		if (!test_bit(NETFS_ICTX_NEW_CONTENT, &vnode->netfs_ctx.flags) &&
-		    (to < f || from > t))
-			goto flush_conflicting_write;
-	}
-
-	*_page = find_subpage(page, pos / PAGE_SIZE);
-	_leave(" = 0");
-	return 0;
-
-	/* The previous write and this write aren't adjacent or overlapping, so
-	 * flush the page out.
-	 */
-flush_conflicting_write:
-	_debug("flush conflict");
-	ret = write_one_page(page);
-	if (ret < 0)
-		goto error;
-
-	ret = lock_page_killable(page);
-	if (ret < 0)
-		goto error;
-	goto try_again;
-
-error:
-	put_page(page);
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * Finalise part of a write to a page.  Note that len may extend beyond the end
- * of the page.
- */
-int afs_write_end(struct file *file, struct address_space *mapping,
-		  loff_t pos, unsigned len, unsigned copied,
-		  struct page *subpage, void *fsdata)
-{
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
-	struct page *page = thp_head(subpage);
-	unsigned long priv;
-	unsigned int f, from = offset_in_thp(page, pos);
-	unsigned int t, to = from + copied;
-	loff_t i_size, write_end_pos;
-
-	_enter("{%llx:%llu},{%lx}",
-	       vnode->fid.vid, vnode->fid.vnode, page->index);
-
-	len = min_t(size_t, len, thp_size(page) - from);
-	if (!PageUptodate(page)) {
-		if (copied < len) {
-			copied = 0;
-			goto out;
-		}
-
-		SetPageUptodate(page);
-	}
-
-	if (copied == 0)
-		goto out;
-
-	write_end_pos = pos + copied;
-
-	i_size = i_size_read(&vnode->vfs_inode);
-	if (write_end_pos > i_size) {
-		write_seqlock(&vnode->cb_lock);
-		i_size = i_size_read(&vnode->vfs_inode);
-		if (write_end_pos > i_size)
-			i_size_write(&vnode->vfs_inode, write_end_pos);
-		write_sequnlock(&vnode->cb_lock);
-		fscache_update_cookie(afs_vnode_cache(vnode), NULL, &write_end_pos);
-	}
-
-	if (PagePrivate(page)) {
-		priv = page_private(page);
-		f = afs_page_dirty_from(page, priv);
-		t = afs_page_dirty_to(page, priv);
-		if (from < f)
-			f = from;
-		if (to > t)
-			t = to;
-		priv = afs_page_dirty(page, f, t);
-		set_page_private(page, priv);
-		trace_afs_page_dirty(vnode, tracepoint_string("dirty+"), page);
-	} else {
-		priv = afs_page_dirty(page, from, to);
-		attach_page_private(page, (void *)priv);
-		trace_afs_page_dirty(vnode, tracepoint_string("dirty"), page);
-	}
-
-	if (set_page_dirty(page))
-		_debug("dirtied %lx", page->index);
-
-out:
-	unlock_page(page);
-	put_page(page);
-	return copied;
-}
-
 /*
  * kill all the pages in the given range
  */
@@ -812,26 +666,6 @@ int afs_writepages(struct address_space *mapping,
 	return ret;
 }
 
-/*
- * write to an AFS file
- */
-ssize_t afs_file_write(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(iocb->ki_filp));
-	size_t count = iov_iter_count(from);
-
-	_enter("{%llx:%llu},{%zu},",
-	       vnode->fid.vid, vnode->fid.vnode, count);
-
-	if (IS_SWAPFILE(&vnode->vfs_inode)) {
-		printk(KERN_INFO
-		       "AFS: Attempt to write to active swap file!\n");
-		return -EBUSY;
-	}
-
-	return generic_file_write_iter(iocb, from);
-}
-
 /*
  * flush any dirty pages for this process, and check for write errors.
  * - the return status from this call provides a reliable indication of
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index c15bfc966d96..3e11453ad2c5 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -1,5 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
-netfs-y := read_helper.o stats.o
+netfs-y := \
+	objects.o \
+	read_helper.o \
+	write_helper.o
+# dio_helper.o
+
+netfs-$(CONFIG_NETFS_STATS) += stats.o
 
 obj-$(CONFIG_NETFS_SUPPORT) := netfs.o
diff --git a/fs/netfs/dio_helper.c b/fs/netfs/dio_helper.c
new file mode 100644
index 000000000000..3072de344601
--- /dev/null
+++ b/fs/netfs/dio_helper.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem high-level DIO support.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/sched/mm.h>
+#include <linux/backing-dev.h>
+#include <linux/task_io_accounting_ops.h>
+#include <linux/netfs.h>
+#include "internal.h"
+#include <trace/events/netfs.h>
+
+/*
+ * Perform a direct I/O write to a netfs server.
+ */
+ssize_t netfs_file_direct_write(struct netfs_dirty_region *region,
+				struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file	*file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	struct inode	*inode = mapping->host;
+	loff_t		pos = iocb->ki_pos, last;
+	ssize_t		written;
+	size_t		write_len;
+	pgoff_t		end;
+	int		ret;
+
+	write_len = iov_iter_count(from);
+	last = pos + write_len - 1;
+	end = to >> PAGE_SHIFT;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		/* If there are pages to writeback, return */
+		if (filemap_range_has_page(file->f_mapping, pos, last))
+			return -EAGAIN;
+	} else {
+		ret = filemap_write_and_wait_range(mapping, pos, last);
+		if (ret)
+			return ret;
+	}
+
+	/* After a write we want buffered reads to be sure to go to disk to get
+	 * the new data.  We invalidate clean cached page from the region we're
+	 * about to write.  We do this *before* the write so that we can return
+	 * without clobbering -EIOCBQUEUED from ->direct_IO().
+	 */
+	ret = invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT, end);
+	if (ret) {
+		/* If the page can't be invalidated, return 0 to fall back to
+		 * buffered write.
+		 */
+		return ret == -EBUSY ? 0 : ret;
+	}
+
+	written = mapping->a_ops->direct_IO(iocb, from);
+
+	/* Finally, try again to invalidate clean pages which might have been
+	 * cached by non-direct readahead, or faulted in by get_user_pages()
+	 * if the source of the write was an mmap'ed region of the file
+	 * we're writing.  Either one is a pretty crazy thing to do,
+	 * so we don't support it 100%.  If this invalidation
+	 * fails, tough, the write still worked...
+	 *
+	 * Most of the time we do not need this since dio_complete() will do
+	 * the invalidation for us. However there are some file systems that
+	 * do not end up with dio_complete() being called, so let's not break
+	 * them by removing it completely.
+	 *
+	 * Noticeable example is a blkdev_direct_IO().
+	 *
+	 * Skip invalidation for async writes or if mapping has no pages.
+	 */
+	if (written > 0 && mapping->nrpages &&
+	    invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT, end))
+		dio_warn_stale_pagecache(file);
+
+	if (written > 0) {
+		pos += written;
+		write_len -= written;
+		if (pos > i_size_read(inode) && !S_ISBLK(inode->i_mode)) {
+			i_size_write(inode, pos);
+			mark_inode_dirty(inode);
+		}
+		iocb->ki_pos = pos;
+	}
+	if (written != -EIOCBQUEUED)
+		iov_iter_revert(from, write_len - iov_iter_count(from));
+out:
+#if 0
+			/*
+		 * If the write stopped short of completing, fall back to
+		 * buffered writes.  Some filesystems do this for writes to
+		 * holes, for example.  For DAX files, a buffered write will
+		 * not succeed (even if it did, DAX does not handle dirty
+		 * page-cache pages correctly).
+		 */
+		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
+			goto out;
+
+		status = netfs_perform_write(region, file, from, pos = iocb->ki_pos);
+		/*
+		 * If generic_perform_write() returned a synchronous error
+		 * then we want to return the number of bytes which were
+		 * direct-written, or the error code if that was zero.  Note
+		 * that this differs from normal direct-io semantics, which
+		 * will return -EFOO even if some bytes were written.
+		 */
+		if (unlikely(status < 0)) {
+			err = status;
+			goto out;
+		}
+		/*
+		 * We need to ensure that the page cache pages are written to
+		 * disk and invalidated to preserve the expected O_DIRECT
+		 * semantics.
+		 */
+		endbyte = pos + status - 1;
+		err = filemap_write_and_wait_range(mapping, pos, endbyte);
+		if (err == 0) {
+			iocb->ki_pos = endbyte + 1;
+			written += status;
+			invalidate_mapping_pages(mapping,
+						 pos >> PAGE_SHIFT,
+						 endbyte >> PAGE_SHIFT);
+		} else {
+			/*
+			 * We don't know how much we wrote, so just return
+			 * the number of bytes which were direct-written
+			 */
+		}
+#endif
+	return written;
+}
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 4805d9fc8808..77ceab694348 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -15,11 +15,41 @@
 
 #define pr_fmt(fmt) "netfs: " fmt
 
+/*
+ * dio_helper.c
+ */
+ssize_t netfs_file_direct_write(struct netfs_dirty_region *region,
+				struct kiocb *iocb, struct iov_iter *from);
+
+/*
+ * objects.c
+ */
+struct netfs_flush_group *netfs_get_flush_group(struct netfs_flush_group *group);
+void netfs_put_flush_group(struct netfs_flush_group *group);
+struct netfs_dirty_region *netfs_alloc_dirty_region(void);
+struct netfs_dirty_region *netfs_get_dirty_region(struct netfs_i_context *ctx,
+						  struct netfs_dirty_region *region,
+						  enum netfs_region_trace what);
+void netfs_free_dirty_region(struct netfs_i_context *ctx, struct netfs_dirty_region *region);
+void netfs_put_dirty_region(struct netfs_i_context *ctx,
+			    struct netfs_dirty_region *region,
+			    enum netfs_region_trace what);
+
 /*
  * read_helper.c
  */
 extern unsigned int netfs_debug;
 
+int netfs_prefetch_for_write(struct file *file, struct page *page, loff_t pos, size_t len,
+			     bool always_fill);
+
+/*
+ * write_helper.c
+ */
+void netfs_flush_region(struct netfs_i_context *ctx,
+			struct netfs_dirty_region *region,
+			enum netfs_dirty_trace why);
+
 /*
  * stats.c
  */
@@ -42,6 +72,8 @@ extern atomic_t netfs_n_rh_write_begin;
 extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
+extern atomic_t netfs_n_wh_region;
+extern atomic_t netfs_n_wh_flush_group;
 
 
 static inline void netfs_stat(atomic_t *stat)
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
new file mode 100644
index 000000000000..ba1e052aa352
--- /dev/null
+++ b/fs/netfs/objects.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Object lifetime handling and tracing.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/backing-dev.h>
+#include "internal.h"
+
+/**
+ * netfs_new_flush_group - Create a new write flush group
+ * @inode: The inode for which this is a flush group.
+ * @netfs_priv: Netfs private data to include in the new group
+ *
+ * Create a new flush group and add it to the tail of the inode's group list.
+ * Flush groups are used to control the order in which dirty data is written
+ * back to the server.
+ *
+ * The caller must hold ctx->lock.
+ */
+struct netfs_flush_group *netfs_new_flush_group(struct inode *inode, void *netfs_priv)
+{
+	struct netfs_flush_group *group;
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	if (group) {
+		group->netfs_priv = netfs_priv;
+		INIT_LIST_HEAD(&group->region_list);
+		refcount_set(&group->ref, 1);
+		netfs_stat(&netfs_n_wh_flush_group);
+		list_add_tail(&group->group_link, &ctx->flush_groups);
+	}
+	return group;
+}
+EXPORT_SYMBOL(netfs_new_flush_group);
+
+struct netfs_flush_group *netfs_get_flush_group(struct netfs_flush_group *group)
+{
+	refcount_inc(&group->ref);
+	return group;
+}
+
+void netfs_put_flush_group(struct netfs_flush_group *group)
+{
+	if (group && refcount_dec_and_test(&group->ref)) {
+		netfs_stat_d(&netfs_n_wh_flush_group);
+		kfree(group);
+	}
+}
+
+struct netfs_dirty_region *netfs_alloc_dirty_region(void)
+{
+	struct netfs_dirty_region *region;
+
+	region = kzalloc(sizeof(struct netfs_dirty_region), GFP_KERNEL);
+	if (region)
+		netfs_stat(&netfs_n_wh_region);
+	return region;
+}
+
+struct netfs_dirty_region *netfs_get_dirty_region(struct netfs_i_context *ctx,
+						  struct netfs_dirty_region *region,
+						  enum netfs_region_trace what)
+{
+	int ref;
+
+	__refcount_inc(&region->ref, &ref);
+	trace_netfs_ref_region(region->debug_id, ref + 1, what);
+	return region;
+}
+
+void netfs_free_dirty_region(struct netfs_i_context *ctx,
+			     struct netfs_dirty_region *region)
+{
+	if (region) {
+		trace_netfs_ref_region(region->debug_id, 0, netfs_region_trace_free);
+		if (ctx->ops->free_dirty_region)
+			ctx->ops->free_dirty_region(region);
+		netfs_put_flush_group(region->group);
+		netfs_stat_d(&netfs_n_wh_region);
+		kfree(region);
+	}
+}
+
+void netfs_put_dirty_region(struct netfs_i_context *ctx,
+			    struct netfs_dirty_region *region,
+			    enum netfs_region_trace what)
+{
+	bool dead;
+	int ref;
+
+	if (!region)
+		return;
+	dead = __refcount_dec_and_test(&region->ref, &ref);
+	trace_netfs_ref_region(region->debug_id, ref - 1, what);
+	if (dead) {
+		if (!list_empty(&region->active_link) ||
+		    !list_empty(&region->dirty_link)) {
+			spin_lock(&ctx->lock);
+			list_del_init(&region->active_link);
+			list_del_init(&region->dirty_link);
+			spin_unlock(&ctx->lock);
+		}
+		netfs_free_dirty_region(ctx, region);
+	}
+}
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index aa98ecf6df6b..bfcdbbd32f4c 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1321,3 +1321,97 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	return ret;
 }
 EXPORT_SYMBOL(netfs_write_begin);
+
+/*
+ * Preload the data into a page we're proposing to write into.
+ */
+int netfs_prefetch_for_write(struct file *file, struct page *page,
+			     loff_t pos, size_t len, bool always_fill)
+{
+	struct address_space *mapping = page_file_mapping(page);
+	struct netfs_read_request *rreq;
+	struct netfs_i_context *ctx = netfs_i_context(mapping->host);
+	struct page *xpage;
+	unsigned int debug_index = 0;
+	int ret;
+
+	DEFINE_READAHEAD(ractl, file, NULL, mapping, page_index(page));
+
+	/* If the page is beyond the EOF, we want to clear it - unless it's
+	 * within the cache granule containing the EOF, in which case we need
+	 * to preload the granule.
+	 */
+	if (!netfs_is_cache_enabled(mapping->host)) {
+		if (netfs_skip_page_read(page, pos, len, always_fill)) {
+			netfs_stat(&netfs_n_rh_write_zskip);
+			ret = 0;
+			goto error;
+		}
+	}
+
+	ret = -ENOMEM;
+	rreq = netfs_alloc_read_request(mapping, file);
+	if (!rreq)
+		goto error;
+	rreq->start		= page_offset(page);
+	rreq->len		= thp_size(page);
+	rreq->no_unlock_page	= page_file_offset(page);
+	__set_bit(NETFS_RREQ_NO_UNLOCK_PAGE, &rreq->flags);
+
+	if (ctx->ops->begin_cache_operation) {
+		ret = ctx->ops->begin_cache_operation(rreq);
+		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
+			goto error_put;
+	}
+
+	netfs_stat(&netfs_n_rh_write_begin);
+	trace_netfs_read(rreq, pos, len, netfs_read_trace_prefetch_for_write);
+
+	/* Expand the request to meet caching requirements and download
+	 * preferences.
+	 */
+	ractl._nr_pages = thp_nr_pages(page);
+	netfs_rreq_expand(rreq, &ractl);
+
+	/* Set up the output buffer */
+	ret = netfs_rreq_set_up_buffer(rreq, &ractl, page,
+				       readahead_index(&ractl), readahead_count(&ractl));
+	if (ret < 0) {
+		while ((xpage = readahead_page(&ractl)))
+			if (xpage != page)
+				put_page(xpage);
+		goto error_put;
+	}
+
+	netfs_get_read_request(rreq);
+	atomic_set(&rreq->nr_rd_ops, 1);
+	do {
+		if (!netfs_rreq_submit_slice(rreq, &debug_index))
+			break;
+
+	} while (rreq->submitted < rreq->len);
+
+	/* Keep nr_rd_ops incremented so that the ref always belongs to us, and
+	 * the service code isn't punted off to a random thread pool to
+	 * process.
+	 */
+	for (;;) {
+		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) == 1);
+		netfs_rreq_assess(rreq, false);
+		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
+			break;
+		cond_resched();
+	}
+
+	ret = rreq->error;
+	if (ret == 0 && rreq->submitted < rreq->len) {
+		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_write_begin);
+		ret = -EIO;
+	}
+
+error_put:
+	netfs_put_read_request(rreq, false);
+error:
+	_leave(" = %d", ret);
+	return ret;
+}
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 5510a7a14a40..7c079ca47b5b 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -27,6 +27,8 @@ atomic_t netfs_n_rh_write_begin;
 atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
+atomic_t netfs_n_wh_region;
+atomic_t netfs_n_wh_flush_group;
 
 void netfs_stats_show(struct seq_file *m)
 {
@@ -54,5 +56,8 @@ void netfs_stats_show(struct seq_file *m)
 		   atomic_read(&netfs_n_rh_write),
 		   atomic_read(&netfs_n_rh_write_done),
 		   atomic_read(&netfs_n_rh_write_failed));
+	seq_printf(m, "WrHelp : R=%u F=%u\n",
+		   atomic_read(&netfs_n_wh_region),
+		   atomic_read(&netfs_n_wh_flush_group));
 }
 EXPORT_SYMBOL(netfs_stats_show);
diff --git a/fs/netfs/write_helper.c b/fs/netfs/write_helper.c
new file mode 100644
index 000000000000..a8c58eaa84d0
--- /dev/null
+++ b/fs/netfs/write_helper.c
@@ -0,0 +1,908 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem high-level write support.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/backing-dev.h>
+#include "internal.h"
+
+static atomic_t netfs_region_debug_ids;
+
+static bool __overlaps(loff_t start1, loff_t end1, loff_t start2, loff_t end2)
+{
+	return (start1 < start2) ? end1 > start2 : end2 > start1;
+}
+
+static bool overlaps(struct netfs_range *a, struct netfs_range *b)
+{
+	return __overlaps(a->start, a->end, b->start, b->end);
+}
+
+static int wait_on_region(struct netfs_dirty_region *region,
+			  enum netfs_region_state state)
+{
+	return wait_var_event_interruptible(&region->state,
+					    READ_ONCE(region->state) >= state);
+}
+
+/*
+ * Grab a page for writing.  We don't lock it at this point as we have yet to
+ * preemptively trigger a fault-in - but we need to know how large the page
+ * will be before we try that.
+ */
+static struct page *netfs_grab_page_for_write(struct address_space *mapping,
+					      loff_t pos, size_t len_remaining)
+{
+	struct page *page;
+	int fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT;
+
+	page = pagecache_get_page(mapping, pos >> PAGE_SHIFT, fgp_flags,
+				  mapping_gfp_mask(mapping));
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+	wait_for_stable_page(page);
+	return page;
+}
+
+/*
+ * Initialise a new dirty page group.  The caller is responsible for setting
+ * the type and any flags that they want.
+ */
+static void netfs_init_dirty_region(struct netfs_dirty_region *region,
+				    struct inode *inode, struct file *file,
+				    enum netfs_region_type type,
+				    unsigned long flags,
+				    loff_t start, loff_t end)
+{
+	struct netfs_flush_group *group;
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+
+	region->state		= NETFS_REGION_IS_PENDING;
+	region->type		= type;
+	region->flags		= flags;
+	region->reserved.start	= start;
+	region->reserved.end	= end;
+	region->dirty.start	= start;
+	region->dirty.end	= start;
+	region->bounds.start	= round_down(start, ctx->bsize);
+	region->bounds.end	= round_up(end, ctx->bsize);
+	region->i_size		= i_size_read(inode);
+	region->debug_id	= atomic_inc_return(&netfs_region_debug_ids);
+	INIT_LIST_HEAD(&region->active_link);
+	INIT_LIST_HEAD(&region->dirty_link);
+	INIT_LIST_HEAD(&region->flush_link);
+	refcount_set(&region->ref, 1);
+	spin_lock_init(&region->lock);
+	if (file && ctx->ops->init_dirty_region)
+		ctx->ops->init_dirty_region(region, file);
+	if (!region->group) {
+		group = list_last_entry(&ctx->flush_groups,
+					struct netfs_flush_group, group_link);
+		region->group = netfs_get_flush_group(group);
+		list_add_tail(&region->flush_link, &group->region_list);
+	}
+	trace_netfs_ref_region(region->debug_id, 1, netfs_region_trace_new);
+	trace_netfs_dirty(ctx, region, NULL, netfs_dirty_trace_new);
+}
+
+/*
+ * Queue a region for flushing.  Regions may need to be flushed in the right
+ * order (e.g. ceph snaps) and so we may need to chuck other regions onto the
+ * flush queue first.
+ *
+ * The caller must hold ctx->lock.
+ */
+void netfs_flush_region(struct netfs_i_context *ctx,
+			struct netfs_dirty_region *region,
+			enum netfs_dirty_trace why)
+{
+	struct netfs_flush_group *group;
+
+	LIST_HEAD(flush_queue);
+
+	kenter("%x", region->debug_id);
+
+	if (test_bit(NETFS_REGION_FLUSH_Q, &region->flags) ||
+	    region->group->flush)
+		return;
+
+	trace_netfs_dirty(ctx, region, NULL, why);
+
+	/* If the region isn't in the bottom flush group, we need to flush out
+	 * all of the flush groups below it.
+	 */
+	while (!list_is_first(&region->group->group_link, &ctx->flush_groups)) {
+		group = list_first_entry(&ctx->flush_groups,
+					 struct netfs_flush_group, group_link);
+		group->flush = true;
+		list_del_init(&group->group_link);
+		list_splice_tail_init(&group->region_list, &ctx->flush_queue);
+		netfs_put_flush_group(group);
+	}
+
+	set_bit(NETFS_REGION_FLUSH_Q, &region->flags);
+	list_move_tail(&region->flush_link, &ctx->flush_queue);
+}
+
+/*
+ * Decide if/how a write can be merged with a dirty region.
+ */
+static enum netfs_write_compatibility netfs_write_compatibility(
+	struct netfs_i_context *ctx,
+	struct netfs_dirty_region *old,
+	struct netfs_dirty_region *candidate)
+{
+	if (old->type == NETFS_REGION_DIO ||
+	    old->type == NETFS_REGION_DSYNC ||
+	    old->state >= NETFS_REGION_IS_FLUSHING ||
+	    /* The bounding boxes of DSYNC writes can overlap with those of
+	     * other DSYNC writes and ordinary writes.
+	     */
+	    candidate->group != old->group ||
+	    old->group->flush)
+		return NETFS_WRITES_INCOMPATIBLE;
+	if (!ctx->ops->is_write_compatible) {
+		if (candidate->type == NETFS_REGION_DSYNC)
+			return NETFS_WRITES_SUPERSEDE;
+		return NETFS_WRITES_COMPATIBLE;
+	}
+	return ctx->ops->is_write_compatible(ctx, old, candidate);
+}
+
+/*
+ * Split a dirty region.
+ */
+static struct netfs_dirty_region *netfs_split_dirty_region(
+	struct netfs_i_context *ctx,
+	struct netfs_dirty_region *region,
+	struct netfs_dirty_region **spare,
+	unsigned long long pos)
+{
+	struct netfs_dirty_region *tail = *spare;
+
+	*spare = NULL;
+	*tail = *region;
+	region->dirty.end = pos;
+	tail->dirty.start = pos;
+	tail->debug_id = atomic_inc_return(&netfs_region_debug_ids);
+
+	refcount_set(&tail->ref, 1);
+	INIT_LIST_HEAD(&tail->active_link);
+	netfs_get_flush_group(tail->group);
+	spin_lock_init(&tail->lock);
+	// TODO: grab cache resources
+
+	// need to split the bounding box?
+	__set_bit(NETFS_REGION_SUPERSEDED, &tail->flags);
+	if (ctx->ops->split_dirty_region)
+		ctx->ops->split_dirty_region(tail);
+	list_add(&tail->dirty_link, &region->dirty_link);
+	list_add(&tail->flush_link, &region->flush_link);
+	trace_netfs_dirty(ctx, tail, region, netfs_dirty_trace_split);
+	return tail;
+}
+
+/*
+ * Queue a write for access to the pagecache.  The caller must hold ctx->lock.
+ * The NETFS_REGION_PENDING flag will be cleared when it's possible to proceed.
+ */
+static void netfs_queue_write(struct netfs_i_context *ctx,
+			      struct netfs_dirty_region *candidate)
+{
+	struct netfs_dirty_region *r;
+	struct list_head *p;
+
+	/* We must wait for any overlapping pending writes */
+	list_for_each_entry(r, &ctx->pending_writes, active_link) {
+		if (overlaps(&candidate->bounds, &r->bounds)) {
+			if (overlaps(&candidate->reserved, &r->reserved) ||
+			    netfs_write_compatibility(ctx, r, candidate) ==
+			    NETFS_WRITES_INCOMPATIBLE)
+				goto add_to_pending_queue;
+		}
+	}
+
+	/* We mustn't let the request overlap with the reservation of any other
+	 * active writes, though it can overlap with a bounding box if the
+	 * writes are compatible.
+	 */
+	list_for_each(p, &ctx->active_writes) {
+		r = list_entry(p, struct netfs_dirty_region, active_link);
+		if (r->bounds.end <= candidate->bounds.start)
+			continue;
+		if (r->bounds.start >= candidate->bounds.end)
+			break;
+		if (overlaps(&candidate->bounds, &r->bounds)) {
+			if (overlaps(&candidate->reserved, &r->reserved) ||
+			    netfs_write_compatibility(ctx, r, candidate) ==
+			    NETFS_WRITES_INCOMPATIBLE)
+				goto add_to_pending_queue;
+		}
+	}
+
+	/* We can install the record in the active list to reserve our slot */
+	list_add(&candidate->active_link, p);
+
+	/* Okay, we've reserved our slot in the active queue */
+	smp_store_release(&candidate->state, NETFS_REGION_IS_RESERVED);
+	trace_netfs_dirty(ctx, candidate, NULL, netfs_dirty_trace_reserved);
+	wake_up_var(&candidate->state);
+	kleave(" [go]");
+	return;
+
+add_to_pending_queue:
+	/* We get added to the pending list and then we have to wait */
+	list_add(&candidate->active_link, &ctx->pending_writes);
+	trace_netfs_dirty(ctx, candidate, NULL, netfs_dirty_trace_wait_pend);
+	kleave(" [wait pend]");
+}
+
+/*
+ * Make sure there's a flush group.
+ */
+static int netfs_require_flush_group(struct inode *inode)
+{
+	struct netfs_flush_group *group;
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+
+	if (list_empty(&ctx->flush_groups)) {
+		kdebug("new flush group");
+		group = netfs_new_flush_group(inode, NULL);
+		if (!group)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+/*
+ * Create a dirty region record for the write we're about to do and add it to
+ * the list of regions.  We may need to wait for conflicting writes to
+ * complete.
+ */
+static struct netfs_dirty_region *netfs_prepare_region(struct inode *inode,
+						       struct file *file,
+						       loff_t start, size_t len,
+						       enum netfs_region_type type,
+						       unsigned long flags)
+{
+	struct netfs_dirty_region *candidate;
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+	loff_t end = start + len;
+	int ret;
+
+	ret = netfs_require_flush_group(inode);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	candidate = netfs_alloc_dirty_region();
+	if (!candidate)
+		return ERR_PTR(-ENOMEM);
+
+	netfs_init_dirty_region(candidate, inode, file, type, flags, start, end);
+
+	spin_lock(&ctx->lock);
+	netfs_queue_write(ctx, candidate);
+	spin_unlock(&ctx->lock);
+	return candidate;
+}
+
+/*
+ * Activate a write.  This adds it to the dirty list and does any necessary
+ * flushing and superceding there.  The caller must provide a spare region
+ * record so that we can split a dirty record if we need to supersede it.
+ */
+static void __netfs_activate_write(struct netfs_i_context *ctx,
+				   struct netfs_dirty_region *candidate,
+				   struct netfs_dirty_region **spare)
+{
+	struct netfs_dirty_region *r;
+	struct list_head *p;
+	enum netfs_write_compatibility comp;
+	bool conflicts = false;
+
+	/* See if there are any dirty regions that need flushing first. */
+	list_for_each(p, &ctx->dirty_regions) {
+		r = list_entry(p, struct netfs_dirty_region, dirty_link);
+		if (r->bounds.end <= candidate->bounds.start)
+			continue;
+		if (r->bounds.start >= candidate->bounds.end)
+			break;
+
+		if (list_empty(&candidate->dirty_link) &&
+		    r->dirty.start > candidate->dirty.start)
+			list_add_tail(&candidate->dirty_link, p);
+
+		comp = netfs_write_compatibility(ctx, r, candidate);
+		switch (comp) {
+		case NETFS_WRITES_INCOMPATIBLE:
+			netfs_flush_region(ctx, r, netfs_dirty_trace_flush_conflict);
+			conflicts = true;
+			continue;
+
+		case NETFS_WRITES_SUPERSEDE:
+			if (!overlaps(&candidate->reserved, &r->dirty))
+				continue;
+			if (r->dirty.start < candidate->dirty.start) {
+				/* The region overlaps the beginning of our
+				 * region, we split it and mark the overlapping
+				 * part as superseded.  We insert ourself
+				 * between.
+				 */
+				r = netfs_split_dirty_region(ctx, r, spare,
+							     candidate->reserved.start);
+				list_add_tail(&candidate->dirty_link, &r->dirty_link);
+				p = &r->dirty_link; /* Advance the for-loop */
+			} else  {
+				/* The region is after ours, so make sure we're
+				 * inserted before it.
+				 */
+				if (list_empty(&candidate->dirty_link))
+					list_add_tail(&candidate->dirty_link, &r->dirty_link);
+				set_bit(NETFS_REGION_SUPERSEDED, &r->flags);
+				trace_netfs_dirty(ctx, candidate, r, netfs_dirty_trace_supersedes);
+			}
+			continue;
+
+		case NETFS_WRITES_COMPATIBLE:
+			continue;
+		}
+	}
+
+	if (list_empty(&candidate->dirty_link))
+		list_add_tail(&candidate->dirty_link, p);
+	netfs_get_dirty_region(ctx, candidate, netfs_region_trace_get_dirty);
+
+	if (conflicts) {
+		/* The caller must wait for the flushes to complete. */
+		trace_netfs_dirty(ctx, candidate, NULL, netfs_dirty_trace_wait_active);
+		kleave(" [wait flush]");
+		return;
+	}
+
+	/* Okay, we're cleared to proceed. */
+	smp_store_release(&candidate->state, NETFS_REGION_IS_ACTIVE);
+	trace_netfs_dirty(ctx, candidate, NULL, netfs_dirty_trace_active);
+	wake_up_var(&candidate->state);
+	kleave(" [go]");
+	return;
+}
+
+static int netfs_activate_write(struct netfs_i_context *ctx,
+				struct netfs_dirty_region *region)
+{
+	struct netfs_dirty_region *spare;
+
+	spare = netfs_alloc_dirty_region();
+	if (!spare)
+		return -ENOMEM;
+
+	spin_lock(&ctx->lock);
+	__netfs_activate_write(ctx, region, &spare);
+	spin_unlock(&ctx->lock);
+	netfs_free_dirty_region(ctx, spare);
+	return 0;
+}
+
+/*
+ * Merge a completed active write into the list of dirty regions.  The region
+ * can be in one of a number of states:
+ *
+ * - Ordinary write, error, no data copied.		Discard.
+ * - Ordinary write, unflushed.				Dirty
+ * - Ordinary write, flush started.			Dirty
+ * - Ordinary write, completed/failed.			Discard.
+ * - DIO write,      completed/failed.			Discard.
+ * - DSYNC write, error before flush.			As ordinary.
+ * - DSYNC write, flushed in progress, EINTR.		Dirty (supersede).
+ * - DSYNC write, written to server and cache.		Dirty (supersede)/Discard.
+ * - DSYNC write, written to server but not yet cache.	Dirty.
+ *
+ * Once we've dealt with this record, we see about activating some other writes
+ * to fill the activity hole.
+ *
+ * This eats the caller's ref on the region.
+ */
+static void netfs_merge_dirty_region(struct netfs_i_context *ctx,
+				     struct netfs_dirty_region *region)
+{
+	struct netfs_dirty_region *p, *q, *front;
+	bool new_content = test_bit(NETFS_ICTX_NEW_CONTENT, &ctx->flags);
+	LIST_HEAD(graveyard);
+
+	list_del_init(&region->active_link);
+
+	switch (region->type) {
+	case NETFS_REGION_DIO:
+		list_move_tail(&region->dirty_link, &graveyard);
+		goto discard;
+
+	case NETFS_REGION_DSYNC:
+		/* A DSYNC write may have overwritten some dirty data
+		 * and caused the writeback of other dirty data.
+		 */
+		goto scan_forwards;
+
+	case NETFS_REGION_ORDINARY:
+		if (region->dirty.end == region->dirty.start) {
+			list_move_tail(&region->dirty_link, &graveyard);
+			goto discard;
+		}
+		goto scan_backwards;
+	}
+
+scan_backwards:
+	kdebug("scan_backwards");
+	/* Search backwards for a preceding record that we might be able to
+	 * merge with.  We skip over any intervening flush-in-progress records.
+	 */
+	p = front = region;
+	list_for_each_entry_continue_reverse(p, &ctx->dirty_regions, dirty_link) {
+		kdebug("- back %x", p->debug_id);
+		if (p->state >= NETFS_REGION_IS_FLUSHING)
+			continue;
+		if (p->state == NETFS_REGION_IS_ACTIVE)
+			break;
+		if (p->bounds.end < region->bounds.start)
+			break;
+		if (p->dirty.end >= region->dirty.start || new_content)
+			goto merge_backwards;
+	}
+	goto scan_forwards;
+
+merge_backwards:
+	kdebug("merge_backwards");
+	if (test_bit(NETFS_REGION_SUPERSEDED, &p->flags) ||
+	    netfs_write_compatibility(ctx, p, region) != NETFS_WRITES_COMPATIBLE)
+		goto scan_forwards;
+
+	front = p;
+	front->bounds.end = max(front->bounds.end, region->bounds.end);
+	front->dirty.end  = max(front->dirty.end,  region->dirty.end);
+	set_bit(NETFS_REGION_SUPERSEDED, &region->flags);
+	list_del_init(&region->flush_link);
+	trace_netfs_dirty(ctx, front, region, netfs_dirty_trace_merged_back);
+
+scan_forwards:
+	/* Subsume forwards any records this one covers.  There should be no
+	 * non-supersedeable incompatible regions in our range as we would have
+	 * flushed and waited for them before permitting this write to start.
+	 *
+	 * There can, however, be regions undergoing flushing which we need to
+	 * skip over and not merge with.
+	 */
+	kdebug("scan_forwards");
+	p = region;
+	list_for_each_entry_safe_continue(p, q, &ctx->dirty_regions, dirty_link) {
+		kdebug("- forw %x", p->debug_id);
+		if (p->state >= NETFS_REGION_IS_FLUSHING)
+			continue;
+		if (p->state == NETFS_REGION_IS_ACTIVE)
+			break;
+		if (p->dirty.start > region->dirty.end &&
+		    (!new_content || p->bounds.start > p->bounds.end))
+			break;
+
+		if (region->dirty.end >= p->dirty.end) {
+			/* Entirely subsumed */
+			list_move_tail(&p->dirty_link, &graveyard);
+			list_del_init(&p->flush_link);
+			trace_netfs_dirty(ctx, front, p, netfs_dirty_trace_merged_sub);
+			continue;
+		}
+
+		goto merge_forwards;
+	}
+	goto merge_complete;
+
+merge_forwards:
+	kdebug("merge_forwards");
+	if (test_bit(NETFS_REGION_SUPERSEDED, &p->flags) ||
+	    netfs_write_compatibility(ctx, p, front) == NETFS_WRITES_SUPERSEDE) {
+		/* If a region was partially superseded by us, we need to roll
+		 * it forwards and remove the superseded flag.
+		 */
+		if (p->dirty.start < front->dirty.end) {
+			p->dirty.start = front->dirty.end;
+			clear_bit(NETFS_REGION_SUPERSEDED, &p->flags);
+		}
+		trace_netfs_dirty(ctx, p, front, netfs_dirty_trace_superseded);
+		goto merge_complete;
+	}
+
+	/* Simply merge overlapping/contiguous ordinary areas together. */
+	front->bounds.end = max(front->bounds.end, p->bounds.end);
+	front->dirty.end  = max(front->dirty.end,  p->dirty.end);
+	list_move_tail(&p->dirty_link, &graveyard);
+	list_del_init(&p->flush_link);
+	trace_netfs_dirty(ctx, front, p, netfs_dirty_trace_merged_forw);
+
+merge_complete:
+	if (test_bit(NETFS_REGION_SUPERSEDED, &region->flags)) {
+		list_move_tail(&region->dirty_link, &graveyard);
+	}
+discard:
+	while (!list_empty(&graveyard)) {
+		p = list_first_entry(&graveyard, struct netfs_dirty_region, dirty_link);
+		list_del_init(&p->dirty_link);
+		smp_store_release(&p->state, NETFS_REGION_IS_COMPLETE);
+		trace_netfs_dirty(ctx, p, NULL, netfs_dirty_trace_complete);
+		wake_up_var(&p->state);
+		netfs_put_dirty_region(ctx, p, netfs_region_trace_put_merged);
+	}
+}
+
+/*
+ * Start pending writes in a window we've created by the removal of an active
+ * write.  The writes are bundled onto the given queue and it's left as an
+ * exercise for the caller to actually start them.
+ */
+static void netfs_start_pending_writes(struct netfs_i_context *ctx,
+				       struct list_head *prev_p,
+				       struct list_head *queue)
+{
+	struct netfs_dirty_region *prev = NULL, *next = NULL, *p, *q;
+	struct netfs_range window = { 0, ULLONG_MAX };
+
+	if (prev_p != &ctx->active_writes) {
+		prev = list_entry(prev_p, struct netfs_dirty_region, active_link);
+		window.start = prev->reserved.end;
+		if (!list_is_last(prev_p, &ctx->active_writes)) {
+			next = list_next_entry(prev, active_link);
+			window.end = next->reserved.start;
+		}
+	} else if (!list_empty(&ctx->active_writes)) {
+		next = list_last_entry(&ctx->active_writes,
+				       struct netfs_dirty_region, active_link);
+		window.end = next->reserved.start;
+	}
+
+	list_for_each_entry_safe(p, q, &ctx->pending_writes, active_link) {
+		bool skip = false;
+
+		if (!overlaps(&p->reserved, &window))
+			continue;
+
+		/* Narrow the window when we find a region that requires more
+		 * than we can immediately provide.  The queue is in submission
+		 * order and we need to prevent starvation.
+		 */
+		if (p->type == NETFS_REGION_DIO) {
+			if (p->bounds.start < window.start) {
+				window.start = p->bounds.start;
+				skip = true;
+			}
+			if (p->bounds.end > window.end) {
+				window.end = p->bounds.end;
+				skip = true;
+			}
+		} else {
+			if (p->reserved.start < window.start) {
+				window.start = p->reserved.start;
+				skip = true;
+			}
+			if (p->reserved.end > window.end) {
+				window.end = p->reserved.end;
+				skip = true;
+			}
+		}
+		if (window.start >= window.end)
+			break;
+		if (skip)
+			continue;
+
+		/* Okay, we have a gap that's large enough to start this write
+		 * in.  Make sure it's compatible with any region its bounds
+		 * overlap.
+		 */
+		if (prev &&
+		    p->bounds.start < prev->bounds.end &&
+		    netfs_write_compatibility(ctx, prev, p) == NETFS_WRITES_INCOMPATIBLE) {
+			window.start = max(window.start, p->bounds.end);
+			skip = true;
+		}
+
+		if (next &&
+		    p->bounds.end > next->bounds.start &&
+		    netfs_write_compatibility(ctx, next, p) == NETFS_WRITES_INCOMPATIBLE) {
+			window.end = min(window.end, p->bounds.start);
+			skip = true;
+		}
+		if (window.start >= window.end)
+			break;
+		if (skip)
+			continue;
+
+		/* Okay, we can start this write. */
+		trace_netfs_dirty(ctx, p, NULL, netfs_dirty_trace_start_pending);
+		list_move(&p->active_link,
+			  prev ? &prev->active_link : &ctx->pending_writes);
+		list_add_tail(&p->dirty_link, queue);
+		if (p->type == NETFS_REGION_DIO)
+			window.start = p->bounds.end;
+		else
+			window.start = p->reserved.end;
+		prev = p;
+	}
+}
+
+/*
+ * We completed the modification phase of a write.  We need to fix up the dirty
+ * list, remove this region from the active list and start waiters.
+ */
+static void netfs_commit_write(struct netfs_i_context *ctx,
+			       struct netfs_dirty_region *region)
+{
+	struct netfs_dirty_region *p;
+	struct list_head *prev;
+	LIST_HEAD(queue);
+
+	spin_lock(&ctx->lock);
+	smp_store_release(&region->state, NETFS_REGION_IS_DIRTY);
+	trace_netfs_dirty(ctx, region, NULL, netfs_dirty_trace_commit);
+	wake_up_var(&region->state);
+
+	prev = region->active_link.prev;
+	netfs_merge_dirty_region(ctx, region);
+	if (!list_empty(&ctx->pending_writes))
+		netfs_start_pending_writes(ctx, prev, &queue);
+	spin_unlock(&ctx->lock);
+
+	while (!list_empty(&queue)) {
+		p = list_first_entry(&queue, struct netfs_dirty_region, dirty_link);
+		list_del_init(&p->dirty_link);
+		smp_store_release(&p->state, NETFS_REGION_IS_DIRTY);
+		wake_up_var(&p->state);
+	}
+}
+
+/*
+ * Write data into a prereserved region of the pagecache attached to a netfs
+ * inode.
+ */
+static ssize_t netfs_perform_write(struct netfs_dirty_region *region,
+				   struct kiocb *iocb, struct iov_iter *i)
+{
+	struct file *file = iocb->ki_filp;
+	struct netfs_i_context *ctx = netfs_i_context(file_inode(file));
+	struct page *page;
+	ssize_t written = 0, ret;
+	loff_t new_pos, i_size;
+	bool always_fill = false;
+
+	do {
+		size_t plen;
+		size_t offset;	/* Offset into pagecache page */
+		size_t bytes;	/* Bytes to write to page */
+		size_t copied;	/* Bytes copied from user */
+		bool relock = false;
+
+		page = netfs_grab_page_for_write(file->f_mapping, region->dirty.end,
+						 iov_iter_count(i));
+		if (!page)
+			return -ENOMEM;
+
+		plen = thp_size(page);
+		offset = region->dirty.end - page_file_offset(page);
+		bytes = min_t(size_t, plen - offset, iov_iter_count(i));
+
+		kdebug("segment %zx @%zx", bytes, offset);
+
+		if (!PageUptodate(page)) {
+			unlock_page(page); /* Avoid deadlocking fault-in */
+			relock = true;
+		}
+
+		/* Bring in the user page that we will copy from _first_.
+		 * Otherwise there's a nasty deadlock on copying from the
+		 * same page as we're writing to, without it being marked
+		 * up-to-date.
+		 *
+		 * Not only is this an optimisation, but it is also required
+		 * to check that the address is actually valid, when atomic
+		 * usercopies are used, below.
+		 */
+		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
+			kdebug("fault-in");
+			ret = -EFAULT;
+			goto error_page;
+		}
+
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			goto error_page;
+		}
+
+		if (relock) {
+			ret = lock_page_killable(page);
+			if (ret < 0)
+				goto error_page;
+		}
+
+redo_prefetch:
+		/* Prefetch area to be written into the cache if we're caching
+		 * this file.  We need to do this before we get a lock on the
+		 * page in case there's more than one writer competing for the
+		 * same cache block.
+		 */
+		if (!PageUptodate(page)) {
+			ret = netfs_prefetch_for_write(file, page, region->dirty.end,
+						       bytes, always_fill);
+			kdebug("prefetch %zx", ret);
+			if (ret < 0)
+				goto error_page;
+		}
+
+		if (mapping_writably_mapped(page->mapping))
+			flush_dcache_page(page);
+		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
+		flush_dcache_page(page);
+		kdebug("copied %zx", copied);
+
+		/*  Deal with a (partially) failed copy */
+		if (!PageUptodate(page)) {
+			if (copied == 0) {
+				ret = -EFAULT;
+				goto error_page;
+			}
+			if (copied < bytes) {
+				iov_iter_revert(i, copied);
+				always_fill = true;
+				goto redo_prefetch;
+			}
+			SetPageUptodate(page);
+		}
+
+		/* Update the inode size if we moved the EOF marker */
+		new_pos = region->dirty.end + copied;
+		i_size = i_size_read(file_inode(file));
+		if (new_pos > i_size) {
+			if (ctx->ops->update_i_size) {
+				ctx->ops->update_i_size(file, new_pos);
+			} else {
+				i_size_write(file_inode(file), new_pos);
+				fscache_update_cookie(ctx->cache, NULL, &new_pos);
+			}
+		}
+
+		/* Update the region appropriately */
+		if (i_size > region->i_size)
+			region->i_size = i_size;
+		smp_store_release(&region->dirty.end, new_pos);
+
+		trace_netfs_dirty(ctx, region, NULL, netfs_dirty_trace_modified);
+		set_page_dirty(page);
+		unlock_page(page);
+		put_page(page);
+		page = NULL;
+
+		cond_resched();
+
+		written += copied;
+
+		balance_dirty_pages_ratelimited(file->f_mapping);
+	} while (iov_iter_count(i));
+
+out:
+	if (likely(written)) {
+		kdebug("written");
+		iocb->ki_pos += written;
+
+		/* Flush and wait for a write that requires immediate synchronisation. */
+		if (region->type == NETFS_REGION_DSYNC) {
+			kdebug("dsync");
+			spin_lock(&ctx->lock);
+			netfs_flush_region(ctx, region, netfs_dirty_trace_flush_dsync);
+			spin_unlock(&ctx->lock);
+
+			ret = wait_on_region(region, NETFS_REGION_IS_COMPLETE);
+			if (ret < 0)
+				written = ret;
+		}
+	}
+
+	netfs_commit_write(ctx, region);
+	return written ? written : ret;
+
+error_page:
+	unlock_page(page);
+	put_page(page);
+	goto out;
+}
+
+/**
+ * netfs_file_write_iter - write data to a file
+ * @iocb:	IO state structure
+ * @from:	iov_iter with data to write
+ *
+ * This is a wrapper around __generic_file_write_iter() to be used by most
+ * filesystems. It takes care of syncing the file in case of O_SYNC file
+ * and acquires i_mutex as needed.
+ * Return:
+ * * negative error code if no data has been written at all of
+ *   vfs_fsync_range() failed for a synchronous write
+ * * number of bytes written, even for truncated writes
+ */
+ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct netfs_dirty_region *region = NULL;
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+	enum netfs_region_type type;
+	unsigned long flags = 0;
+	ssize_t ret;
+
+	printk("\n");
+	kenter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto error_unlock;
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		type = NETFS_REGION_DIO;
+	if (iocb->ki_flags & IOCB_DSYNC)
+		type = NETFS_REGION_DSYNC;
+	else
+		type = NETFS_REGION_ORDINARY;
+	if (iocb->ki_flags & IOCB_SYNC)
+		__set_bit(NETFS_REGION_SYNC, &flags);
+
+	region = netfs_prepare_region(inode, file, iocb->ki_pos,
+				      iov_iter_count(from), type, flags);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
+		goto error_unlock;
+	}
+
+	trace_netfs_write_iter(region, iocb, from);
+
+	/* We can write back this queue in page reclaim */
+	current->backing_dev_info = inode_to_bdi(inode);
+	ret = file_remove_privs(file);
+	if (ret)
+		goto error_unlock;
+
+	ret = file_update_time(file);
+	if (ret)
+		goto error_unlock;
+
+	inode_unlock(inode);
+
+	ret = wait_on_region(region, NETFS_REGION_IS_RESERVED);
+	if (ret < 0)
+		goto error;
+
+	ret = netfs_activate_write(ctx, region);
+	if (ret < 0)
+		goto error;
+
+	/* The region excludes overlapping writes and is used to synchronise
+	 * versus flushes.
+	 */
+	if (iocb->ki_flags & IOCB_DIRECT)
+		ret = -EOPNOTSUPP; //netfs_file_direct_write(region, iocb, from);
+	else
+		ret = netfs_perform_write(region, iocb, from);
+
+out:
+	netfs_put_dirty_region(ctx, region, netfs_region_trace_put_write_iter);
+	current->backing_dev_info = NULL;
+	return ret;
+
+error_unlock:
+	inode_unlock(inode);
+error:
+	if (region)
+		netfs_commit_write(ctx, region);
+	goto out;
+}
+EXPORT_SYMBOL(netfs_file_write_iter);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 35bcd916c3a0..fc91711d3178 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -165,17 +165,95 @@ struct netfs_read_request {
  */
 struct netfs_i_context {
 	const struct netfs_request_ops *ops;
+	struct list_head	pending_writes;	/* List of writes waiting to be begin */
+	struct list_head	active_writes;	/* List of writes being applied */
+	struct list_head	dirty_regions;	/* List of dirty regions in the pagecache */
+	struct list_head	flush_groups;	/* Writeable region ordering queue */
+	struct list_head	flush_queue;	/* Regions that need to be flushed */
 #ifdef CONFIG_FSCACHE
 	struct fscache_cookie	*cache;
 #endif
 	unsigned long		flags;
 #define NETFS_ICTX_NEW_CONTENT	0		/* Set if file has new content (create/trunc-0) */
+	spinlock_t		lock;
+	unsigned int		rsize;		/* Maximum read size */
+	unsigned int		wsize;		/* Maximum write size */
+	unsigned int		bsize;		/* Min block size for bounding box */
+	unsigned int		inval_counter;	/* Number of invalidations made */
+};
+
+/*
+ * Descriptor for a set of writes that will need to be flushed together.
+ */
+struct netfs_flush_group {
+	struct list_head	group_link;	/* Link in i_context->flush_groups */
+	struct list_head	region_list;	/* List of regions in this group */
+	void			*netfs_priv;
+	refcount_t		ref;
+	bool			flush;
+};
+
+struct netfs_range {
+	unsigned long long	start;		/* Start of region */
+	unsigned long long	end;		/* End of region */
+};
+
+/* State of a netfs_dirty_region */
+enum netfs_region_state {
+	NETFS_REGION_IS_PENDING,	/* Proposed write is waiting on an active write */
+	NETFS_REGION_IS_RESERVED,	/* Writable region is reserved, waiting on flushes */
+	NETFS_REGION_IS_ACTIVE,		/* Write is actively modifying the pagecache */
+	NETFS_REGION_IS_DIRTY,		/* Region is dirty */
+	NETFS_REGION_IS_FLUSHING,	/* Region is being flushed */
+	NETFS_REGION_IS_COMPLETE,	/* Region has been completed (stored/invalidated) */
+} __attribute__((mode(byte)));
+
+enum netfs_region_type {
+	NETFS_REGION_ORDINARY,		/* Ordinary write */
+	NETFS_REGION_DIO,		/* Direct I/O write */
+	NETFS_REGION_DSYNC,		/* O_DSYNC/RWF_DSYNC write */
+} __attribute__((mode(byte)));
+
+/*
+ * Descriptor for a dirty region that has a common set of parameters and can
+ * feasibly be written back in one go.  These are held in an ordered list.
+ *
+ * Regions are not allowed to overlap, though they may be merged.
+ */
+struct netfs_dirty_region {
+	struct netfs_flush_group *group;
+	struct list_head	active_link;	/* Link in i_context->pending/active_writes */
+	struct list_head	dirty_link;	/* Link in i_context->dirty_regions */
+	struct list_head	flush_link;	/* Link in group->region_list or
+						 * i_context->flush_queue */
+	spinlock_t		lock;
+	void			*netfs_priv;	/* Private data for the netfs */
+	struct netfs_range	bounds;		/* Bounding box including all affected pages */
+	struct netfs_range	reserved;	/* The region reserved against other writes */
+	struct netfs_range	dirty;		/* The region that has been modified */
+	loff_t			i_size;		/* Size of the file */
+	enum netfs_region_type	type;
+	enum netfs_region_state	state;
+	unsigned long		flags;
+#define NETFS_REGION_SYNC	0		/* Set if metadata sync required (RWF_SYNC) */
+#define NETFS_REGION_FLUSH_Q	1		/* Set if region is on flush queue */
+#define NETFS_REGION_SUPERSEDED	2		/* Set if region is being superseded */
+	unsigned int		debug_id;
+	refcount_t		ref;
+};
+
+enum netfs_write_compatibility {
+	NETFS_WRITES_COMPATIBLE,	/* Dirty regions can be directly merged */
+	NETFS_WRITES_SUPERSEDE,		/* Second write can supersede the first without first
+					 * having to be flushed (eg. authentication, DSYNC) */
+	NETFS_WRITES_INCOMPATIBLE,	/* Second write must wait for first (eg. DIO, ceph snap) */
 };
 
 /*
  * Operations the network filesystem can/must provide to the helpers.
  */
 struct netfs_request_ops {
+	/* Read request handling */
 	void (*init_rreq)(struct netfs_read_request *rreq, struct file *file);
 	int (*begin_cache_operation)(struct netfs_read_request *rreq);
 	void (*expand_readahead)(struct netfs_read_request *rreq);
@@ -186,6 +264,17 @@ struct netfs_request_ops {
 				 struct page *page, void **_fsdata);
 	void (*done)(struct netfs_read_request *rreq);
 	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
+
+	/* Dirty region handling */
+	void (*init_dirty_region)(struct netfs_dirty_region *region, struct file *file);
+	void (*split_dirty_region)(struct netfs_dirty_region *region);
+	void (*free_dirty_region)(struct netfs_dirty_region *region);
+	enum netfs_write_compatibility (*is_write_compatible)(
+		struct netfs_i_context *ctx,
+		struct netfs_dirty_region *old_region,
+		struct netfs_dirty_region *candidate);
+	bool (*check_compatible_write)(struct netfs_dirty_region *region, struct file *file);
+	void (*update_i_size)(struct file *file, loff_t i_size);
 };
 
 /*
@@ -234,9 +323,11 @@ extern int netfs_readpage(struct file *, struct page *);
 extern int netfs_write_begin(struct file *, struct address_space *,
 			     loff_t, unsigned int, unsigned int, struct page **,
 			     void **);
+extern ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
 extern void netfs_stats_show(struct seq_file *);
+extern struct netfs_flush_group *netfs_new_flush_group(struct inode *, void *);
 
 /**
  * netfs_i_context - Get the netfs inode context from the inode
@@ -256,6 +347,13 @@ static inline void netfs_i_context_init(struct inode *inode,
 	struct netfs_i_context *ctx = netfs_i_context(inode);
 
 	ctx->ops = ops;
+	ctx->bsize = PAGE_SIZE;
+	INIT_LIST_HEAD(&ctx->pending_writes);
+	INIT_LIST_HEAD(&ctx->active_writes);
+	INIT_LIST_HEAD(&ctx->dirty_regions);
+	INIT_LIST_HEAD(&ctx->flush_groups);
+	INIT_LIST_HEAD(&ctx->flush_queue);
+	spin_lock_init(&ctx->lock);
 }
 
 /**
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 04ac29fc700f..808433e6ddd3 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -23,6 +23,7 @@ enum netfs_read_trace {
 	netfs_read_trace_readahead,
 	netfs_read_trace_readpage,
 	netfs_read_trace_write_begin,
+	netfs_read_trace_prefetch_for_write,
 };
 
 enum netfs_rreq_trace {
@@ -56,12 +57,43 @@ enum netfs_failure {
 	netfs_fail_prepare_write,
 };
 
+enum netfs_dirty_trace {
+	netfs_dirty_trace_active,
+	netfs_dirty_trace_commit,
+	netfs_dirty_trace_complete,
+	netfs_dirty_trace_flush_conflict,
+	netfs_dirty_trace_flush_dsync,
+	netfs_dirty_trace_merged_back,
+	netfs_dirty_trace_merged_forw,
+	netfs_dirty_trace_merged_sub,
+	netfs_dirty_trace_modified,
+	netfs_dirty_trace_new,
+	netfs_dirty_trace_reserved,
+	netfs_dirty_trace_split,
+	netfs_dirty_trace_start_pending,
+	netfs_dirty_trace_superseded,
+	netfs_dirty_trace_supersedes,
+	netfs_dirty_trace_wait_active,
+	netfs_dirty_trace_wait_pend,
+};
+
+enum netfs_region_trace {
+	netfs_region_trace_get_dirty,
+	netfs_region_trace_get_wreq,
+	netfs_region_trace_put_discard,
+	netfs_region_trace_put_merged,
+	netfs_region_trace_put_write_iter,
+	netfs_region_trace_free,
+	netfs_region_trace_new,
+};
+
 #endif
 
 #define netfs_read_traces					\
 	EM(netfs_read_trace_expanded,		"EXPANDED ")	\
 	EM(netfs_read_trace_readahead,		"READAHEAD")	\
 	EM(netfs_read_trace_readpage,		"READPAGE ")	\
+	EM(netfs_read_trace_prefetch_for_write,	"PREFETCHW")	\
 	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
 #define netfs_rreq_traces					\
@@ -98,6 +130,46 @@ enum netfs_failure {
 	EM(netfs_fail_short_write_begin,	"short-write-begin")	\
 	E_(netfs_fail_prepare_write,		"prep-write")
 
+#define netfs_region_types					\
+	EM(NETFS_REGION_ORDINARY,		"ORD")		\
+	EM(NETFS_REGION_DIO,			"DIO")		\
+	E_(NETFS_REGION_DSYNC,			"DSY")
+
+#define netfs_region_states					\
+	EM(NETFS_REGION_IS_PENDING,		"pend")		\
+	EM(NETFS_REGION_IS_RESERVED,		"resv")		\
+	EM(NETFS_REGION_IS_ACTIVE,		"actv")		\
+	EM(NETFS_REGION_IS_DIRTY,		"drty")		\
+	EM(NETFS_REGION_IS_FLUSHING,		"flsh")		\
+	E_(NETFS_REGION_IS_COMPLETE,		"done")
+
+#define netfs_dirty_traces					\
+	EM(netfs_dirty_trace_active,		"ACTIVE    ")	\
+	EM(netfs_dirty_trace_commit,		"COMMIT    ")	\
+	EM(netfs_dirty_trace_complete,		"COMPLETE  ")	\
+	EM(netfs_dirty_trace_flush_conflict,	"FLSH CONFL")	\
+	EM(netfs_dirty_trace_flush_dsync,	"FLSH DSYNC")	\
+	EM(netfs_dirty_trace_merged_back,	"MERGE BACK")	\
+	EM(netfs_dirty_trace_merged_forw,	"MERGE FORW")	\
+	EM(netfs_dirty_trace_merged_sub,	"SUBSUMED  ")	\
+	EM(netfs_dirty_trace_modified,		"MODIFIED  ")	\
+	EM(netfs_dirty_trace_new,		"NEW       ")	\
+	EM(netfs_dirty_trace_reserved,		"RESERVED  ")	\
+	EM(netfs_dirty_trace_split,		"SPLIT     ")	\
+	EM(netfs_dirty_trace_start_pending,	"START PEND")	\
+	EM(netfs_dirty_trace_superseded,	"SUPERSEDED")	\
+	EM(netfs_dirty_trace_supersedes,	"SUPERSEDES")	\
+	EM(netfs_dirty_trace_wait_active,	"WAIT ACTV ")	\
+	E_(netfs_dirty_trace_wait_pend,		"WAIT PEND ")
+
+#define netfs_region_traces					\
+	EM(netfs_region_trace_get_dirty,	"GET DIRTY  ")	\
+	EM(netfs_region_trace_get_wreq,		"GET WREQ   ")	\
+	EM(netfs_region_trace_put_discard,	"PUT DISCARD")	\
+	EM(netfs_region_trace_put_merged,	"PUT MERGED ")	\
+	EM(netfs_region_trace_put_write_iter,	"PUT WRITER ")	\
+	EM(netfs_region_trace_free,		"FREE       ")	\
+	E_(netfs_region_trace_new,		"NEW        ")
 
 /*
  * Export enum symbols via userspace.
@@ -112,6 +184,9 @@ netfs_rreq_traces;
 netfs_sreq_sources;
 netfs_sreq_traces;
 netfs_failures;
+netfs_region_types;
+netfs_region_states;
+netfs_dirty_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -255,6 +330,111 @@ TRACE_EVENT(netfs_failure,
 		      __entry->error)
 	    );
 
+TRACE_EVENT(netfs_write_iter,
+	    TP_PROTO(struct netfs_dirty_region *region, struct kiocb *iocb,
+		     struct iov_iter *from),
+
+	    TP_ARGS(region, iocb, from),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		region		)
+		    __field(unsigned long long,		start		)
+		    __field(size_t,			len		)
+		    __field(unsigned int,		flags		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->region	= region->debug_id;
+		    __entry->start	= iocb->ki_pos;
+		    __entry->len	= iov_iter_count(from);
+		    __entry->flags	= iocb->ki_flags;
+			   ),
+
+	    TP_printk("D=%x WRITE-ITER s=%llx l=%zx f=%x",
+		      __entry->region, __entry->start, __entry->len, __entry->flags)
+	    );
+
+TRACE_EVENT(netfs_ref_region,
+	    TP_PROTO(unsigned int region_debug_id, int ref,
+		     enum netfs_region_trace what),
+
+	    TP_ARGS(region_debug_id, ref, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		region		)
+		    __field(int,			ref		)
+		    __field(enum netfs_region_trace,	what		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->region	= region_debug_id;
+		    __entry->ref	= ref;
+		    __entry->what	= what;
+			   ),
+
+	    TP_printk("D=%x %s r=%u",
+		      __entry->region,
+		      __print_symbolic(__entry->what, netfs_region_traces),
+		      __entry->ref)
+	    );
+
+TRACE_EVENT(netfs_dirty,
+	    TP_PROTO(struct netfs_i_context *ctx,
+		     struct netfs_dirty_region *region,
+		     struct netfs_dirty_region *region2,
+		     enum netfs_dirty_trace why),
+
+	    TP_ARGS(ctx, region, region2, why),
+
+	    TP_STRUCT__entry(
+		    __field(ino_t,			ino		)
+		    __field(unsigned long long,		bounds_start	)
+		    __field(unsigned long long,		bounds_end	)
+		    __field(unsigned long long,		reserved_start	)
+		    __field(unsigned long long,		reserved_end	)
+		    __field(unsigned long long,		dirty_start	)
+		    __field(unsigned long long,		dirty_end	)
+		    __field(unsigned int,		debug_id	)
+		    __field(unsigned int,		debug_id2	)
+		    __field(enum netfs_region_type,	type		)
+		    __field(enum netfs_region_state,	state		)
+		    __field(unsigned short,		flags		)
+		    __field(unsigned int,		ref		)
+		    __field(enum netfs_dirty_trace,	why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->ino		= (((struct inode *)ctx) - 1)->i_ino;
+		    __entry->why		= why;
+		    __entry->bounds_start	= region->bounds.start;
+		    __entry->bounds_end		= region->bounds.end;
+		    __entry->reserved_start	= region->reserved.start;
+		    __entry->reserved_end	= region->reserved.end;
+		    __entry->dirty_start	= region->dirty.start;
+		    __entry->dirty_end		= region->dirty.end;
+		    __entry->debug_id		= region->debug_id;
+		    __entry->type		= region->type;
+		    __entry->state		= region->state;
+		    __entry->flags		= region->flags;
+		    __entry->debug_id2		= region2 ? region2->debug_id : 0;
+			   ),
+
+	    TP_printk("i=%lx D=%x %s %s dt=%04llx-%04llx bb=%04llx-%04llx rs=%04llx-%04llx %s f=%x XD=%x",
+		      __entry->ino, __entry->debug_id,
+		      __print_symbolic(__entry->why, netfs_dirty_traces),
+		      __print_symbolic(__entry->type, netfs_region_types),
+		      __entry->dirty_start,
+		      __entry->dirty_end,
+		      __entry->bounds_start,
+		      __entry->bounds_end,
+		      __entry->reserved_start,
+		      __entry->reserved_end,
+		      __print_symbolic(__entry->state, netfs_region_states),
+		      __entry->flags,
+		      __entry->debug_id2
+		      )
+	    );
+
 #endif /* _TRACE_NETFS_H */
 
 /* This part must be outside protection */


