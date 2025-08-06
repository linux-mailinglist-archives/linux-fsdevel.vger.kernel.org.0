Return-Path: <linux-fsdevel+bounces-56904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D47B1CDCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA20E565896
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9322157B;
	Wed,  6 Aug 2025 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kn/QR/b9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E752BE65B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512760; cv=none; b=OpNMaejVqyyz/s+/6zQT0WWm+rYmzXmnrFJ0rXKo3NrzroA+7Un6FaFpDCZ2MOPfPquMWh1ENxIXYLcvSeup3RNbpcUgHpI5+DbnJD4NoAQDQkdhpa9tmnCcijtkzVwLnaUyZPLJi2Fr16JDfFJduGuNywPcWGuMfDTkLmNMA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512760; c=relaxed/simple;
	bh=T2bSoxrSwOGDQ+OPDN6pZ89/dtL2KAnQ+Cou834QaRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA2A4DFVeo0o94Fwys/Rh7r3rpPtFp4Fa88jLyjQuv5x9QAjHj+OujOZvyX6Ky7TRVAVlH28lZ7hy4IZTFqyrpaSvPG3e9kQ6s6IWRmPHHTKWsdMGK2CQSElUAx/+uXY+fBtLyUp8yIvbV1UAS0BogQ/HrNp30b5osfCEELmILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kn/QR/b9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjeSK8GjGxfDr1EtNwWgacqn2lDSd3SKB7IJ3INJ84c=;
	b=Kn/QR/b9JzzuKjcCpBUOLe5stefCKtGiSvLkPRdX3xSI/MB+oF0z4C61qYCDPYLs2zkQN1
	WSqMhFr5nWFzL5okklm6G5h25nen3h827XfAAtfBVVuR1iEy5WUKjJy58bIoHT8OIIXoGr
	0fLnlD9ZP4/TjkIRQY0bmgzEQPrdZFs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-qbmsm-QuPm2cVbAzIxy3XA-1; Wed,
 06 Aug 2025 16:39:12 -0400
