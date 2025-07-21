Return-Path: <linux-fsdevel+bounces-55602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A4B0C64C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 16:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141E53BDEAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD772DC33E;
	Mon, 21 Jul 2025 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXInwfsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194F2DCBEB
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108163; cv=none; b=tTp36fCVgoyE7PTugEGvoIpLfs7aY5XwQYwa4xuydKOXV53L2+Z/Psi/YYy61R6UdCAWVJyoPv/JzOSQf9QVeAUhdvbfdH9oYZ1UGtwQeOnGke76GtCq6s3XW2O62YincC/s11TSTPYMwFGOjwJ4kWqVTo6CZj75phGqBLKwDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108163; c=relaxed/simple;
	bh=iHe7cGXyYDxMNCHh98eCdGiCWKtr62no05iRPRviqGA=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=iE28n24rlGQynwKgN4JdOctryA/STDEC8JfHlYWkZT+ldlxOZilb89YDNXlVu243nt/Yo7lMM0eJCC63JBf4KLfifLUYUZNWCRhCuND0DfjjX2szBZbVo40h9UO8AeYotnLLvEDnBuhJCrooYv+OKwHhEBGDxtCon5OMfa4SbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXInwfsi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753108160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wn/awrDmxUHRt5lmLV5MDEAnIMFXTouB6K/+H1Q/U5U=;
	b=VXInwfsiyP8DgwAzESYd1H7POoXs08WZatmn1bv3LKzXVLw3f/qwxfGqIn0hrj+1PLIjqB
	Lj1eIQTUtyWPC4idTqNJbBRhvAuE3eIUNMEfBe27j92LYP3P4DMY6FNjdCeiu/J8vSAtrz
	MQZLIUIFj0ZPQbaEycYhSFqPcjYH4DY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-WLYSAqGwMsGQSRyon-Gy4A-1; Mon,
 21 Jul 2025 10:29:17 -0400
X-MC-Unique: WLYSAqGwMsGQSRyon-Gy4A-1
X-Mimecast-MFC-AGG-ID: WLYSAqGwMsGQSRyon-Gy4A_1753108155
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2986193E88A;
	Mon, 21 Jul 2025 14:29:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAACA1800D82;
	Mon, 21 Jul 2025 14:29:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com,
    syzbot+7741f872f3c53385a2e2@syzkaller.appspotmail.com,
    Leo Stone <leocstone@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix check for NULL terminator
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4119427.1753108152.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Jul 2025 15:29:12 +0100
Message-ID: <4119428.1753108152@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Leo Stone <leocstone@gmail.com>
    =

Add a missing check for reaching the end of the string while attempting
to split a command.

Fixes: f94f70d39cc2 ("afs: Provide a way to configure address priorities")
Reported-by: syzbot+7741f872f3c53385a2e2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D7741f872f3c53385a2e2
Signed-off-by: Leo Stone <leocstone@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/addr_prefs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/addr_prefs.c b/fs/afs/addr_prefs.c
index c0384201b8fe..133736412c3d 100644
--- a/fs/afs/addr_prefs.c
+++ b/fs/afs/addr_prefs.c
@@ -48,7 +48,7 @@ static int afs_split_string(char **pbuf, char *strv[], u=
nsigned int maxstrv)
 		strv[count++] =3D p;
 =

 		/* Skip over word */
-		while (!isspace(*p))
+		while (!isspace(*p) && *p)
 			p++;
 		if (!*p)
 			break;


