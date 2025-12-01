Return-Path: <linux-fsdevel+bounces-70401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 524FEC997BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 198424E264A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EBC2D6E42;
	Mon,  1 Dec 2025 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLQUAk10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793F2C327A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629895; cv=none; b=LAsfgwFsZSmt9VhcUPxFbFn1N9O2w5PgJFED7TZop8rYodvM3vRde+NDvB18OKIkTzO/6PyIxi7zkz+qWBBi9U864I6u8cDyGfj3PCr0aDOWTlXtK1sL08V20QKCzrLieONHZGeb/YAtKyWQ6Klzbm7CJfiM8FvYFdXKPN8xzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629895; c=relaxed/simple;
	bh=ww7Y+4ci+YtAD5oSLu6aJ7Z98wwrhb62fJiwXPIfRvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvzebxIDWKxIFx/vWH93YpUieUWXRmhOATjufGOwOZFfTx+h5rcajUVFSuhl+hW78RR680a9wVZBwPUNJakXXrk6cuwmYGcTjtb11nrG91HQR5xqEBkl9nAI0Tn3kE8GCWIoKv8Fw5PLHQbOY5/MRWJjFxUtlqfxEde7M8TTQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLQUAk10; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764629891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IK8XnacOBIfX/7TLT+Bj4AH8WmJ9K2ndRKm33ZDlOxs=;
	b=RLQUAk103hyMfjMBy5gsox8MtQD3Vbux7JFdfze1/yJCkdhZwY6SXG1SI3tvOVvYwzpnWm
	t/ELQqSh6aOu82qHr0yuVTeyGny3dzYpe+72vMkq4rTLcx7X0RJiEgme86EMy4uKcUKwcD
	wcQK0BltdBEPnXj8QZI2YYI90WsYzZ4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-3sSD0racOaOTCJEj7zn2IQ-1; Mon,
 01 Dec 2025 17:58:06 -0500
X-MC-Unique: 3sSD0racOaOTCJEj7zn2IQ-1
X-Mimecast-MFC-AGG-ID: 3sSD0racOaOTCJEj7zn2IQ_1764629884
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99DA01956053;
	Mon,  1 Dec 2025 22:58:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C463D195608E;
	Mon,  1 Dec 2025 22:58:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/9] cifs: Remove the server pointer from smb_message
Date: Mon,  1 Dec 2025 22:57:27 +0000
Message-ID: <20251201225732.1520128-7-dhowells@redhat.com>
In-Reply-To: <20251201225732.1520128-1-dhowells@redhat.com>
References: <20251201225732.1520128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove the server pointer from smb_message and instead pass it down to all
the things that access it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com> (RDMA, smbdirect)
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsfs.c        |  7 +++--
 fs/smb/client/cifsglob.h      | 14 +++++-----
 fs/smb/client/cifsproto.h     | 21 ++++++++++-----
 fs/smb/client/cifssmb.c       | 15 +++++------
 fs/smb/client/cifstransport.c | 15 +++++------
 fs/smb/client/connect.c       | 34 ++++++++++++------------
 fs/smb/client/netmisc.c       |  5 ++--
 fs/smb/client/smb1ops.c       |  4 +--
 fs/smb/client/smb2ops.c       | 22 ++++++++--------
 fs/smb/client/smb2pdu.c       | 26 ++++++++-----------
 fs/smb/client/smb2transport.c |  9 +++----
 fs/smb/client/transport.c     | 49 ++++++++++++++++-------------------
 12 files changed, 108 insertions(+), 113 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 185ac41bd7e9..44d3dec9743b 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -442,7 +442,7 @@ static struct kmem_cache *cifs_io_request_cachep;
 static struct kmem_cache *cifs_io_subrequest_cachep;
 mempool_t *cifs_sm_req_poolp;
 mempool_t *cifs_req_poolp;
-mempool_t *cifs_mid_poolp;
+mempool_t cifs_mid_pool;
 mempool_t cifs_io_request_pool;
 mempool_t cifs_io_subrequest_pool;
 
@@ -1844,8 +1844,7 @@ static int init_mids(void)
 		return -ENOMEM;
 
 	/* 3 is a reasonable minimum number of simultaneous operations */
