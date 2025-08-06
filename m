Return-Path: <linux-fsdevel+bounces-56888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F12B1CD99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453BE3BA1D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FA228C2BE;
	Wed,  6 Aug 2025 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSw2Ahuo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718612BE7AF
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512683; cv=none; b=gh1aGb9MwZZxLKwAW79k8f4yuHveb6p2rGneLRAyjfKQ6Ov0tpNjah08jFxwhMod94R/NnlJxj1I9KHB1ALipwvLGk8QgMk0V8gntjpWvzzjsMowUf2Sog/6OlBbrh+r48XINq5rcMcHONbGms45JdTxf1NCE/Hv6ZiTxBYMRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512683; c=relaxed/simple;
	bh=HlJtVDS0CF+uKYV5ZU3bq02nbBAOUiTNb80hlbh7iCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoFf9w+hVD7olqFzyioQY3bV9SDb8BxRzo9Ew/nb0dneZRpR2kz3hFJH1og0ZRwBryyNgTibzgmFD11x7t22U0WPYrKcIITGGTOcFo70YmA80pnKlj5L3XSPiu+RxK81TjmY11WRNPMt0XgByzFafDTzn9J8Fjl3flYFmqLUT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSw2Ahuo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvmKYWxdl2Sd25IFOAPHPXp2nwfzUjCOfR+tUgjELuI=;
	b=FSw2AhuoNUFZnHIDJttuiAeXOLRBFAA+WO5lCu+w6esKpg8bLsJYhEqM0Kuyy/q3UuJL7P
	+yRwFfMTwdglncjsPcZHohpAeNyEP3dq+8KEFjfVjNnFrWKxlpOpkRZrC6vSiCjvgMq0gk
	mqYs+XAEJGNLKX9xwX/tj14+ZEUsF8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-P9A-xUo3NDaKZHvKCtkLJw-1; Wed,
 06 Aug 2025 16:37:55 -0400
X-MC-Unique: P9A-xUo3NDaKZHvKCtkLJw-1
X-Mimecast-MFC-AGG-ID: P9A-xUo3NDaKZHvKCtkLJw_1754512674
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48CD719560B4;
	Wed,  6 Aug 2025 20:37:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABABF180035C;
	Wed,  6 Aug 2025 20:37:50 +0000 (UTC)
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
Subject: [RFC PATCH 08/31] cifs: Keep the CPU-endian command ID around
Date: Wed,  6 Aug 2025 21:36:29 +0100
Message-ID: <20250806203705.2560493-9-dhowells@redhat.com>
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

