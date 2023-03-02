Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1AC6A8D1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCBXhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCBXhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:37:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BE2584AC
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677800223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfB+4L/9Skhmwx3bsII6X8Q4qh3L+58o2DaPND89LWc=;
        b=bltaocvEATTM45BMeVr/PccQxnCP6+gJWCwCDm1RTzBFneL0eJIZr1tGm/wksSMSlOB43e
        13mJtc00RiLNfdS6sef37Cuo1ZVn10dPFNbPIk2GOb7QMn/3tvBz9kVf4909YuVMiBpHFw
        9YpGHHAZJ+th+qyxo/ca3XFLvWQeGtY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-TCftiIv7MNuWSIH4rQMgEw-1; Thu, 02 Mar 2023 18:36:52 -0500
X-MC-Unique: TCftiIv7MNuWSIH4rQMgEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B5DC87A382;
        Thu,  2 Mar 2023 23:36:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6ED2140EBF6;
        Thu,  2 Mar 2023 23:36:49 +0000 (UTC)
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
Subject: cifs test patch to convert to using write_cache_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <522330.1677800209.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 02 Mar 2023 23:36:49 +0000
Message-ID: <522331.1677800209@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> And then CIFS. ...
> =

>   Base + write_cache_pages():
> 	WRITE: bw=3D457MiB/s (479MB/s), 114MiB/s-114MiB/s (120MB/s-120MB/s)
> 	WRITE: bw=3D449MiB/s (471MB/s), 112MiB/s-113MiB/s (118MB/s-118MB/s)
> 	WRITE: bw=3D459MiB/s (482MB/s), 115MiB/s-115MiB/s (120MB/s-121MB/s)

Here's my patch to convert cifs to use write_cache_pages().

David
---
 fs/cifs/file.c |  400 ++++++++++++++++-----------------------------------=
------
 1 file changed, 115 insertions(+), 285 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 3d304d4a54d6..04e2466609d9 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2613,140 +2613,35 @@ static int cifs_partialpagewrite(struct page *pag=
e, unsigned from, unsigned to)
 	return rc;
 }
 =

-/*
- * Extend the region to be written back to include subsequent contiguousl=
y
- * dirty pages if possible, but don't sleep while doing so.
- */
-static void cifs_extend_writeback(struct address_space *mapping,
-				  long *_count,
-				  loff_t start,
-				  int max_pages,
-				  size_t max_len,
-				  unsigned int *_len)
-{
-	struct folio_batch batch;
-	struct folio *folio;
-	unsigned int psize, nr_pages;
-	size_t len =3D *_len;
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
-			nr_pages =3D folio_nr_pages(folio);
-			if (nr_pages > max_pages)
-				break;
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
-			if (!folio_test_dirty(folio) || folio_test_writeback(folio)) {
-				folio_unlock(folio);
-				folio_put(folio);
-				break;
-			}
-
-			psize =3D folio_size(folio);
-			len +=3D psize;
-			stop =3D false;
-			if (max_pages <=3D 0 || len >=3D max_len || *_count <=3D 0)
-				stop =3D true;
-
-			index +=3D nr_pages;
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
-			/* The folio should be locked, dirty and not undergoing
-			 * writeback from the loop above.
-			 */
-			if (!folio_clear_dirty_for_io(folio))
-				WARN_ON(1);
-			if (folio_start_writeback(folio))
-				WARN_ON(1);
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
+struct cifs_writepages_context {
+	struct cifs_writedata	*wdata;
+	struct TCP_Server_Info	*server;
+	struct cifs_credits	credits;
+	unsigned long long	start;
+	size_t			len;
+	size_t			wsize;
+	unsigned int		xid;
+	bool			begun;
+	bool			caching;
+};
 =

 /*
- * Write back the locked page and any subsequent non-locked dirty pages.
+ * Set up a writeback op.
  */
-static ssize_t cifs_write_back_from_locked_folio(struct address_space *ma=
pping,
-						 struct writeback_control *wbc,
-						 struct folio *folio,
-						 loff_t start, loff_t end)
+static int cifs_writeback_begin(struct address_space *mapping,
+				struct writeback_control *wbc,
+				unsigned long long start,
+				struct cifs_writepages_context *ctx)
 {
 	struct inode *inode =3D mapping->host;
 	struct TCP_Server_Info *server;
 	struct cifs_writedata *wdata;
 	struct cifs_sb_info *cifs_sb =3D CIFS_SB(inode->i_sb);
-	struct cifs_credits credits_on_stack;
-	struct cifs_credits *credits =3D &credits_on_stack;
 	struct cifsFileInfo *cfile =3D NULL;
-	unsigned int xid, wsize, len;
-	loff_t i_size =3D i_size_read(inode);
-	size_t max_len;
-	long count =3D wbc->nr_to_write;
+	unsigned int wsize, len;
 	int rc;
 =

-	/* The folio should be locked, dirty and not undergoing writeback. */
-	if (folio_start_writeback(folio))
-		WARN_ON(1);
-
-	count -=3D folio_nr_pages(folio);
-	len =3D folio_size(folio);
-
-	xid =3D get_xid();
+	ctx->xid =3D get_xid();
 	server =3D cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
 =

 	rc =3D cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY, &cfile);
@@ -2756,7 +2651,7 @@ static ssize_t cifs_write_back_from_locked_folio(str=
uct address_space *mapping,
 	}
 =

 	rc =3D server->ops->wait_mtu_credits(server, cifs_sb->ctx->wsize,
-					   &wsize, credits);
+					   &wsize, &ctx->credits);
 	if (rc !=3D 0)
 		goto err_close;
 =

