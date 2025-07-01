Return-Path: <linux-fsdevel+bounces-53552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34D5AF0045
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EF216993A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02242857E4;
	Tue,  1 Jul 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuhQFqjp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B432857C5
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388008; cv=none; b=lbYkr1rn//N0mv7psq1HV/qH3bqAs7GgVTPxRnp5S2gqJLGiK8kUHPcGqDwMg0/zFO8TlBHP0bCnzC/kgAPXwCTwPFNdMA0F0bQPRT1Q5O/sNTeO33Qx8A7C7cRqKu5qCP8T7eFIt2JykN9pbxfmgIfXP9QJrUALP2l+LEFt1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388008; c=relaxed/simple;
	bh=f4pbbJNkJ/N4FsPH7fxI908zTDNK1C2evjWLmsQtcXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfQ4q2KnddNNG6mBo+9+p60/VlB9pJzoLUGM4a6tJ+3TC3wrCR+fDOSnY/rkkllJSPrkGSQy3MOPj7+9CAV+JUmQi38zGXdhk5onHnMFr+GvrDLToR126XYtL2rWtodkqkJL4rJFgUrOAratlByTL2X6iNtpF02yLZjV/Q70404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuhQFqjp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751388005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/4uKt+QCZ9HD2iXJMEvXXAIcIVUbyHesNoJ9ppt/So=;
	b=BuhQFqjpCr2QMcL9BwEi5gyRWgYCtt7L0+mTnElokIVEO4Uve23z8BhTNBwNkxpocVAJEv
	kGclBjsg7pQVCHKnzZLcV7McNZzqs/aaPJ+D5GCne1re57r0F9R8h9M1359RySjvKffGkI
	AloTaUbJ5MfDvx98HOumQ5jQl2GufB0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-rcm2kopmN3GKGQ5s8y3tdw-1; Tue,
 01 Jul 2025 12:40:02 -0400
X-MC-Unique: rcm2kopmN3GKGQ5s8y3tdw-1
X-Mimecast-MFC-AGG-ID: rcm2kopmN3GKGQ5s8y3tdw_1751388000
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C49618011EE;
	Tue,  1 Jul 2025 16:40:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A98FF30001B1;
	Tue,  1 Jul 2025 16:39:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 12/13] netfs: Renumber the NETFS_RREQ_* flags to make traces easier to read
Date: Tue,  1 Jul 2025 17:38:47 +0100
Message-ID: <20250701163852.2171681-13-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
References: <20250701163852.2171681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Renumber the NETFS_RREQ_* flags to put the most useful status bits in the
bottom nibble - and therefore the last hex digit in the trace output -
making it easier to grasp the state at a glance.

In particular, put the IN_PROGRESS flag in bit 0 and ALL_QUEUED at bit 1.

Also make the flags field in /proc/fs/netfs/requests larger to accommodate
all the flags.

Also make the flags field in the netfs_sreq tracepoint larger to
accommodate all the NETFS_SREQ_* flags.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/main.c              |  6 +++---
 include/linux/netfs.h        | 20 ++++++++++----------
 include/trace/events/netfs.h |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 3db401d269e7..73da6c9f5777 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -58,15 +58,15 @@ static int netfs_requests_seq_show(struct seq_file *m, void *v)
 
 	if (v == &netfs_io_requests) {
 		seq_puts(m,
-			 "REQUEST  OR REF FL ERR  OPS COVERAGE\n"
-			 "======== == === == ==== === =========\n"
+			 "REQUEST  OR REF FLAG ERR  OPS COVERAGE\n"
+			 "======== == === ==== ==== === =========\n"
 			 );
 		return 0;
 	}
 
 	rreq = list_entry(v, struct netfs_io_request, proc_link);
 	seq_printf(m,
-		   "%08x %s %3d %2lx %4ld %3d @%04llx %llx/%llx",
+		   "%08x %s %3d %4lx %4ld %3d @%04llx %llx/%llx",
 		   rreq->debug_id,
 		   netfs_origins[rreq->origin],
 		   refcount_read(&rreq->ref),
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index d8186b90fb38..f43f075852c0 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -265,17 +265,17 @@ struct netfs_io_request {
 	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	refcount_t		ref;
 	unsigned long		flags;
-#define NETFS_RREQ_OFFLOAD_COLLECTION	0	/* Offload collection to workqueue */
-#define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on completion */
-#define NETFS_RREQ_FAILED		4	/* The request failed */
-#define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes (has ref) */
-#define NETFS_RREQ_FOLIO_COPY_TO_CACHE	6	/* Copy current folio to cache from read */
-#define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
-#define NETFS_RREQ_PAUSE		11	/* Pause subrequest generation */
+#define NETFS_RREQ_IN_PROGRESS		0	/* Unlocked when the request completes (has ref) */
+#define NETFS_RREQ_ALL_QUEUED		1	/* All subreqs are now queued */
+#define NETFS_RREQ_PAUSE		2	/* Pause subrequest generation */
+#define NETFS_RREQ_FAILED		3	/* The request failed */
+#define NETFS_RREQ_RETRYING		4	/* Set if we're in the retry path */
+#define NETFS_RREQ_SHORT_TRANSFER	5	/* Set if we have a short transfer */
+#define NETFS_RREQ_OFFLOAD_COLLECTION	8	/* Offload collection to workqueue */
+#define NETFS_RREQ_NO_UNLOCK_FOLIO	9	/* Don't unlock no_unlock_folio on completion */
+#define NETFS_RREQ_FOLIO_COPY_TO_CACHE	10	/* Copy current folio to cache from read */
+#define NETFS_RREQ_UPLOAD_TO_SERVER	11	/* Need to write to the server */
 #define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
-#define NETFS_RREQ_ALL_QUEUED		13	/* All subreqs are now queued */
-#define NETFS_RREQ_RETRYING		14	/* Set if we're in the retry path */
-#define NETFS_RREQ_SHORT_TRANSFER	15	/* Set if we have a short transfer */
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
 	const struct netfs_request_ops *netfs_ops;
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index ba35dc66e986..c2d581429a7b 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -367,7 +367,7 @@ TRACE_EVENT(netfs_sreq,
 		    __entry->slot	= sreq->io_iter.folioq_slot;
 			   ),
 
-	    TP_printk("R=%08x[%x] %s %s f=%02x s=%llx %zx/%zx s=%u e=%d",
+	    TP_printk("R=%08x[%x] %s %s f=%03x s=%llx %zx/%zx s=%u e=%d",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __print_symbolic(__entry->what, netfs_sreq_traces),


