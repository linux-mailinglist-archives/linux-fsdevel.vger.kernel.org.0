Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FDF3D168B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbhGUSBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 14:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238792AbhGUSBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626892936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ev/WKl0u0g6blajjg/aIie6Q9S6Qwmj0bAxvObPEahw=;
        b=QOKrJvMzf3MHO+bvMvJNzwzyCqzTR5TFU34RfpSUGAacXoDFqoeS+oFrp53aD6bIKY6Gv0
        IXRwxeLoD0sKJDyEFRpJtjmkOzvz9sNSsCFCR2GFj5v8YNlnVgjMlSsvy3iZvsaKK3JHiw
        k5gb6IwTaHKKSyLQAHOO5dTaKZei+RQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-buZuGVf6OgCQ8QBChvYCsA-1; Wed, 21 Jul 2021 14:42:14 -0400
X-MC-Unique: buZuGVf6OgCQ8QBChvYCsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C47B801B0A;
        Wed, 21 Jul 2021 18:42:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 843381970E;
        Wed, 21 Jul 2021 18:42:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/12] netfs: Do copy-to-cache-on-read through VM writeback
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <297201.1626892923.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 21 Jul 2021 19:42:03 +0100
Message-ID: <297202.1626892923@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When data is read from the server and intended to be copied to the cache,
offload the cache write to the VM writeback mechanism rather than
scheduling it immediately.  This allows the downloaded data to be
superseded by local changes before it is written to the cache and means
that we no longer need to use the PG_fscache flag.

This is done by the following means:

 (1) The pages just downloaded into are marked dirty in
     netfs_rreq_unlock().

 (2) A region of NETFS_REGION_CACHE_COPY type is added to the dirty region
     list.

 (3) If a region-to-be-modified overlaps the cache-copy region, the
     modifications supersede the download, moving the end marker over in
     netfs_merge_dirty_region().

 (4) We don't really want to supersede in the middle of a region, so we ma=
y
     split a pristine region so that we can supersede forwards only.

 (5) We mark regions we're going to supersede with NETFS_REGION_SUPERSEDED
     to prevent them getting merged whilst we're superseding them.  This
     flag is cleared when we're done and we may merge afterwards.

 (6) Adjacent download regions are potentially mergeable.

 (7) When being flushed, CACHE_COPY regions are intended only to be writte=
n
     to the cache, not the server, though they may contribute data to a
     cross-page chunk that has to be encrypted or compressed and sent to
     the server.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/internal.h          |    4 --
 fs/netfs/main.c              |    1 =

 fs/netfs/read_helper.c       |  126 ++-----------------------------------=
---------------------------
 fs/netfs/stats.c             |    7 ---
 fs/netfs/write_back.c        |    3 +
 fs/netfs/write_helper.c      |  112 +++++++++++++++++++++++++++++++++++++=
++++++++++++++++++-
 include/linux/netfs.h        |    2 -
 include/trace/events/netfs.h |    3 +
 mm/filemap.c                 |    4 +-
 9 files changed, 125 insertions(+), 137 deletions(-)


diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 6ae1eb55093a..ee83b81e4682 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -98,6 +98,7 @@ void netfs_writeback_worker(struct work_struct *work);
 void netfs_flush_region(struct netfs_i_context *ctx,
 			struct netfs_dirty_region *region,
 			enum netfs_dirty_trace why);
