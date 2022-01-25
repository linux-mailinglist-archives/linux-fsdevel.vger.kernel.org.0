Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE849B591
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 15:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386004AbiAYOCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 09:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1386968AbiAYN7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643119134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccbPkGHDvnm/jO+h2W7/WQj7IG4rRzK7Qeqv7RS6pTU=;
        b=JHpkFV/0NynLQd16VJ5q+7nvAYxtbf6RSEwQATGfx5IOBuZ28kOH6fYkaVLat2BRB5KFf8
        TMVffV8ozCaCaJ1dJ61mTebs19mToxJVRVPiwT0XG8D3zimeVJNlmeeI3e+uvw6032GgWs
        aENQ8PdpjOwWjooEHelSNw1f0K0BvLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-SWP8B1yAM7S1D9XQZ4nrXQ-1; Tue, 25 Jan 2022 08:58:49 -0500
X-MC-Unique: SWP8B1yAM7S1D9XQZ4nrXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C58EA51081;
        Tue, 25 Jan 2022 13:58:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5198A66E34;
        Tue, 25 Jan 2022 13:58:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 5/7] cifs: Make cifs_readahead() pass an iterator down
From:   David Howells <dhowells@redhat.com>
To:     smfrench@gmail.com, nspmangalore@gmail.com
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 13:58:27 +0000
Message-ID: <164311910701.2806745.8126438935821941351.stgit@warthog.procyon.org.uk>
In-Reply-To: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 fs/cifs/file.c |  214 +++++++++++++-------------------------------------------
 1 file changed, 50 insertions(+), 164 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f40e5b938d43..b57f9b492227 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3301,14 +3301,12 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 	return written;
 }
 
