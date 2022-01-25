Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB95349B58C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 15:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385758AbiAYOBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 09:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1386894AbiAYN6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643119107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j930tURWJrqWngUWd4DU/5vAYbSK3uD9wDJcU0irB28=;
        b=guUmTEQNYImZ6LhxeQldE0sLV2bd/8J5gQ5q0BIinNg3G05M7fJTm2+AngeBBxSz2iJ24e
        zIISqxQPLT1QTDs6fDn+0W6wVVpyNZ/3lJ5OP+cr+ID99hvlDqQSjSL0pEnkoGyjOI9E40
        82RwpqX/B/3TaUg2k/m0+RPpEjvq2WU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-H9Rc9HtZMYC8XyQfoaDnbw-1; Tue, 25 Jan 2022 08:58:23 -0500
X-MC-Unique: H9Rc9HtZMYC8XyQfoaDnbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1072801ADA;
        Tue, 25 Jan 2022 13:58:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FDA7703AB;
        Tue, 25 Jan 2022 13:58:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 4/7] cifs: Make cifs_writepages() hand an iterator down
From:   David Howells <dhowells@redhat.com>
To:     smfrench@gmail.com, nspmangalore@gmail.com
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 13:58:19 +0000
Message-ID: <164311909927.2806745.2328370924720971057.stgit@warthog.procyon.org.uk>
In-Reply-To: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 fs/cifs/file.c |  725 +++++++++++++++++++++++---------------------------------
 1 file changed, 304 insertions(+), 421 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 24722fe75def..f40e5b938d43 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2262,294 +2262,334 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 	return rc;
 }
 
-static struct cifs_writedata *
-wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
-			  pgoff_t end, pgoff_t *index,
-			  unsigned int *found_pages)
+/*
+ * Extend the region to be written back to include subsequent contiguously
+ * dirty pages if possible, but don't sleep while doing so.
+ */
+static void cifs_extend_writeback(struct address_space *mapping,
+				  long *_count,
+				  loff_t start,
+				  loff_t max_len,
+				  unsigned int *_len)
 {
-	struct cifs_writedata *wdata;
-
-	wdata = cifs_writedata_alloc((unsigned int)tofind,
-				     cifs_writev_complete);
-	if (!wdata)
-		return NULL;
+	struct pagevec pvec;
+	struct folio *folio;
+	unsigned int psize;
+	loff_t len = *_len;
+	pgoff_t index = (start + len) / PAGE_SIZE;
+	bool stop = true;
+	unsigned int i;
 
-	*found_pages = find_get_pages_range_tag(mapping, index, end,
-				PAGECACHE_TAG_DIRTY, tofind, wdata->pages);
-	return wdata;
-}
+	XA_STATE(xas, &mapping->i_pages, index);
+	pagevec_init(&pvec);
 
