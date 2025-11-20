Return-Path: <linux-fsdevel+bounces-69241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB18C750C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98FD4362222
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9D36E9A3;
	Thu, 20 Nov 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTTmyZVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5143624D6
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652384; cv=none; b=OZBVeQV02mChaFcr+d647WhPqqrOecquu8WvoW4OE36N/VC+4zbI9LtlwWBZf2wUYQTJMRKFUBxKW7WqX2k93OGDaHMUI6iSx8LDIgMchsWobl9989V9YGMsr5W+A766JU4N+AZmQMWJGUnXHOBq6oBI4UjbOd8IjST9XHr988w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652384; c=relaxed/simple;
	bh=X2ij8rDXR2YPI2j3kat477vktWQvC4+I3bw0nkJaWqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRphjPKy1jrOMyfYjx4+qjHQHmge7gmj7PC1/7NPAius/k0QPgGVtVtl2DUWN9Fc6RPwy8vqziJLim39chldxReMXi4NT7uzfNd4sRsVHRfep8nw5Ftv9V3Yq5L7/CTzjqRxQpUm0GxXcXZKspw3jUidSpFZJq061YC/aPmleuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTTmyZVF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763652375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfz/+yRkDh8JJya1xZTKRZcFRg04/iYCjS/FxwsoVzA=;
	b=QTTmyZVFwWPjsUumt2Wv3x/AlmDR2GjV+ctUM7KGLFKtwdcZItBDblVbPFBUypoYoobtFu
	bHB8yAjxM9e2uTvsT30Ee8BT0lDRKaxT9Lk3NNkkQrnS5BcI86xkbBXsjWFiKaYxczEzF1
	mJVCP7YZKnZsP7HY2Ss/nAgE3qZ3viw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-61Fkc0DBNJO-rS6N2x9A6g-1; Thu,
 20 Nov 2025 10:26:11 -0500
X-MC-Unique: 61Fkc0DBNJO-rS6N2x9A6g-1
X-Mimecast-MFC-AGG-ID: 61Fkc0DBNJO-rS6N2x9A6g_1763652369
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01D2219539B4;
	Thu, 20 Nov 2025 15:25:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F46E1940E91;
	Thu, 20 Nov 2025 15:25:48 +0000 (UTC)
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
Subject: [PATCH v2 4/9] cifs: Remove the RFC1002 header from smb_hdr
Date: Thu, 20 Nov 2025 15:25:17 +0000
Message-ID: <20251120152524.2711660-5-dhowells@redhat.com>
In-Reply-To: <20251120152524.2711660-1-dhowells@redhat.com>
References: <20251120152524.2711660-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove the RFC1002 header from struct smb_hdr as used for SMB-1.0.  This
simplifies the SMB-1.0 code by simplifying a lot of places that have to add
or subtract 4 to work around the fact that the RFC1002 header isn't really
part of the message and the base for various offsets within the message is
from the base of the smb_hdr, not the RFC1002 header.

Further, clean up a bunch of places that require an extra kvec struct
specifically pointing to the RFC1002 header, such that kvec[0].iov_base
must be exactly 4 bytes before kvec[1].iov_base.

This allows the header preamble size stuff to be removed too.

The size of the request and response message are then handed around either
directly or by summing the size of all the iov_len members in the kvec
array for which we have a count.

Also, this simplifies and cleans up the common transmission and receive
paths for SMB1 and SMB2/3 as there no longer needs to be special handling
casing for SMB1 messages as the RFC1002 header is now generated on the fly
for SMB1 as it is for SMB2/3.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifs_debug.c    |   6 +-
 fs/smb/client/cifs_debug.h    |   2 +-
 fs/smb/client/cifsencrypt.c   |  36 +-
 fs/smb/client/cifsglob.h      |  20 +-
 fs/smb/client/cifspdu.h       |   2 +-
 fs/smb/client/cifsproto.h     |  32 +-
 fs/smb/client/cifssmb.c       | 695 +++++++++++++++++++---------------
 fs/smb/client/cifstransport.c | 128 +++----
 fs/smb/client/connect.c       |  36 +-
 fs/smb/client/misc.c          |  32 +-
 fs/smb/client/sess.c          |   8 +-
 fs/smb/client/smb1ops.c       |  21 +-
 fs/smb/client/smb2misc.c      |   3 +-
 fs/smb/client/smb2ops.c       |  11 +-
 fs/smb/client/smb2proto.h     |   2 +-
 fs/smb/client/transport.c     |  22 +-
 fs/smb/common/smb2pdu.h       |   3 -
 fs/smb/common/smbglob.h       |   1 -
 18 files changed, 540 insertions(+), 520 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 4a9bd68bfac0..fd7625cdac56 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -37,7 +37,7 @@ cifs_dump_mem(char *label, void *data, int length)
 		       data, length, true);
 }
 
-void cifs_dump_detail(void *buf, struct TCP_Server_Info *server)
+void cifs_dump_detail(void *buf, size_t buf_len, struct TCP_Server_Info *server)
 {
 #ifdef CONFIG_CIFS_DEBUG2
 	struct smb_hdr *smb = buf;
@@ -45,7 +45,7 @@ void cifs_dump_detail(void *buf, struct TCP_Server_Info *server)
 	cifs_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Flgs2: 0x%x Mid: %d Pid: %d Wct: %d\n",
 		 smb->Command, smb->Status.CifsError, smb->Flags,
 		 smb->Flags2, smb->Mid, smb->Pid, smb->WordCount);
-	if (!server->ops->check_message(buf, server->total_read, server)) {
+	if (!server->ops->check_message(buf, buf_len, server->total_read, server)) {
 		cifs_dbg(VFS, "smb buf %p len %u\n", smb,
 			 server->ops->calc_smb_size(smb));
 	}
@@ -79,7 +79,7 @@ void cifs_dump_mids(struct TCP_Server_Info *server)
 		cifs_dbg(VFS, "IsMult: %d IsEnd: %d\n",
 			 smb->multiRsp, smb->multiEnd);
 		if (smb->resp_buf) {
-			cifs_dump_detail(smb->resp_buf, server);
+			cifs_dump_detail(smb->resp_buf, smb->response_pdu_len, server);
 			cifs_dump_mem("existing buf: ", smb->resp_buf, 62);
 		}
 	}
diff --git a/fs/smb/client/cifs_debug.h b/fs/smb/client/cifs_debug.h
index ce5cfd236fdb..e60470a6f771 100644
--- a/fs/smb/client/cifs_debug.h
+++ b/fs/smb/client/cifs_debug.h
@@ -15,7 +15,7 @@
 #define pr_fmt(fmt) "CIFS: " fmt
 
 void cifs_dump_mem(char *label, void *data, int length);
-void cifs_dump_detail(void *buf, struct TCP_Server_Info *ptcp_info);
+void cifs_dump_detail(void *buf, size_t buf_len, struct TCP_Server_Info *ptcp_info);
 void cifs_dump_mids(struct TCP_Server_Info *);
 extern bool traceSMB;		/* flag which enables the function below */
 void dump_smb(void *, int);
diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 801824825ecf..1e0ac87c6686 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -91,18 +91,7 @@ int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	struct kvec *iov = rqst->rq_iov;
 	int n_vec = rqst->rq_nvec;
 
