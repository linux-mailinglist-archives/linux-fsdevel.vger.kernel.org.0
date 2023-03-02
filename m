Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211716A8D0A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCBXas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCBXar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:30:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66392A6CE
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677799756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdbgiP9LCPjNxn4My99O9GNXAepHwTDUFs+lEdKaBzo=;
        b=QchQeLneepxDJOHMgk2RgXDzrhfF2Ix/RRWC+5eR+zkOJj6xfCGSgH8fMkhcBl4wm5hS2z
        t0vr1JZUL/vCN5+6WI4ToHVVct+VLf36UiYLXtB74jM+1YeIBkxZJ61eytrCw3tUVGxL+3
        bQbzpUJyJMkNyE9ndWTUoEkgHGFgWCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-lwSYOI6QPLKykvSFgInyrQ-1; Thu, 02 Mar 2023 18:29:13 -0500
X-MC-Unique: lwSYOI6QPLKykvSFgInyrQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 834E6800B23;
        Thu,  2 Mar 2023 23:29:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD1E492C3E;
        Thu,  2 Mar 2023 23:29:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <521671.1677799421@warthog.procyon.org.uk>
References: <521671.1677799421@warthog.procyon.org.uk> <20230302231638.521280-1-dhowells@redhat.com>
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
Subject: Test patch to make afs use write_cache_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <521913.1677799750.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 02 Mar 2023 23:29:10 +0000
Message-ID: <521914.1677799750@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> AFS firstly. ...
> =

>   Base + Page-dirty-region tracking removed +  write_cache_pages():
> 	WRITE: bw=3D288MiB/s (302MB/s), 71.9MiB/s-72.3MiB/s (75.4MB/s-75.8MB/s)
> 	WRITE: bw=3D284MiB/s (297MB/s), 70.7MiB/s-71.3MiB/s (74.1MB/s-74.8MB/s)
> 	WRITE: bw=3D287MiB/s (301MB/s), 71.2MiB/s-72.6MiB/s (74.7MB/s-76.1MB/s)

Here's a patch to make afs use write_cache_pages() with no per-page dirty
region tracking.  afs_extend_writeback() is removed and the folios are
accumulated via a callback function.

This goes on top of "Test patch to remove per-page dirty region tracking f=
rom
afs".

David
---
 write.c |  345 ++++++++++++----------------------------------------------=
