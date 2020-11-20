Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5632BAC95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgKTPEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:04:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728406AbgKTPEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRCL5m2khDnRDXSdO7heqtmZUt4pDcLom7TTN/032jE=;
        b=LByMrzOm33G328M2BSaWvIziVeLPrw2W7HAJmv4UWxJEEWnigsJvrtCYGciLUGZ14Kkeky
        lSglDHpCkJvN4lw4njWky+ERkbzSkCGdGJ9q20hFkvPwbyXDfb4st963Y4lv2X6kr7Y8tN
        on75eDrTllkpF5TYIpQxTzbhw9a3g2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-iUK3MgXdNoalWfhnvQjofg-1; Fri, 20 Nov 2020 10:03:51 -0500
X-MC-Unique: iUK3MgXdNoalWfhnvQjofg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1EF1911BD;
        Fri, 20 Nov 2020 15:03:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37C5810016F4;
        Fri, 20 Nov 2020 15:03:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 05/76] fscache: Remove the old I/O API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:03:42 +0000
Message-ID: <160588462237.3465195.5911430241577283684.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the old fscache I/O API.  There's no point trying to transform it as
the new one will bear no similarities to the old one.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/Makefile           |    1 
 fs/cachefiles/interface.c        |   15 -
 fs/cachefiles/internal.h         |   38 -
 fs/cachefiles/main.c             |    1 
 fs/cachefiles/rdwr.c             |  975 -----------------------------------
 fs/fscache/cache.c               |    6 
 fs/fscache/cookie.c              |   10 
 fs/fscache/internal.h            |   23 -
 fs/fscache/object.c              |    2 
 fs/fscache/page.c                | 1068 --------------------------------------
 fs/fscache/stats.c               |    6 
 include/linux/fscache-cache.h    |  132 -----
 include/linux/fscache-obsolete.h |   13 
 include/linux/fscache.h          |  349 ------------
 14 files changed, 15 insertions(+), 2624 deletions(-)
 delete mode 100644 fs/cachefiles/rdwr.c
 create mode 100644 include/linux/fscache-obsolete.h

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 891dedda5905..3455d3646547 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -10,7 +10,6 @@ cachefiles-y := \
 	key.o \
 	main.o \
 	namei.o \
-	rdwr.o \
 	security.o \
 	xattr.o
 
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 4cea5fbf695e..04d92ad402a4 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -540,14 +540,6 @@ static void cachefiles_invalidate_object(struct fscache_operation *op)
 	_leave("");
 }
 
