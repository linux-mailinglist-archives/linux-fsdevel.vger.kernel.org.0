Return-Path: <linux-fsdevel+bounces-70399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B0C997E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79E73A5E24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25032BD580;
	Mon,  1 Dec 2025 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKSKI/3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C52BF00B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629884; cv=none; b=JOxcH0i3NgXGduuqhSe2zHGqQcYbauzZ/41fXIxQdtEpKGIczjBZ8342PXHD/I/S53ECE2PI/aiPDF20bzf721+qA4ebsJLFeEqBIZDx9HWCIW+aaUp/OSiuV1Afg8AmqYG26nYjM0f5nvMcXrFHDJreQWP1gKj9HhPS2XrdV00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629884; c=relaxed/simple;
	bh=9shAie4sAr/f0+tftu7KlEkBaGCw1PtPge1VApeTn+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYkTgIB3AK319qOKQAA7Y9StgtbQCYnWK1nqRYgZilYBbdIVhJlRktuVjqWsEUwYwc+ibBsraVom1lOhvp2PcY6DeLO5dPmcvU3TxuxcytiWLyYvOv8jipB5ZYscGcDrSBe1hFbSOSLuXmJFYLMhOQm6vApGT1wgV7o1CJSiyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKSKI/3l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764629880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl7ZBpYYdxoohEAIQbl6ngCtBsso8Yp4hKTKq4KsxRs=;
	b=AKSKI/3lWu7RknwtibGCxPFflxg5rXQGf2FRTEuehtsT85nil5+QtoYaeTNI+JFXkF5Ayq
	vEerHJhdRFxra0QtvTvii0TfWYluOnWWsQeqKAe5ITdAFpvYkVCSIzGTLa3/Z7fLGKwvPC
	Q8BM161M7RhBxQjWJyWyMsGg5iXBrss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-BO7hjacKPwa5Xq_ujMZlOA-1; Mon,
 01 Dec 2025 17:57:57 -0500
X-MC-Unique: BO7hjacKPwa5Xq_ujMZlOA-1
X-Mimecast-MFC-AGG-ID: BO7hjacKPwa5Xq_ujMZlOA_1764629876
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C7CB1800673;
	Mon,  1 Dec 2025 22:57:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A58BA195608E;
	Mon,  1 Dec 2025 22:57:53 +0000 (UTC)
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
Subject: [PATCH v6 4/9] cifs: Replace SendReceiveBlockingLock() with SendReceive() plus flags
Date: Mon,  1 Dec 2025 22:57:25 +0000
Message-ID: <20251201225732.1520128-5-dhowells@redhat.com>
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
 fs/smb/client/cifstransport.c | 199 +---------------------------------
 fs/smb/client/smb1ops.c       |  47 +++++++-
 fs/smb/client/transport.c     |  13 ++-
 6 files changed, 79 insertions(+), 216 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 1255e43a4d82..1bfaf9b71f07 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -311,8 +311,9 @@ struct cifs_open_parms;
 struct cifs_credits;
 
 struct smb_version_operations {
-	int (*send_cancel)(struct TCP_Server_Info *, struct smb_rqst *,
-			   struct mid_q_entry *);
+	int (*send_cancel)(struct cifs_ses *ses, struct TCP_Server_Info *server,
+			   struct smb_rqst *rqst, struct mid_q_entry *mid,
+			   unsigned int xid);
 	bool (*compare_fids)(struct cifsFileInfo *, struct cifsFileInfo *);
 	/* setup request: allocate mid, sign message */
 	struct mid_q_entry *(*setup_request)(struct cifs_ses *,
@@ -1689,6 +1690,7 @@ struct mid_q_entry {
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
index 13e0367e0e10..c36beed87596 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -130,11 +130,12 @@ extern int cifs_wait_mtu_credits(struct TCP_Server_Info *server,
 				 struct cifs_credits *credits);
 
 static inline int
-send_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
-	    struct mid_q_entry *mid)
+send_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
+	    struct smb_rqst *rqst, struct mid_q_entry *mid,
+	    unsigned int xid)
 {
 	return server->ops->send_cancel ?
-				server->ops->send_cancel(server, rqst, mid) : 0;
+		server->ops->send_cancel(ses, server, rqst, mid, xid) : 0;
 }
 
 int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ);
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
index 645831708e1b..f260789a5831 100644
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
index 22615890f35c..08e5a5f0103e 100644
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
@@ -261,193 +254,11 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
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
-	struct mid_q_entry *mid;
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
-	rc = allocate_mid(ses, in_buf, &mid);
-	if (rc) {
-		cifs_server_unlock(server);
-		return rc;
-	}
-
-	rc = cifs_sign_rqst(&rqst, server, &mid->sequence_number);
-	if (rc) {
-		delete_mid(mid);
-		cifs_server_unlock(server);
-		return rc;
-	}
-
-	mid->mid_state = MID_REQUEST_SUBMITTED;
-	rc = __smb_send_rqst(server, 1, &rqst);
-	cifs_save_when_sent(mid);
-
-	if (rc < 0)
-		server->sequence_number -= 2;
-
-	cifs_server_unlock(server);
-
-	if (rc < 0) {
-		delete_mid(mid);
-		return rc;
-	}
-
-	/* Wait for a reply - allow signals to interrupt. */
-	rc = wait_event_interruptible(server->response_q,
-		(!(mid->mid_state == MID_REQUEST_SUBMITTED ||
-		   mid->mid_state == MID_RESPONSE_RECEIVED)) ||
-		((server->tcpStatus != CifsGood) &&
-		 (server->tcpStatus != CifsNew)));
-
-	/* Were we interrupted by a signal ? */
-	spin_lock(&server->srv_lock);
-	if ((rc == -ERESTARTSYS) &&
-		(mid->mid_state == MID_REQUEST_SUBMITTED ||
-		 mid->mid_state == MID_RESPONSE_RECEIVED) &&
-		((server->tcpStatus == CifsGood) ||
-		 (server->tcpStatus == CifsNew))) {
-		spin_unlock(&server->srv_lock);
-
-		if (in_buf->Command == SMB_COM_TRANSACTION2) {
-			/* POSIX lock. We send a NT_CANCEL SMB to cause the
-			   blocking lock to return. */
-			rc = send_cancel(server, &rqst, mid);
-			if (rc) {
-				delete_mid(mid);
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
-				delete_mid(mid);
-				return rc;
-			}
-		}
-
-		rc = wait_for_response(server, mid);
-		if (rc) {
-			send_cancel(server, &rqst, mid);
-			spin_lock(&mid->mid_lock);
-			if (mid->callback) {
-				/* no longer considered to be "in-flight" */
-				mid->callback = release_mid;
-				spin_unlock(&mid->mid_lock);
-				return rc;
-			}
-			spin_unlock(&mid->mid_lock);
-		}
-
-		/* We got the response - restart system call. */
-		rstart = 1;
-		spin_lock(&server->srv_lock);
-	}
-	spin_unlock(&server->srv_lock);
-
-	rc = cifs_sync_mid_result(mid, server);
-	if (rc != 0)
-		return rc;
-
-	/* rcvd frame is ok */
-	if (out_buf == NULL || mid->mid_state != MID_RESPONSE_READY) {
-		rc = -EIO;
-		cifs_tcon_dbg(VFS, "Bad MID state?\n");
-		goto out;
+	if (out_buf) {
+		*pbytes_returned = resp_iov.iov_len;
+		if (resp_iov.iov_len)
+			memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
 	}
-
-	*pbytes_returned = mid->response_pdu_len;
-	memcpy(out_buf, mid->resp_buf, *pbytes_returned);
-	rc = cifs_check_receive(mid, server, 0);
-out:
-	delete_mid(mid);
-	if (rstart && rc == -EACCES)
-		return -ERESTARTSYS;
+	free_rsp_buf(resp_buf_type, resp_iov.iov_base);
 	return rc;
 }
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index f4f74a447c97..45af69d95b27 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -29,8 +29,9 @@
  * SMB_COM_NT_CANCEL request and then sends it.
  */
 static int
