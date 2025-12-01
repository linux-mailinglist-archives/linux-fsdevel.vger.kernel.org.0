Return-Path: <linux-fsdevel+bounces-70315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA877C967B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 10:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1ADA3450E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C603043D3;
	Mon,  1 Dec 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqEMbmnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3898302CB0
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582594; cv=none; b=SD7ZxChTm2w+SaKd8ztRpwf8S8X/WD45G6leNDXydgnuu0QYzhBeSTCgkdFyb/GX+gc33tIuWl58DLFWDe08aV0J9KQX8y6doh5UJdkJVNBVRkIq9CiN3gVrEy/xtoDCR8EX1585EZqAmDooNYZ1R87pLMJP+4zPA0EppiPSvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582594; c=relaxed/simple;
	bh=N0vECHJG0Iubd0Sb6dc3jJZliCtNMZOpU1IGR7n3mvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P43f4H4zOf7mnMVMChTrQFBqDp+owIX9ghFe2Dqc4nmxz/NsU8aflMutODkQRfKSUHd9JzrQFKYNXZStYCliRKJ1CDY4g0BzSoYQ2+e307LYkJNlUWnTc0WXLW6cpBwL1CFdDucR5HNsVA8GyQTi1VmE1CZhMK/aYhF4E9fZheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqEMbmnG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764582590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIolT7ROktfuj7tenuTo9CRicofFShrno3nh0ZBeE0w=;
	b=eqEMbmnGHyLcb6bAfOlgTnlTtnAIOX9lcFpvew5j+ychcV4tG6qHSMshZBDWeOy/KDfuFN
	VsvWKi/pMUolkBonaVw+tFhMXLrb47SdIWIBaY/xOC77LdN1pK6TAnxEUXpnYmnLtKIzSI
	RaFfIYGq3w+eMSQ/jT0S/bT3ZUVspao=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-ZmxNWMkCOTe_KGTo1dzrjA-1; Mon,
 01 Dec 2025 04:49:47 -0500
X-MC-Unique: ZmxNWMkCOTe_KGTo1dzrjA-1
X-Mimecast-MFC-AGG-ID: ZmxNWMkCOTe_KGTo1dzrjA_1764582586
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C033419560B2;
	Mon,  1 Dec 2025 09:49:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14BB91800451;
	Mon,  1 Dec 2025 09:49:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH v5 5/9] cifs: Replace SendReceiveBlockingLock() with SendReceive() plus flags
Date: Mon,  1 Dec 2025 09:49:09 +0000
Message-ID: <20251201094916.1418415-6-dhowells@redhat.com>
In-Reply-To: <20251201094916.1418415-1-dhowells@redhat.com>
References: <20251201094916.1418415-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replace the smb1 transport's SendReceiveBlockingLock() with SendReceive()
plus a couple of flags.  This will then allow that to pick up the transport
changes there.

The first flag, CIFS_INTERRUPTIBLE_WAIT, is added to indicate that the wait
should be interruptible and the second, CIFS_WINDOWS_LOCK, indicates that
we need to send a Lock command with unlock type rather than a Cancel.

send_lock_cancel() is then called from cifs_lock_cancel() which is called
from the main transport loop in compound_send_recv().