-	cifs_mid_poolp = mempool_create_slab_pool(3, cifs_mid_cachep);
-	if (cifs_mid_poolp == NULL) {
+	if (mempool_init_slab_pool(&cifs_mid_pool, 3, cifs_mid_cachep) < 0) {
 		kmem_cache_destroy(cifs_mid_cachep);
 		return -ENOMEM;
 	}
@@ -1855,7 +1854,7 @@ static int init_mids(void)
 
 static void destroy_mids(void)
 {
-	mempool_destroy(cifs_mid_poolp);
+	mempool_exit(&cifs_mid_pool);
 	kmem_cache_destroy(cifs_mid_cachep);
 }
 
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 18ac91d0982d..1f93c309dfe8 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1671,7 +1671,7 @@ typedef int (*mid_receive_t)(struct TCP_Server_Info *server,
  * - it will be called by cifsd, with no locks held
  * - the mid will be removed from any lists
  */
-typedef void (*mid_callback_t)(struct mid_q_entry *mid);
+typedef void (*mid_callback_t)(struct TCP_Server_Info *srv, struct mid_q_entry *mid);
 
 /*
  * This is the protopyte for mid handle function. This is called once the mid
@@ -1683,8 +1683,7 @@ typedef int (*mid_handle_t)(struct TCP_Server_Info *server,
 /* one of these for every pending CIFS request to the server */
 struct mid_q_entry {
 	struct list_head qhead;	/* mids waiting on reply from this server */
-	struct kref refcount;
-	struct TCP_Server_Info *server;	/* server corresponding to this mid */
+	refcount_t refcount;
 	__u64 mid;		/* multiplex id */
 	__u16 credits;		/* number of credits consumed by this mid */
 	__u16 credits_received;	/* number of credits from the response */
@@ -2109,7 +2108,7 @@ extern __u32 cifs_lock_secret;
 
 extern mempool_t *cifs_sm_req_poolp;
 extern mempool_t *cifs_req_poolp;
-extern mempool_t *cifs_mid_poolp;
+extern mempool_t cifs_mid_pool;
 extern mempool_t cifs_io_request_pool;
 extern mempool_t cifs_io_subrequest_pool;
 
@@ -2356,9 +2355,10 @@ static inline bool cifs_netbios_name(const char *name, size_t namelen)
  * Execute mid callback atomically - ensures callback runs exactly once
  * and prevents sleeping in atomic context.
  */
-static inline void mid_execute_callback(struct mid_q_entry *mid)
+static inline void mid_execute_callback(struct TCP_Server_Info *server,
+					struct mid_q_entry *mid)
 {
-	void (*callback)(struct mid_q_entry *mid);
+	mid_callback_t callback;
 
 	spin_lock(&mid->mid_lock);
 	callback = mid->callback;
@@ -2366,7 +2366,7 @@ static inline void mid_execute_callback(struct mid_q_entry *mid)
 	spin_unlock(&mid->mid_lock);
 
 	if (callback)
-		callback(mid);
+		callback(server, mid);
 }
 
 #define CIFS_REPARSE_SUPPORT(tcon) \
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 9a307c9c8c56..d72d66dcb953 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -82,9 +82,9 @@ extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
 				     int add_treename);
 extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
 char *cifs_build_devname(char *nodename, const char *prepath);
-extern void delete_mid(struct mid_q_entry *mid);
-void __release_mid(struct kref *refcount);
-extern void cifs_wake_up_task(struct mid_q_entry *mid);
+void delete_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid);
+void __release_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid);
+void cifs_wake_up_task(struct TCP_Server_Info *server, struct mid_q_entry *mid);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
 extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
@@ -180,7 +180,8 @@ extern int decode_negTokenInit(unsigned char *security_blob, int length,
 extern int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
 extern void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
 extern int map_smb_to_linux_error(char *buf, bool logErr);
-extern int map_and_check_smb_error(struct mid_q_entry *mid, bool logErr);
+extern int map_and_check_smb_error(struct TCP_Server_Info *server,
+				   struct mid_q_entry *mid, bool logErr);
 unsigned int header_assemble(struct smb_hdr *buffer, char smb_command,
 			     const struct cifs_tcon *treeCon, int word_count
 			     /* length of fixed section word count in two byte units  */);
@@ -263,7 +264,7 @@ extern unsigned int setup_special_mode_ACE(struct smb_ace *pace,
 					   __u64 nmode);
 extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
 
-extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
+void dequeue_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid, bool malformed);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 			         unsigned int to_read);
 extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
@@ -767,9 +768,15 @@ static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
 	return true;
 }
 