-static unsigned int
-wdata_prepare_pages(struct cifs_writedata *wdata, unsigned int found_pages,
-		    struct address_space *mapping,
-		    struct writeback_control *wbc,
-		    pgoff_t end, pgoff_t *index, pgoff_t *next, bool *done)
-{
-	unsigned int nr_pages = 0, i;
-	struct page *page;
-
-	for (i = 0; i < found_pages; i++) {
-		page = wdata->pages[i];
-		/*
-		 * At this point we hold neither the i_pages lock nor the
-		 * page lock: the page may be truncated or invalidated
-		 * (changing page->mapping to NULL), or even swizzled
-		 * back from swapper_space to tmpfs file mapping
+	do {
+		/* Firstly, we gather up a batch of contiguous dirty pages
+		 * under the RCU read lock - but we can't clear the dirty flags
+		 * there if any of those pages are mapped.
 		 */
+		rcu_read_lock();
 
-		if (nr_pages == 0)
-			lock_page(page);
-		else if (!trylock_page(page))
-			break;
+		xas_for_each(&xas, folio, ULONG_MAX) {
+			stop = true;
+			if (xas_retry(&xas, folio))
+				continue;
+			if (xa_is_value(folio))
+				break;
+			if (folio_index(folio) != index)
+				break;
 
-		if (unlikely(page->mapping != mapping)) {
-			unlock_page(page);
-			break;
-		}
+			if (!folio_try_get_rcu(folio)) {
+				xas_reset(&xas);
+				continue;
+			}
 
-		if (!wbc->range_cyclic && page->index > end) {
-			*done = true;
-			unlock_page(page);
-			break;
-		}
+			/* Has the page moved or been split? */
+			if (unlikely(folio != xas_reload(&xas))) {
+				folio_put(folio);
+				break;
+			}
 
-		if (*next && (page->index != *next)) {
-			/* Not next consecutive page */
-			unlock_page(page);
-			break;
-		}
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
+				break;
+			}
+			if (!folio_test_dirty(folio) || folio_test_writeback(folio)) {
+				folio_unlock(folio);
+				folio_put(folio);
+				break;
+			}
 
-		if (wbc->sync_mode != WB_SYNC_NONE)
-			wait_on_page_writeback(page);
+			psize = folio_size(folio);
+			len += psize;
+			if (len >= max_len || *_count <= 0)
+				stop = true;
 
-		if (PageWriteback(page) ||
-				!clear_page_dirty_for_io(page)) {
-			unlock_page(page);
-			break;
+			index += folio_nr_pages(folio);
+			if (!pagevec_add(&pvec, &folio->page))
+				break;
+			if (stop)
+				break;
 		}
 
-		/*
-		 * This actually clears the dirty bit in the radix tree.
-		 * See cifs_writepage() for more commentary.
+		if (!stop)
+			xas_pause(&xas);
+		rcu_read_unlock();
+
+		/* Now, if we obtained any pages, we can shift them to being
+		 * writable and mark them for caching.
 		 */
-		set_page_writeback(page);
-		if (page_offset(page) >= i_size_read(mapping->host)) {
-			*done = true;
-			unlock_page(page);
-			end_page_writeback(page);
+		if (!pagevec_count(&pvec))
 			break;
-		}
-
-		wdata->pages[i] = page;
-		*next = page->index + 1;
-		++nr_pages;
-	}
-
-	/* reset index to refind any pages skipped */
-	if (nr_pages == 0)
-		*index = wdata->pages[0]->index + 1;
 
-	/* put any pages we aren't going to use */
-	for (i = nr_pages; i < found_pages; i++) {
-		put_page(wdata->pages[i]);
-		wdata->pages[i] = NULL;
-	}
-
-	return nr_pages;
-}
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			folio = page_folio(pvec.pages[i]);
+			if (!folio_clear_dirty_for_io(folio))
+				BUG();
+			if (folio_start_writeback(folio))
+				BUG();
 
-static int
-wdata_send_pages(struct cifs_writedata *wdata, unsigned int nr_pages,
-		 struct address_space *mapping, struct writeback_control *wbc)
-{
-	int rc;
-
-	wdata->sync_mode = wbc->sync_mode;
-	wdata->nr_pages = nr_pages;
-	wdata->offset = page_offset(wdata->pages[0]);
-	wdata->pagesz = PAGE_SIZE;
-	wdata->tailsz = min(i_size_read(mapping->host) -
-			page_offset(wdata->pages[nr_pages - 1]),
-			(loff_t)PAGE_SIZE);
-	wdata->bytes = ((nr_pages - 1) * PAGE_SIZE) + wdata->tailsz;
-	wdata->pid = wdata->cfile->pid;
-
-	rc = adjust_credits(wdata->server, &wdata->credits, wdata->bytes);
-	if (rc)
-		return rc;
+			*_count -= folio_nr_pages(folio);
+			folio_unlock(folio);
+		}
 
-	if (wdata->cfile->invalidHandle)
-		rc = -EAGAIN;
-	else
-		rc = wdata->server->ops->async_writev(wdata,
-						      cifs_writedata_release);
+		pagevec_release(&pvec);
+		cond_resched();
+	} while (!stop);
 
-	return rc;
+	*_len = len;
 }
 