-	/* iov[0] is actual data and not the rfc1002 length for SMB2+ */
-	if (!is_smb1(server)) {
-		if (iov[0].iov_len <= 4)
-			return -EIO;
-		i = 0;
-	} else {
-		if (n_vec < 2 || iov[0].iov_len != 4)
-			return -EIO;
-		i = 1; /* skip rfc1002 length */
-	}
-
-	for (; i < n_vec; i++) {
+	for (i = 0; i < n_vec; i++) {
 		if (iov[i].iov_len == 0)
 			continue;
 		if (iov[i].iov_base == NULL) {
@@ -165,10 +154,6 @@ int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	char smb_signature[20];
 	struct smb_hdr *cifs_pdu = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return -EIO;
-
 	if ((cifs_pdu == NULL) || (server == NULL))
 		return -EINVAL;
 
@@ -211,17 +196,16 @@ int cifs_sign_smbv(struct kvec *iov, int n_vec, struct TCP_Server_Info *server,
 }
 
 /* must be called with server->srv_mutex held */
-int cifs_sign_smb(struct smb_hdr *cifs_pdu, struct TCP_Server_Info *server,
+int cifs_sign_smb(struct smb_hdr *cifs_pdu, unsigned int pdu_len,
+		  struct TCP_Server_Info *server,
 		  __u32 *pexpected_response_sequence_number)
 {
-	struct kvec iov[2];
+	struct kvec iov[1] = {
+		[0].iov_base = (char *)cifs_pdu,
+		[0].iov_len = pdu_len,
+	};
 
-	iov[0].iov_base = cifs_pdu;
-	iov[0].iov_len = 4;
-	iov[1].iov_base = (char *)cifs_pdu + 4;
-	iov[1].iov_len = be32_to_cpu(cifs_pdu->smb_buf_length);
-
-	return cifs_sign_smbv(iov, 2, server,
+	return cifs_sign_smbv(iov, ARRAY_SIZE(iov), server,
 			      pexpected_response_sequence_number);
 }
 
@@ -234,10 +218,6 @@ int cifs_verify_signature(struct smb_rqst *rqst,
 	char what_we_think_sig_should_be[20];
 	struct smb_hdr *cifs_pdu = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return -EIO;
-
 	if (cifs_pdu == NULL || server == NULL)
 		return -EINVAL;
 
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7cc3bee99fbf..53e4d7788349 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -347,12 +347,12 @@ struct smb_version_operations {
 	int (*map_error)(char *, bool);
 	/* find mid corresponding to the response message */
 	struct smb_message * (*find_mid)(struct TCP_Server_Info *, char *);
-	void (*dump_detail)(void *buf, struct TCP_Server_Info *ptcp_info);
+	void (*dump_detail)(void *buf, size_t buf_len, struct TCP_Server_Info *ptcp_info);
 	void (*clear_stats)(struct cifs_tcon *);
 	void (*print_stats)(struct seq_file *m, struct cifs_tcon *);
 	void (*dump_share_caps)(struct seq_file *, struct cifs_tcon *);
 	/* verify the message */
-	int (*check_message)(char *, unsigned int, struct TCP_Server_Info *);
+	int (*check_message)(char *, unsigned int, unsigned int, struct TCP_Server_Info *);
 	bool (*is_oplock_break)(char *, struct TCP_Server_Info *);
 	int (*handle_cancelled_mid)(struct smb_message *smb, struct TCP_Server_Info *server);
 	void (*downgrade_oplock)(struct TCP_Server_Info *server,
@@ -636,8 +636,7 @@ struct smb_version_operations {
 
 #define HEADER_SIZE(server) (server->vals->header_size)
 #define MAX_HEADER_SIZE(server) (server->vals->max_header_size)
-#define HEADER_PREAMBLE_SIZE(server) (server->vals->header_preamble_size)
-#define MID_HEADER_SIZE(server) (HEADER_SIZE(server) - 1 - HEADER_PREAMBLE_SIZE(server))
+#define MID_HEADER_SIZE(server) (HEADER_SIZE(server) - 1)
 
 /**
  * CIFS superblock mount flags (mnt_cifs_flags) to consider when
@@ -832,9 +831,9 @@ struct TCP_Server_Info {
 	char dns_dom[CIFS_MAX_DOMAINNAME_LEN + 1];
 };
 
-static inline bool is_smb1(struct TCP_Server_Info *server)
+static inline bool is_smb1(const struct TCP_Server_Info *server)
 {
-	return HEADER_PREAMBLE_SIZE(server) != 0;
+	return server->vals->protocol_id == SMB10_PROT_ID;
 }
 
 static inline void cifs_server_lock(struct TCP_Server_Info *server)
@@ -973,16 +972,16 @@ compare_mid(__u16 mid, const struct smb_hdr *smb)
  * of kvecs to handle the receive, though that should only need to be done
  * once.
  */
-#define CIFS_MAX_WSIZE ((1<<24) - 1 - sizeof(WRITE_REQ) + 4)
-#define CIFS_MAX_RSIZE ((1<<24) - sizeof(READ_RSP) + 4)
+#define CIFS_MAX_WSIZE ((1<<24) - 1 - sizeof(WRITE_REQ))
+#define CIFS_MAX_RSIZE ((1<<24) - sizeof(READ_RSP))
 
 /*
  * When the server doesn't allow large posix writes, only allow a rsize/wsize
  * of 2^17-1 minus the size of the call header. That allows for a read or
  * write up to the maximum size described by RFC1002.
  */
-#define CIFS_MAX_RFC1002_WSIZE ((1<<17) - 1 - sizeof(WRITE_REQ) + 4)
-#define CIFS_MAX_RFC1002_RSIZE ((1<<17) - 1 - sizeof(READ_RSP) + 4)
+#define CIFS_MAX_RFC1002_WSIZE ((1<<17) - 1 - sizeof(WRITE_REQ))
+#define CIFS_MAX_RFC1002_RSIZE ((1<<17) - 1 - sizeof(READ_RSP))
 
 /*
  * Windows only supports a max of 60kb reads and 65535 byte writes. Default to
@@ -1701,6 +1700,7 @@ struct smb_message {
 	struct task_struct *creator;
 	void *resp_buf;		/* pointer to received SMB header */
 	unsigned int resp_buf_size;
+	u32 response_pdu_len;
 	int mid_state;	/* wish this were enum but can not pass to wait_event */
 	int mid_rc;		/* rc for MID_RC */
 	__le16 command;		/* smb command code */
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 49f35cb3cf2e..37b23664ddf3 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -90,7 +90,7 @@
 
 /* future chained NTCreateXReadX bigger, but for time being NTCreateX biggest */
 /* among the requests (NTCreateX response is bigger with wct of 34) */
-#define MAX_CIFS_HDR_SIZE 0x58 /* 4 len + 32 hdr + (2*24 wct) + 2 bct + 2 pad */
+#define MAX_CIFS_HDR_SIZE 0x54 /* 32 hdr + (2*24 wct) + 2 bct + 2 pad */
 #define CIFS_SMALL_PATH 120 /* allows for (448-88)/3 */
 
 /* internal cifs vfs structures */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index f8c89dd3733c..8d96c4b1ed79 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -111,12 +111,11 @@ extern int compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			      const int flags, const int num_rqst,
 			      struct smb_rqst *rqst, int *resp_buf_type,
 			      struct kvec *resp_iov);
-extern int SendReceive(const unsigned int /* xid */ , struct cifs_ses *,
-			struct smb_hdr * /* input */ ,
-			struct smb_hdr * /* out */ ,
-			int * /* bytes returned */ , const int);
-extern int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
-			    char *in_buf, int flags);
+int SendReceive(const unsigned int xid, struct cifs_ses *ses,
+		struct smb_hdr *in_buf, unsigned int in_len,
+		struct smb_hdr *out_buf, int *pbytes_returned, const int flags);
+int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
+		     char *in_buf, unsigned int in_len, int flags);
 int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info *server);
 extern struct smb_message *cifs_setup_request(struct cifs_ses *,
 				struct TCP_Server_Info *,
@@ -146,11 +145,9 @@ extern int SendReceive2(const unsigned int /* xid */ , struct cifs_ses *,
 			struct kvec *, int /* nvec to send */,
 			int * /* type of buf returned */, const int flags,
 			struct kvec * /* resp vec */);
-extern int SendReceiveBlockingLock(const unsigned int xid,
-			struct cifs_tcon *ptcon,
-			struct smb_hdr *in_buf,
-			struct smb_hdr *out_buf,
-			int *bytes_returned);
+int SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
+			    struct smb_hdr *in_buf, unsigned int in_len,
+			    struct smb_hdr *out_buf, int *pbytes_returned);
 
 void smb2_query_server_interfaces(struct work_struct *work);
 void
@@ -161,7 +158,8 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 				      bool mark_smb_session);
 extern int cifs_reconnect(struct TCP_Server_Info *server,
 			  bool mark_smb_session);
-extern int checkSMB(char *buf, unsigned int len, struct TCP_Server_Info *srvr);
+int checkSMB(char *buf, unsigned int pdu_len, unsigned int len,
+	     struct TCP_Server_Info *srvr);
 extern bool is_valid_oplock_break(char *, struct TCP_Server_Info *);
 extern bool backup_cred(struct cifs_sb_info *);
 extern bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 eof,
@@ -188,9 +186,9 @@ extern int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
 extern void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
 extern int map_smb_to_linux_error(char *buf, bool logErr);
 extern int map_and_check_smb_error(struct smb_message *smb, bool logErr);
-extern void header_assemble(struct smb_hdr *, char /* command */ ,
-			    const struct cifs_tcon *, int /* length of
-			    fixed section (word count) in two byte units */);
+unsigned int header_assemble(struct smb_hdr *, char /* command */ ,
+			     const struct cifs_tcon *,
+			     int /* length of fixed section (word count) in two byte units */);
 extern int small_smb_init_no_tc(const int smb_cmd, const int wct,
 				struct cifs_ses *ses,
 				void **request_buf);
@@ -567,7 +565,9 @@ extern int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 		   __u32 *pexpected_response_sequence_number);
 extern int cifs_sign_smbv(struct kvec *iov, int n_vec, struct TCP_Server_Info *,
 			  __u32 *);
-extern int cifs_sign_smb(struct smb_hdr *, struct TCP_Server_Info *, __u32 *);
+int cifs_sign_smb(struct smb_hdr *cifs_pdu, unsigned int pdu_len,
+		  struct TCP_Server_Info *server,
+		  __u32 *pexpected_response_sequence_number);
 extern int cifs_verify_signature(struct smb_rqst *rqst,
 				 struct TCP_Server_Info *server,
 				__u32 expected_sequence_number);
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index b383046f8532..7dc87857f7ba 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -226,6 +226,7 @@ static int
 small_smb_init(int smb_command, int wct, struct cifs_tcon *tcon,
 		void **request_buf)
 {
+	unsigned int in_len;
 	int rc;
 
 	rc = cifs_reconnect_tcon(tcon, smb_command);
@@ -238,13 +239,13 @@ small_smb_init(int smb_command, int wct, struct cifs_tcon *tcon,
 		return -ENOMEM;
 	}
 
-	header_assemble((struct smb_hdr *) *request_buf, smb_command,
-			tcon, wct);
+	in_len = header_assemble((struct smb_hdr *) *request_buf, smb_command,
+				 tcon, wct);
 
 	if (tcon != NULL)
 		cifs_stats_inc(&tcon->num_smbs_sent);
 
-	return 0;
+	return in_len;
 }
 
 int
@@ -255,7 +256,7 @@ small_smb_init_no_tc(const int smb_command, const int wct,
 	struct smb_hdr *buffer;
 
 	rc = small_smb_init(smb_command, wct, NULL, request_buf);
-	if (rc)
+	if (rc < 0)
 		return rc;
 
 	buffer = (struct smb_hdr *)*request_buf;
@@ -278,6 +279,8 @@ static int
 __smb_init(int smb_command, int wct, struct cifs_tcon *tcon,
 			void **request_buf, void **response_buf)
 {
+	unsigned int in_len;
+
 	*request_buf = cifs_buf_get();
 	if (*request_buf == NULL) {
 		/* BB should we add a retry in here if not a writepage? */
@@ -290,13 +293,13 @@ __smb_init(int smb_command, int wct, struct cifs_tcon *tcon,
 	if (response_buf)
 		*response_buf = *request_buf;
 
-	header_assemble((struct smb_hdr *) *request_buf, smb_command, tcon,
-			wct);
+	in_len = header_assemble((struct smb_hdr *)*request_buf, smb_command, tcon,
+				 wct);
 
 	if (tcon != NULL)
 		cifs_stats_inc(&tcon->num_smbs_sent);
 
-	return 0;
+	return in_len;
 }
 
 /* If the return code is zero, this function must fill in request_buf pointer */
@@ -421,6 +424,7 @@ CIFSSMBNegotiate(const unsigned int xid,
 {
 	SMB_NEGOTIATE_REQ *pSMB;
 	SMB_NEGOTIATE_RSP *pSMBr;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	int i;
@@ -433,8 +437,9 @@ CIFSSMBNegotiate(const unsigned int xid,
 
 	rc = smb_init(SMB_COM_NEGOTIATE, 0, NULL /* no tcon yet */ ,
 		      (void **) &pSMB, (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->hdr.Mid = get_next_mid(server);
 	pSMB->hdr.Flags2 |= SMBFLG2_ERR_STATUS;
@@ -458,10 +463,10 @@ CIFSSMBNegotiate(const unsigned int xid,
 		memcpy(&pSMB->DialectsArray[count], protocols[i].name, len);
 		count += len;
 	}
-	inc_rfc1001_len(pSMB, count);
+	in_len += count;
 	pSMB->ByteCount = cpu_to_le16(count);
 
-	rc = SendReceive(xid, ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc != 0)
 		goto neg_err_exit;
@@ -530,6 +535,7 @@ int
 CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon)
 {
 	struct smb_hdr *smb_buffer;
+	unsigned int in_len;
 	int rc = 0;
 
 	cifs_dbg(FYI, "In tree disconnect\n");
@@ -553,10 +559,11 @@ CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon)
 
 	rc = small_smb_init(SMB_COM_TREE_DISCONNECT, 0, tcon,
 			    (void **)&smb_buffer);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
-	rc = SendReceiveNoRsp(xid, tcon->ses, (char *)smb_buffer, 0);
+	rc = SendReceiveNoRsp(xid, tcon->ses, (char *)smb_buffer, in_len, 0);
 	cifs_small_buf_release(smb_buffer);
 	if (rc)
 		cifs_dbg(FYI, "Tree disconnect failed %d\n", rc);
@@ -591,15 +598,19 @@ CIFSSMBEcho(struct TCP_Server_Info *server)
 {
 	ECHO_REQ *smb;
 	int rc = 0;
-	struct kvec iov[2];
-	struct smb_rqst rqst = { .rq_iov = iov,
-				 .rq_nvec = 2 };
+	struct kvec iov[1];
+	struct smb_rqst rqst = {
+		.rq_iov = iov,
+		.rq_nvec = ARRAY_SIZE(iov),
+	};
+	unsigned int in_len;
 
 	cifs_dbg(FYI, "In echo request\n");
 
 	rc = small_smb_init(SMB_COM_ECHO, 0, NULL, (void **)&smb);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (server->capabilities & CAP_UNICODE)
 		smb->hdr.Flags2 |= SMBFLG2_UNICODE;
@@ -610,12 +621,10 @@ CIFSSMBEcho(struct TCP_Server_Info *server)
 	put_unaligned_le16(1, &smb->EchoCount);
 	put_bcc(1, &smb->hdr);
 	smb->Data[0] = 'a';
-	inc_rfc1001_len(smb, 3);
+	in_len += 3;
 
-	iov[0].iov_len = 4;
+	iov[0].iov_len = in_len;
 	iov[0].iov_base = smb;
-	iov[1].iov_len = get_rfc1002_len(smb);
-	iov[1].iov_base = (char *)smb + 4;
 
 	rc = cifs_call_async(server, &rqst, NULL, cifs_echo_callback, NULL,
 			     server, CIFS_NON_BLOCKING | CIFS_ECHO_OP, NULL);
@@ -631,6 +640,7 @@ int
 CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses)
 {
 	LOGOFF_ANDX_REQ *pSMB;
+	unsigned int in_len;
 	int rc = 0;
 
 	cifs_dbg(FYI, "In SMBLogoff for session disconnect\n");
@@ -653,10 +663,11 @@ CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses)
 	spin_unlock(&ses->chan_lock);
 
 	rc = small_smb_init(SMB_COM_LOGOFF_ANDX, 2, NULL, (void **)&pSMB);
-	if (rc) {
+	if (rc < 0) {
 		mutex_unlock(&ses->session_mutex);
 		return rc;
 	}
+	in_len = rc;
 
 	pSMB->hdr.Mid = get_next_mid(ses->server);
 
@@ -666,7 +677,7 @@ CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses)
 	pSMB->hdr.Uid = ses->Suid;
 
 	pSMB->AndXCommand = 0xFF;
-	rc = SendReceiveNoRsp(xid, ses, (char *) pSMB, 0);
+	rc = SendReceiveNoRsp(xid, ses, (char *) pSMB, in_len, 0);
 	cifs_small_buf_release(pSMB);
 session_already_dead:
 	mutex_unlock(&ses->session_mutex);
@@ -687,6 +698,7 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 	TRANSACTION2_SPI_REQ *pSMB = NULL;
 	TRANSACTION2_SPI_RSP *pSMBr = NULL;
 	struct unlink_psx_rq *pRqD;
+	unsigned int in_len;
 	int name_len;
 	int rc = 0;
 	int bytes_returned = 0;
@@ -696,8 +708,9 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 PsxDelete:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -718,14 +731,11 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
+				InformationLevel);
 	offset = param_offset + params;
 
-	/* Setup pointer to Request Data (inode type).
-	 * Note that SMB offsets are from the beginning of SMB which is 4 bytes
-	 * in, after RFC1001 field
-	 */
-	pRqD = (struct unlink_psx_rq *)((char *)(pSMB) + offset + 4);
+	/* Setup pointer to Request Data (inode type). */
+	pRqD = (struct unlink_psx_rq *)((char *)(pSMB) + offset);
 	pRqD->type = cpu_to_le16(type);
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 	pSMB->DataOffset = cpu_to_le16(offset);
@@ -740,9 +750,9 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->InformationLevel = cpu_to_le16(SMB_POSIX_UNLINK);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc)
 		cifs_dbg(FYI, "Posix delete returned %d\n", rc);
@@ -762,6 +772,7 @@ CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 {
 	DELETE_FILE_REQ *pSMB = NULL;
 	DELETE_FILE_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	int name_len;
@@ -770,8 +781,9 @@ CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 DelFileRetry:
 	rc = smb_init(SMB_COM_DELETE, 1, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len = cifsConvertToUTF16((__le16 *) pSMB->fileName, name,
@@ -785,9 +797,9 @@ CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	pSMB->SearchAttributes =
 	    cpu_to_le16(ATTR_READONLY | ATTR_HIDDEN | ATTR_SYSTEM);
 	pSMB->BufferFormat = 0x04;
-	inc_rfc1001_len(pSMB, name_len + 1);
+	in_len += name_len + 1;
 	pSMB->ByteCount = cpu_to_le16(name_len + 1);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_deletes);
 	if (rc)
@@ -806,6 +818,7 @@ CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 {
 	DELETE_DIRECTORY_REQ *pSMB = NULL;
 	DELETE_DIRECTORY_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	int name_len;
@@ -815,8 +828,9 @@ CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 RmDirRetry:
 	rc = smb_init(SMB_COM_DELETE_DIRECTORY, 0, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len = cifsConvertToUTF16((__le16 *) pSMB->DirName, name,
@@ -829,9 +843,9 @@ CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	}
 
 	pSMB->BufferFormat = 0x04;
-	inc_rfc1001_len(pSMB, name_len + 1);
+	in_len += name_len + 1;
 	pSMB->ByteCount = cpu_to_le16(name_len + 1);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_rmdirs);
 	if (rc)
@@ -851,6 +865,7 @@ CIFSSMBMkDir(const unsigned int xid, struct inode *inode, umode_t mode,
 	int rc = 0;
 	CREATE_DIRECTORY_REQ *pSMB = NULL;
 	CREATE_DIRECTORY_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int bytes_returned;
 	int name_len;
 	int remap = cifs_remap(cifs_sb);
@@ -859,8 +874,9 @@ CIFSSMBMkDir(const unsigned int xid, struct inode *inode, umode_t mode,
 MkDirRetry:
 	rc = smb_init(SMB_COM_CREATE_DIRECTORY, 0, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len = cifsConvertToUTF16((__le16 *) pSMB->DirName, name,
@@ -873,9 +889,9 @@ CIFSSMBMkDir(const unsigned int xid, struct inode *inode, umode_t mode,
 	}
 
 	pSMB->BufferFormat = 0x04;
-	inc_rfc1001_len(pSMB, name_len + 1);
+	in_len += name_len + 1;
 	pSMB->ByteCount = cpu_to_le16(name_len + 1);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_mkdirs);
 	if (rc)
@@ -896,6 +912,7 @@ CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	TRANSACTION2_SPI_REQ *pSMB = NULL;
 	TRANSACTION2_SPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int name_len;
 	int rc = 0;
 	int bytes_returned = 0;
@@ -907,8 +924,9 @@ CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
 PsxCreat:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -930,10 +948,9 @@ CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
+				InformationLevel);
 	offset = param_offset + params;
-	/* SMB offsets are from the beginning of SMB which is 4 bytes in, after RFC1001 field */
-	pdata = (OPEN_PSX_REQ *)((char *)(pSMB) + offset + 4);
+	pdata = (OPEN_PSX_REQ *)((char *)(pSMB) + offset);
 	pdata->Level = cpu_to_le16(SMB_QUERY_FILE_UNIX_BASIC);
 	pdata->Permissions = cpu_to_le64(mode);
 	pdata->PosixOpenFlags = cpu_to_le32(posix_flags);
@@ -951,9 +968,9 @@ CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->InformationLevel = cpu_to_le16(SMB_POSIX_OPEN);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Posix create returned %d\n", rc);
@@ -969,8 +986,8 @@ CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	/* copy return information to pRetData */
-	psx_rsp = (OPEN_PSX_RSP *)((char *) &pSMBr->hdr.Protocol
-			+ le16_to_cpu(pSMBr->t2.DataOffset));
+	psx_rsp = (OPEN_PSX_RSP *)
+		((char *)pSMBr + le16_to_cpu(pSMBr->t2.DataOffset));
 
 	*pOplock = le16_to_cpu(psx_rsp->OplockFlags);
 	if (netfid)
@@ -990,9 +1007,9 @@ CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
 			pRetData->Type = cpu_to_le32(-1);
 			goto psx_create_err;
 		}
-		memcpy((char *) pRetData,
-			(char *)psx_rsp + sizeof(OPEN_PSX_RSP),
-			sizeof(FILE_UNIX_BASIC_INFO));
+		memcpy(pRetData,
+		       (char *)psx_rsp + sizeof(OPEN_PSX_RSP),
+		       sizeof(*pRetData));
 	}
 
 psx_create_err:
@@ -1079,6 +1096,7 @@ SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc;
 	OPENX_REQ *pSMB = NULL;
 	OPENX_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int bytes_returned;
 	int name_len;
 	__u16 count;
@@ -1086,8 +1104,9 @@ SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
 OldOpenRetry:
 	rc = smb_init(SMB_COM_OPEN_ANDX, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->AndXCommand = 0xFF;       /* none */
 
@@ -1130,10 +1149,10 @@ SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Sattr = cpu_to_le16(ATTR_HIDDEN | ATTR_SYSTEM | ATTR_DIRECTORY);
 	pSMB->OpenFunction = cpu_to_le16(convert_disposition(openDisposition));
 	count += name_len;
-	inc_rfc1001_len(pSMB, count);
+	in_len += count;
 
 	pSMB->ByteCount = cpu_to_le16(count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			(struct smb_hdr *)pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_opens);
 	if (rc) {
@@ -1191,12 +1210,14 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 	int desired_access = oparms->desired_access;
 	int disposition = oparms->disposition;
 	const char *path = oparms->path;
+	unsigned int in_len;
 
 openRetry:
 	rc = smb_init(SMB_COM_NT_CREATE_ANDX, 24, tcon, (void **)&req,
 		      (void **)&rsp);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	/* no commands go after this */
 	req->AndXCommand = 0xFF;
@@ -1254,10 +1275,10 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 	req->SecurityFlags = SECURITY_CONTEXT_TRACKING|SECURITY_EFFECTIVE_ONLY;
 
 	count += name_len;
-	inc_rfc1001_len(req, count);
+	in_len += count;
 
 	req->ByteCount = cpu_to_le16(count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *)req,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *)req, in_len,
 			 (struct smb_hdr *)rsp, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_opens);
 	if (rc) {
@@ -1303,7 +1324,7 @@ cifs_readv_callback(struct smb_message *smb)
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
-				 .rq_nvec = 2,
+				 .rq_nvec = 1,
 				 .rq_iter = rdata->subreq.io_iter };
 	struct cifs_credits credits = {
 		.value = 1,
@@ -1415,7 +1436,8 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	int wct;
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
-				 .rq_nvec = 2 };
+				 .rq_nvec = 1 };
+	unsigned int in_len;
 
 	cifs_dbg(FYI, "%s: offset=%llu bytes=%zu\n",
 		 __func__, rdata->subreq.start, rdata->subreq.len);
@@ -1431,8 +1453,9 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	}
 
 	rc = small_smb_init(SMB_COM_READ_ANDX, wct, tcon, (void **)&smb);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	smb->hdr.Pid = cpu_to_le16((__u16)rdata->req->pid);
 	smb->hdr.PidHigh = cpu_to_le16((__u16)(rdata->req->pid >> 16));
@@ -1456,9 +1479,7 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 
 	/* 4 for RFC1001 length + 1 for BCC */
 	rdata->iov[0].iov_base = smb;
-	rdata->iov[0].iov_len = 4;
-	rdata->iov[1].iov_base = (char *)smb + 4;
-	rdata->iov[1].iov_len = get_rfc1002_len(smb);
+	rdata->iov[0].iov_len = in_len;
 
 	trace_smb3_read_enter(rdata->rreq->debug_id,
 			      rdata->subreq.debug_index,
@@ -1492,6 +1513,7 @@ CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
 	__u16 netfid = io_parms->netfid;
 	__u64 offset = io_parms->offset;
 	struct cifs_tcon *tcon = io_parms->tcon;
+	unsigned int in_len;
 	unsigned int count = io_parms->length;
 
 	cifs_dbg(FYI, "Reading %d bytes on fid %d\n", count, netfid);
@@ -1507,8 +1529,9 @@ CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
 
 	*nbytes = 0;
 	rc = small_smb_init(SMB_COM_READ_ANDX, wct, tcon, (void **) &pSMB);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->hdr.Pid = cpu_to_le16((__u16)pid);
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(pid >> 16));
@@ -1536,7 +1559,7 @@ CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
 	}
 
 	iov[0].iov_base = (char *)pSMB;
-	iov[0].iov_len = be32_to_cpu(pSMB->hdr.smb_buf_length) + 4;
+	iov[0].iov_len = in_len;
 	rc = SendReceive2(xid, tcon->ses, iov, 1, &resp_buf_type,
 			  CIFS_LOG_ERROR, &rsp_iov);
 	cifs_small_buf_release(pSMB);
@@ -1600,7 +1623,7 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
 	__u16 netfid = io_parms->netfid;
 	__u64 offset = io_parms->offset;
 	struct cifs_tcon *tcon = io_parms->tcon;
-	unsigned int count = io_parms->length;
+	unsigned int count = io_parms->length, in_len;
 
 	*nbytes = 0;
 
@@ -1620,8 +1643,9 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
 
 	rc = smb_init(SMB_COM_WRITE_ANDX, wct, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->hdr.Pid = cpu_to_le16((__u16)pid);
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(pid >> 16));
@@ -1654,7 +1678,7 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
 	if (bytes_sent > count)
 		bytes_sent = count;
 	pSMB->DataOffset =
-		cpu_to_le16(offsetof(struct smb_com_write_req, Data) - 4);
+		cpu_to_le16(offsetof(struct smb_com_write_req, Data));
 	if (buf)
 		memcpy(pSMB->Data, buf, bytes_sent);
 	else if (count != 0) {
@@ -1669,7 +1693,7 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
 
 	pSMB->DataLengthLow = cpu_to_le16(bytes_sent & 0xFFFF);
 	pSMB->DataLengthHigh = cpu_to_le16(bytes_sent >> 16);
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 
 	if (wct == 14)
 		pSMB->ByteCount = cpu_to_le16(byte_count);
@@ -1680,7 +1704,7 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
 		pSMBW->ByteCount = cpu_to_le16(byte_count);
 	}
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_writes);
 	if (rc) {
@@ -1794,8 +1818,9 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	WRITE_REQ *req = NULL;
 	int wct;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
-	struct kvec iov[2];
+	struct kvec iov[1];
 	struct smb_rqst rqst = { };
+	unsigned int in_len;
 
 	if (tcon->ses->capabilities & CAP_LARGE_FILES) {
 		wct = 14;
@@ -1809,8 +1834,9 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	}
 
 	rc = small_smb_init(SMB_COM_WRITE_ANDX, wct, tcon, (void **)&req);
-	if (rc)
+	if (rc < 0)
 		goto async_writev_out;
+	in_len = rc;
 
 	req->hdr.Pid = cpu_to_le16((__u16)wdata->req->pid);
 	req->hdr.PidHigh = cpu_to_le16((__u16)(wdata->req->pid >> 16));
@@ -1825,16 +1851,13 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	req->Remaining = 0;
 
 	req->DataOffset =
-	    cpu_to_le16(offsetof(struct smb_com_write_req, Data) - 4);
+	    cpu_to_le16(offsetof(struct smb_com_write_req, Data));
 
-	/* 4 for RFC1001 length + 1 for BCC */
-	iov[0].iov_len = 4;
 	iov[0].iov_base = req;
-	iov[1].iov_len = get_rfc1002_len(req) + 1;
-	iov[1].iov_base = (char *)req + 4;
+	iov[0].iov_len = in_len + 1; /* +1 for BCC */
 
 	rqst.rq_iov = iov;
-	rqst.rq_nvec = 2;
+	rqst.rq_nvec = 1;
 	rqst.rq_iter = wdata->subreq.io_iter;
 
 	cifs_dbg(FYI, "async write at %llu %zu bytes\n",
@@ -1844,15 +1867,15 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	req->DataLengthHigh = cpu_to_le16(wdata->subreq.len >> 16);
 
 	if (wct == 14) {
-		inc_rfc1001_len(&req->hdr, wdata->subreq.len + 1);
+		in_len += wdata->subreq.len + 1;
 		put_bcc(wdata->subreq.len + 1, &req->hdr);
 	} else {
 		/* wct == 12 */
 		struct smb_com_writex_req *reqw =
 				(struct smb_com_writex_req *)req;
-		inc_rfc1001_len(&reqw->hdr, wdata->subreq.len + 5);
+		in_len += wdata->subreq.len + 5;
 		put_bcc(wdata->subreq.len + 5, &reqw->hdr);
-		iov[1].iov_len += 4; /* pad bigger by four bytes */
+		iov[0].iov_len += 4; /* pad bigger by four bytes */
 	}
 
 	rc = cifs_call_async(tcon->ses->server, &rqst, NULL,
@@ -1885,6 +1908,7 @@ CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
 	struct cifs_tcon *tcon = io_parms->tcon;
 	unsigned int count = io_parms->length;
 	struct kvec rsp_iov;
+	unsigned int in_len;
 
 	*nbytes = 0;
 
@@ -1900,8 +1924,9 @@ CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
 		}
 	}
 	rc = small_smb_init(SMB_COM_WRITE_ANDX, wct, tcon, (void **) &pSMB);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->hdr.Pid = cpu_to_le16((__u16)pid);
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(pid >> 16));
@@ -1920,16 +1945,16 @@ CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
 	pSMB->Remaining = 0;
 
 	pSMB->DataOffset =
-	    cpu_to_le16(offsetof(struct smb_com_write_req, Data) - 4);
+	    cpu_to_le16(offsetof(struct smb_com_write_req, Data));
 
 	pSMB->DataLengthLow = cpu_to_le16(count & 0xFFFF);
 	pSMB->DataLengthHigh = cpu_to_le16(count >> 16);
 	/* header + 1 byte pad */
-	smb_hdr_len = be32_to_cpu(pSMB->hdr.smb_buf_length) + 1;
+	smb_hdr_len = in_len + 1;
 	if (wct == 14)
-		inc_rfc1001_len(pSMB, count + 1);
+		in_len += count + 1;
 	else /* wct == 12 */
-		inc_rfc1001_len(pSMB, count + 5); /* smb data starts later */
+		in_len += count + 5; /* smb data starts later */
 	if (wct == 14)
 		pSMB->ByteCount = cpu_to_le16(count + 1);
 	else /* wct == 12 */ /* bigger pad, smaller smb hdr, keep offset ok */ {
@@ -1983,6 +2008,7 @@ int cifs_lockv(const unsigned int xid, struct cifs_tcon *tcon,
 	LOCK_REQ *pSMB = NULL;
 	struct kvec iov[2];
 	struct kvec rsp_iov;
+	unsigned int in_len;
 	int resp_buf_type;
 	__u16 count;
 
@@ -1990,8 +2016,9 @@ int cifs_lockv(const unsigned int xid, struct cifs_tcon *tcon,
 		 num_lock, num_unlock);
 
 	rc = small_smb_init(SMB_COM_LOCKING_ANDX, 8, tcon, (void **) &pSMB);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->Timeout = 0;
 	pSMB->NumberOfLocks = cpu_to_le16(num_lock);
@@ -2001,11 +2028,11 @@ int cifs_lockv(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Fid = netfid; /* netfid stays le */
 
 	count = (num_unlock + num_lock) * sizeof(LOCKING_ANDX_RANGE);
-	inc_rfc1001_len(pSMB, count);
+	in_len += count;
 	pSMB->ByteCount = cpu_to_le16(count);
 
 	iov[0].iov_base = (char *)pSMB;
-	iov[0].iov_len = be32_to_cpu(pSMB->hdr.smb_buf_length) + 4 -
+	iov[0].iov_len = in_len -
 			 (num_unlock + num_lock) * sizeof(LOCKING_ANDX_RANGE);
 	iov[1].iov_base = (char *)buf;
 	iov[1].iov_len = (num_unlock + num_lock) * sizeof(LOCKING_ANDX_RANGE);
@@ -2030,6 +2057,7 @@ CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	LOCK_REQ *pSMB = NULL;
 /*	LOCK_RSP *pSMBr = NULL; */ /* No response data other than rc to parse */
+	unsigned int in_len;
 	int bytes_returned;
 	int flags = 0;
 	__u16 count;
@@ -2038,8 +2066,9 @@ CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
 		 (int)waitFlag, numLock);
 	rc = small_smb_init(SMB_COM_LOCKING_ANDX, 8, tcon, (void **) &pSMB);
 
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (lockType == LOCKING_ANDX_OPLOCK_RELEASE) {
 		/* no response expected */
@@ -2071,14 +2100,14 @@ CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
 		/* oplock break */
 		count = 0;
 	}
-	inc_rfc1001_len(pSMB, count);
+	in_len += count;
 	pSMB->ByteCount = cpu_to_le16(count);
 
 	if (waitFlag)
-		rc = SendReceiveBlockingLock(xid, tcon, (struct smb_hdr *) pSMB,
+		rc = SendReceiveBlockingLock(xid, tcon, (struct smb_hdr *) pSMB, in_len,
 			(struct smb_hdr *) pSMB, &bytes_returned);
 	else
-		rc = SendReceiveNoRsp(xid, tcon->ses, (char *)pSMB, flags);
+		rc = SendReceiveNoRsp(xid, tcon->ses, (char *)pSMB, in_len, flags);
 	cifs_small_buf_release(pSMB);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_locks);
 	if (rc)
@@ -2099,6 +2128,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 	struct smb_com_transaction2_sfi_req *pSMB  = NULL;
 	struct smb_com_transaction2_sfi_rsp *pSMBr = NULL;
 	struct cifs_posix_lock *parm_data;
+	unsigned int in_len;
 	int rc = 0;
 	int timeout = 0;
 	int bytes_returned = 0;
@@ -2110,9 +2140,9 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 	cifs_dbg(FYI, "Posix Lock\n");
 
 	rc = small_smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB);
-
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMBr = (struct smb_com_transaction2_sfi_rsp *)pSMB;
 
@@ -2121,7 +2151,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Reserved = 0;
 	pSMB->Flags = 0;
 	pSMB->Reserved2 = 0;
-	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid) - 4;
+	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid);
 	offset = param_offset + params;
 
 	count = sizeof(struct cifs_posix_lock);
@@ -2139,9 +2169,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->TotalDataCount = pSMB->DataCount;
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
-	/* SMB offsets are from the beginning of SMB which is 4 bytes in, after RFC1001 field */
-	parm_data = (struct cifs_posix_lock *)
-			(((char *)pSMB) + offset + 4);
+	parm_data = (struct cifs_posix_lock *)(((char *)pSMB) + offset);
 
 	parm_data->lock_type = cpu_to_le16(lock_type);
 	if (waitFlag) {
@@ -2159,14 +2187,14 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Fid = smb_file_id;
 	pSMB->InformationLevel = cpu_to_le16(SMB_SET_POSIX_LOCK);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 	if (waitFlag) {
-		rc = SendReceiveBlockingLock(xid, tcon, (struct smb_hdr *) pSMB,
+		rc = SendReceiveBlockingLock(xid, tcon, (struct smb_hdr *) pSMB, in_len,
 			(struct smb_hdr *) pSMBr, &bytes_returned);
 	} else {
 		iov[0].iov_base = (char *)pSMB;
-		iov[0].iov_len = be32_to_cpu(pSMB->hdr.smb_buf_length) + 4;
+		iov[0].iov_len = in_len;
 		rc = SendReceive2(xid, tcon->ses, iov, 1 /* num iovecs */,
 				&resp_buf_type, timeout, &rsp_iov);
 		pSMBr = (struct smb_com_transaction2_sfi_rsp *)rsp_iov.iov_base;
@@ -2226,19 +2254,22 @@ CIFSSMBClose(const unsigned int xid, struct cifs_tcon *tcon, int smb_file_id)
 {
 	int rc = 0;
 	CLOSE_REQ *pSMB = NULL;
+	unsigned int in_len;
+
 	cifs_dbg(FYI, "In CIFSSMBClose\n");
 
 /* do not retry on dead session on close */
 	rc = small_smb_init(SMB_COM_CLOSE, 3, tcon, (void **) &pSMB);
 	if (rc == -EAGAIN)
 		return 0;
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->FileID = (__u16) smb_file_id;
 	pSMB->LastWriteTime = 0xFFFFFFFF;
 	pSMB->ByteCount = 0;
-	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, 0);
+	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, in_len, 0);
 	cifs_small_buf_release(pSMB);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_closes);
 	if (rc) {
@@ -2260,15 +2291,18 @@ CIFSSMBFlush(const unsigned int xid, struct cifs_tcon *tcon, int smb_file_id)
 {
 	int rc = 0;
 	FLUSH_REQ *pSMB = NULL;
+	unsigned int in_len;
+
 	cifs_dbg(FYI, "In CIFSSMBFlush\n");
 
 	rc = small_smb_init(SMB_COM_FLUSH, 1, tcon, (void **) &pSMB);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->FileID = (__u16) smb_file_id;
 	pSMB->ByteCount = 0;
-	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, 0);
+	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, in_len, 0);
 	cifs_small_buf_release(pSMB);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_flushes);
 	if (rc)
@@ -2285,6 +2319,7 @@ int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	RENAME_REQ *pSMB = NULL;
 	RENAME_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int bytes_returned;
 	int name_len, name_len2;
 	__u16 count;
@@ -2294,8 +2329,9 @@ int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
 renameRetry:
 	rc = smb_init(SMB_COM_RENAME, 1, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->BufferFormat = 0x04;
 	pSMB->SearchAttributes =
@@ -2325,10 +2361,10 @@ int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	count = 1 /* 1st signature byte */  + name_len + name_len2;
-	inc_rfc1001_len(pSMB, count);
+	in_len += count;
 	pSMB->ByteCount = cpu_to_le16(count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_renames);
 	if (rc)
@@ -2349,6 +2385,7 @@ int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *pTcon,
 	struct smb_com_transaction2_sfi_req *pSMB  = NULL;
 	struct smb_com_transaction2_sfi_rsp *pSMBr = NULL;
 	struct set_file_rename *rename_info;
+	unsigned int in_len;
 	char *data_offset;
 	char dummy_string[30];
 	int rc = 0;
@@ -2359,8 +2396,9 @@ int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *pTcon,
 	cifs_dbg(FYI, "Rename to File by handle\n");
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, pTcon, (void **) &pSMB,
 			(void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 6;
 	pSMB->MaxSetupCount = 0;
@@ -2368,11 +2406,10 @@ int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *pTcon,
 	pSMB->Flags = 0;
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
-	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid) - 4;
+	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid);
 	offset = param_offset + params;
 
-	/* SMB offsets are from the beginning of SMB which is 4 bytes in, after RFC1001 field */
-	data_offset = (char *)(pSMB) + offset + 4;
+	data_offset = (char *)(pSMB) + offset;
 	rename_info = (struct set_file_rename *) data_offset;
 	pSMB->MaxParameterCount = cpu_to_le16(2);
 	pSMB->MaxDataCount = cpu_to_le16(1000); /* BB find max SMB from sess */
@@ -2408,9 +2445,9 @@ int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *pTcon,
 	pSMB->InformationLevel =
 		cpu_to_le16(SMB_SET_FILE_RENAME_INFORMATION);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, pTcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, pTcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&pTcon->stats.cifs_stats.num_t2renames);
 	if (rc)
@@ -2432,6 +2469,7 @@ CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	TRANSACTION2_SPI_REQ *pSMB = NULL;
 	TRANSACTION2_SPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	char *data_offset;
 	int name_len;
 	int name_len_target;
@@ -2443,8 +2481,9 @@ CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
 createSymLinkRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -2464,11 +2503,10 @@ CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
+				InformationLevel);
 	offset = param_offset + params;
 
-	/* SMB offsets are from the beginning of SMB which is 4 bytes in, after RFC1001 field */
-	data_offset = (char *)pSMB + offset + 4;
+	data_offset = (char *)pSMB + offset;
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len_target =
 		    cifsConvertToUTF16((__le16 *) data_offset, toName,
@@ -2495,9 +2533,9 @@ CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->DataOffset = cpu_to_le16(offset);
 	pSMB->InformationLevel = cpu_to_le16(SMB_SET_FILE_UNIX_LINK);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_symlinks);
 	if (rc)
@@ -2519,6 +2557,7 @@ CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	TRANSACTION2_SPI_REQ *pSMB = NULL;
 	TRANSACTION2_SPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	char *data_offset;
 	int name_len;
 	int name_len_target;
@@ -2530,8 +2569,9 @@ CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
 createHardLinkRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len = cifsConvertToUTF16((__le16 *) pSMB->FileName, toName,
@@ -2549,11 +2589,10 @@ CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
+				InformationLevel);
 	offset = param_offset + params;
 
-	/* SMB offsets are from the beginning of SMB which is 4 bytes in, after RFC1001 field */
-	data_offset = (char *)pSMB + offset + 4;
+	data_offset = (char *)pSMB + offset;
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len_target =
 		    cifsConvertToUTF16((__le16 *) data_offset, fromName,
@@ -2579,9 +2618,9 @@ CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->DataOffset = cpu_to_le16(offset);
 	pSMB->InformationLevel = cpu_to_le16(SMB_SET_FILE_UNIX_HLINK);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_hardlinks);
 	if (rc)
@@ -2604,6 +2643,7 @@ int CIFSCreateHardLink(const unsigned int xid,
 	int rc = 0;
 	NT_RENAME_REQ *pSMB = NULL;
 	RENAME_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int bytes_returned;
 	int name_len, name_len2;
 	__u16 count;
@@ -2614,8 +2654,9 @@ int CIFSCreateHardLink(const unsigned int xid,
 
 	rc = smb_init(SMB_COM_NT_RENAME, 4, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->SearchAttributes =
 	    cpu_to_le16(ATTR_READONLY | ATTR_HIDDEN | ATTR_SYSTEM |
@@ -2649,10 +2690,10 @@ int CIFSCreateHardLink(const unsigned int xid,
 	}
 
 	count = 1 /* string type byte */  + name_len + name_len2;
-	inc_rfc1001_len(pSMB, count);
+	in_len += count;
 	pSMB->ByteCount = cpu_to_le16(count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_hardlinks);
 	if (rc)
@@ -2673,6 +2714,7 @@ CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
 /* SMB_QUERY_FILE_UNIX_LINK */
 	TRANSACTION2_QPI_REQ *pSMB = NULL;
 	TRANSACTION2_QPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	int name_len;
@@ -2684,8 +2726,9 @@ CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
 querySymLinkRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -2708,7 +2751,7 @@ CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-	struct smb_com_transaction2_qpi_req, InformationLevel) - 4);
+		struct smb_com_transaction2_qpi_req, InformationLevel));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
@@ -2719,10 +2762,10 @@ CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_FILE_UNIX_LINK);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in QuerySymLinkInfo = %d\n", rc);
@@ -2770,6 +2813,7 @@ int cifs_query_reparse_point(const unsigned int xid,
 	TRANSACT_IOCTL_REQ *io_req = NULL;
 	TRANSACT_IOCTL_RSP *io_rsp = NULL;
 	struct cifs_fid fid;
+	unsigned int in_len;
 	__u32 data_offset, data_count, len;
 	__u8 *start, *end;
 	int io_rsp_len;
@@ -2801,8 +2845,9 @@ int cifs_query_reparse_point(const unsigned int xid,
 
 	rc = smb_init(SMB_COM_NT_TRANSACT, 23, tcon,
 		      (void **)&io_req, (void **)&io_rsp);
-	if (rc)
+	if (rc < 0)
 		goto error;
+	in_len = rc;
 
 	io_req->TotalParameterCount = 0;
 	io_req->TotalDataCount = 0;
@@ -2823,7 +2868,7 @@ int cifs_query_reparse_point(const unsigned int xid,
 	io_req->Fid = fid.netfid;
 	io_req->ByteCount = 0;
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *)io_req,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *)io_req, in_len,
 			 (struct smb_hdr *)io_rsp, &io_rsp_len, 0);
 	if (rc)
 		goto error;
@@ -2897,7 +2942,7 @@ struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
 	struct kvec in_iov[2];
 	struct kvec out_iov;
 	struct cifs_fid fid;
-	int io_req_len;
+	unsigned int in_len;
 	int oplock = 0;
 	int buf_type = 0;
 	int rc;
@@ -2953,12 +2998,10 @@ struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
 #endif
 
 	rc = smb_init(SMB_COM_NT_TRANSACT, 23, tcon, (void **)&io_req, NULL);
-	if (rc)
+	if (rc < 0)
 		goto out_close;
-
-	inc_rfc1001_len(io_req, sizeof(io_req->Pad));
-
-	io_req_len = be32_to_cpu(io_req->hdr.smb_buf_length) + sizeof(io_req->hdr.smb_buf_length);
+	in_len = rc;
+	in_len += sizeof(io_req->Pad);
 
 	/* NT IOCTL response contains one-word long output setup buffer with size of output data. */
 	io_req->MaxSetupCount = 1;
@@ -2972,8 +3015,7 @@ struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
 	io_req->ParameterCount = io_req->TotalParameterCount;
 	io_req->ParameterOffset = cpu_to_le32(0);
 	io_req->DataCount = io_req->TotalDataCount;
-	io_req->DataOffset = cpu_to_le32(offsetof(typeof(*io_req), Data) -
-					 sizeof(io_req->hdr.smb_buf_length));
+	io_req->DataOffset = cpu_to_le32(offsetof(typeof(*io_req), Data));
 	io_req->SetupCount = 4;
 	io_req->SubCommand = cpu_to_le16(NT_TRANSACT_IOCTL);
 	io_req->FunctionCode = cpu_to_le32(FSCTL_SET_REPARSE_POINT);
@@ -2982,10 +3024,8 @@ struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
 	io_req->IsRootFlag = 0;
 	io_req->ByteCount = cpu_to_le16(le32_to_cpu(io_req->DataCount) + sizeof(io_req->Pad));
 
-	inc_rfc1001_len(io_req, reparse_iov->iov_len);
-
 	in_iov[0].iov_base = (char *)io_req;
-	in_iov[0].iov_len = io_req_len;
+	in_iov[0].iov_len = in_len;
 	in_iov[1] = *reparse_iov;
 	rc = SendReceive2(xid, tcon->ses, in_iov, ARRAY_SIZE(in_iov), &buf_type,
 			  CIFS_NO_RSP_BUF, &out_iov);
@@ -3017,12 +3057,14 @@ CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
 	int bytes_returned;
 	struct smb_com_transaction_compr_ioctl_req *pSMB;
 	struct smb_com_transaction_ioctl_rsp *pSMBr;
+	unsigned int in_len;
 
 	cifs_dbg(FYI, "Set compression for %u\n", fid);
 	rc = smb_init(SMB_COM_NT_TRANSACT, 23, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->compression_state = cpu_to_le16(COMPRESSION_FORMAT_DEFAULT);
 
@@ -3036,7 +3078,7 @@ CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->DataCount = cpu_to_le32(2);
 	pSMB->DataOffset =
 		cpu_to_le32(offsetof(struct smb_com_transaction_compr_ioctl_req,
-				compression_state) - 4);  /* 84 */
+				     compression_state));  /* 84 */
 	pSMB->SetupCount = 4;
 	pSMB->SubCommand = cpu_to_le16(NT_TRANSACT_IOCTL);
 	pSMB->ParameterCount = 0;
@@ -3046,9 +3088,9 @@ CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Fid = fid; /* file handle always le */
 	/* 3 byte pad, followed by 2 byte compress state */
 	pSMB->ByteCount = cpu_to_le16(5);
-	inc_rfc1001_len(pSMB, 5);
+	in_len += 5;
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc)
 		cifs_dbg(FYI, "Send error in SetCompression = %d\n", rc);
@@ -3246,6 +3288,7 @@ int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 /* SMB_QUERY_POSIX_ACL */
 	TRANSACTION2_QPI_REQ *pSMB = NULL;
 	TRANSACTION2_QPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	int name_len;
@@ -3256,8 +3299,9 @@ int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 queryAclRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		(void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -3284,7 +3328,7 @@ int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Reserved2 = 0;
 	pSMB->ParameterOffset = cpu_to_le16(
 		offsetof(struct smb_com_transaction2_qpi_req,
-			 InformationLevel) - 4);
+			 InformationLevel));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
@@ -3295,10 +3339,10 @@ int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_POSIX_ACL);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 		(struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_acl_get);
 	if (rc) {
@@ -3336,6 +3380,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	struct smb_com_transaction2_spi_req *pSMB = NULL;
 	struct smb_com_transaction2_spi_rsp *pSMBr = NULL;
+	unsigned int in_len;
 	char *parm_data;
 	int name_len;
 	int rc = 0;
@@ -3346,8 +3391,9 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 setAclRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
 			cifsConvertToUTF16((__le16 *) pSMB->FileName, fileName,
@@ -3367,9 +3413,9 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
+				InformationLevel);
 	offset = param_offset + params;
-	parm_data = ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) + offset;
+	parm_data = ((char *)pSMB) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 
 	/* convert to on the wire format for POSIX ACL */
