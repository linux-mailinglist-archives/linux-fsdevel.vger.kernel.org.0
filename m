Return-Path: <linux-fsdevel+bounces-41617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5AA3327D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 23:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF81188756A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 22:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA57262170;
	Wed, 12 Feb 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUNtI6Nn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBD204681
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399077; cv=none; b=E8AAJ4Qok6NcOrnWCMG9dxV5yn3FZO8zzUFOAfVJEqlSM6uHxZqtozpkAJLrQzlCqrQETz1NYXOYcNq1yPhEAvcdYZpNpfk7ZDVSuOcgmPUIZVIqqFjdh8z/jSfhV7d2liMK+p3bd2mssMmoeFJc8Re2o5u434jo1xCPS53NcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399077; c=relaxed/simple;
	bh=0xYoA6CBTdWeaOTr1Ri4H2C/7AB+xAOTC98nc+lhcIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dssei5SvA63aTbfwuyXGmUvMqeGrqVR+1/rApUCBouAK9rSR+BuLSW9gyubsggJtEwOMy/PSPKod9b263J7rJg/EqB81Us5a6hmrF//6ZHgA88O+vM8KQ9bYRIJnBXcqnD/F47U5NK7TwAoY14IHKULSeFOcuc7XzztPgqzt2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUNtI6Nn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739399075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAr8WdVllhjcbHJSWKQIBe9IIvyNnreCCr2EOUmv8Zg=;
	b=KUNtI6NnVjUVcakP6ibjClPUVRE6ZWvtTXne8VLUkvsk7BdgdMKms9rpfoLItMDmvNsq7L
	n2ml/HshSDZiDN5hUqY7sF5iesVfJoInFvN5U+Iq2ij+XNsklt5xrscJlBA4tEgl0WZuiT
	Ek4fMsr6H0iS6Z9wcFYBAjdlX8n7tds=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-O3oVQyhNNce_0bSu5p_Hlg-1; Wed,
 12 Feb 2025 17:24:31 -0500
X-MC-Unique: O3oVQyhNNce_0bSu5p_Hlg-1
X-Mimecast-MFC-AGG-ID: O3oVQyhNNce_0bSu5p_Hlg_1739399069
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 630A4180036F;
	Wed, 12 Feb 2025 22:24:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2772719560A3;
	Wed, 12 Feb 2025 22:24:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Max Kellermann <max.kellermann@ionos.com>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeff Layton <jlayton@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] netfs: Add retry stat counters
Date: Wed, 12 Feb 2025 22:24:00 +0000
Message-ID: <20250212222402.3618494-3-dhowells@redhat.com>
In-Reply-To: <20250212222402.3618494-1-dhowells@redhat.com>
References: <20250212222402.3618494-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add stat counters to count the number of request and subrequest retries and
display them in /proc/fs/netfs/stats.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h    | 4 ++++
 fs/netfs/read_retry.c  | 3 +++
 fs/netfs/stats.c       | 9 +++++++++
 fs/netfs/write_issue.c | 1 +
 fs/netfs/write_retry.c | 2 ++
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
@@ -14,6 +14,7 @@ static void netfs_reissue_read(struct netfs_io_request *rreq,
 {
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+	netfs_stat(&netfs_n_rh_retry_read_subreq);
 	subreq->rreq->netfs_ops->issue_read(subreq);
 }
 
@@ -260,6 +261,8 @@ void netfs_retry_reads(struct netfs_io_request *rreq)
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	DEFINE_WAIT(myself);
 
+	netfs_stat(&netfs_n_rh_retry_read_req);
+
 	set_bit(NETFS_RREQ_RETRYING, &rreq->flags);
 
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
+	seq_printf(m, "Retries: rq=%u rs=%u wq=%u ws=%u\n",
+		   atomic_read(&netfs_n_rh_retry_read_req),
+		   atomic_read(&netfs_n_rh_retry_read_subreq),
+		   atomic_read(&netfs_n_wh_retry_write_req),
+		   atomic_read(&netfs_n_wh_retry_write_subreq));
 	seq_printf(m, "Objs   : rr=%u sr=%u foq=%u wsc=%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq),
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 69727411683e..77279fc5b5a7 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -253,6 +253,7 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 	subreq->retry_count++;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+	netfs_stat(&netfs_n_wh_retry_write_subreq);
 	netfs_do_issue_write(stream, subreq);
 }
 
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index c841a851dd73..545d33079a77 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -203,6 +203,8 @@ void netfs_retry_writes(struct netfs_io_request *wreq)
 	struct netfs_io_stream *stream;
 	int s;
 
+	netfs_stat(&netfs_n_wh_retry_write_req);
+
 	/* Wait for all outstanding I/O to quiesce before performing retries as
 	 * we may need to renegotiate the I/O sizes.
 	 */


