Return-Path: <linux-fsdevel+bounces-26275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC56956E8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D14A283141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0445BEC;
	Mon, 19 Aug 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilEtQEjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37145BE3
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080646; cv=none; b=dPrlZadN/rwWH/Ddrh26ymYf4DDClr5QVkb8/taMgQU1H38jRNCrU4UH4f5tp8X1ApZj+pcMLTNLDo8hRyLy6PW+gNJKx6RbMHM43s/bsO0CfagGbO6HP6FKBkcpz7BgEMnYsT26UZ3URnaWyx2VrXdqNIBORYlKLtHQp5RqR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080646; c=relaxed/simple;
	bh=79dx5kJlbp/APxcDTBvNrtwqZA9zos8u2hlpu6v2cxE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=eL/KN0GjptaS+8Fy+agmyz0z5HRzgnvP+baLld3H7BH9uKiMigtLuVR3F2qp0ckDNTwBOKZoGW5pke30BCAGcb1q9kjbg5FwstpEqBx0ZLuBWxpz9DWEgKOgNvsBkQdpSnVQwCkQSr6Kx/aVf+WQ2jGuEHb6LrnFgBVyxoOBPd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilEtQEjs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724080642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oMbslWyUxniTyVqSh/iKY0BQR2pIPVrXRKHLsZfPgg=;
	b=ilEtQEjsGo3az8D3tbDeRHjtQaasdeF0kyluqFUWtWoyQ8mGrACbdq4Y42T341nh++TGtO
	a0TknstzwH1psfH1H8SeKq/3jL6xz4PQrYGBvdR2V8mHz2A5phAdaAE9UjbOpWtVOl7MJk
	PmaUhOaP25xyxal0MEg+5M1VAiu0/Gs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-mFqV8Sn2ONiReiz4ntrKfw-1; Mon,
 19 Aug 2024 11:17:21 -0400
X-MC-Unique: mFqV8Sn2ONiReiz4ntrKfw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A6B41956080;
	Mon, 19 Aug 2024 15:17:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1139719792D8;
	Mon, 19 Aug 2024 15:17:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2924797.1723836663@warthog.procyon.org.uk>
References: <2924797.1723836663@warthog.procyon.org.uk> <20240815090849.972355-1-kernel@pankajraghav.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: dhowells@redhat.com, brauner@kernel.org, akpm@linux-foundation.org,
    chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
    djwong@kernel.org, hare@suse.de, gost.dev@samsung.com,
    linux-xfs@vger.kernel.org, hch@lst.de, david@fromorbit.com,
    Zi Yan <ziy@nvidia.com>, yang@os.amperecomputing.com,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    willy@infradead.org, john.g.garry@oracle.com,
    cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
    ryan.roberts@arm.com
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3452630.1724080629.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Aug 2024 16:17:09 +0100
Message-ID: <3452631.1724080629@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Okay, the code in netfs_invalidate_folio() isn't correct in the way it red=
uces
streaming writes.  Attached is a patch that shows some of the changes I ne=
ed
to make - but this is not yet working.

David
---
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index eaa0a992d178..e237c771eeb5 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -214,18 +215,34 @@ void netfs_invalidate_folio(struct folio *folio, siz=
e_t offset, size_t length)
 		/* We have a partially uptodate page from a streaming write. */
 		unsigned int fstart =3D finfo->dirty_offset;
 		unsigned int fend =3D fstart + finfo->dirty_len;
-		unsigned int end =3D offset + length;
+		unsigned int iend =3D offset + length;
 =

 		if (offset >=3D fend)
 			return;
-		if (end <=3D fstart)
+		if (iend <=3D fstart)
+			return;
+
+		/* The invalidation region overlaps the data.  If the region
+		 * covers the start of the data, we either move along the start
+		 * or just erase the data entirely.
+		 */
+		if (offset <=3D fstart) {
+			if (iend >=3D fend)
+				goto erase_completely;
+			/* Move the start of the data. */
+			finfo->dirty_len =3D fend - iend;
+			finfo->dirty_offset =3D offset;
 			return;
-		if (offset <=3D fstart && end >=3D fend)
-			goto erase_completely;
-		if (offset <=3D fstart && end > fstart)
-			goto reduce_len;
-		if (offset > fstart && end >=3D fend)
-			goto move_start;
+		}
+
+		/* Reduce the length of the data if the invalidation region
+		 * covers the tail part.
+		 */
+		if (iend >=3D fend) {
+			finfo->dirty_len =3D offset - fstart;
+			return;
+		}
+
 		/* A partial write was split.  The caller has already zeroed
 		 * it, so just absorb the hole.
 		 */
@@ -238,12 +261,6 @@ void netfs_invalidate_folio(struct folio *folio, size=
_t offset, size_t length)
 	folio_clear_uptodate(folio);
 	kfree(finfo);
 	return;
-reduce_len:
-	finfo->dirty_len =3D offset + length - finfo->dirty_offset;
-	return;
-move_start:
-	finfo->dirty_len -=3D offset - finfo->dirty_offset;
-	finfo->dirty_offset =3D offset;
 }
 EXPORT_SYMBOL(netfs_invalidate_folio);
 =