@@ -3390,9 +3436,9 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ParameterCount = cpu_to_le16(params);
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc)
 		cifs_dbg(FYI, "Set POSIX ACL returned %d\n", rc);
@@ -3428,6 +3474,7 @@ CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	struct smb_t2_qfi_req *pSMB = NULL;
 	struct smb_t2_qfi_rsp *pSMBr = NULL;
+	unsigned int in_len;
 	int bytes_returned;
 	__u16 params, byte_count;
 
@@ -3438,8 +3485,9 @@ CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
 GetExtAttrRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 2 /* level */ + 2 /* fid */;
 	pSMB->t2.TotalDataCount = 0;
@@ -3452,7 +3500,7 @@ CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->t2.Timeout = 0;
 	pSMB->t2.Reserved2 = 0;
 	pSMB->t2.ParameterOffset = cpu_to_le16(offsetof(struct smb_t2_qfi_req,
-					       Fid) - 4);
+					       Fid));
 	pSMB->t2.DataCount = 0;
 	pSMB->t2.DataOffset = 0;
 	pSMB->t2.SetupCount = 1;
@@ -3464,10 +3512,10 @@ CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_ATTR_FLAGS);
 	pSMB->Pad = 0;
 	pSMB->Fid = netfid;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->t2.ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "error %d in GetExtAttr\n", rc);
