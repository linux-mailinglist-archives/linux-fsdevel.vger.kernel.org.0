Return-Path: <linux-fsdevel+bounces-56899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DDB1CDBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A4B16BAA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF82D1905;
	Wed,  6 Aug 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1OuXtZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8ED2C3749
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512736; cv=none; b=rdWPWMYMAO48+npwl8TbmLCZWONYMmOtZw3a6WXYQTcpmeJEffyKFI99nG74IJNRDST89GCFBqaQOVN0zMrMS46xGIoy9NC9Vg3XIf6Vcx5KC8VGaFsDPPjIollI0U97Og79AZmlP/Yp1CnENZRI4SfRMHRgRCsNeNoPN4dHF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512736; c=relaxed/simple;
	bh=OKHhptfB5jwBXD5+u7zjUFMyyR/hvX8j2hEbb+AAvg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjO7zyKTVoxI0GIrjtpN7jxGZCbCdUOa6exbkSTGvgFNQxz2ao4UkI8K5mEyv5Y5OssE0D7VnjaLxBDMK3SRyL7xhaFLnE5K4q3n49d76bHvluyD1cR/MslyKy6f1KMtzVoeBO3HPXc9EkHDULZN6m8/CDauMR2Ysf0KMGs0IZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1OuXtZ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/433jhOde1F9jr30af40wOYw9SgoaERWUX8VrFSUDNQ=;
	b=R1OuXtZ88i2QCsJzaAbU9eABDSx5BAwoeld2Kr5jhazEakIsdLiK61FJ1DZBVFr6WcrhV5
	+o+SaFrphfYjIOMCWp352KhPu9P8QorSnI6HKDer0uloS8R9mFdKi3Kw5q1Wg7ZiTzT5CV
	GGr5vzExYrAkACY1dcvgpBANGHDV4fo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-b59P-9Y-O_uOT4o7D0Qcog-1; Wed,
 06 Aug 2025 16:38:49 -0400
X-MC-Unique: b59P-9Y-O_uOT4o7D0Qcog-1
X-Mimecast-MFC-AGG-ID: b59P-9Y-O_uOT4o7D0Qcog_1754512727
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97CA61800446;
	Wed,  6 Aug 2025 20:38:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 871AB1800280;
	Wed,  6 Aug 2025 20:38:44 +0000 (UTC)
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
Subject: [RFC PATCH 19/31] cifs: Clean up mid->callback_data and kill off mid->creator
Date: Wed,  6 Aug 2025 21:36:40 +0100
Message-ID: <20250806203705.2560493-20-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

We shouldn't really be pinning a task_struct on the mid_q_struct.  Better
to provide a wait queue there and have the waiter wait on it.  For
synchronous operations, this allows them to remove themselves from it once
this is absorbed into smb_message and smb_message is generated higher up
the stack.  This also gets rid of one of the uses of mid->callback_data.

We can also get rid of the need for callback_data for the Echo command
callback by passing a server pointer down into ->callback() from the
callers (all of which have it available).  This can also be used in the
Read and Write callbacks.

