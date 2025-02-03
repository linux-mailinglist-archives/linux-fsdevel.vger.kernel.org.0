Return-Path: <linux-fsdevel+bounces-40616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C533A25CD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C331664DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CBE211A13;
	Mon,  3 Feb 2025 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjWXMcfl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674D21171C
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592784; cv=none; b=SKjJcZJenIKuB2XRKkVwP8OYW6wmuz+3AGuF7Aobz5wQPs5Dp4qaadxHVnD5XGrW1bAVxx6ae8dZjxjeFQaa8/JYv/rXsJPhtJh1ooWF+sfdcPFHOdAfEWCA6DYTL7d0OrhlAhhtr1S6eOeVBLjASd47XkOPGtjzHqRpBjeSTLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592784; c=relaxed/simple;
	bh=KrC/ngUANOnxIvnc+tv6BLsS4dU+1uIe5vKw3O6k/DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyOCJObu/gkM43QE2oxl7/suPkW9tHKdOZ1BJxkztx8S0l7E77YCY/PKcwBk9nQgzzWnUyEOurswGRH93+KHLeyazUoQ2NseIqKw52w0/v3Bxlbvg9HWunkjvu95NxXpY/YOMYVwAJoIrkmrQvfR7hlnoUJkvdb5lUgDwAqqf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjWXMcfl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvQc4YaEZHaPqxjK0g8slo5hVYt5GHqMm8jeCuIUPQg=;
	b=CjWXMcflsHupc2MO6NBZLgyXNMDn/51euLBhai+ZvLnx1+Kyj/QXHAlSes+aFmfUC7pUd8
	zNQwJC2xmyLJVolXXtNDFTmuLUXzcJlvSZAp12MBt2oPkzIGl2RIN36WTcoAG9AL3aLWrf
	kyHNTY6gkHclspjW+9bsaLrn19idgCg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-_jah63udM5Cm6oQ27aCBGA-1; Mon,
 03 Feb 2025 09:26:15 -0500
X-MC-Unique: _jah63udM5Cm6oQ27aCBGA-1
X-Mimecast-MFC-AGG-ID: _jah63udM5Cm6oQ27aCBGA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C30D1956048;
	Mon,  3 Feb 2025 14:26:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25BA21800365;
	Mon,  3 Feb 2025 14:26:07 +0000 (UTC)
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
Subject: [PATCH net 23/24] rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)
Date: Mon,  3 Feb 2025 14:23:39 +0000
Message-ID: <20250203142343.248839-24-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Implement the basic parts of the yfs-rxgk security class (security index 6)
to support GSSAPI-negotiated security.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 fs/afs/cm_security.c         |    7 +
 include/trace/events/rxrpc.h |   45 +-
 net/rxrpc/Makefile           |    2 +
 net/rxrpc/ar-internal.h      |   16 +
 net/rxrpc/output.c           |    2 +-
 net/rxrpc/protocol.h         |   20 +
 net/rxrpc/rxgk.c             | 1216 ++++++++++++++++++++++++++++++++++
 net/rxrpc/rxgk_app.c         |  285 ++++++++
 net/rxrpc/rxgk_common.h      |   90 +++
 net/rxrpc/rxkad.c            |    6 +-
 net/rxrpc/security.c         |    3 +
 11 files changed, 1687 insertions(+), 5 deletions(-)
 create mode 100644 net/rxrpc/rxgk.c
 create mode 100644 net/rxrpc/rxgk_app.c

diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
index fbec18bc999e..62dbc43c92c0 100644
--- a/fs/afs/cm_security.c
+++ b/fs/afs/cm_security.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <crypto/krb5.h>
 #include "internal.h"
 #include "afs_fs.h"
 #include "protocol_yfs.h"
