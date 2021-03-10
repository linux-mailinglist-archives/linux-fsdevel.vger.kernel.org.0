Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEAF334459
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhCJQ7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 11:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233729AbhCJQ6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615395530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQNUuBW+9nMhmEIAwv23wViHSyykZAhr8Meh+ZBeISc=;
        b=H0ldLEPZ18PkKZwTX/hik8Yw3a2lPqRlWiqHQz3FvxNx67z3TDMrLCMsld6f/GWXqsmeZr
        5frTWWbGlIsCGmRhnOJBOeQj9hMQfd6w82Vt0NTMkKQ2YD6Ayb1xSG1LSUPzNNhvKtCZb6
        fMxors2Uj++j+l/rt56M19qzL87g6U0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195--bcf8gTHO2i8G-PBFB0ZNw-1; Wed, 10 Mar 2021 11:58:46 -0500
X-MC-Unique: -bcf8gTHO2i8G-PBFB0ZNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66D4183DD22;
        Wed, 10 Mar 2021 16:58:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 403C35D9DB;
        Wed, 10 Mar 2021 16:58:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 19/28] afs: Don't truncate iter during data fetch
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Mar 2021 16:58:37 +0000
Message-ID: <161539551721.286939.14655713136572200716.stgit@warthog.procyon.org.uk>
In-Reply-To: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't truncate the iterator to correspond to the actual data size when
fetching the data from the server - rather, pass the length we want to read
to rxrpc.

This will allow the clear-after-read code in future to simply clear the
remaining iterator capacity rather than having to reinitialise the
iterator.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/158861249201.340223.13035445866976590375.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/159465825061.1377938.14403904452300909320.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160588531418.3465195.10712005940763063144.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118148567.1232039.13380313332292947956.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161044610.2537118.17908520793806837792.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340407907.1303470.6501394859511712746.stgit@warthog.procyon.org.uk/ # v3
---

 fs/afs/fsclient.c      |    6 ++++--
 fs/afs/internal.h      |    6 ++++++
 fs/afs/rxrpc.c         |   13 +++++++++----
 fs/afs/yfsclient.c     |    6 ++++--
 include/net/af_rxrpc.h |    2 +-
 net/rxrpc/recvmsg.c    |    9 +++++----
 6 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 1d95ed9dd86e..4a57c6c6f12b 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -305,8 +305,9 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 	unsigned int size;
 	int ret;
 