-/*
- * dissociate a cache from all the pages it was backing
- */
-static void cachefiles_dissociate_pages(struct fscache_cache *cache)
-{
-	_enter("");
-}
-
 const struct fscache_cache_ops cachefiles_cache_ops = {
 	.name			= "cachefiles",
 	.alloc_object		= cachefiles_alloc_object,
@@ -560,12 +552,5 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.put_object		= cachefiles_put_object,
 	.sync_cache		= cachefiles_sync_cache,
 	.attr_changed		= cachefiles_attr_changed,
-	.read_or_alloc_page	= cachefiles_read_or_alloc_page,
-	.read_or_alloc_pages	= cachefiles_read_or_alloc_pages,
-	.allocate_page		= cachefiles_allocate_page,
-	.allocate_pages		= cachefiles_allocate_pages,
-	.write_page		= cachefiles_write_page,
-	.uncache_page		= cachefiles_uncache_page,
-	.dissociate_pages	= cachefiles_dissociate_pages,
 	.check_consistency	= cachefiles_check_consistency,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index cf9bd6401c2d..aca73c8403ab 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -43,7 +43,6 @@ struct cachefiles_object {
 	atomic_t			usage;		/* object usage count */
 	uint8_t				type;		/* object type */
 	uint8_t				new;		/* T if object new */
-	spinlock_t			work_lock;
 	struct rb_node			active_node;	/* link in active tree (dentry is key) */
 };
 
@@ -89,28 +88,6 @@ struct cachefiles_cache {
 	char				*tag;		/* cache binding tag */
 };
 
-/*
- * backing file read tracking
- */
-struct cachefiles_one_read {
-	wait_queue_entry_t			monitor;	/* link into monitored waitqueue */
-	struct page			*back_page;	/* backing file page we're waiting for */
-	struct page			*netfs_page;	/* netfs page we're going to fill */
-	struct fscache_retrieval	*op;		/* retrieval op covering this */
-	struct list_head		op_link;	/* link in op's todo list */
-};
-
-/*
- * backing file write tracking
- */
-struct cachefiles_one_write {
-	struct page			*netfs_page;	/* netfs page to copy */
-	struct cachefiles_object	*object;
-	struct list_head		obj_link;	/* link in object's lists */
-	fscache_rw_complete_t		end_io_func;
-	void				*context;
-};
-
 /*
  * auxiliary data xattr buffer
  */
@@ -202,21 +179,6 @@ void cachefiles_hist(atomic_t histogram[], unsigned long start_jif)
 #define cachefiles_hist(hist, start_jif) do {} while (0)
 #endif
 
-/*
- * rdwr.c
- */
-extern int cachefiles_read_or_alloc_page(struct fscache_retrieval *,
-					 struct page *, gfp_t);
-extern int cachefiles_read_or_alloc_pages(struct fscache_retrieval *,
-					  struct list_head *, unsigned *,
-					  gfp_t);
-extern int cachefiles_allocate_page(struct fscache_retrieval *, struct page *,
-				    gfp_t);
-extern int cachefiles_allocate_pages(struct fscache_retrieval *,
-				     struct list_head *, unsigned *, gfp_t);
-extern int cachefiles_write_page(struct fscache_storage *, struct page *);
-extern void cachefiles_uncache_page(struct fscache_object *, struct page *);
-
 /*
  * security.c
  */
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index ddf0cd58d60c..3f0101a74809 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -42,7 +42,6 @@ static void cachefiles_object_init_once(void *_object)
 	struct cachefiles_object *object = _object;
 
 	memset(object, 0, sizeof(*object));
-	spin_lock_init(&object->work_lock);
 }
 
 /*
diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
deleted file mode 100644
index 8bda092e60c5..000000000000
--- a/fs/cachefiles/rdwr.c
+++ /dev/null
@@ -1,975 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Storage object read/write
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/mount.h>
-#include <linux/slab.h>
-#include <linux/file.h>
-#include <linux/swap.h>
-#include "internal.h"
-
-/*
- * detect wake up events generated by the unlocking of pages in which we're
- * interested
- * - we use this to detect read completion of backing pages
- * - the caller holds the waitqueue lock
- */
-static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
-				  int sync, void *_key)
-{
-	struct cachefiles_one_read *monitor =
-		container_of(wait, struct cachefiles_one_read, monitor);
-	struct cachefiles_object *object;
-	struct fscache_retrieval *op = monitor->op;
-	struct wait_bit_key *key = _key;
-	struct page *page = wait->private;
-
-	ASSERT(key);
-
-	_enter("{%lu},%u,%d,{%p,%u}",
-	       monitor->netfs_page->index, mode, sync,
-	       key->flags, key->bit_nr);
-
-	if (key->flags != &page->flags ||
-	    key->bit_nr != PG_locked)
-		return 0;
-
-	_debug("--- monitor %p %lx ---", page, page->flags);
-
-	if (!PageUptodate(page) && !PageError(page)) {
-		/* unlocked, not uptodate and not erronous? */
-		_debug("page probably truncated");
-	}
-
-	/* remove from the waitqueue */
-	list_del(&wait->entry);
-
-	/* move onto the action list and queue for FS-Cache thread pool */
-	ASSERT(op);
-
-	/* We need to temporarily bump the usage count as we don't own a ref
-	 * here otherwise cachefiles_read_copier() may free the op between the
-	 * monitor being enqueued on the op->to_do list and the op getting
-	 * enqueued on the work queue.
-	 */
-	fscache_get_retrieval(op);
-
-	object = container_of(op->op.object, struct cachefiles_object, fscache);
-	spin_lock(&object->work_lock);
-	list_add_tail(&monitor->op_link, &op->to_do);
-	fscache_enqueue_retrieval(op);
-	spin_unlock(&object->work_lock);
-
-	fscache_put_retrieval(op);
-	return 0;
-}
-
-/*
- * handle a probably truncated page
- * - check to see if the page is still relevant and reissue the read if
- *   possible
- * - return -EIO on error, -ENODATA if the page is gone, -EINPROGRESS if we
- *   must wait again and 0 if successful
- */
-static int cachefiles_read_reissue(struct cachefiles_object *object,
-				   struct cachefiles_one_read *monitor)
-{
-	struct address_space *bmapping = d_backing_inode(object->backer)->i_mapping;
-	struct page *backpage = monitor->back_page, *backpage2;
-	int ret;
-
-	_enter("{ino=%lx},{%lx,%lx}",
-	       d_backing_inode(object->backer)->i_ino,
-	       backpage->index, backpage->flags);
-
-	/* skip if the page was truncated away completely */
-	if (backpage->mapping != bmapping) {
-		_leave(" = -ENODATA [mapping]");
-		return -ENODATA;
-	}
-
-	backpage2 = find_get_page(bmapping, backpage->index);
-	if (!backpage2) {
-		_leave(" = -ENODATA [gone]");
-		return -ENODATA;
-	}
-
-	if (backpage != backpage2) {
-		put_page(backpage2);
-		_leave(" = -ENODATA [different]");
-		return -ENODATA;
-	}
-
-	/* the page is still there and we already have a ref on it, so we don't
-	 * need a second */
-	put_page(backpage2);
-
-	INIT_LIST_HEAD(&monitor->op_link);
-	add_page_wait_queue(backpage, &monitor->monitor);
-
-	if (trylock_page(backpage)) {
-		ret = -EIO;
-		if (PageError(backpage))
-			goto unlock_discard;
-		ret = 0;
-		if (PageUptodate(backpage))
-			goto unlock_discard;
-
-		_debug("reissue read");
-		ret = bmapping->a_ops->readpage(NULL, backpage);
-		if (ret < 0)
-			goto discard;
-	}
-
-	/* but the page may have been read before the monitor was installed, so
-	 * the monitor may miss the event - so we have to ensure that we do get
-	 * one in such a case */
-	if (trylock_page(backpage)) {
-		_debug("jumpstart %p {%lx}", backpage, backpage->flags);
-		unlock_page(backpage);
-	}
-
-	/* it'll reappear on the todo list */
-	_leave(" = -EINPROGRESS");
-	return -EINPROGRESS;
-
-unlock_discard:
-	unlock_page(backpage);
-discard:
-	spin_lock_irq(&object->work_lock);
-	list_del(&monitor->op_link);
-	spin_unlock_irq(&object->work_lock);
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * copy data from backing pages to netfs pages to complete a read operation
- * - driven by FS-Cache's thread pool
- */
-static void cachefiles_read_copier(struct fscache_operation *_op)
-{
-	struct cachefiles_one_read *monitor;
-	struct cachefiles_object *object;
-	struct fscache_retrieval *op;
-	int error, max;
-
-	op = container_of(_op, struct fscache_retrieval, op);
-	object = container_of(op->op.object,
-			      struct cachefiles_object, fscache);
-
-	_enter("{ino=%lu}", d_backing_inode(object->backer)->i_ino);
-
-	max = 8;
-	spin_lock_irq(&object->work_lock);
-
-	while (!list_empty(&op->to_do)) {
-		monitor = list_entry(op->to_do.next,
-				     struct cachefiles_one_read, op_link);
-		list_del(&monitor->op_link);
-
-		spin_unlock_irq(&object->work_lock);
-
-		_debug("- copy {%lu}", monitor->back_page->index);
-
-	recheck:
-		if (test_bit(FSCACHE_COOKIE_INVALIDATING,
-			     &object->fscache.cookie->flags)) {
-			error = -ESTALE;
-		} else if (PageUptodate(monitor->back_page)) {
-			copy_highpage(monitor->netfs_page, monitor->back_page);
-			fscache_mark_page_cached(monitor->op,
-						 monitor->netfs_page);
-			error = 0;
-		} else if (!PageError(monitor->back_page)) {
-			/* the page has probably been truncated */
-			error = cachefiles_read_reissue(object, monitor);
-			if (error == -EINPROGRESS)
-				goto next;
-			goto recheck;
-		} else {
-			cachefiles_io_error_obj(
-				object,
-				"Readpage failed on backing file %lx",
-				(unsigned long) monitor->back_page->flags);
-			error = -EIO;
-		}
-
-		put_page(monitor->back_page);
-
-		fscache_end_io(op, monitor->netfs_page, error);
-		put_page(monitor->netfs_page);
-		fscache_retrieval_complete(op, 1);
-		fscache_put_retrieval(op);
-		kfree(monitor);
-
-	next:
-		/* let the thread pool have some air occasionally */
-		max--;
-		if (max < 0 || need_resched()) {
-			if (!list_empty(&op->to_do))
-				fscache_enqueue_retrieval(op);
-			_leave(" [maxed out]");
-			return;
-		}
-
-		spin_lock_irq(&object->work_lock);
-	}
-
-	spin_unlock_irq(&object->work_lock);
-	_leave("");
-}
-
-/*
- * read the corresponding page to the given set from the backing file
- * - an uncertain page is simply discarded, to be tried again another time
- */
-static int cachefiles_read_backing_file_one(struct cachefiles_object *object,
-					    struct fscache_retrieval *op,
-					    struct page *netpage)
-{
-	struct cachefiles_one_read *monitor;
-	struct address_space *bmapping;
-	struct page *newpage, *backpage;
-	int ret;
-
-	_enter("");
-
-	_debug("read back %p{%lu,%d}",
-	       netpage, netpage->index, page_count(netpage));
-
-	monitor = kzalloc(sizeof(*monitor), cachefiles_gfp);
-	if (!monitor)
-		goto nomem;
-
-	monitor->netfs_page = netpage;
-	monitor->op = fscache_get_retrieval(op);
-
-	init_waitqueue_func_entry(&monitor->monitor, cachefiles_read_waiter);
-
-	/* attempt to get hold of the backing page */
-	bmapping = d_backing_inode(object->backer)->i_mapping;
-	newpage = NULL;
-
-	for (;;) {
-		backpage = find_get_page(bmapping, netpage->index);
-		if (backpage)
-			goto backing_page_already_present;
-
-		if (!newpage) {
-			newpage = __page_cache_alloc(cachefiles_gfp);
-			if (!newpage)
-				goto nomem_monitor;
-		}
-
-		ret = add_to_page_cache_lru(newpage, bmapping,
-					    netpage->index, cachefiles_gfp);
-		if (ret == 0)
-			goto installed_new_backing_page;
-		if (ret != -EEXIST)
-			goto nomem_page;
-	}
-
-	/* we've installed a new backing page, so now we need to start
-	 * it reading */
-installed_new_backing_page:
-	_debug("- new %p", newpage);
-
-	backpage = newpage;
-	newpage = NULL;
-
-read_backing_page:
-	ret = bmapping->a_ops->readpage(NULL, backpage);
-	if (ret < 0)
-		goto read_error;
-
-	/* set the monitor to transfer the data across */
-monitor_backing_page:
-	_debug("- monitor add");
-
-	/* install the monitor */
-	get_page(monitor->netfs_page);
-	get_page(backpage);
-	monitor->back_page = backpage;
-	monitor->monitor.private = backpage;
-	add_page_wait_queue(backpage, &monitor->monitor);
-	monitor = NULL;
-
-	/* but the page may have been read before the monitor was installed, so
-	 * the monitor may miss the event - so we have to ensure that we do get
-	 * one in such a case */
-	if (trylock_page(backpage)) {
-		_debug("jumpstart %p {%lx}", backpage, backpage->flags);
-		unlock_page(backpage);
-	}
-	goto success;
-
-	/* if the backing page is already present, it can be in one of
-	 * three states: read in progress, read failed or read okay */
-backing_page_already_present:
-	_debug("- present");
-
-	if (newpage) {
-		put_page(newpage);
-		newpage = NULL;
-	}
-
-	if (PageError(backpage))
-		goto io_error;
-
-	if (PageUptodate(backpage))
-		goto backing_page_already_uptodate;
-
-	if (!trylock_page(backpage))
-		goto monitor_backing_page;
-	_debug("read %p {%lx}", backpage, backpage->flags);
-	goto read_backing_page;
-
-	/* the backing page is already up to date, attach the netfs
-	 * page to the pagecache and LRU and copy the data across */
-backing_page_already_uptodate:
-	_debug("- uptodate");
-
-	fscache_mark_page_cached(op, netpage);
-
-	copy_highpage(netpage, backpage);
-	fscache_end_io(op, netpage, 0);
-	fscache_retrieval_complete(op, 1);
-
-success:
-	_debug("success");
-	ret = 0;
-
-out:
-	if (backpage)
-		put_page(backpage);
-	if (monitor) {
-		fscache_put_retrieval(monitor->op);
-		kfree(monitor);
-	}
-	_leave(" = %d", ret);
-	return ret;
-
-read_error:
-	_debug("read error %d", ret);
-	if (ret == -ENOMEM) {
-		fscache_retrieval_complete(op, 1);
-		goto out;
-	}
-io_error:
-	cachefiles_io_error_obj(object, "Page read error on backing file");
-	fscache_retrieval_complete(op, 1);
-	ret = -ENOBUFS;
-	goto out;
-
-nomem_page:
-	put_page(newpage);
-nomem_monitor:
-	fscache_put_retrieval(monitor->op);
-	kfree(monitor);
-nomem:
-	fscache_retrieval_complete(op, 1);
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
-}
-
-/*
- * read a page from the cache or allocate a block in which to store it
- * - cache withdrawal is prevented by the caller
- * - returns -EINTR if interrupted
- * - returns -ENOMEM if ran out of memory
- * - returns -ENOBUFS if no buffers can be made available
- * - returns -ENOBUFS if page is beyond EOF
- * - if the page is backed by a block in the cache:
- *   - a read will be started which will call the callback on completion
- *   - 0 will be returned
- * - else if the page is unbacked:
- *   - the metadata will be retained
- *   - -ENODATA will be returned
- */
-int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
-				  struct page *page,
-				  gfp_t gfp)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	struct inode *inode;
-	sector_t block;
-	unsigned shift;
-	int ret, ret2;
-
-	object = container_of(op->op.object,
-			      struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	_enter("{%p},{%lx},,,", object, page->index);
-
-	if (!object->backer)
-		goto enobufs;
-
-	inode = d_backing_inode(object->backer);
-	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->readpages);
-
-	/* calculate the shift required to use bmap */
-	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
-
-	op->op.flags &= FSCACHE_OP_KEEP_FLAGS;
-	op->op.flags |= FSCACHE_OP_ASYNC;
-	op->op.processor = cachefiles_read_copier;
-
-	/* we assume the absence or presence of the first block is a good
-	 * enough indication for the page as a whole
-	 * - TODO: don't use bmap() for this as it is _not_ actually good
-	 *   enough for this as it doesn't indicate errors, but it's all we've
-	 *   got for the moment
-	 */
-	block = page->index;
-	block <<= shift;
-
-	ret2 = bmap(inode, &block);
-	ASSERT(ret2 == 0);
-
-	_debug("%llx -> %llx",
-	       (unsigned long long) (page->index << shift),
-	       (unsigned long long) block);
-
-	if (block) {
-		/* submit the apparently valid page to the backing fs to be
-		 * read from disk */
-		ret = cachefiles_read_backing_file_one(object, op, page);
-	} else if (cachefiles_has_space(cache, 0, 1) == 0) {
-		/* there's space in the cache we can use */
-		fscache_mark_page_cached(op, page);
-		fscache_retrieval_complete(op, 1);
-		ret = -ENODATA;
-	} else {
-		goto enobufs;
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-
-enobufs:
-	fscache_retrieval_complete(op, 1);
-	_leave(" = -ENOBUFS");
-	return -ENOBUFS;
-}
-
-/*
- * read the corresponding pages to the given set from the backing file
- * - any uncertain pages are simply discarded, to be tried again another time
- */
-static int cachefiles_read_backing_file(struct cachefiles_object *object,
-					struct fscache_retrieval *op,
-					struct list_head *list)
-{
-	struct cachefiles_one_read *monitor = NULL;
-	struct address_space *bmapping = d_backing_inode(object->backer)->i_mapping;
-	struct page *newpage = NULL, *netpage, *_n, *backpage = NULL;
-	int ret = 0;
-
-	_enter("");
-
-	list_for_each_entry_safe(netpage, _n, list, lru) {
-		list_del(&netpage->lru);
-
-		_debug("read back %p{%lu,%d}",
-		       netpage, netpage->index, page_count(netpage));
-
-		if (!monitor) {
-			monitor = kzalloc(sizeof(*monitor), cachefiles_gfp);
-			if (!monitor)
-				goto nomem;
-
-			monitor->op = fscache_get_retrieval(op);
-			init_waitqueue_func_entry(&monitor->monitor,
-						  cachefiles_read_waiter);
-		}
-
-		for (;;) {
-			backpage = find_get_page(bmapping, netpage->index);
-			if (backpage)
-				goto backing_page_already_present;
-
-			if (!newpage) {
-				newpage = __page_cache_alloc(cachefiles_gfp);
-				if (!newpage)
-					goto nomem;
-			}
-
-			ret = add_to_page_cache_lru(newpage, bmapping,
-						    netpage->index,
-						    cachefiles_gfp);
-			if (ret == 0)
-				goto installed_new_backing_page;
-			if (ret != -EEXIST)
-				goto nomem;
-		}
-
-		/* we've installed a new backing page, so now we need
-		 * to start it reading */
-	installed_new_backing_page:
-		_debug("- new %p", newpage);
-
-		backpage = newpage;
-		newpage = NULL;
-
-	reread_backing_page:
-		ret = bmapping->a_ops->readpage(NULL, backpage);
-		if (ret < 0)
-			goto read_error;
-
-		/* add the netfs page to the pagecache and LRU, and set the
-		 * monitor to transfer the data across */
-	monitor_backing_page:
-		_debug("- monitor add");
-
-		ret = add_to_page_cache_lru(netpage, op->mapping,
-					    netpage->index, cachefiles_gfp);
-		if (ret < 0) {
-			if (ret == -EEXIST) {
-				put_page(backpage);
-				backpage = NULL;
-				put_page(netpage);
-				netpage = NULL;
-				fscache_retrieval_complete(op, 1);
-				continue;
-			}
-			goto nomem;
-		}
-
-		/* install a monitor */
-		get_page(netpage);
-		monitor->netfs_page = netpage;
-
-		get_page(backpage);
-		monitor->back_page = backpage;
-		monitor->monitor.private = backpage;
-		add_page_wait_queue(backpage, &monitor->monitor);
-		monitor = NULL;
-
-		/* but the page may have been read before the monitor was
-		 * installed, so the monitor may miss the event - so we have to
-		 * ensure that we do get one in such a case */
-		if (trylock_page(backpage)) {
-			_debug("2unlock %p {%lx}", backpage, backpage->flags);
-			unlock_page(backpage);
-		}
-
-		put_page(backpage);
-		backpage = NULL;
-
-		put_page(netpage);
-		netpage = NULL;
-		continue;
-
-		/* if the backing page is already present, it can be in one of
-		 * three states: read in progress, read failed or read okay */
-	backing_page_already_present:
-		_debug("- present %p", backpage);
-
-		if (PageError(backpage))
-			goto io_error;
-
-		if (PageUptodate(backpage))
-			goto backing_page_already_uptodate;
-
-		_debug("- not ready %p{%lx}", backpage, backpage->flags);
-
-		if (!trylock_page(backpage))
-			goto monitor_backing_page;
-
-		if (PageError(backpage)) {
-			_debug("error %lx", backpage->flags);
-			unlock_page(backpage);
-			goto io_error;
-		}
-
-		if (PageUptodate(backpage))
-			goto backing_page_already_uptodate_unlock;
-
-		/* we've locked a page that's neither up to date nor erroneous,
-		 * so we need to attempt to read it again */
-		goto reread_backing_page;
-
-		/* the backing page is already up to date, attach the netfs
-		 * page to the pagecache and LRU and copy the data across */
-	backing_page_already_uptodate_unlock:
-		_debug("uptodate %lx", backpage->flags);
-		unlock_page(backpage);
-	backing_page_already_uptodate:
-		_debug("- uptodate");
-
-		ret = add_to_page_cache_lru(netpage, op->mapping,
-					    netpage->index, cachefiles_gfp);
-		if (ret < 0) {
-			if (ret == -EEXIST) {
-				put_page(backpage);
-				backpage = NULL;
-				put_page(netpage);
-				netpage = NULL;
-				fscache_retrieval_complete(op, 1);
-				continue;
-			}
-			goto nomem;
-		}
-
-		copy_highpage(netpage, backpage);
-
-		put_page(backpage);
-		backpage = NULL;
-
-		fscache_mark_page_cached(op, netpage);
-
-		/* the netpage is unlocked and marked up to date here */
-		fscache_end_io(op, netpage, 0);
-		put_page(netpage);
-		netpage = NULL;
-		fscache_retrieval_complete(op, 1);
-		continue;
-	}
-
-	netpage = NULL;
-
-	_debug("out");
-
-out:
-	/* tidy up */
-	if (newpage)
-		put_page(newpage);
-	if (netpage)
-		put_page(netpage);
-	if (backpage)
-		put_page(backpage);
-	if (monitor) {
-		fscache_put_retrieval(op);
-		kfree(monitor);
-	}
-
-	list_for_each_entry_safe(netpage, _n, list, lru) {
-		list_del(&netpage->lru);
-		put_page(netpage);
-		fscache_retrieval_complete(op, 1);
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-
-nomem:
-	_debug("nomem");
-	ret = -ENOMEM;
-	goto record_page_complete;
-
-read_error:
-	_debug("read error %d", ret);
-	if (ret == -ENOMEM)
-		goto record_page_complete;
-io_error:
-	cachefiles_io_error_obj(object, "Page read error on backing file");
-	ret = -ENOBUFS;
-record_page_complete:
-	fscache_retrieval_complete(op, 1);
-	goto out;
-}
-
-/*
- * read a list of pages from the cache or allocate blocks in which to store
- * them
- */
-int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
-				   struct list_head *pages,
-				   unsigned *nr_pages,
-				   gfp_t gfp)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	struct list_head backpages;
-	struct pagevec pagevec;
-	struct inode *inode;
-	struct page *page, *_n;
-	unsigned shift, nrbackpages;
-	int ret, ret2, space;
-
-	object = container_of(op->op.object,
-			      struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	_enter("{OBJ%x,%d},,%d,,",
-	       object->fscache.debug_id, atomic_read(&op->op.usage),
-	       *nr_pages);
-
-	if (!object->backer)
-		goto all_enobufs;
-
-	space = 1;
-	if (cachefiles_has_space(cache, 0, *nr_pages) < 0)
-		space = 0;
-
-	inode = d_backing_inode(object->backer);
-	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->readpages);
-
-	/* calculate the shift required to use bmap */
-	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
-
-	pagevec_init(&pagevec);
-
-	op->op.flags &= FSCACHE_OP_KEEP_FLAGS;
-	op->op.flags |= FSCACHE_OP_ASYNC;
-	op->op.processor = cachefiles_read_copier;
-
-	INIT_LIST_HEAD(&backpages);
-	nrbackpages = 0;
-
-	ret = space ? -ENODATA : -ENOBUFS;
-	list_for_each_entry_safe(page, _n, pages, lru) {
-		sector_t block;
-
-		/* we assume the absence or presence of the first block is a
-		 * good enough indication for the page as a whole
-		 * - TODO: don't use bmap() for this as it is _not_ actually
-		 *   good enough for this as it doesn't indicate errors, but
-		 *   it's all we've got for the moment
-		 */
-		block = page->index;
-		block <<= shift;
-
-		ret2 = bmap(inode, &block);
-		ASSERT(ret2 == 0);
-
-		_debug("%llx -> %llx",
-		       (unsigned long long) (page->index << shift),
-		       (unsigned long long) block);
-
-		if (block) {
-			/* we have data - add it to the list to give to the
-			 * backing fs */
-			list_move(&page->lru, &backpages);
-			(*nr_pages)--;
-			nrbackpages++;
-		} else if (space && pagevec_add(&pagevec, page) == 0) {
-			fscache_mark_pages_cached(op, &pagevec);
-			fscache_retrieval_complete(op, 1);
-			ret = -ENODATA;
-		} else {
-			fscache_retrieval_complete(op, 1);
-		}
-	}
-
-	if (pagevec_count(&pagevec) > 0)
-		fscache_mark_pages_cached(op, &pagevec);
-
-	if (list_empty(pages))
-		ret = 0;
-
-	/* submit the apparently valid pages to the backing fs to be read from
-	 * disk */
-	if (nrbackpages > 0) {
-		ret2 = cachefiles_read_backing_file(object, op, &backpages);
-		if (ret2 == -ENOMEM || ret2 == -EINTR)
-			ret = ret2;
-	}
-
-	_leave(" = %d [nr=%u%s]",
-	       ret, *nr_pages, list_empty(pages) ? " empty" : "");
-	return ret;
-
-all_enobufs:
-	fscache_retrieval_complete(op, *nr_pages);
-	return -ENOBUFS;
-}
-
-/*
- * allocate a block in the cache in which to store a page
- * - cache withdrawal is prevented by the caller
- * - returns -EINTR if interrupted
- * - returns -ENOMEM if ran out of memory
- * - returns -ENOBUFS if no buffers can be made available
- * - returns -ENOBUFS if page is beyond EOF
- * - otherwise:
- *   - the metadata will be retained
- *   - 0 will be returned
- */
-int cachefiles_allocate_page(struct fscache_retrieval *op,
-			     struct page *page,
-			     gfp_t gfp)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	int ret;
-
-	object = container_of(op->op.object,
-			      struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	_enter("%p,{%lx},", object, page->index);
-
-	ret = cachefiles_has_space(cache, 0, 1);
-	if (ret == 0)
-		fscache_mark_page_cached(op, page);
-	else
-		ret = -ENOBUFS;
-
-	fscache_retrieval_complete(op, 1);
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * allocate blocks in the cache in which to store a set of pages
- * - cache withdrawal is prevented by the caller
- * - returns -EINTR if interrupted
- * - returns -ENOMEM if ran out of memory
- * - returns -ENOBUFS if some buffers couldn't be made available
- * - returns -ENOBUFS if some pages are beyond EOF
- * - otherwise:
- *   - -ENODATA will be returned
- * - metadata will be retained for any page marked
- */
-int cachefiles_allocate_pages(struct fscache_retrieval *op,
-			      struct list_head *pages,
-			      unsigned *nr_pages,
-			      gfp_t gfp)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	struct pagevec pagevec;
-	struct page *page;
-	int ret;
-
-	object = container_of(op->op.object,
-			      struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	_enter("%p,,,%d,", object, *nr_pages);
-
-	ret = cachefiles_has_space(cache, 0, *nr_pages);
-	if (ret == 0) {
-		pagevec_init(&pagevec);
-
-		list_for_each_entry(page, pages, lru) {
-			if (pagevec_add(&pagevec, page) == 0)
-				fscache_mark_pages_cached(op, &pagevec);
-		}
-
-		if (pagevec_count(&pagevec) > 0)
-			fscache_mark_pages_cached(op, &pagevec);
-		ret = -ENODATA;
-	} else {
-		ret = -ENOBUFS;
-	}
-
-	fscache_retrieval_complete(op, *nr_pages);
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * request a page be stored in the cache
- * - cache withdrawal is prevented by the caller
- * - this request may be ignored if there's no cache block available, in which
- *   case -ENOBUFS will be returned
- * - if the op is in progress, 0 will be returned
- */
-int cachefiles_write_page(struct fscache_storage *op, struct page *page)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	struct file *file;
-	struct path path;
-	loff_t pos, eof;
-	size_t len;
-	void *data;
-	int ret = -ENOBUFS;
-
-	ASSERT(op != NULL);
-	ASSERT(page != NULL);
-
-	object = container_of(op->op.object,
-			      struct cachefiles_object, fscache);
-
-	_enter("%p,%p{%lx},,,", object, page, page->index);
-
-	if (!object->backer) {
-		_leave(" = -ENOBUFS");
-		return -ENOBUFS;
-	}
-
-	ASSERT(d_is_reg(object->backer));
-
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	pos = (loff_t)page->index << PAGE_SHIFT;
-
-	/* We mustn't write more data than we have, so we have to beware of a
-	 * partial page at EOF.
-	 */
-	eof = object->fscache.store_limit_l;
-	if (pos >= eof)
-		goto error;
-
-	/* write the page to the backing filesystem and let it store it in its
-	 * own time */
-	path.mnt = cache->mnt;
-	path.dentry = object->backer;
-	file = dentry_open(&path, O_RDWR | O_LARGEFILE, cache->cache_cred);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto error_2;
-	}
-
-	len = PAGE_SIZE;
-	if (eof & ~PAGE_MASK) {
-		if (eof - pos < PAGE_SIZE) {
-			_debug("cut short %llx to %llx",
-			       pos, eof);
-			len = eof - pos;
-			ASSERTCMP(pos + len, ==, eof);
-		}
-	}
-
-	data = kmap(page);
-	ret = kernel_write(file, data, len, &pos);
-	kunmap(page);
-	fput(file);
-	if (ret != len)
-		goto error_eio;
-
-	_leave(" = 0");
-	return 0;
-
-error_eio:
-	ret = -EIO;
-error_2:
-	if (ret == -EIO)
-		cachefiles_io_error_obj(object,
-					"Write page to backing file failed");
-error:
-	_leave(" = -ENOBUFS [%d]", ret);
-	return -ENOBUFS;
-}
-
-/*
- * detach a backing block from a page
- * - cache withdrawal is prevented by the caller
- */
-void cachefiles_uncache_page(struct fscache_object *_object, struct page *page)
-	__releases(&object->fscache.cookie->lock)
-{
-	struct cachefiles_object *object;
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-
-	_enter("%p,{%lu}", object, page->index);
-
-	spin_unlock(&object->fscache.cookie->lock);
-}
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index fcc136361415..7de6d4cd29ee 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -382,12 +382,6 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 	cache->ops->sync_cache(cache);
 	fscache_stat_d(&fscache_n_cop_sync_cache);
 
