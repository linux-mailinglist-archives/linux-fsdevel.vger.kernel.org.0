Return-Path: <linux-fsdevel+bounces-56893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF68B1CDA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11C7166A40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6F62C15B6;
	Wed,  6 Aug 2025 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKREe6Ce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D12C158B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512710; cv=none; b=Adgl1blbIu/ob48F6HZkHY6VCb8rV76UJXLp2hzQinSrxD17/08MlmMVB6zOapX3ondvKhPUXPRSN57JOmIh3CW2UkfH2lbbt2Borj3E6RN4kYia2HKIWDboc/1KPWlfKmzh5PaCZsdZAN2e5ejr0uvHNWo6GbetoFxUQUvpCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512710; c=relaxed/simple;
	bh=3ubwCXKBoRQm2ONk6hVA9wWEGfO6giCUjHgBw+Uhg3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qquwso2qb8FRtq1YjgGt+NABNAnLBNWttjnhll/wLDLz6TmUrqED8nus9vOLA34QY/+ea8qp6uUJ5L33JJS1PAd12nyRqSGWpYMomHw8u7g6WcUlWlmw6Np6st3JZtcP8AkGxg5Z5o+KPFk7wbsw7JDRrj5cR0Xrxpg8HYulC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKREe6Ce; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2G/zyqpIOISsinPIKYCP2yH6Hi/Kj9o4wevMU97HsGE=;
	b=MKREe6CeML9EOi7rt8jJKahjSG1CloudAfb9oalHjSaq9GtGUxpe6xw+zgVOUqG1vLPpie
	h20449NcYlVHCzo2VmK2vR6s2j/vXM/kOaAucgtAuwgynJw/5e3uvwa/yGs+IlHX/09gXf
	RdcWG+cGfg12mjnNHivLFtLhOsQZnC0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-XHmhqDBNPdySZ0z0xhIu8A-1; Wed,
 06 Aug 2025 16:38:20 -0400
X-MC-Unique: XHmhqDBNPdySZ0z0xhIu8A-1
X-Mimecast-MFC-AGG-ID: XHmhqDBNPdySZ0z0xhIu8A_1754512698
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB12B1800280;
	Wed,  6 Aug 2025 20:38:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF7FD1956086;
	Wed,  6 Aug 2025 20:38:15 +0000 (UTC)
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
Subject: [RFC PATCH 13/31] cifs: Institute message managing struct
Date: Wed,  6 Aug 2025 21:36:34 +0100
Message-ID: <20250806203705.2560493-14-dhowells@redhat.com>
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

Turn the smb_message struct into a message handling struct to aid in
building an SMB message, queuing them and holding the resources and
buffers.  It has absorbed the mid_q_struct and now other fields are added.

The idea is that the smb_message struct will be allocated and filled in
much higher up (typically in the PDU encoding code) and passed down to the
transport.

In particular, the following fields:

 (*) ->next: This is used to link together messages into compounds and then
     walk through the message list.

 (*) ->credits: The credit requirements for the message.

 (*) ->request: Pointer to the smb_hdr struct for the request.

 (*) ->command_id: The ID of the command in CPU endian form (better for
     if- and switch-statements).

 (*) ->total_len: The total length of the request message, not including
     rfc1002 or transform headers.

 (*) ->response: Pointer to the smb_hdr struct for the response.

 (*) ->rqst, ->resp_buf_type, ->resp_iov: The old request info stuff.

Functions are provided to get and put refs upon the struct and also to drop
all the refs on a compound string of structs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h      | 101 ++++++++++++++++++++++++----------
 fs/smb/client/cifsproto.h     |  10 +++-
 fs/smb/client/cifstransport.c |   2 +-
 fs/smb/client/connect.c       |   6 +-
 fs/smb/client/smb1ops.c       |   2 +-
 fs/smb/client/smb2ops.c       |   2 +-
 fs/smb/client/smb2transport.c |   4 +-
 fs/smb/client/transport.c     |  46 ++++++++++++++--
 8 files changed, 130 insertions(+), 43 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 091d92ed670a..90dafae1e9ab 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1704,38 +1704,81 @@ typedef void (*mid_callback_t)(struct smb_message *smb);
 typedef int (*mid_handle_t)(struct TCP_Server_Info *server,
 			    struct smb_message *smb);
 
