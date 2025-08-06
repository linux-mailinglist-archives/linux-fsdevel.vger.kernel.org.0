Return-Path: <linux-fsdevel+bounces-56901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F3FB1CDC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B407AD389
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7143E2D3206;
	Wed,  6 Aug 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO5ZfvQY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7D2D23A8
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512744; cv=none; b=AqnD0vuKHTww4EojM0KIoriEl+o1F7NOqY4LPdt8HO2ve56f7fxx9XwbtDOib6jlfP+93yho0ksFUIGsepU+mDb97yUH4Uo1mfwazk/cWGnFCYW+mVXV4bM2ZxzY0RvIfA/I0L/nvw9QV+agnonGMHeeeRrmTar5yZkciAHl4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512744; c=relaxed/simple;
	bh=+eD/sWwxdshenZdDpW9TG7B9UxtTfSihNBWd+vNRfyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXDtihL8xd98oAoipapw7W/2297ZPO6dhVWAVnHpLIjw0I7XlXBNwU5f7YziQt7CJNbKWJpJiKyGhSxAswEXL1UrmzHJdBzGoFVmYLc/i5Y4w2A4gQ3EmM46PHMJafrFP/LrWgHbyZ+iN1TtTrEIseHovDE4TyyOH0UggAASXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO5ZfvQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dst57bsI11GjKrysipjfUIND5eWare7oQxyJC8LbWC4=;
	b=MO5ZfvQYl4MzgtyDI6Hqz5934ldUnhaTt7GBDk8aDY+c/UPHS+Isg7sHEFgWx4sEUPOIVh
	0ohszVHlmyFYeM1aDTnLnQofIzd6zevFYYh8QatDecLPJutEcta67EYDWEDTHmhh7Jg34A
	vjZbdzD0NlFxvHvz24s4A0SReO+yT58=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-aUjvRjiSPrW4rVH7nx40lQ-1; Wed,
 06 Aug 2025 16:38:58 -0400
X-MC-Unique: aUjvRjiSPrW4rVH7nx40lQ-1
X-Mimecast-MFC-AGG-ID: aUjvRjiSPrW4rVH7nx40lQ_1754512737
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E596A1800359;
	Wed,  6 Aug 2025 20:38:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C486A180035C;
	Wed,  6 Aug 2025 20:38:53 +0000 (UTC)
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
Subject: [RFC PATCH 21/31] cifs: [DEBUG] smb_message refcounting
Date: Wed,  6 Aug 2025 21:36:42 +0100
Message-ID: <20250806203705.2560493-22-dhowells@redhat.com>
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

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h      |  1 +
 fs/smb/client/cifsproto.h     |  5 +--
 fs/smb/client/connect.c       | 14 +++++---
 fs/smb/client/smb2ops.c       |  3 +-
 fs/smb/client/smb2pdu.c       |  6 ++--
 fs/smb/client/smb2transport.c |  2 +-
 fs/smb/client/trace.h         | 61 +++++++++++++++++++++++++++++++++++
 fs/smb/client/transport.c     | 57 ++++++++++++++++++++++++++------
 8 files changed, 127 insertions(+), 22 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 14b132fb14e0..045a29cedf0e 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1734,6 +1734,7 @@ struct smb_message {
 	void			*request;	/* Pointer to request message body */
 	wait_queue_head_t	waitq;		/* Wait queue for message events */
 	refcount_t		ref;
+	unsigned int		debug_id;	/* Debugging ID for tracing */
 	bool			sensitive;	/* Request contains sensitive data */
 	bool			cancelled;	/* T if cancelled */
 	unsigned int		sr_flags;	/* Flags passed to send_recv() */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index abae67d83499..074b65bb57a5 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -761,8 +761,9 @@ static inline void cifs_free_open_info(struct cifs_open_info_data *data)
 }
 
 struct smb_message *smb_message_alloc(enum smb2_command cmd, gfp_t gfp);
-void smb_get_message(struct smb_message *smb);
-void smb_put_message(struct smb_message *smb);
+void smb_see_message(struct smb_message *smb, enum smb_message_trace trace);
+void smb_get_message(struct smb_message *smb, enum smb_message_trace trace);
+void smb_put_message(struct smb_message *smb, enum smb_message_trace trace);
 void smb_put_messages(struct smb_message *smb);
 
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9bd19dd91d35..74b88304a782 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -323,6 +323,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
 	spin_lock(&server->mid_lock);
 	list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
+		smb_see_message(smb, smb_message_trace_see_abort_conn);
 		if (smb->mid_state == MID_REQUEST_SUBMITTED)
 			smb->mid_state = MID_RETRY_NEEDED;
 		list_move(&smb->qhead, &retry_list);
@@ -335,7 +336,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	list_for_each_entry_safe(smb, nsmb, &retry_list, qhead) {
 		list_del_init(&smb->qhead);
 		smb->callback(server, smb);
-		smb_put_message(smb);
+		smb_put_message(smb, smb_message_trace_put_abort_conn);
 	}
 
 	if (cifs_rdma_enabled(server)) {
@@ -885,6 +886,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 			 */
 			spin_lock(&server->mid_lock);
 			list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
+				smb_see_message(smb, smb_message_trace_see_is_smb_resp);
 				list_move(&smb->qhead, &dispose_list);
 				smb->mid_flags |= MID_DELETED;
 			}
@@ -918,7 +920,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 				smb->mid_rc = mid_rc;
 				smb->mid_state = MID_RC;
 				smb->callback(server, smb);
-				smb_put_message(smb);
+				smb_put_message(smb, smb_message_trace_put_is_smb_resp);
 			}
 
 			/*
@@ -968,6 +970,7 @@ dequeue_mid(struct smb_message *smb, bool malformed)
 		spin_unlock(&smb->server->mid_lock);
 		pr_warn_once("trying to dequeue a deleted mid\n");
 	} else {
+		smb_see_message(smb, smb_message_trace_see_dequeue_mid);
 		list_del_init(&smb->qhead);
 		smb->mid_flags |= MID_DELETED;
 		spin_unlock(&smb->server->mid_lock);
@@ -1101,6 +1104,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 		spin_lock(&server->mid_lock);
 		list_for_each_entry_safe(smb, smb2, &server->pending_mid_q, qhead) {
 			cifs_dbg(FYI, "Clearing mid %llu\n", smb->mid);
+			smb_see_message(smb, smb_message_trace_see_clean_demux);
 			smb->mid_state = MID_SHUTDOWN;
 			list_move(&smb->qhead, &dispose_list);
 			smb->mid_flags |= MID_DELETED;
@@ -1112,7 +1116,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 			cifs_dbg(FYI, "Callback mid %llu\n", smb->mid);
 			list_del_init(&smb->qhead);
 			smb->callback(server, smb);
-			smb_put_message(smb);
+			smb_put_message(smb, smb_message_trace_put_clean_demux);
 		}
 		/* 1/8th of sec is more than enough time for them to exit */
 		msleep(125);
@@ -1355,7 +1359,7 @@ cifs_demultiplex_thread(void *p)
 		if (length < 0) {
 			for (i = 0; i < num_smbs; i++)
 				if (smbs[i])
-					smb_put_message(smbs[i]);
+					smb_put_message(smbs[i], smb_message_trace_put_demux);
 			continue;
 		}
 
@@ -1390,7 +1394,7 @@ cifs_demultiplex_thread(void *p)
 				if (!smbs[i]->multiRsp || smbs[i]->multiEnd)
 					smbs[i]->callback(server, smbs[i]);
 
