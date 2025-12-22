Return-Path: <linux-fsdevel+bounces-71883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61195CD75A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9705530A9574
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E23350D7E;
	Mon, 22 Dec 2025 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNaJ1GSH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FF350A34
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442741; cv=none; b=Md+YZgPvFmKEdnd99ALuITgu3hla6c+RjVDLhIqWrOIdzmJLPs0rdUcVR6Ac5t5yumaHu0qM1Qv0SfiwQzeyvprXmYHTl5/8q0l0ZxDlQgdcTjSD7FKlao/3Jzg3g8+LKTZVbwjCeU6JIZBBTKs5RbZW11xpQZLxH46QfS/C7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442741; c=relaxed/simple;
	bh=CZPd+ig4Bdcgsw8S0/t2d7xQJ096+lQEIUbnIzn8B3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYhdoRygvlA4dMvl8crsF/RqZoXV0snE6KfVWonD/1BIVd0NI1BkpApQQxo8FaJF3CMhid5wrPGsj6VGHs4ThXVryel7mh+d/Z5YyPSfaLSWQycbQHyAk6AyKjZvb5Xm4hTpU/BBkvieM/MpnuxvTvqQbc6eLKB+BTG/4Ocv07w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNaJ1GSH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwlZE2RPkbmUvY1JHqCeXxXi5atjyS9Zc3Cd72RLY9I=;
	b=fNaJ1GSHNK+nnciSzbzLqrph4+oneqUV48+XZe7nNX53cynMqtsQ8cJ6UOWpp1HKIqb2CE
	e3WMCQ2Jf61Hy5A/W/GWSmc2WHvvjc5LkRr1k/fSWZVK12f9BjQ0REMkJW7Gs9nF45iYsP
	B3TLqEtbuE0ffS+2M8DQvKsSVTLs5yY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-KLSQsTDbM3melhpLH9NE1g-1; Mon,
 22 Dec 2025 17:32:06 -0500
X-MC-Unique: KLSQsTDbM3melhpLH9NE1g-1
X-Mimecast-MFC-AGG-ID: KLSQsTDbM3melhpLH9NE1g_1766442725
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0890C195605F;
	Mon, 22 Dec 2025 22:32:05 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12FD730001A2;
	Mon, 22 Dec 2025 22:32:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 36/37] cifs: SMB1 split: connect.c
Date: Mon, 22 Dec 2025 22:30:01 +0000
Message-ID: <20251222223006.1075635-37-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Split SMB1-specific connection management stuff to smb1ops.c and move
CIFSTCon() to cifssmb.c.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifsproto.h |  20 ---
 fs/smb/client/cifssmb.c   | 140 +++++++++++++++++++++
 fs/smb/client/connect.c   | 251 --------------------------------------
 fs/smb/client/smb1ops.c   | 107 ++++++++++++++++
 fs/smb/client/smb1proto.h |   6 +
 5 files changed, 253 insertions(+), 271 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 49ff68f3c999..96d6b5325aa3 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -291,31 +291,11 @@ int cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
 int cifs_enable_signing(struct TCP_Server_Info *server,
 			bool mnt_sign_required);
 
-int CIFSTCon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
-	     struct cifs_tcon *tcon, const struct nls_table *nls_codepage);
-
-
-
-
-
-
-
 int parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 			unsigned int *num_of_nodes,
 			struct dfs_info3_param **target_nodes,
 			const struct nls_table *nls_codepage, int remap,
 			const char *searchName, bool is_unicode);
-void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
-			  struct cifs_sb_info *cifs_sb,
-			  struct smb3_fs_context *ctx);
-
-
-
-
-
-
-
-
 
 struct cifs_ses *sesInfoAlloc(void);
 void sesInfoFree(struct cifs_ses *buf_to_free);
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 8738fdbb5a59..3990a9012264 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -534,6 +534,146 @@ CIFSSMBNegotiate(const unsigned int xid,
 	return rc;
 }
 
