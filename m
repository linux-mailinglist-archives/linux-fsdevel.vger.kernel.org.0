Return-Path: <linux-fsdevel+bounces-56905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DED2B1CDD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C95218C6711
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554729B229;
	Wed,  6 Aug 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/q4FdxV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264821FF33
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512764; cv=none; b=Atj+K1GF2Z/K/tMZII7o5lmHCxjzbs3el1+i0T9F/WMCetrwtF8nuyMCGis/hTasv1u9cCkip7WEXaqoV1SeU0nN1BGYIfM9RyjNAhYF+k206ZBCceZ0vqpeGax/pHfH2X+gIXnVYkO9qBByp9uYvm9CA5V2TQw8kRPQhcM84BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512764; c=relaxed/simple;
	bh=FgZs7FlbxxcfYWLEAv9uHBpudQGIcMZzepwa8tZo2os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYzlcXqFqXzGX5/uJBKPPEmQyYKEXVKMk4hbPzaH8RPVZqnIoOVty5NsUhNEpGf5q3GCgOvURXoGDIZxO8BxpuxVeSkO1FtwGm0gc32FonfPq31momzJNL8B3XDj5Au05T3lpE5FxGtSHtFR3j6ZxzfZ4IESxFmvd0k8OS65X90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/q4FdxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y38Kg6xeMPfdlB6BUDECDD4woV1aeL7i1JxW9bLzAY=;
	b=Y/q4FdxVp1xr0ufTvTObChtOPbB+KhnhEI1QsNhStAzhRQds9t3dzu8Tko3V3/bcvNM/CG
	i5SVeDUImEYjJJ76AuSvJthzJByhpnZ7m6plqW8dd986AHWgoeKxLUC+B07bh8npxMnmO9
	QzAzXkp02YBZfPOXQSsATe1pDAOac6k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-1-WtZdDROiK-vqhqVrthnw-1; Wed,
 06 Aug 2025 16:39:17 -0400
X-MC-Unique: 1-WtZdDROiK-vqhqVrthnw-1
X-Mimecast-MFC-AGG-ID: 1-WtZdDROiK-vqhqVrthnw_1754512755
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAF0D1800561;
	Wed,  6 Aug 2025 20:39:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 634881800280;
	Wed,  6 Aug 2025 20:39:12 +0000 (UTC)
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
Subject: [RFC PATCH 25/31] cifs: Convert SMB2 Session Setup request
Date: Wed,  6 Aug 2025 21:36:46 +0100
Message-ID: <20250806203705.2560493-26-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/ntlmssp.h |  20 +--
 fs/smb/client/sess.c    | 271 ++++++++++++++++++++++------------------
 fs/smb/client/smb2pdu.c | 172 ++++++++++---------------
 3 files changed, 226 insertions(+), 237 deletions(-)

diff --git a/fs/smb/client/ntlmssp.h b/fs/smb/client/ntlmssp.h
index 875de43b72de..5ca249f1c51c 100644
--- a/fs/smb/client/ntlmssp.h
+++ b/fs/smb/client/ntlmssp.h
@@ -123,7 +123,7 @@ typedef struct _CHALLENGE_MESSAGE {
 	   do not set the version is present flag */
 } __attribute__((packed)) CHALLENGE_MESSAGE, *PCHALLENGE_MESSAGE;
 
