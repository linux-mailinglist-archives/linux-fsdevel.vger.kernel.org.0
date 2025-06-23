Return-Path: <linux-fsdevel+bounces-52560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF3AE4131
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A08F1884A39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DF22512DE;
	Mon, 23 Jun 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4oKF+uI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D924C06A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682992; cv=none; b=dUhhgpKyMjD/rbbwe7nVUfYHhwEewAEk+eYqWitw81cBV05dvIQV8aptrT1Scl5ryR2Cg00YuMP9ETjBH/huwK3rU4nKI254ifCKNZJ91GyHASKzaTrbBRpiKms1yeX7Q2fZr7bS2j1VvzLd4yL+kyVELUrSQzCWmwJihVwy+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682992; c=relaxed/simple;
	bh=oCthaTSlKeRVHmOBNEH7eqZzOGsyawZils3bh9GqBfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFr0RwBcc2aFGQp6jM63MuW4QxJcUddD54m4yScf19X/wQDz3eOZteLcyLkTh9oD6mbgAtb/ufB9DZy9V+AQ1nV9efsV0r3P3JkCVQrfWssu12hUhOJAk3t1oGN23GgW7Hd/TTv2amzt7ZWC3zJuTV3zYC1RkfG5jtGh6kjoTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4oKF+uI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750682990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30JOm3WHwq4PToSA7+AabqrKHKJ051hYzw4hYdUxsoQ=;
	b=S4oKF+uIQSDhBj2C5JFFw6+nfaKcsu6xIHHfX45HulptYlIvQtMg71yYVR0tq0nfmC+o6T
	rLBvM5MbvdfNkiXPeGfBqf5aV6MnkVScI0cD47fZXOZLJ8JxikdhkVFEX9Oswk4yMprtQ8
	iWDtqO9itK+f/YOcTKH99YxvBnQ8dIc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533--Utz4PgUMJW6xjSHJUiXiw-1; Mon,
 23 Jun 2025 08:49:44 -0400
X-MC-Unique: -Utz4PgUMJW6xjSHJUiXiw-1
X-Mimecast-MFC-AGG-ID: -Utz4PgUMJW6xjSHJUiXiw_1750682982
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D53B1809C8B;
	Mon, 23 Jun 2025 12:49:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D62C0180045B;
	Mon, 23 Jun 2025 12:49:38 +0000 (UTC)
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
Subject: [PATCH 11/11] netfs: Update tracepoints in a number of ways
Date: Mon, 23 Jun 2025 13:48:31 +0100
Message-ID: <20250623124835.1106414-12-dhowells@redhat.com>
In-Reply-To: <20250623124835.1106414-1-dhowells@redhat.com>
References: <20250623124835.1106414-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Make a number of updates to the netfs tracepoints:

 (1) Remove a duplicate trace from netfs_unbuffered_write_iter_locked().

 (2) Move the trace in netfs_wake_rreq_flag() to after the flag is cleared
     so that the change appears in the trace.

 (3) Differentiate the use of netfs_rreq_trace_wait/woke_queue symbols.

 (4) Don't do so many trace emissions in the wait functions as some of them
     are redundant.

 (5) In netfs_collect_read_results(), differentiate a subreq that's being
     abandoned vs one that has been consumed in a regular way.

 (6) Add a tracepoint to indicate the call to ->ki_complete().

 (7) Don't double-increment the subreq_counter when retrying a write.

 (8) Move the netfs_sreq_trace_io_progress tracepoint within cifs code to
     just MID_RESPONSE_RECEIVED and add different tracepoints for other MID
     states and note check failure.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