X-MC-Unique: qbmsm-QuPm2cVbAzIxy3XA-1
X-Mimecast-MFC-AGG-ID: qbmsm-QuPm2cVbAzIxy3XA_1754512750
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB54F1956094;
	Wed,  6 Aug 2025 20:39:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8238019560AD;
	Wed,  6 Aug 2025 20:39:07 +0000 (UTC)
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
Subject: [RFC PATCH 24/31] cifs: Convert SMB2 Negotiate Protocol request
Date: Wed,  6 Aug 2025 21:36:45 +0100
Message-ID: <20250806203705.2560493-25-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 509 ++++++++++++++++++++++++----------------
 fs/smb/common/smb2pdu.h |  24 +-
 fs/smb/server/smb2pdu.c |  22 +-
 3 files changed, 319 insertions(+), 236 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 58a2a4ff3368..f1b6d36fe7cd 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -788,144 +788,200 @@ static int smb2_ioctl_req_init(u32 opcode, struct cifs_tcon *tcon,
 
 /* For explanation of negotiate contexts see MS-SMB2 section 2.2.3.1 */
 
-static void
-build_preauth_ctxt(struct smb2_preauth_neg_context *pneg_ctxt)
+static void *cifs_begin_neg_context(struct smb_message *smb,
+				    __le16 context_type)
 {
-	pneg_ctxt->ContextType = SMB2_PREAUTH_INTEGRITY_CAPABILITIES;
-	pneg_ctxt->DataLength = cpu_to_le16(38);
-	pneg_ctxt->HashAlgorithmCount = cpu_to_le16(1);
-	pneg_ctxt->SaltLength = cpu_to_le16(SMB311_SALT_SIZE);
-	get_random_bytes(pneg_ctxt->Salt, SMB311_SALT_SIZE);
-	pneg_ctxt->HashAlgorithms = SMB2_PREAUTH_INTEGRITY_SHA512;
+	struct smb2_neg_context *neg;
+
+	neg = cifs_begin_extension(smb);
+	neg->ContextType	= context_type;
+	neg->Reserved		= 0;
+	return (void *)neg;
 }
 
-static void
-build_compression_ctxt(struct smb2_compression_capabilities_context *pneg_ctxt)
+static void cifs_end_neg_context(struct smb_message *smb, void *p, size_t size)
+{
+	struct smb2_neg_context *neg = p;
+
+	neg->DataLength = cpu_to_le16(size - sizeof(*neg));
+	cifs_end_extension(smb, size);
+}
+
+static void build_preauth_ctxt(struct smb_message *smb)
 {
-	pneg_ctxt->ContextType = SMB2_COMPRESSION_CAPABILITIES;
-	pneg_ctxt->DataLength =
-		cpu_to_le16(sizeof(struct smb2_compression_capabilities_context)
-			  - sizeof(struct smb2_neg_context));
-	pneg_ctxt->CompressionAlgorithmCount = cpu_to_le16(3);
-	pneg_ctxt->CompressionAlgorithms[0] = SMB3_COMPRESS_LZ77;
-	pneg_ctxt->CompressionAlgorithms[1] = SMB3_COMPRESS_LZ77_HUFF;
-	pneg_ctxt->CompressionAlgorithms[2] = SMB3_COMPRESS_LZNT1;
+	struct smb2_preauth_neg_context *preauth;
+
+	preauth = cifs_begin_neg_context(smb, SMB2_PREAUTH_INTEGRITY_CAPABILITIES);
+	preauth->HashAlgorithmCount	= cpu_to_le16(1);
+	preauth->SaltLength		= cpu_to_le16(SMB311_SALT_SIZE);
+	preauth->HashAlgorithms		= SMB2_PREAUTH_INTEGRITY_SHA512;
+	get_random_bytes(preauth->Salt, SMB311_SALT_SIZE);
+	cifs_end_neg_context(smb, preauth, sizeof(*preauth));
 }
 
-static unsigned int
-build_signing_ctxt(struct smb2_signing_capabilities *pneg_ctxt)
+static void build_compression_ctxt(struct smb_message *smb)
+{
+	struct smb2_compression_capabilities_context *compr;
+
+	compr = cifs_begin_neg_context(smb, SMB2_COMPRESSION_CAPABILITIES);
+	compr->CompressionAlgorithmCount = cpu_to_le16(3);
+	compr->CompressionAlgorithms[0] = SMB3_COMPRESS_LZ77;
+	compr->CompressionAlgorithms[1] = SMB3_COMPRESS_LZ77_HUFF;
+	compr->CompressionAlgorithms[2] = SMB3_COMPRESS_LZNT1;
+	cifs_end_neg_context(smb, compr, sizeof(*compr));
+}
+
+static size_t smb2_size_signing_ctxt(void)
+{
+	size_t ctxt_len = sizeof(struct smb2_signing_capabilities);
+	unsigned short num_algs = 1; /* number of signing algorithms sent */
+
+	ctxt_len += sizeof(__le16) * num_algs;
+	return ALIGN8(ctxt_len);
+}
+
+static void build_signing_ctxt(struct smb_message *smb)
 {
-	unsigned int ctxt_len = sizeof(struct smb2_signing_capabilities);
+	struct smb2_signing_capabilities *scap;
 	unsigned short num_algs = 1; /* number of signing algorithms sent */
 
-	pneg_ctxt->ContextType = SMB2_SIGNING_CAPABILITIES;
+	scap = cifs_begin_neg_context(smb, SMB2_SIGNING_CAPABILITIES);
+	scap->SigningAlgorithmCount = cpu_to_le16(num_algs);
+	scap->SigningAlgorithms[0] = cpu_to_le16(SIGNING_ALG_AES_CMAC);
+	/* TBD add SIGNING_ALG_AES_GMAC and/or SIGNING_ALG_HMAC_SHA256 */
+
 	/*
 	 * Context Data length must be rounded to multiple of 8 for some servers
 	 */
-	pneg_ctxt->DataLength = cpu_to_le16(ALIGN8(sizeof(struct smb2_signing_capabilities) -
-					    sizeof(struct smb2_neg_context) +
-					    (num_algs * sizeof(u16))));
-	pneg_ctxt->SigningAlgorithmCount = cpu_to_le16(num_algs);
-	pneg_ctxt->SigningAlgorithms[0] = cpu_to_le16(SIGNING_ALG_AES_CMAC);
-
-	ctxt_len += sizeof(__le16) * num_algs;
-	ctxt_len = ALIGN8(ctxt_len);
-	return ctxt_len;
-	/* TBD add SIGNING_ALG_AES_GMAC and/or SIGNING_ALG_HMAC_SHA256 */
+	cifs_end_neg_context(smb, scap,
+			     ALIGN8(struct_size(scap, SigningAlgorithms, num_algs)));
 }
 
-static void
-build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt)
+static void build_encrypt_ctxt(struct smb_message *smb)
 {
-	pneg_ctxt->ContextType = SMB2_ENCRYPTION_CAPABILITIES;
-	if (require_gcm_256) {
-		pneg_ctxt->DataLength = cpu_to_le16(4); /* Cipher Count + 1 cipher */
-		pneg_ctxt->CipherCount = cpu_to_le16(1);
-		pneg_ctxt->Ciphers[0] = SMB2_ENCRYPTION_AES256_GCM;
-	} else if (enable_gcm_256) {
-		pneg_ctxt->DataLength = cpu_to_le16(8); /* Cipher Count + 3 ciphers */
-		pneg_ctxt->CipherCount = cpu_to_le16(3);
-		pneg_ctxt->Ciphers[0] = SMB2_ENCRYPTION_AES128_GCM;
-		pneg_ctxt->Ciphers[1] = SMB2_ENCRYPTION_AES256_GCM;
-		pneg_ctxt->Ciphers[2] = SMB2_ENCRYPTION_AES128_CCM;
+	struct smb2_encryption_neg_context *ecap;
+	size_t count;
+
+	ecap = cifs_begin_neg_context(smb, SMB2_ENCRYPTION_CAPABILITIES);
+
+	if (READ_ONCE(require_gcm_256)) {
+		ecap->Ciphers[0]  = SMB2_ENCRYPTION_AES256_GCM;
+		count = 1;
+	} else if (READ_ONCE(enable_gcm_256)) {
+		ecap->Ciphers[0]  = SMB2_ENCRYPTION_AES128_GCM;
+		ecap->Ciphers[1]  = SMB2_ENCRYPTION_AES256_GCM;
+		ecap->Ciphers[2]  = SMB2_ENCRYPTION_AES128_CCM;
+		count = 3;
 	} else {
-		pneg_ctxt->DataLength = cpu_to_le16(6); /* Cipher Count + 2 ciphers */
-		pneg_ctxt->CipherCount = cpu_to_le16(2);
-		pneg_ctxt->Ciphers[0] = SMB2_ENCRYPTION_AES128_GCM;
-		pneg_ctxt->Ciphers[1] = SMB2_ENCRYPTION_AES128_CCM;
+		ecap->Ciphers[0]  = SMB2_ENCRYPTION_AES128_GCM;
+		ecap->Ciphers[1]  = SMB2_ENCRYPTION_AES128_CCM;
+		count = 2;
 	}
+	ecap->CipherCount = cpu_to_le16(count);
+	cifs_end_neg_context(smb, ecap, struct_size(ecap, Ciphers, count));
 }
 
-static unsigned int
-build_netname_ctxt(struct smb2_netname_neg_context *pneg_ctxt, char *hostname)
+static size_t smb2_size_netname_ctxt(struct TCP_Server_Info *server)
 {
+	size_t data_len;
+
+#if 0
 	struct nls_table *cp = load_nls_default();
+	const char *hostname;
 
-	pneg_ctxt->ContextType = SMB2_NETNAME_NEGOTIATE_CONTEXT_ID;
+	/* Only include up to first 100 bytes of server name in the NetName
+	 * field.
+	 */
+	cifs_server_lock(pserver);
+	hostname = pserver->hostname;
+	if (hostname && hostname[0])
+		data_len = cifs_size_strtoUTF16(hostname, 100, cp);
+	cifs_server_unlock(pserver);
+#else
+	/* Now, we can't just measure the length of hostname as, unless we hold
+	 * the lock, it may change under us, so allow maximum space for it.
+	 */
+	data_len = 400;
+#endif
+	return ALIGN8(sizeof(struct smb2_neg_context) + data_len);
+}
+
+static void build_netname_ctxt(struct smb_message *smb, const char *hostname)
+{
+	struct smb2_netname_neg_context *name;
+	struct nls_table *cp = load_nls_default();
+	size_t count;
+
+	name = cifs_begin_neg_context(smb, SMB2_NETNAME_NEGOTIATE_CONTEXT_ID);
 
 	/* copy up to max of first 100 bytes of server name to NetName field */
-	pneg_ctxt->DataLength = cpu_to_le16(2 * cifs_strtoUTF16(pneg_ctxt->NetName, hostname, 100, cp));
-	/* context size is DataLength + minimal smb2_neg_context */
-	return ALIGN8(le16_to_cpu(pneg_ctxt->DataLength) + sizeof(struct smb2_neg_context));
+	count = cifs_strtoUTF16(name->NetName, hostname, 100, cp);
+	cifs_end_neg_context(smb, name, struct_size(name, NetName, count));
 }
 
-static void
-build_posix_ctxt(struct smb2_posix_neg_context *pneg_ctxt)
+static void build_posix_ctxt(struct smb_message *smb)
 {
-	pneg_ctxt->ContextType = SMB2_POSIX_EXTENSIONS_AVAILABLE;
-	pneg_ctxt->DataLength = cpu_to_le16(POSIX_CTXT_DATA_LEN);
+	struct smb2_posix_neg_context *posix;
+
+	posix = cifs_begin_neg_context(smb, SMB2_POSIX_EXTENSIONS_AVAILABLE);
 	/* SMB2_CREATE_TAG_POSIX is "0x93AD25509CB411E7B42383DE968BCD7C" */
-	pneg_ctxt->Name[0] = 0x93;
-	pneg_ctxt->Name[1] = 0xAD;
-	pneg_ctxt->Name[2] = 0x25;
-	pneg_ctxt->Name[3] = 0x50;
-	pneg_ctxt->Name[4] = 0x9C;
-	pneg_ctxt->Name[5] = 0xB4;
-	pneg_ctxt->Name[6] = 0x11;
-	pneg_ctxt->Name[7] = 0xE7;
-	pneg_ctxt->Name[8] = 0xB4;
-	pneg_ctxt->Name[9] = 0x23;
-	pneg_ctxt->Name[10] = 0x83;
-	pneg_ctxt->Name[11] = 0xDE;
-	pneg_ctxt->Name[12] = 0x96;
-	pneg_ctxt->Name[13] = 0x8B;
-	pneg_ctxt->Name[14] = 0xCD;
-	pneg_ctxt->Name[15] = 0x7C;
+	posix->Name[0] = 0x93;
+	posix->Name[1] = 0xAD;
+	posix->Name[2] = 0x25;
+	posix->Name[3] = 0x50;
+	posix->Name[4] = 0x9C;
+	posix->Name[5] = 0xB4;
+	posix->Name[6] = 0x11;
+	posix->Name[7] = 0xE7;
+	posix->Name[8] = 0xB4;
+	posix->Name[9] = 0x23;
+	posix->Name[10] = 0x83;
+	posix->Name[11] = 0xDE;
+	posix->Name[12] = 0x96;
+	posix->Name[13] = 0x8B;
+	posix->Name[14] = 0xCD;
+	posix->Name[15] = 0x7C;
+	cifs_end_neg_context(smb, posix, sizeof(posix));
 }
 
-static void
-assemble_neg_contexts(struct smb2_negotiate_req *req,
-		      struct TCP_Server_Info *server, unsigned int *total_len)
+static size_t smb2_size_neg_contexts(struct TCP_Server_Info *server,
+				     size_t offset)
 {
-	unsigned int ctxt_len, neg_context_count;
 	struct TCP_Server_Info *pserver;
-	char *pneg_ctxt;
-	char *hostname;
-
-	if (*total_len > 200) {
-		/* In case length corrupted don't want to overrun smb buffer */
-		cifs_server_dbg(VFS, "Bad frame length assembling neg contexts\n");
-		return;
-	}
 
 	/*
 	 * round up total_len of fixed part of SMB3 negotiate request to 8
 	 * byte boundary before adding negotiate contexts
 	 */
-	*total_len = ALIGN8(*total_len);
+	offset = ALIGN8(offset);
+	offset += ALIGN8(sizeof(struct smb2_preauth_neg_context));
+	offset += ALIGN8(sizeof(struct smb2_encryption_neg_context));
 
-	pneg_ctxt = (*total_len) + (char *)req;
-	req->NegotiateContextOffset = cpu_to_le32(*total_len);
+	/*
+	 * secondary channels don't have the hostname field populated
+	 * use the hostname field in the primary channel instead
+	 */
+	pserver = SERVER_IS_CHAN(server) ? server->primary_server : server;
+	offset += smb2_size_netname_ctxt(pserver);
+
+	offset += ALIGN8(sizeof(struct smb2_posix_neg_context));
+	if (server->compression.requested)
+		offset += ALIGN8(sizeof(struct smb2_compression_capabilities_context));
+	if (enable_negotiate_signing)
+		offset += smb2_size_signing_ctxt();
+	return offset;
+}
 
-	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt);
-	ctxt_len = ALIGN8(sizeof(struct smb2_preauth_neg_context));
-	*total_len += ctxt_len;
-	pneg_ctxt += ctxt_len;
+static void
+assemble_neg_contexts(struct smb_message *smb, struct TCP_Server_Info *server)
+{
+	struct smb2_negotiate_req *req;
+	struct TCP_Server_Info *pserver;
+	const char *hostname;
+	unsigned int neg_context_count = 2;
 
-	build_encrypt_ctxt((struct smb2_encryption_neg_context *)pneg_ctxt);
-	ctxt_len = ALIGN8(sizeof(struct smb2_encryption_neg_context));
-	*total_len += ctxt_len;
-	pneg_ctxt += ctxt_len;
+	build_preauth_ctxt(smb);
+	build_encrypt_ctxt(smb);
 
 	/*
 	 * secondary channels don't have the hostname field populated
@@ -934,47 +990,36 @@ assemble_neg_contexts(struct smb2_negotiate_req *req,
 	pserver = SERVER_IS_CHAN(server) ? server->primary_server : server;
 	cifs_server_lock(pserver);
 	hostname = pserver->hostname;
-	if (hostname && (hostname[0] != 0)) {
-		ctxt_len = build_netname_ctxt((struct smb2_netname_neg_context *)pneg_ctxt,
-					      hostname);
-		*total_len += ctxt_len;
-		pneg_ctxt += ctxt_len;
-		neg_context_count = 3;
-	} else
-		neg_context_count = 2;
+	if (hostname && hostname[0]) {
+		build_netname_ctxt(smb, hostname);
+		neg_context_count++;
+	}
 	cifs_server_unlock(pserver);
 
-	build_posix_ctxt((struct smb2_posix_neg_context *)pneg_ctxt);
-	*total_len += sizeof(struct smb2_posix_neg_context);
-	pneg_ctxt += sizeof(struct smb2_posix_neg_context);
+	build_posix_ctxt(smb);
 	neg_context_count++;
 
 	if (server->compression.requested) {
-		build_compression_ctxt((struct smb2_compression_capabilities_context *)
-				pneg_ctxt);
-		ctxt_len = ALIGN8(sizeof(struct smb2_compression_capabilities_context));
-		*total_len += ctxt_len;
-		pneg_ctxt += ctxt_len;
+		build_compression_ctxt(smb);
 		neg_context_count++;
 	}
 
 	if (enable_negotiate_signing) {
-		ctxt_len = build_signing_ctxt((struct smb2_signing_capabilities *)
-				pneg_ctxt);
-		*total_len += ctxt_len;
-		pneg_ctxt += ctxt_len;
+		build_signing_ctxt(smb);
 		neg_context_count++;
 	}
 
 	/* check for and add transport_capabilities and signing capabilities */
+	req = smb->request;
 	req->NegotiateContextCount = cpu_to_le16(neg_context_count);
-
 }
 
 /* If invalid preauth context warn but use what we requested, SHA-512 */
