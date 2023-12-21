Return-Path: <linux-fsdevel+bounces-6747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F081B975
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 15:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023011F225C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523EE6D6EE;
	Thu, 21 Dec 2023 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiCE/jW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F16D6D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703168639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TW/reE9xPc0IHxJZcKvgnG2qRH9ttpPMFz80v6EmDTg=;
	b=EiCE/jW4GKm5dZQUvowE+oIh6YTOL+EzT2cTxWx9BSjNUXD6G+K5fak4HG7xe9KPbIGAke
	goaFKEl4yrF+c/L/COF5kd+BI7VDBTT7MTWC5H77iQRy2Nlsb3SkyvnmfY2mA39tO7eNPn
	dvRX+FaJRQA8+1gkYAQCowHlvfhY3XM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-zQG30YRBP3awbjWww4paEA-1; Thu, 21 Dec 2023 09:23:55 -0500
X-MC-Unique: zQG30YRBP3awbjWww4paEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00113101A555;
	Thu, 21 Dec 2023 14:23:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48543492BC6;
	Thu, 21 Dec 2023 14:23:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Anastasia Belova <abelova@astralinux.ru>,
    Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    lvc-project@linuxtesting.org
Subject: [PATCH] afs: Fix overwriting of result of DNS query
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1700861.1703168632.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Dec 2023 14:23:52 +0000
Message-ID: <1700862.1703168632@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

In afs_update_cell(), ret is the result of the DNS lookup and the errors
are to be handled by a switch - however, the value gets clobbered in
between by setting it to -ENOMEM in case afs_alloc_vlserver_list() fails.

Fix this by moving the setting of -ENOMEM into the error handling for OOM
failure.  Further, only do it if we don't have an alternative error to
return.

Found by Linux Verification Center (linuxtesting.org) with SVACE.  Based o=
n
a patch from Anastasia Belova[1].

Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Anastasia Belova <abelova@astralinux.ru>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: lvc-project@linuxtesting.org
Link: https://lore.kernel.org/r/20231221085849.1463-1-abelova@astralinux.r=
u/ [1]

---
 fs/afs/cell.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 988c2ac7cece..926cb1188eba 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -409,10 +409,12 @@ static int afs_update_cell(struct afs_cell *cell)
 		if (ret =3D=3D -ENOMEM)
 			goto out_wake;
 =

-		ret =3D -ENOMEM;
 		vllist =3D afs_alloc_vlserver_list(0);
-		if (!vllist)
+		if (!vllist) {
+			if (ret >=3D 0)
+				ret =3D -ENOMEM;
 			goto out_wake;
+		}
 =

 		switch (ret) {
 		case -ENODATA:


