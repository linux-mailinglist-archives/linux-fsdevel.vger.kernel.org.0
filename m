Return-Path: <linux-fsdevel+bounces-2580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8167E6DC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B831C280DE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3708836B0B;
	Thu,  9 Nov 2023 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYYBVqdL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC036AE5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:41:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124F3C3B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQ1HlrgzU8LxXbxkBh2iW9yo0ciwtpNgY9D/13gq0Ys=;
	b=SYYBVqdLwE0DDky9srZy0t3ClInXP/3Xaoj+DWbFjCRBvz2oJfqcTlU1n6htwZpl+nK1/s
	PPIwMivno4oQP32L4vd3QIGTTjdXfcq2sCotAs1upApl+nUQaQJmC8dmsY4u/ZHuYNnRD+
	chH4a17SyH9p7vmKETy9RgZksNw/a10=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-pMi719DUMcefe4qkwqaMHg-1; Thu,
 09 Nov 2023 10:41:19 -0500
X-MC-Unique: pMi719DUMcefe4qkwqaMHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EB133C00092;
	Thu,  9 Nov 2023 15:41:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B5DAF40C6EB9;
	Thu,  9 Nov 2023 15:41:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 41/41] afs: Fix offline and busy handling
Date: Thu,  9 Nov 2023 15:40:04 +0000
Message-ID: <20231109154004.3317227-42-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

The current code assumes offline and busy volume states apply to all
instances of a volume, not just the one on the server that returned
VOFFLINE or VBUSY.

Fix that by moving the flags recording this to the afs_server_entry struct
that is used to represent a particular instance of a volume on a specific
server.

