Return-Path: <linux-fsdevel+bounces-68517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2194C5DBC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 16:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F8394F3FFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FB9329361;
	Fri, 14 Nov 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3oC6gp5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB0325727
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131418; cv=none; b=TSbUz205vp7gogiYZLiqWrPIrhI8uL1mpiwnqTW4VtERphyIdAr4Yh50jh81Ix6NmcL68l8Tx7pYkw4KhDkQkdr1zUNKLwQE2pOLR5TQqg2dJeKw2qOZyn60Lu5QPUCr5PNdGeteCVSH0Ph4EJnZoJlGI7+XN+/u+m4pA27tErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131418; c=relaxed/simple;
	bh=39d/njZ1MyY7SHJEJuY4nsl9lb4BGajxBRj2qoIn+g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJAyTuch6Ry7BUKL7sCJs0O2CmtcnGWI6vas/E5E3U2XLPhG3I11snf/pur7Y4A3QQE2etDnbKdIseYcgVS2Bd1bHAREDNeFtdZPuOrZlezpPCjn81nkNWRUXYZQfn0sFW2QyeqnXUpwpTghTPn4KCmoENl+oIytYiQGCDGM3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3oC6gp5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763131414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf+ivAcPe6bXMhL+4C2vDGkZ/zL/IZ2jfSalhqc65V4=;
	b=e3oC6gp5IP0bcZcXSstJl9s+8ZCwnvYvSSAzcSuHR6FNkqvAbI1X7Flctl+eYXF/+roWAj
	zYtAkfjcAoVDdT/w5lQpKIQlfQpIlg7q4ZCzWEo0RwiRD+oZgMNRlOJj5PZCiSA8q/o81P
	rRJV2ef1/zDS1B5h5e8yI8LQD36z5Zc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-V9-0iRyoMVKNCSnIP8LPzg-1; Fri,
 14 Nov 2025 09:43:30 -0500
X-MC-Unique: V9-0iRyoMVKNCSnIP8LPzg-1
X-Mimecast-MFC-AGG-ID: V9-0iRyoMVKNCSnIP8LPzg_1763131409
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE3A61800452;
	Fri, 14 Nov 2025 14:43:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.87])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43B431955F1B;
	Fri, 14 Nov 2025 14:43:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 7/9] cifs: Remove the server pointer from smb_message