@@ -2767,56 +2662,60 @@ static ssize_t cifs_write_back_from_locked_folio(s=
truct address_space *mapping,
 	}
 =

 	wdata->sync_mode =3D wbc->sync_mode;
-	wdata->offset =3D folio_pos(folio);
+	wdata->offset =3D start;
 	wdata->pid =3D cfile->pid;
-	wdata->credits =3D credits_on_stack;
+	wdata->credits =3D ctx->credits;
 	wdata->cfile =3D cfile;
 	wdata->server =3D server;
-	cfile =3D NULL;
-
-	/* Find all consecutive lockable dirty pages, stopping when we find a
-	 * page that is not immediately lockable, is not dirty or is missing,
-	 * or we reach the end of the range.
-	 */
-	if (start < i_size) {
-		/* Trim the write to the EOF; the extra data is ignored.  Also
-		 * put an upper limit on the size of a single storedata op.
-		 */
-		max_len =3D wsize;
-		max_len =3D min_t(unsigned long long, max_len, end - start + 1);
-		max_len =3D min_t(unsigned long long, max_len, i_size - start);
-
-		if (len < max_len) {
-			int max_pages =3D INT_MAX;
-
-#ifdef CONFIG_CIFS_SMB_DIRECT
-			if (server->smbd_conn)
-				max_pages =3D server->smbd_conn->max_frmr_depth;
-#endif
-			max_pages -=3D folio_nr_pages(folio);
+	ctx->wsize =3D wsize;
+	ctx->server =3D server;
+	ctx->wdata =3D wdata;
+	ctx->begun =3D true;
+	return 0;
 =

-			if (max_pages > 0)
-				cifs_extend_writeback(mapping, &count, start,
-						      max_pages, max_len, &len);
-		}
-		len =3D min_t(loff_t, len, max_len);
+err_uncredit:
+	add_credits_and_wake_if(server, &ctx->credits, 0);
+err_close:
+	if (cfile)
+		cifsFileInfo_put(cfile);
+err_xid:
+	free_xid(ctx->xid);
+	if (is_retryable_error(rc)) {
+		cifs_pages_write_redirty(inode, start, len);
+	} else {
+		cifs_pages_write_failed(inode, start, len);
+		mapping_set_error(mapping, rc);
 	}
+	/* Indication to update ctime and mtime as close is deferred */
+	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
+	return rc;
+}
 =

