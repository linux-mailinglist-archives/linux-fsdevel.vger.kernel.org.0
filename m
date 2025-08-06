Return-Path: <linux-fsdevel+bounces-56909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E4B1CDE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D435B3BE96A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0427D2BEFEB;
	Wed,  6 Aug 2025 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8ll1Nh8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8E218851
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512795; cv=none; b=qqGk0OFzIhvxCBqPDrlBrkFBmJD/esW4U+/GQmT52E7HuWbpEi1S/P4I+VqNu1n4PIOv21BHSMqJ/TNar81deCTsRzbWrO6ZFs8ElyiTizM8mNlNHbBt6piqvHRP4lw5wLFihTCuWkgD0A85CT3v1NayMKZKSJhldk5VB/xwkkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512795; c=relaxed/simple;
	bh=pScYZK0I9EANIJh7jUKFAeAVWFzRano4dJTf29mBV78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nStuzI/5a23kibrUKDFf67fZUCIupeqBMbPSOzoWSjCqcCJ1rTCOQa7mxGzc13sQLxk14NOz1gr/TjBxdQQi7KT8c8NlyMBotohWoXde50hTgVxnVYPAzk/VD5Fg1JfcPlDryfTeNUPUmsA4TAGLOcRGdjU62yTh9qytsT2yFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8ll1Nh8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66jr/y7YOc44P4z2T9xA9okDQqLDR/TOpWQnaz5O5Q0=;
	b=P8ll1Nh8IhF0rOIVvW9S0NTAsGj4qwe2TWzWPTzVgHucNvHGPpjMojM2yRWh//+fVrYNKH
	MIkkuo5cvDKebWMRtx8MUlISOwsBYwpbQyaw3C5z8wPnBkmh3ClGdrh654T4qg2zTadCM9
	Jp5gXaLq4gMADHkU824/kdOBycxGgfY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-cs8AQvgkN9el8UbyoPR5WQ-1; Wed,
 06 Aug 2025 16:39:50 -0400
X-MC-Unique: cs8AQvgkN9el8UbyoPR5WQ-1
X-Mimecast-MFC-AGG-ID: cs8AQvgkN9el8UbyoPR5WQ_1754512779
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 395971956089;
	Wed,  6 Aug 2025 20:39:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E80D180035C;
	Wed,  6 Aug 2025 20:39:35 +0000 (UTC)
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
Subject: [RFC PATCH 30/31] cifs: Convert SMB2 Posix Mkdir request
Date: Wed,  6 Aug 2025 21:36:51 +0100
Message-ID: <20250806203705.2560493-31-dhowells@redhat.com>
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
 fs/smb/client/smb2pdu.c | 244 ++++++++++++++++++++++------------------
 1 file changed, 137 insertions(+), 107 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 85486748dd7b..9fc55b315474 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2388,16 +2388,8 @@ SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 }
 
 
-static struct create_posix *
-create_posix_buf(umode_t mode)
+static void fill_posix_buf(struct create_posix *buf, umode_t mode)
 {
-	struct create_posix *buf;
-
-	buf = kzalloc(sizeof(struct create_posix),
-			GFP_KERNEL);
-	if (!buf)
-		return NULL;
-
 	buf->ccontext.DataOffset =
 		cpu_to_le16(offsetof(struct create_posix, Mode));
 	buf->ccontext.DataLength = cpu_to_le32(4);
@@ -2424,20 +2416,25 @@ create_posix_buf(umode_t mode)
 	buf->Name[15] = 0x7C;
 	buf->Mode = cpu_to_le32(mode);
 	cifs_dbg(FYI, "mode on posix create 0%o\n", mode);
-	return buf;
 }
 
 static int
 add_posix_context(struct kvec *iov, unsigned int *num_iovec, umode_t mode)
 {
+	struct create_posix *buf;
 	unsigned int num = *num_iovec;
 
-	iov[num].iov_base = create_posix_buf(mode);
 	if (mode == ACL_NO_MODE)
 		cifs_dbg(FYI, "%s: no mode\n", __func__);
-	if (iov[num].iov_base == NULL)
+
+	buf = kzalloc(sizeof(struct create_posix), GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
-	iov[num].iov_len = sizeof(struct create_posix);
+
+	fill_posix_buf(buf, mode);
+
+	iov[num].iov_base = buf;
+	iov[num].iov_len  = sizeof(struct create_posix);
 	*num_iovec = num + 1;
 	return 0;
 }
@@ -2906,72 +2903,140 @@ alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
 	return 0;
 }
 
