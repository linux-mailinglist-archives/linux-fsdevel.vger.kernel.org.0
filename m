Return-Path: <linux-fsdevel+bounces-41616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA79A33276
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 23:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C417A083B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9D25D54D;
	Wed, 12 Feb 2025 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="donzMekO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840D202C45
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399073; cv=none; b=oTYvIhfJBkZxlGpYCEFa7R9MkHA/9NKF/xPyUhmDxbpmaKMObSrbXENL574uOIuDwypKeeWeFdxieJ6Jh2VA1f6Gho8noeNHuF6OKXUXgDWzpyzn20skwN3c2UOo3HfUIVtVE79V/NmNS8oKbjFZLAul8X8ubiNmg6pYS3C+KoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399073; c=relaxed/simple;
	bh=7RqIR3gO1J4s6DwKVEvdvC3RY3bXSjSuBCYHwp2WB48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA1ekEtnDIVxusGFHfyHQes7f99gLfXg+BSRk5sXUyU3H0YTS641VSo2m/KeqSd5Uqo6USluawsFwYQlV7zMR4XBPu6OsgQjCTA0A1j3ufxx3kh2xIgPBrc8KQKW+WwmWNzAMy4t81o+T2p4mzCt1Vpe6Eq2klI3R89GFwqRc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=donzMekO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739399070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRldUghMikdwUnBaJvjK9dKHCa6B+hVfjvsAnaaB4KI=;
	b=donzMekOkCA3uK/aFS3J5fPLMg6h2QDu27hqpUl3SPeVSWUNjem108xxJQO0o7kh0s6oIs
	hdD0al4trx1tEqkVGGzI4uaeDsF1lGzjIXrNguDhrpLBZZ2zoRH4PLDUKccg8PZ/vUJM65
	D0dlM+8hkdXgpLSAkFDYeflY8q/OA7E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-_i3eWkCqMoe9SbADcwQVQw-1; Wed,
 12 Feb 2025 17:24:25 -0500
X-MC-Unique: _i3eWkCqMoe9SbADcwQVQw-1
X-Mimecast-MFC-AGG-ID: _i3eWkCqMoe9SbADcwQVQw_1739399062
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E373019560B9;
	Wed, 12 Feb 2025 22:24:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAE8A18004A7;
	Wed, 12 Feb 2025 22:24:14 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH 1/3] netfs: Fix a number of read-retry hangs
Date: Wed, 12 Feb 2025 22:23:59 +0000
Message-ID: <20250212222402.3618494-2-dhowells@redhat.com>
In-Reply-To: <20250212222402.3618494-1-dhowells@redhat.com>
References: <20250212222402.3618494-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix a number of hangs in the netfslib read-retry code, including:

 (1) netfs_reissue_read() doubles up the getting of references on
     subrequests, thereby leaking the subrequest and causing inode eviction
     to wait indefinitely.  This can lead to the kernel reporting a hang in
     the filesystem's evict_inode().

     Fix this by removing the get from netfs_reissue_read() and adding one
     to netfs_retry_read_subrequests() to deal with the one place that
     didn't double up.

 (2) The loop in netfs_retry_read_subrequests() that retries a sequence of
     failed subrequests doesn't record whether or not it retried the one
     that the "subreq" pointer points to when it leaves the loop.  It may
     not if renegotiation/repreparation of the subrequests means that fewer
     subrequests are needed to span the cumulative range of the sequence.

     Because it doesn't record this, the piece of code that discards
     now-superfluous subrequests doesn't know whether it should discard the
     one "subreq" points to - and so it doesn't.

     Fix this by noting whether the last subreq it examines is superfluous
     and if it is, then getting rid of it and all subsequent subrequests.

     If that one one wasn't superfluous, then we would have tried to go
     round the previous loop again and so there can be no further unretried
     subrequests in the sequence.

 (3) netfs_retry_read_subrequests() gets yet an extra ref on any additional
     subrequests it has to get because it ran out of ones it could reuse to
     to renegotiation/repreparation shrinking the subrequests.

     Fix this by removing that extra ref.

 (4) In netfs_retry_reads(), it was using wait_on_bit() to wait for
     NETFS_SREQ_IN_PROGRESS to be cleared on all subrequests in the
     sequence - but netfs_read_subreq_terminated() is now using a wait
     queue on the request instead and so this wait will never finish.

     Fix this by waiting on the wait queue instead.  To make this work, a
     new flag, NETFS_RREQ_RETRYING, is now set around the wait loop to tell
     the wake-up code to wake up the wait queue rather than requeuing the
     request's work item.

     Note that this flag replaces the NETFS_RREQ_NEED_RETRY flag which is
     no longer used.

 (5) Whilst not strictly anything to do with the hang,
     netfs_retry_read_subrequests() was also doubly incrementing the
     subreq_counter and re-setting the debug index, leaving a gap in the
     trace.  This is also fixed.

