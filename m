Return-Path: <linux-fsdevel+bounces-56885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A8B1CD8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4078E18C5D8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174D2BDC24;
	Wed,  6 Aug 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0cj8XZZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F1F1FF7B4
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512669; cv=none; b=E5pQ2t/024ecFNH1uKd5DQbvQhisii3rcPUPb4r1rHQJjDK6d1pRxZmXBY+3sUMYXL/dU+pw5mPAeqJQjHllczfCc/d2CftdjO5c0uAO9UpRl2Xmbl7K7/TmvmV1fvCyoxcp3UzzLDKliv/r9g9jCI0q6zGMymtCyokrZzZQTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512669; c=relaxed/simple;
	bh=ppNcHhXRisKv01c9cZ1qnAtYlgHVNCWEVHkzlLJLWGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDR5il2wdY170LM90ZKDSOGY10Zum3mdpN61hkDFuxDWSo0+aVvxgp+t+4th8TvwEH/Io/3HMYoTrIINprRf64JB6Bws6ODbjRhcYaxtPHINOm8GZypGAn872GKEkwDcKJGJTnEJ90rAGWaWfVqhkYjA4CSzD/IhOYuDPbKIGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0cj8XZZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emfO1GPlFwZIV8t+Z04vg+2LWJzChrqCHQ/rDncitC0=;
	b=V0cj8XZZrzo2pHTOMPDhVlTwCsE3wCaORYnzTdSuQBv3naIhw76vamurYbtsPJC1l89n/u
	ojySXSkiYSnzbCcMuZm7vtOw62JRXod5LMC0Rn5NGzA7WXBLgkbs5gpb03bkENgOCupQdd
	jfxYY+Cot3S5rIuslzwIWuy+hWGI1mw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-szfcuH63M1iJfTs8avUUlQ-1; Wed,
 06 Aug 2025 16:37:43 -0400
X-MC-Unique: szfcuH63M1iJfTs8avUUlQ-1
X-Mimecast-MFC-AGG-ID: szfcuH63M1iJfTs8avUUlQ_1754512659
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8FBC1956095;
	Wed,  6 Aug 2025 20:37:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B7211800446;
	Wed,  6 Aug 2025 20:37:35 +0000 (UTC)
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
Subject: [RFC PATCH 05/31] cifs: Introduce an ALIGN8() macro
Date: Wed,  6 Aug 2025 21:36:26 +0100
Message-ID: <20250806203705.2560493-6-dhowells@redhat.com>
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

The PDU generation seems to do ALIGN(x, 8) a lot, so make a macro for that.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h |  2 ++
 fs/smb/client/reparse.c  |  2 +-
 fs/smb/client/smb2file.c |  2 +-
 fs/smb/client/smb2misc.c |  2 +-
 fs/smb/client/smb2pdu.c  | 28 ++++++++++++++--------------
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 89160bc34d35..67c1a63a08ba 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2375,4 +2375,6 @@ static inline bool cifs_netbios_name(const char *name, size_t namelen)
 	return ret;
 }
 
+#define ALIGN8(x) ALIGN((x), 8)
+
 #endif	/* _CIFS_GLOB_H */
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 5fa29a97ac15..2622f90ebc92 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -571,7 +571,7 @@ static struct smb2_create_ea_ctx *ea_create_context(u32 dlen, size_t *cc_len)
 {
 	struct smb2_create_ea_ctx *cc;
 
-	*cc_len = round_up(sizeof(*cc) + dlen, 8);
+	*cc_len = ALIGN8(sizeof(*cc) + dlen);
 	cc = kzalloc(*cc_len, GFP_KERNEL);
 	if (!cc)
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index a7f629238830..1c8fc06cd46f 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -48,7 +48,7 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 			cifs_dbg(FYI, "%s: skipping unhandled error context: 0x%x\n",
 				 __func__, le32_to_cpu(p->ErrorId));
 
-			len = ALIGN(le32_to_cpu(p->ErrorDataLength), 8);
+			len = ALIGN8(le32_to_cpu(p->ErrorDataLength));
 			p = (struct smb2_error_context_rsp *)(p->ErrorContextData + len);
 		} while (p < end);
 	} else if (le32_to_cpu(err->ByteCount) >= sizeof(*sym) &&
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index cddf273c14ae..93ce9fc7b4a4 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -252,7 +252,7 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 		 * Some windows servers (win2016) will pad also the final
 		 * PDU in a compound to 8 bytes.
 		 */
-		if (ALIGN(calc_len, 8) == len)
+		if (ALIGN8(calc_len) == len)
 			return 0;
 
 		/*
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 2df93a75e3b8..96df4aa7a7af 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -619,14 +619,14 @@ build_signing_ctxt(struct smb2_signing_capabilities *pneg_ctxt)
 	/*
 	 * Context Data length must be rounded to multiple of 8 for some servers
 	 */
-	pneg_ctxt->DataLength = cpu_to_le16(ALIGN(sizeof(struct smb2_signing_capabilities) -
+	pneg_ctxt->DataLength = cpu_to_le16(ALIGN8(sizeof(struct smb2_signing_capabilities) -
 					    sizeof(struct smb2_neg_context) +
-					    (num_algs * sizeof(u16)), 8));
+					    (num_algs * sizeof(u16))));
 	pneg_ctxt->SigningAlgorithmCount = cpu_to_le16(num_algs);
 	pneg_ctxt->SigningAlgorithms[0] = cpu_to_le16(SIGNING_ALG_AES_CMAC);
 
 	ctxt_len += sizeof(__le16) * num_algs;
-	ctxt_len = ALIGN(ctxt_len, 8);
+	ctxt_len = ALIGN8(ctxt_len);
 	return ctxt_len;
 	/* TBD add SIGNING_ALG_AES_GMAC and/or SIGNING_ALG_HMAC_SHA256 */
 }
