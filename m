Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5EB1C41BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgEDRNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:13:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730495AbgEDRNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+p3ydnItH6SGATt95zETPy/GgUnp8my9xHaOjOOl1I=;
        b=WAt1E5K9F6a2KoHOt4idHKeSRSZZLI89Y5trzJnj+ocDgr7Mcnu8jpgvvSTCbvyrreqg6C
        O3YOkncapU6O4M6uD7YfejZoNdhsRKkgF0RMKWTippKf3+i7eHBUOpGELP+wnQuKnmlRl3
        V3njnOh3pUY2c0QkW8arOmyoW9PwIoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-vy4FYchEObeyPJFSHqR0ew-1; Mon, 04 May 2020 13:13:46 -0400
X-MC-Unique: vy4FYchEObeyPJFSHqR0ew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A561D835B40;
        Mon,  4 May 2020 17:13:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0078E5D9D3;
        Mon,  4 May 2020 17:13:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 41/61] fscache: New stats
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:13:41 +0100
Message-ID: <158861242112.340223.12171840222439799009.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create some new stat counters appropriate to the new routines and display them
in /proc/fs/fscache/stats.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/dispatcher.c  |    6 +++++
 fs/fscache/internal.h    |   25 +++++++++++++++++++++
 fs/fscache/io.c          |    2 ++
 fs/fscache/read_helper.c |   38 +++++++++++++++++++++++++++++---
 fs/fscache/stats.c       |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/fs/fscache/dispatcher.c b/fs/fscache/dispatcher.c
index fba71b99c951..489b8ab8cccd 100644
--- a/fs/fscache/dispatcher.c
+++ b/fs/fscache/dispatcher.c
@@ -41,6 +41,8 @@ void fscache_dispatch(struct fscache_cookie *cookie,
 	struct fscache_work *work;
 	bool queued = false;
 
+	fscache_stat(&fscache_n_dispatch_count);
+
 	work = kzalloc(sizeof(struct fscache_work), GFP_KERNEL);
 	if (work) {
 		work->cookie = cookie;
@@ -57,10 +59,13 @@ void fscache_dispatch(struct fscache_cookie *cookie,
 			queued = true;
 		}
 		spin_unlock(&fscache_work_lock);
+		if (queued)
+			fscache_stat(&fscache_n_dispatch_deferred);
 	}
 
 	if (!queued) {
 		kfree(work);
+		fscache_stat(&fscache_n_dispatch_inline);
 		func(cookie, object, param);
 	}
 }
@@ -86,6 +91,7 @@ static int fscache_dispatcher(void *data)
 
 			if (work) {
 				work->func(work->cookie, work->object, work->param);
+				fscache_stat(&fscache_n_dispatch_in_pool);
 				fscache_cookie_put(work->cookie, fscache_cookie_put_work);
 				kfree(work);
 			}
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index d168e37011af..b9cad60e3c4e 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -207,6 +207,31 @@ extern atomic_t fscache_n_cache_stale_objects;
 extern atomic_t fscache_n_cache_retired_objects;
 extern atomic_t fscache_n_cache_culled_objects;
 
