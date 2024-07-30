Return-Path: <linux-fsdevel+bounces-24619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37094169C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959891C240A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7E33DAC01;
	Tue, 30 Jul 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oejwxqd0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DA183CA0
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355314; cv=none; b=RjbqXezdEFk2e63g+/rNOo6Ohk8EZQnbKNJw5jGBhtI+H5duZzHG73bwNDK1BvFagvTahVuwpJVD9pBHhGd3mVyGRMztfSktmah0xO6LSQgii4567RdpkD1LL1PU7qrtImSjQbJjD153ClmDuysltt/KqgD7weRvKXlcKuF2lZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355314; c=relaxed/simple;
	bh=kEiJTulm3FtbnBHqoSdF2BGkegAgL3rSrlaITn/ZiMY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=k7BedbaLVfhXV6cHKbctQv0TeZrX66THg77RyzPPhmlQEUquTNKVyaVvPP9BdZr325Rdd2CJ97K73OPJPdVHAJMvKUk4DPHJWAVelnDRp4Omj0sXPs1L913Q8cVLevMWdT9MSdbn2rwXzdSEXd4qrgYUhJOZEiF737XvLp/aX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oejwxqd0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722355311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gB2say6OeTQRsXVKscO54NC+vbE/2x1QIUKKLmVc6Do=;
	b=Oejwxqd0aVFzS82VaTyJS7E4Vn+t+Jms0uDhsfGLNJ4KjaohzjmD66ZzHI7HyQyu8iWjF4
	VRcv38G9ICP/FURBjS/21T3OBMh3X0Yqcs7VfMx54pQR3gij/AVhRb7cUDW5dgOi9QYFqQ
	JPxNsCofBVKSbhIxGK0+31EJVnafBzY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-AN2sbCrVO_WLFhNEbcSfsA-1; Tue,
 30 Jul 2024 12:01:46 -0400
X-MC-Unique: AN2sbCrVO_WLFhNEbcSfsA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51C6B19560BF;
	Tue, 30 Jul 2024 16:01:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EE03195605F;
	Tue, 30 Jul 2024 16:01:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240729091532.855688-1-max.kellermann@ionos.com>
References: <20240729091532.855688-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
    Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
    willy@infradead.org, ceph-devel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of PG_private_2 as a second writeback flag"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3575456.1722355300.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jul 2024 17:01:40 +0100
Message-ID: <3575457.1722355300@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Max,

Can you try this patch instead of either of yours?

David
---

This reverts commit ae678317b95e760607c7b20b97c9cd4ca9ed6e1a.

Revert the patch that removes the deprecated use of PG_private_2 in
netfslib for the moment as Ceph is actually still using this to track
data copied to the cache.

Fixes: ae678317b95e ("netfs: Remove deprecated use of PG_private_2 as a se=
cond writeback flag")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: ceph-devel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ceph/addr.c               |   19 +++++
 fs/netfs/buffered_read.c     |    8 ++
 fs/netfs/io.c                |  144 +++++++++++++++++++++++++++++++++++++=
++++++
 include/trace/events/netfs.h |    1 =

 4 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8c16bc5250ef..73b5a07bf94d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -498,6 +498,11 @@ const struct netfs_request_ops ceph_netfs_ops =3D {
 };
 =

 #ifdef CONFIG_CEPH_FSCACHE
+static void ceph_set_page_fscache(struct page *page)
+{
+	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
+}
+
 static void ceph_fscache_write_terminated(void *priv, ssize_t error, bool=
 was_async)
 {
 	struct inode *inode =3D priv;
@@ -515,6 +520,10 @@ static void ceph_fscache_write_to_cache(struct inode =
*inode, u64 off, u64 len, b
 			       ceph_fscache_write_terminated, inode, true, caching);
 }
 #else
+static inline void ceph_set_page_fscache(struct page *page)
+{
+}
+
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 o=
ff, u64 len, bool caching)
 {
 }
@@ -706,6 +715,8 @@ static int writepage_nounlock(struct page *page, struc=
t writeback_control *wbc)
 		len =3D wlen;
 =

 	set_page_writeback(page);
+	if (caching)
+		ceph_set_page_fscache(page);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 =

 	if (IS_ENCRYPTED(inode)) {
@@ -789,6 +800,8 @@ static int ceph_writepage(struct page *page, struct wr=
iteback_control *wbc)
 		return AOP_WRITEPAGE_ACTIVATE;
 	}
 =

+	folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
+
 	err =3D writepage_nounlock(page, wbc);
 	if (err =3D=3D -ERESTARTSYS) {
 		/* direct memory reclaimer was killed by SIGKILL. return 0
@@ -1062,7 +1075,8 @@ static int ceph_writepages_start(struct address_spac=
e *mapping,
 				unlock_page(page);
 				break;
 			}
-			if (PageWriteback(page)) {
+			if (PageWriteback(page) ||
+			    PagePrivate2(page) /* [DEPRECATED] */) {
 				if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
 					doutc(cl, "%p under writeback\n", page);
 					unlock_page(page);
@@ -1070,6 +1084,7 @@ static int ceph_writepages_start(struct address_spac=
e *mapping,
 				}
 				doutc(cl, "waiting on writeback %p\n", page);
 				wait_on_page_writeback(page);
+				folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
 			}
 =

 			if (!clear_page_dirty_for_io(page)) {
@@ -1254,6 +1269,8 @@ static int ceph_writepages_start(struct address_spac=
e *mapping,
 			}
 =

 			set_page_writeback(page);
+			if (caching)
+				ceph_set_page_fscache(page);
 			len +=3D thp_size(page);
 		}
 		ceph_fscache_write_to_cache(inode, offset, len, caching);
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a688d4c75d99..424048f9ed1f 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -466,7 +466,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (!netfs_is_cache_enabled(ctx) &&
 	    netfs_skip_folio_read(folio, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
-		goto have_folio;
+		goto have_folio_no_wait;
 	}
 =

 	rreq =3D netfs_alloc_request(mapping, file,
@@ -507,6 +507,12 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 =

 have_folio:
+	if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags)) {
+		ret =3D folio_wait_private_2_killable(folio);
+		if (ret < 0)
+			goto error;
+	}
+have_folio_no_wait:
 	*_folio =3D folio;
 	_leave(" =3D 0");
 	return 0;
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index c93851b98368..c179a1c73fa7 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -98,6 +98,146 @@ static void netfs_rreq_completed(struct netfs_io_reque=
st *rreq, bool was_async)
 	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
 }
 =

