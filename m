Return-Path: <linux-fsdevel+bounces-25414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C394BC7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2491C21255
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108B18C320;
	Thu,  8 Aug 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6cFGGkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5418B469
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117710; cv=none; b=aN+8uI/NDHMeQ4dCKwzZW0phTr59uA23HKwA7RUoBBt42FjxGFP/QhxrjljawnnAzROO3tZ/vQaXGUVq/b2WzbZ7TjqLBcFS4r2+Gf2D0fThttEXVl3Y1MbwSZNRdtYiIgRjijmS8cULyv/1Rx5VhWk9GHBezFube5g3luR0Kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117710; c=relaxed/simple;
	bh=pxNCAzafY1mC1+UJrMyPNc/mk8CnbxQk81qrJbtQWKY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UJBWqhWgP2qA/B4hwZ4TkxK2u8LWAc+/zORw0kPnSEjw4zvfvPiGYEiJ6yEdmuqBlT9W6+Okgu0N2/DuAsMtAyz5v34fFPQUASYTvv80HdY8Rmv3PpdzrMMoLX21U0B1+NXKmtDa6ib5YuNLLkdJ1WHk5nKa5/CXwxKLx77RoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6cFGGkM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723117705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QA2XG5xvt1prpF0gDErNq6ZwHl8YnRbOm+7kGy4pkyw=;
	b=R6cFGGkMBdkOiVCvMt4N/IMn11/uFMxfBwVHtlMZZQdsLuluAjA7Ms+WvryQqnWjNAYin/
	Kx3ZmoKYQ/AJvKe23FH1iJVB2/j/yG/M/uT+E8af0eRblCR2Ln5hC3A2tPVVm3WB/tVLo/
	Jwofn04Z2WnRvW11m3KN1SpMn/VcZ6E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-CvWWlom_PlSRKIGjs6rp7A-1; Thu,
 08 Aug 2024 07:48:22 -0400
X-MC-Unique: CvWWlom_PlSRKIGjs6rp7A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5760D18BEF79;
	Thu,  8 Aug 2024 11:47:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14A7A195ED25;
	Thu,  8 Aug 2024 11:46:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <861629.1723061874@warthog.procyon.org.uk>
References: <861629.1723061874@warthog.procyon.org.uk> <CAKPOu+-4LQM2-Ciro0LbbhVPa+YyHD3BnLL+drmG5Ca-b4wmLg@mail.gmail.com> <20240729091532.855688-1-max.kellermann@ionos.com> <3575457.1722355300@warthog.procyon.org.uk> <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com> <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com> <3717298.1722422465@warthog.procyon.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Hristo Venev <hristo@venev.name>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Jeff Layton <jlayton@kernel.org>, willy@infradead.org,
    ceph-devel@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: [PATCH v2] netfs: Fix handling of USE_PGPRIV2 and WRITE_TO_CACHE flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1068322.1723117607.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Aug 2024 12:46:47 +0100
Message-ID: <1068323.1723117607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Okay, I updated to -rc2 and now the apparent UAF of a ceph inode doesn't
seem to happen.  I've fixed a couple of minor issues in the patch:

 - Switched a kdebug() to a _debug().

 - netfs_rreq_unlock_folios_pgpriv2() needed to updated the 'account'
   variable in the caller, not do it's own thing.

David
---
netfs: Fix handling of USE_PGPRIV2 and WRITE_TO_CACHE flags

The NETFS_RREQ_USE_PGPRIV2 and NETFS_RREQ_WRITE_TO_CACHE flags aren't used
correctly.  The problem is that we try to set them up in the request
initialisation, but we the cache may be in the process of setting up still=
,
and so the state may not be correct.  Further, we secondarily sample the
cache state and make contradictory decisions later.

The issue arises because we set up the cache resources, which allows the
cache's ->prepare_read() to switch on NETFS_SREQ_COPY_TO_CACHE - which
triggers cache writing even if we didn't set the flags when allocating.