+void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq);
 =

 /*
  * write_prep.c
@@ -121,10 +122,7 @@ extern atomic_t netfs_n_rh_read_done;
 extern atomic_t netfs_n_rh_read_failed;
 extern atomic_t netfs_n_rh_zero;
 extern atomic_t netfs_n_rh_short_read;
-extern atomic_t netfs_n_rh_write;
 extern atomic_t netfs_n_rh_write_begin;
-extern atomic_t netfs_n_rh_write_done;
-extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
 extern atomic_t netfs_n_wh_region;
 extern atomic_t netfs_n_wh_flush_group;
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 125b570efefd..ad204dcbb5f7 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -21,6 +21,7 @@ static const char *netfs_proc_region_types[] =3D {
 	[NETFS_REGION_ORDINARY]		=3D "ORD ",
 	[NETFS_REGION_DIO]		=3D "DIOW",
 	[NETFS_REGION_DSYNC]		=3D "DSYN",
+	[NETFS_REGION_CACHE_COPY]	=3D "CCPY",
 };
 =

 /*
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index e5c636acc756..7fa677d4c9ca 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -212,124 +212,6 @@ void netfs_rreq_completed(struct netfs_read_request =
*rreq, bool was_async)
 	netfs_put_read_request(rreq, was_async);
 }
 =

-/*
- * Deal with the completion of writing the data to the cache.  We have to=
 clear
- * the PG_fscache bits on the pages involved and release the caller's ref=
.
- *
- * May be called in softirq mode and we inherit a ref from the caller.
- */
-static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq=
,
-					  bool was_async)
-{
-	struct netfs_read_subrequest *subreq;
-	struct page *page;
-	pgoff_t unlocked =3D 0;
-	bool have_unlocked =3D false;
-
-	rcu_read_lock();
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
-
-		xas_for_each(&xas, page, (subreq->start + subreq->len - 1) / PAGE_SIZE)=
 {
-			/* We might have multiple writes from the same huge
-			 * page, but we mustn't unlock a page more than once.
-			 */
-			if (have_unlocked && page->index <=3D unlocked)
-				continue;
-			unlocked =3D page->index;
-			end_page_fscache(page);
-			have_unlocked =3D true;
-		}
-	}
-
-	rcu_read_unlock();
-	netfs_rreq_completed(rreq, was_async);
-}
-
-static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or=
_error,
-				       bool was_async)
-{
-	struct netfs_read_subrequest *subreq =3D priv;
-	struct netfs_read_request *rreq =3D subreq->rreq;
-
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		netfs_stat(&netfs_n_rh_write_failed);
-		trace_netfs_failure(rreq, subreq, transferred_or_error,
-				    netfs_fail_copy_to_cache);
-	} else {
-		netfs_stat(&netfs_n_rh_write_done);
-	}
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
-
-	/* If we decrement nr_wr_ops to 0, the ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_wr_ops))
-		netfs_rreq_unmark_after_write(rreq, was_async);
-
-	netfs_put_subrequest(subreq, was_async);
-}
-
-/*
- * Perform any outstanding writes to the cache.  We inherit a ref from th=
e
- * caller.
- */
-static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
-{
-	struct netfs_cache_resources *cres =3D &rreq->cache_resources;
-	struct netfs_read_subrequest *subreq, *next, *p;
-	struct iov_iter iter;
-	int ret;
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_write);
-
-	/* We don't want terminating writes trying to wake us up whilst we're
-	 * still going through the list.
-	 */
-	atomic_inc(&rreq->nr_wr_ops);
-
-	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
-		if (!test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
-			list_del_init(&subreq->rreq_link);
-			netfs_put_subrequest(subreq, false);
-		}
-	}
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		/* Amalgamate adjacent writes */
-		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
-			next =3D list_next_entry(subreq, rreq_link);
-			if (next->start !=3D subreq->start + subreq->len)
-				break;
-			subreq->len +=3D next->len;
-			list_del_init(&next->rreq_link);
-			netfs_put_subrequest(next, false);
-		}
-
-		ret =3D cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
-					       rreq->i_size);
-		if (ret < 0) {
-			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
-			continue;
-		}
-
-		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
-				subreq->start, subreq->len);
-
-		atomic_inc(&rreq->nr_wr_ops);
-		netfs_stat(&netfs_n_rh_write);
-		netfs_get_read_subrequest(subreq);
-		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
-		cres->ops->write(cres, subreq->start, &iter,
-				 netfs_rreq_copy_terminated, subreq);
-	}
-
-	/* If we decrement nr_wr_ops to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_wr_ops))
-		netfs_rreq_unmark_after_write(rreq, false);
-}
-
 static void netfs_rreq_write_to_cache_work(struct work_struct *work)
 {
 	struct netfs_read_request *rreq =3D
@@ -390,19 +272,19 @@ static void netfs_rreq_unlock(struct netfs_read_requ=
est *rreq)
 	xas_for_each(&xas, page, last_page) {
 		unsigned int pgpos =3D (page->index - start_page) * PAGE_SIZE;
 		unsigned int pgend =3D pgpos + thp_size(page);
-		bool pg_failed =3D false;
+		bool pg_failed =3D false, caching;
 =

 		for (;;) {
 			if (!subreq) {
 				pg_failed =3D true;
 				break;
 			}
-			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
-				set_page_fscache(page);
 			pg_failed |=3D subreq_failed;
 			if (pgend < iopos + subreq->len)
 				break;
 =

+			caching =3D test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+
 			account +=3D subreq->len - iov_iter_count(&subreq->iter);
 			iopos +=3D subreq->len;
 			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
@@ -420,6 +302,8 @@ static void netfs_rreq_unlock(struct netfs_read_reques=
t *rreq)
 			for (i =3D 0; i < thp_nr_pages(page); i++)
 				flush_dcache_page(page);
 			SetPageUptodate(page);
+			if (caching)
+				set_page_dirty(page);
 		}
 =

 		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_PAGES, &rreq->flags)) {
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index a02d95bba158..414c2fca6b23 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -22,10 +22,7 @@ atomic_t netfs_n_rh_read_done;
 atomic_t netfs_n_rh_read_failed;
 atomic_t netfs_n_rh_zero;
 atomic_t netfs_n_rh_short_read;
-atomic_t netfs_n_rh_write;
 atomic_t netfs_n_rh_write_begin;
-atomic_t netfs_n_rh_write_done;
-atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
 atomic_t netfs_n_wh_region;
 atomic_t netfs_n_wh_flush_group;
@@ -59,10 +56,6 @@ void netfs_stats_show(struct seq_file *m)
 		   atomic_read(&netfs_n_rh_read),
 		   atomic_read(&netfs_n_rh_read_done),
 		   atomic_read(&netfs_n_rh_read_failed));
-	seq_printf(m, "RdHelp : WR=3D%u ws=3D%u wf=3D%u\n",
-		   atomic_read(&netfs_n_rh_write),
-		   atomic_read(&netfs_n_rh_write_done),
-		   atomic_read(&netfs_n_rh_write_failed));
 	seq_printf(m, "WrHelp : R=3D%u F=3D%u wr=3D%u\n",
 		   atomic_read(&netfs_n_wh_region),
 		   atomic_read(&netfs_n_wh_flush_group),
diff --git a/fs/netfs/write_back.c b/fs/netfs/write_back.c
index 7363c3324602..4433c3121435 100644
--- a/fs/netfs/write_back.c
+++ b/fs/netfs/write_back.c
@@ -263,7 +263,8 @@ static void netfs_writeback(struct netfs_write_request=
 *wreq)
 =

 	if (test_bit(NETFS_WREQ_WRITE_TO_CACHE, &wreq->flags))
 		netfs_set_up_write_to_cache(wreq);
-	ctx->ops->add_write_streams(wreq);
+	if (wreq->region->type !=3D NETFS_REGION_CACHE_COPY)
+		ctx->ops->add_write_streams(wreq);
 =

 out:
 	if (atomic_dec_and_test(&wreq->outstanding))
diff --git a/fs/netfs/write_helper.c b/fs/netfs/write_helper.c
index b1fe2d4c0df6..5e50b01527fb 100644
--- a/fs/netfs/write_helper.c
+++ b/fs/netfs/write_helper.c
@@ -80,6 +80,11 @@ static void netfs_init_dirty_region(struct netfs_dirty_=
region *region,
 	INIT_LIST_HEAD(&region->flush_link);
 	refcount_set(&region->ref, 1);
 	spin_lock_init(&region->lock);
+	if (type =3D=3D NETFS_REGION_CACHE_COPY) {
+		region->state =3D NETFS_REGION_IS_DIRTY;
+		region->dirty.end =3D end;
+	}
+
 	if (file && ctx->ops->init_dirty_region)
 		ctx->ops->init_dirty_region(region, file);
 	if (!region->group) {
@@ -160,6 +165,19 @@ static enum netfs_write_compatibility netfs_write_com=
patibility(
 		return NETFS_WRITES_INCOMPATIBLE;
 	}
 =

+	/* Pending writes to the cache alone (ie. copy from a read) can be
+	 * merged or superseded by a modification that will require writing to
+	 * the server too.
+	 */
+	if (old->type =3D=3D NETFS_REGION_CACHE_COPY) {
+		if (candidate->type =3D=3D NETFS_REGION_CACHE_COPY) {
+			kleave(" =3D COMPT [ccopy]");
+			return NETFS_WRITES_COMPATIBLE;
+		}
+		kleave(" =3D SUPER [ccopy]");
+		return NETFS_WRITES_SUPERSEDE;
+	}
+
 	if (!ctx->ops->is_write_compatible) {
 		if (candidate->type =3D=3D NETFS_REGION_DSYNC) {
 			kleave(" =3D SUPER [dsync]");
@@ -220,8 +238,11 @@ static void netfs_queue_write(struct netfs_i_context =
*ctx,
 		if (overlaps(&candidate->bounds, &r->bounds)) {
 			if (overlaps(&candidate->reserved, &r->reserved) ||
 			    netfs_write_compatibility(ctx, r, candidate) =3D=3D
-			    NETFS_WRITES_INCOMPATIBLE)
+			    NETFS_WRITES_INCOMPATIBLE) {
+				kdebug("conflict %x with pend %x",
+				       candidate->debug_id, r->debug_id);
 				goto add_to_pending_queue;
+			}
 		}
 	}
 =

@@ -238,8 +259,11 @@ static void netfs_queue_write(struct netfs_i_context =
*ctx,
 		if (overlaps(&candidate->bounds, &r->bounds)) {
 			if (overlaps(&candidate->reserved, &r->reserved) ||
 			    netfs_write_compatibility(ctx, r, candidate) =3D=3D
-			    NETFS_WRITES_INCOMPATIBLE)
+			    NETFS_WRITES_INCOMPATIBLE) {
+				kdebug("conflict %x with actv %x",
+				       candidate->debug_id, r->debug_id);
 				goto add_to_pending_queue;
+			}
 		}
 	}
 =

