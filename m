Return-Path: <linux-fsdevel+bounces-71880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AECD768B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBF05302A5D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9724034F490;
	Mon, 22 Dec 2025 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qz3t0LGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5EA34F279
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442726; cv=none; b=aOjkd+l+L/ofCKWlcaYgu9QmQX98XkKtN4Ht6GAlgu7w7Q6Ri6M/5Do3MQsCEHNq4d9iPJ3r/MPVyXdRO8wLRr9rH4TJn1ZieRcM5DSSB1GhxjPEReBYl+wNkci7kX4DRf+yAb+YHXMNRYmx7RAf7AfbccQXwxtvRRDPQMtUc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442726; c=relaxed/simple;
	bh=IQILNr/IqOopXPtCvHwy3QXvt6bvhXQ1dbU8ChlecDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoB7bzx041a51tIlr6fiCo1JXentVtBnmhSu+nbqzdrJe2UzbqI3Ct5HfTEEDMXkQAtYOKngreBAESX0DE/n/6sZursml8In0iEwlPQ5oMV3OjcjRf6NECvJjsD6cc55ibcmU/9SdK2bo03dwm0bizcvre9uReoe4mrDBBO8mHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qz3t0LGj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScJ5G6/N4mrJeSZCqPZj0Er5Qn0WXl0xnMbZHNl/UDY=;
	b=Qz3t0LGjXzDsehQqpX3F+YmnHOalPYiQRcdtzXfvsHUIbMqsoxDE7uGilXFGu80wv9o2Nt
	HbHQYX47aNP3JrvkC/+HB/UDUFy45PetosLg1/1q5V+E7l7B2a92MRJUPflKPwo7yUBf0Y
	x1BGuQ09CSg94vyc1jB65sgRfuE5yMY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-9eniXotxNGa3f8_LWU5bWA-1; Mon,
 22 Dec 2025 17:31:59 -0500
X-MC-Unique: 9eniXotxNGa3f8_LWU5bWA-1
X-Mimecast-MFC-AGG-ID: 9eniXotxNGa3f8_LWU5bWA_1766442718
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E36F195605B;
	Mon, 22 Dec 2025 22:31:58 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 824221800669;
	Mon, 22 Dec 2025 22:31:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 34/37] cifs: SMB1 split: cifsencrypt.c
Date: Mon, 22 Dec 2025 22:29:59 +0000
Message-ID: <20251222223006.1075635-35-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Split SMB1-specific message signing into smb1encrypt.c.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/Makefile      |   1 +
 fs/smb/client/cifsencrypt.c | 123 -------------------------------
 fs/smb/client/cifsproto.h   |   5 --
 fs/smb/client/smb1encrypt.c | 139 ++++++++++++++++++++++++++++++++++++
 fs/smb/client/smb1proto.h   |   9 +++
 5 files changed, 149 insertions(+), 128 deletions(-)
 create mode 100644 fs/smb/client/smb1encrypt.c

diff --git a/fs/smb/client/Makefile b/fs/smb/client/Makefile
index 82ad4bccb131..a66e3b5b5912 100644
--- a/fs/smb/client/Makefile
+++ b/fs/smb/client/Makefile
@@ -35,6 +35,7 @@ cifs-$(CONFIG_CIFS_ROOT) += cifsroot.o
 cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) += \
 	cifssmb.o \
 	smb1debug.o \
+	smb1encrypt.o \
 	smb1maperror.o \
 	smb1misc.o \
 	smb1ops.o \
diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 661c7b8dc602..50b7ec39053c 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -115,129 +115,6 @@ int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	return rc;
 }
 
