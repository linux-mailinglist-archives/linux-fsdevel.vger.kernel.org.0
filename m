Return-Path: <linux-fsdevel+bounces-56886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9800DB1CD94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085AC18C5E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387FF2BE7B3;
	Wed,  6 Aug 2025 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZLyoWDZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466D2BE62D
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512676; cv=none; b=iPbq/++Ylt/OTPMiBjPoPMQ4ocoxHQNUTmJCktJEZf8g0dCuhYhSAGs/RR9xa9oZVSbgnpXroRPJ4Qg1BQFoK3joMwzK/scutwbPUsh75g4znbvskhJwZbO/wrDeObwxn0ohxm3H1ZJKZjtHq42+DsxwsvD6vHfMIQv14YNgAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512676; c=relaxed/simple;
	bh=li/hKqgRFk4+n+r5+SCLv4VH+KdtvY9xjpPt2/QLJ5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H95SMngnPA7RlJEOB55SGU5TfmXERovHHn1/oYhwM1Rg9lpQ0tzm07e1qRw0pXNTHpyhBmyj3bbKqzMRChtEdyaaqfkaIaVLfLTgZOeZt6N/TLaJceG6I1g3INpi21yv/hioFSadFzngdJ1XcJyWLEyJR+Aanr2hAr5oxvKIhsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZLyoWDZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TuHgqr0lIiE8hPLO+0aDHW4TmN9tj+Ru9/5tx2eGmY=;
	b=QZLyoWDZE/nDZIb8k1+SfvuISxCcNaHUoVLMRSy+OkDzqhwpDM+xJy3DUO7JDy7CYj1RQk
	shrDKGD9Lj486MQoqutTDGyxfYD6U+P7wWuW3PccpMXNpICJRD+eFvff5GsTB2nLxB4+et
	hDkAP9BkKXUq2WDjbSzvsZEphYe/47U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-rwyJsyy9PcqHWYVjEs9j-g-1; Wed,
 06 Aug 2025 16:37:45 -0400
X-MC-Unique: rwyJsyy9PcqHWYVjEs9j-g-1
X-Mimecast-MFC-AGG-ID: rwyJsyy9PcqHWYVjEs9j-g_1754512664
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC19E180047F;
	Wed,  6 Aug 2025 20:37:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 735443000198;
	Wed,  6 Aug 2025 20:37:40 +0000 (UTC)
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
Subject: [RFC PATCH 06/31] cifs: Move the SMB1 transport code out of transport.c
Date: Wed,  6 Aug 2025 21:36:27 +0100
Message-ID: <20250806203705.2560493-7-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/Makefile        |   2 +-
 fs/smb/client/cifsproto.h     |  15 +
 fs/smb/client/cifstransport.c | 566 ++++++++++++++++++++++++++++++++++
 fs/smb/client/transport.c     | 559 +--------------------------------
 4 files changed, 588 insertions(+), 554 deletions(-)
 create mode 100644 fs/smb/client/cifstransport.c

diff --git a/fs/smb/client/Makefile b/fs/smb/client/Makefile
index 22023e30915b..4c97b31a25c2 100644
--- a/fs/smb/client/Makefile
+++ b/fs/smb/client/Makefile
@@ -32,6 +32,6 @@ cifs-$(CONFIG_CIFS_SMB_DIRECT) += smbdirect.o
 
 cifs-$(CONFIG_CIFS_ROOT) += cifsroot.o
 
-cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) += smb1ops.o cifssmb.o
+cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) += smb1ops.o cifssmb.o cifstransport.o
 
 cifs-$(CONFIG_CIFS_COMPRESSION) += compress.o compress/lz77.o
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 045227ed4efc..8661ab105b4f 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -116,16 +116,31 @@ extern int SendReceive(const unsigned int /* xid */ , struct cifs_ses *,
 			int * /* bytes returned */ , const int);
 extern int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
 			    char *in_buf, int flags);
+int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server);
 extern struct mid_q_entry *cifs_setup_request(struct cifs_ses *,
 				struct TCP_Server_Info *,
 				struct smb_rqst *);
 extern struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *,
 						struct smb_rqst *);
+int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
+		    struct smb_rqst *rqst);
 extern int cifs_check_receive(struct mid_q_entry *mid,
 			struct TCP_Server_Info *server, bool log_error);
+int wait_for_free_request(struct TCP_Server_Info *server, const int flags,
+			  unsigned int *instance);
 extern int cifs_wait_mtu_credits(struct TCP_Server_Info *server,
 				 size_t size, size_t *num,
 				 struct cifs_credits *credits);
