Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E149B58A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 15:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiAYOB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 09:01:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1385922AbiAYN62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643119075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9HP3MD1DfSSpDSHqdPw1zELtDVvoyDQenq8/d5gy62Y=;
        b=PePaKD0vrY3CbJs+RdlLMYFVuh0d3kv11yiEUr2d3lHgfzTNUfRk2+whdb0AKQakKf0p13
        xUXdh81+YaTWQFbdHq//PYcaDa7wH190SlZnkouS5BGW6er3B3lcY6MK9irsEJbSKN+BrJ
        OIsJBAqtLy2qx6784vmGKwP8lRgeTLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-dmO4Of7fNvau3IY-F6jBwQ-1; Tue, 25 Jan 2022 08:57:49 -0500
X-MC-Unique: dmO4Of7fNvau3IY-F6jBwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E47A1922020;
        Tue, 25 Jan 2022 13:57:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FA307D73F;
        Tue, 25 Jan 2022 13:57:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 1/7] cifs: Transition from ->readpages() to ->readahead()
From:   David Howells <dhowells@redhat.com>
To:     smfrench@gmail.com, nspmangalore@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 13:57:44 +0000
Message-ID: <164311906472.2806745.605202239282432844.stgit@warthog.procyon.org.uk>
In-Reply-To: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Transition the cifs filesystem from using the old ->readpages() method to
using the new ->readahead() method.