@@ -3520,11 +3568,13 @@ smb_init_nttransact(const __u16 sub_command, const int setup_count,
 	int rc;
 	__u32 temp_offset;
 	struct smb_com_ntransact_req *pSMB;
+	unsigned int in_len;
 
 	rc = small_smb_init(SMB_COM_NT_TRANSACT, 19 + setup_count, tcon,
 				(void **)&pSMB);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 	*ret_buf = (void *)pSMB;
 	pSMB->Reserved = 0;
 	pSMB->TotalParameterCount = cpu_to_le32(parm_len);
@@ -3533,12 +3583,12 @@ smb_init_nttransact(const __u16 sub_command, const int setup_count,
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->DataCount  = pSMB->TotalDataCount;
 	temp_offset = offsetof(struct smb_com_ntransact_req, Parms) +
-			(setup_count * 2) - 4 /* for rfc1001 length itself */;
+		(setup_count * 2);
 	pSMB->ParameterOffset = cpu_to_le32(temp_offset);
 	pSMB->DataOffset = cpu_to_le32(temp_offset + parm_len);
 	pSMB->SetupCount = setup_count; /* no need to le convert byte fields */
 	pSMB->SubCommand = cpu_to_le16(sub_command);
-	return 0;
+	return in_len;
 }
 
 static int
@@ -3604,6 +3654,7 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 	QUERY_SEC_DESC_REQ *pSMB;
 	struct kvec iov[1];
 	struct kvec rsp_iov;
+	unsigned int in_len;
 
 	cifs_dbg(FYI, "GetCifsACL\n");
 
@@ -3612,8 +3663,9 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 
 	rc = smb_init_nttransact(NT_TRANSACT_QUERY_SECURITY_DESC, 0,
 			8 /* parm len */, tcon, (void **) &pSMB);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->MaxParameterCount = cpu_to_le32(4);
 	/* BB TEST with big acls that might need to be e.g. larger than 16K */
@@ -3621,9 +3673,9 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 	pSMB->Fid = fid; /* file handle always le */
 	pSMB->AclFlags = cpu_to_le32(info);
 	pSMB->ByteCount = cpu_to_le16(11); /* 3 bytes pad + 8 bytes parm */
-	inc_rfc1001_len(pSMB, 11);
+	in_len += 11;
 	iov[0].iov_base = (char *)pSMB;
-	iov[0].iov_len = be32_to_cpu(pSMB->hdr.smb_buf_length) + 4;
+	iov[0].iov_len = in_len;
 
 	rc = SendReceive2(xid, tcon->ses, iov, 1 /* num iovec */, &buf_type,
 			  0, &rsp_iov);
@@ -3692,18 +3744,20 @@ CIFSSMBSetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 	int rc = 0;
 	int bytes_returned = 0;
 	SET_SEC_DESC_REQ *pSMB = NULL;
+	unsigned int in_len;
 	void *pSMBr;
 
 setCifsAclRetry:
 	rc = smb_init(SMB_COM_NT_TRANSACT, 19, tcon, (void **) &pSMB, &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->MaxSetupCount = 0;
 	pSMB->Reserved = 0;
 
 	param_count = 8;
-	param_offset = offsetof(struct smb_com_transaction_ssec_req, Fid) - 4;
+	param_offset = offsetof(struct smb_com_transaction_ssec_req, Fid);
 	data_count = acllen;
 	data_offset = param_offset + param_count;
 	byte_count = 3 /* pad */  + param_count;
@@ -3725,13 +3779,12 @@ CIFSSMBSetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 	pSMB->AclFlags = cpu_to_le32(aclflag);
 
 	if (pntsd && acllen) {
-		memcpy((char *)pSMBr + offsetof(struct smb_hdr, Protocol) +
-				data_offset, pntsd, acllen);
-		inc_rfc1001_len(pSMB, byte_count + data_count);
+		memcpy((char *)pSMBr + data_offset, pntsd, acllen);
+		in_len += byte_count + data_count;
 	} else
-		inc_rfc1001_len(pSMB, byte_count);
+		in_len += byte_count;
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 		(struct smb_hdr *) pSMBr, &bytes_returned, 0);
 
 	cifs_dbg(FYI, "SetCIFSACL bytes_returned: %d, rc: %d\n",
@@ -3756,6 +3809,7 @@ SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	QUERY_INFORMATION_REQ *pSMB;
 	QUERY_INFORMATION_RSP *pSMBr;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	int name_len;
@@ -3764,8 +3818,9 @@ SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
 QInfRetry:
 	rc = smb_init(SMB_COM_QUERY_INFORMATION, 0, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -3779,10 +3834,10 @@ SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 	pSMB->BufferFormat = 0x04;
 	name_len++; /* account for buffer type byte */
-	inc_rfc1001_len(pSMB, (__u16)name_len);
+	in_len += name_len;
 	pSMB->ByteCount = cpu_to_le16(name_len);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in QueryInfo = %d\n", rc);
@@ -3821,6 +3876,7 @@ CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	struct smb_t2_qfi_req *pSMB = NULL;
 	struct smb_t2_qfi_rsp *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	__u16 params, byte_count;
@@ -3828,8 +3884,9 @@ CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 QFileInfoRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 2 /* level */ + 2 /* fid */;
 	pSMB->t2.TotalDataCount = 0;
@@ -3842,7 +3899,7 @@ CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->t2.Timeout = 0;
 	pSMB->t2.Reserved2 = 0;
 	pSMB->t2.ParameterOffset = cpu_to_le16(offsetof(struct smb_t2_qfi_req,
-					       Fid) - 4);
+					       Fid));
 	pSMB->t2.DataCount = 0;
 	pSMB->t2.DataOffset = 0;
 	pSMB->t2.SetupCount = 1;
@@ -3854,10 +3911,10 @@ CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_FILE_ALL_INFO);
 	pSMB->Pad = 0;
 	pSMB->Fid = netfid;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->t2.ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in QFileInfo = %d\n", rc);