-send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
-	       struct mid_q_entry *mid)
+send_nt_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
+	       struct smb_rqst *rqst, struct mid_q_entry *mid,
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
+		 struct smb_rqst *rqst, struct mid_q_entry *mid,
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
+			    struct smb_rqst *rqst, struct mid_q_entry *mid,
+			    unsigned int xid)
+{
+	if (mid->sr_flags & CIFS_WINDOWS_LOCK)
+		return send_lock_cancel(ses, server, rqst, mid, xid);
+	return send_nt_cancel(ses, server, rqst, mid, xid);
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
index 07716a61564a..ea5f9e4171a9 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -642,12 +642,16 @@ cifs_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
 
 int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
+	unsigned int sleep_state = TASK_KILLABLE;
 	int error;
 
+	if (mid->sr_flags & CIFS_INTERRUPTIBLE_WAIT)
+		sleep_state = TASK_INTERRUPTIBLE;
+
 	error = wait_event_state(server->response_q,
 				 mid->mid_state != MID_REQUEST_SUBMITTED &&
 				 mid->mid_state != MID_RESPONSE_RECEIVED,
-				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
+				 (sleep_state | TASK_FREEZABLE_UNSAFE));
 	if (error < 0)
 		return -ERESTARTSYS;
 
@@ -701,6 +705,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 		return PTR_ERR(mid);
 	}
 
+	mid->sr_flags = flags;
 	mid->receive = receive;
 	mid->callback = callback;
 	mid->callback_data = cbdata;
@@ -945,6 +950,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			return PTR_ERR(mid[i]);
 		}
 
+		mid[i]->sr_flags = flags;
 		mid[i]->mid_state = MID_REQUEST_SUBMITTED;
 		mid[i]->optype = optype;
 		/*
@@ -1014,10 +1020,11 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
 				 mid[i]->mid, le16_to_cpu(mid[i]->command));
-			send_cancel(server, &rqst[i], mid[i]);
+			send_cancel(ses, server, &rqst[i], mid[i], xid);
 			spin_lock(&mid[i]->mid_lock);
 			mid[i]->wait_cancelled = true;
-			if (mid[i]->callback) {
+			if (mid[i]->mid_state == MID_REQUEST_SUBMITTED ||
+			    mid[i]->mid_state == MID_RESPONSE_RECEIVED) {
 				mid[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
 				credits[i].value = 0;


