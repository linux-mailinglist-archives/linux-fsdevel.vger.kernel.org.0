Return-Path: <linux-fsdevel+bounces-56898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFDDB1CDBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5583F4E3926
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407FB2D12F1;
	Wed,  6 Aug 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bccJF5Xd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EC2D0C9E
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512734; cv=none; b=orL7BZgdWjYtF12uXlx+H+DZcLsgXrcg9z1HYRCo7citzhdlYgFn9DUY7X71872NA6Ez3TQ4DcBwPhP1aaRc2BZpIxlwbjLYxopyRfGYCcVS4S2qslekLKLlnv0ymNwixJLAIncdpdaAP8eCRT7lgPv+fNYWdBpZGBigJoq8F9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512734; c=relaxed/simple;
	bh=/KYLWM66HsCIyLrUD2j4x9ZdDVeh1/ghbwWgJ/qIhSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An1i1a0dh5fWJLLIv+JzdqELA6cjAl9IvvTRcmoCY6GlXjIXCfdHrF7Dc2rA+IGSG0KGSo1lYLP91xd3FqX+2ljKpNhsbIOnDnBSHsgZLPSNbQxgCR5sDjVl9Uhh8cyq9CW7Yr3ngfvPhKLN6RvN++06umktp5NIDAW90dmps2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bccJF5Xd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE4nIVk7xOe+TmD1HbRuyEA8rxzcr7xUzi3JYj5/pKs=;
	b=bccJF5Xd1AObacNLcjKmbjXYSxoigjsZE7O2pKvE1lY7PVFESdHzQd5McFgQBqdGVqULYs
	QypxKLCR1DVD9g+8Taet/qa+qbyB4si+vZtR/ZT+6wB+CjA7auiPPwxWI/ZDmzbx9Vfdee
	NNu5o9/aKZcm+oyFHP57AFIxaXaZy50=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-MW2HQGbPPXW6kZm-6mDnBg-1; Wed,
 06 Aug 2025 16:38:44 -0400
X-MC-Unique: MW2HQGbPPXW6kZm-6mDnBg-1
X-Mimecast-MFC-AGG-ID: MW2HQGbPPXW6kZm-6mDnBg_1754512723
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 111D7195419B;
	Wed,  6 Aug 2025 20:38:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D676180035C;
	Wed,  6 Aug 2025 20:38:39 +0000 (UTC)
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
Subject: [RFC PATCH 18/31] cifs: Pass smb_message structs down into the transport layer
Date: Wed,  6 Aug 2025 21:36:39 +0100
Message-ID: <20250806203705.2560493-19-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Institute the creation of smb_message structs at the layer above the
transport layer and pass them down into the transport layer.  This replaces
the handling of mid_q_structs entirely within the transport layer.

This includes the following changes:

 (1) The smb_rqst struct is partially absorbed into the smb_message struct.
     Because the latter is on a linked list, the fixed-size arrays of
     requests can be got rid of - along with the COMPOUND_MAX-1 limit that
     gets imposed by the encryption code because it needs to steal a slot
     for the transform header.

 (2) Hand smb_message structs into the message sending code in the
     transport rather than allocating them (as it did for mid_q_structs) in
     the ->setup_request/->setup_async_request functions.

     For the moment compound_send_rcv() does the generation of smb_message
     structs, stringing them together before passing them down.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h      |  38 ++--
 fs/smb/client/cifsproto.h     |  39 ++--
 fs/smb/client/cifssmb.c       |   1 -
 fs/smb/client/cifstransport.c |   8 +-
 fs/smb/client/compress.h      |   6 +-
 fs/smb/client/connect.c       |  24 +--
 fs/smb/client/netmisc.c       |   5 +-
 fs/smb/client/smb1ops.c       |  19 +-
 fs/smb/client/smb2misc.c      |  45 ++---
 fs/smb/client/smb2ops.c       |  40 +++--
 fs/smb/client/smb2pdu.c       | 212 +++++++++++++---------
 fs/smb/client/smb2proto.h     |  31 ++--
 fs/smb/client/smb2transport.c | 183 +++++++------------
 fs/smb/client/transport.c     | 325 +++++++++++++++++++---------------
 14 files changed, 501 insertions(+), 475 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 1eed8a463b58..4173b87bdf0f 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -313,26 +313,24 @@ struct cifs_credits;
 
 struct smb_version_operations {
 	int (*send_cancel)(struct cifs_ses *ses, struct TCP_Server_Info *server,
-			   struct smb_rqst *rqst, struct smb_message *smb,
-			   unsigned int xid);
+			   struct smb_message *smb, unsigned int xid);
 	bool (*compare_fids)(struct cifsFileInfo *, struct cifsFileInfo *);
-	/* setup request: allocate mid, sign message */
-	struct smb_message *(*setup_request)(struct cifs_ses *,
-					     struct TCP_Server_Info *,
-					     struct smb_rqst *);
+	/* setup request: set up mid, sign message */
+	int (*setup_request)(struct cifs_ses *ses,
+			     struct TCP_Server_Info *server,
+			     struct smb_message *smb);
 	/* setup async request: allocate mid, sign message */
-	struct smb_message *(*setup_async_request)(struct TCP_Server_Info *,
-						   struct smb_rqst *);
+	int (*setup_async_request)(struct TCP_Server_Info *server, struct smb_message *smb);
 	/* check response: verify signature, map error */
-	int (*check_receive)(struct smb_message *, struct TCP_Server_Info *,
-			     bool);
+	int (*check_receive)(struct smb_message *smb, struct TCP_Server_Info *server,
+			     bool log_error);
 	void (*add_credits)(struct TCP_Server_Info *server,
 			    struct cifs_credits *credits,
 			    const int optype);
 	void (*set_credits)(struct TCP_Server_Info *, const int);
 	int * (*get_credits_field)(struct TCP_Server_Info *, const int);
 	unsigned int (*get_credits)(struct smb_message *smb);
-	__u64 (*get_next_mid)(struct TCP_Server_Info *);
+	__u64 (*get_next_mid)(struct TCP_Server_Info *server, unsigned int count);
 	void (*revert_current_mid)(struct TCP_Server_Info *server,
 				   const unsigned int val);
 	/* data offset from read response message */
