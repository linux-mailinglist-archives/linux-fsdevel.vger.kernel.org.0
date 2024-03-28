Return-Path: <linux-fsdevel+bounces-15596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC2D8906B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 18:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E3E2900C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79904139D18;
	Thu, 28 Mar 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9+R43fw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA65BAD4
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645266; cv=none; b=j20Yb9A+xRcYFPNis4zfVRiFqYAu2bvxFZe0PRc2zFyckT2suqIx67fYtHEjzvZjODqQvknLbpvTyJIKwPWUJH/7/uGiSarvWM9ZYme1pO+ieLHf0++3PTZudh5c1zGYqic1K/pHb46GXukIosCcNrJX3r1xS21SEZ+OZucYgDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645266; c=relaxed/simple;
	bh=XFDza5oM3WqDd2pWmoZL1oJgsBI07i6RvS39pePp1hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJWWCNdOfB9wVojWEPoRMBdUl2wQ8J0Ua/wljmIDXaTzXXvvaKsvwlBJIMk6cbKgG9eSicXG0VHb7HROsyHk58q1m9kCh9197hLmq01tX+Nbx4KxtqNRM2S4mtAWqcFVk6mA566aWzY4K/hlAoqvtKuoPbfWViaMzaRMnKCDGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9+R43fw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711645263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZ3qln56R8gz/TyHMxIA9wp5yFVEOQhmfIt5qbtPW8s=;
	b=G9+R43fw30OiOGfonOSXBUTa1rYr540TCIzIl7Ry8zbT9qLqOhyd4Jhqu/CqrwWf4QoOxu
	8wnUqwINWQbBTw0qXp/zr/L00dm5nohUBI9u17ShgIosJoXw1vAh930cA+KFl4J+cAFfQm
	qqz+ZpNwyVyLgZSOzc/+AZNVYpLOKmA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-XwmHA-YGNhOtYolac14NJQ-1; Thu, 28 Mar 2024 13:00:56 -0400
X-MC-Unique: XwmHA-YGNhOtYolac14NJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 667E2101CC6D;
	Thu, 28 Mar 2024 17:00:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69129200A384;
	Thu, 28 Mar 2024 17:00:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v6 14/15] cifs: Remove some code that's no longer used, part 2
Date: Thu, 28 Mar 2024 16:58:05 +0000
Message-ID: <20240328165845.2782259-15-dhowells@redhat.com>
In-Reply-To: <20240328165845.2782259-1-dhowells@redhat.com>
References: <20240328165845.2782259-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Remove some code that was #if'd out with the netfslib conversion.  This is
split into parts for file.c as the diff generator otherwise produces a hard
to read diff for part of it where a big chunk is cut out.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/file.c | 634 +------------------------------------------
 1 file changed, 1 insertion(+), 633 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 265d96f663d7..f45a830154d5 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2569,639 +2569,6 @@ cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
 	return -ENOENT;
 }
 