We then only need the callback_data for the Read and Write commands - and
in both cases, it points to a cifs_io_subrequest struct.  So replace
callback_data with a specifically typed pointer in a union that other users
can be added to as the need arises.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifs_debug.c    |  3 +--
 fs/smb/client/cifsglob.h      | 11 ++++++++---
 fs/smb/client/cifsproto.h     |  2 +-
 fs/smb/client/cifstransport.c |  1 -
 fs/smb/client/connect.c       |  8 ++++----
 fs/smb/client/smb2ops.c       |  6 +++---
 fs/smb/client/smb2pdu.c       | 18 +++++++-----------
 fs/smb/client/smb2transport.c |  6 ------
 fs/smb/client/transport.c     | 27 +++++++++++++--------------
 9 files changed, 37 insertions(+), 45 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index cba30f339d6b..13c569ab3417 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -625,11 +625,10 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 					   chan_server->conn_id);
 				spin_lock(&chan_server->mid_lock);
 				list_for_each_entry(smb, &chan_server->pending_mid_q, qhead) {
-					seq_printf(m, "\n\t\tState: %d com: %d pid: %d cbdata: %p mid %llu",
+					seq_printf(m, "\n\t\tState: %d com: %d pid: %d mid %llu",
 						   smb->mid_state,
 						   smb->command_id,
 						   smb->pid,
-						   smb->callback_data,
 						   smb->mid);
 				}
 				spin_unlock(&chan_server->mid_lock);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 4173b87bdf0f..14b132fb14e0 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1692,7 +1692,8 @@ typedef int (*mid_receive_t)(struct TCP_Server_Info *server,
  * - it will be called by cifsd, with no locks held
  * - the mid will be removed from any lists
  */
-typedef void (*mid_callback_t)(struct smb_message *smb);
+typedef void (*mid_callback_t)(struct TCP_Server_Info *server,
+			       struct smb_message *smb);
 
 /*
  * This is the protopyte for mid handle function. This is called once the mid
@@ -1731,11 +1732,17 @@ struct smb_message {
 	struct smb_message	*next;		/* Next message in compound */
 	struct cifs_credits	credits;	/* Credit requirements for this message */
 	void			*request;	/* Pointer to request message body */
+	wait_queue_head_t	waitq;		/* Wait queue for message events */
 	refcount_t		ref;
 	bool			sensitive;	/* Request contains sensitive data */
 	bool			cancelled;	/* T if cancelled */
 	unsigned int		sr_flags;	/* Flags passed to send_recv() */
 
+	/* PDU-type specific data */
+	union {
+		struct cifs_io_subrequest *subreq; /* Read/write subrequest */
+	};
+
 	/* Queue state */
 	struct list_head	qhead;		/* mids waiting on reply from this server */
 	struct TCP_Server_Info	*server;	/* server corresponding to this mid */
@@ -1752,8 +1759,6 @@ struct smb_message {
 	mid_receive_t		receive;	/* call receive callback */
 	mid_callback_t		callback;	/* call completion callback */
 	mid_handle_t		handle;		/* call handle mid callback */
-	void			*callback_data;	/* general purpose pointer for callback */
-	struct task_struct	*creator;
 	void			*resp_buf;	/* pointer to received SMB header */
 	unsigned int		resp_buf_size;
 	int			mid_state;	/* wish this were enum but can not pass to wait_event */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index fd5fe2723b4a..abae67d83499 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -83,7 +83,7 @@ extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
 				     int add_treename);
 extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
 char *cifs_build_devname(char *nodename, const char *prepath);
-extern void cifs_wake_up_task(struct smb_message *smb);
+extern void cifs_wake_up_task(	struct TCP_Server_Info *server, struct smb_message *smb);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct smb_message *smb);
 extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 8cdb9252a37e..1e2a8839d742 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -60,7 +60,6 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 	 * default callback just wakes up the current task.
 	 */
 	get_task_struct(current);
-	smb->creator = current;
 	smb->callback = cifs_wake_up_task;
 	smb->callback_data = current;
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 7a64b070f74b..9bd19dd91d35 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -334,7 +334,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
 	list_for_each_entry_safe(smb, nsmb, &retry_list, qhead) {
 		list_del_init(&smb->qhead);
-		smb->callback(smb);
+		smb->callback(server, smb);
 		smb_put_message(smb);
 	}
 
@@ -917,7 +917,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 				list_del_init(&smb->qhead);
 				smb->mid_rc = mid_rc;
 				smb->mid_state = MID_RC;
-				smb->callback(smb);
+				smb->callback(server, smb);
 				smb_put_message(smb);
 			}
 