Date: Fri, 14 Nov 2025 14:42:49 +0000
Message-ID: <20251114144253.1853312-8-dhowells@redhat.com>
In-Reply-To: <20251114144253.1853312-1-dhowells@redhat.com>
References: <20251114144253.1853312-1-dhowells@redhat.com>
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
 fs/smb/client/cifsglob.h      | 10 ++++----
 fs/smb/client/cifsproto.h     | 21 +++++++++++------
 fs/smb/client/cifssmb.c       | 15 +++++-------
 fs/smb/client/cifstransport.c | 13 +++++------
 fs/smb/client/connect.c       | 34 +++++++++++++--------------
 fs/smb/client/netmisc.c       |  5 ++--
 fs/smb/client/smb1ops.c       |  4 ++--
 fs/smb/client/smb2ops.c       | 22 +++++++++---------
 fs/smb/client/smb2pdu.c       | 23 ++++++++----------
 fs/smb/client/smb2transport.c |  7 +++---
 fs/smb/client/transport.c     | 44 ++++++++++++++++-------------------
 11 files changed, 97 insertions(+), 101 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7146225f4608..6d80df815da4 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1696,7 +1696,7 @@ typedef int (*mid_receive_t)(struct TCP_Server_Info *server,
  * - it will be called by cifsd, with no locks held
  * - the mid will be removed from any lists
  */
-typedef void (*mid_callback_t)(struct smb_message *smb);
+typedef void (*mid_callback_t)(struct TCP_Server_Info *srv, struct smb_message *smb);
 
 /*
  * This is the protopyte for mid handle function. This is called once the mid
@@ -1708,8 +1708,7 @@ typedef int (*mid_handle_t)(struct TCP_Server_Info *server,
 /* one of these for every pending CIFS request to the server */
 struct smb_message {
 	struct list_head qhead;	/* mids waiting on reply from this server */
-	struct kref refcount;
-	struct TCP_Server_Info *server;	/* server corresponding to this mid */
+	refcount_t refcount;
 	__u64 mid;		/* multiplex id */
 	__u16 credits;		/* number of credits consumed by this mid */
 	__u16 credits_received;	/* number of credits from the response */
@@ -2381,7 +2380,8 @@ static inline bool cifs_netbios_name(const char *name, size_t namelen)
  * Execute mid callback atomically - ensures callback runs exactly once
  * and prevents sleeping in atomic context.
  */
-static inline void mid_execute_callback(struct smb_message *smb)
+static inline void mid_execute_callback(struct TCP_Server_Info *server,
+					struct smb_message *smb)
 {
 	mid_callback_t callback;
 
@@ -2391,7 +2391,7 @@ static inline void mid_execute_callback(struct smb_message *smb)
 	spin_unlock(&smb->mid_lock);
 
 	if (callback)
-		callback(smb);
+		callback(server, smb);
 }
 
 #define CIFS_REPARSE_SUPPORT(tcon) \
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 451b847d8a53..33a216f5ed4d 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -82,9 +82,9 @@ extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
 				     int add_treename);
 extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
 char *cifs_build_devname(char *nodename, const char *prepath);
-extern void delete_mid(struct smb_message *smb);
-void __release_mid(struct kref *refcount);
-extern void cifs_wake_up_task(struct smb_message *smb);
+extern void delete_mid(struct TCP_Server_Info *server, struct smb_message *smb);
+void __release_mid(struct TCP_Server_Info *server, struct smb_message *smb);
+extern void cifs_wake_up_task(struct TCP_Server_Info *server, struct smb_message *smb);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct smb_message *smb);
 extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
@@ -181,7 +181,8 @@ extern int decode_negTokenInit(unsigned char *security_blob, int length,
 extern int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
 extern void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
 extern int map_smb_to_linux_error(char *buf, bool logErr);
-extern int map_and_check_smb_error(struct smb_message *smb, bool logErr);
+extern int map_and_check_smb_error(struct TCP_Server_Info *server,
+				   struct smb_message *smb, bool logErr);
 unsigned int header_assemble(struct smb_hdr *, char /* command */ ,
 			     const struct cifs_tcon *,
 			     int /* length of fixed section (word count) in two byte units */);
@@ -264,7 +265,7 @@ extern unsigned int setup_special_mode_ACE(struct smb_ace *pace,
 					   __u64 nmode);
 extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
 
-extern void dequeue_mid(struct smb_message *smb, bool malformed);
+void dequeue_mid(struct TCP_Server_Info *server, struct smb_message *smb, bool malformed);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 			         unsigned int to_read);
 extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
@@ -768,9 +769,15 @@ static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
 	return true;
 }
 
-static inline void release_mid(struct smb_message *smb)
+static inline void smb_get_mid(struct smb_message *smb)
 {
-	kref_put(&smb->refcount, __release_mid);
+	refcount_inc(&smb->refcount);
+}
+
+static inline void release_mid(struct TCP_Server_Info *server, struct smb_message *smb)
+{
+	if (refcount_dec_and_test(&smb->refcount))
+		__release_mid(server, smb);
 }
 
 static inline void cifs_free_open_info(struct cifs_open_info_data *data)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 8966bc512e96..cf70dddb486a 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -584,12 +584,11 @@ CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon)
  * FIXME: maybe we should consider checking that the reply matches request?
  */
 static void
-cifs_echo_callback(struct smb_message *smb)
+cifs_echo_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct TCP_Server_Info *server = smb->callback_data;
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 
-	release_mid(smb);
+	release_mid(server, smb);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
@@ -1317,12 +1316,11 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 }
 
 static void
