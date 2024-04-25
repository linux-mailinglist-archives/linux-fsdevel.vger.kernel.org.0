Return-Path: <linux-fsdevel+bounces-17724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B128B1CED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 10:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9DBAB2280D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649E48005B;
	Thu, 25 Apr 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVoU3rDp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C641772F
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034382; cv=none; b=D8MBkuv5gTn/aHB3b007MrznaHr1ltJ3yfi5UdvQ2SxPEaKI8Z24WUAgHLuGy5KhBPLfSZgbLPXPqqwn17jYxoARTZgIO0pvI1UgeqWI3JIxXP3Mq9jAWRLFpw4aQETRwW9iQzXbMW6YTDuaJnW23sUQUTKF4oxJFjpLxL2kwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034382; c=relaxed/simple;
	bh=/9yyKzE8Zxtr4YeXsLr5diSzcU8HNZj+vrs/DZ3QOog=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=lblUqX7Wenw5g3pGYnxTq9IrKuzyDpvELwDSoZTrbfFDD64zB9rjpTxAyYA5EJRN0lI5/Ocz/d48K7lU5vU4/xMZwhyhJLfrCSZ6WTZUWbB6nz3BN5/tIPXGWct3iBkUWVpl+ayJ54OnTAvbJ59Wc8UL2gVvCDtgs2uAo+FuroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVoU3rDp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714034379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QZ3es0/m9Be3HXMWlawHrU+ruWvHPUrW+BQXBx/9QME=;
	b=IVoU3rDpUsnxmN4Xn1n1DGYR+kjfpJFe51XitIxifI1f5XTxf8bkI/rMMf2aHHmNVbXjrv
	kJBUq234jKedENLX9n3ZKtemSWj9H29dgblSdNLLBbLON26SeCutrD57zLadMRazjf6Q2h
	0PGDKazvGbQCHEZ2e4Xh1/oRRznTuMM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-e4mtFl2tPqGayEHnj_tMnw-1; Thu,
 25 Apr 2024 04:39:36 -0400
X-MC-Unique: e4mtFl2tPqGayEHnj_tMnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85DBE29AA391;
	Thu, 25 Apr 2024 08:39:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 829E551BF;
	Thu, 25 Apr 2024 08:39:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Steve French <sfrench@samba.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, netfs@lists.linux.dev,
    linux-crypto@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] Fix a potential infinite loop in extract_user_to_sg()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1967120.1714034372.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Apr 2024 09:39:32 +0100
Message-ID: <1967121.1714034372@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

    =

Fix extract_user_to_sg() so that it will break out of the loop if
iov_iter_extract_pages() returns 0 rather than looping around forever.

[Note that I've included two fixes lines as the function got moved to a
different file and renamed]

Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC int=
o a BVEC iterator")
Fixes: f5f82cd18732 ("Move netfs_extract_iter_to_sg() to lib/scatterlist.c=
")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: netfs@lists.linux.dev
cc: linux-crypto@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: netdev@vger.kernel.org
---
 lib/scatterlist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 68b45c82c37a..7bc2220fea80 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1124,7 +1124,7 @@ static ssize_t extract_user_to_sg(struct iov_iter *i=
ter,
 	do {
 		res =3D iov_iter_extract_pages(iter, &pages, maxsize, sg_max,
 					     extraction_flags, &off);
-		if (res < 0)
+		if (res <=3D 0)
 			goto failed;
 =

 		len =3D res;


