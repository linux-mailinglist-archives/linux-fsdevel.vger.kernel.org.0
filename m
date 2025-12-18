Return-Path: <linux-fsdevel+bounces-71668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBDFCCC5C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 15:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 774EB3091A15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6A3161A3;
	Thu, 18 Dec 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVV6vP1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747B2F0C68
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069354; cv=none; b=crVpEDP+fe5wnLoEKGIMOa9AA4/RwRUBCd3EppmfPe22slnhD1ehcPOy8t0OcZVx/dRfM3GpoQCzRuYKpS+jETPJT2IjWf1eoLvYuAHvCR7f45yoHuu2Hs+rhu4uuU2dQAR386NtVqQs2lEe6NF7dMbcIAxWWGbWHWWURTqHB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069354; c=relaxed/simple;
	bh=VX0pwQBbyek58PrwiPaQkx7GaxWhGhJ7jZlRaINBvdY=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=srw50eFp9CzVUlHaFhh61ivnSr/wHISlWGxcox1914KqB+S0dn65KjXaV8AnKjcl8N7/Xzgiy7fKQJjCTChpEh1Z53sur1S+CpM0WYYb96Eoq0PfXVYo/6MJWI+voQpaM8HwOoH62dYWafZBZ7sy64MammnECUCAeCQhvFvixic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVV6vP1J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766069351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fI0eJnmPbifiAb/CS8fWvl+cxEgl+IqdfpnXGjo60Rw=;
	b=RVV6vP1Jlw4ydXQqIv5RRI9z4ys+oJDWdmD+85UxdEklWd/YDla0o19xnhDCeEqbSDCv4M
	XxTMIIaAY5bpWmqDaBPs51pRLM0DaC+iH/3S92Ldd5O1sT+wpPr67UTkMxIUgZQUwMpL3t
	cID4PPH0zcekGV081SuzUU7AfpQTUnM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-EgZJXPpwP5OiZSbQgYY7pQ-1; Thu,
 18 Dec 2025 09:49:07 -0500
X-MC-Unique: EgZJXPpwP5OiZSbQgYY7pQ-1
X-Mimecast-MFC-AGG-ID: EgZJXPpwP5OiZSbQgYY7pQ_1766069346
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A52ED180A23F;
	Thu, 18 Dec 2025 14:49:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A85F91953984;
	Thu, 18 Dec 2025 14:49:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
    Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
    Tom Talpey <tom@talpey.com>, Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] ksmbd: Fix to handle removal of rfc1002 header from smb_hdr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <712256.1766069339.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Dec 2025 14:48:59 +0000
Message-ID: <712257.1766069339@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Namjae,

Does this (untested) patch fix the problem for you?

David
---
The commit that removed the RFC1002 header from struct smb_hdr didn't also
fix the places in ksmbd that use it in order to provide graceful rejection
of SMB1 protocol requests.

Fixes: 83bfbd0bb902 ("cifs: Remove the RFC1002 header from smb_hdr")
Reported-by: Namjae Jeon <linkinjeon@kernel.org>
Link: https://lore.kernel.org/r/CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=3DR35M3vQ_Xa=
7Yw34JoNZ0A@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Sergey Senozhatsky <senozhatsky@chromium.org>
cc: Tom Talpey <tom@talpey.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/server/server.c     |    2 +-
 fs/smb/server/smb_common.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 3cea16050e4f..bedc8390b6db 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -95,7 +95,7 @@ static inline int check_conn_state(struct ksmbd_work *wo=
rk)
 =

 	if (ksmbd_conn_exiting(work->conn) ||
 	    ksmbd_conn_need_reconnect(work->conn)) {
-		rsp_hdr =3D work->response_buf;
+		rsp_hdr =3D smb2_get_msg(work->response_buf);
 		rsp_hdr->Status.CifsError =3D STATUS_CONNECTION_DISCONNECTED;
 		return 1;
 	}
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index b23203a1c286..d6084580b59d 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -140,7 +140,7 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
 	if (smb2_hdr->ProtocolId =3D=3D SMB2_PROTO_NUMBER)
 		return ksmbd_smb2_check_message(work);
 =

-	hdr =3D work->request_buf;
+	hdr =3D smb2_get_msg(work->request_buf);
 	if (*(__le32 *)hdr->Protocol =3D=3D SMB1_PROTO_NUMBER &&
 	    hdr->Command =3D=3D SMB_COM_NEGOTIATE) {
 		work->conn->outstanding_credits++;
@@ -278,7 +278,6 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
 						  req->DialectCount);
 	}
 =

-	proto =3D *(__le32 *)((struct smb_hdr *)buf)->Protocol;
 	if (proto =3D=3D SMB1_PROTO_NUMBER) {
 		struct smb_negotiate_req *req;
 =

@@ -320,8 +319,8 @@ static u16 get_smb1_cmd_val(struct ksmbd_work *work)
  */
 static int init_smb1_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb_hdr *rsp_hdr =3D (struct smb_hdr *)work->response_buf;
-	struct smb_hdr *rcv_hdr =3D (struct smb_hdr *)work->request_buf;
+	struct smb_hdr *rsp_hdr =3D (struct smb_hdr *)smb2_get_msg(work->respons=
e_buf);
+	struct smb_hdr *rcv_hdr =3D (struct smb_hdr *)smb2_get_msg(work->request=
_buf);
 =

 	rsp_hdr->Command =3D SMB_COM_NEGOTIATE;
 	*(__le32 *)rsp_hdr->Protocol =3D SMB1_PROTO_NUMBER;
@@ -412,9 +411,10 @@ static int init_smb1_server(struct ksmbd_conn *conn)
 =

 int ksmbd_init_smb_server(struct ksmbd_conn *conn)
 {
+	struct smb_hdr *rcv_hdr =3D (struct smb_hdr *)smb2_get_msg(conn->request=
_buf);
 	__le32 proto;
 =

-	proto =3D *(__le32 *)((struct smb_hdr *)conn->request_buf)->Protocol;
+	proto =3D *(__le32 *)rcv_hdr->Protocol;
 	if (conn->need_neg =3D=3D false) {
 		if (proto =3D=3D SMB1_PROTO_NUMBER)
 			return -EINVAL;