Fix this in the following way:

 (1) Drop NETFS_ICTX_USE_PGPRIV2 and instead set NETFS_RREQ_USE_PGPRIV2 in
     ->init_request() rather than trying to juggle that in
     netfs_alloc_request().

 (2) Repurpose NETFS_RREQ_USE_PGPRIV2 to merely indicate that if caching i=
s
     to be done, then PG_private_2 is to be used rather than only setting
     it if we decide to cache and then having netfs_rreq_unlock_folios()
     set the non-PG_private_2 writeback-to-cache if it wasn't set.

 (3) Split netfs_rreq_unlock_folios() into two functions, one of which
     contains the deprecated code for using PG_private_2 to avoid
     accidentally doing the writeback path - and always use it if
     USE_PGPRIV2 is set.

 (4) As NETFS_ICTX_USE_PGPRIV2 is removed, make netfs_write_begin() always
     wait for PG_private_2.  This function is deprecated and only used by
     ceph anyway, and so label it so.

 (5) Drop the NETFS_RREQ_WRITE_TO_CACHE flag and use
     fscache_operation_valid() on the cache_resources instead.  This has
     the advantage of picking up the result of netfs_begin_cache_read() an=
d
     fscache_begin_write_operation() - which are called after the object i=
s
     initialised and will wait for the cache to come to a usable state.

