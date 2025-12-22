Return-Path: <linux-fsdevel+bounces-71881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC080CD75A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D37130A7479
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD734FF61;
	Mon, 22 Dec 2025 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlNNvDBg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039D34F479
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442729; cv=none; b=sYaVU23r++PRcscjD9tnZClHxWXMMkCsAA6cU0N0PWgpm+cwQjKG56KGAJN+CL7Wj9ryoIP8cqJukZ/MuSs7YEtScjiBkz8kVHR5n42dy/+E/F7vOGFxdVxgj3XB4ZPY3kYg2uyVxNgjZeWCk8pjAkTWUNumS7d0olpgigVsBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442729; c=relaxed/simple;
	bh=PSM9Qeabh5U8UJHRiTYfriDxP03GNBPvmV/Dg+CgBCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJEcz6EuI+/gz6hZOBN+0VC0V0TJIVDLSjZDwbIfSrVbXYXug72EjToJI9pHmo0cYu7EMc+m1EKgNuMpzkJVo8YOYpIRf8pQ+a7L2DDDnvqlAZREV67TxOP7/YZHT56VbEktHme1YZ22bejjbrs73gouCtGQGYrmnU5QauHeo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlNNvDBg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmgNtFDG17GInb033n6LKiYh3dpokOPhT7YXoIAf6yw=;
	b=BlNNvDBgx5jb8a6+swykWld3ynIc5ampQRzcdg+7QU1kRAYAK1mCCpsFKXzuPRGr1ACeD4
	Y8aAHjV0H6zgOaF9frBBjGvOmPAYrfFn+E6tg0EzZdg+LxfPmy5+IrRGFliGBSjGjyBvsn
	1U/TOWIcspyygw3UZiRNUKqQAPFHc8g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-yLIME5ORPKm6F7usWl2Ieg-1; Mon,
 22 Dec 2025 17:32:03 -0500
X-MC-Unique: yLIME5ORPKm6F7usWl2Ieg-1
X-Mimecast-MFC-AGG-ID: yLIME5ORPKm6F7usWl2Ieg_1766442721
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FD56180035A;
	Mon, 22 Dec 2025 22:32:01 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D168180049F;
	Mon, 22 Dec 2025 22:31:59 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 35/37] cifs: SMB1 split: sess.c
Date: Mon, 22 Dec 2025 22:30:00 +0000
Message-ID: <20251222223006.1075635-36-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Split SMB1-specific session setup stuff into smb1session.c.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/Makefile      |   1 +
 fs/smb/client/cifsproto.h   |   3 -
 fs/smb/client/sess.c        | 981 -----------------------------------
 fs/smb/client/smb1proto.h   |   7 +
 fs/smb/client/smb1session.c | 995 ++++++++++++++++++++++++++++++++++++
 5 files changed, 1003 insertions(+), 984 deletions(-)
 create mode 100644 fs/smb/client/smb1session.c

diff --git a/fs/smb/client/Makefile b/fs/smb/client/Makefile
index a66e3b5b5912..059e56e715ad 100644
--- a/fs/smb/client/Makefile
+++ b/fs/smb/client/Makefile
@@ -39,6 +39,7 @@ cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) += \
 	smb1maperror.o \
 	smb1misc.o \
 	smb1ops.o \
+	smb1session.o \
 	smb1transport.o
 
 cifs-$(CONFIG_CIFS_COMPRESSION) += compress.o compress/lz77.o
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index ba571cc7453a..49ff68f3c999 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -152,9 +152,6 @@ int decode_negTokenInit(unsigned char *security_blob, int length,
 			struct TCP_Server_Info *server);
 int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
 void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
-int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
-		   struct TCP_Server_Info *server,
-		   const struct nls_table *nls_cp);
 struct timespec64 cifs_NTtimeToUnix(__le64 ntutc);
 u64 cifs_UnixTimeToNT(struct timespec64 t);
 struct timespec64 cnvrtDosUnixTm(__le16 le_date, __le16 le_time, int offset);
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 9373b77a1b31..d523540565ef 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -638,279 +638,6 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 	return rc;
 }
 
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-static __u32 cifs_ssetup_hdr(struct cifs_ses *ses,
-			     struct TCP_Server_Info *server,
-			     SESSION_SETUP_ANDX *pSMB)
-{
-	__u32 capabilities = 0;
-
-	/* init fields common to all four types of SessSetup */
-	/* Note that offsets for first seven fields in req struct are same  */
-	/*	in CIFS Specs so does not matter which of 3 forms of struct */
-	/*	that we use in next few lines                               */
-	/* Note that header is initialized to zero in header_assemble */
-	pSMB->req.AndXCommand = 0xFF;
-	pSMB->req.MaxBufferSize = cpu_to_le16(min_t(u32,
-					CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4,
-					USHRT_MAX));
-	pSMB->req.MaxMpxCount = cpu_to_le16(server->maxReq);
-	pSMB->req.VcNumber = cpu_to_le16(1);
-	pSMB->req.SessionKey = server->session_key_id;
-
-	/* Now no need to set SMBFLG_CASELESS or obsolete CANONICAL PATH */
-
-	/* BB verify whether signing required on neg or just auth frame (and NTLM case) */
-
-	capabilities = CAP_LARGE_FILES | CAP_NT_SMBS | CAP_LEVEL_II_OPLOCKS |
-			CAP_LARGE_WRITE_X | CAP_LARGE_READ_X;
-
-	if (server->sign)
-		pSMB->req.hdr.Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
-
-	if (ses->capabilities & CAP_UNICODE) {
-		pSMB->req.hdr.Flags2 |= SMBFLG2_UNICODE;
-		capabilities |= CAP_UNICODE;
-	}
-	if (ses->capabilities & CAP_STATUS32) {
-		pSMB->req.hdr.Flags2 |= SMBFLG2_ERR_STATUS;
-		capabilities |= CAP_STATUS32;
-	}
-	if (ses->capabilities & CAP_DFS) {
-		pSMB->req.hdr.Flags2 |= SMBFLG2_DFS;
-		capabilities |= CAP_DFS;
-	}
-	if (ses->capabilities & CAP_UNIX)
-		capabilities |= CAP_UNIX;
-
-	return capabilities;
-}
-
-static void
-unicode_oslm_strings(char **pbcc_area, const struct nls_table *nls_cp)
-{
-	char *bcc_ptr = *pbcc_area;
-	int bytes_ret = 0;
-
-	/* Copy OS version */
-	bytes_ret = cifs_strtoUTF16((__le16 *)bcc_ptr, "Linux version ", 32,
-				    nls_cp);
-	bcc_ptr += 2 * bytes_ret;
-	bytes_ret = cifs_strtoUTF16((__le16 *) bcc_ptr, init_utsname()->release,
-				    32, nls_cp);
-	bcc_ptr += 2 * bytes_ret;
-	bcc_ptr += 2; /* trailing null */
-
-	bytes_ret = cifs_strtoUTF16((__le16 *) bcc_ptr, CIFS_NETWORK_OPSYS,
-				    32, nls_cp);
-	bcc_ptr += 2 * bytes_ret;
-	bcc_ptr += 2; /* trailing null */
-
-	*pbcc_area = bcc_ptr;
-}
-
-static void
-ascii_oslm_strings(char **pbcc_area, const struct nls_table *nls_cp)
-{
-	char *bcc_ptr = *pbcc_area;
-
-	strcpy(bcc_ptr, "Linux version ");
-	bcc_ptr += strlen("Linux version ");
-	strcpy(bcc_ptr, init_utsname()->release);
-	bcc_ptr += strlen(init_utsname()->release) + 1;
-
-	strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
-	bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
-
-	*pbcc_area = bcc_ptr;
-}
-
-static void unicode_domain_string(char **pbcc_area, struct cifs_ses *ses,
-				   const struct nls_table *nls_cp)
-{
-	char *bcc_ptr = *pbcc_area;
-	int bytes_ret = 0;
-
-	/* copy domain */
-	if (ses->domainName == NULL) {
-		/*
-		 * Sending null domain better than using a bogus domain name (as
-		 * we did briefly in 2.6.18) since server will use its default
-		 */
-		*bcc_ptr = 0;
-		*(bcc_ptr+1) = 0;
-		bytes_ret = 0;
-	} else
-		bytes_ret = cifs_strtoUTF16((__le16 *) bcc_ptr, ses->domainName,
-					    CIFS_MAX_DOMAINNAME_LEN, nls_cp);
-	bcc_ptr += 2 * bytes_ret;
-	bcc_ptr += 2;  /* account for null terminator */
-
-	*pbcc_area = bcc_ptr;
-}
-
-static void ascii_domain_string(char **pbcc_area, struct cifs_ses *ses,
-				const struct nls_table *nls_cp)
-{
-	char *bcc_ptr = *pbcc_area;
-	int len;
-
-	/* copy domain */
-	if (ses->domainName != NULL) {
-		len = strscpy(bcc_ptr, ses->domainName, CIFS_MAX_DOMAINNAME_LEN);
-		if (WARN_ON_ONCE(len < 0))
-			len = CIFS_MAX_DOMAINNAME_LEN - 1;
-		bcc_ptr += len;
-	} /* else we send a null domain name so server will default to its own domain */
-	*bcc_ptr = 0;
-	bcc_ptr++;
-
-	*pbcc_area = bcc_ptr;
-}
-
-static void unicode_ssetup_strings(char **pbcc_area, struct cifs_ses *ses,
-				   const struct nls_table *nls_cp)
-{
-	char *bcc_ptr = *pbcc_area;
-	int bytes_ret = 0;
-
-	/* BB FIXME add check that strings less than 335 or will need to send as arrays */
-
-	/* copy user */
-	if (ses->user_name == NULL) {
-		/* null user mount */
-		*bcc_ptr = 0;
-		*(bcc_ptr+1) = 0;
-	} else {
-		bytes_ret = cifs_strtoUTF16((__le16 *) bcc_ptr, ses->user_name,
-					    CIFS_MAX_USERNAME_LEN, nls_cp);
-	}
-	bcc_ptr += 2 * bytes_ret;
-	bcc_ptr += 2; /* account for null termination */
-
-	unicode_domain_string(&bcc_ptr, ses, nls_cp);
-	unicode_oslm_strings(&bcc_ptr, nls_cp);
-
-	*pbcc_area = bcc_ptr;
-}
-
-static void ascii_ssetup_strings(char **pbcc_area, struct cifs_ses *ses,
-				 const struct nls_table *nls_cp)
-{
-	char *bcc_ptr = *pbcc_area;
-	int len;
-
-	/* copy user */
-	/* BB what about null user mounts - check that we do this BB */
-	/* copy user */
-	if (ses->user_name != NULL) {
-		len = strscpy(bcc_ptr, ses->user_name, CIFS_MAX_USERNAME_LEN);
-		if (WARN_ON_ONCE(len < 0))
-			len = CIFS_MAX_USERNAME_LEN - 1;
-		bcc_ptr += len;
-	}
-	/* else null user mount */
-	*bcc_ptr = 0;
-	bcc_ptr++; /* account for null termination */
-
-	/* BB check for overflow here */
-
-	ascii_domain_string(&bcc_ptr, ses, nls_cp);
-	ascii_oslm_strings(&bcc_ptr, nls_cp);
-
-	*pbcc_area = bcc_ptr;
-}
-
-static void
-decode_unicode_ssetup(char **pbcc_area, int bleft, struct cifs_ses *ses,
-		      const struct nls_table *nls_cp)
-{
-	int len;
-	char *data = *pbcc_area;
-
-	cifs_dbg(FYI, "bleft %d\n", bleft);
-
-	kfree(ses->serverOS);
-	ses->serverOS = cifs_strndup_from_utf16(data, bleft, true, nls_cp);
-	cifs_dbg(FYI, "serverOS=%s\n", ses->serverOS);
-	len = (UniStrnlen((wchar_t *) data, bleft / 2) * 2) + 2;
-	data += len;
-	bleft -= len;
-	if (bleft <= 0)
-		return;
-
-	kfree(ses->serverNOS);
-	ses->serverNOS = cifs_strndup_from_utf16(data, bleft, true, nls_cp);
-	cifs_dbg(FYI, "serverNOS=%s\n", ses->serverNOS);
-	len = (UniStrnlen((wchar_t *) data, bleft / 2) * 2) + 2;
-	data += len;
-	bleft -= len;
-	if (bleft <= 0)
-		return;
-
-	kfree(ses->serverDomain);
-	ses->serverDomain = cifs_strndup_from_utf16(data, bleft, true, nls_cp);
-	cifs_dbg(FYI, "serverDomain=%s\n", ses->serverDomain);
-
-	return;
-}
-
-static void decode_ascii_ssetup(char **pbcc_area, __u16 bleft,
-				struct cifs_ses *ses,
-				const struct nls_table *nls_cp)
-{
-	int len;
-	char *bcc_ptr = *pbcc_area;
-
-	cifs_dbg(FYI, "decode sessetup ascii. bleft %d\n", bleft);
-
-	len = strnlen(bcc_ptr, bleft);
-	if (len >= bleft)
-		return;
-
-	kfree(ses->serverOS);
-
-	ses->serverOS = kmalloc(len + 1, GFP_KERNEL);
-	if (ses->serverOS) {
-		memcpy(ses->serverOS, bcc_ptr, len);
-		ses->serverOS[len] = 0;
-		if (strncmp(ses->serverOS, "OS/2", 4) == 0)
-			cifs_dbg(FYI, "OS/2 server\n");
-	}
-
-	bcc_ptr += len + 1;
-	bleft -= len + 1;
-
-	len = strnlen(bcc_ptr, bleft);
-	if (len >= bleft)
-		return;
-
-	kfree(ses->serverNOS);
-
-	ses->serverNOS = kmalloc(len + 1, GFP_KERNEL);
-	if (ses->serverNOS) {
-		memcpy(ses->serverNOS, bcc_ptr, len);
-		ses->serverNOS[len] = 0;
-	}
-
-	bcc_ptr += len + 1;
-	bleft -= len + 1;
-
-	len = strnlen(bcc_ptr, bleft);
-	if (len > bleft)
-		return;
-
-	/*
-	 * No domain field in LANMAN case. Domain is
-	 * returned by old servers in the SMB negprot response
-	 *
-	 * BB For newer servers which do not support Unicode,
-	 * but thus do return domain here, we could add parsing
-	 * for it later, but it is not very important
-	 */
-	cifs_dbg(FYI, "ascii: bytes left %d\n", bleft);
-}
-#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 
 int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
 				    struct cifs_ses *ses)