-/* one of these for every pending CIFS request to the server */
+/*
+ * Definition of an SMB request message to be transmitted.  These may be
+ * chained together and will automatically be turned into compound messages if
+ * they are.
+ *
+ *	+-----------------------+
+ *	| NetBIOS/padding	|
+ *	+-----------------------+ <--- smb->request + pre_offset
+ *	| (Transform header)	|
+ *	+-----------------------+ <--- smb->request
+ *	| SMB2 Header		| }				 }
+ *	+-----------------------+ } header_size			 }
+ *	| Req/Rsp struct	| }				 }
+ *	+-----------------------+ <--- smb->request + ext_offset } protocol_size
+ *	|			|				 }
+ *	| Extra protocol data	|				 }
+ *	|			|				 }
+ *	+-----------------------+ <--- smb->request + smb->data_offset
+ *	|			|
+ *	| Data Payload		|  data_size
+ *	|			|
+ *	+-----------------------+
+ *
+ *
+ * If the data is to be RDMA'd, it will be kept separate from the protocol.
+ */
 struct smb_message {
-	struct list_head qhead;	/* mids waiting on reply from this server */
-	struct kref refcount;
-	struct TCP_Server_Info *server;	/* server corresponding to this mid */
-	__u64 mid;		/* multiplex id */
-	__u16 credits;		/* number of credits consumed by this mid */
-	__u16 credits_received;	/* number of credits from the response */
-	__u32 pid;		/* process id */
-	__u32 sequence_number;  /* for CIFS signing */
-	unsigned int sr_flags;	/* Flags passed to send_recv() */
-	unsigned long when_alloc;  /* when mid was created */
+	struct smb_message	*next;		/* Next message in compound */
+	struct cifs_credits	credits;	/* Credit requirements for this message */
+	void			*request;	/* Pointer to request message body */
+	refcount_t		ref;
+	bool			sensitive;	/* Request contains sensitive data */
+	bool			cancelled;	/* T if cancelled */
+	unsigned int		sr_flags;	/* Flags passed to send_recv() */
+
+	/* Queue state */
+	struct list_head	qhead;		/* mids waiting on reply from this server */
+	struct TCP_Server_Info	*server;	/* server corresponding to this mid */
+	__u64			mid;		/* multiplex id */
+	__u16			credits_consumed; /* number of credits consumed by this op */
+	__u16			credits_received; /* number of credits from the response */
+	__u32			pid;		/* process id */
+	__u32			sequence_number;  /* for CIFS signing */
+	unsigned long		when_alloc;	/* when mid was created */
 #ifdef CONFIG_CIFS_STATS2
-	unsigned long when_sent; /* time when smb send finished */
-	unsigned long when_received; /* when demux complete (taken off wire) */
+	unsigned long		when_sent;	/* time when smb send finished */
+	unsigned long		when_received;	/* when demux complete (taken off wire) */
 #endif
-	mid_receive_t receive; /* call receive callback */
-	mid_callback_t callback; /* call completion callback */
-	mid_handle_t handle; /* call handle mid callback */
-	void *callback_data;	  /* general purpose pointer for callback */
-	struct task_struct *creator;
-	void *resp_buf;		/* pointer to received SMB header */
-	unsigned int resp_buf_size;
-	int mid_state;	/* wish this were enum but can not pass to wait_event */
-	int mid_rc;		/* rc for MID_RC */
-	unsigned int mid_flags;
-	unsigned int optype;	/* operation type */
-	enum smb2_command command_id;	/* smb command code */
-	bool large_buf:1;	/* if valid response, is pointer to large buf */
-	bool multiRsp:1;	/* multiple trans2 responses for one request  */
-	bool multiEnd:1;	/* both received */
-	bool decrypted:1;	/* decrypted entry */
+	mid_receive_t		receive;	/* call receive callback */
+	mid_callback_t		callback;	/* call completion callback */
+	mid_handle_t		handle;		/* call handle mid callback */
+	void			*callback_data;	/* general purpose pointer for callback */
+	struct task_struct	*creator;
+	void			*resp_buf;	/* pointer to received SMB header */
+	unsigned int		resp_buf_size;
+	int			mid_state;	/* wish this were enum but can not pass to wait_event */
+	int			mid_rc;		/* rc for MID_RC */
+	unsigned int		mid_flags;
+	unsigned int		optype;		/* operation type */
+	bool			large_buf:1;	/* if valid response, is pointer to large buf */
+	bool			multiRsp:1;	/* multiple trans2 responses for one request  */
+	bool			multiEnd:1;	/* both received */
+	bool			decrypted:1;	/* decrypted entry */
+
+	/* Request details */
+	enum smb2_command	command_id;	/* Command ID */
+	s16			pre_offset;	/* Offset of pre-headers from ->body (negative) */
+	unsigned int		total_len;	/* Total length of from hdr_offset onwards */
+	/* Response */
+	void			*response;	/* Protocol part of response */
+	u32			response_len;	/* Size of response */
+	/* Compat with old code */
+	struct smb_rqst		rqst;
+	int			*resp_buf_type;
+	struct kvec		*resp_iov;
 };
 
 struct close_cancelled_open {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 3249fe473aa1..6f27fb6ef5dc 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -82,7 +82,7 @@ extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
 extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
 char *cifs_build_devname(char *nodename, const char *prepath);
 extern void delete_mid(struct smb_message *smb);
-void __release_mid(struct kref *refcount);
+void __release_mid(struct smb_message *smb);
 extern void cifs_wake_up_task(struct smb_message *smb);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct smb_message *smb);