cc: Steve French <sfrench@samba.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
---
 fs/netfs/direct_write.c      |  1 -
 fs/netfs/internal.h          |  2 +-
 fs/netfs/misc.c              | 14 ++++++--------
 fs/netfs/read_collect.c      | 12 +++++++++---
 fs/netfs/write_collect.c     |  4 +++-
 fs/netfs/write_retry.c       |  1 -
 fs/smb/client/cifssmb.c      | 20 ++++++++++++++++++++
 fs/smb/client/smb2pdu.c      | 26 ++++++++++++++++++++++----
 include/trace/events/netfs.h | 26 ++++++++++++++++++--------
 9 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index fa9a5bf3c6d5..c0797d6c72c9 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -106,7 +106,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 	}
 
 	if (!async) {
-		trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
 		ret = netfs_wait_for_write(wreq);
 		if (ret > 0)
 			iocb->ki_pos += ret;
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d6656d2b54ab..e13ed767aec0 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -267,9 +267,9 @@ static inline void netfs_wake_rreq_flag(struct netfs_io_request *rreq,
 					enum netfs_rreq_trace trace)
 {
 	if (test_bit(rreq_flag, &rreq->flags)) {
-		trace_netfs_rreq(rreq, trace);
 		clear_bit_unlock(rreq_flag, &rreq->flags);
 		smp_mb__after_atomic(); /* Set flag before task state */
+		trace_netfs_rreq(rreq, trace);
 		wake_up(&rreq->waitq);
 	}
 }
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 127a269938bb..20748bcfbf59 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -359,7 +359,7 @@ void netfs_wait_for_in_progress_stream(struct netfs_io_request *rreq,
 		if (!netfs_check_subreq_in_progress(subreq))
 			continue;
 
-		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_quiesce);
 		for (;;) {
 			prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
 
@@ -368,10 +368,10 @@ void netfs_wait_for_in_progress_stream(struct netfs_io_request *rreq,
 
 			trace_netfs_sreq(subreq, netfs_sreq_trace_wait_for);
 			schedule();
-			trace_netfs_rreq(rreq, netfs_rreq_trace_woke_queue);
 		}
 	}
 
+	trace_netfs_rreq(rreq, netfs_rreq_trace_waited_quiesce);
 	finish_wait(&rreq->waitq, &myself);
 }
 
@@ -437,7 +437,6 @@ static ssize_t netfs_wait_for_in_progress(struct netfs_io_request *rreq,
 	ssize_t ret;
 
 	for (;;) {
-		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
 		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
 
 		if (!test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags)) {
@@ -457,11 +456,12 @@ static ssize_t netfs_wait_for_in_progress(struct netfs_io_request *rreq,
 		if (!netfs_check_rreq_in_progress(rreq))
 			break;
 
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
 		schedule();
-		trace_netfs_rreq(rreq, netfs_rreq_trace_woke_queue);
 	}
 
 all_collected:
+	trace_netfs_rreq(rreq, netfs_rreq_trace_waited_ip);
 	finish_wait(&rreq->waitq, &myself);
 
 	ret = rreq->error;
@@ -504,10 +504,8 @@ static void netfs_wait_for_pause(struct netfs_io_request *rreq,
 {
 	DEFINE_WAIT(myself);
 
-	trace_netfs_rreq(rreq, netfs_rreq_trace_wait_pause);
-
 	for (;;) {
-		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_pause);
 		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
 
 		if (!test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags)) {
@@ -530,10 +528,10 @@ static void netfs_wait_for_pause(struct netfs_io_request *rreq,
 			break;
 
 		schedule();
-		trace_netfs_rreq(rreq, netfs_rreq_trace_woke_queue);
 	}
 
 all_collected:
+	trace_netfs_rreq(rreq, netfs_rreq_trace_waited_pause);
 	finish_wait(&rreq->waitq, &myself);
 }
 
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index cceed9d629c6..3e804da1e1eb 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -293,7 +293,9 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 		spin_lock(&rreq->lock);
 
 		remove = front;
-		trace_netfs_sreq(front, netfs_sreq_trace_discard);
+		trace_netfs_sreq(front,
+				 notes & ABANDON_SREQ ?
+				 netfs_sreq_trace_abandoned : netfs_sreq_trace_consumed);
 		list_del_init(&front->rreq_link);
 		front = list_first_entry_or_null(&stream->subrequests,
 						 struct netfs_io_subrequest, rreq_link);
@@ -353,9 +355,11 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos += rreq->transferred;
-		if (rreq->iocb->ki_complete)
+		if (rreq->iocb->ki_complete) {
+			trace_netfs_rreq(rreq, netfs_rreq_trace_ki_complete);
 			rreq->iocb->ki_complete(
 				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+		}
 	}
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);
@@ -379,9 +383,11 @@ static void netfs_rreq_assess_single(struct netfs_io_request *rreq)
 
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos += rreq->transferred;
-		if (rreq->iocb->ki_complete)
+		if (rreq->iocb->ki_complete) {
+			trace_netfs_rreq(rreq, netfs_rreq_trace_ki_complete);
 			rreq->iocb->ki_complete(
 				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+		}
 	}
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 2ac85a819b71..dedfdf80eccc 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -419,9 +419,11 @@ bool netfs_write_collection(struct netfs_io_request *wreq)
 	if (wreq->iocb) {
 		size_t written = min(wreq->transferred, wreq->len);
 		wreq->iocb->ki_pos += written;
-		if (wreq->iocb->ki_complete)
+		if (wreq->iocb->ki_complete) {
+			trace_netfs_rreq(wreq, netfs_rreq_trace_ki_complete);
 			wreq->iocb->ki_complete(
 				wreq->iocb, wreq->error ? wreq->error : written);
+		}
 		wreq->iocb = VFS_PTR_POISON;
 	}
 
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 7158657061e9..fc9c3e0d34d8 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -146,7 +146,6 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			subreq = netfs_alloc_subrequest(wreq);
 			subreq->source		= to->source;
 			subreq->start		= start;
-			subreq->debug_index	= atomic_inc_return(&wreq->subreq_counter);
 			subreq->stream_nr	= to->stream_nr;
 			subreq->retry_count	= 1;
 
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 0e509a0433fb..75142f49d65d 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1334,7 +1334,11 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		cifs_stats_bytes_read(tcon, rdata->got_bytes);
 		break;
 	case MID_REQUEST_SUBMITTED:
+		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_req_submitted);
+		goto do_retry;
 	case MID_RETRY_NEEDED:
+		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_retry_needed);
+do_retry:
 		__set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
 		rdata->result = -EAGAIN;
 		if (server->sign && rdata->got_bytes)