@@ -1321,711 +1048,3 @@ cifs_select_sectype(struct TCP_Server_Info *server, enum securityEnum requested)
 		return Unspecified;
 	}
 }
-
-struct sess_data {
-	unsigned int xid;
-	struct cifs_ses *ses;
-	struct TCP_Server_Info *server;
-	struct nls_table *nls_cp;
-	void (*func)(struct sess_data *);
-	int result;
-	unsigned int in_len;
-
-	/* we will send the SMB in three pieces:
-	 * a fixed length beginning part, an optional
-	 * SPNEGO blob (which can be zero length), and a
-	 * last part which will include the strings
-	 * and rest of bcc area. This allows us to avoid
-	 * a large buffer 17K allocation
-	 */
-	int buf0_type;
-	struct kvec iov[3];
-};
-
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-static int
-sess_alloc_buffer(struct sess_data *sess_data, int wct)
-{
-	int rc;
-	struct cifs_ses *ses = sess_data->ses;
-	struct smb_hdr *smb_buf;
-
-	rc = small_smb_init_no_tc(SMB_COM_SESSION_SETUP_ANDX, wct, ses,
-				  (void **)&smb_buf);
-
-	if (rc < 0)
-		return rc;
-
-	sess_data->in_len = rc;
-	sess_data->iov[0].iov_base = (char *)smb_buf;
-	sess_data->iov[0].iov_len = sess_data->in_len;
-	/*
-	 * This variable will be used to clear the buffer
-	 * allocated above in case of any error in the calling function.
-	 */
-	sess_data->buf0_type = CIFS_SMALL_BUFFER;
-
-	/* 2000 big enough to fit max user, domain, NOS name etc. */
-	sess_data->iov[2].iov_base = kmalloc(2000, GFP_KERNEL);
-	if (!sess_data->iov[2].iov_base) {
-		rc = -ENOMEM;
-		goto out_free_smb_buf;
-	}
-
-	return 0;
-
-out_free_smb_buf:
-	cifs_small_buf_release(smb_buf);
-	sess_data->iov[0].iov_base = NULL;
-	sess_data->iov[0].iov_len = 0;
-	sess_data->buf0_type = CIFS_NO_BUFFER;
-	return rc;
-}
-
-static void
-sess_free_buffer(struct sess_data *sess_data)
-{
-	struct kvec *iov = sess_data->iov;
-
-	/*
-	 * Zero the session data before freeing, as it might contain sensitive info (keys, etc).
-	 * Note that iov[1] is already freed by caller.
-	 */
-	if (sess_data->buf0_type != CIFS_NO_BUFFER && iov[0].iov_base)
-		memzero_explicit(iov[0].iov_base, iov[0].iov_len);
-
-	free_rsp_buf(sess_data->buf0_type, iov[0].iov_base);
-	sess_data->buf0_type = CIFS_NO_BUFFER;
-	kfree_sensitive(iov[2].iov_base);
-}
-
-static int
-sess_establish_session(struct sess_data *sess_data)
-{
-	struct cifs_ses *ses = sess_data->ses;
-	struct TCP_Server_Info *server = sess_data->server;
-
-	cifs_server_lock(server);
-	if (!server->session_estab) {
-		if (server->sign) {
-			server->session_key.response =
-				kmemdup(ses->auth_key.response,
-				ses->auth_key.len, GFP_KERNEL);
-			if (!server->session_key.response) {
-				cifs_server_unlock(server);
-				return -ENOMEM;
-			}
-			server->session_key.len =
-						ses->auth_key.len;
-		}
-		server->sequence_number = 0x2;
-		server->session_estab = true;
-	}
-	cifs_server_unlock(server);
-
-	cifs_dbg(FYI, "CIFS session established successfully\n");
-	return 0;
-}
-
-static int
-sess_sendreceive(struct sess_data *sess_data)
-{
-	int rc;
-	struct smb_hdr *smb_buf = (struct smb_hdr *) sess_data->iov[0].iov_base;
-	__u16 count;
-	struct kvec rsp_iov = { NULL, 0 };
-
-	count = sess_data->iov[1].iov_len + sess_data->iov[2].iov_len;
-	sess_data->in_len += count;
-	put_bcc(count, smb_buf);
-
-	rc = SendReceive2(sess_data->xid, sess_data->ses,
-			  sess_data->iov, 3 /* num_iovecs */,
-			  &sess_data->buf0_type,
-			  CIFS_LOG_ERROR, &rsp_iov);
-	cifs_small_buf_release(sess_data->iov[0].iov_base);
-	memcpy(&sess_data->iov[0], &rsp_iov, sizeof(struct kvec));
-
-	return rc;
-}
-
-static void
-sess_auth_ntlmv2(struct sess_data *sess_data)
-{
-	int rc = 0;
-	struct smb_hdr *smb_buf;
-	SESSION_SETUP_ANDX *pSMB;
-	char *bcc_ptr;
-	struct cifs_ses *ses = sess_data->ses;
-	struct TCP_Server_Info *server = sess_data->server;
-	__u32 capabilities;
-	__u16 bytes_remaining;
-
-	/* old style NTLM sessionsetup */
-	/* wct = 13 */
-	rc = sess_alloc_buffer(sess_data, 13);
-	if (rc)
-		goto out;
-
-	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
-	bcc_ptr = sess_data->iov[2].iov_base;
-	capabilities = cifs_ssetup_hdr(ses, server, pSMB);
-
-	pSMB->req_no_secext.Capabilities = cpu_to_le32(capabilities);
-
-	/* LM2 password would be here if we supported it */
-	pSMB->req_no_secext.CaseInsensitivePasswordLength = 0;
-
-	if (ses->user_name != NULL) {
-		/* calculate nlmv2 response and session key */
-		rc = setup_ntlmv2_rsp(ses, sess_data->nls_cp);
-		if (rc) {
-			cifs_dbg(VFS, "Error %d during NTLMv2 authentication\n", rc);
-			goto out;
-		}
-
-		memcpy(bcc_ptr, ses->auth_key.response + CIFS_SESS_KEY_SIZE,
-				ses->auth_key.len - CIFS_SESS_KEY_SIZE);
-		bcc_ptr += ses->auth_key.len - CIFS_SESS_KEY_SIZE;
-
-		/* set case sensitive password length after tilen may get
-		 * assigned, tilen is 0 otherwise.
-		 */
-		pSMB->req_no_secext.CaseSensitivePasswordLength =
-			cpu_to_le16(ses->auth_key.len - CIFS_SESS_KEY_SIZE);
-	} else {
-		pSMB->req_no_secext.CaseSensitivePasswordLength = 0;
-	}
-
-	if (ses->capabilities & CAP_UNICODE) {
-		if (!IS_ALIGNED(sess_data->iov[0].iov_len, 2)) {
-			*bcc_ptr = 0;
-			bcc_ptr++;
-		}
-		unicode_ssetup_strings(&bcc_ptr, ses, sess_data->nls_cp);
-	} else {
-		ascii_ssetup_strings(&bcc_ptr, ses, sess_data->nls_cp);
-	}
-
-
-	sess_data->iov[2].iov_len = (long) bcc_ptr -
-			(long) sess_data->iov[2].iov_base;
-
-	rc = sess_sendreceive(sess_data);
-	if (rc)
-		goto out;
-
-	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
-	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
-
-	if (smb_buf->WordCount != 3) {
-		rc = smb_EIO1(smb_eio_trace_sess_nl2_wcc, smb_buf->WordCount);
-		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
-		goto out;
-	}
-
-	if (le16_to_cpu(pSMB->resp.Action) & GUEST_LOGIN)
-		cifs_dbg(FYI, "Guest login\n"); /* BB mark SesInfo struct? */
-
-	ses->Suid = smb_buf->Uid;   /* UID left in wire format (le) */
-	cifs_dbg(FYI, "UID = %llu\n", ses->Suid);
-
-	bytes_remaining = get_bcc(smb_buf);
-	bcc_ptr = pByteArea(smb_buf);
-
-	/* BB check if Unicode and decode strings */
-	if (bytes_remaining == 0) {
-		/* no string area to decode, do nothing */
-	} else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
-		/* unicode string area must be word-aligned */
-		if (!IS_ALIGNED((unsigned long)bcc_ptr - (unsigned long)smb_buf, 2)) {
-			++bcc_ptr;
-			--bytes_remaining;
-		}
-		decode_unicode_ssetup(&bcc_ptr, bytes_remaining, ses,
-				      sess_data->nls_cp);
-	} else {
-		decode_ascii_ssetup(&bcc_ptr, bytes_remaining, ses,
-				    sess_data->nls_cp);
-	}
-
-	rc = sess_establish_session(sess_data);
-out:
-	sess_data->result = rc;
-	sess_data->func = NULL;
-	sess_free_buffer(sess_data);
-	kfree_sensitive(ses->auth_key.response);
-	ses->auth_key.response = NULL;
-}
-
-#ifdef CONFIG_CIFS_UPCALL
-static void
-sess_auth_kerberos(struct sess_data *sess_data)
-{
-	int rc = 0;
-	struct smb_hdr *smb_buf;
-	SESSION_SETUP_ANDX *pSMB;
-	char *bcc_ptr;
-	struct cifs_ses *ses = sess_data->ses;
-	struct TCP_Server_Info *server = sess_data->server;
-	__u32 capabilities;
-	__u16 bytes_remaining;
-	struct key *spnego_key = NULL;
-	struct cifs_spnego_msg *msg;
-	u16 blob_len;
-
-	/* extended security */
-	/* wct = 12 */
-	rc = sess_alloc_buffer(sess_data, 12);
-	if (rc)
-		goto out;
-
-	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
-	bcc_ptr = sess_data->iov[2].iov_base;
-	capabilities = cifs_ssetup_hdr(ses, server, pSMB);
-
-	spnego_key = cifs_get_spnego_key(ses, server);
-	if (IS_ERR(spnego_key)) {
-		rc = PTR_ERR(spnego_key);
-		spnego_key = NULL;
-		goto out;
-	}
-
-	msg = spnego_key->payload.data[0];
-	/*
-	 * check version field to make sure that cifs.upcall is
-	 * sending us a response in an expected form
-	 */
-	if (msg->version != CIFS_SPNEGO_UPCALL_VERSION) {
-		cifs_dbg(VFS, "incorrect version of cifs.upcall (expected %d but got %d)\n",
-			 CIFS_SPNEGO_UPCALL_VERSION, msg->version);
-		rc = -EKEYREJECTED;
-		goto out_put_spnego_key;
-	}
-
-	kfree_sensitive(ses->auth_key.response);
-	ses->auth_key.response = kmemdup(msg->data, msg->sesskey_len,
-					 GFP_KERNEL);
-	if (!ses->auth_key.response) {
-		cifs_dbg(VFS, "Kerberos can't allocate (%u bytes) memory\n",
-			 msg->sesskey_len);
-		rc = -ENOMEM;
-		goto out_put_spnego_key;
-	}
-	ses->auth_key.len = msg->sesskey_len;
-
-	pSMB->req.hdr.Flags2 |= SMBFLG2_EXT_SEC;
-	capabilities |= CAP_EXTENDED_SECURITY;
-	pSMB->req.Capabilities = cpu_to_le32(capabilities);
-	sess_data->iov[1].iov_base = msg->data + msg->sesskey_len;
-	sess_data->iov[1].iov_len = msg->secblob_len;
-	pSMB->req.SecurityBlobLength = cpu_to_le16(sess_data->iov[1].iov_len);
-
-	if (pSMB->req.hdr.Flags2 & SMBFLG2_UNICODE) {
-		/* unicode strings must be word aligned */
-		if (!IS_ALIGNED(sess_data->iov[0].iov_len + sess_data->iov[1].iov_len, 2)) {
-			*bcc_ptr = 0;
-			bcc_ptr++;
-		}
-		unicode_oslm_strings(&bcc_ptr, sess_data->nls_cp);
-		unicode_domain_string(&bcc_ptr, ses, sess_data->nls_cp);
-	} else {
-		ascii_oslm_strings(&bcc_ptr, sess_data->nls_cp);
-		ascii_domain_string(&bcc_ptr, ses, sess_data->nls_cp);
-	}
-
-	sess_data->iov[2].iov_len = (long) bcc_ptr -
-			(long) sess_data->iov[2].iov_base;
-
-	rc = sess_sendreceive(sess_data);
-	if (rc)
-		goto out_put_spnego_key;
-
-	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
-	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
-
-	if (smb_buf->WordCount != 4) {
-		rc = smb_EIO1(smb_eio_trace_sess_krb_wcc, smb_buf->WordCount);
-		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
-		goto out_put_spnego_key;
-	}
-
-	if (le16_to_cpu(pSMB->resp.Action) & GUEST_LOGIN)
-		cifs_dbg(FYI, "Guest login\n"); /* BB mark SesInfo struct? */
-
-	ses->Suid = smb_buf->Uid;   /* UID left in wire format (le) */
-	cifs_dbg(FYI, "UID = %llu\n", ses->Suid);
-
-	bytes_remaining = get_bcc(smb_buf);
-	bcc_ptr = pByteArea(smb_buf);
-
-	blob_len = le16_to_cpu(pSMB->resp.SecurityBlobLength);
-	if (blob_len > bytes_remaining) {
-		cifs_dbg(VFS, "bad security blob length %d\n",
-				blob_len);
-		rc = -EINVAL;
-		goto out_put_spnego_key;
-	}
-	bcc_ptr += blob_len;
-	bytes_remaining -= blob_len;
-
-	/* BB check if Unicode and decode strings */
-	if (bytes_remaining == 0) {
-		/* no string area to decode, do nothing */
-	} else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
-		/* unicode string area must be word-aligned */
-		if (!IS_ALIGNED((unsigned long)bcc_ptr - (unsigned long)smb_buf, 2)) {
-			++bcc_ptr;
-			--bytes_remaining;
-		}
-		decode_unicode_ssetup(&bcc_ptr, bytes_remaining, ses,
-				      sess_data->nls_cp);
-	} else {
-		decode_ascii_ssetup(&bcc_ptr, bytes_remaining, ses,
-				    sess_data->nls_cp);
-	}
-
-	rc = sess_establish_session(sess_data);
-out_put_spnego_key:
-	key_invalidate(spnego_key);
-	key_put(spnego_key);
-out:
-	sess_data->result = rc;
-	sess_data->func = NULL;
-	sess_free_buffer(sess_data);
-	kfree_sensitive(ses->auth_key.response);
-	ses->auth_key.response = NULL;
-}
-
-#endif /* ! CONFIG_CIFS_UPCALL */
-
-/*
- * The required kvec buffers have to be allocated before calling this
- * function.
- */
-static int
-_sess_auth_rawntlmssp_assemble_req(struct sess_data *sess_data)
-{
-	SESSION_SETUP_ANDX *pSMB;
-	struct cifs_ses *ses = sess_data->ses;
-	struct TCP_Server_Info *server = sess_data->server;
-	__u32 capabilities;
-	char *bcc_ptr;
-
-	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
-
-	capabilities = cifs_ssetup_hdr(ses, server, pSMB);
-	pSMB->req.hdr.Flags2 |= SMBFLG2_EXT_SEC;
-	capabilities |= CAP_EXTENDED_SECURITY;
-	pSMB->req.Capabilities |= cpu_to_le32(capabilities);
-
-	bcc_ptr = sess_data->iov[2].iov_base;
-
-	if (pSMB->req.hdr.Flags2 & SMBFLG2_UNICODE) {
-		/* unicode strings must be word aligned */
-		if (!IS_ALIGNED(sess_data->iov[0].iov_len + sess_data->iov[1].iov_len, 2)) {
-			*bcc_ptr = 0;
-			bcc_ptr++;
-		}
-		unicode_oslm_strings(&bcc_ptr, sess_data->nls_cp);
-	} else {
-		ascii_oslm_strings(&bcc_ptr, sess_data->nls_cp);
-	}
-
-	sess_data->iov[2].iov_len = (long) bcc_ptr -
-					(long) sess_data->iov[2].iov_base;
-
-	return 0;
-}
-
-static void
-sess_auth_rawntlmssp_authenticate(struct sess_data *sess_data);
-
-static void
-sess_auth_rawntlmssp_negotiate(struct sess_data *sess_data)
-{
-	int rc;
-	struct smb_hdr *smb_buf;
-	SESSION_SETUP_ANDX *pSMB;
-	struct cifs_ses *ses = sess_data->ses;
-	struct TCP_Server_Info *server = sess_data->server;
-	__u16 bytes_remaining;
-	char *bcc_ptr;
-	unsigned char *ntlmsspblob = NULL;
-	u16 blob_len;
-
-	cifs_dbg(FYI, "rawntlmssp session setup negotiate phase\n");
-
-	/*
-	 * if memory allocation is successful, caller of this function
-	 * frees it.
-	 */
-	ses->ntlmssp = kmalloc(sizeof(struct ntlmssp_auth), GFP_KERNEL);
-	if (!ses->ntlmssp) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	ses->ntlmssp->sesskey_per_smbsess = false;
-
-	/* wct = 12 */
-	rc = sess_alloc_buffer(sess_data, 12);
-	if (rc)
-		goto out;
-
-	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
-
-	/* Build security blob before we assemble the request */
-	rc = build_ntlmssp_negotiate_blob(&ntlmsspblob,
-				     &blob_len, ses, server,
-				     sess_data->nls_cp);
-	if (rc)
-		goto out_free_ntlmsspblob;
-
-	sess_data->iov[1].iov_len = blob_len;
-	sess_data->iov[1].iov_base = ntlmsspblob;
-	pSMB->req.SecurityBlobLength = cpu_to_le16(blob_len);
-
-	rc = _sess_auth_rawntlmssp_assemble_req(sess_data);
-	if (rc)
-		goto out_free_ntlmsspblob;
-
-	rc = sess_sendreceive(sess_data);
-
-	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
-	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
-
-	/* If true, rc here is expected and not an error */
-	if (sess_data->buf0_type != CIFS_NO_BUFFER &&
-	    smb_buf->Status.CifsError ==
-			cpu_to_le32(NT_STATUS_MORE_PROCESSING_REQUIRED))
-		rc = 0;
-
-	if (rc)
-		goto out_free_ntlmsspblob;
-
-	cifs_dbg(FYI, "rawntlmssp session setup challenge phase\n");
-
-	if (smb_buf->WordCount != 4) {
-		rc = smb_EIO1(smb_eio_trace_sess_rawnl_neg_wcc, smb_buf->WordCount);
-		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
-		goto out_free_ntlmsspblob;
-	}
-
-	ses->Suid = smb_buf->Uid;   /* UID left in wire format (le) */
-	cifs_dbg(FYI, "UID = %llu\n", ses->Suid);
-
-	bytes_remaining = get_bcc(smb_buf);
-	bcc_ptr = pByteArea(smb_buf);
-
-	blob_len = le16_to_cpu(pSMB->resp.SecurityBlobLength);
-	if (blob_len > bytes_remaining) {
-		cifs_dbg(VFS, "bad security blob length %d\n",
-				blob_len);
-		rc = -EINVAL;
-		goto out_free_ntlmsspblob;
-	}
-
-	rc = decode_ntlmssp_challenge(bcc_ptr, blob_len, ses);
-
-out_free_ntlmsspblob:
-	kfree_sensitive(ntlmsspblob);
-out:
-	sess_free_buffer(sess_data);
-
-	if (!rc) {
-		sess_data->func = sess_auth_rawntlmssp_authenticate;
-		return;
-	}
-
-	/* Else error. Cleanup */
-	kfree_sensitive(ses->auth_key.response);
-	ses->auth_key.response = NULL;
-	kfree_sensitive(ses->ntlmssp);
-	ses->ntlmssp = NULL;
-
-	sess_data->func = NULL;
-	sess_data->result = rc;
-}
-
-static void
-sess_auth_rawntlmssp_authenticate(struct sess_data *sess_data)
-{
-	int rc;
-	struct smb_hdr *smb_buf;
-	SESSION_SETUP_ANDX *pSMB;
-	struct cifs_ses *ses = sess_data->ses;
-	struct TCP_Server_Info *server = sess_data->server;
-	__u16 bytes_remaining;
-	char *bcc_ptr;
-	unsigned char *ntlmsspblob = NULL;
-	u16 blob_len;
-
-	cifs_dbg(FYI, "rawntlmssp session setup authenticate phase\n");
-
-	/* wct = 12 */
-	rc = sess_alloc_buffer(sess_data, 12);
-	if (rc)
-		goto out;
-
-	/* Build security blob before we assemble the request */
-	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
-	smb_buf = (struct smb_hdr *)pSMB;
-	rc = build_ntlmssp_auth_blob(&ntlmsspblob,
-					&blob_len, ses, server,
-					sess_data->nls_cp);
-	if (rc)
-		goto out_free_ntlmsspblob;
-	sess_data->iov[1].iov_len = blob_len;
-	sess_data->iov[1].iov_base = ntlmsspblob;
-	pSMB->req.SecurityBlobLength = cpu_to_le16(blob_len);
-	/*
-	 * Make sure that we tell the server that we are using
-	 * the uid that it just gave us back on the response
-	 * (challenge)
-	 */
-	smb_buf->Uid = ses->Suid;
-
-	rc = _sess_auth_rawntlmssp_assemble_req(sess_data);
-	if (rc)
-		goto out_free_ntlmsspblob;
-
-	rc = sess_sendreceive(sess_data);
-	if (rc)
-		goto out_free_ntlmsspblob;
-
-	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
-	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
-	if (smb_buf->WordCount != 4) {
-		rc = smb_EIO1(smb_eio_trace_sess_rawnl_auth_wcc, smb_buf->WordCount);
-		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
-		goto out_free_ntlmsspblob;
-	}
-
-	if (le16_to_cpu(pSMB->resp.Action) & GUEST_LOGIN)
-		cifs_dbg(FYI, "Guest login\n"); /* BB mark SesInfo struct? */
-
-	if (ses->Suid != smb_buf->Uid) {
-		ses->Suid = smb_buf->Uid;
-		cifs_dbg(FYI, "UID changed! new UID = %llu\n", ses->Suid);
-	}
-
-	bytes_remaining = get_bcc(smb_buf);
-	bcc_ptr = pByteArea(smb_buf);
-	blob_len = le16_to_cpu(pSMB->resp.SecurityBlobLength);
-	if (blob_len > bytes_remaining) {
-		cifs_dbg(VFS, "bad security blob length %d\n",
-				blob_len);
-		rc = -EINVAL;
-		goto out_free_ntlmsspblob;
-	}
-	bcc_ptr += blob_len;
-	bytes_remaining -= blob_len;
-
-
-	/* BB check if Unicode and decode strings */
-	if (bytes_remaining == 0) {
-		/* no string area to decode, do nothing */
-	} else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
-		/* unicode string area must be word-aligned */
-		if (!IS_ALIGNED((unsigned long)bcc_ptr - (unsigned long)smb_buf, 2)) {
-			++bcc_ptr;
-			--bytes_remaining;
-		}
-		decode_unicode_ssetup(&bcc_ptr, bytes_remaining, ses,
-				      sess_data->nls_cp);
-	} else {
-		decode_ascii_ssetup(&bcc_ptr, bytes_remaining, ses,
-				    sess_data->nls_cp);
-	}
-
-out_free_ntlmsspblob:
-	kfree_sensitive(ntlmsspblob);
-out:
-	sess_free_buffer(sess_data);
-
-	if (!rc)
-		rc = sess_establish_session(sess_data);
-
-	/* Cleanup */
-	kfree_sensitive(ses->auth_key.response);
-	ses->auth_key.response = NULL;
-	kfree_sensitive(ses->ntlmssp);
-	ses->ntlmssp = NULL;
-
-	sess_data->func = NULL;
-	sess_data->result = rc;
-}
-
-static int select_sec(struct sess_data *sess_data)
-{
-	int type;
-	struct cifs_ses *ses = sess_data->ses;
-	struct TCP_Server_Info *server = sess_data->server;
-
-	type = cifs_select_sectype(server, ses->sectype);
-	cifs_dbg(FYI, "sess setup type %d\n", type);
-	if (type == Unspecified) {
-		cifs_dbg(VFS, "Unable to select appropriate authentication method!\n");
-		return -EINVAL;
-	}
-
-	switch (type) {
-	case NTLMv2:
-		sess_data->func = sess_auth_ntlmv2;
-		break;
-	case Kerberos:
-#ifdef CONFIG_CIFS_UPCALL
-		sess_data->func = sess_auth_kerberos;
-		break;
-#else
-		cifs_dbg(VFS, "Kerberos negotiated but upcall support disabled!\n");
-		return -ENOSYS;
-#endif /* CONFIG_CIFS_UPCALL */
-	case RawNTLMSSP:
-		sess_data->func = sess_auth_rawntlmssp_negotiate;
-		break;
-	default:
-		cifs_dbg(VFS, "secType %d not supported!\n", type);
-		return -ENOSYS;
-	}
-
-	return 0;
-}
-
-int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
-		   struct TCP_Server_Info *server,
-		   const struct nls_table *nls_cp)
-{
-	int rc = 0;
-	struct sess_data *sess_data;
-
-	if (ses == NULL) {
-		WARN(1, "%s: ses == NULL!", __func__);
-		return -EINVAL;
-	}
-
-	sess_data = kzalloc(sizeof(struct sess_data), GFP_KERNEL);
-	if (!sess_data)
-		return -ENOMEM;
-
-	sess_data->xid = xid;
-	sess_data->ses = ses;
-	sess_data->server = server;
-	sess_data->buf0_type = CIFS_NO_BUFFER;
-	sess_data->nls_cp = (struct nls_table *) nls_cp;
-
-	rc = select_sec(sess_data);
-	if (rc)
-		goto out;
-
-	while (sess_data->func)
-		sess_data->func(sess_data);
-
-	/* Store result before we free sess_data */
-	rc = sess_data->result;
-
-out:
-	kfree_sensitive(sess_data);
-	return rc;
-}
-#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index 0f54c0740da1..645f3e74fcc4 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -250,6 +250,13 @@ unsigned int smbCalcSize(void *buf);
 extern struct smb_version_operations smb1_operations;
 extern struct smb_version_values smb1_values;
 
