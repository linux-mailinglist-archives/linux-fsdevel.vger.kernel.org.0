Return-Path: <linux-fsdevel+bounces-29858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF0097EDCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870E0280CE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1E519E984;
	Mon, 23 Sep 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3HqVdBO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839691A070C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104148; cv=none; b=tyX//MItbIk5ySTO+R88LC6tl9pv1VnR+KOGDybra7S1k0UvKmdtwZJAkQzUId63KlJZkZqfkeOYJJZ/oTgBZcJzSF1Sk9Q5jFZ9J/xwNH6g2Des91rOyN7ulnC25Ec5yRsskKjSSIULCML/O2JKTe+AXq94rDmvFnH8BvDBTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104148; c=relaxed/simple;
	bh=YdgTs3NXTVXKytM4MZ9ekQvYiCfKyHWyGYaMPKC/AYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2r4ilCGPOG4ta2IQmlU6JAJOK59D3GleDAMkCmyyCyPKpA82N1fQsT7/RTATz1ZDdoQjz9rQivAwClkPS9B9GX428ALDsnUqhzLQG1WAWbTBnI56jjNs88y6J9JtyLZ1dpd9wVG9TiW/Kp7O/IvNro3Iqs9uxFg7Gc4rONTyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3HqVdBO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h43zAABX1+Y84szWbuf6Y3zUUIJDGkYGOYZIeY5MUOA=;
	b=e3HqVdBOeUT2XysHFnpi3ubvIzrWLdUsOWNwB/sPxfqfJVb6dxOZlNDcDHq5+DScL/Hynd
	8B+F67q7uabSYxiT8HmyHcsD63+/WdMRyWAXkyKbxy+epyRhT/ArFel8kGqJ2jcDVXYi49
	KJpww5qq1u1VaJuX+aCCg00WhmoBYcM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-iresh_brOiyWhufnlrfLWA-1; Mon,
 23 Sep 2024 11:09:02 -0400
X-MC-Unique: iresh_brOiyWhufnlrfLWA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0E2718BC2C9;
	Mon, 23 Sep 2024 15:08:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B0E21955D87;
	Mon, 23 Sep 2024 15:08:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 8/8] cifs: Make the write_{enter,done,err} tracepoints display netfs info
Date: Mon, 23 Sep 2024 16:07:52 +0100
Message-ID: <20240923150756.902363-9-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Make the write RPC tracepoints use the same trace macro complexes as the
read tracepoints and display the netfs request and subrequest IDs where
available (see commit 519be989717c ("cifs: Add a tracepoint to track
credits involved in R/W requests")).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 22 +++++++++++++++-------
 fs/smb/client/trace.h   |  6 +++---
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 0b63608aeecb..9afc3baba27b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4858,7 +4858,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
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
@@ -4866,7 +4868,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
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
@@ -4944,7 +4948,9 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 				offsetof(struct smb2_write_req, Buffer));
 	req->RemainingBytes = 0;
 
-	trace_smb3_write_enter(wdata->xid,
+	trace_smb3_write_enter(wdata->rreq->debug_id,
+			       wdata->subreq.debug_index,
+			       wdata->xid,
 			       io_parms->persistent_fid,
 			       io_parms->tcon->tid,
 			       io_parms->tcon->ses->Suid,
@@ -5024,7 +5030,9 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 			     wdata, flags, &wdata->credits);
 	/* Can't touch wdata if rc == 0 */
 	if (rc) {
-		trace_smb3_write_err(xid,
+		trace_smb3_write_err(wdata->rreq->debug_id,
+				     wdata->subreq.debug_index,
+				     xid,
 				     io_parms->persistent_fid,
 				     io_parms->tcon->tid,
 				     io_parms->tcon->ses->Suid,
@@ -5104,7 +5112,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 				offsetof(struct smb2_write_req, Buffer));
 	req->RemainingBytes = 0;
 
-	trace_smb3_write_enter(xid, io_parms->persistent_fid,
+	trace_smb3_write_enter(0, 0, xid, io_parms->persistent_fid,
 		io_parms->tcon->tid, io_parms->tcon->ses->Suid,
 		io_parms->offset, io_parms->length);
 
@@ -5125,7 +5133,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 	rsp = (struct smb2_write_rsp *)rsp_iov.iov_base;
 
 	if (rc) {
-		trace_smb3_write_err(xid,
+		trace_smb3_write_err(0, 0, xid,
 				     req->PersistentFileId,
 				     io_parms->tcon->tid,
 				     io_parms->tcon->ses->Suid,
@@ -5134,7 +5142,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 		cifs_dbg(VFS, "Send error in write = %d\n", rc);
 	} else {
 		*nbytes = le32_to_cpu(rsp->DataLength);
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
 	TP_ARGS(rreq_debug_id, rreq_debug_index, xid, fid, tid, sesid, offset, len, rc))
 
 DEFINE_SMB3_RW_ERR_EVENT(read_err);
+DEFINE_SMB3_RW_ERR_EVENT(write_err);
 
 /* For logging errors in other file I/O ops */
 DECLARE_EVENT_CLASS(smb3_other_err_class,
@@ -202,7 +203,6 @@ DEFINE_EVENT(smb3_other_err_class, smb3_##name, \
 		int	rc),			\
 	TP_ARGS(xid, fid, tid, sesid, offset, len, rc))
 
-DEFINE_SMB3_OTHER_ERR_EVENT(write_err);
 DEFINE_SMB3_OTHER_ERR_EVENT(query_dir_err);
 DEFINE_SMB3_OTHER_ERR_EVENT(zero_err);
 DEFINE_SMB3_OTHER_ERR_EVENT(falloc_err);
@@ -370,6 +370,8 @@ DEFINE_EVENT(smb3_rw_done_class, smb3_##name,   \
 
 DEFINE_SMB3_RW_DONE_EVENT(read_enter);
 DEFINE_SMB3_RW_DONE_EVENT(read_done);
+DEFINE_SMB3_RW_DONE_EVENT(write_enter);
+DEFINE_SMB3_RW_DONE_EVENT(write_done);
 
 /* For logging successful other op */
 DECLARE_EVENT_CLASS(smb3_other_done_class,
@@ -411,11 +413,9 @@ DEFINE_EVENT(smb3_other_done_class, smb3_##name,   \
 		__u32	len),			\
 	TP_ARGS(xid, fid, tid, sesid, offset, len))
 
-DEFINE_SMB3_OTHER_DONE_EVENT(write_enter);
 DEFINE_SMB3_OTHER_DONE_EVENT(query_dir_enter);
 DEFINE_SMB3_OTHER_DONE_EVENT(zero_enter);
 DEFINE_SMB3_OTHER_DONE_EVENT(falloc_enter);
-DEFINE_SMB3_OTHER_DONE_EVENT(write_done);
 DEFINE_SMB3_OTHER_DONE_EVENT(query_dir_done);
 DEFINE_SMB3_OTHER_DONE_EVENT(zero_done);
 DEFINE_SMB3_OTHER_DONE_EVENT(falloc_done);