@@ -1344,8 +1348,14 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		task_io_account_read(rdata->got_bytes);
 		cifs_stats_bytes_read(tcon, rdata->got_bytes);
 		break;
+	case MID_RESPONSE_MALFORMED:
+		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_malformed);
+		rdata->result = -EIO;
+		break;
 	default:
+		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_unknown);
 		rdata->result = -EIO;
+		break;
 	}
 
 	if (rdata->result == -ENODATA) {
@@ -1714,11 +1724,21 @@ cifs_writev_callback(struct mid_q_entry *mid)
 		}
 		break;
 	case MID_REQUEST_SUBMITTED:
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_req_submitted);
+		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
+		result = -EAGAIN;
+		break;
 	case MID_RETRY_NEEDED:
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_retry_needed);
 		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 		result = -EAGAIN;
 		break;
+	case MID_RESPONSE_MALFORMED:
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_malformed);
+		result = -EIO;
+		break;
 	default:
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_unknown);
 		result = -EIO;
 		break;
 	}
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 084ee66e73fd..7f6186c2e60d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4567,7 +4567,11 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		cifs_stats_bytes_read(tcon, rdata->got_bytes);
 		break;
 	case MID_REQUEST_SUBMITTED:
+		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_req_submitted);
+		goto do_retry;
 	case MID_RETRY_NEEDED:
+		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_retry_needed);
+do_retry:
 		__set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
 		rdata->result = -EAGAIN;
 		if (server->sign && rdata->got_bytes)
@@ -4578,11 +4582,15 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		cifs_stats_bytes_read(tcon, rdata->got_bytes);
 		break;
 	case MID_RESPONSE_MALFORMED:
+		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_malformed);
 		credits.value = le16_to_cpu(shdr->CreditRequest);
 		credits.instance = server->reconnect_instance;
-		fallthrough;
+		rdata->result = -EIO;
+		break;
 	default:
+		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_unknown);
 		rdata->result = -EIO;
