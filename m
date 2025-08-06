Return-Path: <linux-fsdevel+bounces-56900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FF8B1CDC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A542618C656E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C52D23B8;
	Wed,  6 Aug 2025 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbua7eQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855612D1F6B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512742; cv=none; b=KV0QSExQEaAFZcVj5tRCvF1Hrl8Ahw8u+8ZRZa1efvzuTONX+sr8LZY3nNVNnRWFpKMtvj+Zb5Gne333GZ+h346qk579liBH9SpjRGwQPJPeuhCTLehQ28OqD3Vo8QOtY/duWrERjrnkziwbl94jLKWFsha0EefJ+aVgs5f/ElY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512742; c=relaxed/simple;
	bh=sGkIqwI4kKVf31IFHCvik9vYPq7stY3n3/q2f/ete+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hswYUUE08jlIKm4FXVKnho7ETgm/MRYZjYbX7ix5cb7vD85ChH55DY1QHKBzm7XAGg9s6V57dyGd01MpCGLZiL8stKVlrBohX2E7QvWKuc7ZJ0q8zz0P6qIDnrGAkk81gLKL8gzALHVFQmyeKo7YVd2HLnq4sTz5gQhyNWubOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbua7eQS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWFEygVcswswekGUvxP15RMRYsPo7UmyYBIY6DSNdhI=;
	b=hbua7eQS2a7HQDtP0FCLDRAL7uWZGhmZt88eVLN8wBxsZoVUmRd+c5Mlp/DK9Kfl0XbeLr
	9oMmr7i23VgaD1M78kieIwWLOxp78bLD3ufmQPzvdAgMmH7Zl8gbMtRimeowWrhJaN/NvN
	5+BWYtsiZud2ToaIPHn5OwWPWedh6pc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-qk4wtJRiN2m4hgjIOSmZxw-1; Wed,
 06 Aug 2025 16:38:54 -0400
X-MC-Unique: qk4wtJRiN2m4hgjIOSmZxw-1
X-Mimecast-MFC-AGG-ID: qk4wtJRiN2m4hgjIOSmZxw_1754512732
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24DA2195608C;
	Wed,  6 Aug 2025 20:38:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 130C91800447;
	Wed,  6 Aug 2025 20:38:48 +0000 (UTC)
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
Subject: [RFC PATCH 20/31] cifs: Don't need state locking in smb2_get_mid_entry()
Date: Wed,  6 Aug 2025 21:36:41 +0100
Message-ID: <20250806203705.2560493-21-dhowells@redhat.com>
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

There's no need to get ->srv_lock or ->ses_lock in smb2_get_mid_entry() as
all that happens of relevance (to the lock) inside the locked sections is
the reading of one status value in each.

Replace the locking with READ_ONCE() and use a switch instead of a chain of
if-statements.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2transport.c | 46 +++++++++++++++--------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 7c60584a8544..7194082bb5ac 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -769,43 +769,35 @@ static int
 smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		   struct smb_message *smb)
 {
-	spin_lock(&server->srv_lock);
-	if (server->tcpStatus == CifsExiting) {
-		spin_unlock(&server->srv_lock);
+	switch (READ_ONCE(server->tcpStatus)) {
+	case CifsExiting:
 		return -ENOENT;
-	}
-
-	if (server->tcpStatus == CifsNeedReconnect) {
-		spin_unlock(&server->srv_lock);
+	case CifsNeedReconnect:
 		cifs_dbg(FYI, "tcp session dead - return to caller to retry\n");
 		return -EAGAIN;
+	case CifsNeedNegotiate:
+		if (smb->command_id != SMB2_NEGOTIATE)
+			return -EAGAIN;
+		break;
+	default:
+		break;
 	}
 
-	if (server->tcpStatus == CifsNeedNegotiate &&
-	    smb->command_id != SMB2_NEGOTIATE) {
-		spin_unlock(&server->srv_lock);
-		return -EAGAIN;
-	}
-	spin_unlock(&server->srv_lock);
-
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_NEW) {
+	switch (READ_ONCE(ses->ses_status)) {
+	case SES_NEW:
 		if (smb->command_id != SMB2_SESSION_SETUP &&
-		    smb->command_id != SMB2_NEGOTIATE) {
-			spin_unlock(&ses->ses_lock);
+		    smb->command_id != SMB2_NEGOTIATE)
 			return -EAGAIN;
-		}
-		/* else ok - we are setting up session */
-	}
-
-	if (ses->ses_status == SES_EXITING) {
-		if (smb->command_id != SMB2_LOGOFF) {
-			spin_unlock(&ses->ses_lock);
+			/* else ok - we are setting up session */
+		break;
+	case SES_EXITING:
+		if (smb->command_id != SMB2_LOGOFF)
 			return -EAGAIN;
-		}
 		/* else ok - we are shutting down the session */
+		break;
+	default:
+		break;
 	}
-	spin_unlock(&ses->ses_lock);
 
 	smb2_init_mid(smb, server);
 


