Return-Path: <linux-fsdevel+bounces-56911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEFB1CDE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB11188C85A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289312D63EE;
	Wed,  6 Aug 2025 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSdMKA8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42872BEC4E
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512802; cv=none; b=tvxYJj/3YI/b1tzY+OleWqJVU6qZ73jdSjNBOf8U3mLP6h2mnEakSVuaybfSVA1M9Rrv9o3yS3c2TMTq/durtQhLrBeek6/+RGElA4imwRSSLAj2hjmnG6B37pX9l8fx4MsW8i23ukMMkCcfjb21YJMK+aNR6mjZJIpJsRiMzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512802; c=relaxed/simple;
	bh=Gghf6k/fnry+2WFWCe6fJYxjAU0qFTZeucHXPfX09aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uedx7cZ33a/2CywjtGy8v/sUsH+0oqyZZUnGoXnoSxoLDUDfyMS5KZMO+cHA9kL8nTy/1UijGbWqC6wmgaPVNDL2RIGcQpp4TpgHI5tPGSC4RUx+Xee/rjVulPboUXStlFqrS5AS0aPFOdRsvWhnHtLQ6Ok62Lt1JIxoyPtsZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSdMKA8k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmhepafm0TOsow0EGo0RSETMNdoSQ3DnpqhK9FsEIx8=;
	b=XSdMKA8kFa/lRXjixZl3soXhoM3cufb0kiUak/BQsJ2GwpdHeugD7uyBZZDSNPXt0yxKFK
	RVxwX+m2GOxmBRqN4fKIe3tTnOtPRayMQMKqh9lqr6bv1LgJXIMUSe2VD6waYC3D/1Rv69
	ZaaUl2KH5MvTCNH/KrmTIyXZUcfEl/8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-sBmFLl4uNSSSd-fvQyqKsg-1; Wed,
 06 Aug 2025 16:39:52 -0400
X-MC-Unique: sBmFLl4uNSSSd-fvQyqKsg-1
X-Mimecast-MFC-AGG-ID: sBmFLl4uNSSSd-fvQyqKsg_1754512784
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DCDF180035B;
	Wed,  6 Aug 2025 20:39:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CDE681956086;
	Wed,  6 Aug 2025 20:39:40 +0000 (UTC)
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
Subject: [RFC PATCH 31/31] cifs: Convert SMB2 Open request
Date: Wed,  6 Aug 2025 21:36:52 +0100
Message-ID: <20250806203705.2560493-32-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cached_dir.c |  41 +-
 fs/smb/client/cifsglob.h   |   5 +-
 fs/smb/client/smb2inode.c  |   6 +-
 fs/smb/client/smb2ops.c    |  34 +-
 fs/smb/client/smb2pdu.c    | 877 +++++++++++++++----------------------
 fs/smb/client/smb2proto.h  |  29 +-
 6 files changed, 399 insertions(+), 593 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 368e870624da..e4534f6b31da 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -141,9 +141,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_open_parms oparms;
 	struct smb2_create_rsp *o_rsp = NULL;
 	struct smb2_query_info_rsp *qi_rsp = NULL;
-	int resp_buftype[2];
-	struct smb_rqst rqst[2];
-	struct kvec rsp_iov[2];
+	struct smb_message *smb;
 	struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
 	struct kvec qi_iov[1];
 	int rc, flags = 0;
@@ -260,29 +258,20 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 
 	server->ops->new_lease_key(pfid);
 
-	memset(rqst, 0, sizeof(rqst));
-	resp_buftype[0] = resp_buftype[1] = CIFS_NO_BUFFER;
-	memset(rsp_iov, 0, sizeof(rsp_iov));
-
 	/* Open */
-	memset(&open_iov, 0, sizeof(open_iov));
-	rqst[0].rq_iov = open_iov;
-	rqst[0].rq_nvec = SMB2_CREATE_IOV_SIZE;
-
 	oparms = (struct cifs_open_parms) {
-		.tcon = tcon,
-		.path = path,
-		.create_options = cifs_create_options(cifs_sb, CREATE_NOT_FILE),
-		.desired_access =  FILE_READ_DATA | FILE_READ_ATTRIBUTES |
-				   FILE_READ_EA,
-		.disposition = FILE_OPEN,
-		.fid = pfid,
-		.lease_flags = lease_flags,
-		.replay = !!(retries),
+		.tcon		= tcon,
+		.path		= path,
+		.create_options	= cifs_create_options(cifs_sb, CREATE_NOT_FILE),
+		.desired_access	= FILE_READ_DATA | FILE_READ_ATTRIBUTES |
+				  FILE_READ_EA,
+		.disposition	= FILE_OPEN,
+		.fid		= pfid,
+		.lease_flags	= lease_flags,
+		.replay		= !!(retries),
 	};
 
-	rc = SMB2_open_init(tcon, server,
-			    &rqst[0], &oplock, &oparms, utf16_path);
+	smb = SMB2_open_init(tcon, server, &oplock, &oparms, utf16_path);
 	if (rc)
 		goto oshr_free;
 	smb2_set_next_command(tcon, &rqst[0]);
@@ -336,10 +325,10 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		goto oshr_free;
 	}
 
