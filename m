Return-Path: <linux-fsdevel+bounces-56908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EABB1CDDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A0A1896191
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A042D4B65;
	Wed,  6 Aug 2025 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQuGj8xd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0282D46BB
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512778; cv=none; b=uuVIjb4IeCdAWE7vNdugvE5hodCZlvi5MuHQ30q1x4mCfFgKKaNIG6CNE8lYAd4W8mMbH34CJoaRcLSBJkzqNE2y7DOCaXBYTPei1cXtvj4j/5DuyywfaWVYdEieFoZfH0qOOAl2Bv8JFx7XqszgCFGWr/bJQwkbzqLpM8TjLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512778; c=relaxed/simple;
	bh=XoqgTX1eo1X1heEZwLfDpLWPxo4E0Ftvt+pp/Wua9Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyh2mABudViENU0CXwGKYYiY3Nq6zqDZXJnoqwddtc9hDPAwcGEkJiy1svunhqSYkNOm2B0DukqJD+93FkjzQmGm+Iv3iN1BpAs58u/V0aYBBb2IPBJlO9T9xTPeLIctu0FGhmYeF7pFDLyW5tsk/A278QWAxjQcrlQJvl1Q3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQuGj8xd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1DRWP+raeweIc7wbapxyNrt0tD9BCSLBA67eiNSXJg=;
	b=FQuGj8xdcOded9aWrj6c1sk8OglYUlqhwbQQBeGRA4HAKsWuWb3kYYM3ZizN+VS5q/F7if
	PraXN9flMSTJi5FPzbOQ2E5iQW5Hcgtqxyn4FbljVhA03zWf3aF6vZqctRC6+GFe0YvIdJ
	MqIU1ORlG5QezJ1vDn8YRkNcjGYWycg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-WZyqM8nJOvWGdMwc-ZI6mw-1; Wed,
 06 Aug 2025 16:39:31 -0400
X-MC-Unique: WZyqM8nJOvWGdMwc-ZI6mw-1
X-Mimecast-MFC-AGG-ID: WZyqM8nJOvWGdMwc-ZI6mw_1754512770
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE87A19560B4;
	Wed,  6 Aug 2025 20:39:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC3CF19560AD;
	Wed,  6 Aug 2025 20:39:26 +0000 (UTC)
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
Subject: [RFC PATCH 28/31] cifs: Convert SMB2 Tree Disconnect request
Date: Wed,  6 Aug 2025 21:36:49 +0100
Message-ID: <20250806203705.2560493-29-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4300ae311ee2..9357c4953d9f 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2396,16 +2396,12 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 int
 SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 {
-	struct smb_rqst rqst;
 	struct smb2_tree_disconnect_req *req; /* response is trivial */
-	int rc = 0;
+	struct smb_message *smb = NULL;
 	struct cifs_ses *ses = tcon->ses;
 	struct TCP_Server_Info *server = cifs_pick_channel(ses);
 	int flags = 0;
-	unsigned int total_len;
-	struct kvec iov[1];
-	struct kvec rsp_iov;
-	int resp_buf_type;
+	int rc = 0;
 
 	cifs_dbg(FYI, "Tree Disconnect\n");
 
@@ -2423,33 +2419,26 @@ SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 
 	invalidate_all_cached_dirs(tcon);
 
-	rc = smb2_plain_req_init(SMB2_TREE_DISCONNECT, tcon, server,
-				 (void **) &req,
-				 &total_len);
-	if (rc)
-		return rc;
+	smb = smb2_create_request(SMB2_TREE_DISCONNECT, server, tcon,
+				  sizeof(*req), sizeof(*req), 0,
+				  SMB2_REQ_DYNAMIC);
+	if (!smb)
+		return -ENOMEM;
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
 	flags |= CIFS_NO_RSP_BUF;
 
-	iov[0].iov_base = (char *)req;
-	iov[0].iov_len = total_len;
-
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = 1;
-
-	rc = cifs_send_recv(xid, ses, server,
-			    &rqst, &resp_buf_type, flags, &rsp_iov);
-	cifs_small_buf_release(req);
+	rc = smb_send_recv_messages(xid, ses, server, smb, flags);
+	smb_clear_request(smb);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_TREE_DISCONNECT);
 		trace_smb3_tdis_err(xid, tcon->tid, ses->Suid, rc);
 	}
 	trace_smb3_tdis_done(xid, tcon->tid, ses->Suid);
 
+	smb_put_messages(smb);
 	return rc;
 }
 


