Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A36A8CE7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCBXVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCBXVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C955119B6
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677799251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BTUiF+GY1waT+xMwvvMmWYfbj3+0BAFFbw2niqb1y8=;
        b=R6jfsMxvH1He+SPIKCwtFCjFr/Byhy+31hGZeJxORWraqINvmmXyWgCpsrYl2hXBUDjrsG
        4eYLFy8zYp7V0KYiK5WLLGiv6mIRXSRsMI7Sd0slisZQ26D9daU5pCftOxd69AIr562yWo
        agsh8H++Gbc4w6CW0MMb2opSpCtuUL8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-Brb1r7lLMleA_juSJAxiDQ-1; Thu, 02 Mar 2023 18:20:48 -0500
X-MC-Unique: Brb1r7lLMleA_juSJAxiDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4993E811E9C;
        Thu,  2 Mar 2023 23:20:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CF602026D4B;
        Thu,  2 Mar 2023 23:20:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230302231638.521280-1-dhowells@redhat.com>
References: <20230302231638.521280-1-dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Vishal Moola <vishal.moola@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Paulo Alcantara <pc@cjr.nz>, Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] smb3, afs: Revert changes to {cifs,afs}_writepages_region()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <521518.1677799244.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 02 Mar 2023 23:20:44 +0000
Message-ID: <521519.1677799244@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> AFS firstly. ...
> =

>   Base + write_cache_pages():
> 	WRITE: bw=3D280MiB/s (294MB/s), 69.7MiB/s-70.5MiB/s (73.0MB/s-73.9MB/s)
> 	WRITE: bw=3D285MiB/s (299MB/s), 70.9MiB/s-71.5MiB/s (74.4MB/s-74.9MB/s)
> 	WRITE: bw=3D290MiB/s (304MB/s), 71.6MiB/s-73.2MiB/s (75.1MB/s-76.8MB/s)

Here's the patch to convert AFS to use write_cache_pages(), retaining the =
use
of page->private to track the dirtied part of the page.

David
---
 write.c |  382 +++++++++++++---------------------------------------------=
------
 1 file changed, 78 insertions(+), 304 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 571f3b9a417e..01323fa58e1c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -14,11 +14,6 @@
 #include <linux/netfs.h>
 #include "internal.h"
 =

-static int afs_writepages_region(struct address_space *mapping,
-				 struct writeback_control *wbc,
-				 loff_t start, loff_t end, loff_t *_next,
-				 bool max_one_loop);
-
 static void afs_write_to_cache(struct afs_vnode *vnode, loff_t start, siz=
e_t len,
 			       loff_t i_size, bool caching);
 =

@@ -56,10 +51,8 @@ static int afs_flush_conflicting_write(struct address_s=
pace *mapping,
 		.range_start	=3D folio_pos(folio),
 		.range_end	=3D LLONG_MAX,
 	};
-	loff_t next;
 =

-	return afs_writepages_region(mapping, &wbc, folio_pos(folio), LLONG_MAX,
-				     &next, true);
+	return afs_writepages(mapping, &wbc);
 }
 =

 /*
@@ -449,212 +442,57 @@ static int afs_store_data(struct afs_vnode *vnode, =
struct iov_iter *iter, loff_t
 	return afs_put_operation(op);
 }
 =

-/*
- * Extend the region to be written back to include subsequent contiguousl=
y
- * dirty pages if possible, but don't sleep while doing so.
- *
- * If this page holds new content, then we can include filler zeros in th=
e
- * writeback.
- */
-static void afs_extend_writeback(struct address_space *mapping,
-				 struct afs_vnode *vnode,
-				 long *_count,
-				 loff_t start,
-				 loff_t max_len,
-				 bool new_content,
-				 bool caching,
-				 unsigned int *_len)
-{
-	struct pagevec pvec;
-	struct folio *folio;
-	unsigned long priv;
-	unsigned int psize, filler =3D 0;
-	unsigned int f, t;
-	loff_t len =3D *_len;
-	pgoff_t index =3D (start + len) / PAGE_SIZE;
-	bool stop =3D true;
-	unsigned int i;
-
-	XA_STATE(xas, &mapping->i_pages, index);
-	pagevec_init(&pvec);
-
-	do {
-		/* Firstly, we gather up a batch of contiguous dirty pages
-		 * under the RCU read lock - but we can't clear the dirty flags
-		 * there if any of those pages are mapped.
-		 */
-		rcu_read_lock();
-
-		xas_for_each(&xas, folio, ULONG_MAX) {
-			stop =3D true;
-			if (xas_retry(&xas, folio))
-				continue;
-			if (xa_is_value(folio))
-				break;
-			if (folio_index(folio) !=3D index)
-				break;
-
-			if (!folio_try_get_rcu(folio)) {
-				xas_reset(&xas);
-				continue;
-			}
-
-			/* Has the page moved or been split? */
-			if (unlikely(folio !=3D xas_reload(&xas))) {
-				folio_put(folio);
-				break;
-			}
-
-			if (!folio_trylock(folio)) {
-				folio_put(folio);
-				break;
-			}
-			if (!folio_test_dirty(folio) ||
-			    folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				folio_put(folio);
-				break;
-			}
-
-			psize =3D folio_size(folio);
-			priv =3D (unsigned long)folio_get_private(folio);
-			f =3D afs_folio_dirty_from(folio, priv);
-			t =3D afs_folio_dirty_to(folio, priv);
-			if (f !=3D 0 && !new_content) {
-				folio_unlock(folio);
-				folio_put(folio);
-				break;
-			}
-
-			len +=3D filler + t;
-			filler =3D psize - t;
-			if (len >=3D max_len || *_count <=3D 0)
-				stop =3D true;
-			else if (t =3D=3D psize || new_content)
-				stop =3D false;
-
-			index +=3D folio_nr_pages(folio);
-			if (!pagevec_add(&pvec, &folio->page))
-				break;
-			if (stop)
-				break;
-		}
-
-		if (!stop)
-			xas_pause(&xas);
-		rcu_read_unlock();
-
-		/* Now, if we obtained any pages, we can shift them to being
-		 * writable and mark them for caching.
-		 */
-		if (!pagevec_count(&pvec))
-			break;
-
-		for (i =3D 0; i < pagevec_count(&pvec); i++) {
-			folio =3D page_folio(pvec.pages[i]);
-			trace_afs_folio_dirty(vnode, tracepoint_string("store+"), folio);
-
-			if (!folio_clear_dirty_for_io(folio))
-				BUG();
-			if (folio_start_writeback(folio))
-				BUG();
-			afs_folio_start_fscache(caching, folio);
-
-			*_count -=3D folio_nr_pages(folio);
-			folio_unlock(folio);
-		}
-
-		pagevec_release(&pvec);
-		cond_resched();
-	} while (!stop);
-
-	*_len =3D len;
-}
+struct afs_writepages_context {
+	unsigned long long	start;
+	unsigned long long	end;
+	unsigned long long	annex_at;
+	bool			begun;
+	bool			caching;
+	bool			new_content;
+};
 =

 /*
- * Synchronously write back the locked page and any subsequent non-locked=
 dirty
- * pages.
+ * Flush a block of pages to the server and the cache.
  */