+struct smb2_create_layout {
+	const struct nls_table *cp;
+	u16		offset;		/* Running offset for assembly */
+	u16		path_len;	/* Length of utf16 path (or 0) */
+	u16		treename_len;	/* Length of DFS prefix (or 0) */
+	u16		name_len;	/* Total name length */
+	u16		name_offset;	/* Offset in message of name */
+	u16		contexts_offset; /* Offset in message contexts */
+	u16		contexts_len;	/* Length of contexts (or 0) */
+	u16		posix_offset;	/* Offset in message of posix context */
+	u8		name_pad;	/* Amount of name padding needed */
+};
+
+static int smb311_posix_mkdir_layout(struct cifs_tcon *tcon,
+				     struct smb2_create_layout *lay)
+{
+	size_t offset = lay->offset;
+	size_t tmp;
+	bool has_contexts = false;
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
+	offset = ALIGN8(offset);
+	lay->name_pad = offset - tmp;
+	lay->contexts_offset = offset;
+
+	if (tcon->posix_extensions) {
+		/* resource #3: posix buf */
+		offset += sizeof(struct create_posix);
+		has_contexts = true;
+	}
+
+	if (has_contexts)
+		lay->contexts_len = offset - lay->contexts_offset;
+	else
+		lay->contexts_offset = 0;
+
+	lay->offset = offset;
+	return 0;
+}
+
 int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 			       umode_t mode, struct cifs_tcon *tcon,
 			       const char *full_path,
 			       struct cifs_sb_info *cifs_sb)
 {
-	struct smb_rqst rqst;
+	struct TCP_Server_Info *server;
 	struct smb2_create_req *req;
 	struct smb2_create_rsp *rsp = NULL;
+	struct smb_message *smb = NULL;
 	struct cifs_ses *ses = tcon->ses;
-	struct kvec iov[3]; /* make sure at least one for each open context */
-	struct kvec rsp_iov = {NULL, 0};
-	int resp_buftype;
-	int uni_path_len;
-	__le16 *copy_path = NULL;
-	int copy_size;
-	int rc = 0;
-	unsigned int n_iov = 2;
+	__le16 *utf16_path = NULL;
 	__u32 file_attributes = 0;
-	char *pc_buf = NULL;
+	int retries = 0, cur_sleep = 1, path_len;
 	int flags = 0;
-	unsigned int total_len;
-	__le16 *utf16_path = NULL;
-	struct TCP_Server_Info *server;
-	int retries = 0, cur_sleep = 1;
+	int rc = 0;
+
+	/* resource #1: path allocation */
+	utf16_path = cifs_convert_path_to_utf16(full_path, cifs_sb);
+	if (!utf16_path)
+		return -ENOMEM;
+	path_len = UniStrlen(utf16_path);
 
 replay_again:
 	/* reinitialize for possible replay */
 	flags = 0;
-	n_iov = 2;
 	server = cifs_pick_channel(ses);
 
 	cifs_dbg(FYI, "mkdir\n");
 
-	/* resource #1: path allocation */
-	utf16_path = cifs_convert_path_to_utf16(full_path, cifs_sb);
-	if (!utf16_path)
-		return -ENOMEM;
-
-	if (!ses || !server) {
+	if (!server) {
 		rc = -EIO;
 		goto err_free_path;
 	}
 
+	struct smb2_create_layout layout = {
+		.offset		= sizeof(struct smb2_create_req),
+		.path_len	= path_len,
+		.cp		= cifs_sb->local_nls,
+	};
+	rc = smb311_posix_mkdir_layout(tcon, &layout);
+	if (rc < 0)
+		goto err_free_path;
+
 	/* resource #2: request */
-	rc = smb2_plain_req_init(SMB2_CREATE, tcon, server,
-				 (void **) &req, &total_len);
-	if (rc)
+	rc = -ENOMEM;
+	smb = smb2_create_request(SMB2_CREATE, server, tcon,
+				  sizeof(*req), layout.offset, 0,
+				  SMB2_REQ_DYNAMIC);
+	if (!smb)
 		goto err_free_path;
 
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
-	req->ImpersonationLevel = IL_IMPERSONATION;
-	req->DesiredAccess = cpu_to_le32(FILE_WRITE_ATTRIBUTES);
+	req->ImpersonationLevel	= IL_IMPERSONATION;
+	req->DesiredAccess	= cpu_to_le32(FILE_WRITE_ATTRIBUTES);
 	/* File attributes ignored on open (used in create though) */
-	req->FileAttributes = cpu_to_le32(file_attributes);
-	req->ShareAccess = FILE_SHARE_ALL_LE;
-	req->CreateDisposition = cpu_to_le32(FILE_CREATE);
-	req->CreateOptions = cpu_to_le32(CREATE_NOT_FILE);
-
-	iov[0].iov_base = (char *)req;
-	/* -1 since last byte is buf[0] which is sent below (path) */
-	iov[0].iov_len = total_len - 1;
-
-	req->NameOffset = cpu_to_le16(sizeof(struct smb2_create_req));
+	req->FileAttributes	= cpu_to_le32(file_attributes);
+	req->ShareAccess	= FILE_SHARE_ALL_LE;
+	req->CreateDisposition	= cpu_to_le32(FILE_CREATE);
+	req->CreateOptions	= cpu_to_le32(CREATE_NOT_FILE);
+	req->NameOffset		= cpu_to_le16(layout.name_offset);
+	req->NameLength		= cpu_to_le16(layout.name_len);
+	req->RequestedOplockLevel = SMB2_OPLOCK_LEVEL_NONE;
+	req->CreateContextsOffset = cpu_to_le32(layout.contexts_offset);
+	req->CreateContextsLength = cpu_to_le32(layout.contexts_len);
 
 	/* [MS-SMB2] 2.2.13 NameOffset:
 	 * If SMB2_FLAGS_DFS_OPERATIONS is set in the Flags field of
@@ -2981,78 +3046,48 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	 * the share that is identified by the TreeId in the SMB2
 	 * header.
 	 */
+	__le16 *name = smb->request + layout.name_offset;
+
 	if (tcon->share_flags & SHI1005_FLAGS_DFS) {
-		int name_len;
+		int tmp;
 
 		req->hdr.Flags |= SMB2_FLAGS_DFS_OPERATIONS;
-		rc = alloc_path_with_tree_prefix(&copy_path, &copy_size,
-						 &name_len,
-						 tcon->tree_name, utf16_path);
-		if (rc)
-			goto err_free_req;
 
-		req->NameLength = cpu_to_le16(name_len * 2);
-		uni_path_len = copy_size;
-		/* free before overwriting resource */
-		kfree(utf16_path);
-		utf16_path = copy_path;
-	} else {
-		uni_path_len = (2 * UniStrnlen((wchar_t *)utf16_path, PATH_MAX)) + 2;
-		/* MUST set path len (NameLength) to 0 opening root of share */
-		req->NameLength = cpu_to_le16(uni_path_len - 2);
-		if (uni_path_len % 8 != 0) {
-			copy_size = roundup(uni_path_len, 8);
-			copy_path = kzalloc(copy_size, GFP_KERNEL);
-			if (!copy_path) {
-				rc = -ENOMEM;
-				goto err_free_req;
-			}
-			memcpy((char *)copy_path, (const char *)utf16_path,
-			       uni_path_len);
-			uni_path_len = copy_size;
-			/* free before overwriting resource */
-			kfree(utf16_path);
-			utf16_path = copy_path;
+		tmp = cifs_strtoUTF16(name, tcon->tree_name + 2, INT_MAX,
+				      layout.cp);
+		WARN_ON(tmp != layout.treename_len);
+		name += tmp;
+		if (layout.path_len) {
+			*name++ = cpu_to_le16('\\');
+			memcpy(name, utf16_path, layout.path_len);
 		}
+	} else {
+		memcpy(name, utf16_path, layout.path_len);
 	}
 
-	iov[1].iov_len = uni_path_len;
-	iov[1].iov_base = utf16_path;
-	req->RequestedOplockLevel = SMB2_OPLOCK_LEVEL_NONE;
+	if (layout.name_pad)
+		memset(smb->request + layout.name_offset + layout.name_len,
+		       0, layout.name_pad);
 
-	if (tcon->posix_extensions) {
+	if (tcon->posix_extensions)
 		/* resource #3: posix buf */
-		rc = add_posix_context(iov, &n_iov, mode);
-		if (rc)
-			goto err_free_req;
-		req->CreateContextsOffset = cpu_to_le32(
-			sizeof(struct smb2_create_req) +
-			iov[1].iov_len);
-		le32_add_cpu(&req->CreateContextsLength, iov[n_iov-1].iov_len);
-		pc_buf = iov[n_iov-1].iov_base;
-	}
-
-
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = n_iov;
+		fill_posix_buf(smb->request + layout.posix_offset, mode);
 
 	/* no need to inc num_remote_opens because we close it just below */
 	trace_smb3_posix_mkdir_enter(xid, tcon->tid, ses->Suid, full_path, CREATE_NOT_FILE,
 				    FILE_WRITE_ATTRIBUTES);
 
 	if (retries)
-		smb2_set_replay(server, &rqst);
+		smb2_set_replay_smb(server, smb);
 
 	/* resource #4: response buffer */
-	rc = cifs_send_recv(xid, ses, server,
-			    &rqst, &resp_buftype, flags, &rsp_iov);
+	rc = smb_send_recv_messages(xid, ses, server, smb, flags);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_CREATE);
 		trace_smb3_posix_mkdir_err(xid, tcon->tid, ses->Suid,
 					   CREATE_NOT_FILE,
 					   FILE_WRITE_ATTRIBUTES, rc);
-		goto err_free_rsp_buf;
+		goto err_free_req;
 	}
 
 	/*
@@ -3060,10 +3095,9 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	 * adding check below is slightly safer long term (and quiets Coverity
 	 * warning)
 	 */
-	rsp = (struct smb2_create_rsp *)rsp_iov.iov_base;
+	rsp = (struct smb2_create_rsp *)smb->response;
 	if (rsp == NULL) {
 		rc = -EIO;
-		kfree(pc_buf);
 		goto err_free_req;
 	}
 
@@ -3074,18 +3108,14 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 
 	/* Eventually save off posix specific response info and timestamps */
 
-err_free_rsp_buf:
-	free_rsp_buf(resp_buftype, rsp_iov.iov_base);
-	kfree(pc_buf);
 err_free_req:
-	cifs_small_buf_release(req);
+	smb_put_messages(smb);
 err_free_path:
-	kfree(utf16_path);
-
 	if (is_replayable_error(rc) &&
 	    smb2_should_replay(tcon, &retries, &cur_sleep))
 		goto replay_again;
 
+	kfree(utf16_path);
 	return rc;
 }
 