+extern atomic_t fscache_n_dispatch_count;
+extern atomic_t fscache_n_dispatch_deferred;
+extern atomic_t fscache_n_dispatch_inline;
+extern atomic_t fscache_n_dispatch_in_pool;
+
+extern atomic_t fscache_n_read;
+extern atomic_t fscache_n_write;
+
+extern atomic_t fscache_n_read_helper;
+extern atomic_t fscache_n_read_helper_stop_nomem;
+extern atomic_t fscache_n_read_helper_stop_noncontig;
+extern atomic_t fscache_n_read_helper_stop_uptodate;
+extern atomic_t fscache_n_read_helper_stop_exist;
+extern atomic_t fscache_n_read_helper_stop_kill;
+extern atomic_t fscache_n_read_helper_read;
+extern atomic_t fscache_n_read_helper_download;
+extern atomic_t fscache_n_read_helper_zero;
+extern atomic_t fscache_n_read_helper_beyond_eof;
+extern atomic_t fscache_n_read_helper_reissue;
+extern atomic_t fscache_n_read_helper_read_done;
+extern atomic_t fscache_n_read_helper_read_failed;
+extern atomic_t fscache_n_read_helper_copy;
+extern atomic_t fscache_n_read_helper_copy_done;
+extern atomic_t fscache_n_read_helper_copy_failed;
+
 static inline void fscache_stat(atomic_t *stat)
 {
 	atomic_inc(stat);
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 0cea98bbb8ad..66005c9d2d99 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -141,6 +141,7 @@ int __fscache_read(struct fscache_io_request *req, struct iov_iter *iter)
 		fscache_begin_io_operation(req->cookie, FSCACHE_WANT_READ, req);
 
 	if (!IS_ERR(object)) {
+		fscache_stat(&fscache_n_read);
 		req->object = object;
 		return object->cache->ops->read(object, req, iter);
 	} else {
@@ -161,6 +162,7 @@ int __fscache_write(struct fscache_io_request *req, struct iov_iter *iter)
 		fscache_begin_io_operation(req->cookie, FSCACHE_WANT_WRITE, req);
 
 	if (!IS_ERR(object)) {
+		fscache_stat(&fscache_n_write);
 		req->object = object;
 		return object->cache->ops->write(object, req, iter);
 	} else {
diff --git a/fs/fscache/read_helper.c b/fs/fscache/read_helper.c
index 9ed6e76ef255..b36ad2a0b749 100644
--- a/fs/fscache/read_helper.c
+++ b/fs/fscache/read_helper.c
@@ -32,6 +32,11 @@ static void fscache_read_copy_done(struct fscache_io_request *req)
 
 	_enter("%lx,%x,%llx", index, req->nr_pages, req->transferred);
 
+	if (req->error == 0)
+		fscache_stat(&fscache_n_read_helper_copy_done);
+	else
+		fscache_stat(&fscache_n_read_helper_copy_failed);
+
 	/* Clear PG_fscache on the pages that were being written out. */
 	rcu_read_lock();
 	xas_for_each(&xas, page, last) {
@@ -54,6 +59,8 @@ static void fscache_do_read_copy_to_cache(struct work_struct *work)
 
 	_enter("");
 
+	fscache_stat(&fscache_n_read_helper_copy);
+
 	iov_iter_mapping(&iter, WRITE, req->mapping, req->pos,
 			 round_up(req->len, req->dio_block_size));
 
@@ -106,6 +113,11 @@ static void fscache_read_done(struct fscache_io_request *req)
 	_enter("%lx,%x,%llx,%d",
 	       start, req->nr_pages, req->transferred, req->error);
 
+	if (req->error == 0)
+		fscache_stat(&fscache_n_read_helper_read_done);
+	else
+		fscache_stat(&fscache_n_read_helper_read_failed);
+
 	if (req->transferred < req->len)
 		fscache_clear_unread(req);
 
@@ -157,6 +169,7 @@ static void fscache_file_read_maybe_reissue(struct fscache_io_request *req)
 	if (req->error == 0) {
 		fscache_read_done(req);
 	} else {
+		fscache_stat(&fscache_n_read_helper_reissue);
 		INIT_WORK(&req->work, fscache_reissue_read);
 		fscache_get_io_request(req);
 		queue_work(fscache_op_wq, &req->work);
@@ -255,6 +268,8 @@ int fscache_read_helper(struct fscache_io_request *req,
 	loff_t i_size;
 	int ret;
 
+	fscache_stat(&fscache_n_read_helper);
+
 	first_index = extent->start;
 	_enter("{%lx,%lx}", first_index, extent->limit);
 
@@ -300,8 +315,10 @@ int fscache_read_helper(struct fscache_io_request *req,
 		while (cursor < first_index) {
 			page = find_or_create_page(mapping, cursor,
 						   readahead_gfp_mask(mapping));
-			if (!page)
+			if (!page) {
+				fscache_stat(&fscache_n_read_helper_stop_nomem);
 				goto nomem;
+			}
 			if (!PageUptodate(page)) {
 				req->nr_pages++; /* Add to the reading list */
 				cursor++;
@@ -313,6 +330,7 @@ int fscache_read_helper(struct fscache_io_request *req,
 			 * cache.
 			 */
 			notes |= FSCACHE_RHLP_NOTE_U2D_IN_PREFACE;
+			fscache_stat(&fscache_n_read_helper_stop_uptodate);
 			fscache_ignore_pages(mapping, start, cursor + 1);
 			req->write_to_cache = false;
 			start = cursor = first_index;
@@ -337,14 +355,18 @@ int fscache_read_helper(struct fscache_io_request *req,
 			_debug("prewrite req %lx", cursor);
 			page = *requested_page;
 			ret = -ERESTARTSYS;
-			if (lock_page_killable(page) < 0)
+			if (lock_page_killable(page) < 0) {
+				fscache_stat(&fscache_n_read_helper_stop_kill);
 				goto dont;
+			}
 		} else {
 			_debug("prewrite new %lx %lx", cursor, eof);
 			page = grab_cache_page_write_begin(mapping, first_index,
 							   aop_flags);
-			if (!page)
+			if (!page) {
+				fscache_stat(&fscache_n_read_helper_stop_nomem);
 				goto nomem;
+			}
 			*requested_page = page;
 		}
 		get_page(page);
@@ -376,6 +398,7 @@ int fscache_read_helper(struct fscache_io_request *req,
 			page = lru_to_page(pages);
 			if (page->index != cursor) {
 				notes |= FSCACHE_RHLP_NOTE_LIST_NOTCONTIG;
+				fscache_stat(&fscache_n_read_helper_stop_noncontig);
 				break;
 			}
 
@@ -399,12 +422,14 @@ int fscache_read_helper(struct fscache_io_request *req,
 							   readahead_gfp_mask(mapping));
 				if (!page) {
 					notes |= FSCACHE_RHLP_NOTE_LIST_NOMEM;
+					fscache_stat(&fscache_n_read_helper_stop_nomem);
 					goto stop;
 				}
 
 				if (PageUptodate(page)) {
 					unlock_page(page);
 					put_page(page); /* Avoid overwriting */
+					fscache_stat(&fscache_n_read_helper_stop_exist);
 					ret = 0;
 					notes |= FSCACHE_RHLP_NOTE_LIST_U2D;
 					goto stop;
@@ -417,6 +442,7 @@ int fscache_read_helper(struct fscache_io_request *req,
 			default:
 				_debug("add fail %lx %d", cursor, ret);
 				put_page(page);
+				fscache_stat(&fscache_n_read_helper_stop_nomem);
 				page = NULL;
 				notes |= FSCACHE_RHLP_NOTE_LIST_ERROR;
 				goto stop;
@@ -450,12 +476,14 @@ int fscache_read_helper(struct fscache_io_request *req,
 						   readahead_gfp_mask(mapping));
 			if (!page) {
 				notes |= FSCACHE_RHLP_NOTE_TRAILER_NOMEM;
+				fscache_stat(&fscache_n_read_helper_stop_nomem);
 				goto stop;
 			}
 			if (PageUptodate(page)) {
 				unlock_page(page);
 				put_page(page); /* Avoid overwriting */
 				notes |= FSCACHE_RHLP_NOTE_TRAILER_U2D;
+				fscache_stat(&fscache_n_read_helper_stop_uptodate);
 				goto stop;
 			}
 
@@ -513,18 +541,22 @@ int fscache_read_helper(struct fscache_io_request *req,
 		 * the pages.
 		 */
 		_debug("SKIP READ: %llu", req->len);
+		fscache_stat(&fscache_n_read_helper_beyond_eof);
 		fscache_read_done(req);
 		break;
 	case fscache_read_helper_zero:
 		_debug("ZERO READ: %llu", req->len);
+		fscache_stat(&fscache_n_read_helper_zero);
 		fscache_read_done(req);
 		break;
 	case fscache_read_helper_read:
+		fscache_stat(&fscache_n_read_helper_read);
 		req->io_done = fscache_file_read_maybe_reissue;
 		fscache_read_from_cache(req);
 		break;
 	case fscache_read_helper_download:
 		_debug("DOWNLOAD: %llu", req->len);
+		fscache_stat(&fscache_n_read_helper_download);
 		req->io_done = fscache_read_done;
 		fscache_read_from_server(req);
 		break;
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index ccca0016fd26..fdea31ff8e69 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -58,6 +58,31 @@ atomic_t fscache_n_cache_stale_objects;
 atomic_t fscache_n_cache_retired_objects;
 atomic_t fscache_n_cache_culled_objects;
 
+atomic_t fscache_n_dispatch_count;
+atomic_t fscache_n_dispatch_deferred;
+atomic_t fscache_n_dispatch_inline;
+atomic_t fscache_n_dispatch_in_pool;
+
+atomic_t fscache_n_read;
+atomic_t fscache_n_write;
+
+atomic_t fscache_n_read_helper;
+atomic_t fscache_n_read_helper_stop_nomem;
+atomic_t fscache_n_read_helper_stop_noncontig;
+atomic_t fscache_n_read_helper_stop_uptodate;
+atomic_t fscache_n_read_helper_stop_exist;
+atomic_t fscache_n_read_helper_stop_kill;
+atomic_t fscache_n_read_helper_read;
+atomic_t fscache_n_read_helper_download;
+atomic_t fscache_n_read_helper_zero;
+atomic_t fscache_n_read_helper_beyond_eof;
+atomic_t fscache_n_read_helper_reissue;
+atomic_t fscache_n_read_helper_read_done;
+atomic_t fscache_n_read_helper_read_failed;
+atomic_t fscache_n_read_helper_copy;
+atomic_t fscache_n_read_helper_copy_done;
+atomic_t fscache_n_read_helper_copy_failed;
+
 /*
  * display the general statistics
  */
@@ -117,5 +142,35 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_cache_stale_objects),
 		   atomic_read(&fscache_n_cache_retired_objects),
 		   atomic_read(&fscache_n_cache_culled_objects));
+
+	seq_printf(m, "Disp   : n=%u il=%u df=%u pl=%u\n",
+		   atomic_read(&fscache_n_dispatch_count),
+		   atomic_read(&fscache_n_dispatch_inline),
+		   atomic_read(&fscache_n_dispatch_deferred),
+		   atomic_read(&fscache_n_dispatch_in_pool));
+
+	seq_printf(m, "IO     : rd=%u wr=%u\n",
+		   atomic_read(&fscache_n_read),
+		   atomic_read(&fscache_n_write));
+
+	seq_printf(m, "RdHelp : nm=%u nc=%u ud=%u ex=%u kl=%u\n",
+		   atomic_read(&fscache_n_read_helper_stop_nomem),
+		   atomic_read(&fscache_n_read_helper_stop_noncontig),
+		   atomic_read(&fscache_n_read_helper_stop_uptodate),
+		   atomic_read(&fscache_n_read_helper_stop_exist),
+		   atomic_read(&fscache_n_read_helper_stop_kill));
+	seq_printf(m, "RdHelp : n=%u rd=%u dl=%u zr=%u eo=%u\n",
+		   atomic_read(&fscache_n_read_helper),
+		   atomic_read(&fscache_n_read_helper_read),
+		   atomic_read(&fscache_n_read_helper_download),
+		   atomic_read(&fscache_n_read_helper_zero),
+		   atomic_read(&fscache_n_read_helper_beyond_eof));
+	seq_printf(m, "RdHelp : ri=%u dn=%u fl=%u cp=%u cd=%u cf=%u\n",
+		   atomic_read(&fscache_n_read_helper_reissue),
+		   atomic_read(&fscache_n_read_helper_read_done),
+		   atomic_read(&fscache_n_read_helper_read_failed),
+		   atomic_read(&fscache_n_read_helper_copy),
+		   atomic_read(&fscache_n_read_helper_copy_done),
+		   atomic_read(&fscache_n_read_helper_copy_failed));
 	return 0;
 }


