Return-Path: <linux-fsdevel+bounces-52909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44FFAE84E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D07C16388C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD54C2638B2;
	Wed, 25 Jun 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ga3wEviO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AE262FC5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858659; cv=none; b=KqRW1vFecUWuD1C7hlKg8F/7l3ItszbtIn+X8kv0wJRjMkMemPhVNppd0XVcHslWcbv8cET7p1xZpxEnsKqKXsGdmhwqqVD2iab417O1Z5lP2FphSsowkapq3rRmAqa+bHXM+jgm0tisOndimEgvOj0ScyOnLvdHiB3sq4sRwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858659; c=relaxed/simple;
	bh=wulRLZGJb3h5Sy6VUKgn3h/xZ4W+D9ycXw4/RiRXods=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=AxwYe8oKCUwVyeDw1oRXqsbadQIwgZkxQVn4FZnmlMGYYAYPDT75a4tAu5L8lgCdShBq3xuyI4cUjXTlGqnmGUbFeGWl07hEu+nVsn6pzDXmoWwL7S6bJpkZpJj+f5XWtcLmnim36r0WpAQBJhpicFUHpPrVY3h5BKZo9wpE8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ga3wEviO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750858654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DabOJJa1DrUsfTYb2fsq6yAk1bbwXjFbh/XQEYLvjZw=;
	b=ga3wEviOnLsZ2p8vlTcVKZS8dARmh27/PXWZ22uzmZcfXXR9miQS0X88hZLilP5Y3ECA5H
	QLz+tmgdH+3o7rNDvcRumI94I9CJDxjfRSnh52BMD57KjGbZu4ylHPMUBvHZoBby8xyqGG
	eM3iUMx0mmRErmNQzkyNhNaeg9thj+0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-FCApuVIYOliRWSVwHqg1qA-1; Wed,
 25 Jun 2025 09:37:29 -0400
X-MC-Unique: FCApuVIYOliRWSVwHqg1qA-1
X-Mimecast-MFC-AGG-ID: FCApuVIYOliRWSVwHqg1qA_1750858647
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9E5E1809C8A;
	Wed, 25 Jun 2025 13:37:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87FDA1956096;
	Wed, 25 Jun 2025 13:37:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Stefan Metzmacher <metze@samba.org>,
    Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix the smbd_request and smbd_reponse slabs to allow usercopy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1372500.1750858644.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jun 2025 14:37:24 +0100
Message-ID: <1372501.1750858644@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The handling of received data in the smbdirect client code involves using
copy_to_iter() to copy data from the smbd_reponse struct's packet trailer
to a folioq buffer provided by netfslib that encapsulates a chunk of
pagecache.

If, however, CONFIG_HARDENED_USERCOPY=3Dy, this will result in the checks
then performed in copy_to_iter() oopsing with something like the following=
:

 CIFS: Attempting to mount //172.31.9.1/test
 CIFS: VFS: RDMA transport established
 usercopy: Kernel memory exposure attempt detected from SLUB object 'smbd_=
response_0000000091e24ea1' (offset 81, size 63)!
 ------------[ cut here ]------------
 kernel BUG at mm/usercopy.c:102!
 ...
 RIP: 0010:usercopy_abort+0x6c/0x80
 ...
 Call Trace:
  <TASK>
  __check_heap_object+0xe3/0x120
  __check_object_size+0x4dc/0x6d0
  smbd_recv+0x77f/0xfe0 [cifs]
  cifs_readv_from_socket+0x276/0x8f0 [cifs]
  cifs_read_from_socket+0xcd/0x120 [cifs]
  cifs_demultiplex_thread+0x7e9/0x2d50 [cifs]
  kthread+0x396/0x830
  ret_from_fork+0x2b8/0x3b0
  ret_from_fork_asm+0x1a/0x30

The problem is that the smbd_response slab's packet field isn't marked as
being permitted for usercopy.

Fix this by passing parameters to kmem_slab_create() to indicate that
copy_to_iter() is permitted from the packet region of the smbd_response
slab objects.

Further, do the same thing for smbd_request slab objects and their packet
field.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Stefan Metzmacher <metze@samba.org>
Link: https://lore.kernel.org/r/acb7f612-df26-4e2a-a35d-7cd040f513e1@samba=
.org/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smbdirect.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index ef6bf8d6808d..5915273636ad 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1476,12 +1476,17 @@ static int allocate_caches_and_workqueue(struct sm=
bd_connection *info)
 	int rc;
 =

 	scnprintf(name, MAX_NAME_LEN, "smbd_request_%p", info);
+	struct kmem_cache_args request_args =3D {
+		.align		=3D __alignof__(struct smbd_request),
+		.useroffset	=3D offsetof(struct smbd_request, packet),
+		.usersize	=3D sizeof(struct smbdirect_data_transfer),
+	};
 	info->request_cache =3D
 		kmem_cache_create(
 			name,
 			sizeof(struct smbd_request) +
 				sizeof(struct smbdirect_data_transfer),
-			0, SLAB_HWCACHE_ALIGN, NULL);
+			&request_args, SLAB_HWCACHE_ALIGN);
 	if (!info->request_cache)
 		return -ENOMEM;
 =

@@ -1492,12 +1497,16 @@ static int allocate_caches_and_workqueue(struct sm=
bd_connection *info)
 		goto out1;
 =

 	scnprintf(name, MAX_NAME_LEN, "smbd_response_%p", info);
+
+	struct kmem_cache_args response_args =3D {
+		.align		=3D __alignof__(struct smbd_response),
+		.useroffset	=3D offsetof(struct smbd_response, packet),
+		.usersize	=3D sp->max_recv_size,
+	};
 	info->response_cache =3D
-		kmem_cache_create(
-			name,
-			sizeof(struct smbd_response) +
-				sp->max_recv_size,
-			0, SLAB_HWCACHE_ALIGN, NULL);
+		kmem_cache_create(name,
+				  sizeof(struct smbd_response) + sp->max_recv_size,
+				  &response_args, SLAB_HWCACHE_ALIGN);
 	if (!info->response_cache)
 		goto out2;
 =