@@ -1111,7 +1111,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 		list_for_each_entry_safe(smb, smb2, &dispose_list, qhead) {
 			cifs_dbg(FYI, "Callback mid %llu\n", smb->mid);
 			list_del_init(&smb->qhead);
-			smb->callback(smb);
+			smb->callback(server, smb);
 			smb_put_message(smb);
 		}
 		/* 1/8th of sec is more than enough time for them to exit */
@@ -1388,7 +1388,7 @@ cifs_demultiplex_thread(void *p)
 				}
 
 				if (!smbs[i]->multiRsp || smbs[i]->multiEnd)
-					smbs[i]->callback(smbs[i]);
+					smbs[i]->callback(server, smbs[i]);
 
 				smb_put_message(smbs[i]);
 			} else if (server->ops->is_oplock_break &&
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 835a76169d40..63226bbba3d1 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4527,7 +4527,7 @@ handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 	unsigned int cur_off;
 	unsigned int cur_page_idx;
 	unsigned int pad_len;
-	struct cifs_io_subrequest *rdata = smb->callback_data;
+	struct cifs_io_subrequest *rdata = smb->subreq;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	int length;
 	bool use_rdma_mr = false;
@@ -4707,7 +4707,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				dw->server->ops->is_network_name_deleted(dw->buf,
 									 dw->server);
 
-			smb->callback(smb);
+			smb->callback(dw->server, smb);
 		} else {
 			spin_lock(&dw->server->srv_lock);
 			if (dw->server->tcpStatus == CifsNeedReconnect) {
@@ -4715,7 +4715,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				smb->mid_state = MID_RETRY_NEEDED;
 				spin_unlock(&dw->server->mid_lock);
 				spin_unlock(&dw->server->srv_lock);
-				smb->callback(smb);
+				smb->callback(dw->server, smb);
 			} else {
 				spin_lock(&dw->server->mid_lock);
 				smb->mid_state = MID_REQUEST_SUBMITTED;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 6b94da4c1149..8d50036fd028 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4094,9 +4094,8 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
  * FIXME: maybe we should consider checking that the reply matches request?
  */
 static void
-smb2_echo_callback(struct smb_message *smb)
+smb2_echo_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct TCP_Server_Info *server = smb->callback_data;
 	struct smb2_echo_rsp *rsp = (struct smb2_echo_rsp *)smb->resp_buf;
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
 
@@ -4298,7 +4297,6 @@ SMB2_echo(struct TCP_Server_Info *server)
 	smb->request		= req;
 	smb->total_len		= total_len;
 	smb->callback		= smb2_echo_callback;
-	smb->callback_data	= server;
 
 	req->hdr.CreditRequest = cpu_to_le16(1);
 
@@ -4533,12 +4531,11 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 }
 
 static void
-smb2_readv_callback(struct smb_message *smb)
+smb2_readv_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct cifs_io_subrequest *rdata = smb->callback_data;
+	struct cifs_io_subrequest *rdata = smb->subreq;
 	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
-	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)rdata->iov[0].iov_base;
 	struct cifs_credits credits = {
 		.value = 0,
@@ -4720,7 +4717,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	smb->receive		= cifs_readv_receive;
 	smb->handle		= smb3_handle_read_data;
 	smb->callback		= smb2_readv_callback;
-	smb->callback_data	= rdata;
+	smb->subreq		= rdata;
 
 	shdr = (struct smb2_hdr *)smb->request;
 
@@ -4847,11 +4844,10 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
  * workqueue completion task.
  */
 static void
-smb2_writev_callback(struct smb_message *smb)
+smb2_writev_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct cifs_io_subrequest *wdata = smb->callback_data;
+	struct cifs_io_subrequest *wdata = smb->subreq;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
-	struct TCP_Server_Info *server = wdata->server;
 	struct smb2_write_rsp *rsp = (struct smb2_write_rsp *)smb->resp_buf;
 	struct cifs_credits credits = {
 		.value = 0,
@@ -5016,7 +5012,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	smb->request		= req;
 	smb->total_len		= total_len;
 	smb->callback		= smb2_writev_callback;
-	smb->callback_data	= wdata;
+	smb->subreq		= wdata;
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index b02f458e408a..7c60584a8544 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -759,12 +759,6 @@ static void smb2_init_mid(struct smb_message *smb,
 	smb->credits_consumed	= credits > 0 ? credits : 1;
 	smb->server		= server;
 
-	/*
-	 * The default is for the mid to be synchronous, so the
-	 * default callback just wakes up the current task.
-	 */
-	smb->creator		= get_task_struct(current);
-
 	atomic_inc(&mid_count);
 	trace_smb3_cmd_enter(le32_to_cpu(shdr->Id.SyncId.TreeId),
 			     le64_to_cpu(shdr->SessionId),
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 042f689bbf52..7a4788b54a07 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -49,8 +49,9 @@ struct smb_message *smb_message_alloc(enum smb2_command cmd, gfp_t gfp)
 		 * callback just wakes up the current task.
 		 */
 		smb->callback		= cifs_wake_up_task;
-		smb->callback_data	= current;
 		smb->mid_state		= MID_REQUEST_ALLOCATED;
+
+		init_waitqueue_head(&smb->waitq);
 	}
 	return smb;
 }
@@ -84,11 +85,11 @@ void smb_put_messages(struct smb_message *smb)
 }
 
 void
-cifs_wake_up_task(struct smb_message *smb)
+cifs_wake_up_task(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	if (smb->mid_state == MID_RESPONSE_RECEIVED)
 		smb->mid_state = MID_RESPONSE_READY;
-	wake_up_process(smb->callback_data);
+	wake_up_all(&smb->waitq);
 }
 
 static void smb_clear_mid(struct smb_message *smb, struct TCP_Server_Info *server)
@@ -163,7 +164,6 @@ static void smb_clear_mid(struct smb_message *smb, struct TCP_Server_Info *serve
 		}
 	}
 #endif