[!] I *think* the error code handling is probably right.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h      |   8 +-
 fs/smb/client/cifsproto.h     |  10 +-
 fs/smb/client/cifssmb.c       |  18 +--
 fs/smb/client/cifstransport.c | 200 +---------------------------------
 fs/smb/client/smb1ops.c       |  47 +++++++-
 fs/smb/client/transport.c     |  10 +-
 6 files changed, 77 insertions(+), 216 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 1ed3dd48c4a4..b3a8fd754d1f 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -311,8 +311,9 @@ struct cifs_open_parms;
 struct cifs_credits;
 
 struct smb_version_operations {
-	int (*send_cancel)(struct TCP_Server_Info *, struct smb_rqst *,
-			   struct smb_message *smb);
+	int (*send_cancel)(struct cifs_ses *ses, struct TCP_Server_Info *server,
+			   struct smb_rqst *rqst, struct smb_message *smb,
+			   unsigned int xid);
 	bool (*compare_fids)(struct cifsFileInfo *, struct cifsFileInfo *);
 	/* setup request: allocate mid, sign message */
 	struct smb_message *(*setup_request)(struct cifs_ses *ses,
@@ -1689,6 +1690,7 @@ struct smb_message {
 	__u16 credits_received;	/* number of credits from the response */
 	__u32 pid;		/* process id */
 	__u32 sequence_number;  /* for CIFS signing */
+	unsigned int sr_flags;	/* Flags passed to send_recv() */
 	unsigned long when_alloc;  /* when mid was created */
 #ifdef CONFIG_CIFS_STATS2
 	unsigned long when_sent; /* time when smb send finished */
@@ -1900,6 +1902,8 @@ enum cifs_writable_file_flags {
 #define   CIFS_TRANSFORM_REQ      0x0800 /* transform request before sending */
 #define   CIFS_NO_SRV_RSP         0x1000 /* there is no server response */
 #define   CIFS_COMPRESS_REQ       0x4000 /* compress request before sending */
+#define   CIFS_INTERRUPTIBLE_WAIT 0x8000 /* Interruptible wait (e.g. lock request) */
+#define   CIFS_WINDOWS_LOCK       0x10000 /* We're trying to get a Windows lock */
 
 /* Security Flags: indicate type of session setup needed */
 #define   CIFSSEC_MAY_SIGN	0x00001
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 4657635e6dfc..cacf0bd70fa1 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -130,11 +130,12 @@ extern int cifs_wait_mtu_credits(struct TCP_Server_Info *server,
 				 struct cifs_credits *credits);
 
 static inline int
-send_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
-	    struct smb_message *smb)
+send_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
+	    struct smb_rqst *rqst, struct smb_message *smb,
+	    unsigned int xid)
 {
 	return server->ops->send_cancel ?
-				server->ops->send_cancel(server, rqst, smb) : 0;
+		server->ops->send_cancel(ses, server, rqst, smb, xid) : 0;
 }
 
 int wait_for_response(struct TCP_Server_Info *server, struct smb_message *smb);
@@ -142,9 +143,6 @@ extern int SendReceive2(const unsigned int /* xid */ , struct cifs_ses *,
 			struct kvec *, int /* nvec to send */,
 			int * /* type of buf returned */, const int flags,
 			struct kvec * /* resp vec */);
-int SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
-			    struct smb_hdr *in_buf, unsigned int in_len,
-			    struct smb_hdr *out_buf, int *pbytes_returned);
 
 void smb2_query_server_interfaces(struct work_struct *work);
 void
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 5f0b96a5d696..c1523bd60fad 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2059,7 +2059,7 @@ CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
 /*	LOCK_RSP *pSMBr = NULL; */ /* No response data other than rc to parse */
 	unsigned int in_len;
 	int bytes_returned;
-	int flags = 0;
+	int flags = CIFS_WINDOWS_LOCK | CIFS_INTERRUPTIBLE_WAIT;
 	__u16 count;
 
 	cifs_dbg(FYI, "CIFSSMBLock timeout %d numLock %d\n",
@@ -2104,8 +2104,9 @@ CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->ByteCount = cpu_to_le16(count);
 
 	if (waitFlag)
-		rc = SendReceiveBlockingLock(xid, tcon, (struct smb_hdr *) pSMB, in_len,
-			(struct smb_hdr *) pSMB, &bytes_returned);
+		rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
+				 (struct smb_hdr *) pSMB, &bytes_returned,
+				 flags);
 	else
 		rc = SendReceiveNoRsp(xid, tcon->ses, (char *)pSMB, in_len, flags);
 	cifs_small_buf_release(pSMB);
@@ -2130,7 +2131,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_posix_lock *parm_data;
 	unsigned int in_len;
 	int rc = 0;
-	int timeout = 0;
+	int sr_flags = CIFS_INTERRUPTIBLE_WAIT;
 	int bytes_returned = 0;
 	int resp_buf_type = 0;
 	__u16 params, param_offset, offset, byte_count, count;
@@ -2173,7 +2174,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 
 	parm_data->lock_type = cpu_to_le16(lock_type);
 	if (waitFlag) {
-		timeout = CIFS_BLOCKING_OP; /* blocking operation, no timeout */
+		sr_flags |= CIFS_BLOCKING_OP; /* blocking operation, no timeout */
 		parm_data->lock_flags = cpu_to_le16(1);
 		pSMB->Timeout = cpu_to_le32(-1);
 	} else
@@ -2190,13 +2191,14 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 	in_len += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 	if (waitFlag) {
-		rc = SendReceiveBlockingLock(xid, tcon, (struct smb_hdr *) pSMB, in_len,
-			(struct smb_hdr *) pSMBr, &bytes_returned);
+		rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB, in_len,
+				 (struct smb_hdr *) pSMBr, &bytes_returned,
+				 sr_flags);
 	} else {
 		iov[0].iov_base = (char *)pSMB;
 		iov[0].iov_len = in_len;
 		rc = SendReceive2(xid, tcon->ses, iov, 1 /* num iovecs */,
-				&resp_buf_type, timeout, &rsp_iov);
+				&resp_buf_type, sr_flags, &rsp_iov);
 		pSMBr = (struct smb_com_transaction2_sfi_rsp *)rsp_iov.iov_base;
 	}
 	cifs_small_buf_release(pSMB);
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 5b07d0555526..7ea737fc5127 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -239,13 +239,6 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		return -EIO;
 	}
 