-	/* dissociate all the netfs pages backed by this cache from the block
-	 * mappings in the cache */
-	fscache_stat(&fscache_n_cop_dissociate_pages);
-	cache->ops->dissociate_pages(cache);
-	fscache_stat_d(&fscache_n_cop_dissociate_pages);
-
 	/* we now have to destroy all the active objects pertaining to this
 	 * cache - which we do by passing them off to thread pool to be
 	 * disposed of */
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index c7047544972b..b35f727cc0d4 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -191,13 +191,8 @@ struct fscache_cookie *fscache_alloc_cookie(
 	cookie->flags		= (1 << FSCACHE_COOKIE_NO_DATA_YET);
 	cookie->type		= def->type;
 	spin_lock_init(&cookie->lock);
-	spin_lock_init(&cookie->stores_lock);
 	INIT_HLIST_HEAD(&cookie->backing_objects);
 
-	/* radix tree insertion won't use the preallocation pool unless it's
-	 * told it may not wait */
-	INIT_RADIX_TREE(&cookie->stores, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
-
 	write_lock(&fscache_cookies_lock);
 	list_add_tail(&cookie->proc_link, &fscache_cookies);
 	write_unlock(&fscache_cookies_lock);
@@ -786,10 +781,6 @@ void __fscache_disable_cookie(struct fscache_cookie *cookie,
 			       !atomic_read(&cookie->n_active));
 	}
 
-	/* Make sure any pending writes are cancelled. */
-	if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
-		fscache_invalidate_writes(cookie);
-
 	/* Reset the cookie state if it wasn't relinquished */
 	if (!test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags)) {
 		atomic_inc(&cookie->n_active);
@@ -838,7 +829,6 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
 	/* Clear pointers back to the netfs */
 	cookie->netfs_data	= NULL;
 	cookie->def		= NULL;
-	BUG_ON(!radix_tree_empty(&cookie->stores));
 
 	if (cookie->parent) {
 		ASSERTCMP(atomic_read(&cookie->parent->usage), >, 0);
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 4b535c2dae4a..83dfbe0e3964 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -142,7 +142,6 @@ extern int fscache_wait_for_operation_activation(struct fscache_object *,
 						 struct fscache_operation *,
 						 atomic_t *,
 						 atomic_t *);
-extern void fscache_invalidate_writes(struct fscache_cookie *);
 
 /*
  * proc.c
@@ -272,7 +271,6 @@ extern atomic_t fscache_n_cop_allocate_page;
 extern atomic_t fscache_n_cop_allocate_pages;
 extern atomic_t fscache_n_cop_write_page;
 extern atomic_t fscache_n_cop_uncache_page;
-extern atomic_t fscache_n_cop_dissociate_pages;
 
 extern atomic_t fscache_n_cache_no_space_reject;
 extern atomic_t fscache_n_cache_stale_objects;
@@ -325,27 +323,6 @@ static inline void fscache_cookie_get(struct fscache_cookie *cookie,
 	trace_fscache_cookie(cookie, where, usage);
 }
 
-/*
- * get an extra reference to a netfs retrieval context
- */
-static inline
-void *fscache_get_context(struct fscache_cookie *cookie, void *context)
-{
-	if (cookie->def->get_context)
-		cookie->def->get_context(cookie->netfs_data, context);
-	return context;
-}
-
-/*
- * release a reference to a netfs retrieval context
- */
-static inline
-void fscache_put_context(struct fscache_cookie *cookie, void *context)
-{
-	if (cookie->def->put_context)
-		cookie->def->put_context(cookie->netfs_data, context);
-}
-
 /*
  * Update the auxiliary data on a cookie.
  */
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index cb2146e02cd5..3d7f956a01c6 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -973,14 +973,12 @@ static const struct fscache_state *_fscache_invalidate_object(struct fscache_obj
 	 * retire the object instead.
 	 */
 	if (!fscache_use_cookie(object)) {
-		ASSERT(radix_tree_empty(&object->cookie->stores));
 		set_bit(FSCACHE_OBJECT_RETIRED, &object->flags);
 		_leave(" [no cookie]");
 		return transit_to(KILL_OBJECT);
 	}
 
 	/* Reject any new read/write ops and abort any that are pending. */
-	fscache_invalidate_writes(cookie);
 	clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
 	fscache_cancel_all_ops(object);
 
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index 26af6fdf1538..1beffb071205 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -13,174 +13,6 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-/*
- * check to see if a page is being written to the cache
- */
-bool __fscache_check_page_write(struct fscache_cookie *cookie, struct page *page)
-{
-	void *val;
-
-	rcu_read_lock();
-	val = radix_tree_lookup(&cookie->stores, page->index);
-	rcu_read_unlock();
-	trace_fscache_check_page(cookie, page, val, 0);
-
-	return val != NULL;
-}
-EXPORT_SYMBOL(__fscache_check_page_write);
-
-/*
- * wait for a page to finish being written to the cache
- */
-void __fscache_wait_on_page_write(struct fscache_cookie *cookie, struct page *page)
-{
-	wait_queue_head_t *wq = bit_waitqueue(&cookie->flags, 0);
-
-	trace_fscache_page(cookie, page, fscache_page_write_wait);
-
-	wait_event(*wq, !__fscache_check_page_write(cookie, page));
-}
-EXPORT_SYMBOL(__fscache_wait_on_page_write);
-
-/*
- * wait for a page to finish being written to the cache. Put a timeout here
- * since we might be called recursively via parent fs.
- */
-static
-bool release_page_wait_timeout(struct fscache_cookie *cookie, struct page *page)
-{
-	wait_queue_head_t *wq = bit_waitqueue(&cookie->flags, 0);
-
-	return wait_event_timeout(*wq, !__fscache_check_page_write(cookie, page),
-				  HZ);
-}
-
-/*
- * decide whether a page can be released, possibly by cancelling a store to it
- * - we're allowed to sleep if __GFP_DIRECT_RECLAIM is flagged
- */
-bool __fscache_maybe_release_page(struct fscache_cookie *cookie,
-				  struct page *page,
-				  gfp_t gfp)
-{
-	struct page *xpage;
-	void *val;
-
-	_enter("%p,%p,%x", cookie, page, gfp);
-
-	trace_fscache_page(cookie, page, fscache_page_maybe_release);
-
-try_again:
-	rcu_read_lock();
-	val = radix_tree_lookup(&cookie->stores, page->index);
-	if (!val) {
-		rcu_read_unlock();
-		fscache_stat(&fscache_n_store_vmscan_not_storing);
-		__fscache_uncache_page(cookie, page);
-		return true;
-	}
-
-	/* see if the page is actually undergoing storage - if so we can't get
-	 * rid of it till the cache has finished with it */
-	if (radix_tree_tag_get(&cookie->stores, page->index,
-			       FSCACHE_COOKIE_STORING_TAG)) {
-		rcu_read_unlock();
-		goto page_busy;
-	}
-
-	/* the page is pending storage, so we attempt to cancel the store and
-	 * discard the store request so that the page can be reclaimed */
-	spin_lock(&cookie->stores_lock);
-	rcu_read_unlock();
-
-	if (radix_tree_tag_get(&cookie->stores, page->index,
-			       FSCACHE_COOKIE_STORING_TAG)) {
-		/* the page started to undergo storage whilst we were looking,
-		 * so now we can only wait or return */
-		spin_unlock(&cookie->stores_lock);
-		goto page_busy;
-	}
-
-	xpage = radix_tree_delete(&cookie->stores, page->index);
-	trace_fscache_page(cookie, page, fscache_page_radix_delete);
-	spin_unlock(&cookie->stores_lock);
-
-	if (xpage) {
-		fscache_stat(&fscache_n_store_vmscan_cancelled);
-		fscache_stat(&fscache_n_store_radix_deletes);
-		ASSERTCMP(xpage, ==, page);
-	} else {
-		fscache_stat(&fscache_n_store_vmscan_gone);
-	}
-
-	wake_up_bit(&cookie->flags, 0);
-	trace_fscache_wake_cookie(cookie);
-	if (xpage)
-		put_page(xpage);
-	__fscache_uncache_page(cookie, page);
-	return true;
-
-page_busy:
-	/* We will wait here if we're allowed to, but that could deadlock the
-	 * allocator as the work threads writing to the cache may all end up
-	 * sleeping on memory allocation, so we may need to impose a timeout
-	 * too. */
-	if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS)) {
-		fscache_stat(&fscache_n_store_vmscan_busy);
-		return false;
-	}
-
-	fscache_stat(&fscache_n_store_vmscan_wait);
-	if (!release_page_wait_timeout(cookie, page))
-		_debug("fscache writeout timeout page: %p{%lx}",
-			page, page->index);
-
-	gfp &= ~__GFP_DIRECT_RECLAIM;
-	goto try_again;
-}
-EXPORT_SYMBOL(__fscache_maybe_release_page);
-
-/*
- * note that a page has finished being written to the cache
- */
-static void fscache_end_page_write(struct fscache_object *object,
-				   struct page *page)
-{
-	struct fscache_cookie *cookie;
-	struct page *xpage = NULL, *val;
-
-	spin_lock(&object->lock);
-	cookie = object->cookie;
-	if (cookie) {
-		/* delete the page from the tree if it is now no longer
-		 * pending */
-		spin_lock(&cookie->stores_lock);
-		radix_tree_tag_clear(&cookie->stores, page->index,
-				     FSCACHE_COOKIE_STORING_TAG);
-		trace_fscache_page(cookie, page, fscache_page_radix_clear_store);
-		if (!radix_tree_tag_get(&cookie->stores, page->index,
-					FSCACHE_COOKIE_PENDING_TAG)) {
-			fscache_stat(&fscache_n_store_radix_deletes);
-			xpage = radix_tree_delete(&cookie->stores, page->index);
-			trace_fscache_page(cookie, page, fscache_page_radix_delete);
-			trace_fscache_page(cookie, page, fscache_page_write_end);
-
-			val = radix_tree_lookup(&cookie->stores, page->index);
-			trace_fscache_check_page(cookie, page, val, 1);
-		} else {
-			trace_fscache_page(cookie, page, fscache_page_write_end_pend);
-		}
-		spin_unlock(&cookie->stores_lock);
-		wake_up_bit(&cookie->flags, 0);
-		trace_fscache_wake_cookie(cookie);
-	} else {
-		trace_fscache_page(cookie, page, fscache_page_write_end_noc);
-	}
-	spin_unlock(&object->lock);
-	if (xpage)
-		put_page(xpage);
-}
-
 /*
  * actually apply the changed attributes to a cache object
  */
@@ -265,76 +97,6 @@ int __fscache_attr_changed(struct fscache_cookie *cookie)
 }
 EXPORT_SYMBOL(__fscache_attr_changed);
 