-				smb_put_message(smbs[i]);
+				smb_put_message(smbs[i], smb_message_trace_put_demux_cb);
 			} else if (server->ops->is_oplock_break &&
 				   server->ops->is_oplock_break(bufs[i],
 								server)) {
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 63226bbba3d1..1e24489b55e3 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -408,6 +408,7 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 		if ((smb->mid == wire_mid) &&
 		    (smb->mid_state == MID_REQUEST_SUBMITTED) &&
 		    (smb->command_id == command)) {
+			smb_see_message(smb, smb_message_trace_see_find_mid);
 			if (dequeue) {
 				list_del_init(&smb->qhead);
 				smb->mid_flags |= MID_DELETED;
@@ -4726,7 +4727,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				spin_unlock(&dw->server->srv_lock);
 			}
 		}
-		smb_put_message(smb);
+		smb_put_message(smb, smb_message_trace_put_decrypt_offload);
 	}
 
 free_pages:
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 8d50036fd028..3009acf0d884 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4305,7 +4305,7 @@ SMB2_echo(struct TCP_Server_Info *server)
 		cifs_dbg(FYI, "Echo request failed: %d\n", rc);
 
 	cifs_small_buf_release(req);
-	smb_put_message(smb);
+	smb_put_messages(smb);
 	return rc;
 }
 
@@ -4753,7 +4753,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 
 async_readv_out:
 	cifs_small_buf_release(buf);
-	smb_put_message(smb);
+	smb_put_messages(smb);
 	return rc;
 }
 
@@ -5127,7 +5127,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 
 async_writev_out:
 	cifs_small_buf_release(req);