@@ -3892,6 +3949,7 @@ CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	/* level 263 SMB_QUERY_FILE_ALL_INFO */
 	TRANSACTION2_QPI_REQ *pSMB = NULL;
 	TRANSACTION2_QPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	int name_len;
@@ -3901,8 +3959,9 @@ CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 QPathInfoRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -3925,7 +3984,7 @@ CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-	struct smb_com_transaction2_qpi_req, InformationLevel) - 4);
+		struct smb_com_transaction2_qpi_req, InformationLevel));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
@@ -3939,10 +3998,10 @@ CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	else
 		pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_FILE_ALL_INFO);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in QPathInfo = %d\n", rc);
@@ -3988,6 +4047,7 @@ CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	struct smb_t2_qfi_req *pSMB = NULL;
 	struct smb_t2_qfi_rsp *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	__u16 params, byte_count;
@@ -3995,8 +4055,9 @@ CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 UnixQFileInfoRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 2 /* level */ + 2 /* fid */;
 	pSMB->t2.TotalDataCount = 0;
@@ -4009,7 +4070,7 @@ CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->t2.Timeout = 0;
 	pSMB->t2.Reserved2 = 0;
 	pSMB->t2.ParameterOffset = cpu_to_le16(offsetof(struct smb_t2_qfi_req,
-					       Fid) - 4);
+					       Fid));
 	pSMB->t2.DataCount = 0;
 	pSMB->t2.DataOffset = 0;
 	pSMB->t2.SetupCount = 1;
@@ -4021,10 +4082,10 @@ CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_FILE_UNIX_BASIC);
 	pSMB->Pad = 0;
 	pSMB->Fid = netfid;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->t2.ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in UnixQFileInfo = %d\n", rc);
@@ -4059,6 +4120,7 @@ CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 /* SMB_QUERY_FILE_UNIX_BASIC */
 	TRANSACTION2_QPI_REQ *pSMB = NULL;
 	TRANSACTION2_QPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned = 0;
 	int name_len;
@@ -4068,8 +4130,9 @@ CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 UnixQPathInfoRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -4092,7 +4155,7 @@ CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-	struct smb_com_transaction2_qpi_req, InformationLevel) - 4);
+		struct smb_com_transaction2_qpi_req, InformationLevel));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
@@ -4103,10 +4166,10 @@ CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_FILE_UNIX_BASIC);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in UnixQPathInfo = %d\n", rc);
@@ -4143,7 +4206,7 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 	TRANSACTION2_FFIRST_RSP *pSMBr = NULL;
 	T2_FFIRST_RSP_PARMS *parms;
 	struct nls_table *nls_codepage;
-	unsigned int lnoff;
+	unsigned int in_len, lnoff;
 	__u16 params, byte_count;
 	int bytes_returned = 0;
 	int name_len, remap;
@@ -4154,8 +4217,9 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 findFirstRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	nls_codepage = cifs_sb->local_nls;
 	remap = cifs_remap(cifs_sb);
@@ -4215,8 +4279,7 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->TotalParameterCount = cpu_to_le16(params);
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->ParameterOffset = cpu_to_le16(
-	      offsetof(struct smb_com_transaction2_ffirst_req, SearchAttributes)
-		- 4);
+	      offsetof(struct smb_com_transaction2_ffirst_req, SearchAttributes));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;	/* one byte, no need to make endian neutral */
@@ -4231,10 +4294,10 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* BB what should we set StorageType to? Does it matter? BB */
 	pSMB->SearchStorageType = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_ffirst);
 
@@ -4293,7 +4356,7 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 	TRANSACTION2_FNEXT_REQ *pSMB = NULL;
 	TRANSACTION2_FNEXT_RSP *pSMBr = NULL;
 	T2_FNEXT_RSP_PARMS *parms;
-	unsigned int name_len;
+	unsigned int name_len, in_len;
 	unsigned int lnoff;
 	__u16 params, byte_count;
 	char *response_data;
@@ -4307,8 +4370,9 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		(void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 14; /* includes 2 bytes of null string, converted to LE below*/
 	byte_count = 0;
@@ -4321,7 +4385,7 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	pSMB->ParameterOffset =  cpu_to_le16(
-	      offsetof(struct smb_com_transaction2_fnext_req,SearchHandle) - 4);
+	      offsetof(struct smb_com_transaction2_fnext_req,SearchHandle));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
@@ -4349,10 +4413,10 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 	byte_count = params + 1 /* pad */ ;
 	pSMB->TotalParameterCount = cpu_to_le16(params);
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			(struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_fnext);
 
@@ -4418,6 +4482,7 @@ CIFSFindClose(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	int rc = 0;
 	FINDCLOSE_REQ *pSMB = NULL;
+	unsigned int in_len;
 
 	cifs_dbg(FYI, "In CIFSSMBFindClose\n");
 	rc = small_smb_init(SMB_COM_FIND_CLOSE2, 1, tcon, (void **)&pSMB);
@@ -4426,12 +4491,13 @@ CIFSFindClose(const unsigned int xid, struct cifs_tcon *tcon,
 		as file handle has been closed */
 	if (rc == -EAGAIN)
 		return 0;
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->FileID = searchHandle;
 	pSMB->ByteCount = 0;
-	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, 0);
+	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, in_len, 0);
 	cifs_small_buf_release(pSMB);
 	if (rc)
 		cifs_dbg(VFS, "Send error in FindClose = %d\n", rc);
@@ -4453,6 +4519,7 @@ CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	TRANSACTION2_QPI_REQ *pSMB = NULL;
 	TRANSACTION2_QPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int name_len, bytes_returned;
 	__u16 params, byte_count;
 
@@ -4463,8 +4530,9 @@ CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
 GetInodeNumberRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -4488,7 +4556,7 @@ CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-		struct smb_com_transaction2_qpi_req, InformationLevel) - 4);
+		struct smb_com_transaction2_qpi_req, InformationLevel));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
@@ -4499,10 +4567,10 @@ CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_FILE_INTERNAL_INFO);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 		(struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "error %d in QueryInternalInfo\n", rc);
@@ -4545,6 +4613,7 @@ CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
 /* TRANS2_GET_DFS_REFERRAL */
 	TRANSACTION2_GET_DFS_REFER_REQ *pSMB = NULL;
 	TRANSACTION2_GET_DFS_REFER_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	int name_len;
@@ -4564,8 +4633,9 @@ CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
 	 */
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, ses->tcon_ipc,
 		      (void **)&pSMB, (void **)&pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	/* server pointer checked in called function,
 	but should never be null here anyway */
@@ -4607,7 +4677,7 @@ CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-	  struct smb_com_transaction2_get_dfs_refer_req, MaxReferralLevel) - 4);
+	  struct smb_com_transaction2_get_dfs_refer_req, MaxReferralLevel));
 	pSMB->SetupCount = 1;
 	pSMB->Reserved3 = 0;
 	pSMB->SubCommand = cpu_to_le16(TRANS2_GET_DFS_REFERRAL);
@@ -4615,10 +4685,10 @@ CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
 	pSMB->ParameterCount = cpu_to_le16(params);
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->MaxReferralLevel = cpu_to_le16(3);
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in GetDFSRefer = %d\n", rc);
@@ -4660,6 +4730,7 @@ SMBOldQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	TRANSACTION2_QFSI_REQ *pSMB = NULL;
 	TRANSACTION2_QFSI_RSP *pSMBr = NULL;
 	FILE_SYSTEM_ALLOC_INFO *response_data;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count;
@@ -4668,8 +4739,9 @@ SMBOldQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
 oldQFSInfoRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		(void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 2;     /* level */
 	pSMB->TotalDataCount = 0;
@@ -4684,17 +4756,17 @@ SMBOldQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->TotalParameterCount = cpu_to_le16(params);
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-	struct smb_com_transaction2_qfsi_req, InformationLevel) - 4);
+		struct smb_com_transaction2_qfsi_req, InformationLevel));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
 	pSMB->Reserved3 = 0;
 	pSMB->SubCommand = cpu_to_le16(TRANS2_QUERY_FS_INFORMATION);
 	pSMB->InformationLevel = cpu_to_le16(SMB_INFO_ALLOCATION);
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 		(struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in QFSInfo = %d\n", rc);
@@ -4747,6 +4819,7 @@ CIFSSMBQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	TRANSACTION2_QFSI_REQ *pSMB = NULL;
 	TRANSACTION2_QFSI_RSP *pSMBr = NULL;
 	FILE_SYSTEM_SIZE_INFO *response_data;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count;
@@ -4755,8 +4828,9 @@ CIFSSMBQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
 QFSInfoRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 2;	/* level */
 	pSMB->TotalDataCount = 0;
@@ -4771,17 +4845,17 @@ CIFSSMBQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->TotalParameterCount = cpu_to_le16(params);
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-		struct smb_com_transaction2_qfsi_req, InformationLevel) - 4);
+		struct smb_com_transaction2_qfsi_req, InformationLevel));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
 	pSMB->Reserved3 = 0;
 	pSMB->SubCommand = cpu_to_le16(TRANS2_QUERY_FS_INFORMATION);
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_FS_SIZE_INFO);
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in QFSInfo = %d\n", rc);
@@ -4833,6 +4907,7 @@ CIFSSMBQFSAttributeInfo(const unsigned int xid, struct cifs_tcon *tcon)
 	TRANSACTION2_QFSI_REQ *pSMB = NULL;
 	TRANSACTION2_QFSI_RSP *pSMBr = NULL;
 	FILE_SYSTEM_ATTRIBUTE_INFO *response_data;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count;
@@ -4841,8 +4916,9 @@ CIFSSMBQFSAttributeInfo(const unsigned int xid, struct cifs_tcon *tcon)
 QFSAttributeRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 2;	/* level */
 	pSMB->TotalDataCount = 0;
@@ -4858,17 +4934,17 @@ CIFSSMBQFSAttributeInfo(const unsigned int xid, struct cifs_tcon *tcon)
 	pSMB->TotalParameterCount = cpu_to_le16(params);
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-		struct smb_com_transaction2_qfsi_req, InformationLevel) - 4);
+		struct smb_com_transaction2_qfsi_req, InformationLevel));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
 	pSMB->Reserved3 = 0;
 	pSMB->SubCommand = cpu_to_le16(TRANS2_QUERY_FS_INFORMATION);
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_FS_ATTRIBUTE_INFO);
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(VFS, "Send error in QFSAttributeInfo = %d\n", rc);
@@ -4903,6 +4979,7 @@ CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon)
 	TRANSACTION2_QFSI_REQ *pSMB = NULL;
 	TRANSACTION2_QFSI_RSP *pSMBr = NULL;
 	FILE_SYSTEM_DEVICE_INFO *response_data;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count;
@@ -4911,8 +4988,9 @@ CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon)
 QFSDeviceRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 2;	/* level */
 	pSMB->TotalDataCount = 0;
