Return-Path: <linux-fsdevel+bounces-32977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E29B10E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C03F1F21269
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B723AA6B;
	Fri, 25 Oct 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZUT2W0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6627D235A28
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889024; cv=none; b=bhflZGpphwJxxRNQ4J1BAFg9B/R1raZaylllN6UUd6WjxN4AN5u49mTAIcNAhsyxVhSrTX2RInn4ZOhbo2N1UBjEtzR7/OiceMcra5PH5b3c+mx0tVUjlY9FS4zeKCSS+rvcFosiH2wDiW7iFz5CSRIUZ+dmpD/a5Bp7anlmxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889024; c=relaxed/simple;
	bh=w/QUy+Q1M64ZJh31ZN7fzRbhVOhRFlNHTlwai2FIezU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWqelcqPsfx0fVAMiq2KRKTxdrCdE5qHi5TyYyWxlwJ5/K/Uoqxyk0bf6Y8KVnBLpOmhazmLukQWYN46V/gAMMzodmycsAOJ4LSbb9CNTOHhqqIdYsgScA5vnuQV2VtbAB+nShBTEW0LLahuowkjzwAjRgJWukDp1OaQ+zhck0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZUT2W0j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729889021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0urA38A4ADOiCMpfN0uGJZmadb1R6bcZLrketz8DnY=;
	b=WZUT2W0jHOGRkJfNKCxU8UdWFnngFmnXshYOx3O1oLA0rEhKpChli/rfCvJT+gQlzA81lF
	yWJ0i/cEQF+nr2PSHB/VORpx/rSMD4NOwHGWeRU0a/6mnMd/KZxrFLQMs88IRl5lGl7Y/k
	DaitvTqfRlOqJZCxSs9A2/gyfiJQY/E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-bOhXfy4qM0m2gI-6uqYeIg-1; Fri,
 25 Oct 2024 16:43:38 -0400
X-MC-Unique: bOhXfy4qM0m2gI-6uqYeIg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6085719560B8;
	Fri, 25 Oct 2024 20:43:35 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AAD3196BB7E;
	Fri, 25 Oct 2024 20:43:30 +0000 (UTC)
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
Subject: [PATCH v2 30/31] afs: Add a tracepoint for afs_read_receive()
Date: Fri, 25 Oct 2024 21:39:57 +0100
Message-ID: <20241025204008.4076565-31-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add a tracepoint for afs_read_receive() to allow potential missed wakeups
to be debugged.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c              |  1 +
 include/trace/events/afs.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index e89a98735317..dbc108c6cae5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -270,6 +270,7 @@ static void afs_read_receive(struct afs_call *call)
 	enum afs_call_state state;
 
 	_enter("");
+	trace_afs_read_recv(op, call);
 
 	state = READ_ONCE(call->state);
 	if (state == AFS_CALL_COMPLETE)
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 020ab7302a6b..8da64c9d25e6 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1773,6 +1773,36 @@ TRACE_EVENT(afs_make_call,
 		      __entry->fid.unique)
 	    );
 
+TRACE_EVENT(afs_read_recv,
+	    TP_PROTO(const struct afs_operation *op, const struct afs_call *call),
+
+	    TP_ARGS(op, call),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		sreq)
+		    __field(unsigned int,		op)
+		    __field(unsigned int,		op_flags)
+		    __field(unsigned int,		call)
+		    __field(enum afs_call_state,	call_state)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->op = op->debug_id;
+		    __entry->sreq = op->fetch.subreq->debug_index;
+		    __entry->rreq = op->fetch.subreq->rreq->debug_id;
+		    __entry->op_flags = op->flags;
+		    __entry->call = call->debug_id;
+		    __entry->call_state = call->state;
+			   ),
+
+	    TP_printk("R=%08x[%x] OP=%08x c=%08x cs=%x of=%x",
+		      __entry->rreq, __entry->sreq,
+		      __entry->op,
+		      __entry->call, __entry->call_state,
+		      __entry->op_flags)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */


