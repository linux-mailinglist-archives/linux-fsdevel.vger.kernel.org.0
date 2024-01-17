Return-Path: <linux-fsdevel+bounces-8174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C420830ABC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C73928C8AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8059E224C2;
	Wed, 17 Jan 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agPpuU2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2122319
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508092; cv=none; b=BmuOP+/vXWn2Ik6VOQ5BDv1B86WJ7kTKUJoPcHI8nyLvR00JWmEfXowPsjbrRBuMsho2A9hzCv1YHQKpEN6HpA1FqplVfKQ1og+anucMfi1CdvIYB3/WJk/5nPFXORf8jjg16oOojqHa9lZbJSulxjrpdvVvXkAMt7QpahKyxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508092; c=relaxed/simple;
	bh=NNp7EBLIzaXw/7mCitS2vMhUdRanFmB9E2Mm7QsT++E=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:
	 Organization:From:To:cc:Subject:MIME-Version:Content-Type:
	 Content-ID:Content-Transfer-Encoding:Date:Message-ID:X-Scanned-By;
	b=Y4YHm9vdUiICKQRN5e/21B4N+UW0rs0dfdhHAjBCDNR2X7it/gyi7TJLUT+O2HsPFsvKEYpJdQbTFdNFk5enHVc4aVIawEnTV9F9+DaYrYKT410qNhGqsXvMRfiVDR1NA7G4CIbdA4RTqcKVA8jLtLPS8g21XU4Le4TAV2n4Yds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agPpuU2s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705508089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LeaeQDlEh2LuJK20KLIGSOeAcFEeBt+olazsW/kSruE=;
	b=agPpuU2s5zctwddTj7OoBnN9ZTlPxfXOoKV4LWtLhULHBVkmBr2zYstzYE3i4EDhjzWO4v
	+7Zh58cxLy96d32O1in9OGz3NpdHQ3mRDBuwPMYahRh6XAPEeQuw+pZCCZTqgEWudd+khk
	kDPcGlOYCRh6qwQZAObx8CJOn2XpqjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-V68_g6WuPauNusTbKnV1XA-1; Wed, 17 Jan 2024 11:14:43 -0500
X-MC-Unique: V68_g6WuPauNusTbKnV1XA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B75D85A58F;
	Wed, 17 Jan 2024 16:14:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0DA12026D6F;
	Wed, 17 Jan 2024 16:14:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix missing/incorrect unlocking of RCU read lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2929033.1705508081.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 16:14:42 +0000
Message-ID: <2929034.1705508082@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

In afs_proc_addr_prefs_show(), we need to unlock the RCU read lock in both
places before returning (and not lock it again).

Fixes: f94f70d39cc2 ("afs: Provide a way to configure address priorities")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/proc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 3bd02571f30d..15eab053af6d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -166,7 +166,7 @@ static int afs_proc_addr_prefs_show(struct seq_file *m=
, void *v)
 =

 	if (!preflist) {
 		seq_puts(m, "NO PREFS\n");
-		return 0;
+		goto out;
 	}
 =

 	seq_printf(m, "PROT SUBNET                                      PRIOR (v=
=3D%u n=3D%u/%u/%u)\n",
@@ -191,7 +191,8 @@ static int afs_proc_addr_prefs_show(struct seq_file *m=
, void *v)
 		}
 	}
 =

-	rcu_read_lock();
+out:
+	rcu_read_unlock();
 	return 0;
 }
 =


