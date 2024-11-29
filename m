Return-Path: <linux-fsdevel+bounces-36161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243F9DEAD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 17:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882F9B236B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA7A19884C;
	Fri, 29 Nov 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4TiVdKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835445BEC
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897213; cv=none; b=OoGmGYWu/Y9yBUK3oAJGszPZ7/ez/t9MIPwhQhfC88ZAaXM5PVElOUICoaXtJg69lE0sDqzEMJzObWEkthXjHA6E4Z1ameqZs7O/d9JCCadHi9eMFM0dIKSOUiY5MveXVzz8IU68X0EA/guGy0VY9Yn8cqjF6aUCI7xaxC9LJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897213; c=relaxed/simple;
	bh=VLIEVNL9LBNDEDmtL3P5+Dw+zfGuvDucK94TvHOCz8o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kXsCcPfPQUotWT/kX/I8+VwlsfW2BJKEUniYg/RXn1kVmQQwIhFo3kv47yBdrQMwEveRdjxZ1XUD/t/3ruaqxc21gH47M8kcxBKdtKjev65iKo2DI+/NKMqmIxHuCu8AbDehgIcsR/+JbhUCq79yBTEYM0NrDI6o2XOzNGuYijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4TiVdKv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732897210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5o8km8xnhEeZ9EFzhJ7F1HLgoKQ4zXXkjzA/RaAN1c=;
	b=K4TiVdKvdwVq9LihiSriCMhCXYCH+WnAalneaAgk1jGnmWvf3xEmcjq+M/PW5s9PA+3E3q
	qxHJSzQX5DCQVS+TKLHvgdY56buQTcsodbwrLTIJQaLHOASh2JRYHW34P9DLxxSTK5QR0E
	DprM6zLyCI46fd5p5etg/XjVEsIqLZA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-TkIfTi1AOgyUXVT740yygA-1; Fri,
 29 Nov 2024 11:20:07 -0500
X-MC-Unique: TkIfTi1AOgyUXVT740yygA-1
X-Mimecast-MFC-AGG-ID: TkIfTi1AOgyUXVT740yygA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 706971953952;
	Fri, 29 Nov 2024 16:20:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E45931955D47;
	Fri, 29 Nov 2024 16:19:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <67478d91.050a0220.253251.0061.GAE@google.com>
References: <67478d91.050a0220.253251.0061.GAE@google.com>
To: syzbot <syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, asmadeus@codewreck.org, bharathsm@microsoft.com,
    brauner@kernel.org, ericvh@kernel.org, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com,
    lucho@ionkov.net, marc.dionne@auristor.com,
    mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
    netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com,
    rostedt@goodmis.org, samba-technical@lists.samba.org,
    sfrench@samba.org, sprasad@microsoft.com,
    syzkaller-bugs@googlegroups.com, tom@talpey.com,
    v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_read_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4020303.1732897192.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Nov 2024 16:19:52 +0000
Message-ID: <4020304.1732897192@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git netfs-writeback

commit 1daca71a815b0d8cfe3db81a31b6dd3fc0da4b50
Author: David Howells <dhowells@redhat.com>
Date:   Fri Nov 29 16:19:03 2024 +0000

    netfs: Fix hang in synchronous read due to failed subreq
    =

    When netfs is performing a synchronous read, it doesn't offload the
    collection of results off to a workqueue, but rather does the collecti=
on in
    the app thread - thereby avoiding the overhead of using a work queue.
    =

    However, if a failure occurs and we might want to retry or if it wants=
 to
    throttle the production of new subreqs, netfs can throw a pause on the
    producer by setting NETFS_RREQ_PAUSE.  This is fine if collection is d=
one
    by workqueue, but in synchronous mode, the collection and retry is don=
e
    after the producer loop completes - thereby deadlocking the two parts.
    =

    Fix this by making the synchronous read producer loop, when it sees th=
e
    PAUSE flag, go and wait for the flag to be cleared or the op to comple=
te
    whilst running the collector to process results.
    =

    This fixes "netfs: Change the read result collector to only use one wo=