@@ -18,6 +19,8 @@
 int afs_respond_to_challenge(struct rxrpc_call *rxcall, unsigned long user_call_ID,
 			     u16 service_id, u8 security_index)
 {
+	struct krb5_buffer appdata = {};
+
 	_enter("%u,%u", service_id, security_index);
 
 	switch (service_id) {
@@ -40,6 +43,10 @@ int afs_respond_to_challenge(struct rxrpc_call *rxcall, unsigned long user_call_
 	case RXRPC_SECURITY_RXKAD:
 		return rxkad_kernel_respond_to_challenge(rxcall);
 
+	case RXRPC_SECURITY_RXGK:
+	case RXRPC_SECURITY_YFS_RXGK:
+		return rxgk_kernel_respond_to_challenge(rxcall, &appdata);
+
 	default:
 		return rxrpc_kernel_reject_challenge(rxcall, RX_USER_ABORT, -EPROTO,
 						     afs_abort_unsupported_sec_class);
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 109eb5898a63..536113c10e04 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -69,6 +69,38 @@
 	EM(rxkad_abort_resp_tkt_sname,		"rxkad-resp-tk-sname")	\
 	EM(rxkad_abort_resp_unknown_tkt,	"rxkad-resp-unknown-tkt") \
 	EM(rxkad_abort_resp_version,		"rxkad-resp-version")	\
+	/* RxGK security errors */					\
+	EM(rxgk_abort_1_verify_mic_eproto,	"rxgk1-vfy-mic-eproto")	\
+	EM(rxgk_abort_2_decrypt_eproto,		"rxgk2-dec-eproto")	\
+	EM(rxgk_abort_2_short_data,		"rxgk2-short-data")	\
+	EM(rxgk_abort_2_short_encdata,		"rxgk2-short-encdata")	\
+	EM(rxgk_abort_2_short_header,		"rxgk2-short-hdr")	\
+	EM(rxgk_abort_bad_key_number,		"rxgk-bad-key-num")	\
+	EM(rxgk_abort_chall_key_expired,	"rxgk-chall-key-exp")	\
+	EM(rxgk_abort_chall_no_key,		"rxgk-chall-nokey")	\
+	EM(rxgk_abort_chall_short,		"rxgk-chall-short")	\
+	EM(rxgk_abort_resp_auth_dec,		"rxgk-resp-auth-dec")	\
+	EM(rxgk_abort_resp_bad_callid,		"rxgk-resp-bad-callid")	\
+	EM(rxgk_abort_resp_bad_nonce,		"rxgk-resp-bad-nonce")	\
+	EM(rxgk_abort_resp_bad_param,		"rxgk-resp-bad-param")	\
+	EM(rxgk_abort_resp_call_ctr,		"rxgk-resp-call-ctr")	\
+	EM(rxgk_abort_resp_call_state,		"rxgk-resp-call-state")	\
+	EM(rxgk_abort_resp_internal_error,	"rxgk-resp-int-error")	\
+	EM(rxgk_abort_resp_nopkg,		"rxgk-resp-nopkg")	\
+	EM(rxgk_abort_resp_short_applen,	"rxgk-resp-short-applen") \
+	EM(rxgk_abort_resp_short_auth,		"rxgk-resp-short-auth") \
+	EM(rxgk_abort_resp_short_call_list,	"rxgk-resp-short-callls") \
+	EM(rxgk_abort_resp_short_packet,	"rxgk-resp-short-packet") \
+	EM(rxgk_abort_resp_short_yfs_klen,	"rxgk-resp-short-yfs-klen") \
+	EM(rxgk_abort_resp_short_yfs_key,	"rxgk-resp-short-yfs-key") \
+	EM(rxgk_abort_resp_short_yfs_tkt,	"rxgk-resp-short-yfs-tkt") \
+	EM(rxgk_abort_resp_tok_dec,		"rxgk-resp-tok-dec")	\
+	EM(rxgk_abort_resp_tok_internal_error,	"rxgk-resp-tok-int-err") \
+	EM(rxgk_abort_resp_tok_keyerr,		"rxgk-resp-tok-keyerr")	\
+	EM(rxgk_abort_resp_tok_nokey,		"rxgk-resp-tok-nokey")	\
+	EM(rxgk_abort_resp_tok_nopkg,		"rxgk-resp-tok-nopkg")	\
+	EM(rxgk_abort_resp_tok_short,		"rxgk-resp-tok-short")	\
+	EM(rxgk_abort_resp_xdr_align,		"rxgk-resp-xdr-align")	\
 	/* rxrpc errors */						\
 	EM(rxrpc_abort_call_improper_term,	"call-improper-term")	\
 	EM(rxrpc_abort_call_reset,		"call-reset")		\
@@ -461,6 +493,7 @@
 	EM(rxrpc_tx_point_call_final_resend,	"CallFinalResend") \
 	EM(rxrpc_tx_point_conn_abort,		"ConnAbort") \
 	EM(rxrpc_tx_point_reject,		"Reject") \
+	EM(rxrpc_tx_point_rxgk_challenge,	"RxGKChall") \
 	EM(rxrpc_tx_point_rxkad_challenge,	"RxkadChall") \
 	EM(rxrpc_tx_point_response,		"Response") \
 	EM(rxrpc_tx_point_version_keepalive,	"VerKeepalive") \
@@ -479,6 +512,7 @@
 
 #define rxrpc_txbuf_traces \
 	EM(rxrpc_txbuf_alloc_data,		"ALLOC DATA ")	\
+	EM(rxrpc_txbuf_alloc_response,		"ALLOC RESP ")	\
 	EM(rxrpc_txbuf_free,			"FREE       ")	\
 	EM(rxrpc_txbuf_get_buffer,		"GET BUFFER ")	\
 	EM(rxrpc_txbuf_get_trans,		"GET TRANS  ")	\
@@ -486,6 +520,7 @@
 	EM(rxrpc_txbuf_put_cleaned,		"PUT CLEANED")	\
 	EM(rxrpc_txbuf_put_nomem,		"PUT NOMEM  ")	\
 	EM(rxrpc_txbuf_put_rotated,		"PUT ROTATED")	\
+	EM(rxrpc_txbuf_put_response_tx,		"PUT RESP TX")	\
 	EM(rxrpc_txbuf_put_send_aborted,	"PUT SEND-X ")	\
 	EM(rxrpc_txbuf_put_trans,		"PUT TRANS  ")	\
 	EM(rxrpc_txbuf_see_lost,		"SEE LOST   ")	\
@@ -1168,6 +1203,7 @@ TRACE_EVENT(rxrpc_rx_challenge,
 		    __field(u32,		version)
 		    __field(u32,		nonce)
 		    __field(u32,		min_level)
+		    __field(u8,			security_ix)
 			     ),
 
 	    TP_fast_assign(
@@ -1176,11 +1212,13 @@ TRACE_EVENT(rxrpc_rx_challenge,
 		    __entry->version = version;
 		    __entry->nonce = nonce;
 		    __entry->min_level = min_level;
+		    __entry->security_ix = conn->security_ix;
 			   ),
 
-	    TP_printk("C=%08x CHALLENGE %08x v=%x n=%x ml=%x",
+	    TP_printk("C=%08x CHALLENGE r=%08x sx=%u v=%x n=%x ml=%x",
 		      __entry->conn,
 		      __entry->serial,
+		      __entry->security_ix,
 		      __entry->version,
 		      __entry->nonce,
 		      __entry->min_level)
@@ -1198,6 +1236,7 @@ TRACE_EVENT(rxrpc_rx_response,
 		    __field(u32,		version)
 		    __field(u32,		kvno)
 		    __field(u32,		ticket_len)
+		    __field(u8,			security_ix)
 			     ),
 
 	    TP_fast_assign(
@@ -1206,11 +1245,13 @@ TRACE_EVENT(rxrpc_rx_response,
 		    __entry->version = version;
 		    __entry->kvno = kvno;
 		    __entry->ticket_len = ticket_len;
+		    __entry->security_ix = conn->security_ix;
 			   ),
 
-	    TP_printk("C=%08x RESPONSE %08x v=%x kvno=%x tl=%x",
+	    TP_printk("C=%08x RESPONSE r=%08x sx=%u v=%x kvno=%x tl=%x",
 		      __entry->conn,
 		      __entry->serial,
+		      __entry->security_ix,
 		      __entry->version,
 		      __entry->kvno,
 		      __entry->ticket_len)
diff --git a/net/rxrpc/Makefile b/net/rxrpc/Makefile
index 9c8eb1471054..2ef05701d6d1 100644
--- a/net/rxrpc/Makefile
+++ b/net/rxrpc/Makefile
@@ -40,6 +40,8 @@ rxrpc-$(CONFIG_PROC_FS) += proc.o
 rxrpc-$(CONFIG_RXKAD) += rxkad.o
 rxrpc-$(CONFIG_SYSCTL) += sysctl.o
 rxrpc-$(CONFIG_RXGK) += \
+	rxgk.o \
+	rxgk_app.o \
 	rxgk_kdf.o
 
 obj-$(CONFIG_RXPERF) += rxperf.o
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 2b318d88546a..7d5a28c8131d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -31,6 +31,7 @@ struct key_preparsed_payload;
 struct rxrpc_connection;
 struct rxrpc_txbuf;
 struct rxrpc_txqueue;
+struct rxgk_context;
 
 /*
  * Mark applied to socket buffers in skb->mark.  skb->priority is used
@@ -300,6 +301,11 @@ struct rxrpc_security {
 
 	/* clear connection security */
 	void (*clear)(struct rxrpc_connection *);
+
+	/* Default ticket -> key decoder */
+	int (*default_decode_ticket)(struct rxrpc_connection *conn, struct sk_buff *skb,
+				     unsigned int ticket_offset, unsigned int ticket_len,
+				     struct key **_key);
 };
 
 /*
@@ -547,7 +553,9 @@ struct rxrpc_connection {
 			u32	nonce;		/* response re-use preventer */
 		} rxkad;
 		struct {
+			struct rxgk_context *keys[1];
 			u64	start_time;	/* The start time for TK derivation */
+			u8	nonce[20];	/* Response re-use preventer */
 		} rxgk;
 	};
 	struct sk_buff		*tx_response;	/* Response packet to be transmitted */
@@ -895,6 +903,8 @@ struct rxrpc_txbuf {
 	unsigned short		len;		/* Amount of data in buffer */
 	unsigned short		space;		/* Remaining data space */
 	unsigned short		offset;		/* Offset of fill point */
+	unsigned short		crypto_header;	/* Size of crypto header */
+	unsigned short		sec_header;	/* Size of security header */
 	unsigned short		pkt_len;	/* Size of packet content */
 	unsigned short		alloc_size;	/* Amount of bufferage allocated */
 	unsigned int		flags;
@@ -1321,6 +1331,7 @@ static inline struct rxrpc_net *rxrpc_net(struct net *net)
 /*
  * output.c
  */
+ssize_t do_udp_sendmsg(struct socket *socket, struct msghdr *msg, size_t len);
 void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why);
 void rxrpc_send_probe_for_pmtud(struct rxrpc_call *call);
@@ -1393,6 +1404,11 @@ void rxrpc_call_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 ktime_t rxrpc_get_rto_backoff(struct rxrpc_call *call, bool retrans);
 void rxrpc_call_init_rtt(struct rxrpc_call *call);
 
+/*
+ * rxgk.c
+ */
+extern const struct rxrpc_security rxgk_yfs;
+
 /*
  * rxkad.c
  */
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 8207b87ea836..9c5d6e982599 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -18,7 +18,7 @@
 
 extern int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
 
-static ssize_t do_udp_sendmsg(struct socket *socket, struct msghdr *msg, size_t len)
+ssize_t do_udp_sendmsg(struct socket *socket, struct msghdr *msg, size_t len)
 {
 	struct sockaddr *sa = msg->msg_name;
 	struct sock *sk = socket->sk;
diff --git a/net/rxrpc/protocol.h b/net/rxrpc/protocol.h
index 42f70e4636f8..f8bfec12bc7e 100644
--- a/net/rxrpc/protocol.h
+++ b/net/rxrpc/protocol.h
@@ -181,4 +181,24 @@ struct rxkad_response {
 	__be32		ticket_len;	/* Kerberos ticket length  */
 } __packed;
 
+/*
+ * GSSAPI security type-4 and type-6 data header.
+ */
+struct rxgk_header {
+	__be32	epoch;
+	__be32	cid;
+	__be32	call_number;
+	__be32	seq;
+	__be32	sec_index;
+	__be32	data_len;
+} __packed;
+
+/*
+ * GSSAPI security type-4 and type-6 response packet header.
+ */
+struct rxgk_response {
+	__be64	start_time;
+	__be32	token_len;
+} __packed;
+
 #endif /* _LINUX_RXRPC_PACKET_H */
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
new file mode 100644
index 000000000000..d8f15e145a82
--- /dev/null
+++ b/net/rxrpc/rxgk.c
@@ -0,0 +1,1216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* GSSAPI-based RxRPC security
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/net.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/key-type.h>
+#include "ar-internal.h"
+#include "rxgk_common.h"
+
+/*
+ * Parse the information from a server key
+ */
+static int rxgk_preparse_server_key(struct key_preparsed_payload *prep)
+{
+	const struct krb5_enctype *krb5;
+	struct krb5_buffer *server_key = (void *)&prep->payload.data[2];
+	unsigned int service, sec_class, kvno, enctype;
+	int n = 0;
+
+	_enter("%zu", prep->datalen);
+
+	if (sscanf(prep->orig_description, "%u:%u:%u:%u%n",
+		   &service, &sec_class, &kvno, &enctype, &n) != 4)
+		return -EINVAL;
+
+	if (prep->orig_description[n])
+		return -EINVAL;
+
+	krb5 = crypto_krb5_find_enctype(enctype);
+	if (!krb5)
+		return -ENOPKG;
+
+	prep->payload.data[0] = (struct krb5_enctype *)krb5;
+
+	if (prep->datalen != krb5->key_len)
+		return -EKEYREJECTED;
+
+	server_key->len = prep->datalen;
+	server_key->data = kmemdup(prep->data, prep->datalen, GFP_KERNEL);
+	if (!server_key->data)
+		return -ENOMEM;
+
+	_leave(" = 0");
+	return 0;
+}
+
+static void rxgk_free_server_key(union key_payload *payload)
+{
+	struct krb5_buffer *server_key = (void *)&payload->data[2];
+
+	kfree_sensitive(server_key->data);
+}
+
+static void rxgk_free_preparse_server_key(struct key_preparsed_payload *prep)
+{
+	rxgk_free_server_key(&prep->payload);
+}
+
+static void rxgk_destroy_server_key(struct key *key)
+{
+	rxgk_free_server_key(&key->payload);
+}
+
+static void rxgk_describe_server_key(const struct key *key, struct seq_file *m)
+{
+	const struct krb5_enctype *krb5 = key->payload.data[0];
+
+	if (krb5)
+		seq_printf(m, ": %s", krb5->name);
+}
+
+static struct rxgk_context *rxgk_get_key(struct rxrpc_connection *conn,
+					 u16 *specific_key_number)
+{
+	refcount_inc(&conn->rxgk.keys[0]->usage);
+	return conn->rxgk.keys[0];
+}
+
+/*
+ * initialise connection security
+ */
+static int rxgk_init_connection_security(struct rxrpc_connection *conn,
+					 struct rxrpc_key_token *token)
+{
+	struct rxgk_context *gk;
+	int ret;
+
+	_enter("{%d},{%x}", conn->debug_id, key_serial(conn->key));
+
+	conn->security_ix = token->security_index;
+	conn->security_level = token->rxgk->level;
+
+	if (rxrpc_conn_is_client(conn)) {
+		conn->rxgk.start_time = ktime_get();
+		do_div(conn->rxgk.start_time, 100);
+	}
+
+	gk = rxgk_generate_transport_key(conn, token->rxgk, 0, GFP_NOFS);
+	if (IS_ERR(gk))
+		return PTR_ERR(gk);
+	conn->rxgk.keys[0] = gk;
+
+	switch (conn->security_level) {
+	case RXRPC_SECURITY_PLAIN:
+	case RXRPC_SECURITY_AUTH:
+	case RXRPC_SECURITY_ENCRYPT:
+		break;
+	default:
+		ret = -EKEYREJECTED;
+		goto error;
+	}
+
+	ret = 0;
+error:
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Clean up the crypto on a call.
+ */
+static void rxgk_free_call_crypto(struct rxrpc_call *call)
+{
+}
+
+/*
+ * Work out how much data we can put in a packet.
+ */
+static struct rxrpc_txbuf *rxgk_alloc_txbuf(struct rxrpc_call *call, size_t remain, gfp_t gfp)
+{
+	enum krb5_crypto_mode mode;
+	struct rxgk_context *gk;
+	struct rxrpc_txbuf *txb;
+	size_t shdr, alloc, limit, part, offset, gap;
+
+	switch (call->conn->security_level) {
+	default:
+		alloc = umin(remain, RXRPC_JUMBO_DATALEN);
+		return rxrpc_alloc_data_txbuf(call, alloc, 1, gfp);
+	case RXRPC_SECURITY_AUTH:
+		shdr = 0;
+		mode = KRB5_CHECKSUM_MODE;
+		break;
+	case RXRPC_SECURITY_ENCRYPT:
+		shdr = sizeof(struct rxgk_header);
+		mode = KRB5_ENCRYPT_MODE;
+		break;
+	}
+
+	gk = rxgk_get_key(call->conn, NULL);
+	if (IS_ERR(gk))
+		return NULL;
+
+	/* Work out the maximum amount of data that will fit. */
+	alloc = RXRPC_JUMBO_DATALEN;
+	limit = crypto_krb5_how_much_data(gk->krb5, mode, &alloc, &offset);
+
+	if (remain < limit - shdr) {
+		part = remain;
+		alloc = crypto_krb5_how_much_buffer(gk->krb5, mode,
+						    shdr + part, &offset);
+		gap = 0;
+	} else {
+		part = limit - shdr;
+		gap = RXRPC_JUMBO_DATALEN - alloc;
+		alloc = RXRPC_JUMBO_DATALEN;
+	}
+
+	rxgk_put(gk);
+
+	txb = rxrpc_alloc_data_txbuf(call, alloc, 16, gfp);
+	if (!txb)
+		return NULL;
+
+	txb->crypto_header	= offset;
+	txb->sec_header		= shdr;
+	txb->offset		+= offset + shdr;
+	txb->space		= part;
+
+	/* Clear excess space in the packet */
+	if (gap) {
+		struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+		void *p = whdr + 1;
+
+		memset(p + alloc - gap, 0, gap);
+	}
+	return txb;
+}
+
+/*
+ * Integrity mode (sign a packet - level 1 security)
+ */
+static int rxgk_secure_packet_integrity(const struct rxrpc_call *call,
+					struct rxgk_context *gk,
+					struct rxrpc_txbuf *txb)
+{
+	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+	struct rxgk_header *hdr;
+	struct scatterlist sg[1];
+	struct krb5_buffer metadata;
+	void *payload = whdr + 1;
+	int ret = -ENOMEM;
+
+	_enter("");
+
+	hdr = kzalloc(sizeof(*hdr), GFP_NOFS);
+	if (!hdr)
+		goto error_gk;
+
+	hdr->epoch	= htonl(call->conn->proto.epoch);
+	hdr->cid	= htonl(call->cid);
+	hdr->call_number = htonl(call->call_id);
+	hdr->seq	= htonl(txb->seq);
+	hdr->sec_index	= htonl(call->security_ix);
+	hdr->data_len	= htonl(txb->len);
+	metadata.len = sizeof(*hdr);
+	metadata.data = hdr;
+
+	sg_init_table(sg, 1);
+	sg_set_buf(&sg[0], payload, txb->alloc_size);
+
+	ret = crypto_krb5_get_mic(gk->krb5, gk->tx_Kc, &metadata,
+				  sg, 1, txb->alloc_size,
+				  txb->crypto_header, txb->sec_header + txb->len);
+	if (ret >= 0) {
+		txb->pkt_len = ret;
+		if (txb->alloc_size == RXRPC_JUMBO_DATALEN)
+			txb->jumboable = true;
+		gk->bytes_remaining -= ret;
+	}
+	kfree(hdr);
+error_gk:
+	rxgk_put(gk);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * wholly encrypt a packet (level 2 security)
+ */
+static int rxgk_secure_packet_encrypted(const struct rxrpc_call *call,
+					struct rxgk_context *gk,
+					struct rxrpc_txbuf *txb)
+{
+	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+	struct rxgk_header *hdr;
+	struct scatterlist sg[1];
+	void *payload = whdr + 1;
+	int ret;
+
+	_enter("%x", txb->len);
+
+	/* Insert the header into the buffer. */
+	hdr = payload + txb->crypto_header;
+	hdr->epoch	 = htonl(call->conn->proto.epoch);
+	hdr->cid	 = htonl(call->cid);
+	hdr->call_number = htonl(call->call_id);
+	hdr->seq	 = htonl(txb->seq);
+	hdr->sec_index	 = htonl(call->security_ix);
+	hdr->data_len	 = htonl(txb->len);
+
+	sg_init_table(sg, 1);
+	sg_set_buf(&sg[0], payload, txb->alloc_size);
+
+	ret = crypto_krb5_encrypt(gk->krb5, gk->tx_enc,
+				  sg, 1, txb->alloc_size,
+				  txb->crypto_header, txb->sec_header + txb->len,
+				  false);
+	if (ret >= 0) {
+		txb->pkt_len = ret;
+		if (txb->alloc_size == RXRPC_JUMBO_DATALEN)
+			txb->jumboable = true;
+		gk->bytes_remaining -= ret;
+	}
+
+	rxgk_put(gk);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * checksum an RxRPC packet header
+ */
+static int rxgk_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+{
+	struct rxgk_context *gk;
+	int ret;
+
+	_enter("{%d{%x}},{#%u},%u,",
+	       call->debug_id, key_serial(call->conn->key), txb->seq, txb->len);
+
+	gk = rxgk_get_key(call->conn, NULL);
+	if (IS_ERR(gk))
+		return PTR_ERR(gk) == -ESTALE ? -EKEYREJECTED : PTR_ERR(gk);
+
+	ret = key_validate(call->conn->key);
+	if (ret < 0)
+		return ret;
+
+	txb->cksum = htons(gk->key_number);
+
+	switch (call->conn->security_level) {
+	case RXRPC_SECURITY_PLAIN:
+		rxgk_put(gk);
+		txb->pkt_len = txb->len;
+		return 0;
+	case RXRPC_SECURITY_AUTH:
+		return rxgk_secure_packet_integrity(call, gk, txb);
+	case RXRPC_SECURITY_ENCRYPT:
+		return rxgk_secure_packet_encrypted(call, gk, txb);
+	default:
+		rxgk_put(gk);
+		return -EPERM;
+	}
+}
+
+/*
+ * Integrity mode (check the signature on a packet - level 1 security)
+ */
+static int rxgk_verify_packet_integrity(struct rxrpc_call *call,
+					struct rxgk_context *gk,
+					struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	struct rxgk_header *hdr;
+	struct krb5_buffer metadata;
+	unsigned int offset = sp->offset, len = sp->len;
+	size_t data_offset = 0, data_len = len;
+	u32 ac;
+	int ret = -ENOMEM;
+
+	_enter("");
+
+	crypto_krb5_where_is_the_data(gk->krb5, KRB5_CHECKSUM_MODE,
+				      &data_offset, &data_len);
+
+	hdr = kzalloc(sizeof(*hdr), GFP_NOFS);
+	if (!hdr)
+		return -ENOMEM;
+
+	hdr->epoch	= htonl(call->conn->proto.epoch);
+	hdr->cid	= htonl(call->cid);
+	hdr->call_number = htonl(call->call_id);
+	hdr->seq	= htonl(sp->hdr.seq);
+	hdr->sec_index	= htonl(call->security_ix);
+	hdr->data_len	= htonl(data_len);
+
+	metadata.len = sizeof(*hdr);
+	metadata.data = hdr;
+	ret = rxgk_verify_mic_skb(gk->krb5, gk->rx_Kc, &metadata,
+				  skb, &offset, &len, &ac);
+	kfree(hdr);
+	if (ret == -EPROTO) {
+		rxrpc_abort_eproto(call, skb, ac,
+				   rxgk_abort_1_verify_mic_eproto);
+	} else {
+		sp->offset = offset;
+		sp->len = len;
+	}
+
+	rxgk_put(gk);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Decrypt an encrypted packet (level 2 security).
+ */
+static int rxgk_verify_packet_encrypted(struct rxrpc_call *call,
+					struct rxgk_context *gk,
+					struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	struct rxgk_header hdr;
+	unsigned int offset = sp->offset, len = sp->len;
+	int ret;
+	u32 ac;
+
+	_enter("");
+
+	ret = rxgk_decrypt_skb(gk->krb5, gk->rx_enc, skb, &offset, &len, &ac);
+	if (ret == -EPROTO)
+		rxrpc_abort_eproto(call, skb, ac, rxgk_abort_2_decrypt_eproto);
+	if (ret < 0)
+		goto error;
+
+	if (len < sizeof(hdr)) {
+		ret = rxrpc_abort_eproto(call, skb, RXGK_PACKETSHORT,
+					 rxgk_abort_2_short_header);
+		goto error;
+	}
+
+	/* Extract the header from the skb */
+	ret = skb_copy_bits(skb, offset, &hdr, sizeof(hdr));
+	if (ret < 0) {
+		ret = rxrpc_abort_eproto(call, skb, RXGK_PACKETSHORT,
+					 rxgk_abort_2_short_encdata);
+		goto error;
+	}
+	offset += sizeof(hdr);
+	len -= sizeof(hdr);
+
+	if (ntohl(hdr.epoch)		!= call->conn->proto.epoch ||
+	    ntohl(hdr.cid)		!= call->cid ||
+	    ntohl(hdr.call_number)	!= call->call_id ||
+	    ntohl(hdr.seq)		!= sp->hdr.seq ||
+	    ntohl(hdr.sec_index)	!= call->security_ix ||
+	    ntohl(hdr.data_len)		> len) {
+		ret = rxrpc_abort_eproto(call, skb, RXGK_SEALED_INCON,
+					 rxgk_abort_2_short_data);
+		goto error;
+	}
+
+	sp->offset = offset;
+	sp->len = ntohl(hdr.data_len);
+	ret = 0;
+error:
+	rxgk_put(gk);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Verify the security on a received packet or subpacket (if part of a
+ * jumbo packet).
+ */
+static int rxgk_verify_packet(struct rxrpc_call *call, struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	struct rxgk_context *gk;
+	u16 key_number = sp->hdr.cksum;
+
+	_enter("{%d{%x}},{#%u}",
+	       call->debug_id, key_serial(call->conn->key), sp->hdr.seq);
+
+	gk = rxgk_get_key(call->conn, &key_number);
+	if (IS_ERR(gk)) {
+		switch (PTR_ERR(gk)) {
+		case -ESTALE:
+			return rxrpc_abort_eproto(call, skb, RXGK_BADKEYNO,
+						  rxgk_abort_bad_key_number);
+		default:
+			return PTR_ERR(gk);
+		}
+	}
+
+	switch (call->conn->security_level) {
+	case RXRPC_SECURITY_PLAIN:
+		return 0;
+	case RXRPC_SECURITY_AUTH:
+		return rxgk_verify_packet_integrity(call, gk, skb);
+	case RXRPC_SECURITY_ENCRYPT:
+		return rxgk_verify_packet_encrypted(call, gk, skb);
+	default:
+		rxgk_put(gk);
+		return -ENOANO;
+	}
+}
+
+/*
+ * Allocate memory to hold a challenge or a response packet.  We're not running
+ * in the io_thread, so we can't use ->tx_alloc.
+ */
+static struct page *rxgk_alloc_packet(size_t total_len)
+{
+	gfp_t gfp = GFP_NOFS;
+	int order;
+
+	order = get_order(total_len);
+	if (order > 0)
+		gfp |= __GFP_COMP;
+	return alloc_pages(gfp, order);
+}
+
+/*
+ * Issue a challenge.
+ */
+static int rxgk_issue_challenge(struct rxrpc_connection *conn)
+{
+	struct rxrpc_wire_header *whdr;
+	struct bio_vec bvec[1];
+	struct msghdr msg;
+	struct page *page;
+	size_t len = sizeof(*whdr) + sizeof(conn->rxgk.nonce);
+	u32 serial;
+	int ret;
+
+	_enter("{%d}", conn->debug_id);
+
+	get_random_bytes(&conn->rxgk.nonce, sizeof(conn->rxgk.nonce));
+
+	/* We can't use conn->tx_alloc without a lock */
+	page = rxgk_alloc_packet(sizeof(*whdr) + sizeof(conn->rxgk.nonce));
+	if (!page)
+		return -ENOMEM;
+
+	bvec_set_page(&bvec[0], page, len, 0);
+	iov_iter_bvec(&msg.msg_iter, WRITE, bvec, 1, len);
+
+	msg.msg_name	= &conn->peer->srx.transport;
+	msg.msg_namelen	= conn->peer->srx.transport_len;
+	msg.msg_control	= NULL;
+	msg.msg_controllen = 0;
+	msg.msg_flags	= MSG_SPLICE_PAGES;
+
+	whdr = page_address(page);
+	whdr->epoch	= htonl(conn->proto.epoch);
+	whdr->cid	= htonl(conn->proto.cid);
+	whdr->callNumber = 0;
+	whdr->seq	= 0;
+	whdr->type	= RXRPC_PACKET_TYPE_CHALLENGE;
+	whdr->flags	= conn->out_clientflag;
+	whdr->userStatus = 0;
+	whdr->securityIndex = conn->security_ix;
+	whdr->_rsvd	= 0;
+	whdr->serviceId	= htons(conn->service_id);
+
+	memcpy(whdr + 1, conn->rxgk.nonce, sizeof(conn->rxgk.nonce));
+
+	serial = rxrpc_get_next_serials(conn, 1);
+	whdr->serial = htonl(serial);
+
+	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
+	if (ret > 0)
+		conn->peer->last_tx_at = ktime_get_seconds();
+	__free_page(page);
+
+	if (ret < 0) {
+		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
+				    rxrpc_tx_point_rxgk_challenge);
+		return -EAGAIN;
+	}
+
+	trace_rxrpc_tx_packet(conn->debug_id, whdr,
+			      rxrpc_tx_point_rxgk_challenge);
+	_leave(" = 0");
+	return 0;
+}
+
+/*
+ * Validate a challenge packet.
+ */
+static bool rxgk_validate_challenge(struct rxrpc_connection *conn,
+				    struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	u8 nonce[20];
+
+	if (!conn->key) {
+		rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
+				 rxgk_abort_chall_no_key);
+		return false;
+	}
+
+	if (key_validate(conn->key) < 0) {
+		rxrpc_abort_conn(conn, skb, RXGK_EXPIRED, -EPROTO,
+				 rxgk_abort_chall_key_expired);
+		return false;
+	}
+		
+
+	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
+			  nonce, sizeof(nonce)) < 0) {
+		rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
+				 rxgk_abort_chall_short);
+		return false;
+	}
+
+	trace_rxrpc_rx_challenge(conn, sp->hdr.serial, 0, *(u32 *)nonce, 0);
+	return true;
+}
+
+/*
+ * Fill out the control message to pass to userspace to inform about the
+ * challenge.
+ */
+static int rxgk_challenge_to_recvmsg(struct rxrpc_connection *conn,
+				     struct sk_buff *challenge,
+				     struct msghdr *msg)
+{
+	struct rxgk_challenge chall;
+	struct rxgk_context *gk;
+
+	gk = rxgk_get_key(conn, NULL);
+
+	chall.base.service_id		= conn->service_id;
+	chall.base.security_index	= conn->security_ix;
+	chall.enctype			= gk->krb5->etype;
+	rxgk_put(gk);
+
+	return put_cmsg(msg, SOL_RXRPC, RXRPC_CHALLENGED, sizeof(chall), &chall);
+}
+
+/*
+ * Insert the requisite amount of XDR padding for the length given.
+ */
+static int rxgk_pad_out(struct sk_buff *response, size_t len, size_t offset)
+{
+	__be32 zero = 0;
+	size_t pad = xdr_round_up(len) - len;
+	int ret;
+
+	if (!pad)
+		return 0;
+
+	ret = skb_store_bits(response, offset, &zero, pad);
+	if (ret < 0)
+		return ret;
+	return pad;
+}
+
+/*
+ * Insert the header into the response.
+ */
+static noinline ssize_t rxgk_insert_response_header(struct rxrpc_connection *conn,
+						    struct rxgk_context *gk,
+						    struct sk_buff *response,
+						    size_t offset)
+{
+	struct {
+		struct rxrpc_wire_header whdr;
+		__be32 start_time_msw;
+		__be32 start_time_lsw;
+		__be32 ticket_len;
+	} h;
+	int ret;
+
+	h.whdr.epoch		= htonl(conn->proto.epoch);
+	h.whdr.cid		= htonl(conn->proto.cid);
+	h.whdr.callNumber	= 0;
+	h.whdr.serial		= 0;
+	h.whdr.seq		= 0;
+	h.whdr.type		= RXRPC_PACKET_TYPE_RESPONSE;
+	h.whdr.flags		= conn->out_clientflag;
+	h.whdr.userStatus	= 0;
+	h.whdr.securityIndex	= conn->security_ix;
+	h.whdr.cksum		= htons(gk->key_number);
+	h.whdr.serviceId	= htons(conn->service_id);
+	h.start_time_msw	= htonl(upper_32_bits(conn->rxgk.start_time));
+	h.start_time_lsw	= htonl(lower_32_bits(conn->rxgk.start_time));
+	h.ticket_len		= htonl(gk->key->ticket.len);
+
+	ret = skb_store_bits(response, offset, &h, sizeof(h));
+	return ret < 0 ? ret : sizeof(h);
+}
+
+/*
+ * Construct the authenticator to go in the response packet
+ *
+ * struct RXGK_Authenticator {
+ *	opaque nonce[20];
+ *	opaque appdata<>;
+ *	RXGK_Level level;
+ *	unsigned int epoch;
+ *	unsigned int cid;
+ *	unsigned int call_numbers<>;
+ * };
+ */
+static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
+					    struct sk_buff *challenge,
+					    const struct krb5_buffer *appdata,
+					    struct sk_buff *response,
+					    size_t offset)
+{
+	struct {
+		u8	nonce[20];
+		__be32	appdata_len;
+	} a;
+	struct {
+		__be32	level;
+		__be32	epoch;
+		__be32	cid;
+		__be32	call_numbers_count;
+		__be32	call_numbers[4];
+	} b;
+	int ret;
+
+	ret = skb_copy_bits(challenge, sizeof(struct rxrpc_wire_header),
+			    a.nonce, sizeof(a.nonce));
+	if (ret < 0)
+		return -EPROTO;
+
+	a.appdata_len = htonl(appdata->len);
+
+	ret = skb_store_bits(response, offset, &a, sizeof(a));
+	if (ret < 0)
+		return ret;
+	offset += sizeof(a);
+
+	if (appdata->len) {
+		ret = skb_store_bits(response, offset, appdata->data, appdata->len);
+		if (ret < 0)
+			return ret;
+		offset += appdata->len;
+
+		ret = rxgk_pad_out(response, appdata->len, offset);
+		if (ret < 0)
+			return ret;
+		offset += ret;
+	}
+
+	b.level			= htonl(conn->security_level);
+	b.epoch			= htonl(conn->proto.epoch);
+	b.cid			= htonl(conn->proto.cid);
+	b.call_numbers_count	= htonl(4);
+	b.call_numbers[0]	= htonl(conn->channels[0].call_counter);
+	b.call_numbers[1]	= htonl(conn->channels[1].call_counter);
+	b.call_numbers[2]	= htonl(conn->channels[2].call_counter);
+	b.call_numbers[3]	= htonl(conn->channels[3].call_counter);
+
+	ret = skb_store_bits(response, offset, &b, sizeof(b));
+	if (ret < 0)
+		return ret;
+	return sizeof(a) + xdr_round_up(appdata->len) + sizeof(b);
+}
+
+static ssize_t rxgk_encrypt_authenticator(struct rxrpc_connection *conn,
+					  struct rxgk_context *gk,
+					  struct sk_buff *response,
+					  size_t offset,
+					  size_t alloc_len,
+					  size_t auth_offset,
+					  size_t auth_len)
+{
+	struct scatterlist sg[16];
+	int nr_sg;
+
+	sg_init_table(sg, ARRAY_SIZE(sg));
+	nr_sg = skb_to_sgvec(response, sg, offset, alloc_len);
+	if (unlikely(nr_sg < 0))
+		return nr_sg;
+	return crypto_krb5_encrypt(gk->krb5, gk->resp_enc, sg, nr_sg, alloc_len,
+				   auth_offset, auth_len, false);
+}
+
+/*
+ * Construct the response.
+ *
+ * struct RXGK_Response {
+ *	rxgkTime start_time;
+ *	RXGK_Data token;
+ *	opaque authenticator<RXGK_MAXAUTHENTICATOR>
+ * };
+ */
+static int rxgk_construct_response(struct rxrpc_connection *conn,
+				   struct sk_buff *challenge,
+				   struct krb5_buffer *appdata)
+{
+	struct rxrpc_skb_priv *csp, *rsp;
+	struct rxgk_context *gk;
+	struct sk_buff *response;
+	size_t len, auth_len, authx_len, offset, auth_offset, authx_offset;
+	__be32 tmp;
+	int ret;
+
+	gk = rxgk_get_key(conn, NULL);
+	if (IS_ERR(gk))
+		return PTR_ERR(gk);
+
+	auth_len = 20 + (4 + appdata->len) + 12 + (1 + 4) * 4;
+	authx_len = crypto_krb5_how_much_buffer(gk->krb5, KRB5_ENCRYPT_MODE,
+						auth_len, &auth_offset);
+	len = sizeof(struct rxrpc_wire_header) +
+		8 + (4 + xdr_round_up(gk->key->ticket.len)) + (4 + authx_len);
+
+	response = alloc_skb_with_frags(0, len, 0, &ret, GFP_NOFS);
+	if (!response)
+		goto error;
+	response->len = len;
+	response->data_len = len;
+
+	ret = rxgk_insert_response_header(conn, gk, response, 0);
+	if (ret < 0)
+		goto error;
+	offset = ret;
+
+	ret = skb_store_bits(response, offset, gk->key->ticket.data, gk->key->ticket.len);
+	if (ret < 0)
+		goto error;
+	offset += gk->key->ticket.len;
+	ret = rxgk_pad_out(response, gk->key->ticket.len, offset);
+	if (ret < 0)
+		goto error;
+
+	authx_offset = offset + ret + 4; /* Leave a gap for the length. */
+
+	ret = rxgk_construct_authenticator(conn, challenge, appdata, response,
+					   authx_offset + auth_offset);
+	if (ret < 0)
+		goto error;
+	auth_len = ret;
+
+	ret = rxgk_encrypt_authenticator(conn, gk, response,
+					 authx_offset, authx_len,
+					 auth_offset, auth_len);
+	if (ret < 0)
+		goto error;
+	authx_len = ret;
+
+	tmp = htonl(authx_len);
+	ret = skb_store_bits(response, authx_offset - 4, &tmp, 4);
+	if (ret < 0)
+		goto error;
+
+	ret = rxgk_pad_out(response, authx_len, authx_offset + authx_len);
+	if (ret < 0)
+		return ret;
+	len = authx_offset + authx_len + ret;
+
+	if (len != response->len) {
+		response->len = len;
+		response->data_len = len;
+	}
+
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
+	rxgk_put(gk);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Respond to a challenge packet.
+ */
+static int rxgk_respond_to_challenge(struct rxrpc_connection *conn,
+				     struct sk_buff *challenge,
+				     struct krb5_buffer *appdata)
+{
+	_enter("{%d,%x}", conn->debug_id, key_serial(conn->key));
+
+	if (key_validate(conn->key) < 0)
+		return rxrpc_abort_conn(conn, NULL, RXGK_EXPIRED, -EPROTO,
+					rxgk_abort_chall_key_expired);
+
+	return rxgk_construct_response(conn, challenge, appdata);
+}
+
+static int rxgk_respond_to_challenge_no_appdata(struct rxrpc_connection *conn,
+						struct sk_buff *challenge)
+{
+	struct krb5_buffer appdata = {};
+
+	return rxgk_respond_to_challenge(conn, challenge, &appdata);
+}
+
+/**
+ * rxgk_kernel_respond_to_challenge - Respond to a challenge with appdata
+ * @call: The call used as a reference for the connection
+ * @appdata: The application data to include in the RESPONSE authenticator
+ *
+ * Allow a kernel application to respond to a CHALLENGE with application data
+ * to be included in the RxGK RESPONSE Authenticator.
+ */
+int rxgk_kernel_respond_to_challenge(struct rxrpc_call *call,
+				     struct krb5_buffer *appdata)
+{
+	if (!call->challenge) {
+		kleave(" = -EP");
+		return -EPROTO;
+	}
+	return rxgk_respond_to_challenge(call->conn, call->challenge, appdata);
+}
+EXPORT_SYMBOL(rxgk_kernel_respond_to_challenge);
+
+/*
+ * Parse sendmsg() control message and respond to challenge.  We need to see if
+ * there's an appdata to fish out.
+ */
+static int rxgk_sendmsg_respond_to_challenge(struct rxrpc_call *call,
+					     struct msghdr *msg)
+{
+	struct krb5_buffer appdata = {};
+	struct sk_buff *challenge = call->challenge;
+	struct cmsghdr *cmsg;
+	int ret = -EINVAL;
+
+	if (!challenge)
+		return -EPROTO;
+	call->challenge = NULL;
+
+	for_each_cmsghdr(cmsg, msg) {
+		if (cmsg->cmsg_level != SOL_RXRPC ||
+		    cmsg->cmsg_type != RXRPC_RESP_RXGK_APPDATA)
+			continue;
+		if (appdata.data)
+			goto out;
+		appdata.data = CMSG_DATA(cmsg);
+		appdata.len = cmsg->cmsg_len - sizeof(struct cmsghdr);
+	}
+
+	ret = rxgk_respond_to_challenge(call->conn, challenge, &appdata);
+out:
+	rxrpc_free_skb(challenge, rxrpc_skb_put_challenge);
+	return ret;
+}
+
+/*
+ * Verify the authenticator.
+ *
+ * struct RXGK_Authenticator {
+ *	opaque nonce[20];
+ *	opaque appdata<>;
+ *	RXGK_Level level;
+ *	unsigned int epoch;
+ *	unsigned int cid;
+ *	unsigned int call_numbers<>;
+ * };
+ */
+static int rxgk_do_verify_authenticator(struct rxrpc_connection *conn,
+					const struct krb5_enctype *krb5,
+					struct sk_buff *skb,
+					__be32 *p, __be32 *end)
+{
+	u32 app_len, call_count, level, epoch, cid, i;
+
+	_enter("");
+
+	if (memcmp(p, conn->rxgk.nonce, 20) != 0)
+		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+					rxgk_abort_resp_bad_nonce);
+	p += 20 / sizeof(__be32);
+
+	app_len	= ntohl(*p++);
+	if (app_len > (end - p) * sizeof(__be32))
+		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+					rxgk_abort_resp_short_applen);
+
+	p += xdr_round_up(app_len) / sizeof(__be32);
+	if (end - p < 4)
+		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+					rxgk_abort_resp_short_applen);
+
+	level	= ntohl(*p++);
+	epoch	= ntohl(*p++);
+	cid	= ntohl(*p++);
+	call_count = ntohl(*p++);
+
+	if (level	!= conn->security_level ||
+	    epoch	!= conn->proto.epoch ||
+	    cid		!= conn->proto.cid ||
+	    call_count	> 4)
+		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+					rxgk_abort_resp_bad_param);
+
+	if (end - p < call_count)
+		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+					rxgk_abort_resp_short_call_list);
+
+	for (i = 0; i < call_count; i++) {
+		u32 call_id = ntohl(*p++);
+
+		if (call_id > INT_MAX)
+			return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+						rxgk_abort_resp_bad_callid);
+
+		if (call_id < conn->channels[i].call_counter)
+			return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+						rxgk_abort_resp_call_ctr);
+
+		if (call_id > conn->channels[i].call_counter) {
+			if (conn->channels[i].call)
+				return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+							rxgk_abort_resp_call_state);
+
+			conn->channels[i].call_counter = call_id;
+		}
+	}
+
+	_leave(" = 0");
+	return 0;
+}
+
+/*
+ * Extract the authenticator and verify it.
+ */
+static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
+				     const struct krb5_enctype *krb5,
+				     struct sk_buff *skb,
+				     unsigned int auth_offset, unsigned int auth_len)
+{
+	void *auth;
+	__be32 *p;
+	int ret;
+
+	auth = kmalloc(auth_len, GFP_NOFS);
+	if (!auth)
+		return -ENOMEM;
+
+	ret = skb_copy_bits(skb, auth_offset, auth, auth_len);
+	if (ret < 0) {
+		ret = rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+				       rxgk_abort_resp_short_auth);
+		goto error;
+	}
+
+	p = auth;
+	ret = rxgk_do_verify_authenticator(conn, krb5, skb, p, p + auth_len);
+error:
+	kfree(auth);
+	return ret;
+}
+
+/*
+ * Verify a response.
+ *
+ * struct RXGK_Response {
+ *	rxgkTime	start_time;
+ *	RXGK_Data	token;
+ *	opaque		authenticator<RXGK_MAXAUTHENTICATOR>
+ * };
+ */
+static int rxgk_verify_response(struct rxrpc_connection *conn,
+				struct sk_buff *skb)
+{
+	const struct krb5_enctype *krb5;
+	struct rxrpc_key_token *token;
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	struct rxgk_response rhdr;
+	struct rxgk_context *gk;
+	struct key *key = NULL;
+	unsigned int offset = sizeof(struct rxrpc_wire_header);
+	unsigned int len = skb->len - sizeof(struct rxrpc_wire_header);
+	unsigned int token_offset, token_len;
+	unsigned int auth_offset, auth_len;
+	__be32 xauth_len;
+	int ret, ec;
+
+	_enter("{%d}", conn->debug_id);
+
+	/* Parse the RXGK_Response object */
+	if (sizeof(rhdr) + sizeof(__be32) > len)
+		goto short_packet;
+
+	if (skb_copy_bits(skb, offset, &rhdr, sizeof(rhdr)) < 0)
+		goto short_packet;
+	offset	+= sizeof(rhdr);
+	len	-= sizeof(rhdr);
+
+	token_offset	= offset;
+	token_len	= ntohl(rhdr.token_len);
+	if (xdr_round_up(token_len) + sizeof(__be32) > len)
+		goto short_packet;
+
+	offset	+= xdr_round_up(token_len);
+	len	-= xdr_round_up(token_len);
+
+	if (skb_copy_bits(skb, offset, &xauth_len, sizeof(xauth_len)) < 0)
+		goto short_packet;
+	offset	+= sizeof(xauth_len);
+	len	-= sizeof(xauth_len);
+
+	auth_offset	= offset;
+	auth_len	= ntohl(xauth_len);
+	if (auth_len < len)
+		goto short_packet;
+	if (auth_len & 3)
+		goto inconsistent;
+	if (auth_len < 20 + 9 * 4)
+		goto auth_too_short;
+
+	/* We need to extract and decrypt the token and instantiate a session
+	 * key for it.  This bit, however, is application-specific.  If
+	 * possible, we use a default parser, but we might end up bumping this
+	 * to the app to deal with - which might mean a round trip to
+	 * userspace.
+	 */
+	ret = rxgk_extract_token(conn, skb, token_offset, token_len, &key);
+	if (ret < 0)
+		goto out;
+
+	/* We now have a key instantiated from the decrypted ticket.  We can
+	 * pass this to the application so that they can parse the ticket
+	 * content and we can use the session key it contains to derive the
+	 * keys we need.
+	 *
+	 * Note that we have to switch enctype at this point as the enctype of
+	 * the ticket doesn't necessarily match that of the transport.
+	 */
+	token = key->payload.data[0];
+	conn->security_level = token->rxgk->level;
+	conn->rxgk.start_time = __be64_to_cpu(rhdr.start_time);
+
+	gk = rxgk_generate_transport_key(conn, token->rxgk, sp->hdr.cksum, GFP_NOFS);
+	if (IS_ERR(gk)) {
+		ret = PTR_ERR(gk);
+		goto cant_get_token;
+	}
+
+	krb5 = gk->krb5;
+
+	trace_rxrpc_rx_response(conn, sp->hdr.serial, krb5->etype, sp->hdr.cksum, token_len);
+
+	/* Decrypt, parse and verify the authenticator. */
+	ret = rxgk_decrypt_skb(krb5, gk->resp_enc, skb,
+			       &auth_offset, &auth_len, &ec);
+	if (ret < 0) {
+		rxrpc_abort_conn(conn, skb, RXGK_SEALED_INCON, ret,
+				 rxgk_abort_resp_auth_dec);
+		goto out;
+	}
+
+	ret = rxgk_verify_authenticator(conn, krb5, skb, auth_offset, auth_len);
+	if (ret < 0)
+		goto out;
+
+	conn->key = key;
+	key = NULL;
+	ret = 0;
+out:
+	key_put(key);
+	_leave(" = %d", ret);
+	return ret;
+
+inconsistent:
+	ret = rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
+			       rxgk_abort_resp_xdr_align);
+	goto out;
+auth_too_short:
+	ret = rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
+			       rxgk_abort_resp_short_auth);
+	goto out;
+short_packet:
+	ret = rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
+			       rxgk_abort_resp_short_packet);
+	goto out;
+
+cant_get_token:
+	switch (ret) {
+	case -ENOMEM:
+		goto temporary_error;
+	case -EINVAL:
+		ret = rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EKEYREJECTED,
+				       rxgk_abort_resp_internal_error);
+		goto out;
+	case -ENOPKG:
+		ret = rxrpc_abort_conn(conn, skb, RXGK_BADETYPE, -EKEYREJECTED,
+				       rxgk_abort_resp_nopkg);
+		goto out;
+	}
+
+temporary_error:
+	/* Ignore the response packet if we got a temporary error such as
+	 * ENOMEM.  We just want to send the challenge again.  Note that we
+	 * also come out this way if the ticket decryption fails.
+	 */
+	goto out;
+}
+
+/*
+ * clear the connection security
+ */
+static void rxgk_clear(struct rxrpc_connection *conn)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(conn->rxgk.keys); i++)
+		rxgk_put(conn->rxgk.keys[i]);
+}
+
+/*
+ * Initialise the RxGK security service.
+ */
+static int rxgk_init(void)
+{
+	return 0;
+}
+
+/*
+ * Clean up the RxGK security service.
+ */
+static void rxgk_exit(void)
+{
+}
+
+/*
+ * RxRPC YFS GSSAPI-based security
+ */
+const struct rxrpc_security rxgk_yfs = {
+	.name				= "yfs-rxgk",
+	.security_index			= RXRPC_SECURITY_YFS_RXGK,
+	.no_key_abort			= RXGK_NOTAUTH,
+	.init				= rxgk_init,
+	.exit				= rxgk_exit,
+	.preparse_server_key		= rxgk_preparse_server_key,
+	.free_preparse_server_key	= rxgk_free_preparse_server_key,
+	.destroy_server_key		= rxgk_destroy_server_key,
+	.describe_server_key		= rxgk_describe_server_key,
+	.init_connection_security	= rxgk_init_connection_security,
+	.alloc_txbuf			= rxgk_alloc_txbuf,
+	.secure_packet			= rxgk_secure_packet,
+	.verify_packet			= rxgk_verify_packet,
+	.free_call_crypto		= rxgk_free_call_crypto,
+	.issue_challenge		= rxgk_issue_challenge,
+	.validate_challenge		= rxgk_validate_challenge,
+	.challenge_to_recvmsg		= rxgk_challenge_to_recvmsg,
+	.sendmsg_respond_to_challenge	= rxgk_sendmsg_respond_to_challenge,
+	.respond_to_challenge		= rxgk_respond_to_challenge_no_appdata,
+	.verify_response		= rxgk_verify_response,
+	.clear				= rxgk_clear,
+	.default_decode_ticket		= rxgk_yfs_decode_ticket,
+};
diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
new file mode 100644
index 000000000000..58d1a062eb01
--- /dev/null
+++ b/net/rxrpc/rxgk_app.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Application-specific bits for GSSAPI-based RxRPC security
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/net.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/key-type.h>
+#include "ar-internal.h"
+#include "rxgk_common.h"
+
+/*
+ * Decode a default-style YFS ticket in a response and turn it into an
+ * rxrpc-type key.
+ *
+ * struct rxgk_key {
+ *	afs_uint32	enctype;
+ *	opaque		key<>;
+ * };
+ *
+ * struct RXGK_AuthName {
+ *	afs_int32	kind;
+ *	opaque		data<AUTHDATAMAX>;
+ *	opaque		display<AUTHPRINTABLEMAX>;
+ * };
+ *
+ * struct RXGK_Token {
+ *	rxgk_key		K0;
+ *	RXGK_Level		level;
+ *	rxgkTime		starttime;
+ *	afs_int32		lifetime;
+ *	afs_int32		bytelife;
+ *	rxgkTime		expirationtime;
+ *	struct RXGK_AuthName	identities<>;
+ * };
+ */
+int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
+			   unsigned int ticket_offset, unsigned int ticket_len,
+			   struct key **_key)
+{
+	struct rxrpc_key_token *token;
+	const struct cred *cred = current_cred(); // TODO - use socket creds
+	struct key *key;
+	size_t pre_ticket_len, payload_len;
+	unsigned int klen, enctype;
+	void *payload, *ticket;
+	__be32 *t, *p, *q, tmp[2];
+	int ret;
+
+	_enter("");
+
+	/* Get the session key length */
+	ret = skb_copy_bits(skb, ticket_offset, tmp, sizeof(tmp));
+	if (ret < 0)
+		return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
+					rxgk_abort_resp_short_yfs_klen);
+	enctype = ntohl(tmp[0]);
+	klen = ntohl(tmp[1]);
+
+	if (klen > ticket_len - 10 * sizeof(__be32))
+		return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
+					rxgk_abort_resp_short_yfs_key);
+
+	pre_ticket_len = ((5 + 14) * sizeof(__be32) +
+			  xdr_round_up(klen) +
+			  sizeof(__be32));
+	payload_len = pre_ticket_len + xdr_round_up(ticket_len);
+
+	payload = kzalloc(payload_len, GFP_NOFS);
+	if (!payload)
+		return -ENOMEM;
+
+	/* We need to fill out the XDR form for a key payload that we can pass
+	 * to add_key().  Start by copying in the ticket so that we can parse
+	 * it.
+	 */
+	ticket = payload + pre_ticket_len;
+	ret = skb_copy_bits(skb, ticket_offset, ticket, ticket_len);
+	if (ret < 0) {
+		ret = rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
+				       rxgk_abort_resp_short_yfs_tkt);
+		goto error;
+	}
+
+	/* Fill out the form header. */
+	p = payload;
+	p[0] = htonl(0); /* Flags */
+	p[1] = htonl(1); /* len(cellname) */
+	p[2] = htonl(0x20000000); /* Cellname " " */
+	p[3] = htonl(1); /* #tokens */
+	p[4] = htonl(15 * sizeof(__be32) + xdr_round_up(klen) +
+		     xdr_round_up(ticket_len)); /* Token len */
+
+	/* Now fill in the body.  Most of this we can just scrape directly from
+	 * the ticket.
+	 */
+	t = ticket + sizeof(__be32) * 2 + xdr_round_up(klen);
+	q = payload + 5 * sizeof(__be32);
+	q[0]  = htonl(RXRPC_SECURITY_YFS_RXGK);
+	q[1]  = t[1];		/* begintime - msw */
+	q[2]  = t[2];		/* - lsw */
+	q[3]  = t[5];		/* endtime - msw */
+	q[4]  = t[6];		/* - lsw */
+	q[5]  = 0;		/* level - msw */
+	q[6]  = t[0];		/* - lsw */
+	q[7]  = 0;		/* lifetime - msw */
+	q[8]  = t[3];		/* - lsw */
+	q[9]  = 0;		/* bytelife - msw */
+	q[10] = t[4];		/* - lsw */
+	q[11] = 0;		/* enctype - msw */
+	q[12] = htonl(enctype);	/* - lsw */
+	q[13] = htonl(klen);	/* Key length */
+
+	q += 14;
+
+	memcpy(q, ticket + sizeof(__be32) * 2, klen);
+	q += xdr_round_up(klen) / 4;
+	q[0] = htonl(ticket_len);
+	q++;
+	if (WARN_ON((unsigned long)q != (unsigned long)ticket)) {
+		ret = -EIO;
+		goto error;
+	}
+
+	/* Ticket read in with skb_copy_bits above */
+	q += xdr_round_up(ticket_len) / 4;
+	if (WARN_ON((unsigned long)q - (unsigned long)payload != payload_len)) {
+		ret = -EIO;
+		goto error;
+	}
+
+	/* Now turn that into a key. */
+	key = key_alloc(&key_type_rxrpc, "x",
+			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred, // TODO: Use socket owner
+			KEY_USR_VIEW,
+			KEY_ALLOC_NOT_IN_QUOTA, NULL);
+	if (IS_ERR(key)) {
+		_leave(" = -ENOMEM [alloc %ld]", PTR_ERR(key));
+		goto error;
+	}
+
+	_debug("key %d", key_serial(key));
+
+	ret = key_instantiate_and_link(key, payload, payload_len, NULL, NULL);
+	if (ret < 0)
+		goto error_key;
+
+	token = key->payload.data[0];
+	token->no_leak_key = true;
+	*_key = key;
+	key = NULL;
+	ret = 0;
+	goto error;
+
+error_key:
+	key_put(key);
+error:
+	kfree_sensitive(payload);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Extract the token and set up a session key from the details.
+ *
+ * struct RXGK_TokenContainer {
+ *	afs_int32	kvno;
+ *	afs_int32	enctype;
+ *	opaque		encrypted_token<>;
+ * };
+ *
+ * [tools.ietf.org/html/draft-wilkinson-afs3-rxgk-afs-08 sec 6.1]
+ */
+int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
+		       unsigned int token_offset, unsigned int token_len,
+		       struct key **_key)
+{
+	const struct krb5_enctype *krb5;
+	const struct krb5_buffer *server_secret;
+	struct crypto_aead *token_enc = NULL;
+	struct key *server_key;
+	unsigned int ticket_offset, ticket_len;
+	u32 kvno, enctype;
+	int ret, ec;
+
+	struct {
+		__be32 kvno;
+		__be32 enctype;
+		__be32 token_len;
+	} container;
+
+	/* Decode the RXGK_TokenContainer object.  This tells us which server
+	 * key we should be using.  We can then fetch the key, get the secret
+	 * and set up the crypto to extract the token.
+	 */
+	if (skb_copy_bits(skb, token_offset, &container, sizeof(container)) < 0)
+		return rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
+					rxgk_abort_resp_tok_short);
+
+	kvno		= ntohl(container.kvno);
+	enctype		= ntohl(container.enctype);
+	ticket_len	= ntohl(container.token_len);
+	ticket_offset	= token_offset + sizeof(container);
+
+	if (xdr_round_up(ticket_len) > token_len - 3 * 4)
+		return rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
+					rxgk_abort_resp_tok_short);
+
+	_debug("KVNO %u", kvno);
+	_debug("ENC  %u", enctype);
+	_debug("TLEN %u", ticket_len);
+
+	server_key = rxrpc_look_up_server_security(conn, skb, kvno, enctype);
+	if (IS_ERR(server_key))
+		goto cant_get_server_key;
+
+	down_read(&server_key->sem);
+	server_secret = (const void *)&server_key->payload.data[2];
+	ret = rxgk_set_up_token_cipher(server_secret, &token_enc, enctype, &krb5, GFP_NOFS);
+	up_read(&server_key->sem);
+	key_put(server_key);
+	if (ret < 0)
+		goto cant_get_token;
+
+	/* We can now decrypt and parse the token/ticket.  This allows us to
+	 * gain access to K0, from which we can derive the transport key and
+	 * thence decode the authenticator.
+	 */
+	ret = rxgk_decrypt_skb(krb5, token_enc, skb,
+			       &ticket_offset, &ticket_len, &ec);
+	crypto_free_aead(token_enc);
+	token_enc = NULL;
+	if (ret < 0)
+		return rxrpc_abort_conn(conn, skb, ec, ret,
+					rxgk_abort_resp_tok_dec);
+
+	ret = conn->security->default_decode_ticket(conn, skb, ticket_offset,
+						    ticket_len, _key);
+	if (ret < 0)
+		goto cant_get_token;
+
+	_leave(" = 0");
+	return ret;
+
+cant_get_server_key:
+	ret = PTR_ERR(server_key);
+	switch (ret) {
+	case -ENOMEM:
+		goto temporary_error;
+	case -ENOKEY:
+	case -EKEYREJECTED:
+	case -EKEYEXPIRED:
+	case -EKEYREVOKED:
+	case -EPERM:
+		return rxrpc_abort_conn(conn, skb, RXGK_BADKEYNO, -EKEYREJECTED,
+					rxgk_abort_resp_tok_nokey);
+	default:
+		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EKEYREJECTED,
+					rxgk_abort_resp_tok_keyerr);
+	}
+
+cant_get_token:
+	switch (ret) {
+	case -ENOMEM:
+		goto temporary_error;
+	case -EINVAL:
+		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EKEYREJECTED,
+					rxgk_abort_resp_tok_internal_error);
+	case -ENOPKG:
+		return rxrpc_abort_conn(conn, skb, RXGK_BADETYPE, -EKEYREJECTED,
+					rxgk_abort_resp_tok_nopkg);
+	}
+
+temporary_error:
+	/* Ignore the response packet if we got a temporary error such as
+	 * ENOMEM.  We just want to send the challenge again.  Note that we
+	 * also come out this way if the ticket decryption fails.
+	 */
+	return ret;
+}
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
index da1464e65766..96dd64086ed9 100644
--- a/net/rxrpc/rxgk_common.h
+++ b/net/rxrpc/rxgk_common.h
@@ -33,6 +33,18 @@ struct rxgk_context {
 	struct crypto_aead	*resp_enc;	/* Response packet enc key */
 };
 