+		break;
 	}
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	/*
@@ -4835,11 +4843,14 @@ smb2_writev_callback(struct mid_q_entry *mid)
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_progress);
 		credits.value = le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance = server->reconnect_instance;
 		result = smb2_check_receive(mid, server, 0);
-		if (result != 0)
+		if (result != 0) {
+			trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_bad);
 			break;
+		}
 
 		written = le32_to_cpu(rsp->DataLength);
 		/*
@@ -4861,15 +4872,23 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		}
 		break;
 	case MID_REQUEST_SUBMITTED:
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_req_submitted);
+		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
+		result = -EAGAIN;
+		break;
 	case MID_RETRY_NEEDED:
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_retry_needed);
 		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 		result = -EAGAIN;
 		break;
 	case MID_RESPONSE_MALFORMED:
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_malformed);
 		credits.value = le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance = server->reconnect_instance;
-		fallthrough;
+		result = -EIO;
+		break;
 	default:
+		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_unknown);
 		result = -EIO;
 		break;
 	}
@@ -4909,7 +4928,6 @@ smb2_writev_callback(struct mid_q_entry *mid)
 			      server->credits, server->in_flight,
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
-	trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_progress);
 	cifs_write_subrequest_terminated(wdata, result ?: written);
 	release_mid(mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index c2d581429a7b..73e96ccbe830 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -50,12 +50,13 @@
 
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
-	EM(netfs_rreq_trace_copy,		"COPY   ")	\
 	EM(netfs_rreq_trace_collect,		"COLLECT")	\
 	EM(netfs_rreq_trace_complete,		"COMPLET")	\
+	EM(netfs_rreq_trace_copy,		"COPY   ")	\
 	EM(netfs_rreq_trace_dirty,		"DIRTY  ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
+	EM(netfs_rreq_trace_ki_complete,	"KI-CMPL")	\
 	EM(netfs_rreq_trace_recollect,		"RECLLCT")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
@@ -64,13 +65,15 @@
 	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
 	EM(netfs_rreq_trace_unlock_pgpriv2,	"UNLCK-2")	\
 	EM(netfs_rreq_trace_unmark,		"UNMARK ")	\
+	EM(netfs_rreq_trace_unpause,		"UNPAUSE")	\
 	EM(netfs_rreq_trace_wait_ip,		"WAIT-IP")	\
-	EM(netfs_rreq_trace_wait_pause,		"WT-PAUS")	\
-	EM(netfs_rreq_trace_wait_queue,		"WAIT-Q ")	\
+	EM(netfs_rreq_trace_wait_pause,		"--PAUSED--")	\
+	EM(netfs_rreq_trace_wait_quiesce,	"WAIT-QUIESCE")	\
+	EM(netfs_rreq_trace_waited_ip,		"DONE-IP")	\
+	EM(netfs_rreq_trace_waited_pause,	"--UNPAUSED--")	\
+	EM(netfs_rreq_trace_waited_quiesce,	"DONE-QUIESCE")	\
 	EM(netfs_rreq_trace_wake_ip,		"WAKE-IP")	\
 	EM(netfs_rreq_trace_wake_queue,		"WAKE-Q ")	\
-	EM(netfs_rreq_trace_woke_queue,		"WOKE-Q ")	\
-	EM(netfs_rreq_trace_unpause,		"UNPAUSE")	\
 	E_(netfs_rreq_trace_write_done,		"WR-DONE")
 
 #define netfs_sreq_sources					\
@@ -83,6 +86,7 @@
 	E_(NETFS_WRITE_TO_CACHE,		"WRIT")
 
 #define netfs_sreq_traces					\
+	EM(netfs_sreq_trace_abandoned,		"ABNDN")	\
 	EM(netfs_sreq_trace_add_donations,	"+DON ")	\
 	EM(netfs_sreq_trace_added,		"ADD  ")	\
 	EM(netfs_sreq_trace_cache_nowrite,	"CA-NW")	\
@@ -90,6 +94,7 @@
 	EM(netfs_sreq_trace_cache_write,	"CA-WR")	\
 	EM(netfs_sreq_trace_cancel,		"CANCL")	\
 	EM(netfs_sreq_trace_clear,		"CLEAR")	\
+	EM(netfs_sreq_trace_consumed,		"CONSM")	\
 	EM(netfs_sreq_trace_discard,		"DSCRD")	\
 	EM(netfs_sreq_trace_donate_to_prev,	"DON-P")	\
 	EM(netfs_sreq_trace_donate_to_next,	"DON-N")	\
@@ -97,7 +102,12 @@
 	EM(netfs_sreq_trace_fail,		"FAIL ")	\
 	EM(netfs_sreq_trace_free,		"FREE ")	\
 	EM(netfs_sreq_trace_hit_eof,		"EOF  ")	\
-	EM(netfs_sreq_trace_io_progress,	"IO   ")	\
+	EM(netfs_sreq_trace_io_bad,		"I-BAD")	\
+	EM(netfs_sreq_trace_io_malformed,	"I-MLF")	\
+	EM(netfs_sreq_trace_io_unknown,		"I-UNK")	\
+	EM(netfs_sreq_trace_io_progress,	"I-OK ")	\
+	EM(netfs_sreq_trace_io_req_submitted,	"I-RSB")	\
+	EM(netfs_sreq_trace_io_retry_needed,	"I-RTR")	\
 	EM(netfs_sreq_trace_limited,		"LIMIT")	\
 	EM(netfs_sreq_trace_need_clear,		"N-CLR")	\
 	EM(netfs_sreq_trace_partial_read,	"PARTR")	\
@@ -143,8 +153,8 @@
 
 #define netfs_sreq_ref_traces					\
 	EM(netfs_sreq_trace_get_copy_to_cache,	"GET COPY2C ")	\
-	EM(netfs_sreq_trace_get_resubmit,	"GET RESUBMIT")	\
-	EM(netfs_sreq_trace_get_submit,		"GET SUBMIT")	\
+	EM(netfs_sreq_trace_get_resubmit,	"GET RESUBMT")	\
+	EM(netfs_sreq_trace_get_submit,		"GET SUBMIT ")	\
 	EM(netfs_sreq_trace_get_short_read,	"GET SHORTRD")	\
 	EM(netfs_sreq_trace_new,		"NEW        ")	\
 	EM(netfs_sreq_trace_put_abandon,	"PUT ABANDON")	\