+/*
+ * [DEPRECATED] Deal with the completion of writing the data to the cache=
.  We
+ * have to clear the PG_fscache bits on the folios involved and release t=
he
+ * caller's ref.
+ *
+ * May be called in softirq mode and we inherit a ref from the caller.
+ */
+static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
+					  bool was_async)
+{
+	struct netfs_io_subrequest *subreq;
+	struct folio *folio;
+	pgoff_t unlocked =3D 0;
+	bool have_unlocked =3D false;
+
+	rcu_read_lock();
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
+
+		xas_for_each(&xas, folio, (subreq->start + subreq->len - 1) / PAGE_SIZE=
) {
+			if (xas_retry(&xas, folio))
+				continue;
+
+			/* We might have multiple writes from the same huge
+			 * folio, but we mustn't unlock a folio more than once.
+			 */
+			if (have_unlocked && folio->index <=3D unlocked)
+				continue;
+			unlocked =3D folio_next_index(folio) - 1;
+			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
+			folio_end_private_2(folio);
+			have_unlocked =3D true;
+		}
+	}
+
+	rcu_read_unlock();
+	netfs_rreq_completed(rreq, was_async);
+}
+
+static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or=
_error,
+				       bool was_async) /* [DEPRECATED] */
+{
+	struct netfs_io_subrequest *subreq =3D priv;
+	struct netfs_io_request *rreq =3D subreq->rreq;
+
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		netfs_stat(&netfs_n_rh_write_failed);
+		trace_netfs_failure(rreq, subreq, transferred_or_error,
+				    netfs_fail_copy_to_cache);
+	} else {
+		netfs_stat(&netfs_n_rh_write_done);
+	}
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
+
+	/* If we decrement nr_copy_ops to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
+		netfs_rreq_unmark_after_write(rreq, was_async);
+
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated)=
;
+}
+
+/*
+ * [DEPRECATED] Perform any outstanding writes to the cache.  We inherit =
a ref
+ * from the caller.
+ */
+static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
+{
+	struct netfs_cache_resources *cres =3D &rreq->cache_resources;
+	struct netfs_io_subrequest *subreq, *next, *p;
+	struct iov_iter iter;
+	int ret;
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_copy);
+
+	/* We don't want terminating writes trying to wake us up whilst we're
+	 * still going through the list.
+	 */
+	atomic_inc(&rreq->nr_copy_ops);
+
+	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
+		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
+			list_del_init(&subreq->rreq_link);
+			netfs_put_subrequest(subreq, false,
+					     netfs_sreq_trace_put_no_copy);
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
+			netfs_put_subrequest(next, false,
+					     netfs_sreq_trace_put_merged);
+		}
+
+		ret =3D cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
+					       subreq->len, rreq->i_size, true);
+		if (ret < 0) {
+			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
+			continue;
+		}
+
+		iov_iter_xarray(&iter, ITER_SOURCE, &rreq->mapping->i_pages,
+				subreq->start, subreq->len);
+
+		atomic_inc(&rreq->nr_copy_ops);
+		netfs_stat(&netfs_n_rh_write);
+		netfs_get_subrequest(subreq, netfs_sreq_trace_get_copy_to_cache);
+		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
+		cres->ops->write(cres, subreq->start, &iter,
+				 netfs_rreq_copy_terminated, subreq);
+	}
+
+	/* If we decrement nr_copy_ops to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
+		netfs_rreq_unmark_after_write(rreq, false);
+}
+
+static void netfs_rreq_write_to_cache_work(struct work_struct *work) /* [=
DEPRECATED] */
+{
+	struct netfs_io_request *rreq =3D
+		container_of(work, struct netfs_io_request, work);
+
+	netfs_rreq_do_write_to_cache(rreq);
+}
+
+static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq) /* [=
DEPRECATED] */
+{
+	rreq->work.func =3D netfs_rreq_write_to_cache_work;
+	if (!queue_work(system_unbound_wq, &rreq->work))
+		BUG();
+}
+
 /*
  * Handle a short read.
  */
@@ -275,6 +415,10 @@ static void netfs_rreq_assess(struct netfs_io_request=
 *rreq, bool was_async)
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
 =

+	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags) &&
+	    test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags))
+		return netfs_rreq_write_to_cache(rreq);
+
 	netfs_rreq_completed(rreq, was_async);
 }
 =

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index da23484268df..24ec3434d32e 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -145,6 +145,7 @@
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
 	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_copy_to_cache,	"mark-copy")	\
+	EM(netfs_folio_trace_end_copy,		"end-copy")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
 	EM(netfs_folio_trace_kill_cc,		"kill-cc")	\