-cifs_readv_callback(struct smb_message *smb)
+cifs_readv_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	struct cifs_io_subrequest *rdata = smb->callback_data;
 	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
-	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 1,
 				 .rq_iter = rdata->subreq.io_iter };
@@ -1420,7 +1418,7 @@ cifs_readv_callback(struct smb_message *smb)
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
-	release_mid(smb);
+	release_mid(server, smb);
 	add_credits(server, &credits, 0);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
@@ -1736,10 +1734,9 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
  * workqueue completion task.
  */
 static void
-cifs_writev_callback(struct smb_message *smb)
+cifs_writev_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	struct cifs_io_subrequest *wdata = smb->callback_data;
-	struct TCP_Server_Info *server = wdata->server;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	WRITE_RSP *rsp = (WRITE_RSP *)smb->resp_buf;
 	struct cifs_credits credits = {
@@ -1803,7 +1800,7 @@ cifs_writev_callback(struct smb_message *smb)
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
 	cifs_write_subrequest_terminated(wdata, result);
-	release_mid(smb);
+	release_mid(server, smb);
 	trace_smb3_rw_credits(credits.rreq_debug_id, credits.rreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_write_response_add);
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 7ea737fc5127..6b7d4bac8b83 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -45,7 +45,7 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 
 	smb = mempool_alloc(&smb_message_pool, GFP_NOFS);
 	memset(smb, 0, sizeof(struct smb_message));
-	kref_init(&smb->refcount);
+	refcount_set(&smb->refcount, 1);
 	spin_lock_init(&smb->mid_lock);
 	smb->mid = get_mid(smb_buffer);
 	smb->pid = current->pid;
@@ -54,7 +54,6 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 	/* easier to use jiffies */
 	/* when mid allocated can be before when sent */
 	smb->when_alloc = jiffies;
-	smb->server = server;
 
 	/*
 	 * The default is for the mid to be synchronous, so the
@@ -119,7 +118,7 @@ cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 
 	rc = cifs_sign_rqst(rqst, server, &smb->sequence_number);
 	if (rc) {
-		release_mid(smb);
+		release_mid(server, smb);
 		return ERR_PTR(rc);
 	}
 
@@ -179,11 +178,11 @@ cifs_check_receive(struct smb_message *smb, struct TCP_Server_Info *server,
 	}
 
 	/* BB special case reconnect tid and uid here? */
-	return map_and_check_smb_error(smb, log_error);
+	return map_and_check_smb_error(server, smb, log_error);
 }
 
 struct smb_message *
-cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
+cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		   struct smb_rqst *rqst)
 {
 	int rc;
@@ -193,9 +192,9 @@ cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
 	rc = allocate_mid(ses, hdr, &smb);
 	if (rc)
 		return ERR_PTR(rc);
-	rc = cifs_sign_rqst(rqst, ses->server, &smb->sequence_number);
+	rc = cifs_sign_rqst(rqst, server, &smb->sequence_number);
 	if (rc) {
-		delete_mid(smb);
+		delete_mid(server, smb);
 		return ERR_PTR(rc);
 	}
 	return smb;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 476b96d715b1..abb8bafc95c8 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -325,7 +325,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
 	spin_lock(&server->mid_queue_lock);
 	list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
-		kref_get(&smb->refcount);
+		smb_get_mid(smb);
 		if (smb->mid_state == MID_REQUEST_SUBMITTED)
 			smb->mid_state = MID_RETRY_NEEDED;
 		list_move(&smb->qhead, &retry_list);
@@ -337,8 +337,8 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
 	list_for_each_entry_safe(smb, nsmb, &retry_list, qhead) {
 		list_del_init(&smb->qhead);
-		mid_execute_callback(smb);
-		release_mid(smb);
+		mid_execute_callback(server, smb);
+		release_mid(server, smb);
 	}
 }
 
@@ -882,7 +882,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 			 */
 			spin_lock(&server->mid_queue_lock);
 			list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
