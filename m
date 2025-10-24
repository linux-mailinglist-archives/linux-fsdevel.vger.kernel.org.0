Return-Path: <linux-fsdevel+bounces-65529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B02C07089
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 416C75089A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018DE32D0F9;
	Fri, 24 Oct 2025 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ro2vnjfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878332A3C2
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320581; cv=none; b=RntuxtAHHqsRaAU+LhX6NjKUhe1PWCx2sJtji1FiF254/McxeVVMp0eTKm1GzK2Q5nAyBYqi3AQhnZNeBAIkQBPjHQIcEpeNJeWEQPNMr5x3DcHTyz9tVui+FDvbE/KmXzOpRrYLLNiS/HOVLpZv2lOLJd8rdaqaLmMBFuBjvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320581; c=relaxed/simple;
	bh=iwGtGSkl539qxHbUnVxAeqGQHm9nmFNJXbjpYpIoN+o=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=t+8ZubEpzWpvtY1oTKNTe75malwiw5EmEU4UYE4M9H6KDMSKiWv9693+4qejF0+junZQwRJRoghiwMr89SsaF6TCIjwP8lmKte2G6PcWwt6JnvtLJjz0TbOZK5QR28IMOxsoPpg229hnhoyiIjs4YqIlXHsXiFhmwNF2EGJoADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ro2vnjfT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761320578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LhgReGKV6jRu0dbzPytjjMwmtz8YOk/kvC3OoDxDtzg=;
	b=Ro2vnjfTh9b+T3oykYKBp4cM2H/PNHZmTt8GIKiP++pz8LBvSg4mjLYBlAUkslfprvdFsk
	J74dXMUKLkAzOXaxfmbDM8kBM6K1Mb2nT4fvuNSJ82BscFiEh3ywIA96v0/1TzdaIE+sAp
	l114Y0P+bAHq/SE5G1cwDuMLV3fqmNg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-gQzB8hBdOtKKa3L7vOwoFA-1; Fri,
 24 Oct 2025 11:42:55 -0400
X-MC-Unique: gQzB8hBdOtKKa3L7vOwoFA-1
X-Mimecast-MFC-AGG-ID: gQzB8hBdOtKKa3L7vOwoFA_1761320574
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E0251852991;
	Fri, 24 Oct 2025 15:42:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89A13180044F;
	Fri, 24 Oct 2025 15:42:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Call the smb3_read_* tracepoints from SMB1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2014674.1761320570.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Oct 2025 16:42:50 +0100
Message-ID: <2014675.1761320570@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Call the smb3_read_* tracepoints from SMB1's cifs_async_readv() and
cifs_readv_callback().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifssmb.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 703c5a8ed924..132d015cbdf1 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1363,6 +1363,14 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	if (rdata->result =3D=3D -ENODATA) {
 		rdata->result =3D 0;
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
 		size_t trans =3D rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
@@ -1374,6 +1382,13 @@ cifs_readv_callback(struct mid_q_entry *mid)
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
 =

 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.=
value,
@@ -1445,6 +1460,13 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	rdata->iov[1].iov_base =3D (char *)smb + 4;
 	rdata->iov[1].iov_len =3D get_rfc1002_len(smb);
 =

+	trace_smb3_read_enter(rdata->rreq->debug_id,
+			      rdata->subreq.debug_index,
+			      rdata->xid,
+			      rdata->req->cfile->fid.netfid,
+			      tcon->tid, tcon->ses->Suid,
+			      rdata->subreq.start, rdata->subreq.len);
+
 	rc =3D cifs_call_async(tcon->ses->server, &rqst, cifs_readv_receive,
 			     cifs_readv_callback, NULL, rdata, 0, NULL);
 =


