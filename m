Return-Path: <linux-fsdevel+bounces-56889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD6B1CD9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1493BE536
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A512BEC52;
	Wed,  6 Aug 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgCQl8P1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA092BEC26
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512691; cv=none; b=qXJ66PJbQJNMhXQSwQM24GrLRH9brU13WfjPiPxukTHWZAGD8GkW2G+i6IWAW3sw+WrhvZLk/c14+xrVfgdjFuR2m8EzzmhV/iOpTFcu0qiu6zEt/9lkuxgdUfOBYPabm7jATqMou736zVZjYHuu+/w6mZbllNJ5EBg1zDK+8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512691; c=relaxed/simple;
	bh=dlpYImrdr5ig5f0eGfjCGwi/zkNFspEhX8SFybOIW6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HW9iDxtIVWs4O+7U+K3EzbMcSylCIgtAilX61sIKSeiKr10krXB+jCdnNNCzRTJaxelHNEQqsQJBzEaXvT8TWkR5I32um0tKWRlUoQq2t7creNQivxBDPv5o1VGUhdzFzcQ9fI7aKZuAbGFmq7NKU80QZiT53qM54I9re4AbBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgCQl8P1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EniwsJc+bUFAtIahAbpGM/bZVSnuaGlzZlTbBHFQ4zw=;
	b=MgCQl8P195fXgftTtU8h4itAJjPUOBZzFLZiCBMq8dQIb3ESlsVijuy/+bEDVUiLLCufCv
	Q6lbGEpsJl5DBBqaNYJmxBvibSUIXvVFAX32bFOeCrm3nWa+lmPdkJUhkEt3/dDBQtV3Km
	98tOtSkeoOO2IdMRAVH81x3Fa63rIdE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-Yr9TL-XPNROBob1EU7WrJw-1; Wed,
 06 Aug 2025 16:38:01 -0400
X-MC-Unique: Yr9TL-XPNROBob1EU7WrJw-1
X-Mimecast-MFC-AGG-ID: Yr9TL-XPNROBob1EU7WrJw_1754512679
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1044418004D4;
	Wed,  6 Aug 2025 20:37:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97D52180028E;
	Wed,  6 Aug 2025 20:37:55 +0000 (UTC)
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
Subject: [RFC PATCH 09/31] cifs: Rename SMB2_xxxx_HE to SMB2_xxxx
Date: Wed,  6 Aug 2025 21:36:30 +0100
Message-ID: <20250806203705.2560493-10-dhowells@redhat.com>
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

Rename SMB2_xxxx_HE to SMB2_xxxx as the LE variants have been got rid of.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/compress.c      |   4 +-
 fs/smb/client/smb2misc.c      |  43 ++++++-----
 fs/smb/client/smb2ops.c       |  72 +++++++++---------
 fs/smb/client/smb2pdu.c       | 134 +++++++++++++++++-----------------
 fs/smb/client/smb2transport.c |  18 ++---
 fs/smb/common/smb2pdu.h       |  40 +++++-----
 fs/smb/server/connection.c    |   2 +-
 fs/smb/server/oplock.c        |   4 +-
 fs/smb/server/smb2misc.c      |  44 +++++------
 fs/smb/server/smb2ops.c       |  46 ++++++------
 fs/smb/server/smb2pdu.c       |  42 +++++------
 fs/smb/server/smb_common.c    |   2 +-
 12 files changed, 225 insertions(+), 226 deletions(-)

diff --git a/fs/smb/client/compress.c b/fs/smb/client/compress.c
index f52710425151..3caf4b89d8a5 100644
--- a/fs/smb/client/compress.c
+++ b/fs/smb/client/compress.c
@@ -303,7 +303,7 @@ bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq)
 	if (!(tcon->share_flags & SMB2_SHAREFLAG_COMPRESS_DATA))
 		return false;
 
-	if (le16_to_cpu(shdr->Command) == SMB2_WRITE_HE) {
+	if (le16_to_cpu(shdr->Command) == SMB2_WRITE) {
 		const struct smb2_write_req *wreq = rq->rq_iov->iov_base;
 
 		if (le32_to_cpu(wreq->Length) < SMB_COMPRESS_MIN_LEN)
@@ -312,7 +312,7 @@ bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq)
 		return is_compressible(&rq->rq_iter);
 	}
 