-/*
- * Handle cancellation of a pending retrieval op
- */
-static void fscache_do_cancel_retrieval(struct fscache_operation *_op)
-{
-	struct fscache_retrieval *op =
-		container_of(_op, struct fscache_retrieval, op);
-
-	atomic_set(&op->n_pages, 0);
-}
-
-/*
- * release a retrieval op reference
- */
-static void fscache_release_retrieval_op(struct fscache_operation *_op)
-{
-	struct fscache_retrieval *op =
-		container_of(_op, struct fscache_retrieval, op);
-
-	_enter("{OP%x}", op->op.debug_id);
-
-	ASSERTIFCMP(op->op.state != FSCACHE_OP_ST_INITIALISED,
-		    atomic_read(&op->n_pages), ==, 0);
-
-	fscache_hist(fscache_retrieval_histogram, op->start_time);
-	if (op->context)
-		fscache_put_context(op->cookie, op->context);
-
-	_leave("");
-}
-
-/*
- * allocate a retrieval op
- */
-static struct fscache_retrieval *fscache_alloc_retrieval(
-	struct fscache_cookie *cookie,
-	struct address_space *mapping,
-	fscache_rw_complete_t end_io_func,
-	void *context)
-{
-	struct fscache_retrieval *op;
-
-	/* allocate a retrieval operation and attempt to submit it */
-	op = kzalloc(sizeof(*op), GFP_NOIO);
-	if (!op) {
-		fscache_stat(&fscache_n_retrievals_nomem);
-		return NULL;
-	}
-
-	fscache_operation_init(cookie, &op->op, NULL,
-			       fscache_do_cancel_retrieval,
-			       fscache_release_retrieval_op);
-	op->op.flags	= FSCACHE_OP_MYTHREAD |
-		(1UL << FSCACHE_OP_WAITING) |
-		(1UL << FSCACHE_OP_UNUSE_COOKIE);
-	op->cookie	= cookie;
-	op->mapping	= mapping;
-	op->end_io_func	= end_io_func;
-	op->context	= context;
-	op->start_time	= jiffies;
-	INIT_LIST_HEAD(&op->to_do);
-
-	/* Pin the netfs read context in case we need to do the actual netfs
-	 * read because we've encountered a cache read failure.
-	 */
-	if (context)
-		fscache_get_context(op->cookie, context);
-	return op;
-}
-
 /*
  * wait for a deferred lookup to complete
  */
