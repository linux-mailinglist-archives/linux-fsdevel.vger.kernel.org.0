Return-Path: <linux-fsdevel+bounces-29671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D93397C070
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 21:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26361C212E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 19:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6A1CA68A;
	Wed, 18 Sep 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgxjaPyY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121D1C9EAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687479; cv=none; b=syZI7NZ9PnU0sP9RzkHBosb/V32Jz5c228xgS86i3OrBzwyXwXC78spMWB7zslS/OFpI5U4IiSe9Z2fzPayaZyFVy5bysG3rj87J4+vgNKTPtBzFurqMQxWScnBlc46doYEloFixJ7UN5aHd8vFA67C/r7aZHK1/ZxN91QP391U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687479; c=relaxed/simple;
	bh=YdyFzy1jcfMaY51nnWIzBvWMvrJGWBsGOA35UGZoFfs=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=Ati1W9Lru5PNRB1IfybXxowb4epKWU/Fy/cW2AcDmUDADEFIgtUAuMxaeFa+a4Gfu1BygIN5l4OxeIvXBHLPhBHqyaU6uNLvPwOwmCTHP4AmA42DesOPbLtZn/Fsa5dFFc7/GVTgYB4ny5vQe6hNjPG4hFKHN4M4RltoCY+KX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgxjaPyY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726687476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=13NcS5WBCHgSavsJ+5jrwMZ/ERpINeUvrEKrZx5QIkI=;
	b=AgxjaPyYPqwkoY0nqUMSs2HZWUH8tg9ohj11z94ty3ciQldRf63cFCCpWJjwDRqbeBTb/5
	yyg2d9RmyWjwJxRzqtbGq1GcghbqpikpbqChv1gF9lkPvgTJRzWLkD/ey/hYqAc7BlexH8
	isohJzZIeFIPadVZ3rAbzdWhS4sX480=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-mbeDwEILOO-ofncEXk_s2g-1; Wed,
 18 Sep 2024 15:24:30 -0400