-	_enter("{%u,%zu/%llu}",
-	       call->unmarshall, iov_iter_count(call->iter), req->actual_len);
+	_enter("{%u,%zu,%zu/%llu}",
+	       call->unmarshall, call->iov_len, iov_iter_count(call->iter),
+	       req->actual_len);
 
 	switch (call->unmarshall) {
 	case 0:
@@ -343,6 +344,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			size = PAGE_SIZE - req->offset;
 		else
 			size = req->remain;
+		call->iov_len = size;
 		call->bvec[0].bv_len = size;
 		call->bvec[0].bv_offset = req->offset;
 		call->bvec[0].bv_page = req->pages[req->index];
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 921e7d3b2cfa..4725cfc4aaef 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -104,6 +104,7 @@ struct afs_call {
 	struct afs_server	*server;	/* The fileserver record if fs op (pins ref) */
 	struct afs_vlserver	*vlserver;	/* The vlserver record if vl op */
 	void			*request;	/* request data (first part) */
+	size_t			iov_len;	/* Size of *iter to be used */
 	struct iov_iter		def_iter;	/* Default buffer/data iterator */
 	struct iov_iter		*iter;		/* Iterator currently in use */
 	union {	/* Convenience for ->def_iter */
@@ -1271,6 +1272,7 @@ static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *c
 
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
 {
+	call->iov_len = size;
 	call->kvec[0].iov_base = buf;
 	call->kvec[0].iov_len = size;
 	iov_iter_kvec(&call->def_iter, READ, call->kvec, 1, size);
@@ -1278,21 +1280,25 @@ static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t si
 
 static inline void afs_extract_to_tmp(struct afs_call *call)
 {
+	call->iov_len = sizeof(call->tmp);
 	afs_extract_begin(call, &call->tmp, sizeof(call->tmp));
 }
 
 static inline void afs_extract_to_tmp64(struct afs_call *call)
 {
+	call->iov_len = sizeof(call->tmp64);
 	afs_extract_begin(call, &call->tmp64, sizeof(call->tmp64));
 }
 
 static inline void afs_extract_discard(struct afs_call *call, size_t size)
 {
+	call->iov_len = size;
 	iov_iter_discard(&call->def_iter, READ, size);
 }
 
 static inline void afs_extract_to_buf(struct afs_call *call, size_t size)
 {
+	call->iov_len = size;
 	afs_extract_begin(call, call->buffer, size);
 }
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 8be709cb8542..0ec38b758f29 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -363,6 +363,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
+	size_t len;
 	s64 tx_total_len;
 	int ret;
 
@@ -466,9 +467,10 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 		rxrpc_kernel_abort_call(call->net->socket, rxcall,
 					RX_USER_ABORT, ret, "KSD");
 	} else {
+		len = 0;
 		iov_iter_kvec(&msg.msg_iter, READ, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
-				       &msg.msg_iter, false,
+				       &msg.msg_iter, &len, false,
 				       &call->abort_code, &call->service_id);
 		ac->abort_code = call->abort_code;
 		ac->responded = true;
@@ -504,6 +506,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 static void afs_deliver_to_call(struct afs_call *call)
 {
 	enum afs_call_state state;
+	size_t len;
 	u32 abort_code, remote_abort = 0;
 	int ret;
 
@@ -516,10 +519,11 @@ static void afs_deliver_to_call(struct afs_call *call)
 	       state == AFS_CALL_SV_AWAIT_ACK
 	       ) {
 		if (state == AFS_CALL_SV_AWAIT_ACK) {
+			len = 0;
 			iov_iter_kvec(&call->def_iter, READ, NULL, 0, 0);
 			ret = rxrpc_kernel_recv_data(call->net->socket,
 						     call->rxcall, &call->def_iter,
-						     false, &remote_abort,
+						     &len, false, &remote_abort,
 						     &call->service_id);
 			trace_afs_receive_data(call, &call->def_iter, false, ret);
 
@@ -929,10 +933,11 @@ int afs_extract_data(struct afs_call *call, bool want_more)
 	u32 remote_abort = 0;
 	int ret;
 
-	_enter("{%s,%zu},%d", call->type->name, iov_iter_count(iter), want_more);
+	_enter("{%s,%zu,%zu},%d",
+	       call->type->name, call->iov_len, iov_iter_count(iter), want_more);
 
 	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall, iter,
-				     want_more, &remote_abort,
+				     &call->iov_len, want_more, &remote_abort,
 				     &call->service_id);
 	if (ret == 0 || ret == -EAGAIN)
 		return ret;
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index bd787e71a657..6c45d32da13c 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -363,8 +363,9 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 	unsigned int size;
 	int ret;
 
-	_enter("{%u,%zu/%llu}",
-	       call->unmarshall, iov_iter_count(call->iter), req->actual_len);
+	_enter("{%u,%zu, %zu/%llu}",
+	       call->unmarshall, call->iov_len, iov_iter_count(call->iter),
+	       req->actual_len);
 
 	switch (call->unmarshall) {
 	case 0:
@@ -396,6 +397,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 			size = PAGE_SIZE - req->offset;
 		else
 			size = req->remain;
+		call->iov_len = size;
 		call->bvec[0].bv_len = size;
 		call->bvec[0].bv_offset = req->offset;
 		call->bvec[0].bv_page = req->pages[req->index];
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index f6abcc0bbd6e..cee5f83c0f11 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -53,7 +53,7 @@ int rxrpc_kernel_send_data(struct socket *, struct rxrpc_call *,
 			   struct msghdr *, size_t,
 			   rxrpc_notify_end_tx_t);
 int rxrpc_kernel_recv_data(struct socket *, struct rxrpc_call *,
-			   struct iov_iter *, bool, u32 *, u16 *);
+			   struct iov_iter *, size_t *, bool, u32 *, u16 *);
 bool rxrpc_kernel_abort_call(struct socket *, struct rxrpc_call *,
 			     u32, int, const char *);
 void rxrpc_kernel_end_call(struct socket *, struct rxrpc_call *);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index fef3573fdc8b..eca6dda26c77 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -669,6 +669,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * @sock: The socket that the call exists on
  * @call: The call to send data through
  * @iter: The buffer to receive into
+ * @_len: The amount of data we want to receive (decreased on return)
  * @want_more: True if more data is expected to be read
  * @_abort: Where the abort code is stored if -ECONNABORTED is returned
  * @_service: Where to store the actual service ID (may be upgraded)
@@ -684,7 +685,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * *_abort should also be initialised to 0.
  */
 int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
-			   struct iov_iter *iter,
+			   struct iov_iter *iter, size_t *_len,
 			   bool want_more, u32 *_abort, u16 *_service)
 {
 	size_t offset = 0;
@@ -692,7 +693,7 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 
 	_enter("{%d,%s},%zu,%d",
 	       call->debug_id, rxrpc_call_states[call->state],
-	       iov_iter_count(iter), want_more);
+	       *_len, want_more);
 
 	ASSERTCMP(call->state, !=, RXRPC_CALL_SERVER_SECURING);
 
@@ -703,8 +704,8 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 	case RXRPC_CALL_SERVER_RECV_REQUEST:
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
 		ret = rxrpc_recvmsg_data(sock, call, NULL, iter,
-					 iov_iter_count(iter), 0,
-					 &offset);
+					 *_len, 0, &offset);
+		*_len -= offset;
 		if (ret < 0)
 			goto out;
 