-static struct cifs_readdata *
-cifs_readdata_direct_alloc(struct page **pages, work_func_t complete)
+static struct cifs_readdata *cifs_readdata_alloc(work_func_t complete)
 {
 	struct cifs_readdata *rdata;
 
 	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
-	if (rdata != NULL) {
-		rdata->pages = pages;
+	if (rdata) {
 		kref_init(&rdata->refcount);
 		INIT_LIST_HEAD(&rdata->list);
 		init_completion(&rdata->done);
@@ -3318,22 +3316,6 @@ cifs_readdata_direct_alloc(struct page **pages, work_func_t complete)
 	return rdata;
 }
 
-static struct cifs_readdata *
-cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
-{
-	struct page **pages =
-		kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
-	struct cifs_readdata *ret = NULL;
-
-	if (pages) {
-		ret = cifs_readdata_direct_alloc(pages, complete);
-		if (!ret)
-			kfree(pages);
-	}
-
-	return ret;
-}
-
 void
 cifs_readdata_release(struct kref *refcount)
 {
@@ -4147,145 +4129,60 @@ int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return rc;
 }
 
-static void
-cifs_readv_complete(struct work_struct *work)
+/*
+ * Unlock a bunch of folios in the pagecache.
+ */
+static void cifs_unlock_folios(struct address_space *mapping, pgoff_t first, pgoff_t last)
 {
-	unsigned int i, got_bytes;
-	struct cifs_readdata *rdata = container_of(work,
-						struct cifs_readdata, work);
-
-	got_bytes = rdata->got_bytes;
-	for (i = 0; i < rdata->nr_pages; i++) {
-		struct page *page = rdata->pages[i];
-
-		if (rdata->result == 0 ||
-		    (rdata->result == -EAGAIN && got_bytes)) {
-			flush_dcache_page(page);
-			SetPageUptodate(page);
-		} else
-			SetPageError(page);
-
-		unlock_page(page);
-
-		if (rdata->result == 0 ||
-		    (rdata->result == -EAGAIN && got_bytes))
-			cifs_readpage_to_fscache(rdata->mapping->host, page);
-
-		got_bytes -= min_t(unsigned int, PAGE_SIZE, got_bytes);
-
-		put_page(page);
-		rdata->pages[i] = NULL;
-	}
-	kref_put(&rdata->refcount, cifs_readdata_release);
+       struct folio *folio;
+       XA_STATE(xas, &mapping->i_pages, first);
+
+       rcu_read_lock();
+       xas_for_each(&xas, folio, last) {
+               folio_unlock(folio);
+       }
+       rcu_read_unlock();
 }
 
-static int
-readpages_fill_pages(struct TCP_Server_Info *server,
-		     struct cifs_readdata *rdata, struct iov_iter *iter,
-		     unsigned int len)
+static void cifs_readahead_complete(struct work_struct *work)
 {
-	int result = 0;
-	unsigned int i;
-	u64 eof;
-	pgoff_t eof_index;
-	unsigned int nr_pages = rdata->nr_pages;
-	unsigned int page_offset = rdata->page_offset;
+	struct cifs_readdata *rdata = container_of(work,
+						   struct cifs_readdata, work);
+	struct folio *folio;
+	pgoff_t last;
+	bool good = rdata->result == 0 || (rdata->result == -EAGAIN && rdata->got_bytes);
 
-	/* determine the eof that the server (probably) has */
-	eof = CIFS_I(rdata->mapping->host)->server_eof;
-	eof_index = eof ? (eof - 1) >> PAGE_SHIFT : 0;
-	cifs_dbg(FYI, "eof=%llu eof_index=%lu\n", eof, eof_index);
+	XA_STATE(xas, &rdata->mapping->i_pages, rdata->offset / PAGE_SIZE);
 
-	rdata->got_bytes = 0;
-	rdata->tailsz = PAGE_SIZE;
-	for (i = 0; i < nr_pages; i++) {
-		struct page *page = rdata->pages[i];
-		unsigned int to_read = rdata->pagesz;
-		size_t n;
+#if 0
+	if (good)
+		cifs_readpage_to_fscache(rdata->mapping->host, page);
+#endif
 
-		if (i == 0)
-			to_read -= page_offset;
-		else
-			page_offset = 0;
+	if (iov_iter_count(&rdata->iter) > 0)
+		iov_iter_zero(iov_iter_count(&rdata->iter), &rdata->iter);
 
-		n = to_read;
+	last = round_down(rdata->offset + rdata->got_bytes - 1, PAGE_SIZE);
 
-		if (len >= to_read) {
-			len -= to_read;
-		} else if (len > 0) {
-			/* enough for partial page, fill and zero the rest */
-			zero_user(page, len + page_offset, to_read - len);
-			n = rdata->tailsz = len;
-			len = 0;
-		} else if (page->index > eof_index) {
-			/*
-			 * The VFS will not try to do readahead past the
-			 * i_size, but it's possible that we have outstanding
-			 * writes with gaps in the middle and the i_size hasn't
-			 * caught up yet. Populate those with zeroed out pages
-			 * to prevent the VFS from repeatedly attempting to
-			 * fill them until the writes are flushed.
-			 */
-			zero_user(page, 0, PAGE_SIZE);
-			flush_dcache_page(page);
-			SetPageUptodate(page);
-			unlock_page(page);
-			put_page(page);
-			rdata->pages[i] = NULL;
-			rdata->nr_pages--;
-			continue;
-		} else {
-			/* no need to hold page hostage */
-			unlock_page(page);
-			put_page(page);
-			rdata->pages[i] = NULL;
-			rdata->nr_pages--;
-			continue;
+	xas_for_each(&xas, folio, last) {
+		if (good) {
+			flush_dcache_folio(folio);
+			folio_mark_uptodate(folio);
 		}
-
-		if (iter)
-			result = copy_page_from_iter(
-					page, page_offset, n, iter);
-#ifdef CONFIG_CIFS_SMB_DIRECT
-		else if (rdata->mr)
-			result = n;
-#endif
-		else
-			result = cifs_read_page_from_socket(
-					server, page, page_offset, n);
-		if (result < 0)
-			break;
-
-		rdata->got_bytes += result;
+		folio_unlock(folio);
 	}
 
-	return rdata->got_bytes > 0 && result != -ECONNABORTED ?
-						rdata->got_bytes : result;
-}
-
-static int
-cifs_readpages_read_into_pages(struct TCP_Server_Info *server,
-			       struct cifs_readdata *rdata, unsigned int len)
-{
-	return readpages_fill_pages(server, rdata, NULL, len);
-}
-
-static int
-cifs_readpages_copy_into_pages(struct TCP_Server_Info *server,
-			       struct cifs_readdata *rdata,
-			       struct iov_iter *iter)
-{
-	return readpages_fill_pages(server, rdata, iter, iter->count);
+	kref_put(&rdata->refcount, cifs_readdata_release);
 }
 
 static void cifs_readahead(struct readahead_control *ractl)
 {
-	int rc;
 	struct cifsFileInfo *open_file = ractl->file->private_data;
 	struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(ractl->file);
 	struct TCP_Server_Info *server;
-	pid_t pid;
 	unsigned int xid;
+	pid_t pid;
+	int rc = 0;
 
 	xid = get_xid();
 
@@ -4294,7 +4191,6 @@ static void cifs_readahead(struct readahead_control *ractl)
 	else
 		pid = current->tgid;
 
-	rc = 0;
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 
 	cifs_dbg(FYI, "%s: file=%p mapping=%p num_pages=%u\n",
@@ -4304,8 +4200,7 @@ static void cifs_readahead(struct readahead_control *ractl)
 	 * Chop the readahead request up into rsize-sized read requests.
 	 */
 	while (readahead_count(ractl) - ractl->_batch_count) {
-		unsigned int i, nr_pages, got, rsize;
-		struct page *page;
+		unsigned int i, nr_pages, rsize;
 		struct cifs_readdata *rdata;
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
@@ -4336,33 +4231,28 @@ static void cifs_readahead(struct readahead_control *ractl)
 			break;
 		}
 
-		rdata = cifs_readdata_alloc(nr_pages, cifs_readv_complete);
+		rdata = cifs_readdata_alloc(cifs_readahead_complete);
 		if (!rdata) {
 			/* best to give up if we're out of mem */
 			add_credits_and_wake_if(server, credits, 0);
 			break;
 		}
 
-		got = __readahead_batch(ractl, rdata->pages, nr_pages);
-		if (got != nr_pages) {
-			pr_warn("__readahead_batch() returned %u/%u\n",
-				got, nr_pages);
-			nr_pages = got;
-		}
-
-		rdata->nr_pages = nr_pages;
-		rdata->bytes	= readahead_batch_length(ractl);
+		rdata->offset	= readahead_pos(ractl);
+		rdata->bytes	= nr_pages * PAGE_SIZE;
 		rdata->cfile	= cifsFileInfo_get(open_file);
 		rdata->server	= server;
 		rdata->mapping	= ractl->mapping;
-		rdata->offset	= readahead_pos(ractl);
 		rdata->pid	= pid;
-		rdata->pagesz	= PAGE_SIZE;
-		rdata->tailsz	= PAGE_SIZE;
-		rdata->read_into_pages = cifs_readpages_read_into_pages;
-		rdata->copy_into_pages = cifs_readpages_copy_into_pages;
 		rdata->credits	= credits_on_stack;
 
+		for (i = 0; i < nr_pages; i++)
+			if (!readahead_folio(ractl))
+				BUG();
+
+		iov_iter_xarray(&rdata->iter, READ, &rdata->mapping->i_pages,
+				rdata->offset, rdata->bytes);
+
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 		if (!rc) {
 			if (rdata->cfile->invalidHandle)
@@ -4373,17 +4263,13 @@ static void cifs_readahead(struct readahead_control *ractl)
 
 		if (rc) {
 			add_credits_and_wake_if(server, &rdata->credits, 0);
-			for (i = 0; i < rdata->nr_pages; i++) {
-				page = rdata->pages[i];
-				unlock_page(page);
-				put_page(page);
-			}
+			cifs_unlock_folios(rdata->mapping,
+					   rdata->offset / PAGE_SIZE,
+					   (rdata->offset + rdata->bytes - 1) / PAGE_SIZE);
 			/* Fallback to the readpage in error/reconnect cases */
 			kref_put(&rdata->refcount, cifs_readdata_release);
 			break;
 		}
-
-		kref_put(&rdata->refcount, cifs_readdata_release);
 	}
 
 	free_xid(xid);


