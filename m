Return-Path: <linux-fsdevel+bounces-71864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F8CD754F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19B80300CD64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C8434A79F;
	Mon, 22 Dec 2025 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQwlnysK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05116349B04
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442676; cv=none; b=aJlfUlsoczecOsGRB/2sQvONdRjcXcRSFf6J+5RMbBaYGhfcNb2nVfoJmKvYbdHdHIicYLHzZFhLfOlrR8L2vUD3kYun0THTi2yzleq88NuxBdwOidKO852UTSZ1PPfl3XKJnn91pW1sVl66+sgNm0oKe0r+kQSo9mqOXv3yOzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442676; c=relaxed/simple;
	bh=LDVxs4HVzGamgRyO4hgKW44vmux4lO4xwEKPQYnOq00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2THZ12B/oJUBt1BYzR3SeFoWPj96i+AdMsSIQI0dHpxkjP3Yze7z9hfbTw+qyI/LoyO1hOKkbrO1uPSK0aUTW78UahOs53nXN2pJEvjqS1Y0q0zzSUHoPOysXMP+m9zn3O4/19WhGJYKsG2s757DlmiqpNdxcskqhSVknszSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQwlnysK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYb0W3+K58jDqolNtPQz939MnKma4O1rdy9kUT/7xKE=;
	b=VQwlnysKMXp/SnldMW9f1gyy1vR9iVlJEtZIozCHdhyYwlXzTwrhaux+ZK9MySPv1kFlAt
	ussrvYr5CRCLZkNly1JC8JnXa8op7asV7yYB2cIIXAD1F11Kwlmxu3o6nRTqmLPzXYNpIO
	RjmHRjbX0noH2gw3XlvK4uZpR/qsCa0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-stUx3xVNN5iTuSu6IOwyLQ-1; Mon,
 22 Dec 2025 17:31:08 -0500
X-MC-Unique: stUx3xVNN5iTuSu6IOwyLQ-1
X-Mimecast-MFC-AGG-ID: stUx3xVNN5iTuSu6IOwyLQ_1766442667
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80396180060D;
	Mon, 22 Dec 2025 22:31:07 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C59FD19560AB;
	Mon, 22 Dec 2025 22:31:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/37] cifs: Scripted clean up fs/smb/client/ntlmssp.h
Date: Mon, 22 Dec 2025 22:29:43 +0000
Message-ID: <20251222223006.1075635-19-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/ntlmssp.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/ntlmssp.h b/fs/smb/client/ntlmssp.h
index a11fddc321f6..be0365f08396 100644
--- a/fs/smb/client/ntlmssp.h
+++ b/fs/smb/client/ntlmssp.h
@@ -142,16 +142,17 @@ typedef struct _AUTHENTICATE_MESSAGE {
  * Size of the session key (crypto key encrypted with the password
  */
 
-int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len, struct cifs_ses *ses);
+int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
+			     struct cifs_ses *ses);
 int build_ntlmssp_negotiate_blob(unsigned char **pbuffer, u16 *buflen,
 				 struct cifs_ses *ses,
 				 struct TCP_Server_Info *server,
 				 const struct nls_table *nls_cp);
 int build_ntlmssp_smb3_negotiate_blob(unsigned char **pbuffer, u16 *buflen,
-				 struct cifs_ses *ses,
-				 struct TCP_Server_Info *server,
-				 const struct nls_table *nls_cp);
+				      struct cifs_ses *ses,
+				      struct TCP_Server_Info *server,
+				      const struct nls_table *nls_cp);
 int build_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
-			struct cifs_ses *ses,
-			struct TCP_Server_Info *server,
-			const struct nls_table *nls_cp);
+			    struct cifs_ses *ses,
+			    struct TCP_Server_Info *server,
+			    const struct nls_table *nls_cp);