-static inline void release_mid(struct mid_q_entry *mid)
+static inline void smb_get_mid(struct mid_q_entry *mid)
 {
-	kref_put(&mid->refcount, __release_mid);
+	refcount_inc(&mid->refcount);
+}
+
+static inline void release_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid)
+{
+	if (refcount_dec_and_test(&mid->refcount))
+		__release_mid(server, mid);
 }
 
 static inline void cifs_free_open_info(struct cifs_open_info_data *data)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f260789a5831..071ec22b5e34 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -584,12 +584,11 @@ CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon)
  * FIXME: maybe we should consider checking that the reply matches request?
  */
 static void
-cifs_echo_callback(struct mid_q_entry *mid)
+cifs_echo_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
-	struct TCP_Server_Info *server = mid->callback_data;
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 
-	release_mid(mid);
+	release_mid(server, mid);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
@@ -1317,12 +1316,11 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 }
 
 static void
-cifs_readv_callback(struct mid_q_entry *mid)
+cifs_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
-	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 1,
 				 .rq_iter = rdata->subreq.io_iter };
@@ -1420,7 +1418,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
-	release_mid(mid);
+	release_mid(server, mid);
 	add_credits(server, &credits, 0);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
@@ -1736,10 +1734,9 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
  * workqueue completion task.
  */
 static void
-cifs_writev_callback(struct mid_q_entry *mid)
+cifs_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *wdata = mid->callback_data;
-	struct TCP_Server_Info *server = wdata->server;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	WRITE_RSP *smb = (WRITE_RSP *)mid->resp_buf;
 	struct cifs_credits credits = {
@@ -1803,7 +1800,7 @@ cifs_writev_callback(struct mid_q_entry *mid)
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
 	cifs_write_subrequest_terminated(wdata, result);
-	release_mid(mid);
+	release_mid(server, mid);
 	trace_smb3_rw_credits(credits.rreq_debug_id, credits.rreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_write_response_add);
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 08e5a5f0103e..87a246efe695 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -43,9 +43,9 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 		return NULL;
 	}
 
-	temp = mempool_alloc(cifs_mid_poolp, GFP_NOFS);
+	temp = mempool_alloc(&cifs_mid_pool, GFP_NOFS);
 	memset(temp, 0, sizeof(struct mid_q_entry));
-	kref_init(&temp->refcount);
+	refcount_set(&temp->refcount, 1);
 	spin_lock_init(&temp->mid_lock);
 	temp->mid = get_mid(smb_buffer);
 	temp->pid = current->pid;
@@ -54,7 +54,6 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 	/* easier to use jiffies */
 	/* when mid allocated can be before when sent */
 	temp->when_alloc = jiffies;
-	temp->server = server;
 
 	/*
 	 * The default is for the mid to be synchronous, so the
@@ -119,7 +118,7 @@ cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 
 	rc = cifs_sign_rqst(rqst, server, &mid->sequence_number);
 	if (rc) {
-		release_mid(mid);
+		release_mid(server, mid);
 		return ERR_PTR(rc);
 	}
 
@@ -179,11 +178,11 @@ cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 	}
 
 	/* BB special case reconnect tid and uid here? */
-	return map_and_check_smb_error(mid, log_error);
+	return map_and_check_smb_error(server, mid, log_error);
 }
 
 struct mid_q_entry *
-cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
+cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		   struct smb_rqst *rqst)
 {
 	int rc;
@@ -193,9 +192,9 @@ cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
 	rc = allocate_mid(ses, hdr, &mid);
 	if (rc)
 		return ERR_PTR(rc);
-	rc = cifs_sign_rqst(rqst, ses->server, &mid->sequence_number);
+	rc = cifs_sign_rqst(rqst, server, &mid->sequence_number);
 	if (rc) {
-		delete_mid(mid);
+		delete_mid(server, mid);
 		return ERR_PTR(rc);
 	}
 	return mid;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index d10fe1b11377..59f1affc4790 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -325,7 +325,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
 	spin_lock(&server->mid_queue_lock);
 	list_for_each_entry_safe(mid, nmid, &server->pending_mid_q, qhead) {
-		kref_get(&mid->refcount);
+		smb_get_mid(mid);
 		if (mid->mid_state == MID_REQUEST_SUBMITTED)
 			mid->mid_state = MID_RETRY_NEEDED;
 		list_move(&mid->qhead, &retry_list);
@@ -337,8 +337,8 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
 	list_for_each_entry_safe(mid, nmid, &retry_list, qhead) {
 		list_del_init(&mid->qhead);
-		mid_execute_callback(mid);
-		release_mid(mid);
+		mid_execute_callback(server, mid);
+		release_mid(server, mid);
 	}
 }
 
@@ -882,7 +882,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 			 */
 			spin_lock(&server->mid_queue_lock);
 			list_for_each_entry_safe(mid, nmid, &server->pending_mid_q, qhead) {
-				kref_get(&mid->refcount);
+				smb_get_mid(mid);
 				list_move(&mid->qhead, &dispose_list);
 				mid->deleted_from_q = true;
 			}
@@ -915,8 +915,8 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 				list_del_init(&mid->qhead);
 				mid->mid_rc = mid_rc;
 				mid->mid_state = MID_RC;
-				mid_execute_callback(mid);
-				release_mid(mid);
+				mid_execute_callback(server, mid);
+				release_mid(server, mid);
 			}
 
 			/*
@@ -948,12 +948,12 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 }
 
 void
-dequeue_mid(struct mid_q_entry *mid, bool malformed)
+dequeue_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid, bool malformed)
 {
 #ifdef CONFIG_CIFS_STATS2
 	mid->when_received = jiffies;
 #endif
-	spin_lock(&mid->server->mid_queue_lock);
+	spin_lock(&server->mid_queue_lock);
 	if (!malformed)
 		mid->mid_state = MID_RESPONSE_RECEIVED;
 	else
@@ -963,12 +963,12 @@ dequeue_mid(struct mid_q_entry *mid, bool malformed)
 	 * function has finished processing it is a bug.
 	 */
 	if (mid->deleted_from_q == true) {
-		spin_unlock(&mid->server->mid_queue_lock);
+		spin_unlock(&server->mid_queue_lock);
 		pr_warn_once("trying to dequeue a deleted mid\n");
 	} else {
 		list_del_init(&mid->qhead);
 		mid->deleted_from_q = true;
-		spin_unlock(&mid->server->mid_queue_lock);
+		spin_unlock(&server->mid_queue_lock);
 	}
 }
 
@@ -1004,7 +1004,7 @@ handle_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 		else
 			server->smallbuf = NULL;
 	}
-	dequeue_mid(mid, malformed);
+	dequeue_mid(server, mid, malformed);
 }
 
 int
@@ -1101,7 +1101,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 		list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
 			mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
 			cifs_dbg(FYI, "Clearing mid %llu\n", mid_entry->mid);
-			kref_get(&mid_entry->refcount);
+			smb_get_mid(mid_entry);
 			mid_entry->mid_state = MID_SHUTDOWN;
 			list_move(&mid_entry->qhead, &dispose_list);
 			mid_entry->deleted_from_q = true;
@@ -1113,8 +1113,8 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 			mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
 			cifs_dbg(FYI, "Callback mid %llu\n", mid_entry->mid);
 			list_del_init(&mid_entry->qhead);
-			mid_execute_callback(mid_entry);
-			release_mid(mid_entry);
+			mid_execute_callback(server, mid_entry);
+			release_mid(server, mid_entry);
 		}
 		/* 1/8th of sec is more than enough time for them to exit */
 		msleep(125);
@@ -1355,7 +1355,7 @@ cifs_demultiplex_thread(void *p)
 		if (length < 0) {
 			for (i = 0; i < num_mids; i++)
 				if (mids[i])
-					release_mid(mids[i]);
+					release_mid(server, mids[i]);
 			continue;
 		}
 
@@ -1388,9 +1388,9 @@ cifs_demultiplex_thread(void *p)
 				}
 
 				if (!mids[i]->multiRsp || mids[i]->multiEnd)
-					mid_execute_callback(mids[i]);
+					mid_execute_callback(server, mids[i]);
 
-				release_mid(mids[i]);
+				release_mid(server, mids[i]);
 			} else if (server->ops->is_oplock_break &&
 				   server->ops->is_oplock_break(bufs[i],
 								server)) {
diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
index 9ec20601cee2..ba8a92b430c1 100644
--- a/fs/smb/client/netmisc.c
+++ b/fs/smb/client/netmisc.c
@@ -889,7 +889,8 @@ map_smb_to_linux_error(char *buf, bool logErr)
 }
 
 int
