Return-Path: <linux-fsdevel+bounces-34048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E669C23A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5991F26402
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F41F26EF;
	Fri,  8 Nov 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ktw6PZUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B91F26C6
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087300; cv=none; b=FSsncZWL3GWaFumdiQT8lEE5M1Y6+y6Pksi0T5pK1KqNXcIFFktGeHVZP869HL50Ora3Ugn6S4iaSWBOIKCPFfGPip5t9d+9WNvhmzClQ93RxoCZo+kkORN1Cn5e2yP4mk0pdnm5+RjdHxzUzxX2bbt4Z01CyJTPmnAtdvaRcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087300; c=relaxed/simple;
	bh=LOURsnIZQDl9tWN/DtXMyLu3vMcnBJb7H0S0wNAcQls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtDP6XqVA1TXoAcmDQDJ02Ym5eiIaGN7CG1VrjUSGz+I8kRmRE6loyUCW0HalGlqxiZ+zMcCANRWqN60qzybwMznRmQPu1bYUZb7JJCZ2LDqSY8rPiShG5EF1FlK+xfF98cHYOvj3l6vPIxcjh6M00WtMxHaiafOqrQQxGg/Ua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ktw6PZUP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kDl7vtgTz4UJLk1NBKECBmgzlrlbYChuV4j2ks8Pq0=;
	b=Ktw6PZUPABNcFelrt61slnBqk6Y3tlPnyTC7hvfVdbLHArCDUOmydW1RyU1mW4atTaD3gs
	vpLQUxQmXU5vTYdohmSv0MUxRwjVwlWRdySu5wAWH8hg120AVLZjzgGOtW1YKQoFekp1fH
	v/HB4NTdBa7rDlVMjZ+99WoqBVZoAKA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-utFlB_VuN8Sv2_-v1sEaMg-1; Fri,
 08 Nov 2024 12:34:52 -0500
X-MC-Unique: utFlB_VuN8Sv2_-v1sEaMg-1
X-Mimecast-MFC-AGG-ID: utFlB_VuN8Sv2_-v1sEaMg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D7EC19560B5;
	Fri,  8 Nov 2024 17:34:48 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDDA1195E480;
	Fri,  8 Nov 2024 17:34:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/33] cachefiles: Add some subrequest tracepoints
Date: Fri,  8 Nov 2024 17:32:18 +0000
Message-ID: <20241108173236.1382366-18-dhowells@redhat.com>
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add some tracepoints into the cachefiles write paths.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfs@lists.linux.dev
---
 fs/cachefiles/io.c           | 4 ++++
 include/trace/events/netfs.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 6a821a959b59..92058ae43488 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -13,6 +13,7 @@
 #include <linux/falloc.h>
 #include <linux/sched/mm.h>
 #include <trace/events/fscache.h>
+#include <trace/events/netfs.h>
 #include "internal.h"
 
 struct cachefiles_kiocb {
@@ -366,6 +367,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE)) {
 		if (term_func)
 			term_func(term_func_priv, -ENOBUFS, false);
+		trace_netfs_sreq(term_func_priv, netfs_sreq_trace_cache_nowrite);
 		return -ENOBUFS;
 	}
 
@@ -695,6 +697,7 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 		iov_iter_truncate(&subreq->io_iter, len);
 	}
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_cache_prepare);
 	cachefiles_begin_secure(cache, &saved_cred);
 	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
 					 &start, &len, len, true);
@@ -704,6 +707,7 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 		return;
 	}
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_cache_write);
 	cachefiles_write(&subreq->rreq->cache_resources,
 			 subreq->start, &subreq->io_iter,
 			 netfs_write_subrequest_terminated, subreq);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index a0f5b13aab86..7c3c866ae183 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -74,6 +74,9 @@
 #define netfs_sreq_traces					\
 	EM(netfs_sreq_trace_add_donations,	"+DON ")	\
 	EM(netfs_sreq_trace_added,		"ADD  ")	\
+	EM(netfs_sreq_trace_cache_nowrite,	"CA-NW")	\
+	EM(netfs_sreq_trace_cache_prepare,	"CA-PR")	\
+	EM(netfs_sreq_trace_cache_write,	"CA-WR")	\
 	EM(netfs_sreq_trace_clear,		"CLEAR")	\
 	EM(netfs_sreq_trace_discard,		"DSCRD")	\
 	EM(netfs_sreq_trace_donate_to_prev,	"DON-P")	\