-static int cifs_writepages(struct address_space *mapping,
-			   struct writeback_control *wbc)
+/*
+ * Write back the locked page and any subsequent non-locked dirty pages.
+ */
+static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
+						 struct writeback_control *wbc,
+						 struct folio *folio,
+						 loff_t start, loff_t end)
 {
 	struct inode *inode = mapping->host;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct TCP_Server_Info *server;
-	bool done = false, scanned = false, range_whole = false;
-	pgoff_t end, index;
 	struct cifs_writedata *wdata;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_credits credits_on_stack;
+	struct cifs_credits *credits = &credits_on_stack;
 	struct cifsFileInfo *cfile = NULL;
-	int rc = 0;
-	int saved_rc = 0;
-	unsigned int xid;
+	unsigned int xid, wsize, len, max_len;
+	loff_t i_size = i_size_read(inode);
+	long count = wbc->nr_to_write;
+	int rc;
 
-	/*
-	 * If wsize is smaller than the page cache size, default to writing
-	 * one page at a time via cifs_writepage
-	 */
-	if (cifs_sb->ctx->wsize < PAGE_SIZE)
-		return generic_writepages(mapping, wbc);
+	if (folio_start_writeback(folio))
+		BUG();
+
+	count -= folio_nr_pages(folio);
+	len = folio_size(folio);
 
 	xid = get_xid();
-	if (wbc->range_cyclic) {
-		index = mapping->writeback_index; /* Start from prev offset */
-		end = -1;
-	} else {
-		index = wbc->range_start >> PAGE_SHIFT;
-		end = wbc->range_end >> PAGE_SHIFT;
-		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-			range_whole = true;
-		scanned = true;
-	}
 	server = cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
 
-retry:
-	while (!done && index <= end) {
-		unsigned int i, nr_pages, found_pages, wsize;
-		pgoff_t next = 0, tofind, saved_index = index;
-		struct cifs_credits credits_on_stack;
-		struct cifs_credits *credits = &credits_on_stack;
-		int get_file_rc = 0;
+	rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY, &cfile);
+	if (rc) {
+		cifs_dbg(VFS, "No writable handle in writepages rc=%d\n", rc);
+		goto err_xid;
+	}
 
-		if (cfile)
-			cifsFileInfo_put(cfile);
+	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->wsize,
+					   &wsize, credits);
+	if (rc != 0)
+		goto err_close;
 
-		rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY, &cfile);
+	wdata = cifs_writedata_alloc(cifs_writev_complete);
+	if (!wdata) {
+		rc = -ENOMEM;
+		goto err_uncredit;
+	}
 
-		/* in case of an error store it to return later */
-		if (rc)
-			get_file_rc = rc;
+	wdata->sync_mode = wbc->sync_mode;
+	wdata->offset = folio_pos(folio);
+	wdata->pid = cfile->pid;
+	wdata->credits = credits_on_stack;
+	wdata->cfile = cfile;
+	wdata->server = server;
+	cfile = NULL;
+
+	/* Find all consecutive lockable dirty pages, stopping when we find a
+	 * page that is not immediately lockable, is not dirty or is missing,
+	 * or we reach the end of the range.
+	 */
+	if (start < i_size) {
+		/* Trim the write to the EOF; the extra data is ignored.  Also
+		 * put an upper limit on the size of a single storedata op.
+		 */
+		max_len = wsize;
+		max_len = min_t(unsigned long long, max_len, end - start + 1);
+		max_len = min_t(unsigned long long, max_len, i_size - start);
 
-		rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->wsize,
-						   &wsize, credits);
-		if (rc != 0) {
-			done = true;
-			break;
-		}
+		if (len < max_len)
+			cifs_extend_writeback(mapping, &count, start,
+					      max_len, &len);
+		len = min_t(loff_t, len, max_len);
+	}
 
-		tofind = min((wsize / PAGE_SIZE) - 1, end - index) + 1;
+	wdata->bytes = len;
 