+
+static inline int
+send_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
+	    struct mid_q_entry *mid)
+{
+	return server->ops->send_cancel ?
+				server->ops->send_cancel(server, rqst, mid) : 0;
+}
+
+int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ);
 extern int SendReceive2(const unsigned int /* xid */ , struct cifs_ses *,
 			struct kvec *, int /* nvec to send */,
 			int * /* type of buf returned */, const int flags,
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
new file mode 100644
index 000000000000..241e0b427357
--- /dev/null
+++ b/fs/smb/client/cifstransport.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ *
+ *   Copyright (C) International Business Machines  Corp., 2002,2008
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *   Jeremy Allison (jra@samba.org) 2006.
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/gfp.h>
+#include <linux/wait.h>
+#include <linux/net.h>
+#include <linux/delay.h>
+#include <linux/freezer.h>
+#include <linux/tcp.h>
+#include <linux/bvec.h>
+#include <linux/highmem.h>
+#include <linux/uaccess.h>
+#include <linux/processor.h>
+#include <linux/mempool.h>
+#include <linux/sched/signal.h>
+#include <linux/task_io_accounting_ops.h>
+#include "cifspdu.h"
+#include "cifsglob.h"
+#include "cifsproto.h"
+#include "cifs_debug.h"
+#include "smb2proto.h"
+#include "smbdirect.h"
+#include "compress.h"
+
+/* Max number of iovectors we can use off the stack when sending requests. */
+#define CIFS_MAX_IOV_SIZE 8
+
+static struct mid_q_entry *
+alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
+{
+	struct mid_q_entry *temp;
+
+	if (server == NULL) {
+		cifs_dbg(VFS, "%s: null TCP session\n", __func__);
+		return NULL;
+	}
+
+	temp = mempool_alloc(cifs_mid_poolp, GFP_NOFS);
+	memset(temp, 0, sizeof(struct mid_q_entry));
+	kref_init(&temp->refcount);
+	temp->mid = get_mid(smb_buffer);
+	temp->pid = current->pid;
+	temp->command = cpu_to_le16(smb_buffer->Command);
+	cifs_dbg(FYI, "For smb_command %d\n", smb_buffer->Command);
+	/* easier to use jiffies */
+	/* when mid allocated can be before when sent */
+	temp->when_alloc = jiffies;
+	temp->server = server;
+
+	/*
+	 * The default is for the mid to be synchronous, so the
+	 * default callback just wakes up the current task.
+	 */
+	get_task_struct(current);
+	temp->creator = current;
+	temp->callback = cifs_wake_up_task;
+	temp->callback_data = current;
+
+	atomic_inc(&mid_count);
+	temp->mid_state = MID_REQUEST_ALLOCATED;
+	return temp;
+}
+
+int
+smb_send(struct TCP_Server_Info *server, struct smb_hdr *smb_buffer,
+	 unsigned int smb_buf_length)
+{
+	struct kvec iov[2];
+	struct smb_rqst rqst = { .rq_iov = iov,
+				 .rq_nvec = 2 };
+
+	iov[0].iov_base = smb_buffer;
+	iov[0].iov_len = 4;
+	iov[1].iov_base = (char *)smb_buffer + 4;
+	iov[1].iov_len = smb_buf_length;
+
+	return __smb_send_rqst(server, 1, &rqst);
+}
+
+static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
+			struct mid_q_entry **ppmidQ)
+{
+	spin_lock(&ses->ses_lock);
+	if (ses->ses_status == SES_NEW) {
+		if ((in_buf->Command != SMB_COM_SESSION_SETUP_ANDX) &&
+			(in_buf->Command != SMB_COM_NEGOTIATE)) {
+			spin_unlock(&ses->ses_lock);
+			return -EAGAIN;
+		}
+		/* else ok - we are setting up session */
+	}
+
+	if (ses->ses_status == SES_EXITING) {
+		/* check if SMB session is bad because we are setting it up */
+		if (in_buf->Command != SMB_COM_LOGOFF_ANDX) {
+			spin_unlock(&ses->ses_lock);
+			return -EAGAIN;
+		}
+		/* else ok - we are shutting down session */
+	}
+	spin_unlock(&ses->ses_lock);
+
+	*ppmidQ = alloc_mid(in_buf, ses->server);
+	if (*ppmidQ == NULL)
+		return -ENOMEM;
+	spin_lock(&ses->server->mid_lock);
+	list_add_tail(&(*ppmidQ)->qhead, &ses->server->pending_mid_q);
+	spin_unlock(&ses->server->mid_lock);
+	return 0;
+}
+
+struct mid_q_entry *
+cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
+{
+	int rc;
+	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
+	struct mid_q_entry *mid;
+
+	if (rqst->rq_iov[0].iov_len != 4 ||
+	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
+		return ERR_PTR(-EIO);
+
+	/* enable signing if server requires it */
+	if (server->sign)
+		hdr->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
+
+	mid = alloc_mid(hdr, server);
+	if (mid == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	rc = cifs_sign_rqst(rqst, server, &mid->sequence_number);
+	if (rc) {
+		release_mid(mid);
+		return ERR_PTR(rc);
+	}
+
+	return mid;
+}
+
+/*
+ *
+ * Send an SMB Request.  No response info (other than return code)
+ * needs to be parsed.
+ *
+ * flags indicate the type of request buffer and how long to wait
+ * and whether to log NT STATUS code (error) before mapping it to POSIX error
+ *
+ */
+int
+SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
+		 char *in_buf, int flags)
+{
+	int rc;
+	struct kvec iov[1];
+	struct kvec rsp_iov;
+	int resp_buf_type;
+
+	iov[0].iov_base = in_buf;
+	iov[0].iov_len = get_rfc1002_length(in_buf) + 4;
+	flags |= CIFS_NO_RSP_BUF;
+	rc = SendReceive2(xid, ses, iov, 1, &resp_buf_type, flags, &rsp_iov);
+	cifs_dbg(NOISY, "SendRcvNoRsp flags %d rc %d\n", flags, rc);
+
+	return rc;
+}
+
+int
+cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+		   bool log_error)
+{
+	unsigned int len = get_rfc1002_length(mid->resp_buf) + 4;
+
+	dump_smb(mid->resp_buf, min_t(u32, 92, len));
+
+	/* convert the length into a more usable form */
+	if (server->sign) {
+		struct kvec iov[2];
+		int rc = 0;
+		struct smb_rqst rqst = { .rq_iov = iov,
+					 .rq_nvec = 2 };
+
+		iov[0].iov_base = mid->resp_buf;
+		iov[0].iov_len = 4;
+		iov[1].iov_base = (char *)mid->resp_buf + 4;
+		iov[1].iov_len = len - 4;
+		/* FIXME: add code to kill session */
+		rc = cifs_verify_signature(&rqst, server,
+					   mid->sequence_number);
+		if (rc)
+			cifs_server_dbg(VFS, "SMB signature verification returned error = %d\n",
+				 rc);
+	}
+
+	/* BB special case reconnect tid and uid here? */
+	return map_and_check_smb_error(mid, log_error);
+}
+
+struct mid_q_entry *
+cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
+		   struct smb_rqst *rqst)
+{
+	int rc;
+	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
+	struct mid_q_entry *mid;
+
+	if (rqst->rq_iov[0].iov_len != 4 ||
+	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
+		return ERR_PTR(-EIO);
+
+	rc = allocate_mid(ses, hdr, &mid);
+	if (rc)
+		return ERR_PTR(rc);
+	rc = cifs_sign_rqst(rqst, ses->server, &mid->sequence_number);
+	if (rc) {
+		delete_mid(mid);
+		return ERR_PTR(rc);
+	}
+	return mid;
+}
+
+int
+SendReceive2(const unsigned int xid, struct cifs_ses *ses,
+	     struct kvec *iov, int n_vec, int *resp_buf_type /* ret */,
+	     const int flags, struct kvec *resp_iov)
+{
+	struct smb_rqst rqst;
+	struct kvec s_iov[CIFS_MAX_IOV_SIZE], *new_iov;
+	int rc;
+
+	if (n_vec + 1 > CIFS_MAX_IOV_SIZE) {
+		new_iov = kmalloc_array(n_vec + 1, sizeof(struct kvec),
+					GFP_KERNEL);
+		if (!new_iov) {
+			/* otherwise cifs_send_recv below sets resp_buf_type */
+			*resp_buf_type = CIFS_NO_BUFFER;
+			return -ENOMEM;
+		}
+	} else
+		new_iov = s_iov;
+
+	/* 1st iov is a RFC1001 length followed by the rest of the packet */
+	memcpy(new_iov + 1, iov, (sizeof(struct kvec) * n_vec));
+
+	new_iov[0].iov_base = new_iov[1].iov_base;
+	new_iov[0].iov_len = 4;
+	new_iov[1].iov_base += 4;
+	new_iov[1].iov_len -= 4;
+
+	memset(&rqst, 0, sizeof(struct smb_rqst));
+	rqst.rq_iov = new_iov;
+	rqst.rq_nvec = n_vec + 1;
+
+	rc = cifs_send_recv(xid, ses, ses->server,
+			    &rqst, resp_buf_type, flags, resp_iov);
+	if (n_vec + 1 > CIFS_MAX_IOV_SIZE)
+		kfree(new_iov);
+	return rc;
+}
+
+int
+SendReceive(const unsigned int xid, struct cifs_ses *ses,
+	    struct smb_hdr *in_buf, struct smb_hdr *out_buf,
+	    int *pbytes_returned, const int flags)
+{
+	int rc = 0;
+	struct mid_q_entry *midQ;
+	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
+	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
+	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
+	struct cifs_credits credits = { .value = 1, .instance = 0 };
+	struct TCP_Server_Info *server;
+
+	if (ses == NULL) {
+		cifs_dbg(VFS, "Null smb session\n");
+		return -EIO;
+	}
+	server = ses->server;
+	if (server == NULL) {
+		cifs_dbg(VFS, "Null tcp session\n");
+		return -EIO;
+	}
+
+	spin_lock(&server->srv_lock);
+	if (server->tcpStatus == CifsExiting) {
+		spin_unlock(&server->srv_lock);
+		return -ENOENT;
+	}
+	spin_unlock(&server->srv_lock);
+
+	/* Ensure that we do not send more than 50 overlapping requests
+	   to the same server. We may make this configurable later or
+	   use ses->maxReq */
+
+	if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
+		cifs_server_dbg(VFS, "Invalid length, greater than maximum frame, %d\n",
+				len);
+		return -EIO;
+	}
+
+	rc = wait_for_free_request(server, flags, &credits.instance);
+	if (rc)
+		return rc;
+
+	/* make sure that we sign in the same order that we send on this socket
+	   and avoid races inside tcp sendmsg code that could cause corruption
+	   of smb data */
+
+	cifs_server_lock(server);
+
+	rc = allocate_mid(ses, in_buf, &midQ);
+	if (rc) {
+		cifs_server_unlock(server);
+		/* Update # of requests on wire to server */
+		add_credits(server, &credits, 0);
+		return rc;
+	}
+
+	rc = cifs_sign_smb(in_buf, server, &midQ->sequence_number);
+	if (rc) {
+		cifs_server_unlock(server);
+		goto out;
+	}
+
+	midQ->mid_state = MID_REQUEST_SUBMITTED;
+
+	rc = smb_send(server, in_buf, len);
+	cifs_save_when_sent(midQ);
+
+	if (rc < 0)
+		server->sequence_number -= 2;
+
+	cifs_server_unlock(server);
+
+	if (rc < 0)
+		goto out;
+
+	rc = wait_for_response(server, midQ);
+	if (rc != 0) {
+		send_cancel(server, &rqst, midQ);
+		spin_lock(&server->mid_lock);
+		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
+			/* no longer considered to be "in-flight" */
+			midQ->callback = release_mid;
+			spin_unlock(&server->mid_lock);
+			add_credits(server, &credits, 0);
+			return rc;
+		}
+		spin_unlock(&server->mid_lock);
+	}
+
+	rc = cifs_sync_mid_result(midQ, server);
+	if (rc != 0) {
+		add_credits(server, &credits, 0);
+		return rc;
+	}
+
+	if (!midQ->resp_buf || !out_buf ||
+	    midQ->mid_state != MID_RESPONSE_READY) {
+		rc = -EIO;
+		cifs_server_dbg(VFS, "Bad MID state?\n");
+		goto out;
+	}
+
+	*pbytes_returned = get_rfc1002_length(midQ->resp_buf);
+	memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
+	rc = cifs_check_receive(midQ, server, 0);
+out:
+	delete_mid(midQ);
+	add_credits(server, &credits, 0);
+
+	return rc;
+}
+
+/* We send a LOCKINGX_CANCEL_LOCK to cause the Windows
+   blocking lock to return. */
+
+static int
+send_lock_cancel(const unsigned int xid, struct cifs_tcon *tcon,
+			struct smb_hdr *in_buf,
+			struct smb_hdr *out_buf)
+{
+	int bytes_returned;
+	struct cifs_ses *ses = tcon->ses;
+	LOCK_REQ *pSMB = (LOCK_REQ *)in_buf;
+
+	/* We just modify the current in_buf to change
+	   the type of lock from LOCKING_ANDX_SHARED_LOCK
+	   or LOCKING_ANDX_EXCLUSIVE_LOCK to
+	   LOCKING_ANDX_CANCEL_LOCK. */
+
+	pSMB->LockType = LOCKING_ANDX_CANCEL_LOCK|LOCKING_ANDX_LARGE_FILES;
+	pSMB->Timeout = 0;
+	pSMB->hdr.Mid = get_next_mid(ses->server);
+
+	return SendReceive(xid, ses, in_buf, out_buf,
+			&bytes_returned, 0);
+}
+
+int
+SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
+	    struct smb_hdr *in_buf, struct smb_hdr *out_buf,
+	    int *pbytes_returned)
+{
+	int rc = 0;
+	int rstart = 0;
+	struct mid_q_entry *midQ;
+	struct cifs_ses *ses;
+	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
+	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
+	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
+	unsigned int instance;
+	struct TCP_Server_Info *server;
+
+	if (tcon == NULL || tcon->ses == NULL) {
+		cifs_dbg(VFS, "Null smb session\n");
+		return -EIO;
+	}
+	ses = tcon->ses;
+	server = ses->server;
+
+	if (server == NULL) {
+		cifs_dbg(VFS, "Null tcp session\n");
+		return -EIO;
+	}
+
+	spin_lock(&server->srv_lock);
+	if (server->tcpStatus == CifsExiting) {
+		spin_unlock(&server->srv_lock);
+		return -ENOENT;
+	}
+	spin_unlock(&server->srv_lock);
+
+	/* Ensure that we do not send more than 50 overlapping requests
+	   to the same server. We may make this configurable later or
+	   use ses->maxReq */
+
+	if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
+		cifs_tcon_dbg(VFS, "Invalid length, greater than maximum frame, %d\n",
+			      len);
+		return -EIO;
+	}
+
+	rc = wait_for_free_request(server, CIFS_BLOCKING_OP, &instance);
+	if (rc)
+		return rc;
+
+	/* make sure that we sign in the same order that we send on this socket
+	   and avoid races inside tcp sendmsg code that could cause corruption
+	   of smb data */
+
+	cifs_server_lock(server);
+
+	rc = allocate_mid(ses, in_buf, &midQ);
+	if (rc) {
+		cifs_server_unlock(server);
+		return rc;
+	}
+
+	rc = cifs_sign_smb(in_buf, server, &midQ->sequence_number);
+	if (rc) {
+		delete_mid(midQ);
+		cifs_server_unlock(server);
+		return rc;
+	}
+
+	midQ->mid_state = MID_REQUEST_SUBMITTED;
+	rc = smb_send(server, in_buf, len);
+	cifs_save_when_sent(midQ);
+
+	if (rc < 0)
+		server->sequence_number -= 2;
+
+	cifs_server_unlock(server);
+
+	if (rc < 0) {
+		delete_mid(midQ);
+		return rc;
+	}
+
+	/* Wait for a reply - allow signals to interrupt. */
+	rc = wait_event_interruptible(server->response_q,
+		(!(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		   midQ->mid_state == MID_RESPONSE_RECEIVED)) ||
+		((server->tcpStatus != CifsGood) &&
+		 (server->tcpStatus != CifsNew)));
+
+	/* Were we interrupted by a signal ? */
+	spin_lock(&server->srv_lock);
+	if ((rc == -ERESTARTSYS) &&
+		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
+		((server->tcpStatus == CifsGood) ||
+		 (server->tcpStatus == CifsNew))) {
+		spin_unlock(&server->srv_lock);
+
+		if (in_buf->Command == SMB_COM_TRANSACTION2) {
+			/* POSIX lock. We send a NT_CANCEL SMB to cause the
+			   blocking lock to return. */
+			rc = send_cancel(server, &rqst, midQ);
+			if (rc) {
+				delete_mid(midQ);
+				return rc;
+			}
+		} else {
+			/* Windows lock. We send a LOCKINGX_CANCEL_LOCK
+			   to cause the blocking lock to return. */
+
+			rc = send_lock_cancel(xid, tcon, in_buf, out_buf);
+
+			/* If we get -ENOLCK back the lock may have
+			   already been removed. Don't exit in this case. */
+			if (rc && rc != -ENOLCK) {
+				delete_mid(midQ);
+				return rc;
+			}
+		}
+
+		rc = wait_for_response(server, midQ);
+		if (rc) {
+			send_cancel(server, &rqst, midQ);
+			spin_lock(&server->mid_lock);
+			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
+				/* no longer considered to be "in-flight" */
+				midQ->callback = release_mid;
+				spin_unlock(&server->mid_lock);
+				return rc;
+			}
+			spin_unlock(&server->mid_lock);
+		}
+
+		/* We got the response - restart system call. */
+		rstart = 1;
+		spin_lock(&server->srv_lock);
+	}
+	spin_unlock(&server->srv_lock);
+
+	rc = cifs_sync_mid_result(midQ, server);
+	if (rc != 0)
+		return rc;
+
+	/* rcvd frame is ok */
+	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_READY) {
+		rc = -EIO;
+		cifs_tcon_dbg(VFS, "Bad MID state?\n");
+		goto out;
+	}
+
+	*pbytes_returned = get_rfc1002_length(midQ->resp_buf);
+	memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
+	rc = cifs_check_receive(midQ, server, 0);
+out:
+	delete_mid(midQ);
+	if (rstart && rc == -EACCES)
+		return -ERESTARTSYS;
+	return rc;
+}
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 191783f553ce..68c73e22c3c9 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -30,9 +30,6 @@
 #include "smbdirect.h"
 #include "compress.h"
 