@@ -663,7 +663,7 @@ build_netname_ctxt(struct smb2_netname_neg_context *pneg_ctxt, char *hostname)
 	/* copy up to max of first 100 bytes of server name to NetName field */
 	pneg_ctxt->DataLength = cpu_to_le16(2 * cifs_strtoUTF16(pneg_ctxt->NetName, hostname, 100, cp));
 	/* context size is DataLength + minimal smb2_neg_context */
-	return ALIGN(le16_to_cpu(pneg_ctxt->DataLength) + sizeof(struct smb2_neg_context), 8);
+	return ALIGN8(le16_to_cpu(pneg_ctxt->DataLength) + sizeof(struct smb2_neg_context));
 }
 
 static void
@@ -709,18 +709,18 @@ assemble_neg_contexts(struct smb2_negotiate_req *req,
 	 * round up total_len of fixed part of SMB3 negotiate request to 8
 	 * byte boundary before adding negotiate contexts
 	 */
-	*total_len = ALIGN(*total_len, 8);
+	*total_len = ALIGN8(*total_len);
 
 	pneg_ctxt = (*total_len) + (char *)req;
 	req->NegotiateContextOffset = cpu_to_le32(*total_len);
 
 	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt);
-	ctxt_len = ALIGN(sizeof(struct smb2_preauth_neg_context), 8);
+	ctxt_len = ALIGN8(sizeof(struct smb2_preauth_neg_context));
 	*total_len += ctxt_len;
 	pneg_ctxt += ctxt_len;
 
 	build_encrypt_ctxt((struct smb2_encryption_neg_context *)pneg_ctxt);
-	ctxt_len = ALIGN(sizeof(struct smb2_encryption_neg_context), 8);
+	ctxt_len = ALIGN8(sizeof(struct smb2_encryption_neg_context));
 	*total_len += ctxt_len;
 	pneg_ctxt += ctxt_len;
 
@@ -749,7 +749,7 @@ assemble_neg_contexts(struct smb2_negotiate_req *req,
 	if (server->compression.requested) {
 		build_compression_ctxt((struct smb2_compression_capabilities_context *)
 				pneg_ctxt);
-		ctxt_len = ALIGN(sizeof(struct smb2_compression_capabilities_context), 8);
+		ctxt_len = ALIGN8(sizeof(struct smb2_compression_capabilities_context));
 		*total_len += ctxt_len;
 		pneg_ctxt += ctxt_len;
 		neg_context_count++;
@@ -940,7 +940,7 @@ static int smb311_decode_neg_context(struct smb2_negotiate_rsp *rsp,
 		 * aligned offset following the previous negotiate context.
 		 */
 		if (i + 1 != ctxt_cnt)
-			clen = ALIGN(clen, 8);
+			clen = ALIGN8(clen);
 		if (clen > len_of_ctxts)
 			break;
 
@@ -2631,7 +2631,7 @@ create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
 	unsigned int group_offset = 0;
 	struct smb3_acl acl = {};
 
-	*len = round_up(sizeof(struct crt_sd_ctxt) + (sizeof(struct smb_ace) * 4), 8);
+	*len = ALIGN8(sizeof(struct crt_sd_ctxt) + (sizeof(struct smb_ace) * 4));
 
 	if (set_owner) {
 		/* sizeof(struct owner_group_sids) is already multiple of 8 so no need to round */
@@ -2706,7 +2706,7 @@ create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
 	memcpy(aclptr, &acl, sizeof(struct smb3_acl));
 
 	buf->ccontext.DataLength = cpu_to_le32(ptr - (__u8 *)&buf->sd);
-	*len = round_up((unsigned int)(ptr - (__u8 *)buf), 8);
+	*len = ALIGN8((unsigned int)(ptr - (__u8 *)buf));
 
 	return buf;
 }
@@ -2799,7 +2799,7 @@ alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
 	 * final path needs to be 8-byte aligned as specified in
 	 * MS-SMB2 2.2.13 SMB2 CREATE Request.
 	 */
-	*out_size = round_up(*out_len * sizeof(__le16), 8);
+	*out_size = ALIGN8(*out_len * sizeof(__le16));
 	*out_path = kzalloc(*out_size + sizeof(__le16) /* null */, GFP_KERNEL);
 	if (!*out_path)
 		return -ENOMEM;
@@ -3064,7 +3064,7 @@ SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 		uni_path_len = (2 * UniStrnlen((wchar_t *)path, PATH_MAX)) + 2;
 		/* MUST set path len (NameLength) to 0 opening root of share */
 		req->NameLength = cpu_to_le16(uni_path_len - 2);
-		copy_size = round_up(uni_path_len, 8);
+		copy_size = ALIGN8(uni_path_len);
 		copy_path = kzalloc(copy_size, GFP_KERNEL);
 		if (!copy_path)
 			return -ENOMEM;
@@ -4490,7 +4490,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	if (request_type & CHAINED_REQUEST) {
 		if (!(request_type & END_OF_CHAIN)) {
 			/* next 8-byte aligned request */
-			*total_len = ALIGN(*total_len, 8);
+			*total_len = ALIGN8(*total_len);
 			shdr->NextCommand = cpu_to_le32(*total_len);
 		} else /* END_OF_CHAIN */
 			shdr->NextCommand = 0;


