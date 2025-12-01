Return-Path: <linux-fsdevel+bounces-70402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70969C997CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D76223428C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 23:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB402D3EF2;
	Mon,  1 Dec 2025 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe7iCBHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA32D24AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629896; cv=none; b=iKzvtbsyMy7hGWgKiukumJAlR0vlUTK6jX6RjpUHClZFlhdiOTHJoTk0xwEi6EdXV0CTEFXfL9wvZjOjLY0UVHhubtpsHqPyW6kbIqKltnIOh2//86lXqZ5JZeDiezKOX+rZ0++eBDfJPKCNBDMIpRweDKEUtflKlL40pWiW3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629896; c=relaxed/simple;
	bh=kVAzsdYACNxCMIlrstbDN4TiRE8cu9bDDpWkvccgviQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTlZG7RbkDlGzX6B53omhyj4KhCLE/e9D/K0MtdrDcGLBXYoJ5s5NV2ptsM2xfHC8AGenWmNnMsBJ3a+361zYm9x9SxJ/UINsZcOrxNoyUxcpCMNelcf58r2DoONaOZPizbIdmINzkI1sGtb3WVkY8cCtmr02rDr5056FhHcI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pe7iCBHu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764629893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkk/qeDFISFqpoIzreaKbH6PF7a/zBmUeahYIhhBiU0=;
	b=Pe7iCBHugHYUIy9Ei8puw4UF5smgSVOcjbKkXhqQ6tyhRkFOReYRIbv77FU+fD+xlbwNqA
	NmhpHe61NcnG1scca1kMbizMMi2MCn+kUzWpPVPXRGXpBsTYV2ZQmtHl9owG0tT49lbVYO
	5gUlBj2qjBLDpTbhwLlMnGV+7tI+hmc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-wXejG35tPvKSbc0osxpLlw-1; Mon,
 01 Dec 2025 17:58:10 -0500
X-MC-Unique: wXejG35tPvKSbc0osxpLlw-1
X-Mimecast-MFC-AGG-ID: wXejG35tPvKSbc0osxpLlw_1764629888
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B75F1195609D;
	Mon,  1 Dec 2025 22:58:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23C0219560B2;
	Mon,  1 Dec 2025 22:58:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/9] cifs: Don't need state locking in smb2_get_mid_entry()
Date: Mon,  1 Dec 2025 22:57:28 +0000
Message-ID: <20251201225732.1520128-8-dhowells@redhat.com>
In-Reply-To: <20251201225732.1520128-1-dhowells@redhat.com>
References: <20251201225732.1520128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index d06f872c9ab2..99fa48bcd459 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -684,43 +684,35 @@ static int
 smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		   struct smb2_hdr *shdr, struct mid_q_entry **mid)
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
 
 	*mid = smb2_mid_entry_alloc(shdr, server);
 	if (*mid == NULL)