-map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)
+map_and_check_smb_error(struct TCP_Server_Info *server,
+			struct mid_q_entry *mid, bool logErr)
 {
 	int rc;
 	struct smb_hdr *smb = (struct smb_hdr *)mid->resp_buf;
@@ -904,7 +905,7 @@ map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)
 		if (class == ERRSRV && code == ERRbaduid) {
 			cifs_dbg(FYI, "Server returned 0x%x, reconnecting session...\n",
 				code);
-			cifs_signal_cifsd_for_reconnect(mid->server, false);
+			cifs_signal_cifsd_for_reconnect(server, false);
 		}
 	}
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 45af69d95b27..53c77db552da 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -145,7 +145,7 @@ cifs_find_mid(struct TCP_Server_Info *server, char *buffer)
 		if (compare_mid(mid->mid, buf) &&
 		    mid->mid_state == MID_REQUEST_SUBMITTED &&
 		    le16_to_cpu(mid->command) == buf->Command) {
-			kref_get(&mid->refcount);
+			smb_get_mid(mid);
 			spin_unlock(&server->mid_queue_lock);
 			return mid;
 		}
@@ -447,7 +447,7 @@ cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 			return true;
 		/* All parts received or packet is malformed. */
 		mid->multiEnd = true;
-		dequeue_mid(mid, malformed);
+		dequeue_mid(server, mid, malformed);
 		return true;
 	}
 	if (!server->large_buf) {
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 3b8d3852009e..760edb98ed64 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -406,7 +406,7 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 		if ((mid->mid == wire_mid) &&
 		    (mid->mid_state == MID_REQUEST_SUBMITTED) &&
 		    (mid->command == shdr->Command)) {
-			kref_get(&mid->refcount);
+			smb_get_mid(mid);
 			if (dequeue) {
 				list_del_init(&mid->qhead);
 				mid->deleted_from_q = true;
@@ -4716,7 +4716,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		if (is_offloaded)
 			mid->mid_state = MID_RESPONSE_RECEIVED;
 		else
-			dequeue_mid(mid, false);
+			dequeue_mid(server, mid, false);
 		return 0;
 	}
 
@@ -4743,7 +4743,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		if (is_offloaded)
 			mid->mid_state = MID_RESPONSE_MALFORMED;
 		else
-			dequeue_mid(mid, rdata->result);
+			dequeue_mid(server, mid, rdata->result);
 		return 0;
 	}
 
@@ -4762,7 +4762,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(mid, rdata->result);
+				dequeue_mid(server, mid, rdata->result);
 			return 0;
 		}
 
@@ -4772,7 +4772,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(mid, rdata->result);
+				dequeue_mid(server, mid, rdata->result);
 			return 0;
 		}
 
@@ -4783,7 +4783,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(mid, rdata->result);
+				dequeue_mid(server, mid, rdata->result);
 			return 0;
 		}
 		rdata->got_bytes = buffer_len;
@@ -4802,14 +4802,14 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		if (is_offloaded)
 			mid->mid_state = MID_RESPONSE_MALFORMED;
 		else
-			dequeue_mid(mid, rdata->result);
+			dequeue_mid(server, mid, rdata->result);
 		return 0;
 	}
 
 	if (is_offloaded)
 		mid->mid_state = MID_RESPONSE_RECEIVED;
 	else
-		dequeue_mid(mid, false);
+		dequeue_mid(server, mid, false);
 	return 0;
 }
 
@@ -4856,7 +4856,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				dw->server->ops->is_network_name_deleted(dw->buf,
 									 dw->server);
 
-			mid_execute_callback(mid);
+			mid_execute_callback(dw->server, mid);
 		} else {
 			spin_lock(&dw->server->srv_lock);
 			if (dw->server->tcpStatus == CifsNeedReconnect) {
@@ -4864,7 +4864,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				mid->mid_state = MID_RETRY_NEEDED;
 				spin_unlock(&dw->server->mid_queue_lock);
 				spin_unlock(&dw->server->srv_lock);
-				mid_execute_callback(mid);
+				mid_execute_callback(dw->server, mid);
 			} else {
 				spin_lock(&dw->server->mid_queue_lock);
 				mid->mid_state = MID_REQUEST_SUBMITTED;
@@ -4875,7 +4875,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				spin_unlock(&dw->server->srv_lock);
 			}
 		}
-		release_mid(mid);
+		release_mid(dw->server, mid);
 	}
 
 free_pages:
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index ef2c6ac500f7..910703d8efb5 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4091,9 +4091,8 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
  * FIXME: maybe we should consider checking that the reply matches request?
  */
 static void