-	wdata->bytes =3D len;
+/*
+ * Flush a block of pages to the server and the cache.
+ */
+static int cifs_writepages_submit(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  struct cifs_writepages_context *ctx)
+{
+	struct TCP_Server_Info *server =3D ctx->server;
+	struct cifs_writedata *wdata =3D ctx->wdata;
+	unsigned long long i_size =3D i_size_read(mapping->host);
+	int rc;
 =

-	/* We now have a contiguous set of dirty pages, each with writeback
-	 * set; the first page is still locked at this point, but all the rest
-	 * have been unlocked.
+	/* We now have a contiguous set of dirty pages, each with
+	 * writeback set.
 	 */
-	folio_unlock(folio);
-
-	if (start < i_size) {
-		iov_iter_xarray(&wdata->iter, ITER_SOURCE, &mapping->i_pages,
-				start, len);
+	if (ctx->start < i_size) {
+		if (ctx->len > i_size - ctx->start)
+			ctx->len =3D i_size - ctx->start;
+		wdata->bytes =3D ctx->len;
+		iov_iter_xarray(&wdata->iter, ITER_SOURCE,
+				&mapping->i_pages, ctx->start, wdata->bytes);
 =

 		rc =3D adjust_credits(wdata->server, &wdata->credits, wdata->bytes);
 		if (rc)
-			goto err_wdata;
+			goto err;
 =

 		if (wdata->cfile->invalidHandle)
 			rc =3D -EAGAIN;
@@ -2827,133 +2726,79 @@ static ssize_t cifs_write_back_from_locked_folio(=
struct address_space *mapping,
 			kref_put(&wdata->refcount, cifs_writedata_release);
 			goto err_close;
 		}
+
 	} else {
 		/* The dirty region was entirely beyond the EOF. */
-		cifs_pages_written_back(inode, start, len);
+		cifs_pages_written_back(mapping->host, ctx->start, ctx->len);
 		rc =3D 0;
 	}
 =

-err_wdata:
+err:
 	kref_put(&wdata->refcount, cifs_writedata_release);
-err_uncredit:
-	add_credits_and_wake_if(server, credits, 0);
+	add_credits_and_wake_if(server, &ctx->credits, 0);
 err_close:
-	if (cfile)
-		cifsFileInfo_put(cfile);
-err_xid:
-	free_xid(xid);
+	free_xid(ctx->xid);
 	if (rc =3D=3D 0) {
-		wbc->nr_to_write =3D count;
-		rc =3D len;
+		rc =3D 0;
 	} else if (is_retryable_error(rc)) {
-		cifs_pages_write_redirty(inode, start, len);
+		cifs_pages_write_redirty(mapping->host, ctx->start, ctx->len);
 	} else {
-		cifs_pages_write_failed(inode, start, len);
+		cifs_pages_write_failed(mapping->host, ctx->start, ctx->len);
 		mapping_set_error(mapping, rc);
 	}
+
 	/* Indication to update ctime and mtime as close is deferred */
-	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
+	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(mapping->host)->flags);
+	ctx->wdata =3D NULL;
+	ctx->begun =3D false;
 	return rc;
 }
 =

 /*
- * write a region of pages back to the server
+ * Add a page to the set and flush when large enough.
  */