@@ -755,7 +755,8 @@ static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
 
 static inline void release_mid(struct smb_message *smb)
 {
-	kref_put(&smb->refcount, __release_mid);
+	if (refcount_dec_and_test(&smb->ref))
+		__release_mid(smb);
 }
 
 static inline void cifs_free_open_info(struct cifs_open_info_data *data)
@@ -765,4 +766,9 @@ static inline void cifs_free_open_info(struct cifs_open_info_data *data)
 	memset(data, 0, sizeof(*data));
 }
 
+struct smb_message *smb_message_alloc(enum smb2_command cmd, gfp_t gfp);
+void smb_get_message(struct smb_message *smb);
+void smb_put_message(struct smb_message *smb);
+void smb_put_messages(struct smb_message *smb);
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index b5f652ad9e59..a2db95faeb17 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -45,7 +45,7 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 
 	smb = mempool_alloc(&smb_message_pool, GFP_NOFS);
 	memset(smb, 0, sizeof(struct smb_message));
-	kref_init(&smb->refcount);
+	refcount_set(&smb->ref, 1);
 	smb->mid = get_mid(smb_buffer);
 	smb->pid = current->pid;
 	smb->command_id = le16_to_cpu(smb_buffer->Command);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9abaca4c8eba..d26e2a6d7674 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -323,7 +323,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
 	spin_lock(&server->mid_lock);
 	list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
-		kref_get(&smb->refcount);
+		smb_get_message(smb);
 		if (smb->mid_state == MID_REQUEST_SUBMITTED)
 			smb->mid_state = MID_RETRY_NEEDED;
 		list_move(&smb->qhead, &retry_list);
@@ -886,7 +886,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 			 */
 			spin_lock(&server->mid_lock);
 			list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
-				kref_get(&smb->refcount);
+				smb_get_message(smb);
 				list_move(&smb->qhead, &dispose_list);
 				smb->mid_flags |= MID_DELETED;
 			}
@@ -1105,7 +1105,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 		list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
 			smb = list_entry(tmp, struct smb_message, qhead);
 			cifs_dbg(FYI, "Clearing mid %llu\n", smb->mid);
