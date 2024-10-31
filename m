Return-Path: <linux-fsdevel+bounces-33345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AECA9B7B2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC571C2144E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D71819D089;
	Thu, 31 Oct 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAhTuZ5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88822175BF
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379527; cv=none; b=KKOGJ4euD148fQAXkIyWv2HKhpGfxftO38jJyThc3rakvNQhtT1FL27pvGeHhYDgTlBBT9P5UKpWmr/zrVTEJlnDWI/0MH0cli3YR5Qe9g/q4rIqyu+zenlmROKAMez9u28qppuAe6Hszd3g2qmKRAeg4tMQjy1+Q61iaWpS7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379527; c=relaxed/simple;
	bh=DXnZKixscFoBQMJXA8w4bMmQD+j421Dnphaji0yHKQU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Gf735LSGr5+ylSEqSJRYGcyKHRgzsia0D9gyrovsr8LtB2L75rkU9K493KsFLqO+DVKBnkcEPqhNexscVlx/uvqJB7DsiBDVRzcwOM3Ktm7usJAdEkQ9EgrJl/+4R8X2WybGciOM+GaRsDEw4Dcpup5hQ7/CQEpayYLg090Vwgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAhTuZ5w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730379524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tw7g6uU6ZxI1gC/pUKtFC6nfgE91Ln7aDN8ewiylNhk=;
	b=cAhTuZ5wPsYghsQmQ9HoNpzbD4yboAXgCUtjiEJvRGSOPbseKo7Rqf/crJJZ66cEPGTd4y
	LK/2/kgV/0WjqY+/JKFfb3uqd3SOD7v3uz/Yh277PIJSeyRneS7p1HzUn7ZDjr/hsyBajw
	Vt5rLlvI9yniZ0ni3tPGbYWp24izWNE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-Mc0dZgGdMRKw16nHTE7gOw-1; Thu,
 31 Oct 2024 08:58:41 -0400
X-MC-Unique: Mc0dZgGdMRKw16nHTE7gOw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91A071956058;
	Thu, 31 Oct 2024 12:58:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40C4E1956054;
	Thu, 31 Oct 2024 12:58:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-26-dhowells@redhat.com>
References: <20241025204008.4076565-26-dhowells@redhat.com> <20241025204008.4076565-1-dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/31] afs: Make {Y,}FS.FetchData an asynchronous operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43387.1730379513.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Oct 2024 12:58:33 +0000
Message-ID: <43388.1730379513@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

I think this may need an additional bit (see attached).

David
---
afs: Fix hang due to FetchData RPC op being cancelled by signal

If a signal comes in just as an RPC operation is being queued to get a
channel for transmission, afs_make_call() will submit an immediate abort
and cancel the asynchronous work.  This is a problem for asynchronous
FetchData as the file-read routines don't get notified and don't therefore
get to inform netfslib, leaving netfslib hanging.

Fix this by:

 (1) Split the ->done() call op to have an ->immediate_cancel() op also
     that is called by afs_make_call() instead of ->done().

     It is undesirable from async FetchData's point of view to implement
     ->done() as this is also called from the received data processing
     loop, which is triggered by the async notification from AF_RXRPC.

 (2) Make the various async Probe RPCs use their ->immediate_cancel() go t=
o
     the same handler as their ->done() call.

 (3) Don't provide the Lock RPCs, InlineBulkStatus RPC and YFS.RemoveFile2
     RPC with ->immediate_cancel() as their ->done() calls are only
     interested in looking at the response from the server.

 (4) Implement this for FetchData RPCs, making it schedule the async
     handler and wait for it so that it doesn't get cancelled.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c      |    8 ++++++++
 fs/afs/fsclient.c  |    3 +++
 fs/afs/internal.h  |   17 +++++++++++++++++
 fs/afs/rxrpc.c     |   17 ++---------------
 fs/afs/vlclient.c  |    1 +
 fs/afs/yfsclient.c |    1 +
 6 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index dbc108c6cae5..a2880fd3c460 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -314,6 +314,14 @@ void afs_fetch_data_async_rx(struct work_struct *work=
)
 	afs_put_call(call);
 }
 =

+void afs_fetch_data_immediate_cancel(struct afs_call *call)
+{
+	afs_get_call(call, afs_call_trace_wake);
+	if (!queue_work(afs_async_calls, &call->async_work))
+		afs_deferred_put_call(call);
+	flush_work(&call->async_work);
+}
+
 /*
  * Fetch file data from the volume.
  */
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 6380cdcfd4fc..1d9ecd5418d8 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -410,6 +410,7 @@ static const struct afs_call_type afs_RXFSFetchData =3D=
 {
 	.op		=3D afs_FS_FetchData,
 	.async_rx	=3D afs_fetch_data_async_rx,
 	.deliver	=3D afs_deliver_fs_fetch_data,
+	.immediate_cancel =3D afs_fetch_data_immediate_cancel,
 	.destructor	=3D afs_flat_call_destructor,
 };
 =