------
 1 file changed, 67 insertions(+), 278 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index d2f6623c8eab..af414b72d42a 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -371,193 +371,55 @@ static int afs_store_data(struct afs_vnode *vnode, =
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
-	struct folio_batch batch;
-	struct folio *folio;
-	size_t psize;
-	loff_t len =3D *_len;
-	pgoff_t index =3D (start + len) / PAGE_SIZE;
-	bool stop =3D true;
-	unsigned int i;
-	XA_STATE(xas, &mapping->i_pages, index);
-
-	folio_batch_init(&batch);
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
-			len +=3D psize;
-			stop =3D false;
-			if (len >=3D max_len || *_count <=3D 0)
-				stop =3D true;
-
-			index +=3D folio_nr_pages(folio);
-			if (!folio_batch_add(&batch, folio))
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
-		if (!folio_batch_count(&batch))
-			break;
-
-		for (i =3D 0; i < folio_batch_count(&batch); i++) {
-			folio =3D batch.folios[i];
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
-		folio_batch_release(&batch);
-		cond_resched();
-	} while (!stop);
-
-	*_len =3D len;
-}
+struct afs_writepages_context {
+	unsigned long long	start;
+	size_t			len;
+	bool			begun;
+	bool			caching;
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
-	unsigned int len, max_len;
-	loff_t i_size =3D i_size_read(&vnode->netfs.inode);
-	bool new_content =3D test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
-	bool caching =3D fscache_cookie_enabled(afs_vnode_cache(vnode));
-	long count =3D wbc->nr_to_write;
+	unsigned long long i_size =3D i_size_read(&vnode->netfs.inode);
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
-	/* Find all consecutive lockable dirty pages, stopping when we find a
-	 * page that is not immediately lockable, is not dirty or is missing,
-	 * or we reach the end of the range.
-	 */
-	trace_afs_folio_dirty(vnode, tracepoint_string("store"), folio);
-
-	len =3D folio_size(folio);
-	start =3D folio_pos(folio);
-	if (start < i_size) {
-		/* Trim the write to the EOF; the extra data is ignored.  Also
-		 * put an upper limit on the size of a single storedata op.
-		 */
-		max_len =3D 65536 * 4096;
-		max_len =3D min_t(unsigned long long, max_len, end - start + 1);
-		max_len =3D min_t(unsigned long long, max_len, i_size - start);
-
-		if (len < max_len)
-			afs_extend_writeback(mapping, vnode, &count,
-					     start, max_len, new_content,
-					     caching, &len);
-		len =3D min_t(loff_t, len, max_len);
-	}
+	_enter("%llx-%llx", ctx->start, ctx->start + ctx->len - 1);
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
+		if (ctx->len > i_size - ctx->start)
+			ctx->len =3D i_size - ctx->start;
+		_debug("write back %zx @%llx [%llx]", ctx->len, ctx->start, i_size);
 =

 		/* Speculatively write to the cache.  We have to fix this up
 		 * later if the store fails.
 		 */
-		afs_write_to_cache(vnode, start, len, i_size, caching);
+		afs_write_to_cache(vnode, ctx->start, ctx->len, i_size, ctx->caching);
 =

-		iov_iter_xarray(&iter, ITER_SOURCE, &mapping->i_pages, start, len);
-		ret =3D afs_store_data(vnode, &iter, start, false);
+		iov_iter_xarray(&iter, ITER_SOURCE,
+				&mapping->i_pages, ctx->start, ctx->len);
+		ret =3D afs_store_data(vnode, &iter, ctx->start, false);
 	} else {
-		_debug("write discard %x @%llx [%llx]", len, start, i_size);
+		_debug("write discard %zx @%llx [%llx]", ctx->len, ctx->start, i_size);
 =

 		/* The dirty region was entirely beyond the EOF. */
-		fscache_clear_page_bits(mapping, start, len, caching);
-		afs_pages_written_back(vnode, start, len);
+		fscache_clear_page_bits(mapping, ctx->start, ctx->len, ctx->caching);
+		afs_pages_written_back(vnode, ctx->start, ctx->len);
 		ret =3D 0;
 	}
 =

 	switch (ret) {
 	case 0:
-		wbc->nr_to_write =3D count;
-		ret =3D len;
+		ret =3D ctx->len;
 		break;
 =

 	default:
@@ -570,13 +432,13 @@ static ssize_t afs_write_back_from_locked_folio(stru=
ct address_space *mapping,
 	case -EKEYREJECTED:
 	case -EKEYREVOKED:
 	case -ENETRESET:
-		afs_redirty_pages(wbc, mapping, start, len);
+		afs_redirty_pages(wbc, mapping, ctx->start, ctx->len);
 		mapping_set_error(mapping, ret);
 		break;
 =

 	case -EDQUOT:
 	case -ENOSPC:
-		afs_redirty_pages(wbc, mapping, start, len);
+		afs_redirty_pages(wbc, mapping, ctx->start, ctx->len);
 		mapping_set_error(mapping, -ENOSPC);
 		break;
 =

@@ -588,7 +450,7 @@ static ssize_t afs_write_back_from_locked_folio(struct=
 address_space *mapping,
 	case -ENOMEDIUM:
 	case -ENXIO:
 		trace_afs_file_error(vnode, ret, afs_file_error_writeback_fail);
-		afs_kill_pages(mapping, start, len);
+		afs_kill_pages(mapping, ctx->start, ctx->len);
 		mapping_set_error(mapping, ret);
 		break;
 	}
@@ -598,100 +460,43 @@ static ssize_t afs_write_back_from_locked_folio(str=
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
-
-		n =3D filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					PAGECACHE_TAG_DIRTY, &fbatch);
+	struct afs_writepages_context *ctx =3D data;
+	struct afs_vnode *vnode =3D AFS_FS_I(folio->mapping->host);
+	int ret;
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
+		if (folio_pos(folio) =3D=3D ctx->start + ctx->len) {
+			trace_afs_folio_dirty(vnode, tracepoint_string("store+"), folio);
+			goto add;
 		}
+		ret =3D afs_writepages_submit(folio->mapping, wbc, ctx);
+		if (ret < 0)
+			return ret;
+	}
 =

-		folio_batch_release(&fbatch);
-		cond_resched();
-	} while (wbc->nr_to_write > 0);
+	ctx->begun =3D true;
+	ctx->start =3D folio_pos(folio);
+	ctx->len =3D 0;
+	trace_afs_folio_dirty(vnode, tracepoint_string("store"), folio);
+add:
+	ctx->len +=3D folio_size(folio);
 =

-	*_next =3D start;
-	_leave(" =3D 0 [%llx]", *_next);
+	folio_wait_fscache(folio);
+	folio_start_writeback(folio);
+	afs_folio_start_fscache(ctx->caching, folio);
+	folio_unlock(folio);
+
+	if (ctx->len >=3D 65536 * 4096) {
+		ret =3D afs_writepages_submit(folio->mapping, wbc, ctx);
+		if (ret < 0)
+			return ret;
+		ctx->begun =3D false;
+	}
 	return 0;
 }
 =

@@ -702,7 +507,9 @@ int afs_writepages(struct address_space *mapping,
 		   struct writeback_control *wbc)
 {
 	struct afs_vnode *vnode =3D AFS_FS_I(mapping->host);
-	loff_t start, next;
+	struct afs_writepages_context ctx =3D {
+		.caching =3D fscache_cookie_enabled(afs_vnode_cache(vnode)),
+	};
 	int ret;
 =

 	_enter("");
@@ -716,29 +523,11 @@ int afs_writepages(struct address_space *mapping,
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