-smb2_echo_callback(struct mid_q_entry *mid)
+smb2_echo_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
-	struct TCP_Server_Info *server = mid->callback_data;
 	struct smb2_echo_rsp *rsp = (struct smb2_echo_rsp *)mid->resp_buf;
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
 
@@ -4103,7 +4102,7 @@ smb2_echo_callback(struct mid_q_entry *mid)
 		credits.instance = server->reconnect_instance;
 	}
 
-	release_mid(mid);
+	release_mid(server, mid);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
@@ -4518,14 +4517,12 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 }
 
 static void
-smb2_readv_callback(struct mid_q_entry *mid)
+smb2_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
-	struct TCP_Server_Info *server = rdata->server;
-	struct smb2_hdr *shdr =
-				(struct smb2_hdr *)rdata->iov[0].iov_base;
+	struct smb2_hdr *shdr = (struct smb2_hdr *)rdata->iov[0].iov_base;
 	struct cifs_credits credits = {
 		.value = 0,
 		.instance = 0,
@@ -4540,9 +4537,9 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		rqst.rq_iter	  = rdata->subreq.io_iter;
 	}
 
-	WARN_ONCE(rdata->server != mid->server,
+	WARN_ONCE(rdata->server != server,
 		  "rdata server %p != mid server %p",
-		  rdata->server, mid->server);
+		  rdata->server, server);
 
 	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu/%zu\n",
 		 __func__, mid->mid, mid->mid_state, rdata->result,
@@ -4643,7 +4640,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
-	release_mid(mid);
+	release_mid(server, mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_read_response_add);
@@ -4820,11 +4817,10 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
  * workqueue completion task.
  */
 static void
-smb2_writev_callback(struct mid_q_entry *mid)
+smb2_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *wdata = mid->callback_data;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
-	struct TCP_Server_Info *server = wdata->server;
 	struct smb2_write_rsp *rsp = (struct smb2_write_rsp *)mid->resp_buf;
 	struct cifs_credits credits = {
 		.value = 0,
@@ -4837,9 +4833,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
 	ssize_t result = 0;
 	size_t written;
 
-	WARN_ONCE(wdata->server != mid->server,
+	WARN_ONCE(wdata->server != server,
 		  "wdata server %p != mid server %p",
-		  wdata->server, mid->server);
+		  wdata->server, server);
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
@@ -4929,7 +4925,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
 	cifs_write_subrequest_terminated(wdata, result ?: written);
-	release_mid(mid);
+	release_mid(server, mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_write_response_add);
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 6a9b80385b86..d06f872c9ab2 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -653,16 +653,15 @@ smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
 		return NULL;
 	}
 
-	temp = mempool_alloc(cifs_mid_poolp, GFP_NOFS);
+	temp = mempool_alloc(&cifs_mid_pool, GFP_NOFS);
 	memset(temp, 0, sizeof(struct mid_q_entry));
-	kref_init(&temp->refcount);
+	refcount_set(&temp->refcount, 1);
 	spin_lock_init(&temp->mid_lock);
 	temp->mid = le64_to_cpu(shdr->MessageId);
 	temp->credits = credits > 0 ? credits : 1;
 	temp->pid = current->pid;
 	temp->command = shdr->Command; /* Always LE */
 	temp->when_alloc = jiffies;