-	return le16_to_cpu(shdr->Command) == SMB2_READ_HE;
+	return le16_to_cpu(shdr->Command) == SMB2_READ;
 }
 
 int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_send_fn send_fn)
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index f6280e3d4e55..b8e3fe26d658 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -33,7 +33,7 @@ check_smb2_hdr(struct smb2_hdr *shdr, __u64 mid)
 			return 0;
 		else {
 			/* only one valid case where server sends us request */
-			if (le16_to_cpu(shdr->Command) == SMB2_OPLOCK_BREAK_HE)
+			if (le16_to_cpu(shdr->Command) == SMB2_OPLOCK_BREAK)
 				return 0;
 			else
 				cifs_dbg(VFS, "Received Request not response\n");
@@ -209,13 +209,13 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 	}
 
 	if (smb2_rsp_struct_sizes[command] != pdu->StructureSize2) {
-		if (command != SMB2_OPLOCK_BREAK_HE && (shdr->Status == 0 ||
+		if (command != SMB2_OPLOCK_BREAK && (shdr->Status == 0 ||
 		    pdu->StructureSize2 != SMB2_ERROR_STRUCTURE_SIZE2_LE)) {
 			/* error packets have 9 byte structure size */
 			cifs_dbg(VFS, "Invalid response size %u for command %d\n",
 				 le16_to_cpu(pdu->StructureSize2), command);
 			return 1;
-		} else if (command == SMB2_OPLOCK_BREAK_HE
+		} else if (command == SMB2_OPLOCK_BREAK
 			   && (shdr->Status == 0)
 			   && (le16_to_cpu(pdu->StructureSize2) != 44)
 			   && (le16_to_cpu(pdu->StructureSize2) != 36)) {
@@ -230,19 +230,19 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 
 	/* For SMB2_IOCTL, OutputOffset and OutputLength are optional, so might
 	 * be 0, and not a real miscalculation */
-	if (command == SMB2_IOCTL_HE && calc_len == 0)
+	if (command == SMB2_IOCTL && calc_len == 0)
 		return 0;
 
-	if (command == SMB2_NEGOTIATE_HE)
+	if (command == SMB2_NEGOTIATE)
 		calc_len += get_neg_ctxt_len(shdr, len, calc_len);
 
 	if (len != calc_len) {
 		/* create failed on symlink */
-		if (command == SMB2_CREATE_HE &&
+		if (command == SMB2_CREATE &&
 		    shdr->Status == STATUS_STOPPED_ON_SYMLINK)
 			return 0;
 		/* Windows 7 server returns 24 bytes more */
-		if (calc_len + 24 == len && command == SMB2_OPLOCK_BREAK_HE)
+		if (calc_len + 24 == len && command == SMB2_OPLOCK_BREAK)
 			return 0;
 		/* server can return one byte more due to implied bcc[0] */
 		if (calc_len == len + 1)
@@ -331,48 +331,48 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
 	 * command.
 	 */
 	switch (le16_to_cpu(shdr->Command)) {
-	case SMB2_NEGOTIATE_HE:
+	case SMB2_NEGOTIATE:
 		*off = le16_to_cpu(
 		  ((struct smb2_negotiate_rsp *)shdr)->SecurityBufferOffset);
 		*len = le16_to_cpu(
 		  ((struct smb2_negotiate_rsp *)shdr)->SecurityBufferLength);
 		break;
-	case SMB2_SESSION_SETUP_HE:
+	case SMB2_SESSION_SETUP:
 		*off = le16_to_cpu(
 		  ((struct smb2_sess_setup_rsp *)shdr)->SecurityBufferOffset);
 		*len = le16_to_cpu(
 		  ((struct smb2_sess_setup_rsp *)shdr)->SecurityBufferLength);
 		break;
-	case SMB2_CREATE_HE:
+	case SMB2_CREATE:
 		*off = le32_to_cpu(
 		    ((struct smb2_create_rsp *)shdr)->CreateContextsOffset);
 		*len = le32_to_cpu(
 		    ((struct smb2_create_rsp *)shdr)->CreateContextsLength);
 		break;
-	case SMB2_QUERY_INFO_HE:
+	case SMB2_QUERY_INFO:
 		*off = le16_to_cpu(
 		    ((struct smb2_query_info_rsp *)shdr)->OutputBufferOffset);
 		*len = le32_to_cpu(
 		    ((struct smb2_query_info_rsp *)shdr)->OutputBufferLength);
 		break;
-	case SMB2_READ_HE:
+	case SMB2_READ:
 		/* TODO: is this a bug ? */
 		*off = ((struct smb2_read_rsp *)shdr)->DataOffset;
 		*len = le32_to_cpu(((struct smb2_read_rsp *)shdr)->DataLength);
 		break;
-	case SMB2_QUERY_DIRECTORY_HE:
+	case SMB2_QUERY_DIRECTORY:
 		*off = le16_to_cpu(
 		  ((struct smb2_query_directory_rsp *)shdr)->OutputBufferOffset);
 		*len = le32_to_cpu(
 		  ((struct smb2_query_directory_rsp *)shdr)->OutputBufferLength);
 		break;
-	case SMB2_IOCTL_HE:
+	case SMB2_IOCTL:
 		*off = le32_to_cpu(
 		  ((struct smb2_ioctl_rsp *)shdr)->OutputOffset);
 		*len = le32_to_cpu(
 		  ((struct smb2_ioctl_rsp *)shdr)->OutputCount);
 		break;
-	case SMB2_CHANGE_NOTIFY_HE:
+	case SMB2_CHANGE_NOTIFY:
 		*off = le16_to_cpu(
 		  ((struct smb2_change_notify_rsp *)shdr)->OutputBufferOffset);
 		*len = le32_to_cpu(
@@ -680,11 +680,10 @@ smb2_is_valid_oplock_break(char *buffer, struct TCP_Server_Info *server)
 
 	cifs_dbg(FYI, "Checking for oplock break\n");
 
-	if (rsp->hdr.Command != cpu_to_le32(SMB2_OPLOCK_BREAK_HE))
+	if (rsp->hdr.Command != cpu_to_le32(SMB2_OPLOCK_BREAK))
 		return false;
 
-	if (rsp->StructureSize !=
-				smb2_rsp_struct_sizes[SMB2_OPLOCK_BREAK_HE]) {
+	if (rsp->StructureSize != smb2_rsp_struct_sizes[SMB2_OPLOCK_BREAK]) {
 		if (le16_to_cpu(rsp->StructureSize) == 44)
 			return smb2_is_valid_lease_break(buffer, server);
 		else
@@ -830,7 +829,7 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 			    netfs_trace_tcon_ref_get_cancelled_close);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	rc = __smb2_handle_cancelled_cmd(tcon, SMB2_CLOSE_HE, 0,
+	rc = __smb2_handle_cancelled_cmd(tcon, SMB2_CLOSE, 0,
 					 persistent_fid, volatile_fid);
 	if (rc)
 		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_close);
@@ -846,7 +845,7 @@ smb2_handle_cancelled_mid(struct smb_message *smb, struct TCP_Server_Info *serve
 	struct cifs_tcon *tcon;
 	int rc;
 
-	if ((smb->optype & CIFS_CP_CREATE_CLOSE_OP) || smb->command_id != SMB2_CREATE_HE ||
+	if ((smb->optype & CIFS_CP_CREATE_CLOSE_OP) || smb->command_id != SMB2_CREATE ||
 	    hdr->Status != STATUS_SUCCESS)
 		return 0;
 
@@ -887,7 +886,7 @@ smb311_update_preauth_hash(struct cifs_ses *ses, struct TCP_Server_Info *server,
 
 	hdr = (struct smb2_hdr *)iov[0].iov_base;
 	/* neg prot are always taken */
-	if (le16_to_cpu(hdr->Command) == SMB2_NEGOTIATE_HE)
+	if (le16_to_cpu(hdr->Command) == SMB2_NEGOTIATE)
 		goto ok;
 
 	/*
@@ -898,7 +897,7 @@ smb311_update_preauth_hash(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	if (server->dialect != SMB311_PROT_ID)
 		return 0;
 
-	if (le16_to_cpu(hdr->Command) != SMB2_SESSION_SETUP_HE)
+	if (le16_to_cpu(hdr->Command) != SMB2_SESSION_SETUP)
 		return 0;
 
 	/* skip last sess setup response */
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 0116bf348a76..36c506577b0e 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1405,47 +1405,47 @@ smb2_print_stats(struct seq_file *m, struct cifs_tcon *tcon)
 		   atomic_read(&tcon->num_local_opens),
 		   atomic_read(&tcon->num_remote_opens));
 	seq_printf(m, "\nTreeConnects: %d total %d failed",
-		   atomic_read(&sent[SMB2_TREE_CONNECT_HE]),
-		   atomic_read(&failed[SMB2_TREE_CONNECT_HE]));
+		   atomic_read(&sent[SMB2_TREE_CONNECT]),
+		   atomic_read(&failed[SMB2_TREE_CONNECT]));
 	seq_printf(m, "\nTreeDisconnects: %d total %d failed",
-		   atomic_read(&sent[SMB2_TREE_DISCONNECT_HE]),
-		   atomic_read(&failed[SMB2_TREE_DISCONNECT_HE]));
+		   atomic_read(&sent[SMB2_TREE_DISCONNECT]),
+		   atomic_read(&failed[SMB2_TREE_DISCONNECT]));
 	seq_printf(m, "\nCreates: %d total %d failed",
-		   atomic_read(&sent[SMB2_CREATE_HE]),
-		   atomic_read(&failed[SMB2_CREATE_HE]));
+		   atomic_read(&sent[SMB2_CREATE]),
+		   atomic_read(&failed[SMB2_CREATE]));
 	seq_printf(m, "\nCloses: %d total %d failed",
-		   atomic_read(&sent[SMB2_CLOSE_HE]),
-		   atomic_read(&failed[SMB2_CLOSE_HE]));
+		   atomic_read(&sent[SMB2_CLOSE]),
+		   atomic_read(&failed[SMB2_CLOSE]));
 	seq_printf(m, "\nFlushes: %d total %d failed",
-		   atomic_read(&sent[SMB2_FLUSH_HE]),
-		   atomic_read(&failed[SMB2_FLUSH_HE]));
+		   atomic_read(&sent[SMB2_FLUSH]),
+		   atomic_read(&failed[SMB2_FLUSH]));
 	seq_printf(m, "\nReads: %d total %d failed",
-		   atomic_read(&sent[SMB2_READ_HE]),
-		   atomic_read(&failed[SMB2_READ_HE]));
+		   atomic_read(&sent[SMB2_READ]),
+		   atomic_read(&failed[SMB2_READ]));
 	seq_printf(m, "\nWrites: %d total %d failed",
-		   atomic_read(&sent[SMB2_WRITE_HE]),
-		   atomic_read(&failed[SMB2_WRITE_HE]));
+		   atomic_read(&sent[SMB2_WRITE]),
+		   atomic_read(&failed[SMB2_WRITE]));
 	seq_printf(m, "\nLocks: %d total %d failed",
-		   atomic_read(&sent[SMB2_LOCK_HE]),
-		   atomic_read(&failed[SMB2_LOCK_HE]));
+		   atomic_read(&sent[SMB2_LOCK]),
+		   atomic_read(&failed[SMB2_LOCK]));
 	seq_printf(m, "\nIOCTLs: %d total %d failed",
-		   atomic_read(&sent[SMB2_IOCTL_HE]),
-		   atomic_read(&failed[SMB2_IOCTL_HE]));
+		   atomic_read(&sent[SMB2_IOCTL]),
+		   atomic_read(&failed[SMB2_IOCTL]));
 	seq_printf(m, "\nQueryDirectories: %d total %d failed",
-		   atomic_read(&sent[SMB2_QUERY_DIRECTORY_HE]),
-		   atomic_read(&failed[SMB2_QUERY_DIRECTORY_HE]));
+		   atomic_read(&sent[SMB2_QUERY_DIRECTORY]),
+		   atomic_read(&failed[SMB2_QUERY_DIRECTORY]));
 	seq_printf(m, "\nChangeNotifies: %d total %d failed",
-		   atomic_read(&sent[SMB2_CHANGE_NOTIFY_HE]),
-		   atomic_read(&failed[SMB2_CHANGE_NOTIFY_HE]));
+		   atomic_read(&sent[SMB2_CHANGE_NOTIFY]),
+		   atomic_read(&failed[SMB2_CHANGE_NOTIFY]));
 	seq_printf(m, "\nQueryInfos: %d total %d failed",
-		   atomic_read(&sent[SMB2_QUERY_INFO_HE]),
-		   atomic_read(&failed[SMB2_QUERY_INFO_HE]));
+		   atomic_read(&sent[SMB2_QUERY_INFO]),
+		   atomic_read(&failed[SMB2_QUERY_INFO]));
 	seq_printf(m, "\nSetInfos: %d total %d failed",
-		   atomic_read(&sent[SMB2_SET_INFO_HE]),
-		   atomic_read(&failed[SMB2_SET_INFO_HE]));
+		   atomic_read(&sent[SMB2_SET_INFO]),
+		   atomic_read(&failed[SMB2_SET_INFO]));
 	seq_printf(m, "\nOplockBreaks: %d sent %d failed",
-		   atomic_read(&sent[SMB2_OPLOCK_BREAK_HE]),
-		   atomic_read(&failed[SMB2_OPLOCK_BREAK_HE]));
+		   atomic_read(&sent[SMB2_OPLOCK_BREAK]),
+		   atomic_read(&failed[SMB2_OPLOCK_BREAK]));
 }
 
 static void