Further, add a sleep for when we have iterated through all the servers so
that we don't keep poking the server every few milliseconds.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/internal.h          |  7 ++++---
 fs/afs/rotate.c            | 40 ++++++++++++++++++++++++--------------
 include/trace/events/afs.h |  1 +
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d1031241d11b..eb59b0487f8b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -603,6 +603,9 @@ struct afs_server_entry {
 	struct afs_volume	*volume;
 	struct list_head	slink;		/* Link in server->volumes */
 	time64_t		cb_expires_at;	/* Time at which volume-level callback expires */
+	unsigned long		flags;
+#define AFS_SE_VOLUME_OFFLINE	0		/* Set if volume offline notice given */
+#define AFS_SE_VOLUME_BUSY	1		/* Set if volume busy notice given */
 };
 
 struct afs_server_list {
@@ -636,9 +639,7 @@ struct afs_volume {
 #define AFS_VOLUME_UPDATING	1	/* - T if an update is in progress */
 #define AFS_VOLUME_WAIT		2	/* - T if users must wait for update */
 #define AFS_VOLUME_DELETED	3	/* - T if volume appears deleted */
-#define AFS_VOLUME_OFFLINE	4	/* - T if volume offline notice given */
-#define AFS_VOLUME_BUSY		5	/* - T if volume busy notice given */
-#define AFS_VOLUME_MAYBE_NO_IBULK 6	/* - T if some servers don't have InlineBulkStatus */
+#define AFS_VOLUME_MAYBE_NO_IBULK 4	/* - T if some servers don't have InlineBulkStatus */
 #ifdef CONFIG_AFS_FSCACHE
 	struct fscache_volume	*cache;		/* Caching cookie */
 #endif
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 3f656dcb0adf..cb0ab1c2c401 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -111,7 +111,7 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 /*
  * Post volume busy note.
  */
-static void afs_busy(struct afs_volume *volume, u32 abort_code)
+static void afs_busy(struct afs_operation *op, u32 abort_code)
 {
 	const char *m;
 
@@ -122,7 +122,8 @@ static void afs_busy(struct afs_volume *volume, u32 abort_code)
 	default:		m = "busy";		break;
 	}
 
-	pr_notice("kAFS: Volume %llu '%s' is %s\n", volume->vid, volume->name, m);
+	pr_notice("kAFS: Volume %llu '%s' on server %pU is %s\n",
+		  op->volume->vid, op->volume->name, &op->server->uuid, m);
 }
 
 /*
@@ -130,6 +131,7 @@ static void afs_busy(struct afs_volume *volume, u32 abort_code)
  */
 static bool afs_sleep_and_retry(struct afs_operation *op)
 {
+	trace_afs_rotate(op, afs_rotate_trace_busy_sleep, 0);
 	if (!(op->flags & AFS_OPERATION_UNINTR)) {
 		msleep_interruptible(1000);
 		if (signal_pending(current)) {
@@ -180,6 +182,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (op->call_error) {
 	case 0:
+		clear_bit(AFS_SE_VOLUME_OFFLINE,
+			  &op->server_list->servers[op->server_index].flags);
+		clear_bit(AFS_SE_VOLUME_BUSY,
+			  &op->server_list->servers[op->server_index].flags);
 		op->cumul_error.responded = true;
 		fallthrough;
 	default:
@@ -297,18 +303,16 @@ bool afs_select_fileserver(struct afs_operation *op)
 			 * expected to come back but it might take a long time (could be
 			 * days).
 			 */
-			if (!test_and_set_bit(AFS_VOLUME_OFFLINE, &op->volume->flags)) {
-				afs_busy(op->volume, abort_code);
-				clear_bit(AFS_VOLUME_BUSY, &op->volume->flags);
+			if (!test_and_set_bit(AFS_SE_VOLUME_OFFLINE,
+					      &op->server_list->servers[op->server_index].flags)) {
+				afs_busy(op, abort_code);
+				clear_bit(AFS_SE_VOLUME_BUSY,
+					  &op->server_list->servers[op->server_index].flags);
 			}
 			if (op->flags & AFS_OPERATION_NO_VSLEEP) {
 				afs_op_set_error(op, -EADV);
 				goto failed;
 			}
-			if (op->flags & AFS_OPERATION_CUR_ONLY) {
-				afs_op_set_error(op, -ESTALE);
-				goto failed;
-			}
 			goto busy;
 
 		case VRESTARTING: /* The fileserver is either shutting down or starting up. */
@@ -329,9 +333,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 				afs_op_set_error(op, -EBUSY);
 				goto failed;
 			}
-			if (!test_and_set_bit(AFS_VOLUME_BUSY, &op->volume->flags)) {
-				afs_busy(op->volume, abort_code);
-				clear_bit(AFS_VOLUME_OFFLINE, &op->volume->flags);
+			if (!test_and_set_bit(AFS_SE_VOLUME_BUSY,
+					      &op->server_list->servers[op->server_index].flags)) {
+				afs_busy(op, abort_code);
+				clear_bit(AFS_SE_VOLUME_OFFLINE,
+					  &op->server_list->servers[op->server_index].flags);
 			}
 		busy:
 			if (op->flags & AFS_OPERATION_CUR_ONLY) {
@@ -411,8 +417,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 		default:
 			afs_op_accumulate_error(op, error, abort_code);
 		failed_but_online:
-			clear_bit(AFS_VOLUME_OFFLINE, &op->volume->flags);
-			clear_bit(AFS_VOLUME_BUSY, &op->volume->flags);
+			clear_bit(AFS_SE_VOLUME_OFFLINE,
+				  &op->server_list->servers[op->server_index].flags);
+			clear_bit(AFS_SE_VOLUME_BUSY,
+				  &op->server_list->servers[op->server_index].flags);
 			goto failed;
 		}
 
@@ -640,8 +648,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 	 * of them were busy.
 	 */
 	trace_afs_rotate(op, afs_rotate_trace_no_more_servers, 0);
-	if (op->flags & AFS_OPERATION_VBUSY)
+	if (op->flags & AFS_OPERATION_VBUSY) {
+		afs_sleep_and_retry(op);
 		goto restart_from_beginning;
+	}
 
 	rcu_read_lock();
 	for (i = 0; i < op->server_list->nr_servers; i++) {
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 804d9e147314..ac50fa687429 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -446,6 +446,7 @@ enum yfs_cm_operation {
 
 #define afs_rotate_traces						\
 	EM(afs_rotate_trace_aborted,		"Abortd")		\
+	EM(afs_rotate_trace_busy_sleep,		"BsySlp")		\
 	EM(afs_rotate_trace_check_vol_status,	"VolStt")		\
 	EM(afs_rotate_trace_failed,		"Failed")		\
 	EM(afs_rotate_trace_iter,		"Iter  ")		\