-	rc = smb2_parse_contexts(server, rsp_iov,
-				 &oparms.fid->epoch,
-				 oparms.fid->lease_key,
-				 &oplock, NULL, NULL);
+	rc = smb2_parse_create_response(server, rsp_iov,
+					&oparms.fid->epoch,
+					oparms.fid->lease_key,
+					&oplock, NULL, NULL);
 	if (rc) {
 		spin_unlock(&cfids->cfid_list_lock);
 		goto oshr_free;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 0cc71f504c68..b96c45f57c2b 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -554,8 +554,9 @@ struct smb_version_operations {
 	/* set oplock level for the inode */
 	void (*set_oplock_level)(struct cifsInodeInfo *cinode, __u32 oplock, __u16 epoch,
 				 bool *purge_cache);
-	/* create lease context buffer for CREATE request */
-	char * (*create_lease_buf)(u8 *lease_key, u8 oplock, u8 *parent_lease_key, __le32 le_flags);
+	/* Fill in a lease context buffer for CREATE request */
+	void (*fill_lease_buf)(struct smb_message *smb, const u8 *lease_key, u8 oplock,
+			       const u8 *parent_lease_key, __le32 le_flags);
 	/* parse lease context buffer and return oplock/epoch info */
 	__u8 (*parse_lease_buf)(void *buf, __u16 *epoch, char *lkey);
 	ssize_t (*copychunk_range)(const unsigned int,
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 2a3e46b8e15a..c5041fa94779 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -663,9 +663,9 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		idata->fi.DeletePending = 0;
 		idata->fi.Directory = !!(le32_to_cpu(create_rsp->FileAttributes) & ATTR_DIRECTORY);
 
-		/* smb2_parse_contexts() fills idata->fi.IndexNumber */
-		rc = smb2_parse_contexts(server, &rsp_iov[0], &oparms->fid->epoch,
-					 oparms->fid->lease_key, &oplock, &idata->fi, NULL);
+		/* smb2_parse_create_response() fills idata->fi.IndexNumber */
+		rc = smb2_parse_create_response(server, &rsp_iov[0], &oparms->fid->epoch,
+						oparms->fid->lease_key, &oplock, &idata->fi, NULL);
 		if (rc)
 			cifs_dbg(VFS, "rc: %d parsing context of compound op\n", rc);
 	}
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 9db383ec22e8..7c30475054b8 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4086,14 +4086,11 @@ map_oplock_to_lease(u8 oplock)
 	return 0;
 }
 
-static char *
-smb2_create_lease_buf(u8 *lease_key, u8 oplock, u8 *parent_lease_key, __le32 flags)
+static void
+smb2_fill_lease_buf(struct smb_message *smb, const u8 *lease_key, u8 oplock,
+		    const u8 *parent_lease_key, __le32 flags)
 {
-	struct create_lease *buf;
-
-	buf = kzalloc(sizeof(struct create_lease), GFP_KERNEL);
-	if (!buf)
-		return NULL;
+	struct create_lease *buf = cifs_begin_extension(smb);
 
 	memcpy(&buf->lcontext.LeaseKey, lease_key, SMB2_LEASE_KEY_SIZE);
 	buf->lcontext.LeaseState = map_oplock_to_lease(oplock);
@@ -4109,17 +4106,14 @@ smb2_create_lease_buf(u8 *lease_key, u8 oplock, u8 *parent_lease_key, __le32 fla
 	buf->Name[1] = 'q';
 	buf->Name[2] = 'L';
 	buf->Name[3] = 's';
-	return (char *)buf;
+	cifs_end_extension(smb, sizeof(*buf));
 }
 
-static char *
-smb3_create_lease_buf(u8 *lease_key, u8 oplock, u8 *parent_lease_key, __le32 flags)
+static void
+smb3_fill_lease_buf(struct smb_message *smb, const u8 *lease_key, u8 oplock,
+		    const u8 *parent_lease_key, __le32 flags)
 {
-	struct create_lease_v2 *buf;
-
-	buf = kzalloc(sizeof(struct create_lease_v2), GFP_KERNEL);
-	if (!buf)
-		return NULL;
+	struct create_lease_v2 *buf = cifs_begin_extension(smb);
 
 	memcpy(&buf->lcontext.LeaseKey, lease_key, SMB2_LEASE_KEY_SIZE);
 	buf->lcontext.LeaseState = map_oplock_to_lease(oplock);
@@ -4138,7 +4132,7 @@ smb3_create_lease_buf(u8 *lease_key, u8 oplock, u8 *parent_lease_key, __le32 fla
 	buf->Name[1] = 'q';
 	buf->Name[2] = 'L';
 	buf->Name[3] = 's';
-	return (char *)buf;
+	cifs_end_extension(smb, sizeof(*buf));
 }
 
 static __u8
@@ -5263,7 +5257,7 @@ struct smb_version_operations smb20_operations = {
 	.calc_signature = smb2_calc_signature,
 	.is_read_op = smb2_is_read_op,
 	.set_oplock_level = smb2_set_oplock_level,
-	.create_lease_buf = smb2_create_lease_buf,
+	.fill_lease_buf = smb2_fill_lease_buf,
 	.parse_lease_buf = smb2_parse_lease_buf,
 	.copychunk_range = smb2_copychunk_range,
 	.wp_retry_size = smb2_wp_retry_size,
@@ -5366,7 +5360,7 @@ struct smb_version_operations smb21_operations = {
 	.calc_signature = smb2_calc_signature,
 	.is_read_op = smb21_is_read_op,
 	.set_oplock_level = smb21_set_oplock_level,
-	.create_lease_buf = smb2_create_lease_buf,
+	.fill_lease_buf = smb2_fill_lease_buf,
 	.parse_lease_buf = smb2_parse_lease_buf,
 	.copychunk_range = smb2_copychunk_range,
 	.wp_retry_size = smb2_wp_retry_size,
@@ -5476,7 +5470,7 @@ struct smb_version_operations smb30_operations = {
 	.set_integrity  = smb3_set_integrity,
 	.is_read_op = smb21_is_read_op,
 	.set_oplock_level = smb3_set_oplock_level,
-	.create_lease_buf = smb3_create_lease_buf,
+	.fill_lease_buf = smb3_fill_lease_buf,
 	.parse_lease_buf = smb3_parse_lease_buf,
 	.copychunk_range = smb2_copychunk_range,
 	.duplicate_extents = smb2_duplicate_extents,
@@ -5592,7 +5586,7 @@ struct smb_version_operations smb311_operations = {
 	.set_integrity  = smb3_set_integrity,
 	.is_read_op = smb21_is_read_op,
 	.set_oplock_level = smb3_set_oplock_level,
-	.create_lease_buf = smb3_create_lease_buf,
+	.fill_lease_buf = smb3_fill_lease_buf,
 	.parse_lease_buf = smb3_parse_lease_buf,
 	.copychunk_range = smb2_copychunk_range,
 	.duplicate_extents = smb2_duplicate_extents,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 9fc55b315474..e9827aeab43f 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2387,298 +2387,179 @@ SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 	return rc;
 }
 
-
-static void fill_posix_buf(struct create_posix *buf, umode_t mode)
+/*
+ * Begin a create context record.  This fills in the chain pointer on the
+ * previous record if there was one.
+ */
+static void *cifs_begin_ccontext(struct smb_message *smb)
 {
-	buf->ccontext.DataOffset =
-		cpu_to_le16(offsetof(struct create_posix, Mode));
-	buf->ccontext.DataLength = cpu_to_le32(4);
-	buf->ccontext.NameOffset =
-		cpu_to_le16(offsetof(struct create_posix, Name));
-	buf->ccontext.NameLength = cpu_to_le16(16);
+	struct create_context_hdr *ccontext = cifs_begin_extension(smb);
 
-	/* SMB2_CREATE_TAG_POSIX is "0x93AD25509CB411E7B42383DE968BCD7C" */
-	buf->Name[0] = 0x93;
-	buf->Name[1] = 0xAD;
-	buf->Name[2] = 0x25;
-	buf->Name[3] = 0x50;
-	buf->Name[4] = 0x9C;
-	buf->Name[5] = 0xB4;
-	buf->Name[6] = 0x11;
-	buf->Name[7] = 0xE7;
-	buf->Name[8] = 0xB4;
-	buf->Name[9] = 0x23;
-	buf->Name[10] = 0x83;
-	buf->Name[11] = 0xDE;
-	buf->Name[12] = 0x96;
-	buf->Name[13] = 0x8B;
-	buf->Name[14] = 0xCD;
-	buf->Name[15] = 0x7C;
-	buf->Mode = cpu_to_le32(mode);
-	cifs_dbg(FYI, "mode on posix create 0%o\n", mode);
+	if (smb->latest_record) {
+		struct create_context_hdr *latest = smb->request + smb->latest_record;
+
+		latest->Next = cpu_to_le32(smb->offset - smb->latest_record);
+	}
+	smb->latest_record = smb->offset;
+	return ccontext;
 }
 
-static int
-add_posix_context(struct kvec *iov, unsigned int *num_iovec, umode_t mode)
+#define CREATE_CONTEXT_HDR(ptr, name, data, namelen) {			\
+		.NameOffset = cpu_to_le16(offsetof(ptr, name)),		\
+		.NameLength = cpu_to_le16(namelen),			\
+		.DataOffset = cpu_to_le16(offsetof(ptr, data)),		\
+		.DataLength = cpu_to_le32(sizeof_field(ptr, data)),	\
+	}
+
+static void fill_posix_context(struct smb_message *smb, umode_t mode)
 {
-	struct create_posix *buf;
-	unsigned int num = *num_iovec;
+	struct create_posix *buf = cifs_begin_ccontext(smb);
 
 	if (mode == ACL_NO_MODE)
 		cifs_dbg(FYI, "%s: no mode\n", __func__);
 
-	buf = kzalloc(sizeof(struct create_posix), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	fill_posix_buf(buf, mode);
-
-	iov[num].iov_base = buf;
-	iov[num].iov_len  = sizeof(struct create_posix);
-	*num_iovec = num + 1;
-	return 0;
+	*buf = (struct create_posix){
+		.ccontext = CREATE_CONTEXT_HDR(struct create_posix, Name, Mode, 16),
+		/* SMB2_CREATE_TAG_POSIX is "0x93AD25509CB411E7B42383DE968BCD7C" */
+		.Name = {
+			0x93, 0xAD, 0x25, 0x50, 0x9C, 0xB4, 0x11, 0xE7,
+			0xB4, 0x23, 0x83, 0xDE, 0x96, 0x8B, 0xCD, 0x7C
+		},
+		.Mode = cpu_to_le32(mode),
+	};
+	cifs_dbg(FYI, "mode on posix create 0%o\n", mode);
+	cifs_end_extension(smb, sizeof(*buf));
 }
 
-static struct create_durable *
-create_durable_buf(void)
+static void fill_lease_context(struct TCP_Server_Info *server,
+			       struct smb2_create_req *req,
+			       struct smb_message *smb,
+			       u8 *lease_key,
+			       __u8 *oplock,
+			       u8 *parent_lease_key,
+			       __le32 flags)
 {
-	struct create_durable *buf;
-
-	buf = kzalloc(sizeof(struct create_durable), GFP_KERNEL);
-	if (!buf)
-		return NULL;
-
-	buf->ccontext.DataOffset = cpu_to_le16(offsetof
-					(struct create_durable, Data));
-	buf->ccontext.DataLength = cpu_to_le32(16);
-	buf->ccontext.NameOffset = cpu_to_le16(offsetof
-				(struct create_durable, Name));
-	buf->ccontext.NameLength = cpu_to_le16(4);
-	/* SMB2_CREATE_DURABLE_HANDLE_REQUEST is "DHnQ" */
-	buf->Name[0] = 'D';
-	buf->Name[1] = 'H';
-	buf->Name[2] = 'n';
-	buf->Name[3] = 'Q';
-	return buf;
+	req->RequestedOplockLevel = SMB2_OPLOCK_LEVEL_LEASE;
+	server->ops->fill_lease_buf(smb, lease_key, *oplock,
+				    parent_lease_key, flags);
 }
 
-static struct create_durable *
-create_reconnect_durable_buf(struct cifs_fid *fid)
+static void fill_durable_v1_context(struct smb_message *smb)
 {
-	struct create_durable *buf;
+	struct create_durable *buf = cifs_begin_ccontext(smb);
 
-	buf = kzalloc(sizeof(struct create_durable), GFP_KERNEL);
-	if (!buf)
-		return NULL;
-
-	buf->ccontext.DataOffset = cpu_to_le16(offsetof
-					(struct create_durable, Data));
-	buf->ccontext.DataLength = cpu_to_le32(16);
-	buf->ccontext.NameOffset = cpu_to_le16(offsetof
-				(struct create_durable, Name));
-	buf->ccontext.NameLength = cpu_to_le16(4);
-	buf->Data.Fid.PersistentFileId = fid->persistent_fid;
-	buf->Data.Fid.VolatileFileId = fid->volatile_fid;
-	/* SMB2_CREATE_DURABLE_HANDLE_RECONNECT is "DHnC" */
-	buf->Name[0] = 'D';
-	buf->Name[1] = 'H';
-	buf->Name[2] = 'n';
-	buf->Name[3] = 'C';
-	return buf;
+	*buf = (struct create_durable){
+		.ccontext = CREATE_CONTEXT_HDR(struct create_durable, Name, Data, 4),
+		/* SMB2_CREATE_DURABLE_HANDLE_REQUEST is "DHnQ" */
+		.Name = {'D', 'H', 'n', 'Q' },
+	};
+	cifs_end_extension(smb, sizeof(*buf));
 }
 
-static int
-add_lease_context(struct TCP_Server_Info *server,
-		  struct smb2_create_req *req,
-		  struct kvec *iov,
-		  unsigned int *num_iovec,
-		  u8 *lease_key,
-		  __u8 *oplock,
-		  u8 *parent_lease_key,
-		  __le32 flags)
+static void fill_reconnect_durable_context(struct smb_message *smb,
+					   struct cifs_open_parms *oparms)
 {
-	unsigned int num = *num_iovec;
+	struct create_durable *buf = cifs_begin_ccontext(smb);
+	struct cifs_fid *fid = oparms->fid;
 
-	iov[num].iov_base = server->ops->create_lease_buf(lease_key, *oplock,
-							  parent_lease_key, flags);
-	if (iov[num].iov_base == NULL)
-		return -ENOMEM;
-	iov[num].iov_len = server->vals->create_lease_size;
-	req->RequestedOplockLevel = SMB2_OPLOCK_LEVEL_LEASE;
-	*num_iovec = num + 1;
-	return 0;
+	/* indicate that we don't need to relock the file */
+	oparms->reconnect = false;
+
+	*buf = (struct create_durable){
+		.ccontext = CREATE_CONTEXT_HDR(struct create_durable, Name, Data, 4),
+		/* SMB2_CREATE_DURABLE_HANDLE_RECONNECT is "DHnC" */
+		.Name = {'D', 'H', 'n', 'C' },
+		.Data.Fid.PersistentFileId	= fid->persistent_fid,
+		.Data.Fid.VolatileFileId	= fid->volatile_fid,
+	};
+	cifs_end_extension(smb, sizeof(*buf));
 }
 
-static struct create_durable_v2 *
-create_durable_v2_buf(struct cifs_open_parms *oparms)
+static void fill_durable_v2_context(struct smb_message *smb,
+				    struct cifs_open_parms *oparms)
 {
-	struct cifs_fid *pfid = oparms->fid;
-	struct create_durable_v2 *buf;
+	struct create_durable_v2 *buf = cifs_begin_ccontext(smb);
+	struct cifs_fid *fid = oparms->fid;
 
-	buf = kzalloc(sizeof(struct create_durable_v2), GFP_KERNEL);
-	if (!buf)
-		return NULL;
+	*buf = (struct create_durable_v2){
+		.ccontext = CREATE_CONTEXT_HDR(struct create_durable_v2, Name, dcontext, 4),
+		/* SMB2_CREATE_DURABLE_HANDLE_REQUEST is "DH2Q" */
+		.Name = {'D', 'H', '2', 'Q' },
 
-	buf->ccontext.DataOffset = cpu_to_le16(offsetof
-					(struct create_durable_v2, dcontext));
-	buf->ccontext.DataLength = cpu_to_le32(sizeof(struct durable_context_v2));
-	buf->ccontext.NameOffset = cpu_to_le16(offsetof
-				(struct create_durable_v2, Name));
-	buf->ccontext.NameLength = cpu_to_le16(4);
-
-	/*
-	 * NB: Handle timeout defaults to 0, which allows server to choose
-	 * (most servers default to 120 seconds) and most clients default to 0.
-	 * This can be overridden at mount ("handletimeout=") if the user wants
-	 * a different persistent (or resilient) handle timeout for all opens
-	 * on a particular SMB3 mount.
-	 */
-	buf->dcontext.Timeout = cpu_to_le32(oparms->tcon->handle_timeout);
-	buf->dcontext.Flags = cpu_to_le32(SMB2_DHANDLE_FLAG_PERSISTENT);
+		/*
+		 * NB: Handle timeout defaults to 0, which allows server to
+		 * choose (most servers default to 120 seconds) and most
+		 * clients default to 0.  This can be overridden at mount
+		 * ("handletimeout=") if the user wants a different persistent
+		 * (or resilient) handle timeout for all opens on a particular
+		 * SMB3 mount.
+		 */
+		.dcontext.Timeout = cpu_to_le32(oparms->tcon->handle_timeout),
+		.dcontext.Flags	  = cpu_to_le32(SMB2_DHANDLE_FLAG_PERSISTENT),
+	};
 
 	/* for replay, we should not overwrite the existing create guid */
 	if (!oparms->replay) {
 		generate_random_uuid(buf->dcontext.CreateGuid);
-		memcpy(pfid->create_guid, buf->dcontext.CreateGuid, 16);
-	} else
-		memcpy(buf->dcontext.CreateGuid, pfid->create_guid, 16);
-
-	/* SMB2_CREATE_DURABLE_HANDLE_REQUEST is "DH2Q" */
-	buf->Name[0] = 'D';
-	buf->Name[1] = 'H';
-	buf->Name[2] = '2';
-	buf->Name[3] = 'Q';
-	return buf;
-}
-
-static struct create_durable_handle_reconnect_v2 *
-create_reconnect_durable_v2_buf(struct cifs_fid *fid)
-{
-	struct create_durable_handle_reconnect_v2 *buf;
-
-	buf = kzalloc(sizeof(struct create_durable_handle_reconnect_v2),
-			GFP_KERNEL);
-	if (!buf)
-		return NULL;
-
-	buf->ccontext.DataOffset =
-		cpu_to_le16(offsetof(struct create_durable_handle_reconnect_v2,
-				     dcontext));
-	buf->ccontext.DataLength =
-		cpu_to_le32(sizeof(struct durable_reconnect_context_v2));
-	buf->ccontext.NameOffset =
-		cpu_to_le16(offsetof(struct create_durable_handle_reconnect_v2,
-			    Name));
-	buf->ccontext.NameLength = cpu_to_le16(4);
-
-	buf->dcontext.Fid.PersistentFileId = fid->persistent_fid;
-	buf->dcontext.Fid.VolatileFileId = fid->volatile_fid;
-	buf->dcontext.Flags = cpu_to_le32(SMB2_DHANDLE_FLAG_PERSISTENT);
-	memcpy(buf->dcontext.CreateGuid, fid->create_guid, 16);
-
-	/* SMB2_CREATE_DURABLE_HANDLE_RECONNECT_V2 is "DH2C" */
-	buf->Name[0] = 'D';
-	buf->Name[1] = 'H';
-	buf->Name[2] = '2';
-	buf->Name[3] = 'C';
-	return buf;
-}
-
-static int
-add_durable_v2_context(struct kvec *iov, unsigned int *num_iovec,
-		    struct cifs_open_parms *oparms)
-{
-	unsigned int num = *num_iovec;
+		memcpy(fid->create_guid, buf->dcontext.CreateGuid, 16);
+	} else {
+		memcpy(buf->dcontext.CreateGuid, fid->create_guid, 16);
+	}
 
-	iov[num].iov_base = create_durable_v2_buf(oparms);
-	if (iov[num].iov_base == NULL)
-		return -ENOMEM;
-	iov[num].iov_len = sizeof(struct create_durable_v2);
-	*num_iovec = num + 1;
-	return 0;
+	cifs_end_extension(smb, sizeof(*buf));
 }
 
-static int
-add_durable_reconnect_v2_context(struct kvec *iov, unsigned int *num_iovec,
-		    struct cifs_open_parms *oparms)
+static void fill_durable_reconnect_v2_context(struct smb_message *smb,
+					      struct cifs_open_parms *oparms)
 {
-	unsigned int num = *num_iovec;
+	struct create_durable_handle_reconnect_v2 *buf = cifs_begin_ccontext(smb);
+	struct cifs_fid *fid = oparms->fid;
 
 	/* indicate that we don't need to relock the file */
 	oparms->reconnect = false;
 
-	iov[num].iov_base = create_reconnect_durable_v2_buf(oparms->fid);
-	if (iov[num].iov_base == NULL)
-		return -ENOMEM;
-	iov[num].iov_len = sizeof(struct create_durable_handle_reconnect_v2);
-	*num_iovec = num + 1;
-	return 0;
+	*buf = (struct create_durable_handle_reconnect_v2){
+		.ccontext = CREATE_CONTEXT_HDR(struct create_durable_handle_reconnect_v2,
+					       Name, dcontext, 4),
+		/* SMB2_CREATE_DURABLE_HANDLE_RECONNECT_V2 is "DH2C" */
+		.Name = {'D', 'H', '2', 'C' },
+		.dcontext.Fid.PersistentFileId	= fid->persistent_fid,
+		.dcontext.Fid.VolatileFileId	= fid->volatile_fid,
+		.dcontext.Flags			= cpu_to_le32(SMB2_DHANDLE_FLAG_PERSISTENT),
+	};
+
+	memcpy(buf->dcontext.CreateGuid, fid->create_guid, 16);
+	cifs_end_extension(smb, sizeof(*buf));
 }
 
-static int
-add_durable_context(struct kvec *iov, unsigned int *num_iovec,
-		    struct cifs_open_parms *oparms, bool use_persistent)
+static void
+fill_durable_context(struct smb_message *smb,
+		     struct cifs_open_parms *oparms, bool use_persistent)
 {
-	unsigned int num = *num_iovec;
-
 	if (use_persistent) {
 		if (oparms->reconnect)
-			return add_durable_reconnect_v2_context(iov, num_iovec,
-								oparms);
-		else
-			return add_durable_v2_context(iov, num_iovec, oparms);
+			return fill_durable_reconnect_v2_context(smb, oparms);
+		return fill_durable_v2_context(smb, oparms);
 	}
 
-	if (oparms->reconnect) {
-		iov[num].iov_base = create_reconnect_durable_buf(oparms->fid);
-		/* indicate that we don't need to relock the file */
-		oparms->reconnect = false;
-	} else
-		iov[num].iov_base = create_durable_buf();
-	if (iov[num].iov_base == NULL)
-		return -ENOMEM;
-	iov[num].iov_len = sizeof(struct create_durable);
-	*num_iovec = num + 1;
-	return 0;
+	if (oparms->reconnect)
+		return fill_reconnect_durable_context(smb, oparms);
+	return fill_durable_v1_context(smb);
 }
 
 /* See MS-SMB2 2.2.13.2.7 */
-static struct crt_twarp_ctxt *
-create_twarp_buf(__u64 timewarp)
+static void fill_twarp_context(struct smb_message *smb, __u64 timewarp)
 {
-	struct crt_twarp_ctxt *buf;
-
-	buf = kzalloc(sizeof(struct crt_twarp_ctxt), GFP_KERNEL);
-	if (!buf)
-		return NULL;
-
-	buf->ccontext.DataOffset = cpu_to_le16(offsetof
-					(struct crt_twarp_ctxt, Timestamp));
-	buf->ccontext.DataLength = cpu_to_le32(8);
-	buf->ccontext.NameOffset = cpu_to_le16(offsetof
-				(struct crt_twarp_ctxt, Name));
-	buf->ccontext.NameLength = cpu_to_le16(4);
-	/* SMB2_CREATE_TIMEWARP_TOKEN is "TWrp" */
-	buf->Name[0] = 'T';
-	buf->Name[1] = 'W';
-	buf->Name[2] = 'r';
-	buf->Name[3] = 'p';
-	buf->Timestamp = cpu_to_le64(timewarp);
-	return buf;
-}
+	struct crt_twarp_ctxt *buf = cifs_begin_ccontext(smb);
 
-/* See MS-SMB2 2.2.13.2.7 */
-static int
-add_twarp_context(struct kvec *iov, unsigned int *num_iovec, __u64 timewarp)
-{
-	unsigned int num = *num_iovec;
+	*buf = (struct crt_twarp_ctxt){
+		.ccontext = CREATE_CONTEXT_HDR(struct crt_twarp_ctxt, Name, Timestamp, 4),
+		/* SMB2_CREATE_TIMEWARP_TOKEN is "TWrp" */
+		.Name		= {'T', 'W', 'r', 'p' },
+		.Timestamp	= cpu_to_le64(timewarp),
+	};
 
-	iov[num].iov_base = create_twarp_buf(timewarp);
-	if (iov[num].iov_base == NULL)
-		return -ENOMEM;
-	iov[num].iov_len = sizeof(struct crt_twarp_ctxt);
-	*num_iovec = num + 1;
-	return 0;
+	cifs_end_extension(smb, sizeof(*buf));
 }
 
 /* See http://technet.microsoft.com/en-us/library/hh509017(v=ws.10).aspx */
@@ -2706,26 +2587,21 @@ static void setup_owner_group_sids(char *buf)
 }
 
 /* See MS-SMB2 2.2.13.2.2 and MS-DTYP 2.4.6 */
-static struct crt_sd_ctxt *
-create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
+static void fill_sd_context(struct smb_message *smb, umode_t mode, bool set_owner)
 {
-	struct crt_sd_ctxt *buf;
+	struct crt_sd_ctxt *buf = cifs_begin_extension(smb);
 	__u8 *ptr, *aclptr;
 	unsigned int acelen, acl_size, ace_count;
 	unsigned int owner_offset = 0;
 	unsigned int group_offset = 0;
+	unsigned int len;
 	struct smb3_acl acl = {};
 
-	*len = ALIGN8(sizeof(struct crt_sd_ctxt) + (sizeof(struct smb_ace) * 4));
+	len = ALIGN8(sizeof(struct crt_sd_ctxt) + (sizeof(struct smb_ace) * 4));
 
-	if (set_owner) {
+	if (set_owner)
 		/* sizeof(struct owner_group_sids) is already multiple of 8 so no need to round */
-		*len += sizeof(struct owner_group_sids);
-	}
-
-	buf = kzalloc(*len, GFP_KERNEL);
-	if (buf == NULL)
-		return buf;
+		len += sizeof(struct owner_group_sids);
 
 	ptr = (__u8 *)&buf[1];
 	if (set_owner) {
@@ -2791,33 +2667,15 @@ create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
 	memcpy(aclptr, &acl, sizeof(struct smb3_acl));
 
 	buf->ccontext.DataLength = cpu_to_le32(ptr - (__u8 *)&buf->sd);
-	*len = ALIGN8((unsigned int)(ptr - (__u8 *)buf));
-
-	return buf;
-}
-
-static int
-add_sd_context(struct kvec *iov, unsigned int *num_iovec, umode_t mode, bool set_owner)
-{
-	unsigned int num = *num_iovec;
-	unsigned int len = 0;
-
-	iov[num].iov_base = create_sd_buf(mode, set_owner, &len);
-	if (iov[num].iov_base == NULL)
-		return -ENOMEM;
-	iov[num].iov_len = len;
-	*num_iovec = num + 1;
-	return 0;
+	len = ALIGN8((unsigned int)(ptr - (__u8 *)buf));
+	cifs_end_extension(smb, len);
+	cifs_pad_to_8(smb);
 }
 
-static struct crt_query_id_ctxt *
-create_query_id_buf(void)
+/* See MS-SMB2 2.2.13.2.9 */
+static void fill_query_id_context(struct smb_message *smb)
 {
-	struct crt_query_id_ctxt *buf;
-
-	buf = kzalloc(sizeof(struct crt_query_id_ctxt), GFP_KERNEL);
-	if (!buf)
-		return NULL;
+	struct crt_query_id_ctxt *buf = cifs_begin_extension(smb);
 
 	buf->ccontext.DataOffset = cpu_to_le16(0);
 	buf->ccontext.DataLength = cpu_to_le32(0);
@@ -2829,78 +2687,19 @@ create_query_id_buf(void)
 	buf->Name[1] = 'F';
 	buf->Name[2] = 'i';
 	buf->Name[3] = 'd';
-	return buf;
-}
-
-/* See MS-SMB2 2.2.13.2.9 */
-static int
-add_query_id_context(struct kvec *iov, unsigned int *num_iovec)
-{
-	unsigned int num = *num_iovec;
-
-	iov[num].iov_base = create_query_id_buf();
-	if (iov[num].iov_base == NULL)
-		return -ENOMEM;
-	iov[num].iov_len = sizeof(struct crt_query_id_ctxt);
-	*num_iovec = num + 1;
-	return 0;
+	cifs_end_extension(smb, sizeof(*buf));
 }
 
-static void add_ea_context(struct cifs_open_parms *oparms,
-			   struct kvec *rq_iov, unsigned int *num_iovs)
+static void fill_ea_context(struct smb_message *smb, const struct cifs_open_parms *oparms)
 {
-	struct kvec *iov = oparms->ea_cctx;
+	const struct kvec *iov = oparms->ea_cctx;
 
 	if (iov && iov->iov_base && iov->iov_len) {
-		rq_iov[(*num_iovs)++] = *iov;
-		memset(iov, 0, sizeof(*iov));
-	}
-}
-
-static int
-alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
-			    const char *treename, const __le16 *path)
-{
-	int treename_len, path_len;
-	struct nls_table *cp;
-	const __le16 sep[] = {cpu_to_le16('\\'), cpu_to_le16(0x0000)};
+		void *p = cifs_begin_extension(smb);
 
-	/*
-	 * skip leading "\\"
-	 */
-	treename_len = strlen(treename);
-	if (treename_len < 2 || !(treename[0] == '\\' && treename[1] == '\\'))
-		return -EINVAL;
-
-	treename += 2;
-	treename_len -= 2;
-
-	path_len = UniStrnlen((wchar_t *)path, PATH_MAX);
-
-	/* make room for one path separator only if @path isn't empty */
-	*out_len = treename_len + (path[0] ? 1 : 0) + path_len;
-
-	/*
-	 * final path needs to be 8-byte aligned as specified in
-	 * MS-SMB2 2.2.13 SMB2 CREATE Request.
-	 */
-	*out_size = ALIGN8(*out_len * sizeof(__le16));
-	*out_path = kzalloc(*out_size + sizeof(__le16) /* null */, GFP_KERNEL);
-	if (!*out_path)
-		return -ENOMEM;
-
-	cp = load_nls_default();
-	cifs_strtoUTF16(*out_path, treename, treename_len, cp);
-
-	/* Do not append the separator if the path is empty */
-	if (path[0] != cpu_to_le16(0x0000)) {
-		UniStrcat((wchar_t *)*out_path, (wchar_t *)sep);
-		UniStrcat((wchar_t *)*out_path, (wchar_t *)path);
+		memcpy(p, iov->iov_base, iov->iov_len);
+		cifs_end_extension(smb, iov->iov_len);
 	}
-
-	unload_nls(cp);
-
-	return 0;
 }
 
 struct smb2_create_layout {
@@ -2912,7 +2711,6 @@ struct smb2_create_layout {
 	u16		name_offset;	/* Offset in message of name */
 	u16		contexts_offset; /* Offset in message contexts */
 	u16		contexts_len;	/* Length of contexts (or 0) */
-	u16		posix_offset;	/* Offset in message of posix context */
 	u8		name_pad;	/* Amount of name padding needed */
 };
 
@@ -2920,8 +2718,6 @@ static int smb311_posix_mkdir_layout(struct cifs_tcon *tcon,
 				     struct smb2_create_layout *lay)
 {
 	size_t offset = lay->offset;
-	size_t tmp;
-	bool has_contexts = false;
 
 	/* [MS-SMB2] 2.2.13 NameOffset: If SMB2_FLAGS_DFS_OPERATIONS
 	 * is set in the Flags field of the SMB2 header, the file name
@@ -2950,22 +2746,17 @@ static int smb311_posix_mkdir_layout(struct cifs_tcon *tcon,
 	}
 
 	offset += lay->name_len;
-	tmp = offset;
-	offset = ALIGN8(offset);
-	lay->name_pad = offset - tmp;
+	offset = ALIGN(offset, 8);
 	lay->contexts_offset = offset;
 
-	if (tcon->posix_extensions) {
+	if (tcon->posix_extensions)
 		/* resource #3: posix buf */
 		offset += sizeof(struct create_posix);
-		has_contexts = true;
-	}
 
-	if (has_contexts)
-		lay->contexts_len = offset - lay->contexts_offset;
+	if (offset == lay->contexts_offset)
+		lay->contexts_offset = 0; /* None */
 	else
-		lay->contexts_offset = 0;
-
+		lay->contexts_len = offset - lay->contexts_offset;
 	lay->offset = offset;
 	return 0;
 }
@@ -3065,13 +2856,12 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 		memcpy(name, utf16_path, layout.path_len);
 	}
 
-	if (layout.name_pad)
-		memset(smb->request + layout.name_offset + layout.name_len,
-		       0, layout.name_pad);
+	smb->offset = layout.name_offset + layout.name_len;
+	cifs_pad_to_8(smb);
 
 	if (tcon->posix_extensions)
 		/* resource #3: posix buf */
-		fill_posix_buf(smb->request + layout.posix_offset, mode);
+		fill_posix_context(smb, mode);
 
 	/* no need to inc num_remote_opens because we close it just below */
 	trace_smb3_posix_mkdir_enter(xid, tcon->tid, ses->Suid, full_path, CREATE_NOT_FILE,
@@ -3119,81 +2909,185 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	return rc;
 }
 
-int
-SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
-	       struct smb_rqst *rqst, __u8 *oplock,
-	       struct cifs_open_parms *oparms, __le16 *path)
+/*
+ * Calculate the request size and layout for an "open" (i.e. Create) request.
+ */
+static int smb2_lay_out_open(const struct cifs_tcon *tcon,
+			     const struct TCP_Server_Info *server,
+			     __u8 oplock,
+			     const struct cifs_open_parms *oparms,
+			     struct smb2_create_layout *lay)
+{
+	size_t offset = lay->offset, csize, tmp;
+
+	/* [MS-SMB2] 2.2.13 NameOffset: If SMB2_FLAGS_DFS_OPERATIONS
+	 * is set in the Flags field of the SMB2 header, the file name
+	 * includes a prefix that will be processed during DFS name
+	 * normalization as specified in section 3.3.5.9. Otherwise,
+	 * the file name is relative to the share that is identified
+	 * by the TreeId in the SMB2 header.
+	 */
+	lay->name_offset = offset;
+	if (tcon->share_flags & SHI1005_FLAGS_DFS) {
+		const char *treename = tcon->tree_name;
+		int treename_len;
+
+		/* skip leading "\\" */
+		if (!(treename[0] == '\\' && treename[1] == '\\'))
+			return -EINVAL;
+
+		treename_len = cifs_size_strtoUTF16(treename + 2, INT_MAX, lay->cp);
+
+		lay->treename_len = treename_len;
+		lay->name_len = treename_len;
+		if (lay->path_len)
+			lay->name_len += 2 + lay->path_len;
+	} else {
+		lay->name_len = lay->path_len;
+	}
+
+	offset += lay->name_len;
+	tmp = offset;
+	offset = round_up(offset, 8);
+	lay->name_pad = offset - tmp;
+	lay->contexts_offset = offset;
+
+	/* TODO: This bit of code is very suspicious. */
+	if (!(server->capabilities & SMB2_GLOBAL_CAP_LEASING) ||
+	    oplock == SMB2_OPLOCK_LEVEL_NONE)
+		;
+	else if (!(server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING) &&
+		 (oparms->create_options & CREATE_NOT_FILE))
+		; /* no srv lease support */
+	else
+		offset = ALIGN(offset, 8) + server->vals->create_lease_size;
+
+	if (oplock == SMB2_OPLOCK_LEVEL_BATCH) {
+		if (!tcon->use_persistent)
+			csize = sizeof(struct create_durable);
+		else if (oparms->reconnect)
+			csize = sizeof(struct create_durable_handle_reconnect_v2);
+		else
+			csize = sizeof(struct create_durable_v2);
+		offset = ALIGN(offset, 8) + csize;
+	}
+
+	if (tcon->posix_extensions)
+		offset = ALIGN(offset, 8) + sizeof(struct create_posix);
+	if (tcon->snapshot_time)
+		offset = ALIGN(offset, 8) + sizeof(struct crt_twarp_ctxt);
+
+	if (oparms->disposition != FILE_OPEN && oparms->cifs_sb) {
+		bool set_mode;
+		bool set_owner;
+
+		set_mode = (oparms->cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MODE_FROM_SID) &&
+			(oparms->mode != ACL_NO_MODE);
+
+		set_owner = oparms->cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UID_FROM_ACL;
+
+		if (set_owner || set_mode) {
+			csize = sizeof(struct crt_sd_ctxt) + sizeof(struct smb_ace) * 4;
+			csize = round_up(csize, 8);
+
+			if (set_owner) {
+				/* sizeof(struct owner_group_sids) is already
+				 * multiple of 8 so no need to round */
+				csize += sizeof(struct owner_group_sids);
+			}
+		}
+		offset = ALIGN(offset, 8) + csize;
+	}
+
+	offset = ALIGN(offset, 8) + sizeof(struct crt_query_id_ctxt);
+
+	/* TODO: Pass down the desired EA list and render directly into the buffer. */
+	if (oparms->ea_cctx->iov_base && oparms->ea_cctx->iov_len)
+		offset = ALIGN(offset, 8) + oparms->ea_cctx->iov_len;
+
+	if (tcon->posix_extensions)
+		offset = ALIGN(offset, 8) + sizeof(struct create_posix);
+
+	lay->contexts_len = offset - lay->contexts_offset;
+	lay->offset = offset;
+	return 0;
+}
+
+struct smb_message *SMB2_open_init(struct cifs_tcon *tcon,
+				   struct TCP_Server_Info *server, __u8 *oplock,
+				   struct cifs_open_parms *oparms, __le16 *path)
 {
 	struct smb2_create_req *req;
-	unsigned int n_iov = 2;
+	struct smb_message *smb;
 	__u32 file_attributes = 0;
-	int copy_size;
-	int uni_path_len;
-	unsigned int total_len;
-	struct kvec *iov = rqst->rq_iov;
-	__le16 *copy_path;
 	int rc;
 
-	rc = smb2_plain_req_init(SMB2_CREATE, tcon, server,
-				 (void **) &req, &total_len);
-	if (rc)
-		return rc;
+	if (!server->oplocks || tcon->no_lease)
+		*oplock = SMB2_OPLOCK_LEVEL_NONE;
 
-	iov[0].iov_base = (char *)req;
-	/* -1 since last byte is buf[0] which is sent below (path) */
-	iov[0].iov_len = total_len - 1;
+	struct smb2_create_layout layout = {
+		.cp		= oparms->cifs_sb->local_nls,
+		.offset		= sizeof(struct smb2_create_req),
+		.path_len	= UniStrnlen((wchar_t *)path, PATH_MAX) * 2,
+	};
+
+	rc = smb2_lay_out_open(tcon, server, *oplock, oparms, &layout);
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	smb = smb2_create_request(SMB2_CREATE, server, tcon,
+				  sizeof(*req), layout.offset, 0,
+				  SMB2_REQ_DYNAMIC);
+	if (!smb)
+		return ERR_PTR(-ENOMEM);
 
 	if (oparms->create_options & CREATE_OPTION_READONLY)
 		file_attributes |= ATTR_READONLY;
 	if (oparms->create_options & CREATE_OPTION_SPECIAL)
 		file_attributes |= ATTR_SYSTEM;
 
-	req->ImpersonationLevel = IL_IMPERSONATION;
-	req->DesiredAccess = cpu_to_le32(oparms->desired_access);
+	req->ImpersonationLevel	= IL_IMPERSONATION;
+	req->DesiredAccess	= cpu_to_le32(oparms->desired_access);
 	/* File attributes ignored on open (used in create though) */
-	req->FileAttributes = cpu_to_le32(file_attributes);
-	req->ShareAccess = FILE_SHARE_ALL_LE;
-
-	req->CreateDisposition = cpu_to_le32(oparms->disposition);
-	req->CreateOptions = cpu_to_le32(oparms->create_options & CREATE_OPTIONS_MASK);
-	req->NameOffset = cpu_to_le16(sizeof(struct smb2_create_req));
+	req->FileAttributes	= cpu_to_le32(file_attributes);
+	req->ShareAccess	= FILE_SHARE_ALL_LE;
+	req->CreateDisposition	= cpu_to_le32(oparms->disposition);
+	req->CreateOptions	= cpu_to_le32(oparms->create_options & CREATE_OPTIONS_MASK);
+	req->NameOffset		= cpu_to_le16(layout.name_offset);
+	req->NameLength		= cpu_to_le16(layout.name_len);
+	req->RequestedOplockLevel = SMB2_OPLOCK_LEVEL_NONE;
+	req->CreateContextsOffset = cpu_to_le32(layout.contexts_offset);
+	req->CreateContextsLength = cpu_to_le32(layout.contexts_len);
 
 	/* [MS-SMB2] 2.2.13 NameOffset:
-	 * If SMB2_FLAGS_DFS_OPERATIONS is set in the Flags field of
-	 * the SMB2 header, the file name includes a prefix that will
-	 * be processed during DFS name normalization as specified in
-	 * section 3.3.5.9. Otherwise, the file name is relative to
-	 * the share that is identified by the TreeId in the SMB2
-	 * header.
+	 * If SMB2_FLAGS_DFS_OPERATIONS is set in the Flags field of the SMB2
+	 * header, the file name includes a prefix that will be processed
+	 * during DFS name normalization as specified in section
+	 * 3.3.5.9. Otherwise, the file name is relative to the share that is
+	 * identified by the TreeId in the SMB2 header.
 	 */
+	__le16 *name = smb->request + layout.name_offset;
+
 	if (tcon->share_flags & SHI1005_FLAGS_DFS) {
-		int name_len;
+		int tmp;
 
 		req->hdr.Flags |= SMB2_FLAGS_DFS_OPERATIONS;
-		rc = alloc_path_with_tree_prefix(&copy_path, &copy_size,
-						 &name_len,
-						 tcon->tree_name, path);
-		if (rc)
-			return rc;
-		req->NameLength = cpu_to_le16(name_len * 2);
-		uni_path_len = copy_size;
-		path = copy_path;
-	} else {
-		uni_path_len = (2 * UniStrnlen((wchar_t *)path, PATH_MAX)) + 2;
-		/* MUST set path len (NameLength) to 0 opening root of share */
-		req->NameLength = cpu_to_le16(uni_path_len - 2);
-		copy_size = ALIGN8(uni_path_len);
-		copy_path = kzalloc(copy_size, GFP_KERNEL);
-		if (!copy_path)
-			return -ENOMEM;
-		memcpy((char *)copy_path, (const char *)path,
-		       uni_path_len);
-		uni_path_len = copy_size;
-		path = copy_path;
+
+		tmp = cifs_strtoUTF16(name, tcon->tree_name + 2, INT_MAX,
+				      layout.cp);
+		WARN_ON(tmp != layout.treename_len);
+		name += tmp;
+		if (layout.path_len) {
+			*name++ = cpu_to_le16('\\');
+			memcpy(name, path, layout.path_len);
+		}
+	} else if (layout.path_len) {
+		memcpy(name, path, layout.path_len);
 	}
 
-	iov[1].iov_len = uni_path_len;
-	iov[1].iov_base = path;
+	smb->offset = layout.name_offset + layout.name_len;
+	cifs_pad_to_8(smb);
+	WARN_ON_ONCE(smb->offset != layout.contexts_offset);
 
 	if ((!server->oplocks) || (tcon->no_lease))
 		*oplock = SMB2_OPLOCK_LEVEL_NONE;
@@ -3205,32 +3099,21 @@ SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 		  (oparms->create_options & CREATE_NOT_FILE))
 		req->RequestedOplockLevel = *oplock; /* no srv lease support */
 	else {
-		rc = add_lease_context(server, req, iov, &n_iov,
-				       oparms->fid->lease_key, oplock,
-				       oparms->fid->parent_lease_key,
-				       oparms->lease_flags);
-		if (rc)
-			return rc;
+		fill_lease_context(server, req, smb,
+				   oparms->fid->lease_key, oplock,
+				   oparms->fid->parent_lease_key,
+				   oparms->lease_flags);
 	}
 
-	if (*oplock == SMB2_OPLOCK_LEVEL_BATCH) {
-		rc = add_durable_context(iov, &n_iov, oparms,
-					tcon->use_persistent);
-		if (rc)
-			return rc;
-	}
+	if (*oplock == SMB2_OPLOCK_LEVEL_BATCH)
+		fill_durable_context(smb, oparms, tcon->use_persistent);
 
-	if (tcon->posix_extensions) {
-		rc = add_posix_context(iov, &n_iov, oparms->mode);
-		if (rc)
-			return rc;
-	}
+	if (tcon->posix_extensions)
+		fill_posix_context(smb, oparms->mode);
 
 	if (tcon->snapshot_time) {
 		cifs_dbg(FYI, "adding snapshot context\n");
-		rc = add_twarp_context(iov, &n_iov, tcon->snapshot_time);
-		if (rc)
-			return rc;
+		fill_twarp_context(smb, tcon->snapshot_time);
 	}
 
 	if ((oparms->disposition != FILE_OPEN) && (oparms->cifs_sb)) {
@@ -3252,40 +3135,13 @@ SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 
 		if (set_owner | set_mode) {
 			cifs_dbg(FYI, "add sd with mode 0x%x\n", oparms->mode);
-			rc = add_sd_context(iov, &n_iov, oparms->mode, set_owner);
-			if (rc)
-				return rc;
+			fill_sd_context(smb, oparms->mode, set_owner);
 		}
 	}
 
-	add_query_id_context(iov, &n_iov);
-	add_ea_context(oparms, iov, &n_iov);
-
-	if (n_iov > 2) {
-		/*
-		 * We have create contexts behind iov[1] (the file
-		 * name), point at them from the main create request
-		 */
-		req->CreateContextsOffset = cpu_to_le32(
-			sizeof(struct smb2_create_req) +
-			iov[1].iov_len);
-		req->CreateContextsLength = 0;
-
-		for (unsigned int i = 2; i < (n_iov-1); i++) {
-			struct kvec *v = &iov[i];
-			size_t len = v->iov_len;
-			struct create_context *cctx =
-				(struct create_context *)v->iov_base;
-
-			cctx->Next = cpu_to_le32(len);
-			le32_add_cpu(&req->CreateContextsLength, len);
-		}
-		le32_add_cpu(&req->CreateContextsLength,
-			     iov[n_iov-1].iov_len);
-	}
-
-	rqst->rq_nvec = n_iov;
-	return 0;
+	fill_query_id_context(smb);
+	fill_ea_context(smb, oparms);
+	return smb;
 }
 
 static void
@@ -3333,14 +3189,14 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 		 posix->nlink, posix->mode, posix->reparse_tag);
 }
 