-/* Max number of iovectors we can use off the stack when sending requests. */
-#define CIFS_MAX_IOV_SIZE 8
-
 void
 cifs_wake_up_task(struct mid_q_entry *mid)
 {
@@ -41,42 +38,6 @@ cifs_wake_up_task(struct mid_q_entry *mid)
 	wake_up_process(mid->callback_data);
 }
 
-static struct mid_q_entry *
-alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
-{
-	struct mid_q_entry *temp;
-
-	if (server == NULL) {
-		cifs_dbg(VFS, "%s: null TCP session\n", __func__);
-		return NULL;
-	}
-
-	temp = mempool_alloc(cifs_mid_poolp, GFP_NOFS);
-	memset(temp, 0, sizeof(struct mid_q_entry));
-	kref_init(&temp->refcount);
-	temp->mid = get_mid(smb_buffer);
-	temp->pid = current->pid;
-	temp->command = cpu_to_le16(smb_buffer->Command);
-	cifs_dbg(FYI, "For smb_command %d\n", smb_buffer->Command);
-	/* easier to use jiffies */
-	/* when mid allocated can be before when sent */
-	temp->when_alloc = jiffies;
-	temp->server = server;
-
-	/*
-	 * The default is for the mid to be synchronous, so the
-	 * default callback just wakes up the current task.
-	 */
-	get_task_struct(current);
-	temp->creator = current;
-	temp->callback = cifs_wake_up_task;
-	temp->callback_data = current;
-
-	atomic_inc(&mid_count);
-	temp->mid_state = MID_REQUEST_ALLOCATED;
-	return temp;
-}
-
 void __release_mid(struct kref *refcount)
 {
 	struct mid_q_entry *midEntry =
@@ -269,9 +230,8 @@ smb_rqst_len(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	return buflen;
 }
 
-static int
-__smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
-		struct smb_rqst *rqst)
+int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
+		    struct smb_rqst *rqst)
 {
 	int rc;
 	struct kvec *iov;
@@ -456,22 +416,6 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	return rc;
 }
 