One of these hangs was observed with 9p and with cifs.  Others were forced
by manual code injection into fs/afs/file.c.  Firstly, afs_prepare_read()
was created to provide an changing pattern of maximum subrequest sizes:

	static int afs_prepare_read(struct netfs_io_subrequest *subreq)
	{
		struct netfs_io_request *rreq = subreq->rreq;
		if (!S_ISREG(subreq->rreq->inode->i_mode))
			return 0;
		if (subreq->retry_count < 20)
			rreq->io_streams[0].sreq_max_len =
				umax(200, 2222 - subreq->retry_count * 40);
		else
			rreq->io_streams[0].sreq_max_len = 3333;
		return 0;
	}

and pointed to by afs_req_ops.  Then the following:

	struct netfs_io_subrequest *subreq = op->fetch.subreq;
	if (subreq->error == 0 &&
	    S_ISREG(subreq->rreq->inode->i_mode) &&
	    subreq->retry_count < 20) {
		subreq->transferred = subreq->already_done;
		__clear_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
		__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
		afs_fetch_data_notify(op);
		return;
	}

was inserted into afs_fetch_data_success() at the beginning and struct
netfs_io_subrequest given an extra field, "already_done" that was set to
the value in "subreq->transferred" by netfs_reissue_read().

When reading a 4K file, the subrequests would get gradually smaller, a new
subrequest would be allocated around the 3rd retry and then eventually be
rendered superfluous when the 20th retry was hit and the limit on the first
subrequest was eased.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Steve French <stfrench@microsoft.com>
cc: Ihor Solodrai <ihor.solodrai@pm.me>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c      |  6 ++++--
 fs/netfs/read_retry.c        | 40 +++++++++++++++++++++++++++---------
 include/linux/netfs.h        |  2 +-
 include/trace/events/netfs.h |  4 +++-
 4 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index f65affa5a9e4..636cc5a98ef5 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -470,7 +470,8 @@ void netfs_read_collection_worker(struct work_struct *work)
  */
 void netfs_wake_read_collector(struct netfs_io_request *rreq)
 {
-	if (test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags)) {
+	if (test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags) &&
+	    !test_bit(NETFS_RREQ_RETRYING, &rreq->flags)) {
 		if (!work_pending(&rreq->work)) {
 			netfs_get_request(rreq, netfs_rreq_trace_get_work);
 			if (!queue_work(system_unbound_wq, &rreq->work))
@@ -586,7 +587,8 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 	smp_mb__after_atomic(); /* Clear IN_PROGRESS before task state */
 
 	/* If we are at the head of the queue, wake up the collector. */
-	if (list_is_first(&subreq->rreq_link, &stream->subrequests))
+	if (list_is_first(&subreq->rreq_link, &stream->subrequests) ||
+	    test_bit(NETFS_RREQ_RETRYING, &rreq->flags))
 		netfs_wake_read_collector(rreq);
 
 	netfs_put_subrequest(subreq, true, netfs_sreq_trace_put_terminated);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 2290af0d51ac..8316c4533a51 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -14,7 +14,6 @@ static void netfs_reissue_read(struct netfs_io_request *rreq,
 {
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 	subreq->rreq->netfs_ops->issue_read(subreq);
 }
 
@@ -48,6 +47,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 				__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 				subreq->retry_count++;
 				netfs_reset_iter(subreq);
+				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 				netfs_reissue_read(rreq, subreq);
 			}
 		}
@@ -75,7 +75,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		struct iov_iter source;
 		unsigned long long start, len;
 		size_t part;
-		bool boundary = false;
+		bool boundary = false, subreq_superfluous = false;
 
 		/* Go through the subreqs and find the next span of contiguous
 		 * buffer that we then rejig (cifs, for example, needs the
@@ -116,8 +116,10 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		/* Work through the sublist. */
 		subreq = from;
 		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
-			if (!len)
+			if (!len) {
+				subreq_superfluous = true;
 				break;
+			}
 			subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
 			subreq->start	= start - subreq->transferred;
 			subreq->len	= len   + subreq->transferred;
@@ -154,19 +156,21 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 
 			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 			netfs_reissue_read(rreq, subreq);
-			if (subreq == to)
+			if (subreq == to) {
+				subreq_superfluous = false;
 				break;
+			}
 		}
 
 		/* If we managed to use fewer subreqs, we can discard the
 		 * excess; if we used the same number, then we're done.
 		 */
 		if (!len) {
-			if (subreq == to)
+			if (!subreq_superfluous)
 				continue;
 			list_for_each_entry_safe_from(subreq, tmp,
 						      &stream->subrequests, rreq_link) {
-				trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
+				trace_netfs_sreq(subreq, netfs_sreq_trace_superfluous);
 				list_del(&subreq->rreq_link);
 				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
 				if (subreq == to)
@@ -187,14 +191,12 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			subreq->source		= NETFS_DOWNLOAD_FROM_SERVER;
 			subreq->start		= start;
 			subreq->len		= len;
-			subreq->debug_index	= atomic_inc_return(&rreq->subreq_counter);
 			subreq->stream_nr	= stream->stream_nr;
 			subreq->retry_count	= 1;
 
 			trace_netfs_sreq_ref(rreq->debug_id, subreq->debug_index,
 					     refcount_read(&subreq->ref),
 					     netfs_sreq_trace_new);
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 
 			list_add(&subreq->rreq_link, &to->rreq_link);
 			to = list_next_entry(to, rreq_link);
@@ -256,14 +258,32 @@ void netfs_retry_reads(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	DEFINE_WAIT(myself);
+
+	set_bit(NETFS_RREQ_RETRYING, &rreq->flags);
 
 	/* Wait for all outstanding I/O to quiesce before performing retries as
 	 * we may need to renegotiate the I/O sizes.
 	 */
 	list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
-		wait_on_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS,
-			    TASK_UNINTERRUPTIBLE);
+		if (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags))
+			continue;
+
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
+		for (;;) {
+			prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
+
+			if (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags))
+				break;
+
+			trace_netfs_sreq(subreq, netfs_sreq_trace_wait_for);
+			schedule();
+			trace_netfs_rreq(rreq, netfs_rreq_trace_woke_queue);
+		}
+
+		finish_wait(&rreq->waitq, &myself);
 	}
