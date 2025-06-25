Return-Path: <linux-fsdevel+bounces-52939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F464AE8A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F9A189D485
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158142E11C5;
	Wed, 25 Jun 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVaUSakl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E263278E5A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869768; cv=none; b=apw8fsn1/HKCRIl5mDya6EbctapZsG6c00f+VFPxX0qJ7CaojnpI0ykTxbXzMM525Bhg4vxK4LSloCiwBRl+ymm8kF8LsoevcF1KOQcH1QZKbrZ3muaXHEXBdah+b3bCD+6CgsZ8cGLzirmhfICvEUUkLk2QZwU3949DTz2rAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869768; c=relaxed/simple;
	bh=HpvECxWq+voRGmSFNB6p+dkZRjN0lwqBCGONj4lfHTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGv9Ckh/OSmdWcTm7P7wrlfOoW8PNlnZO6atldJ17lcjpanZap4PVb+kC65CTLv6FWi+E3LFK2Jk8eHQ0mx6Oe+5Cv6aMeo2VqzOxB0XELHgcBY4E/+7WABeQD8pabfr5K1leXOI6UNDgLM5Vzq20Av+ygUdcRyvgVQIqzFW0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVaUSakl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEcv5lb3KTTeQXiCv2Kg7zidLkcI1VoEfXAblq1PCdo=;
	b=iVaUSaklWn6qbqtk2VqDL8gRRmj9rEleAbgtCVEHbTE/qJGTJy65JknCIDrel3tcDIqor5
	YBBnNrSEgQFvPSmC4x1ERQXmSVLjm/JeUFt9/l4jkYX0HfqUwxM4Na8KPDNJVyQM45/ozx
	3dYdQPh4FyEb78Ne1l+YIaiOOfUmGU0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-IUCsWjHlMny0pq8eGPY1BA-1; Wed,
 25 Jun 2025 12:42:41 -0400
X-MC-Unique: IUCsWjHlMny0pq8eGPY1BA-1
X-Mimecast-MFC-AGG-ID: IUCsWjHlMny0pq8eGPY1BA_1750869759
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAE94180034E;
	Wed, 25 Jun 2025 16:42:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6956918003FC;
	Wed, 25 Jun 2025 16:42:35 +0000 (UTC)
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
Subject: [PATCH v2 03/16] netfs: Provide helpers to perform NETFS_RREQ_IN_PROGRESS flag wangling
Date: Wed, 25 Jun 2025 17:41:58 +0100
Message-ID: <20250625164213.1408754-4-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-1-dhowells@redhat.com>
References: <20250625164213.1408754-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Provide helpers to clear and test the NETFS_RREQ_IN_PROGRESS and to insert
the appropriate barrierage.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h      | 18 ++++++++++++++++++
 fs/netfs/misc.c          | 10 +++++-----
 fs/netfs/read_collect.c  |  4 ++--
 fs/netfs/write_collect.c |  4 ++--
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index e2ee9183392b..d6656d2b54ab 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -274,6 +274,24 @@ static inline void netfs_wake_rreq_flag(struct netfs_io_request *rreq,
 	}
 }
 
+/*
+ * Test the NETFS_RREQ_IN_PROGRESS flag, inserting an appropriate barrier.
+ */
+static inline bool netfs_check_rreq_in_progress(const struct netfs_io_request *rreq)
+{
+	/* Order read of flags before read of anything else, such as error. */
+	return test_bit_acquire(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+}
+
+/*
+ * Test the NETFS_SREQ_IN_PROGRESS flag, inserting an appropriate barrier.
+ */
+static inline bool netfs_check_subreq_in_progress(const struct netfs_io_subrequest *subreq)
+{
+	/* Order read of flags before read of anything else, such as error. */
+	return test_bit_acquire(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+}
+
 /*
  * fscache-cache.c
  */
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 8cf73b237269..7f31c3cbfe01 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -356,14 +356,14 @@ void netfs_wait_for_in_progress_stream(struct netfs_io_request *rreq,
 	DEFINE_WAIT(myself);
 
 	list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
-		if (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags))
+		if (!netfs_check_subreq_in_progress(subreq))
 			continue;
 
 		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
 		for (;;) {
 			prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
 
-			if (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags))
+			if (!netfs_check_subreq_in_progress(subreq))
 				break;
 
 			trace_netfs_sreq(subreq, netfs_sreq_trace_wait_for);
@@ -400,7 +400,7 @@ static int netfs_collect_in_app(struct netfs_io_request *rreq,
 						  struct netfs_io_subrequest,
 						  rreq_link);
 		if (subreq &&
-		    (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
+		    (!netfs_check_subreq_in_progress(subreq) ||
 		     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags))) {
 			need_collect = true;
 			break;
@@ -451,7 +451,7 @@ static ssize_t netfs_wait_for_request(struct netfs_io_request *rreq,
 			}
 		}
 
-		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
+		if (!netfs_check_rreq_in_progress(rreq))
 			break;
 
 		schedule();
@@ -518,7 +518,7 @@ static void netfs_wait_for_pause(struct netfs_io_request *rreq,
 			}
 		}
 
-		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags) ||
+		if (!netfs_check_rreq_in_progress(rreq) ||
 		    !test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
 			break;
 
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 96ee18af28ef..cceed9d629c6 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -218,7 +218,7 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 			stream->collected_to = front->start;
 		}
 
-		if (test_bit(NETFS_SREQ_IN_PROGRESS, &front->flags))
+		if (netfs_check_subreq_in_progress(front))
 			notes |= HIT_PENDING;
 		smp_rmb(); /* Read counters after IN_PROGRESS flag. */
 		transferred = READ_ONCE(front->transferred);
@@ -445,7 +445,7 @@ void netfs_read_collection_worker(struct work_struct *work)
 	struct netfs_io_request *rreq = container_of(work, struct netfs_io_request, work);
 
 	netfs_see_request(rreq, netfs_rreq_trace_see_work);
-	if (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags)) {
+	if (netfs_check_rreq_in_progress(rreq)) {
 		if (netfs_read_collection(rreq))
 			/* Drop the ref from the IN_PROGRESS flag. */
 			netfs_put_request(rreq, netfs_rreq_trace_put_work_ip);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index e2b102ffb768..2ac85a819b71 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -240,7 +240,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 			}
 
 			/* Stall if the front is still undergoing I/O. */
-			if (test_bit(NETFS_SREQ_IN_PROGRESS, &front->flags)) {
+			if (netfs_check_subreq_in_progress(front)) {
 				notes |= HIT_PENDING;
 				break;
 			}
@@ -434,7 +434,7 @@ void netfs_write_collection_worker(struct work_struct *work)
 	struct netfs_io_request *rreq = container_of(work, struct netfs_io_request, work);
 
 	netfs_see_request(rreq, netfs_rreq_trace_see_work);
-	if (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags)) {
+	if (netfs_check_rreq_in_progress(rreq)) {
 		if (netfs_write_collection(rreq))
 			/* Drop the ref from the IN_PROGRESS flag. */
 			netfs_put_request(rreq, netfs_rreq_trace_put_work_ip);


