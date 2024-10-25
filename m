Return-Path: <linux-fsdevel+bounces-32978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6619B10F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC428263A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E5A21F220;
	Fri, 25 Oct 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4ne3AtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F3215C7A
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889032; cv=none; b=c0/FprwJw8LILZKxAF2wVVMkjNSBYDpR0tZvCkgH4WYEI34HPfVtG+sREIQCSYLYV0Z1CbSiDuhf4eNtQjc9bA6k5hh/GD/NVXGp5IWRjHpQnsJNX4Dlc1jWwc1ovA3Lm8lVg/Hcm5Z6cKU1d1RL//2tMtL7jhYpHfu8OYoSYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889032; c=relaxed/simple;
	bh=YfHQHHklQqGthguUT+hofehz3Evx2ahQywNsAF+2OGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgG878vwUHpWg8Vi1G/t0gtoaXDytITXziusWXzPXXT7CxWklFjNuaSHKkcRIPHwj17mwe1AzNBO7eW16ZXPuWnsIwCCDPBbAIJAB2Cs6+XFt93BmILIrcy3yy+HT9QO48pssuTuPTyFNEPkxluHb4SEil3GI4iZGwHOUDozdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4ne3AtH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729889028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlfv2ApsSBgn//KdBsSlx8BkotK5+tCpg2808yZLllw=;
	b=U4ne3AtHIEV/4H8+XCiF+5OSpc2dXCK1eRVzxH6QfzpWmDXV0fLTJJXh97I7VTUu1P6EPn
	Y4+kg/C+6lf29tt0k/6Pq4+OlRE0Lkb0H3wAIIVHbTm2c5mstSoJKx9ARYNKonrjavjzHz
	zxdl4XOSQYQh6SMW1RFeQQT3Av/nHgk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-u5Lv1EpXN9KW8rs1n0j3Wg-1; Fri,
 25 Oct 2024 16:43:45 -0400
X-MC-Unique: u5Lv1EpXN9KW8rs1n0j3Wg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6E6719560A7;
	Fri, 25 Oct 2024 20:43:41 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9ADD73000198;
	Fri, 25 Oct 2024 20:43:36 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com,
	Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v2 31/31] netfs: Report on NULL folioq in netfs_writeback_unlock_folios()
Date: Fri, 25 Oct 2024 21:39:58 +0100
Message-ID: <20241025204008.4076565-32-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

It seems that it's possible to get to netfs_writeback_unlock_folios() with
an empty rolling buffer during buffered writes.  This should not be
possible as the rolling buffer is initialised as the write request is set
up and thereafter maintains at least one folio_queue struct therein until
it gets destroyed.  This allows lockless addition and removal of
folio_queue structs in the buffer because, unlike with a ring buffer, the
producer and consumer each only need to look at and alter one pointer into
the buffer.

Now, the rolling buffer is only used for buffered I/O operations as
netfs_collect_write_results() should only call
netfs_writeback_unlock_folios() if the request is of origin type
NETFS_WRITEBACK, NETFS_WRITETHROUGH or NETFS_PGPRIV2_COPY_TO_CACHE.

So it would seem that one of the following occurred: (1) I/O started before
the request was fully initialised, (2) the origin got switched mid-flow or
(3) the request has already been freed and this is a UAF error.  I think the
last is the most likely.

Make netfs_writeback_unlock_folios() report information about the request
and subrequests if folioq is seen to be NULL to try and help debug this,
throw a warning and return.

Note that this does not try to fix the problem.

Reported-by: syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Chang Yu <marcus.yu.56@gmail.com>
Link: https://lore.kernel.org/r/ZxshMEW4U7MTgQYa@gmail.com/
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_collect.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 3d8b87c8e6a6..4a1499167770 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -21,6 +21,34 @@
 #define NEED_RETRY		0x10	/* A front op requests retrying */
 #define SAW_FAILURE		0x20	/* One stream or hit a permanent failure */
 
+static void netfs_dump_request(const struct netfs_io_request *rreq)
+{
+	pr_err("Request R=%08x r=%d fl=%lx or=%x e=%ld\n",
+	       rreq->debug_id, refcount_read(&rreq->ref), rreq->flags,
+	       rreq->origin, rreq->error);
+	pr_err("  st=%llx tsl=%zx/%llx/%llx\n",
+	       rreq->start, rreq->transferred, rreq->submitted, rreq->len);
+	pr_err("  cci=%llx/%llx/%llx\n",
+	       rreq->cleaned_to, rreq->collected_to, atomic64_read(&rreq->issued_to));
+	pr_err("  iw=%pSR\n", rreq->netfs_ops->issue_write);
+	for (int i = 0; i < NR_IO_STREAMS; i++) {
+		const struct netfs_io_subrequest *sreq;
+		const struct netfs_io_stream *s = &rreq->io_streams[i];
+
+		pr_err("  str[%x] s=%x e=%d acnf=%u,%u,%u,%u\n",
+		       s->stream_nr, s->source, s->error,
+		       s->avail, s->active, s->need_retry, s->failed);
+		pr_err("  str[%x] ct=%llx t=%zx\n",
+		       s->stream_nr, s->collected_to, s->transferred);
+		list_for_each_entry(sreq, &s->subrequests, rreq_link) {
+			pr_err("  sreq[%x:%x] sc=%u s=%llx t=%zx/%zx r=%d f=%lx\n",
+			       sreq->stream_nr, sreq->debug_index, sreq->source,
+			       sreq->start, sreq->transferred, sreq->len,
+			       refcount_read(&sreq->ref), sreq->flags);
+		}
+	}
+}
+
 /*
  * Successful completion of write of a folio to the server and/or cache.  Note
  * that we are not allowed to lock the folio here on pain of deadlocking with
@@ -87,6 +115,12 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 	unsigned long long collected_to = wreq->collected_to;
 	unsigned int slot = wreq->buffer.first_tail_slot;
 
+	if (WARN_ON_ONCE(!folioq)) {
+		pr_err("[!] Writeback unlock found empty rolling buffer!\n");
+		netfs_dump_request(wreq);
+		return;
+	}
+
 	if (wreq->origin == NETFS_PGPRIV2_COPY_TO_CACHE) {
 		if (netfs_pgpriv2_unlock_copied_folios(wreq))
 			*notes |= MADE_PROGRESS;