-int
-smb_send(struct TCP_Server_Info *server, struct smb_hdr *smb_buffer,
-	 unsigned int smb_buf_length)
-{
-	struct kvec iov[2];
-	struct smb_rqst rqst = { .rq_iov = iov,
-				 .rq_nvec = 2 };
-
-	iov[0].iov_base = smb_buffer;
-	iov[0].iov_len = 4;
-	iov[1].iov_base = (char *)smb_buffer + 4;
-	iov[1].iov_len = smb_buf_length;
-
-	return __smb_send_rqst(server, 1, &rqst);
-}
-
 static int
 wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 		      const int timeout, const int flags,
@@ -626,9 +570,8 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 	return 0;
 }
 
-static int
-wait_for_free_request(struct TCP_Server_Info *server, const int flags,
-		      unsigned int *instance)
+int wait_for_free_request(struct TCP_Server_Info *server, const int flags,
+			  unsigned int *instance)
 {
 	return wait_for_free_credits(server, 1, -1, flags,
 				     instance);
@@ -690,40 +633,7 @@ cifs_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
 	return 0;
 }
 
-static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
-			struct mid_q_entry **ppmidQ)
-{
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_NEW) {
-		if ((in_buf->Command != SMB_COM_SESSION_SETUP_ANDX) &&
-			(in_buf->Command != SMB_COM_NEGOTIATE)) {
-			spin_unlock(&ses->ses_lock);
-			return -EAGAIN;
-		}
-		/* else ok - we are setting up session */
-	}
-
-	if (ses->ses_status == SES_EXITING) {
-		/* check if SMB session is bad because we are setting it up */
-		if (in_buf->Command != SMB_COM_LOGOFF_ANDX) {
-			spin_unlock(&ses->ses_lock);
-			return -EAGAIN;
-		}
-		/* else ok - we are shutting down session */
-	}
-	spin_unlock(&ses->ses_lock);
-
-	*ppmidQ = alloc_mid(in_buf, ses->server);
-	if (*ppmidQ == NULL)
-		return -ENOMEM;
-	spin_lock(&ses->server->mid_lock);
-	list_add_tail(&(*ppmidQ)->qhead, &ses->server->pending_mid_q);
-	spin_unlock(&ses->server->mid_lock);
-	return 0;
-}
-
-static int
-wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
+int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 {
 	int error;
 
@@ -737,34 +647,6 @@ wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 	return 0;
 }
 
