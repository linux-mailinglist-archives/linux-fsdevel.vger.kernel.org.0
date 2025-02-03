Return-Path: <linux-fsdevel+bounces-40613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C951A25CD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0933AD18E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8D7210F58;
	Mon,  3 Feb 2025 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKUrsHp7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F27209671
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592766; cv=none; b=CU9WiUfDhhwq0wiAfOF7XPdVY1RFMTDWA0V5Yff+8dpv1QYMAOK9uAgxAqo6toQ1Sjvubd3PZYEg3vnUvcr3my8cl7e8RdZtGxNMyhButdoOS3b/J1TATL0wyezJ2pSxdp7bCdvn0ZwHUfyWOdfWRd0FXqlrvUEVe+G+RMLQMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592766; c=relaxed/simple;
	bh=UKySk4YA27Poc0tLF9Vyb39T5cmfO6KLXwgtPjnld00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey0wgQ6PujXcbkhnY27uL5EtHzuAVWl7bNjfDQwWbG7D3gn26M8buW+5oPlN88E1F1LPl524KsaIxdRCIMeJ105ZHx6/df6V8MlyKa8a+jh5BtKfSfodk1R5l8I3TUkUnsMBin0ADRWlCIeu0Ghmfx2QTyTml4Kcz4na7MlwXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKUrsHp7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6egcbc7oxooYiAxCZ3oV+a5mOmoFE2MFii5yBiZ6ZIs=;
	b=XKUrsHp73s7xLC/JzJDM0h57RkbF37d3Hc1GU3Ld3j65x/GO/cBzN7W5cNkU5w3Wzuo2rc
	YIttgqR9vK1tIBAhseGRWK0tzkVfwn4llIQHkTapcsnSb6+5okgBdtdkFJ8dbgIp/O+1z7
	3KrwrEvdVLuZiOwfTeeL1iOmHxaLNk8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-tYrD4rFLOiCi4zykTPj5AA-1; Mon,
 03 Feb 2025 09:25:56 -0500
X-MC-Unique: tYrD4rFLOiCi4zykTPj5AA-1
X-Mimecast-MFC-AGG-ID: tYrD4rFLOiCi4zykTPj5AA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08A9B1801F22;
	Mon,  3 Feb 2025 14:25:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AA8D19560AB;
	Mon,  3 Feb 2025 14:25:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 19/24] rxrpc: Pass CHALLENGE packets to the call for recvmsg() to respond to
Date: Mon,  3 Feb 2025 14:23:35 +0000
Message-ID: <20250203142343.248839-20-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Pass CHALLENGE packets to the receive queue of one of the calls on a
connection for recvmsg() to process rather than doing it behind the scenes
in a worker thread.

This will allow the application (AFS or userspace) to interact with the
process if it wants to and put values into user-defined fields.  This will
be used by AFS when talking to a fileserver to supply that fileserver with
a crypto key by which callback RPCs can be encrypted (ie. notifications
from the fileserver to the client).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 fs/afs/Makefile              |   1 +
 fs/afs/cm_security.c         |  47 ++++++
 fs/afs/internal.h            |   6 +
 fs/afs/rxrpc.c               |   5 +
 include/net/af_rxrpc.h       |  15 ++
 include/trace/events/rxrpc.h |   8 +-
 include/uapi/linux/rxrpc.h   |  46 ++++--
 net/rxrpc/af_rxrpc.c         |  25 +++-
 net/rxrpc/ar-internal.h      |  32 +++-
 net/rxrpc/call_object.c      |   5 +-
 net/rxrpc/conn_event.c       |  97 +++++++++++-
 net/rxrpc/conn_object.c      |   1 +
 net/rxrpc/insecure.c         |  13 +-
 net/rxrpc/io_thread.c        |   8 +-
 net/rxrpc/output.c           |  56 +++++++
 net/rxrpc/recvmsg.c          | 114 +++++++++++++-
 net/rxrpc/rxkad.c            | 281 +++++++++++++++++++++--------------
 net/rxrpc/sendmsg.c          |  69 ++++++++-
 net/rxrpc/server_key.c       |  40 +++++
 19 files changed, 722 insertions(+), 147 deletions(-)
 create mode 100644 fs/afs/cm_security.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 5efd7e13b304..b49b8fe682f3 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -8,6 +8,7 @@ kafs-y := \
 	addr_prefs.o \
 	callback.o \
 	cell.o \
+	cm_security.o \
 	cmservice.o \
 	dir.o \
 	dir_edit.o \
diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
new file mode 100644
index 000000000000..fbec18bc999e
--- /dev/null
+++ b/fs/afs/cm_security.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Cache manager security.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/slab.h>
+#include "internal.h"
+#include "afs_fs.h"
+#include "protocol_yfs.h"
+#define RXRPC_TRACE_ONLY_DEFINE_ENUMS
+#include <trace/events/rxrpc.h>
+
+/*
+ * Respond to an RxGK challenge, adding appdata.
+ */
+int afs_respond_to_challenge(struct rxrpc_call *rxcall, unsigned long user_call_ID,
+			     u16 service_id, u8 security_index)
+{
+	_enter("%u,%u", service_id, security_index);
+
+	switch (service_id) {
+		/* We don't send CM_SERVICE RPCs, so don't expect a challenge
+		 * therefrom.
+		 */
+	case FS_SERVICE:
+	case VL_SERVICE:
+	case YFS_FS_SERVICE:
+	case YFS_VL_SERVICE:
+		break;
+	default:
+		pr_warn("Can't respond to unknown challenge %u:%u",
+			service_id, security_index);
+		return rxrpc_kernel_reject_challenge(rxcall, RX_USER_ABORT, -EPROTO,
+						     afs_abort_unsupported_sec_class);
+	}
+
+	switch (security_index) {
+	case RXRPC_SECURITY_RXKAD:
+		return rxkad_kernel_respond_to_challenge(rxcall);
+
+	default:
+		return rxrpc_kernel_reject_challenge(rxcall, RX_USER_ABORT, -EPROTO,
+						     afs_abort_unsupported_sec_class);
+	}
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 90f407774a9a..018e83dd7afe 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1061,6 +1061,12 @@ extern void __net_exit afs_cell_purge(struct afs_net *);
  */
 extern bool afs_cm_incoming_call(struct afs_call *);
 
+/*
+ * cm_security.c
+ */
+int afs_respond_to_challenge(struct rxrpc_call *rxcall, unsigned long user_call_ID,
+			     u16 service_id, u8 security_index);
+
 /*
  * dir.c
  */
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index be914ecdc162..21a028c21070 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -31,6 +31,7 @@ static const struct rxrpc_kernel_ops afs_rxrpc_callback_ops = {
 	.notify_new_call	= afs_rx_new_call,
 	.discard_new_call	= afs_rx_discard_new_call,
 	.user_attach_call	= afs_rx_attach,
+	.respond_to_challenge	= afs_respond_to_challenge,
 };
 
 /* asynchronous incoming call initial processing */
@@ -71,6 +72,10 @@ int afs_open_socket(struct afs_net *net)
 	if (ret < 0)
 		goto error_2;
 
+	ret = rxrpc_sock_set_manage_response(socket->sk, true);
+	if (ret < 0)
+		goto error_2;
+
 	ret = kernel_bind(socket, (struct sockaddr *) &srx, sizeof(srx));
 	if (ret == -EADDRINUSE) {
 		srx.transport.sin6.sin6_port = 0;
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 7ea24aef0ac6..1fd6ab0fca6d 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -16,6 +16,7 @@ struct sock;
 struct socket;
 struct rxrpc_call;
 struct rxrpc_peer;
+struct krb5_buffer;
 enum rxrpc_abort_reason;
 
 enum rxrpc_interruptibility {
@@ -37,6 +38,14 @@ struct rxrpc_kernel_ops {
 				unsigned long user_call_ID);
 	void (*discard_new_call)(struct rxrpc_call *call, unsigned long user_call_ID);
 	void (*user_attach_call)(struct rxrpc_call *call, unsigned long user_call_ID);
+	int (*respond_to_challenge)(struct rxrpc_call *call, unsigned long user_call_ID,
+				    u16 service_id, u8 security_index);
+	ssize_t (*rxgk_get_appdata)(struct rxrpc_call *call, unsigned long user_call_ID,
+				    u16 service_id, u8 security_index, u32 enctype,
+				    void *buffer, size_t bufsize);
+	int (*rxgk_check_appdata)(struct rxrpc_call *call, unsigned long user_call_ID,
+				  u16 service_id, u8 security_index, u32 enctype,
+				  const void *buffer, size_t bufsize);
 };
 
 typedef void (*rxrpc_notify_rx_t)(struct sock *, struct rxrpc_call *,
@@ -85,5 +94,11 @@ void rxrpc_kernel_set_max_life(struct socket *, struct rxrpc_call *,
 
 int rxrpc_sock_set_min_security_level(struct sock *sk, unsigned int val);
 int rxrpc_sock_set_security_keyring(struct sock *, struct key *);
+int rxrpc_sock_set_manage_response(struct sock *sk, bool set);
+
+int rxrpc_kernel_reject_challenge(struct rxrpc_call *call, u32 abort_code, int error,
+				  enum rxrpc_abort_reason why);
+int rxkad_kernel_respond_to_challenge(struct rxrpc_call *call);
+int rxgk_kernel_respond_to_challenge(struct rxrpc_call *call, struct krb5_buffer *appdata);
 
 #endif /* _NET_RXRPC_H */
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index cad50d91077e..109eb5898a63 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -25,6 +25,7 @@
 	EM(afs_abort_probeuuid_negative,	"afs-probeuuid-neg")	\
 	EM(afs_abort_send_data_error,		"afs-send-data")	\
 	EM(afs_abort_unmarshal_error,		"afs-unmarshal")	\
+	EM(afs_abort_unsupported_sec_class,	"afs-unsup-sec-class")	\
 	/* rxperf errors */						\
 	EM(rxperf_abort_general_error,		"rxperf-error")		\
 	EM(rxperf_abort_oom,			"rxperf-oom")		\
@@ -77,6 +78,7 @@
 	EM(rxrpc_abort_call_timeout,		"call-timeout")		\
 	EM(rxrpc_abort_no_service_key,		"no-serv-key")		\
 	EM(rxrpc_abort_nomem,			"nomem")		\
+	EM(rxrpc_abort_response_sendmsg,	"resp-sendmsg")		\
 	EM(rxrpc_abort_service_not_offered,	"serv-not-offered")	\
 	EM(rxrpc_abort_shut_down,		"shut-down")		\
 	EM(rxrpc_abort_unsupported_security,	"unsup-sec")		\
@@ -133,6 +135,7 @@
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
 	EM(rxrpc_skb_get_local_work,		"GET locl-work") \
+	EM(rxrpc_skb_get_post_challenge,	"GET post-chal") \
 	EM(rxrpc_skb_get_reject_work,		"GET rej-work ") \
 	EM(rxrpc_skb_get_to_recvmsg,		"GET to-recv  ") \
 	EM(rxrpc_skb_get_to_recvmsg_oos,	"GET to-recv-o") \
@@ -141,12 +144,14 @@
 	EM(rxrpc_skb_new_jumbo_subpacket,	"NEW jumbo-sub") \
 	EM(rxrpc_skb_new_unshared,		"NEW unshared ") \
 	EM(rxrpc_skb_put_call_rx,		"PUT call-rx  ") \
+	EM(rxrpc_skb_put_challenge,		"PUT challenge") \
 	EM(rxrpc_skb_put_conn_secured,		"PUT conn-secd") \
 	EM(rxrpc_skb_put_conn_work,		"PUT conn-work") \
 	EM(rxrpc_skb_put_error_report,		"PUT error-rep") \
 	EM(rxrpc_skb_put_input,			"PUT input    ") \
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
+	EM(rxrpc_skb_put_response,		"PUT response ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
 	EM(rxrpc_skb_see_conn_work,		"SEE conn-work") \
@@ -219,6 +224,7 @@
 	EM(rxrpc_conn_get_conn_input,		"GET inp-conn") \
 	EM(rxrpc_conn_get_idle,			"GET idle    ") \
 	EM(rxrpc_conn_get_poke_abort,		"GET pk-abort") \
+	EM(rxrpc_conn_get_poke_response,	"GET response") \
 	EM(rxrpc_conn_get_poke_secured,		"GET secured ") \
 	EM(rxrpc_conn_get_poke_timer,		"GET poke    ") \
 	EM(rxrpc_conn_get_service_conn,		"GET svc-conn") \
@@ -456,7 +462,7 @@
 	EM(rxrpc_tx_point_conn_abort,		"ConnAbort") \
 	EM(rxrpc_tx_point_reject,		"Reject") \
 	EM(rxrpc_tx_point_rxkad_challenge,	"RxkadChall") \
-	EM(rxrpc_tx_point_rxkad_response,	"RxkadResp") \
+	EM(rxrpc_tx_point_response,		"Response") \
 	EM(rxrpc_tx_point_version_keepalive,	"VerKeepalive") \
 	E_(rxrpc_tx_point_version_reply,	"VerReply")
 
diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
index 8f8dc7a937a4..eac460d37598 100644
--- a/include/uapi/linux/rxrpc.h
+++ b/include/uapi/linux/rxrpc.h
@@ -36,26 +36,33 @@ struct sockaddr_rxrpc {
 #define RXRPC_MIN_SECURITY_LEVEL	4	/* minimum security level */
 #define RXRPC_UPGRADEABLE_SERVICE	5	/* Upgrade service[0] -> service[1] */
 #define RXRPC_SUPPORTED_CMSG		6	/* Get highest supported control message type */
+#define RXRPC_MANAGE_RESPONSE		7	/* [clnt] Want to manage RESPONSE packets */
 
 /*
  * RxRPC control messages
  * - If neither abort or accept are specified, the message is a data message.
  * - terminal messages mean that a user call ID tag can be recycled
+ * - C/S/- indicate whether these are applicable to client, server or both
  * - s/r/- indicate whether these are applicable to sendmsg() and/or recvmsg()
  */
 enum rxrpc_cmsg_type {
-	RXRPC_USER_CALL_ID	= 1,	/* sr: user call ID specifier */
-	RXRPC_ABORT		= 2,	/* sr: abort request / notification [terminal] */
-	RXRPC_ACK		= 3,	/* -r: [Service] RPC op final ACK received [terminal] */
-	RXRPC_NET_ERROR		= 5,	/* -r: network error received [terminal] */
-	RXRPC_BUSY		= 6,	/* -r: server busy received [terminal] */
-	RXRPC_LOCAL_ERROR	= 7,	/* -r: local error generated [terminal] */
-	RXRPC_NEW_CALL		= 8,	/* -r: [Service] new incoming call notification */
-	RXRPC_EXCLUSIVE_CALL	= 10,	/* s-: Call should be on exclusive connection */
-	RXRPC_UPGRADE_SERVICE	= 11,	/* s-: Request service upgrade for client call */
-	RXRPC_TX_LENGTH		= 12,	/* s-: Total length of Tx data */
-	RXRPC_SET_CALL_TIMEOUT	= 13,	/* s-: Set one or more call timeouts */
-	RXRPC_CHARGE_ACCEPT	= 14,	/* s-: Charge the accept pool with a user call ID */
+	RXRPC_USER_CALL_ID	= 1,	/* -sr: User call ID specifier */
+	RXRPC_ABORT		= 2,	/* -sr: Abort request / notification [terminal] */
+	RXRPC_ACK		= 3,	/* S-r: RPC op final ACK received [terminal] */
+	RXRPC_NET_ERROR		= 5,	/* --r: Network error received [terminal] */
+	RXRPC_BUSY		= 6,	/* C-r: Server busy received [terminal] */
+	RXRPC_LOCAL_ERROR	= 7,	/* --r: Local error generated [terminal] */
+	RXRPC_NEW_CALL		= 8,	/* S-r: New incoming call notification */
+	RXRPC_EXCLUSIVE_CALL	= 10,	/* Cs-: Call should be on exclusive connection */
+	RXRPC_UPGRADE_SERVICE	= 11,	/* Cs-: Request service upgrade for client call */
+	RXRPC_TX_LENGTH		= 12,	/* -s-: Total length of Tx data */
+	RXRPC_SET_CALL_TIMEOUT	= 13,	/* -s-: Set one or more call timeouts */
+	RXRPC_CHARGE_ACCEPT	= 14,	/* Ss-: Charge the accept pool with a user call ID */
+	RXRPC_CHALLENGED	= 15,	/* C-r: Info on a received CHALLENGE */
+	RXRPC_RESPOND		= 16,	/* Cs-: Respond to a challenge */
+	RXRPC_RESPOND_ABORT	= 17,	/* Cs-: Abort in response to a challenge */
+	RXRPC_RESPONDED		= 18,	/* S-r: Data received in RESPONSE */
+	RXRPC_RESP_RXGK_APPDATA	= 19,	/* Cs-: RESPONSE: RxGK app data to include */
 	RXRPC__SUPPORTED
 };
 
@@ -118,4 +125,19 @@ enum rxrpc_cmsg_type {
 #define RXKADDATALEN		19270411	/* user data too long */
 #define RXKADILLEGALLEVEL	19270412	/* caller not authorised to use encrypted conns */
 
+/*
+ * Challenge information in the RXRPC_CHALLENGED control message.
+ */
+struct rxrpc_challenge {
+	__u16		service_id;	/* The service ID of the connection (may be upgraded) */
+	__u8		security_index;	/* The security index of the connection */
+	__u8		pad;		/* Round out to a multiple of 4 bytes. */
+	/* ... The security class gets to append extra information ... */
+};
+
+struct rxgk_challenge {
+	struct rxrpc_challenge	base;
+	__u32			enctype;	/* Krb5 encoding type */
+};
+
 #endif /* _UAPI_LINUX_RXRPC_H */
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 70467bbda4af..c4404d3068f3 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -445,7 +445,8 @@ bool rxrpc_kernel_check_life(const struct socket *sock,
 		return true;
 	if (call->completion != RXRPC_CALL_SUCCEEDED)
 		return false;
-	return !skb_queue_empty(&call->recvmsg_queue);
+	return (!skb_queue_empty(&call->recvmsg_queue) ||
+		!skb_queue_empty(&call->recvmsg_oobq));
 }
 EXPORT_SYMBOL(rxrpc_kernel_check_life);
 
@@ -655,7 +656,7 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
 	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	unsigned int min_sec_level;
+	unsigned int min_sec_level, val;
 	u16 service_upgrade[2];
 	int ret;
 
@@ -736,6 +737,26 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 			rx->service_upgrade.to = service_upgrade[1];
 			goto success;
 
+		case RXRPC_MANAGE_RESPONSE:
+			ret = -EINVAL;
+			if (optlen != sizeof(unsigned int))
+				goto error;
+			ret = -EISCONN;
+			if (rx->sk.sk_state != RXRPC_UNBOUND)
+				goto error;
+			ret = copy_safe_from_sockptr(&val, sizeof(val),
+						     optval, optlen);
+			if (ret)
+				goto error;
+			ret = -EINVAL;
+			if (val > 1)
+				goto error;
+			if (val)
+				set_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+			else
+				clear_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+			goto success;
+
 		default:
 			break;
 		}
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 8ab34ef9dbcb..caf448fe77d4 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -159,6 +159,7 @@ struct rxrpc_sock {
 	struct rb_root		calls;		/* User ID -> call mapping */
 	unsigned long		flags;
 #define RXRPC_SOCK_CONNECTED		0	/* connect_srx is set */
+#define RXRPC_SOCK_MANAGE_RESPONSE	1	/* User wants to manage RESPONSE packets */
 	rwlock_t		call_lock;	/* lock for calls */
 	u32			min_sec_level;	/* minimum security level */
 #define RXRPC_SECURITY_MAX	RXRPC_SECURITY_ENCRYPT
@@ -216,6 +217,11 @@ struct rxrpc_skb_priv {
 			u16		nr_acks;	/* Number of acks+nacks */
 			u8		reason;		/* Reason for ack */
 		} ack;
+		u32 rxkad_nonce;
+		struct {
+			rxrpc_serial_t	challenge_serial;
+			u16		len;
+		} resp;
 	};
 	struct rxrpc_host_header hdr;	/* RxRPC packet header from this packet */
 };
@@ -269,9 +275,24 @@ struct rxrpc_security {
 	/* issue a challenge */
 	int (*issue_challenge)(struct rxrpc_connection *);
 
+	/* Validate a challenge packet */
+	bool (*validate_challenge)(struct rxrpc_connection *conn,
+				   struct sk_buff *skb);
+
+	/* Fill out the cmsg for recvmsg() to pass on a challenge to userspace.
+	 * The security class gets to add additional information.
+	 */
+	int (*challenge_to_recvmsg)(struct rxrpc_connection *conn,
+				    struct sk_buff *challenge,
+				    struct msghdr *msg);
+
+	/* Parse sendmsg() control message and respond to challenge. */
+	int (*sendmsg_respond_to_challenge)(struct rxrpc_call *call,
+					    struct msghdr *msg);
+
 	/* respond to a challenge */
-	int (*respond_to_challenge)(struct rxrpc_connection *,
-				    struct sk_buff *);
+	int (*respond_to_challenge)(struct rxrpc_connection *conn,
+				    struct sk_buff *challenge);
 
 	/* verify a response */
 	int (*verify_response)(struct rxrpc_connection *,
@@ -526,6 +547,7 @@ struct rxrpc_connection {
 			u32	nonce;		/* response re-use preventer */
 		} rxkad;
 	};
+	struct sk_buff		*tx_response;	/* Response packet to be transmitted */
 	unsigned long		flags;
 	unsigned long		events;
 	unsigned long		idle_timestamp;	/* Time at which last became idle */
@@ -670,6 +692,7 @@ struct rxrpc_call {
 	struct list_head	sock_link;	/* Link in rx->sock_calls */
 	struct rb_node		sock_node;	/* Node in rx->calls */
 	struct list_head	attend_link;	/* Link in local->call_attend_q */
+	struct sk_buff		*challenge;	/* Pending challenge to respond to */
 	struct rxrpc_txbuf	*tx_pending;	/* Tx buffer being filled */
 	wait_queue_head_t	waitq;		/* Wait queue for channel or Tx */
 	s64			tx_total_len;	/* Total length left to be transmitted (or -1) */
@@ -718,6 +741,7 @@ struct rxrpc_call {
 
 	/* Received data tracking */
 	struct sk_buff_head	recvmsg_queue;	/* Queue of packets ready for recvmsg() */
+	struct sk_buff_head	recvmsg_oobq;	/* Queue of OOB packets ready for recvmsg() */
 	struct sk_buff_head	rx_queue;	/* Queue of packets for this call to receive */
 	struct sk_buff_head	rx_oos_queue;	/* Queue of out of sequence packets */
 
@@ -831,6 +855,8 @@ enum rxrpc_command {
 	RXRPC_CMD_SEND_ABORT,		/* request abort generation */
 	RXRPC_CMD_REJECT_BUSY,		/* [server] reject a call as busy */
 	RXRPC_CMD_CHARGE_ACCEPT,	/* [server] charge accept preallocation */
+	RXRPC_CMD_SEND_RESPONSE,	/* [clnt] Send a RESPONSE packet to a challenge */
+	RXRPC_CMD_ABORT_RESPONSE,	/* [clnt] Send an ABORT packet to a challenge */
 };
 
 struct rxrpc_call_params {
@@ -1198,6 +1224,7 @@ void rxrpc_error_report(struct sock *);
 bool rxrpc_direct_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
 			s32 abort_code, int err);
 int rxrpc_io_thread(void *data);
+void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb);
 static inline void rxrpc_wake_up_io_thread(struct rxrpc_local *local)
 {
 	wake_up_process(READ_ONCE(local->io_thread));
@@ -1299,6 +1326,7 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req
 void rxrpc_send_conn_abort(struct rxrpc_connection *conn);
 void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb);
 void rxrpc_send_keepalive(struct rxrpc_peer *);
+void rxrpc_send_response(struct rxrpc_connection *conn, struct sk_buff *skb);
 
 /*
  * peer_event.c
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index c4c8b46a68c6..4535da8cf664 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -145,8 +145,9 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	INIT_LIST_HEAD(&call->recvmsg_link);
 	INIT_LIST_HEAD(&call->sock_link);
 	INIT_LIST_HEAD(&call->attend_link);
-	skb_queue_head_init(&call->rx_queue);
 	skb_queue_head_init(&call->recvmsg_queue);
+	skb_queue_head_init(&call->recvmsg_oobq);
+	skb_queue_head_init(&call->rx_queue);
 	skb_queue_head_init(&call->rx_oos_queue);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->notify_lock);
@@ -551,6 +552,7 @@ static void rxrpc_cleanup_tx_buffers(struct rxrpc_call *call)
 static void rxrpc_cleanup_rx_buffers(struct rxrpc_call *call)
 {
 	rxrpc_purge_queue(&call->recvmsg_queue);
+	rxrpc_purge_queue(&call->recvmsg_oobq);
 	rxrpc_purge_queue(&call->rx_queue);
 	rxrpc_purge_queue(&call->rx_oos_queue);
 }
@@ -692,6 +694,7 @@ static void rxrpc_destroy_call(struct work_struct *work)
 
 	rxrpc_cleanup_tx_buffers(call);
 	rxrpc_cleanup_rx_buffers(call);
+	rxrpc_free_skb(call->challenge, rxrpc_skb_put_challenge);
 	rxrpc_put_txbuf(call->tx_pending, rxrpc_txbuf_put_cleaned);
 	rxrpc_put_connection(call->conn, rxrpc_conn_put_call);
 	rxrpc_deactivate_bundle(call->bundle);
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 4d9c5e21ba78..329c10564ba9 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -19,7 +19,7 @@
 /*
  * Set the completion state on an aborted connection.
  */
-static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn, struct sk_buff *skb,
+static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn,
 				   s32 abort_code, int err,
 				   enum rxrpc_call_completion compl)
 {
@@ -49,12 +49,20 @@ static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn, struct sk_buff
 int rxrpc_abort_conn(struct rxrpc_connection *conn, struct sk_buff *skb,
 		     s32 abort_code, int err, enum rxrpc_abort_reason why)
 {
-	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 
-	if (rxrpc_set_conn_aborted(conn, skb, abort_code, err,
+	u32 cid = conn->proto.cid, call = 0, seq = 0;
+
+	if (skb) {
+		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+		cid  = sp->hdr.cid;
+		call = sp->hdr.callNumber;
+		seq  = sp->hdr.seq;
+	}
+
+	if (rxrpc_set_conn_aborted(conn, abort_code, err,
 				   RXRPC_CALL_LOCALLY_ABORTED)) {
-		trace_rxrpc_abort(0, why, sp->hdr.cid, sp->hdr.callNumber,
-				  sp->hdr.seq, abort_code, err);
+		trace_rxrpc_abort(0, why, cid, call, seq, abort_code, err);
 		rxrpc_poke_conn(conn, rxrpc_conn_get_poke_abort);
 	}
 	return -EPROTO;
@@ -67,7 +75,7 @@ static void rxrpc_input_conn_abort(struct rxrpc_connection *conn,
 				   struct sk_buff *skb)
 {
 	trace_rxrpc_rx_conn_abort(conn, skb);
-	rxrpc_set_conn_aborted(conn, skb, skb->priority, -ECONNABORTED,
+	rxrpc_set_conn_aborted(conn, skb->priority, -ECONNABORTED,
 			       RXRPC_CALL_REMOTELY_ABORTED);
 }
 
@@ -391,6 +399,33 @@ static void rxrpc_post_packet_to_conn(struct rxrpc_connection *conn,
 	rxrpc_queue_conn(conn, rxrpc_conn_queue_rx_work);
 }
 
+/*
+ * Post a CHALLENGE packet to one of a connection's calls so that it can get
+ * application data to include in the packet, possibly querying userspace.
+ */
+static bool rxrpc_post_challenge_to_call(struct rxrpc_connection *conn,
+					 struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	struct rxrpc_call *call = NULL;
+
+	for (int i = 0; i < ARRAY_SIZE(conn->channels); i++) {
+		if (conn->channels[i].call) {
+			call = conn->channels[i].call;
+			break;
+		}
+	}
+
+	if (!call)
+		return false;
+
+	rxrpc_get_skb(skb, rxrpc_skb_get_post_challenge);
+	skb_queue_tail(&call->recvmsg_oobq, skb);
+	trace_rxrpc_notify_socket(call->debug_id, sp->hdr.serial);
+	rxrpc_notify_socket(call);
+	return true;
+}
+
 /*
  * Input a connection-level packet.
  */
@@ -411,6 +446,15 @@ bool rxrpc_input_conn_packet(struct rxrpc_connection *conn, struct sk_buff *skb)
 		return true;
 
 	case RXRPC_PACKET_TYPE_CHALLENGE:
+		if (rxrpc_is_conn_aborted(conn)) {
+			if (conn->completion == RXRPC_CALL_LOCALLY_ABORTED)
+				rxrpc_send_conn_abort(conn);
+			return true;
+		}
+		if (!conn->security->validate_challenge(conn, skb))
+			return false;
+		return rxrpc_post_challenge_to_call(conn, skb);
+
 	case RXRPC_PACKET_TYPE_RESPONSE:
 		if (rxrpc_is_conn_aborted(conn)) {
 			if (conn->completion == RXRPC_CALL_LOCALLY_ABORTED)
@@ -436,6 +480,19 @@ void rxrpc_input_conn_event(struct rxrpc_connection *conn, struct sk_buff *skb)
 	if (test_and_clear_bit(RXRPC_CONN_EV_ABORT_CALLS, &conn->events))
 		rxrpc_abort_calls(conn);
 
+	if (conn->tx_response) {
+		struct sk_buff *skb;
+
+		spin_lock_irq(&conn->local->lock);
+		skb = conn->tx_response;
+		conn->tx_response = NULL;
+		spin_unlock_irq(&conn->local->lock);
+
+		if (conn->state != RXRPC_CONN_ABORTED)
+			rxrpc_send_response(conn, skb);
+		rxrpc_free_skb(skb, rxrpc_skb_put_response);
+	}
+
 	if (skb) {
 		switch (skb->mark) {
 		case RXRPC_SKB_MARK_SERVICE_CONN_SECURED:
@@ -452,3 +509,31 @@ void rxrpc_input_conn_event(struct rxrpc_connection *conn, struct sk_buff *skb)
 	if (conn->flags & RXRPC_CONN_FINAL_ACK_MASK)
 		rxrpc_process_delayed_final_acks(conn, false);
 }
+
+/*
+ * Post a RESPONSE message to the I/O thread for transmission.
+ */
+void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	struct rxrpc_local *local = conn->local;
+	struct sk_buff *old;
+
+	_enter("%x", sp->resp.challenge_serial);
+
+	spin_lock_irq(&local->lock);
+	old = conn->tx_response;
+	if (old) {
+		struct rxrpc_skb_priv *osp = rxrpc_skb(skb);
+
+		/* Always go with the response to the most recent challenge. */
+		if (after(sp->resp.challenge_serial, osp->resp.challenge_serial))
+			conn->tx_response = old;
+		else
+			old = skb;
+	} else {
+		conn->tx_response = skb;
+	}
+	spin_unlock_irq(&local->lock);
+	rxrpc_poke_conn(conn, rxrpc_conn_get_poke_response);
+}
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 2f1fd1e2e7e4..f1e36cba9f4c 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -329,6 +329,7 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	}
 
 	rxrpc_purge_queue(&conn->rx_queue);
+	rxrpc_free_skb(conn->tx_response, rxrpc_skb_put_response);
 
 	rxrpc_kill_client_conn(conn);
 
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index e068f9b79d02..2b35e6e91c6f 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -42,13 +42,19 @@ static void none_free_call_crypto(struct rxrpc_call *call)
 {
 }
 
-static int none_respond_to_challenge(struct rxrpc_connection *conn,
-				     struct sk_buff *skb)
+static bool none_validate_challenge(struct rxrpc_connection *conn,
+				    struct sk_buff *skb)
 {
 	return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
 				rxrpc_eproto_rxnull_challenge);
 }
 
+static int none_sendmsg_respond_to_challenge(struct rxrpc_call *call,
+					     struct msghdr *msg)
+{
+	return -EINVAL;
+}
+
 static int none_verify_response(struct rxrpc_connection *conn,
 				struct sk_buff *skb)
 {
@@ -82,7 +88,8 @@ const struct rxrpc_security rxrpc_no_security = {
 	.alloc_txbuf			= none_alloc_txbuf,
 	.secure_packet			= none_secure_packet,
 	.verify_packet			= none_verify_packet,
-	.respond_to_challenge		= none_respond_to_challenge,
+	.validate_challenge		= none_validate_challenge,
+	.sendmsg_respond_to_challenge	= none_sendmsg_respond_to_challenge,
 	.verify_response		= none_verify_response,
 	.clear				= none_clear,
 };
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 64f8d77b8731..67b23f6172fd 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -501,9 +501,11 @@ int rxrpc_io_thread(void *data)
 		}
 
 		/* Deal with connections that want immediate attention. */
-		spin_lock_irq(&local->lock);
-		list_splice_tail_init(&local->conn_attend_q, &conn_attend_q);
-		spin_unlock_irq(&local->lock);
+		if (!list_empty_careful(&local->conn_attend_q)) {
+			spin_lock_irq(&local->lock);
+			list_splice_tail_init(&local->conn_attend_q, &conn_attend_q);
+			spin_unlock_irq(&local->lock);
+		}
 
 		while ((conn = list_first_entry_or_null(&conn_attend_q,
 							struct rxrpc_connection,
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 6f7a125d6e90..8207b87ea836 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -896,3 +896,59 @@ void rxrpc_send_keepalive(struct rxrpc_peer *peer)
 	peer->last_tx_at = ktime_get_seconds();
 	_leave("");
 }
+
+/*
+ * Send a RESPONSE message.
+ */
+void rxrpc_send_response(struct rxrpc_connection *conn, struct sk_buff *response)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(response);
+	struct scatterlist sg[16];
+	struct bio_vec bvec[16];
+	struct msghdr msg;
+	size_t len = sp->resp.len;
+	__be32 wserial;
+	u32 serial = 0;
+	int ret, nr_sg;
+
+	_enter("C=%x,%x", conn->debug_id, sp->resp.challenge_serial);
+
+	sg_init_table(sg, ARRAY_SIZE(sg));
+	ret = skb_to_sgvec(response, sg, 0, len);
+	if (ret < 0)
+		goto fail;
+	nr_sg = ret;
+
+	for (int i = 0; i < nr_sg; i++)
+		bvec_set_page(&bvec[i], sg_page(&sg[i]), sg[i].length, sg[i].offset);
+
+	iov_iter_bvec(&msg.msg_iter, WRITE, bvec, nr_sg, len);
+
+	msg.msg_name	= &conn->peer->srx.transport;
+	msg.msg_namelen	= conn->peer->srx.transport_len;
+	msg.msg_control	= NULL;
+	msg.msg_controllen = 0;
+	msg.msg_flags	= MSG_SPLICE_PAGES;
+
+	serial = rxrpc_get_next_serials(conn, 1);
+	wserial = htonl(serial);
+
+	ret = skb_store_bits(response, offsetof(struct rxrpc_wire_header, serial),
+			     &wserial, sizeof(wserial));
+	if (ret < 0)
+		goto fail;
+
+	rxrpc_local_dont_fragment(conn->local, false);
+
+	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
+	if (ret < 0)
+		goto fail;
+
+	conn->peer->last_tx_at = ktime_get_seconds();
+	return;
+
+fail:
+	trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
+			    rxrpc_tx_point_response);
+	kleave(" = %d", ret);
+}
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 32cd5f1d541d..508ba7e057e9 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -154,6 +154,97 @@ static int rxrpc_verify_data(struct rxrpc_call *call, struct sk_buff *skb)
 	return call->security->verify_packet(call, skb);
 }
 
+/*
+ * Deal with a CHALLENGE packet.
+ */
+static int rxrpc_recvmsg_challenge(struct socket *sock, struct rxrpc_call *call,
+				   struct msghdr *msg, struct sk_buff *challenge)
+{
+	struct rxrpc_connection *conn = call->conn;
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
+	int ret;
+
+	rxrpc_free_skb(call->challenge, rxrpc_skb_put_challenge);
+	call->challenge = challenge;
+
+	if (!test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags)) {
+		ret = conn->security->respond_to_challenge(conn, challenge);
+		goto out;
+	}
+
+	if (rx->app_ops) {
+		ret = rx->app_ops->respond_to_challenge(call, call->user_call_ID,
+							call->conn->service_id,
+							call->security_ix);
+		goto out;
+	}
+
+	ret = conn->security->challenge_to_recvmsg(conn, challenge, msg);
+	return ret;
+out:
+	call->challenge = NULL;
+	rxrpc_free_skb(challenge, rxrpc_skb_put_challenge);
+	return ret;
+}
+
+/*
+ * Merely peek at a challenge packet.  This doesn't make it respondable to.
+ */
+static int rxrpc_recvmsg_peek_challenge(struct socket *sock, struct rxrpc_call *call,
+					struct msghdr *msg, struct sk_buff *challenge)
+{
+	struct rxrpc_connection *conn = call->conn;
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
+
+	if (WARN_ON_ONCE(rx->app_ops))
+		return -EIO; /* The kernel isn't allowed to do this. */
+	return conn->security->challenge_to_recvmsg(conn, challenge, msg);
+}
+
+/*
+ * Process OOB packets.
+ */
+static int rxrpc_recvmsg_oob(struct socket *sock, struct rxrpc_call *call,
+			     struct msghdr *msg, unsigned int flags)
+{
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
+	struct sk_buff *skb;
+	int ret = -EAGAIN, ret2;
+
+	while ((skb = skb_peek(&call->recvmsg_oobq))) {
+		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+		rxrpc_see_skb(skb, rxrpc_skb_see_recvmsg);
+
+		if (sp->hdr.type == RXRPC_PACKET_TYPE_CHALLENGE) {
+			/* Only expose response packets to the application
+			 * layer if they ask for it.
+			 */
+			if (unlikely(flags & MSG_PEEK) &&
+			    test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags)) {
+				ret2 = rxrpc_recvmsg_peek_challenge(sock, call, msg, skb);
+				break;
+			}
+
+			skb_unlink(skb, &call->recvmsg_queue);
+
+			ret2 = rxrpc_recvmsg_challenge(sock, call, msg, skb);
+
+			/* We only let on about errors to the app layer if
+			 * they're interested in managing the response.
+			 */
+			if (test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags) &&
+			    !rx->app_ops) {
+				if (ret2 < 0)
+					ret = ret2;
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 /*
  * Deliver messages to a call.  This keeps processing packets until the buffer
  * is filled and we find either more DATA (returns 0) or the end of the DATA
@@ -171,6 +262,7 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 	unsigned int rx_pkt_offset, rx_pkt_len;
 	int copy, ret = -EAGAIN, ret2;
 
+again:
 	rx_pkt_offset = call->rx_pkt_offset;
 	rx_pkt_len = call->rx_pkt_len;
 
@@ -190,7 +282,7 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 	 * need the Rx lock to walk it.
 	 */
 	skb = skb_peek(&call->recvmsg_queue);
-	while (skb) {
+	while (skb && skb_queue_empty_lockless(&call->recvmsg_oobq)) {
 		rxrpc_see_skb(skb, rxrpc_skb_see_recvmsg);
 		sp = rxrpc_skb(skb);
 		seq = sp->hdr.seq;
@@ -207,7 +299,6 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 			trace_rxrpc_recvdata(call, rxrpc_recvmsg_next, seq,
 					     sp->offset, sp->len, ret2);
 			if (ret2 < 0) {
-				kdebug("verify = %d", ret2);
 				ret = ret2;
 				goto out;
 			}
@@ -262,6 +353,15 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 		call->rx_pkt_offset = rx_pkt_offset;
 		call->rx_pkt_len = rx_pkt_len;
 	}
+
+	if (ret == -EAGAIN &&
+	    *_offset == 0 &&
+	    !skb_queue_empty_lockless(&call->recvmsg_oobq)) {
+		ret = rxrpc_recvmsg_oob(sock, call, msg, flags);
+		if (ret == -EAGAIN)
+			goto again;
+	}
+
 done:
 	trace_rxrpc_recvdata(call, rxrpc_recvmsg_data_return, seq,
 			     rx_pkt_offset, rx_pkt_len, ret);
@@ -342,7 +442,8 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	call = list_entry(l, struct rxrpc_call, recvmsg_link);
 
 	if (!rxrpc_call_is_complete(call) &&
-	    skb_queue_empty(&call->recvmsg_queue)) {
+	    skb_queue_empty(&call->recvmsg_queue) &&
+	    skb_queue_empty(&call->recvmsg_oobq)) {
 		list_del_init(&call->recvmsg_link);
 		spin_unlock_irq(&rx->recvmsg_lock);
 		release_sock(&rx->sk);
@@ -410,17 +511,20 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		goto error_unlock_call;
 
 	if (rxrpc_call_is_complete(call) &&
-	    skb_queue_empty(&call->recvmsg_queue))
+	    skb_queue_empty(&call->recvmsg_queue) &&
+	    skb_queue_empty(&call->recvmsg_oobq))
 		goto call_complete;
 	if (rxrpc_call_has_failed(call))
 		goto call_failed;
 
-	if (!skb_queue_empty(&call->recvmsg_queue))
+	if (!skb_queue_empty(&call->recvmsg_queue) ||
+	    !skb_queue_empty(&call->recvmsg_oobq))
 		rxrpc_notify_socket(call);
 	goto not_yet_complete;
 
 call_failed:
 	rxrpc_purge_queue(&call->recvmsg_queue);
+	rxrpc_purge_queue(&call->recvmsg_oobq);
 call_complete:
 	ret = rxrpc_recvmsg_term(call, msg);
 	if (ret < 0)
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 62b09d23ec08..300b0138e49e 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -700,62 +700,6 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 	return 0;
 }
 
-/*
- * send a Kerberos security response
- */
-static int rxkad_send_response(struct rxrpc_connection *conn,
-			       struct rxrpc_host_header *hdr,
-			       struct rxkad_response *resp,
-			       const struct rxkad_key *s2)
-{
-	struct rxrpc_wire_header whdr;
-	struct msghdr msg;
-	struct kvec iov[3];
-	size_t len;
-	u32 serial;
-	int ret;
-
-	_enter("");
-
-	msg.msg_name	= &conn->peer->srx.transport;
-	msg.msg_namelen	= conn->peer->srx.transport_len;
-	msg.msg_control	= NULL;
-	msg.msg_controllen = 0;
-	msg.msg_flags	= 0;
-
-	memset(&whdr, 0, sizeof(whdr));
-	whdr.epoch	= htonl(hdr->epoch);
-	whdr.cid	= htonl(hdr->cid);
-	whdr.type	= RXRPC_PACKET_TYPE_RESPONSE;
-	whdr.flags	= conn->out_clientflag;
-	whdr.securityIndex = hdr->securityIndex;
-	whdr.serviceId	= htons(hdr->serviceId);
-
-	iov[0].iov_base	= &whdr;
-	iov[0].iov_len	= sizeof(whdr);
-	iov[1].iov_base	= resp;
-	iov[1].iov_len	= sizeof(*resp);
-	iov[2].iov_base	= (void *)s2->ticket;
-	iov[2].iov_len	= s2->ticket_len;
-
-	len = iov[0].iov_len + iov[1].iov_len + iov[2].iov_len;
-
-	serial = rxrpc_get_next_serial(conn);
-	whdr.serial = htonl(serial);
-
-	rxrpc_local_dont_fragment(conn->local, false);
-	ret = kernel_sendmsg(conn->local->socket, &msg, iov, 3, len);
-	if (ret < 0) {
-		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
-				    rxrpc_tx_point_rxkad_response);
-		return -EAGAIN;
-	}
-
-	conn->peer->last_tx_at = ktime_get_seconds();
-	_leave(" = 0");
-	return 0;
-}
-
 /*
  * calculate the response checksum
  */
@@ -775,12 +719,21 @@ static void rxkad_calc_response_checksum(struct rxkad_response *response)
  * encrypt the response packet
  */
 static int rxkad_encrypt_response(struct rxrpc_connection *conn,
-				  struct rxkad_response *resp,
+				  struct sk_buff *response,
 				  const struct rxkad_key *s2)
 {
 	struct skcipher_request *req;
 	struct rxrpc_crypt iv;
 	struct scatterlist sg[1];
+	size_t encsize = sizeof(((struct rxkad_response *)0)->encrypted);
+	int ret;
+
+	sg_init_table(sg, ARRAY_SIZE(sg));
+	ret = skb_to_sgvec(response, sg,
+			   sizeof(struct rxrpc_wire_header) +
+			   offsetof(struct rxkad_response, encrypted), encsize);
+	if (ret < 0)
+		return ret;
 
 	req = skcipher_request_alloc(&conn->rxkad.cipher->base, GFP_NOFS);
 	if (!req)
@@ -789,88 +742,198 @@ static int rxkad_encrypt_response(struct rxrpc_connection *conn,
 	/* continue encrypting from where we left off */
 	memcpy(&iv, s2->session_key, sizeof(iv));
 
-	sg_init_table(sg, 1);
-	sg_set_buf(sg, &resp->encrypted, sizeof(resp->encrypted));
 	skcipher_request_set_sync_tfm(req, conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
-	skcipher_request_set_crypt(req, sg, sg, sizeof(resp->encrypted), iv.x);
-	crypto_skcipher_encrypt(req);
+	skcipher_request_set_crypt(req, sg, sg, encsize, iv.x);
+	ret = crypto_skcipher_encrypt(req);
 	skcipher_request_free(req);
-	return 0;
+	return ret;
 }
 
 /*
- * respond to a challenge packet
+ * Validate a challenge packet.
  */
-static int rxkad_respond_to_challenge(struct rxrpc_connection *conn,
-				      struct sk_buff *skb)
+static bool rxkad_validate_challenge(struct rxrpc_connection *conn,
+				     struct sk_buff *skb)
 {
-	const struct rxrpc_key_token *token;
 	struct rxkad_challenge challenge;
-	struct rxkad_response *resp;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	u32 version, nonce, min_level;
-	int ret = -EPROTO;
+	u32 version, min_level;
+	int ret;
 
 	_enter("{%d,%x}", conn->debug_id, key_serial(conn->key));
 
-	if (!conn->key)
-		return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
-					rxkad_abort_chall_no_key);
+	if (!conn->key) {
+		rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
+				 rxkad_abort_chall_no_key);
+		return false;
+	}
 
 	ret = key_validate(conn->key);
-	if (ret < 0)
-		return rxrpc_abort_conn(conn, skb, RXKADEXPIRED, ret,
-					rxkad_abort_chall_key_expired);
+	if (ret < 0) {
+		rxrpc_abort_conn(conn, skb, RXKADEXPIRED, ret,
+				 rxkad_abort_chall_key_expired);
+		return false;
+	}
 
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  &challenge, sizeof(challenge)) < 0)
-		return rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
-					rxkad_abort_chall_short);
+			  &challenge, sizeof(challenge)) < 0) {
+		rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
+				 rxkad_abort_chall_short);
+		return false;
+	}
 
 	version = ntohl(challenge.version);
-	nonce = ntohl(challenge.nonce);
+	sp->rxkad_nonce = ntohl(challenge.nonce);
 	min_level = ntohl(challenge.min_level);
 
-	trace_rxrpc_rx_challenge(conn, sp->hdr.serial, version, nonce, min_level);
+	trace_rxrpc_rx_challenge(conn, sp->hdr.serial, version, sp->rxkad_nonce, min_level);
+
+	if (version != RXKAD_VERSION) {
+		rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
+				 rxkad_abort_chall_version);
+		return false;
+	}
+
+	if (conn->security_level < min_level) {
+		rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EACCES,
+				 rxkad_abort_chall_level);
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Insert the header into the response.
+ */
+static noinline int rxkad_insert_response_header(struct rxrpc_connection *conn,
+						 const struct rxrpc_key_token *token,
+						 struct sk_buff *challenge,
+						 struct sk_buff *response,
+						 size_t *offset)
+{
+	struct rxrpc_skb_priv *csp = rxrpc_skb(challenge);
+	struct {
+		struct rxrpc_wire_header whdr;
+		struct rxkad_response	resp;
+	} h;
+	int ret;
+
+	h.whdr.epoch			= htonl(conn->proto.epoch);
+	h.whdr.cid			= htonl(conn->proto.cid);
+	h.whdr.callNumber		= 0;
+	h.whdr.serial			= 0;
+	h.whdr.seq			= 0;
+	h.whdr.type			= RXRPC_PACKET_TYPE_RESPONSE;
+	h.whdr.flags			= conn->out_clientflag;
+	h.whdr.userStatus		= 0;
+	h.whdr.securityIndex		= conn->security_ix;
+	h.whdr.cksum			= 0;
+	h.whdr.serviceId		= htons(conn->service_id);
+	h.resp.version			= htonl(RXKAD_VERSION);
+	h.resp.__pad			= 0;
+	h.resp.encrypted.epoch		= htonl(conn->proto.epoch);
+	h.resp.encrypted.cid		= htonl(conn->proto.cid);
+	h.resp.encrypted.checksum	= 0;
+	h.resp.encrypted.securityIndex	= htonl(conn->security_ix);
+	h.resp.encrypted.call_id[0]	= htonl(conn->channels[0].call_counter);
+	h.resp.encrypted.call_id[1]	= htonl(conn->channels[1].call_counter);
+	h.resp.encrypted.call_id[2]	= htonl(conn->channels[2].call_counter);
+	h.resp.encrypted.call_id[3]	= htonl(conn->channels[3].call_counter);
+	h.resp.encrypted.inc_nonce	= htonl(csp->rxkad_nonce + 1);
+	h.resp.encrypted.level		= htonl(conn->security_level);
+	h.resp.kvno			= htonl(token->kad->kvno);
+	h.resp.ticket_len		= htonl(token->kad->ticket_len);
+
+	rxkad_calc_response_checksum(&h.resp);
+
+	ret = skb_store_bits(response, *offset, &h, sizeof(h));
+	*offset += sizeof(h);
+	return ret;
+}
+
+/*
+ * respond to a challenge packet
+ */
+static int rxkad_respond_to_challenge(struct rxrpc_connection *conn,
+				      struct sk_buff *challenge)
+{
+	const struct rxrpc_key_token *token;
+	struct rxrpc_skb_priv *csp, *rsp;
+	struct sk_buff *response;
+	size_t len, offset = 0;
+	int ret = -EPROTO;
 
-	if (version != RXKAD_VERSION)
-		return rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
-					rxkad_abort_chall_version);
+	_enter("{%d,%x}", conn->debug_id, key_serial(conn->key));
 
-	if (conn->security_level < min_level)
-		return rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EACCES,
-					rxkad_abort_chall_level);
+	ret = key_validate(conn->key);
+	if (ret < 0)
+		return rxrpc_abort_conn(conn, challenge, RXKADEXPIRED, ret,
+					rxkad_abort_chall_key_expired);
 
 	token = conn->key->payload.data[0];
 
 	/* build the response packet */
-	resp = kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
-	if (!resp)
-		return -ENOMEM;
+	len = sizeof(struct rxrpc_wire_header) +
+		sizeof(struct rxkad_response) +
+		token->kad->ticket_len;
+
+	response = alloc_skb_with_frags(0, len, 0, &ret, GFP_NOFS);
+	if (!response)
+		goto error;
+	response->len = len;
+	response->data_len = len;
+
+	offset = 0;
+	ret = rxkad_insert_response_header(conn, token, challenge, response, &offset);
+	if (ret < 0)
+		goto error;
+
+	ret = rxkad_encrypt_response(conn, response, token->kad);
+	if (ret < 0)
+		goto error;
+
+	ret = skb_store_bits(response, offset, token->kad->ticket, token->kad->ticket_len);
+	if (ret < 0)
+		goto error;
 
-	resp->version			= htonl(RXKAD_VERSION);
-	resp->encrypted.epoch		= htonl(conn->proto.epoch);
-	resp->encrypted.cid		= htonl(conn->proto.cid);
-	resp->encrypted.securityIndex	= htonl(conn->security_ix);
-	resp->encrypted.inc_nonce	= htonl(nonce + 1);
-	resp->encrypted.level		= htonl(conn->security_level);
-	resp->kvno			= htonl(token->kad->kvno);
-	resp->ticket_len		= htonl(token->kad->ticket_len);
-	resp->encrypted.call_id[0]	= htonl(conn->channels[0].call_counter);
-	resp->encrypted.call_id[1]	= htonl(conn->channels[1].call_counter);
-	resp->encrypted.call_id[2]	= htonl(conn->channels[2].call_counter);
-	resp->encrypted.call_id[3]	= htonl(conn->channels[3].call_counter);
-
-	/* calculate the response checksum and then do the encryption */
-	rxkad_calc_response_checksum(resp);
-	ret = rxkad_encrypt_response(conn, resp, token->kad);
-	if (ret == 0)
-		ret = rxkad_send_response(conn, &sp->hdr, resp, token->kad);
-	kfree(resp);
+	csp = rxrpc_skb(challenge);
+	rsp = rxrpc_skb(response);
+	rsp->resp.len = len;
+	rsp->resp.challenge_serial = csp->hdr.serial;
+	rxrpc_post_response(conn, response);
+	response = NULL;
+	ret = 0;
+
+error:
+	rxrpc_free_skb(response, rxrpc_skb_put_response);
 	return ret;
 }
 
+/*
+ * RxKAD does automatic response only as there's nothing to manage that isn't
+ * already in the key.
+ */
+static int rxkad_sendmsg_respond_to_challenge(struct rxrpc_call *call,
+					      struct msghdr *msg)
+{
+	return -EINVAL;
+}
+
+/**
+ * rxkad_kernel_respond_to_challenge - Respond to a challenge with appdata
+ * @call: The call used as a reference for the connection
+ *
+ * Allow a kernel application to respond to a CHALLENGE.
+ */
+int rxkad_kernel_respond_to_challenge(struct rxrpc_call *call)
+{
+	if (!call->challenge)
+		return -EPROTO;
+	return rxkad_respond_to_challenge(call->conn, call->challenge);
+}
+EXPORT_SYMBOL(rxkad_kernel_respond_to_challenge);
+
 /*
  * decrypt the kerberos IV ticket in the response
  */
@@ -1279,6 +1342,8 @@ const struct rxrpc_security rxkad = {
 	.verify_packet			= rxkad_verify_packet,
 	.free_call_crypto		= rxkad_free_call_crypto,
 	.issue_challenge		= rxkad_issue_challenge,
+	.validate_challenge		= rxkad_validate_challenge,
+	.sendmsg_respond_to_challenge	= rxkad_sendmsg_respond_to_challenge,
 	.respond_to_challenge		= rxkad_respond_to_challenge,
 	.verify_response		= rxkad_verify_response,
 	.clear				= rxkad_clear,
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 584397aba4a0..8775d7fe660f 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -588,6 +588,25 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
 				return -ERANGE;
 			break;
 
+		case RXRPC_RESPOND:
+			if (p->command != RXRPC_CMD_SEND_DATA)
+				return -EINVAL;
+			p->command = RXRPC_CMD_SEND_RESPONSE;
+			break;
+		case RXRPC_RESPOND_ABORT:
+			if (p->command != RXRPC_CMD_SEND_DATA)
+				return -EINVAL;
+			p->command = RXRPC_CMD_ABORT_RESPONSE;
+			if (len != sizeof(p->abort_code))
+				return -EINVAL;
+			p->abort_code = *(unsigned int *)CMSG_DATA(cmsg);
+			if (p->abort_code == 0)
+				return -EINVAL;
+			break;
+		case RXRPC_RESP_RXGK_APPDATA:
+			if (p->command != RXRPC_CMD_SEND_RESPONSE)
+				return -EINVAL;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -761,14 +780,34 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	if (rxrpc_call_is_complete(call)) {
 		/* it's too late for this call */
 		ret = -ESHUTDOWN;
-	} else if (p.command == RXRPC_CMD_SEND_ABORT) {
+		goto out_put_unlock;
+	}
+
+	switch (p.command) {
+	case RXRPC_CMD_SEND_ABORT:
 		rxrpc_propose_abort(call, p.abort_code, -ECONNABORTED,
 				    rxrpc_abort_call_sendmsg);
 		ret = 0;
-	} else if (p.command != RXRPC_CMD_SEND_DATA) {
-		ret = -EINVAL;
-	} else {
+		break;
+	case RXRPC_CMD_SEND_DATA:
 		ret = rxrpc_send_data(rx, call, msg, len, NULL, &dropped_lock);
+		break;
+	case RXRPC_CMD_SEND_RESPONSE:
+		if (!call->conn)
+			ret = -ENOTCONN;
+		else if (call->conn->security->sendmsg_respond_to_challenge)
+			ret = call->conn->security->sendmsg_respond_to_challenge(call, msg);
+		else
+			ret = -EOPNOTSUPP;
+		break;
+	case RXRPC_CMD_ABORT_RESPONSE:
+		rxrpc_abort_conn(call->conn, NULL, p.abort_code, -ECONNABORTED,
+				 rxrpc_abort_response_sendmsg);
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
 out_put_unlock:
@@ -867,3 +906,25 @@ void rxrpc_kernel_set_tx_length(struct socket *sock, struct rxrpc_call *call,
 	call->tx_total_len = tx_total_len;
 }
 EXPORT_SYMBOL(rxrpc_kernel_set_tx_length);
+
+/**
+ * rxrpc_kernel_reject_challenge - Allow a kernel service to reject a challenge
+ * @call: The call used as reference for the conn to be aborted
+ * @abort_code: The abort code to stick into the ABORT packet
+ * @error: Local error value
+ * @why: Indication as to why.
+ *
+ * Allow a kernel service to reject a challenge by aborting the connection, if
+ * it's still in an abortable state.
+ */
+int rxrpc_kernel_reject_challenge(struct rxrpc_call *call, u32 abort_code, int error,
+				  enum rxrpc_abort_reason why)
+{
+	_enter("{%d},%d,%d,%u", call->debug_id, abort_code, error, why);
+
+	mutex_lock(&call->user_mutex);
+	rxrpc_abort_conn(call->conn, NULL, abort_code, error, why);
+	mutex_unlock(&call->user_mutex);
+	return error;
+}
+EXPORT_SYMBOL(rxrpc_kernel_reject_challenge);
diff --git a/net/rxrpc/server_key.c b/net/rxrpc/server_key.c
index e51940589ee5..4c44a27d01ee 100644
--- a/net/rxrpc/server_key.c
+++ b/net/rxrpc/server_key.c
@@ -169,3 +169,43 @@ int rxrpc_sock_set_security_keyring(struct sock *sk, struct key *keyring)
 	return ret;
 }
 EXPORT_SYMBOL(rxrpc_sock_set_security_keyring);
+
+/**
+ * rxrpc_sock_set_manage_response - Set the manage-response flag for a kernel service
+ * @sk: The socket to set the keyring on
+ * @set: True to set, false to clear the flag
+ *
+ * Set the flag on an rxrpc socket to say that the caller wants to manage the
+ * RESPONSE packet and the user-defined data it may contain.  Setting this
+ * means that recvmsg() will return messages with RXRPC_CHALLENGED in the
+ * control message buffer containing information about the challenge.
+ *
+ * The user should respond to the challenge by passing RXRPC_RESPOND or
+ * RXRPC_RESPOND_ABORT control messages with sendmsg() to the same call.
+ * Supplementary control messages, such as RXRPC_RESP_RXGK_APPDATA, may be
+ * included to indicate the parts the user wants to supply.
+ *
+ * The server will be passed the response data with a RXRPC_RESPONDED control
+ * message when it gets the first data from each call.
+ *
+ * Note that this is only honoured by security classes that need auxiliary data
+ * (e.g. RxGK).  Those that don't offer the facility (e.g. RxKAD) respond
+ * without consulting userspace.
+ *
+ * Returns the previous setting.
+ */
+int rxrpc_sock_set_manage_response(struct sock *sk, bool set)
+{
+	struct rxrpc_sock *rx = rxrpc_sk(sk);
+	int ret;
+
+	lock_sock(sk);
+	ret = !!test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+	if (set)
+		set_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+	else
+		clear_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+	release_sock(sk);
+	return ret;
+}
+EXPORT_SYMBOL(rxrpc_sock_set_manage_response);