X-MC-Unique: mbeDwEILOO-ofncEXk_s2g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F2A91953943;
	Wed, 18 Sep 2024 19:24:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9937F30001A1;
	Wed, 18 Sep 2024 19:24:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Paulo Alcantara (Red Hat) <pc@manguebit.com>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Make the write_{enter,done,err} tracepoints display netfs info
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2390623.1726687464.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Sep 2024 20:24:24 +0100
Message-ID: <2390624.1726687464@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Make the write RPC tracepoints use the same trace macro complexes as the
read tracepoints and display the netfs request and subrequest IDs where
available (see commit 519be989717c "cifs: Add a tracepoint to track credit=
s
involved in R/W requests").

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c |   22 +++++++++++++++-------
 fs/smb/client/trace.h   |    6 +++---
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index bb8ecbbe78af..6544deac8069 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4865,7 +4865,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
 #endif
 	if (result) {
 		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
-		trace_smb3_write_err(wdata->xid,
+		trace_smb3_write_err(wdata->rreq->debug_id,
+				     wdata->subreq.debug_index,
+				     wdata->xid,
 				     wdata->req->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid, wdata->subreq.start,
 				     wdata->subreq.len, wdata->result);
@@ -4873,7 +4875,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
 			pr_warn_once("Out of space writing to %s\n",
 				     tcon->tree_name);
 	} else
-		trace_smb3_write_done(0 /* no xid */,
+		trace_smb3_write_done(wdata->rreq->debug_id,
+				      wdata->subreq.debug_index,
+				      wdata->xid,
 				      wdata->req->cfile->fid.persistent_fid,
 				      tcon->tid, tcon->ses->Suid,
 				      wdata->subreq.start, wdata->subreq.len);
@@ -4951,7 +4955,9 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 				offsetof(struct smb2_write_req, Buffer));
 	req->RemainingBytes =3D 0;
 =

-	trace_smb3_write_enter(wdata->xid,
+	trace_smb3_write_enter(wdata->rreq->debug_id,
+			       wdata->subreq.debug_index,
+			       wdata->xid,
 			       io_parms->persistent_fid,
 			       io_parms->tcon->tid,
 			       io_parms->tcon->ses->Suid,
@@ -5027,7 +5033,9 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 			     wdata, flags, &wdata->credits);
 	/* Can't touch wdata if rc =3D=3D 0 */
 	if (rc) {
-		trace_smb3_write_err(xid,
+		trace_smb3_write_err(wdata->rreq->debug_id,
+				     wdata->subreq.debug_index,
+				     xid,
 				     io_parms->persistent_fid,
 				     io_parms->tcon->tid,
 				     io_parms->tcon->ses->Suid,
@@ -5107,7 +5115,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_pa=
rms *io_parms,
 				offsetof(struct smb2_write_req, Buffer));
 	req->RemainingBytes =3D 0;
 =

-	trace_smb3_write_enter(xid, io_parms->persistent_fid,
+	trace_smb3_write_enter(0, 0, xid, io_parms->persistent_fid,
 		io_parms->tcon->tid, io_parms->tcon->ses->Suid,
 		io_parms->offset, io_parms->length);
 =

@@ -5128,7 +5136,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_pa=
rms *io_parms,
 	rsp =3D (struct smb2_write_rsp *)rsp_iov.iov_base;
 =

 	if (rc) {
-		trace_smb3_write_err(xid,
+		trace_smb3_write_err(0, 0, xid,
 				     req->PersistentFileId,
 				     io_parms->tcon->tid,
 				     io_parms->tcon->ses->Suid,
@@ -5137,7 +5145,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_pa=
rms *io_parms,
 		cifs_dbg(VFS, "Send error in write =3D %d\n", rc);
 	} else {
 		*nbytes =3D le32_to_cpu(rsp->DataLength);
-		trace_smb3_write_done(xid,
+		trace_smb3_write_done(0, 0, xid,
 				      req->PersistentFileId,
 				      io_parms->tcon->tid,
 				      io_parms->tcon->ses->Suid,
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 8e9964001e2a..0b52d22a91a0 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -157,6 +157,7 @@ DEFINE_EVENT(smb3_rw_err_class, smb3_##name,    \
 	TP_ARGS(rreq_debug_id, rreq_debug_index, xid, fid, tid, sesid, offset, l=
en, rc))
 =

 DEFINE_SMB3_RW_ERR_EVENT(read_err);
+DEFINE_SMB3_RW_ERR_EVENT(write_err);
 =

 /* For logging errors in other file I/O ops */
 DECLARE_EVENT_CLASS(smb3_other_err_class,
@@ -202,7 +203,6 @@ DEFINE_EVENT(smb3_other_err_class, smb3_##name, \
 		int	rc),			\
 	TP_ARGS(xid, fid, tid, sesid, offset, len, rc))
 =

-DEFINE_SMB3_OTHER_ERR_EVENT(write_err);
 DEFINE_SMB3_OTHER_ERR_EVENT(query_dir_err);
 DEFINE_SMB3_OTHER_ERR_EVENT(zero_err);
 DEFINE_SMB3_OTHER_ERR_EVENT(falloc_err);
@@ -370,6 +370,8 @@ DEFINE_EVENT(smb3_rw_done_class, smb3_##name,   \
 =

 DEFINE_SMB3_RW_DONE_EVENT(read_enter);
 DEFINE_SMB3_RW_DONE_EVENT(read_done);
+DEFINE_SMB3_RW_DONE_EVENT(write_enter);
+DEFINE_SMB3_RW_DONE_EVENT(write_done);
 =

 /* For logging successful other op */
 DECLARE_EVENT_CLASS(smb3_other_done_class,
@@ -411,11 +413,9 @@ DEFINE_EVENT(smb3_other_done_class, smb3_##name,   \
 		__u32	len),			\
 	TP_ARGS(xid, fid, tid, sesid, offset, len))
 =

-DEFINE_SMB3_OTHER_DONE_EVENT(write_enter);
 DEFINE_SMB3_OTHER_DONE_EVENT(query_dir_enter);
 DEFINE_SMB3_OTHER_DONE_EVENT(zero_enter);
 DEFINE_SMB3_OTHER_DONE_EVENT(falloc_enter);
-DEFINE_SMB3_OTHER_DONE_EVENT(write_done);
 DEFINE_SMB3_OTHER_DONE_EVENT(query_dir_done);
 DEFINE_SMB3_OTHER_DONE_EVENT(zero_done);
 DEFINE_SMB3_OTHER_DONE_EVENT(falloc_done);