-				kref_get(&smb->refcount);
+				smb_get_mid(smb);
 				list_move(&smb->qhead, &dispose_list);
 				smb->deleted_from_q = true;
 			}
@@ -915,8 +915,8 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 				list_del_init(&smb->qhead);
 				smb->mid_rc = mid_rc;
 				smb->mid_state = MID_RC;
-				mid_execute_callback(smb);
-				release_mid(smb);
+				mid_execute_callback(server, smb);
+				release_mid(server, smb);
 			}
 
 			/*
@@ -948,12 +948,12 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 }
 
 void
-dequeue_mid(struct smb_message *smb, bool malformed)
+dequeue_mid(struct TCP_Server_Info *server, struct smb_message *smb, bool malformed)
 {
 #ifdef CONFIG_CIFS_STATS2
 	smb->when_received = jiffies;
 #endif
-	spin_lock(&smb->server->mid_queue_lock);
+	spin_lock(&server->mid_queue_lock);
 	if (!malformed)
 		smb->mid_state = MID_RESPONSE_RECEIVED;
 	else
@@ -963,12 +963,12 @@ dequeue_mid(struct smb_message *smb, bool malformed)
 	 * function has finished processing it is a bug.
 	 */
 	if (smb->deleted_from_q) {
-		spin_unlock(&smb->server->mid_queue_lock);
+		spin_unlock(&server->mid_queue_lock);
 		pr_warn_once("trying to dequeue a deleted mid\n");
 	} else {
 		list_del_init(&smb->qhead);
 		smb->deleted_from_q = true;
-		spin_unlock(&smb->server->mid_queue_lock);
+		spin_unlock(&server->mid_queue_lock);
 	}
 }
 
@@ -1004,7 +1004,7 @@ handle_mid(struct smb_message *smb, struct TCP_Server_Info *server,
 		else
 			server->smallbuf = NULL;
 	}
-	dequeue_mid(smb, malformed);
+	dequeue_mid(server, smb, malformed);
 }
 
 int
@@ -1101,7 +1101,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 		list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
 			smb = list_entry(tmp, struct smb_message, qhead);
 			cifs_dbg(FYI, "Clearing mid %llu\n", smb->mid);
-			kref_get(&smb->refcount);
+			smb_get_mid(smb);
 			smb->mid_state = MID_SHUTDOWN;
 			list_move(&smb->qhead, &dispose_list);
 			smb->deleted_from_q = true;
@@ -1113,8 +1113,8 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 			smb = list_entry(tmp, struct smb_message, qhead);
 			cifs_dbg(FYI, "Callback mid %llu\n", smb->mid);
 			list_del_init(&smb->qhead);
-			mid_execute_callback(smb);
-			release_mid(smb);
+			mid_execute_callback(server, smb);
+			release_mid(server, smb);
 		}
 		/* 1/8th of sec is more than enough time for them to exit */
 		msleep(125);
@@ -1355,7 +1355,7 @@ cifs_demultiplex_thread(void *p)
 		if (length < 0) {
 			for (i = 0; i < num_smbs; i++)
 				if (smbs[i])
-					release_mid(smbs[i]);
+					release_mid(server, smbs[i]);
 			continue;
 		}
 
@@ -1388,9 +1388,9 @@ cifs_demultiplex_thread(void *p)
 				}
 
 				if (!smbs[i]->multiRsp || smbs[i]->multiEnd)
-					mid_execute_callback(smbs[i]);
+					mid_execute_callback(server, smbs[i]);
 
-				release_mid(smbs[i]);
+				release_mid(server, smbs[i]);
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
index 44c7d4d17b56..ce1996d378d7 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -144,7 +144,7 @@ cifs_find_mid(struct TCP_Server_Info *server, char *buffer)
 		if (compare_mid(smb->mid, buf) &&
 		    smb->mid_state == MID_REQUEST_SUBMITTED &&
 		    le16_to_cpu(smb->command) == buf->Command) {
-			kref_get(&smb->refcount);
+			smb_get_mid(smb);
 			spin_unlock(&server->mid_queue_lock);
 			return smb;
 		}