-int smb2_parse_contexts(struct TCP_Server_Info *server,
-			struct kvec *rsp_iov,
-			__u16 *epoch,
-			char *lease_key, __u8 *oplock,
-			struct smb2_file_all_info *buf,
-			struct create_posix_rsp *posix)
+int smb2_parse_create_response(struct TCP_Server_Info *server,
+			       struct smb_message *smb,
+			       __u16 *epoch,
+			       char *lease_key, __u8 *oplock,
+			       struct smb2_file_all_info *buf,
+			       struct create_posix_rsp *posix)
 {
-	struct smb2_create_rsp *rsp = rsp_iov->iov_base;
+	struct smb2_create_rsp *rsp = smb->response;
 	struct create_context *cc;
 	size_t rem, off, len;
 	size_t doff, dlen;
@@ -3356,7 +3212,7 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 
 	off = le32_to_cpu(rsp->CreateContextsOffset);
 	rem = le32_to_cpu(rsp->CreateContextsLength);
-	if (check_add_overflow(off, rem, &len) || len > rsp_iov->iov_len)
+	if (check_add_overflow(off, rem, &len) || len > smb->response_len)
 		return -EINVAL;
 	cc = (struct create_context *)((u8 *)rsp + off);
 
@@ -3412,39 +3268,18 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 	return 0;
 }
 
