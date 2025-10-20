Return-Path: <linux-fsdevel+bounces-64682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92902BF0F2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AEC54E7C39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DA53043C4;
	Mon, 20 Oct 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWweumay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B12F7AD7
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961384; cv=none; b=ioosub5GBBd6ms5GQJLpW7+F/rNIvXlwyqS241W6m0w4mvfuxix0BALIsMgQP40eu2k540FAKmOeNr8tjTxGxRRK7dJO5T55nHiXoat3toaUpB7bBCnneAym0B73pASASl4aesFRuFPyVozsJnhiVVlG9mZPQOpavdX42BlYfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961384; c=relaxed/simple;
	bh=/thsdxnpKRmIAOfuIpSH5cvifzDKhf8lk4A3cZdWsAI=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=RVe6/VrB+AvSzCrEDcqpvD9+fNIPS01XKmdRp075zN7uG6TNz9Gi4f7i8+MosdsEny2NZwPOjS0knpqttCMQykFeyyH8jmhUDQUqniT1OxHRIng9r7/2AO+k3QinEkkAubXvLz0CCx9+SQ2jC1CgDxDjJRGvzSz54v2+vjjMVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWweumay; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760961380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HIK1mI79hxAHpXyxTMFMhPb+0wM8sYw+VEGXupPQppw=;
	b=dWweumayF+6fzKKSMefCnbcAW9V3UXy6+3qEZZWyVUa/8StPi1ek9sz8JMReCTDm2iCsoq
	60s0I+c6R3fmkrjJ77N4+PkbxphmnBpKkThRCaHZ69ZO93dokgsMf/PnTZmrpFkbLuWMMS
	b79iRJ2bHJw/bNSoWrX9uFZgloYOgNw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-O0-B5uklMuaAyjurTxcAqw-1; Mon,
 20 Oct 2025 07:56:19 -0400
X-MC-Unique: O0-B5uklMuaAyjurTxcAqw-1
X-Mimecast-MFC-AGG-ID: O0-B5uklMuaAyjurTxcAqw_1760961378
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43D7918001D1;
	Mon, 20 Oct 2025 11:56:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4665180044F;
	Mon, 20 Oct 2025 11:56:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Call the calc_signature functions directly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1090389.1760961374.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Oct 2025 12:56:15 +0100
Message-ID: <1090391.1760961375@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