rk
    item" - but there's no stable commit ID yet.
    =

    Reported-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Jeff Layton <jlayton@kernel.org>
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index dedcfc2bab2d..0bf3c2f5a710 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -102,10 +102,8 @@ static int netfs_dispatch_unbuffered_reads(struct net=
fs_io_request *rreq)
 =

 		rreq->netfs_ops->issue_read(subreq);
 =

-		if (test_bit(NETFS_RREQ_PAUSE, &rreq->flags)) {
-			trace_netfs_rreq(rreq, netfs_rreq_trace_wait_pause);
-			wait_on_bit(&rreq->flags, NETFS_RREQ_PAUSE, TASK_UNINTERRUPTIBLE);
-		}
+		if (test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
+			netfs_wait_for_pause(rreq);
 		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags))
 			break;
 		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 334bf9f6e6f2..db59ed8880e3 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -96,6 +96,7 @@ void netfs_read_collection_worker(struct work_struct *wo=
rk);
 void netfs_wake_read_collector(struct netfs_io_request *rreq);
 void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error=
, bool was_async);
 ssize_t netfs_wait_for_read(struct netfs_io_request *rreq);
+void netfs_wait_for_pause(struct netfs_io_request *rreq);
 =

 /*
  * read_pgpriv2.c
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index f1b15c20b6f8..3803ef5894c8 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -312,7 +312,7 @@ static void netfs_collect_read_results(struct netfs_io=
_request *rreq)
 	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE, &rreq->flags))=
 {
 		trace_netfs_rreq(rreq, netfs_rreq_trace_unpause);
 		clear_bit_unlock(NETFS_RREQ_PAUSE, &rreq->flags);
-		wake_up_bit(&rreq->flags, NETFS_RREQ_PAUSE);
+		wake_up(&rreq->waitq);
 	}
 =

 	if (notes & MADE_PROGRESS) {
@@ -659,3 +659,39 @@ ssize_t netfs_wait_for_read(struct netfs_io_request *=
rreq)
 =

 	return ret;
 }
+
+/*
+ * Wait for a paused read operation to unpause or complete in some manner=
.
+ */
+void netfs_wait_for_pause(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	struct netfs_io_stream *stream =3D &rreq->io_streams[0];
+	DEFINE_WAIT(myself);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_wait_pause);
+
+	for (;;) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
+		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
+
+		subreq =3D list_first_entry_or_null(&stream->subrequests,
+						  struct netfs_io_subrequest, rreq_link);
+		if (subreq &&
+		    (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
+		     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags))) {
+			__set_current_state(TASK_RUNNING);
+			netfs_read_collection(rreq);
+			continue;
+		}
+
+		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags) ||
+		    !test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
+			break;
+
+		schedule();
+		trace_netfs_rreq(rreq, netfs_rreq_trace_woke_queue);
+	}
+
+	finish_wait(&rreq->waitq, &myself);
+}
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 4a1499167770..bb74f30a4216 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -324,7 +324,7 @@ static void netfs_collect_write_results(struct netfs_i=
o_request *wreq)
 	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE, &wreq->flags))=
 {
 		trace_netfs_rreq(wreq, netfs_rreq_trace_unpause);
 		clear_bit_unlock(NETFS_RREQ_PAUSE, &wreq->flags);
-		wake_up_bit(&wreq->flags, NETFS_RREQ_PAUSE);
+		wake_up(&wreq->waitq);
 	}
 =

 	if (notes & NEED_REASSESS) {
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index cd2b349243b3..6506bf1d970e 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -721,7 +721,7 @@ int netfs_unbuffered_write(struct netfs_io_request *wr=
eq, bool may_wait, size_t
 		rolling_buffer_advance(&wreq->buffer, part);
 		if (test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
 			trace_netfs_rreq(wreq, netfs_rreq_trace_wait_pause);
-			wait_on_bit(&wreq->flags, NETFS_RREQ_PAUSE, TASK_UNINTERRUPTIBLE);
+			wait_event(wreq->waitq, !test_bit(NETFS_RREQ_PAUSE, &wreq->flags));
 		}
 		if (test_bit(NETFS_RREQ_FAILED, &wreq->flags))
 			break;