-typedef struct _AUTHENTICATE_MESSAGE {
+struct ntlmssp_authenticate_message {
 	__u8 Signature[sizeof(NTLMSSP_SIGNATURE)];
 	__le32 MessageType;  /* NtLmsAuthenticate = 3 */
 	SECURITY_BUFFER LmChallengeResponse;
@@ -136,7 +136,7 @@ typedef struct _AUTHENTICATE_MESSAGE {
 	struct	ntlmssp_version Version;
 	/* SECURITY_BUFFER */
 	char UserString[];
-} __attribute__((packed)) AUTHENTICATE_MESSAGE, *PAUTHENTICATE_MESSAGE;
+} __attribute__((packed));
 
 /*
  * Size of the session key (crypto key encrypted with the password
@@ -147,11 +147,11 @@ int build_ntlmssp_negotiate_blob(unsigned char **pbuffer, u16 *buflen,
 				 struct cifs_ses *ses,
 				 struct TCP_Server_Info *server,
 				 const struct nls_table *nls_cp);
-int build_ntlmssp_smb3_negotiate_blob(unsigned char **pbuffer, u16 *buflen,
-				 struct cifs_ses *ses,
-				 struct TCP_Server_Info *server,
-				 const struct nls_table *nls_cp);
-int build_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
-			struct cifs_ses *ses,
-			struct TCP_Server_Info *server,
-			const struct nls_table *nls_cp);
+int build_ntlmssp_smb3_negotiate_blob(struct smb_message *smb,
+				      struct cifs_ses *ses,
+				      struct TCP_Server_Info *server,
+				      const struct nls_table *nls_cp);
+int build_ntlmssp_auth_blob(struct smb_message *smb,
+			    struct cifs_ses *ses,
+			    struct TCP_Server_Info *server,
+			    const struct nls_table *nls_cp);
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 330bc3d25bad..8063cf06ea9f 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -966,32 +966,86 @@ int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
 	return 0;
 }
 
-static int size_of_ntlmssp_blob(struct cifs_ses *ses, int base_size)
+static int size_of_ntlmssp_blob(struct cifs_ses *ses, int base_size,
+				const struct nls_table *nls_cp)
 {
 	int sz = base_size + ses->auth_key.len
 		- CIFS_SESS_KEY_SIZE + CIFS_CPHTXT_SIZE + 2;
 
 	if (ses->domainName)
-		sz += sizeof(__le16) * strnlen(ses->domainName, CIFS_MAX_DOMAINNAME_LEN);
+		sz += cifs_size_strtoUTF16(ses->domainName, CIFS_MAX_DOMAINNAME_LEN,
+					   nls_cp);
 	else
 		sz += sizeof(__le16);
 
 	if (ses->user_name)
-		sz += sizeof(__le16) * strnlen(ses->user_name, CIFS_MAX_USERNAME_LEN);
+		sz += cifs_size_strtoUTF16(ses->user_name, CIFS_MAX_USERNAME_LEN,
+					   nls_cp);
 	else
 		sz += sizeof(__le16);
 
 	if (ses->workstation_name[0])
-		sz += sizeof(__le16) * strnlen(ses->workstation_name,
-					       ntlmssp_workstation_name_size(ses));
+		sz += cifs_size_strtoUTF16(ses->workstation_name,
+					   ntlmssp_workstation_name_size(ses),
+					   nls_cp);
 	else
 		sz += sizeof(__le16);
 
 	return sz;
 }
 
+static void cifs_append_security_string(struct smb_message *smb,
+					SECURITY_BUFFER *pbuf,
+					const char *str_value,
+					int str_length,
+					unsigned char **pcur,
+					const struct nls_table *nls_cp)
+{
+	int len;
+
+	if (!str_value) {
+		pbuf->BufferOffset = cpu_to_le32(smb->offset);
+		pbuf->Length = 0;
+		pbuf->MaximumLength = 0;
+		*(__le16 *)*pcur = 0;
+		smb->offset += 2;
+		pcur += 2;
+	} else {
+		len = cifs_strtoUTF16((__le16 *)*pcur,
+				      str_value,
+				      str_length,
+				      nls_cp);
+		len *= sizeof(__le16);
+		pbuf->BufferOffset = cpu_to_le32(smb->offset);
+		pbuf->Length = cpu_to_le16(len);
+		pbuf->MaximumLength = cpu_to_le16(len);
+		smb->offset += len;
+		pcur += len;
+	}
+}
+
+static void cifs_append_security_blob(struct smb_message *smb,
+				      SECURITY_BUFFER *pbuf,
+				      const void *content,
+				      int len,
+				      unsigned char **pcur)
+{
+	if (!content) {
+		pbuf->BufferOffset	= cpu_to_le32(smb->offset);
+		pbuf->Length		= 0;
+		pbuf->MaximumLength	= 0;
+	} else {
+		memcpy(pcur, content, len);
+		pbuf->BufferOffset	= cpu_to_le32(smb->offset);
+		pbuf->Length		= cpu_to_le16(len);
+		pbuf->MaximumLength	= cpu_to_le16(len);
+		smb->offset += len;
+		pcur += len;
+	}
+}
+
 static inline void cifs_security_buffer_from_str(SECURITY_BUFFER *pbuf,
-						 char *str_value,
+						 const char *str_value,
 						 int str_length,
 						 unsigned char *pstart,
 						 unsigned char **pcur,
@@ -1038,7 +1092,7 @@ int build_ntlmssp_negotiate_blob(unsigned char **pbuffer,
 	unsigned char *tmp;
 	int len;
 
-	len = size_of_ntlmssp_blob(ses, sizeof(NEGOTIATE_MESSAGE));
+	len = size_of_ntlmssp_blob(ses, sizeof(NEGOTIATE_MESSAGE), nls_cp);
 	*pbuffer = kmalloc(len, GFP_KERNEL);
 	if (!*pbuffer) {
 		rc = -ENOMEM;
@@ -1088,173 +1142,148 @@ int build_ntlmssp_negotiate_blob(unsigned char **pbuffer,
  * supported by modern servers. For safety limit to SMB3 or later
  * See notes in MS-NLMP Section 2.2.2.1 e.g.
  */
-int build_ntlmssp_smb3_negotiate_blob(unsigned char **pbuffer,
-				 u16 *buflen,
-				 struct cifs_ses *ses,
-				 struct TCP_Server_Info *server,
-				 const struct nls_table *nls_cp)
+int build_ntlmssp_smb3_negotiate_blob(struct smb_message *smb,
+				      struct cifs_ses *ses,
+				      struct TCP_Server_Info *server,
+				      const struct nls_table *nls_cp)
 {
-	int rc = 0;
-	struct negotiate_message *sec_blob;
-	__u32 flags;
+	struct negotiate_message *neg_msg;
 	unsigned char *tmp;
+	__u32 flags;
+	void *blob;
 	int len;
+	int rc = 0;
 
-	len = size_of_ntlmssp_blob(ses, sizeof(struct negotiate_message));
-	*pbuffer = kmalloc(len, GFP_KERNEL);
-	if (!*pbuffer) {
+	len = size_of_ntlmssp_blob(ses, sizeof(*neg_msg), nls_cp);
+	blob = cifs_allocate_tx_buf(server, len);
+	if (!blob) {
 		rc = -ENOMEM;
 		cifs_dbg(VFS, "Error %d during NTLMSSP allocation\n", rc);
-		*buflen = 0;
 		goto setup_ntlm_smb3_neg_ret;
 	}
-	sec_blob = (struct negotiate_message *)*pbuffer;
 
-	memset(*pbuffer, 0, sizeof(struct negotiate_message));
-	memcpy(sec_blob->Signature, NTLMSSP_SIGNATURE, 8);
-	sec_blob->MessageType = NtLmNegotiate;
+	smb_add_segment_to_tx_buf(smb, blob, len);
+	smb->offset = sizeof(*neg_msg);
 
 	/* BB is NTLMV2 session security format easier to use here? */
-	flags = NTLMSSP_NEGOTIATE_56 |	NTLMSSP_REQUEST_TARGET |
-		NTLMSSP_NEGOTIATE_128 | NTLMSSP_NEGOTIATE_UNICODE |
-		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC |
-		NTLMSSP_NEGOTIATE_ALWAYS_SIGN | NTLMSSP_NEGOTIATE_SEAL |
-		NTLMSSP_NEGOTIATE_SIGN | NTLMSSP_NEGOTIATE_VERSION;
+	flags = NTLMSSP_NEGOTIATE_56		| NTLMSSP_REQUEST_TARGET |
+		NTLMSSP_NEGOTIATE_128		| NTLMSSP_NEGOTIATE_UNICODE |
+		NTLMSSP_NEGOTIATE_NTLM		| NTLMSSP_NEGOTIATE_EXTENDED_SEC |
+		NTLMSSP_NEGOTIATE_ALWAYS_SIGN	| NTLMSSP_NEGOTIATE_SEAL |
+		NTLMSSP_NEGOTIATE_SIGN		| NTLMSSP_NEGOTIATE_VERSION;
 	if (!server->session_estab || ses->ntlmssp->sesskey_per_smbsess)
 		flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
 
-	sec_blob->Version.ProductMajorVersion = LINUX_VERSION_MAJOR;
-	sec_blob->Version.ProductMinorVersion = LINUX_VERSION_PATCHLEVEL;
-	sec_blob->Version.ProductBuild = cpu_to_le16(SMB3_PRODUCT_BUILD);
-	sec_blob->Version.NTLMRevisionCurrent = NTLMSSP_REVISION_W2K3;
+	neg_msg = (struct negotiate_message *)blob;
+	*neg_msg = (struct negotiate_message){
+		.Signature			= NTLMSSP_SIGNATURE,
+		.MessageType			= NtLmNegotiate,
+		.NegotiateFlags			= cpu_to_le32(flags),
+		.Version.ProductMajorVersion	= LINUX_VERSION_MAJOR,
+		.Version.ProductMinorVersion	= LINUX_VERSION_PATCHLEVEL,
+		.Version.ProductBuild		= cpu_to_le16(SMB3_PRODUCT_BUILD),
+		.Version.NTLMRevisionCurrent	= NTLMSSP_REVISION_W2K3,
+	};
 
-	tmp = *pbuffer + sizeof(struct negotiate_message);
 	ses->ntlmssp->client_flags = flags;
-	sec_blob->NegotiateFlags = cpu_to_le32(flags);
+	tmp = blob + sizeof(struct negotiate_message);
 
 	/* these fields should be null in negotiate phase MS-NLMP 3.1.5.1.1 */
-	cifs_security_buffer_from_str(&sec_blob->DomainName,
-				      NULL,
-				      CIFS_MAX_DOMAINNAME_LEN,
-				      *pbuffer, &tmp,
-				      nls_cp);
+	cifs_append_security_string(smb, &neg_msg->DomainName,
+				    NULL, CIFS_MAX_DOMAINNAME_LEN,
+				    &tmp, nls_cp);
 
-	cifs_security_buffer_from_str(&sec_blob->WorkstationName,
-				      NULL,
-				      CIFS_MAX_WORKSTATION_LEN,
-				      *pbuffer, &tmp,
-				      nls_cp);
-
-	*buflen = tmp - *pbuffer;
+	cifs_append_security_string(smb, &neg_msg->WorkstationName,
+				    NULL, CIFS_MAX_WORKSTATION_LEN,
+				    &tmp, nls_cp);
 setup_ntlm_smb3_neg_ret:
 	return rc;
 }
 
 
 /* See MS-NLMP 2.2.1.3 */
-int build_ntlmssp_auth_blob(unsigned char **pbuffer,
-					u16 *buflen,
-				   struct cifs_ses *ses,
-				   struct TCP_Server_Info *server,
-				   const struct nls_table *nls_cp)
+int build_ntlmssp_auth_blob(struct smb_message *smb,
+			    struct cifs_ses *ses,
+			    struct TCP_Server_Info *server,
+			    const struct nls_table *nls_cp)
 {
-	int rc;
-	AUTHENTICATE_MESSAGE *sec_blob;
-	__u32 flags;
+	struct ntlmssp_authenticate_message *auth_msg;
 	unsigned char *tmp;
+	__u32 flags;
+	void *blob;
 	int len;
+	int rc;
 
 	rc = setup_ntlmv2_rsp(ses, nls_cp);
 	if (rc) {
 		cifs_dbg(VFS, "Error %d during NTLMSSP authentication\n", rc);
-		*buflen = 0;
 		goto setup_ntlmv2_ret;
 	}
 
-	len = size_of_ntlmssp_blob(ses, sizeof(AUTHENTICATE_MESSAGE));
-	*pbuffer = kmalloc(len, GFP_KERNEL);
-	if (!*pbuffer) {
+	len = size_of_ntlmssp_blob(ses, sizeof(*auth_msg), nls_cp);
+	blob = cifs_allocate_tx_buf(server, len);
+	if (!blob) {
 		rc = -ENOMEM;
 		cifs_dbg(VFS, "Error %d during NTLMSSP allocation\n", rc);
-		*buflen = 0;
 		goto setup_ntlmv2_ret;
 	}
-	sec_blob = (AUTHENTICATE_MESSAGE *)*pbuffer;
 
-	memcpy(sec_blob->Signature, NTLMSSP_SIGNATURE, 8);
-	sec_blob->MessageType = NtLmAuthenticate;
+	smb_add_segment_to_tx_buf(smb, blob, len);
+	smb->offset = sizeof(*auth_msg);
 
 	/* send version information in ntlmssp authenticate also */
-	flags = ses->ntlmssp->server_flags | NTLMSSP_REQUEST_TARGET |
-		NTLMSSP_NEGOTIATE_TARGET_INFO | NTLMSSP_NEGOTIATE_VERSION |
+	flags = ses->ntlmssp->server_flags	| NTLMSSP_REQUEST_TARGET |
+		NTLMSSP_NEGOTIATE_TARGET_INFO	| NTLMSSP_NEGOTIATE_VERSION |
 		NTLMSSP_NEGOTIATE_WORKSTATION_SUPPLIED;
 
-	sec_blob->Version.ProductMajorVersion = LINUX_VERSION_MAJOR;
-	sec_blob->Version.ProductMinorVersion = LINUX_VERSION_PATCHLEVEL;
-	sec_blob->Version.ProductBuild = cpu_to_le16(SMB3_PRODUCT_BUILD);
-	sec_blob->Version.NTLMRevisionCurrent = NTLMSSP_REVISION_W2K3;
+	auth_msg = blob;
+	*auth_msg = (struct ntlmssp_authenticate_message){
+		.Signature			= NTLMSSP_SIGNATURE,
+		.MessageType			= NtLmAuthenticate,
+		.NegotiateFlags			= cpu_to_le32(flags),
+		.Version.ProductMajorVersion	= LINUX_VERSION_MAJOR,
+		.Version.ProductMinorVersion	= LINUX_VERSION_PATCHLEVEL,
+		.Version.ProductBuild		= cpu_to_le16(SMB3_PRODUCT_BUILD),
+		.Version.NTLMRevisionCurrent	= NTLMSSP_REVISION_W2K3,
+	};
 
-	tmp = *pbuffer + sizeof(AUTHENTICATE_MESSAGE);
-	sec_blob->NegotiateFlags = cpu_to_le32(flags);
+	tmp = blob + sizeof(*auth_msg);
 
-	sec_blob->LmChallengeResponse.BufferOffset =
-				cpu_to_le32(sizeof(AUTHENTICATE_MESSAGE));
-	sec_blob->LmChallengeResponse.Length = 0;
-	sec_blob->LmChallengeResponse.MaximumLength = 0;
+	cifs_append_security_blob(smb, &auth_msg->LmChallengeResponse,
+				  NULL, 0, &tmp);
 
-	sec_blob->NtChallengeResponse.BufferOffset =
-				cpu_to_le32(tmp - *pbuffer);
-	if (ses->user_name != NULL) {
-		memcpy(tmp, ses->auth_key.response + CIFS_SESS_KEY_SIZE,
-				ses->auth_key.len - CIFS_SESS_KEY_SIZE);
-		tmp += ses->auth_key.len - CIFS_SESS_KEY_SIZE;
+	/* Only send an NT Response for anonymous access */
+	if (ses->user_name)
+		cifs_append_security_blob(smb, &auth_msg->NtChallengeResponse,
+					  ses->auth_key.response + CIFS_SESS_KEY_SIZE,
+					  ses->auth_key.len - CIFS_SESS_KEY_SIZE,
+					  &tmp);
+	else
+		cifs_append_security_blob(smb, &auth_msg->NtChallengeResponse,
+					  NULL, 0, &tmp);
 
-		sec_blob->NtChallengeResponse.Length =
-				cpu_to_le16(ses->auth_key.len - CIFS_SESS_KEY_SIZE);
-		sec_blob->NtChallengeResponse.MaximumLength =
-				cpu_to_le16(ses->auth_key.len - CIFS_SESS_KEY_SIZE);
-	} else {
-		/*
-		 * don't send an NT Response for anonymous access
-		 */
-		sec_blob->NtChallengeResponse.Length = 0;
-		sec_blob->NtChallengeResponse.MaximumLength = 0;
-	}
+	cifs_append_security_string(smb, &auth_msg->DomainName,
+				    ses->domainName, CIFS_MAX_DOMAINNAME_LEN,
+				    &tmp, nls_cp);
 
-	cifs_security_buffer_from_str(&sec_blob->DomainName,
-				      ses->domainName,
-				      CIFS_MAX_DOMAINNAME_LEN,
-				      *pbuffer, &tmp,
-				      nls_cp);
+	cifs_append_security_string(smb, &auth_msg->UserName,
+				    ses->user_name, CIFS_MAX_USERNAME_LEN,
+				    &tmp, nls_cp);
 
-	cifs_security_buffer_from_str(&sec_blob->UserName,
-				      ses->user_name,
-				      CIFS_MAX_USERNAME_LEN,
-				      *pbuffer, &tmp,
-				      nls_cp);
-
-	cifs_security_buffer_from_str(&sec_blob->WorkstationName,
-				      ses->workstation_name,
-				      ntlmssp_workstation_name_size(ses),
-				      *pbuffer, &tmp,
-				      nls_cp);
+	cifs_append_security_string(smb, &auth_msg->WorkstationName,
+				    ses->workstation_name,
+				    ntlmssp_workstation_name_size(ses),
+				    &tmp, nls_cp);
 
 	if ((ses->ntlmssp->server_flags & NTLMSSP_NEGOTIATE_KEY_XCH) &&
 	    (!ses->server->session_estab || ses->ntlmssp->sesskey_per_smbsess) &&
-	    !calc_seckey(ses)) {
-		memcpy(tmp, ses->ntlmssp->ciphertext, CIFS_CPHTXT_SIZE);
-		sec_blob->SessionKey.BufferOffset = cpu_to_le32(tmp - *pbuffer);
-		sec_blob->SessionKey.Length = cpu_to_le16(CIFS_CPHTXT_SIZE);
-		sec_blob->SessionKey.MaximumLength =
-				cpu_to_le16(CIFS_CPHTXT_SIZE);
-		tmp += CIFS_CPHTXT_SIZE;
-	} else {
-		sec_blob->SessionKey.BufferOffset = cpu_to_le32(tmp - *pbuffer);
-		sec_blob->SessionKey.Length = 0;
-		sec_blob->SessionKey.MaximumLength = 0;
-	}
-
-	*buflen = tmp - *pbuffer;
+	    !calc_seckey(ses))
+		cifs_append_security_blob(smb, &auth_msg->SessionKey,
+					  ses->ntlmssp->ciphertext, CIFS_CPHTXT_SIZE,
+					  &tmp);
+	else
+		cifs_append_security_blob(smb, &auth_msg->SessionKey,
+					  NULL, 0, &tmp);
 setup_ntlmv2_ret:
 	return rc;
 }
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index f1b6d36fe7cd..685af9c0cdcb 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1740,33 +1740,29 @@ struct SMB2_sess_data {
 	void (*func)(struct SMB2_sess_data *);
 	int result;
 	u64 previous_session;
-
-	/* we will send the SMB in three pieces:
-	 * a fixed length beginning part, an optional
-	 * SPNEGO blob (which can be zero length), and a
-	 * last part which will include the strings
-	 * and rest of bcc area. This allows us to avoid
-	 * a large buffer 17K allocation
-	 */
-	int buf0_type;
-	struct kvec iov[2];
 };
 
-static int
-SMB2_sess_alloc_buffer(struct SMB2_sess_data *sess_data)
+static struct smb_message *
+SMB2_create_session_request(struct SMB2_sess_data *sess_data)
 {
-	int rc;
+	struct smb_message *smb;
 	struct cifs_ses *ses = sess_data->ses;
 	struct TCP_Server_Info *server = sess_data->server;
 	struct smb2_sess_setup_req *req;
-	unsigned int total_len;
 	bool is_binding = false;
 
-	rc = smb2_plain_req_init(SMB2_SESSION_SETUP, NULL, server,
-				 (void **) &req,
-				 &total_len);
-	if (rc)
-		return rc;
+	/* We will send the SMB in three pieces:
+	 * - a fixed length beginning part,
+	 * - an optional SPNEGO blob (which can be zero length), and
+	 * - a last part which will include the strings and rest of bcc area.
+	 * This allows us to avoid a large buffer 17K allocation
+	 */
+	smb = smb2_create_request(SMB2_SESSION_SETUP, server, NULL,
+				  sizeof(*req), sizeof(*req), 0,
+				  SMB2_REQ_DYNAMIC |
+				  SMB2_REQ_SENSITIVE);
+	if (!smb)
+		return NULL;
 
 	spin_lock(&ses->ses_lock);
 	is_binding = (ses->ses_status == SES_GOOD);
@@ -1815,55 +1811,25 @@ SMB2_sess_alloc_buffer(struct SMB2_sess_data *sess_data)
 
 	req->Channel = 0; /* MBZ */
 
-	sess_data->iov[0].iov_base = (char *)req;
-	/* 1 for pad */
-	sess_data->iov[0].iov_len = total_len - 1;
-	/*
-	 * This variable will be used to clear the buffer
-	 * allocated above in case of any error in the calling function.
-	 */
-	sess_data->buf0_type = CIFS_SMALL_BUFFER;
-
-	return 0;
-}
-
-static void
-SMB2_sess_free_buffer(struct SMB2_sess_data *sess_data)
-{
-	struct kvec *iov = sess_data->iov;
-
-	/* iov[1] is already freed by caller */
-	if (sess_data->buf0_type != CIFS_NO_BUFFER && iov[0].iov_base)
-		memzero_explicit(iov[0].iov_base, iov[0].iov_len);
-
-	free_rsp_buf(sess_data->buf0_type, iov[0].iov_base);
-	sess_data->buf0_type = CIFS_NO_BUFFER;
+	/* Testing shows that buffer offset must be at location of Buffer[0] */
+	req->SecurityBufferOffset = cpu_to_le16(sizeof(*req));
+	req->SecurityBufferLength = 0;
+	return smb;
 }
 
 static int
-SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)
+SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data,
+		      struct smb_message *smb)
 {
 	int rc;
-	struct smb_rqst rqst;
-	struct smb2_sess_setup_req *req = sess_data->iov[0].iov_base;
-	struct kvec rsp_iov = { NULL, 0 };
+	struct smb2_sess_setup_req *req = smb->request;
 
-	/* Testing shows that buffer offset must be at location of Buffer[0] */
-	req->SecurityBufferOffset =
-		cpu_to_le16(sizeof(struct smb2_sess_setup_req));
-	req->SecurityBufferLength = cpu_to_le16(sess_data->iov[1].iov_len);
-
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = sess_data->iov;
-	rqst.rq_nvec = 2;
+	req->SecurityBufferLength = cpu_to_le16(smb->total_len - sizeof(*req));
 
 	/* BB add code to build os and lm fields */
-	rc = cifs_send_recv(sess_data->xid, sess_data->ses,
-			    sess_data->server,
-			    &rqst,
-			    &sess_data->buf0_type,
-			    CIFS_LOG_ERROR | CIFS_SESS_OP, &rsp_iov);
-	cifs_small_buf_release(sess_data->iov[0].iov_base);
+	rc = smb_send_recv_messages(sess_data->xid, sess_data->ses, sess_data->server,
+				    smb, CIFS_LOG_ERROR | CIFS_SESS_OP);
+	smb_clear_request(smb);
 	if (rc == 0)
 		sess_data->ses->expired_pwd = false;
 	else if ((rc == -EACCES) || (rc == -EKEYEXPIRED) || (rc == -EKEYREVOKED)) {
@@ -1875,8 +1841,6 @@ SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)
 		sess_data->ses->expired_pwd = true;
 	}
 