-/*
- * Calculate and return the CIFS signature based on the mac key and SMB PDU.
- * The 16 byte signature must be allocated by the caller. Note we only use the
- * 1st eight bytes and that the smb header signature field on input contains
- * the sequence number before this function is called. Also, this function
- * should be called with the server->srv_mutex held.
- */
-static int cifs_calc_signature(struct smb_rqst *rqst,
-			struct TCP_Server_Info *server, char *signature)
-{
-	struct md5_ctx ctx;
-
-	if (!rqst->rq_iov || !signature || !server)
-		return -EINVAL;
-	if (fips_enabled) {
-		cifs_dbg(VFS,
-			 "MD5 signature support is disabled due to FIPS\n");
-		return -EOPNOTSUPP;
-	}
-
-	md5_init(&ctx);
-	md5_update(&ctx, server->session_key.response, server->session_key.len);
-
-	return __cifs_calc_signature(
-		rqst, server, signature,
-		&(struct cifs_calc_sig_ctx){ .md5 = &ctx });
-}
-
-/* must be called with server->srv_mutex held */
-int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
-		   __u32 *pexpected_response_sequence_number)
-{
-	int rc = 0;
-	char smb_signature[20];
-	struct smb_hdr *cifs_pdu = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
-
-	if ((cifs_pdu == NULL) || (server == NULL))
-		return -EINVAL;
-
-	spin_lock(&server->srv_lock);
-	if (!(cifs_pdu->Flags2 & SMBFLG2_SECURITY_SIGNATURE) ||
-	    server->tcpStatus == CifsNeedNegotiate) {
-		spin_unlock(&server->srv_lock);
-		return rc;
-	}
-	spin_unlock(&server->srv_lock);
-
-	if (!server->session_estab) {
-		memcpy(cifs_pdu->Signature.SecuritySignature, "BSRSPYL", 8);
-		return rc;
-	}
-
-	cifs_pdu->Signature.Sequence.SequenceNumber =
-				cpu_to_le32(server->sequence_number);
-	cifs_pdu->Signature.Sequence.Reserved = 0;
-
-	*pexpected_response_sequence_number = ++server->sequence_number;
-	++server->sequence_number;
-
-	rc = cifs_calc_signature(rqst, server, smb_signature);
-	if (rc)
-		memset(cifs_pdu->Signature.SecuritySignature, 0, 8);
-	else
-		memcpy(cifs_pdu->Signature.SecuritySignature, smb_signature, 8);
-
-	return rc;
-}
-
-int cifs_verify_signature(struct smb_rqst *rqst,
-			  struct TCP_Server_Info *server,
-			  __u32 expected_sequence_number)
-{
-	unsigned int rc;
-	char server_response_sig[8];
-	char what_we_think_sig_should_be[20];
-	struct smb_hdr *cifs_pdu = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
-
-	if (cifs_pdu == NULL || server == NULL)
-		return -EINVAL;
-
-	if (!server->session_estab)
-		return 0;
-
-	if (cifs_pdu->Command == SMB_COM_LOCKING_ANDX) {
-		struct smb_com_lock_req *pSMB =
-			(struct smb_com_lock_req *)cifs_pdu;
-		if (pSMB->LockType & LOCKING_ANDX_OPLOCK_RELEASE)
-			return 0;
-	}
-
-	/* BB what if signatures are supposed to be on for session but
-	   server does not send one? BB */
-
-	/* Do not need to verify session setups with signature "BSRSPYL "  */
-	if (memcmp(cifs_pdu->Signature.SecuritySignature, "BSRSPYL ", 8) == 0)
-		cifs_dbg(FYI, "dummy signature received for smb command 0x%x\n",
-			 cifs_pdu->Command);
-
-	/* save off the original signature so we can modify the smb and check
-		its signature against what the server sent */
-	memcpy(server_response_sig, cifs_pdu->Signature.SecuritySignature, 8);
-
-	cifs_pdu->Signature.Sequence.SequenceNumber =
-					cpu_to_le32(expected_sequence_number);
-	cifs_pdu->Signature.Sequence.Reserved = 0;
-
-	cifs_server_lock(server);
-	rc = cifs_calc_signature(rqst, server, what_we_think_sig_should_be);
-	cifs_server_unlock(server);
-
-	if (rc)
-		return rc;
-
-/*	cifs_dump_mem("what we think it should be: ",
-		      what_we_think_sig_should_be, 16); */
-
-	if (memcmp(server_response_sig, what_we_think_sig_should_be, 8))
-		return -EACCES;
-	else
-		return 0;
-
-}
-
 /* Build a proper attribute value/target info pairs blob.
  * Fill in netbios and dns domain name and workstation name
  * and client time (total five av pairs and + one end of fields indicator.
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 884a66b6bd34..ba571cc7453a 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -326,11 +326,6 @@ struct cifs_tcon *tcon_info_alloc(bool dir_leases_enabled,
 				  enum smb3_tcon_ref_trace trace);
 void tconInfoFree(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace);
 
-int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
-		   __u32 *pexpected_response_sequence_number);
-int cifs_verify_signature(struct smb_rqst *rqst,
-			  struct TCP_Server_Info *server,
-			  __u32 expected_sequence_number);
 int setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp);
 void cifs_crypto_secmech_release(struct TCP_Server_Info *server);
 int calc_seckey(struct cifs_ses *ses);
diff --git a/fs/smb/client/smb1encrypt.c b/fs/smb/client/smb1encrypt.c
new file mode 100644
index 000000000000..0dbbce2431ff
--- /dev/null
+++ b/fs/smb/client/smb1encrypt.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ *
+ *   Encryption and hashing operations relating to NTLM, NTLMv2.  See MS-NLMP
+ *   for more detailed information
+ *
+ *   Copyright (C) International Business Machines  Corp., 2005,2013
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *
+ */
+
+#include <linux/fips.h>
+#include <crypto/md5.h>
+#include "cifsproto.h"
+#include "smb1proto.h"
+#include "cifs_debug.h"
+
+/*
+ * Calculate and return the CIFS signature based on the mac key and SMB PDU.
+ * The 16 byte signature must be allocated by the caller. Note we only use the
+ * 1st eight bytes and that the smb header signature field on input contains
+ * the sequence number before this function is called. Also, this function
+ * should be called with the server->srv_mutex held.
+ */
+static int cifs_calc_signature(struct smb_rqst *rqst,
+			struct TCP_Server_Info *server, char *signature)
+{
+	struct md5_ctx ctx;
+
+	if (!rqst->rq_iov || !signature || !server)
+		return -EINVAL;
+	if (fips_enabled) {
+		cifs_dbg(VFS,
+			 "MD5 signature support is disabled due to FIPS\n");
+		return -EOPNOTSUPP;
+	}
+
+	md5_init(&ctx);
+	md5_update(&ctx, server->session_key.response, server->session_key.len);
+
+	return __cifs_calc_signature(
+		rqst, server, signature,
+		&(struct cifs_calc_sig_ctx){ .md5 = &ctx });
+}
+
+/* must be called with server->srv_mutex held */
+int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
+		   __u32 *pexpected_response_sequence_number)
+{
+	int rc = 0;
+	char smb_signature[20];
+	struct smb_hdr *cifs_pdu = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
+
+	if ((cifs_pdu == NULL) || (server == NULL))
+		return -EINVAL;
+
+	spin_lock(&server->srv_lock);
+	if (!(cifs_pdu->Flags2 & SMBFLG2_SECURITY_SIGNATURE) ||
+	    server->tcpStatus == CifsNeedNegotiate) {
+		spin_unlock(&server->srv_lock);
+		return rc;
+	}
+	spin_unlock(&server->srv_lock);
+
+	if (!server->session_estab) {
+		memcpy(cifs_pdu->Signature.SecuritySignature, "BSRSPYL", 8);
+		return rc;
+	}
+
+	cifs_pdu->Signature.Sequence.SequenceNumber =
+				cpu_to_le32(server->sequence_number);
+	cifs_pdu->Signature.Sequence.Reserved = 0;
+
+	*pexpected_response_sequence_number = ++server->sequence_number;
+	++server->sequence_number;
+
+	rc = cifs_calc_signature(rqst, server, smb_signature);
+	if (rc)
+		memset(cifs_pdu->Signature.SecuritySignature, 0, 8);
+	else
+		memcpy(cifs_pdu->Signature.SecuritySignature, smb_signature, 8);
+
+	return rc;
+}
+
+int cifs_verify_signature(struct smb_rqst *rqst,
+			  struct TCP_Server_Info *server,
+			  __u32 expected_sequence_number)
+{
+	unsigned int rc;
+	char server_response_sig[8];
+	char what_we_think_sig_should_be[20];
+	struct smb_hdr *cifs_pdu = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
+
+	if (cifs_pdu == NULL || server == NULL)
+		return -EINVAL;
+
+	if (!server->session_estab)
+		return 0;
+
+	if (cifs_pdu->Command == SMB_COM_LOCKING_ANDX) {
+		struct smb_com_lock_req *pSMB =
+			(struct smb_com_lock_req *)cifs_pdu;
+		if (pSMB->LockType & LOCKING_ANDX_OPLOCK_RELEASE)
+			return 0;
+	}
+
+	/* BB what if signatures are supposed to be on for session but
+	   server does not send one? BB */
+
+	/* Do not need to verify session setups with signature "BSRSPYL "  */
+	if (memcmp(cifs_pdu->Signature.SecuritySignature, "BSRSPYL ", 8) == 0)
+		cifs_dbg(FYI, "dummy signature received for smb command 0x%x\n",
+			 cifs_pdu->Command);
+
+	/* save off the original signature so we can modify the smb and check
+		its signature against what the server sent */
+	memcpy(server_response_sig, cifs_pdu->Signature.SecuritySignature, 8);
+
+	cifs_pdu->Signature.Sequence.SequenceNumber =
+					cpu_to_le32(expected_sequence_number);
+	cifs_pdu->Signature.Sequence.Reserved = 0;
+
+	cifs_server_lock(server);
+	rc = cifs_calc_signature(rqst, server, what_we_think_sig_should_be);
+	cifs_server_unlock(server);
+
+	if (rc)
+		return rc;
+
+/*	cifs_dump_mem("what we think it should be: ",
+		      what_we_think_sig_should_be, 16); */
+
+	if (memcmp(server_response_sig, what_we_think_sig_should_be, 8))
+		return -EACCES;
+	else
+		return 0;
+
+}
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index f5760af58999..0f54c0740da1 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -220,6 +220,15 @@ int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 void cifs_dump_detail(void *buf, size_t buf_len,
 		      struct TCP_Server_Info *server);
 
+/*
+ * smb1encrypt.c
+ */
+int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
+		   __u32 *pexpected_response_sequence_number);
+int cifs_verify_signature(struct smb_rqst *rqst,
+			  struct TCP_Server_Info *server,
+			  __u32 expected_sequence_number);
+
 /*
  * smb1maperror.c
  */