-	spin_lock(&server->srv_lock);
-	if (server->tcpStatus == CifsExiting) {
-		spin_unlock(&server->srv_lock);
-		return -ENOENT;
-	}
-	spin_unlock(&server->srv_lock);
-
 	/* Ensure that we do not send more than 50 overlapping requests
 	   to the same server. We may make this configurable later or
 	   use ses->maxReq */
@@ -261,194 +254,11 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	if (rc < 0)
 		return rc;
 
-	*pbytes_returned = resp_iov.iov_len;
-	if (resp_iov.iov_len)
-		memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
-	free_rsp_buf(resp_buf_type, resp_iov.iov_base);
-	return rc;
-}
-
-/* We send a LOCKINGX_CANCEL_LOCK to cause the Windows
-   blocking lock to return. */
-
-static int
-send_lock_cancel(const unsigned int xid, struct cifs_tcon *tcon,
-		 struct smb_hdr *in_buf, unsigned int in_len,
-		 struct smb_hdr *out_buf)
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
-	return SendReceive(xid, ses, in_buf, in_len, out_buf,
-			&bytes_returned, 0);
-}
-
-int SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
-			    struct smb_hdr *in_buf, unsigned int in_len,
-			    struct smb_hdr *out_buf, int *pbytes_returned)
-{
-	int rc = 0;
-	int rstart = 0;
-	struct smb_message *smb;
-	struct cifs_ses *ses;
-	struct kvec iov = { .iov_base = in_buf, .iov_len = in_len };
-	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
-	unsigned int instance;
-	struct TCP_Server_Info *server;
-
-	if (WARN_ON_ONCE(in_len > 0xffffff))
-		return -EIO;
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
-	if (in_len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
-		cifs_tcon_dbg(VFS, "Invalid length, greater than maximum frame, %d\n",
-			      in_len);
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
-	rc = allocate_mid(ses, in_buf, &smb);
-	if (rc) {
-		cifs_server_unlock(server);
-		return rc;
-	}
-
-	rc = cifs_sign_rqst(&rqst, server, &smb->sequence_number);
-	if (rc) {
-		delete_mid(smb);
-		cifs_server_unlock(server);
-		return rc;
-	}
-
-	smb->mid_state = MID_REQUEST_SUBMITTED;
-	rc = __smb_send_rqst(server, 1, &rqst);
-	cifs_save_when_sent(smb);
-
-	if (rc < 0)
-		server->sequence_number -= 2;
-
-	cifs_server_unlock(server);
-
-	if (rc < 0) {
-		delete_mid(smb);
-		return rc;
-	}
-
-	/* Wait for a reply - allow signals to interrupt. */
-	rc = wait_event_interruptible(server->response_q,
-		(!(smb->mid_state == MID_REQUEST_SUBMITTED ||
-		   smb->mid_state == MID_RESPONSE_RECEIVED)) ||
-		((server->tcpStatus != CifsGood) &&
-		 (server->tcpStatus != CifsNew)));
-
-	/* Were we interrupted by a signal ? */
-	spin_lock(&server->srv_lock);
-	if ((rc == -ERESTARTSYS) &&
-		(smb->mid_state == MID_REQUEST_SUBMITTED ||
-		 smb->mid_state == MID_RESPONSE_RECEIVED) &&
-		((server->tcpStatus == CifsGood) ||
-		 (server->tcpStatus == CifsNew))) {
-		spin_unlock(&server->srv_lock);
-
-		if (in_buf->Command == SMB_COM_TRANSACTION2) {
-			/* POSIX lock. We send a NT_CANCEL SMB to cause the
-			   blocking lock to return. */
-			rc = send_cancel(server, &rqst, smb);
-			if (rc) {
-				delete_mid(smb);
-				return rc;
-			}
-		} else {
-			/* Windows lock. We send a LOCKINGX_CANCEL_LOCK
-			   to cause the blocking lock to return. */
-
-			rc = send_lock_cancel(xid, tcon, in_buf, in_len, out_buf);
-
-			/* If we get -ENOLCK back the lock may have
-			   already been removed. Don't exit in this case. */
-			if (rc && rc != -ENOLCK) {
-				delete_mid(smb);
-				return rc;
-			}
-		}
-
-		rc = wait_for_response(server, smb);
-		if (rc) {
-			send_cancel(server, &rqst, smb);
-			spin_lock(&smb->mid_lock);
-			if (smb->mid_state == MID_REQUEST_SUBMITTED ||
-			    smb->mid_state == MID_RESPONSE_RECEIVED) {
-				/* no longer considered to be "in-flight" */
-				smb->callback = release_mid;
-				spin_unlock(&smb->mid_lock);
-				return rc;
-			}
-			spin_unlock(&smb->mid_lock);
-		}
-
-		/* We got the response - restart system call. */
-		rstart = 1;
-		spin_lock(&server->srv_lock);
-	}
-	spin_unlock(&server->srv_lock);
-
-	rc = cifs_sync_mid_result(smb, server);
-	if (rc != 0)
-		return rc;
-
-	/* rcvd frame is ok */
-	if (out_buf == NULL || smb->mid_state != MID_RESPONSE_READY) {
-		rc = -EIO;
-		cifs_tcon_dbg(VFS, "Bad MID state?\n");
-		goto out;
+	if (out_buf) {
+		*pbytes_returned = resp_iov.iov_len;
+		if (resp_iov.iov_len)
+			memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
 	}
-
-	*pbytes_returned = smb->response_pdu_len;
-	memcpy(out_buf, smb->resp_buf, *pbytes_returned);
-	rc = cifs_check_receive(smb, server, 0);
-out:
-	delete_mid(smb);
-	if (rstart && rc == -EACCES)
-		return -ERESTARTSYS;
+	free_rsp_buf(resp_buf_type, resp_iov.iov_base);
 	return rc;
 }
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 93c52e4288db..fe6c0573fe76 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -29,8 +29,9 @@
  * SMB_COM_NT_CANCEL request and then sends it.
  */
 static int
-send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
-	       struct smb_message *smb)
+send_nt_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
+	       struct smb_rqst *rqst, struct smb_message *smb,
+	       unsigned int xid)
 {
 	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 	struct kvec iov[1];
@@ -70,6 +71,46 @@ send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	return rc;
 }
 