-static void decode_preauth_context(struct smb2_preauth_neg_context *ctxt)
+static void decode_preauth_context(struct smb2_neg_context *neg)
 {
-	unsigned int len = le16_to_cpu(ctxt->DataLength);
+	struct smb2_preauth_neg_context *ctxt =
+		container_of(neg, struct smb2_preauth_neg_context, neg);
+	unsigned int len = le16_to_cpu(ctxt->neg.DataLength);
 
 	/*
 	 * Caller checked that DataLength remains within SMB boundary. We still
@@ -994,9 +1039,11 @@ static void decode_preauth_context(struct smb2_preauth_neg_context *ctxt)
 }
 
 static void decode_compress_ctx(struct TCP_Server_Info *server,
-			 struct smb2_compression_capabilities_context *ctxt)
+				struct smb2_neg_context *neg)
 {
-	unsigned int len = le16_to_cpu(ctxt->DataLength);
+	struct smb2_compression_capabilities_context *ctxt =
+		container_of(neg, struct smb2_compression_capabilities_context, neg);
+	unsigned int len = le16_to_cpu(ctxt->neg.DataLength);
 	__le16 alg;
 
 	server->compression.enabled = false;
@@ -1029,9 +1076,11 @@ static void decode_compress_ctx(struct TCP_Server_Info *server,
 }
 
 static int decode_encrypt_ctx(struct TCP_Server_Info *server,
-			      struct smb2_encryption_neg_context *ctxt)
+			      struct smb2_neg_context *neg)
 {
-	unsigned int len = le16_to_cpu(ctxt->DataLength);
+	struct smb2_encryption_neg_context *ctxt =
+		container_of(neg, struct smb2_encryption_neg_context, neg);
+	unsigned int len = le16_to_cpu(ctxt->neg.DataLength);
 
 	cifs_dbg(FYI, "decode SMB3.11 encryption neg context of len %d\n", len);
 	/*
@@ -1081,9 +1130,11 @@ static int decode_encrypt_ctx(struct TCP_Server_Info *server,
 }
 
 static void decode_signing_ctx(struct TCP_Server_Info *server,
-			       struct smb2_signing_capabilities *pctxt)
+			       struct smb2_neg_context *neg)
 {
-	unsigned int len = le16_to_cpu(pctxt->DataLength);
+	struct smb2_signing_capabilities *pctxt =
+		container_of(neg, struct smb2_signing_capabilities, neg);
+	unsigned int len = le16_to_cpu(pctxt->neg.DataLength);
 
 	/*
 	 * Caller checked that DataLength remains within SMB boundary. We still
@@ -1110,11 +1161,12 @@ static void decode_signing_ctx(struct TCP_Server_Info *server,
 }
 
 
-static int smb311_decode_neg_context(struct smb2_negotiate_rsp *rsp,
-				     struct TCP_Server_Info *server,
-				     unsigned int len_of_smb)
+static int smb311_decode_neg_context(struct smb_message *smb,
+				     struct TCP_Server_Info *server)
 {
+	struct smb2_negotiate_rsp *rsp = smb->response;
 	struct smb2_neg_context *pctx;
+	unsigned int len_of_smb = smb->response_len;
 	unsigned int offset = le32_to_cpu(rsp->NegotiateContextOffset);
 	unsigned int ctxt_cnt = le16_to_cpu(rsp->NegotiateContextCount);
 	unsigned int len_of_ctxts, i;
@@ -1147,23 +1199,26 @@ static int smb311_decode_neg_context(struct smb2_negotiate_rsp *rsp,
 		if (clen > len_of_ctxts)
 			break;
 
-		if (pctx->ContextType == SMB2_PREAUTH_INTEGRITY_CAPABILITIES)
-			decode_preauth_context(
-				(struct smb2_preauth_neg_context *)pctx);
-		else if (pctx->ContextType == SMB2_ENCRYPTION_CAPABILITIES)
-			rc = decode_encrypt_ctx(server,
-				(struct smb2_encryption_neg_context *)pctx);
-		else if (pctx->ContextType == SMB2_COMPRESSION_CAPABILITIES)
-			decode_compress_ctx(server,
-				(struct smb2_compression_capabilities_context *)pctx);
-		else if (pctx->ContextType == SMB2_POSIX_EXTENSIONS_AVAILABLE)
+		switch (pctx->ContextType) {
+		case SMB2_PREAUTH_INTEGRITY_CAPABILITIES:
+			decode_preauth_context(pctx);
+			break;
+		case SMB2_ENCRYPTION_CAPABILITIES:
+			rc = decode_encrypt_ctx(server, pctx);
+			break;
+		case SMB2_COMPRESSION_CAPABILITIES:
+			decode_compress_ctx(server, pctx);
+			break;
+		case SMB2_POSIX_EXTENSIONS_AVAILABLE:
 			server->posix_ext_supported = true;
-		else if (pctx->ContextType == SMB2_SIGNING_CAPABILITIES)
-			decode_signing_ctx(server,
-				(struct smb2_signing_capabilities *)pctx);
-		else
+			break;
+		case SMB2_SIGNING_CAPABILITIES:
+			decode_signing_ctx(server, pctx);
+			break;
+		default:
 			cifs_server_dbg(VFS, "unknown negcontext of type %d ignored\n",
 				le16_to_cpu(pctx->ContextType));
+		}
 		if (rc)
 			break;
 
@@ -1248,17 +1303,16 @@ SMB2_negotiate(const unsigned int xid,
 	       struct cifs_ses *ses,
 	       struct TCP_Server_Info *server)
 {
-	struct smb_rqst rqst;
 	struct smb2_negotiate_req *req;
 	struct smb2_negotiate_rsp *rsp;
-	struct kvec iov[1];
-	struct kvec rsp_iov;
+	struct smb_message *smb;
+	const char *vs;
+	size_t offset, num_dialects;
 	int rc;
-	int resp_buftype;
 	int blob_offset, blob_length;
 	char *security_blob;
 	int flags = CIFS_NEG_OP;
-	unsigned int total_len;
+	enum { DEF, ANY3, SPEC } version;
 
 	cifs_dbg(FYI, "Negotiate protocol\n");
 
@@ -1267,36 +1321,67 @@ SMB2_negotiate(const unsigned int xid,
 		return -EIO;
 	}
 
-	rc = smb2_plain_req_init(SMB2_NEGOTIATE, NULL, server,
-				 (void **) &req, &total_len);
+	rc = smb2_reconnect(SMB2_SESSION_SETUP, NULL, server, false);
 	if (rc)
 		return rc;
 
+	/* Calculate how much space we need for a Negotiate Request message.
+	 * We can't do this exactly as the hostname might change, but we don't
+	 * want to hold the lock across the allocation.
+	 */
+	vs = server->vals->version_string;
+	if (strcmp(vs, SMB3ANY_VERSION_STRING) == 0) {
+		version = ANY3;
+		num_dialects = 3;
+	} else if (strcmp(vs, SMBDEFAULT_VERSION_STRING) == 0) {
+		version = DEF;
+		num_dialects = 4;
+	} else {
+		version = SPEC;
+		num_dialects = 1;
+	}
+
+	offset = sizeof(struct smb2_negotiate_req);
+	offset += sizeof(req->Dialects[0]) * num_dialects;
+
+	if ((server->vals->protocol_id == SMB311_PROT_ID) ||
+	    (version == ANY3) ||
+	    (version == DEF))
+		offset = smb2_size_neg_contexts(server, offset);
+
+	smb = smb2_create_request(SMB2_NEGOTIATE, server, NULL,
+				  sizeof(*req), offset, 0,
+				  SMB2_REQ_HEAD);
+	if (!smb)
+		return -ENOMEM;
+
+	/* Fill in the message. */
+	req = smb->request;
 	req->hdr.SessionId = 0;
+	req->NegotiateContextOffset = cpu_to_be32(smb->ext_offset);
 
 	memset(server->preauth_sha_hash, 0, SMB2_PREAUTH_HASH_SIZE);
 	memset(ses->preauth_sha_hash, 0, SMB2_PREAUTH_HASH_SIZE);
 
-	if (strcmp(server->vals->version_string,
-		   SMB3ANY_VERSION_STRING) == 0) {
+	switch (version) {
+	case ANY3:
 		req->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
 		req->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
 		req->Dialects[2] = cpu_to_le16(SMB311_PROT_ID);
 		req->DialectCount = cpu_to_le16(3);
-		total_len += 6;
-	} else if (strcmp(server->vals->version_string,
-		   SMBDEFAULT_VERSION_STRING) == 0) {
+		break;
+	case DEF:
 		req->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
 		req->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
 		req->Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
 		req->Dialects[3] = cpu_to_le16(SMB311_PROT_ID);
 		req->DialectCount = cpu_to_le16(4);
-		total_len += 8;
-	} else {
+		break;
+	case SPEC:
 		/* otherwise send specific dialect */
 		req->Dialects[0] = cpu_to_le16(server->vals->protocol_id);
 		req->DialectCount = cpu_to_le16(1);
-		total_len += 2;
+		break;
 	}
 
 	/* only one of SMB2 signing flags may be set in SMB2 request */
@@ -1312,97 +1397,108 @@ SMB2_negotiate(const unsigned int xid,
 		req->Capabilities |= cpu_to_le32(SMB2_GLOBAL_CAP_MULTI_CHANNEL);
 
 	/* ClientGUID must be zero for SMB2.02 dialect */
-	if (server->vals->protocol_id == SMB20_PROT_ID)
+	if (server->vals->protocol_id == SMB20_PROT_ID) {
 		memset(req->ClientGUID, 0, SMB2_CLIENT_GUID_SIZE);
-	else {
+	} else {
 		memcpy(req->ClientGUID, server->client_guid,
 			SMB2_CLIENT_GUID_SIZE);
 		if ((server->vals->protocol_id == SMB311_PROT_ID) ||
-		    (strcmp(server->vals->version_string,
-		     SMB3ANY_VERSION_STRING) == 0) ||
-		    (strcmp(server->vals->version_string,
-		     SMBDEFAULT_VERSION_STRING) == 0))
-			assemble_neg_contexts(req, server, &total_len);
+		    (version == ANY3) ||
+		    (version == DEF))
+			assemble_neg_contexts(smb, server);
 	}
-	iov[0].iov_base = (char *)req;
-	iov[0].iov_len = total_len;
 
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = 1;
+	rc = smb_send_recv_messages(xid, ses, server, smb, flags);
+	smb_clear_request(smb);
 
-	rc = cifs_send_recv(xid, ses, server,
-			    &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(req);
-	rsp = (struct smb2_negotiate_rsp *)rsp_iov.iov_base;
 	/*
 	 * No tcon so can't do
 	 * cifs_stats_inc(&tcon->stats.smb2_stats.smb2_com_fail[SMB2...]);
 	 */
-	if (rc == -EOPNOTSUPP) {
-		cifs_server_dbg(VFS, "Dialect not supported by server. Consider  specifying vers=1.0 or vers=2.0 on mount for accessing older servers\n");
-		goto neg_exit;
-	} else if (rc != 0)
+	if (rc != 0) {
+		if (rc == -EOPNOTSUPP)
+			cifs_server_dbg(VFS, "Dialect not supported by server. Consider  specifying vers=1.0 or vers=2.0 on mount for accessing older servers\n");
 		goto neg_exit;
+	}
 
+	/* ________________________________________
+	 * Decode the response.
+	 */
+	rsp = (struct smb2_negotiate_rsp *)smb->response;
+
+	int dialect_revision = le16_to_cpu(rsp->DialectRevision);
 	rc = -EIO;
-	if (strcmp(server->vals->version_string,
-		   SMB3ANY_VERSION_STRING) == 0) {
-		if (rsp->DialectRevision == cpu_to_le16(SMB20_PROT_ID)) {
+	switch (version) {
+	case ANY3:
+		switch (dialect_revision) {
+		case SMB20_PROT_ID:
 			cifs_server_dbg(VFS,
 				"SMB2 dialect returned but not requested\n");
 			goto neg_exit;
-		} else if (rsp->DialectRevision == cpu_to_le16(SMB21_PROT_ID)) {
+		case SMB21_PROT_ID:
 			cifs_server_dbg(VFS,
 				"SMB2.1 dialect returned but not requested\n");
 			goto neg_exit;
-		} else if (rsp->DialectRevision == cpu_to_le16(SMB311_PROT_ID)) {
+		case SMB311_PROT_ID:
 			/* ops set to 3.0 by default for default so update */
 			server->ops = &smb311_operations;
 			server->vals = &smb311_values;
+			break;
 		}
-	} else if (strcmp(server->vals->version_string,
-		   SMBDEFAULT_VERSION_STRING) == 0) {
-		if (rsp->DialectRevision == cpu_to_le16(SMB20_PROT_ID)) {
+		break;
+	case DEF:
+		switch (dialect_revision) {
+		case SMB20_PROT_ID:
 			cifs_server_dbg(VFS,
 				"SMB2 dialect returned but not requested\n");
 			goto neg_exit;
-		} else if (rsp->DialectRevision == cpu_to_le16(SMB21_PROT_ID)) {
+		case SMB21_PROT_ID:
 			/* ops set to 3.0 by default for default so update */
 			server->ops = &smb21_operations;
 			server->vals = &smb21_values;
-		} else if (rsp->DialectRevision == cpu_to_le16(SMB311_PROT_ID)) {
+			break;
+		case SMB311_PROT_ID:
 			server->ops = &smb311_operations;
 			server->vals = &smb311_values;
+			break;
 		}
-	} else if (le16_to_cpu(rsp->DialectRevision) !=
-				server->vals->protocol_id) {
-		/* if requested single dialect ensure returned dialect matched */
-		cifs_server_dbg(VFS, "Invalid 0x%x dialect returned: not requested\n",
-				le16_to_cpu(rsp->DialectRevision));
-		goto neg_exit;
+		break;
+	default:
+		if (dialect_revision != server->vals->protocol_id) {
+			/* if requested single dialect ensure returned dialect matched */
+			cifs_server_dbg(VFS, "Invalid 0x%x dialect returned: not requested\n",
+					dialect_revision);
+			goto neg_exit;
+		}
+		break;
 	}
 
 	cifs_dbg(FYI, "mode 0x%x\n", rsp->SecurityMode);
 
-	if (rsp->DialectRevision == cpu_to_le16(SMB20_PROT_ID))
+	switch (dialect_revision) {
+	case SMB20_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb2.0 dialect\n");
-	else if (rsp->DialectRevision == cpu_to_le16(SMB21_PROT_ID))
+		break;
+	case SMB21_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb2.1 dialect\n");
-	else if (rsp->DialectRevision == cpu_to_le16(SMB30_PROT_ID))
+		break;
+	case SMB30_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb3.0 dialect\n");
-	else if (rsp->DialectRevision == cpu_to_le16(SMB302_PROT_ID))
+		break;
+	case SMB302_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb3.02 dialect\n");
-	else if (rsp->DialectRevision == cpu_to_le16(SMB311_PROT_ID))
+		break;
+	case SMB311_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb3.1.1 dialect\n");
-	else {
+		break;
+	default:
 		cifs_server_dbg(VFS, "Invalid dialect returned by server 0x%x\n",
-				le16_to_cpu(rsp->DialectRevision));
+				dialect_revision);
 		goto neg_exit;
 	}
 
 	rc = 0;
-	server->dialect = le16_to_cpu(rsp->DialectRevision);
+	server->dialect = dialect_revision;
 
 	/*
 	 * Keep a copy of the hash after negprot. This hash will be
@@ -1461,10 +1557,9 @@ SMB2_negotiate(const unsigned int xid,
 			rc = -EIO;
 	}
 
-	if (rsp->DialectRevision == cpu_to_le16(SMB311_PROT_ID)) {
+	if (server->dialect == SMB311_PROT_ID) {
 		if (rsp->NegotiateContextCount)
-			rc = smb311_decode_neg_context(rsp, server,
-						       rsp_iov.iov_len);
+			rc = smb311_decode_neg_context(smb, server);
 		else
 			cifs_server_dbg(VFS, "Missing expected negotiate contexts\n");
 	}
@@ -1472,7 +1567,7 @@ SMB2_negotiate(const unsigned int xid,
 	if (server->cipher_type && !rc)
 		rc = smb3_crypto_aead_allocate(server);
 neg_exit:
-	free_rsp_buf(resp_buftype, rsp);
+	smb_put_messages(smb);
 	return rc;
 }
 
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 7da40d229ab5..e3b888140b59 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -455,9 +455,7 @@ struct smb2_neg_context {
 #define MIN_PREAUTH_CTXT_DATA_LEN 6
 
 struct smb2_preauth_neg_context {
-	__le16	ContextType; /* 1 */
-	__le16	DataLength;
-	__le32	Reserved;
+	struct smb2_neg_context neg;
 	__le16	HashAlgorithmCount; /* 1 */
 	__le16	SaltLength;
 	__le16	HashAlgorithms; /* HashAlgorithms[0] since only one defined */
@@ -473,9 +471,7 @@ struct smb2_preauth_neg_context {
 /* Min encrypt context data is one cipher so 2 bytes + 2 byte count field */
 #define MIN_ENCRYPT_CTXT_DATA_LEN	4
 struct smb2_encryption_neg_context {
-	__le16	ContextType; /* 2 */
-	__le16	DataLength;
-	__le32	Reserved;
+	struct smb2_neg_context neg;
 	/* CipherCount usually 2, but can be 3 when AES256-GCM enabled */
 	__le16	CipherCount; /* AES128-GCM and AES128-CCM by default */
 	__le16	Ciphers[];
@@ -495,9 +491,7 @@ struct smb2_encryption_neg_context {
 #define SMB2_COMPRESSION_CAPABILITIES_FLAG_CHAINED	cpu_to_le32(0x00000001)
 
 struct smb2_compression_capabilities_context {
-	__le16	ContextType; /* 3 */
-	__le16  DataLength;
-	__le32	Reserved;
+	struct smb2_neg_context neg;
 	__le16	CompressionAlgorithmCount;
 	__le16	Padding;
 	__le32	Flags;
@@ -511,9 +505,7 @@ struct smb2_compression_capabilities_context {
  * Its struct simply contains NetName, an array of Unicode characters
  */
 struct smb2_netname_neg_context {
-	__le16	ContextType; /* 5 */
-	__le16	DataLength;
-	__le32	Reserved;
+	struct smb2_neg_context neg;
 	__le16	NetName[]; /* hostname of target converted to UCS-2 */
 } __packed;
 
@@ -567,9 +559,7 @@ struct smb2_rdma_transform_capabilities_context {
 #define SIGNING_ALG_AES_GMAC_LE    cpu_to_le16(2)
 
 struct smb2_signing_capabilities {
-	__le16	ContextType; /* 8 */
-	__le16	DataLength;
-	__le32	Reserved;
+	struct smb2_neg_context neg;
 	__le16	SigningAlgorithmCount;
 	__le16	SigningAlgorithms[];
 	/*  Followed by padding to 8 byte boundary (required by some servers) */
@@ -577,9 +567,7 @@ struct smb2_signing_capabilities {
 
 #define POSIX_CTXT_DATA_LEN	16
 struct smb2_posix_neg_context {
-	__le16	ContextType; /* 0x100 */
-	__le16	DataLength;
-	__le32	Reserved;
+	struct smb2_neg_context neg;
 	__u8	Name[16]; /* POSIX ctxt GUID 93AD25509CB411E7B42383DE968BCD7C */
 } __packed;
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 1ed2bcba649f..af5187d1101e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -774,10 +774,10 @@ static int smb2_get_dos_mode(struct kstat *stat, int attribute)
 static void build_preauth_ctxt(struct smb2_preauth_neg_context *pneg_ctxt,
 			       __le16 hash_id)
 {
-	pneg_ctxt->ContextType = SMB2_PREAUTH_INTEGRITY_CAPABILITIES;
-	pneg_ctxt->DataLength = cpu_to_le16(38);
+	pneg_ctxt->neg.ContextType = SMB2_PREAUTH_INTEGRITY_CAPABILITIES;
+	pneg_ctxt->neg.DataLength = cpu_to_le16(38);
+	pneg_ctxt->neg.Reserved = cpu_to_le32(0);
 	pneg_ctxt->HashAlgorithmCount = cpu_to_le16(1);
-	pneg_ctxt->Reserved = cpu_to_le32(0);
 	pneg_ctxt->SaltLength = cpu_to_le16(SMB311_SALT_SIZE);
 	get_random_bytes(pneg_ctxt->Salt, SMB311_SALT_SIZE);
 	pneg_ctxt->HashAlgorithms = hash_id;
@@ -786,9 +786,9 @@ static void build_preauth_ctxt(struct smb2_preauth_neg_context *pneg_ctxt,
 static void build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt,
 			       __le16 cipher_type)
 {
-	pneg_ctxt->ContextType = SMB2_ENCRYPTION_CAPABILITIES;
-	pneg_ctxt->DataLength = cpu_to_le16(4);
-	pneg_ctxt->Reserved = cpu_to_le32(0);
+	pneg_ctxt->neg.ContextType = SMB2_ENCRYPTION_CAPABILITIES;
+	pneg_ctxt->neg.DataLength = cpu_to_le16(4);
+	pneg_ctxt->neg.Reserved = cpu_to_le32(0);
 	pneg_ctxt->CipherCount = cpu_to_le16(1);
 	pneg_ctxt->Ciphers[0] = cipher_type;
 }
@@ -796,19 +796,19 @@ static void build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt,
 static void build_sign_cap_ctxt(struct smb2_signing_capabilities *pneg_ctxt,
 				__le16 sign_algo)
 {
-	pneg_ctxt->ContextType = SMB2_SIGNING_CAPABILITIES;
-	pneg_ctxt->DataLength =
+	pneg_ctxt->neg.ContextType = SMB2_SIGNING_CAPABILITIES;
+	pneg_ctxt->neg.DataLength =
 		cpu_to_le16((sizeof(struct smb2_signing_capabilities) + 2)
 			- sizeof(struct smb2_neg_context));
-	pneg_ctxt->Reserved = cpu_to_le32(0);
+	pneg_ctxt->neg.Reserved = cpu_to_le32(0);
 	pneg_ctxt->SigningAlgorithmCount = cpu_to_le16(1);
 	pneg_ctxt->SigningAlgorithms[0] = sign_algo;
 }
 
 static void build_posix_ctxt(struct smb2_posix_neg_context *pneg_ctxt)
 {
-	pneg_ctxt->ContextType = SMB2_POSIX_EXTENSIONS_AVAILABLE;
-	pneg_ctxt->DataLength = cpu_to_le16(POSIX_CTXT_DATA_LEN);
+	pneg_ctxt->neg.ContextType = SMB2_POSIX_EXTENSIONS_AVAILABLE;
+	pneg_ctxt->neg.DataLength = cpu_to_le16(POSIX_CTXT_DATA_LEN);
 	/* SMB2_CREATE_TAG_POSIX is "0x93AD25509CB411E7B42383DE968BCD7C" */
 	pneg_ctxt->Name[0] = 0x93;
 	pneg_ctxt->Name[1] = 0xAD;


