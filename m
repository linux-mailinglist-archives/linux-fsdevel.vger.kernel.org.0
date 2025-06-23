Return-Path: <linux-fsdevel+bounces-52552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F474AE4100
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9AB1647DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C87252287;
	Mon, 23 Jun 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAxb0ECD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84782251799
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682950; cv=none; b=tw5JHbaQue8F4Qlx0Mt4h91bJEx57x+xZ7CB6V98+gxo6RqcUTkiXOCLSYjvUvBrR6j5FHW3MOtsf+GkxEgGdWUqfTU2aeLvXatd6cBYAdHCUSonsf4XQEEucznRNBzIf14R9fTOEzS5AIV83gSSZgd/efo60oXlA6SRY8q9v/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682950; c=relaxed/simple;
	bh=HpvECxWq+voRGmSFNB6p+dkZRjN0lwqBCGONj4lfHTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwaJa6OYtTMWelZTOsp4K5+Q7fTn4vWXzgfY7S9KRnMn968z1RfF69EYPM3KQDho3PlWHg7OnRXWShcNntrN/Sym+1a5NI+Z2VgpTH6Hm8auwcgwGqFInMJ1q1YOPBuRpPzCZLm7nC/biSsazm1U/7/d+jL8bKUEwQxfhtPWywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAxb0ECD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750682947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEcv5lb3KTTeQXiCv2Kg7zidLkcI1VoEfXAblq1PCdo=;
	b=GAxb0ECDHIYOokKvvuvHlsIyNaV0i1U2kkBIxCMhoMR6bVT8I5O/M6QtRyUZUp7PXk+/IM
	fh0SqD6TSA8HVsRHQziiGEZlZbqocg6+wKHuZm8CfMEBhZbAl7o1XoWrZgIUYRV/GriD30
	XZhY4tviwcNTgfBDTZrZSbuGjfrWKI4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-P4yChsFSNYKZPKaeexkjFg-1; Mon,
 23 Jun 2025 08:49:01 -0400
X-MC-Unique: P4yChsFSNYKZPKaeexkjFg-1
X-Mimecast-MFC-AGG-ID: P4yChsFSNYKZPKaeexkjFg_1750682939
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AC4A195608A;
	Mon, 23 Jun 2025 12:48:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4FC6D1956096;
	Mon, 23 Jun 2025 12:48:54 +0000 (UTC)
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
Subject: [PATCH 03/11] netfs: Provide helpers to perform NETFS_RREQ_IN_PROGRESS flag wangling
Date: Mon, 23 Jun 2025 13:48:23 +0100
Message-ID: <20250623124835.1106414-4-dhowells@redhat.com>
In-Reply-To: <20250623124835.1106414-1-dhowells@redhat.com>
References: <20250623124835.1106414-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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


