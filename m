Return-Path: <linux-fsdevel+bounces-68511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACEC5DB2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DA294EF3E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520B326931;
	Fri, 14 Nov 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnNAdgBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631F732143A
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131393; cv=none; b=cHoiJaoUu6NgcMgK14Kad7mpHChxzT11xekSKaurWcPRLxiy86k9Cjfa+Rs05xrJPAxr13dNuETdqZbnoWVShFHfwM/5Ob9dBtT70iUChX8r2pbgqDhDOVcdmrL+MO/gyqC1hvU1KAqsyNfPasOn6CrH+AxZSX36V1O5YDqB3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131393; c=relaxed/simple;
	bh=RVmNxwihlG9YoD1lbuTf7xysW4xcMQq9JtuqV2Yj0xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtGFhSEpZ8/q6yZ84/0enLNFTlGYb/4pvJ0GGOJR8gUZyPGgOxxwkvtAPTjEuEbEho7eMADE96Ew91oynQMEnoBnrvw0Nadnex5KF7mhto/kPxMUDFe9JVvfCzpzXemWCLMO9G21bVqmMxfqibk/rgbMk96tbzLNp985QMa4yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnNAdgBI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763131390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwVmHJJzICh9TQUmMwLLLQmB0XyJBudL6Pra/npu/nE=;
	b=bnNAdgBIisHuzk1SvKB+dKJbbSQXSOWb1ey3lH1v8WRqlB0WEw9rtQx4TOXyUy2E6Dwin2
	4I4iUBXbLfXYCtOel+4oKSvQ/Wv863WnkYyrLD7YTLFWlKqS+fptRRhR3wV4Jh/mikl59g
	aTi1gYxR3t1Xfl57Hk+5xLjbgNlZmgU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-t_qf03nuMNWzF_LEy2GXmw-1; Fri,
 14 Nov 2025 09:43:05 -0500
X-MC-Unique: t_qf03nuMNWzF_LEy2GXmw-1
X-Mimecast-MFC-AGG-ID: t_qf03nuMNWzF_LEy2GXmw_1763131383
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3264F18001D1;
	Fri, 14 Nov 2025 14:43:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.87])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E25BB1800269;
	Fri, 14 Nov 2025 14:43:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] cifs: Add the smb3_read_* tracepoints to SMB1
Date: Fri, 14 Nov 2025 14:42:43 +0000
Message-ID: <20251114144253.1853312-2-dhowells@redhat.com>
In-Reply-To: <20251114144253.1853312-1-dhowells@redhat.com>
References: <20251114144253.1853312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index 7da194f29fef..dcc50a2bfa4b 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1363,6 +1363,14 @@ cifs_readv_callback(struct mid_q_entry *mid)
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
 
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
@@ -1445,6 +1460,13 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	rdata->iov[1].iov_base = (char *)smb + 4;
 	rdata->iov[1].iov_len = get_rfc1002_length(smb);
 
+	trace_smb3_read_enter(rdata->rreq->debug_id,
+			      rdata->subreq.debug_index,
+			      rdata->xid,
+			      rdata->req->cfile->fid.netfid,
+			      tcon->tid, tcon->ses->Suid,
+			      rdata->subreq.start, rdata->subreq.len);
+
 	rc = cifs_call_async(tcon->ses->server, &rqst, cifs_readv_receive,
 			     cifs_readv_callback, NULL, rdata, 0, NULL);
 