-#if 0 // TODO remove 2773
-void
-cifs_writedata_release(struct cifs_io_subrequest *wdata)
-{
-	if (wdata->uncached)
-		kref_put(&wdata->ctx->refcount, cifs_aio_ctx_release);
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (wdata->mr) {
-		smbd_deregister_mr(wdata->mr);
-		wdata->mr = NULL;
-	}
-#endif
-
-	if (wdata->cfile)
-		cifsFileInfo_put(wdata->cfile);
-
-	kfree(wdata);
-}
-
-/*
- * Write failed with a retryable error. Resend the write request. It's also
- * possible that the page was redirtied so re-clean the page.
- */
-static void
-cifs_writev_requeue(struct cifs_io_subrequest *wdata)
-{
-	int rc = 0;
-	struct inode *inode = d_inode(wdata->cfile->dentry);
-	struct TCP_Server_Info *server;
-	unsigned int rest_len = wdata->subreq.len;
-	loff_t fpos = wdata->subreq.start;
-
-	server = tlink_tcon(wdata->cfile->tlink)->ses->server;
-	do {
-		struct cifs_io_subrequest *wdata2;
-		unsigned int wsize, cur_len;
-
-		wsize = server->ops->wp_retry_size(inode);
-		if (wsize < rest_len) {
-			if (wsize < PAGE_SIZE) {
-				rc = -EOPNOTSUPP;
-				break;
-			}
-			cur_len = min(round_down(wsize, PAGE_SIZE), rest_len);
-		} else {
-			cur_len = rest_len;
-		}
-
-		wdata2 = cifs_writedata_alloc(cifs_writev_complete);
-		if (!wdata2) {
-			rc = -ENOMEM;
-			break;
-		}
-
-		wdata2->sync_mode = wdata->sync_mode;
-		wdata2->subreq.start	= fpos;
-		wdata2->subreq.len	= cur_len;
-		wdata2->subreq.io_iter = wdata->subreq.io_iter;
-
-		iov_iter_advance(&wdata2->subreq.io_iter, fpos - wdata->subreq.start);
-		iov_iter_truncate(&wdata2->subreq.io_iter, wdata2->subreq.len);
-
-		if (iov_iter_is_xarray(&wdata2->subreq.io_iter))
-			/* Check for pages having been redirtied and clean
-			 * them.  We can do this by walking the xarray.  If
-			 * it's not an xarray, then it's a DIO and we shouldn't
-			 * be mucking around with the page bits.
-			 */
-			cifs_undirty_folios(inode, fpos, cur_len);
-
-		rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY,
-					    &wdata2->cfile);
-		if (!wdata2->cfile) {
-			cifs_dbg(VFS, "No writable handle to retry writepages rc=%d\n",
-				 rc);
-			if (!is_retryable_error(rc))
-				rc = -EBADF;
-		} else {
-			wdata2->pid = wdata2->cfile->pid;
-			rc = server->ops->async_writev(wdata2);
-		}
-
-		cifs_put_writedata(wdata2);
-		if (rc) {
-			if (is_retryable_error(rc))
-				continue;
-			fpos += cur_len;
-			rest_len -= cur_len;
-			break;
-		}
-
-		fpos += cur_len;
-		rest_len -= cur_len;
-	} while (rest_len > 0);
-
-	/* Clean up remaining pages from the original wdata */
-	if (iov_iter_is_xarray(&wdata->subreq.io_iter))
-		cifs_pages_write_failed(inode, fpos, rest_len);
-
-	if (rc != 0 && !is_retryable_error(rc))
-		mapping_set_error(inode->i_mapping, rc);
-	cifs_put_writedata(wdata);
-}
-
-void
-cifs_writev_complete(struct work_struct *work)
-{
-	struct cifs_io_subrequest *wdata = container_of(work,
-						struct cifs_io_subrequest, work);
-	struct inode *inode = d_inode(wdata->cfile->dentry);
-
-	if (wdata->result == 0) {
-		spin_lock(&inode->i_lock);
-		cifs_update_eof(CIFS_I(inode), wdata->subreq.start, wdata->subreq.len);
-		spin_unlock(&inode->i_lock);
-		cifs_stats_bytes_written(tlink_tcon(wdata->cfile->tlink),
-					 wdata->subreq.len);
-	} else if (wdata->sync_mode == WB_SYNC_ALL && wdata->result == -EAGAIN)
-		return cifs_writev_requeue(wdata);
-
-	if (wdata->result == -EAGAIN)
-		cifs_pages_write_redirty(inode, wdata->subreq.start, wdata->subreq.len);
-	else if (wdata->result < 0)
-		cifs_pages_write_failed(inode, wdata->subreq.start, wdata->subreq.len);
-	else
-		cifs_pages_written_back(inode, wdata->subreq.start, wdata->subreq.len);
-
-	if (wdata->result != -EAGAIN)
-		mapping_set_error(inode->i_mapping, wdata->result);
-	cifs_put_writedata(wdata);
-}
-
-struct cifs_io_subrequest *cifs_writedata_alloc(work_func_t complete)
-{
-	struct cifs_io_subrequest *wdata;
-
-	wdata = kzalloc(sizeof(*wdata), GFP_NOFS);
-	if (wdata != NULL) {
-		refcount_set(&wdata->subreq.ref, 1);
-		INIT_LIST_HEAD(&wdata->list);
-		init_completion(&wdata->done);
-		INIT_WORK(&wdata->work, complete);
-	}
-	return wdata;
-}
-
-/*
- * Extend the region to be written back to include subsequent contiguously
- * dirty pages if possible, but don't sleep while doing so.
- */
-static void cifs_extend_writeback(struct address_space *mapping,
-				  struct xa_state *xas,
-				  long *_count,
-				  loff_t start,
-				  int max_pages,
-				  loff_t max_len,
-				  size_t *_len)
-{
-	struct folio_batch batch;
-	struct folio *folio;
-	unsigned int nr_pages;
-	pgoff_t index = (start + *_len) / PAGE_SIZE;
-	size_t len;
-	bool stop = true;
-	unsigned int i;
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
-		xas_for_each(xas, folio, ULONG_MAX) {
-			stop = true;
-			if (xas_retry(xas, folio))
-				continue;
-			if (xa_is_value(folio))
-				break;
-			if (folio->index != index) {
-				xas_reset(xas);
-				break;
-			}
-
-			if (!folio_try_get_rcu(folio)) {
-				xas_reset(xas);
-				continue;
-			}
-			nr_pages = folio_nr_pages(folio);
-			if (nr_pages > max_pages) {
-				xas_reset(xas);
-				break;
-			}
-
-			/* Has the page moved or been split? */
-			if (unlikely(folio != xas_reload(xas))) {
-				folio_put(folio);
-				xas_reset(xas);
-				break;
-			}
-
-			if (!folio_trylock(folio)) {
-				folio_put(folio);
-				xas_reset(xas);
-				break;
-			}
-			if (!folio_test_dirty(folio) ||
-			    folio_test_writeback(folio)) {
-				folio_unlock(folio);
-				folio_put(folio);
-				xas_reset(xas);
-				break;
-			}
-
-			max_pages -= nr_pages;
-			len = folio_size(folio);
-			stop = false;
-
-			index += nr_pages;
-			*_count -= nr_pages;
-			*_len += len;
-			if (max_pages <= 0 || *_len >= max_len || *_count <= 0)
-				stop = true;
-
-			if (!folio_batch_add(&batch, folio))
-				break;
-			if (stop)
-				break;
-		}
-
-		xas_pause(xas);
-		rcu_read_unlock();
-
-		/* Now, if we obtained any pages, we can shift them to being
-		 * writable and mark them for caching.
-		 */
-		if (!folio_batch_count(&batch))
-			break;
-
-		for (i = 0; i < folio_batch_count(&batch); i++) {
-			folio = batch.folios[i];
-			/* The folio should be locked, dirty and not undergoing
-			 * writeback from the loop above.
-			 */
-			if (!folio_clear_dirty_for_io(folio))
-				WARN_ON(1);
-			folio_start_writeback(folio);
-			folio_unlock(folio);
-		}
-
-		folio_batch_release(&batch);
-		cond_resched();
-	} while (!stop);
-}
-
-/*
- * Write back the locked page and any subsequent non-locked dirty pages.
- */
-static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
-						 struct writeback_control *wbc,
-						 struct xa_state *xas,
-						 struct folio *folio,
-						 unsigned long long start,
-						 unsigned long long end)
-{
-	struct inode *inode = mapping->host;
-	struct TCP_Server_Info *server;
-	struct cifs_io_subrequest *wdata;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
-	struct cifs_credits credits_on_stack;
-	struct cifs_credits *credits = &credits_on_stack;
-	struct cifsFileInfo *cfile = NULL;
-	unsigned long long i_size = i_size_read(inode), max_len;
-	unsigned int xid;
-	size_t wsize;
-	size_t len = folio_size(folio);
-	long count = wbc->nr_to_write;
-	int rc;
-
-	/* The folio should be locked, dirty and not undergoing writeback. */
-	if (!folio_clear_dirty_for_io(folio))
-		WARN_ON_ONCE(1);
-	folio_start_writeback(folio);
-
-	count -= folio_nr_pages(folio);
-
-	xid = get_xid();
-	server = cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
-
-	rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY, &cfile);
-	if (rc) {
-		cifs_dbg(VFS, "No writable handle in writepages rc=%d\n", rc);
-		goto err_xid;
-	}
-
-	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->wsize,
-					   &wsize, credits);
-	if (rc != 0)
-		goto err_close;
-
-	wdata = cifs_writedata_alloc(cifs_writev_complete);
-	if (!wdata) {
-		rc = -ENOMEM;
-		goto err_uncredit;
-	}
-
-	wdata->sync_mode = wbc->sync_mode;
-	wdata->subreq.start = folio_pos(folio);
-	wdata->pid = cfile->pid;
-	wdata->credits = credits_on_stack;
-	wdata->cfile = cfile;
-	wdata->server = server;
-	cfile = NULL;
-
-	/* Find all consecutive lockable dirty pages that have contiguous
-	 * written regions, stopping when we find a page that is not
-	 * immediately lockable, is not dirty or is missing, or we reach the
-	 * end of the range.
-	 */
-	if (start < i_size) {
-		/* Trim the write to the EOF; the extra data is ignored.  Also
-		 * put an upper limit on the size of a single storedata op.
-		 */
-		max_len = wsize;
-		max_len = min_t(unsigned long long, max_len, end - start + 1);
-		max_len = min_t(unsigned long long, max_len, i_size - start);
-
-		if (len < max_len) {
-			int max_pages = INT_MAX;
-
-#ifdef CONFIG_CIFS_SMB_DIRECT
-			if (server->smbd_conn)
-				max_pages = server->smbd_conn->max_frmr_depth;
-#endif
-			max_pages -= folio_nr_pages(folio);
-
-			if (max_pages > 0)
-				cifs_extend_writeback(mapping, xas, &count, start,
-						      max_pages, max_len, &len);
-		}
-	}
-	len = min_t(unsigned long long, len, i_size - start);
-
-	/* We now have a contiguous set of dirty pages, each with writeback
-	 * set; the first page is still locked at this point, but all the rest
-	 * have been unlocked.
-	 */
-	folio_unlock(folio);
-	wdata->subreq.len = len;
-
-	if (start < i_size) {
-		iov_iter_xarray(&wdata->subreq.io_iter, ITER_SOURCE, &mapping->i_pages,
-				start, len);
-
-		rc = adjust_credits(wdata->server, &wdata->credits, wdata->subreq.len);
-		if (rc)
-			goto err_wdata;
-
-		if (wdata->cfile->invalidHandle)
-			rc = -EAGAIN;
-		else
-			rc = wdata->server->ops->async_writev(wdata);
-		if (rc >= 0) {
-			cifs_put_writedata(wdata);
-			goto err_close;
-		}
-	} else {
-		/* The dirty region was entirely beyond the EOF. */
-		cifs_pages_written_back(inode, start, len);
-		rc = 0;
-	}
-
-err_wdata:
-	cifs_put_writedata(wdata);
-err_uncredit:
-	add_credits_and_wake_if(server, credits, 0);
-err_close:
-	if (cfile)
-		cifsFileInfo_put(cfile);
-err_xid:
-	free_xid(xid);
-	if (rc == 0) {
-		wbc->nr_to_write = count;
-		rc = len;
-	} else if (is_retryable_error(rc)) {
-		cifs_pages_write_redirty(inode, start, len);
-	} else {
-		cifs_pages_write_failed(inode, start, len);
-		mapping_set_error(mapping, rc);
-	}
-	/* Indication to update ctime and mtime as close is deferred */
-	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
-	return rc;
-}
-
-/*
- * write a region of pages back to the server
- */
-static ssize_t cifs_writepages_begin(struct address_space *mapping,
-				     struct writeback_control *wbc,
-				     struct xa_state *xas,
-				     unsigned long long *_start,
-				     unsigned long long end)
-{
-	struct folio *folio;
-	unsigned long long start = *_start;
-	ssize_t ret;
-	int skips = 0;
-
-search_again:
-	/* Find the first dirty page. */
-	rcu_read_lock();
-
-	for (;;) {
-		folio = xas_find_marked(xas, end / PAGE_SIZE, PAGECACHE_TAG_DIRTY);
-		if (xas_retry(xas, folio) || xa_is_value(folio))
-			continue;
-		if (!folio)
-			break;
-
-		if (!folio_try_get_rcu(folio)) {
-			xas_reset(xas);
-			continue;
-		}
-
-		if (unlikely(folio != xas_reload(xas))) {
-			folio_put(folio);
-			xas_reset(xas);
-			continue;
-		}
-
-		xas_pause(xas);
-		break;
-	}
-	rcu_read_unlock();
-	if (!folio)
-		return 0;
-
-	start = folio_pos(folio); /* May regress with THPs */
-
-	/* At this point we hold neither the i_pages lock nor the page lock:
-	 * the page may be truncated or invalidated (changing page->mapping to
-	 * NULL), or even swizzled back from swapper_space to tmpfs file
-	 * mapping
-	 */
-lock_again:
-	if (wbc->sync_mode != WB_SYNC_NONE) {
-		ret = folio_lock_killable(folio);
-		if (ret < 0)
-			return ret;
-	} else {
-		if (!folio_trylock(folio))
-			goto search_again;
-	}
-
-	if (folio->mapping != mapping ||
-	    !folio_test_dirty(folio)) {
-		start += folio_size(folio);
-		folio_unlock(folio);
-		goto search_again;
-	}
-
-	if (folio_test_writeback(folio) ||
-	    folio_test_private_2(folio)) { /* [DEPRECATED] */
-		folio_unlock(folio);
-		if (wbc->sync_mode != WB_SYNC_NONE) {
-			folio_wait_writeback(folio);
-#ifdef CONFIG_CIFS_FSCACHE
-			folio_wait_private_2(folio);
-#endif
-			goto lock_again;
-		}
-
-		start += folio_size(folio);
-		if (wbc->sync_mode == WB_SYNC_NONE) {
-			if (skips >= 5 || need_resched()) {
-				ret = 0;
-				goto out;
-			}
-			skips++;
-		}
-		goto search_again;
-	}
-
-	ret = cifs_write_back_from_locked_folio(mapping, wbc, xas, folio, start, end);
-out:
-	if (ret > 0)
-		*_start = start + ret;
-	return ret;
-}
-
-/*
- * Write a region of pages back to the server
- */
-static int cifs_writepages_region(struct address_space *mapping,
-				  struct writeback_control *wbc,
-				  unsigned long long *_start,
-				  unsigned long long end)
-{
-	ssize_t ret;
-
-	XA_STATE(xas, &mapping->i_pages, *_start / PAGE_SIZE);
-
-	do {
-		ret = cifs_writepages_begin(mapping, wbc, &xas, _start, end);
-		if (ret > 0 && wbc->nr_to_write > 0)
-			cond_resched();
-	} while (ret > 0 && wbc->nr_to_write > 0);
-
-	return ret > 0 ? 0 : ret;
-}
-
-/*
- * Write some of the pending data back to the server
- */
-static int cifs_writepages(struct address_space *mapping,
-			   struct writeback_control *wbc)
-{
-	loff_t start, end;
-	int ret;
-
-	/* We have to be careful as we can end up racing with setattr()
-	 * truncating the pagecache since the caller doesn't take a lock here
-	 * to prevent it.
-	 */
-
-	if (wbc->range_cyclic && mapping->writeback_index) {
-		start = mapping->writeback_index * PAGE_SIZE;
-		ret = cifs_writepages_region(mapping, wbc, &start, LLONG_MAX);
-		if (ret < 0)
-			goto out;
-
-		if (wbc->nr_to_write <= 0) {
-			mapping->writeback_index = start / PAGE_SIZE;
-			goto out;
-		}
-
-		start = 0;
-		end = mapping->writeback_index * PAGE_SIZE;
-		mapping->writeback_index = 0;
-		ret = cifs_writepages_region(mapping, wbc, &start, end);
-		if (ret == 0)
-			mapping->writeback_index = start / PAGE_SIZE;
-	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
-		start = 0;
-		ret = cifs_writepages_region(mapping, wbc, &start, LLONG_MAX);
-		if (wbc->nr_to_write > 0 && ret == 0)
-			mapping->writeback_index = start / PAGE_SIZE;
-	} else {
-		start = wbc->range_start;
-		ret = cifs_writepages_region(mapping, wbc, &start, wbc->range_end);
-	}
-
-out:
-	return ret;
-}
-
-static int cifs_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
-{
-	int rc;
-	struct inode *inode = mapping->host;
-	struct cifsFileInfo *cfile = file->private_data;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(cfile->dentry->d_sb);
-	struct folio *folio = page_folio(page);
-	__u32 pid;
-
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
-		pid = cfile->pid;
-	else
-		pid = current->tgid;
-
-	cifs_dbg(FYI, "write_end for page %p from pos %lld with %d bytes\n",
-		 page, pos, copied);
-
-	if (folio_test_checked(folio)) {
-		if (copied == len)
-			folio_mark_uptodate(folio);
-		folio_clear_checked(folio);
-	} else if (!folio_test_uptodate(folio) && copied == PAGE_SIZE)
-		folio_mark_uptodate(folio);
-
-	if (!folio_test_uptodate(folio)) {
-		char *page_data;
-		unsigned offset = pos & (PAGE_SIZE - 1);
-		unsigned int xid;
-
-		xid = get_xid();
-		/* this is probably better than directly calling
-		   partialpage_write since in this function the file handle is
-		   known which we might as well	leverage */
-		/* BB check if anything else missing out of ppw
-		   such as updating last write time */
-		page_data = kmap(page);
-		rc = cifs_write(cfile, pid, page_data + offset, copied, &pos);
-		/* if (rc < 0) should we set writebehind rc? */
-		kunmap(page);
-
-		free_xid(xid);
-	} else {
-		rc = copied;
-		pos += copied;
-		set_page_dirty(page);
-	}
-
-	if (rc > 0) {
-		spin_lock(&inode->i_lock);
-		if (pos > inode->i_size) {
-			loff_t additional_blocks = (512 - 1 + copied) >> 9;
-
-			i_size_write(inode, pos);
-			/*
-			 * Estimate new allocation size based on the amount written.
-			 * This will be updated from server on close (and on queryinfo)
-			 */
-			inode->i_blocks = min_t(blkcnt_t, (512 - 1 + pos) >> 9,
-						inode->i_blocks + additional_blocks);
-		}
-		spin_unlock(&inode->i_lock);
-	}
-
-	unlock_page(page);
-	put_page(page);
-	/* Indication to update ctime and mtime as close is deferred */
-	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
-
-	return rc;
-}
-#endif // End netfs removal 2773
-
 /*
  * Flush data on a strict file.
  */
@@ -4517,6 +3884,7 @@ cifs_read(struct file *file, char *read_data, size_t read_size, loff_t *offset)
 }
 #endif // end netfslib remove 4633
 
+
 static vm_fault_t cifs_page_mkwrite(struct vm_fault *vmf)
 {
 	return netfs_page_mkwrite(vmf, NULL);


