Return-Path: <linux-fsdevel+bounces-69235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA708C7515C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1B75F3505A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B983362149;
	Thu, 20 Nov 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqaXG7BH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16722361DC0
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652355; cv=none; b=k8Nd1Jmmj42ug6HxoMUaGtEKhTQpg7XE6TEXQ106LEHlD0Kmc9zj3zwil5D9m2j/TxgrXNC63lpBKOcpXEs2N2QXpdygpwIqAQhay91y0g0h/oZr40USuJGF6bEiBmGwN9dFSP4Ri/e2IFo5C+gWnyRH0UQB7+LTEF70euHSflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652355; c=relaxed/simple;
	bh=epRVSgiyPolGA0AqPKZZL9y8fB98KAoyNAXw2WVsOio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hO+9c4PtpmUZcKLtoHArE8VkpW5vcD/5S3cL/oNOXbMHdcWL6wBggysfDThcTinoqZOxO01lrfgZW/JRxCPFF2mGqwPKXX3FSd5lSHWM5puCu0fMN19bdQ+a6ovRELhaObr/clQZsvgB4XUD0bADZCYdPy8ntkbo+e+hv9mb6HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqaXG7BH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763652353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86uLFKiUzyybY9jmd/IJawWDLIWLvoZFmDu2y+UwGTc=;
	b=fqaXG7BHp3ndOW6fyJOC2A5WWbJ3/+f+9nilw82rM9uQ8dRwfzVo86llq0QEfg9GqTGkm8
	GHM9JH2oil2TplvZiQUU5dLH7BU5JoWRrUDjN4itul8icTHL1OdcMF6s5BS3vI2AAh7KEh
	N6QA8FgBoY4JgiSjSIgeuvb4T+CZ/vc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-bGUcSfg4PRi72H6ca0YtSw-1; Thu,
 20 Nov 2025 10:25:47 -0500
X-MC-Unique: bGUcSfg4PRi72H6ca0YtSw-1
X-Mimecast-MFC-AGG-ID: bGUcSfg4PRi72H6ca0YtSw_1763652346
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8869E18997DA;
	Thu, 20 Nov 2025 15:25:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F27330044DC;
	Thu, 20 Nov 2025 15:25:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] cifs: Add the smb3_read_* tracepoints to SMB1
Date: Thu, 20 Nov 2025 15:25:14 +0000
Message-ID: <20251120152524.2711660-2-dhowells@redhat.com>
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
index 257a6beb4b7d..428e582e0414 100644
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
 


