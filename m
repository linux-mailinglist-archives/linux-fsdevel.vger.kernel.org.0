Return-Path: <linux-fsdevel+bounces-29157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2B97684C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA9F1C219EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5173F1A262F;
	Thu, 12 Sep 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c60cbSQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47F1A3AA6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141818; cv=none; b=dhvgHTg4eyOaTRlVZZlvitnSPGW75VMBuYg3gkGj8aKO9b7TkmkrvzIAIg67UgjMAfJYPfD3S9kxnoAaTa6F5dfJSt3Wic+G//bgf0b3NM3Fx4zzYyjGa22NX2G9vdiLp8ZgSVA4OhOVWATwfeoPqDv9dctyOpfuYzpWmUwmu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141818; c=relaxed/simple;
	bh=Xl6nNLBK8GTBKxLIKD61vE0uvYByirFE263h76WjaRM=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=mOwxGBBj2zbMb2nE7dzol62XzCjFhh2MbzXA77OI4UtYJ8Wuc2LDcMILG9j+OU541yBAfDYpFPiUu9Wi+XuznCP48YGFzRY+I9dg7Pg8K9vmmDwWYN7ZpqeOQ74l58vDFPnA1NpeQJXtftVP1lILZ496kw79tBYli3Ou6oYIyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c60cbSQ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726141816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jLN3U1yZ7TMderZrIcQLdov+Z22mdFuW5sMvjEe338o=;
	b=c60cbSQ6ECuz5CYf30bQT21XKzAF2vUr3AaRfycsazw8kc1hhv3LjCx63uQua0fynN39ni
	IKxLHo1+o5sfXjqIl2HP2UQXzkaAurVjauw18Tn2FSNWeUFSAetouxrr0vfACo3Sd1/CMr
	pOZetFAZcrH3qVJxk5u3rd/F5U8NzFs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-FdrR9fltPha0VMOFb_6fTA-1; Thu,
 12 Sep 2024 07:50:13 -0400
X-MC-Unique: FdrR9fltPha0VMOFb_6fTA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3217197702F;
	Thu, 12 Sep 2024 11:50:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FA4519560AA;
	Thu, 12 Sep 2024 11:50:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
    Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Jeff Layton <jlayton@kernel.org>,
    Stephen Rothwell <sfr@canb.auug.org.au>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix up netfs-writeback vs cifs fixes merge conflicts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1131387.1726141806.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 12:50:06 +0100
Message-ID: <1131388.1726141806@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

    =

Fix up the conflicts between the netfslib development patches and cifs fix
commits due to:

        a68c74865f517e26728735aba0ae05055eaff76c
        cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3

conflicting with:

        ee4cdf7ba857
        netfs: Speed up buffered reading"

This will need to be applied if/when Christian's vfs.netfs branch is merge=
d.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifssmb.c |   14 +++++++-------
 fs/smb/client/smb2pdu.c |    2 --
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6ad22732c25c..d0df0c17b18f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1266,9 +1266,7 @@ static void cifs_readv_worker(struct work_struct *wo=
rk)
 	struct cifs_io_subrequest *rdata =3D
 		container_of(work, struct cifs_io_subrequest, subreq.work);
 =

-	netfs_subreq_terminated(&rdata->subreq,
-				(rdata->result =3D=3D 0 || rdata->result =3D=3D -EAGAIN) ?
-				rdata->got_bytes : rdata->result, true);
+	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
 }
 =

 static void
@@ -1327,9 +1325,9 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 		rdata->result =3D 0;
 	} else {
-		if (rdata->got_bytes < rdata->actual_len &&
-		    rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes =
=3D=3D
-		    ictx->remote_i_size) {
+		size_t trans =3D rdata->subreq.transferred + rdata->got_bytes;
+		if (trans < rdata->subreq.len &&
+		    rdata->subreq.start + trans =3D=3D ictx->remote_i_size) {
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result =3D 0;
 		}
@@ -1337,7 +1335,9 @@ cifs_readv_callback(struct mid_q_entry *mid)
 =

 	rdata->credits.value =3D 0;
 	rdata->subreq.transferred +=3D rdata->got_bytes;
-	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
+	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
+	INIT_WORK(&rdata->subreq.work, cifs_readv_worker);
+	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 95377bb91950..bb8ecbbe78af 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4614,8 +4614,6 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			      0, cifs_trace_rw_credits_read_response_clear);
 	rdata->credits.value =3D 0;
 	rdata->subreq.transferred +=3D rdata->got_bytes;
-	if (rdata->subreq.start + rdata->subreq.transferred >=3D rdata->subreq.r=
req->i_size)
-		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);


