Return-Path: <linux-fsdevel+bounces-68519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E5EC5DC99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1C8D4E5D86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64432938B;
	Fri, 14 Nov 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcjKARk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCA329C47
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131424; cv=none; b=iqcLlNNvQOmJzMU+bkl+XG+Cu3tV3ra2vcl5+blWhJ7HKY8ZIAAAvwEYcKvWmx7NvcjXDncgi/TMeJRBAwmP2spRnrvCjBGmjcpjFlJ6UMRqBqdkQmdBH+jog9YolZGq901YwcjaFXMgwh30dlMqvEJ93CuGLB71YOMnzIzGk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131424; c=relaxed/simple;
	bh=9azUYLxcrprXapB2AW29/5U1XZ7wheGbaYw8wddL248=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhMl1Pu26N0t86grV5vrqsLARnXe07HDzfZlHBizBvLoLOkZkTikaIRKKZhm1hQPcZhLGfSq18HwmnVEB+7mhk3tO91yAot1sYK0hUMUp/oHW6zrtFJZJqdrPRGHY+VbVibKaMeQuABkgP6DKdfuKt+AJAbRJklMIO9No2Dcrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcjKARk0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763131421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FUmnWmOFPZ/yS6/aSdvHVfj2x2LVbiiAoaubXk9WOA=;
	b=hcjKARk0jNxs+uBAs2GAsSVFmetijxPeNbPa7idH/Ct5LqA3uiko4jlEalKOrvdEVAS3xs
	6t9lwIQIg5IAsLzKn8UdgzhuORUIJAJkFbQZsK7Xximay+6KgLsdf0E7o7EZRdlneAKo/f
	35dq7cR2PXsn+UGXW9aIHXYLbdUvsHc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-Ga70rzyzMpSqvX6NLN2uRQ-1; Fri,
 14 Nov 2025 09:43:38 -0500
X-MC-Unique: Ga70rzyzMpSqvX6NLN2uRQ-1
X-Mimecast-MFC-AGG-ID: Ga70rzyzMpSqvX6NLN2uRQ_1763131417
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D90941956094;
	Fri, 14 Nov 2025 14:43:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D58E180049F;
	Fri, 14 Nov 2025 14:43:34 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 9/9] cifs: Don't need state locking in smb2_get_mid_entry()
Date: Fri, 14 Nov 2025 14:42:51 +0000
Message-ID: <20251114144253.1853312-10-dhowells@redhat.com>
In-Reply-To: <20251114144253.1853312-1-dhowells@redhat.com>
References: <20251114144253.1853312-1-dhowells@redhat.com>
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
 fs/smb/client/smb2transport.c | 48 +++++++++++++++--------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 6d76b0c6d73d..47eab3753c9e 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -684,43 +684,35 @@ static int
 smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		   struct smb2_hdr *shdr, struct smb_message **smb)
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
-	}
-
-	if (server->tcpStatus == CifsNeedNegotiate &&
-	   shdr->Command != SMB2_NEGOTIATE) {
-		spin_unlock(&server->srv_lock);
-		return -EAGAIN;
-	}
-	spin_unlock(&server->srv_lock);
-
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_NEW) {
-		if ((shdr->Command != SMB2_SESSION_SETUP) &&
-		    (shdr->Command != SMB2_NEGOTIATE)) {
-			spin_unlock(&ses->ses_lock);
+	case CifsNeedNegotiate:
+		if (shdr->Command != SMB2_NEGOTIATE)
 			return -EAGAIN;
-		}
-		/* else ok - we are setting up session */
+		break;
+	default:
+		break;
 	}
 
-	if (ses->ses_status == SES_EXITING) {
-		if (shdr->Command != SMB2_LOGOFF) {
-			spin_unlock(&ses->ses_lock);
+	switch (READ_ONCE(ses->ses_status)) {
+	case SES_NEW:
+		if (shdr->Command != SMB2_SESSION_SETUP &&
+		    shdr->Command != SMB2_NEGOTIATE)
+			return -EAGAIN;
+			/* else ok - we are setting up session */
+		break;
+	case SES_EXITING:
+		if (shdr->Command != SMB2_LOGOFF)
 			return -EAGAIN;
-		}
 		/* else ok - we are shutting down the session */
+		break;
+	default:
+		break;
 	}
-	spin_unlock(&ses->ses_lock);
 
 	*smb = smb2_mid_entry_alloc(shdr, server);
 	if (*smb == NULL)