-		wdata = wdata_alloc_and_fillpages(tofind, mapping, end, &index,
-						  &found_pages);
-		if (!wdata) {
-			rc = -ENOMEM;
-			done = true;
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
+	/* We now have a contiguous set of dirty pages, each with writeback
+	 * set; the first page is still locked at this point, but all the rest
+	 * have been unlocked.
+	 */
+	folio_unlock(folio);
 
-		if (found_pages == 0) {
-			kref_put(&wdata->refcount, cifs_writedata_release);
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
+	if (start < i_size) {
+		iov_iter_xarray(&wdata->iter, WRITE, &mapping->i_pages, start, len);
 
-		nr_pages = wdata_prepare_pages(wdata, found_pages, mapping, wbc,
-					       end, &index, &next, &done);
+		rc = adjust_credits(wdata->server, &wdata->credits, wdata->bytes);
+		if (rc)
+			goto err_wdata;
 
-		/* nothing to write? */
-		if (nr_pages == 0) {
-			kref_put(&wdata->refcount, cifs_writedata_release);
-			add_credits_and_wake_if(server, credits, 0);
-			continue;
-		}
+		if (wdata->cfile->invalidHandle)
+			rc = -EAGAIN;
+		else
+			rc = wdata->server->ops->async_writev(wdata,
+							      cifs_writedata_release);
+	} else {
+		/* The dirty region was entirely beyond the EOF. */
+		cifs_pages_written_back(inode, start, len);
+		rc = 0;
+	}
 
-		wdata->credits = credits_on_stack;
-		wdata->cfile = cfile;
-		wdata->server = server;
-		cfile = NULL;
+err_wdata:
+	kref_put(&wdata->refcount, cifs_writedata_release);
+err_uncredit:
+	add_credits_and_wake_if(server, credits, 0);
+err_close:
+	if (cfile)
+		cifsFileInfo_put(cfile);
+err_xid:
+	free_xid(xid);
+	if (rc == 0) {
+		wbc->nr_to_write = count;
+	} else if (is_retryable_error(rc)) {
+		cifs_pages_write_redirty(inode, start, len);
+	} else {
+		cifs_pages_write_failed(inode, start, len);
+		mapping_set_error(mapping, rc);
+	}
+	/* Indication to update ctime and mtime as close is deferred */
+	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
+	return rc;
+}
 
-		if (!wdata->cfile) {
-			cifs_dbg(VFS, "No writable handle in writepages rc=%d\n",
-				 get_file_rc);
-			if (is_retryable_error(get_file_rc))
-				rc = get_file_rc;
-			else
-				rc = -EBADF;
-		} else
-			rc = wdata_send_pages(wdata, nr_pages, mapping, wbc);
+/*
+ * write a region of pages back to the server
+ */
+static int cifs_writepages_region(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  loff_t start, loff_t end, loff_t *_next)
+{
+	struct folio *folio;
+	struct page *head_page;
+	ssize_t ret;
+	int n;
 
-		for (i = 0; i < nr_pages; ++i)
-			unlock_page(wdata->pages[i]);
+	do {
+		pgoff_t index = start / PAGE_SIZE;
 
-		/* send failure -- clean up the mess */
-		if (rc != 0) {
-			add_credits_and_wake_if(server, &wdata->credits, 0);
-			for (i = 0; i < nr_pages; ++i) {
-				if (is_retryable_error(rc))
-					redirty_page_for_writepage(wbc,
-							   wdata->pages[i]);
-				else
-					SetPageError(wdata->pages[i]);
-				end_page_writeback(wdata->pages[i]);
-				put_page(wdata->pages[i]);
+		n = find_get_pages_range_tag(mapping, &index, end / PAGE_SIZE,
+					     PAGECACHE_TAG_DIRTY, 1, &head_page);
+		if (!n)
+			break;
+
+		folio = page_folio(head_page);
+		start = folio_pos(folio); /* May regress with THPs */
+
+		/* At this point we hold neither the i_pages lock nor the
+		 * page lock: the page may be truncated or invalidated
+		 * (changing page->mapping to NULL), or even swizzled
+		 * back from swapper_space to tmpfs file mapping
+		 */
+		if (wbc->sync_mode != WB_SYNC_NONE) {
+			ret = folio_lock_killable(folio);
+			if (ret < 0) {
+				folio_put(folio);
+				return ret;
+			}
+		} else {
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
+				return 0;
 			}
-			if (!is_retryable_error(rc))
-				mapping_set_error(mapping, rc);
 		}
-		kref_put(&wdata->refcount, cifs_writedata_release);
 
-		if (wbc->sync_mode == WB_SYNC_ALL && rc == -EAGAIN) {
-			index = saved_index;
+		if (folio_mapping(folio) != mapping ||
+		    !folio_test_dirty(folio)) {
+			start += folio_size(folio);
+			folio_unlock(folio);
+			folio_put(folio);
 			continue;
 		}
 
-		/* Return immediately if we received a signal during writing */
-		if (is_interrupt_error(rc)) {
-			done = true;
-			break;
+		if (folio_test_writeback(folio)) {
+			folio_unlock(folio);
+			if (wbc->sync_mode != WB_SYNC_NONE)
+				folio_wait_writeback(folio);
+			folio_put(folio);
+			continue;
 		}
 
-		if (rc != 0 && saved_rc == 0)
-			saved_rc = rc;
+		if (!folio_clear_dirty_for_io(folio))
+			BUG();
 
-		wbc->nr_to_write -= nr_pages;
-		if (wbc->nr_to_write <= 0)
-			done = true;
+		ret = cifs_write_back_from_locked_folio(mapping, wbc, folio, start, end);
+		folio_put(folio);
+		if (ret < 0)
+			return ret;
 
-		index = next;
-	}
+		start += ret;
+		cond_resched();
+	} while (wbc->nr_to_write > 0);
 
-	if (!scanned && !done) {
-		/*
-		 * We hit the last page and there is more work to be done: wrap
-		 * back to the start of the file
-		 */
-		scanned = true;
-		index = 0;
-		goto retry;
-	}
+	*_next = start;
+	return 0;
+}
 
-	if (saved_rc != 0)
-		rc = saved_rc;
+/*
+ * Write some of the pending data back to the server
+ */
+static int cifs_writepages(struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	loff_t start, next;
+	int ret;
 
-	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
-		mapping->writeback_index = index;
+	/* We have to be careful as we can end up racing with setattr()
+	 * truncating the pagecache since the caller doesn't take a lock here
+	 * to prevent it.
+	 */
 
-	if (cfile)
-		cifsFileInfo_put(cfile);
-	free_xid(xid);
-	/* Indication to update ctime and mtime as close is deferred */
-	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
-	return rc;
+	if (wbc->range_cyclic) {
+		start = mapping->writeback_index * PAGE_SIZE;
+		ret = cifs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
+		if (ret == 0) {
+			mapping->writeback_index = next / PAGE_SIZE;
+			if (start > 0 && wbc->nr_to_write > 0) {
+				ret = cifs_writepages_region(mapping, wbc, 0,
+							     start, &next);
+				if (ret == 0)
+					mapping->writeback_index =
+						next / PAGE_SIZE;
+			}
+		}
+	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
+		ret = cifs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
+		if (wbc->nr_to_write > 0 && ret == 0)
+			mapping->writeback_index = next / PAGE_SIZE;
+	} else {
+		ret = cifs_writepages_region(mapping, wbc,
+					     wbc->range_start, wbc->range_end, &next);
+	}
+
+	return ret;
 }
 
 static int
@@ -2608,6 +2648,7 @@ static int cifs_write_end(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct cifsFileInfo *cfile = file->private_data;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(cfile->dentry->d_sb);
+	struct folio *folio = page_folio(page);
 	__u32 pid;
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
@@ -2618,14 +2659,14 @@ static int cifs_write_end(struct file *file, struct address_space *mapping,
 	cifs_dbg(FYI, "write_end for page %p from pos %lld with %d bytes\n",
 		 page, pos, copied);
 
-	if (PageChecked(page)) {
+	if (folio_test_checked(folio)) {
 		if (copied == len)
-			SetPageUptodate(page);
-		ClearPageChecked(page);
-	} else if (!PageUptodate(page) && copied == PAGE_SIZE)
-		SetPageUptodate(page);
+			folio_mark_uptodate(folio);
+		folio_clear_checked(folio);
+	} else if (!folio_test_uptodate(folio) && copied == PAGE_SIZE)
+		folio_mark_uptodate(folio);
 
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		char *page_data;
 		unsigned offset = pos & (PAGE_SIZE - 1);
 		unsigned int xid;
@@ -2782,57 +2823,13 @@ int cifs_flush(struct file *file, fl_owner_t id)
 	return rc;
 }
 
-static int
-cifs_write_allocate_pages(struct page **pages, unsigned long num_pages)
-{
-	int rc = 0;
-	unsigned long i;
-
-	for (i = 0; i < num_pages; i++) {
-		pages[i] = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
-		if (!pages[i]) {
-			/*
-			 * save number of pages we have already allocated and
-			 * return with ENOMEM error
-			 */
-			num_pages = i;
-			rc = -ENOMEM;
-			break;
-		}
-	}
-
-	if (rc) {
-		for (i = 0; i < num_pages; i++)
-			put_page(pages[i]);
-	}
-	return rc;
-}
-
-static inline
-size_t get_numpages(const size_t wsize, const size_t len, size_t *cur_len)
-{
-	size_t num_pages;
-	size_t clen;
-
-	clen = min_t(const size_t, len, wsize);
-	num_pages = DIV_ROUND_UP(clen, PAGE_SIZE);
-
-	if (cur_len)
-		*cur_len = clen;
-
-	return num_pages;
-}
-
 static void
 cifs_uncached_writedata_release(struct kref *refcount)
 {
-	int i;
 	struct cifs_writedata *wdata = container_of(refcount,
 					struct cifs_writedata, refcount);
 
 	kref_put(&wdata->ctx->refcount, cifs_aio_ctx_release);
-	for (i = 0; i < wdata->nr_pages; i++)
-		put_page(wdata->pages[i]);
 	cifs_writedata_release(refcount);
 }
 
@@ -2858,48 +2855,6 @@ cifs_uncached_writev_complete(struct work_struct *work)
 	kref_put(&wdata->refcount, cifs_uncached_writedata_release);
 }
 
-static int
-wdata_fill_from_iovec(struct cifs_writedata *wdata, struct iov_iter *from,
-		      size_t *len, unsigned long *num_pages)
-{
-	size_t save_len, copied, bytes, cur_len = *len;
-	unsigned long i, nr_pages = *num_pages;
-
-	save_len = cur_len;
-	for (i = 0; i < nr_pages; i++) {
-		bytes = min_t(const size_t, cur_len, PAGE_SIZE);
-		copied = copy_page_from_iter(wdata->pages[i], 0, bytes, from);
-		cur_len -= copied;
-		/*
-		 * If we didn't copy as much as we expected, then that
-		 * may mean we trod into an unmapped area. Stop copying
-		 * at that point. On the next pass through the big
-		 * loop, we'll likely end up getting a zero-length
-		 * write and bailing out of it.
-		 */
-		if (copied < bytes)
-			break;
-	}
-	cur_len = save_len - cur_len;
-	*len = cur_len;
-
-	/*
-	 * If we have no data to send, then that probably means that
-	 * the copy above failed altogether. That's most likely because
-	 * the address in the iovec was bogus. Return -EFAULT and let
-	 * the caller free anything we allocated and bail out.
-	 */
-	if (!cur_len)
-		return -EFAULT;
-
-	/*
-	 * i + 1 now represents the number of pages we actually used in
-	 * the copy phase above.
-	 */
-	*num_pages = i + 1;
-	return 0;
-}
-
 static int
 cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_list,
 	struct cifs_aio_ctx *ctx)
@@ -2978,14 +2933,11 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 {
 	int rc = 0;
 	size_t cur_len;
-	unsigned long nr_pages, num_pages, i;
 	struct cifs_writedata *wdata;
 	struct iov_iter saved_from = *from;
 	loff_t saved_offset = offset;
 	pid_t pid;
 	struct TCP_Server_Info *server;
-	struct page **pagevec;
-	size_t start;
 	unsigned int xid;
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
@@ -3016,93 +2968,22 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 
 		cur_len = min_t(const size_t, len, wsize);
 
-		if (ctx->direct_io) {
-			ssize_t result;
-
-			result = iov_iter_get_pages_alloc(
-				from, &pagevec, cur_len, &start);
-			if (result < 0) {
-				cifs_dbg(VFS,
-					 "direct_writev couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
-					 result, iov_iter_type(from),
-					 from->iov_offset, from->count);
-				dump_stack();
-
-				rc = result;
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-			cur_len = (size_t)result;
-			iov_iter_advance(from, cur_len);
-
-			nr_pages =
-				(cur_len + start + PAGE_SIZE - 1) / PAGE_SIZE;
-
-			wdata = cifs_writedata_direct_alloc(pagevec,
-					     cifs_uncached_writev_complete);
-			if (!wdata) {
-				rc = -ENOMEM;
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-
-
-			wdata->page_offset = start;
-			wdata->tailsz =
-				nr_pages > 1 ?
-					cur_len - (PAGE_SIZE - start) -
-					(nr_pages - 2) * PAGE_SIZE :
-					cur_len;
-		} else {
-			nr_pages = get_numpages(wsize, len, &cur_len);
-			wdata = cifs_writedata_alloc(nr_pages,
-					     cifs_uncached_writev_complete);
-			if (!wdata) {
-				rc = -ENOMEM;
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-
-			rc = cifs_write_allocate_pages(wdata->pages, nr_pages);
-			if (rc) {
-				kvfree(wdata->pages);
-				kfree(wdata);
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-
-			num_pages = nr_pages;
-			rc = wdata_fill_from_iovec(
-				wdata, from, &cur_len, &num_pages);
-			if (rc) {
-				for (i = 0; i < nr_pages; i++)
-					put_page(wdata->pages[i]);
-				kvfree(wdata->pages);
-				kfree(wdata);
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-
-			/*
-			 * Bring nr_pages down to the number of pages we
-			 * actually used, and free any pages that we didn't use.
-			 */
-			for ( ; nr_pages > num_pages; nr_pages--)
-				put_page(wdata->pages[nr_pages - 1]);
-
-			wdata->tailsz = cur_len - ((nr_pages - 1) * PAGE_SIZE);
+		wdata = cifs_writedata_alloc(cifs_uncached_writev_complete);
+		if (!wdata) {
+			rc = -ENOMEM;
+			add_credits_and_wake_if(server, credits, 0);
+			break;
 		}
 
 		wdata->sync_mode = WB_SYNC_ALL;
-		wdata->nr_pages = nr_pages;
-		wdata->offset = (__u64)offset;
-		wdata->cfile = cifsFileInfo_get(open_file);
-		wdata->server = server;
-		wdata->pid = pid;
-		wdata->bytes = cur_len;
-		wdata->pagesz = PAGE_SIZE;
-		wdata->credits = credits_on_stack;
-		wdata->ctx = ctx;
+		wdata->offset	= (__u64)offset;
+		wdata->cfile	= cifsFileInfo_get(open_file);
+		wdata->server	= server;
+		wdata->pid	= pid;
+		wdata->bytes	= cur_len;
+		wdata->credits	= credits_on_stack;
+		wdata->iter	= *from;
+		wdata->ctx	= ctx;
 		kref_get(&ctx->refcount);
 
 		rc = adjust_credits(server, &wdata->credits, wdata->bytes);
@@ -3228,7 +3109,6 @@ static ssize_t __cifs_writev(
 	struct cifs_sb_info *cifs_sb;
 	struct cifs_aio_ctx *ctx;
 	struct iov_iter saved_from = *from;
-	size_t len = iov_iter_count(from);
 	int rc;
 
 	/*
@@ -3262,18 +3142,21 @@ static ssize_t __cifs_writev(
 		ctx->iocb = iocb;
 
 	ctx->pos = iocb->ki_pos;
+	ctx->direct_io = direct;
 
-	if (direct) {
-		ctx->direct_io = true;
-		ctx->iter = *from;
-		ctx->len = len;
-	} else {
-		rc = setup_aio_ctx_iter(ctx, from, WRITE);
-		if (rc) {
-			kref_put(&ctx->refcount, cifs_aio_ctx_release);
-			return rc;
-		}
+	/*
+	 * Duplicate the iterator as it may contain references to the calling
+	 * process's virtual memory layout which won't be available in an async
+	 * worker thread.  This also takes a ref on every folio involved and
+	 * attaches them to ctx->bv[].
+	 */
+	rc = extract_iter_to_iter(from, ctx->len, &ctx->iter, &ctx->bv);
+	if (rc < 0) {
+		kref_put(&ctx->refcount, cifs_aio_ctx_release);
+		return rc;
 	}
+	ctx->npages = rc;
+	ctx->len = iov_iter_count(&ctx->iter);
 
 	/* grab a lock here due to read response handlers can access ctx */
 	mutex_lock(&ctx->aio_mutex);