-/* rq_iov[0] is the request and is released by cifs_small_buf_release().
- * All other vectors are freed by kfree().
- */
-void
-SMB2_open_free(struct smb_rqst *rqst)
-{
-	int i;
-
-	if (rqst && rqst->rq_iov) {
-		cifs_small_buf_release(rqst->rq_iov[0].iov_base);
-		for (i = 1; i < rqst->rq_nvec; i++)
-			if (rqst->rq_iov[i].iov_base != smb2_padding)
-				kfree(rqst->rq_iov[i].iov_base);
-	}
-}
-
-int
-SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
-	  __u8 *oplock, struct smb2_file_all_info *buf,
-	  struct create_posix_rsp *posix,
-	  struct kvec *err_iov, int *buftype)
+int SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
+	      __u8 *oplock, struct smb2_file_all_info *buf,
+	      struct create_posix_rsp *posix, struct kvec *err_iov)
 {
-	struct smb_rqst rqst;
+	struct TCP_Server_Info *server;
 	struct smb2_create_rsp *rsp = NULL;
+	struct smb_message *smb;
 	struct cifs_tcon *tcon = oparms->tcon;
 	struct cifs_ses *ses = tcon->ses;
-	struct TCP_Server_Info *server;
-	struct kvec iov[SMB2_CREATE_IOV_SIZE];
-	struct kvec rsp_iov = {NULL, 0};
-	int resp_buftype = CIFS_NO_BUFFER;
-	int rc = 0;
-	int flags = 0;
 	int retries = 0, cur_sleep = 1;
+	int flags = 0;
+	int rc = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -3459,34 +3294,27 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	memset(&iov, 0, sizeof(iov));
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = SMB2_CREATE_IOV_SIZE;
-
-	rc = SMB2_open_init(tcon, server,
-			    &rqst, oplock, oparms, path);
-	if (rc)
+	smb = SMB2_open_init(tcon, server, oplock, oparms, path);
+	if (IS_ERR(smb)) {
+		rc = PTR_ERR(smb);
+		smb = NULL;
 		goto creat_exit;
+	}
 
 	trace_smb3_open_enter(xid, tcon->tid, tcon->ses->Suid, oparms->path,
 		oparms->create_options, oparms->desired_access);
 
 	if (retries)
-		smb2_set_replay(server, &rqst);
+		smb2_set_replay_smb(server, smb);
 
-	rc = cifs_send_recv(xid, ses, server,
-			    &rqst, &resp_buftype, flags,
-			    &rsp_iov);
-	rsp = (struct smb2_create_rsp *)rsp_iov.iov_base;
+	rc = smb_send_recv_messages(xid, ses, server, smb, flags);
+	rsp = (struct smb2_create_rsp *)smb->response;
 
 	if (rc != 0) {
 		cifs_stats_fail_inc(tcon, SMB2_CREATE);
 		if (err_iov && rsp) {
-			*err_iov = rsp_iov;
-			*buftype = resp_buftype;
-			resp_buftype = CIFS_NO_BUFFER;
-			rsp = NULL;
+			err_iov->iov_base = smb->response;
+			err_iov->iov_len  = smb->response_len;
 		}
 		trace_smb3_open_err(xid, tcon->tid, ses->Suid,
 				    oparms->create_options, oparms->desired_access, rc);
@@ -3496,10 +3324,11 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 			tcon->need_reconnect = true;
 		}
 		goto creat_exit;
-	} else if (rsp == NULL) /* unlikely to happen, but safer to check */
+	}
+	if (!rsp) /* unlikely to happen, but safer to check */
 		goto creat_exit;