-	memcpy(&sess_data->iov[0], &rsp_iov, sizeof(struct kvec));
-
 	return rc;
 }
 
@@ -1911,16 +1875,18 @@ SMB2_sess_establish_session(struct SMB2_sess_data *sess_data)
 static void
 SMB2_auth_kerberos(struct SMB2_sess_data *sess_data)
 {
-	int rc;
-	struct cifs_ses *ses = sess_data->ses;
+	struct smb2_sess_setup_rsp *rsp = NULL;
 	struct TCP_Server_Info *server = sess_data->server;
 	struct cifs_spnego_msg *msg;
+	struct smb_message *smb = NULL;
+	struct cifs_ses *ses = sess_data->ses;
 	struct key *spnego_key = NULL;
-	struct smb2_sess_setup_rsp *rsp = NULL;
+	void *key_buf = NULL;
 	bool is_binding = false;
+	int rc = -ENOMEM;
 
-	rc = SMB2_sess_alloc_buffer(sess_data);
-	if (rc)
+	smb = SMB2_create_session_request(sess_data);
+	if (!smb)
 		goto out;
 
 	spnego_key = cifs_get_spnego_key(ses, server);
@@ -1962,14 +1928,21 @@ SMB2_auth_kerberos(struct SMB2_sess_data *sess_data)
 		ses->auth_key.len = msg->sesskey_len;
 	}
 
