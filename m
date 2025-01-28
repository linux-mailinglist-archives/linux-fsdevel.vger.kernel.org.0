Return-Path: <linux-fsdevel+bounces-40211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9F3A2075F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2899416705B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE593199935;
	Tue, 28 Jan 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diQt+UcW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB58197A8E
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056804; cv=none; b=Y9bW3UYY3PCDif3+E9+iPfgutK18YG2i4ShrLoCrBskzJn2fkaLYfVszAWViP0yzt9/OhIVtLTLnl2m1s4fPBDftTL5U+Q3vmni3T+oAtQvtmQ6iVmlLjn9qxB1eTcxN6gdPVXEDuKpWFhi04faDcHMVe5hz+L3c8b+LoyLGnzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056804; c=relaxed/simple;
	bh=CTt6FJeEz8PKfEvXUcfrbb2W9N03Pct7gpU7cvpZ2sY=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=dF2kcuKncNcQfHu5XvPhBs8zuFdRomHFN310LBMYM098LydQOHP9fBXjpIZTh79Rr9ZWZdiDEqXwnw6CG9uPCrHPmdrwdFdDZMr86hycvrbV2sxq377QRpZHJ+UFi7M/vvvwdnND0mxTKPq/SqVnK+21MRCcxUPrzSNJy1v5p5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diQt+UcW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738056801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jbqcm38PsHs4LcYNLGGlnzcQpQ6OWBsjXDx6bIsk090=;
	b=diQt+UcWiQo5pvJZjOAP/kbEN210Up9Ebnc7iRzrtfsZPYZT1DFi36MmmMGuSTvLU7e12j
	6ueGOjusO80hcn3/y8FjqJC13Y7H3dWcF0n7+A7BfUq03Mzr0E+k60/g7/SXkD58cEMSzg
	fcWdt7SmhY+tyT1yUevChY8QC+rtx40=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-WI0CUzjLPy2snmXOMPcLyA-1; Tue,
 28 Jan 2025 04:33:17 -0500
X-MC-Unique: WI0CUzjLPy2snmXOMPcLyA-1
X-Mimecast-MFC-AGG-ID: WI0CUzjLPy2snmXOMPcLyA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 131041801F1B;
	Tue, 28 Jan 2025 09:33:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.56])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE51E19560AD;
	Tue, 28 Jan 2025 09:33:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <3173328.1738024385@warthog.procyon.org.uk>
References: <3173328.1738024385@warthog.procyon.org.uk>
To: Ihor Solodrai <ihor.solodrai@pm.me>,
    Marc Dionne <marc.dionne@auristor.com>,
    Steve French <stfrench@microsoft.com>
Cc: dhowells@redhat.com, Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Add retry stat counters
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3187273.1738056718.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Tue, 28 Jan 2025 09:33:09 +0000
Message-ID: <3187377.1738056789@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Here's an additional patch to allow stats on the number of retries to be
obtained.  This isn't a fix per se.

David
---
From: David Howells <dhowells@redhat.com>

netfs: Add retry stat counters

Add stat counters to count the number of request and subrequest retries an=
d
display them in /proc/fs/netfs/stats.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h    |    4 ++++
 fs/netfs/read_retry.c  |    3 +++
 fs/netfs/stats.c       |    9 +++++++++
 fs/netfs/write_issue.c |    1 +
 fs/netfs/write_retry.c |    2 ++
 5 files changed, 19 insertions(+)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index eb76f98c894b..1c4f953c3d68 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -135,6 +135,8 @@ extern atomic_t netfs_n_rh_write_begin;
 extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
+extern atomic_t netfs_n_rh_retry_read_req;
+extern atomic_t netfs_n_rh_retry_read_subreq;
 extern atomic_t netfs_n_wh_buffered_write;
 extern atomic_t netfs_n_wh_writethrough;
 extern atomic_t netfs_n_wh_dio_write;
@@ -147,6 +149,8 @@ extern atomic_t netfs_n_wh_upload_failed;
 extern atomic_t netfs_n_wh_write;
 extern atomic_t netfs_n_wh_write_done;
 extern atomic_t netfs_n_wh_write_failed;
+extern atomic_t netfs_n_wh_retry_write_req;
+extern atomic_t netfs_n_wh_retry_write_subreq;
 extern atomic_t netfs_n_wb_lock_skip;
 extern atomic_t netfs_n_wb_lock_wait;
 extern atomic_t netfs_n_folioq;
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 8316c4533a51..0f294b26e08c 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -14,6 +14,7 @@ static void netfs_reissue_read(struct netfs_io_request *=
rreq,
 {
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+	netfs_stat(&netfs_n_rh_retry_read_subreq);
 	subreq->rreq->netfs_ops->issue_read(subreq);
 }
 =

@@ -260,6 +261,8 @@ void netfs_retry_reads(struct netfs_io_request *rreq)
 	struct netfs_io_stream *stream =3D &rreq->io_streams[0];
 	DEFINE_WAIT(myself);
 =

+	netfs_stat(&netfs_n_rh_retry_read_req);
+
 	set_bit(NETFS_RREQ_RETRYING, &rreq->flags);
 =

 	/* Wait for all outstanding I/O to quiesce before performing retries as
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index f1af344266cc..ab6b916addc4 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -29,6 +29,8 @@ atomic_t netfs_n_rh_write_begin;
 atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
+atomic_t netfs_n_rh_retry_read_req;
+atomic_t netfs_n_rh_retry_read_subreq;
 atomic_t netfs_n_wh_buffered_write;
 atomic_t netfs_n_wh_writethrough;
 atomic_t netfs_n_wh_dio_write;
@@ -41,6 +43,8 @@ atomic_t netfs_n_wh_upload_failed;
 atomic_t netfs_n_wh_write;
 atomic_t netfs_n_wh_write_done;
 atomic_t netfs_n_wh_write_failed;
+atomic_t netfs_n_wh_retry_write_req;
+atomic_t netfs_n_wh_retry_write_subreq;
 atomic_t netfs_n_wb_lock_skip;
 atomic_t netfs_n_wb_lock_wait;
 atomic_t netfs_n_folioq;
@@ -81,6 +85,11 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_wh_write),
 		   atomic_read(&netfs_n_wh_write_done),
 		   atomic_read(&netfs_n_wh_write_failed));
+	seq_printf(m, "Retries: rq=3D%u rs=3D%u wq=3D%u ws=3D%u\n",
+		   atomic_read(&netfs_n_rh_retry_read_req),
+		   atomic_read(&netfs_n_rh_retry_read_subreq),
+		   atomic_read(&netfs_n_wh_retry_write_req),
+		   atomic_read(&netfs_n_wh_retry_write_subreq));
 	seq_printf(m, "Objs   : rr=3D%u sr=3D%u foq=3D%u wsc=3D%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq),
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 69727411683e..77279fc5b5a7 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -253,6 +253,7 @@ void netfs_reissue_write(struct netfs_io_stream *strea=
m,
 	subreq->retry_count++;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+	netfs_stat(&netfs_n_wh_retry_write_subreq);
 	netfs_do_issue_write(stream, subreq);
 }
 =

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index c841a851dd73..545d33079a77 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -203,6 +203,8 @@ void netfs_retry_writes(struct netfs_io_request *wreq)
 	struct netfs_io_stream *stream;
 	int s;
 =

+	netfs_stat(&netfs_n_wh_retry_write_req);
+
 	/* Wait for all outstanding I/O to quiesce before performing retries as
 	 * we may need to renegotiate the I/O sizes.
 	 */