-struct mid_q_entry *
-cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
-{
-	int rc;
-	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
-	struct mid_q_entry *mid;
-
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return ERR_PTR(-EIO);
-
-	/* enable signing if server requires it */
-	if (server->sign)
-		hdr->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
-
-	mid = alloc_mid(hdr, server);
-	if (mid == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	rc = cifs_sign_rqst(rqst, server, &mid->sequence_number);
-	if (rc) {
-		release_mid(mid);
-		return ERR_PTR(rc);
-	}
-
-	return mid;
-}
-
 /*
  * Send a SMB request and set the callback function in the mid to handle
  * the result. Caller is responsible for dealing with timeouts.
@@ -845,35 +727,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	return rc;
 }
 
-/*
- *
- * Send an SMB Request.  No response info (other than return code)
- * needs to be parsed.
- *
- * flags indicate the type of request buffer and how long to wait
- * and whether to log NT STATUS code (error) before mapping it to POSIX error
- *
- */
-int
-SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
-		 char *in_buf, int flags)
-{
-	int rc;
-	struct kvec iov[1];
-	struct kvec rsp_iov;
-	int resp_buf_type;
-
-	iov[0].iov_base = in_buf;
-	iov[0].iov_len = get_rfc1002_length(in_buf) + 4;
-	flags |= CIFS_NO_RSP_BUF;
-	rc = SendReceive2(xid, ses, iov, 1, &resp_buf_type, flags, &rsp_iov);
-	cifs_dbg(NOISY, "SendRcvNoRsp flags %d rc %d\n", flags, rc);
-
-	return rc;
-}
-
-static int
-cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
+int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 {
 	int rc = 0;
 
@@ -915,68 +769,6 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 	return rc;
 }
 