For the moment, this removes any invocation of fscache to read data from
the local cache, leaving that to another patch.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <smfrench@gmail.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
---

 fs/cifs/file.c |  169 +++++++++++---------------------------------------------
 1 file changed, 33 insertions(+), 136 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 015fd415e5ee..1cce7e5b2334 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4269,8 +4269,6 @@ cifs_readv_complete(struct work_struct *work)
 	for (i = 0; i < rdata->nr_pages; i++) {
 		struct page *page = rdata->pages[i];
 
-		lru_cache_add(page);
-
 		if (rdata->result == 0 ||
 		    (rdata->result == -EAGAIN && got_bytes)) {
 			flush_dcache_page(page);
@@ -4340,7 +4338,6 @@ readpages_fill_pages(struct TCP_Server_Info *server,
 			 * fill them until the writes are flushed.
 			 */
 			zero_user(page, 0, PAGE_SIZE);
-			lru_cache_add(page);
 			flush_dcache_page(page);
 			SetPageUptodate(page);
 			unlock_page(page);
@@ -4350,7 +4347,6 @@ readpages_fill_pages(struct TCP_Server_Info *server,
 			continue;
 		} else {
 			/* no need to hold page hostage */
-			lru_cache_add(page);
 			unlock_page(page);
 			put_page(page);
 			rdata->pages[i] = NULL;
@@ -4393,92 +4389,16 @@ cifs_readpages_copy_into_pages(struct TCP_Server_Info *server,
 	return readpages_fill_pages(server, rdata, iter, iter->count);
 }
 
-static int
-readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
-		    unsigned int rsize, struct list_head *tmplist,
-		    unsigned int *nr_pages, loff_t *offset, unsigned int *bytes)
-{
-	struct page *page, *tpage;
-	unsigned int expected_index;
-	int rc;
-	gfp_t gfp = readahead_gfp_mask(mapping);
-
-	INIT_LIST_HEAD(tmplist);
-
-	page = lru_to_page(page_list);
-
-	/*
-	 * Lock the page and put it in the cache. Since no one else
-	 * should have access to this page, we're safe to simply set
-	 * PG_locked without checking it first.
-	 */
-	__SetPageLocked(page);
-	rc = add_to_page_cache_locked(page, mapping,
-				      page->index, gfp);
-
-	/* give up if we can't stick it in the cache */
-	if (rc) {
-		__ClearPageLocked(page);
-		return rc;
-	}
-
-	/* move first page to the tmplist */
-	*offset = (loff_t)page->index << PAGE_SHIFT;
-	*bytes = PAGE_SIZE;
-	*nr_pages = 1;
-	list_move_tail(&page->lru, tmplist);
-
-	/* now try and add more pages onto the request */
-	expected_index = page->index + 1;
-	list_for_each_entry_safe_reverse(page, tpage, page_list, lru) {
-		/* discontinuity ? */
-		if (page->index != expected_index)
-			break;
-
-		/* would this page push the read over the rsize? */
-		if (*bytes + PAGE_SIZE > rsize)
-			break;
-
-		__SetPageLocked(page);
-		rc = add_to_page_cache_locked(page, mapping, page->index, gfp);
-		if (rc) {
-			__ClearPageLocked(page);
-			break;
-		}
-		list_move_tail(&page->lru, tmplist);
-		(*bytes) += PAGE_SIZE;
-		expected_index++;
-		(*nr_pages)++;
-	}
-	return rc;
-}
-
-static int cifs_readpages(struct file *file, struct address_space *mapping,
-	struct list_head *page_list, unsigned num_pages)
+static void cifs_readahead(struct readahead_control *ractl)
 {
 	int rc;
-	int err = 0;
-	struct list_head tmplist;
-	struct cifsFileInfo *open_file = file->private_data;
-	struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(file);
+	struct cifsFileInfo *open_file = ractl->file->private_data;
+	struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(ractl->file);
 	struct TCP_Server_Info *server;
 	pid_t pid;
 	unsigned int xid;
 
 	xid = get_xid();
-	/*
-	 * Reads as many pages as possible from fscache. Returns -ENOBUFS
-	 * immediately if the cookie is negative
-	 *
-	 * After this point, every page in the list might have PG_fscache set,
-	 * so we will need to clean that up off of every page we don't use.
-	 */
-	rc = cifs_readpages_from_fscache(mapping->host, mapping, page_list,
-					 &num_pages);
-	if (rc == 0) {
-		free_xid(xid);
-		return rc;
-	}
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
 		pid = open_file->pid;
@@ -4489,39 +4409,32 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 
 	cifs_dbg(FYI, "%s: file=%p mapping=%p num_pages=%u\n",
-		 __func__, file, mapping, num_pages);
+		 __func__, ractl->file, ractl->mapping, readahead_count(ractl));
 
 	/*
-	 * Start with the page at end of list and move it to private
-	 * list. Do the same with any following pages until we hit
-	 * the rsize limit, hit an index discontinuity, or run out of
-	 * pages. Issue the async read and then start the loop again
-	 * until the list is empty.
-	 *
-	 * Note that list order is important. The page_list is in
-	 * the order of declining indexes. When we put the pages in
-	 * the rdata->pages, then we want them in increasing order.
+	 * Chop the readahead request up into rsize-sized read requests.
 	 */
-	while (!list_empty(page_list) && !err) {
-		unsigned int i, nr_pages, bytes, rsize;
-		loff_t offset;
-		struct page *page, *tpage;
+	while (readahead_count(ractl) - ractl->_batch_count) {
+		unsigned int i, nr_pages, got, rsize;
+		struct page *page;
 		struct cifs_readdata *rdata;
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
 
 		if (open_file->invalidHandle) {
 			rc = cifs_reopen_file(open_file, true);
-			if (rc == -EAGAIN)
-				continue;
-			else if (rc)
+			if (rc) {
+				if (rc == -EAGAIN)
+					continue;
 				break;
+			}
 		}
 
 		rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
 						   &rsize, credits);
 		if (rc)
 			break;
+		nr_pages = min_t(size_t, rsize / PAGE_SIZE, readahead_count(ractl));
 
 		/*
 		 * Give up immediately if rsize is too small to read an entire
@@ -4529,16 +4442,7 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		 * reach this point however since we set ra_pages to 0 when the
 		 * rsize is smaller than a cache page.
 		 */
-		if (unlikely(rsize < PAGE_SIZE)) {
-			add_credits_and_wake_if(server, credits, 0);
-			free_xid(xid);
-			return 0;
-		}
-
-		nr_pages = 0;
-		err = readpages_get_pages(mapping, page_list, rsize, &tmplist,
-					 &nr_pages, &offset, &bytes);
-		if (!nr_pages) {
+		if (unlikely(!nr_pages)) {
 			add_credits_and_wake_if(server, credits, 0);
 			break;
 		}
@@ -4546,36 +4450,31 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		rdata = cifs_readdata_alloc(nr_pages, cifs_readv_complete);
 		if (!rdata) {
 			/* best to give up if we're out of mem */
-			list_for_each_entry_safe(page, tpage, &tmplist, lru) {
-				list_del(&page->lru);
-				lru_cache_add(page);
-				unlock_page(page);
-				put_page(page);
-			}
-			rc = -ENOMEM;
 			add_credits_and_wake_if(server, credits, 0);
 			break;
 		}
 
-		rdata->cfile = cifsFileInfo_get(open_file);
-		rdata->server = server;
-		rdata->mapping = mapping;
-		rdata->offset = offset;
-		rdata->bytes = bytes;
-		rdata->pid = pid;
-		rdata->pagesz = PAGE_SIZE;
-		rdata->tailsz = PAGE_SIZE;
+		got = __readahead_batch(ractl, rdata->pages, nr_pages);
+		if (got != nr_pages) {
+			pr_warn("__readahead_batch() returned %u/%u\n",
+				got, nr_pages);
+			nr_pages = got;
+		}
+
+		rdata->nr_pages = nr_pages;
+		rdata->bytes	= readahead_batch_length(ractl);
+		rdata->cfile	= cifsFileInfo_get(open_file);
+		rdata->server	= server;
+		rdata->mapping	= ractl->mapping;
+		rdata->offset	= readahead_pos(ractl);
+		rdata->pid	= pid;
+		rdata->pagesz	= PAGE_SIZE;
+		rdata->tailsz	= PAGE_SIZE;
 		rdata->read_into_pages = cifs_readpages_read_into_pages;
 		rdata->copy_into_pages = cifs_readpages_copy_into_pages;
-		rdata->credits = credits_on_stack;
-
-		list_for_each_entry_safe(page, tpage, &tmplist, lru) {
-			list_del(&page->lru);
-			rdata->pages[rdata->nr_pages++] = page;
-		}
+		rdata->credits	= credits_on_stack;
 
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
-
 		if (!rc) {
 			if (rdata->cfile->invalidHandle)
 				rc = -EAGAIN;
@@ -4587,7 +4486,6 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 			add_credits_and_wake_if(server, &rdata->credits, 0);
 			for (i = 0; i < rdata->nr_pages; i++) {
 				page = rdata->pages[i];
-				lru_cache_add(page);
 				unlock_page(page);
 				put_page(page);
 			}
@@ -4600,7 +4498,6 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 	}
 
 	free_xid(xid);
-	return rc;
 }
 
 /*
@@ -4905,7 +4802,7 @@ void cifs_oplock_break(struct work_struct *work)
  * In the non-cached mode (mount with cache=none), we shunt off direct read and write requests
  * so this method should never be called.
  *
- * Direct IO is not yet supported in the cached mode. 
+ * Direct IO is not yet supported in the cached mode.
  */
 static ssize_t
 cifs_direct_io(struct kiocb *iocb, struct iov_iter *iter)
@@ -4987,7 +4884,7 @@ static int cifs_set_page_dirty(struct page *page)
 
 const struct address_space_operations cifs_addr_ops = {
 	.readpage = cifs_readpage,
-	.readpages = cifs_readpages,
+	.readahead = cifs_readahead,
 	.writepage = cifs_writepage,
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,