@@ -451,6 +475,9 @@ static void netfs_merge_dirty_region(struct netfs_i_co=
ntext *ctx,
 			goto discard;
 		}
 		goto scan_backwards;
+
+	case NETFS_REGION_CACHE_COPY:
+		goto scan_backwards;
 	}
 =

 scan_backwards:
@@ -922,3 +949,84 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, str=
uct iov_iter *from)
 	goto out;
 }
 EXPORT_SYMBOL(netfs_file_write_iter);
+
+/*
+ * Add a region that's just been read as a region on the dirty list to
+ * schedule a write to the cache.
+ */
+static bool netfs_copy_to_cache(struct netfs_read_request *rreq,
+				struct netfs_read_subrequest *subreq)
+{
+	struct netfs_dirty_region *candidate, *r;
+	struct netfs_i_context *ctx =3D netfs_i_context(rreq->inode);
+	struct list_head *p;
+	loff_t end =3D subreq->start + subreq->len;
+	int ret;
+
+	ret =3D netfs_require_flush_group(rreq->inode);
+	if (ret < 0)
+		return false;
+
+	candidate =3D netfs_alloc_dirty_region();
+	if (!candidate)
+		return false;
+
+	netfs_init_dirty_region(candidate, rreq->inode, NULL,
+				NETFS_REGION_CACHE_COPY, 0, subreq->start, end);
+
+	spin_lock(&ctx->lock);
+
+	/* Find a place to insert.  There can't be any dirty regions
+	 * overlapping with the region we're adding.
+	 */
+	list_for_each(p, &ctx->dirty_regions) {
+		r =3D list_entry(p, struct netfs_dirty_region, dirty_link);
+		if (r->bounds.end <=3D candidate->bounds.start)
+			continue;
+		if (r->bounds.start >=3D candidate->bounds.end)
+			break;
+	}
+
+	list_add_tail(&candidate->dirty_link, p);
+	netfs_merge_dirty_region(ctx, candidate);
+
+	spin_unlock(&ctx->lock);
+	return true;
+}
+
+/*
+ * If we downloaded some data and it now needs writing to the cache, we a=
dd it
+ * to the dirty region list and let that flush it.  This way it can get m=
erged
+ * with writes.
+ *
+ * We inherit a ref from the caller.
+ */
+void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
+{
+	struct netfs_read_subrequest *subreq, *next, *p;
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_write);
+
+	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
+		if (!test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
+			list_del_init(&subreq->rreq_link);
+			netfs_put_subrequest(subreq, false);
+		}
+	}
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		/* Amalgamate adjacent writes */
+		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+			next =3D list_next_entry(subreq, rreq_link);
+			if (next->start !=3D subreq->start + subreq->len)
+				break;
+			subreq->len +=3D next->len;
+			list_del_init(&next->rreq_link);
+			netfs_put_subrequest(next, false);
+		}
+
+		netfs_copy_to_cache(rreq, subreq);
+	}
+
+	netfs_rreq_completed(rreq, false);
+}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 43d195badb0d..527f08eb4898 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -145,7 +145,6 @@ struct netfs_read_request {
 	void			*netfs_priv;	/* Private data for the netfs */
 	unsigned int		debug_id;
 	atomic_t		nr_rd_ops;	/* Number of read ops in progress */
-	atomic_t		nr_wr_ops;	/* Number of write ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
 	size_t			len;		/* Length of the request */
 	short			error;		/* 0 or error that occurred */
@@ -218,6 +217,7 @@ enum netfs_region_type {
 	NETFS_REGION_ORDINARY,		/* Ordinary write */
 	NETFS_REGION_DIO,		/* Direct I/O write */
 	NETFS_REGION_DSYNC,		/* O_DSYNC/RWF_DSYNC write */
+	NETFS_REGION_CACHE_COPY,	/* Data to be written to cache only */
 } __attribute__((mode(byte)));
 =

 /*
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index aa002725b209..136cc42263f9 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -156,7 +156,8 @@ enum netfs_write_stream_trace {
 #define netfs_region_types					\
 	EM(NETFS_REGION_ORDINARY,		"ORD")		\
 	EM(NETFS_REGION_DIO,			"DIO")		\
-	E_(NETFS_REGION_DSYNC,			"DSY")
+	EM(NETFS_REGION_DSYNC,			"DSY")		\
+	E_(NETFS_REGION_CACHE_COPY,		"CCP")
 =

 #define netfs_region_states					\
 	EM(NETFS_REGION_IS_PENDING,		"pend")		\
diff --git a/mm/filemap.c b/mm/filemap.c
index d1458ecf2f51..442cd767a047 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1545,8 +1545,10 @@ void end_page_writeback(struct page *page)
 	 * reused before the wake_up_page().
 	 */
 	get_page(page);
-	if (!test_clear_page_writeback(page))
+	if (!test_clear_page_writeback(page)) {
+		pr_err("Page %lx doesn't have wb set\n", page->index);
 		BUG();
+	}
 =

 	smp_mb__after_atomic();
 	wake_up_page(page, PG_writeback);