@@ -416,833 +178,3 @@ int fscache_wait_for_operation_activation(struct fscache_object *object,
 	}
 	return 0;
 }
-
-/*
- * read a page from the cache or allocate a block in which to store it
- * - we return:
- *   -ENOMEM	- out of memory, nothing done
- *   -ERESTARTSYS - interrupted
- *   -ENOBUFS	- no backing object available in which to cache the block
- *   -ENODATA	- no data available in the backing object for this block
- *   0		- dispatched a read - it'll call end_io_func() when finished
- */
-int __fscache_read_or_alloc_page(struct fscache_cookie *cookie,
-				 struct page *page,
-				 fscache_rw_complete_t end_io_func,
-				 void *context,
-				 gfp_t gfp)
-{
-	struct fscache_retrieval *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-	int ret;
-
-	_enter("%p,%p,,,", cookie, page);
-
-	fscache_stat(&fscache_n_retrievals);
-
-	if (hlist_empty(&cookie->backing_objects))
-		goto nobufs;
-
-	if (test_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags)) {
-		_leave(" = -ENOBUFS [invalidating]");
-		return -ENOBUFS;
-	}
-
-	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-	ASSERTCMP(page, !=, NULL);
-
-	if (fscache_wait_for_deferred_lookup(cookie) < 0)
-		return -ERESTARTSYS;
-
-	op = fscache_alloc_retrieval(cookie, page->mapping,
-				     end_io_func, context);
-	if (!op) {
-		_leave(" = -ENOMEM");
-		return -ENOMEM;
-	}
-	atomic_set(&op->n_pages, 1);
-	trace_fscache_page_op(cookie, page, &op->op, fscache_page_op_retr_one);
-
-	spin_lock(&cookie->lock);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs_unlock;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	ASSERT(test_bit(FSCACHE_OBJECT_IS_LOOKED_UP, &object->flags));
-
-	__fscache_use_cookie(cookie);
-	atomic_inc(&object->n_reads);
-	__set_bit(FSCACHE_OP_DEC_READ_CNT, &op->op.flags);
-
-	if (fscache_submit_op(object, &op->op) < 0)
-		goto nobufs_unlock_dec;
-	spin_unlock(&cookie->lock);
-
-	fscache_stat(&fscache_n_retrieval_ops);
-
-	/* we wait for the operation to become active, and then process it
-	 * *here*, in this thread, and not in the thread pool */
-	ret = fscache_wait_for_operation_activation(
-		object, &op->op,
-		__fscache_stat(&fscache_n_retrieval_op_waits),
-		__fscache_stat(&fscache_n_retrievals_object_dead));
-	if (ret < 0)
-		goto error;
-
-	/* ask the cache to honour the operation */
-	if (test_bit(FSCACHE_COOKIE_NO_DATA_YET, &object->cookie->flags)) {
-		fscache_stat(&fscache_n_cop_allocate_page);
-		ret = object->cache->ops->allocate_page(op, page, gfp);
-		fscache_stat_d(&fscache_n_cop_allocate_page);
-		if (ret == 0)
-			ret = -ENODATA;
-	} else {
-		fscache_stat(&fscache_n_cop_read_or_alloc_page);
-		ret = object->cache->ops->read_or_alloc_page(op, page, gfp);
-		fscache_stat_d(&fscache_n_cop_read_or_alloc_page);
-	}
-
-error:
-	if (ret == -ENOMEM)
-		fscache_stat(&fscache_n_retrievals_nomem);
-	else if (ret == -ERESTARTSYS)
-		fscache_stat(&fscache_n_retrievals_intr);
-	else if (ret == -ENODATA)
-		fscache_stat(&fscache_n_retrievals_nodata);
-	else if (ret < 0)
-		fscache_stat(&fscache_n_retrievals_nobufs);
-	else
-		fscache_stat(&fscache_n_retrievals_ok);
-
-	fscache_put_retrieval(op);
-	_leave(" = %d", ret);
-	return ret;
-
-nobufs_unlock_dec:
-	atomic_dec(&object->n_reads);
-	wake_cookie = __fscache_unuse_cookie(cookie);
-nobufs_unlock:
-	spin_unlock(&cookie->lock);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-	fscache_put_retrieval(op);
-nobufs:
-	fscache_stat(&fscache_n_retrievals_nobufs);
-	_leave(" = -ENOBUFS");
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(__fscache_read_or_alloc_page);
-
-/*
- * read a list of page from the cache or allocate a block in which to store
- * them
- * - we return:
- *   -ENOMEM	- out of memory, some pages may be being read
- *   -ERESTARTSYS - interrupted, some pages may be being read
- *   -ENOBUFS	- no backing object or space available in which to cache any
- *                pages not being read
- *   -ENODATA	- no data available in the backing object for some or all of
- *                the pages
- *   0		- dispatched a read on all pages
- *
- * end_io_func() will be called for each page read from the cache as it is
- * finishes being read
- *
- * any pages for which a read is dispatched will be removed from pages and
- * nr_pages
- */
-int __fscache_read_or_alloc_pages(struct fscache_cookie *cookie,
-				  struct address_space *mapping,
-				  struct list_head *pages,
-				  unsigned *nr_pages,
-				  fscache_rw_complete_t end_io_func,
-				  void *context,
-				  gfp_t gfp)
-{
-	struct fscache_retrieval *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-	int ret;
-
-	_enter("%p,,%d,,,", cookie, *nr_pages);
-
-	fscache_stat(&fscache_n_retrievals);
-
-	if (hlist_empty(&cookie->backing_objects))
-		goto nobufs;
-
-	if (test_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags)) {
-		_leave(" = -ENOBUFS [invalidating]");
-		return -ENOBUFS;
-	}
-
-	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-	ASSERTCMP(*nr_pages, >, 0);
-	ASSERT(!list_empty(pages));
-
-	if (fscache_wait_for_deferred_lookup(cookie) < 0)
-		return -ERESTARTSYS;
-
-	op = fscache_alloc_retrieval(cookie, mapping, end_io_func, context);
-	if (!op)
-		return -ENOMEM;
-	atomic_set(&op->n_pages, *nr_pages);
-	trace_fscache_page_op(cookie, NULL, &op->op, fscache_page_op_retr_multi);
-
-	spin_lock(&cookie->lock);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs_unlock;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	__fscache_use_cookie(cookie);
-	atomic_inc(&object->n_reads);
-	__set_bit(FSCACHE_OP_DEC_READ_CNT, &op->op.flags);
-
-	if (fscache_submit_op(object, &op->op) < 0)
-		goto nobufs_unlock_dec;
-	spin_unlock(&cookie->lock);
-
-	fscache_stat(&fscache_n_retrieval_ops);
-
-	/* we wait for the operation to become active, and then process it
-	 * *here*, in this thread, and not in the thread pool */
-	ret = fscache_wait_for_operation_activation(
-		object, &op->op,
-		__fscache_stat(&fscache_n_retrieval_op_waits),
-		__fscache_stat(&fscache_n_retrievals_object_dead));
-	if (ret < 0)
-		goto error;
-
-	/* ask the cache to honour the operation */
-	if (test_bit(FSCACHE_COOKIE_NO_DATA_YET, &object->cookie->flags)) {
-		fscache_stat(&fscache_n_cop_allocate_pages);
-		ret = object->cache->ops->allocate_pages(
-			op, pages, nr_pages, gfp);
-		fscache_stat_d(&fscache_n_cop_allocate_pages);
-	} else {
-		fscache_stat(&fscache_n_cop_read_or_alloc_pages);
-		ret = object->cache->ops->read_or_alloc_pages(
-			op, pages, nr_pages, gfp);
-		fscache_stat_d(&fscache_n_cop_read_or_alloc_pages);
-	}
-
-error:
-	if (ret == -ENOMEM)
-		fscache_stat(&fscache_n_retrievals_nomem);
-	else if (ret == -ERESTARTSYS)
-		fscache_stat(&fscache_n_retrievals_intr);
-	else if (ret == -ENODATA)
-		fscache_stat(&fscache_n_retrievals_nodata);
-	else if (ret < 0)
-		fscache_stat(&fscache_n_retrievals_nobufs);
-	else
-		fscache_stat(&fscache_n_retrievals_ok);
-
-	fscache_put_retrieval(op);
-	_leave(" = %d", ret);
-	return ret;
-
-nobufs_unlock_dec:
-	atomic_dec(&object->n_reads);
-	wake_cookie = __fscache_unuse_cookie(cookie);
-nobufs_unlock:
-	spin_unlock(&cookie->lock);
-	fscache_put_retrieval(op);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-nobufs:
-	fscache_stat(&fscache_n_retrievals_nobufs);
-	_leave(" = -ENOBUFS");
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(__fscache_read_or_alloc_pages);
-
-/*
- * allocate a block in the cache on which to store a page
- * - we return:
- *   -ENOMEM	- out of memory, nothing done
- *   -ERESTARTSYS - interrupted
- *   -ENOBUFS	- no backing object available in which to cache the block
- *   0		- block allocated
- */
-int __fscache_alloc_page(struct fscache_cookie *cookie,
-			 struct page *page,
-			 gfp_t gfp)
-{
-	struct fscache_retrieval *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-	int ret;
-
-	_enter("%p,%p,,,", cookie, page);
-
-	fscache_stat(&fscache_n_allocs);
-
-	if (hlist_empty(&cookie->backing_objects))
-		goto nobufs;
-
-	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-	ASSERTCMP(page, !=, NULL);
-
-	if (test_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags)) {
-		_leave(" = -ENOBUFS [invalidating]");
-		return -ENOBUFS;
-	}
-
-	if (fscache_wait_for_deferred_lookup(cookie) < 0)
-		return -ERESTARTSYS;
-
-	op = fscache_alloc_retrieval(cookie, page->mapping, NULL, NULL);
-	if (!op)
-		return -ENOMEM;
-	atomic_set(&op->n_pages, 1);
-	trace_fscache_page_op(cookie, page, &op->op, fscache_page_op_alloc_one);
-
-	spin_lock(&cookie->lock);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs_unlock;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	__fscache_use_cookie(cookie);
-	if (fscache_submit_op(object, &op->op) < 0)
-		goto nobufs_unlock_dec;
-	spin_unlock(&cookie->lock);
-
-	fscache_stat(&fscache_n_alloc_ops);
-
-	ret = fscache_wait_for_operation_activation(
-		object, &op->op,
-		__fscache_stat(&fscache_n_alloc_op_waits),
-		__fscache_stat(&fscache_n_allocs_object_dead));
-	if (ret < 0)
-		goto error;
-
-	/* ask the cache to honour the operation */
-	fscache_stat(&fscache_n_cop_allocate_page);
-	ret = object->cache->ops->allocate_page(op, page, gfp);
-	fscache_stat_d(&fscache_n_cop_allocate_page);
-
-error:
-	if (ret == -ERESTARTSYS)
-		fscache_stat(&fscache_n_allocs_intr);
-	else if (ret < 0)
-		fscache_stat(&fscache_n_allocs_nobufs);
-	else
-		fscache_stat(&fscache_n_allocs_ok);
-
-	fscache_put_retrieval(op);
-	_leave(" = %d", ret);
-	return ret;
-
-nobufs_unlock_dec:
-	wake_cookie = __fscache_unuse_cookie(cookie);
-nobufs_unlock:
-	spin_unlock(&cookie->lock);
-	fscache_put_retrieval(op);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-nobufs:
-	fscache_stat(&fscache_n_allocs_nobufs);
-	_leave(" = -ENOBUFS");
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(__fscache_alloc_page);
-
-/*
- * Unmark pages allocate in the readahead code path (via:
- * fscache_readpages_or_alloc) after delegating to the base filesystem
- */
-void __fscache_readpages_cancel(struct fscache_cookie *cookie,
-				struct list_head *pages)
-{
-	struct page *page;
-
-	list_for_each_entry(page, pages, lru) {
-		if (PageFsCache(page))
-			__fscache_uncache_page(cookie, page);
-	}
-}
-EXPORT_SYMBOL(__fscache_readpages_cancel);
-
-/*
- * release a write op reference
- */
-static void fscache_release_write_op(struct fscache_operation *_op)
-{
-	_enter("{OP%x}", _op->debug_id);
-}
-
-/*
- * perform the background storage of a page into the cache
- */
-static void fscache_write_op(struct fscache_operation *_op)
-{
-	struct fscache_storage *op =
-		container_of(_op, struct fscache_storage, op);
-	struct fscache_object *object = op->op.object;
-	struct fscache_cookie *cookie;
-	struct page *page;
-	unsigned n;
-	void *results[1];
-	int ret;
-
-	_enter("{OP%x,%d}", op->op.debug_id, atomic_read(&op->op.usage));
-
-again:
-	spin_lock(&object->lock);
-	cookie = object->cookie;
-
-	if (!fscache_object_is_active(object)) {
-		/* If we get here, then the on-disk cache object likely no
-		 * longer exists, so we should just cancel this write
-		 * operation.
-		 */
-		spin_unlock(&object->lock);
-		fscache_op_complete(&op->op, true);
-		_leave(" [inactive]");
-		return;
-	}
-
-	if (!cookie) {
-		/* If we get here, then the cookie belonging to the object was
-		 * detached, probably by the cookie being withdrawn due to
-		 * memory pressure, which means that the pages we might write
-		 * to the cache from no longer exist - therefore, we can just
-		 * cancel this write operation.
-		 */
-		spin_unlock(&object->lock);
-		fscache_op_complete(&op->op, true);
-		_leave(" [cancel] op{f=%lx s=%u} obj{s=%s f=%lx}",
-		       _op->flags, _op->state, object->state->short_name,
-		       object->flags);
-		return;
-	}
-
-	spin_lock(&cookie->stores_lock);
-
-	fscache_stat(&fscache_n_store_calls);
-
-	/* find a page to store */
-	results[0] = NULL;
-	page = NULL;
-	n = radix_tree_gang_lookup_tag(&cookie->stores, results, 0, 1,
-				       FSCACHE_COOKIE_PENDING_TAG);
-	trace_fscache_gang_lookup(cookie, &op->op, results, n, op->store_limit);
-	if (n != 1)
-		goto superseded;
-	page = results[0];
-	_debug("gang %d [%lx]", n, page->index);
-
-	radix_tree_tag_set(&cookie->stores, page->index,
-			   FSCACHE_COOKIE_STORING_TAG);
-	radix_tree_tag_clear(&cookie->stores, page->index,
-			     FSCACHE_COOKIE_PENDING_TAG);
-	trace_fscache_page(cookie, page, fscache_page_radix_pend2store);
-
-	spin_unlock(&cookie->stores_lock);
-	spin_unlock(&object->lock);
-
-	if (page->index >= op->store_limit)
-		goto discard_page;
-
-	fscache_stat(&fscache_n_store_pages);
-	fscache_stat(&fscache_n_cop_write_page);
-	ret = object->cache->ops->write_page(op, page);
-	fscache_stat_d(&fscache_n_cop_write_page);
-	trace_fscache_wrote_page(cookie, page, &op->op, ret);
-	fscache_end_page_write(object, page);
-	if (ret < 0) {
-		fscache_abort_object(object);
-		fscache_op_complete(&op->op, true);
-	} else {
-		fscache_enqueue_operation(&op->op);
-	}
-
-	_leave("");
-	return;
-
-discard_page:
-	fscache_stat(&fscache_n_store_pages_over_limit);
-	trace_fscache_wrote_page(cookie, page, &op->op, -ENOBUFS);
-	fscache_end_page_write(object, page);
-	goto again;
-
-superseded:
-	/* this writer is going away and there aren't any more things to
-	 * write */
-	_debug("cease");
-	spin_unlock(&cookie->stores_lock);
-	clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
-	spin_unlock(&object->lock);
-	fscache_op_complete(&op->op, false);
-	_leave("");
-}
-
-/*
- * Clear the pages pending writing for invalidation
- */
-void fscache_invalidate_writes(struct fscache_cookie *cookie)
-{
-	struct page *page;
-	void *results[16];
-	int n, i;
-
-	_enter("");
-
-	for (;;) {
-		spin_lock(&cookie->stores_lock);
-		n = radix_tree_gang_lookup_tag(&cookie->stores, results, 0,
-					       ARRAY_SIZE(results),
-					       FSCACHE_COOKIE_PENDING_TAG);
-		if (n == 0) {
-			spin_unlock(&cookie->stores_lock);
-			break;
-		}
-
-		for (i = n - 1; i >= 0; i--) {
-			page = results[i];
-			radix_tree_delete(&cookie->stores, page->index);
-			trace_fscache_page(cookie, page, fscache_page_radix_delete);
-			trace_fscache_page(cookie, page, fscache_page_inval);
-		}
-
-		spin_unlock(&cookie->stores_lock);
-
-		for (i = n - 1; i >= 0; i--)
-			put_page(results[i]);
-	}
-
-	wake_up_bit(&cookie->flags, 0);
-	trace_fscache_wake_cookie(cookie);
-
-	_leave("");
-}
-
-/*
- * request a page be stored in the cache
- * - returns:
- *   -ENOMEM	- out of memory, nothing done
- *   -ENOBUFS	- no backing object available in which to cache the page
- *   0		- dispatched a write - it'll call end_io_func() when finished
- *
- * if the cookie still has a backing object at this point, that object can be
- * in one of a few states with respect to storage processing:
- *
- *  (1) negative lookup, object not yet created (FSCACHE_COOKIE_CREATING is
- *      set)
- *
- *	(a) no writes yet
- *
- *	(b) writes deferred till post-creation (mark page for writing and
- *	    return immediately)
- *
- *  (2) negative lookup, object created, initial fill being made from netfs
- *
- *	(a) fill point not yet reached this page (mark page for writing and
- *          return)
- *
- *	(b) fill point passed this page (queue op to store this page)
- *
- *  (3) object extant (queue op to store this page)
- *
- * any other state is invalid
- */
-int __fscache_write_page(struct fscache_cookie *cookie,
-			 struct page *page,
-			 loff_t object_size,
-			 gfp_t gfp)
-{
-	struct fscache_storage *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-	int ret;
-
-	_enter("%p,%x,", cookie, (u32) page->flags);
-
-	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-	ASSERT(PageFsCache(page));
-
-	fscache_stat(&fscache_n_stores);
-
-	if (test_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags)) {
-		_leave(" = -ENOBUFS [invalidating]");
-		return -ENOBUFS;
-	}
-
-	op = kzalloc(sizeof(*op), GFP_NOIO | __GFP_NOMEMALLOC | __GFP_NORETRY);
-	if (!op)
-		goto nomem;
-
-	fscache_operation_init(cookie, &op->op, fscache_write_op, NULL,
-			       fscache_release_write_op);
-	op->op.flags = FSCACHE_OP_ASYNC |
-		(1 << FSCACHE_OP_WAITING) |
-		(1 << FSCACHE_OP_UNUSE_COOKIE);
-
-	ret = radix_tree_maybe_preload(gfp & ~__GFP_HIGHMEM);
-	if (ret < 0)
-		goto nomem_free;
-
-	trace_fscache_page_op(cookie, page, &op->op, fscache_page_op_write_one);
-
-	ret = -ENOBUFS;
-	spin_lock(&cookie->lock);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-	if (test_bit(FSCACHE_IOERROR, &object->cache->flags))
-		goto nobufs;
-
-	trace_fscache_page(cookie, page, fscache_page_write);
-
-	/* add the page to the pending-storage radix tree on the backing
-	 * object */
-	spin_lock(&object->lock);
-
-	if (object->store_limit_l != object_size)
-		fscache_set_store_limit(object, object_size);
-
-	spin_lock(&cookie->stores_lock);
-
-	_debug("store limit %llx", (unsigned long long) object->store_limit);
-
-	ret = radix_tree_insert(&cookie->stores, page->index, page);
-	if (ret < 0) {
-		if (ret == -EEXIST)
-			goto already_queued;
-		_debug("insert failed %d", ret);
-		goto nobufs_unlock_obj;
-	}
-
-	trace_fscache_page(cookie, page, fscache_page_radix_insert);
-	radix_tree_tag_set(&cookie->stores, page->index,
-			   FSCACHE_COOKIE_PENDING_TAG);
-	trace_fscache_page(cookie, page, fscache_page_radix_set_pend);
-	get_page(page);
-
-	/* we only want one writer at a time, but we do need to queue new
-	 * writers after exclusive ops */
-	if (test_and_set_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags))
-		goto already_pending;
-
-	spin_unlock(&cookie->stores_lock);
-	spin_unlock(&object->lock);
-
-	op->op.debug_id	= atomic_inc_return(&fscache_op_debug_id);
-	op->store_limit = object->store_limit;
-
-	__fscache_use_cookie(cookie);
-	if (fscache_submit_op(object, &op->op) < 0)
-		goto submit_failed;
-
-	spin_unlock(&cookie->lock);
-	radix_tree_preload_end();
-	fscache_stat(&fscache_n_store_ops);
-	fscache_stat(&fscache_n_stores_ok);
-
-	/* the work queue now carries its own ref on the object */
-	fscache_put_operation(&op->op);
-	_leave(" = 0");
-	return 0;
-
-already_queued:
-	fscache_stat(&fscache_n_stores_again);
-already_pending:
-	spin_unlock(&cookie->stores_lock);
-	spin_unlock(&object->lock);
-	spin_unlock(&cookie->lock);
-	radix_tree_preload_end();
-	fscache_put_operation(&op->op);
-	fscache_stat(&fscache_n_stores_ok);
-	_leave(" = 0");
-	return 0;
-
-submit_failed:
-	spin_lock(&cookie->stores_lock);
-	radix_tree_delete(&cookie->stores, page->index);
-	trace_fscache_page(cookie, page, fscache_page_radix_delete);
-	spin_unlock(&cookie->stores_lock);
-	wake_cookie = __fscache_unuse_cookie(cookie);
-	put_page(page);
-	ret = -ENOBUFS;
-	goto nobufs;
-
-nobufs_unlock_obj:
-	spin_unlock(&cookie->stores_lock);
-	spin_unlock(&object->lock);
-nobufs:
-	spin_unlock(&cookie->lock);
-	radix_tree_preload_end();
-	fscache_put_operation(&op->op);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-	fscache_stat(&fscache_n_stores_nobufs);
-	_leave(" = -ENOBUFS");
-	return -ENOBUFS;
-
-nomem_free:
-	fscache_put_operation(&op->op);
-nomem:
-	fscache_stat(&fscache_n_stores_oom);
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
-}
-EXPORT_SYMBOL(__fscache_write_page);
-
-/*
- * remove a page from the cache
- */
-void __fscache_uncache_page(struct fscache_cookie *cookie, struct page *page)
-{
-	struct fscache_object *object;
-
-	_enter(",%p", page);
-
-	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-	ASSERTCMP(page, !=, NULL);
-
-	fscache_stat(&fscache_n_uncaches);
-
-	/* cache withdrawal may beat us to it */
-	if (!PageFsCache(page))
-		goto done;
-
-	trace_fscache_page(cookie, page, fscache_page_uncache);
-
-	/* get the object */
-	spin_lock(&cookie->lock);
-
-	if (hlist_empty(&cookie->backing_objects)) {
-		ClearPageFsCache(page);
-		goto done_unlock;
-	}
-
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	/* there might now be stuff on disk we could read */
-	clear_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-
-	/* only invoke the cache backend if we managed to mark the page
-	 * uncached here; this deals with synchronisation vs withdrawal */
-	if (TestClearPageFsCache(page) &&
-	    object->cache->ops->uncache_page) {
-		/* the cache backend releases the cookie lock */
-		fscache_stat(&fscache_n_cop_uncache_page);
-		object->cache->ops->uncache_page(object, page);
-		fscache_stat_d(&fscache_n_cop_uncache_page);
-		goto done;
-	}
-
-done_unlock:
-	spin_unlock(&cookie->lock);
-done:
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_uncache_page);
-
-/**
- * fscache_mark_page_cached - Mark a page as being cached
- * @op: The retrieval op pages are being marked for
- * @page: The page to be marked
- *
- * Mark a netfs page as being cached.  After this is called, the netfs
- * must call fscache_uncache_page() to remove the mark.
- */
-void fscache_mark_page_cached(struct fscache_retrieval *op, struct page *page)
-{
-	struct fscache_cookie *cookie = op->op.object->cookie;
-
-#ifdef CONFIG_FSCACHE_STATS
-	atomic_inc(&fscache_n_marks);
-#endif
-
-	trace_fscache_page(cookie, page, fscache_page_cached);
-
-	_debug("- mark %p{%lx}", page, page->index);
-	if (TestSetPageFsCache(page)) {
-		static bool once_only;
-		if (!once_only) {
-			once_only = true;
-			pr_warn("Cookie type %s marked page %lx multiple times\n",
-				cookie->def->name, page->index);
-		}
-	}
-
-	if (cookie->def->mark_page_cached)
-		cookie->def->mark_page_cached(cookie->netfs_data,
-					      op->mapping, page);
-}
-EXPORT_SYMBOL(fscache_mark_page_cached);
-
-/**
- * fscache_mark_pages_cached - Mark pages as being cached
- * @op: The retrieval op pages are being marked for
- * @pagevec: The pages to be marked
- *
- * Mark a bunch of netfs pages as being cached.  After this is called,
- * the netfs must call fscache_uncache_page() to remove the mark.
- */
-void fscache_mark_pages_cached(struct fscache_retrieval *op,
-			       struct pagevec *pagevec)
-{
-	unsigned long loop;
-
-	for (loop = 0; loop < pagevec->nr; loop++)
-		fscache_mark_page_cached(op, pagevec->pages[loop]);
-
-	pagevec_reinit(pagevec);
-}
-EXPORT_SYMBOL(fscache_mark_pages_cached);
-
-/*
- * Uncache all the pages in an inode that are marked PG_fscache, assuming them
- * to be associated with the given cookie.
- */
-void __fscache_uncache_all_inode_pages(struct fscache_cookie *cookie,
-				       struct inode *inode)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct pagevec pvec;
-	pgoff_t next;
-	int i;
-
-	_enter("%p,%p", cookie, inode);
-
-	if (!mapping || mapping->nrpages == 0) {
-		_leave(" [no pages]");
-		return;
-	}
-
-	pagevec_init(&pvec);
-	next = 0;
-	do {
-		if (!pagevec_lookup(&pvec, mapping, &next))
-			break;
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-			if (PageFsCache(page)) {
-				__fscache_wait_on_page_write(cookie, page);
-				__fscache_uncache_page(cookie, page);
-			}
-		}
-		pagevec_release(&pvec);
-		cond_resched();
-	} while (next);
-
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_uncache_all_inode_pages);
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index a5aa93ece8c5..281022871e70 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -124,7 +124,6 @@ atomic_t fscache_n_cop_allocate_page;
 atomic_t fscache_n_cop_allocate_pages;
 atomic_t fscache_n_cop_write_page;
 atomic_t fscache_n_cop_uncache_page;