@@ -4928,7 +5006,7 @@ CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon)
 	pSMB->TotalParameterCount = cpu_to_le16(params);
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-		struct smb_com_transaction2_qfsi_req, InformationLevel) - 4);
+		struct smb_com_transaction2_qfsi_req, InformationLevel));
 
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
@@ -4936,10 +5014,10 @@ CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon)
 	pSMB->Reserved3 = 0;
 	pSMB->SubCommand = cpu_to_le16(TRANS2_QUERY_FS_INFORMATION);
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_FS_DEVICE_INFO);
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in QFSDeviceInfo = %d\n", rc);
@@ -4974,6 +5052,7 @@ CIFSSMBQFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon)
 	TRANSACTION2_QFSI_REQ *pSMB = NULL;
 	TRANSACTION2_QFSI_RSP *pSMBr = NULL;
 	FILE_SYSTEM_UNIX_INFO *response_data;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count;
@@ -4982,8 +5061,9 @@ CIFSSMBQFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon)
 QFSUnixRetry:
 	rc = smb_init_no_reconnect(SMB_COM_TRANSACTION2, 15, tcon,
 				   (void **) &pSMB, (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 2;	/* level */
 	pSMB->TotalDataCount = 0;
@@ -5001,15 +5081,15 @@ CIFSSMBQFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon)
 	pSMB->ParameterCount = cpu_to_le16(params);
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(struct
-			smb_com_transaction2_qfsi_req, InformationLevel) - 4);
+			smb_com_transaction2_qfsi_req, InformationLevel));
 	pSMB->SetupCount = 1;
 	pSMB->Reserved3 = 0;
 	pSMB->SubCommand = cpu_to_le16(TRANS2_QUERY_FS_INFORMATION);
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_CIFS_UNIX_INFO);
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(VFS, "Send error in QFSUnixInfo = %d\n", rc);
@@ -5043,6 +5123,7 @@ CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon, __u64 cap)
 /* level 0x200  SMB_SET_CIFS_UNIX_INFO */
 	TRANSACTION2_SETFSI_REQ *pSMB = NULL;
 	TRANSACTION2_SETFSI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, param_offset, offset, byte_count;
@@ -5052,8 +5133,9 @@ CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon, __u64 cap)
 	/* BB switch to small buf init to save memory */
 	rc = smb_init_no_reconnect(SMB_COM_TRANSACTION2, 15, tcon,
 					(void **) &pSMB, (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 4;	/* 2 bytes zero followed by info level. */
 	pSMB->MaxSetupCount = 0;
@@ -5061,8 +5143,7 @@ CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon, __u64 cap)
 	pSMB->Flags = 0;
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
-	param_offset = offsetof(struct smb_com_transaction2_setfsi_req, FileNum)
-				- 4;
+	param_offset = offsetof(struct smb_com_transaction2_setfsi_req, FileNum);
 	offset = param_offset + params;
 
 	pSMB->MaxParameterCount = cpu_to_le16(4);
@@ -5089,10 +5170,10 @@ CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon, __u64 cap)
 	pSMB->ClientUnixMinor = cpu_to_le16(CIFS_UNIX_MINOR_VERSION);
 	pSMB->ClientUnixCap = cpu_to_le64(cap);
 
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(VFS, "Send error in SETFSUnixInfo = %d\n", rc);
@@ -5119,6 +5200,7 @@ CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	TRANSACTION2_QFSI_REQ *pSMB = NULL;
 	TRANSACTION2_QFSI_RSP *pSMBr = NULL;
 	FILE_SYSTEM_POSIX_INFO *response_data;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count;
@@ -5127,8 +5209,9 @@ CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
 QFSPosixRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	params = 2;	/* level */
 	pSMB->TotalDataCount = 0;
@@ -5146,15 +5229,15 @@ CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ParameterCount = cpu_to_le16(params);
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(struct
-			smb_com_transaction2_qfsi_req, InformationLevel) - 4);
+			smb_com_transaction2_qfsi_req, InformationLevel));
 	pSMB->SetupCount = 1;
 	pSMB->Reserved3 = 0;
 	pSMB->SubCommand = cpu_to_le16(TRANS2_QUERY_FS_INFORMATION);
 	pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_POSIX_FS_INFO);
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in QFSUnixInfo = %d\n", rc);
@@ -5219,6 +5302,7 @@ CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 	struct smb_com_transaction2_spi_req *pSMB = NULL;
 	struct smb_com_transaction2_spi_rsp *pSMBr = NULL;
 	struct file_end_of_file_info *parm_data;
+	unsigned int in_len;
 	int name_len;
 	int rc = 0;
 	int bytes_returned = 0;
@@ -5230,8 +5314,9 @@ CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 SetEOFRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -5252,7 +5337,7 @@ CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
+				InformationLevel);
 	offset = param_offset + params;
 	if (set_allocation) {
 		if (tcon->ses->capabilities & CAP_INFOLEVEL_PASSTHRU)
@@ -5284,10 +5369,10 @@ CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ParameterCount = cpu_to_le16(params);
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	parm_data->FileSize = cpu_to_le64(size);
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc)
 		cifs_dbg(FYI, "SetPathInfo (file size) returned %d\n", rc);
@@ -5306,15 +5391,16 @@ CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	struct smb_com_transaction2_sfi_req *pSMB  = NULL;
 	struct file_end_of_file_info *parm_data;
+	unsigned int in_len;
 	int rc = 0;
 	__u16 params, param_offset, offset, byte_count, count;
 
 	cifs_dbg(FYI, "SetFileSize (via SetFileInfo) %lld\n",
 		 (long long)size);
 	rc = small_smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB);
-
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->hdr.Pid = cpu_to_le16((__u16)cfile->pid);
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(cfile->pid >> 16));
@@ -5325,7 +5411,7 @@ CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Flags = 0;
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
-	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid) - 4;
+	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid);
 	offset = param_offset + params;
 
 	count = sizeof(struct file_end_of_file_info);
@@ -5341,9 +5427,8 @@ CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->TotalDataCount = pSMB->DataCount;
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
-	/* SMB offsets are from the beginning of SMB which is 4 bytes in, after RFC1001 field */
 	parm_data =
-		(struct file_end_of_file_info *)(((char *)pSMB) + offset + 4);
+		(struct file_end_of_file_info *)(((char *)pSMB) + offset);
 	pSMB->DataOffset = cpu_to_le16(offset);
 	parm_data->FileSize = cpu_to_le64(size);
 	pSMB->Fid = cfile->fid.netfid;
@@ -5363,9 +5448,9 @@ CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
 				cpu_to_le16(SMB_SET_FILE_END_OF_FILE_INFO);
 	}
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, 0);
+	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, in_len, 0);
 	cifs_small_buf_release(pSMB);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in SetFileInfo (SetFileSize) = %d\n",
@@ -5387,6 +5472,7 @@ SMBSetInformation(const unsigned int xid, struct cifs_tcon *tcon,
 	SETATTR_REQ *pSMB;
 	SETATTR_RSP *pSMBr;
 	struct timespec64 ts;
+	unsigned int in_len;
 	int bytes_returned;
 	int name_len;
 	int rc;
@@ -5396,8 +5482,9 @@ SMBSetInformation(const unsigned int xid, struct cifs_tcon *tcon,
 retry:
 	rc = smb_init(SMB_COM_SETATTR, 8, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -5419,10 +5506,10 @@ SMBSetInformation(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 	pSMB->BufferFormat = 0x04;
 	name_len++; /* account for buffer type byte */
-	inc_rfc1001_len(pSMB, (__u16)name_len);
+	in_len += name_len;
 	pSMB->ByteCount = cpu_to_le16(name_len);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc)
 		cifs_dbg(FYI, "Send error in %s = %d\n", __func__, rc);
@@ -5446,15 +5533,16 @@ CIFSSMBSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 		    const FILE_BASIC_INFO *data, __u16 fid, __u32 pid_of_opener)
 {
 	struct smb_com_transaction2_sfi_req *pSMB  = NULL;
+	unsigned int in_len;
 	char *data_offset;
 	int rc = 0;
 	__u16 params, param_offset, offset, byte_count, count;
 
 	cifs_dbg(FYI, "Set Times (via SetFileInfo)\n");
 	rc = small_smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB);
-
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->hdr.Pid = cpu_to_le16((__u16)pid_of_opener);
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(pid_of_opener >> 16));
@@ -5465,11 +5553,10 @@ CIFSSMBSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Flags = 0;
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
-	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid) - 4;
+	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid);
 	offset = param_offset + params;
 
-	data_offset = (char *)pSMB +
-			offsetof(struct smb_hdr, Protocol) + offset;
+	data_offset = (char *)pSMB + offset;
 
 	count = sizeof(FILE_BASIC_INFO);
 	pSMB->MaxParameterCount = cpu_to_le16(2);
@@ -5491,10 +5578,10 @@ CIFSSMBSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	else
 		pSMB->InformationLevel = cpu_to_le16(SMB_SET_FILE_BASIC_INFO);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 	memcpy(data_offset, data, sizeof(FILE_BASIC_INFO));
-	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, 0);
+	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, in_len, 0);
 	cifs_small_buf_release(pSMB);
 	if (rc)
 		cifs_dbg(FYI, "Send error in Set Time (SetFileInfo) = %d\n",
@@ -5511,15 +5598,16 @@ CIFSSMBSetFileDisposition(const unsigned int xid, struct cifs_tcon *tcon,
 			  bool delete_file, __u16 fid, __u32 pid_of_opener)
 {
 	struct smb_com_transaction2_sfi_req *pSMB  = NULL;
+	unsigned int in_len;
 	char *data_offset;
 	int rc = 0;
 	__u16 params, param_offset, offset, byte_count, count;
 
 	cifs_dbg(FYI, "Set File Disposition (via SetFileInfo)\n");
 	rc = small_smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB);
-
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->hdr.Pid = cpu_to_le16((__u16)pid_of_opener);
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(pid_of_opener >> 16));
@@ -5530,11 +5618,9 @@ CIFSSMBSetFileDisposition(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Flags = 0;
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
-	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid) - 4;
+	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid);
 	offset = param_offset + params;
-
-	/* SMB offsets are from the beginning of SMB which is 4 bytes in, after RFC1001 field */
-	data_offset = (char *)(pSMB) + offset + 4;
+	data_offset = (char *)(pSMB) + offset;
 
 	count = 1;
 	pSMB->MaxParameterCount = cpu_to_le16(2);
@@ -5553,10 +5639,10 @@ CIFSSMBSetFileDisposition(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Fid = fid;
 	pSMB->InformationLevel = cpu_to_le16(SMB_SET_FILE_DISPOSITION_INFO);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 	*data_offset = delete_file ? 1 : 0;
-	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, 0);
+	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, in_len, 0);
 	cifs_small_buf_release(pSMB);
 	if (rc)
 		cifs_dbg(FYI, "Send error in SetFileDisposition = %d\n", rc);
@@ -5604,6 +5690,7 @@ CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	TRANSACTION2_SPI_REQ *pSMB = NULL;
 	TRANSACTION2_SPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int name_len;
 	int rc = 0;
 	int bytes_returned = 0;
@@ -5616,8 +5703,9 @@ CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 SetTimesRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -5640,7 +5728,7 @@ CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
+				InformationLevel);
 	offset = param_offset + params;
 	data_offset = (char *)pSMB + offsetof(typeof(*pSMB), hdr.Protocol) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
@@ -5659,10 +5747,10 @@ CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	else
 		pSMB->InformationLevel = cpu_to_le16(SMB_SET_FILE_BASIC_INFO);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	memcpy(data_offset, data, sizeof(FILE_BASIC_INFO));
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc)
 		cifs_dbg(FYI, "SetPathInfo (times) returned %d\n", rc);
@@ -5732,15 +5820,16 @@ CIFSSMBUnixSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 		       u16 fid, u32 pid_of_opener)
 {
 	struct smb_com_transaction2_sfi_req *pSMB  = NULL;
+	unsigned int in_len;
 	char *data_offset;
 	int rc = 0;
 	u16 params, param_offset, offset, byte_count, count;
 
 	cifs_dbg(FYI, "Set Unix Info (via SetFileInfo)\n");
 	rc = small_smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB);
-
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	pSMB->hdr.Pid = cpu_to_le16((__u16)pid_of_opener);
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(pid_of_opener >> 16));
@@ -5751,11 +5840,10 @@ CIFSSMBUnixSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Flags = 0;
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
-	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid) - 4;
+	param_offset = offsetof(struct smb_com_transaction2_sfi_req, Fid);
 	offset = param_offset + params;
 
-	data_offset = (char *)pSMB +
-			offsetof(struct smb_hdr, Protocol) + offset;
+	data_offset = (char *)pSMB + offset;
 
 	count = sizeof(FILE_UNIX_BASIC_INFO);
 
@@ -5775,12 +5863,12 @@ CIFSSMBUnixSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Fid = fid;
 	pSMB->InformationLevel = cpu_to_le16(SMB_SET_FILE_UNIX_BASIC);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
 	cifs_fill_unix_set_info((FILE_UNIX_BASIC_INFO *)data_offset, args);
 
-	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, 0);
+	rc = SendReceiveNoRsp(xid, tcon->ses, (char *) pSMB, in_len, 0);
 	cifs_small_buf_release(pSMB);
 	if (rc)
 		cifs_dbg(FYI, "Send error in Set Time (SetFileInfo) = %d\n",
@@ -5800,6 +5888,7 @@ CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	TRANSACTION2_SPI_REQ *pSMB = NULL;
 	TRANSACTION2_SPI_RSP *pSMBr = NULL;
+	unsigned int in_len;
 	int name_len;
 	int rc = 0;
 	int bytes_returned = 0;
@@ -5810,8 +5899,9 @@ CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 setPermsRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -5834,10 +5924,9 @@ CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
+				InformationLevel);
 	offset = param_offset + params;
-	/* SMB offsets are from the beginning of SMB which is 4 bytes in, after RFC1001 field */
-	data_offset = (FILE_UNIX_BASIC_INFO *)((char *) pSMB + offset + 4);
+	data_offset = (FILE_UNIX_BASIC_INFO *)((char *) pSMB + offset);
 	memset(data_offset, 0, count);
 	pSMB->DataOffset = cpu_to_le16(offset);
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
@@ -5851,12 +5940,12 @@ CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->TotalDataCount = pSMB->DataCount;
 	pSMB->InformationLevel = cpu_to_le16(SMB_SET_FILE_UNIX_BASIC);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 
 	cifs_fill_unix_set_info(data_offset, args);
 
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc)
 		cifs_dbg(FYI, "SetPathInfo (perms) returned %d\n", rc);
@@ -5888,6 +5977,7 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 	TRANSACTION2_QPI_RSP *pSMBr = NULL;
 	int remap = cifs_remap(cifs_sb);
 	struct nls_table *nls_codepage = cifs_sb->local_nls;
+	unsigned int in_len;
 	int rc = 0;
 	int bytes_returned;
 	int list_len;
@@ -5902,8 +5992,9 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 QAllEAsRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		list_len =
@@ -5926,7 +6017,7 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	pSMB->ParameterOffset = cpu_to_le16(offsetof(
-	struct smb_com_transaction2_qpi_req, InformationLevel) - 4);
+		struct smb_com_transaction2_qpi_req, InformationLevel));
 	pSMB->DataCount = 0;
 	pSMB->DataOffset = 0;
 	pSMB->SetupCount = 1;
@@ -5937,10 +6028,10 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ParameterCount = pSMB->TotalParameterCount;
 	pSMB->InformationLevel = cpu_to_le16(SMB_INFO_QUERY_ALL_EAS);
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in QueryAllEAs = %d\n", rc);
@@ -6072,6 +6163,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	struct smb_com_transaction2_spi_req *pSMB = NULL;
 	struct smb_com_transaction2_spi_rsp *pSMBr = NULL;
 	struct fealist *parm_data;
+	unsigned int in_len;
 	int name_len;
 	int rc = 0;
 	int bytes_returned = 0;