-			kref_get(&smb->refcount);
+			smb_get_message(smb);
 			smb->mid_state = MID_SHUTDOWN;
 			list_move(&smb->qhead, &dispose_list);
 			smb->mid_flags |= MID_DELETED;
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index d2094b8872ac..cc5b3c531c77 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -144,7 +144,7 @@ cifs_find_mid(struct TCP_Server_Info *server, char *buffer)
 		if (compare_mid(smb->mid, buf) &&
 		    smb->mid_state == MID_REQUEST_SUBMITTED &&
 		    smb->command_id == command) {
-			kref_get(&smb->refcount);
+			smb_get_message(smb);
 			spin_unlock(&server->mid_lock);
 			return smb;
 		}
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 36c506577b0e..7b714e50f681 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -407,7 +407,7 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 		if ((smb->mid == wire_mid) &&
 		    (smb->mid_state == MID_REQUEST_SUBMITTED) &&
 		    (smb->command_id == command)) {
-			kref_get(&smb->refcount);
+			smb_get_message(smb);
 			if (dequeue) {
 				list_del_init(&smb->qhead);
 				smb->mid_flags |= MID_DELETED;
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index fcf0999e77aa..b217bc0e8e5b 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -770,9 +770,9 @@ smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
 
 	smb = mempool_alloc(&smb_message_pool, GFP_NOFS);
 	memset(smb, 0, sizeof(*smb));
-	kref_init(&smb->refcount);
+	refcount_set(&smb->ref, 1);
 	smb->mid = le64_to_cpu(shdr->MessageId);
-	smb->credits = credits > 0 ? credits : 1;
+	smb->credits_consumed = credits > 0 ? credits : 1;
 	smb->pid = current->pid;
 	smb->command_id = le16_to_cpu(shdr->Command);
 	smb->when_alloc = jiffies;
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 9282a3276318..288351c27fc4 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -30,6 +30,46 @@
 #include "smbdirect.h"
 #include "compress.h"
 
+struct smb_message *smb_message_alloc(enum smb2_command cmd, gfp_t gfp)
+{
+	struct smb_message *smb;
+
+	smb = mempool_alloc(&smb_message_pool, gfp);
+	if (smb) {
+		memset(smb, 0, sizeof(*smb));
+		refcount_set(&smb->ref, 1);
+		smb->command_id = cmd;
+	}
+	return smb;
+}
+
+void smb_get_message(struct smb_message *smb)
+{
+	refcount_inc(&smb->ref);
+}
+
+/*
+ * Drop a ref on a message.  This does not touch the chained messages.
+ */
+void smb_put_message(struct smb_message *smb)
+{
+	if (refcount_dec_and_test(&smb->ref))
+		mempool_free(smb, &smb_message_pool);
+}
+
+/*
+ * Dispose of a chain of compound messages.
+ */
+void smb_put_messages(struct smb_message *smb)
+{
+	struct smb_message *next;
+
+	for (; smb; smb = next) {
+		next = smb->next;
+		smb_put_message(smb);
+	}
+}
+
 void
 cifs_wake_up_task(struct smb_message *smb)
 {
@@ -38,10 +78,8 @@ cifs_wake_up_task(struct smb_message *smb)
 	wake_up_process(smb->callback_data);
 }
 
-void __release_mid(struct kref *refcount)
+void __release_mid(struct smb_message *smb)
 {
-	struct smb_message *smb =
-			container_of(refcount, struct smb_message, refcount);
 #ifdef CONFIG_CIFS_STATS2
 	enum smb2_command command = smb->server->vals->lock_cmd;
 	enum smb2_command smb_cmd = smb->command_id;
@@ -719,7 +757,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	rc = smb_send_rqst(server, 1, rqst, flags);
 
 	if (rc < 0) {
-		revert_current_mid(server, smb->credits);
+		revert_current_mid(server, smb->credits_consumed);
 		server->sequence_number -= 2;
 		delete_mid(smb);
 	}