-atomic_t fscache_n_cop_dissociate_pages;
 
 atomic_t fscache_n_cache_no_space_reject;
 atomic_t fscache_n_cache_stale_objects;
@@ -265,14 +264,13 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_cop_put_object),
 		   atomic_read(&fscache_n_cop_attr_changed),
 		   atomic_read(&fscache_n_cop_sync_cache));
-	seq_printf(m, "CacheOp: rap=%d ras=%d alp=%d als=%d wrp=%d ucp=%d dsp=%d\n",
+	seq_printf(m, "CacheOp: rap=%d ras=%d alp=%d als=%d wrp=%d ucp=%d\n",
 		   atomic_read(&fscache_n_cop_read_or_alloc_page),
 		   atomic_read(&fscache_n_cop_read_or_alloc_pages),
 		   atomic_read(&fscache_n_cop_allocate_page),
 		   atomic_read(&fscache_n_cop_allocate_pages),
 		   atomic_read(&fscache_n_cop_write_page),
-		   atomic_read(&fscache_n_cop_uncache_page),
-		   atomic_read(&fscache_n_cop_dissociate_pages));
+		   atomic_read(&fscache_n_cop_uncache_page));
 	seq_printf(m, "CacheEv: nsp=%d stl=%d rtr=%d cul=%d\n",
 		   atomic_read(&fscache_n_cache_no_space_reject),
 		   atomic_read(&fscache_n_cache_stale_objects),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 3f0b19dcfae7..f01fe979b323 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -137,88 +137,6 @@ extern void fscache_operation_init(struct fscache_cookie *,
 				   fscache_operation_cancel_t,
 				   fscache_operation_release_t);
 
-/*
- * data read operation
- */
-struct fscache_retrieval {
-	struct fscache_operation op;
-	struct fscache_cookie	*cookie;	/* The netfs cookie */
-	struct address_space	*mapping;	/* netfs pages */
-	fscache_rw_complete_t	end_io_func;	/* function to call on I/O completion */
-	void			*context;	/* netfs read context (pinned) */
-	struct list_head	to_do;		/* list of things to be done by the backend */
-	unsigned long		start_time;	/* time at which retrieval started */
-	atomic_t		n_pages;	/* number of pages to be retrieved */
-};
-
-typedef int (*fscache_page_retrieval_func_t)(struct fscache_retrieval *op,
-					     struct page *page,
-					     gfp_t gfp);
-
-typedef int (*fscache_pages_retrieval_func_t)(struct fscache_retrieval *op,
-					      struct list_head *pages,
-					      unsigned *nr_pages,
-					      gfp_t gfp);
-
-/**
- * fscache_get_retrieval - Get an extra reference on a retrieval operation
- * @op: The retrieval operation to get a reference on
- *
- * Get an extra reference on a retrieval operation.
- */
-static inline
-struct fscache_retrieval *fscache_get_retrieval(struct fscache_retrieval *op)
-{
-	atomic_inc(&op->op.usage);
-	return op;
-}
-
-/**
- * fscache_enqueue_retrieval - Enqueue a retrieval operation for processing
- * @op: The retrieval operation affected
- *
- * Enqueue a retrieval operation for processing by the FS-Cache thread pool.
- */
-static inline void fscache_enqueue_retrieval(struct fscache_retrieval *op)
-{
-	fscache_enqueue_operation(&op->op);
-}
-
-/**
- * fscache_retrieval_complete - Record (partial) completion of a retrieval
- * @op: The retrieval operation affected
- * @n_pages: The number of pages to account for
- */
-static inline void fscache_retrieval_complete(struct fscache_retrieval *op,
-					      int n_pages)
-{
-	if (atomic_sub_return_relaxed(n_pages, &op->n_pages) <= 0)
-		fscache_op_complete(&op->op, false);
-}
-
-/**
- * fscache_put_retrieval - Drop a reference to a retrieval operation
- * @op: The retrieval operation affected
- *
- * Drop a reference to a retrieval operation.
- */
-static inline void fscache_put_retrieval(struct fscache_retrieval *op)
-{
-	fscache_put_operation(&op->op);
-}
-
-/*
- * cached page storage work item
- * - used to do three things:
- *   - batch writes to the cache
- *   - do cache writes asynchronously
- *   - defer writes until cache object lookup completion
- */
-struct fscache_storage {
-	struct fscache_operation op;
-	pgoff_t			store_limit;	/* don't write more than this */
-};
-
 /*
  * cache operations
  */
@@ -275,35 +193,6 @@ struct fscache_cache_ops {
 
 	/* reserve space for an object's data and associated metadata */
 	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
-
-	/* request a backing block for a page be read or allocated in the
-	 * cache */
-	fscache_page_retrieval_func_t read_or_alloc_page;
-
-	/* request backing blocks for a list of pages be read or allocated in
-	 * the cache */
-	fscache_pages_retrieval_func_t read_or_alloc_pages;
-
-	/* request a backing block for a page be allocated in the cache so that
-	 * it can be written directly */
-	fscache_page_retrieval_func_t allocate_page;
-
-	/* request backing blocks for pages be allocated in the cache so that
-	 * they can be written directly */
-	fscache_pages_retrieval_func_t allocate_pages;
-
-	/* write a page to its backing block in the cache */
-	int (*write_page)(struct fscache_storage *op, struct page *page);
-
-	/* detach backing block from a page (optional)
-	 * - must release the cookie lock before returning
-	 * - may sleep
-	 */
-	void (*uncache_page)(struct fscache_object *object,
-			     struct page *page);
-
-	/* dissociate a cache from all the pages it was backing */
-	void (*dissociate_pages)(struct fscache_cache *cache);
 };
 
 extern struct fscache_cookie fscache_fsdef_index;
@@ -466,21 +355,6 @@ void fscache_set_store_limit(struct fscache_object *object, loff_t i_size)
 		object->store_limit++;
 }
 