+/*
+ * Issue a TREE_CONNECT request.
+ */
+int
+CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
+	 const char *tree, struct cifs_tcon *tcon,
+	 const struct nls_table *nls_codepage)
+{
+	struct smb_hdr *smb_buffer;
+	struct smb_hdr *smb_buffer_response;
+	TCONX_REQ *pSMB;
+	TCONX_RSP *pSMBr;
+	unsigned char *bcc_ptr;
+	int rc = 0;
+	int length, in_len;
+	__u16 bytes_left, count;
+
+	if (ses == NULL)
+		return smb_EIO(smb_eio_trace_null_pointers);
+
+	smb_buffer = cifs_buf_get();
+	if (smb_buffer == NULL)
+		return -ENOMEM;
+
+	smb_buffer_response = smb_buffer;
+
+	in_len = header_assemble(smb_buffer, SMB_COM_TREE_CONNECT_ANDX,
+				 NULL /*no tid */, 4 /*wct */);
+
+	smb_buffer->Mid = get_next_mid(ses->server);
+	smb_buffer->Uid = ses->Suid;
+	pSMB = (TCONX_REQ *) smb_buffer;
+	pSMBr = (TCONX_RSP *) smb_buffer_response;
+
+	pSMB->AndXCommand = 0xFF;
+	pSMB->Flags = cpu_to_le16(TCON_EXTENDED_SECINFO);
+	bcc_ptr = &pSMB->Password[0];
+
+	pSMB->PasswordLength = cpu_to_le16(1);	/* minimum */
+	*bcc_ptr = 0; /* password is null byte */
+	bcc_ptr++;              /* skip password */
+	/* already aligned so no need to do it below */
+
+	if (ses->server->sign)
+		smb_buffer->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
+
+	if (ses->capabilities & CAP_STATUS32)
+		smb_buffer->Flags2 |= SMBFLG2_ERR_STATUS;
+
+	if (ses->capabilities & CAP_DFS)
+		smb_buffer->Flags2 |= SMBFLG2_DFS;
+
+	if (ses->capabilities & CAP_UNICODE) {
+		smb_buffer->Flags2 |= SMBFLG2_UNICODE;
+		length =
+		    cifs_strtoUTF16((__le16 *) bcc_ptr, tree,
+			6 /* max utf8 char length in bytes */ *
+			(/* server len*/ + 256 /* share len */), nls_codepage);
+		bcc_ptr += 2 * length;	/* convert num 16 bit words to bytes */
+		bcc_ptr += 2;	/* skip trailing null */
+	} else {		/* ASCII */
+		strcpy(bcc_ptr, tree);
+		bcc_ptr += strlen(tree) + 1;
+	}
+	strcpy(bcc_ptr, "?????");
+	bcc_ptr += strlen("?????");
+	bcc_ptr += 1;
+	count = bcc_ptr - &pSMB->Password[0];
+	in_len += count;
+	pSMB->ByteCount = cpu_to_le16(count);
+
+	rc = SendReceive(xid, ses, smb_buffer, in_len, smb_buffer_response,
+			 &length, 0);
+
+	/* above now done in SendReceive */
+	if (rc == 0) {
+		bool is_unicode;
+
+		tcon->tid = smb_buffer_response->Tid;
+		bcc_ptr = pByteArea(smb_buffer_response);
+		bytes_left = get_bcc(smb_buffer_response);
+		length = strnlen(bcc_ptr, bytes_left - 2);
+		if (smb_buffer->Flags2 & SMBFLG2_UNICODE)
+			is_unicode = true;
+		else
+			is_unicode = false;
+
+
+		/* skip service field (NB: this field is always ASCII) */
+		if (length == 3) {
+			if ((bcc_ptr[0] == 'I') && (bcc_ptr[1] == 'P') &&
+			    (bcc_ptr[2] == 'C')) {
+				cifs_dbg(FYI, "IPC connection\n");
+				tcon->ipc = true;
+				tcon->pipe = true;
+			}
+		} else if (length == 2) {
+			if ((bcc_ptr[0] == 'A') && (bcc_ptr[1] == ':')) {
+				/* the most common case */
+				cifs_dbg(FYI, "disk share connection\n");
+			}
+		}
+		bcc_ptr += length + 1;
+		bytes_left -= (length + 1);
+		strscpy(tcon->tree_name, tree, sizeof(tcon->tree_name));
+
+		/* mostly informational -- no need to fail on error here */
+		kfree(tcon->nativeFileSystem);
+		tcon->nativeFileSystem = cifs_strndup_from_utf16(bcc_ptr,
+						      bytes_left, is_unicode,
+						      nls_codepage);
+
+		cifs_dbg(FYI, "nativeFileSystem=%s\n", tcon->nativeFileSystem);
+
+		if ((smb_buffer_response->WordCount == 3) ||
+			 (smb_buffer_response->WordCount == 7))
+			/* field is in same location */
+			tcon->Flags = le16_to_cpu(pSMBr->OptionalSupport);
+		else
+			tcon->Flags = 0;
+		cifs_dbg(FYI, "Tcon flags: 0x%x\n", tcon->Flags);
+
+		/*
+		 * reset_cifs_unix_caps calls QFSInfo which requires
+		 * need_reconnect to be false, but we would not need to call
+		 * reset_caps if this were not a reconnect case so must check
+		 * need_reconnect flag here.  The caller will also clear
+		 * need_reconnect when tcon was successful but needed to be
+		 * cleared earlier in the case of unix extensions reconnect
+		 */
+		if (tcon->need_reconnect && tcon->unix_ext) {
+			cifs_dbg(FYI, "resetting caps for %s\n", tcon->tree_name);
+			tcon->need_reconnect = false;
+			reset_cifs_unix_caps(xid, tcon, NULL, NULL);
+		}
+	}
+	cifs_buf_release(smb_buffer);
+	return rc;
+}
+
 int
 CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon)
 {
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 536edb0a8ed3..39f9e50369ea 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3462,115 +3462,6 @@ ip_connect(struct TCP_Server_Info *server)
 	return generic_ip_connect(server);
 }
 
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
-			  struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
-{
-	/*
-	 * If we are reconnecting then should we check to see if
-	 * any requested capabilities changed locally e.g. via
-	 * remount but we can not do much about it here
-	 * if they have (even if we could detect it by the following)
-	 * Perhaps we could add a backpointer to array of sb from tcon
-	 * or if we change to make all sb to same share the same
-	 * sb as NFS - then we only have one backpointer to sb.
-	 * What if we wanted to mount the server share twice once with
-	 * and once without posixacls or posix paths?
-	 */
-	__u64 saved_cap = le64_to_cpu(tcon->fsUnixInfo.Capability);
-
-	if (ctx && ctx->no_linux_ext) {
-		tcon->fsUnixInfo.Capability = 0;
-		tcon->unix_ext = 0; /* Unix Extensions disabled */
-		cifs_dbg(FYI, "Linux protocol extensions disabled\n");
-		return;
-	} else if (ctx)
-		tcon->unix_ext = 1; /* Unix Extensions supported */
-
-	if (!tcon->unix_ext) {
-		cifs_dbg(FYI, "Unix extensions disabled so not set on reconnect\n");
-		return;
-	}
-
-	if (!CIFSSMBQFSUnixInfo(xid, tcon)) {
-		__u64 cap = le64_to_cpu(tcon->fsUnixInfo.Capability);
-
-		cifs_dbg(FYI, "unix caps which server supports %lld\n", cap);
-		/*
-		 * check for reconnect case in which we do not
-		 * want to change the mount behavior if we can avoid it
-		 */
-		if (ctx == NULL) {
-			/*
-			 * turn off POSIX ACL and PATHNAMES if not set
-			 * originally at mount time
-			 */
-			if ((saved_cap & CIFS_UNIX_POSIX_ACL_CAP) == 0)
-				cap &= ~CIFS_UNIX_POSIX_ACL_CAP;
-			if ((saved_cap & CIFS_UNIX_POSIX_PATHNAMES_CAP) == 0) {
-				if (cap & CIFS_UNIX_POSIX_PATHNAMES_CAP)
-					cifs_dbg(VFS, "POSIXPATH support change\n");
-				cap &= ~CIFS_UNIX_POSIX_PATHNAMES_CAP;
-			} else if ((cap & CIFS_UNIX_POSIX_PATHNAMES_CAP) == 0) {
-				cifs_dbg(VFS, "possible reconnect error\n");
-				cifs_dbg(VFS, "server disabled POSIX path support\n");
-			}
-		}
-
-		if (cap & CIFS_UNIX_TRANSPORT_ENCRYPTION_MANDATORY_CAP)
-			cifs_dbg(VFS, "per-share encryption not supported yet\n");
-
-		cap &= CIFS_UNIX_CAP_MASK;
-		if (ctx && ctx->no_psx_acl)
-			cap &= ~CIFS_UNIX_POSIX_ACL_CAP;
-		else if (CIFS_UNIX_POSIX_ACL_CAP & cap) {
-			cifs_dbg(FYI, "negotiated posix acl support\n");
-			if (cifs_sb)
-				cifs_sb->mnt_cifs_flags |=
-					CIFS_MOUNT_POSIXACL;
-		}
-
-		if (ctx && ctx->posix_paths == 0)
-			cap &= ~CIFS_UNIX_POSIX_PATHNAMES_CAP;
-		else if (cap & CIFS_UNIX_POSIX_PATHNAMES_CAP) {
-			cifs_dbg(FYI, "negotiate posix pathnames\n");
-			if (cifs_sb)
-				cifs_sb->mnt_cifs_flags |=
-					CIFS_MOUNT_POSIX_PATHS;
-		}
-
-		cifs_dbg(FYI, "Negotiate caps 0x%x\n", (int)cap);
-#ifdef CONFIG_CIFS_DEBUG2
-		if (cap & CIFS_UNIX_FCNTL_CAP)
-			cifs_dbg(FYI, "FCNTL cap\n");
-		if (cap & CIFS_UNIX_EXTATTR_CAP)
-			cifs_dbg(FYI, "EXTATTR cap\n");
-		if (cap & CIFS_UNIX_POSIX_PATHNAMES_CAP)
-			cifs_dbg(FYI, "POSIX path cap\n");
-		if (cap & CIFS_UNIX_XATTR_CAP)
-			cifs_dbg(FYI, "XATTR cap\n");
-		if (cap & CIFS_UNIX_POSIX_ACL_CAP)
-			cifs_dbg(FYI, "POSIX ACL cap\n");
-		if (cap & CIFS_UNIX_LARGE_READ_CAP)
-			cifs_dbg(FYI, "very large read cap\n");
-		if (cap & CIFS_UNIX_LARGE_WRITE_CAP)
-			cifs_dbg(FYI, "very large write cap\n");
-		if (cap & CIFS_UNIX_TRANSPORT_ENCRYPTION_CAP)
-			cifs_dbg(FYI, "transport encryption cap\n");
-		if (cap & CIFS_UNIX_TRANSPORT_ENCRYPTION_MANDATORY_CAP)
-			cifs_dbg(FYI, "mandatory transport encryption cap\n");
-#endif /* CIFS_DEBUG2 */
-		if (CIFSSMBSetFSUnixInfo(xid, tcon, cap)) {
-			if (ctx == NULL)
-				cifs_dbg(FYI, "resetting capabilities failed\n");
-			else
-				cifs_dbg(VFS, "Negotiating Unix capabilities with the server failed. Consider mounting with the Unix Extensions disabled if problems are found by specifying the nounix mount option.\n");
-
-		}
-	}
-}
-#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
-
 int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb)
 {
 	struct smb3_fs_context *ctx = cifs_sb->ctx;
@@ -3984,148 +3875,6 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 }
 #endif
 
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-/*
- * Issue a TREE_CONNECT request.
- */
-int
-CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
-	 const char *tree, struct cifs_tcon *tcon,
-	 const struct nls_table *nls_codepage)
-{
-	struct smb_hdr *smb_buffer;
-	struct smb_hdr *smb_buffer_response;
-	TCONX_REQ *pSMB;
-	TCONX_RSP *pSMBr;
-	unsigned char *bcc_ptr;
-	int rc = 0;
-	int length, in_len;
-	__u16 bytes_left, count;
-
-	if (ses == NULL)
-		return smb_EIO(smb_eio_trace_null_pointers);
-
-	smb_buffer = cifs_buf_get();
-	if (smb_buffer == NULL)
-		return -ENOMEM;
-
-	smb_buffer_response = smb_buffer;
-
-	in_len = header_assemble(smb_buffer, SMB_COM_TREE_CONNECT_ANDX,
-				 NULL /*no tid */, 4 /*wct */);
-
-	smb_buffer->Mid = get_next_mid(ses->server);
-	smb_buffer->Uid = ses->Suid;
-	pSMB = (TCONX_REQ *) smb_buffer;
-	pSMBr = (TCONX_RSP *) smb_buffer_response;
-
-	pSMB->AndXCommand = 0xFF;
-	pSMB->Flags = cpu_to_le16(TCON_EXTENDED_SECINFO);
-	bcc_ptr = &pSMB->Password[0];
-
-	pSMB->PasswordLength = cpu_to_le16(1);	/* minimum */
-	*bcc_ptr = 0; /* password is null byte */
-	bcc_ptr++;              /* skip password */
-	/* already aligned so no need to do it below */
-
-	if (ses->server->sign)
-		smb_buffer->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
-
-	if (ses->capabilities & CAP_STATUS32)
-		smb_buffer->Flags2 |= SMBFLG2_ERR_STATUS;
-
-	if (ses->capabilities & CAP_DFS)
-		smb_buffer->Flags2 |= SMBFLG2_DFS;
-
-	if (ses->capabilities & CAP_UNICODE) {
-		smb_buffer->Flags2 |= SMBFLG2_UNICODE;
-		length =
-		    cifs_strtoUTF16((__le16 *) bcc_ptr, tree,
-			6 /* max utf8 char length in bytes */ *
-			(/* server len*/ + 256 /* share len */), nls_codepage);
-		bcc_ptr += 2 * length;	/* convert num 16 bit words to bytes */
-		bcc_ptr += 2;	/* skip trailing null */
-	} else {		/* ASCII */
-		strcpy(bcc_ptr, tree);
-		bcc_ptr += strlen(tree) + 1;
-	}
-	strcpy(bcc_ptr, "?????");
-	bcc_ptr += strlen("?????");
-	bcc_ptr += 1;
-	count = bcc_ptr - &pSMB->Password[0];
-	in_len += count;
-	pSMB->ByteCount = cpu_to_le16(count);
-
-	rc = SendReceive(xid, ses, smb_buffer, in_len, smb_buffer_response,
-			 &length, 0);
-
-	/* above now done in SendReceive */
-	if (rc == 0) {
-		bool is_unicode;
-
-		tcon->tid = smb_buffer_response->Tid;
-		bcc_ptr = pByteArea(smb_buffer_response);
-		bytes_left = get_bcc(smb_buffer_response);
-		length = strnlen(bcc_ptr, bytes_left - 2);
-		if (smb_buffer->Flags2 & SMBFLG2_UNICODE)
-			is_unicode = true;
-		else
-			is_unicode = false;
-
-
-		/* skip service field (NB: this field is always ASCII) */
-		if (length == 3) {
-			if ((bcc_ptr[0] == 'I') && (bcc_ptr[1] == 'P') &&
-			    (bcc_ptr[2] == 'C')) {
-				cifs_dbg(FYI, "IPC connection\n");
-				tcon->ipc = true;
-				tcon->pipe = true;
-			}
-		} else if (length == 2) {
-			if ((bcc_ptr[0] == 'A') && (bcc_ptr[1] == ':')) {
-				/* the most common case */
-				cifs_dbg(FYI, "disk share connection\n");
-			}
-		}
-		bcc_ptr += length + 1;
-		bytes_left -= (length + 1);
-		strscpy(tcon->tree_name, tree, sizeof(tcon->tree_name));
-
-		/* mostly informational -- no need to fail on error here */
-		kfree(tcon->nativeFileSystem);
-		tcon->nativeFileSystem = cifs_strndup_from_utf16(bcc_ptr,
-						      bytes_left, is_unicode,
-						      nls_codepage);
-
-		cifs_dbg(FYI, "nativeFileSystem=%s\n", tcon->nativeFileSystem);
-
-		if ((smb_buffer_response->WordCount == 3) ||
-			 (smb_buffer_response->WordCount == 7))
-			/* field is in same location */
-			tcon->Flags = le16_to_cpu(pSMBr->OptionalSupport);
-		else
-			tcon->Flags = 0;
-		cifs_dbg(FYI, "Tcon flags: 0x%x\n", tcon->Flags);
-
-		/*
-		 * reset_cifs_unix_caps calls QFSInfo which requires
-		 * need_reconnect to be false, but we would not need to call
-		 * reset_caps if this were not a reconnect case so must check
-		 * need_reconnect flag here.  The caller will also clear
-		 * need_reconnect when tcon was successful but needed to be
-		 * cleared earlier in the case of unix extensions reconnect
-		 */
-		if (tcon->need_reconnect && tcon->unix_ext) {
-			cifs_dbg(FYI, "resetting caps for %s\n", tcon->tree_name);
-			tcon->need_reconnect = false;
-			reset_cifs_unix_caps(xid, tcon, NULL, NULL);
-		}
-	}
-	cifs_buf_release(smb_buffer);
-	return rc;
-}
-#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
-
 static void delayed_free(struct rcu_head *p)
 {
 	struct cifs_sb_info *cifs_sb = container_of(p, struct cifs_sb_info, rcu);
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 65d55a81b1b2..9c3b97d2a20a 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -18,6 +18,113 @@
 #include "smberr.h"
 #include "reparse.h"
 
+void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
+			  struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
+{
+	/*
+	 * If we are reconnecting then should we check to see if
+	 * any requested capabilities changed locally e.g. via
+	 * remount but we can not do much about it here
+	 * if they have (even if we could detect it by the following)
+	 * Perhaps we could add a backpointer to array of sb from tcon
+	 * or if we change to make all sb to same share the same
+	 * sb as NFS - then we only have one backpointer to sb.
+	 * What if we wanted to mount the server share twice once with
+	 * and once without posixacls or posix paths?
+	 */
+	__u64 saved_cap = le64_to_cpu(tcon->fsUnixInfo.Capability);
+
+	if (ctx && ctx->no_linux_ext) {
+		tcon->fsUnixInfo.Capability = 0;
+		tcon->unix_ext = 0; /* Unix Extensions disabled */
+		cifs_dbg(FYI, "Linux protocol extensions disabled\n");
+		return;
+	} else if (ctx)
+		tcon->unix_ext = 1; /* Unix Extensions supported */
+
+	if (!tcon->unix_ext) {
+		cifs_dbg(FYI, "Unix extensions disabled so not set on reconnect\n");
+		return;
+	}
+
+	if (!CIFSSMBQFSUnixInfo(xid, tcon)) {
+		__u64 cap = le64_to_cpu(tcon->fsUnixInfo.Capability);
+
+		cifs_dbg(FYI, "unix caps which server supports %lld\n", cap);
+		/*
+		 * check for reconnect case in which we do not
+		 * want to change the mount behavior if we can avoid it
+		 */
+		if (ctx == NULL) {
+			/*
+			 * turn off POSIX ACL and PATHNAMES if not set
+			 * originally at mount time
+			 */
+			if ((saved_cap & CIFS_UNIX_POSIX_ACL_CAP) == 0)
+				cap &= ~CIFS_UNIX_POSIX_ACL_CAP;
+			if ((saved_cap & CIFS_UNIX_POSIX_PATHNAMES_CAP) == 0) {
+				if (cap & CIFS_UNIX_POSIX_PATHNAMES_CAP)
+					cifs_dbg(VFS, "POSIXPATH support change\n");
+				cap &= ~CIFS_UNIX_POSIX_PATHNAMES_CAP;
+			} else if ((cap & CIFS_UNIX_POSIX_PATHNAMES_CAP) == 0) {
+				cifs_dbg(VFS, "possible reconnect error\n");
+				cifs_dbg(VFS, "server disabled POSIX path support\n");
+			}
+		}
+
+		if (cap & CIFS_UNIX_TRANSPORT_ENCRYPTION_MANDATORY_CAP)
+			cifs_dbg(VFS, "per-share encryption not supported yet\n");
+
+		cap &= CIFS_UNIX_CAP_MASK;
+		if (ctx && ctx->no_psx_acl)
+			cap &= ~CIFS_UNIX_POSIX_ACL_CAP;
+		else if (CIFS_UNIX_POSIX_ACL_CAP & cap) {
+			cifs_dbg(FYI, "negotiated posix acl support\n");
+			if (cifs_sb)
+				cifs_sb->mnt_cifs_flags |=
+					CIFS_MOUNT_POSIXACL;
+		}
+
+		if (ctx && ctx->posix_paths == 0)
+			cap &= ~CIFS_UNIX_POSIX_PATHNAMES_CAP;
+		else if (cap & CIFS_UNIX_POSIX_PATHNAMES_CAP) {
+			cifs_dbg(FYI, "negotiate posix pathnames\n");
+			if (cifs_sb)
+				cifs_sb->mnt_cifs_flags |=
+					CIFS_MOUNT_POSIX_PATHS;
+		}
+
+		cifs_dbg(FYI, "Negotiate caps 0x%x\n", (int)cap);
+#ifdef CONFIG_CIFS_DEBUG2
+		if (cap & CIFS_UNIX_FCNTL_CAP)
+			cifs_dbg(FYI, "FCNTL cap\n");
+		if (cap & CIFS_UNIX_EXTATTR_CAP)
+			cifs_dbg(FYI, "EXTATTR cap\n");
+		if (cap & CIFS_UNIX_POSIX_PATHNAMES_CAP)
+			cifs_dbg(FYI, "POSIX path cap\n");
+		if (cap & CIFS_UNIX_XATTR_CAP)
+			cifs_dbg(FYI, "XATTR cap\n");
+		if (cap & CIFS_UNIX_POSIX_ACL_CAP)
+			cifs_dbg(FYI, "POSIX ACL cap\n");
+		if (cap & CIFS_UNIX_LARGE_READ_CAP)
+			cifs_dbg(FYI, "very large read cap\n");
+		if (cap & CIFS_UNIX_LARGE_WRITE_CAP)
+			cifs_dbg(FYI, "very large write cap\n");
+		if (cap & CIFS_UNIX_TRANSPORT_ENCRYPTION_CAP)
+			cifs_dbg(FYI, "transport encryption cap\n");
+		if (cap & CIFS_UNIX_TRANSPORT_ENCRYPTION_MANDATORY_CAP)
+			cifs_dbg(FYI, "mandatory transport encryption cap\n");
+#endif /* CIFS_DEBUG2 */
+		if (CIFSSMBSetFSUnixInfo(xid, tcon, cap)) {
+			if (ctx == NULL)
+				cifs_dbg(FYI, "resetting capabilities failed\n");
+			else
+				cifs_dbg(VFS, "Negotiating Unix capabilities with the server failed. Consider mounting with the Unix Extensions disabled if problems are found by specifying the nounix mount option.\n");
+
+		}
+	}
+}
+
 /*
  * An NT cancel request header looks just like the original request except:
  *
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index 645f3e74fcc4..5ccca02841a8 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -33,6 +33,8 @@ int small_smb_init_no_tc(const int smb_command, const int wct,
 			 struct cifs_ses *ses, void **request_buf);
 int CIFSSMBNegotiate(const unsigned int xid, struct cifs_ses *ses,
 		     struct TCP_Server_Info *server);
+int CIFSTCon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
+	     struct cifs_tcon *tcon, const struct nls_table *nls_codepage);
 int CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon);
 int CIFSSMBEcho(struct TCP_Server_Info *server);
 int CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses);
@@ -250,6 +252,10 @@ unsigned int smbCalcSize(void *buf);
 extern struct smb_version_operations smb1_operations;
 extern struct smb_version_values smb1_values;
 
+void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
+			  struct cifs_sb_info *cifs_sb,
+			  struct smb3_fs_context *ctx);
+
 /*
  * smb1session.c
  */


