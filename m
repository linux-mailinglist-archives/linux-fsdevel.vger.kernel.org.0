Return-Path: <linux-fsdevel+bounces-14280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB387A6C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 12:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBF51C22B73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8129443AD5;
	Wed, 13 Mar 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MA8R7KyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5674205F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328129; cv=none; b=sRiy7vtVM5QbbLbywy0iAuoRLVdFV2uWfi3je7qr0KQrGuE3XjsRqkygpRYR+WCOdD66IzRYqCgMXZu/MGOKYLE14O+Z42DOCD6n3AiL+MD4BQ/x6KDTTdngDQQluBFfs5u8GETDuEOHjl0eD4ju4E+kcxq1kkiR8ghxP/R4G74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328129; c=relaxed/simple;
	bh=luniAF9OyE9AxjoQ87oukSfN2nAfisuW4QkMcg5MzAo=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=fRDURdRsXBQ2EXbCiApDKs1lwLW0oi1v9ILBw6klFdnVLGSyIWmkETruIkgq83jcClGAup1fFqGbk04y6dYBe4KSZyqy7GMmh3wkZuZlt7Uwn0NdGx5Ph3aC/+IpF4G7qN7Xhn3VnXGEKSds4U6cAzWMrV/U4r2gi4xElx88EiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MA8R7KyK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710328126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QTP9uAHVPvXi9wcTkRv8pSjlNhXJ/YsIlYMbNyFLnuo=;
	b=MA8R7KyK1I1up5YV3Ofbj4bbi0kQZELBJAa/DHnG9C7qnlgTxn814m1mVv5Mmxam8ggGhQ
	PeYDjvYiAI7/UJejyPyGhfCAwRerCOlFvOBAYh+4QqQ81mEA0Yik5U/V23AY9zHRrK0e1D
	fHMrepMJy7vdYbYuZ+zz2cuB4eYPwws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-6Zq0fiNLPpuMq8oycQT-rA-1; Wed, 13 Mar 2024 07:08:43 -0400
X-MC-Unique: 6Zq0fiNLPpuMq8oycQT-rA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2579487280B;
	Wed, 13 Mar 2024 11:08:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D2DB492BC7;
	Wed, 13 Mar 2024 11:08:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>,
    Markus Suvanto <markus.suvanto@gmail.com>
cc: dhowells@redhat.com, Jeffrey Altman <jaltman@auristor.com>,
    Christian Brauner <brauner@kernel.org>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Revert "afs: Hide silly-rename files from userspace"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3085694.1710328121.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Mar 2024 11:08:41 +0000
Message-ID: <3085695.1710328121@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

    =

This reverts commit 57e9d49c54528c49b8bffe6d99d782ea051ea534.

This undoes the hiding of .__afsXXXX silly-rename files.  The problem with
hiding them is that rm can't then manually delete them.

This also reverts commit 5f7a07646655fb4108da527565dcdc80124b14c4 ("afs: F=
ix
endless loop in directory parsing") as that's a bugfix for the above.

Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/008102=
.html
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8a67fc427e74..67afe68972d5 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -474,16 +474,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dv=
node,
 			continue;
 		}
 =

-		/* Don't expose silly rename entries to userspace. */
-		if (nlen > 6 &&
-		    dire->u.name[0] =3D=3D '.' &&
-		    ctx->actor !=3D afs_lookup_filldir &&
-		    ctx->actor !=3D afs_lookup_one_filldir &&
-		    memcmp(dire->u.name, ".__afs", 6) =3D=3D 0) {
-			ctx->pos =3D blkoff + next * sizeof(union afs_xdr_dirent);
-			continue;
-		}
-
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
 			      ntohl(dire->u.vnode),