-/**
- * fscache_end_io - End a retrieval operation on a page
- * @op: The FS-Cache operation covering the retrieval
- * @page: The page that was to be fetched
- * @error: The error code (0 if successful)
- *
- * Note the end of an operation to retrieve a page, as covered by a particular
- * operation record.
- */
-static inline void fscache_end_io(struct fscache_retrieval *op,
-				  struct page *page, int error)
-{
-	op->end_io_func(page, op->context, error);
-}
-
 static inline void __fscache_use_cookie(struct fscache_cookie *cookie)
 {
 	atomic_inc(&cookie->n_active);
@@ -538,12 +412,6 @@ extern void fscache_withdraw_cache(struct fscache_cache *cache);
 
 extern void fscache_io_error(struct fscache_cache *cache);
 
-extern void fscache_mark_page_cached(struct fscache_retrieval *op,
-				     struct page *page);
-
-extern void fscache_mark_pages_cached(struct fscache_retrieval *op,
-				      struct pagevec *pagevec);
-
 extern bool fscache_object_sleep_till_congested(signed long *timeoutp);
 
 extern enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
diff --git a/include/linux/fscache-obsolete.h b/include/linux/fscache-obsolete.h
new file mode 100644
index 000000000000..8d6d3a3b0d0a
--- /dev/null
+++ b/include/linux/fscache-obsolete.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Obsolete fscache bits
+ *
+ * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_FSCACHE_OBSOLETE_H
+#define _LINUX_FSCACHE_OBSOLETE_H
+
+
+
+#endif /* _LINUX_FSCACHE_OBSOLETE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 2606fe7edd29..143d48281117 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -47,10 +47,6 @@ struct fscache_cache_tag;
 struct fscache_cookie;
 struct fscache_netfs;
 
-typedef void (*fscache_rw_complete_t)(struct page *page,
-				      void *context,
-				      int error);
-
 /* result of index entry consultation */
 enum fscache_checkaux {
 	FSCACHE_CHECKAUX_OKAY,		/* entry okay as is */
@@ -89,27 +85,6 @@ struct fscache_cookie_def {
 					   const void *data,
 					   uint16_t datalen,
 					   loff_t object_size);
-
-	/* get an extra reference on a read context
-	 * - this function can be absent if the completion function doesn't
-	 *   require a context
-	 */
-	void (*get_context)(void *cookie_netfs_data, void *context);
-
-	/* release an extra reference on a read context
-	 * - this function can be absent if the completion function doesn't
-	 *   require a context
-	 */
-	void (*put_context)(void *cookie_netfs_data, void *context);
-
-	/* indicate page that now have cache metadata retained
-	 * - this function should mark the specified page as now being cached
-	 * - the page will have been marked with PG_fscache before this is
-	 *   called, so this is optional
-	 */
-	void (*mark_page_cached)(void *cookie_netfs_data,
-				 struct address_space *mapping,
-				 struct page *page);
 };
 
 /*
@@ -136,16 +111,12 @@ struct fscache_cookie {
 	atomic_t			n_active;	/* number of active users of netfs ptrs */
 	unsigned int			debug_id;
 	spinlock_t			lock;
-	spinlock_t			stores_lock;	/* lock on page store tree */
 	struct hlist_head		backing_objects; /* object(s) backing this file/index */
 	const struct fscache_cookie_def	*def;		/* definition */
 	struct fscache_cookie		*parent;	/* parent of this entry */
 	struct hlist_bl_node		hash_link;	/* Link in hash table */
 	struct list_head		proc_link;	/* Link in proc list */
 	void				*netfs_data;	/* back pointer to netfs */
-	struct radix_tree_root		stores;		/* pages to be stored on this cookie */
-#define FSCACHE_COOKIE_PENDING_TAG	0		/* pages tag: pending write to cache */
-#define FSCACHE_COOKIE_STORING_TAG	1		/* pages tag: writing to cache */
 
 	unsigned long			flags;
 #define FSCACHE_COOKIE_LOOKING_UP	0	/* T if non-index cookie being looked up still */
@@ -202,29 +173,6 @@ extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
 extern int __fscache_attr_changed(struct fscache_cookie *);
 extern void __fscache_invalidate(struct fscache_cookie *);
 extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
-extern int __fscache_read_or_alloc_page(struct fscache_cookie *,
-					struct page *,
-					fscache_rw_complete_t,
-					void *,
-					gfp_t);
-extern int __fscache_read_or_alloc_pages(struct fscache_cookie *,
-					 struct address_space *,
-					 struct list_head *,
-					 unsigned *,
-					 fscache_rw_complete_t,
-					 void *,
-					 gfp_t);
-extern int __fscache_alloc_page(struct fscache_cookie *, struct page *, gfp_t);
-extern int __fscache_write_page(struct fscache_cookie *, struct page *, loff_t, gfp_t);
-extern void __fscache_uncache_page(struct fscache_cookie *, struct page *);
-extern bool __fscache_check_page_write(struct fscache_cookie *, struct page *);
-extern void __fscache_wait_on_page_write(struct fscache_cookie *, struct page *);
-extern bool __fscache_maybe_release_page(struct fscache_cookie *, struct page *,
-					 gfp_t);
-extern void __fscache_uncache_all_inode_pages(struct fscache_cookie *,
-					      struct inode *);
-extern void __fscache_readpages_cancel(struct fscache_cookie *cookie,
-				       struct list_head *pages);
 extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
 extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
 				    bool (*)(void *), void *);
