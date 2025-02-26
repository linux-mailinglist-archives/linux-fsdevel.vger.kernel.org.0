Return-Path: <linux-fsdevel+bounces-42682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE9A460EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E603172E14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE1D153BF0;
	Wed, 26 Feb 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzLRQJAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4718CC10
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576609; cv=none; b=dFE6wWWI33m8vXBa8n7YPtl/sgU4D0X/FaSsI7Jv/fnQwNdCl6f4APlnKsb5ERuNr5C4YlEe/QVNsk33j09unsy6/Qy7P7RKg8y0scVSxsUNqybOJ7fDgj+TawEA0812wemeJKroGn0MvnVxPmLSTLItymfKAO72wX9WJEnooTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576609; c=relaxed/simple;
	bh=gbtSDsNREtt1StU3tTGiU8wDwt7jFuQNsaQebRZe3U0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=EAJZgup1pS49S42tVwQbYimJydqBm+7vfuUvZkmugxwqA4ITbtmAzhuHbwl1wURjm8JHcUkSM3sIm39KQuj1ZUVSttpyfD6GOWosVfzN+i74dhHZixcfxfxap6pBSfx/iy9g7Oj9zSsAlDEFxVWVNjrRcSS4GJZxkqJjKWRUaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzLRQJAk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740576605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C4B22y5jIbu5fLuM9ql7DqeVvYnnQsAnENr+CqjaWMY=;
	b=gzLRQJAkhX4fCvfUFTgBTzW7Y6wiE8H6uf1favZJlLfOPIVSelmQ/t5vs5a1Uf204cOxEA
	57qUaT2kk/P8jpThQIoVF5Dr0vJzk3CRFEVtUyuiNTgNbzdXQrcfvUxuG8tcifAJs2Yt/c
	25gn3b8XQZoAhguCzOb49/W8+xco0Vo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-KjdWZ0_6OGOxakcyLi6G8Q-1; Wed,
 26 Feb 2025 08:30:02 -0500
X-MC-Unique: KjdWZ0_6OGOxakcyLi6G8Q-1
X-Mimecast-MFC-AGG-ID: KjdWZ0_6OGOxakcyLi6G8Q_1740576601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E7141800878;
	Wed, 26 Feb 2025 13:30:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8C2719560A3;
	Wed, 26 Feb 2025 13:29:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Use rreq->issued_to instead of rreq->submitted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2613163.1740576598.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Feb 2025 13:29:58 +0000
Message-ID: <2613164.1740576598@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The netfslib read side uses rreq->submitted to track what's been issued an=
d
the write side uses rreq->issued_to - but both mean the same thing.

Switch the read side to use rreq->issued_to instead and get rid of
rreq->submitted.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c |   10 +++++-----
 fs/netfs/direct_read.c   |    4 ++--
 fs/netfs/main.c          |    2 +-
 fs/netfs/misc.c          |    2 +-
 fs/netfs/read_single.c   |    4 ++--
 fs/netfs/write_collect.c |    3 ++-
 include/linux/netfs.h    |    1 -
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index fd4619275801..80143f17ed26 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -96,14 +96,14 @@ static ssize_t netfs_prepare_read_iterator(struct netf=
s_io_subrequest *subreq)
 		struct folio_batch put_batch;
 =

 		folio_batch_init(&put_batch);
-		while (rreq->submitted < subreq->start + rsize) {
+		while (atomic64_read(&rreq->issued_to) < subreq->start + rsize) {
 			ssize_t added;
 =

 			added =3D rolling_buffer_load_from_ra(&rreq->buffer, rreq->ractl,
 							    &put_batch);
 			if (added < 0)
 				return added;
-			rreq->submitted +=3D added;
+			atomic64_add(added, &rreq->issued_to);
 		}
 		folio_batch_release(&put_batch);
 	}
@@ -360,7 +360,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	netfs_rreq_expand(rreq, ractl);
 =

 	rreq->ractl =3D ractl;
-	rreq->submitted =3D rreq->start;
+	atomic64_set(&rreq->issued_to, rreq->start);
 	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
 		goto cleanup_free;
 	netfs_read_to_pagecache(rreq);
@@ -386,7 +386,7 @@ static int netfs_create_singular_buffer(struct netfs_i=
o_request *rreq, struct fo
 	added =3D rolling_buffer_append(&rreq->buffer, folio, rollbuf_flags);
 	if (added < 0)
 		return added;
-	rreq->submitted =3D rreq->start + added;
+	atomic64_set(&rreq->issued_to, rreq->start + added);
 	rreq->ractl =3D (struct readahead_control *)1UL;
 	return 0;
 }