-	sess_data->iov[1].iov_base = msg->data + msg->sesskey_len;
-	sess_data->iov[1].iov_len = msg->secblob_len;
+	/* Copy the key data here so that we can pass it to MSG_SPLICE_PAGES
+	 * and the need to copy the whole message.
+	 */
+	key_buf = cifs_allocate_tx_buf(server, msg->secblob_len);
+	if (!key_buf)
+		goto out;
+
+	memcpy(key_buf, msg->data + msg->sesskey_len, msg->secblob_len);
+	smb_add_segment_to_tx_buf(smb, key_buf, msg->secblob_len);
 
-	rc = SMB2_sess_sendreceive(sess_data);
+	rc = SMB2_sess_sendreceive(sess_data, smb);
 	if (rc)
 		goto out_put_spnego_key;
 
-	rsp = (struct smb2_sess_setup_rsp *)sess_data->iov[0].iov_base;
+	rsp = (struct smb2_sess_setup_rsp *)smb->response;
 	/* keep session id and flags if binding */
 	if (!is_binding) {
 		ses->Suid = le64_to_cpu(rsp->hdr.SessionId);
@@ -1985,10 +1958,11 @@ SMB2_auth_kerberos(struct SMB2_sess_data *sess_data)
 		ses->auth_key.response = NULL;
 		ses->auth_key.len = 0;
 	}