-	smb_put_message(smb);
+	smb_put_messages(smb);
 out:
 	if (rc) {
 		trace_smb3_rw_credits(wdata->rreq->debug_id,
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 7194082bb5ac..da6377521fe9 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -801,7 +801,7 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 
 	smb2_init_mid(smb, server);
 
-	smb_get_message(smb);
+	smb_get_message(smb, smb_message_trace_get_enqueue_sync);
 	spin_lock(&server->mid_lock);
 	list_add_tail(&smb->qhead, &server->pending_mid_q);
 	spin_unlock(&server->mid_lock);
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 93e5b2bb9f28..5cee63960419 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -20,6 +20,45 @@
 /*
  * Specify enums for tracing information.
  */
+#define smb_message_traces \
+	EM(smb_message_trace_alloc_cancel,		"AL Cancel    ") \
+	EM(smb_message_trace_alloc_change_notify,	"AL Change-Nfy") \
+	EM(smb_message_trace_alloc_close,		"AL Close     ") \
+	EM(smb_message_trace_alloc_create,		"AL Create    ") \
+	EM(smb_message_trace_alloc_echo,		"AL Echo      ") \
+	EM(smb_message_trace_alloc_flush,		"AL Flush     ") \
+	EM(smb_message_trace_alloc_ioctl,		"AL Ioctl     ") \
+	EM(smb_message_trace_alloc_lock,		"AL Lock      ") \
+	EM(smb_message_trace_alloc_logoff,		"AL Logoff    ") \
+	EM(smb_message_trace_alloc_negotiate,		"AL Negotiate ") \
+	EM(smb_message_trace_alloc_oplock_break,	"AL Oplock-Brk") \
+	EM(smb_message_trace_alloc_query_directory,	"AL Query-Dir ") \
+	EM(smb_message_trace_alloc_query_info,		"AL Query-Info") \
+	EM(smb_message_trace_alloc_read,		"AL Read      ") \
+	EM(smb_message_trace_alloc_session_setup,	"AL Sess-setup") \
+	EM(smb_message_trace_alloc_set_info,		"AL Set-Info  ") \
+	EM(smb_message_trace_alloc_srv_to_cln_notif,	"AL s2c-Notify") \
+	EM(smb_message_trace_alloc_tree_connect,	"AL Tree-conn ") \
+	EM(smb_message_trace_alloc_tree_disconnect,	"AL Tree-disc ") \
+	EM(smb_message_trace_alloc_write,		"AL Write     ") \
+	EM(smb_message_trace_free,			"FREE         ") \
+	EM(smb_message_trace_get_call_async,		"GET call-asyn") \
+	EM(smb_message_trace_get_enqueue_sync,		"GET enq-sync ") \
+	EM(smb_message_trace_put_abort_conn,		"PUT abrt-conn") \
+	EM(smb_message_trace_put_clean_demux,		"PUT cln-demux") \
+	EM(smb_message_trace_put_decrypt_offload,	"PUT decrypt-o") \
+	EM(smb_message_trace_put_demux,			"PUT demux    ") \
+	EM(smb_message_trace_put_demux_cb,		"PUT demux-cb ") \
+	EM(smb_message_trace_put_discard_message,	"PUT disc-msg ") \
+	EM(smb_message_trace_put_is_smb_resp,		"PUT is-s-resp") \
+	EM(smb_message_trace_put_messages,		"PUT messages ") \
+	EM(smb_message_trace_see_abort_conn,		"SEE abrt-conn") \
+	EM(smb_message_trace_see_clean_demux,		"SEE cln-demux") \
+	EM(smb_message_trace_see_dequeue_mid,		"SEE deque-mid") \
+	EM(smb_message_trace_see_find_mid,		"SEE find-mid ") \
+	EM(smb_message_trace_see_is_smb_resp,		"SEE is-s-resp") \
+	E_(smb_message_trace_see_wake_up_task,		"SEE wake-task")
+
 #define smb3_rw_credits_traces \
 	EM(cifs_trace_rw_credits_call_readv_adjust,	"rd-call-adj") \
 	EM(cifs_trace_rw_credits_call_writev_adjust,	"wr-call-adj") \
@@ -79,6 +118,7 @@
 #define EM(a, b) a,
 #define E_(a, b) a
 
+enum smb_message_trace		{ smb_message_traces } __mode(byte);
 enum smb3_rw_credits_trace	{ smb3_rw_credits_traces } __mode(byte);
 enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mode(byte);
 
@@ -92,6 +132,7 @@ enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mode(byte);
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
+smb_message_traces;
 smb3_rw_credits_traces;
 smb3_tcon_ref_traces;
 
@@ -1573,6 +1614,26 @@ TRACE_EVENT(smb3_rw_credits,
 		      __entry->server_credits, __entry->in_flight)
 	    );
 
+TRACE_EVENT(smb3_message,
+	    TP_PROTO(unsigned int smb_message_debug_id, int ref,
+		     enum smb_message_trace trace),
+	    TP_ARGS(smb_message_debug_id, ref, trace),
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		smb_message)
+		    __field(int,			ref)
+		    __field(enum smb_message_trace,	trace)
+			     ),
+	    TP_fast_assign(
+		    __entry->smb_message = smb_message_debug_id;
+		    __entry->ref	= ref;
+		    __entry->trace	= trace;
+			   ),
+	    TP_printk("SMB=%08x %s r=%d",
+		      __entry->smb_message,
+		      __print_symbolic(__entry->trace, smb_message_traces),
+		      __entry->ref)
+	    );
+
 
 #undef EM
 #undef E_
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 7a4788b54a07..2ccfdd6b958b 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -34,12 +34,14 @@
 
 struct smb_message *smb_message_alloc(enum smb2_command cmd, gfp_t gfp)
 {
+	static atomic_t debug_ids;
 	struct smb_message *smb;
 
 	smb = mempool_alloc(&smb_message_pool, gfp);
 	if (smb) {
 		memset(smb, 0, sizeof(*smb));
 		refcount_set(&smb->ref, 1);
+		smb->debug_id	= atomic_inc_return(&debug_ids);
 		smb->command_id	= cmd;
 		smb->when_alloc	= jiffies;
 		smb->pid	= current->pid;
@@ -52,22 +54,47 @@ struct smb_message *smb_message_alloc(enum smb2_command cmd, gfp_t gfp)
 		smb->mid_state		= MID_REQUEST_ALLOCATED;
 
 		init_waitqueue_head(&smb->waitq);
+		trace_smb3_message(smb->debug_id, 1, (enum smb_message_trace)cmd);
 	}
 	return smb;
 }
 