@@ -418,6 +419,7 @@ static const struct afs_call_type afs_RXFSFetchData64 =
=3D {
 	.op		=3D afs_FS_FetchData64,
 	.async_rx	=3D afs_fetch_data_async_rx,
 	.deliver	=3D afs_deliver_fs_fetch_data,
+	.immediate_cancel =3D afs_fetch_data_immediate_cancel,
 	.destructor	=3D afs_flat_call_destructor,
 };
 =

@@ -1734,6 +1736,7 @@ static const struct afs_call_type afs_RXFSGetCapabil=
ities =3D {
 	.op		=3D afs_FS_GetCapabilities,
 	.deliver	=3D afs_deliver_fs_get_capabilities,
 	.done		=3D afs_fileserver_probe_result,
+	.immediate_cancel =3D afs_fileserver_probe_result,
 	.destructor	=3D afs_fs_get_capabilities_destructor,
 };
 =

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b11b2dfb8380..2077f6c923e0 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -210,6 +210,9 @@ struct afs_call_type {
 =

 	/* Call done function (gets called immediately on success or failure) */
 	void (*done)(struct afs_call *call);
+
+	/* Handle a call being immediately cancelled. */
+	void (*immediate_cancel)(struct afs_call *call);
 };
 =

 /*
@@ -1127,6 +1130,7 @@ extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
 void afs_fetch_data_async_rx(struct work_struct *work);
+void afs_fetch_data_immediate_cancel(struct afs_call *call);
 =

 /*
  * flock.c
@@ -1362,6 +1366,19 @@ extern void afs_send_simple_reply(struct afs_call *=
, const void *, size_t);
 extern int afs_extract_data(struct afs_call *, bool);
 extern int afs_protocol_error(struct afs_call *, enum afs_eproto_cause);
 =

+static inline struct afs_call *afs_get_call(struct afs_call *call,
+					    enum afs_call_trace why)
+{
+	int r;
+
+	__refcount_inc(&call->ref, &r);
+
+	trace_afs_call(call->debug_id, why, r + 1,
+		       atomic_read(&call->net->nr_outstanding_calls),
+		       __builtin_return_address(0));
+	return call;
+}
+
 static inline void afs_make_op_call(struct afs_operation *op, struct afs_=
call *call,
 				    gfp_t gfp)
 {
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 94fff4e214b0..066e5d70dabe 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -236,19 +236,6 @@ void afs_deferred_put_call(struct afs_call *call)
 		schedule_work(&call->free_work);
 }
 =

-static struct afs_call *afs_get_call(struct afs_call *call,
-				     enum afs_call_trace why)
-{
-	int r;
-
-	__refcount_inc(&call->ref, &r);
-
-	trace_afs_call(call->debug_id, why, r + 1,
-		       atomic_read(&call->net->nr_outstanding_calls),
-		       __builtin_return_address(0));
-	return call;
-}
-
 /*
  * Queue the call for actual work.
  */
@@ -444,8 +431,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	call->error =3D ret;
 	trace_afs_call_done(call);
 error_kill_call:
-	if (call->type->done)
-		call->type->done(call);
+	if (call->type->immediate_cancel)
+		call->type->immediate_cancel(call);
 =

 	/* We need to dispose of the extra ref we grabbed for an async call.
 	 * The call, however, might be queued on afs_async_calls and we need to
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index cac75f89b64a..adc617a82a86 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -370,6 +370,7 @@ static const struct afs_call_type afs_RXVLGetCapabilit=
ies =3D {
 	.name		=3D "VL.GetCapabilities",
 	.op		=3D afs_VL_GetCapabilities,
 	.deliver	=3D afs_deliver_vl_get_capabilities,
+	.immediate_cancel =3D afs_vlserver_probe_result,
 	.done		=3D afs_vlserver_probe_result,
 	.destructor	=3D afs_destroy_vl_get_capabilities,
 };
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 4e7d93ee5a08..f57c089f26ee 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -458,6 +458,7 @@ static const struct afs_call_type yfs_RXYFSFetchData64=
 =3D {
 	.op		=3D yfs_FS_FetchData64,
 	.async_rx	=3D afs_fetch_data_async_rx,
 	.deliver	=3D yfs_deliver_fs_fetch_data64,
+	.immediate_cancel =3D afs_fetch_data_immediate_cancel,
 	.destructor	=3D afs_flat_call_destructor,
 };
 =