-	else
-		trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
+
+	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
 				     oparms->create_options, oparms->desired_access);
 
 	atomic_inc(&tcon->num_remote_opens);
@@ -3523,12 +3352,10 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	}
 
 
-	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
-				 oparms->fid->lease_key, oplock, buf, posix);
+	rc = smb2_parse_create_response(server, smb, &oparms->fid->epoch,
+					oparms->fid->lease_key, oplock, buf, posix);
 creat_exit:
-	SMB2_open_free(&rqst);
-	free_rsp_buf(resp_buftype, rsp);
-
+	smb_put_messages(smb);
 	if (is_replayable_error(rc) &&
 	    smb2_should_replay(tcon, &retries, &cur_sleep))
 		goto replay_again;
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 22284a52f300..f854093dd92c 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -151,17 +151,12 @@ extern int SMB2_tcon(const unsigned int xid, struct cifs_ses *ses,
 		     const char *tree, struct cifs_tcon *tcon,
 		     const struct nls_table *);
 extern int SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon);
-extern int SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms,
-		     __le16 *path, __u8 *oplock,
-		     struct smb2_file_all_info *buf,
-		     struct create_posix_rsp *posix,
-		     struct kvec *err_iov, int *resp_buftype);
-extern int SMB2_open_init(struct cifs_tcon *tcon,
-			  struct TCP_Server_Info *server,
-			  struct smb_rqst *rqst,
-			  __u8 *oplock, struct cifs_open_parms *oparms,
-			  __le16 *path);
-extern void SMB2_open_free(struct smb_rqst *rqst);
+int SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
+	      __u8 *oplock, struct smb2_file_all_info *buf,
+	      struct create_posix_rsp *posix, struct kvec *err_iov);
+struct smb_message *SMB2_open_init(struct cifs_tcon *tcon,
+				   struct TCP_Server_Info *server, __u8 *oplock,
+				   struct cifs_open_parms *oparms, __le16 *path);
 extern int SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon,
 		     u64 persistent_fid, u64 volatile_fid, u32 opcode,
 		     char *in_data, u32 indatalen, u32 maxoutlen,
@@ -276,12 +271,12 @@ extern int smb3_validate_negotiate(const unsigned int, struct cifs_tcon *);
 
 extern enum securityEnum smb2_select_sectype(struct TCP_Server_Info *,
 					enum securityEnum);
-int smb2_parse_contexts(struct TCP_Server_Info *server,
-			struct kvec *rsp_iov,
-			__u16 *epoch,
-			char *lease_key, __u8 *oplock,
-			struct smb2_file_all_info *buf,
-			struct create_posix_rsp *posix);
+int smb2_parse_create_response(struct TCP_Server_Info *server,
+			       struct smb_message *smb,
+			       __u16 *epoch,
+			       char *lease_key, __u8 *oplock,
+			       struct smb2_file_all_info *buf,
+			       struct create_posix_rsp *posix);
 
 extern int smb3_encryption_required(const struct cifs_tcon *tcon);
 extern int smb2_validate_iov(unsigned int offset, unsigned int buffer_length,