-static inline int
-send_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
-	    struct mid_q_entry *mid)
-{
-	return server->ops->send_cancel ?
-				server->ops->send_cancel(server, rqst, mid) : 0;
-}
-
-int
-cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
-		   bool log_error)
-{
-	unsigned int len = get_rfc1002_length(mid->resp_buf) + 4;
-
-	dump_smb(mid->resp_buf, min_t(u32, 92, len));
-
-	/* convert the length into a more usable form */
-	if (server->sign) {
-		struct kvec iov[2];
-		int rc = 0;
-		struct smb_rqst rqst = { .rq_iov = iov,
-					 .rq_nvec = 2 };
-
-		iov[0].iov_base = mid->resp_buf;
-		iov[0].iov_len = 4;
-		iov[1].iov_base = (char *)mid->resp_buf + 4;
-		iov[1].iov_len = len - 4;
-		/* FIXME: add code to kill session */
-		rc = cifs_verify_signature(&rqst, server,
-					   mid->sequence_number);
-		if (rc)
-			cifs_server_dbg(VFS, "SMB signature verification returned error = %d\n",
-				 rc);
-	}
-
-	/* BB special case reconnect tid and uid here? */
-	return map_and_check_smb_error(mid, log_error);
-}
-
-struct mid_q_entry *
-cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
-		   struct smb_rqst *rqst)
-{
-	int rc;
-	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
-	struct mid_q_entry *mid;
-
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return ERR_PTR(-EIO);
-
-	rc = allocate_mid(ses, hdr, &mid);
-	if (rc)
-		return ERR_PTR(rc);
-	rc = cifs_sign_rqst(rqst, ses->server, &mid->sequence_number);
-	if (rc) {
-		delete_mid(mid);
-		return ERR_PTR(rc);
-	}
-	return mid;
-}
-
 static void
 cifs_compound_callback(struct mid_q_entry *mid)
 {
@@ -1304,345 +1096,6 @@ cifs_send_recv(const unsigned int xid, struct cifs_ses *ses,
 				  rqst, resp_buf_type, resp_iov);
 }
 
