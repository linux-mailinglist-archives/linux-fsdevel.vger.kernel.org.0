Return-Path: <linux-fsdevel+bounces-62730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB5B9F6CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4642B7B307F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BEE218592;
	Thu, 25 Sep 2025 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StX7G1x9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92F212548
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805713; cv=none; b=pb/I7hT6BIg+EwhArrNIRt4CmliF2Z2EReMdwzcLWu2fsos222FFOAuzDCAw4maZN52dkBtG6dktoxvVRideCHEAngkIJABg+oZlnZXWp0OlN9Ac7BcU3/SOdAS+yemQgMWWUY3UgEhMUyCKpVWgMhlzVKRVhE7MEizWF6tcwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805713; c=relaxed/simple;
	bh=YRJJmmXKNbfhABbQyRQerUqXKWEQWKDTlYkhnT4dyg0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uJPanG7BYNjptEfIGk/7HfBYmXMiiSBhGksr2+J2uf6EeZrkq99ZQxCLYM0CUU4ovY6/iwsWR4/6cwmHfBu/1oKBxK6Avwn2/5ClGrfk/puKsQZjTNKWoF/eWjtpI9RBSB1CSa8DxOM66MicnbkDx7VOCN5hbhe4PTddtuOTvXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StX7G1x9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758805709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6WH7NPNAfBZ8hnDGigIxW/W6oqhD+jWMoR9pdfeRFs=;
	b=StX7G1x94uuEBMTBbUUTpmwNb+OAk5hFpC/FfTJjHaUydqHtRHNHXPYBqqaNjq1tdSJejk
	4nMlKGrtOyfofcgsheuLPR64gJsg80CgnJxXco6yRnj9lMDOoFsOhSA6eIBeHQQ8wtiSdW
	9rdmK70i5QfU9eYz157+eP759FBxzpQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-p5G3CBt4OaeguhJuKzTTIw-1; Thu,
 25 Sep 2025 09:08:25 -0400
X-MC-Unique: p5G3CBt4OaeguhJuKzTTIw-1
X-Mimecast-MFC-AGG-ID: p5G3CBt4OaeguhJuKzTTIw_1758805704
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E77B81800285;
	Thu, 25 Sep 2025 13:08:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D78071800446;
	Thu, 25 Sep 2025 13:08:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <928357.1758793097@warthog.procyon.org.uk>
References: <928357.1758793097@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: [PATCH v3 REPOST] netfs: fix reference leak
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <936423.1758805700.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Sep 2025 14:08:20 +0100
Message-ID: <936424.1758805700@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Max Kellermann <max.kellermann@ionos.com>

