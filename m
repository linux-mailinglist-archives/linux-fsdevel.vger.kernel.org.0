Return-Path: <linux-fsdevel+bounces-44313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494ACA6727B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 12:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BBF3B06B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7D209F51;
	Tue, 18 Mar 2025 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YseUkDSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A746F208994
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296837; cv=none; b=O2MOxdsMu7r5kM8BW1Cfu1vr7ueJ2Uzmiadp5M5sT+HYDOgXgjEl6Tpfs6Srki+qQDtGYhfwA9hKpURKQuISajIYNVJcd4Ipzcwv9oH4TwEA1WJU6T+TYTEKZgRj/jVaPrzPklvLYNz8uMT16uj8o17gEmU1m13I/2gUXeXxpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296837; c=relaxed/simple;
	bh=I3mEF0CXp4fgaZehZjbMcukyS3xtgcmya3IHzsSTe/g=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=o7H9X9I/2qmu1F4pSuiNjAEAdDb8xwU+doSWgS8jNUAAVtD8Vbzr8qNMiY6TZmO9do2iqF1lEsjve/ykeP7YUYRggJR76g9Zws/6QjcBhdIQl+ozeRxa2DVChNPblsYO6w5Oeq2BXZrTmSnpb+rVYT928fXIV4qW6H6tFyfhZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YseUkDSz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742296830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vtocWDEfGRYd0c3G59HO/uUaWgBtC+TnrmN0auONqxI=;
	b=YseUkDSzmAR+lfyCsIlu0nQ8vm4tZ45tjA1uGlYXe7kJ4X4xWnyrgWyvWDaK7mmTISR3+S
	S5aHGduMZ9aQSfv8/NAiUDUqwQPPw8i6iImNc1yAH3R8vH0F7H9r0drw/VOXwiNM2/+fVo
	aHLO9xX2RtohQfDyEMsNzXPugsCAO+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-rj4eyDXtMCWKX69OuNMU7g-1; Tue,
 18 Mar 2025 07:20:24 -0400
X-MC-Unique: rj4eyDXtMCWKX69OuNMU7g-1
X-Mimecast-MFC-AGG-ID: rj4eyDXtMCWKX69OuNMU7g_1742296823
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECF30180025B;
	Tue, 18 Mar 2025 11:20:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEA611956094;
	Tue, 18 Mar 2025 11:20:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix afs_atcell_get_link() to check if ws_cell is unset first
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2481795.1742296819.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Mar 2025 11:20:19 +0000
Message-ID: <2481796.1742296819@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fix afs_atcell_get_link() to check if the workstation cell is unset before
doing the RCU pathwalk bit where we dereference that.

Fixes: 823869e1e616 ("afs: Fix afs_atcell_get_link() to handle RCU pathwal=
k")
Reported-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dynroot.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 9732a1e17db3..691e0ae607a1 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -210,6 +210,9 @@ static const char *afs_atcell_get_link(struct dentry *=
dentry, struct inode *inod
 	const char *name;
 	bool dotted =3D vnode->fid.vnode =3D=3D 3;
 =

+	if (!rcu_access_pointer(net->ws_cell))
+		return ERR_PTR(-ENOENT);
+
 	if (!dentry) {
 		/* We're in RCU-pathwalk. */
 		cell =3D rcu_dereference(net->ws_cell);
@@ -221,9 +224,6 @@ static const char *afs_atcell_get_link(struct dentry *=
dentry, struct inode *inod
 		return name;
 	}
 =

-	if (!rcu_access_pointer(net->ws_cell))
-		return ERR_PTR(-ENOENT);
-
 	down_read(&net->cells_lock);
 =

 	cell =3D rcu_dereference_protected(net->ws_cell, lockdep_is_held(&net->c=
ells_lock));