+	clear_bit(NETFS_RREQ_RETRYING, &rreq->flags);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
 	netfs_retry_read_subrequests(rreq);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 071d05d81d38..c86a11cfc4a3 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -278,7 +278,7 @@ struct netfs_io_request {
 #define NETFS_RREQ_PAUSE		11	/* Pause subrequest generation */
 #define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
 #define NETFS_RREQ_ALL_QUEUED		13	/* All subreqs are now queued */
-#define NETFS_RREQ_NEED_RETRY		14	/* Need to try retrying */
+#define NETFS_RREQ_RETRYING		14	/* Set if we're in the retry path */
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
 	const struct netfs_request_ops *netfs_ops;
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 6e699cadcb29..f880835f7695 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -99,7 +99,7 @@
 	EM(netfs_sreq_trace_limited,		"LIMIT")	\
 	EM(netfs_sreq_trace_need_clear,		"N-CLR")	\
 	EM(netfs_sreq_trace_partial_read,	"PARTR")	\
-	EM(netfs_sreq_trace_need_retry,		"NRTRY")	\
+	EM(netfs_sreq_trace_need_retry,		"ND-RT")	\
 	EM(netfs_sreq_trace_prepare,		"PREP ")	\
 	EM(netfs_sreq_trace_prep_failed,	"PRPFL")	\
 	EM(netfs_sreq_trace_progress,		"PRGRS")	\
@@ -108,7 +108,9 @@
 	EM(netfs_sreq_trace_short,		"SHORT")	\
 	EM(netfs_sreq_trace_split,		"SPLIT")	\
 	EM(netfs_sreq_trace_submit,		"SUBMT")	\
+	EM(netfs_sreq_trace_superfluous,	"SPRFL")	\
 	EM(netfs_sreq_trace_terminated,		"TERM ")	\
+	EM(netfs_sreq_trace_wait_for,		"_WAIT")	\
 	EM(netfs_sreq_trace_write,		"WRITE")	\
 	EM(netfs_sreq_trace_write_skip,		"SKIP ")	\
 	E_(netfs_sreq_trace_write_term,		"WTERM")