+/*
+ * smb1session.c
+ */
+int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
+		   struct TCP_Server_Info *server,
+		   const struct nls_table *nls_cp);
+
 /*
  * smb1transport.c
  */
diff --git a/fs/smb/client/smb1session.c b/fs/smb/client/smb1session.c
new file mode 100644
index 000000000000..1cf6bd640fde
--- /dev/null
+++ b/fs/smb/client/smb1session.c
@@ -0,0 +1,995 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ *
+ *   SMB/CIFS session setup handling routines
+ *
+ *   Copyright (c) International Business Machines  Corp., 2006, 2009
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *
+ */
+
+#include "cifsproto.h"
+#include "smb1proto.h"
+#include "ntlmssp.h"
+#include "nterr.h"
+#include "cifs_spnego.h"
+#include "cifs_unicode.h"
+#include "cifs_debug.h"
+
+struct sess_data {
+	unsigned int xid;
+	struct cifs_ses *ses;
+	struct TCP_Server_Info *server;
+	struct nls_table *nls_cp;
+	void (*func)(struct sess_data *);
+	int result;
+	unsigned int in_len;
+
+	/* we will send the SMB in three pieces:
+	 * a fixed length beginning part, an optional
+	 * SPNEGO blob (which can be zero length), and a
+	 * last part which will include the strings
+	 * and rest of bcc area. This allows us to avoid
+	 * a large buffer 17K allocation
+	 */
+	int buf0_type;
+	struct kvec iov[3];
+};
+
+static __u32 cifs_ssetup_hdr(struct cifs_ses *ses,
+			     struct TCP_Server_Info *server,
+			     SESSION_SETUP_ANDX *pSMB)
+{
+	__u32 capabilities = 0;
+
+	/* init fields common to all four types of SessSetup */
+	/* Note that offsets for first seven fields in req struct are same  */
+	/*	in CIFS Specs so does not matter which of 3 forms of struct */
+	/*	that we use in next few lines                               */
+	/* Note that header is initialized to zero in header_assemble */
+	pSMB->req.AndXCommand = 0xFF;
+	pSMB->req.MaxBufferSize = cpu_to_le16(min_t(u32,
+					CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4,
+					USHRT_MAX));
+	pSMB->req.MaxMpxCount = cpu_to_le16(server->maxReq);
+	pSMB->req.VcNumber = cpu_to_le16(1);
+	pSMB->req.SessionKey = server->session_key_id;
+
+	/* Now no need to set SMBFLG_CASELESS or obsolete CANONICAL PATH */
+
+	/* BB verify whether signing required on neg or just auth frame (and NTLM case) */
+
+	capabilities = CAP_LARGE_FILES | CAP_NT_SMBS | CAP_LEVEL_II_OPLOCKS |
+			CAP_LARGE_WRITE_X | CAP_LARGE_READ_X;
+
+	if (server->sign)
+		pSMB->req.hdr.Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
+
+	if (ses->capabilities & CAP_UNICODE) {
+		pSMB->req.hdr.Flags2 |= SMBFLG2_UNICODE;
+		capabilities |= CAP_UNICODE;
+	}
+	if (ses->capabilities & CAP_STATUS32) {
+		pSMB->req.hdr.Flags2 |= SMBFLG2_ERR_STATUS;
+		capabilities |= CAP_STATUS32;
+	}
+	if (ses->capabilities & CAP_DFS) {
+		pSMB->req.hdr.Flags2 |= SMBFLG2_DFS;
+		capabilities |= CAP_DFS;
+	}
+	if (ses->capabilities & CAP_UNIX)
+		capabilities |= CAP_UNIX;
+
+	return capabilities;
+}
+
+static void
+unicode_oslm_strings(char **pbcc_area, const struct nls_table *nls_cp)
+{
+	char *bcc_ptr = *pbcc_area;
+	int bytes_ret = 0;
+
+	/* Copy OS version */
+	bytes_ret = cifs_strtoUTF16((__le16 *)bcc_ptr, "Linux version ", 32,
+				    nls_cp);
+	bcc_ptr += 2 * bytes_ret;
+	bytes_ret = cifs_strtoUTF16((__le16 *) bcc_ptr, init_utsname()->release,
+				    32, nls_cp);
+	bcc_ptr += 2 * bytes_ret;
+	bcc_ptr += 2; /* trailing null */
+
+	bytes_ret = cifs_strtoUTF16((__le16 *) bcc_ptr, CIFS_NETWORK_OPSYS,
+				    32, nls_cp);
+	bcc_ptr += 2 * bytes_ret;
+	bcc_ptr += 2; /* trailing null */
+
+	*pbcc_area = bcc_ptr;
+}
+
+static void
+ascii_oslm_strings(char **pbcc_area, const struct nls_table *nls_cp)
+{
+	char *bcc_ptr = *pbcc_area;
+
+	strcpy(bcc_ptr, "Linux version ");
+	bcc_ptr += strlen("Linux version ");
+	strcpy(bcc_ptr, init_utsname()->release);
+	bcc_ptr += strlen(init_utsname()->release) + 1;
+
+	strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
+	bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
+
+	*pbcc_area = bcc_ptr;
+}
+
+static void unicode_domain_string(char **pbcc_area, struct cifs_ses *ses,
+				   const struct nls_table *nls_cp)
+{
+	char *bcc_ptr = *pbcc_area;
+	int bytes_ret = 0;
+
+	/* copy domain */
+	if (ses->domainName == NULL) {
+		/*
+		 * Sending null domain better than using a bogus domain name (as
+		 * we did briefly in 2.6.18) since server will use its default
+		 */
+		*bcc_ptr = 0;
+		*(bcc_ptr+1) = 0;
+		bytes_ret = 0;
+	} else
+		bytes_ret = cifs_strtoUTF16((__le16 *) bcc_ptr, ses->domainName,
+					    CIFS_MAX_DOMAINNAME_LEN, nls_cp);
+	bcc_ptr += 2 * bytes_ret;
+	bcc_ptr += 2;  /* account for null terminator */
+
+	*pbcc_area = bcc_ptr;
+}
+
+static void ascii_domain_string(char **pbcc_area, struct cifs_ses *ses,
+				const struct nls_table *nls_cp)
+{
+	char *bcc_ptr = *pbcc_area;
+	int len;
+
+	/* copy domain */
+	if (ses->domainName != NULL) {
+		len = strscpy(bcc_ptr, ses->domainName, CIFS_MAX_DOMAINNAME_LEN);
+		if (WARN_ON_ONCE(len < 0))
+			len = CIFS_MAX_DOMAINNAME_LEN - 1;
+		bcc_ptr += len;
+	} /* else we send a null domain name so server will default to its own domain */
+	*bcc_ptr = 0;
+	bcc_ptr++;
+
+	*pbcc_area = bcc_ptr;
+}
+
+static void unicode_ssetup_strings(char **pbcc_area, struct cifs_ses *ses,
+				   const struct nls_table *nls_cp)
+{
+	char *bcc_ptr = *pbcc_area;
+	int bytes_ret = 0;
+
+	/* BB FIXME add check that strings less than 335 or will need to send as arrays */
+
+	/* copy user */
+	if (ses->user_name == NULL) {
+		/* null user mount */
+		*bcc_ptr = 0;
+		*(bcc_ptr+1) = 0;
+	} else {
+		bytes_ret = cifs_strtoUTF16((__le16 *) bcc_ptr, ses->user_name,
+					    CIFS_MAX_USERNAME_LEN, nls_cp);
+	}
+	bcc_ptr += 2 * bytes_ret;
+	bcc_ptr += 2; /* account for null termination */
+
+	unicode_domain_string(&bcc_ptr, ses, nls_cp);
+	unicode_oslm_strings(&bcc_ptr, nls_cp);
+
+	*pbcc_area = bcc_ptr;
+}
+
+static void ascii_ssetup_strings(char **pbcc_area, struct cifs_ses *ses,
+				 const struct nls_table *nls_cp)
+{
+	char *bcc_ptr = *pbcc_area;
+	int len;
+
+	/* copy user */
+	/* BB what about null user mounts - check that we do this BB */
+	/* copy user */
+	if (ses->user_name != NULL) {
+		len = strscpy(bcc_ptr, ses->user_name, CIFS_MAX_USERNAME_LEN);
+		if (WARN_ON_ONCE(len < 0))
+			len = CIFS_MAX_USERNAME_LEN - 1;
+		bcc_ptr += len;
+	}
+	/* else null user mount */
+	*bcc_ptr = 0;
+	bcc_ptr++; /* account for null termination */
+
+	/* BB check for overflow here */
+
+	ascii_domain_string(&bcc_ptr, ses, nls_cp);
+	ascii_oslm_strings(&bcc_ptr, nls_cp);
+
+	*pbcc_area = bcc_ptr;
+}
+
+static void
+decode_unicode_ssetup(char **pbcc_area, int bleft, struct cifs_ses *ses,
+		      const struct nls_table *nls_cp)
+{
+	int len;
+	char *data = *pbcc_area;
+
+	cifs_dbg(FYI, "bleft %d\n", bleft);
+
+	kfree(ses->serverOS);
+	ses->serverOS = cifs_strndup_from_utf16(data, bleft, true, nls_cp);
+	cifs_dbg(FYI, "serverOS=%s\n", ses->serverOS);
+	len = (UniStrnlen((wchar_t *) data, bleft / 2) * 2) + 2;
+	data += len;
+	bleft -= len;
+	if (bleft <= 0)
+		return;
+
+	kfree(ses->serverNOS);
+	ses->serverNOS = cifs_strndup_from_utf16(data, bleft, true, nls_cp);
+	cifs_dbg(FYI, "serverNOS=%s\n", ses->serverNOS);
+	len = (UniStrnlen((wchar_t *) data, bleft / 2) * 2) + 2;
+	data += len;
+	bleft -= len;
+	if (bleft <= 0)
+		return;
+
+	kfree(ses->serverDomain);
+	ses->serverDomain = cifs_strndup_from_utf16(data, bleft, true, nls_cp);
+	cifs_dbg(FYI, "serverDomain=%s\n", ses->serverDomain);
+
+	return;
+}
+
+static void decode_ascii_ssetup(char **pbcc_area, __u16 bleft,
+				struct cifs_ses *ses,
+				const struct nls_table *nls_cp)
+{
+	int len;
+	char *bcc_ptr = *pbcc_area;
+
+	cifs_dbg(FYI, "decode sessetup ascii. bleft %d\n", bleft);
+
+	len = strnlen(bcc_ptr, bleft);
+	if (len >= bleft)
+		return;
+
+	kfree(ses->serverOS);
+
+	ses->serverOS = kmalloc(len + 1, GFP_KERNEL);
+	if (ses->serverOS) {
+		memcpy(ses->serverOS, bcc_ptr, len);
+		ses->serverOS[len] = 0;
+		if (strncmp(ses->serverOS, "OS/2", 4) == 0)
+			cifs_dbg(FYI, "OS/2 server\n");
+	}
+
+	bcc_ptr += len + 1;
+	bleft -= len + 1;
+
+	len = strnlen(bcc_ptr, bleft);
+	if (len >= bleft)
+		return;
+
+	kfree(ses->serverNOS);
+
+	ses->serverNOS = kmalloc(len + 1, GFP_KERNEL);
+	if (ses->serverNOS) {
+		memcpy(ses->serverNOS, bcc_ptr, len);
+		ses->serverNOS[len] = 0;
+	}
+
+	bcc_ptr += len + 1;
+	bleft -= len + 1;
+
+	len = strnlen(bcc_ptr, bleft);
+	if (len > bleft)
+		return;
+
+	/*
+	 * No domain field in LANMAN case. Domain is
+	 * returned by old servers in the SMB negprot response
+	 *
+	 * BB For newer servers which do not support Unicode,
+	 * but thus do return domain here, we could add parsing
+	 * for it later, but it is not very important
+	 */
+	cifs_dbg(FYI, "ascii: bytes left %d\n", bleft);
+}
+
+static int
+sess_alloc_buffer(struct sess_data *sess_data, int wct)
+{
+	int rc;
+	struct cifs_ses *ses = sess_data->ses;
+	struct smb_hdr *smb_buf;
+
+	rc = small_smb_init_no_tc(SMB_COM_SESSION_SETUP_ANDX, wct, ses,
+				  (void **)&smb_buf);
+
+	if (rc < 0)
+		return rc;
+
+	sess_data->in_len = rc;
+	sess_data->iov[0].iov_base = (char *)smb_buf;
+	sess_data->iov[0].iov_len = sess_data->in_len;
+	/*
+	 * This variable will be used to clear the buffer
+	 * allocated above in case of any error in the calling function.
+	 */
+	sess_data->buf0_type = CIFS_SMALL_BUFFER;
+
+	/* 2000 big enough to fit max user, domain, NOS name etc. */
+	sess_data->iov[2].iov_base = kmalloc(2000, GFP_KERNEL);
+	if (!sess_data->iov[2].iov_base) {
+		rc = -ENOMEM;
+		goto out_free_smb_buf;
+	}
+
+	return 0;
+
+out_free_smb_buf:
+	cifs_small_buf_release(smb_buf);
+	sess_data->iov[0].iov_base = NULL;
+	sess_data->iov[0].iov_len = 0;
+	sess_data->buf0_type = CIFS_NO_BUFFER;
+	return rc;
+}
+
+static void
+sess_free_buffer(struct sess_data *sess_data)
+{
+	struct kvec *iov = sess_data->iov;
+
+	/*
+	 * Zero the session data before freeing, as it might contain sensitive info (keys, etc).
+	 * Note that iov[1] is already freed by caller.
+	 */
+	if (sess_data->buf0_type != CIFS_NO_BUFFER && iov[0].iov_base)
+		memzero_explicit(iov[0].iov_base, iov[0].iov_len);
+
+	free_rsp_buf(sess_data->buf0_type, iov[0].iov_base);
+	sess_data->buf0_type = CIFS_NO_BUFFER;
+	kfree_sensitive(iov[2].iov_base);
+}
+
+static int
+sess_establish_session(struct sess_data *sess_data)
+{
+	struct cifs_ses *ses = sess_data->ses;
+	struct TCP_Server_Info *server = sess_data->server;
+
+	cifs_server_lock(server);
+	if (!server->session_estab) {
+		if (server->sign) {
+			server->session_key.response =
+				kmemdup(ses->auth_key.response,
+				ses->auth_key.len, GFP_KERNEL);
+			if (!server->session_key.response) {
+				cifs_server_unlock(server);
+				return -ENOMEM;
+			}
+			server->session_key.len =
+						ses->auth_key.len;
+		}
+		server->sequence_number = 0x2;
+		server->session_estab = true;
+	}
+	cifs_server_unlock(server);
+
+	cifs_dbg(FYI, "CIFS session established successfully\n");
+	return 0;
+}
+
+static int
+sess_sendreceive(struct sess_data *sess_data)
+{
+	int rc;
+	struct smb_hdr *smb_buf = (struct smb_hdr *) sess_data->iov[0].iov_base;
+	__u16 count;
+	struct kvec rsp_iov = { NULL, 0 };
+
+	count = sess_data->iov[1].iov_len + sess_data->iov[2].iov_len;
+	sess_data->in_len += count;
+	put_bcc(count, smb_buf);
+
+	rc = SendReceive2(sess_data->xid, sess_data->ses,
+			  sess_data->iov, 3 /* num_iovecs */,
+			  &sess_data->buf0_type,
+			  CIFS_LOG_ERROR, &rsp_iov);
+	cifs_small_buf_release(sess_data->iov[0].iov_base);
+	memcpy(&sess_data->iov[0], &rsp_iov, sizeof(struct kvec));
+
+	return rc;
+}
+
+static void
+sess_auth_ntlmv2(struct sess_data *sess_data)
+{
+	int rc = 0;
+	struct smb_hdr *smb_buf;
+	SESSION_SETUP_ANDX *pSMB;
+	char *bcc_ptr;
+	struct cifs_ses *ses = sess_data->ses;
+	struct TCP_Server_Info *server = sess_data->server;
+	__u32 capabilities;
+	__u16 bytes_remaining;
+
+	/* old style NTLM sessionsetup */
+	/* wct = 13 */
+	rc = sess_alloc_buffer(sess_data, 13);
+	if (rc)
+		goto out;
+
+	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
+	bcc_ptr = sess_data->iov[2].iov_base;
+	capabilities = cifs_ssetup_hdr(ses, server, pSMB);
+
+	pSMB->req_no_secext.Capabilities = cpu_to_le32(capabilities);
+
+	/* LM2 password would be here if we supported it */
+	pSMB->req_no_secext.CaseInsensitivePasswordLength = 0;
+
+	if (ses->user_name != NULL) {
+		/* calculate nlmv2 response and session key */
+		rc = setup_ntlmv2_rsp(ses, sess_data->nls_cp);
+		if (rc) {
+			cifs_dbg(VFS, "Error %d during NTLMv2 authentication\n", rc);
+			goto out;
+		}
+
+		memcpy(bcc_ptr, ses->auth_key.response + CIFS_SESS_KEY_SIZE,
+				ses->auth_key.len - CIFS_SESS_KEY_SIZE);
+		bcc_ptr += ses->auth_key.len - CIFS_SESS_KEY_SIZE;
+
+		/* set case sensitive password length after tilen may get
+		 * assigned, tilen is 0 otherwise.
+		 */
+		pSMB->req_no_secext.CaseSensitivePasswordLength =
+			cpu_to_le16(ses->auth_key.len - CIFS_SESS_KEY_SIZE);
+	} else {
+		pSMB->req_no_secext.CaseSensitivePasswordLength = 0;
+	}
+
+	if (ses->capabilities & CAP_UNICODE) {
+		if (!IS_ALIGNED(sess_data->iov[0].iov_len, 2)) {
+			*bcc_ptr = 0;
+			bcc_ptr++;
+		}
+		unicode_ssetup_strings(&bcc_ptr, ses, sess_data->nls_cp);
+	} else {
+		ascii_ssetup_strings(&bcc_ptr, ses, sess_data->nls_cp);
+	}
+
+
+	sess_data->iov[2].iov_len = (long) bcc_ptr -
+			(long) sess_data->iov[2].iov_base;
+
+	rc = sess_sendreceive(sess_data);
+	if (rc)
+		goto out;
+
+	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
+	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
+
+	if (smb_buf->WordCount != 3) {
+		rc = smb_EIO1(smb_eio_trace_sess_nl2_wcc, smb_buf->WordCount);
+		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
+		goto out;
+	}
+
+	if (le16_to_cpu(pSMB->resp.Action) & GUEST_LOGIN)
+		cifs_dbg(FYI, "Guest login\n"); /* BB mark SesInfo struct? */
+
+	ses->Suid = smb_buf->Uid;   /* UID left in wire format (le) */
+	cifs_dbg(FYI, "UID = %llu\n", ses->Suid);
+
+	bytes_remaining = get_bcc(smb_buf);
+	bcc_ptr = pByteArea(smb_buf);
+
+	/* BB check if Unicode and decode strings */
+	if (bytes_remaining == 0) {
+		/* no string area to decode, do nothing */
+	} else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
+		/* unicode string area must be word-aligned */
+		if (!IS_ALIGNED((unsigned long)bcc_ptr - (unsigned long)smb_buf, 2)) {
+			++bcc_ptr;
+			--bytes_remaining;
+		}
+		decode_unicode_ssetup(&bcc_ptr, bytes_remaining, ses,
+				      sess_data->nls_cp);
+	} else {
+		decode_ascii_ssetup(&bcc_ptr, bytes_remaining, ses,
+				    sess_data->nls_cp);
+	}
+
+	rc = sess_establish_session(sess_data);
+out:
+	sess_data->result = rc;
+	sess_data->func = NULL;
+	sess_free_buffer(sess_data);
+	kfree_sensitive(ses->auth_key.response);
+	ses->auth_key.response = NULL;
+}
+
+#ifdef CONFIG_CIFS_UPCALL
+static void
+sess_auth_kerberos(struct sess_data *sess_data)
+{
+	int rc = 0;
+	struct smb_hdr *smb_buf;
+	SESSION_SETUP_ANDX *pSMB;
+	char *bcc_ptr;
+	struct cifs_ses *ses = sess_data->ses;
+	struct TCP_Server_Info *server = sess_data->server;
+	__u32 capabilities;
+	__u16 bytes_remaining;
+	struct key *spnego_key = NULL;
+	struct cifs_spnego_msg *msg;
+	u16 blob_len;
+
+	/* extended security */
+	/* wct = 12 */
+	rc = sess_alloc_buffer(sess_data, 12);
+	if (rc)
+		goto out;
+
+	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
+	bcc_ptr = sess_data->iov[2].iov_base;
+	capabilities = cifs_ssetup_hdr(ses, server, pSMB);
+
+	spnego_key = cifs_get_spnego_key(ses, server);
+	if (IS_ERR(spnego_key)) {
+		rc = PTR_ERR(spnego_key);
+		spnego_key = NULL;
+		goto out;
+	}
+
+	msg = spnego_key->payload.data[0];
+	/*
+	 * check version field to make sure that cifs.upcall is
+	 * sending us a response in an expected form
+	 */
+	if (msg->version != CIFS_SPNEGO_UPCALL_VERSION) {
+		cifs_dbg(VFS, "incorrect version of cifs.upcall (expected %d but got %d)\n",
+			 CIFS_SPNEGO_UPCALL_VERSION, msg->version);
+		rc = -EKEYREJECTED;
+		goto out_put_spnego_key;
+	}
+
+	kfree_sensitive(ses->auth_key.response);
+	ses->auth_key.response = kmemdup(msg->data, msg->sesskey_len,
+					 GFP_KERNEL);
+	if (!ses->auth_key.response) {
+		cifs_dbg(VFS, "Kerberos can't allocate (%u bytes) memory\n",
+			 msg->sesskey_len);
+		rc = -ENOMEM;
+		goto out_put_spnego_key;
+	}
+	ses->auth_key.len = msg->sesskey_len;
+
+	pSMB->req.hdr.Flags2 |= SMBFLG2_EXT_SEC;
+	capabilities |= CAP_EXTENDED_SECURITY;
+	pSMB->req.Capabilities = cpu_to_le32(capabilities);
+	sess_data->iov[1].iov_base = msg->data + msg->sesskey_len;
+	sess_data->iov[1].iov_len = msg->secblob_len;
+	pSMB->req.SecurityBlobLength = cpu_to_le16(sess_data->iov[1].iov_len);
+
+	if (pSMB->req.hdr.Flags2 & SMBFLG2_UNICODE) {
+		/* unicode strings must be word aligned */
+		if (!IS_ALIGNED(sess_data->iov[0].iov_len + sess_data->iov[1].iov_len, 2)) {
+			*bcc_ptr = 0;
+			bcc_ptr++;
+		}
+		unicode_oslm_strings(&bcc_ptr, sess_data->nls_cp);
+		unicode_domain_string(&bcc_ptr, ses, sess_data->nls_cp);
+	} else {
+		ascii_oslm_strings(&bcc_ptr, sess_data->nls_cp);
+		ascii_domain_string(&bcc_ptr, ses, sess_data->nls_cp);
+	}
+
+	sess_data->iov[2].iov_len = (long) bcc_ptr -
+			(long) sess_data->iov[2].iov_base;
+
+	rc = sess_sendreceive(sess_data);
+	if (rc)
+		goto out_put_spnego_key;
+
+	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
+	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
+
+	if (smb_buf->WordCount != 4) {
+		rc = smb_EIO1(smb_eio_trace_sess_krb_wcc, smb_buf->WordCount);
+		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
+		goto out_put_spnego_key;
+	}
+
+	if (le16_to_cpu(pSMB->resp.Action) & GUEST_LOGIN)
+		cifs_dbg(FYI, "Guest login\n"); /* BB mark SesInfo struct? */
+
+	ses->Suid = smb_buf->Uid;   /* UID left in wire format (le) */
+	cifs_dbg(FYI, "UID = %llu\n", ses->Suid);
+
+	bytes_remaining = get_bcc(smb_buf);
+	bcc_ptr = pByteArea(smb_buf);
+
+	blob_len = le16_to_cpu(pSMB->resp.SecurityBlobLength);
+	if (blob_len > bytes_remaining) {
+		cifs_dbg(VFS, "bad security blob length %d\n",
+				blob_len);
+		rc = -EINVAL;
+		goto out_put_spnego_key;
+	}
+	bcc_ptr += blob_len;
+	bytes_remaining -= blob_len;
+
+	/* BB check if Unicode and decode strings */
+	if (bytes_remaining == 0) {
+		/* no string area to decode, do nothing */
+	} else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
+		/* unicode string area must be word-aligned */
+		if (!IS_ALIGNED((unsigned long)bcc_ptr - (unsigned long)smb_buf, 2)) {
+			++bcc_ptr;
+			--bytes_remaining;
+		}
+		decode_unicode_ssetup(&bcc_ptr, bytes_remaining, ses,
+				      sess_data->nls_cp);
+	} else {
+		decode_ascii_ssetup(&bcc_ptr, bytes_remaining, ses,
+				    sess_data->nls_cp);
+	}
+
+	rc = sess_establish_session(sess_data);
+out_put_spnego_key:
+	key_invalidate(spnego_key);
+	key_put(spnego_key);
+out:
+	sess_data->result = rc;
+	sess_data->func = NULL;
+	sess_free_buffer(sess_data);
+	kfree_sensitive(ses->auth_key.response);
+	ses->auth_key.response = NULL;
+}
+
+#endif /* ! CONFIG_CIFS_UPCALL */
+
+/*
+ * The required kvec buffers have to be allocated before calling this
+ * function.
+ */
+static int
+_sess_auth_rawntlmssp_assemble_req(struct sess_data *sess_data)
+{
+	SESSION_SETUP_ANDX *pSMB;
+	struct cifs_ses *ses = sess_data->ses;
+	struct TCP_Server_Info *server = sess_data->server;
+	__u32 capabilities;
+	char *bcc_ptr;
+
+	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
+
+	capabilities = cifs_ssetup_hdr(ses, server, pSMB);
+	pSMB->req.hdr.Flags2 |= SMBFLG2_EXT_SEC;
+	capabilities |= CAP_EXTENDED_SECURITY;
+	pSMB->req.Capabilities |= cpu_to_le32(capabilities);
+
+	bcc_ptr = sess_data->iov[2].iov_base;
+
+	if (pSMB->req.hdr.Flags2 & SMBFLG2_UNICODE) {
+		/* unicode strings must be word aligned */
+		if (!IS_ALIGNED(sess_data->iov[0].iov_len + sess_data->iov[1].iov_len, 2)) {
+			*bcc_ptr = 0;
+			bcc_ptr++;
+		}
+		unicode_oslm_strings(&bcc_ptr, sess_data->nls_cp);
+	} else {
+		ascii_oslm_strings(&bcc_ptr, sess_data->nls_cp);
+	}
+
+	sess_data->iov[2].iov_len = (long) bcc_ptr -
+					(long) sess_data->iov[2].iov_base;
+
+	return 0;
+}
+
+static void
+sess_auth_rawntlmssp_authenticate(struct sess_data *sess_data);
+
+static void
+sess_auth_rawntlmssp_negotiate(struct sess_data *sess_data)
+{
+	int rc;
+	struct smb_hdr *smb_buf;
+	SESSION_SETUP_ANDX *pSMB;
+	struct cifs_ses *ses = sess_data->ses;
+	struct TCP_Server_Info *server = sess_data->server;
+	__u16 bytes_remaining;
+	char *bcc_ptr;
+	unsigned char *ntlmsspblob = NULL;
+	u16 blob_len;
+
+	cifs_dbg(FYI, "rawntlmssp session setup negotiate phase\n");
+
+	/*
+	 * if memory allocation is successful, caller of this function
+	 * frees it.
+	 */
+	ses->ntlmssp = kmalloc(sizeof(struct ntlmssp_auth), GFP_KERNEL);
+	if (!ses->ntlmssp) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	ses->ntlmssp->sesskey_per_smbsess = false;
+
+	/* wct = 12 */
+	rc = sess_alloc_buffer(sess_data, 12);
+	if (rc)
+		goto out;
+
+	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
+
+	/* Build security blob before we assemble the request */
+	rc = build_ntlmssp_negotiate_blob(&ntlmsspblob,
+				     &blob_len, ses, server,
+				     sess_data->nls_cp);
+	if (rc)
+		goto out_free_ntlmsspblob;
+
+	sess_data->iov[1].iov_len = blob_len;
+	sess_data->iov[1].iov_base = ntlmsspblob;
+	pSMB->req.SecurityBlobLength = cpu_to_le16(blob_len);
+
+	rc = _sess_auth_rawntlmssp_assemble_req(sess_data);
+	if (rc)
+		goto out_free_ntlmsspblob;
+
+	rc = sess_sendreceive(sess_data);
+
+	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
+	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
+
+	/* If true, rc here is expected and not an error */
+	if (sess_data->buf0_type != CIFS_NO_BUFFER &&
+	    smb_buf->Status.CifsError ==
+			cpu_to_le32(NT_STATUS_MORE_PROCESSING_REQUIRED))
+		rc = 0;
+
+	if (rc)
+		goto out_free_ntlmsspblob;
+
+	cifs_dbg(FYI, "rawntlmssp session setup challenge phase\n");
+
+	if (smb_buf->WordCount != 4) {
+		rc = smb_EIO1(smb_eio_trace_sess_rawnl_neg_wcc, smb_buf->WordCount);
+		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
+		goto out_free_ntlmsspblob;
+	}
+
+	ses->Suid = smb_buf->Uid;   /* UID left in wire format (le) */
+	cifs_dbg(FYI, "UID = %llu\n", ses->Suid);
+
+	bytes_remaining = get_bcc(smb_buf);
+	bcc_ptr = pByteArea(smb_buf);
+
+	blob_len = le16_to_cpu(pSMB->resp.SecurityBlobLength);
+	if (blob_len > bytes_remaining) {
+		cifs_dbg(VFS, "bad security blob length %d\n",
+				blob_len);
+		rc = -EINVAL;
+		goto out_free_ntlmsspblob;
+	}
+
+	rc = decode_ntlmssp_challenge(bcc_ptr, blob_len, ses);
+
+out_free_ntlmsspblob:
+	kfree_sensitive(ntlmsspblob);
+out:
+	sess_free_buffer(sess_data);
+
+	if (!rc) {
+		sess_data->func = sess_auth_rawntlmssp_authenticate;
+		return;
+	}
+
+	/* Else error. Cleanup */
+	kfree_sensitive(ses->auth_key.response);
+	ses->auth_key.response = NULL;
+	kfree_sensitive(ses->ntlmssp);
+	ses->ntlmssp = NULL;
+
+	sess_data->func = NULL;
+	sess_data->result = rc;
+}
+
+static void
+sess_auth_rawntlmssp_authenticate(struct sess_data *sess_data)
+{
+	int rc;
+	struct smb_hdr *smb_buf;
+	SESSION_SETUP_ANDX *pSMB;
+	struct cifs_ses *ses = sess_data->ses;
+	struct TCP_Server_Info *server = sess_data->server;
+	__u16 bytes_remaining;
+	char *bcc_ptr;
+	unsigned char *ntlmsspblob = NULL;
+	u16 blob_len;
+
+	cifs_dbg(FYI, "rawntlmssp session setup authenticate phase\n");
+
+	/* wct = 12 */
+	rc = sess_alloc_buffer(sess_data, 12);
+	if (rc)
+		goto out;
+
+	/* Build security blob before we assemble the request */
+	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
+	smb_buf = (struct smb_hdr *)pSMB;
+	rc = build_ntlmssp_auth_blob(&ntlmsspblob,
+					&blob_len, ses, server,
+					sess_data->nls_cp);
+	if (rc)
+		goto out_free_ntlmsspblob;
+	sess_data->iov[1].iov_len = blob_len;
+	sess_data->iov[1].iov_base = ntlmsspblob;
+	pSMB->req.SecurityBlobLength = cpu_to_le16(blob_len);
+	/*
+	 * Make sure that we tell the server that we are using
+	 * the uid that it just gave us back on the response
+	 * (challenge)
+	 */
+	smb_buf->Uid = ses->Suid;
+
+	rc = _sess_auth_rawntlmssp_assemble_req(sess_data);
+	if (rc)
+		goto out_free_ntlmsspblob;
+
+	rc = sess_sendreceive(sess_data);
+	if (rc)
+		goto out_free_ntlmsspblob;
+
+	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
+	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
+	if (smb_buf->WordCount != 4) {
+		rc = smb_EIO1(smb_eio_trace_sess_rawnl_auth_wcc, smb_buf->WordCount);
+		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
+		goto out_free_ntlmsspblob;
+	}
+
+	if (le16_to_cpu(pSMB->resp.Action) & GUEST_LOGIN)
+		cifs_dbg(FYI, "Guest login\n"); /* BB mark SesInfo struct? */
+
+	if (ses->Suid != smb_buf->Uid) {
+		ses->Suid = smb_buf->Uid;
+		cifs_dbg(FYI, "UID changed! new UID = %llu\n", ses->Suid);
+	}
+
+	bytes_remaining = get_bcc(smb_buf);
+	bcc_ptr = pByteArea(smb_buf);
+	blob_len = le16_to_cpu(pSMB->resp.SecurityBlobLength);
+	if (blob_len > bytes_remaining) {
+		cifs_dbg(VFS, "bad security blob length %d\n",
+				blob_len);
+		rc = -EINVAL;
+		goto out_free_ntlmsspblob;
+	}
+	bcc_ptr += blob_len;
+	bytes_remaining -= blob_len;
+
+
+	/* BB check if Unicode and decode strings */
+	if (bytes_remaining == 0) {
+		/* no string area to decode, do nothing */
+	} else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
+		/* unicode string area must be word-aligned */
+		if (!IS_ALIGNED((unsigned long)bcc_ptr - (unsigned long)smb_buf, 2)) {
+			++bcc_ptr;
+			--bytes_remaining;
+		}
+		decode_unicode_ssetup(&bcc_ptr, bytes_remaining, ses,
+				      sess_data->nls_cp);
+	} else {
+		decode_ascii_ssetup(&bcc_ptr, bytes_remaining, ses,
+				    sess_data->nls_cp);
+	}
+
+out_free_ntlmsspblob:
+	kfree_sensitive(ntlmsspblob);
+out:
+	sess_free_buffer(sess_data);
+
+	if (!rc)
+		rc = sess_establish_session(sess_data);
+
+	/* Cleanup */
+	kfree_sensitive(ses->auth_key.response);
+	ses->auth_key.response = NULL;
+	kfree_sensitive(ses->ntlmssp);
+	ses->ntlmssp = NULL;
+
+	sess_data->func = NULL;
+	sess_data->result = rc;
+}
+
+static int select_sec(struct sess_data *sess_data)
+{
+	int type;
+	struct cifs_ses *ses = sess_data->ses;
+	struct TCP_Server_Info *server = sess_data->server;
+
+	type = cifs_select_sectype(server, ses->sectype);
+	cifs_dbg(FYI, "sess setup type %d\n", type);
+	if (type == Unspecified) {
+		cifs_dbg(VFS, "Unable to select appropriate authentication method!\n");
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case NTLMv2:
+		sess_data->func = sess_auth_ntlmv2;
+		break;
+	case Kerberos:
+#ifdef CONFIG_CIFS_UPCALL
+		sess_data->func = sess_auth_kerberos;
+		break;
+#else
+		cifs_dbg(VFS, "Kerberos negotiated but upcall support disabled!\n");
+		return -ENOSYS;
+#endif /* CONFIG_CIFS_UPCALL */
+	case RawNTLMSSP:
+		sess_data->func = sess_auth_rawntlmssp_negotiate;
+		break;
+	default:
+		cifs_dbg(VFS, "secType %d not supported!\n", type);
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
+int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
+		   struct TCP_Server_Info *server,
+		   const struct nls_table *nls_cp)
+{
+	int rc = 0;
+	struct sess_data *sess_data;
+
+	if (ses == NULL) {
+		WARN(1, "%s: ses == NULL!", __func__);
+		return -EINVAL;
+	}
+
+	sess_data = kzalloc(sizeof(struct sess_data), GFP_KERNEL);
+	if (!sess_data)
+		return -ENOMEM;
+
+	sess_data->xid = xid;
+	sess_data->ses = ses;
+	sess_data->server = server;
+	sess_data->buf0_type = CIFS_NO_BUFFER;
+	sess_data->nls_cp = (struct nls_table *) nls_cp;
+
+	rc = select_sec(sess_data);
+	if (rc)
+		goto out;
+
+	while (sess_data->func)
+		sess_data->func(sess_data);
+
+	/* Store result before we free sess_data */
+	rc = sess_data->result;
+
+out:
+	kfree_sensitive(sess_data);
+	return rc;
+}