@@ -491,303 +439,6 @@ void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
 		__fscache_wait_on_invalidate(cookie);
 }
 
-/**
- * fscache_reserve_space - Reserve data space for a cached object
- * @cookie: The cookie representing the cache object
- * @i_size: The amount of space to be reserved
- *
- * Reserve an amount of space in the cache for the cache object attached to a
- * cookie so that a write to that object within the space can always be
- * honoured.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_reserve_space(struct fscache_cookie *cookie, loff_t size)
-{
-	return -ENOBUFS;
-}
-
-/**
- * fscache_read_or_alloc_page - Read a page from the cache or allocate a block
- * in which to store it
- * @cookie: The cookie representing the cache object
- * @page: The netfs page to fill if possible
- * @end_io_func: The callback to invoke when and if the page is filled
- * @context: An arbitrary piece of data to pass on to end_io_func()
- * @gfp: The conditions under which memory allocation should be made
- *
- * Read a page from the cache, or if that's not possible make a potential
- * one-block reservation in the cache into which the page may be stored once
- * fetched from the server.
- *
- * If the page is not backed by the cache object, or if it there's some reason
- * it can't be, -ENOBUFS will be returned and nothing more will be done for
- * that page.
- *
- * Else, if that page is backed by the cache, a read will be initiated directly
- * to the netfs's page and 0 will be returned by this function.  The
- * end_io_func() callback will be invoked when the operation terminates on a
- * completion or failure.  Note that the callback may be invoked before the
- * return.
- *
- * Else, if the page is unbacked, -ENODATA is returned and a block may have
- * been allocated in the cache.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_read_or_alloc_page(struct fscache_cookie *cookie,
-			       struct page *page,
-			       fscache_rw_complete_t end_io_func,
-			       void *context,
-			       gfp_t gfp)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_read_or_alloc_page(cookie, page, end_io_func,
-						    context, gfp);
-	else
-		return -ENOBUFS;
-}
-
-/**
- * fscache_read_or_alloc_pages - Read pages from the cache and/or allocate
- * blocks in which to store them
- * @cookie: The cookie representing the cache object
- * @mapping: The netfs inode mapping to which the pages will be attached
- * @pages: A list of potential netfs pages to be filled
- * @nr_pages: Number of pages to be read and/or allocated
- * @end_io_func: The callback to invoke when and if each page is filled
- * @context: An arbitrary piece of data to pass on to end_io_func()
- * @gfp: The conditions under which memory allocation should be made
- *
- * Read a set of pages from the cache, or if that's not possible, attempt to
- * make a potential one-block reservation for each page in the cache into which
- * that page may be stored once fetched from the server.
- *
- * If some pages are not backed by the cache object, or if it there's some
- * reason they can't be, -ENOBUFS will be returned and nothing more will be
- * done for that pages.
- *
- * Else, if some of the pages are backed by the cache, a read will be initiated
- * directly to the netfs's page and 0 will be returned by this function.  The
- * end_io_func() callback will be invoked when the operation terminates on a
- * completion or failure.  Note that the callback may be invoked before the
- * return.
- *
- * Else, if a page is unbacked, -ENODATA is returned and a block may have
- * been allocated in the cache.
- *
- * Because the function may want to return all of -ENOBUFS, -ENODATA and 0 in
- * regard to different pages, the return values are prioritised in that order.
- * Any pages submitted for reading are removed from the pages list.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_read_or_alloc_pages(struct fscache_cookie *cookie,
-				struct address_space *mapping,
-				struct list_head *pages,
-				unsigned *nr_pages,
-				fscache_rw_complete_t end_io_func,
-				void *context,
-				gfp_t gfp)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_read_or_alloc_pages(cookie, mapping, pages,
-						     nr_pages, end_io_func,
-						     context, gfp);
-	else
-		return -ENOBUFS;
-}
-
-/**
- * fscache_alloc_page - Allocate a block in which to store a page
- * @cookie: The cookie representing the cache object
- * @page: The netfs page to allocate a page for
- * @gfp: The conditions under which memory allocation should be made
- *
- * Request Allocation a block in the cache in which to store a netfs page
- * without retrieving any contents from the cache.
- *
- * If the page is not backed by a file then -ENOBUFS will be returned and
- * nothing more will be done, and no reservation will be made.
- *
- * Else, a block will be allocated if one wasn't already, and 0 will be
- * returned
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_alloc_page(struct fscache_cookie *cookie,
-		       struct page *page,
-		       gfp_t gfp)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_alloc_page(cookie, page, gfp);
-	else
-		return -ENOBUFS;
-}
-
-/**
- * fscache_readpages_cancel - Cancel read/alloc on pages
- * @cookie: The cookie representing the inode's cache object.
- * @pages: The netfs pages that we canceled write on in readpages()
- *
- * Uncache/unreserve the pages reserved earlier in readpages() via
- * fscache_readpages_or_alloc() and similar.  In most successful caches in
- * readpages() this doesn't do anything.  In cases when the underlying netfs's
- * readahead failed we need to clean up the pagelist (unmark and uncache).
- *
- * This function may sleep as it may have to clean up disk state.
- */
-static inline
-void fscache_readpages_cancel(struct fscache_cookie *cookie,
-			      struct list_head *pages)
-{
-	if (fscache_cookie_valid(cookie))
-		__fscache_readpages_cancel(cookie, pages);
-}
-
-/**
- * fscache_write_page - Request storage of a page in the cache
- * @cookie: The cookie representing the cache object
- * @page: The netfs page to store
- * @object_size: Updated size of object
- * @gfp: The conditions under which memory allocation should be made
- *
- * Request the contents of the netfs page be written into the cache.  This
- * request may be ignored if no cache block is currently allocated, in which
- * case it will return -ENOBUFS.
- *
- * If a cache block was already allocated, a write will be initiated and 0 will
- * be returned.  The PG_fscache_write page bit is set immediately and will then
- * be cleared at the completion of the write to indicate the success or failure
- * of the operation.  Note that the completion may happen before the return.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_write_page(struct fscache_cookie *cookie,
-		       struct page *page,
-		       loff_t object_size,
-		       gfp_t gfp)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_write_page(cookie, page, object_size, gfp);
-	else
-		return -ENOBUFS;
-}
-
-/**
- * fscache_uncache_page - Indicate that caching is no longer required on a page
- * @cookie: The cookie representing the cache object
- * @page: The netfs page that was being cached.
- *
- * Tell the cache that we no longer want a page to be cached and that it should
- * remove any knowledge of the netfs page it may have.
- *
- * Note that this cannot cancel any outstanding I/O operations between this
- * page and the cache.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_uncache_page(struct fscache_cookie *cookie,
-			  struct page *page)
-{
-	if (fscache_cookie_valid(cookie))
-		__fscache_uncache_page(cookie, page);
-}
-
-/**
- * fscache_check_page_write - Ask if a page is being writing to the cache
- * @cookie: The cookie representing the cache object
- * @page: The netfs page that is being cached.
- *
- * Ask the cache if a page is being written to the cache.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-bool fscache_check_page_write(struct fscache_cookie *cookie,
-			      struct page *page)
-{
-	if (fscache_cookie_valid(cookie))
-		return __fscache_check_page_write(cookie, page);
-	return false;
-}
-
-/**
- * fscache_wait_on_page_write - Wait for a page to complete writing to the cache
- * @cookie: The cookie representing the cache object
- * @page: The netfs page that is being cached.
- *
- * Ask the cache to wake us up when a page is no longer being written to the
- * cache.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_wait_on_page_write(struct fscache_cookie *cookie,
-				struct page *page)
-{
-	if (fscache_cookie_valid(cookie))
-		__fscache_wait_on_page_write(cookie, page);
-}
-
-/**
- * fscache_maybe_release_page - Consider releasing a page, cancelling a store
- * @cookie: The cookie representing the cache object
- * @page: The netfs page that is being cached.
- * @gfp: The gfp flags passed to releasepage()
- *
- * Consider releasing a page for the vmscan algorithm, on behalf of the netfs's
- * releasepage() call.  A storage request on the page may cancelled if it is
- * not currently being processed.
- *
- * The function returns true if the page no longer has a storage request on it,
- * and false if a storage request is left in place.  If true is returned, the
- * page will have been passed to fscache_uncache_page().  If false is returned
- * the page cannot be freed yet.
- */
-static inline
-bool fscache_maybe_release_page(struct fscache_cookie *cookie,
-				struct page *page,
-				gfp_t gfp)
-{
-	if (fscache_cookie_valid(cookie) && PageFsCache(page))
-		return __fscache_maybe_release_page(cookie, page, gfp);
-	return true;
-}
-
-/**
- * fscache_uncache_all_inode_pages - Uncache all an inode's pages
- * @cookie: The cookie representing the inode's cache object.
- * @inode: The inode to uncache pages from.
- *
- * Uncache all the pages in an inode that are marked PG_fscache, assuming them
- * to be associated with the given cookie.
- *
- * This function may sleep.  It will wait for pages that are being written out
- * and will wait whilst the PG_fscache mark is removed by the cache.
- */
-static inline
-void fscache_uncache_all_inode_pages(struct fscache_cookie *cookie,
-				     struct inode *inode)
-{
-	if (fscache_cookie_valid(cookie))
-		__fscache_uncache_all_inode_pages(cookie, inode);
-}
-
 /**
  * fscache_disable_cookie - Disable a cookie
  * @cookie: The cookie representing the cache object