-static ssize_t afs_write_back_from_locked_folio(struct address_space *map=
ping,
-						struct writeback_control *wbc,
-						struct folio *folio,
-						loff_t start, loff_t end)
+static int afs_writepages_submit(struct address_space *mapping,
+				 struct writeback_control *wbc,
+				 struct afs_writepages_context *ctx)
 {
 	struct afs_vnode *vnode =3D AFS_FS_I(mapping->host);
 	struct iov_iter iter;
-	unsigned long priv;
-	unsigned int offset, to, len, max_len;
-	loff_t i_size =3D i_size_read(&vnode->netfs.inode);
-	bool new_content =3D test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
-	bool caching =3D fscache_cookie_enabled(afs_vnode_cache(vnode));
-	long count =3D wbc->nr_to_write;
+	unsigned long long i_size =3D i_size_read(&vnode->netfs.inode);
+	size_t len =3D ctx->end - ctx->start;
 	int ret;
 =

-	_enter(",%lx,%llx-%llx", folio_index(folio), start, end);
-
-	if (folio_start_writeback(folio))
-		BUG();
-	afs_folio_start_fscache(caching, folio);
-
-	count -=3D folio_nr_pages(folio);
-
-	/* Find all consecutive lockable dirty pages that have contiguous
-	 * written regions, stopping when we find a page that is not
-	 * immediately lockable, is not dirty or is missing, or we reach the
-	 * end of the range.
-	 */
-	priv =3D (unsigned long)folio_get_private(folio);
-	offset =3D afs_folio_dirty_from(folio, priv);
-	to =3D afs_folio_dirty_to(folio, priv);
-	trace_afs_folio_dirty(vnode, tracepoint_string("store"), folio);
-
-	len =3D to - offset;
-	start +=3D offset;
-	if (start < i_size) {
-		/* Trim the write to the EOF; the extra data is ignored.  Also
-		 * put an upper limit on the size of a single storedata op.
-		 */
-		max_len =3D 65536 * 4096;
-		max_len =3D min_t(unsigned long long, max_len, end - start + 1);
-		max_len =3D min_t(unsigned long long, max_len, i_size - start);
-
-		if (len < max_len &&
-		    (to =3D=3D folio_size(folio) || new_content))
-			afs_extend_writeback(mapping, vnode, &count,
-					     start, max_len, new_content,
-					     caching, &len);
-		len =3D min_t(loff_t, len, max_len);
-	}
+	_enter("%llx-%llx", ctx->start, ctx->start + len - 1);
 =

 	/* We now have a contiguous set of dirty pages, each with writeback
-	 * set; the first page is still locked at this point, but all the rest
-	 * have been unlocked.
+	 * set.
 	 */
-	folio_unlock(folio);
-
-	if (start < i_size) {
-		_debug("write back %x @%llx [%llx]", len, start, i_size);
+	if (ctx->start < i_size) {
+		if (len > i_size - ctx->start)
+			len =3D i_size - ctx->start;
+		_debug("write back %zx @%llx [%llx]", len, ctx->start, i_size);
 =

 		/* Speculatively write to the cache.  We have to fix this up
 		 * later if the store fails.
 		 */
-		afs_write_to_cache(vnode, start, len, i_size, caching);
+		afs_write_to_cache(vnode, ctx->start, len, i_size, ctx->caching);
 =

-		iov_iter_xarray(&iter, ITER_SOURCE, &mapping->i_pages, start, len);
-		ret =3D afs_store_data(vnode, &iter, start, false);
+		iov_iter_xarray(&iter, ITER_SOURCE,
+				&mapping->i_pages, ctx->start, len);
+		ret =3D afs_store_data(vnode, &iter, ctx->start, false);
 	} else {
-		_debug("write discard %x @%llx [%llx]", len, start, i_size);
+		_debug("write discard %zx @%llx [%llx]", len, ctx->start, i_size);
 =

 		/* The dirty region was entirely beyond the EOF. */
-		fscache_clear_page_bits(mapping, start, len, caching);
-		afs_pages_written_back(vnode, start, len);
+		fscache_clear_page_bits(mapping, ctx->start, len, ctx->caching);
+		afs_pages_written_back(vnode, ctx->start, len);
 		ret =3D 0;
 	}
 =

 	switch (ret) {
 	case 0:
-		wbc->nr_to_write =3D count;
 		ret =3D len;
 		break;
 =

@@ -668,13 +506,13 @@ static ssize_t afs_write_back_from_locked_folio(stru=
ct address_space *mapping,
 	case -EKEYREJECTED:
 	case -EKEYREVOKED:
 	case -ENETRESET:
-		afs_redirty_pages(wbc, mapping, start, len);
+		afs_redirty_pages(wbc, mapping, ctx->start, len);
 		mapping_set_error(mapping, ret);
 		break;
 =

 	case -EDQUOT:
 	case -ENOSPC:
-		afs_redirty_pages(wbc, mapping, start, len);
+		afs_redirty_pages(wbc, mapping, ctx->start, len);
 		mapping_set_error(mapping, -ENOSPC);
 		break;
 =

@@ -686,7 +524,7 @@ static ssize_t afs_write_back_from_locked_folio(struct=
 address_space *mapping,
 	case -ENOMEDIUM:
 	case -ENXIO:
 		trace_afs_file_error(vnode, ret, afs_file_error_writeback_fail);
-		afs_kill_pages(mapping, start, len);
+		afs_kill_pages(mapping, ctx->start, len);
 		mapping_set_error(mapping, ret);
 		break;
 	}
@@ -696,100 +534,51 @@ static ssize_t afs_write_back_from_locked_folio(str=
uct address_space *mapping,
 }
 =

 /*
- * write a region of pages back to the server
+ * Add a page to the set and flush when large enough.
  */
-static int afs_writepages_region(struct address_space *mapping,
-				 struct writeback_control *wbc,
-				 loff_t start, loff_t end, loff_t *_next,
-				 bool max_one_loop)
+static int afs_writepages_add_folio(struct folio *folio,
+				    struct writeback_control *wbc, void *data)
 {
-	struct folio *folio;
-	struct folio_batch fbatch;
-	ssize_t ret;
-	unsigned int i;
-	int n, skips =3D 0;
-
-	_enter("%llx,%llx,", start, end);
-	folio_batch_init(&fbatch);
-
-	do {
-		pgoff_t index =3D start / PAGE_SIZE;
+	struct afs_writepages_context *ctx =3D data;
+	struct afs_vnode *vnode =3D AFS_FS_I(folio->mapping->host);
+	unsigned long long pos =3D folio_pos(folio);
+	unsigned long priv;
+	size_t f, t;
+	int ret;
 =

-		n =3D filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					PAGECACHE_TAG_DIRTY, &fbatch);
+	priv =3D (unsigned long)folio_get_private(folio);
+	f =3D afs_folio_dirty_from(folio, priv);
+	t =3D afs_folio_dirty_to(folio, priv);
 =

-		if (!n)
-			break;
-		for (i =3D 0; i < n; i++) {
-			folio =3D fbatch.folios[i];
-			start =3D folio_pos(folio); /* May regress with THPs */
-
-			_debug("wback %lx", folio_index(folio));
-
-			/* At this point we hold neither the i_pages lock nor the
-			 * page lock: the page may be truncated or invalidated
-			 * (changing page->mapping to NULL), or even swizzled
-			 * back from swapper_space to tmpfs file mapping
-			 */
-			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
-				ret =3D folio_lock_killable(folio);
-				if (ret < 0) {
-					folio_batch_release(&fbatch);
-					return ret;
-				}
-			} else {
-				if (!folio_trylock(folio))
-					continue;
-			}
-
-			if (folio->mapping !=3D mapping ||
-			    !folio_test_dirty(folio)) {
-				start +=3D folio_size(folio);
-				folio_unlock(folio);
-				continue;
-			}
-
-			if (folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				if (wbc->sync_mode !=3D WB_SYNC_NONE) {
-					folio_wait_writeback(folio);
-#ifdef CONFIG_AFS_FSCACHE
-					folio_wait_fscache(folio);
-#endif
-				} else {
-					start +=3D folio_size(folio);
-				}
-				if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
-					if (skips >=3D 5 || need_resched()) {
-						*_next =3D start;
-						_leave(" =3D 0 [%llx]", *_next);
-						return 0;
-					}
-					skips++;
-				}
-				continue;
-			}
-
-			if (!folio_clear_dirty_for_io(folio))
-				BUG();
-			ret =3D afs_write_back_from_locked_folio(mapping, wbc,
-					folio, start, end);
-			if (ret < 0) {
-				_leave(" =3D %zd", ret);
-				folio_batch_release(&fbatch);
-				return ret;
-			}
-
-			start +=3D ret;
+	if (ctx->begun) {
+		if ((f =3D=3D 0 || ctx->new_content) &&
+		    pos =3D=3D ctx->annex_at) {
+			trace_afs_folio_dirty(vnode, tracepoint_string("store+"), folio);
+			goto add;
 		}
+		ret =3D afs_writepages_submit(folio->mapping, wbc, ctx);
+		if (ret < 0)
+			return ret;
+	}
+
+	ctx->begun	=3D true;
+	ctx->start	=3D pos + f;
+	trace_afs_folio_dirty(vnode, tracepoint_string("store"), folio);
+add:
+	ctx->end	=3D pos + t;
+	ctx->annex_at	=3D pos + folio_size(folio);
 =

-		folio_batch_release(&fbatch);
-		cond_resched();
-	} while (wbc->nr_to_write > 0);
+	folio_wait_fscache(folio);
+	folio_start_writeback(folio);
+	afs_folio_start_fscache(ctx->caching, folio);
+	folio_unlock(folio);
 =

-	*_next =3D start;
-	_leave(" =3D 0 [%llx]", *_next);
+	if (ctx->end - ctx->start >=3D 65536 * 4096) {
+		ret =3D afs_writepages_submit(folio->mapping, wbc, ctx);
+		if (ret < 0)
+			return ret;
+		ctx->begun =3D false;
+	}
 	return 0;
 }
 =

@@ -800,7 +589,10 @@ int afs_writepages(struct address_space *mapping,
 		   struct writeback_control *wbc)
 {
 	struct afs_vnode *vnode =3D AFS_FS_I(mapping->host);
-	loff_t start, next;
+	struct afs_writepages_context ctx =3D {
+		.caching	=3D fscache_cookie_enabled(afs_vnode_cache(vnode)),
+		.new_content	=3D test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags),
+	};
 	int ret;
 =

 	_enter("");
@@ -814,29 +606,11 @@ int afs_writepages(struct address_space *mapping,
 	else if (!down_read_trylock(&vnode->validate_lock))
 		return 0;
 =

-	if (wbc->range_cyclic) {
-		start =3D mapping->writeback_index * PAGE_SIZE;
-		ret =3D afs_writepages_region(mapping, wbc, start, LLONG_MAX,
-					    &next, false);
-		if (ret =3D=3D 0) {
-			mapping->writeback_index =3D next / PAGE_SIZE;
-			if (start > 0 && wbc->nr_to_write > 0) {
-				ret =3D afs_writepages_region(mapping, wbc, 0,
-							    start, &next, false);
-				if (ret =3D=3D 0)
-					mapping->writeback_index =3D
-						next / PAGE_SIZE;
-			}
-		}
-	} else if (wbc->range_start =3D=3D 0 && wbc->range_end =3D=3D LLONG_MAX)=
 {
-		ret =3D afs_writepages_region(mapping, wbc, 0, LLONG_MAX,
-					    &next, false);
-		if (wbc->nr_to_write > 0 && ret =3D=3D 0)
-			mapping->writeback_index =3D next / PAGE_SIZE;
-	} else {
-		ret =3D afs_writepages_region(mapping, wbc,
-					    wbc->range_start, wbc->range_end,
-					    &next, false);
+	ret =3D write_cache_pages(mapping, wbc, afs_writepages_add_folio, &ctx);
+	if (ret >=3D 0 && ctx.begun) {
+		ret =3D afs_writepages_submit(mapping, wbc, &ctx);
+		if (ret < 0)
+			return ret;
 	}
 =

 	up_read(&vnode->validate_lock);