+#define xdr_round_up(x) (round_up((x), sizeof(__be32)))
+
+/*
+ * rxgk_app.c
+ */
+int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
+			   unsigned int ticket_offset, unsigned int ticket_len,
+			   struct key **_key);
+int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
+		       unsigned int token_offset, unsigned int token_len,
+		       struct key **_key);
+
 /*
  * rxgk_kdf.c
  */
@@ -46,3 +58,81 @@ int rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
 			     unsigned int enctype,
 			     const struct krb5_enctype **_krb5,
 			     gfp_t gfp);
+
+/*
+ * Apply decryption and checksumming functions to part of an skbuff.  The
+ * offset and length are updated to reflect the actual content of the encrypted
+ * region.
+ */
+static inline
+int rxgk_decrypt_skb(const struct krb5_enctype *krb5,
+		     struct crypto_aead *aead,
+		     struct sk_buff *skb,
+		     unsigned int *_offset, unsigned int *_len,
+		     int *_error_code)
+{
+	struct scatterlist sg[16];
+	size_t offset = 0, len = *_len;
+	int nr_sg, ret;
+
+	sg_init_table(sg, ARRAY_SIZE(sg));
+	nr_sg = skb_to_sgvec(skb, sg, *_offset, len);
+	if (unlikely(nr_sg < 0))
+		return nr_sg;
+
+	ret = crypto_krb5_decrypt(krb5, aead, sg, nr_sg,
+				  &offset, &len);
+	switch (ret) {
+	case 0:
+		*_offset += offset;
+		*_len = len;
+		break;
+	case -EPROTO:
+	case -EBADMSG:
+		*_error_code = RXGK_SEALED_INCON;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Check the MIC on a region of an skbuff.  The offset and length are updated
+ * to reflect the actual content of the secure region.
+ */
+static inline
+int rxgk_verify_mic_skb(const struct krb5_enctype *krb5,
+			struct crypto_shash *shash,
+			const struct krb5_buffer *metadata,
+			struct sk_buff *skb,
+			unsigned int *_offset, unsigned int *_len,
+			u32 *_error_code)
+{
+	struct scatterlist sg[16];
+	size_t offset = 0, len = *_len;
+	int nr_sg, ret;
+
+	sg_init_table(sg, ARRAY_SIZE(sg));
+	nr_sg = skb_to_sgvec(skb, sg, *_offset, len);
+	if (unlikely(nr_sg < 0))
+		return nr_sg;
+
+	ret = crypto_krb5_verify_mic(krb5, shash, metadata, sg, nr_sg,
+				     &offset, &len);
+	switch (ret) {
+	case 0:
+		*_offset += offset;
+		*_len = len;
+		break;
+	case -EPROTO:
+	case -EBADMSG:
+		*_error_code = RXGK_SEALED_INCON;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 300b0138e49e..e5d8a7c770da 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -177,8 +177,10 @@ static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct rxrpc_call *call, size_t rem
 	if (!txb)
 		return NULL;
 
-	txb->offset += shdr;
-	txb->space = part;
+	txb->crypto_header	= 0;
+	txb->sec_header		= shdr;
+	txb->offset		+= shdr;
+	txb->space		= part;
 	return txb;
 }
 
diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
index 9784adc8f275..078d91a6b77f 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -20,6 +20,9 @@ static const struct rxrpc_security *rxrpc_security_types[] = {
 #ifdef CONFIG_RXKAD
 	[RXRPC_SECURITY_RXKAD]	= &rxkad,
 #endif
+#ifdef CONFIG_RXGK
+	[RXRPC_SECURITY_YFS_RXGK] = &rxgk_yfs,
+#endif
 };
 
 int __init rxrpc_init_security(void)