Just reverting ae678317b95e[1] isn't a sufficient fix, so this need to be
applied on top of that.  Without this as well, things like:

 rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: {

and:

 WARNING: CPU: 13 PID: 3621 at fs/ceph/caps.c:3386

may happen, along with some UAFs due to PG_private_2 not getting used to
wait on writeback completion.

Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private =
and marking dirty")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Hristo Venev <hristo@venev.name>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: ceph-devel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk/=
 [1]
---
 fs/ceph/addr.c               |    3 +
 fs/ceph/inode.c              |    2 =

 fs/netfs/buffered_read.c     |  125 ++++++++++++++++++++++++++++++++++++-=
------
 fs/netfs/objects.c           |    4 -
 fs/netfs/write_issue.c       |    2 =

 fs/nfs/fscache.c             |    2 =

 fs/nfs/fscache.h             |    2 =

 include/linux/netfs.h        |    3 -
 include/trace/events/netfs.h |    1 =

 9 files changed, 114 insertions(+), 30 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 73b5a07bf94d..cc0a2240de98 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -424,6 +424,9 @@ static int ceph_init_request(struct netfs_io_request *=
rreq, struct file *file)
 	struct ceph_netfs_request_data *priv;
 	int ret =3D 0;
 =

+	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cach=
e. */
+	__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
+
 	if (rreq->origin !=3D NETFS_READAHEAD)
 		return 0;
 =

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8f8de8f33abb..71cd70514efa 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -577,8 +577,6 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 =

 	/* Set parameters for the netfs library */
 	netfs_inode_init(&ci->netfs, &ceph_netfs_ops, false);
-	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cach=
e. */
-	__set_bit(NETFS_ICTX_USE_PGPRIV2, &ci->netfs.flags);
 =

 	spin_lock_init(&ci->i_ceph_lock);
 =

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 424048f9ed1f..27c750d39476 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -9,6 +9,97 @@
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 =

+/*
+ * [DEPRECATED] Unlock the folios in a read operation for when the filesy=
stem
+ * is using PG_private_2 and direct writing to the cache from here rather=
 than
+ * marking the page for writeback.
+ *
+ * Note that we don't touch folio->private in this code.
+ */
+static void netfs_rreq_unlock_folios_pgpriv2(struct netfs_io_request *rre=
q,
+					     size_t *account)
+{
+	struct netfs_io_subrequest *subreq;
+	struct folio *folio;
+	pgoff_t start_page =3D rreq->start / PAGE_SIZE;
+	pgoff_t last_page =3D ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
+	bool subreq_failed =3D false;
+
+	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
+
+	/* Walk through the pagecache and the I/O request lists simultaneously.
+	 * We may have a mixture of cached and uncached sections and we only
+	 * really want to write out the uncached sections.  This is slightly
+	 * complicated by the possibility that we might have huge pages with a
+	 * mixture inside.
+	 */
+	subreq =3D list_first_entry(&rreq->subrequests,
+				  struct netfs_io_subrequest, rreq_link);
+	subreq_failed =3D (subreq->error < 0);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_unlock_pgpriv2);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, last_page) {
+		loff_t pg_end;
+		bool pg_failed =3D false;
+		bool folio_started =3D false;
+
+		if (xas_retry(&xas, folio))
+			continue;
+
+		pg_end =3D folio_pos(folio) + folio_size(folio) - 1;
+
+		for (;;) {
+			loff_t sreq_end;
+
+			if (!subreq) {
+				pg_failed =3D true;
+				break;
+			}
+
+			if (!folio_started &&
+			    test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags) &&
+			    fscache_operation_valid(&rreq->cache_resources)) {
+				trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
+				folio_start_private_2(folio);
+				folio_started =3D true;
+			}
+
+			pg_failed |=3D subreq_failed;
+			sreq_end =3D subreq->start + subreq->len - 1;
+			if (pg_end < sreq_end)
+				break;
+
+			*account +=3D subreq->transferred;
+			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+				subreq =3D list_next_entry(subreq, rreq_link);
+				subreq_failed =3D (subreq->error < 0);
+			} else {
+				subreq =3D NULL;
+				subreq_failed =3D false;
+			}
+
+			if (pg_end =3D=3D sreq_end)
+				break;
+		}
+
+		if (!pg_failed) {
+			flush_dcache_folio(folio);
+			folio_mark_uptodate(folio);
+		}
+
+		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
+			if (folio->index =3D=3D rreq->no_unlock_folio &&
+			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
+				_debug("no unlock");
+			else
+				folio_unlock(folio);
+		}
+	}
+	rcu_read_unlock();
+}
+
 /*
  * Unlock the folios in a read operation.  We need to set PG_writeback on=
 any
  * folios we're going to write back before we unlock them.
@@ -35,6 +126,12 @@ void netfs_rreq_unlock_folios(struct netfs_io_request =
*rreq)
 		}
 	}
 =

+	/* Handle deprecated PG_private_2 case. */
+	if (test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)) {
+		netfs_rreq_unlock_folios_pgpriv2(rreq, &account);
+		goto out;
+	}
+
 	/* Walk through the pagecache and the I/O request lists simultaneously.
 	 * We may have a mixture of cached and uncached sections and we only
 	 * really want to write out the uncached sections.  This is slightly
@@ -52,7 +149,6 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *=
rreq)
 		loff_t pg_end;
 		bool pg_failed =3D false;
 		bool wback_to_cache =3D false;
-		bool folio_started =3D false;
 =

 		if (xas_retry(&xas, folio))
 			continue;
@@ -66,17 +162,8 @@ void netfs_rreq_unlock_folios(struct netfs_io_request =
*rreq)
 				pg_failed =3D true;
 				break;
 			}
-			if (test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)) {
-				if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE,
-							       &subreq->flags)) {
-					trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
-					folio_start_private_2(folio);
-					folio_started =3D true;
-				}
-			} else {
-				wback_to_cache |=3D
-					test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
-			}
+
+			wback_to_cache |=3D test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)=
;
 			pg_failed |=3D subreq_failed;
 			sreq_end =3D subreq->start + subreq->len - 1;
 			if (pg_end < sreq_end)
@@ -124,6 +211,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request =
*rreq)
 	}
 	rcu_read_unlock();
 =

+out:
 	task_io_account_read(account);
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);
@@ -395,7 +483,7 @@ static bool netfs_skip_folio_read(struct folio *folio,=
 loff_t pos, size_t len,
 }
 =

 /**
- * netfs_write_begin - Helper to prepare for writing
+ * netfs_write_begin - Helper to prepare for writing [DEPRECATED]
  * @ctx: The netfs context
  * @file: The file to read from
  * @mapping: The mapping to read from
@@ -426,6 +514,9 @@ static bool netfs_skip_folio_read(struct folio *folio,=
 loff_t pos, size_t len,
  * inode before calling this.
  *
  * This is usable whether or not caching is enabled.
+ *
+ * Note that this should be considered deprecated and netfs_perform_write=
()
+ * used instead.
  */
 int netfs_write_begin(struct netfs_inode *ctx,
 		      struct file *file, struct address_space *mapping,
@@ -507,11 +598,9 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 =

 have_folio:
-	if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags)) {
-		ret =3D folio_wait_private_2_killable(folio);
-		if (ret < 0)
-			goto error;
-	}
+	ret =3D folio_wait_private_2_killable(folio);
+	if (ret < 0)
+		goto error;
 have_folio_no_wait:
 	*_folio =3D folio;
 	_leave(" =3D 0");
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index f4a642727479..0faea0cee179 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -57,10 +57,6 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
 =

 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	if (cached) {
-		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
-		if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags))
-			/* Filesystem uses deprecated PG_private_2 marking. */
-			__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
 	}
 	if (file && file->f_flags & O_NONBLOCK)
 		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 9258d30cffe3..d35bb0f25d69 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -102,7 +102,7 @@ struct netfs_io_request *netfs_create_write_req(struct=
 address_space *mapping,
 	_enter("R=3D%x", wreq->debug_id);
 =

 	ictx =3D netfs_inode(wreq->inode);
-	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
+	if (fscache_operation_valid(&wreq->cache_resources))
 		fscache_begin_write_operation(&wreq->cache_resources, netfs_i_cookie(ic=
tx));
 =

 	wreq->contiguity =3D wreq->start;
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 7202ce84d0eb..bf29a65c5027 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -265,6 +265,8 @@ static int nfs_netfs_init_request(struct netfs_io_requ=
est *rreq, struct file *fi
 {
 	rreq->netfs_priv =3D get_nfs_open_context(nfs_file_open_context(file));
 	rreq->debug_id =3D atomic_inc_return(&nfs_netfs_debug_id);
+	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cach=
e. */
+	__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
 =

 	return 0;
 }
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index fbed0027996f..e8adae1bc260 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -81,8 +81,6 @@ static inline void nfs_netfs_put(struct nfs_netfs_io_dat=
a *netfs)
 static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
 {
 	netfs_inode_init(&nfsi->netfs, &nfs_netfs_ops, false);
-	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cach=
e. */
-	__set_bit(NETFS_ICTX_USE_PGPRIV2, &nfsi->netfs.flags);
 }
 extern void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr);
 extern void nfs_netfs_read_completion(struct nfs_pgio_header *hdr);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5d0288938cc2..983816608f15 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -73,8 +73,6 @@ struct netfs_inode {
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
 #define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
-#define NETFS_ICTX_USE_PGPRIV2	31		/* [DEPRECATED] Use PG_private_2 to ma=
rk
-						 * write to cache on read */
 };
 =

 /*
@@ -269,7 +267,6 @@ struct netfs_io_request {
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on com=
pletion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes =
*/
-#define NETFS_RREQ_WRITE_TO_CACHE	7	/* Need to write to the cache */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 #define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
 #define NETFS_RREQ_BLOCKED		10	/* We blocked */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 24ec3434d32e..606b4a0f92da 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -51,6 +51,7 @@
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
 	EM(netfs_rreq_trace_set_pause,		"PAUSE  ")	\
 	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
+	EM(netfs_rreq_trace_unlock_pgpriv2,	"UNLCK-2")	\
 	EM(netfs_rreq_trace_unmark,		"UNMARK ")	\
 	EM(netfs_rreq_trace_wait_ip,		"WAIT-IP")	\
 	EM(netfs_rreq_trace_wait_pause,		"WT-PAUS")	\


