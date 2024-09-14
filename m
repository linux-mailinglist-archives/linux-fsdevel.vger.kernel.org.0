Return-Path: <linux-fsdevel+bounces-29392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20340979354
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 22:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C412D283C2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98BE12FF71;
	Sat, 14 Sep 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvKh6HNk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7721433BB
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726346415; cv=none; b=KHZONnYRXcdqCaOfLc8jK1l5WdFPfPkpvqtapyngxtpVE0x/5Tgm+0NG7lv4jrnW9i6JIxA7Qj4SYu2zHbzK4mhPZGTERh+oGKFamZmezoh1c4syug+/BOm4gjzd2RoCF2wkl+KW8pf3hnpGRtXAQPaFBpw8YG7Yl4pIpYDMOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726346415; c=relaxed/simple;
	bh=8uxyuUaxJOkH8vX/RGr3kDFl9I63UzbJ+nTNCh6D+/U=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=RP7YvC0cQOtXiSUkJZDE25hUckBA1d78Ob+AI4Uu2OVZrUeA8d+NEXRXN+a4IoM6x5qEWsvUxAejWWayml8VK+1uLHgAAILeTelC7ue/CPnceU/Ge30IlIBwVkZQHJkRx5zQA/fQXJ/0MnVBQ978QuHcJof/dG8+gDJ4+awc7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvKh6HNk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726346411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RfizNILj8Bic7UhBJkx7foDXeeUTZejgV3kKoRryAVc=;
	b=AvKh6HNkkNFslb1EhNUd7BzW0i/FspEuMc1N9g2r/5LFD3nbs0EQxr5KzfxCpgHAA8yEyk
	lMAz9+DPGzPiQS7nB2LHVRHt77iQUWNVslCUd6wRkscVPk6ZDqpeTYKHa1+xXPig6XPV2u
	cmZ7fmswYrBK68DqISbANVHA/jbI9NM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-vDdsiWTFMj6PNxmjdDY64Q-1; Sat,
 14 Sep 2024 16:40:08 -0400
X-MC-Unique: vDdsiWTFMj6PNxmjdDY64Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 800C71956089;
	Sat, 14 Sep 2024 20:40:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D252D30001AB;
	Sat, 14 Sep 2024 20:40:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, "Dr. David Alan Gilbert" <linux@treblig.org>,
    brauner@kernel.org, Jeff Layton <jlayton@kernel.org>,
    linux-afs@lists.infradead.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix missing wire-up of afs_retry_request()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1690846.1726346402.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Sep 2024 21:40:02 +0100
Message-ID: <1690847.1726346402@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

afs_retry_request() is supposed to be pointed to by the afs_req_ops netfs
operations table, but the pointer got lost somewhere.  The function is use=
d
during writeback to rotate through the authentication keys that were in
force when the file was modified locally.

Fix this by adding the pointer to the function.

Fixes: 1ecb146f7cd8 ("netfs, afs: Use writeback retry to deal with alterna=
te keys")
Reported-by: "Dr. David Alan Gilbert" <linux@treblig.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index ec1be0091fdb..290f60460ec7 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -404,6 +404,7 @@ const struct netfs_request_ops afs_req_ops =3D {
 	.begin_writeback	=3D afs_begin_writeback,
 	.prepare_write		=3D afs_prepare_write,
 	.issue_write		=3D afs_issue_write,
+	.retry_request		=3D afs_retry_request,
 };
 =

 static void afs_add_open_mmap(struct afs_vnode *vnode)