-static int cifs_writepages_region(struct address_space *mapping,
-				  struct writeback_control *wbc,
-				  loff_t start, loff_t end, loff_t *_next)
+static int cifs_writepages_add_folio(struct folio *folio,
+				     struct writeback_control *wbc, void *data)
 {
-	struct folio_batch fbatch;
-	int skips =3D 0;
-
-	folio_batch_init(&fbatch);
-	do {
-		int nr;
-		pgoff_t index =3D start / PAGE_SIZE;
-
-		nr =3D filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					    PAGECACHE_TAG_DIRTY, &fbatch);
-		if (!nr)
-			break;
-
-		for (int i =3D 0; i < nr; i++) {
-			ssize_t ret;
-			struct folio *folio =3D fbatch.folios[i];
-
-redo_folio:
-			start =3D folio_pos(folio); /* May regress with THPs */
-
-			/* At this point we hold neither the i_pages lock nor the
-			 * page lock: the page may be truncated or invalidated
-			 * (changing page->mapping to NULL), or even swizzled
-			 * back from swapper_space to tmpfs file mapping
-			 */
-			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
-				ret =3D folio_lock_killable(folio);
-				if (ret < 0)
-					goto write_error;
-			} else {
-				if (!folio_trylock(folio))
-					goto skip_write;
-			}
-
-			if (folio_mapping(folio) !=3D mapping ||
-			    !folio_test_dirty(folio)) {
-				start +=3D folio_size(folio);
-				folio_unlock(folio);
-				continue;
-			}
-
-			if (folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				if (wbc->sync_mode =3D=3D WB_SYNC_NONE)
-					goto skip_write;
-
-				folio_wait_writeback(folio);
-#ifdef CONFIG_CIFS_FSCACHE
-				folio_wait_fscache(folio);
-#endif
-				goto redo_folio;
-			}
-
-			if (!folio_clear_dirty_for_io(folio))
-				/* We hold the page lock - it should've been dirty. */
-				WARN_ON(1);
+	struct cifs_writepages_context *ctx =3D data;
+	unsigned long long i_size =3D i_size_read(folio->mapping->host);
+	unsigned long long pos =3D folio_pos(folio);
+	size_t size =3D folio_size(folio);
+	int ret;
 =

-			ret =3D cifs_write_back_from_locked_folio(mapping, wbc, folio, start, =
end);
-			if (ret < 0)
-				goto write_error;
+	if (pos < i_size && size > i_size - pos)
+		size =3D i_size - pos;
 =

-			start +=3D ret;
-			continue;
-
-write_error:
-			folio_batch_release(&fbatch);
-			*_next =3D start;
+	if (ctx->begun) {
+		if (pos =3D=3D ctx->start + ctx->len &&
+		    ctx->len + size <=3D ctx->wsize)
+			goto add;
+		ret =3D cifs_writepages_submit(folio->mapping, wbc, ctx);
+		if (ret < 0) {
+			ctx->begun =3D false;
 			return ret;
+		}
+	}
 =

-skip_write:
-			/*
-			 * Too many skipped writes, or need to reschedule?
-			 * Treat it as a write error without an error code.
-			 */
-			if (skips >=3D 5 || need_resched()) {
-				ret =3D 0;
-				goto write_error;
-			}
+	ret =3D cifs_writeback_begin(folio->mapping, wbc, pos, ctx);
+	if (ret < 0)
+		return ret;
 =

-			/* Otherwise, just skip that folio and go on to the next */
-			skips++;
-			start +=3D folio_size(folio);
-			continue;
-		}
+	ctx->start =3D folio_pos(folio);
+	ctx->len =3D 0;
+add:
+	ctx->len +=3D folio_size(folio);
 =

-		folio_batch_release(&fbatch);		=

-		cond_resched();
-	} while (wbc->nr_to_write > 0);
+	folio_wait_fscache(folio);
+	folio_start_writeback(folio);
+	folio_unlock(folio);
 =

-	*_next =3D start;
+	if (ctx->len >=3D ctx->wsize) {
+		ret =3D cifs_writepages_submit(folio->mapping, wbc, ctx);
+		if (ret < 0)
+			return ret;
+		ctx->begun =3D false;
+	}
 	return 0;
 }
 =

@@ -2963,7 +2808,7 @@ static int cifs_writepages_region(struct address_spa=
ce *mapping,
 static int cifs_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
-	loff_t start, next;
+	struct cifs_writepages_context ctx =3D {};
 	int ret;
 =

 	/* We have to be careful as we can end up racing with setattr()
@@ -2971,26 +2816,11 @@ static int cifs_writepages(struct address_space *m=
apping,
 	 * to prevent it.
 	 */
 =

-	if (wbc->range_cyclic) {
-		start =3D mapping->writeback_index * PAGE_SIZE;
-		ret =3D cifs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
-		if (ret =3D=3D 0) {
-			mapping->writeback_index =3D next / PAGE_SIZE;
-			if (start > 0 && wbc->nr_to_write > 0) {
-				ret =3D cifs_writepages_region(mapping, wbc, 0,
-							     start, &next);
-				if (ret =3D=3D 0)
-					mapping->writeback_index =3D
-						next / PAGE_SIZE;
-			}
-		}
-	} else if (wbc->range_start =3D=3D 0 && wbc->range_end =3D=3D LLONG_MAX)=
 {
-		ret =3D cifs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
-		if (wbc->nr_to_write > 0 && ret =3D=3D 0)
-			mapping->writeback_index =3D next / PAGE_SIZE;
-	} else {
-		ret =3D cifs_writepages_region(mapping, wbc,
-					     wbc->range_start, wbc->range_end, &next);
+	ret =3D write_cache_pages(mapping, wbc, cifs_writepages_add_folio, &ctx)=
;
+	if (ret >=3D 0 && ctx.begun) {
+		ret =3D cifs_writepages_submit(mapping, wbc, &ctx);
+		if (ret < 0)
+			return ret;
 	}
 =

 	return ret;