Because the command IDs are small integers in a sequence, the C compiler
can generate better code if they're cpu-endian.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifs_debug.c    |   2 +-
 fs/smb/client/cifsglob.h      |   4 +-
 fs/smb/client/cifstransport.c |   4 +-
 fs/smb/client/compress.c      |   4 +-
 fs/smb/client/smb1ops.c       |   3 +-
 fs/smb/client/smb2misc.c      |  30 +++++-----
 fs/smb/client/smb2ops.c       |  19 ++++---
 fs/smb/client/smb2pdu.c       | 103 ++++++++++++++++++----------------
 fs/smb/client/smb2transport.c |  20 +++----
 fs/smb/client/transport.c     |  12 ++--
 fs/smb/common/smb2pdu.h       |  68 +++++++++-------------
 fs/smb/server/oplock.c        |   4 +-
 fs/smb/server/smb2misc.c      |  40 ++++++-------
 fs/smb/server/smb2ops.c       |   8 +--
 fs/smb/server/smb2pdu.c       |  14 ++---
 15 files changed, 162 insertions(+), 173 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 163e8954b940..cba30f339d6b 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -627,7 +627,7 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 				list_for_each_entry(smb, &chan_server->pending_mid_q, qhead) {
 					seq_printf(m, "\n\t\tState: %d com: %d pid: %d cbdata: %p mid %llu",
 						   smb->mid_state,
-						   le16_to_cpu(smb->command),
+						   smb->command_id,
 						   smb->pid,
 						   smb->callback_data,
 						   smb->mid);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 5d523099e298..60350213a02b 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -647,7 +647,7 @@ struct smb_version_values {
 	size_t		header_size;
 	size_t		max_header_size;
 	size_t		read_rsp_size;
-	__le16		lock_cmd;
+	enum smb2_command lock_cmd;
 	unsigned int	cap_unix;
 	unsigned int	cap_nt_find;
 	unsigned int	cap_large_files;
@@ -1728,8 +1728,8 @@ struct smb_message {
 	int mid_state;	/* wish this were enum but can not pass to wait_event */
 	int mid_rc;		/* rc for MID_RC */
 	unsigned int mid_flags;
-	__le16 command;		/* smb command code */
 	unsigned int optype;	/* operation type */
+	enum smb2_command command_id;	/* smb command code */
 	bool large_buf:1;	/* if valid response, is pointer to large buf */
 	bool multiRsp:1;	/* multiple trans2 responses for one request  */
 	bool multiEnd:1;	/* both received */
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 20709ae52d26..a3400a757968 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -48,8 +48,8 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 	kref_init(&smb->refcount);
 	smb->mid = get_mid(smb_buffer);
 	smb->pid = current->pid;
-	smb->command = cpu_to_le16(smb_buffer->Command);
-	cifs_dbg(FYI, "For smb_command %d\n", smb_buffer->Command);
+	smb->command_id = le16_to_cpu(smb_buffer->Command);
+	cifs_dbg(FYI, "For smb_command %d\n", smb->command_id);
 	/* easier to use jiffies */
 	/* when mid allocated can be before when sent */
 	smb->when_alloc = jiffies;
diff --git a/fs/smb/client/compress.c b/fs/smb/client/compress.c
index 766b4de13da7..f52710425151 100644
--- a/fs/smb/client/compress.c
+++ b/fs/smb/client/compress.c
@@ -303,7 +303,7 @@ bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq)
 	if (!(tcon->share_flags & SMB2_SHAREFLAG_COMPRESS_DATA))
 		return false;
 
-	if (shdr->Command == SMB2_WRITE) {
+	if (le16_to_cpu(shdr->Command) == SMB2_WRITE_HE) {
 		const struct smb2_write_req *wreq = rq->rq_iov->iov_base;
 
 		if (le32_to_cpu(wreq->Length) < SMB_COMPRESS_MIN_LEN)
@@ -312,7 +312,7 @@ bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq)
 		return is_compressible(&rq->rq_iter);
 	}
 
-	return (shdr->Command == SMB2_READ);
+	return le16_to_cpu(shdr->Command) == SMB2_READ_HE;
 }
 
 int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_send_fn send_fn)
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index ba301c94d4ff..dc2daba936e2 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -93,12 +93,13 @@ cifs_find_mid(struct TCP_Server_Info *server, char *buffer)
 {
 	struct smb_hdr *buf = (struct smb_hdr *)buffer;
 	struct smb_message *smb;
+	enum smb2_command command = le16_to_cpu(buf->Command);
 
 	spin_lock(&server->mid_lock);
 	list_for_each_entry(smb, &server->pending_mid_q, qhead) {
 		if (compare_mid(smb->mid, buf) &&
 		    smb->mid_state == MID_REQUEST_SUBMITTED &&
-		    le16_to_cpu(smb->command) == buf->Command) {
+		    smb->command_id == command) {
 			kref_get(&smb->refcount);
 			spin_unlock(&server->mid_lock);
 			return smb;
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index f1b0546c7858..f6280e3d4e55 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -33,7 +33,7 @@ check_smb2_hdr(struct smb2_hdr *shdr, __u64 mid)
 			return 0;
 		else {
 			/* only one valid case where server sends us request */
-			if (shdr->Command == SMB2_OPLOCK_BREAK)
+			if (le16_to_cpu(shdr->Command) == SMB2_OPLOCK_BREAK_HE)
 				return 0;
 			else
 				cifs_dbg(VFS, "Received Request not response\n");
@@ -138,9 +138,9 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 	struct TCP_Server_Info *pserver;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	struct smb2_pdu *pdu = (struct smb2_pdu *)shdr;
+	enum smb2_command command;
 	int hdr_size = sizeof(struct smb2_hdr);
 	int pdu_size = sizeof(struct smb2_pdu);
-	int command;
 	__u32 calc_len; /* calculated length */
 	__u64 mid;
 
@@ -330,49 +330,49 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
 	 * of the data buffer offset and data buffer length for the particular
 	 * command.
 	 */
-	switch (shdr->Command) {
-	case SMB2_NEGOTIATE:
+	switch (le16_to_cpu(shdr->Command)) {
+	case SMB2_NEGOTIATE_HE:
 		*off = le16_to_cpu(
 		  ((struct smb2_negotiate_rsp *)shdr)->SecurityBufferOffset);
 		*len = le16_to_cpu(
 		  ((struct smb2_negotiate_rsp *)shdr)->SecurityBufferLength);
 		break;
-	case SMB2_SESSION_SETUP:
+	case SMB2_SESSION_SETUP_HE:
 		*off = le16_to_cpu(
 		  ((struct smb2_sess_setup_rsp *)shdr)->SecurityBufferOffset);
 		*len = le16_to_cpu(
 		  ((struct smb2_sess_setup_rsp *)shdr)->SecurityBufferLength);
 		break;
-	case SMB2_CREATE:
+	case SMB2_CREATE_HE:
 		*off = le32_to_cpu(
 		    ((struct smb2_create_rsp *)shdr)->CreateContextsOffset);
 		*len = le32_to_cpu(
 		    ((struct smb2_create_rsp *)shdr)->CreateContextsLength);
 		break;
-	case SMB2_QUERY_INFO:
+	case SMB2_QUERY_INFO_HE:
 		*off = le16_to_cpu(
 		    ((struct smb2_query_info_rsp *)shdr)->OutputBufferOffset);
 		*len = le32_to_cpu(
 		    ((struct smb2_query_info_rsp *)shdr)->OutputBufferLength);
 		break;
-	case SMB2_READ:
+	case SMB2_READ_HE:
 		/* TODO: is this a bug ? */
 		*off = ((struct smb2_read_rsp *)shdr)->DataOffset;
 		*len = le32_to_cpu(((struct smb2_read_rsp *)shdr)->DataLength);
 		break;
-	case SMB2_QUERY_DIRECTORY:
+	case SMB2_QUERY_DIRECTORY_HE:
 		*off = le16_to_cpu(
 		  ((struct smb2_query_directory_rsp *)shdr)->OutputBufferOffset);
 		*len = le32_to_cpu(
 		  ((struct smb2_query_directory_rsp *)shdr)->OutputBufferLength);
 		break;
-	case SMB2_IOCTL:
+	case SMB2_IOCTL_HE:
 		*off = le32_to_cpu(
 		  ((struct smb2_ioctl_rsp *)shdr)->OutputOffset);
 		*len = le32_to_cpu(
 		  ((struct smb2_ioctl_rsp *)shdr)->OutputCount);
 		break;
-	case SMB2_CHANGE_NOTIFY:
+	case SMB2_CHANGE_NOTIFY_HE:
 		*off = le16_to_cpu(
 		  ((struct smb2_change_notify_rsp *)shdr)->OutputBufferOffset);
 		*len = le32_to_cpu(
@@ -680,7 +680,7 @@ smb2_is_valid_oplock_break(char *buffer, struct TCP_Server_Info *server)
 
 	cifs_dbg(FYI, "Checking for oplock break\n");
 
-	if (rsp->hdr.Command != SMB2_OPLOCK_BREAK)
+	if (rsp->hdr.Command != cpu_to_le32(SMB2_OPLOCK_BREAK_HE))
 		return false;
 
 	if (rsp->StructureSize !=
@@ -846,7 +846,7 @@ smb2_handle_cancelled_mid(struct smb_message *smb, struct TCP_Server_Info *serve
 	struct cifs_tcon *tcon;
 	int rc;
 
-	if ((smb->optype & CIFS_CP_CREATE_CLOSE_OP) || hdr->Command != SMB2_CREATE ||
+	if ((smb->optype & CIFS_CP_CREATE_CLOSE_OP) || smb->command_id != SMB2_CREATE_HE ||
 	    hdr->Status != STATUS_SUCCESS)
 		return 0;
 
@@ -887,7 +887,7 @@ smb311_update_preauth_hash(struct cifs_ses *ses, struct TCP_Server_Info *server,
 
 	hdr = (struct smb2_hdr *)iov[0].iov_base;
 	/* neg prot are always taken */
-	if (hdr->Command == SMB2_NEGOTIATE)
+	if (le16_to_cpu(hdr->Command) == SMB2_NEGOTIATE_HE)
 		goto ok;
 
 	/*
@@ -898,7 +898,7 @@ smb311_update_preauth_hash(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	if (server->dialect != SMB311_PROT_ID)
 		return 0;
 
-	if (hdr->Command != SMB2_SESSION_SETUP)
+	if (le16_to_cpu(hdr->Command) != SMB2_SESSION_SETUP_HE)
 		return 0;
 
 	/* skip last sess setup response */
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a7ba4a77721e..0116bf348a76 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -394,6 +394,7 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 {
 	struct smb_message *smb;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
+	enum smb2_command command = le16_to_cpu(shdr->Command);
 	__u64 wire_mid = le64_to_cpu(shdr->MessageId);
 
 	if (shdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM) {
@@ -405,7 +406,7 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 	list_for_each_entry(smb, &server->pending_mid_q, qhead) {
 		if ((smb->mid == wire_mid) &&
 		    (smb->mid_state == MID_REQUEST_SUBMITTED) &&
-		    (smb->command == shdr->Command)) {
+		    (smb->command_id == command)) {
 			kref_get(&smb->refcount);
 			if (dequeue) {
 				list_del_init(&smb->qhead);
@@ -4625,7 +4626,7 @@ handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 	int length;
 	bool use_rdma_mr = false;
 
-	if (shdr->Command != SMB2_READ) {
+	if (le16_to_cpu(shdr->Command) != SMB2_READ_HE) {
 		cifs_server_dbg(VFS, "only big read responses are supported\n");
 		return -EOPNOTSUPP;
 	}
@@ -5714,7 +5715,7 @@ struct smb_version_values smb20_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5736,7 +5737,7 @@ struct smb_version_values smb21_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5757,7 +5758,7 @@ struct smb_version_values smb3any_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5778,7 +5779,7 @@ struct smb_version_values smbdefault_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5799,7 +5800,7 @@ struct smb_version_values smb30_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5820,7 +5821,7 @@ struct smb_version_values smb302_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -5841,7 +5842,7 @@ struct smb_version_values smb311_values = {
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 645d67d04a8d..97a267ce2a62 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -92,7 +92,7 @@ int smb3_encryption_required(const struct cifs_tcon *tcon)
 }
 
 static void
-smb2_hdr_assemble(struct smb2_hdr *shdr, __le16 smb2_cmd,
+smb2_hdr_assemble(struct smb2_hdr *shdr, enum smb2_command smb2_cmd,
 		  const struct cifs_tcon *tcon,
 		  struct TCP_Server_Info *server)
 {
@@ -100,7 +100,7 @@ smb2_hdr_assemble(struct smb2_hdr *shdr, __le16 smb2_cmd,
 
 	shdr->ProtocolId = SMB2_PROTO_NUMBER;
 	shdr->StructureSize = cpu_to_le16(64);
-	shdr->Command = smb2_cmd;
+	shdr->Command = cpu_to_le16(smb2_cmd);
 
 	if (server) {
 		/* After reconnect SMB3 must set ChannelSequence on subsequent reqs */
@@ -215,7 +215,7 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
 }
 
 static int
-smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
+smb2_reconnect(enum smb2_command smb2_command, struct cifs_tcon *tcon,
 	       struct TCP_Server_Info *server, bool from_reconnect)
 {
 	struct cifs_ses *ses;
@@ -230,7 +230,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	if (tcon == NULL)
 		return 0;
 
-	if (smb2_command == SMB2_TREE_CONNECT)
+	if (smb2_command == SMB2_TREE_CONNECT_HE)
 		return 0;
 
 	spin_lock(&tcon->tc_lock);
@@ -238,7 +238,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		/*
 		 * only tree disconnect allowed when disconnecting ...
 		 */
-		if (smb2_command != SMB2_TREE_DISCONNECT) {
+		if (smb2_command != SMB2_TREE_DISCONNECT_HE) {
 			spin_unlock(&tcon->tc_lock);
 			cifs_dbg(FYI, "can not send cmd %d while umounting\n",
 				 smb2_command);
@@ -269,12 +269,14 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		/*
 		 * BB Should we keep oplock break and add flush to exceptions?
 		 */
-		case SMB2_TREE_DISCONNECT:
-		case SMB2_CANCEL:
-		case SMB2_CLOSE:
-		case SMB2_OPLOCK_BREAK:
+		case SMB2_TREE_DISCONNECT_HE:
+		case SMB2_CANCEL_HE:
+		case SMB2_CLOSE_HE:
+		case SMB2_OPLOCK_BREAK_HE:
 			spin_unlock(&server->srv_lock);
 			return -EAGAIN;
+		default:
+			break;
 		}
 	}
 
@@ -462,7 +464,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	ses->flags &= ~CIFS_SES_FLAG_SCALE_CHANNELS;
 	spin_unlock(&ses->ses_lock);
 
-	if (smb2_command != SMB2_INTERNAL_CMD)
+	if (smb2_command != SMB2_INTERNAL_CMD_HE)
 		mod_delayed_work(cifsiod_wq, &server->reconnect, 0);
 
 	atomic_inc(&tconInfoReconnectCount);
@@ -476,29 +478,32 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	 * case it and skip above?
 	 */
 	switch (smb2_command) {
-	case SMB2_FLUSH:
-	case SMB2_READ:
-	case SMB2_WRITE:
-	case SMB2_LOCK:
-	case SMB2_QUERY_DIRECTORY:
-	case SMB2_CHANGE_NOTIFY:
-	case SMB2_QUERY_INFO:
-	case SMB2_SET_INFO:
-	case SMB2_IOCTL:
+	case SMB2_FLUSH_HE:
+	case SMB2_READ_HE:
+	case SMB2_WRITE_HE:
+	case SMB2_LOCK_HE:
+	case SMB2_QUERY_DIRECTORY_HE:
+	case SMB2_CHANGE_NOTIFY_HE:
+	case SMB2_QUERY_INFO_HE:
+	case SMB2_SET_INFO_HE:
+	case SMB2_IOCTL_HE:
 		rc = -EAGAIN;
+		break;
+	default:
+		break;
 	}
 	return rc;
 }
 
 static void
-fill_small_buf(__le16 smb2_command, struct cifs_tcon *tcon,
+fill_small_buf(enum smb2_command smb2_command, struct cifs_tcon *tcon,
 	       struct TCP_Server_Info *server,
 	       void *buf,
 	       unsigned int *total_len)
 {
 	struct smb2_pdu *spdu = buf;
 	/* lookup word count ie StructureSize from table */
-	__u16 parmsize = smb2_req_struct_sizes[le16_to_cpu(smb2_command)];
+	__u16 parmsize = smb2_req_struct_sizes[smb2_command];
 
 	/*
 	 * smaller than SMALL_BUFFER_SIZE but bigger than fixed area of
@@ -517,14 +522,14 @@ fill_small_buf(__le16 smb2_command, struct cifs_tcon *tcon,
  * SMB information in the SMB header. If the return code is zero, this
  * function must have filled in request_buf pointer.
  */
-static int __smb2_plain_req_init(__le16 smb2_command, struct cifs_tcon *tcon,
+static int __smb2_plain_req_init(enum smb2_command smb2_command, struct cifs_tcon *tcon,
 				 struct TCP_Server_Info *server,
 				 void **request_buf, unsigned int *total_len)
 {
 	/* BB eventually switch this to SMB2 specific small buf size */
 	switch (smb2_command) {
-	case SMB2_SET_INFO:
-	case SMB2_QUERY_INFO:
+	case SMB2_SET_INFO_HE:
+	case SMB2_QUERY_INFO_HE:
 		*request_buf = cifs_buf_get();
 		break;
 	default:
@@ -576,10 +581,10 @@ static int smb2_ioctl_req_init(u32 opcode, struct cifs_tcon *tcon,
 	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO ||
 	    (opcode == FSCTL_QUERY_NETWORK_INTERFACE_INFO &&
 	     (tcon->ses->flags & CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES)))
-		return __smb2_plain_req_init(SMB2_IOCTL, tcon, server,
+		return __smb2_plain_req_init(SMB2_IOCTL_HE, tcon, server,
 					     request_buf, total_len);
 
-	return smb2_plain_req_init(SMB2_IOCTL, tcon, server,
+	return smb2_plain_req_init(SMB2_IOCTL_HE, tcon, server,
 				   request_buf, total_len);
 }
 
@@ -1064,7 +1069,7 @@ SMB2_negotiate(const unsigned int xid,
 		return -EIO;
 	}
 
-	rc = smb2_plain_req_init(SMB2_NEGOTIATE, NULL, server,
+	rc = smb2_plain_req_init(SMB2_NEGOTIATE_HE, NULL, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -1464,7 +1469,7 @@ SMB2_sess_alloc_buffer(struct SMB2_sess_data *sess_data)
 	unsigned int total_len;
 	bool is_binding = false;
 
-	rc = smb2_plain_req_init(SMB2_SESSION_SETUP, NULL, server,
+	rc = smb2_plain_req_init(SMB2_SESSION_SETUP_HE, NULL, server,
 				 (void **) &req,
 				 &total_len);
 	if (rc)
@@ -1979,7 +1984,7 @@ SMB2_logoff(const unsigned int xid, struct cifs_ses *ses)
 	}
 	spin_unlock(&ses->chan_lock);
 
-	rc = smb2_plain_req_init(SMB2_LOGOFF, NULL, ses->server,
+	rc = smb2_plain_req_init(SMB2_LOGOFF_HE, NULL, ses->server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -2064,7 +2069,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	/* SMB2 TREE_CONNECT request must be called with TreeId == 0 */
 	tcon->tid = 0;
 	atomic_set(&tcon->num_remote_opens, 0);
-	rc = smb2_plain_req_init(SMB2_TREE_CONNECT, tcon, server,
+	rc = smb2_plain_req_init(SMB2_TREE_CONNECT_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc) {
 		kfree(unc_path);
@@ -2199,7 +2204,7 @@ SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 
 	invalidate_all_cached_dirs(tcon);
 
-	rc = smb2_plain_req_init(SMB2_TREE_DISCONNECT, tcon, server,
+	rc = smb2_plain_req_init(SMB2_TREE_DISCONNECT_HE, tcon, server,
 				 (void **) &req,
 				 &total_len);
 	if (rc)
@@ -2862,7 +2867,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	}
 
 	/* resource #2: request */
-	rc = smb2_plain_req_init(SMB2_CREATE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_CREATE_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		goto err_free_path;
@@ -3016,7 +3021,7 @@ SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	__le16 *copy_path;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_CREATE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_CREATE_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -3571,7 +3576,7 @@ SMB2_close_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	unsigned int total_len;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_CLOSE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_CLOSE_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -3765,7 +3770,7 @@ SMB2_query_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 		     len > CIFSMaxBufSize))
 		return -EINVAL;
 
-	rc = smb2_plain_req_init(SMB2_QUERY_INFO, tcon, server,
+	rc = smb2_plain_req_init(SMB2_QUERY_INFO_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -3966,7 +3971,7 @@ SMB2_notify_init(const unsigned int xid, struct smb_rqst *rqst,
 	unsigned int total_len;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_CHANGE_NOTIFY, tcon, server,
+	rc = smb2_plain_req_init(SMB2_CHANGE_NOTIFY_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -4203,7 +4208,7 @@ void smb2_reconnect_server(struct work_struct *work)
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	list_for_each_entry_safe(tcon, tcon2, &tmp_list, rlist) {
-		rc = smb2_reconnect(SMB2_INTERNAL_CMD, tcon, server, true);
+		rc = smb2_reconnect(SMB2_INTERNAL_CMD_HE, tcon, server, true);
 		if (!rc) {
 			cifs_renegotiate_iosize(server, tcon);
 			cifs_reopen_persistent_handles(tcon);
@@ -4235,7 +4240,7 @@ void smb2_reconnect_server(struct work_struct *work)
 	/* now reconnect sessions for necessary channels */
 	list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
 		tcon->ses = ses;
-		rc = smb2_reconnect(SMB2_INTERNAL_CMD, tcon, server, true);
+		rc = smb2_reconnect(SMB2_INTERNAL_CMD_HE, tcon, server, true);
 		if (rc)
 			resched = true;
 		list_del_init(&ses->rlist);
@@ -4275,7 +4280,7 @@ SMB2_echo(struct TCP_Server_Info *server)
 	}
 	spin_unlock(&server->srv_lock);
 
-	rc = smb2_plain_req_init(SMB2_ECHO, NULL, server,
+	rc = smb2_plain_req_init(SMB2_ECHO_HE, NULL, server,
 				 (void **)&req, &total_len);
 	if (rc)
 		return rc;
@@ -4311,7 +4316,7 @@ SMB2_flush_init(const unsigned int xid, struct smb_rqst *rqst,
 	unsigned int total_len;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_FLUSH, tcon, server,
+	rc = smb2_plain_req_init(SMB2_FLUSH_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -4432,7 +4437,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	struct smb2_hdr *shdr;
 	struct TCP_Server_Info *server = io_parms->server;
 
-	rc = smb2_plain_req_init(SMB2_READ, io_parms->tcon, server,
+	rc = smb2_plain_req_init(SMB2_READ_HE, io_parms->tcon, server,
 				 (void **) &req, total_len);
 	if (rc)
 		return rc;
@@ -4964,7 +4969,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	};
 	io_parms = &_io_parms;
 
-	rc = smb2_plain_req_init(SMB2_WRITE, tcon, server,
+	rc = smb2_plain_req_init(SMB2_WRITE_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		goto out;
@@ -5136,7 +5141,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 	if (n_vec < 1)
 		return rc;
 
-	rc = smb2_plain_req_init(SMB2_WRITE, io_parms->tcon, server,
+	rc = smb2_plain_req_init(SMB2_WRITE_HE, io_parms->tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -5369,7 +5374,7 @@ int SMB2_query_directory_init(const unsigned int xid,
 	struct kvec *iov = rqst->rq_iov;
 	int len, rc;
 
-	rc = smb2_plain_req_init(SMB2_QUERY_DIRECTORY, tcon, server,
+	rc = smb2_plain_req_init(SMB2_QUERY_DIRECTORY_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -5603,7 +5608,7 @@ SMB2_set_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	unsigned int i, total_len;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_SET_INFO, tcon, server,
+	rc = smb2_plain_req_init(SMB2_SET_INFO_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -5777,7 +5782,7 @@ SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
 	server = cifs_pick_channel(ses);
 
 	cifs_dbg(FYI, "SMB2_oplock_break\n");
-	rc = smb2_plain_req_init(SMB2_OPLOCK_BREAK, tcon, server,
+	rc = smb2_plain_req_init(SMB2_OPLOCK_BREAK_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -5863,7 +5868,7 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon,
 	if ((tcon->ses == NULL) || server == NULL)
 		return -EIO;
 
-	rc = smb2_plain_req_init(SMB2_QUERY_INFO, tcon, server,
+	rc = smb2_plain_req_init(SMB2_QUERY_INFO_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -6076,7 +6081,7 @@ smb2_lockv(const unsigned int xid, struct cifs_tcon *tcon,
 
 	cifs_dbg(FYI, "smb2_lockv num lock %d\n", num_lock);
 
-	rc = smb2_plain_req_init(SMB2_LOCK, tcon, server,
+	rc = smb2_plain_req_init(SMB2_LOCK_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
@@ -6159,7 +6164,7 @@ SMB2_lease_break(const unsigned int xid, struct cifs_tcon *tcon,
 	struct TCP_Server_Info *server = cifs_pick_channel(tcon->ses);
 
 	cifs_dbg(FYI, "SMB2_lease_break\n");
-	rc = smb2_plain_req_init(SMB2_OPLOCK_BREAK, tcon, server,
+	rc = smb2_plain_req_init(SMB2_OPLOCK_BREAK_HE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
 		return rc;
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 5348bfd5fad0..806ced5d0783 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -671,7 +671,7 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 	shdr = (struct smb2_hdr *)rqst->rq_iov[0].iov_base;
 	ssr = (struct smb2_sess_setup_req *)shdr;
 
-	is_binding = shdr->Command == SMB2_SESSION_SETUP &&
+	is_binding = le16_to_cpu(shdr->Command) == SMB2_SESSION_SETUP_HE &&
 		(ssr->Flags & SMB2_SESSION_REQ_FLAG_BINDING);
 	is_signed = shdr->Flags & SMB2_FLAGS_SIGNED;
 
@@ -702,9 +702,9 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 	struct smb2_hdr *shdr =
 			(struct smb2_hdr *)rqst->rq_iov[0].iov_base;
 
-	if ((shdr->Command == SMB2_NEGOTIATE) ||
-	    (shdr->Command == SMB2_SESSION_SETUP) ||
-	    (shdr->Command == SMB2_OPLOCK_BREAK) ||
+	if (le16_to_cpu(shdr->Command) == SMB2_NEGOTIATE_HE ||
+	    le16_to_cpu(shdr->Command) == SMB2_SESSION_SETUP_HE ||
+	    le16_to_cpu(shdr->Command) == SMB2_OPLOCK_BREAK_HE ||
 	    server->ignore_signature ||
 	    (!server->session_estab))
 		return 0;
@@ -774,7 +774,7 @@ smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
 	smb->mid = le64_to_cpu(shdr->MessageId);
 	smb->credits = credits > 0 ? credits : 1;
 	smb->pid = current->pid;
-	smb->command = shdr->Command; /* Always LE */
+	smb->command_id = le16_to_cpu(shdr->Command);
 	smb->when_alloc = jiffies;
 	smb->server = server;
 
@@ -812,7 +812,7 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	}
 
 	if (server->tcpStatus == CifsNeedNegotiate &&
-	   shdr->Command != SMB2_NEGOTIATE) {
+	    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE_HE) {
 		spin_unlock(&server->srv_lock);
 		return -EAGAIN;
 	}
@@ -820,8 +820,8 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 
 	spin_lock(&ses->ses_lock);
 	if (ses->ses_status == SES_NEW) {
-		if ((shdr->Command != SMB2_SESSION_SETUP) &&
-		    (shdr->Command != SMB2_NEGOTIATE)) {
+		if (le16_to_cpu(shdr->Command) != SMB2_SESSION_SETUP_HE &&
+		    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE_HE) {
 			spin_unlock(&ses->ses_lock);
 			return -EAGAIN;
 		}
@@ -829,7 +829,7 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	}
 
 	if (ses->ses_status == SES_EXITING) {
-		if (shdr->Command != SMB2_LOGOFF) {
+		if (le16_to_cpu(shdr->Command) != SMB2_LOGOFF_HE) {
 			spin_unlock(&ses->ses_lock);
 			return -EAGAIN;
 		}
@@ -910,7 +910,7 @@ smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsNeedNegotiate &&
-	   shdr->Command != SMB2_NEGOTIATE) {
+	    le16_to_cpu(shdr->Command) != SMB2_NEGOTIATE_HE) {
 		spin_unlock(&server->srv_lock);
 		return ERR_PTR(-EAGAIN);
 	}
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index a105e0ddf81a..d55b24d1aa77 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -43,8 +43,8 @@ void __release_mid(struct kref *refcount)
 	struct smb_message *smb =
 			container_of(refcount, struct smb_message, refcount);
 #ifdef CONFIG_CIFS_STATS2
-	__le16 command = smb->server->vals->lock_cmd;
-	__u16 smb_cmd = le16_to_cpu(smb->command);
+	enum smb2_command command = smb->server->vals->lock_cmd;
+	enum smb2_command smb_cmd = smb->command_id;
 	unsigned long now;
 	unsigned long roundtrip_time;
 #endif
@@ -93,7 +93,7 @@ void __release_mid(struct kref *refcount)
 	 */
 	if ((slow_rsp_threshold != 0) &&
 	    time_after(now, smb->when_alloc + (slow_rsp_threshold * HZ)) &&
-	    (smb->command != command)) {
+	    (smb->command_id != command)) {
 		/*
 		 * smb2slowcmd[NUMBER_OF_SMB2_COMMANDS] counts by command
 		 * NB: le16_to_cpu returns unsigned so can not be negative below
@@ -105,7 +105,7 @@ void __release_mid(struct kref *refcount)
 				    smb->when_sent, smb->when_received);
 		if (cifsFYI & CIFS_TIMER) {
 			pr_debug("slow rsp: cmd %d mid %llu",
-				 smb->command, smb->mid);
+				 smb->command_id, smb->mid);
 			cifs_info("A: 0x%lx S: 0x%lx R: 0x%lx\n",
 				  now - smb->when_alloc,
 				  now - smb->when_sent,
@@ -733,7 +733,7 @@ int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info *server
 	int rc = 0;
 
 	cifs_dbg(FYI, "%s: cmd=%d mid=%llu state=%d\n",
-		 __func__, le16_to_cpu(smb->command), smb->mid, smb->mid_state);
+		 __func__, smb->command_id, smb->mid, smb->mid_state);
 
 	spin_lock(&server->mid_lock);
 	switch (smb->mid_state) {
@@ -1004,7 +1004,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	if (rc != 0) {
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
-				 smb[i]->mid, le16_to_cpu(smb[i]->command));
+				 smb[i]->mid, smb[i]->command_id);
 			send_cancel(server, &rqst[i], smb[i]);
 			spin_lock(&server->mid_lock);
 			smb[i]->mid_flags |= MID_WAIT_CANCELLED;
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index f79a5165a7cc..2f4b158518cd 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -15,49 +15,30 @@
  */
 
 /* List of commands in host endian */
-#define SMB2_NEGOTIATE_HE	0x0000
-#define SMB2_SESSION_SETUP_HE	0x0001
-#define SMB2_LOGOFF_HE		0x0002 /* trivial request/resp */
-#define SMB2_TREE_CONNECT_HE	0x0003
-#define SMB2_TREE_DISCONNECT_HE	0x0004 /* trivial req/resp */
-#define SMB2_CREATE_HE		0x0005
-#define SMB2_CLOSE_HE		0x0006
-#define SMB2_FLUSH_HE		0x0007 /* trivial resp */
-#define SMB2_READ_HE		0x0008
-#define SMB2_WRITE_HE		0x0009
-#define SMB2_LOCK_HE		0x000A
-#define SMB2_IOCTL_HE		0x000B
-#define SMB2_CANCEL_HE		0x000C
-#define SMB2_ECHO_HE		0x000D
-#define SMB2_QUERY_DIRECTORY_HE	0x000E
-#define SMB2_CHANGE_NOTIFY_HE	0x000F
-#define SMB2_QUERY_INFO_HE	0x0010
-#define SMB2_SET_INFO_HE	0x0011
-#define SMB2_OPLOCK_BREAK_HE	0x0012
-#define SMB2_SERVER_TO_CLIENT_NOTIFICATION 0x0013
-
-/* The same list in little endian */
-#define SMB2_NEGOTIATE		cpu_to_le16(SMB2_NEGOTIATE_HE)
-#define SMB2_SESSION_SETUP	cpu_to_le16(SMB2_SESSION_SETUP_HE)
-#define SMB2_LOGOFF		cpu_to_le16(SMB2_LOGOFF_HE)
-#define SMB2_TREE_CONNECT	cpu_to_le16(SMB2_TREE_CONNECT_HE)
-#define SMB2_TREE_DISCONNECT	cpu_to_le16(SMB2_TREE_DISCONNECT_HE)
-#define SMB2_CREATE		cpu_to_le16(SMB2_CREATE_HE)
-#define SMB2_CLOSE		cpu_to_le16(SMB2_CLOSE_HE)
-#define SMB2_FLUSH		cpu_to_le16(SMB2_FLUSH_HE)
-#define SMB2_READ		cpu_to_le16(SMB2_READ_HE)
-#define SMB2_WRITE		cpu_to_le16(SMB2_WRITE_HE)
-#define SMB2_LOCK		cpu_to_le16(SMB2_LOCK_HE)
-#define SMB2_IOCTL		cpu_to_le16(SMB2_IOCTL_HE)
-#define SMB2_CANCEL		cpu_to_le16(SMB2_CANCEL_HE)
-#define SMB2_ECHO		cpu_to_le16(SMB2_ECHO_HE)
-#define SMB2_QUERY_DIRECTORY	cpu_to_le16(SMB2_QUERY_DIRECTORY_HE)
-#define SMB2_CHANGE_NOTIFY	cpu_to_le16(SMB2_CHANGE_NOTIFY_HE)
-#define SMB2_QUERY_INFO		cpu_to_le16(SMB2_QUERY_INFO_HE)
-#define SMB2_SET_INFO		cpu_to_le16(SMB2_SET_INFO_HE)
-#define SMB2_OPLOCK_BREAK	cpu_to_le16(SMB2_OPLOCK_BREAK_HE)
-
-#define SMB2_INTERNAL_CMD	cpu_to_le16(0xFFFF)
+enum smb2_command {
+    SMB2_NEGOTIATE_HE			= 0x0000,
+    SMB2_SESSION_SETUP_HE		= 0x0001,
+    SMB2_LOGOFF_HE			= 0x0002, /* trivial request/resp */
+    SMB2_TREE_CONNECT_HE		= 0x0003,
+    SMB2_TREE_DISCONNECT_HE		= 0x0004, /* trivial req/resp */
+    SMB2_CREATE_HE			= 0x0005,
+    SMB2_CLOSE_HE			= 0x0006,
+    SMB2_FLUSH_HE			= 0x0007, /* trivial resp */
+    SMB2_READ_HE			= 0x0008,
+    SMB2_WRITE_HE			= 0x0009,
+    SMB2_LOCK_HE			= 0x000A,
+    SMB2_IOCTL_HE			= 0x000B,
+    SMB2_CANCEL_HE			= 0x000C,
+    SMB2_ECHO_HE			= 0x000D,
+    SMB2_QUERY_DIRECTORY_HE		= 0x000E,
+    SMB2_CHANGE_NOTIFY_HE		= 0x000F,
+    SMB2_QUERY_INFO_HE			= 0x0010,
+    SMB2_SET_INFO_HE			= 0x0011,
+    SMB2_OPLOCK_BREAK_HE		= 0x0012,
+    SMB2_SERVER_TO_CLIENT_NOTIFICATION	= 0x0013
+};
+
+#define SMB2_INTERNAL_CMD_HE		0xFFFF
 
 #define NUMBER_OF_SMB2_COMMANDS	0x0013
 
@@ -182,6 +163,7 @@ struct smb3_hdr_req {
 struct smb2_pdu {
 	struct smb2_hdr hdr;
 	__le16 StructureSize2; /* size of wct area (varies, request specific) */
+#define SMB2_STRUCT_HAS_DYNAMIC_PART	0x01
 } __packed;
 
 #define SMB2_ERROR_STRUCTURE_SIZE2	9
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index d7a8a580d013..dd3c046aeae3 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -642,7 +642,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
-	rsp_hdr->Command = SMB2_OPLOCK_BREAK;
+	rsp_hdr->Command = cpu_to_le16(SMB2_OPLOCK_BREAK_HE);
 	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
 	rsp_hdr->NextCommand = 0;
 	rsp_hdr->MessageId = cpu_to_le64(-1);
@@ -749,7 +749,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
-	rsp_hdr->Command = SMB2_OPLOCK_BREAK;
+	rsp_hdr->Command = cpu_to_le16(SMB2_OPLOCK_BREAK_HE);
 	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
 	rsp_hdr->NextCommand = 0;
 	rsp_hdr->MessageId = cpu_to_le64(-1);
diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index ae501024665e..41323492f214 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -95,18 +95,18 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 	 * of the data buffer offset and data buffer length for the particular
 	 * command.
 	 */
-	switch (hdr->Command) {
-	case SMB2_SESSION_SETUP:
+	switch (le16_to_cpu(hdr->Command)) {
+	case SMB2_SESSION_SETUP_HE:
 		*off = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferOffset);
 		*len = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
 		break;
-	case SMB2_TREE_CONNECT:
+	case SMB2_TREE_CONNECT_HE:
 		*off = max_t(unsigned short int,
 			     le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset),
 			     offsetof(struct smb2_tree_connect_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathLength);
 		break;
-	case SMB2_CREATE:
+	case SMB2_CREATE_HE:
 	{
 		unsigned short int name_off =
 			max_t(unsigned short int,
@@ -131,23 +131,23 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = name_len;
 		break;
 	}
-	case SMB2_QUERY_INFO:
+	case SMB2_QUERY_INFO_HE:
 		*off = max_t(unsigned int,
 			     le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset),
 			     offsetof(struct smb2_query_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferLength);
 		break;
-	case SMB2_SET_INFO:
+	case SMB2_SET_INFO_HE:
 		*off = max_t(unsigned int,
 			     le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset),
 			     offsetof(struct smb2_set_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_set_info_req *)hdr)->BufferLength);
 		break;
-	case SMB2_READ:
+	case SMB2_READ_HE:
 		*off = le16_to_cpu(((struct smb2_read_req *)hdr)->ReadChannelInfoOffset);
 		*len = le16_to_cpu(((struct smb2_read_req *)hdr)->ReadChannelInfoLength);
 		break;
-	case SMB2_WRITE:
+	case SMB2_WRITE_HE:
 		if (((struct smb2_write_req *)hdr)->DataOffset ||
 		    ((struct smb2_write_req *)hdr)->Length) {
 			*off = max_t(unsigned short int,
@@ -160,13 +160,13 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*off = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoOffset);
 		*len = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
 		break;
-	case SMB2_QUERY_DIRECTORY:
+	case SMB2_QUERY_DIRECTORY_HE:
 		*off = max_t(unsigned short int,
 			     le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset),
 			     offsetof(struct smb2_query_directory_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameLength);
 		break;
-	case SMB2_LOCK:
+	case SMB2_LOCK_HE:
 	{
 		unsigned short lock_count;
 
@@ -177,7 +177,7 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		}
 		break;
 	}
-	case SMB2_IOCTL:
+	case SMB2_IOCTL_HE:
 		*off = max_t(unsigned int,
 			     le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset),
 			     offsetof(struct smb2_ioctl_req, Buffer));
@@ -226,7 +226,7 @@ static int smb2_calc_size(void *buf, unsigned int *len)
 	 * regardless of number of locks. Subtract single
 	 * smb2_lock_element for correct buffer size check.
 	 */
-	if (hdr->Command == SMB2_LOCK)
+	if (le16_to_cpu(hdr->Command) == SMB2_LOCK_HE)
 		*len -= sizeof(struct smb2_lock_element);
 
 	if (has_smb2_data_area[le16_to_cpu(hdr->Command)] == false)
@@ -306,27 +306,27 @@ static int smb2_validate_credit_charge(struct ksmbd_conn *conn,
 	void *__hdr = hdr;
 	int ret = 0;
 
-	switch (hdr->Command) {
-	case SMB2_QUERY_INFO:
+	switch (le16_to_cpu(hdr->Command)) {
+	case SMB2_QUERY_INFO_HE:
 		req_len = smb2_query_info_req_len(__hdr);
 		break;
-	case SMB2_SET_INFO:
+	case SMB2_SET_INFO_HE:
 		req_len = smb2_set_info_req_len(__hdr);
 		break;
-	case SMB2_READ:
+	case SMB2_READ_HE:
 		req_len = smb2_read_req_len(__hdr);
 		break;
-	case SMB2_WRITE:
+	case SMB2_WRITE_HE:
 		req_len = smb2_write_req_len(__hdr);
 		break;
-	case SMB2_QUERY_DIRECTORY:
+	case SMB2_QUERY_DIRECTORY_HE:
 		req_len = smb2_query_dir_req_len(__hdr);
 		break;
-	case SMB2_IOCTL:
+	case SMB2_IOCTL_HE:
 		req_len = smb2_ioctl_req_len(__hdr);
 		expect_resp_len = smb2_ioctl_resp_len(__hdr);
 		break;
-	case SMB2_CANCEL:
+	case SMB2_CANCEL_HE:
 		return 0;
 	default:
 		req_len = 1;
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index 606aa3c5189a..c9302dd71e53 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -27,7 +27,7 @@ static struct smb_version_values smb21_server_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -53,7 +53,7 @@ static struct smb_version_values smb30_server_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -80,7 +80,7 @@ static struct smb_version_values smb302_server_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
@@ -107,7 +107,7 @@ static struct smb_version_values smb311_server_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
 	.read_rsp_size = sizeof(struct smb2_read_rsp),
-	.lock_cmd = SMB2_LOCK,
+	.lock_cmd = SMB2_LOCK_HE,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
 	.cap_large_files = SMB2_LARGE_FILES,
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index fafa86273f12..74749c60d9f6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -181,7 +181,7 @@ bool is_smb2_neg_cmd(struct ksmbd_work *work)
 	if (hdr->Flags & SMB2_FLAGS_SERVER_TO_REDIR)
 		return false;
 
-	if (hdr->Command != SMB2_NEGOTIATE)
+	if (le16_to_cpu(hdr->Command) != SMB2_NEGOTIATE_HE)
 		return false;
 
 	return true;
@@ -262,7 +262,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(2);
-	rsp_hdr->Command = SMB2_NEGOTIATE;
+	rsp_hdr->Command = cpu_to_le16(SMB2_NEGOTIATE_HE);
 	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
 	rsp_hdr->NextCommand = 0;
 	rsp_hdr->MessageId = 0;
@@ -349,7 +349,7 @@ int smb2_set_rsp_credits(struct ksmbd_work *work)
 	 * TODO: Need to adjuct CreditRequest value according to
 	 * current cpu load
 	 */
-	if (hdr->Command == SMB2_NEGOTIATE)
+	if (le16_to_cpu(hdr->Command) == SMB2_NEGOTIATE_HE)
 		aux_max = 1;
 	else
 		aux_max = conn->vals->max_credits - conn->total_credits;
@@ -389,7 +389,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
 	/* Storing the current local FID which may be needed by subsequent
 	 * command in the compound request
 	 */
-	if (req->Command == SMB2_CREATE && rsp->Status == STATUS_SUCCESS) {
+	if (req->Command == cpu_to_le16(SMB2_CREATE_HE) && rsp->Status == STATUS_SUCCESS) {
 		work->compound_fid = ((struct smb2_create_rsp *)rsp)->VolatileFileId;
 		work->compound_pfid = ((struct smb2_create_rsp *)rsp)->PersistentFileId;
 		work->compound_sid = le64_to_cpu(rsp->SessionId);
@@ -572,7 +572,7 @@ int smb2_check_user_session(struct ksmbd_work *work)
 {
 	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
 	struct ksmbd_conn *conn = work->conn;
-	unsigned int cmd = le16_to_cpu(req_hdr->Command);
+	enum smb2_command cmd = le16_to_cpu(req_hdr->Command);
 	unsigned long long sess_id;
 
 	/*
@@ -8887,7 +8887,7 @@ void smb2_set_sign_rsp(struct ksmbd_work *work)
 	hdr->Flags |= SMB2_FLAGS_SIGNED;
 	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 
-	if (hdr->Command == SMB2_READ) {
+	if (hdr->Command == cpu_to_le16(SMB2_READ_HE)) {
 		iov = &work->iov[work->iov_idx - 1];
 		n_vec++;
 	} else {
@@ -8993,7 +8993,7 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	hdr->Flags |= SMB2_FLAGS_SIGNED;
 	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 
-	if (hdr->Command == SMB2_READ) {
+	if (hdr->Command == cpu_to_le16(SMB2_READ_HE)) {
 		iov = &work->iov[work->iov_idx - 1];
 		n_vec++;
 	} else {


