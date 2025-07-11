Return-Path: <linux-fsdevel+bounces-54661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72BB02025
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7532F1C848A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4FE2EAD0D;
	Fri, 11 Jul 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EB0wwHrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAF2EACE3
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246630; cv=none; b=sSh4TRwWdLg9Rg2rpNr5+7yLevjHWnbDDJTq10Zshdwd6+oFniuvtCk1FTrC1carKWGV/r4D1u8v7QLtFMmDu0IahzGY2WYXhSl0/ksTSVYV8IA4KIIvZfQ9iPuKRdzQSEQFeHqFzox0IuJowlG48Ogqd/Oy7ib17LgiozGsW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246630; c=relaxed/simple;
	bh=42OW8HtRVrn4ka97mxxTKFHMUOFbwunF8W/XjB+zxpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBMpS9EBU2PsoDO+KnD0li4OiKeQxesajCwVAGHvr08+hhIyvwBjrIsl/uDKdmKGbKfQG0cUgOCJoeBOTD+SVnpNwGaQmh9egTiF2hlo4WUSmDgLH/Wmer0bV0ou6n4ap7vM2RdvPEKd927ZnEBaNGc3hm+5HcR53NWkGEEu4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EB0wwHrn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752246627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdhyDCmlT4ts8aQ+TP8bcuvBLfh0c8Wa4MgdYSfHeQY=;
	b=EB0wwHrnE8d0MKedybPdzwZCJ6ahNq8gkgGl1LnFa+l4sZst3xAm5utwozigWo6fuLt5k2
	ZyWG1cDxps9qNdOGX2f9J6k6ZSb+I5q8qBGlOX3ae8zoQV1v4waNmyCMSWYNe2z5z0f7h0
	uLD6RJNg1O0fsggXtqK2GahFyoLy/Us=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-Hy-oLIUjPUSIyG8RSfkY8w-1; Fri,
 11 Jul 2025 11:10:24 -0400
X-MC-Unique: Hy-oLIUjPUSIyG8RSfkY8w-1
X-Mimecast-MFC-AGG-ID: Hy-oLIUjPUSIyG8RSfkY8w_1752246622
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8902F1956087;
	Fri, 11 Jul 2025 15:10:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFE801956094;
	Fri, 11 Jul 2025 15:10:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] netfs: Fix race between cache write completion and ALL_QUEUED being set
Date: Fri, 11 Jul 2025 16:10:01 +0100
Message-ID: <20250711151005.2956810-3-dhowells@redhat.com>
In-Reply-To: <20250711151005.2956810-1-dhowells@redhat.com>
References: <20250711151005.2956810-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When netfslib is issuing subrequests, the subrequests start processing
immediately and may complete before we reach the end of the issuing
function.  At the end of the issuing function we set NETFS_RREQ_ALL_QUEUED
to indicate to the collector that we aren't going to issue any more subreqs
and that it can do the final notifications and cleanup.

Now, this isn't a problem if the request is synchronous
(NETFS_RREQ_OFFLOAD_COLLECTION is unset) as the result collection will be
done in-thread and we're guaranteed an opportunity to run the collector.

However, if the request is asynchronous, collection is primarily triggered
by the termination of subrequests queuing it on a workqueue.  Now, a race
can occur here if the app thread sets ALL_QUEUED after the last subrequest
terminates.

This can happen most easily with the copy2cache code (as used by Ceph)
where, in the collection routine of a read request, an asynchronous write
request is spawned to copy data to the cache.  Folios are added to the
write request as they're unlocked, but there may be a delay before
ALL_QUEUED is set as the write subrequests may complete before we get
there.

If all the write subreqs have finished by the ALL_QUEUED point, no further
events happen and the collection never happens, leaving the request
hanging.

Fix this by queuing the collector after setting ALL_QUEUED.  This is a bit
heavy-handed and it may be sufficient to do it only if there are no extant
subreqs.

Also add a tracepoint to cross-reference both requests in a copy-to-request
operation and add a trace to the netfs_rreq tracepoint to indicate the
setting of ALL_QUEUED.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/netfs/read_pgpriv2.c      |  4 ++++
 include/trace/events/netfs.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 080d2a6a51d9..8097bc069c1d 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -111,6 +111,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 		goto cancel_put;
 
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
+	trace_netfs_copy2cache(rreq, creq);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
 	rreq->copy_to_cache = creq;
@@ -155,6 +156,9 @@ void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_request *rreq)
 	netfs_issue_write(creq, &creq->io_streams[1]);
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &creq->flags);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_end_copy_to_cache);
+	if (list_empty_careful(&creq->io_streams[1].subrequests))
+		netfs_wake_collector(creq);
 
 	netfs_put_request(creq, netfs_rreq_trace_put_return);
 	creq->copy_to_cache = NULL;
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 73e96ccbe830..64a382fbc31a 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -55,6 +55,7 @@
 	EM(netfs_rreq_trace_copy,		"COPY   ")	\
 	EM(netfs_rreq_trace_dirty,		"DIRTY  ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
+	EM(netfs_rreq_trace_end_copy_to_cache,	"END-C2C")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_ki_complete,	"KI-CMPL")	\
 	EM(netfs_rreq_trace_recollect,		"RECLLCT")	\
@@ -559,6 +560,35 @@ TRACE_EVENT(netfs_write,
 		      __entry->start, __entry->start + __entry->len - 1)
 	    );
 
+TRACE_EVENT(netfs_copy2cache,
+	    TP_PROTO(const struct netfs_io_request *rreq,
+		     const struct netfs_io_request *creq),
+
+	    TP_ARGS(rreq, creq),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		creq)
+		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		ino)
+			     ),
+
+	    TP_fast_assign(
+		    struct netfs_inode *__ctx = netfs_inode(rreq->inode);
+		    struct fscache_cookie *__cookie = netfs_i_cookie(__ctx);
+		    __entry->rreq	= rreq->debug_id;
+		    __entry->creq	= creq->debug_id;
+		    __entry->cookie	= __cookie ? __cookie->debug_id : 0;
+		    __entry->ino	= rreq->inode->i_ino;
+			   ),
+
+	    TP_printk("R=%08x CR=%08x c=%08x i=%x ",
+		      __entry->rreq,
+		      __entry->creq,
+		      __entry->cookie,
+		      __entry->ino)
+	    );
+
 TRACE_EVENT(netfs_collect,
 	    TP_PROTO(const struct netfs_io_request *wreq),
 