-	put_task_struct(smb->creator);
 }
 
 static bool discard_message(struct TCP_Server_Info *server, struct smb_message *smb)
@@ -817,7 +817,7 @@ int wait_for_response(struct TCP_Server_Info *server, struct smb_message *smb)
 	if (smb->sr_flags & CIFS_INTERRUPTIBLE_WAIT)
 		sleep_state = TASK_INTERRUPTIBLE;
 
-	error = wait_event_state(server->response_q,
+	error = wait_event_state(smb->waitq,
 				 smb->mid_state != MID_REQUEST_SUBMITTED &&
 				 smb->mid_state != MID_RESPONSE_RECEIVED,
 				 (sleep_state | TASK_FREEZABLE_UNSAFE));
@@ -948,9 +948,8 @@ int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info *server
 }
 
 static void
-cifs_compound_callback(struct smb_message *smb)
+cifs_compound_callback(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct TCP_Server_Info *server = smb->server;
 	struct cifs_credits credits = {
 		.value = server->ops->get_credits(smb),
 		.instance = server->reconnect_instance,
@@ -963,16 +962,16 @@ cifs_compound_callback(struct smb_message *smb)
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
+	cifs_compound_callback(server, smb);
 }
 
 /*
@@ -1352,7 +1351,7 @@ __cifs_readv_discard(struct TCP_Server_Info *server, struct smb_message *smb,
 static int
 cifs_readv_discard(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct cifs_io_subrequest *rdata = smb->callback_data;
+	struct cifs_io_subrequest *rdata = smb->subreq;
 
 	return  __cifs_readv_discard(server, smb, rdata->result);
 }
@@ -1362,7 +1361,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	int length, len;
 	unsigned int data_offset, data_len;
-	struct cifs_io_subrequest *rdata = smb->callback_data;
+	struct cifs_io_subrequest *rdata = smb->subreq;
 	char *buf = server->smallbuf;
 	unsigned int buflen = server->pdu_size + HEADER_PREAMBLE_SIZE(server);
 	bool use_rdma_mr = false;


