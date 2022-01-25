Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3EE49B598
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 15:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386754AbiAYOCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 09:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1385695AbiAYOAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643119198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMnxoC/tm/Le0PTs9L7jXpIOpWSLwNekY7CodNmRy78=;
        b=DwISSVGO7NKn9TCzMFN8yh/A6zNSNdJB/vOjqzW1/UOhapJuYBWapqoG+M06ZBKuZh0WRq
        LrYqdi4yRqlHTwQRWTTD0UrrMi1hEdDtDiwLhxVnOYecDDcETAhu9nxPLxgdZYAOrR7XL+
        WURGyH940LtwGkv2jww1keDW0/4Q23Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-KpvIqEq4N8uo2lrv_c68dg-1; Tue, 25 Jan 2022 08:59:53 -0500
X-MC-Unique: KpvIqEq4N8uo2lrv_c68dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16FBA1083F60;
        Tue, 25 Jan 2022 13:59:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA63D7E125;
        Tue, 25 Jan 2022 13:58:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 6/7] cifs: Get direct I/O and unbuffered I/O working with
 iterators
From:   David Howells <dhowells@redhat.com>
To:     smfrench@gmail.com, nspmangalore@gmail.com
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 13:58:53 +0000
Message-ID: <164311913303.2806745.13306912789898168904.stgit@warthog.procyon.org.uk>
In-Reply-To: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 fs/cifs/cifsproto.h |    1 
 fs/cifs/file.c      |  299 ++++++---------------------------------------------
 fs/cifs/misc.c      |   90 ---------------
 3 files changed, 35 insertions(+), 355 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 1b143f0a03c0..fb6bcda46266 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -595,7 +595,6 @@ enum securityEnum cifs_select_sectype(struct TCP_Server_Info *,
 					enum securityEnum);
 struct cifs_aio_ctx *cifs_aio_ctx_alloc(void);
 void cifs_aio_ctx_release(struct kref *refcount);