@@ -537,8 +535,8 @@ struct smb_version_operations {
 	void (*new_lease_key)(struct cifs_fid *);
 	int (*generate_signingkey)(struct cifs_ses *ses,
 				   struct TCP_Server_Info *server);
-	int (*calc_signature)(struct smb_rqst *, struct TCP_Server_Info *,
-				bool allocate_crypto);
+	int (*calc_signature)(struct smb_message *smb, struct TCP_Server_Info *server,
+			      bool allocate_crypto);
 	int (*set_integrity)(const unsigned int, struct cifs_tcon *tcon,
 			     struct cifsFileInfo *src_file);
 	int (*enum_snapshots)(const unsigned int xid, struct cifs_tcon *tcon,
@@ -594,10 +592,8 @@ struct smb_version_operations {
 	long (*fallocate)(struct file *, struct cifs_tcon *, int, loff_t,
 			  loff_t);
 	/* init transform (compress/encrypt) request */
-	int (*init_transform_rq)(struct TCP_Server_Info *server,
-				 int num_rqst, const struct smb_rqst *rqst,
-				 struct smb2_transform_hdr *tr_hdr,
-				 struct iov_iter *iter);
+	int (*init_transform_rq)(struct TCP_Server_Info *server, struct smb_message *head_smb,
+				 struct smb2_transform_hdr *tr_hdr, struct iov_iter *iter);
 	int (*is_transform_hdr)(void *buf);
 	int (*receive_transform)(struct TCP_Server_Info *,
 				 struct smb_message **smb, char **, int *);
@@ -945,16 +941,16 @@ adjust_credits(struct TCP_Server_Info *server, struct cifs_io_subrequest *subreq
 		server->ops->adjust_credits(server, subreq, trace) : 0;
 }
 
-static inline __le64
-get_next_mid64(struct TCP_Server_Info *server)
+static inline __u64
+get_next_mid64(struct TCP_Server_Info *server, unsigned int count)
 {
-	return cpu_to_le64(server->ops->get_next_mid(server));
+	return server->ops->get_next_mid(server, count);
 }
 
 static inline __le16
 get_next_mid(struct TCP_Server_Info *server)
 {
-	__u16 mid = server->ops->get_next_mid(server);
+	__u16 mid = server->ops->get_next_mid(server, 1);
 	/*
 	 * The value in the SMB header should be little endian for easy
 	 * on-the-wire decoding.
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 76cb047b2715..fd5fe2723b4a 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -83,8 +83,6 @@ extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
 				     int add_treename);
 extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
 char *cifs_build_devname(char *nodename, const char *prepath);
-extern void delete_mid(struct smb_message *smb);
-void __release_mid(struct smb_message *smb);
 extern void cifs_wake_up_task(struct smb_message *smb);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct smb_message *smb);
@@ -96,15 +94,16 @@ extern int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
 extern bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs);
 extern int cifs_discard_remaining_data(struct TCP_Server_Info *server);
 extern int cifs_call_async(struct TCP_Server_Info *server,
-			struct smb_rqst *rqst,
-			mid_receive_t receive, mid_callback_t callback,
-			mid_handle_t handle, void *cbdata, const int flags,
-			const struct cifs_credits *exist_credits);
+			   struct smb_message *msg, const int flags,
+			   const struct cifs_credits *exist_credits);
 extern struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses);
 extern int cifs_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			  struct TCP_Server_Info *server,
 			  struct smb_rqst *rqst, int *resp_buf_type,
 			  const int flags, struct kvec *resp_iov);
+int smb_send_recv_messages(const unsigned int xid, struct cifs_ses *ses,
+			   struct TCP_Server_Info *server,
+			   struct smb_message *smb, const int flags);
 extern int compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			      struct TCP_Server_Info *server,
 			      const int flags, const int num_rqst,
@@ -117,14 +116,14 @@ extern int SendReceive(const unsigned int /* xid */ , struct cifs_ses *,
 extern int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
 			    char *in_buf, int flags);
 int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info *server);
-extern struct smb_message *cifs_setup_request(struct cifs_ses *,
-				struct TCP_Server_Info *,
-				struct smb_rqst *);
-extern struct smb_message *cifs_setup_async_request(struct TCP_Server_Info *,
-						struct smb_rqst *);
+int cifs_setup_request(struct cifs_ses *ses,
+		       struct TCP_Server_Info *server,
+		       struct smb_message *smb);
+int cifs_setup_async_request(struct TCP_Server_Info *server,
+			     struct smb_message *smb);
 int __smb_send_rqst(struct TCP_Server_Info *server, struct iov_iter *iter);
-extern int cifs_check_receive(struct smb_message *msg,
-			struct TCP_Server_Info *server, bool log_error);
+int cifs_check_receive(struct smb_message *smb,
+		       struct TCP_Server_Info *server, bool log_error);
 int wait_for_free_request(struct TCP_Server_Info *server, const int flags,
 			  unsigned int *instance);
 extern int cifs_wait_mtu_credits(struct TCP_Server_Info *server,
@@ -133,11 +132,10 @@ extern int cifs_wait_mtu_credits(struct TCP_Server_Info *server,
 
 static inline int
 send_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
-	    struct smb_rqst *rqst, struct smb_message *smb,
-	    unsigned int xid)
+	    struct smb_message *smb, unsigned int xid)
 {
 	return server->ops->send_cancel ?
-		server->ops->send_cancel(ses, server, rqst, smb, xid) : 0;
+		server->ops->send_cancel(ses, server, smb, xid) : 0;
 }
 
 int wait_for_response(struct TCP_Server_Info *server, struct smb_message *smb);
@@ -181,7 +179,8 @@ extern int decode_negTokenInit(unsigned char *security_blob, int length,
 extern int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
 extern void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
 extern int map_smb_to_linux_error(char *buf, bool logErr);
-extern int map_and_check_smb_error(struct smb_message *smb, bool logErr);
+extern int map_and_check_smb_error(struct TCP_Server_Info *server,
+				   struct smb_message *smb, bool logErr);
 extern void header_assemble(struct smb_hdr *, char /* command */ ,
 			    const struct cifs_tcon *, int /* length of
 			    fixed section (word count) in two byte units */);
@@ -754,12 +753,6 @@ static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
 	return true;
 }
 
-static inline void release_mid(struct smb_message *smb)
-{
-	if (refcount_dec_and_test(&smb->ref))
-		__release_mid(smb);
-}
-
 static inline void cifs_free_open_info(struct cifs_open_info_data *data)
 {
 	kfree(data->symlink_target);
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index a7a9f63f8c21..789ce76e3154 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -582,7 +582,6 @@ cifs_echo_callback(struct smb_message *smb)
 	struct TCP_Server_Info *server = smb->callback_data;
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 
-	release_mid(smb);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index a2db95faeb17..8cdb9252a37e 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -101,8 +101,8 @@ static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
 	return 0;
 }
 
-struct smb_message *
-cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
+int
+cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	int rc;
 	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
@@ -181,9 +181,9 @@ cifs_check_receive(struct smb_message *smb, struct TCP_Server_Info *server,
 	return map_and_check_smb_error(smb, log_error);
 }
 
-struct smb_message *
+int
 cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
-		   struct smb_rqst *rqst)
+		   struct smb_message *smb)
 {
 	int rc;
 	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
diff --git a/fs/smb/client/compress.h b/fs/smb/client/compress.h
index f3ed1d3e52fb..472b0e8b2f45 100644
--- a/fs/smb/client/compress.h
+++ b/fs/smb/client/compress.h
@@ -35,7 +35,7 @@ int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_s
  * should_compress() - Determines if a request (write) or the response to a
  *		       request (read) should be compressed.
  * @tcon: tcon of the request is being sent to
- * @rqst: request to evaluate
+ * @smb: request to evaluate
  *
  * Return: true iff:
  * - compression was successfully negotiated with server
@@ -46,7 +46,7 @@ int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_s
  *
  * Return false otherwise.
  */
-bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq);
+bool should_compress(const struct cifs_tcon *tcon, const struct smb_message *smb);
 
 /**
  * smb_compress_alg_valid() - Validate a compression algorithm.
@@ -77,7 +77,7 @@ static inline int smb_compress(void *unused1, void *unused2, void *unused3)
 	return -EOPNOTSUPP;
 }
 
-static inline bool should_compress(void *unused1, void *unused2)
+static inline bool should_compress(const struct cifs_tcon *tcon, const struct smb_message *smb)
 {
 	return false;
 }
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index d26e2a6d7674..7a64b070f74b 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -323,7 +323,6 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
 	spin_lock(&server->mid_lock);
 	list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
-		smb_get_message(smb);
 		if (smb->mid_state == MID_REQUEST_SUBMITTED)
 			smb->mid_state = MID_RETRY_NEEDED;
 		list_move(&smb->qhead, &retry_list);
@@ -336,7 +335,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	list_for_each_entry_safe(smb, nsmb, &retry_list, qhead) {
 		list_del_init(&smb->qhead);
 		smb->callback(smb);
-		release_mid(smb);
+		smb_put_message(smb);
 	}
 
 	if (cifs_rdma_enabled(server)) {
@@ -871,9 +870,9 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 		    server->tcpStatus == CifsInNegotiate &&
 		    !server->with_rfc1001 &&
 		    server->rfc1001_sessinit != 0) {
-			int rc, mid_rc;
 			struct smb_message *smb, *nsmb;
 			LIST_HEAD(dispose_list);
+			int rc, mid_rc;
 
 			cifs_dbg(FYI, "RFC 1002 negative session response during SMB Negotiate, retrying with NetBIOS session\n");
 
@@ -886,7 +885,6 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 			 */
 			spin_lock(&server->mid_lock);
 			list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
-				smb_get_message(smb);
 				list_move(&smb->qhead, &dispose_list);
 				smb->mid_flags |= MID_DELETED;
 			}
@@ -920,7 +918,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 				smb->mid_rc = mid_rc;
 				smb->mid_state = MID_RC;
 				smb->callback(smb);
-				release_mid(smb);
+				smb_put_message(smb);
 			}
 
 			/*
@@ -1097,15 +1095,12 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 	}
 
 	if (!list_empty(&server->pending_mid_q)) {
-		struct smb_message *smb;
-		struct list_head *tmp, *tmp2;
+		struct smb_message *smb, *smb2;
 		LIST_HEAD(dispose_list);
 
 		spin_lock(&server->mid_lock);
-		list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
-			smb = list_entry(tmp, struct smb_message, qhead);
+		list_for_each_entry_safe(smb, smb2, &server->pending_mid_q, qhead) {
 			cifs_dbg(FYI, "Clearing mid %llu\n", smb->mid);
-			smb_get_message(smb);
 			smb->mid_state = MID_SHUTDOWN;
 			list_move(&smb->qhead, &dispose_list);
 			smb->mid_flags |= MID_DELETED;
@@ -1113,12 +1108,11 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 		spin_unlock(&server->mid_lock);
 
 		/* now walk dispose list and issue callbacks */
-		list_for_each_safe(tmp, tmp2, &dispose_list) {
-			smb = list_entry(tmp, struct smb_message, qhead);
+		list_for_each_entry_safe(smb, smb2, &dispose_list, qhead) {
 			cifs_dbg(FYI, "Callback mid %llu\n", smb->mid);
 			list_del_init(&smb->qhead);
 			smb->callback(smb);
-			release_mid(smb);
+			smb_put_message(smb);
 		}
 		/* 1/8th of sec is more than enough time for them to exit */
 		msleep(125);
@@ -1361,7 +1355,7 @@ cifs_demultiplex_thread(void *p)
 		if (length < 0) {
 			for (i = 0; i < num_smbs; i++)
 				if (smbs[i])
-					release_mid(smbs[i]);
+					smb_put_message(smbs[i]);
 			continue;
 		}
 
@@ -1396,7 +1390,7 @@ cifs_demultiplex_thread(void *p)
 				if (!smbs[i]->multiRsp || smbs[i]->multiEnd)
 					smbs[i]->callback(smbs[i]);
 
-				release_mid(smbs[i]);
+				smb_put_message(smbs[i]);
 			} else if (server->ops->is_oplock_break &&
 				   server->ops->is_oplock_break(bufs[i],
 								server)) {
diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
index b34d2b91cf5a..89bd1ca9e3ce 100644
--- a/fs/smb/client/netmisc.c
+++ b/fs/smb/client/netmisc.c
@@ -889,7 +889,8 @@ map_smb_to_linux_error(char *buf, bool logErr)
 }
 
 int
-map_and_check_smb_error(struct smb_message *smb, bool logErr)
+map_and_check_smb_error(struct TCP_Server_Info *server,
+			struct smb_message *smb, bool logErr)
 {
 	int rc;
 	struct smb_hdr *rhdr = (struct smb_hdr *)smb->resp_buf;
@@ -904,7 +905,7 @@ map_and_check_smb_error(struct smb_message *smb, bool logErr)
 		if (class == ERRSRV && code == ERRbaduid) {
 			cifs_dbg(FYI, "Server returned 0x%x, reconnecting session...\n",
 				code);
-			cifs_signal_cifsd_for_reconnect(smb->server, false);
+			cifs_signal_cifsd_for_reconnect(server, false);
 		}
 	}
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 185210b7fd03..f179f1b4c0c1 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -29,11 +29,10 @@
  */
 static int
 send_nt_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
-	       struct smb_rqst *rqst, struct smb_message *smb,
-	       unsigned int xid)
+	       struct smb_message *smb, unsigned int xid)
 {
 	struct iov_iter iter;
-	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
+	struct smb_hdr *in_buf = (struct smb_hdr *)smb->rqst.rq_iov[0].iov_base;
 	struct kvec iov[1];
 	struct smb_rqst crqst = { .rq_iov = iov, .rq_nvec = 1 };
 	int rc = 0;
@@ -80,10 +79,9 @@ send_nt_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
  */
 static int
 send_lock_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
-		 struct smb_rqst *rqst, struct smb_message *smb,
-		 unsigned int xid)
+		 struct smb_message *smb, unsigned int xid)
 {
-	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
+	struct smb_hdr *in_buf = (struct smb_hdr *)smb->rqst.rq_iov[0].iov_base;
 	LOCK_REQ *pSMB = (LOCK_REQ *)in_buf;
 	int rc;
 
@@ -104,12 +102,11 @@ send_lock_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
 }
 
 static int cifs_send_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
