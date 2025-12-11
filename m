Return-Path: <linux-fsdevel+bounces-71113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D896FCB5D82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DFF83020DBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8BB302750;
	Thu, 11 Dec 2025 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZ5A1DyF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB75311C20
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455573; cv=none; b=AhYyqCu9LXkq/RzrpoySxB2cCjhdDsIqHOK3WsIu4YJnjKGObhQiu9YNBi6pTbVEJmHm0rVQ+Uwr8OYMsEHAOfeft16WOu/8hFjd0cN2DWdDM5/pqJfXKcD6nHro7L9t+cjSU2mdO8qng0aMP/bRi+qD6/jPbMnRyDsP/2D3sgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455573; c=relaxed/simple;
	bh=LDVxs4HVzGamgRyO4hgKW44vmux4lO4xwEKPQYnOq00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3Vegx47tsur13i+AQMNRppbD0bIbV30E4h0jECoGOPj3a0vhGBrSIYdXqqdD4q5IkVMvBe8L/H4v278ZMoGoDRdiVUywK9jAtcUZeKX7vOzl3jlAA9vmsyuERAPN6QRUiuwiQVgikl8cjWJ7qycQiEBDAgfxKl6IrTxNNFrFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZ5A1DyF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYb0W3+K58jDqolNtPQz939MnKma4O1rdy9kUT/7xKE=;
	b=ZZ5A1DyFEef9wNr+Sc+5L5MYg2T/NqxY7kLPs1Dbq+u5w1IwnGqmk0qG7RuB9wd3wpdEqy
	9HCtLt7bhmkHcM6xcfIWRe99b8ABcx/3HnTvADbj0TUdyuWwVBqQQl/Q8sqvhiBd7XEw54
	74I3Or7JbsyeT1MSKdbivDDa+9r00LQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-CBpNi5YHN9ytx28_kxrkzw-1; Thu,
 11 Dec 2025 07:18:52 -0500
X-MC-Unique: CBpNi5YHN9ytx28_kxrkzw-1
X-Mimecast-MFC-AGG-ID: CBpNi5YHN9ytx28_kxrkzw_1765455530
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C74E818001E2;
	Thu, 11 Dec 2025 12:18:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E164180049F;
	Thu, 11 Dec 2025 12:18:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/18] cifs: Scripted clean up fs/smb/client/ntlmssp.h
Date: Thu, 11 Dec 2025 12:17:12 +0000
Message-ID: <20251211121715.759074-20-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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