@@ -446,7 +446,7 @@ cifs_check_trans2(struct smb_message *smb, struct TCP_Server_Info *server,
 			return true;
 		/* All parts received or packet is malformed. */
 		smb->multiEnd = true;
-		dequeue_mid(smb, malformed);
+		dequeue_mid(server, smb, malformed);
 		return true;
 	}
 	if (!server->large_buf) {
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 535f15749880..acd2d9688fb9 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -406,7 +406,7 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 		if ((smb->mid == wire_mid) &&
 		    (smb->mid_state == MID_REQUEST_SUBMITTED) &&
 		    (smb->command == shdr->Command)) {
-			kref_get(&smb->refcount);
+			smb_get_mid(smb);
 			if (dequeue) {
 				list_del_init(&smb->qhead);
 				smb->deleted_from_q = true;
@@ -4769,7 +4769,7 @@ handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 		if (is_offloaded)
 			smb->mid_state = MID_RESPONSE_RECEIVED;
 		else
-			dequeue_mid(smb, false);
+			dequeue_mid(server, smb, false);
 		return 0;
 	}
 
@@ -4796,7 +4796,7 @@ handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 		if (is_offloaded)
 			smb->mid_state = MID_RESPONSE_MALFORMED;
 		else
-			dequeue_mid(smb, rdata->result);
+			dequeue_mid(server, smb, rdata->result);
 		return 0;
 	}
 
@@ -4815,7 +4815,7 @@ handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 			if (is_offloaded)
 				smb->mid_state = MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(smb, rdata->result);
+				dequeue_mid(server, smb, rdata->result);
 			return 0;
 		}
 
@@ -4825,7 +4825,7 @@ handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 			if (is_offloaded)
 				smb->mid_state = MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(smb, rdata->result);
+				dequeue_mid(server, smb, rdata->result);
 			return 0;
 		}
 
@@ -4836,7 +4836,7 @@ handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 			if (is_offloaded)
 				smb->mid_state = MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(smb, rdata->result);
+				dequeue_mid(server, smb, rdata->result);
 			return 0;
 		}
 		rdata->got_bytes = buffer_len;
@@ -4855,14 +4855,14 @@ handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 		if (is_offloaded)
 			smb->mid_state = MID_RESPONSE_MALFORMED;
 		else
-			dequeue_mid(smb, rdata->result);
+			dequeue_mid(server, smb, rdata->result);
 		return 0;
 	}
 
 	if (is_offloaded)
 		smb->mid_state = MID_RESPONSE_RECEIVED;
 	else
-		dequeue_mid(smb, false);
+		dequeue_mid(server, smb, false);
 	return 0;
 }
 
@@ -4909,7 +4909,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				dw->server->ops->is_network_name_deleted(dw->buf,
 									 dw->server);
 
-			mid_execute_callback(smb);
+			mid_execute_callback(dw->server, smb);
 		} else {
 			spin_lock(&dw->server->srv_lock);
 			if (dw->server->tcpStatus == CifsNeedReconnect) {
@@ -4917,7 +4917,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				smb->mid_state = MID_RETRY_NEEDED;
 				spin_unlock(&dw->server->mid_queue_lock);
 				spin_unlock(&dw->server->srv_lock);
-				mid_execute_callback(smb);
+				mid_execute_callback(dw->server, smb);
 			} else {
 				spin_lock(&dw->server->mid_queue_lock);
 				smb->mid_state = MID_REQUEST_SUBMITTED;
@@ -4928,7 +4928,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				spin_unlock(&dw->server->srv_lock);
 			}
 		}
-		release_mid(smb);
+		release_mid(dw->server, smb);
 	}
 
 free_pages:
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 7a0aafff59ef..bfcfc3bcffa0 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4092,9 +4092,8 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
  * FIXME: maybe we should consider checking that the reply matches request?
  */
 static void
