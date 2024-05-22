Return-Path: <linux-fsdevel+bounces-19989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055848CBD1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 10:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FE2282A0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618048004B;
	Wed, 22 May 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRJ8dHUr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689EF7E0E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367138; cv=none; b=pxY/LP1DIosJXm7X2m0gj3hQu/9h/eBCMRQ5oLD89tTkU1O6f0oIjU6uoJe170nvGfhXGJT5S2/8ENocXQkcyqzskh+xUZKqKvbAJV+xLPxcWYsyJYQwBW76eSsR6GQ1kMHJMskCy4x0lkhWOWfkrpmLssE+QI1k+giUTmk353I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367138; c=relaxed/simple;
	bh=/RnVnFs+KBCUyJM9I5ehIQyQQbahNe1uMoXF8W9mSLQ=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=juwtrjJ2pQmZ/5aiDzvnvXKKUvCPR23aTBY7exQzwjE4o0EHv+TdJtkaToU3U5+9YYslsIJpEGNNbXGdA7/moScH7kwdxXFygM0GEmx263rwxjM4rb0PpL8S4w9vt4libGdVKKfL1WvVvGOrnxyJEctBr+EmnNA4lAAHDqvffhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRJ8dHUr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716367135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQwhx3neX6nMoV4M7dECoGraKOSt02xj+EKmgIl1zZ4=;
	b=RRJ8dHUrSEpnEuDi1h+4sD/zDB69TgocZ3p4x46UABflA4SPACvMcxk17skwDwOCI54Flp
	4fNd+gzyCBgtBPDD/q1fWFYzfwZKoUVrWQWMYD5UKYq6OxtvkG5V2+IeaDrnjLzquDbirw
	vikS+cCoc2zdN7TKDgtVfq+96E8FxI4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-hqowDmYNMsW252bSaIgkLQ-1; Wed, 22 May 2024 04:38:51 -0400
X-MC-Unique: hqowDmYNMsW252bSaIgkLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07227101A52C;
	Wed, 22 May 2024 08:38:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 419C3200A35C;
	Wed, 22 May 2024 08:38:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix smb3_insert_range() to move the zero_point
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <367855.1716367128.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 May 2024 09:38:48 +0100
Message-ID: <367856.1716367128@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Fix smb3_insert_range() to move the zero_point over to the new EOF.
Without this, generic/147 fails as reads of data beyond the old EOF point
return zeroes.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
---
 fs/smb/client/smb2ops.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ef18cd30f66c..b87b70edd0be 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3636,6 +3636,7 @@ static long smb3_insert_range(struct file *file, str=
uct cifs_tcon *tcon,
 	rc =3D smb2_copychunk_range(xid, cfile, cfile, off, count, off + len);
 	if (rc < 0)
 		goto out_2;
+	cifsi->netfs.zero_point =3D new_eof;
 =

 	rc =3D smb3_zero_data(file, tcon, off, len, xid);
 	if (rc < 0)


