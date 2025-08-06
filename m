Return-Path: <linux-fsdevel+bounces-56903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15402B1CDCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF3418C653E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582692D3746;
	Wed,  6 Aug 2025 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CF4zmUw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA992D3732
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512758; cv=none; b=TL6g/oW1j2KW96PecFYzo5NNhaQOS1aMklZ4tkRDo4IUmd2a4YXHuYY3JmbNz7wo/Eo7hFj0XIZt6HmCtJAXJvpTXwkRVdeL0JUw/MEDISpC6txk2LX91JmPlzjjWyDqb0bWR8HuY7dBNGAffkOdSuB87fK9C86KeCctgQOBnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512758; c=relaxed/simple;
	bh=QntpqNUVgYTVtBSXzFZ+NxT/K9ws0ueULFx/abmOvis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeZoxPXDD6nqO8a3u8EABejZTif/qYp2nIgw5BYODwO8Ssc0MtDIbxnC/6eLuovo2f90CP4SseLdveh9nWAfcEpz1dgxgKqDsKu6oYMtIUzac3UBCtNk7uSXEF5qOPj+20ikSbqcJHLOBM+AsP+R1RbVvtG1glTU8gnn4Cp7tng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CF4zmUw2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TWFDe3ULvHcZ6pORsVwekyETTBpEwWps6j7AzyH0q4=;
	b=CF4zmUw271b6R1xtXdZdfi2JCjeO/FMQfjmAIlmz2Oho5HxIzyx+yISwuX90guXtQEr67j
	X11X0VTxyP+Fz041V7QVkuh4Msz7churgT/yuz+xmvIxn1KO5DBaNor1uS96C2RqtvDaXD
	NhNXE0kX26qQAa26YlH6bFHCoSgpSaA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-Ck5Pq_d0NlmzUyZCqg53_Q-1; Wed,
 06 Aug 2025 16:39:07 -0400
X-MC-Unique: Ck5Pq_d0NlmzUyZCqg53_Q-1
X-Mimecast-MFC-AGG-ID: Ck5Pq_d0NlmzUyZCqg53_Q_1754512746
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1582E1956094;
	Wed,  6 Aug 2025 20:39:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00A471956094;
	Wed,  6 Aug 2025 20:39:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 23/31] cifs: Add more pieces to smb_message
Date: Wed,  6 Aug 2025 21:36:44 +0100
Message-ID: <20250806203705.2560493-24-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add more pieces to the smb_message struct to facilitate future changes.