-void smb_get_message(struct smb_message *smb)
+void smb_see_message(struct smb_message *smb, enum smb_message_trace trace)
 {
-	refcount_inc(&smb->ref);
+	trace_smb3_message(smb->debug_id, refcount_read(&smb->ref), trace);
+}
+
+void smb_get_message(struct smb_message *smb, enum smb_message_trace trace)
+{
+	int r;
+
+	__refcount_inc(&smb->ref, &r);
+	trace_smb3_message(smb->debug_id, r + 1, trace);
+	printk("GET SMB=%08x{%d} %pSR\n",
+	       smb->debug_id, r + 1, __builtin_return_address(0));
+}
+
+static void smb_free_message(struct smb_message *smb)
+{
+	trace_smb3_message(smb->debug_id, refcount_read(&smb->ref),
+			   smb_message_trace_free);
+	mempool_free(smb, &smb_message_pool);
 }
 
 /*
  * Drop a ref on a message.  This does not touch the chained messages.
  */
-void smb_put_message(struct smb_message *smb)
+void smb_put_message(struct smb_message *smb, enum smb_message_trace trace)
 {
-	if (refcount_dec_and_test(&smb->ref))
-		mempool_free(smb, &smb_message_pool);
+	unsigned int debug_id = smb->debug_id;
+	bool dead;
+	int r;
+
+	dead = __refcount_dec_and_test(&smb->ref, &r);
+	trace_smb3_message(debug_id, r - 1, trace);
+	printk("PUT SMB=%08x{%d} %pSR\n", debug_id, r - 1, __builtin_return_address(0));
+	if (dead)
+		smb_free_message(smb);
 }
 
 /*
@@ -79,8 +106,17 @@ void smb_put_messages(struct smb_message *smb)
 	struct smb_message *next;
 
 	for (; smb; smb = next) {
+		unsigned int debug_id = smb->debug_id;
+		bool dead;
+		int r;
+
 		next = smb->next;
-		smb_put_message(smb);
+		dead = __refcount_dec_and_test(&smb->ref, &r);
+		trace_smb3_message(debug_id, r - 1, smb_message_trace_put_messages);
+		printk("PUTS SMB=%08x{%d} %pSR\n",
+		       debug_id, r - 1, __builtin_return_address(0));
+		if (dead)
+			smb_free_message(smb);
 	}
 }
 
@@ -89,6 +125,7 @@ cifs_wake_up_task(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	if (smb->mid_state == MID_RESPONSE_RECEIVED)
 		smb->mid_state = MID_RESPONSE_READY;
+	smb_see_message(smb, smb_message_trace_see_wake_up_task);
 	wake_up_all(&smb->waitq);
 }
 
@@ -189,7 +226,7 @@ static void smb_discard_messages(struct TCP_Server_Info *server, struct smb_mess
 	for (smb = head_smb; smb; smb = next) {
 		next = smb->next;
 		if (discard_message(server, smb))
-			smb_put_message(smb);
+			smb_put_message(smb, smb_message_trace_put_discard_message);
 	}
 }
 
@@ -877,7 +914,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_message *smb,
 	smb->mid_state = MID_REQUEST_SUBMITTED;
 
 	/* put it on the pending_mid_q */
-	smb_get_message(smb);
+	smb_get_message(smb, smb_message_trace_get_call_async);
 	spin_lock(&server->mid_lock);
 	list_add_tail(&smb->qhead, &server->pending_mid_q);
 	spin_unlock(&server->mid_lock);
@@ -893,7 +930,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_message *smb,
 		revert_current_mid(server, smb->credits_consumed);
 		server->sequence_number -= 2;
 		if (discard_message(server, smb))
-			smb_put_message(smb);
+			smb_put_message(smb, smb_message_trace_put_discard_message);
 	}
 
 	cifs_server_unlock(server);
@@ -1295,7 +1332,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	rc = smb_send_recv_messages(xid, ses, server, head_smb, flags);
 
 error:
-	smb_put_messages(smb);
+	smb_put_messages(head_smb);
 	return rc;
 }
 