+
 out:
+	smb_put_messages(smb);
 	sess_data->result = rc;
 	sess_data->func = NULL;
-	SMB2_sess_free_buffer(sess_data);
 }
 #else
 static void
@@ -2006,14 +1980,13 @@ SMB2_sess_auth_rawntlmssp_authenticate(struct SMB2_sess_data *sess_data);
 static void
 SMB2_sess_auth_rawntlmssp_negotiate(struct SMB2_sess_data *sess_data)
 {
-	int rc;
-	struct cifs_ses *ses = sess_data->ses;
-	struct TCP_Server_Info *server = sess_data->server;
 	struct smb2_sess_setup_rsp *rsp = NULL;
-	unsigned char *ntlmssp_blob = NULL;
+	struct TCP_Server_Info *server = sess_data->server;
+	struct smb_message *smb = NULL;
+	struct cifs_ses *ses = sess_data->ses;
 	bool use_spnego = false; /* else use raw ntlmssp */
-	u16 blob_length = 0;
 	bool is_binding = false;
+	int rc = -ENOMEM;
 
 	/*
 	 * If memory allocation is successful, caller of this function
@@ -2026,13 +1999,12 @@ SMB2_sess_auth_rawntlmssp_negotiate(struct SMB2_sess_data *sess_data)
 	}
 	ses->ntlmssp->sesskey_per_smbsess = true;
 
-	rc = SMB2_sess_alloc_buffer(sess_data);
-	if (rc)
+	smb = SMB2_create_session_request(sess_data);
+	if (!smb)
 		goto out_err;
 
-	rc = build_ntlmssp_smb3_negotiate_blob(&ntlmssp_blob,
-					  &blob_length, ses, server,
-					  sess_data->nls_cp);
+	rc = build_ntlmssp_smb3_negotiate_blob(smb, ses, server,
+					       sess_data->nls_cp);
 	if (rc)
 		goto out;
 
@@ -2042,15 +2014,12 @@ SMB2_sess_auth_rawntlmssp_negotiate(struct SMB2_sess_data *sess_data)
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
-	sess_data->iov[1].iov_base = ntlmssp_blob;
-	sess_data->iov[1].iov_len = blob_length;
 
-	rc = SMB2_sess_sendreceive(sess_data);
-	rsp = (struct smb2_sess_setup_rsp *)sess_data->iov[0].iov_base;
+	rc = SMB2_sess_sendreceive(sess_data, smb);
+	rsp = (struct smb2_sess_setup_rsp *)smb->response;
 
 	/* If true, rc here is expected and not an error */
-	if (sess_data->buf0_type != CIFS_NO_BUFFER &&
-		rsp->hdr.Status == STATUS_MORE_PROCESSING_REQUIRED)
+	if (rsp->hdr.Status == STATUS_MORE_PROCESSING_REQUIRED)
 		rc = 0;
 
 	if (rc)
@@ -2081,14 +2050,13 @@ SMB2_sess_auth_rawntlmssp_negotiate(struct SMB2_sess_data *sess_data)
 	}
 
 out:
