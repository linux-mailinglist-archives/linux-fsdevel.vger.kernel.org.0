Return-Path: <linux-fsdevel+bounces-69243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5EC75163
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93C5A364F12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8974F3A79DC;
	Thu, 20 Nov 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxpmQYCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FCA3A79B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652390; cv=none; b=JdAAQPrDH3vlAVxvEvKTItV+rnlA22iMBub59CgtttzYkVg7SqPbiRTTIj8sRdhEUQlLcp5RgmU08JV7U06cqduxfFUuZWXP0Kc+J8HVqAUfDk43ysTHiRtYw3JEtuRonz4BhzJ/QWI0tvORNHkAjUmNuSSLyHpJVdtLNTlFeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652390; c=relaxed/simple;
	bh=9azUYLxcrprXapB2AW29/5U1XZ7wheGbaYw8wddL248=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDl1SSpChjKWL6fpsAcTX0jhumFpOEMucZfeadCf+EZJr7ZQ1fmoXANOX9mXmEFVxIrinT8RlZWZ6QmNf5+WlCCFO7WLlvhC0w0e3/id/Kb+WP+/PFG7jadWIsad56MWs4rKsB0ro/ye9To/rnoX0Yn4Sk270WWlAKU/Ac75ZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxpmQYCC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763652388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FUmnWmOFPZ/yS6/aSdvHVfj2x2LVbiiAoaubXk9WOA=;
	b=CxpmQYCCiakrOuZKz/OLLTGSBglSfKK527312f/utePRst4M0KkKxlmLEvu9BmiFfKTG/6
	Uv41qpAue+C9S/C39C335mdsT/JWNP4KZFOWnW+ox6Fxz59EZv6v+2q6VtBkCNcQZSYleb
	UooqjQ6dbNOy+E1nv+v3peCdqlqkDwU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-5u3njFTYPHmFH6hmwEyJVg-1; Thu,
 20 Nov 2025 10:26:19 -0500
X-MC-Unique: 5u3njFTYPHmFH6hmwEyJVg-1
X-Mimecast-MFC-AGG-ID: 5u3njFTYPHmFH6hmwEyJVg_1763652378
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE0ED1954231;
	Thu, 20 Nov 2025 15:26:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BF6430044E0;
	Thu, 20 Nov 2025 15:26:15 +0000 (UTC)
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
Subject: [PATCH v2 9/9] cifs: Don't need state locking in smb2_get_mid_entry()
Date: Thu, 20 Nov 2025 15:25:22 +0000
Message-ID: <20251120152524.2711660-10-dhowells@redhat.com>
In-Reply-To: <20251120152524.2711660-1-dhowells@redhat.com>
References: <20251120152524.2711660-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