@@ -6082,8 +6174,9 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 SetEARetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
-	if (rc)
+	if (rc < 0)
 		return rc;
+	in_len = rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
@@ -6115,12 +6208,12 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->Reserved2 = 0;
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
-				InformationLevel) - 4;
+				InformationLevel);
 	offset = param_offset + params;
 	pSMB->InformationLevel =
 		cpu_to_le16(SMB_SET_FILE_EA);
 
-	parm_data = (void *)pSMB + offsetof(struct smb_hdr, Protocol) + offset;
+	parm_data = (void *)pSMB + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 	pSMB->DataOffset = cpu_to_le16(offset);
 	pSMB->SetupCount = 1;
@@ -6149,9 +6242,9 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ParameterCount = cpu_to_le16(params);
 	pSMB->TotalParameterCount = pSMB->ParameterCount;
 	pSMB->Reserved4 = 0;
-	inc_rfc1001_len(pSMB, byte_count);
+	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc)
 		cifs_dbg(FYI, "SetPathInfo (EA) returned %d\n", rc);
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 2f08fcad945e..94f43c8df07a 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -74,14 +74,14 @@ int
 smb_send(struct TCP_Server_Info *server, struct smb_hdr *smb_buffer,
 	 unsigned int smb_buf_length)
 {
-	struct kvec iov[2];
-	struct smb_rqst rqst = { .rq_iov = iov,
-				 .rq_nvec = 2 };
-
-	iov[0].iov_base = smb_buffer;
-	iov[0].iov_len = 4;
-	iov[1].iov_base = (char *)smb_buffer + 4;
-	iov[1].iov_len = smb_buf_length;
+	struct kvec iov[1] = {
+		[0].iov_base = smb_buffer,
+		[0].iov_len = smb_buf_length,
+	};
+	struct smb_rqst rqst = {
+		.rq_iov = iov,
+		.rq_nvec = ARRAY_SIZE(iov),
+	};
 
 	return __smb_send_rqst(server, 1, &rqst);
 }
@@ -125,10 +125,6 @@ cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 	struct smb_message *smb;
 
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return ERR_PTR(-EIO);
-
 	/* enable signing if server requires it */
 	if (server->sign)
 		hdr->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
@@ -157,7 +153,7 @@ cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
  */
 int
 SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
-		 char *in_buf, int flags)
+		 char *in_buf, unsigned int in_len, int flags)
 {
 	int rc;
 	struct kvec iov[1];
@@ -165,7 +161,7 @@ SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
 	int resp_buf_type;
 
 	iov[0].iov_base = in_buf;
-	iov[0].iov_len = get_rfc1002_len(in_buf) + 4;
+	iov[0].iov_len = in_len;
 	flags |= CIFS_NO_RSP_BUF;
 	rc = SendReceive2(xid, ses, iov, 1, &resp_buf_type, flags, &rsp_iov);
 	cifs_dbg(NOISY, "SendRcvNoRsp flags %d rc %d\n", flags, rc);
@@ -177,21 +173,19 @@ int
 cifs_check_receive(struct smb_message *smb, struct TCP_Server_Info *server,
 		   bool log_error)
 {
-	unsigned int len = get_rfc1002_len(smb->resp_buf) + 4;
+	unsigned int len = smb->response_pdu_len;
 
 	dump_smb(smb->resp_buf, min_t(u32, 92, len));
 
 	/* convert the length into a more usable form */
 	if (server->sign) {
-		struct kvec iov[2];
+		struct kvec iov[1];
 		int rc = 0;
 		struct smb_rqst rqst = { .rq_iov = iov,
-					 .rq_nvec = 2 };
+					 .rq_nvec = ARRAY_SIZE(iov) };
 
 		iov[0].iov_base = smb->resp_buf;
-		iov[0].iov_len = 4;
-		iov[1].iov_base = (char *)smb->resp_buf + 4;
-		iov[1].iov_len = len - 4;
+		iov[0].iov_len = len;
 		/* FIXME: add code to kill session */
 		rc = cifs_verify_signature(&rqst, server,
 					   smb->sequence_number);
@@ -212,10 +206,6 @@ cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
 	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 	struct smb_message *smb;
 
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return ERR_PTR(-EIO);
-
 	rc = allocate_mid(ses, hdr, &smb);
 	if (rc)
 		return ERR_PTR(rc);
@@ -232,53 +222,29 @@ SendReceive2(const unsigned int xid, struct cifs_ses *ses,
 	     struct kvec *iov, int n_vec, int *resp_buf_type /* ret */,
 	     const int flags, struct kvec *resp_iov)
 {
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
+	struct smb_rqst rqst = {
+		.rq_iov = iov,
+		.rq_nvec = n_vec,
+	};
 
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
+	return cifs_send_recv(xid, ses, ses->server,
+			      &rqst, resp_buf_type, flags, resp_iov);
 }
 
 int
 SendReceive(const unsigned int xid, struct cifs_ses *ses,
-	    struct smb_hdr *in_buf, struct smb_hdr *out_buf,
-	    int *pbytes_returned, const int flags)
+	    struct smb_hdr *in_buf, unsigned int in_len,
+	    struct smb_hdr *out_buf, int *pbytes_returned, const int flags)
 {
 	int rc = 0;
 	struct smb_message *smb;
-	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
-	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
+	struct kvec iov = { .iov_base = in_buf, .iov_len = in_len };
 	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 	struct TCP_Server_Info *server;
 
+	if (WARN_ON_ONCE(in_len > 0xffffff))
+		return -EIO;
 	if (ses == NULL) {
 		cifs_dbg(VFS, "Null smb session\n");
 		return -EIO;
@@ -300,9 +266,9 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	   to the same server. We may make this configurable later or
 	   use ses->maxReq */
 
-	if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
+	if (in_len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
 		cifs_server_dbg(VFS, "Invalid length, greater than maximum frame, %d\n",
-				len);
+				in_len);
 		return -EIO;
 	}
 
@@ -324,7 +290,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		return rc;
 	}
 
-	rc = cifs_sign_smb(in_buf, server, &smb->sequence_number);
+	rc = cifs_sign_smb(in_buf, in_len, server, &smb->sequence_number);
 	if (rc) {
 		cifs_server_unlock(server);
 		goto out;
@@ -332,7 +298,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 
 	smb->mid_state = MID_REQUEST_SUBMITTED;
 
-	rc = smb_send(server, in_buf, len);
+	rc = smb_send(server, in_buf, in_len);
 	cifs_save_when_sent(smb);
 
 	if (rc < 0)
@@ -371,8 +337,8 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		goto out;
 	}
 
-	*pbytes_returned = get_rfc1002_len(smb->resp_buf);
-	memcpy(out_buf, smb->resp_buf, *pbytes_returned + 4);
+	*pbytes_returned = smb->response_pdu_len;
+	memcpy(out_buf, smb->resp_buf, *pbytes_returned);
 	rc = cifs_check_receive(smb, server, 0);
 out:
 	delete_mid(smb);
@@ -386,8 +352,8 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 
 static int
 send_lock_cancel(const unsigned int xid, struct cifs_tcon *tcon,
-			struct smb_hdr *in_buf,
-			struct smb_hdr *out_buf)
+		 struct smb_hdr *in_buf, unsigned int in_len,
+		 struct smb_hdr *out_buf)
 {
 	int bytes_returned;
 	struct cifs_ses *ses = tcon->ses;
@@ -402,25 +368,25 @@ send_lock_cancel(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Timeout = 0;
 	pSMB->hdr.Mid = get_next_mid(ses->server);
 
-	return SendReceive(xid, ses, in_buf, out_buf,
+	return SendReceive(xid, ses, in_buf, in_len, out_buf,
 			&bytes_returned, 0);
 }
 
-int
-SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
-	    struct smb_hdr *in_buf, struct smb_hdr *out_buf,
-	    int *pbytes_returned)
+int SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
+			    struct smb_hdr *in_buf, unsigned int in_len,
+			    struct smb_hdr *out_buf, int *pbytes_returned)
 {
 	int rc = 0;
 	int rstart = 0;
 	struct smb_message *smb;
 	struct cifs_ses *ses;
-	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
-	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
+	struct kvec iov = { .iov_base = in_buf, .iov_len = in_len };
 	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
 	unsigned int instance;
 	struct TCP_Server_Info *server;
 
+	if (WARN_ON_ONCE(in_len > 0xffffff))
+		return -EIO;
 	if (tcon == NULL || tcon->ses == NULL) {
 		cifs_dbg(VFS, "Null smb session\n");
 		return -EIO;
@@ -444,9 +410,9 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	   to the same server. We may make this configurable later or
 	   use ses->maxReq */
 
-	if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
+	if (in_len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
 		cifs_tcon_dbg(VFS, "Invalid length, greater than maximum frame, %d\n",
-			      len);
+			      in_len);
 		return -EIO;
 	}
 
@@ -466,7 +432,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 	}
 
-	rc = cifs_sign_smb(in_buf, server, &smb->sequence_number);
+	rc = cifs_sign_smb(in_buf, in_len, server, &smb->sequence_number);
 	if (rc) {
 		delete_mid(smb);
 		cifs_server_unlock(server);
@@ -474,7 +440,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	smb->mid_state = MID_REQUEST_SUBMITTED;
-	rc = smb_send(server, in_buf, len);
+	rc = smb_send(server, in_buf, in_len);
 	cifs_save_when_sent(smb);
 
 	if (rc < 0)
@@ -515,7 +481,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 			/* Windows lock. We send a LOCKINGX_CANCEL_LOCK
 			   to cause the blocking lock to return. */
 
-			rc = send_lock_cancel(xid, tcon, in_buf, out_buf);
+			rc = send_lock_cancel(xid, tcon, in_buf, in_len, out_buf);
 
 			/* If we get -ENOLCK back the lock may have
 			   already been removed. Don't exit in this case. */
@@ -556,8 +522,8 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		goto out;
 	}
 
-	*pbytes_returned = get_rfc1002_len(smb->resp_buf);
-	memcpy(out_buf, smb->resp_buf, *pbytes_returned + 4);
+	*pbytes_returned = smb->response_pdu_len;
+	memcpy(out_buf, smb->resp_buf, *pbytes_returned);
 	rc = cifs_check_receive(smb, server, 0);
 out:
 	delete_mid(smb);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 51ac28990e11..78d1b40e724d 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1155,15 +1155,14 @@ standard_receive3(struct TCP_Server_Info *server, struct smb_message *smb)
 	unsigned int pdu_length = server->pdu_size;
 
 	/* make sure this will fit in a large buffer */