As the SMB1 and SMB2/3 calc_signature functions are called from separate
sign and verify paths, just call them directly rather than using a functio=
n
pointer.  The SMB3 calc_signature then jumps to the SMB2 variant if
necessary.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h      |    2 --
 fs/smb/client/smb2ops.c       |    4 ----
 fs/smb/client/smb2proto.h     |    6 ------
 fs/smb/client/smb2transport.c |   18 +++++++++---------
 4 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index b91397dbb6aa..7297f0f01cb3 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -536,8 +536,6 @@ struct smb_version_operations {
 	void (*new_lease_key)(struct cifs_fid *);
 	int (*generate_signingkey)(struct cifs_ses *ses,
 				   struct TCP_Server_Info *server);
-	int (*calc_signature)(struct smb_rqst *, struct TCP_Server_Info *,
-				bool allocate_crypto);
 	int (*set_integrity)(const unsigned int, struct cifs_tcon *tcon,
 			     struct cifsFileInfo *src_file);
 	int (*enum_snapshots)(const unsigned int xid, struct cifs_tcon *tcon,
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7c392cf5940b..66eee3440df6 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5446,7 +5446,6 @@ struct smb_version_operations smb20_operations =3D {
 	.get_lease_key =3D smb2_get_lease_key,
 	.set_lease_key =3D smb2_set_lease_key,
 	.new_lease_key =3D smb2_new_lease_key,
-	.calc_signature =3D smb2_calc_signature,
 	.is_read_op =3D smb2_is_read_op,
 	.set_oplock_level =3D smb2_set_oplock_level,
 	.create_lease_buf =3D smb2_create_lease_buf,
@@ -5550,7 +5549,6 @@ struct smb_version_operations smb21_operations =3D {
 	.get_lease_key =3D smb2_get_lease_key,
 	.set_lease_key =3D smb2_set_lease_key,
 	.new_lease_key =3D smb2_new_lease_key,
-	.calc_signature =3D smb2_calc_signature,
 	.is_read_op =3D smb21_is_read_op,
 	.set_oplock_level =3D smb21_set_oplock_level,
 	.create_lease_buf =3D smb2_create_lease_buf,
@@ -5660,7 +5658,6 @@ struct smb_version_operations smb30_operations =3D {
 	.set_lease_key =3D smb2_set_lease_key,
 	.new_lease_key =3D smb2_new_lease_key,
 	.generate_signingkey =3D generate_smb30signingkey,
-	.calc_signature =3D smb3_calc_signature,
 	.set_integrity  =3D smb3_set_integrity,
 	.is_read_op =3D smb21_is_read_op,
 	.set_oplock_level =3D smb3_set_oplock_level,
@@ -5777,7 +5774,6 @@ struct smb_version_operations smb311_operations =3D =
{
 	.set_lease_key =3D smb2_set_lease_key,
 	.new_lease_key =3D smb2_new_lease_key,
 	.generate_signingkey =3D generate_smb311signingkey,
-	.calc_signature =3D smb3_calc_signature,
 	.set_integrity  =3D smb3_set_integrity,
 	.is_read_op =3D smb21_is_read_op,
 	.set_oplock_level =3D smb3_set_oplock_level,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index b3f1398c9f79..7e98fbe7bf33 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -39,12 +39,6 @@ extern struct mid_q_entry *smb2_setup_async_request(
 			struct TCP_Server_Info *server, struct smb_rqst *rqst);
 extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *serve=
r,
 						__u64 ses_id, __u32  tid);
-extern int smb2_calc_signature(struct smb_rqst *rqst,
-				struct TCP_Server_Info *server,
-				bool allocate_crypto);
-extern int smb3_calc_signature(struct smb_rqst *rqst,
-				struct TCP_Server_Info *server,
-				bool allocate_crypto);
 extern void smb2_echo_request(struct work_struct *work);
 extern __le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
 extern bool smb2_is_valid_oplock_break(char *buffer,
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 33f33013b392..916c131d763d 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -247,9 +247,9 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, __u=
64 ses_id, __u32  tid)
 	return tcon;
 }
 =

-int
+static int
 smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server=
,
-			bool allocate_crypto)
+		    bool allocate_crypto)
 {
 	int rc;
 	unsigned char smb2_signature[SMB2_HMACSHA256_SIZE];
@@ -576,9 +576,9 @@ generate_smb311signingkey(struct cifs_ses *ses,
 	return generate_smb3signingkey(ses, server, &triplet);
 }
 =

-int
+static int
 smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server=
,
-			bool allocate_crypto)
+		    bool allocate_crypto)
 {
 	int rc;
 	unsigned char smb3_signature[SMB2_CMACAES_SIZE];
@@ -589,6 +589,9 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_=
Server_Info *server,
 	struct smb_rqst drqst;
 	u8 key[SMB3_SIGN_KEY_SIZE];
 =

+	if ((server->vals->protocol_id & 0xf00) =3D=3D 0x200)
+		return smb2_calc_signature(rqst, server, allocate_crypto);
+
 	rc =3D smb3_get_sign_key(le64_to_cpu(shdr->SessionId), server, key);
 	if (unlikely(rc)) {
 		cifs_server_dbg(FYI, "%s: Could not get signing key\n", __func__);
@@ -657,7 +660,6 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_=
Server_Info *server,
 static int
 smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 {
-	int rc =3D 0;
 	struct smb2_hdr *shdr;
 	struct smb2_sess_setup_req *ssr;
 	bool is_binding;
@@ -684,9 +686,7 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Serve=
r_Info *server)
 		return 0;
 	}
 =

-	rc =3D server->ops->calc_signature(rqst, server, false);
-
-	return rc;
+	return smb3_calc_signature(rqst, server, false);
 }
 =

 int
@@ -722,7 +722,7 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TC=
P_Server_Info *server)
 =

 	memset(shdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 =

-	rc =3D server->ops->calc_signature(rqst, server, true);
+	rc =3D smb3_calc_signature(rqst, server, true);
 =

 	if (rc)
 		return rc;


