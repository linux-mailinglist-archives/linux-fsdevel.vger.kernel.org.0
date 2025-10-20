Return-Path: <linux-fsdevel+bounces-64664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE210BF0367
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88FF134A090
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8972F6189;
	Mon, 20 Oct 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fp6jufgC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42B2F6183
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953092; cv=none; b=eVUW59rhgSz2DFVhpAmTiEOjYQyJmV1w+OcS+wYJbHMnMXdlGmfI+dAtOk9tFQ1cJ6kWomDxICa0+yyfN8eknZBFqZOEqF3hzyRvSUDhXkbI40+woX1b4xxaeBvEGxmpMbP6L/clltuj2Zr2dG4hRNWWM1/mL09gJ+T8VIWDhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953092; c=relaxed/simple;
	bh=Y4akFPyqNZ4gnOcCriXi9WLSyaE0UFAHWq70mLAc43s=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=IgW7K1c1/iWuV4WHlQLdT4KF94sCEq6ZQ4EzEC0qm49ysdFKsXWv6vdktp5lBXkts+Sxj6X7fc7xTn9HBav1GgUSBK67ItMy6uvAhmD7uFa9rgQzlS3q5dFcRlP5TgUE5nJrKrzD6VGV5PxNbOZfXfXjb6L2lw9NAv9zL1nKJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fp6jufgC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760953086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFGptIdtZBHmiHibVZMuWEQ14EDEx3uCXIG9Z8fctL4=;
	b=Fp6jufgCpMt4hDnUNjlFLnSsQj2Kz8W4jXkVR9XBv6iNyonJqEmHz587Vym7si+tPlsRHz
	kr9b0kOr+mcPoyCbMiu0WXg3v3xLx/EmLlcM+kgvozT2BYuyT5L6v2yKHWzfEWeG5VxiTE
	vp2z6gTeN4upPRMKNvgzx8FrRNoAE/I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-Oj_gfafkMAqmNfTMrMK-ZQ-1; Mon,
 20 Oct 2025 05:38:04 -0400
X-MC-Unique: Oj_gfafkMAqmNfTMrMK-ZQ-1
X-Mimecast-MFC-AGG-ID: Oj_gfafkMAqmNfTMrMK-ZQ_1760953083
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 092A919560B2;
	Mon, 20 Oct 2025 09:38:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB4EB19560A2;
	Mon, 20 Oct 2025 09:38:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Add a couple of missing smb3_rw_credits tracepoints
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1040866.1760953079.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Oct 2025 10:37:59 +0100
Message-ID: <1040867.1760953079@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add missing smb3_rw_credits tracepoints to cifs_readv_callback() (for SMB1=
)
to match those of SMB2/3.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifssmb.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 7368479ac9c4..6acec5a229ac 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1294,6 +1294,8 @@ cifs_readv_callback(struct TCP_Server_Info *server, =
struct smb_message *smb)
 		.rreq_debug_id =3D rdata->rreq->debug_id,
 		.rreq_debug_index =3D rdata->subreq.debug_index,
 	};
+	unsigned int rreq_debug_id =3D rdata->rreq->debug_id;
+	unsigned int subreq_debug_index =3D rdata->subreq.debug_index;
 =

 	cifs_dbg(FYI, "%s: mid=3D%llu state=3D%d result=3D%d bytes=3D%zu\n",
 		 __func__, smb->mid, smb->mid_state, rdata->result,
@@ -1357,12 +1359,18 @@ cifs_readv_callback(struct TCP_Server_Info *server=
, struct smb_message *smb)
 			__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
 	}
 =

+	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.=
value,
+			      server->credits, server->in_flight,
+			      0, cifs_trace_rw_credits_read_response_clear);
 	rdata->credits.value =3D 0;
 	rdata->subreq.error =3D rdata->result;
 	rdata->subreq.transferred +=3D smb->resp_data_len;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
 	add_credits(server, &credits, 0);
+	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
+			      server->credits, server->in_flight,
+			      credits.value, cifs_trace_rw_credits_read_response_add);
 }
 =

 /* cifs_async_readv - send an async write, and set up mid to handle resul=
t */