Also move towards not needing the server pointer in smb_message.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h      |   7 ++
 fs/smb/client/cifsproto.h     |  15 +++
 fs/smb/client/cifstransport.c |   2 +-
 fs/smb/client/smb2ops.c       |  10 ++
 fs/smb/client/smb2pdu.c       | 198 ++++++++++++++++++++++++++++++++++
 fs/smb/client/smb2proto.h     |   1 +
 fs/smb/client/transport.c     |  28 ++++-
 7 files changed, 259 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 045a29cedf0e..0cc71f504c68 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1774,7 +1774,12 @@ struct smb_message {
 	/* Request details */
 	enum smb2_command	command_id;	/* Command ID */
 	s16			pre_offset;	/* Offset of pre-headers from ->body (negative) */
+	u16			ext_offset;	/* Offset of extensions from ->body */
+	u16			latest_record;	/* Offset of latest context record (or 0) */
+	u16			offset;		/* Running offset during assembly */
+	u16			data_offset;	/* Offset of data in message (maybe in ->body) */
 	unsigned int		total_len;	/* Total length of from hdr_offset onwards */
+	struct iov_iter		iter;		/* Data iterator */
 	/* Response */
 	void			*response;	/* Protocol part of response */
 	u32			response_len;	/* Size of response */
@@ -1782,6 +1787,8 @@ struct smb_message {
 	struct smb_rqst		rqst;
 	int			*resp_buf_type;
 	struct kvec		*resp_iov;
+	/* Variable-length request fragment list - must be last! */
+	struct bvecq		bvecq;		/* List of request frags (passed to socket) */
 };
 
 struct close_cancelled_open {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index ccd70a402567..60a0c9b64d98 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -765,8 +765,23 @@ void smb_see_message(struct smb_message *smb, enum smb_message_trace trace);
 void smb_get_message(struct smb_message *smb, enum smb_message_trace trace);
 void smb_put_message(struct smb_message *smb, enum smb_message_trace trace);
 void smb_put_messages(struct smb_message *smb);
+void smb_clear_request(struct smb_message *smb);
 
 void *cifs_allocate_tx_buf(struct TCP_Server_Info *server, size_t size);
 void cifs_free_tx_buf(void *p);
 
+/*
+ * Add a segment to a message.  This should be allocated with
+ * cifs_allocate_tx_buf() so that it can be used with MSG_SPLICE_PAGES.
+ */
+static inline void smb_add_segment_to_tx_buf(struct smb_message *smb,
+					     void *key_buf, size_t size)
+{
+	unsigned int nr = smb->bvecq.nr_segs;
+
+	bvec_set_virt(&smb->bvecq.bv[nr], key_buf, size);
+	smb->bvecq.nr_segs = nr++;
+	smb->total_len += size;
+}
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 1e2a8839d742..b93dd2be68e1 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -177,7 +177,7 @@ cifs_check_receive(struct smb_message *smb, struct TCP_Server_Info *server,
 	}
 
 	/* BB special case reconnect tid and uid here? */
-	return map_and_check_smb_error(smb, log_error);
+	return map_and_check_smb_error(server, smb, log_error);
 }
 
 int
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1e24489b55e3..9db383ec22e8 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2602,6 +2602,16 @@ smb2_set_replay(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	shdr->Flags |= SMB2_FLAGS_REPLAY_OPERATION;
 }
 
+void smb2_set_replay_smb(struct TCP_Server_Info *server, struct smb_message *smb)
+{
+	struct smb2_hdr *shdr = smb->request;
+
+	if (server->dialect < SMB30_PROT_ID)
+		return;
+
+	shdr->Flags |= SMB2_FLAGS_REPLAY_OPERATION;
+}
+
 void
 smb2_set_related(struct smb_rqst *rqst)
 {
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 3009acf0d884..58a2a4ff3368 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -91,6 +91,204 @@ int smb3_encryption_required(const struct cifs_tcon *tcon)
 	return 0;
 }
 
+static void smb2_enc_header(struct smb_message *smb,
+			    const struct cifs_tcon *tcon,
+			    struct TCP_Server_Info *server)
+{
+	struct smb2_hdr *shdr = smb->request;
+	struct smb3_hdr_req *smb3_hdr = (struct smb3_hdr_req *)shdr;
+
+	shdr->ProtocolId	= SMB2_PROTO_NUMBER;
+	shdr->StructureSize	= cpu_to_le16(64);
+	shdr->CreditCharge	= 0;
+	shdr->Status		= 0; /* ChanSeq for smb3 */
+	shdr->Command		= cpu_to_le16(smb->command_id);
+	shdr->CreditRequest	= cpu_to_le16(2);
+	shdr->Flags		= 0;
+	shdr->NextCommand	= 0;
+	shdr->MessageId		= 0;
+	shdr->Id.SyncId.ProcessId = cpu_to_le32((__u16)current->tgid);
+	shdr->SessionId		= 0;
+
+	if (server) {
+		/* After reconnect SMB3 must set ChannelSequence on subsequent reqs */
+		if (server->dialect >= SMB30_PROT_ID) {
+			/*
+			 * if primary channel is not set yet, use default
+			 * channel for chan sequence num
+			 */
+			if (SERVER_IS_CHAN(server))
+				smb3_hdr->ChannelSequence =
+					cpu_to_le16(server->primary_server->channel_sequence_num);
+			else
+				smb3_hdr->ChannelSequence =
+					cpu_to_le16(server->channel_sequence_num);
+		}
+		spin_lock(&server->req_lock);
+		/* Request up to 10 credits but don't go over the limit. */
+		if (server->credits >= server->max_credits)
+			shdr->CreditRequest = cpu_to_le16(0);
+		else
+			shdr->CreditRequest = cpu_to_le16(
+				min_t(int, server->max_credits -
+						server->credits, 10));
+		spin_unlock(&server->req_lock);
+	}
+
+	if (tcon) {
+		/* GLOBAL_CAP_LARGE_MTU will only be set if dialect > SMB2.02 */
+		/* See sections 2.2.4 and 3.2.4.1.5 of MS-SMB2 */
+		if (server && (server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
+			shdr->CreditCharge = cpu_to_le16(1);
+		/* else CreditCharge MBZ */
+
+		shdr->Id.SyncId.TreeId = cpu_to_le32(tcon->tid);
+		/* Uid is not converted */
+		if (tcon->ses)
+			shdr->SessionId = cpu_to_le64(tcon->ses->Suid);
+
+		/*
+		 * If we would set SMB2_FLAGS_DFS_OPERATIONS on open we also
+		 * would have to pass the path on the Open SMB prefixed by
+		 * \\server\share.  Not sure when we would need to do the
+		 * augmented path (if ever) and setting this flag breaks the
+		 * SMB2 open operation since it is illegal to send an empty
+		 * path name (without \\server\share prefix) when the DFS flag
+		 * is set in the SMB open header. We could consider setting the
+		 * flag on all operations other than open but it is safer to
+		 * net set it for now.
+		 */
+/*	if (tcon->share_flags & SHI1005_FLAGS_DFS)
+	shdr->Flags |= SMB2_FLAGS_DFS_OPERATIONS; */
+
+		if (server && server->sign && !smb3_encryption_required(tcon))
+			shdr->Flags |= SMB2_FLAGS_SIGNED;
+	}
+}
+
+/* Flags for smb2_create_request() */
+#define SMB2_REQ_DYNAMIC	0x01	/* Dynamic request */
+#define SMB2_REQ_HEAD		0x02	/* Head of compound */
+#define SMB2_REQ_SENSITIVE	0x04	/* May contain sensitive crypto data */
+
+/*
+ * smb2_create_request: Allocate and set up a request
+ * @command: The command type we're going to issue
+ * @server: The server the command is going to go to
+ * @header_size: The size of the base protocol structure
+ * @protocol_size: The size of the header plus extensions
+ * @data_size: The size of the data payload
+ * @head: If this is the head of a compound
+ * @flags: Mask of SMB2_REQ_* flags
+ *
+ * Create a request and allocate netmem memory to hold the netbios header (if
+ * appropriate) and the protocol part of the message.  Memory will also be
+ * allocated for the data part of the message if this is to be encrypted by the
+ * CPU.  The allocated buffers will be attached to a bvec-queue struct so that
+ * they can be chained together and passed to the socket.
+ */
+static struct smb_message *smb2_create_request(enum smb2_command command,
+					       struct TCP_Server_Info *server,
+					       struct cifs_tcon *tcon,
+					       size_t header_size,
+					       size_t protocol_size,
+					       size_t data_size,
+					       unsigned int flags)
+{
+	struct smb_message *smb;
+	const size_t max_segs = 3; /* We preallocate 3 segment slots in the message */
+	size_t pre_size;
+	void *body;
+	bool encrypted = false; //, rdma = false;
+	u16 ssize;
+
+	smb = kzalloc(struct_size(smb, bvecq.bv, max_segs), GFP_NOFS);
+	if (!smb)
+		return NULL;
+
+	smb->command_id = command;
+	smb->sensitive = flags & SMB2_REQ_SENSITIVE;
+
+	/* We allocate space for inter-SMB padding or rfc1002 header plus
+	 * transform headers (as needed), but don't add them in at this time.
+	 */
+	pre_size = 8;
+	if (encrypted)
+		pre_size += sizeof(struct smb2_transform_hdr);
+	smb->pre_offset = -pre_size;
+
+	if (encrypted)
+		/* We want the encrypted blob to be correctly aligned. */
+		pre_size = round_up(pre_size, 16);
+
+	/* Allocate space for the SMB header, the request struct (both in
+	 * header_size) plus any extension bits, bearing in mind that some bits
+	 * may follow the header directly (header_added_size) and some may have
+	 * to be padded to an 8-byte alignment first (extension_size).  The
+	 * Negotiate Request has both.
+	 */
+	smb->ext_offset	 = header_size;
+	smb->offset	 = header_size;
+	smb->data_offset = protocol_size;
+	smb->total_len	 = protocol_size;
+
+	body = cifs_allocate_tx_buf(server, pre_size + protocol_size);
+	if (!body) {
+		kfree(smb);
+		return NULL;
+	}
+
+	smb_add_segment_to_tx_buf(smb, body + pre_size, protocol_size);
+	smb->request = body + pre_size;
+	smb->bvecq.max_segs = max_segs;
+
+	struct smb2_pdu *spdu = body;
+
+	smb2_enc_header(smb, tcon, server);
+	ssize = header_size - sizeof(spdu->hdr);
+	if (flags & SMB2_REQ_DYNAMIC)
+		ssize |= SMB2_STRUCT_HAS_DYNAMIC_PART;
+	spdu->StructureSize2 = cpu_to_le16(ssize);
+
+	if (tcon) {
+		cifs_stats_inc(&tcon->stats.smb2_stats.smb2_com_sent[command]);
+		cifs_stats_inc(&tcon->num_smbs_sent);
+	}
+
+	/* Include the buffer from the start of the RFC1002 header in the
+	 * iterator, but may need to adjust it later.
+	 */
+	iov_iter_bvec_queue(&smb->iter, ITER_SOURCE, &smb->bvecq, 0,
+			    pre_size, protocol_size);
+
+	return smb;
+}
+
+static void cifs_pad_to_8(struct smb_message *smb)
+{
+	size_t offset = smb->offset;
+	u8 *p = smb->request;
+
+	while (offset & 7)
+		p[offset++] = 0;
+	smb->offset = offset;
+}
+
+/*
+ * Begin adding an extension to a message.  The offset is padded to an 8-byte
+ * alignment;
+ */
+static void *cifs_begin_extension(struct smb_message *smb)
+{
+	cifs_pad_to_8(smb);
+	return smb->request + smb->offset;
+}
+
+static void cifs_end_extension(struct smb_message *smb, size_t size)
+{
+	smb->offset += size;
+}
+
 static void
 smb2_hdr_assemble(struct smb2_hdr *shdr, enum smb2_command smb2_cmd,
 		  const struct cifs_tcon *tcon,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 3018b171c6de..22284a52f300 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -131,6 +131,7 @@ extern void smb2_set_next_command(struct cifs_tcon *tcon,
 extern void smb2_set_related(struct smb_rqst *rqst);
 extern void smb2_set_replay(struct TCP_Server_Info *server,
 			    struct smb_rqst *rqst);
+void smb2_set_replay_smb(struct TCP_Server_Info *server, struct smb_message *smb);
 extern bool smb2_should_replay(struct cifs_tcon *tcon,
 			  int *pretries,
 			  int *pcur_sleep);
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index b497bf319a7e..1d732953a90b 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -93,9 +93,31 @@ static void smb_free_message(struct smb_message *smb)
 {
 	trace_smb3_message(smb->debug_id, refcount_read(&smb->ref),
 			   smb_message_trace_free);
+	cifs_free_tx_buf(smb->request);
 	mempool_free(smb, &smb_message_pool);
 }
 
+/*
+ * Clear the request parts of a message.
+ */
+void smb_clear_request(struct smb_message *smb)
+{
+	for (; smb; smb = smb->next) {
+		if (smb->request) {
+			if (smb->sensitive) {
+				iov_iter_bvec_queue(&smb->iter, ITER_SOURCE,
+						    &smb->bvecq, 3,
+						    -smb->pre_offset,
+						    smb->ext_offset - -smb->pre_offset);
+				iov_iter_zero(smb->ext_offset - -smb->pre_offset,
+					      &smb->iter);
+			}
+			cifs_free_tx_buf(smb->request);
+			smb->request = NULL;
+		}
+	}
+}
+
 /*
  * Drop a ref on a message.  This does not touch the chained messages.
  */
@@ -120,6 +142,8 @@ void smb_put_messages(struct smb_message *smb)
 {
 	struct smb_message *next;
 
+	smb_clear_request(smb);
+
 	for (; smb; smb = next) {
 		unsigned int debug_id = smb->debug_id;
 		bool dead;
@@ -1099,9 +1123,11 @@ int smb_send_recv_messages(const unsigned int xid, struct cifs_ses *ses,
 	optype = flags & CIFS_OP_MASK;
 
 	/* TODO: Stitch together the messages in a compound. */
+	//u32 last_next = 0;
 	nr_reqs = 0;
-	for (struct smb_message *smb = head_smb; smb; smb = smb->next)
+	for (struct smb_message *smb = head_smb; smb; smb = smb->next) {
 		nr_reqs++;
+	}
 
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsExiting) {


