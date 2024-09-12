Return-Path: <linux-fsdevel+bounces-29188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BD976E4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E54284DED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B121B9832;
	Thu, 12 Sep 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWzgsHeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C968192B87
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156738; cv=none; b=OxgcR57Da6cBpymC+XJGpbQcS+fTJI6QuFx1Xkln6JJ0hPIqgJnymdp/d+vx7Su4cJ63VM1kEtdMxX2afPwO/IYdBBQQBEZiajGW3JlX2Tmbids2a1Od70GyDk6a2aUGD9bgB/mysF427L4kGLvCDuE4rahbGxZftPiylHEEZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156738; c=relaxed/simple;
	bh=2Ah+UB8jWbF2jpIVo3QtWSvjzROR0a+owJiVel0AMQs=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=dY69Og5R+8NKCk2SCu+troaZCOYRyMXdVJ35bCaGRaQhTmXDKNXB7D724orDInUmvFKloQLmjqQPKLFwP4GywmfdGXERtu+1frh3ZNH52Cfoh6E+E6q6zNhuHSKcJwd5TTjjaX4KtN/A+FcOI2p/ak0sU47Zr6SRFiGcZG+rS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWzgsHeV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726156735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YL60uZXjVMA/Ai1HS+Y5Ta5iPB8j6En/OIngcfUhpNs=;
	b=cWzgsHeVtPW2pf/qhAZKooQQCWFkpFU0I4d2UZzYwAlfn2WU7AevdL6C1h3jXsN9dhHeTE
	tipPIq4TKx4Fxd5QDfpl5qXEf5+FJ4x0u1RYE+MsjuGzILPIvTlNx0oINAlc7NT1i21gJJ
	Zh5aqZdWMUGpYJbQ9I9oHFSyclpGerQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-Hx4GskIqONK8Mkk5DvRy9g-1; Thu,
 12 Sep 2024 11:58:53 -0400
X-MC-Unique: Hx4GskIqONK8Mkk5DvRy9g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FF0B194510D;
	Thu, 12 Sep 2024 15:58:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98C241956052;
	Thu, 12 Sep 2024 15:58:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix signature miscalculation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1197026.1726156728.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 16:58:48 +0100
Message-ID: <1197027.1726156728@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

    =

Fix the calculation of packet signatures by adding the offset into a page
in the read or write data payload when hashing the pages from it.

Fixes: 39bc58203f04 ("cifs: Add a function to Hash the contents of an iter=
ator")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsencrypt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 6322f0f68a17..b0473c2567fe 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -129,7 +129,7 @@ static ssize_t cifs_shash_xarray(const struct iov_iter=
 *iter, ssize_t maxsize,
 			for (j =3D foffset / PAGE_SIZE; j < npages; j++) {
 				len =3D min_t(size_t, maxsize, PAGE_SIZE - offset);
 				p =3D kmap_local_page(folio_page(folio, j));
-				ret =3D crypto_shash_update(shash, p, len);
+				ret =3D crypto_shash_update(shash, p + offset, len);
 				kunmap_local(p);
 				if (ret < 0)
 					return ret;