+/*
+ * Send a LOCKINGX_CANCEL_LOCK to cause the Windows blocking lock to
+ * return.
+ */
+static int
+send_lock_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
+		 struct smb_rqst *rqst, struct smb_message *smb,
+		 unsigned int xid)
+{
+	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
+	unsigned int in_len = rqst->rq_iov[0].iov_len;
+	LOCK_REQ *pSMB = (LOCK_REQ *)in_buf;
+	int rc;
+
+	/* We just modify the current in_buf to change
+	 * the type of lock from LOCKING_ANDX_SHARED_LOCK
+	 * or LOCKING_ANDX_EXCLUSIVE_LOCK to
+	 * LOCKING_ANDX_CANCEL_LOCK.
+	 */
+	pSMB->LockType = LOCKING_ANDX_CANCEL_LOCK|LOCKING_ANDX_LARGE_FILES;
+	pSMB->Timeout = 0;
+	pSMB->hdr.Mid = get_next_mid(ses->server);
+
+	rc = SendReceive(xid, ses, in_buf, in_len, NULL, NULL, 0);
+	if (rc == -ENOLCK)
+		rc = 0; /* If we get back -ENOLCK, it probably means we managed
+			 * to cancel the lock command before it took effect.
+			 */
+	return rc;
+}
+
+static int cifs_send_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
+			    struct smb_rqst *rqst, struct smb_message *smb,
+			    unsigned int xid)
+{
+	if (smb->sr_flags & CIFS_WINDOWS_LOCK)
+		return send_lock_cancel(ses, server, rqst, smb, xid);
+	return send_nt_cancel(ses, server, rqst, smb, xid);
+}
+
 static bool
 cifs_compare_fids(struct cifsFileInfo *ob1, struct cifsFileInfo *ob2)
 {
@@ -1396,7 +1437,7 @@ cifs_is_network_name_deleted(char *buf, struct TCP_Server_Info *server)
 }
 
 struct smb_version_operations smb1_operations = {
-	.send_cancel = send_nt_cancel,
+	.send_cancel = cifs_send_cancel,
 	.compare_fids = cifs_compare_fids,
 	.setup_request = cifs_setup_request,
 	.setup_async_request = cifs_setup_async_request,
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 7036acd6542b..5c4cc7015d2e 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -643,12 +643,16 @@ cifs_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
 
 int wait_for_response(struct TCP_Server_Info *server, struct smb_message *smb)
 {
+	unsigned int sleep_state = TASK_KILLABLE;
 	int error;
 
+	if (smb->sr_flags & CIFS_INTERRUPTIBLE_WAIT)
+		sleep_state = TASK_INTERRUPTIBLE;
+
 	error = wait_event_state(server->response_q,
 				 smb->mid_state != MID_REQUEST_SUBMITTED &&
 				 smb->mid_state != MID_RESPONSE_RECEIVED,
-				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
+				 (sleep_state | TASK_FREEZABLE_UNSAFE));
 	if (error < 0)
 		return -ERESTARTSYS;
 
@@ -702,6 +706,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 		return PTR_ERR(smb);
 	}
 
+	smb->sr_flags = flags;
 	smb->receive = receive;
 	smb->callback = callback;
 	smb->callback_data = cbdata;
@@ -946,6 +951,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			return PTR_ERR(smb[i]);
 		}
 
+		smb[i]->sr_flags = flags;
 		smb[i]->mid_state = MID_REQUEST_SUBMITTED;
 		smb[i]->optype = optype;
 		/*
@@ -1015,7 +1021,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
 				 smb[i]->mid, le16_to_cpu(smb[i]->command));
-			send_cancel(server, &rqst[i], smb[i]);
+			send_cancel(ses, server, &rqst[i], smb[i], xid);
 			spin_lock(&smb[i]->mid_lock);
 			smb[i]->wait_cancelled = true;
 			if (smb[i]->mid_state == MID_REQUEST_SUBMITTED ||


