Return-Path: <linux-fsdevel+bounces-69601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0DC7E9F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AA93A485F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A5227E049;
	Sun, 23 Nov 2025 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1GuO4nM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0627AC54
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763941987; cv=none; b=NNIe5y7KNDdkAyjWJXQk4gNGONVLvt2qcUFYBZM6hg3ThIV5MV8kagz2knn40891MBrVLnfenZZyNdp6JunxyeHAjldRR3vYqU25gR/f+a/0Ri/3iQ+mcjR20oZInLRIk9xEaSAoD4zE7tKlnC+uf4GtcE+JVOYN0zNptQZLWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763941987; c=relaxed/simple;
	bh=JRZw1+NRRDhGC3+t9NuubpnUDXd3G5ICSlUy5oqZlfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACwdi2tmrRpC9TnyswuOkT/00vNdg5NvW3Ru9GAizD+dYHRLXcKYLgs6IkOKwRTmpbNKQ1UdxB+fD1IYkPSCGIrvDylSqSQhm/UhJU1C1TFdOnB4zZk5DXCrqdA+iORZloYcxtx69MQpC7EOkeexWJm3XiFJRaL9OOUyFcrWueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1GuO4nM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763941985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQ1WtFdq74kkE0ZraVreA3xQBS+xu0SO2hZ5QW0FJwI=;
	b=h1GuO4nMRkD5KZer4Kg+f9OHB4tj8XGNrxtjxCeiKR6V2ySxRpaYgXNEz/HrzUPDBEiZ3K
	baxxjaa/SKRz5ONfzjN0v6Rn8I0i2Yc0BWyfuhGlLd1YGiG0yn7he26C0kcSWotb+4COlX
	hJBj8qp4dK+bT3ZqbwyeHef1mB0sbAE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-3OMcUr32OjOpYUbSTUiTpQ-1; Sun,
 23 Nov 2025 18:53:01 -0500
X-MC-Unique: 3OMcUr32OjOpYUbSTUiTpQ-1
X-Mimecast-MFC-AGG-ID: 3OMcUr32OjOpYUbSTUiTpQ_1763941980
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1186B1800452;
	Sun, 23 Nov 2025 23:53:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D61223003761;
	Sun, 23 Nov 2025 23:52:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/12] cifs: Add the smb3_read_* tracepoints to SMB1
Date: Sun, 23 Nov 2025 23:52:30 +0000
Message-ID: <20251123235242.3361706-4-dhowells@redhat.com>
In-Reply-To: <20251123235242.3361706-1-dhowells@redhat.com>
References: <20251123235242.3361706-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add the smb3_read_* tracepoints to SMB1's cifs_async_readv() and
cifs_readv_callback().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifssmb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6bb0ec6420d2..85a9fa3b3768 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1364,6 +1364,14 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	if (rdata->result == -ENODATA) {
 		rdata->result = 0;
 		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+		trace_smb3_read_err(rdata->rreq->debug_id,
+				    rdata->subreq.debug_index,
+				    rdata->xid,
+				    rdata->req->cfile->fid.persistent_fid,
+				    tcon->tid, tcon->ses->Suid,
+				    rdata->subreq.start + rdata->subreq.transferred,
+				    rdata->subreq.len   - rdata->subreq.transferred,
+				    rdata->result);
 	} else {
 		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
@@ -1375,6 +1383,13 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		}
 		if (rdata->got_bytes)
 			__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
+		trace_smb3_read_done(rdata->rreq->debug_id,
+				     rdata->subreq.debug_index,
+				     rdata->xid,
+				     rdata->req->cfile->fid.persistent_fid,
+				     tcon->tid, tcon->ses->Suid,
+				     rdata->subreq.start + rdata->subreq.transferred,
+				     rdata->got_bytes);
 	}
 
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
@@ -1446,6 +1461,13 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	rdata->iov[1].iov_base = (char *)smb + 4;
 	rdata->iov[1].iov_len = get_rfc1002_len(smb);
 
+	trace_smb3_read_enter(rdata->rreq->debug_id,
+			      rdata->subreq.debug_index,
+			      rdata->xid,
+			      rdata->req->cfile->fid.netfid,
+			      tcon->tid, tcon->ses->Suid,
+			      rdata->subreq.start, rdata->subreq.len);
+
 	rc = cifs_call_async(tcon->ses->server, &rqst, cifs_readv_receive,
 			     cifs_readv_callback, NULL, rdata, 0, NULL);
 


