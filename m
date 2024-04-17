Return-Path: <linux-fsdevel+bounces-17108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9238A7EA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 10:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECD71C218D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C0F12C80B;
	Wed, 17 Apr 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcZ4Db8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7912B170
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343654; cv=none; b=c6o8yAVLPcMjoB2+YxIBKw9ONXN7WZ2/QLGEhWfAsE7/SOHc7smMCkpvobTgJ3frowjW8MHOpEnq8jILJxJ3TLvRd0gQqVKRPHUmTFP1j5HTFNfczKf5HjZM94tEZ+iEjwoDRoC5JYPKU2bcP3ofZX+ZZFJmjVbKUO+OW6lra9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343654; c=relaxed/simple;
	bh=FzkSsyVA3DqH+Qb0YG94ZILKeOZaj7ifhswsxDiiqfk=;
	h=To:cc:Subject:MIME-Version:Content-Type:From:Date:Message-ID; b=rlh6W1opV2eRWWN3P11q/aC+bK6uhdxxFyC00VCueiZWpmZ1WAe1UufPt7WffQM36VdJY/VknITMF4kLJTUZe5ymIbq5NRYxOH/MnSUdsdHXDKPSZOJ2oz4BLH+4EzfZ7jlr7N0NWnTDDwTXd/Mt7wcRdMEcda0qnIKJJqdcCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcZ4Db8Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713343651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S/MMEzxbl19W2vLclxih4GIBuPLFZ2AxlUuzHcCQFgU=;
	b=DcZ4Db8Y9REk7dytqXe2byS5plUybQ/Qe/2ZDKIM1zKsHJl0XMkjWMRifEWAOG8MbO1RHc
	omxTQU/MClQT2QQ3HaRwtr8aFrV40gxoiuubluJAB0uOkpSWghoHVFg6GLKEHhKOn7i2ga
	8+oi2+tgl+pb6l2EgUXwf7nq6nxCV7c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-sNk2jFwvMP2Y4fvxfa_78w-1; Wed,
 17 Apr 2024 04:47:26 -0400
X-MC-Unique: sNk2jFwvMP2Y4fvxfa_78w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB6C51C3F101;
	Wed, 17 Apr 2024 08:47:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16CC12026D06;
	Wed, 17 Apr 2024 08:47:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix writethrough-mode error handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6634.1713343604.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Wed, 17 Apr 2024 09:47:19 +0100
Message-ID: <6736.1713343639@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Fix the error return in netfs_perform_write() acting in writethrough-mode
to return any cached error in the case that netfs_end_writethrough()
returns 0.

This can affect the use of O_SYNC/O_DSYNC/RWF_SYNC/RWF_DSYNC in 9p and afs=
.

Fixes: 41d8e7673a77 ("netfs: Implement a write-through caching option")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
---
 fs/netfs/buffered_write.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 9a0d32e4b422..8f13ca8fbc74 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -164,7 +164,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct=
 iov_iter *iter,
 	enum netfs_how_to_modify howto;
 	enum netfs_folio_trace trace;
 	unsigned int bdp_flags =3D (iocb->ki_flags & IOCB_SYNC) ? 0: BDP_ASYNC;
-	ssize_t written =3D 0, ret;
+	ssize_t written =3D 0, ret, ret2;
 	loff_t i_size, pos =3D iocb->ki_pos, from, to;
 	size_t max_chunk =3D PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	bool maybe_trouble =3D false;
@@ -395,10 +395,12 @@ ssize_t netfs_perform_write(struct kiocb *iocb, stru=
ct iov_iter *iter,
 =

 out:
 	if (unlikely(wreq)) {
-		ret =3D netfs_end_writethrough(wreq, iocb);
+		ret2 =3D netfs_end_writethrough(wreq, iocb);
 		wbc_detach_inode(&wbc);
-		if (ret =3D=3D -EIOCBQUEUED)
-			return ret;
+		if (ret2 =3D=3D -EIOCBQUEUED)
+			return ret2;
+		if (ret =3D=3D 0)
+			ret =3D ret2;
 	}
 =

 	iocb->ki_pos +=3D written;