-			    struct smb_rqst *rqst, struct smb_message *smb,
-			    unsigned int xid)
+			    struct smb_message *smb, unsigned int xid)
 {
 	if (smb->sr_flags & CIFS_WINDOWS_LOCK)
-		return send_lock_cancel(ses, server, rqst, smb, xid);
-	return send_nt_cancel(ses, server, rqst, smb, xid);
+		return send_lock_cancel(ses, server, smb, xid);
+	return send_nt_cancel(ses, server, smb, xid);
 }
 
 static bool
@@ -210,7 +207,7 @@ cifs_get_credits(struct smb_message *smb)
  * so many threads being in the vfs at one time.
  */
 static __u64
-cifs_get_next_mid(struct TCP_Server_Info *server)
+cifs_get_next_mid(struct TCP_Server_Info *server, unsigned int count)
 {
 	__u64 mid = 0;
 	__u16 last_mid, cur_mid;
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index b8e3fe26d658..122e9fe78e23 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -866,27 +866,22 @@ smb2_handle_cancelled_mid(struct smb_message *smb, struct TCP_Server_Info *serve
 }
 
 /**
- * smb311_update_preauth_hash - update @ses hash with the packet data in @iov
- *
- * Assumes @iov does not contain the rfc1002 length and iov[0] has the
- * SMB2 header.
- *
+ * smb311_update_preauth_hash - update @ses hash from the message
  * @ses:	server session structure
  * @server:	pointer to server info
- * @iov:	array containing the SMB request we will send to the server
- * @nvec:	number of array entries for the iov
+ * @smb:	the SMB request we will send to the server
+ * @hash_resp:	T if we're hashing a response
  */
 int
 smb311_update_preauth_hash(struct cifs_ses *ses, struct TCP_Server_Info *server,
-			   struct kvec *iov, int nvec)
+			   struct smb_message *smb, bool hash_resp)
 {
-	int i, rc;
-	struct smb2_hdr *hdr;
 	struct shash_desc *sha512 = NULL;
+	struct kvec *iov;
+	int i, rc, ioc;
 
-	hdr = (struct smb2_hdr *)iov[0].iov_base;
 	/* neg prot are always taken */
-	if (le16_to_cpu(hdr->Command) == SMB2_NEGOTIATE)
+	if (smb->command_id == SMB2_NEGOTIATE)
 		goto ok;
 
 	/*
@@ -897,15 +892,16 @@ smb311_update_preauth_hash(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	if (server->dialect != SMB311_PROT_ID)
 		return 0;
 
-	if (le16_to_cpu(hdr->Command) != SMB2_SESSION_SETUP)
+	if (smb->command_id != SMB2_SESSION_SETUP)
 		return 0;
 
 	/* skip last sess setup response */
-	if ((hdr->Flags & SMB2_FLAGS_SERVER_TO_REDIR)
-	    && (hdr->Status == NT_STATUS_OK
-		|| (hdr->Status !=
-		    cpu_to_le32(NT_STATUS_MORE_PROCESSING_REQUIRED))))
-		return 0;
+	if (hash_resp) {
+		struct smb2_hdr *resp = smb->resp_iov->iov_base;
+		if (resp->Status == NT_STATUS_OK ||
+		    resp->Status != cpu_to_le32(NT_STATUS_MORE_PROCESSING_REQUIRED))
+			return 0;
+	}
 
 ok:
 	rc = smb311_crypto_shash_allocate(server);
@@ -926,8 +922,17 @@ smb311_update_preauth_hash(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		return rc;
 	}
 
-	for (i = 0; i < nvec; i++) {
-		rc = crypto_shash_update(sha512, iov[i].iov_base, iov[i].iov_len);
+	if (hash_resp) {
+		ioc = 1;
+		iov = smb->resp_iov;
+	} else {
+		ioc = smb->rqst.rq_nvec;
+		iov = smb->rqst.rq_iov;
+	}
+
+	for (i = 0; i < ioc; i++) {
+		rc = crypto_shash_update(sha512, iov[i].iov_base,
+					 iov[i].iov_len);
 		if (rc) {
 			cifs_dbg(VFS, "%s: Could not update sha512 shash\n",
 				 __func__);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 5933757d0170..835a76169d40 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -370,12 +370,13 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 }
 
 static __u64
-smb2_get_next_mid(struct TCP_Server_Info *server)
+smb2_get_next_mid(struct TCP_Server_Info *server, unsigned int count)
 {
 	__u64 mid;
 	/* for SMB2 we need the current value */
 	spin_lock(&server->mid_lock);
-	mid = server->CurrentMid++;
+	mid = server->CurrentMid;
+	server->CurrentMid = mid + umax(count, 1);
 	spin_unlock(&server->mid_lock);
 	return mid;
 }
@@ -407,7 +408,6 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 		if ((smb->mid == wire_mid) &&
 		    (smb->mid_state == MID_REQUEST_SUBMITTED) &&
 		    (smb->command_id == command)) {
-			smb_get_message(smb);
 			if (dequeue) {
 				list_del_init(&smb->qhead);
 				smb->mid_flags |= MID_DELETED;
@@ -4168,10 +4168,12 @@ smb2_dir_needs_close(struct cifsFileInfo *cfile)
 }
 
 static void
-fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, unsigned int orig_len,
-		   const struct smb_rqst *old_rq, __le16 cipher_type)
+fill_transform_hdr(struct smb2_transform_hdr *tr_hdr,
+		   struct smb_message *head_smb,
+		   unsigned int orig_len,
+		   __le16 cipher_type)
 {
-	struct smb2_hdr *shdr = (struct smb2_hdr *)old_rq->rq_iov[0].iov_base;
+	struct smb2_hdr *shdr = head_smb->request;
 
 	*tr_hdr = (struct smb2_transform_hdr){
 		.ProtocolId		= SMB2_TRANSFORM_PROTO_NUM,
@@ -4422,7 +4424,6 @@ decrypt_message(struct TCP_Server_Info *server,
 	aead_request_set_ad(req, assoc_data_len);
 
 	rc = crypto_aead_decrypt(req);
-
 	kvfree_sensitive(creq, sensitive_size);
 	return rc;
 }
@@ -4434,13 +4435,14 @@ decrypt_message(struct TCP_Server_Info *server,
  */
 static int
 smb3_init_transform_rq(struct TCP_Server_Info *server,
-		       int num_rqst, const struct smb_rqst *rqst,
+		       struct smb_message *head_smb,
 		       struct smb2_transform_hdr *tr_hdr,
 		       struct iov_iter *iter)
+
 {
 	int rc;
 
-	fill_transform_hdr(tr_hdr, iov_iter_count(iter), rqst,
+	fill_transform_hdr(tr_hdr, head_smb, iov_iter_count(iter),
 			   server->cipher_type);
 
 	rc = encrypt_message(server, tr_hdr, iter, server->secmech.enc);
@@ -4689,9 +4691,9 @@ static void smb2_decrypt_offload(struct work_struct *work)
 
 	dw->server->lstrp = jiffies;
 	smb = smb2_find_dequeue_mid(dw->server, dw->buf);
-	if (smb == NULL)
+	if (smb == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
-	else {
+	} else {
 		smb->decrypted = true;
 		rc = handle_read_data(dw->server, smb, dw->buf,
 				      dw->server->vals->read_rsp_size,
@@ -4724,7 +4726,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				spin_unlock(&dw->server->srv_lock);
 			}
 		}
-		release_mid(smb);
+		smb_put_message(smb);
 	}
 
 free_pages:
@@ -4735,9 +4737,12 @@ static void smb2_decrypt_offload(struct work_struct *work)
 
 
 static int
-receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **smb,
+receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **mid,
 		       int *num_mids)
 {
+	WARN_ON_ONCE(1);
+	return -ENOANO; // TODO
+#if 0
 	char *buf = server->smallbuf;
 	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
 	struct iov_iter iter;
@@ -4753,8 +4758,8 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **smb,
 	dw->server = server;
 
 	*num_mids = 1;
-	len = min_t(unsigned int, buflen, server->vals->read_rsp_size +
-		sizeof(struct smb2_transform_hdr)) - HEADER_SIZE(server) + 1;
+	len = umin(buflen, server->vals->read_rsp_size +
+		   sizeof(struct smb2_transform_hdr)) - HEADER_SIZE(server) + 1;
 
 	rc = cifs_read_from_socket(server, buf + HEADER_SIZE(server) - 1, len);
 	if (rc < 0)
@@ -4836,6 +4841,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **smb,
 discard_data:
 	cifs_discard_remaining_data(server);
 	goto free_pages;
+#endif
 }
 
 static int
@@ -4893,9 +4899,9 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	}
 
 	smb = smb2_find_mid(server, buf);
-	if (smb == NULL)
+	if (smb == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
-	else {
+	} else {
 		cifs_dbg(FYI, "mid found\n");
 		smb->decrypted = true;
 		smb->resp_buf_size = server->pdu_size;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 8554a4aa001d..6b94da4c1149 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4106,7 +4106,6 @@ smb2_echo_callback(struct smb_message *smb)
 		credits.instance = server->reconnect_instance;
 	}
 
-	release_mid(smb);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
@@ -4262,10 +4261,9 @@ int
 SMB2_echo(struct TCP_Server_Info *server)
 {
 	struct smb2_echo_req *req;
+	struct smb_message *smb;
 	int rc = 0;
 	struct kvec iov[1];
-	struct smb_rqst rqst = { .rq_iov = iov,
-				 .rq_nvec = 1 };
 	unsigned int total_len;
 
 	cifs_dbg(FYI, "In echo request for conn_id %lld\n", server->conn_id);
@@ -4280,22 +4278,36 @@ SMB2_echo(struct TCP_Server_Info *server)
 	}
 	spin_unlock(&server->srv_lock);
 
+	smb = smb_message_alloc(SMB2_ECHO, GFP_NOFS);
+	if (!smb)
+		return -ENOMEM;
+
 	rc = smb2_plain_req_init(SMB2_ECHO, NULL, server,
 				 (void **)&req, &total_len);
-	if (rc)
+	if (rc) {
+		mempool_free(smb, &smb_message_pool);
 		return rc;
-
-	req->hdr.CreditRequest = cpu_to_le16(1);
+	}
 
 	iov[0].iov_len = total_len;
 	iov[0].iov_base = (char *)req;
 
-	rc = cifs_call_async(server, &rqst, NULL, smb2_echo_callback, NULL,
-			     server, CIFS_ECHO_OP, NULL);
+	smb->rqst.rq_iov	= iov;
+	smb->rqst.rq_nvec	= 1;
+	smb->command_id		= SMB2_ECHO;
+	smb->request		= req;
+	smb->total_len		= total_len;
+	smb->callback		= smb2_echo_callback;
+	smb->callback_data	= server;
+
+	req->hdr.CreditRequest = cpu_to_le16(1);
+
+	rc = cifs_call_async(server, smb, CIFS_ECHO_OP, NULL);
 	if (rc)
 		cifs_dbg(FYI, "Echo request failed: %d\n", rc);
 
 	cifs_small_buf_release(req);
+	smb_put_message(smb);
 	return rc;
 }
 
@@ -4559,7 +4571,7 @@ smb2_readv_callback(struct smb_message *smb)
 			int rc;
 
 			iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes);
-			rc = smb2_verify_signature(&rqst, server);
+			rc = smb2_verify_signature(smb, server);
 			if (rc)
 				cifs_tcon_dbg(VFS, "SMB signature verification returned error = %d\n",
 					 rc);
@@ -4645,7 +4657,6 @@ smb2_readv_callback(struct smb_message *smb)
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
-	release_mid(smb);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_read_response_add);
@@ -4656,46 +4667,62 @@ smb2_readv_callback(struct smb_message *smb)
 int
 smb2_async_readv(struct cifs_io_subrequest *rdata)
 {
-	int rc, flags = 0;
-	char *buf;
 	struct netfs_io_subrequest *subreq = &rdata->subreq;
-	struct smb2_hdr *shdr;
-	struct cifs_io_parms io_parms;
-	struct smb_rqst rqst = { .rq_iov = rdata->iov,
-				 .rq_nvec = 1 };
 	struct TCP_Server_Info *server;
+	struct smb_message *smb;
+	struct smb2_hdr *shdr;
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	unsigned int total_len;
+	void *buf;
 	int credit_request;
+	int rc, flags = 0;
 
 	cifs_dbg(FYI, "%s: offset=%llu bytes=%zu\n",
 		 __func__, subreq->start, subreq->len);
 
-	if (!rdata->server)
-		rdata->server = cifs_pick_channel(tcon->ses);
+	server = rdata->server;
+	if (!server)
+		server = rdata->server = cifs_pick_channel(tcon->ses);
+
+	struct cifs_io_parms io_parms = {
+		.tcon		= tlink_tcon(rdata->req->cfile->tlink),
+		.server		= server,
+		.offset		= subreq->start + subreq->transferred,
+		.length		= subreq->len   - subreq->transferred,
+		.persistent_fid	= rdata->req->cfile->fid.persistent_fid,
+		.volatile_fid	= rdata->req->cfile->fid.volatile_fid,
+		.pid		= rdata->req->pid,
+	};
 
-	io_parms.tcon = tlink_tcon(rdata->req->cfile->tlink);
-	io_parms.server = server = rdata->server;
-	io_parms.offset = subreq->start + subreq->transferred;
-	io_parms.length = subreq->len   - subreq->transferred;
-	io_parms.persistent_fid = rdata->req->cfile->fid.persistent_fid;
-	io_parms.volatile_fid = rdata->req->cfile->fid.volatile_fid;
-	io_parms.pid = rdata->req->pid;
+	smb = smb_message_alloc(SMB2_READ, GFP_NOFS);
+	if (!smb)
+		return -ENOMEM;
 
-	rc = smb2_new_read_req(
-		(void **) &buf, &total_len, &io_parms, rdata, 0, 0);
-	if (rc)
+	rc = smb2_new_read_req(&buf, &total_len, &io_parms, rdata, 0, 0);
+	if (rc) {
+		mempool_free(smb, &smb_message_pool);
 		return rc;
+	}
 
 	if (smb3_encryption_required(io_parms.tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
-	rdata->iov[0].iov_base = buf;
-	rdata->iov[0].iov_len = total_len;
-	rdata->got_bytes = 0;
-	rdata->result = 0;
+	rdata->iov[0].iov_base	= buf;
+	rdata->iov[0].iov_len	= total_len;
+	rdata->got_bytes	= 0;
+	rdata->result		= 0;
+
+	smb->rqst.rq_iov	= rdata->iov;
+	smb->rqst.rq_nvec	= 1;
+	smb->command_id		= SMB2_READ;
+	smb->request		= buf;
+	smb->total_len		= total_len;
+	smb->receive		= cifs_readv_receive;
+	smb->handle		= smb3_handle_read_data;
+	smb->callback		= smb2_readv_callback;
+	smb->callback_data	= rdata;
 
-	shdr = (struct smb2_hdr *)buf;
+	shdr = (struct smb2_hdr *)smb->request;
 
 	if (rdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(io_parms.length,
@@ -4715,10 +4742,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 		flags |= CIFS_HAS_CREDITS;
 	}
 
-	rc = cifs_call_async(server, &rqst,
-			     cifs_readv_receive, smb2_readv_callback,
-			     smb3_handle_read_data, rdata, flags,
-			     &rdata->credits);
+	rc = cifs_call_async(server, smb, flags, &rdata->credits);
 	if (rc) {
 		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ);
 		trace_smb3_read_err(rdata->rreq->debug_id,
@@ -4732,6 +4756,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 
 async_readv_out:
 	cifs_small_buf_release(buf);
+	smb_put_message(smb);
 	return rc;
 }
 
@@ -4931,7 +4956,6 @@ smb2_writev_callback(struct smb_message *smb)
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
 	cifs_write_subrequest_terminated(wdata, result ?: written);
-	release_mid(smb);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_write_response_add);
@@ -4942,77 +4966,90 @@ smb2_writev_callback(struct smb_message *smb)
 void
 smb2_async_writev(struct cifs_io_subrequest *wdata)
 {
-	int rc = -EACCES, flags = 0;
 	struct smb2_write_req *req = NULL;
+	struct smb_message *smb;
 	struct smb2_hdr *shdr;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = wdata->server;
 	struct kvec iov[1];
-	struct smb_rqst rqst = { };
 	unsigned int total_len, xid = wdata->xid;
-	struct cifs_io_parms _io_parms;
-	struct cifs_io_parms *io_parms = NULL;
 	int credit_request;
+	int rc = -EACCES, flags = 0;
 
 	/*
 	 * in future we may get cifs_io_parms passed in from the caller,
 	 * but for now we construct it here...
 	 */
-	_io_parms = (struct cifs_io_parms) {
-		.tcon = tcon,
-		.server = server,
-		.offset = wdata->subreq.start,
-		.length = wdata->subreq.len,
-		.persistent_fid = wdata->req->cfile->fid.persistent_fid,
-		.volatile_fid = wdata->req->cfile->fid.volatile_fid,
-		.pid = wdata->req->pid,
+	struct cifs_io_parms io_parms = {
+		.tcon		= tcon,
+		.server		= server,
+		.offset		= wdata->subreq.start,
+		.length		= wdata->subreq.len,
+		.persistent_fid	= wdata->req->cfile->fid.persistent_fid,
+		.volatile_fid	= wdata->req->cfile->fid.volatile_fid,
+		.pid		= wdata->req->pid,
 	};
-	io_parms = &_io_parms;
+
+	smb = smb_message_alloc(SMB2_WRITE, GFP_NOFS);
+	if (!smb) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	rc = smb2_plain_req_init(SMB2_WRITE, tcon, server,
 				 (void **) &req, &total_len);
-	if (rc)
+	if (rc) {
+		mempool_free(smb, &smb_message_pool);
 		goto out;
+	}
 
-	rqst.rq_iov = iov;
-	rqst.rq_iter = wdata->subreq.io_iter;
+	smb->rqst.rq_iov = iov;
+	smb->rqst.rq_iter = wdata->subreq.io_iter;
+
+	smb->rqst.rq_iov[0].iov_len = total_len - 1;
+	smb->rqst.rq_iov[0].iov_base = (char *)req;
+	smb->rqst.rq_nvec += 1;
 
-	rqst.rq_iov[0].iov_len = total_len - 1;
-	rqst.rq_iov[0].iov_base = (char *)req;
-	rqst.rq_nvec += 1;
+	smb->rqst.rq_iov	= wdata->iov;
+	smb->rqst.rq_nvec	= 1;
+	smb->command_id		= SMB2_WRITE;
+	smb->request		= req;
+	smb->total_len		= total_len;
+	smb->callback		= smb2_writev_callback;
+	smb->callback_data	= wdata;
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
 	shdr = (struct smb2_hdr *)req;
-	shdr->Id.SyncId.ProcessId = cpu_to_le32(io_parms->pid);
-
-	req->PersistentFileId = io_parms->persistent_fid;
-	req->VolatileFileId = io_parms->volatile_fid;
-	req->WriteChannelInfoOffset = 0;
-	req->WriteChannelInfoLength = 0;
-	req->Channel = SMB2_CHANNEL_NONE;
-	req->Length = cpu_to_le32(io_parms->length);
-	req->Offset = cpu_to_le64(io_parms->offset);
-	req->DataOffset = cpu_to_le16(
-				offsetof(struct smb2_write_req, Buffer));
-	req->RemainingBytes = 0;
+	shdr->Id.SyncId.ProcessId = cpu_to_le32(io_parms.pid);
+
+	req->PersistentFileId		= io_parms.persistent_fid;
+	req->VolatileFileId		= io_parms.volatile_fid;
+	req->WriteChannelInfoOffset	= 0;
+	req->WriteChannelInfoLength	= 0;
+	req->Channel			= SMB2_CHANNEL_NONE;
+	req->Length			= cpu_to_le32(io_parms.length);
+	req->Offset			= cpu_to_le64(io_parms.offset);
+	req->DataOffset			=
+		cpu_to_le16(offsetof(struct smb2_write_req, Buffer));
+	req->RemainingBytes		= 0;
 
 	trace_smb3_write_enter(wdata->rreq->debug_id,
 			       wdata->subreq.debug_index,
 			       wdata->xid,
-			       io_parms->persistent_fid,
-			       io_parms->tcon->tid,
-			       io_parms->tcon->ses->Suid,
-			       io_parms->offset,
-			       io_parms->length);
+			       io_parms.persistent_fid,
+			       io_parms.tcon->tid,
+			       io_parms.tcon->ses->Suid,
+			       io_parms.offset,
+			       io_parms.length);
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	/*
 	 * If we want to do a server RDMA read, fill in and append
 	 * smbdirect_buffer_descriptor_v1 to the end of write request
 	 */
-	if (smb3_use_rdma_offload(io_parms)) {
+	if (smb3_use_rdma_offload(&io_parms)) {
 		struct smbdirect_buffer_descriptor_v1 *v1;
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
@@ -5038,21 +5075,21 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		v1->token = cpu_to_le32(wdata->mr->mr->rkey);
 		v1->length = cpu_to_le32(wdata->mr->mr->length);
 
-		rqst.rq_iov[0].iov_len += sizeof(*v1);
+		smb->rqst.rq_iov[0].iov_len += sizeof(*v1);
 
 		/*
 		 * We keep wdata->subreq.io_iter,
 		 * but we have to truncate rqst.rq_iter
 		 */
-		iov_iter_truncate(&rqst.rq_iter, 0);
+		iov_iter_truncate(&smb->rqst.rq_iter, 0);
 	}
 #endif
 
 	if (wdata->subreq.retry_count > 0)
-		smb2_set_replay(server, &rqst);
+		smb2_set_replay(server, &smb->rqst);
 
 	cifs_dbg(FYI, "async write at %llu %u bytes iter=%zx\n",
-		 io_parms->offset, io_parms->length, iov_iter_count(&wdata->subreq.io_iter));
+		 io_parms.offset, io_parms.length, iov_iter_count(&wdata->subreq.io_iter));
 
 	if (wdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(wdata->subreq.len,
@@ -5073,27 +5110,28 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	}
 
 	/* XXX: compression + encryption is unsupported for now */
-	if (((flags & CIFS_TRANSFORM_REQ) != CIFS_TRANSFORM_REQ) && should_compress(tcon, &rqst))
+	if (((flags & CIFS_TRANSFORM_REQ) != CIFS_TRANSFORM_REQ) &&
+	    should_compress(tcon, smb))
 		flags |= CIFS_COMPRESS_REQ;
 
-	rc = cifs_call_async(server, &rqst, NULL, smb2_writev_callback, NULL,
-			     wdata, flags, &wdata->credits);
+	rc = cifs_call_async(server, smb, flags, &wdata->credits);
 	/* Can't touch wdata if rc == 0 */
 	if (rc) {
 		trace_smb3_write_err(wdata->rreq->debug_id,
 				     wdata->subreq.debug_index,
 				     xid,
-				     io_parms->persistent_fid,
-				     io_parms->tcon->tid,
-				     io_parms->tcon->ses->Suid,
-				     io_parms->offset,
-				     io_parms->length,
+				     io_parms.persistent_fid,
+				     io_parms.tcon->tid,
+				     io_parms.tcon->ses->Suid,
+				     io_parms.offset,
+				     io_parms.length,
 				     rc);
 		cifs_stats_fail_inc(tcon, SMB2_WRITE);
 	}
 
 async_writev_out:
 	cifs_small_buf_release(req);
+	smb_put_message(smb);
 out:
 	if (rc) {
 		trace_smb3_rw_credits(wdata->rreq->debug_id,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 6f1ce0399334..3018b171c6de 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -29,22 +29,20 @@ extern char *smb2_get_data_area_len(int *off, int *len,
 extern __le16 *cifs_convert_path_to_utf16(const char *from,
 					  struct cifs_sb_info *cifs_sb);
 
-extern int smb2_verify_signature(struct smb_rqst *, struct TCP_Server_Info *);
-extern int smb2_check_receive(struct smb_message *smb,
-			      struct TCP_Server_Info *server, bool log_error);
-extern struct smb_message *smb2_setup_request(struct cifs_ses *ses,
-					      struct TCP_Server_Info *,
-					      struct smb_rqst *rqst);
-extern struct smb_message *smb2_setup_async_request(
-			struct TCP_Server_Info *server, struct smb_rqst *rqst);
+int smb2_verify_signature(struct smb_message *smb, struct TCP_Server_Info *server);
+int smb2_check_receive(struct smb_message *smb, struct TCP_Server_Info *server,
+		       bool log_error);
+int smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
+		       struct smb_message *smb);
+int smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_message *smb);
 extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *server,
 						__u64 ses_id, __u32  tid);
-extern int smb2_calc_signature(struct smb_rqst *rqst,
-				struct TCP_Server_Info *server,
-				bool allocate_crypto);
-extern int smb3_calc_signature(struct smb_rqst *rqst,
-				struct TCP_Server_Info *server,
-				bool allocate_crypto);
+int smb2_calc_signature(struct smb_message *smb,
+			struct TCP_Server_Info *server,
+			bool allocate_crypto);
+int smb3_calc_signature(struct smb_message *smb,
+			struct TCP_Server_Info *server,
+			bool allocate_crypto);
 extern void smb2_echo_request(struct work_struct *work);
 extern __le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
 extern bool smb2_is_valid_oplock_break(char *buffer,
@@ -127,8 +125,7 @@ extern int smb2_unlock_range(struct cifsFileInfo *cfile,
 extern int smb2_push_mandatory_locks(struct cifsFileInfo *cfile);
 extern void smb2_reconnect_server(struct work_struct *work);
 extern int smb3_crypto_aead_allocate(struct TCP_Server_Info *server);
-extern unsigned long smb_rqst_len(struct TCP_Server_Info *server,
-				  struct smb_rqst *rqst);
+extern unsigned long smb_rqst_len(struct TCP_Server_Info *server, struct smb_rqst *rqst);
 extern void smb2_set_next_command(struct cifs_tcon *tcon,
 				  struct smb_rqst *rqst);
 extern void smb2_set_related(struct smb_rqst *rqst);
@@ -298,7 +295,7 @@ extern void smb2_copy_fs_info_to_kstatfs(
 extern int smb311_crypto_shash_allocate(struct TCP_Server_Info *server);
 extern int smb311_update_preauth_hash(struct cifs_ses *ses,
 				      struct TCP_Server_Info *server,
-				      struct kvec *iov, int nvec);
+				      struct smb_message *smb, bool hash_resp);
 extern int smb2_query_info_compound(const unsigned int xid,
 				    struct cifs_tcon *tcon,
 				    const char *path, u32 desired_access,
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index b217bc0e8e5b..b02f458e408a 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -252,14 +252,13 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, __u64 ses_id, __u32  tid)
 	return tcon;
 }
 
-int
-smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
+int smb2_calc_signature(struct smb_message *smb, struct TCP_Server_Info *server,
 			bool allocate_crypto)
 {
 	int rc;
 	unsigned char smb2_signature[SMB2_HMACSHA256_SIZE];
 	unsigned char *sigptr = smb2_signature;
-	struct kvec *iov = rqst->rq_iov;
+	struct kvec *iov = smb->rqst.rq_iov;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)iov[0].iov_base;
 	struct shash_desc *shash = NULL;
 	struct smb_rqst drqst;
@@ -308,7 +307,7 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	 * Sign the rfc1002 length prior to passing the data (iov[1-N]) down to
 	 * __cifs_calc_signature().
 	 */
-	drqst = *rqst;
+	drqst = smb->rqst;
 	if (drqst.rq_nvec >= 2 && iov[0].iov_len == 4) {
 		rc = crypto_shash_update(shash, iov[0].iov_base,
 					 iov[0].iov_len);
@@ -581,15 +580,14 @@ generate_smb311signingkey(struct cifs_ses *ses,
 	return generate_smb3signingkey(ses, server, &triplet);
 }
 
-int
-smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
+int smb3_calc_signature(struct smb_message *smb, struct TCP_Server_Info *server,
 			bool allocate_crypto)
 {
 	int rc;
 	unsigned char smb3_signature[SMB2_CMACAES_SIZE];
 	unsigned char *sigptr = smb3_signature;
-	struct kvec *iov = rqst->rq_iov;
-	struct smb2_hdr *shdr = (struct smb2_hdr *)iov[0].iov_base;
+	struct kvec *iov = smb->rqst.rq_iov;
+	struct smb2_hdr *shdr = smb->request;
 	struct shash_desc *shash = NULL;
 	struct smb_rqst drqst;
 	u8 key[SMB3_SIGN_KEY_SIZE];
@@ -635,7 +633,7 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	 * Sign the rfc1002 length prior to passing the data (iov[1-N]) down to
 	 * __cifs_calc_signature().
 	 */
-	drqst = *rqst;
+	drqst = smb->rqst;
 	if (drqst.rq_nvec >= 2 && iov[0].iov_len == 4) {
 		rc = crypto_shash_update(shash, iov[0].iov_base,
 					 iov[0].iov_len);
@@ -660,23 +658,22 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 
 /* must be called with server->srv_mutex held */
 static int
-smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
+smb2_sign_rqst(struct smb_message *smb, struct TCP_Server_Info *server)
 {
 	int rc = 0;
-	struct smb2_hdr *shdr;
+	struct smb2_hdr *shdr = smb->request;
 	struct smb2_sess_setup_req *ssr;
 	bool is_binding;
 	bool is_signed;
 
-	shdr = (struct smb2_hdr *)rqst->rq_iov[0].iov_base;
 	ssr = (struct smb2_sess_setup_req *)shdr;
 
-	is_binding = le16_to_cpu(shdr->Command) == SMB2_SESSION_SETUP &&
+	is_binding = smb->command_id == SMB2_SESSION_SETUP &&
 		(ssr->Flags & SMB2_SESSION_REQ_FLAG_BINDING);
 	is_signed = shdr->Flags & SMB2_FLAGS_SIGNED;
-
 	if (!is_signed)
 		return 0;
+
 	spin_lock(&server->srv_lock);
 	if (server->ops->need_neg &&
 	    server->ops->need_neg(server)) {
@@ -689,24 +686,21 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 		return 0;
 	}
 
-	rc = server->ops->calc_signature(rqst, server, false);
-
+	rc = server->ops->calc_signature(smb, server, false);
 	return rc;
 }
 
-int
-smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
+int smb2_verify_signature(struct smb_message *smb, struct TCP_Server_Info *server)
 {
-	unsigned int rc;
+	struct smb2_hdr *shdr = smb->request;
 	char server_response_sig[SMB2_SIGNATURE_SIZE];
-	struct smb2_hdr *shdr =
-			(struct smb2_hdr *)rqst->rq_iov[0].iov_base;
+	int rc;
 
-	if (le16_to_cpu(shdr->Command) == SMB2_NEGOTIATE ||
-	    le16_to_cpu(shdr->Command) == SMB2_SESSION_SETUP ||
-	    le16_to_cpu(shdr->Command) == SMB2_OPLOCK_BREAK ||
+	if (smb->command_id == SMB2_NEGOTIATE ||
+	    smb->command_id == SMB2_SESSION_SETUP ||
+	    smb->command_id == SMB2_OPLOCK_BREAK ||
 	    server->ignore_signature ||
-	    (!server->session_estab))
+	    !server->session_estab)
 		return 0;
 
 	/*
@@ -727,7 +721,7 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 
 	memset(shdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 
-	rc = server->ops->calc_signature(rqst, server, true);
+	rc = server->ops->calc_signature(smb, server, true);
 
 	if (rc)
 		return rc;
@@ -736,8 +730,8 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 		cifs_dbg(VFS, "sign fail cmd 0x%x message id 0x%llx\n",
 			shdr->Command, shdr->MessageId);
 		return -EACCES;
-	} else
-		return 0;
+	}
+	return 0;
 }
 
 /*
@@ -746,58 +740,40 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
  */
 static inline void
 smb2_seq_num_into_buf(struct TCP_Server_Info *server,
-		      struct smb2_hdr *shdr)
+		      struct smb_message *smb)
 {
-	unsigned int i, num = le16_to_cpu(shdr->CreditCharge);
+	struct smb2_hdr *shdr = smb->request;
+	unsigned int num = le16_to_cpu(shdr->CreditCharge);
 
-	shdr->MessageId = get_next_mid64(server);
 	/* skip message numbers according to CreditCharge field */
-	for (i = 1; i < num; i++)
-		get_next_mid(server);
+	smb->mid = get_next_mid64(server, num);
+	shdr->MessageId = cpu_to_le64(smb->mid);
 }
 
-static struct smb_message *
-smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
-		     struct TCP_Server_Info *server)
+static void smb2_init_mid(struct smb_message *smb,
+			  struct TCP_Server_Info *server)
 {
-	struct smb_message *smb;
+	const struct smb2_hdr *shdr = smb->request;
 	unsigned int credits = le16_to_cpu(shdr->CreditCharge);
 
-	if (server == NULL) {
-		cifs_dbg(VFS, "Null TCP session in smb2_mid_entry_alloc\n");
-		return NULL;
-	}
-
-	smb = mempool_alloc(&smb_message_pool, GFP_NOFS);
-	memset(smb, 0, sizeof(*smb));
-	refcount_set(&smb->ref, 1);
-	smb->mid = le64_to_cpu(shdr->MessageId);
-	smb->credits_consumed = credits > 0 ? credits : 1;
-	smb->pid = current->pid;
-	smb->command_id = le16_to_cpu(shdr->Command);
-	smb->when_alloc = jiffies;
-	smb->server = server;
+	smb->credits_consumed	= credits > 0 ? credits : 1;
+	smb->server		= server;
 
 	/*
 	 * The default is for the mid to be synchronous, so the
 	 * default callback just wakes up the current task.
 	 */
-	get_task_struct(current);
-	smb->creator = current;
-	smb->callback = cifs_wake_up_task;
-	smb->callback_data = current;
+	smb->creator		= get_task_struct(current);
 
 	atomic_inc(&mid_count);
-	smb->mid_state = MID_REQUEST_ALLOCATED;
 	trace_smb3_cmd_enter(le32_to_cpu(shdr->Id.SyncId.TreeId),
 			     le64_to_cpu(shdr->SessionId),
 			     le16_to_cpu(shdr->Command), smb->mid);
-	return smb;
 }
 
 static int
 smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
-		   struct smb2_hdr *shdr, struct smb_message **smb)
+		   struct smb_message *smb)
 {
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsExiting) {
@@ -812,7 +788,7 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	}
 
 	if (server->tcpStatus == CifsNeedNegotiate &&
-	    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE) {
+	    smb->command_id != SMB2_NEGOTIATE) {
 		spin_unlock(&server->srv_lock);
 		return -EAGAIN;
 	}
@@ -820,8 +796,8 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 
 	spin_lock(&ses->ses_lock);
 	if (ses->ses_status == SES_NEW) {
-		if (le16_to_cpu(shdr->Command) != SMB2_SESSION_SETUP &&
-		    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE) {
+		if (smb->command_id != SMB2_SESSION_SETUP &&
+		    smb->command_id != SMB2_NEGOTIATE) {
 			spin_unlock(&ses->ses_lock);
 			return -EAGAIN;
 		}
@@ -829,7 +805,7 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	}
 
 	if (ses->ses_status == SES_EXITING) {
-		if (le16_to_cpu(shdr->Command) != SMB2_LOGOFF) {
+		if (smb->command_id != SMB2_LOGOFF) {
 			spin_unlock(&ses->ses_lock);
 			return -EAGAIN;
 		}
@@ -837,101 +813,78 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	}
 	spin_unlock(&ses->ses_lock);
 
-	*smb = smb2_mid_entry_alloc(shdr, server);
-	if (*smb == NULL)
-		return -ENOMEM;
+	smb2_init_mid(smb, server);
+
+	smb_get_message(smb);
 	spin_lock(&server->mid_lock);
-	list_add_tail(&(*smb)->qhead, &server->pending_mid_q);
+	list_add_tail(&smb->qhead, &server->pending_mid_q);
 	spin_unlock(&server->mid_lock);
-
 	return 0;
 }
 
-int
-smb2_check_receive(struct smb_message *mid, struct TCP_Server_Info *server,
-		   bool log_error)
+int smb2_check_receive(struct smb_message *smb, struct TCP_Server_Info *server,
+		       bool log_error)
 {
-	unsigned int len = mid->resp_buf_size;
-	struct kvec iov[1];
-	struct smb_rqst rqst = { .rq_iov = iov,
-				 .rq_nvec = 1 };
+	unsigned int len = smb->resp_buf_size;
 
-	iov[0].iov_base = (char *)mid->resp_buf;
-	iov[0].iov_len = len;
-
-	dump_smb(mid->resp_buf, min_t(u32, 80, len));
+	dump_smb(smb->resp_buf, min_t(u32, 80, len));
 	/* convert the length into a more usable form */
-	if (len > 24 && server->sign && !mid->decrypted) {
+	if (len > 24 && server->sign && !smb->decrypted) {
 		int rc;
 
-		rc = smb2_verify_signature(&rqst, server);
+		rc = smb2_verify_signature(smb, server);
 		if (rc)
 			cifs_server_dbg(VFS, "SMB signature verification returned error = %d\n",
 				 rc);
 	}
 
-	return map_smb2_to_linux_error(mid->resp_buf, log_error);
+	return map_smb2_to_linux_error(smb->resp_buf, log_error);
 }
 
-struct smb_message *
-smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
-		   struct smb_rqst *rqst)
+int smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
+		       struct smb_message *smb)
 {
+	struct smb2_hdr *shdr = smb->request;
 	int rc;
-	struct smb2_hdr *shdr =
-			(struct smb2_hdr *)rqst->rq_iov[0].iov_base;
-	struct smb_message *mid;
 
-	smb2_seq_num_into_buf(server, shdr);
+	smb2_seq_num_into_buf(server, smb);
 
-	rc = smb2_get_mid_entry(ses, server, shdr, &mid);
+	rc = smb2_get_mid_entry(ses, server, smb);
 	if (rc) {
 		revert_current_mid_from_hdr(server, shdr);
-		return ERR_PTR(rc);
+		return rc;
 	}
 
-	rc = smb2_sign_rqst(rqst, server);
-	if (rc) {
+	rc = smb2_sign_rqst(smb, server);
+	if (rc)
 		revert_current_mid_from_hdr(server, shdr);
-		delete_mid(mid);
-		return ERR_PTR(rc);
-	}
-
-	return mid;
+	return rc;
 }
 
-struct smb_message *
-smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
+int
+smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_message *smb)
 {
+	struct smb2_hdr *shdr = smb->request;
 	int rc;
-	struct smb2_hdr *shdr =
-			(struct smb2_hdr *)rqst->rq_iov[0].iov_base;
-	struct smb_message *smb;
 
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsNeedNegotiate &&
-	    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE) {
+	   smb->command_id != SMB2_NEGOTIATE) {
 		spin_unlock(&server->srv_lock);
-		return ERR_PTR(-EAGAIN);
+		return -EAGAIN;
 	}
 	spin_unlock(&server->srv_lock);
 
-	smb2_seq_num_into_buf(server, shdr);
-
-	smb = smb2_mid_entry_alloc(shdr, server);
-	if (smb == NULL) {
-		revert_current_mid_from_hdr(server, shdr);
-		return ERR_PTR(-ENOMEM);
-	}
+	smb2_seq_num_into_buf(server, smb);
+	smb2_init_mid(smb, server);
 
-	rc = smb2_sign_rqst(rqst, server);
+	rc = smb2_sign_rqst(smb, server);
 	if (rc) {
 		revert_current_mid_from_hdr(server, shdr);
-		release_mid(smb);
-		return ERR_PTR(rc);
+		return rc;
 	}
 
-	return smb;
+	return 0;
 }
 
 int
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 6459acf959f3..042f689bbf52 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -40,7 +40,17 @@ struct smb_message *smb_message_alloc(enum smb2_command cmd, gfp_t gfp)
 	if (smb) {
 		memset(smb, 0, sizeof(*smb));
 		refcount_set(&smb->ref, 1);
-		smb->command_id = cmd;
+		smb->command_id	= cmd;
+		smb->when_alloc	= jiffies;
+		smb->pid	= current->pid;
+
+		/*
+		 * The default is for the mid to be synchronous, so the default
+		 * callback just wakes up the current task.
+		 */
+		smb->callback		= cifs_wake_up_task;
+		smb->callback_data	= current;
+		smb->mid_state		= MID_REQUEST_ALLOCATED;
 	}
 	return smb;
 }
@@ -60,7 +70,8 @@ void smb_put_message(struct smb_message *smb)
 }
 
 /*
- * Dispose of a chain of compound messages.
+ * Dispose of a chain of compound messages.  This should only be called by the
+ * caller of smb_send_recv_messages().
  */
 void smb_put_messages(struct smb_message *smb)
 {
@@ -80,7 +91,7 @@ cifs_wake_up_task(struct smb_message *smb)
 	wake_up_process(smb->callback_data);
 }
 
-void __release_mid(struct smb_message *smb)
+static void smb_clear_mid(struct smb_message *smb, struct TCP_Server_Info *server)
 {
 #ifdef CONFIG_CIFS_STATS2
 	enum smb2_command command = smb->server->vals->lock_cmd;
@@ -88,7 +99,6 @@ void __release_mid(struct smb_message *smb)
 	unsigned long now;
 	unsigned long roundtrip_time;
 #endif
-	struct TCP_Server_Info *server = smb->server;
 
 	if (smb->resp_buf && (smb->mid_flags & MID_WAIT_CANCELLED) &&
 	    (smb->mid_state == MID_RESPONSE_RECEIVED ||
@@ -154,22 +164,33 @@ void __release_mid(struct smb_message *smb)
 	}
 #endif
 	put_task_struct(smb->creator);
-
-	mempool_free(smb, &smb_message_pool);
 }
 
-void
-delete_mid(struct smb_message *smb)
+static bool discard_message(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	spin_lock(&smb->server->mid_lock);
+	bool got_ref = false;
+
+	spin_lock(&server->mid_lock);
 
 	if (!(smb->mid_flags & MID_DELETED)) {
 		list_del_init(&smb->qhead);
 		smb->mid_flags |= MID_DELETED;
+		got_ref = true;
 	}
-	spin_unlock(&smb->server->mid_lock);
 
-	release_mid(smb);
+	spin_unlock(&server->mid_lock);
+	return got_ref;
+}
+
+static void smb_discard_messages(struct TCP_Server_Info *server, struct smb_message *head_smb)
+{
+	struct smb_message *smb, *next;
+
+	for (smb = head_smb; smb; smb = next) {
+		next = smb->next;
+		if (discard_message(server, smb))
+			smb_put_message(smb);
+	}
 }
 
 /*
@@ -456,20 +477,16 @@ static size_t smb3_copy_data_iter(void *iter_from, size_t progress, size_t len,
  * at the front for the header(s).
  */
 static int smb_copy_data_into_buffer(struct TCP_Server_Info *server,
-				     int num_rqst, struct smb_rqst *rqst,
+				     struct smb_message *head_smb,
 				     struct iov_iter *iter, struct bvecq **_bq)
 {
+	struct smb_message *smb;
 	struct bvecq *bq;
 	size_t total_len = 0, offset = 0;
 
-	for (int i = 0; i < num_rqst; i++) {
-		struct smb_rqst *req = &rqst[i];
-		size_t size = iov_iter_count(&req->rq_iter);
-
-		for (int j = 0; j < req->rq_nvec; j++)
-			size += req->rq_iov[j].iov_len;
+	for (smb = head_smb; smb; smb = smb->next) {
 		total_len = ALIGN8(total_len);
-		total_len += size;
+		total_len += smb->total_len;
 	}
 
 	bq = netfs_alloc_bvecq_buffer(total_len, 1, GFP_NOFS);
@@ -478,9 +495,8 @@ static int smb_copy_data_into_buffer(struct TCP_Server_Info *server,
 
 	iov_iter_bvec_queue(iter, ITER_DEST, bq, 1, 0, total_len);
 
-	for (int i = 0; i < num_rqst; i++) {
-		struct smb_rqst *req = &rqst[i];
-		size_t size = iov_iter_count(&req->rq_iter);
+	for (smb = head_smb; smb; smb = smb->next) {
+		size_t size = iov_iter_count(&smb->rqst.rq_iter);
 
 		if (offset & 7) {
 			unsigned int tmp = offset;
@@ -488,14 +504,15 @@ static int smb_copy_data_into_buffer(struct TCP_Server_Info *server,
 			iov_iter_zero(offset - tmp, iter);
 		}
 
-		for (int j = 0; j < req->rq_nvec; j++) {
-			size_t len = req->rq_iov[j].iov_len;
-			if (copy_to_iter(req->rq_iov[j].iov_base, len, iter) != len)
+		for (int i = 0; i < smb->rqst.rq_nvec; i++) {
+			size_t len = smb->rqst.rq_iov[i].iov_len;
+			if (copy_to_iter(smb->rqst.rq_iov[i].iov_base,
+					 len, iter) != len)
 				goto error;
 			offset += len;
 		}
 
-		if (iterate_and_advance_kernel(&req->rq_iter,
+		if (iterate_and_advance_kernel(&smb->rqst.rq_iter,
 					       size, iter, NULL,
 					       smb3_copy_data_iter) != size)
 			goto error;
@@ -517,8 +534,7 @@ static int smb_copy_data_into_buffer(struct TCP_Server_Info *server,
 }
 
 static int
-smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
-	      struct smb_rqst *rqst, int flags)
+smb_send_rqst(struct TCP_Server_Info *server, struct smb_message *head_smb, int flags)
 {
 	struct smb2_transform_hdr *tr_hdr;
 	struct iov_iter iter;
@@ -532,7 +548,7 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 		return -EIO;
 	}
 
-	rc = smb_copy_data_into_buffer(server, num_rqst, rqst, &iter, &bq);
+	rc = smb_copy_data_into_buffer(server, head_smb, &iter, &bq);
 	if (rc)
 		return rc;
 	content_len = iov_iter_count(&iter);
@@ -562,7 +578,7 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			hdr_len += sizeof(*tr_hdr);
 			iov_iter_bvec_queue(&iter, ITER_SOURCE, bq, 1, 0, content_len);
 
-			rc = server->ops->init_transform_rq(server, num_rqst, rqst, tr_hdr, &iter);
+			rc = server->ops->init_transform_rq(server, head_smb, tr_hdr, &iter);
 			if (rc)
 				goto error;
 		}
@@ -816,16 +832,16 @@ int wait_for_response(struct TCP_Server_Info *server, struct smb_message *smb)
  * the result. Caller is responsible for dealing with timeouts.
  */
 int
-cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
-		mid_receive_t receive, mid_callback_t callback,
-		mid_handle_t handle, void *cbdata, const int flags,
-		const struct cifs_credits *exist_credits)
+cifs_call_async(struct TCP_Server_Info *server, struct smb_message *smb,
+		const int flags, const struct cifs_credits *exist_credits)
 {
-	int rc;
-	struct smb_message *smb;
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
 	unsigned int instance;
 	int optype;
+	int rc;
+
+	if (WARN_ON_ONCE(smb->next))
+		return -EIO;
 
 	optype = flags & CIFS_OP_MASK;
 
@@ -851,21 +867,17 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 		return -EAGAIN;
 	}
 
-	smb = server->ops->setup_async_request(server, rqst);
-	if (IS_ERR(smb)) {
+	rc = server->ops->setup_async_request(server, smb);
+	if (rc) {
 		cifs_server_unlock(server);
 		add_credits_and_wake_if(server, &credits, optype);
-		return PTR_ERR(smb);
+		return rc;
 	}
 
-	smb->sr_flags = flags;
-	smb->receive = receive;
-	smb->callback = callback;
-	smb->callback_data = cbdata;
-	smb->handle = handle;
 	smb->mid_state = MID_REQUEST_SUBMITTED;
 
 	/* put it on the pending_mid_q */
+	smb_get_message(smb);
 	spin_lock(&server->mid_lock);
 	list_add_tail(&smb->qhead, &server->pending_mid_q);
 	spin_unlock(&server->mid_lock);
@@ -875,12 +887,13 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	 * I/O response may come back and free the mid entry on another thread.
 	 */
 	cifs_save_when_sent(smb);
-	rc = smb_send_rqst(server, 1, rqst, flags);
+	rc = smb_send_rqst(server, smb, flags);
 
 	if (rc < 0) {
 		revert_current_mid(server, smb->credits_consumed);
 		server->sequence_number -= 2;
-		delete_mid(smb);
+		if (discard_message(server, smb))
+			smb_put_message(smb);
 	}
 
 	cifs_server_unlock(server);
@@ -930,7 +943,7 @@ int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info *server
 	spin_unlock(&server->mid_lock);
 
 sync_mid_done:
-	release_mid(smb);
+	smb_clear_mid(smb, server);
 	return rc;
 }
 
@@ -960,7 +973,6 @@ static void
 cifs_cancelled_callback(struct smb_message *smb)
 {
 	cifs_compound_callback(smb);
-	release_mid(smb);
 }
 
 /*
@@ -1017,31 +1029,29 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 	return server;
 }
 
-int
-compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
-		   struct TCP_Server_Info *server,
-		   const int flags, const int num_rqst, struct smb_rqst *rqst,
-		   int *resp_buf_type, struct kvec *resp_iov)
+/*
+ * Send a single message or a string of messages as a compound.
+ */
+int smb_send_recv_messages(const unsigned int xid, struct cifs_ses *ses,
+			   struct TCP_Server_Info *server,
+			   struct smb_message *head_smb, const int flags)
 {
-	int i, j, optype, rc = 0;
-	struct smb_message *smb[MAX_COMPOUND];
-	bool cancelled_mid[MAX_COMPOUND] = {false};
-	struct cifs_credits credits[MAX_COMPOUND] = {
-		{ .value = 0, .instance = 0 }
-	};
 	unsigned int instance;
+	int nr_reqs, i, optype, rc = 0;
 	char *buf;
 
-	optype = flags & CIFS_OP_MASK;
-
-	for (i = 0; i < num_rqst; i++)
-		resp_buf_type[i] = CIFS_NO_BUFFER;  /* no response buf yet */
-
 	if (!ses || !ses->server || !server) {
 		cifs_dbg(VFS, "Null session\n");
 		return -EIO;
 	}
 
+	optype = flags & CIFS_OP_MASK;
+
+	/* TODO: Stitch together the messages in a compound. */
+	nr_reqs = 0;
+	for (struct smb_message *smb = head_smb; smb; smb = smb->next)
+		nr_reqs++;
+
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsExiting) {
 		spin_unlock(&server->srv_lock);
@@ -1057,14 +1067,13 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	 * other requests.
 	 * This can be handled by the eventual session reconnect.
 	 */
-	rc = wait_for_compound_request(server, num_rqst, flags,
-				       &instance);
+	rc = wait_for_compound_request(server, nr_reqs, flags, &instance);
 	if (rc)
 		return rc;
 
-	for (i = 0; i < num_rqst; i++) {
-		credits[i].value = 1;
-		credits[i].instance = instance;
+	for (struct smb_message *smb = head_smb; smb; smb = smb->next) {
+		smb->credits.value	= 1;
+		smb->credits.instance	= instance;
 	}
 
 	/*
@@ -1084,45 +1093,46 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	 */
 	if (instance != server->reconnect_instance) {
 		cifs_server_unlock(server);
-		for (j = 0; j < num_rqst; j++)
-			add_credits(server, &credits[j], optype);
+		for (struct smb_message *smb = head_smb; smb; smb = smb->next)
+			add_credits(server, &smb->credits, optype);
 		return -EAGAIN;
 	}
 
-	for (i = 0; i < num_rqst; i++) {
-		smb[i] = server->ops->setup_request(ses, server, &rqst[i]);
-		if (IS_ERR(smb[i])) {
-			revert_current_mid(server, i);
-			for (j = 0; j < i; j++)
-				delete_mid(smb[j]);
-			cifs_server_unlock(server);
-
-			/* Update # of requests on wire to server */
-			for (j = 0; j < num_rqst; j++)
-				add_credits(server, &credits[j], optype);
-			return PTR_ERR(smb[i]);
-		}
-
-		smb[i]->sr_flags = flags;
-		smb[i]->mid_state = MID_REQUEST_SUBMITTED;
-		smb[i]->optype = optype;
+	i = 0;
+	for (struct smb_message *smb = head_smb; smb; smb = smb->next) {
+		smb->optype = optype;
 		/*
 		 * Invoke callback for every part of the compound chain
 		 * to calculate credits properly. Wake up this thread only when
 		 * the last element is received.
 		 */
-		if (i < num_rqst - 1)
-			smb[i]->callback = cifs_compound_callback;
+		if (smb->next)
+			smb->callback = cifs_compound_callback;
 		else
-			smb[i]->callback = cifs_compound_last_callback;
+			smb->callback = cifs_compound_last_callback;
+
+		rc = server->ops->setup_request(ses, server, smb);
+		if (rc) {
+			revert_current_mid(server, i);
+			smb_discard_messages(server, head_smb);
+			cifs_server_unlock(server);
+
+			/* Update # of requests on wire to server */
+			for (struct smb_message *smb = head_smb; smb; smb = smb->next)
+				add_credits(server, &smb->credits, optype);
+			return rc;
+		}
+
+		smb->mid_state = MID_REQUEST_SUBMITTED;
 	}
-	rc = smb_send_rqst(server, num_rqst, rqst, flags);
 
-	for (i = 0; i < num_rqst; i++)
-		cifs_save_when_sent(smb[i]);
+	rc = smb_send_rqst(server, head_smb, flags);
+
+	for (struct smb_message *smb = head_smb; smb; smb = smb->next)
+		cifs_save_when_sent(smb);
 
 	if (rc < 0) {
-		revert_current_mid(server, num_rqst);
+		revert_current_mid(server, nr_reqs);
 		server->sequence_number -= 2;
 	}
 
@@ -1133,8 +1143,8 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	 * will not receive a response to - return credits back
 	 */
 	if (rc < 0 || (flags & CIFS_NO_SRV_RSP)) {
-		for (i = 0; i < num_rqst; i++)
-			add_credits(server, &credits[i], optype);
+		for (struct smb_message *smb = head_smb; smb; smb = smb->next)
+			add_credits(server, &smb->credits, optype);
 		goto out;
 	}
 
@@ -1154,70 +1164,71 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		spin_unlock(&ses->ses_lock);
 
 		cifs_server_lock(server);
-		smb311_update_preauth_hash(ses, server, rqst[0].rq_iov, rqst[0].rq_nvec);
+		smb311_update_preauth_hash(ses, server, head_smb, false);
 		cifs_server_unlock(server);
-
-		spin_lock(&ses->ses_lock);
+	} else {
+		spin_unlock(&ses->ses_lock);
 	}
-	spin_unlock(&ses->ses_lock);
 
-	for (i = 0; i < num_rqst; i++) {
-		rc = wait_for_response(server, smb[i]);
-		if (rc != 0)
-			break;
+	for (struct smb_message *smb = head_smb; smb; smb = smb->next) {
+		if (!smb->next) {
+			rc = wait_for_response(server, smb);
+			if (rc != 0)
+				break;
+		}
 	}
 	if (rc != 0) {
-		for (; i < num_rqst; i++) {
+		for (struct smb_message *smb = head_smb; smb; smb = smb->next) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
-				 smb[i]->mid, smb[i]->command_id);
-			send_cancel(ses, server, &rqst[i], smb[i], xid);
+					smb->mid, smb->command_id);
+			send_cancel(ses, server, smb, xid);
 			spin_lock(&server->mid_lock);
-			smb[i]->mid_flags |= MID_WAIT_CANCELLED;
-			if (smb[i]->mid_state == MID_REQUEST_SUBMITTED ||
-			    smb[i]->mid_state == MID_RESPONSE_RECEIVED) {
-				smb[i]->callback = cifs_cancelled_callback;
-				cancelled_mid[i] = true;
-				credits[i].value = 0;
+			smb->mid_flags |= MID_WAIT_CANCELLED;
+			if (smb->mid_state == MID_REQUEST_SUBMITTED ||
+			    smb->mid_state == MID_RESPONSE_RECEIVED) {
+				smb->callback = cifs_cancelled_callback;
+				smb->cancelled = true;
+				smb->credits.value = 0;
 			}
 			spin_unlock(&server->mid_lock);
 		}
 	}
 
-	for (i = 0; i < num_rqst; i++) {
+	for (struct smb_message *smb = head_smb; smb; smb = smb->next) {
 		if (rc < 0)
 			goto out;
 
-		rc = cifs_sync_mid_result(smb[i], server);
+		rc = cifs_sync_mid_result(smb, server);
 		if (rc != 0) {
 			/* mark this mid as cancelled to not free it below */
-			cancelled_mid[i] = true;
+			smb->cancelled = true;
 			goto out;
 		}
 
-		if (!smb[i]->resp_buf ||
-		    smb[i]->mid_state != MID_RESPONSE_READY) {
+		if (!smb->resp_buf ||
+		    smb->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
 			goto out;
 		}
 
-		rc = server->ops->check_receive(smb[i], server,
-						     flags & CIFS_LOG_ERROR);
+		rc = server->ops->check_receive(smb, server,
+						flags & CIFS_LOG_ERROR);
 
-		if (resp_iov) {
-			buf = (char *)smb[i]->resp_buf;
-			resp_iov[i].iov_base = buf;
-			resp_iov[i].iov_len = smb[i]->resp_buf_size +
+		if (smb->resp_iov) {
+			buf = (char *)smb->resp_buf;
+			smb->resp_iov->iov_base = buf;
+			smb->resp_iov->iov_len = smb->resp_buf_size +
 				HEADER_PREAMBLE_SIZE(server);
 
-			if (smb[i]->large_buf)
-				resp_buf_type[i] = CIFS_LARGE_BUFFER;
+			if (smb->large_buf)
+				*smb->resp_buf_type = CIFS_LARGE_BUFFER;
 			else
-				resp_buf_type[i] = CIFS_SMALL_BUFFER;
+				*smb->resp_buf_type = CIFS_SMALL_BUFFER;
 
 			/* mark it so buf will not be freed by delete_mid */
 			if ((flags & CIFS_NO_RSP_BUF) == 0)
-				smb[i]->resp_buf = NULL;
+				smb->resp_buf = NULL;
 		}
 	}
 
@@ -1226,17 +1237,13 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	 */
 	spin_lock(&ses->ses_lock);
 	if ((ses->ses_status == SES_NEW) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
-		struct kvec iov = {
-			.iov_base = resp_iov[0].iov_base,
-			.iov_len = resp_iov[0].iov_len
-		};
 		spin_unlock(&ses->ses_lock);
 		cifs_server_lock(server);
-		smb311_update_preauth_hash(ses, server, &iov, 1);
+		smb311_update_preauth_hash(ses, server, head_smb, true);
 		cifs_server_unlock(server);
-		spin_lock(&ses->ses_lock);
+	} else {
+		spin_unlock(&ses->ses_lock);
 	}
-	spin_unlock(&ses->ses_lock);
 
 out:
 	/*
@@ -1245,11 +1252,51 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	 * This is prevented above by using a noop callback that will not
 	 * wake this thread except for the very last PDU.
 	 */
-	for (i = 0; i < num_rqst; i++) {
-		if (!cancelled_mid[i])
-			delete_mid(smb[i]);
+	for (struct smb_message *smb = head_smb; smb; smb = smb->next)
+		if (!smb->cancelled)
+			discard_message(server, smb);
+
+	return rc;
+}
+
+int
+compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
+		   struct TCP_Server_Info *server,
+		   const int flags, const int num_rqst, struct smb_rqst *rqst,
+		   int *resp_buf_type, struct kvec *resp_iov)
+{
+	struct smb_message *head_smb = NULL, **ppsmb = &head_smb, *smb;
+	int rc = -ENOMEM;
+
+	if (!ses || !ses->server || !server) {
+		cifs_dbg(VFS, "Null session\n");
+		return -EIO;
+	}
+
+	for (int i = 0; i < num_rqst; i++) {
+		void *request = rqst[i].rq_iov[0].iov_base;
+		struct smb2_hdr *hdr = request;
+		enum smb2_command cmd = le16_to_cpu(hdr->Command);
+
+		smb = smb_message_alloc(cmd, GFP_NOFS);
+		if (!smb)
+			goto error;
+
+		*ppsmb = smb;
+		ppsmb = &smb->next;
+		smb->request		= request;
+		smb->rqst		= rqst[i];
+		smb->sr_flags		= flags;
+		smb->total_len		= smb_rqst_len(server, &smb->rqst);
+		smb->resp_buf_type	= &resp_buf_type[i];
+		smb->resp_iov		= &resp_iov[i];
+		resp_buf_type[i] = CIFS_NO_BUFFER;  /* no response buf yet */
 	}
 
+	rc = smb_send_recv_messages(xid, ses, server, head_smb, flags);
+
+error:
+	smb_put_messages(smb);
 	return rc;
 }
 