-	if (pdu_length > CIFSMaxBufSize + MAX_HEADER_SIZE(server) -
-	    HEADER_PREAMBLE_SIZE(server)) {
+	if (pdu_length > CIFSMaxBufSize + MAX_HEADER_SIZE(server)) {
 		cifs_server_dbg(VFS, "SMB response too long (%u bytes)\n", pdu_length);
 		cifs_reconnect(server, true);
 		return -ECONNABORTED;
 	}
 
 	/* switch to large buffer if too big for a small one */
-	if (pdu_length > MAX_CIFS_SMALL_BUFFER_SIZE - 4) {
+	if (pdu_length > MAX_CIFS_SMALL_BUFFER_SIZE) {
 		server->large_buf = true;
 		memcpy(server->bigbuf, buf, server->total_read);
 		buf = server->bigbuf;
@@ -1196,7 +1195,8 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct smb_message *smb)
 	 * 48 bytes is enough to display the header and a little bit
 	 * into the payload for debugging purposes.
 	 */
-	rc = server->ops->check_message(buf, server->total_read, server);
+	rc = server->ops->check_message(buf, server->pdu_size,
+					server->total_read, server);
 	if (rc)
 		cifs_dump_mem("Bad SMB: ", buf,
 			min_t(unsigned int, server->total_read, 48));
@@ -1286,16 +1286,13 @@ cifs_demultiplex_thread(void *p)
 		if (length < 0)
 			continue;
 
-		if (is_smb1(server))
-			server->total_read = length;
-		else
-			server->total_read = 0;
+		server->total_read = 0;
 
 		/*
 		 * The right amount was read from socket - 4 bytes,
 		 * so we can now interpret the length field.
 		 */
-		pdu_length = get_rfc1002_len(buf);
+		pdu_length = be32_to_cpup(((__be32 *)buf)) & 0xffffff;
 
 		cifs_dbg(FYI, "RFC1002 header 0x%x\n", pdu_length);
 		if (!is_smb_response(server, buf[0]))
@@ -1314,9 +1311,8 @@ cifs_demultiplex_thread(void *p)
 		}
 
 		/* read down to the MID */
-		length = cifs_read_from_socket(server,
-			     buf + HEADER_PREAMBLE_SIZE(server),
-			     MID_HEADER_SIZE(server));
+		length = cifs_read_from_socket(server, buf,
+					       MID_HEADER_SIZE(server));
 		if (length < 0)
 			continue;
 		server->total_read += length;
@@ -1348,6 +1344,8 @@ cifs_demultiplex_thread(void *p)
 			bufs[0] = buf;
 			num_smbs = 1;
 
+			if (smbs[0])
+				smbs[0]->response_pdu_len = pdu_length;
 			if (!smbs[0] || !smbs[0]->receive)
 				length = standard_receive3(server, smbs[0]);
 			else
@@ -1406,7 +1404,7 @@ cifs_demultiplex_thread(void *p)
 				smb2_add_credits_from_hdr(bufs[i], server);
 #ifdef CONFIG_CIFS_DEBUG2
 				if (server->ops->dump_detail)
-					server->ops->dump_detail(bufs[i],
+					server->ops->dump_detail(bufs[i], pdu_length,
 								 server);
 				cifs_dump_mids(server);
 #endif /* CIFS_DEBUG2 */
@@ -3999,7 +3997,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 	TCONX_RSP *pSMBr;
 	unsigned char *bcc_ptr;
 	int rc = 0;
-	int length;
+	int length, in_len;
 	__u16 bytes_left, count;
 
 	if (ses == NULL)
@@ -4011,8 +4009,8 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 
 	smb_buffer_response = smb_buffer;
 
-	header_assemble(smb_buffer, SMB_COM_TREE_CONNECT_ANDX,
-			NULL /*no tid */, 4 /*wct */);
+	in_len = header_assemble(smb_buffer, SMB_COM_TREE_CONNECT_ANDX,
+				 NULL /*no tid */, 4 /*wct */);
 
 	smb_buffer->Mid = get_next_mid(ses->server);
 	smb_buffer->Uid = ses->Suid;
@@ -4053,11 +4051,11 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 	bcc_ptr += strlen("?????");
 	bcc_ptr += 1;
 	count = bcc_ptr - &pSMB->Password[0];
-	be32_add_cpu(&pSMB->hdr.smb_buf_length, count);
+	in_len += count;
 	pSMB->ByteCount = cpu_to_le16(count);
 
-	rc = SendReceive(xid, ses, smb_buffer, smb_buffer_response, &length,
-			 0);
+	rc = SendReceive(xid, ses, smb_buffer, in_len, smb_buffer_response,
+			 &length, 0);
 
 	/* above now done in SendReceive */
 	if (rc == 0) {
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 340c44dc7b5b..83b253ac37e9 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -264,19 +264,18 @@ free_rsp_buf(int resp_buftype, void *rsp)
 
 /* NB: MID can not be set if treeCon not passed in, in that
    case it is responsibility of caller to set the mid */
-void
+unsigned int
 header_assemble(struct smb_hdr *buffer, char smb_command /* command */ ,
 		const struct cifs_tcon *treeCon, int word_count
 		/* length of fixed section (word count) in two byte units  */)
 {
+	unsigned int in_len;
 	char *temp = (char *) buffer;
 
 	memset(temp, 0, 256); /* bigger than MAX_CIFS_HDR_SIZE */
 
-	buffer->smb_buf_length = cpu_to_be32(
-	    (2 * word_count) + sizeof(struct smb_hdr) -
-	    4 /*  RFC 1001 length field does not count */  +
-	    2 /* for bcc field itself */) ;
+	in_len = (2 * word_count) + sizeof(struct smb_hdr) +
+		2 /* for bcc field itself */ ;
 
 	buffer->Protocol[0] = 0xFF;
 	buffer->Protocol[1] = 'S';
@@ -311,7 +310,7 @@ header_assemble(struct smb_hdr *buffer, char smb_command /* command */ ,
 
 /*  endian conversion of flags is now done just before sending */
 	buffer->WordCount = (char) word_count;
-	return;
+	return in_len;
 }
 
 static int
@@ -346,10 +345,11 @@ check_smb_hdr(struct smb_hdr *smb)
 }
 
 int
-checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
+checkSMB(char *buf, unsigned int pdu_len, unsigned int total_read,
+	 struct TCP_Server_Info *server)
 {
 	struct smb_hdr *smb = (struct smb_hdr *)buf;
-	__u32 rfclen = be32_to_cpu(smb->smb_buf_length);
+	__u32 rfclen = pdu_len;
 	__u32 clc_len;  /* calculated length */
 	cifs_dbg(FYI, "checkSMB Length: 0x%x, smb_buf_length: 0x%x\n",
 		 total_read, rfclen);
@@ -394,24 +394,24 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
 		return -EIO;
 	clc_len = smbCalcSize(smb);
 
-	if (4 + rfclen != total_read) {
-		cifs_dbg(VFS, "Length read does not match RFC1001 length %d\n",
-			 rfclen);
+	if (rfclen != total_read) {
+		cifs_dbg(VFS, "Length read does not match RFC1001 length %d/%d\n",
+			 rfclen, total_read);
 		return -EIO;
 	}
 
-	if (4 + rfclen != clc_len) {
+	if (rfclen != clc_len) {
 		__u16 mid = get_mid(smb);
 		/* check if bcc wrapped around for large read responses */
 		if ((rfclen > 64 * 1024) && (rfclen > clc_len)) {
 			/* check if lengths match mod 64K */
-			if (((4 + rfclen) & 0xFFFF) == (clc_len & 0xFFFF))
+			if (((rfclen) & 0xFFFF) == (clc_len & 0xFFFF))
 				return 0; /* bcc wrapped */
 		}
 		cifs_dbg(FYI, "Calculated size %u vs length %u mismatch for mid=%u\n",
-			 clc_len, 4 + rfclen, mid);
+			 clc_len, rfclen, mid);
 
-		if (4 + rfclen < clc_len) {
+		if (rfclen < clc_len) {
 			cifs_dbg(VFS, "RFC1001 size %u smaller than SMB for mid=%u\n",
 				 rfclen, mid);
 			return -EIO;
@@ -451,7 +451,7 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
 			(struct smb_com_transaction_change_notify_rsp *)buf;
 		struct file_notify_information *pnotify;
 		__u32 data_offset = 0;
-		size_t len = srv->total_read - sizeof(pSMBr->hdr.smb_buf_length);
+		size_t len = srv->total_read - srv->pdu_size;
 
 		if (get_bcc(buf) > sizeof(struct file_notify_information)) {
 			data_offset = le32_to_cpu(pSMBr->DataOffset);
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index ef3b498b0a02..752dee5a020c 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -1313,6 +1313,7 @@ struct sess_data {
 	struct nls_table *nls_cp;
 	void (*func)(struct sess_data *);
 	int result;
+	unsigned int in_len;
 
 	/* we will send the SMB in three pieces:
 	 * a fixed length beginning part, an optional
@@ -1336,11 +1337,12 @@ sess_alloc_buffer(struct sess_data *sess_data, int wct)
 	rc = small_smb_init_no_tc(SMB_COM_SESSION_SETUP_ANDX, wct, ses,
 				  (void **)&smb_buf);
 
-	if (rc)
+	if (rc < 0)
 		return rc;
 
+	sess_data->in_len = rc;
 	sess_data->iov[0].iov_base = (char *)smb_buf;
-	sess_data->iov[0].iov_len = be32_to_cpu(smb_buf->smb_buf_length) + 4;
+	sess_data->iov[0].iov_len = sess_data->in_len;
 	/*
 	 * This variable will be used to clear the buffer
 	 * allocated above in case of any error in the calling function.
@@ -1418,7 +1420,7 @@ sess_sendreceive(struct sess_data *sess_data)
 	struct kvec rsp_iov = { NULL, 0 };
 
 	count = sess_data->iov[1].iov_len + sess_data->iov[2].iov_len;
-	be32_add_cpu(&smb_buf->smb_buf_length, count);
+	sess_data->in_len += count;
 	put_bcc(count, smb_buf);
 
 	rc = SendReceive2(sess_data->xid, sess_data->ses,
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index b652833f04d7..e7d83bca1c38 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -34,15 +34,15 @@ send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 {
 	int rc = 0;
 	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
+	unsigned int in_len = rqst->rq_iov[0].iov_len;
 
-	/* -4 for RFC1001 length and +2 for BCC field */
-	in_buf->smb_buf_length = cpu_to_be32(sizeof(struct smb_hdr) - 4  + 2);
+	/* +2 for BCC field */
 	in_buf->Command = SMB_COM_NT_CANCEL;
 	in_buf->WordCount = 0;
 	put_bcc(0, in_buf);
 
 	cifs_server_lock(server);
-	rc = cifs_sign_smb(in_buf, server, &smb->sequence_number);
+	rc = cifs_sign_smb(in_buf, in_len, server, &smb->sequence_number);
 	if (rc) {
 		cifs_server_unlock(server);
 		return rc;
@@ -54,7 +54,7 @@ send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	 * after signing here.
 	 */
 	--server->sequence_number;
-	rc = smb_send(server, in_buf, be32_to_cpu(in_buf->smb_buf_length));
+	rc = smb_send(server, in_buf, in_len);
 	if (rc < 0)
 		server->sequence_number--;
 
@@ -288,7 +288,7 @@ check2ndT2(char *buf)
 }
 
 static int
-coalesce_t2(char *second_buf, struct smb_hdr *target_hdr)
+coalesce_t2(char *second_buf, struct smb_hdr *target_hdr, unsigned int *pdu_len)
 {
 	struct smb_t2_rsp *pSMBs = (struct smb_t2_rsp *)second_buf;
 	struct smb_t2_rsp *pSMBt  = (struct smb_t2_rsp *)target_hdr;
@@ -354,15 +354,15 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr)
 	}
 	put_bcc(byte_count, target_hdr);
 
-	byte_count = be32_to_cpu(target_hdr->smb_buf_length);
+	byte_count = *pdu_len;
 	byte_count += total_in_src;
 	/* don't allow buffer to overflow */
-	if (byte_count > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
+	if (byte_count > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
 		cifs_dbg(FYI, "coalesced BCC exceeds buffer size (%u)\n",
 			 byte_count);
 		return -ENOBUFS;
 	}
-	target_hdr->smb_buf_length = cpu_to_be32(byte_count);
+	*pdu_len = byte_count;
 
 	/* copy second buffer into end of first buffer */
 	memcpy(data_area_of_tgt, data_area_of_src, total_in_src);
@@ -397,7 +397,7 @@ cifs_check_trans2(struct smb_message *smb, struct TCP_Server_Info *server,
 	smb->multiRsp = true;
 	if (smb->resp_buf) {
 		/* merge response - fix up 1st*/
-		malformed = coalesce_t2(buf, smb->resp_buf);
+		malformed = coalesce_t2(buf, smb->resp_buf, &smb->response_pdu_len);
 		if (malformed > 0)
 			return true;
 		/* All parts received or packet is malformed. */
@@ -460,7 +460,7 @@ smb1_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	if (!(server->capabilities & CAP_LARGE_WRITE_X) ||
 	    (!(server->capabilities & CAP_UNIX) && server->sign))
 		wsize = min_t(unsigned int, wsize,
-				server->maxBuf - sizeof(WRITE_REQ) + 4);
+				server->maxBuf - sizeof(WRITE_REQ));
 
 	/* hard limit of CIFS_MAX_WSIZE */
 	wsize = min_t(unsigned int, wsize, CIFS_MAX_WSIZE);
@@ -1486,7 +1486,6 @@ struct smb_version_values smb1_values = {
 	.exclusive_lock_type = 0,
 	.shared_lock_type = LOCKING_ANDX_SHARED_LOCK,
 	.unlock_lock_type = 0,
-	.header_preamble_size = 4,
 	.header_size = sizeof(struct smb_hdr),
 	.max_header_size = MAX_CIFS_HDR_SIZE,
 	.read_rsp_size = sizeof(READ_RSP),
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index f0eb25033d72..84e6b01000c6 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -134,7 +134,8 @@ static __u32 get_neg_ctxt_len(struct smb2_hdr *hdr, __u32 len,
 }
 
 int
-smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
+smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
+		   struct TCP_Server_Info *server)
 {
 	struct TCP_Server_Info *pserver;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ba942beb2b56..67212783e329 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -432,7 +432,7 @@ smb2_find_dequeue_mid(struct TCP_Server_Info *server, char *buf)
 }
 
 static void
-smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
+smb2_dump_detail(void *buf, size_t buf_len, struct TCP_Server_Info *server)
 {
 #ifdef CONFIG_CIFS_DEBUG2
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
@@ -440,7 +440,7 @@ smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
 	cifs_server_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Mid: %llu Pid: %d\n",
 		 shdr->Command, shdr->Status, shdr->Flags, shdr->MessageId,
 		 shdr->Id.SyncId.ProcessId);
-	if (!server->ops->check_message(buf, server->total_read, server)) {
+	if (!server->ops->check_message(buf, buf_len, server->total_read, server)) {
 		cifs_server_dbg(VFS, "smb buf %p len %u\n", buf,
 				server->ops->calc_smb_size(buf));
 	}
@@ -5767,7 +5767,6 @@ struct smb_version_values smb20_values = {
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
-	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
@@ -5789,7 +5788,6 @@ struct smb_version_values smb21_values = {
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
-	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
@@ -5810,7 +5808,6 @@ struct smb_version_values smb3any_values = {
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
-	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
@@ -5831,7 +5828,6 @@ struct smb_version_values smbdefault_values = {
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
-	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
@@ -5852,7 +5848,6 @@ struct smb_version_values smb30_values = {
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
-	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
@@ -5873,7 +5868,6 @@ struct smb_version_values smb302_values = {
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
-	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
@@ -5894,7 +5888,6 @@ struct smb_version_values smb311_values = {
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
-	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 3bf5f77b0fed..c9ad4382334e 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -21,7 +21,7 @@ struct smb_rqst;
  *****************************************************************
  */
 extern int map_smb2_to_linux_error(char *buf, bool log_err);
-extern int smb2_check_message(char *buf, unsigned int length,
+extern int smb2_check_message(char *buf, unsigned int pdu_len, unsigned int length,
 			      struct TCP_Server_Info *server);
 extern unsigned int smb2_calc_size(void *buf);
 extern char *smb2_get_data_area_len(int *off, int *len,
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 52083b79609b..2e338e186809 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -290,8 +290,8 @@ int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	sigfillset(&mask);
 	sigprocmask(SIG_BLOCK, &mask, &oldmask);
 
-	/* Generate a rfc1002 marker for SMB2+ */
-	if (!is_smb1(server)) {
+	/* Generate a rfc1002 marker */
+	{
 		struct kvec hiov = {
 			.iov_base = &rfc1002_marker,
 			.iov_len  = 4
@@ -1045,8 +1045,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 
 		buf = (char *)smb[i]->resp_buf;
 		resp_iov[i].iov_base = buf;
-		resp_iov[i].iov_len = smb[i]->resp_buf_size +
-			HEADER_PREAMBLE_SIZE(server);
+		resp_iov[i].iov_len = smb[i]->resp_buf_size;
 
 		if (smb[i]->large_buf)
 			resp_buf_type[i] = CIFS_LARGE_BUFFER;
@@ -1113,8 +1112,7 @@ int
 cifs_discard_remaining_data(struct TCP_Server_Info *server)
 {
 	unsigned int rfclen = server->pdu_size;
-	size_t remaining = rfclen + HEADER_PREAMBLE_SIZE(server) -
-		server->total_read;
+	size_t remaining = rfclen - server->total_read;
 
 	while (remaining > 0) {
 		ssize_t length;
@@ -1159,7 +1157,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message *smb)
 	unsigned int data_offset, data_len;
 	struct cifs_io_subrequest *rdata = smb->callback_data;
 	char *buf = server->smallbuf;
-	unsigned int buflen = server->pdu_size + HEADER_PREAMBLE_SIZE(server);
+	unsigned int buflen = server->pdu_size;
 	bool use_rdma_mr = false;
 
 	cifs_dbg(FYI, "%s: mid=%llu offset=%llu bytes=%zu\n",
@@ -1193,14 +1191,9 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message *smb)
 
 	/* set up first two iov for signature check and to get credits */
 	rdata->iov[0].iov_base = buf;
-	rdata->iov[0].iov_len = HEADER_PREAMBLE_SIZE(server);
-	rdata->iov[1].iov_base = buf + HEADER_PREAMBLE_SIZE(server);
-	rdata->iov[1].iov_len =
-		server->total_read - HEADER_PREAMBLE_SIZE(server);
+	rdata->iov[0].iov_len = server->total_read;
 	cifs_dbg(FYI, "0: iov_base=%p iov_len=%zu\n",
 		 rdata->iov[0].iov_base, rdata->iov[0].iov_len);
-	cifs_dbg(FYI, "1: iov_base=%p iov_len=%zu\n",
-		 rdata->iov[1].iov_base, rdata->iov[1].iov_len);
 
 	/* Was the SMB read successful? */
 	rdata->result = server->ops->map_error(buf, false);
@@ -1220,8 +1213,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message *smb)
 		return cifs_readv_discard(server, smb);
 	}
 
-	data_offset = server->ops->read_data_offset(buf) +
-		HEADER_PREAMBLE_SIZE(server);
+	data_offset = server->ops->read_data_offset(buf);
 	if (data_offset < server->total_read) {
 		/*
 		 * win2k8 sometimes sends an offset of 0 when the read
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index f38c5739a9d2..945a8e0cf36c 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -2016,9 +2016,6 @@ struct smb2_lease_ack {
  *     MS-SMB 2.2.3.1
  */
 struct smb_hdr {
-	__be32 smb_buf_length;	/* BB length is only two (rarely three) bytes,
-		with one or two byte "type" preceding it that will be
-		zero - we could mask the type byte off */
 	__u8 Protocol[4];
 	__u8 Command;
 	union {
diff --git a/fs/smb/common/smbglob.h b/fs/smb/common/smbglob.h
index 7853b5771128..9562845a5617 100644
--- a/fs/smb/common/smbglob.h
+++ b/fs/smb/common/smbglob.h
@@ -26,7 +26,6 @@ struct smb_version_values {
 	__u32		exclusive_lock_type;
 	__u32		shared_lock_type;
 	__u32		unlock_lock_type;
-	size_t		header_preamble_size;
 	size_t		header_size;
 	size_t		max_header_size;
 	size_t		read_rsp_size;