@@ -455,7 +455,7 @@ static int netfs_read_gaps(struct file *file, struct f=
olio *folio)
 	if (to < flen)
 		bvec_set_folio(&bvec[i++], folio, flen - to, to);
 	iov_iter_bvec(&rreq->buffer.iter, ITER_DEST, bvec, i, rreq->len);
-	rreq->submitted =3D rreq->start + flen;
+	atomic64_set(&rreq->issued_to, rreq->start + flen);
 =

 	netfs_read_to_pagecache(rreq);
 =

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 17738baa1124..210a11068455 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -94,7 +94,7 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_=
io_request *rreq)
 		slice =3D subreq->len;
 		size -=3D slice;
 		start +=3D slice;
-		rreq->submitted +=3D slice;
+		atomic64_add(slice, &rreq->issued_to);
 		if (size <=3D 0) {
 			smp_wmb(); /* Write lists before ALL_QUEUED. */
 			set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
@@ -143,7 +143,7 @@ static int netfs_unbuffered_read(struct netfs_io_reque=
st *rreq, bool sync)
 =

 	ret =3D netfs_dispatch_unbuffered_reads(rreq);
 =

-	if (!rreq->submitted) {
+	if (!atomic64_read(&rreq->issued_to)) {
 		netfs_put_request(rreq, netfs_rreq_trace_put_no_submit);
 		inode_dio_end(rreq->inode);
 		ret =3D 0;
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 4e3e62040831..07b1adfac57f 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -72,7 +72,7 @@ static int netfs_requests_seq_show(struct seq_file *m, v=
oid *v)
 		   rreq->flags,
 		   rreq->error,
 		   0,
-		   rreq->start, rreq->submitted, rreq->len);
+		   rreq->start, atomic64_read(&rreq->issued_to), rreq->len);
 	seq_putc(m, '\n');
 	return 0;
 }
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 77e7f7c79d27..055b7d53a018 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -464,7 +464,7 @@ static ssize_t netfs_wait_for_request(struct netfs_io_=
request *rreq,
 		case NETFS_UNBUFFERED_WRITE:
 			break;
 		default:
-			if (rreq->submitted < rreq->len) {
+			if (atomic64_read(&rreq->issued_to) < rreq->len) {
 				trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
 				ret =3D -EIO;
 			}
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..66926c80fda0 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -123,12 +123,12 @@ static int netfs_single_dispatch_read(struct netfs_i=
o_request *rreq)
 		}
 =

 		rreq->netfs_ops->issue_read(subreq);
-		rreq->submitted +=3D subreq->len;
+		atomic64_add(subreq->len, &rreq->issued_to);
 		break;
 	case NETFS_READ_FROM_CACHE:
 		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 		netfs_single_read_cache(rreq, subreq);
-		rreq->submitted +=3D subreq->len;
+		atomic64_add(subreq->len, &rreq->issued_to);
 		ret =3D 0;
 		break;
 	default:
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 3cc6a5a0919b..3dbde09b692d 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -27,7 +27,8 @@ static void netfs_dump_request(const struct netfs_io_req=
uest *rreq)
 	       rreq->debug_id, refcount_read(&rreq->ref), rreq->flags,
 	       rreq->origin, rreq->error);
 	pr_err("  st=3D%llx tsl=3D%zx/%llx/%llx\n",
-	       rreq->start, rreq->transferred, rreq->submitted, rreq->len);
+	       rreq->start, rreq->transferred, atomic64_read(&rreq->issued_to),
+	       rreq->len);
 	pr_err("  cci=3D%llx/%llx/%llx\n",
 	       rreq->cleaned_to, rreq->collected_to, atomic64_read(&rreq->issued=
_to));
 	pr_err("  iw=3D%pSR\n", rreq->netfs_ops->issue_write);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 6869f6d36ee7..5ec7dfa7a9dc 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -250,7 +250,6 @@ struct netfs_io_request {
 	atomic_t		subreq_counter;	/* Next subreq->debug_index */
 	unsigned int		nr_group_rel;	/* Number of refs to release on ->group */
 	spinlock_t		lock;		/* Lock for queuing subreqs */
-	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
 	long			error;		/* 0 or error that occurred */