-smb2_echo_callback(struct smb_message *smb)
+smb2_echo_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct TCP_Server_Info *server = smb->callback_data;
 	struct smb2_echo_rsp *rsp = (struct smb2_echo_rsp *)smb->resp_buf;
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
 
@@ -4104,7 +4103,7 @@ smb2_echo_callback(struct smb_message *smb)
 		credits.instance = server->reconnect_instance;
 	}
 
-	release_mid(smb);
+	release_mid(server, smb);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
@@ -4519,12 +4518,11 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 }
 
 static void
-smb2_readv_callback(struct smb_message *smb)
+smb2_readv_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	struct cifs_io_subrequest *rdata = smb->callback_data;
 	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
-	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)rdata->iov[0].iov_base;
 	struct cifs_credits credits = {
 		.value = 0,
@@ -4540,9 +4538,9 @@ smb2_readv_callback(struct smb_message *smb)
 		rqst.rq_iter	  = rdata->subreq.io_iter;
 	}
 
-	WARN_ONCE(rdata->server != smb->server,
+	WARN_ONCE(rdata->server != server,
 		  "rdata server %p != mid server %p",
-		  rdata->server, smb->server);
+		  rdata->server, server);
 
 	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu/%zu\n",
 		 __func__, smb->mid, smb->mid_state, rdata->result,
@@ -4643,7 +4641,7 @@ smb2_readv_callback(struct smb_message *smb)
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
-	release_mid(smb);
+	release_mid(server, smb);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_read_response_add);
@@ -4820,11 +4818,10 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
  * workqueue completion task.
  */
 static void
-smb2_writev_callback(struct smb_message *smb)
+smb2_writev_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	struct cifs_io_subrequest *wdata = smb->callback_data;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
-	struct TCP_Server_Info *server = wdata->server;
 	struct smb2_write_rsp *rsp = (struct smb2_write_rsp *)smb->resp_buf;
 	struct cifs_credits credits = {
 		.value = 0,
@@ -4837,9 +4834,9 @@ smb2_writev_callback(struct smb_message *smb)
 	ssize_t result = 0;
 	size_t written;
 
-	WARN_ONCE(wdata->server != smb->server,
+	WARN_ONCE(wdata->server != server,
 		  "wdata server %p != mid server %p",
-		  wdata->server, smb->server);
+		  wdata->server, server);
 
 	switch (smb->mid_state) {
 	case MID_RESPONSE_RECEIVED:
@@ -4929,7 +4926,7 @@ smb2_writev_callback(struct smb_message *smb)
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
 	cifs_write_subrequest_terminated(wdata, result ?: written);
-	release_mid(smb);
+	release_mid(server, smb);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_write_response_add);
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 21b027040643..6d76b0c6d73d 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -655,14 +655,13 @@ smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
 
 	smb = mempool_alloc(&smb_message_pool, GFP_NOFS);
 	memset(smb, 0, sizeof(*smb));
-	kref_init(&smb->refcount);
+	refcount_set(&smb->refcount, 1);
 	spin_lock_init(&smb->mid_lock);
 	smb->mid = le64_to_cpu(shdr->MessageId);
 	smb->credits = credits > 0 ? credits : 1;
 	smb->pid = current->pid;
 	smb->command = shdr->Command; /* Always LE */
 	smb->when_alloc = jiffies;
-	smb->server = server;
 
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
-		release_mid(smb);
+		release_mid(server, smb);
 		return ERR_PTR(rc);
 	}
 
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index d347febc821a..362c5c6c91a4 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -32,24 +32,21 @@
 #include "compress.h"
 
 void
-cifs_wake_up_task(struct smb_message *smb)
+cifs_wake_up_task(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	if (smb->mid_state == MID_RESPONSE_RECEIVED)
 		smb->mid_state = MID_RESPONSE_READY;
 	wake_up_process(smb->callback_data);
 }
 