-int
-SendReceive2(const unsigned int xid, struct cifs_ses *ses,
-	     struct kvec *iov, int n_vec, int *resp_buf_type /* ret */,
-	     const int flags, struct kvec *resp_iov)
-{
-	struct smb_rqst rqst;
-	struct kvec s_iov[CIFS_MAX_IOV_SIZE], *new_iov;
-	int rc;
-
-	if (n_vec + 1 > CIFS_MAX_IOV_SIZE) {
-		new_iov = kmalloc_array(n_vec + 1, sizeof(struct kvec),
-					GFP_KERNEL);
-		if (!new_iov) {
-			/* otherwise cifs_send_recv below sets resp_buf_type */
-			*resp_buf_type = CIFS_NO_BUFFER;
-			return -ENOMEM;
-		}
-	} else
-		new_iov = s_iov;
-
-	/* 1st iov is a RFC1001 length followed by the rest of the packet */
-	memcpy(new_iov + 1, iov, (sizeof(struct kvec) * n_vec));
-
-	new_iov[0].iov_base = new_iov[1].iov_base;
-	new_iov[0].iov_len = 4;
-	new_iov[1].iov_base += 4;
-	new_iov[1].iov_len -= 4;
-
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = new_iov;
-	rqst.rq_nvec = n_vec + 1;
-
-	rc = cifs_send_recv(xid, ses, ses->server,
-			    &rqst, resp_buf_type, flags, resp_iov);
-	if (n_vec + 1 > CIFS_MAX_IOV_SIZE)
-		kfree(new_iov);
-	return rc;
-}
-
-int
-SendReceive(const unsigned int xid, struct cifs_ses *ses,
-	    struct smb_hdr *in_buf, struct smb_hdr *out_buf,
-	    int *pbytes_returned, const int flags)
-{
-	int rc = 0;
-	struct mid_q_entry *midQ;
-	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
-	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
-	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
-	struct cifs_credits credits = { .value = 1, .instance = 0 };
-	struct TCP_Server_Info *server;
-
-	if (ses == NULL) {
-		cifs_dbg(VFS, "Null smb session\n");
-		return -EIO;
-	}
-	server = ses->server;
-	if (server == NULL) {
-		cifs_dbg(VFS, "Null tcp session\n");
-		return -EIO;
-	}
-
-	spin_lock(&server->srv_lock);
-	if (server->tcpStatus == CifsExiting) {
-		spin_unlock(&server->srv_lock);
-		return -ENOENT;
-	}
-	spin_unlock(&server->srv_lock);
-
-	/* Ensure that we do not send more than 50 overlapping requests
-	   to the same server. We may make this configurable later or
-	   use ses->maxReq */
-
-	if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
-		cifs_server_dbg(VFS, "Invalid length, greater than maximum frame, %d\n",
-				len);
-		return -EIO;
-	}
-
-	rc = wait_for_free_request(server, flags, &credits.instance);
-	if (rc)
-		return rc;
-
-	/* make sure that we sign in the same order that we send on this socket
-	   and avoid races inside tcp sendmsg code that could cause corruption
-	   of smb data */
-
-	cifs_server_lock(server);
-
-	rc = allocate_mid(ses, in_buf, &midQ);
-	if (rc) {
-		cifs_server_unlock(server);
-		/* Update # of requests on wire to server */
-		add_credits(server, &credits, 0);
-		return rc;
-	}
-
-	rc = cifs_sign_smb(in_buf, server, &midQ->sequence_number);
-	if (rc) {
-		cifs_server_unlock(server);
-		goto out;
-	}
-
-	midQ->mid_state = MID_REQUEST_SUBMITTED;
-
-	rc = smb_send(server, in_buf, len);
-	cifs_save_when_sent(midQ);
-
-	if (rc < 0)
-		server->sequence_number -= 2;
-
-	cifs_server_unlock(server);
-
-	if (rc < 0)
-		goto out;
-
-	rc = wait_for_response(server, midQ);
-	if (rc != 0) {
-		send_cancel(server, &rqst, midQ);
-		spin_lock(&server->mid_lock);
-		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
-		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
-			/* no longer considered to be "in-flight" */
-			midQ->callback = release_mid;
-			spin_unlock(&server->mid_lock);
-			add_credits(server, &credits, 0);
-			return rc;
-		}
-		spin_unlock(&server->mid_lock);
-	}
-
-	rc = cifs_sync_mid_result(midQ, server);
-	if (rc != 0) {
-		add_credits(server, &credits, 0);
-		return rc;
-	}
-
-	if (!midQ->resp_buf || !out_buf ||
-	    midQ->mid_state != MID_RESPONSE_READY) {
-		rc = -EIO;
-		cifs_server_dbg(VFS, "Bad MID state?\n");
-		goto out;
-	}
-
-	*pbytes_returned = get_rfc1002_length(midQ->resp_buf);
-	memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
-	rc = cifs_check_receive(midQ, server, 0);
-out:
-	delete_mid(midQ);
-	add_credits(server, &credits, 0);
-
-	return rc;
-}
-
-/* We send a LOCKINGX_CANCEL_LOCK to cause the Windows
-   blocking lock to return. */
-
-static int
-send_lock_cancel(const unsigned int xid, struct cifs_tcon *tcon,
-			struct smb_hdr *in_buf,
-			struct smb_hdr *out_buf)
-{
-	int bytes_returned;
-	struct cifs_ses *ses = tcon->ses;
-	LOCK_REQ *pSMB = (LOCK_REQ *)in_buf;
-
-	/* We just modify the current in_buf to change
-	   the type of lock from LOCKING_ANDX_SHARED_LOCK
-	   or LOCKING_ANDX_EXCLUSIVE_LOCK to
-	   LOCKING_ANDX_CANCEL_LOCK. */
-
-	pSMB->LockType = LOCKING_ANDX_CANCEL_LOCK|LOCKING_ANDX_LARGE_FILES;
-	pSMB->Timeout = 0;
-	pSMB->hdr.Mid = get_next_mid(ses->server);
-
-	return SendReceive(xid, ses, in_buf, out_buf,
-			&bytes_returned, 0);
-}
-
-int
-SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
-	    struct smb_hdr *in_buf, struct smb_hdr *out_buf,
-	    int *pbytes_returned)
-{
-	int rc = 0;
-	int rstart = 0;
-	struct mid_q_entry *midQ;
-	struct cifs_ses *ses;
-	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
-	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
-	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
-	unsigned int instance;
-	struct TCP_Server_Info *server;
-
-	if (tcon == NULL || tcon->ses == NULL) {
-		cifs_dbg(VFS, "Null smb session\n");
-		return -EIO;
-	}
-	ses = tcon->ses;
-	server = ses->server;
-
-	if (server == NULL) {
-		cifs_dbg(VFS, "Null tcp session\n");
-		return -EIO;
-	}
-
-	spin_lock(&server->srv_lock);
-	if (server->tcpStatus == CifsExiting) {
-		spin_unlock(&server->srv_lock);
-		return -ENOENT;
-	}
-	spin_unlock(&server->srv_lock);
-
-	/* Ensure that we do not send more than 50 overlapping requests
-	   to the same server. We may make this configurable later or
-	   use ses->maxReq */
-
-	if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
-		cifs_tcon_dbg(VFS, "Invalid length, greater than maximum frame, %d\n",
-			      len);
-		return -EIO;
-	}
-
-	rc = wait_for_free_request(server, CIFS_BLOCKING_OP, &instance);
-	if (rc)
-		return rc;
-
-	/* make sure that we sign in the same order that we send on this socket
-	   and avoid races inside tcp sendmsg code that could cause corruption
-	   of smb data */
-
-	cifs_server_lock(server);
-
-	rc = allocate_mid(ses, in_buf, &midQ);
-	if (rc) {
-		cifs_server_unlock(server);
-		return rc;
-	}
-
-	rc = cifs_sign_smb(in_buf, server, &midQ->sequence_number);
-	if (rc) {
-		delete_mid(midQ);
-		cifs_server_unlock(server);
-		return rc;
-	}
-
-	midQ->mid_state = MID_REQUEST_SUBMITTED;
-	rc = smb_send(server, in_buf, len);
-	cifs_save_when_sent(midQ);
-
-	if (rc < 0)
-		server->sequence_number -= 2;
-
-	cifs_server_unlock(server);
-
-	if (rc < 0) {
-		delete_mid(midQ);
-		return rc;
-	}
-
-	/* Wait for a reply - allow signals to interrupt. */
-	rc = wait_event_interruptible(server->response_q,
-		(!(midQ->mid_state == MID_REQUEST_SUBMITTED ||
-		   midQ->mid_state == MID_RESPONSE_RECEIVED)) ||
-		((server->tcpStatus != CifsGood) &&
-		 (server->tcpStatus != CifsNew)));
-
-	/* Were we interrupted by a signal ? */
-	spin_lock(&server->srv_lock);
-	if ((rc == -ERESTARTSYS) &&
-		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
-		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
-		((server->tcpStatus == CifsGood) ||
-		 (server->tcpStatus == CifsNew))) {
-		spin_unlock(&server->srv_lock);
-
-		if (in_buf->Command == SMB_COM_TRANSACTION2) {
-			/* POSIX lock. We send a NT_CANCEL SMB to cause the
-			   blocking lock to return. */
-			rc = send_cancel(server, &rqst, midQ);
-			if (rc) {
-				delete_mid(midQ);
-				return rc;
-			}
-		} else {
-			/* Windows lock. We send a LOCKINGX_CANCEL_LOCK
-			   to cause the blocking lock to return. */
-
-			rc = send_lock_cancel(xid, tcon, in_buf, out_buf);
-
-			/* If we get -ENOLCK back the lock may have
-			   already been removed. Don't exit in this case. */
-			if (rc && rc != -ENOLCK) {
-				delete_mid(midQ);
-				return rc;
-			}
-		}
-
-		rc = wait_for_response(server, midQ);
-		if (rc) {
-			send_cancel(server, &rqst, midQ);
-			spin_lock(&server->mid_lock);
-			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
-			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
-				/* no longer considered to be "in-flight" */
-				midQ->callback = release_mid;
-				spin_unlock(&server->mid_lock);
-				return rc;
-			}
-			spin_unlock(&server->mid_lock);
-		}
-
-		/* We got the response - restart system call. */
-		rstart = 1;
-		spin_lock(&server->srv_lock);
-	}
-	spin_unlock(&server->srv_lock);
-
-	rc = cifs_sync_mid_result(midQ, server);
-	if (rc != 0)
-		return rc;
-
-	/* rcvd frame is ok */
-	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_READY) {
-		rc = -EIO;
-		cifs_tcon_dbg(VFS, "Bad MID state?\n");
-		goto out;
-	}
-
-	*pbytes_returned = get_rfc1002_length(midQ->resp_buf);
-	memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
-	rc = cifs_check_receive(midQ, server, 0);
-out:
-	delete_mid(midQ);
-	if (rstart && rc == -EACCES)
-		return -ERESTARTSYS;
-	return rc;
-}
-
 /*
  * Discard any remaining data in the current SMB. To do this, we borrow the
  * current bigbuf.