-int setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw);
 void smb2_cached_lease_break(struct work_struct *work);
 
 int cifs_alloc_hash(const char *name, struct crypto_shash **shash,
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index b57f9b492227..f9b9a1562e17 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3321,6 +3321,9 @@ cifs_readdata_release(struct kref *refcount)
 {
 	struct cifs_readdata *rdata = container_of(refcount,
 					struct cifs_readdata, refcount);
+
+	if (rdata->ctx)
+		kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (rdata->mr) {
 		smbd_deregister_mr(rdata->mr);
@@ -3330,85 +3333,9 @@ cifs_readdata_release(struct kref *refcount)
 	if (rdata->cfile)
 		cifsFileInfo_put(rdata->cfile);
 
-	kvfree(rdata->pages);
 	kfree(rdata);
 }
 
-static int
-cifs_read_allocate_pages(struct cifs_readdata *rdata, unsigned int nr_pages)
-{
-	int rc = 0;
-	struct page *page;
-	unsigned int i;
-
-	for (i = 0; i < nr_pages; i++) {
-		page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
-		if (!page) {
-			rc = -ENOMEM;
-			break;
-		}
-		rdata->pages[i] = page;
-	}
-
-	if (rc) {
-		unsigned int nr_page_failed = i;
-
-		for (i = 0; i < nr_page_failed; i++) {
-			put_page(rdata->pages[i]);
-			rdata->pages[i] = NULL;
-		}
-	}
-	return rc;
-}
-
-static void
-cifs_uncached_readdata_release(struct kref *refcount)
-{
-	struct cifs_readdata *rdata = container_of(refcount,
-					struct cifs_readdata, refcount);
-	unsigned int i;
-
-	kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
-	for (i = 0; i < rdata->nr_pages; i++) {
-		put_page(rdata->pages[i]);
-	}
-	cifs_readdata_release(refcount);
-}
-
-/**
- * cifs_readdata_to_iov - copy data from pages in response to an iovec
- * @rdata:	the readdata response with list of pages holding data
- * @iter:	destination for our data
- *
- * This function copies data from a list of pages in a readdata response into
- * an array of iovecs. It will first calculate where the data should go
- * based on the info in the readdata and then copy the data into that spot.
- */
-static int
-cifs_readdata_to_iov(struct cifs_readdata *rdata, struct iov_iter *iter)
-{
-	size_t remaining = rdata->got_bytes;
-	unsigned int i;
-
-	for (i = 0; i < rdata->nr_pages; i++) {
-		struct page *page = rdata->pages[i];
-		size_t copy = min_t(size_t, remaining, PAGE_SIZE);
-		size_t written;
-
-		if (unlikely(iov_iter_is_pipe(iter))) {
-			void *addr = kmap_atomic(page);
-
-			written = copy_to_iter(addr, copy, iter);
-			kunmap_atomic(addr);
-		} else
-			written = copy_page_to_iter(page, 0, copy, iter);
-		remaining -= written;
-		if (written < copy && iov_iter_count(iter) > 0)
-			break;
-	}
-	return remaining ? -EFAULT : 0;
-}
-
 static void collect_uncached_read_data(struct cifs_aio_ctx *ctx);
 
 static void
@@ -3420,81 +3347,7 @@ cifs_uncached_readv_complete(struct work_struct *work)
 	complete(&rdata->done);
 	collect_uncached_read_data(rdata->ctx);
 	/* the below call can possibly free the last ref to aio ctx */
-	kref_put(&rdata->refcount, cifs_uncached_readdata_release);
-}
-
-static int
-uncached_fill_pages(struct TCP_Server_Info *server,
-		    struct cifs_readdata *rdata, struct iov_iter *iter,
-		    unsigned int len)
-{
-	int result = 0;
-	unsigned int i;
-	unsigned int nr_pages = rdata->nr_pages;
-	unsigned int page_offset = rdata->page_offset;
-
-	rdata->got_bytes = 0;
-	rdata->tailsz = PAGE_SIZE;
-	for (i = 0; i < nr_pages; i++) {
-		struct page *page = rdata->pages[i];
-		size_t n;
-		unsigned int segment_size = rdata->pagesz;
-
-		if (i == 0)
-			segment_size -= page_offset;
-		else
-			page_offset = 0;
-
-
-		if (len <= 0) {
-			/* no need to hold page hostage */
-			rdata->pages[i] = NULL;
-			rdata->nr_pages--;
-			put_page(page);
-			continue;
-		}
-
-		n = len;
-		if (len >= segment_size)
-			/* enough data to fill the page */
-			n = segment_size;
-		else
-			rdata->tailsz = len;
-		len -= n;
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
-	}
-
-	return rdata->got_bytes > 0 && result != -ECONNABORTED ?
-						rdata->got_bytes : result;
-}
-
-static int
-cifs_uncached_read_into_pages(struct TCP_Server_Info *server,
-			      struct cifs_readdata *rdata, unsigned int len)
-{
-	return uncached_fill_pages(server, rdata, NULL, len);
-}
-
-static int
-cifs_uncached_copy_into_pages(struct TCP_Server_Info *server,
-			      struct cifs_readdata *rdata,
-			      struct iov_iter *iter)
-{
-	return uncached_fill_pages(server, rdata, iter, iter->count);
+	kref_put(&rdata->refcount, cifs_readdata_release);
 }
 
 static int cifs_resend_rdata(struct cifs_readdata *rdata,
@@ -3565,7 +3418,7 @@ static int cifs_resend_rdata(struct cifs_readdata *rdata,
 	} while (rc == -EAGAIN);
 
 fail:
-	kref_put(&rdata->refcount, cifs_uncached_readdata_release);
+	kref_put(&rdata->refcount, cifs_readdata_release);
 	return rc;
 }
 
@@ -3575,16 +3428,13 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 		     struct cifs_aio_ctx *ctx)
 {
 	struct cifs_readdata *rdata;
-	unsigned int npages, rsize;
+	unsigned int rsize;
 	struct cifs_credits credits_on_stack;
 	struct cifs_credits *credits = &credits_on_stack;
 	size_t cur_len;
 	int rc;
 	pid_t pid;
 	struct TCP_Server_Info *server;
-	struct page **pagevec;
-	size_t start;
-	struct iov_iter direct_iov = ctx->iter;
 
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 
@@ -3593,9 +3443,6 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 	else
 		pid = current->tgid;
 
-	if (ctx->direct_io)
-		iov_iter_advance(&direct_iov, offset - ctx->pos);
-
 	do {
 		if (open_file->invalidHandle) {
 			rc = cifs_reopen_file(open_file, true);
@@ -3612,77 +3459,26 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 
 		cur_len = min_t(const size_t, len, rsize);
 
-		if (ctx->direct_io) {
-			ssize_t result;
-
-			result = iov_iter_get_pages_alloc(
-					&direct_iov, &pagevec,
-					cur_len, &start);
-			if (result < 0) {
-				cifs_dbg(VFS,
-					 "Couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
-					 result, iov_iter_type(&direct_iov),
-					 direct_iov.iov_offset,
-					 direct_iov.count);
-				dump_stack();
-
-				rc = result;
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-			cur_len = (size_t)result;
-			iov_iter_advance(&direct_iov, cur_len);
-
-			rdata = cifs_readdata_direct_alloc(
-					pagevec, cifs_uncached_readv_complete);
-			if (!rdata) {
-				add_credits_and_wake_if(server, credits, 0);
-				rc = -ENOMEM;
-				break;
-			}
-
-			npages = (cur_len + start + PAGE_SIZE-1) / PAGE_SIZE;
-			rdata->page_offset = start;
-			rdata->tailsz = npages > 1 ?
-				cur_len-(PAGE_SIZE-start)-(npages-2)*PAGE_SIZE :
-				cur_len;
-
-		} else {
-
-			npages = DIV_ROUND_UP(cur_len, PAGE_SIZE);
-			/* allocate a readdata struct */
-			rdata = cifs_readdata_alloc(npages,
-					    cifs_uncached_readv_complete);
-			if (!rdata) {
-				add_credits_and_wake_if(server, credits, 0);
-				rc = -ENOMEM;
-				break;
-			}
-
-			rc = cifs_read_allocate_pages(rdata, npages);
-			if (rc) {
-				kvfree(rdata->pages);
-				kfree(rdata);
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-
-			rdata->tailsz = PAGE_SIZE;
+		rdata = cifs_readdata_alloc(cifs_uncached_readv_complete);
+		if (!rdata) {
+			add_credits_and_wake_if(server, credits, 0);
+			rc = -ENOMEM;
+			break;
 		}
 
-		rdata->server = server;
-		rdata->cfile = cifsFileInfo_get(open_file);
-		rdata->nr_pages = npages;
-		rdata->offset = offset;
-		rdata->bytes = cur_len;
-		rdata->pid = pid;
-		rdata->pagesz = PAGE_SIZE;
-		rdata->read_into_pages = cifs_uncached_read_into_pages;
-		rdata->copy_into_pages = cifs_uncached_copy_into_pages;
-		rdata->credits = credits_on_stack;
-		rdata->ctx = ctx;
+		rdata->server	= server;
+		rdata->cfile	= cifsFileInfo_get(open_file);
+		rdata->offset	= offset;
+		rdata->bytes	= cur_len;
+		rdata->pid	= pid;
+		rdata->credits	= credits_on_stack;
+		rdata->ctx	= ctx;
 		kref_get(&ctx->refcount);
 
+		rdata->iter	= ctx->iter;
+		iov_iter_advance(&rdata->iter, offset - ctx->pos);
+		iov_iter_truncate(&rdata->iter, cur_len);
+
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 
 		if (!rc) {
@@ -3694,12 +3490,9 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 
 		if (rc) {
 			add_credits_and_wake_if(server, &rdata->credits, 0);
-			kref_put(&rdata->refcount,
-				cifs_uncached_readdata_release);
-			if (rc == -EAGAIN) {
-				iov_iter_revert(&direct_iov, cur_len);
+			kref_put(&rdata->refcount, cifs_readdata_release);
+			if (rc == -EAGAIN)
 				continue;
-			}
 			break;
 		}
 
@@ -3746,22 +3539,6 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 				list_del_init(&rdata->list);
 				INIT_LIST_HEAD(&tmp_list);
 
-				/*
-				 * Got a part of data and then reconnect has
-				 * happened -- fill the buffer and continue
-				 * reading.
-				 */
-				if (got_bytes && got_bytes < rdata->bytes) {
-					rc = 0;
-					if (!ctx->direct_io)
-						rc = cifs_readdata_to_iov(rdata, to);
-					if (rc) {
-						kref_put(&rdata->refcount,
-							cifs_uncached_readdata_release);
-						continue;
-					}
-				}
-
 				if (ctx->direct_io) {
 					/*
 					 * Re-use rdata as this is a
@@ -3778,7 +3555,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 						&tmp_list, ctx);
 
 					kref_put(&rdata->refcount,
-						cifs_uncached_readdata_release);
+						cifs_readdata_release);
 				}
 
 				list_splice(&tmp_list, &ctx->list);
@@ -3786,8 +3563,6 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 				goto again;
 			} else if (rdata->result)
 				rc = rdata->result;
-			else if (!ctx->direct_io)
-				rc = cifs_readdata_to_iov(rdata, to);
 
 			/* if there was a short read -- discard anything left */
 			if (rdata->got_bytes && rdata->got_bytes < rdata->bytes)
@@ -3796,7 +3571,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 			ctx->total_len += rdata->got_bytes;
 		}
 		list_del_init(&rdata->list);
-		kref_put(&rdata->refcount, cifs_uncached_readdata_release);
+		kref_put(&rdata->refcount, cifs_readdata_release);
 	}
 
 	if (!ctx->direct_io)
@@ -3856,7 +3631,10 @@ static ssize_t __cifs_readv(
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->cfile = cifsFileInfo_get(cfile);
+	ctx->pos	= offset;
+	ctx->direct_io	= direct;
+	ctx->len	= len;
+	ctx->cfile	= cifsFileInfo_get(cfile);
 
 	if (!is_sync_kiocb(iocb))
 		ctx->iocb = iocb;
@@ -3864,19 +3642,12 @@ static ssize_t __cifs_readv(
 	if (iter_is_iovec(to))
 		ctx->should_dirty = true;
 
-	if (direct) {
-		ctx->pos = offset;
-		ctx->direct_io = true;
-		ctx->iter = *to;
-		ctx->len = len;
-	} else {
-		rc = setup_aio_ctx_iter(ctx, to, READ);
-		if (rc) {
-			kref_put(&ctx->refcount, cifs_aio_ctx_release);
-			return rc;
-		}
-		len = ctx->len;
+	rc = extract_iter_to_iter(to, len, &ctx->iter, &ctx->bv);
+	if (rc < 0) {
+		kref_put(&ctx->refcount, cifs_aio_ctx_release);
+		return rc;
 	}
+	ctx->npages = rc;
 
 	/* grab a lock here due to read response handlers can access ctx */
 	mutex_lock(&ctx->aio_mutex);
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index f5fe5720456a..6bbc314ab84c 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -974,96 +974,6 @@ cifs_aio_ctx_release(struct kref *refcount)
 	kfree(ctx);
 }
 
-#define CIFS_AIO_KMALLOC_LIMIT (1024 * 1024)
-
-int
-setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
-{
-	ssize_t rc;
-	unsigned int cur_npages;
-	unsigned int npages = 0;
-	unsigned int i;
-	size_t len;
-	size_t count = iov_iter_count(iter);
-	unsigned int saved_len;
-	size_t start;
-	unsigned int max_pages = iov_iter_npages(iter, INT_MAX);
-	struct page **pages = NULL;
-	struct bio_vec *bv = NULL;
-
-	if (iov_iter_is_kvec(iter)) {
-		memcpy(&ctx->iter, iter, sizeof(*iter));
-		ctx->len = count;
-		iov_iter_advance(iter, count);
-		return 0;
-	}
-
-	if (array_size(max_pages, sizeof(*bv)) <= CIFS_AIO_KMALLOC_LIMIT)
-		bv = kmalloc_array(max_pages, sizeof(*bv), GFP_KERNEL);
-
-	if (!bv) {
-		bv = vmalloc(array_size(max_pages, sizeof(*bv)));
-		if (!bv)
-			return -ENOMEM;
-	}
-
-	if (array_size(max_pages, sizeof(*pages)) <= CIFS_AIO_KMALLOC_LIMIT)
-		pages = kmalloc_array(max_pages, sizeof(*pages), GFP_KERNEL);
-
-	if (!pages) {
-		pages = vmalloc(array_size(max_pages, sizeof(*pages)));
-		if (!pages) {
-			kvfree(bv);
-			return -ENOMEM;
-		}
-	}
-
-	saved_len = count;
-
-	while (count && npages < max_pages) {
-		rc = iov_iter_get_pages(iter, pages, count, max_pages, &start);
-		if (rc < 0) {
-			cifs_dbg(VFS, "Couldn't get user pages (rc=%zd)\n", rc);
-			break;
-		}
-
-		if (rc > count) {
-			cifs_dbg(VFS, "get pages rc=%zd more than %zu\n", rc,
-				 count);
-			break;
-		}
-
-		iov_iter_advance(iter, rc);
-		count -= rc;
-		rc += start;
-		cur_npages = DIV_ROUND_UP(rc, PAGE_SIZE);
-
-		if (npages + cur_npages > max_pages) {
-			cifs_dbg(VFS, "out of vec array capacity (%u vs %u)\n",
-				 npages + cur_npages, max_pages);
-			break;
-		}
-
-		for (i = 0; i < cur_npages; i++) {
-			len = rc > PAGE_SIZE ? PAGE_SIZE : rc;
-			bv[npages + i].bv_page = pages[i];
-			bv[npages + i].bv_offset = start;
-			bv[npages + i].bv_len = len - start;
-			rc -= len;
-			start = 0;
-		}
-
-		npages += cur_npages;
-	}
-
-	kvfree(pages);
-	ctx->bv = bv;
-	ctx->len = saved_len - count;
-	ctx->npages = npages;
-	iov_iter_bvec(&ctx->iter, rw, ctx->bv, npages, ctx->len);
-	return 0;
-}
-
 /**
  * cifs_alloc_hash - allocate hash and hash context together
  * @name: The name of the crypto hash algo