-	kfree_sensitive(ntlmssp_blob);
-	SMB2_sess_free_buffer(sess_data);
 	if (!rc) {
 		sess_data->result = 0;
 		sess_data->func = SMB2_sess_auth_rawntlmssp_authenticate;
 		return;
 	}
 out_err:
+	smb_put_messages(smb);
 	kfree_sensitive(ses->ntlmssp);
 	ses->ntlmssp = NULL;
 	sess_data->result = rc;
@@ -2098,26 +2066,23 @@ SMB2_sess_auth_rawntlmssp_negotiate(struct SMB2_sess_data *sess_data)
 static void
 SMB2_sess_auth_rawntlmssp_authenticate(struct SMB2_sess_data *sess_data)
 {
-	int rc;
+	struct smb_message *smb;
 	struct cifs_ses *ses = sess_data->ses;
 	struct TCP_Server_Info *server = sess_data->server;
 	struct smb2_sess_setup_req *req;
 	struct smb2_sess_setup_rsp *rsp = NULL;
-	unsigned char *ntlmssp_blob = NULL;
 	bool use_spnego = false; /* else use raw ntlmssp */
-	u16 blob_length = 0;
 	bool is_binding = false;
+	int rc = -ENOMEM;
 
-	rc = SMB2_sess_alloc_buffer(sess_data);
-	if (rc)
+	smb = SMB2_create_session_request(sess_data);
+	if (!smb)
 		goto out;
 
-	req = (struct smb2_sess_setup_req *) sess_data->iov[0].iov_base;
+	req = smb->request;
 	req->hdr.SessionId = cpu_to_le64(ses->Suid);
 
-	rc = build_ntlmssp_auth_blob(&ntlmssp_blob, &blob_length,
-				     ses, server,
-				     sess_data->nls_cp);
+	rc = build_ntlmssp_auth_blob(smb, ses, server, sess_data->nls_cp);
 	if (rc) {
 		cifs_dbg(FYI, "build_ntlmssp_auth_blob failed %d\n", rc);
 		goto out;
@@ -2129,14 +2094,12 @@ SMB2_sess_auth_rawntlmssp_authenticate(struct SMB2_sess_data *sess_data)
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
-	sess_data->iov[1].iov_base = ntlmssp_blob;
-	sess_data->iov[1].iov_len = blob_length;
 
-	rc = SMB2_sess_sendreceive(sess_data);
+	rc = SMB2_sess_sendreceive(sess_data, smb);
 	if (rc)
 		goto out;
 
-	rsp = (struct smb2_sess_setup_rsp *)sess_data->iov[0].iov_base;
+	rsp = (struct smb2_sess_setup_rsp *)smb->response;
 
 	spin_lock(&ses->ses_lock);
 	is_binding = (ses->ses_status == SES_GOOD);
@@ -2165,8 +2128,6 @@ SMB2_sess_auth_rawntlmssp_authenticate(struct SMB2_sess_data *sess_data)
 	}
 #endif
 out:
-	kfree_sensitive(ntlmssp_blob);
-	SMB2_sess_free_buffer(sess_data);
 	kfree_sensitive(ses->ntlmssp);
 	ses->ntlmssp = NULL;
 	sess_data->result = rc;
@@ -2224,7 +2185,6 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_ses *ses,
 	sess_data->xid = xid;
 	sess_data->ses = ses;
 	sess_data->server = server;
-	sess_data->buf0_type = CIFS_NO_BUFFER;
 	sess_data->nls_cp = (struct nls_table *) nls_cp;
 	sess_data->previous_session = ses->Suid;
 