-	temp->server = server;
 
 	/*
 	 * The default is for the mid to be synchronous, so the
@@ -779,7 +778,7 @@ smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	rc = smb2_sign_rqst(rqst, server);
 	if (rc) {
 		revert_current_mid_from_hdr(server, shdr);
-		delete_mid(mid);
+		delete_mid(server, mid);
 		return ERR_PTR(rc);
 	}
 
@@ -813,7 +812,7 @@ smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	rc = smb2_sign_rqst(rqst, server);
 	if (rc) {
 		revert_current_mid_from_hdr(server, shdr);
-		release_mid(mid);
+		release_mid(server, mid);
 		return ERR_PTR(rc);
 	}
 
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 6077eaf73df6..c26d1837d527 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -32,24 +32,21 @@
 #include "compress.h"
 
 void
-cifs_wake_up_task(struct mid_q_entry *mid)
+cifs_wake_up_task(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	if (mid->mid_state == MID_RESPONSE_RECEIVED)
 		mid->mid_state = MID_RESPONSE_READY;
 	wake_up_process(mid->callback_data);
 }
 
-void __release_mid(struct kref *refcount)
+void __release_mid(struct TCP_Server_Info *server, struct mid_q_entry *midEntry)
 {
-	struct mid_q_entry *midEntry =
-			container_of(refcount, struct mid_q_entry, refcount);
 #ifdef CONFIG_CIFS_STATS2
-	__le16 command = midEntry->server->vals->lock_cmd;
+	__le16 command = server->vals->lock_cmd;
 	__u16 smb_cmd = le16_to_cpu(midEntry->command);
 	unsigned long now;
 	unsigned long roundtrip_time;
 #endif
-	struct TCP_Server_Info *server = midEntry->server;
 
 	if (midEntry->resp_buf && (midEntry->wait_cancelled) &&
 	    (midEntry->mid_state == MID_RESPONSE_RECEIVED ||
@@ -116,20 +113,21 @@ void __release_mid(struct kref *refcount)
 #endif
 	put_task_struct(midEntry->creator);
 
-	mempool_free(midEntry, cifs_mid_poolp);
+	mempool_free(midEntry, &cifs_mid_pool);
 }
 
 void
-delete_mid(struct mid_q_entry *mid)
+delete_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
-	spin_lock(&mid->server->mid_queue_lock);
-	if (mid->deleted_from_q == false) {
+	spin_lock(&server->mid_queue_lock);
+
+	if (!mid->deleted_from_q) {
 		list_del_init(&mid->qhead);
 		mid->deleted_from_q = true;
 	}
-	spin_unlock(&mid->server->mid_queue_lock);
+	spin_unlock(&server->mid_queue_lock);
 
-	release_mid(mid);
+	release_mid(server, mid);
 }
 
 /*
@@ -727,7 +725,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	if (rc < 0) {
 		revert_current_mid(server, mid->credits);
 		server->sequence_number -= 2;
-		delete_mid(mid);
+		delete_mid(server, mid);
 	}
 
 	cifs_server_unlock(server);
@@ -777,14 +775,13 @@ int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server
 	spin_unlock(&server->mid_queue_lock);
 
 sync_mid_done:
-	release_mid(mid);
+	release_mid(server, mid);
 	return rc;
 }
 
 static void
-cifs_compound_callback(struct mid_q_entry *mid)
+cifs_compound_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
-	struct TCP_Server_Info *server = mid->server;
 	struct cifs_credits credits = {
 		.value = server->ops->get_credits(mid),
 		.instance = server->reconnect_instance,
@@ -797,17 +794,17 @@ cifs_compound_callback(struct mid_q_entry *mid)
 }
 
 static void
-cifs_compound_last_callback(struct mid_q_entry *mid)
+cifs_compound_last_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
-	cifs_compound_callback(mid);
-	cifs_wake_up_task(mid);
+	cifs_compound_callback(server, mid);
+	cifs_wake_up_task(server, mid);
 }
 
 static void
-cifs_cancelled_callback(struct mid_q_entry *mid)
+cifs_cancelled_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
-	cifs_compound_callback(mid);
-	release_mid(mid);
+	cifs_compound_callback(server, mid);
+	release_mid(server, mid);
 }
 
 /*
@@ -941,7 +938,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		if (IS_ERR(mid[i])) {
 			revert_current_mid(server, i);
 			for (j = 0; j < i; j++)
-				delete_mid(mid[j]);
+				delete_mid(server, mid[j]);
 			cifs_server_unlock(server);
 
 			/* Update # of requests on wire to server */
@@ -1096,7 +1093,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	 */
 	for (i = 0; i < num_rqst; i++) {
 		if (!cancelled_mid[i])
-			delete_mid(mid[i]);
+			delete_mid(server, mid[i]);
 	}
 
 	return rc;
@@ -1145,7 +1142,7 @@ __cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	int length;
 
 	length = cifs_discard_remaining_data(server);
-	dequeue_mid(mid, malformed);
+	dequeue_mid(server, mid, malformed);
 	mid->resp_buf = server->smallbuf;
 	server->smallbuf = NULL;
 	return length;
@@ -1282,7 +1279,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	if (server->total_read < buflen)
 		return cifs_readv_discard(server, mid);
 
-	dequeue_mid(mid, false);
+	dequeue_mid(server, mid, false);
 	mid->resp_buf = server->smallbuf;
 	server->smallbuf = NULL;
 	return length;