-void __release_mid(struct kref *refcount)
+void __release_mid(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct smb_message *smb =
-			container_of(refcount, struct smb_message, refcount);
 #ifdef CONFIG_CIFS_STATS2
-	__le16 command = smb->server->vals->lock_cmd;
+	__le16 command = server->vals->lock_cmd;
 	__u16 smb_cmd = le16_to_cpu(smb->command);
 	unsigned long now;
 	unsigned long roundtrip_time;
 #endif
-	struct TCP_Server_Info *server = smb->server;
 
 	if (smb->resp_buf && smb->wait_cancelled &&
 	    (smb->mid_state == MID_RESPONSE_RECEIVED ||
@@ -120,17 +117,17 @@ void __release_mid(struct kref *refcount)
 }
 
 void
-delete_mid(struct smb_message *smb)
+delete_mid(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	spin_lock(&smb->server->mid_queue_lock);
+	spin_lock(&server->mid_queue_lock);
 
 	if (!smb->deleted_from_q) {
 		list_del_init(&smb->qhead);
 		smb->deleted_from_q = true;
 	}
-	spin_unlock(&smb->server->mid_queue_lock);
+	spin_unlock(&server->mid_queue_lock);
 
-	release_mid(smb);
+	release_mid(server, smb);
 }
 
 /*
@@ -728,7 +725,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	if (rc < 0) {
 		revert_current_mid(server, smb->credits);
 		server->sequence_number -= 2;
-		delete_mid(smb);
+		delete_mid(server, smb);
 	}
 
 	cifs_server_unlock(server);
@@ -778,14 +775,13 @@ int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info *server
 	spin_unlock(&server->mid_queue_lock);
 
 sync_mid_done:
-	release_mid(smb);
+	release_mid(server, smb);
 	return rc;
 }
 
 static void
-cifs_compound_callback(struct smb_message *smb)
+cifs_compound_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct TCP_Server_Info *server = smb->server;
 	struct cifs_credits credits = {
 		.value = server->ops->get_credits(smb),
 		.instance = server->reconnect_instance,
@@ -798,17 +794,17 @@ cifs_compound_callback(struct smb_message *smb)
 }
 
 static void
-cifs_compound_last_callback(struct smb_message *smb)
+cifs_compound_last_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	cifs_compound_callback(smb);
-	cifs_wake_up_task(smb);
+	cifs_compound_callback(server, smb);
+	cifs_wake_up_task(server, smb);
 }
 
 static void
-cifs_cancelled_callback(struct smb_message *smb)
+cifs_cancelled_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	cifs_compound_callback(smb);
-	release_mid(smb);
+	cifs_compound_callback(server, smb);
+	release_mid(server, smb);
 }
 
 /*
@@ -942,7 +938,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		if (IS_ERR(smb[i])) {
 			revert_current_mid(server, i);
 			for (j = 0; j < i; j++)
-				delete_mid(smb[j]);
+				delete_mid(server, smb[j]);
 			cifs_server_unlock(server);
 
 			/* Update # of requests on wire to server */
@@ -1094,7 +1090,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	 */
 	for (i = 0; i < num_rqst; i++) {
 		if (!cancelled_mid[i])
-			delete_mid(smb[i]);
+			delete_mid(server, smb[i]);
 	}
 
 	return rc;
@@ -1143,7 +1139,7 @@ __cifs_readv_discard(struct TCP_Server_Info *server, struct smb_message *smb,
 	int length;
 
 	length = cifs_discard_remaining_data(server);
-	dequeue_mid(smb, malformed);
+	dequeue_mid(server, smb, malformed);
 	smb->resp_buf = server->smallbuf;
 	server->smallbuf = NULL;
 	return length;
@@ -1280,7 +1276,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message *smb)
 	if (server->total_read < buflen)
 		return cifs_readv_discard(server, smb);
 
-	dequeue_mid(smb, false);
+	dequeue_mid(server, smb, false);
 	smb->resp_buf = server->smallbuf;
 	server->smallbuf = NULL;
 	return length;