Commit 20d72b00ca81 ("netfs: Fix the request's work item to not
require a ref") modified netfs_alloc_request() to initialize the
reference counter to 2 instead of 1.  The rationale was that the
requet's "work" would release the second reference after completion
(via netfs_{read,write}_collection_worker()).  That works most of the
time if all goes well.

However, it leaks this additional reference if the request is released
before the I/O operation has been submitted: the error code path only
decrements the reference counter once and the work item will never be
queued because there will never be a completion.

This has caused outages of our whole server cluster today because
tasks were blocked in netfs_wait_for_outstanding_io(), leading to
deadlocks in Ceph (another bug that I will address soon in another
patch).  This was caused by a netfs_pgpriv2_begin_copy_to_cache() call
which failed in fscache_begin_write_operation().  The leaked
netfs_io_request was never completed, leaving `netfs_inode.io_count`
with a positive value forever.

All of this is super-fragile code.  Finding out which code paths will
lead to an eventual completion and which do not is hard to see:

- Some functions like netfs_create_write_req() allocate a request, but
  will never submit any I/O.

- netfs_unbuffered_read_iter_locked() calls netfs_unbuffered_read()
  and then netfs_put_request(); however, netfs_unbuffered_read() can
  also fail early before submitting the I/O request, therefore another
  netfs_put_request() call must be added there.

A rule of thumb is that functions that return a `netfs_io_request` do
not submit I/O, and all of their callers must be checked.

For my taste, the whole netfs code needs an overhaul to make reference
counting easier to understand and less fragile & obscure.  But to fix
this bug here and now and produce a patch that is adequate for a
stable backport, I tried a minimal approach that quickly frees the
request object upon early failure.

I decided against adding a second netfs_put_request() each time
because that would cause code duplication which obscures the code
further.  Instead, I added the function netfs_put_failed_request()
which frees such a failed request synchronously under the assumption
that the reference count is exactly 2 (as initially set by
netfs_alloc_request() and never touched), verified by a
WARN_ON_ONCE().  It then deinitializes the request object (without
going through the "cleanup_work" indirection) and frees the allocation
(with RCU protection to protect against concurrent access by
netfs_requests_seq_start()).

All code paths that fail early have been changed to call
netfs_put_failed_request() instead of netfs_put_request().
Additionally, I have added a netfs_put_request() call to
netfs_unbuffered_read() as explained above because the
netfs_put_failed_request() approach does not work there.

Fixes: 20d72b00ca81 ("netfs: Fix the request's work item to not require a =
ref")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev,
cc: linux-fsdevel@vger.kernel.org,
cc: stable@vger.kernel.org
---
 Changes
 =3D=3D=3D=3D=3D=3D=3D
 ver #3)
  - Log the refcount in the tracepoint in netfs_put_failed_request().
 =

 ver #2)
  - Fix missing RCU handling in netfs_put_failed_request().

 fs/netfs/buffered_read.c |   10 +++++-----
 fs/netfs/direct_read.c   |    7 ++++++-
 fs/netfs/direct_write.c  |    6 +++++-
 fs/netfs/internal.h      |    1 +
 fs/netfs/objects.c       |   30 +++++++++++++++++++++++++++---
 fs/netfs/read_pgpriv2.c  |    2 +-
 fs/netfs/read_single.c   |    2 +-
 fs/netfs/write_issue.c   |    3 +--
 8 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 18b3dc74c70e..37ab6f28b5ad 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -369,7 +369,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	return netfs_put_request(rreq, netfs_rreq_trace_put_return);
 =

 cleanup_free:
-	return netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+	return netfs_put_failed_request(rreq);
 }
 EXPORT_SYMBOL(netfs_readahead);
 =

@@ -472,7 +472,7 @@ static int netfs_read_gaps(struct file *file, struct f=
olio *folio)
 	return ret < 0 ? ret : 0;
 =

 discard:
-	netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+	netfs_put_failed_request(rreq);
 alloc_error:
 	folio_unlock(folio);
 	return ret;
@@ -532,7 +532,7 @@ int netfs_read_folio(struct file *file, struct folio *=
folio)
 	return ret < 0 ? ret : 0;
 =

 discard:
-	netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+	netfs_put_failed_request(rreq);
 alloc_error:
 	folio_unlock(folio);
 	return ret;
@@ -699,7 +699,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	return 0;
 =

 error_put:
-	netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+	netfs_put_failed_request(rreq);
 error:
 	if (folio) {
 		folio_unlock(folio);
@@ -754,7 +754,7 @@ int netfs_prefetch_for_write(struct file *file, struct=
 folio *folio,
 	return ret < 0 ? ret : 0;
 =

 error_put:
-	netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+	netfs_put_failed_request(rreq);
 error:
 	_leave(" =3D %d", ret);
 	return ret;
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a05e13472baf..a498ee8d6674 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -131,6 +131,7 @@ static ssize_t netfs_unbuffered_read(struct netfs_io_r=
equest *rreq, bool sync)
 =

 	if (rreq->len =3D=3D 0) {
 		pr_err("Zero-sized read [R=3D%x]\n", rreq->debug_id);
+		netfs_put_request(rreq, netfs_rreq_trace_put_discard);
 		return -EIO;
 	}
 =

@@ -205,7 +206,7 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb=
 *iocb, struct iov_iter *i
 	if (user_backed_iter(iter)) {
 		ret =3D netfs_extract_user_iter(iter, rreq->len, &rreq->buffer.iter, 0)=
;
 		if (ret < 0)
-			goto out;
+			goto error_put;
 		rreq->direct_bv =3D (struct bio_vec *)rreq->buffer.iter.bvec;
 		rreq->direct_bv_count =3D ret;
 		rreq->direct_bv_unpin =3D iov_iter_extract_will_pin(iter);
@@ -238,6 +239,10 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kioc=
b *iocb, struct iov_iter *i
 	if (ret > 0)
 		orig_count -=3D ret;
 	return ret;
+
+error_put:
+	netfs_put_failed_request(rreq);
+	return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_read_iter_locked);
 =

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index a16660ab7f83..a9d1c3b2c084 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -57,7 +57,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb =
*iocb, struct iov_iter *
 			n =3D netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
 			if (n < 0) {
 				ret =3D n;
-				goto out;
+				goto error_put;
 			}
 			wreq->direct_bv =3D (struct bio_vec *)wreq->buffer.iter.bvec;
 			wreq->direct_bv_count =3D n;
@@ -101,6 +101,10 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kio=
cb *iocb, struct iov_iter *
 out:
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
 	return ret;
+
+error_put:
+	netfs_put_failed_request(wreq);
+	return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_write_iter_locked);
 =

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d4f16fefd965..4319611f5354 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -87,6 +87,7 @@ struct netfs_io_request *netfs_alloc_request(struct addr=
ess_space *mapping,
 void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref=
_trace what);
 void netfs_clear_subrequests(struct netfs_io_request *rreq);
 void netfs_put_request(struct netfs_io_request *rreq, enum netfs_rreq_ref=
_trace what);
+void netfs_put_failed_request(struct netfs_io_request *rreq);
 struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_reques=
t *rreq);
 =

 static inline void netfs_see_request(struct netfs_io_request *rreq,
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e8c99738b5bb..40a1c7d6f6e0 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -116,10 +116,8 @@ static void netfs_free_request_rcu(struct rcu_head *r=
cu)
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 =

-static void netfs_free_request(struct work_struct *work)
+static void netfs_deinit_request(struct netfs_io_request *rreq)
 {
-	struct netfs_io_request *rreq =3D
-		container_of(work, struct netfs_io_request, cleanup_work);
 	struct netfs_inode *ictx =3D netfs_inode(rreq->inode);
 	unsigned int i;
 =

@@ -149,6 +147,14 @@ static void netfs_free_request(struct work_struct *wo=
rk)
 =

 	if (atomic_dec_and_test(&ictx->io_count))
 		wake_up_var(&ictx->io_count);
+}
+
+static void netfs_free_request(struct work_struct *work)
+{
+	struct netfs_io_request *rreq =3D
+		container_of(work, struct netfs_io_request, cleanup_work);
+
+	netfs_deinit_request(rreq);
 	call_rcu(&rreq->rcu, netfs_free_request_rcu);
 }
 =

@@ -167,6 +173,24 @@ void netfs_put_request(struct netfs_io_request *rreq,=
 enum netfs_rreq_ref_trace
 	}
 }
 =

+/*
+ * Free a request (synchronously) that was just allocated but has
+ * failed before it could be submitted.
+ */
+void netfs_put_failed_request(struct netfs_io_request *rreq)
+{
+	int r =3D refcount_read(&rreq->ref);
+
+	/* new requests have two references (see
+	 * netfs_alloc_request(), and this function is only allowed on
+	 * new request objects
+	 */
+	WARN_ON_ONCE(r !=3D 2);
+
+	trace_netfs_rreq_ref(rreq->debug_id, r, netfs_rreq_trace_put_failed);
+	netfs_free_request(&rreq->cleanup_work);
+}
+
 /*
  * Allocate and partially initialise an I/O request structure.
  */
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 8097bc069c1d..a1489aa29f78 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -118,7 +118,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_co=
py_to_cache(
 	return creq;
 =

 cancel_put:
-	netfs_put_request(creq, netfs_rreq_trace_put_return);
+	netfs_put_failed_request(creq);
 cancel:
 	rreq->copy_to_cache =3D ERR_PTR(-ENOBUFS);
 	clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..5c0dc4efc792 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -189,7 +189,7 @@ ssize_t netfs_read_single(struct inode *inode, struct =
file *file, struct iov_ite
 	return ret;
 =

 cleanup_free:
-	netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+	netfs_put_failed_request(rreq);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_read_single);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 0584cba1a043..dd8743bc8d7f 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -133,8 +133,7 @@ struct netfs_io_request *netfs_create_write_req(struct=
 address_space *mapping,
 =

 	return wreq;
 nomem:
-	wreq->error =3D -ENOMEM;
-	netfs_put_request(wreq, netfs_rreq_trace_put_failed);
+	netfs_put_failed_request(wreq);
 	return ERR_PTR(-ENOMEM);
 }
 =