@@ -4626,7 +4626,7 @@ handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 	int length;
 	bool use_rdma_mr = false;
 
-	if (le16_to_cpu(shdr->Command) != SMB2_READ_HE) {
+	if (le16_to_cpu(shdr->Command) != SMB2_READ) {
 		cifs_server_dbg(VFS, "only big read responses are supported\n");
 		return -EOPNOTSUPP;
 	}
@@ -5715,7 +5715,7 @@ struct smb_version_values smb20_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5737,7 +5737,7 @@ struct smb_version_values smb21_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5758,7 +5758,7 @@ struct smb_version_values smb3any_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5779,7 +5779,7 @@ struct smb_version_values smbdefault_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5800,7 +5800,7 @@ struct smb_version_values smb30_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5821,7 +5821,7 @@ struct smb_version_values smb302_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5842,7 +5842,7 @@ struct smb_version_values smb311_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 97a267ce2a62..8554a4aa001d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -230,7 +230,7 @@ smb2_reconnect(enum smb2_command smb2_command, struct cifs_tcon *tcon,
 	if (tcon == NULL)
 		return 0;
 
-	if (smb2_command == SMB2_TREE_CONNECT_HE)
+	if (smb2_command == SMB2_TREE_CONNECT)
 		return 0;
 
 	spin_lock(&tcon->tc_lock);
@@ -238,7 +238,7 @@ smb2_reconnect(enum smb2_command smb2_command, struct cifs_tcon *tcon,
 		/*
 		 * only tree disconnect allowed when disconnecting ...
 		 */
-		if (smb2_command != SMB2_TREE_DISCONNECT_HE) {
+		if (smb2_command != SMB2_TREE_DISCONNECT) {
 			spin_unlock(&tcon->tc_lock);
 			cifs_dbg(FYI, "can not send cmd %d while umounting\n",
 				 smb2_command);
@@ -269,10 +269,10 @@ smb2_reconnect(enum smb2_command smb2_command, struct cifs_tcon *tcon,
 		/*
 		 * BB Should we keep oplock break and add flush to exceptions?
 		 */
-		case SMB2_TREE_DISCONNECT_HE:
-		case SMB2_CANCEL_HE:
-		case SMB2_CLOSE_HE:
-		case SMB2_OPLOCK_BREAK_HE:
+		case SMB2_TREE_DISCONNECT:
+		case SMB2_CANCEL:
+		case SMB2_CLOSE:
+		case SMB2_OPLOCK_BREAK:
 			spin_unlock(&server->srv_lock);
 			return -EAGAIN;
 		default:
@@ -464,7 +464,7 @@ smb2_reconnect(enum smb2_command smb2_command, struct cifs_tcon *tcon,
 	ses->flags &= ~CIFS_SES_FLAG_SCALE_CHANNELS;
 	spin_unlock(&ses->ses_lock);
 
-	if (smb2_command != SMB2_INTERNAL_CMD_HE)
+	if (smb2_command != SMB2_INTERNAL_CMD)
 		mod_delayed_work(cifsiod_wq, &server->reconnect, 0);
 
 	atomic_inc(&tconInfoReconnectCount);
@@ -478,15 +478,15 @@ smb2_reconnect(enum smb2_command smb2_command, struct cifs_tcon *tcon,
 	 * case it and skip above?
 	 */
 	switch (smb2_command) {
-	case SMB2_FLUSH_HE:
-	case SMB2_READ_HE:
-	case SMB2_WRITE_HE:
-	case SMB2_LOCK_HE:
-	case SMB2_QUERY_DIRECTORY_HE:
-	case SMB2_CHANGE_NOTIFY_HE:
-	case SMB2_QUERY_INFO_HE:
-	case SMB2_SET_INFO_HE:
-	case SMB2_IOCTL_HE:
+	case SMB2_FLUSH:
+	case SMB2_READ:
+	case SMB2_WRITE:
+	case SMB2_LOCK:
+	case SMB2_QUERY_DIRECTORY:
+	case SMB2_CHANGE_NOTIFY:
+	case SMB2_QUERY_INFO:
+	case SMB2_SET_INFO:
+	case SMB2_IOCTL:
 		rc = -EAGAIN;
 		break;
 	default:
@@ -528,8 +528,8 @@ static int __smb2_plain_req_init(enum smb2_command smb2_command, struct cifs_tco
 {
 	/* BB eventually switch this to SMB2 specific small buf size */
 	switch (smb2_command) {
-	case SMB2_SET_INFO_HE:
-	case SMB2_QUERY_INFO_HE:
+	case SMB2_SET_INFO:
+	case SMB2_QUERY_INFO:
 		*request_buf = cifs_buf_get();
 		break;
 	default:
@@ -581,10 +581,10 @@ static int smb2_ioctl_req_init(u32 opcode, struct cifs_tcon *tcon,
 	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO ||
 	    (opcode == FSCTL_QUERY_NETWORK_INTERFACE_INFO &&
 	     (tcon->ses->flags & CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES)))
-		return __smb2_plain_req_init(SMB2_IOCTL_HE, tcon, server,
+		return __smb2_plain_req_init(SMB2_IOCTL, tcon, server,
 					     request_buf, total_len);
 
-	return smb2_plain_req_init(SMB2_IOCTL_HE, tcon, server,
+	return smb2_plain_req_init(SMB2_IOCTL, tcon, server,
 				   request_buf, total_len);
 }
 
@@ -1069,7 +1069,7 @@ SMB2_negotiate(const unsigned int xid,
 		return -EIO;
 	}
 
-	rc = smb2_plain_req_init(SMB2_NEGOTIATE_HE, NULL, server,
+	rc = smb2_plain_req_init(SMB2_NEGOTIATE, NULL, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -1469,7 +1469,7 @@ SMB2_sess_alloc_buffer(struct SMB2_sess_data *sess_data)
 	unsigned int total_len;
 	bool is_binding = false;
 
-	rc = smb2_plain_req_init(SMB2_SESSION_SETUP_HE, NULL, server,
+	rc = smb2_plain_req_init(SMB2_SESSION_SETUP, NULL, server,
 				 (void **) &req,
 				 &total_len);
 	if (rc)
@@ -1984,7 +1984,7 @@ SMB2_logoff(const unsigned int xid, struct cifs_ses *ses)
 	}
 	spin_unlock(&ses->chan_lock);
 
-	rc = smb2_plain_req_init(SMB2_LOGOFF_HE, NULL, ses->server,
+	rc = smb2_plain_req_init(SMB2_LOGOFF, NULL, ses->server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -2069,7 +2069,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	/* SMB2 TREE_CONNECT request must be called with TreeId == 0 */
 	tcon->tid = 0;
 	atomic_set(&tcon->num_remote_opens, 0);
-	rc = smb2_plain_req_init(SMB2_TREE_CONNECT_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_TREE_CONNECT, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc) {
 		kfree(unc_path);
@@ -2119,7 +2119,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	rsp = (struct smb2_tree_connect_rsp *)rsp_iov.iov_base;
 	trace_smb3_tcon(xid, tcon->tid, ses->Suid, tree, rc);
 	if ((rc != 0) || (rsp == NULL)) {
-		cifs_stats_fail_inc(tcon, SMB2_TREE_CONNECT_HE);
+		cifs_stats_fail_inc(tcon, SMB2_TREE_CONNECT);
 		tcon->need_reconnect = true;
 		goto tcon_error_exit;
 	}
@@ -2204,7 +2204,7 @@ SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 
 	invalidate_all_cached_dirs(tcon);
 
-	rc = smb2_plain_req_init(SMB2_TREE_DISCONNECT_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_TREE_DISCONNECT, tcon, server,
 				 (void **) &req,
 				 &total_len);
 	if (rc)
@@ -2226,7 +2226,7 @@ SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 			    &rqst, &resp_buf_type, flags, &rsp_iov);
 	cifs_small_buf_release(req);
 	if (rc) {
-		cifs_stats_fail_inc(tcon, SMB2_TREE_DISCONNECT_HE);
+		cifs_stats_fail_inc(tcon, SMB2_TREE_DISCONNECT);
 		trace_smb3_tdis_err(xid, tcon->tid, ses->Suid, rc);
 	}
 	trace_smb3_tdis_done(xid, tcon->tid, ses->Suid);
@@ -2867,7 +2867,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	}
 
 	/* resource #2: request */
-	rc = smb2_plain_req_init(SMB2_CREATE_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_CREATE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		goto err_free_path;
@@ -2965,7 +2965,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
 	if (rc) {
-		cifs_stats_fail_inc(tcon, SMB2_CREATE_HE);
+		cifs_stats_fail_inc(tcon, SMB2_CREATE);
 		trace_smb3_posix_mkdir_err(xid, tcon->tid, ses->Suid,
 					   CREATE_NOT_FILE,
 					   FILE_WRITE_ATTRIBUTES, rc);
@@ -3021,7 +3021,7 @@ SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	__le16 *copy_path;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_CREATE_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_CREATE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -3244,7 +3244,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	rsp = (struct smb2_create_rsp *)rsp_iov.iov_base;
 
 	if (rc != 0) {
-		cifs_stats_fail_inc(tcon, SMB2_CREATE_HE);
+		cifs_stats_fail_inc(tcon, SMB2_CREATE);
 		if (err_iov && rsp) {
 			*err_iov = rsp_iov;
 			*buftype = resp_buftype;
@@ -3473,17 +3473,17 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 				ses->Suid, 0, opcode, rc);
 
 	if ((rc != 0) && (rc != -EINVAL) && (rc != -E2BIG)) {
-		cifs_stats_fail_inc(tcon, SMB2_IOCTL_HE);
+		cifs_stats_fail_inc(tcon, SMB2_IOCTL);
 		goto ioctl_exit;
 	} else if (rc == -EINVAL) {
 		if ((opcode != FSCTL_SRV_COPYCHUNK_WRITE) &&
 		    (opcode != FSCTL_SRV_COPYCHUNK)) {
-			cifs_stats_fail_inc(tcon, SMB2_IOCTL_HE);
+			cifs_stats_fail_inc(tcon, SMB2_IOCTL);
 			goto ioctl_exit;
 		}
 	} else if (rc == -E2BIG) {
 		if (opcode != FSCTL_QUERY_ALLOCATED_RANGES) {
-			cifs_stats_fail_inc(tcon, SMB2_IOCTL_HE);
+			cifs_stats_fail_inc(tcon, SMB2_IOCTL);
 			goto ioctl_exit;
 		}
 	}
@@ -3576,7 +3576,7 @@ SMB2_close_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	unsigned int total_len;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_CLOSE_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_CLOSE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -3655,7 +3655,7 @@ __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
 	rsp = (struct smb2_close_rsp *)rsp_iov.iov_base;
 
 	if (rc != 0) {
-		cifs_stats_fail_inc(tcon, SMB2_CLOSE_HE);
+		cifs_stats_fail_inc(tcon, SMB2_CLOSE);
 		trace_smb3_close_err(xid, persistent_fid, tcon->tid, ses->Suid,
 				     rc);
 		goto close_exit;
@@ -3770,7 +3770,7 @@ SMB2_query_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 		     len > CIFSMaxBufSize))
 		return -EINVAL;
 
-	rc = smb2_plain_req_init(SMB2_QUERY_INFO_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_QUERY_INFO, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -3860,7 +3860,7 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 	rsp = (struct smb2_query_info_rsp *)rsp_iov.iov_base;
 
 	if (rc) {
-		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
+		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO);
 		trace_smb3_query_info_err(xid, persistent_fid, tcon->tid,
 				ses->Suid, info_class, (__u32)info_type, rc);
 		goto qinf_exit;
@@ -3971,7 +3971,7 @@ SMB2_notify_init(const unsigned int xid, struct smb_rqst *rqst,
 	unsigned int total_len;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_CHANGE_NOTIFY_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_CHANGE_NOTIFY, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -4046,7 +4046,7 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
 
 	if (rc != 0) {
-		cifs_stats_fail_inc(tcon, SMB2_CHANGE_NOTIFY_HE);
+		cifs_stats_fail_inc(tcon, SMB2_CHANGE_NOTIFY);
 		trace_smb3_notify_err(xid, persistent_fid, tcon->tid, ses->Suid,
 				(u8)watch_tree, completion_filter, rc);
 	} else {
@@ -4208,7 +4208,7 @@ void smb2_reconnect_server(struct work_struct *work)
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	list_for_each_entry_safe(tcon, tcon2, &tmp_list, rlist) {
-		rc = smb2_reconnect(SMB2_INTERNAL_CMD_HE, tcon, server, true);
+		rc = smb2_reconnect(SMB2_INTERNAL_CMD, tcon, server, true);
 		if (!rc) {
 			cifs_renegotiate_iosize(server, tcon);
 			cifs_reopen_persistent_handles(tcon);
@@ -4240,7 +4240,7 @@ void smb2_reconnect_server(struct work_struct *work)
 	/* now reconnect sessions for necessary channels */
 	list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
 		tcon->ses = ses;
-		rc = smb2_reconnect(SMB2_INTERNAL_CMD_HE, tcon, server, true);
+		rc = smb2_reconnect(SMB2_INTERNAL_CMD, tcon, server, true);
 		if (rc)
 			resched = true;
 		list_del_init(&ses->rlist);
@@ -4280,7 +4280,7 @@ SMB2_echo(struct TCP_Server_Info *server)
 	}
 	spin_unlock(&server->srv_lock);
 
-	rc = smb2_plain_req_init(SMB2_ECHO_HE, NULL, server,
+	rc = smb2_plain_req_init(SMB2_ECHO, NULL, server,
 				 (void **)&req, &total_len);
 	if (rc)
 		return rc;
@@ -4316,7 +4316,7 @@ SMB2_flush_init(const unsigned int xid, struct smb_rqst *rqst,
 	unsigned int total_len;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_FLUSH_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_FLUSH, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -4375,7 +4375,7 @@ SMB2_flush(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
 
 	if (rc != 0) {
-		cifs_stats_fail_inc(tcon, SMB2_FLUSH_HE);
+		cifs_stats_fail_inc(tcon, SMB2_FLUSH);
 		trace_smb3_flush_err(xid, persistent_fid, tcon->tid, ses->Suid,
 				     rc);
 	} else
@@ -4437,7 +4437,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	struct smb2_hdr *shdr;
 	struct TCP_Server_Info *server = io_parms->server;
 
-	rc = smb2_plain_req_init(SMB2_READ_HE, io_parms->tcon, server,
+	rc = smb2_plain_req_init(SMB2_READ, io_parms->tcon, server,
 				 (void **) &req, total_len);
 	if (rc)
 		return rc;
@@ -4606,7 +4606,7 @@ smb2_readv_callback(struct smb_message *smb)
 	}
 #endif
 	if (rdata->result && rdata->result != -ENODATA) {
-		cifs_stats_fail_inc(tcon, SMB2_READ_HE);
+		cifs_stats_fail_inc(tcon, SMB2_READ);
 		trace_smb3_read_err(rdata->rreq->debug_id,
 				    rdata->subreq.debug_index,
 				    rdata->xid,
@@ -4720,7 +4720,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 			     smb3_handle_read_data, rdata, flags,
 			     &rdata->credits);
 	if (rc) {
-		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ_HE);
+		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ);
 		trace_smb3_read_err(rdata->rreq->debug_id,
 				    subreq->debug_index,
 				    rdata->xid, io_parms.persistent_fid,
@@ -4773,7 +4773,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 
 	if (rc) {
 		if (rc != -ENODATA) {
-			cifs_stats_fail_inc(io_parms->tcon, SMB2_READ_HE);
+			cifs_stats_fail_inc(io_parms->tcon, SMB2_READ);
 			cifs_dbg(VFS, "Send error in read = %d\n", rc);
 			trace_smb3_read_err(0, 0, xid,
 					    req->PersistentFileId,
@@ -4908,7 +4908,7 @@ smb2_writev_callback(struct smb_message *smb)
 	}
 #endif
 	if (result) {
-		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
+		cifs_stats_fail_inc(tcon, SMB2_WRITE);
 		trace_smb3_write_err(wdata->rreq->debug_id,
 				     wdata->subreq.debug_index,
 				     wdata->xid,
@@ -4969,7 +4969,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	};
 	io_parms = &_io_parms;
 
-	rc = smb2_plain_req_init(SMB2_WRITE_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_WRITE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		goto out;
@@ -5089,7 +5089,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 				     io_parms->offset,
 				     io_parms->length,
 				     rc);
-		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
+		cifs_stats_fail_inc(tcon, SMB2_WRITE);
 	}
 
 async_writev_out:
@@ -5141,7 +5141,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 	if (n_vec < 1)
 		return rc;
 
-	rc = smb2_plain_req_init(SMB2_WRITE_HE, io_parms->tcon, server,
+	rc = smb2_plain_req_init(SMB2_WRITE, io_parms->tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -5188,7 +5188,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 				     io_parms->tcon->tid,
 				     io_parms->tcon->ses->Suid,
 				     io_parms->offset, io_parms->length, rc);
-		cifs_stats_fail_inc(io_parms->tcon, SMB2_WRITE_HE);
+		cifs_stats_fail_inc(io_parms->tcon, SMB2_WRITE);
 		cifs_dbg(VFS, "Send error in write = %d\n", rc);
 	} else {
 		*nbytes = le32_to_cpu(rsp->DataLength);
@@ -5374,7 +5374,7 @@ int SMB2_query_directory_init(const unsigned int xid,
 	struct kvec *iov = rqst->rq_iov;
 	int len, rc;
 
-	rc = smb2_plain_req_init(SMB2_QUERY_DIRECTORY_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_QUERY_DIRECTORY, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -5568,7 +5568,7 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
 		} else {
 			trace_smb3_query_dir_err(xid, persistent_fid, tcon->tid,
 				tcon->ses->Suid, index, 0, rc);
-			cifs_stats_fail_inc(tcon, SMB2_QUERY_DIRECTORY_HE);
+			cifs_stats_fail_inc(tcon, SMB2_QUERY_DIRECTORY);
 		}
 		goto qdir_exit;
 	}
@@ -5608,7 +5608,7 @@ SMB2_set_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	unsigned int i, total_len;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_SET_INFO_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_SET_INFO, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -5704,7 +5704,7 @@ send_set_info(const unsigned int xid, struct cifs_tcon *tcon,
 	rsp = (struct smb2_set_info_rsp *)rsp_iov.iov_base;
 
 	if (rc != 0) {
-		cifs_stats_fail_inc(tcon, SMB2_SET_INFO_HE);
+		cifs_stats_fail_inc(tcon, SMB2_SET_INFO);
 		trace_smb3_set_info_err(xid, persistent_fid, tcon->tid,
 				ses->Suid, info_class, (__u32)info_type, rc);
 	}
@@ -5782,7 +5782,7 @@ SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
 	server = cifs_pick_channel(ses);
 
 	cifs_dbg(FYI, "SMB2_oplock_break\n");
-	rc = smb2_plain_req_init(SMB2_OPLOCK_BREAK_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_OPLOCK_BREAK, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -5811,7 +5811,7 @@ SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
 			    &rqst, &resp_buf_type, flags, &rsp_iov);
 	cifs_small_buf_release(req);
 	if (rc) {
-		cifs_stats_fail_inc(tcon, SMB2_OPLOCK_BREAK_HE);
+		cifs_stats_fail_inc(tcon, SMB2_OPLOCK_BREAK);
 		cifs_dbg(FYI, "Send error in Oplock Break = %d\n", rc);
 	}
 
@@ -5868,7 +5868,7 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon,
 	if ((tcon->ses == NULL) || server == NULL)
 		return -EIO;
 
-	rc = smb2_plain_req_init(SMB2_QUERY_INFO_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_QUERY_INFO, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -5935,7 +5935,7 @@ SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon *tcon,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
 	free_qfs_info_req(&iov);
 	if (rc) {
-		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
+		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO);
 		goto posix_qfsinf_exit;
 	}
 	rsp = (struct smb2_query_info_rsp *)rsp_iov.iov_base;
@@ -6016,7 +6016,7 @@ SMB2_QFS_attr(const unsigned int xid, struct cifs_tcon *tcon,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
 	free_qfs_info_req(&iov);
 	if (rc) {
-		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
+		cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO);
 		goto qfsattr_exit;
 	}
 	rsp = (struct smb2_query_info_rsp *)rsp_iov.iov_base;
@@ -6081,7 +6081,7 @@ smb2_lockv(const unsigned int xid, struct cifs_tcon *tcon,
 
 	cifs_dbg(FYI, "smb2_lockv num lock %d\n", num_lock);
 
-	rc = smb2_plain_req_init(SMB2_LOCK_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_LOCK, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -6117,7 +6117,7 @@ smb2_lockv(const unsigned int xid, struct cifs_tcon *tcon,
 	cifs_small_buf_release(req);
 	if (rc) {
 		cifs_dbg(FYI, "Send error in smb2_lockv = %d\n", rc);
-		cifs_stats_fail_inc(tcon, SMB2_LOCK_HE);
+		cifs_stats_fail_inc(tcon, SMB2_LOCK);
 		trace_smb3_lock_err(xid, persist_fid, tcon->tid,
 				    tcon->ses->Suid, rc);
 	}
@@ -6164,7 +6164,7 @@ SMB2_lease_break(const unsigned int xid, struct cifs_tcon *tcon,
 	struct TCP_Server_Info *server = cifs_pick_channel(tcon->ses);
 
 	cifs_dbg(FYI, "SMB2_lease_break\n");
-	rc = smb2_plain_req_init(SMB2_OPLOCK_BREAK_HE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_OPLOCK_BREAK, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -6195,7 +6195,7 @@ SMB2_lease_break(const unsigned int xid, struct cifs_tcon *tcon,
 	please_key_low = (__u64 *)lease_key;
 	please_key_high = (__u64 *)(lease_key+8);
 	if (rc) {
-		cifs_stats_fail_inc(tcon, SMB2_OPLOCK_BREAK_HE);
+		cifs_stats_fail_inc(tcon, SMB2_OPLOCK_BREAK);
 		trace_smb3_lease_err(le32_to_cpu(lease_state), tcon->tid,
 			ses->Suid, *please_key_low, *please_key_high, rc);
 		cifs_dbg(FYI, "Send error in Lease Break = %d\n", rc);
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 806ced5d0783..fcf0999e77aa 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -671,7 +671,7 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 	shdr = (struct smb2_hdr *)rqst->rq_iov[0].iov_base;
 	ssr = (struct smb2_sess_setup_req *)shdr;
 
-	is_binding = le16_to_cpu(shdr->Command) == SMB2_SESSION_SETUP_HE &&
+	is_binding = le16_to_cpu(shdr->Command) == SMB2_SESSION_SETUP &&
 		(ssr->Flags & SMB2_SESSION_REQ_FLAG_BINDING);
 	is_signed = shdr->Flags & SMB2_FLAGS_SIGNED;
 
@@ -702,9 +702,9 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 	struct smb2_hdr *shdr =
 			(struct smb2_hdr *)rqst->rq_iov[0].iov_base;
 
-	if (le16_to_cpu(shdr->Command) == SMB2_NEGOTIATE_HE ||
-	    le16_to_cpu(shdr->Command) == SMB2_SESSION_SETUP_HE ||
-	    le16_to_cpu(shdr->Command) == SMB2_OPLOCK_BREAK_HE ||
+	if (le16_to_cpu(shdr->Command) == SMB2_NEGOTIATE ||
+	    le16_to_cpu(shdr->Command) == SMB2_SESSION_SETUP ||
+	    le16_to_cpu(shdr->Command) == SMB2_OPLOCK_BREAK ||
 	    server->ignore_signature ||
 	    (!server->session_estab))
 		return 0;
@@ -812,7 +812,7 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	}
 
 	if (server->tcpStatus == CifsNeedNegotiate &&
-	    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE_HE) {
+	    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE) {
 		spin_unlock(&server->srv_lock);
 		return -EAGAIN;
 	}
@@ -820,8 +820,8 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 
 	spin_lock(&ses->ses_lock);
 	if (ses->ses_status == SES_NEW) {
-		if (le16_to_cpu(shdr->Command) != SMB2_SESSION_SETUP_HE &&
-		    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE_HE) {
+		if (le16_to_cpu(shdr->Command) != SMB2_SESSION_SETUP &&
+		    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE) {
 			spin_unlock(&ses->ses_lock);
 			return -EAGAIN;
 		}
@@ -829,7 +829,7 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	}
 
 	if (ses->ses_status == SES_EXITING) {
-		if (le16_to_cpu(shdr->Command) != SMB2_LOGOFF_HE) {
+		if (le16_to_cpu(shdr->Command) != SMB2_LOGOFF) {
 			spin_unlock(&ses->ses_lock);
 			return -EAGAIN;
 		}
@@ -910,7 +910,7 @@ smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsNeedNegotiate &&
-	    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE_HE) {
+	    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE) {
 		spin_unlock(&server->srv_lock);
 		return ERR_PTR(-EAGAIN);
 	}
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 2f4b158518cd..7da40d229ab5 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -16,29 +16,29 @@
 
 /* List of commands in host endian */
 enum smb2_command {
-    SMB2_NEGOTIATE_HE			= 0x0000,
-    SMB2_SESSION_SETUP_HE		= 0x0001,
-    SMB2_LOGOFF_HE			= 0x0002, /* trivial request/resp */
-    SMB2_TREE_CONNECT_HE		= 0x0003,
-    SMB2_TREE_DISCONNECT_HE		= 0x0004, /* trivial req/resp */
-    SMB2_CREATE_HE			= 0x0005,
-    SMB2_CLOSE_HE			= 0x0006,
-    SMB2_FLUSH_HE			= 0x0007, /* trivial resp */
-    SMB2_READ_HE			= 0x0008,
-    SMB2_WRITE_HE			= 0x0009,
-    SMB2_LOCK_HE			= 0x000A,
-    SMB2_IOCTL_HE			= 0x000B,
-    SMB2_CANCEL_HE			= 0x000C,
-    SMB2_ECHO_HE			= 0x000D,
-    SMB2_QUERY_DIRECTORY_HE		= 0x000E,
-    SMB2_CHANGE_NOTIFY_HE		= 0x000F,
-    SMB2_QUERY_INFO_HE			= 0x0010,
-    SMB2_SET_INFO_HE			= 0x0011,
-    SMB2_OPLOCK_BREAK_HE		= 0x0012,
+    SMB2_NEGOTIATE		= 0x0000,
+    SMB2_SESSION_SETUP		= 0x0001,
+    SMB2_LOGOFF			= 0x0002, /* trivial request/resp */
+    SMB2_TREE_CONNECT		= 0x0003,
+    SMB2_TREE_DISCONNECT	= 0x0004, /* trivial req/resp */
+    SMB2_CREATE			= 0x0005,
+    SMB2_CLOSE			= 0x0006,
+    SMB2_FLUSH			= 0x0007, /* trivial resp */
+    SMB2_READ			= 0x0008,
+    SMB2_WRITE			= 0x0009,
+    SMB2_LOCK			= 0x000A,
+    SMB2_IOCTL			= 0x000B,
+    SMB2_CANCEL			= 0x000C,
+    SMB2_ECHO			= 0x000D,
+    SMB2_QUERY_DIRECTORY	= 0x000E,
+    SMB2_CHANGE_NOTIFY		= 0x000F,
+    SMB2_QUERY_INFO		= 0x0010,
+    SMB2_SET_INFO		= 0x0011,
+    SMB2_OPLOCK_BREAK		= 0x0012,
     SMB2_SERVER_TO_CLIENT_NOTIFICATION	= 0x0013
 };
 
-#define SMB2_INTERNAL_CMD_HE		0xFFFF
+#define SMB2_INTERNAL_CMD	0xFFFF
 
 #define NUMBER_OF_SMB2_COMMANDS	0x0013
 
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 3f04a2977ba8..b9914c88f5c5 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -118,7 +118,7 @@ void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	struct list_head *requests_queue = NULL;
 
-	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE)
+	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL)
 		requests_queue = &conn->requests;
 
 	atomic_inc(&conn->req_running);
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index dd3c046aeae3..d99842336c62 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -642,7 +642,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
-	rsp_hdr->Command = cpu_to_le16(SMB2_OPLOCK_BREAK_HE);
+	rsp_hdr->Command = cpu_to_le16(SMB2_OPLOCK_BREAK);
 	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
 	rsp_hdr->NextCommand = 0;
 	rsp_hdr->MessageId = cpu_to_le64(-1);
@@ -749,7 +749,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
-	rsp_hdr->Command = cpu_to_le16(SMB2_OPLOCK_BREAK_HE);
+	rsp_hdr->Command = cpu_to_le16(SMB2_OPLOCK_BREAK);
 	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
 	rsp_hdr->NextCommand = 0;
 	rsp_hdr->MessageId = cpu_to_le64(-1);
diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index 41323492f214..faa0346ca21c 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -96,17 +96,17 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 	 * command.
 	 */
 	switch (le16_to_cpu(hdr->Command)) {
-	case SMB2_SESSION_SETUP_HE:
+	case SMB2_SESSION_SETUP:
 		*off = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferOffset);
 		*len = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
 		break;
-	case SMB2_TREE_CONNECT_HE:
+	case SMB2_TREE_CONNECT:
 		*off = max_t(unsigned short int,
 			     le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset),
 			     offsetof(struct smb2_tree_connect_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathLength);
 		break;
-	case SMB2_CREATE_HE:
+	case SMB2_CREATE:
 	{
 		unsigned short int name_off =
 			max_t(unsigned short int,
@@ -131,23 +131,23 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = name_len;
 		break;
 	}
-	case SMB2_QUERY_INFO_HE:
+	case SMB2_QUERY_INFO:
 		*off = max_t(unsigned int,
 			     le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset),
 			     offsetof(struct smb2_query_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferLength);
 		break;
-	case SMB2_SET_INFO_HE:
+	case SMB2_SET_INFO:
 		*off = max_t(unsigned int,
 			     le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset),
 			     offsetof(struct smb2_set_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_set_info_req *)hdr)->BufferLength);
 		break;
-	case SMB2_READ_HE:
+	case SMB2_READ:
 		*off = le16_to_cpu(((struct smb2_read_req *)hdr)->ReadChannelInfoOffset);
 		*len = le16_to_cpu(((struct smb2_read_req *)hdr)->ReadChannelInfoLength);
 		break;
-	case SMB2_WRITE_HE:
+	case SMB2_WRITE:
 		if (((struct smb2_write_req *)hdr)->DataOffset ||
 		    ((struct smb2_write_req *)hdr)->Length) {
 			*off = max_t(unsigned short int,
@@ -160,13 +160,13 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*off = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoOffset);
 		*len = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
 		break;
-	case SMB2_QUERY_DIRECTORY_HE:
+	case SMB2_QUERY_DIRECTORY:
 		*off = max_t(unsigned short int,
 			     le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset),
 			     offsetof(struct smb2_query_directory_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameLength);
 		break;
-	case SMB2_LOCK_HE:
+	case SMB2_LOCK:
 	{
 		unsigned short lock_count;
 
@@ -177,7 +177,7 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		}
 		break;
 	}
-	case SMB2_IOCTL_HE:
+	case SMB2_IOCTL:
 		*off = max_t(unsigned int,
 			     le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset),
 			     offsetof(struct smb2_ioctl_req, Buffer));
@@ -226,7 +226,7 @@ static int smb2_calc_size(void *buf, unsigned int *len)
 	 * regardless of number of locks. Subtract single
 	 * smb2_lock_element for correct buffer size check.
 	 */
-	if (le16_to_cpu(hdr->Command) == SMB2_LOCK_HE)
+	if (le16_to_cpu(hdr->Command) == SMB2_LOCK)
 		*len -= sizeof(struct smb2_lock_element);
 
 	if (has_smb2_data_area[le16_to_cpu(hdr->Command)] == false)
@@ -307,26 +307,26 @@ static int smb2_validate_credit_charge(struct ksmbd_conn *conn,
 	int ret = 0;
 
 	switch (le16_to_cpu(hdr->Command)) {
-	case SMB2_QUERY_INFO_HE:
+	case SMB2_QUERY_INFO:
 		req_len = smb2_query_info_req_len(__hdr);
 		break;
-	case SMB2_SET_INFO_HE:
+	case SMB2_SET_INFO:
 		req_len = smb2_set_info_req_len(__hdr);
 		break;
-	case SMB2_READ_HE:
+	case SMB2_READ:
 		req_len = smb2_read_req_len(__hdr);
 		break;
-	case SMB2_WRITE_HE:
+	case SMB2_WRITE:
 		req_len = smb2_write_req_len(__hdr);
 		break;
-	case SMB2_QUERY_DIRECTORY_HE:
+	case SMB2_QUERY_DIRECTORY:
 		req_len = smb2_query_dir_req_len(__hdr);
 		break;
-	case SMB2_IOCTL_HE:
+	case SMB2_IOCTL:
 		req_len = smb2_ioctl_req_len(__hdr);
 		expect_resp_len = smb2_ioctl_resp_len(__hdr);
 		break;
-	case SMB2_CANCEL_HE:
+	case SMB2_CANCEL:
 		return 0;
 	default:
 		req_len = 1;
@@ -401,7 +401,7 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	}
 
 	if (smb2_req_struct_sizes[command] != pdu->StructureSize2) {
-		if (!(command == SMB2_OPLOCK_BREAK_HE &&
+		if (!(command == SMB2_OPLOCK_BREAK &&
 		    (le16_to_cpu(pdu->StructureSize2) == OP_BREAK_STRUCT_SIZE_20 ||
 		    le16_to_cpu(pdu->StructureSize2) == OP_BREAK_STRUCT_SIZE_21))) {
 			/* special case for SMB2.1 lease break message */
@@ -414,7 +414,7 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 
 	req_struct_size = le16_to_cpu(pdu->StructureSize2) +
 		__SMB2_HEADER_STRUCTURE_SIZE;
-	if (command == SMB2_LOCK_HE)
+	if (command == SMB2_LOCK)
 		req_struct_size -= sizeof(struct smb2_lock_element);
 
 	if (req_struct_size > len + 1)
@@ -439,7 +439,7 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 		 * SMB2 NEGOTIATE request will be validated when message
 		 * handling proceeds.
 		 */
-		if (command == SMB2_NEGOTIATE_HE)
+		if (command == SMB2_NEGOTIATE)
 			goto validate_credit;
 
 		/*
@@ -469,5 +469,5 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 
 int smb2_negotiate_request(struct ksmbd_work *work)
 {
-	return ksmbd_smb_negotiate_common(work, SMB2_NEGOTIATE_HE);
+	return ksmbd_smb_negotiate_common(work, SMB2_NEGOTIATE);
 }
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index c9302dd71e53..a528f53b9be6 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -27,7 +27,7 @@ static struct smb_version_values smb21_server_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -53,7 +53,7 @@ static struct smb_version_values smb30_server_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -80,7 +80,7 @@ static struct smb_version_values smb302_server_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -107,7 +107,7 @@ static struct smb_version_values smb311_server_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK_HE,
+	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -169,25 +169,25 @@ static struct smb_version_ops smb3_11_server_ops = {
 };
 
 static struct smb_version_cmds smb2_0_server_cmds[NUMBER_OF_SMB2_COMMANDS] = {
-	[SMB2_NEGOTIATE_HE]	=	{ .proc = smb2_negotiate_request, },
-	[SMB2_SESSION_SETUP_HE] =	{ .proc = smb2_sess_setup, },
-	[SMB2_TREE_CONNECT_HE]  =	{ .proc = smb2_tree_connect,},
-	[SMB2_TREE_DISCONNECT_HE]  =	{ .proc = smb2_tree_disconnect,},
-	[SMB2_LOGOFF_HE]	=	{ .proc = smb2_session_logoff,},
-	[SMB2_CREATE_HE]	=	{ .proc = smb2_open},
-	[SMB2_QUERY_INFO_HE]	=	{ .proc = smb2_query_info},
-	[SMB2_QUERY_DIRECTORY_HE] =	{ .proc = smb2_query_dir},
-	[SMB2_CLOSE_HE]		=	{ .proc = smb2_close},
-	[SMB2_ECHO_HE]		=	{ .proc = smb2_echo},
-	[SMB2_SET_INFO_HE]      =       { .proc = smb2_set_info},
-	[SMB2_READ_HE]		=	{ .proc = smb2_read},
-	[SMB2_WRITE_HE]		=	{ .proc = smb2_write},
-	[SMB2_FLUSH_HE]		=	{ .proc = smb2_flush},
-	[SMB2_CANCEL_HE]	=	{ .proc = smb2_cancel},
-	[SMB2_LOCK_HE]		=	{ .proc = smb2_lock},
-	[SMB2_IOCTL_HE]		=	{ .proc = smb2_ioctl},
-	[SMB2_OPLOCK_BREAK_HE]	=	{ .proc = smb2_oplock_break},
-	[SMB2_CHANGE_NOTIFY_HE]	=	{ .proc = smb2_notify},
+	[SMB2_NEGOTIATE]	=	{ .proc = smb2_negotiate_request, },
+	[SMB2_SESSION_SETUP]	=	{ .proc = smb2_sess_setup, },
+	[SMB2_TREE_CONNECT]	=	{ .proc = smb2_tree_connect,},
+	[SMB2_TREE_DISCONNECT]  =	{ .proc = smb2_tree_disconnect,},
+	[SMB2_LOGOFF]		=	{ .proc = smb2_session_logoff,},
+	[SMB2_CREATE]		=	{ .proc = smb2_open},
+	[SMB2_QUERY_INFO]	=	{ .proc = smb2_query_info},
+	[SMB2_QUERY_DIRECTORY]	=	{ .proc = smb2_query_dir},
+	[SMB2_CLOSE]		=	{ .proc = smb2_close},
+	[SMB2_ECHO]		=	{ .proc = smb2_echo},
+	[SMB2_SET_INFO]		=       { .proc = smb2_set_info},
+	[SMB2_READ]		=	{ .proc = smb2_read},
+	[SMB2_WRITE]		=	{ .proc = smb2_write},
+	[SMB2_FLUSH]		=	{ .proc = smb2_flush},
+	[SMB2_CANCEL]		=	{ .proc = smb2_cancel},
+	[SMB2_LOCK]		=	{ .proc = smb2_lock},
+	[SMB2_IOCTL]		=	{ .proc = smb2_ioctl},
+	[SMB2_OPLOCK_BREAK]	=	{ .proc = smb2_oplock_break},
+	[SMB2_CHANGE_NOTIFY]	=	{ .proc = smb2_notify},
 };
 
 /**
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 74749c60d9f6..1ed2bcba649f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -94,9 +94,9 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	unsigned int tree_id;
 
-	if (cmd == SMB2_TREE_CONNECT_HE ||
-	    cmd ==  SMB2_CANCEL_HE ||
-	    cmd ==  SMB2_LOGOFF_HE) {
+	if (cmd == SMB2_TREE_CONNECT ||
+	    cmd == SMB2_CANCEL ||
+	    cmd == SMB2_LOGOFF) {
 		ksmbd_debug(SMB, "skip to check tree connect request\n");
 		return 0;
 	}
@@ -181,7 +181,7 @@ bool is_smb2_neg_cmd(struct ksmbd_work *work)
 	if (hdr->Flags & SMB2_FLAGS_SERVER_TO_REDIR)
 		return false;
 
-	if (le16_to_cpu(hdr->Command) != SMB2_NEGOTIATE_HE)
+	if (le16_to_cpu(hdr->Command) != SMB2_NEGOTIATE)
 		return false;
 
 	return true;
@@ -262,7 +262,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(2);
-	rsp_hdr->Command = cpu_to_le16(SMB2_NEGOTIATE_HE);
+	rsp_hdr->Command = cpu_to_le16(SMB2_NEGOTIATE);
 	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
 	rsp_hdr->NextCommand = 0;
 	rsp_hdr->MessageId = 0;
@@ -349,7 +349,7 @@ int smb2_set_rsp_credits(struct ksmbd_work *work)
 	 * TODO: Need to adjuct CreditRequest value according to
 	 * current cpu load
 	 */
-	if (le16_to_cpu(hdr->Command) == SMB2_NEGOTIATE_HE)
+	if (le16_to_cpu(hdr->Command) == SMB2_NEGOTIATE)
 		aux_max = 1;
 	else
 		aux_max = conn->vals->max_credits - conn->total_credits;
@@ -389,7 +389,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
 	/* Storing the current local FID which may be needed by subsequent
 	 * command in the compound request
 	 */
-	if (req->Command == cpu_to_le16(SMB2_CREATE_HE) && rsp->Status == STATUS_SUCCESS) {
+	if (req->Command == cpu_to_le16(SMB2_CREATE) && rsp->Status == STATUS_SUCCESS) {
 		work->compound_fid = ((struct smb2_create_rsp *)rsp)->VolatileFileId;
 		work->compound_pfid = ((struct smb2_create_rsp *)rsp)->PersistentFileId;
 		work->compound_sid = le64_to_cpu(rsp->SessionId);
@@ -532,10 +532,10 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	size_t sz = small_sz;
 	int cmd = le16_to_cpu(hdr->Command);
 
-	if (cmd == SMB2_IOCTL_HE || cmd == SMB2_QUERY_DIRECTORY_HE)
+	if (cmd == SMB2_IOCTL || cmd == SMB2_QUERY_DIRECTORY)
 		sz = large_sz;
 
-	if (cmd == SMB2_QUERY_INFO_HE) {
+	if (cmd == SMB2_QUERY_INFO) {
 		struct smb2_query_info_req *req;
 
 		if (get_rfc1002_len(work->request_buf) <
@@ -580,8 +580,8 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	 * require a session id, so no need to validate user session's for
 	 * these commands.
 	 */
-	if (cmd == SMB2_ECHO_HE || cmd == SMB2_NEGOTIATE_HE ||
-	    cmd == SMB2_SESSION_SETUP_HE)
+	if (cmd == SMB2_ECHO || cmd == SMB2_NEGOTIATE ||
+	    cmd == SMB2_SESSION_SETUP)
 		return 0;
 
 	if (!ksmbd_conn_good(conn))
@@ -8819,9 +8819,9 @@ bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
 	struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);
 
 	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
-	    command != SMB2_NEGOTIATE_HE &&
-	    command != SMB2_SESSION_SETUP_HE &&
-	    command != SMB2_OPLOCK_BREAK_HE)
+	    command != SMB2_NEGOTIATE &&
+	    command != SMB2_SESSION_SETUP &&
+	    command != SMB2_OPLOCK_BREAK)
 		return true;
 
 	return false;
@@ -8887,7 +8887,7 @@ void smb2_set_sign_rsp(struct ksmbd_work *work)
 	hdr->Flags |= SMB2_FLAGS_SIGNED;
 	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 
-	if (hdr->Command == cpu_to_le16(SMB2_READ_HE)) {
+	if (hdr->Command == cpu_to_le16(SMB2_READ)) {
 		iov = &work->iov[work->iov_idx - 1];
 		n_vec++;
 	} else {
@@ -8928,7 +8928,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 		len = get_rfc1002_len(work->request_buf) -
 			work->next_smb2_rcv_hdr_off;
 
-	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
+	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
 		chann = lookup_chann_list(work->sess, conn);
@@ -8977,7 +8977,7 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	hdr = ksmbd_resp_buf_curr(work);
 
 	if (conn->binding == false &&
-	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
+	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
 		chann = lookup_chann_list(work->sess, work->conn);
@@ -8993,7 +8993,7 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	hdr->Flags |= SMB2_FLAGS_SIGNED;
 	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 
-	if (hdr->Command == cpu_to_le16(SMB2_READ_HE)) {
+	if (hdr->Command == cpu_to_le16(SMB2_READ)) {
 		iov = &work->iov[work->iov_idx - 1];
 		n_vec++;
 	} else {
@@ -9021,12 +9021,12 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 
 	WORK_BUFFERS(work, req, rsp);
 
-	if (le16_to_cpu(req->Command) == SMB2_NEGOTIATE_HE &&
+	if (le16_to_cpu(req->Command) == SMB2_NEGOTIATE &&
 	    conn->preauth_info)
 		ksmbd_gen_preauth_integrity_hash(conn, work->response_buf,
 						 conn->preauth_info->Preauth_HashValue);
 
-	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP_HE && sess) {
+	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP && sess) {
 		__u8 *hash_value;
 
 		if (conn->binding) {
@@ -9149,7 +9149,7 @@ bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		rsp = ksmbd_resp_buf_next(work);
 
-	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP_HE &&
+	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP &&
 	    sess->user && !user_guest(sess->user) &&
 	    rsp->Status == STATUS_SUCCESS)
 		return true;
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 425c756bcfb8..0e6250483776 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -596,7 +596,7 @@ int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command)
 		ksmbd_negotiate_smb_dialect(work->request_buf);
 	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
 
-	if (command == SMB2_NEGOTIATE_HE) {
+	if (command == SMB2_NEGOTIATE) {
 		ret = smb2_handle_negotiate(work);
 		return ret;
 	}


