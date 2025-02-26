Return-Path: <linux-fsdevel+bounces-42680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F7A46098
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48092171690
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB69421D3D9;
	Wed, 26 Feb 2025 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN2L/8Qc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AF2192EE
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576063; cv=none; b=UZrTsRI7uolsP0vzAoUgNgPrfmAcJS2RkPspyT1K1tfkTrQI5gM+a2Eek9rpmotbkI37G2++2gWU8gSab/HTZoMerjz318namON5cX33Uj+FlXHLSrLjE/AjaEtkSFx6zxVbAh6kqRxNRwmvjpvfxZ+w1FRv/eexyC+QybO5uLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576063; c=relaxed/simple;
	bh=Qnm2hG1KnsQDqXnZ7Ak67qCxfQakLBBxso81jVcduA0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=JPd8LzMV4k+Bw9jJBc0Ov0Do9ux/8O6SxnYKrj4ezfrBFriknC0ObjhGQbEjrI004P8dkvI4hJZcxrS8ey5UtLw/nrzsYXW8zCFU2ed74sk6oqIWDOWyKSqHdQSWwMIog0wXJ/wdOkLpCy9E0T+HVo3T4XJSI2huvtDtPBFxm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AN2L/8Qc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740576059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pOKQylrR35KbXG+jocGUv5N9FH8CHHirEUON+cGjZNs=;
	b=AN2L/8QcZ2eXo6v6UgkD1OzUs1vwx17PXvsm7DHu1rw2xbVgecGpXquo6hoMgfDVARPW6Q
	8eH75Acl276HlTWuqtNT2kIXMCFLZfTYD/XTZns+rgDuhmFzXXhIHqLOyYxiMzuJ14eD9R
	YI6oGHcnC9CKVhMhh5DRWdGzp7NpcYw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-Cd6NdM0AOWCNDV3PSSOq0g-1; Wed,
 26 Feb 2025 08:20:54 -0500
X-MC-Unique: Cd6NdM0AOWCNDV3PSSOq0g-1
X-Mimecast-MFC-AGG-ID: Cd6NdM0AOWCNDV3PSSOq0g_1740576052
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A516918EB2CE;
	Wed, 26 Feb 2025 13:20:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49C0F1800358;
	Wed, 26 Feb 2025 13:20:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
    Steve French <stfrench@microsoft.com>,
    Dominique Martinet <asmadeus@codewreck.org>
cc: dhowells@redhat.com, Ihor Solodrai <ihor.solodrai@pm.me>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
    v9fs@lists.linux.dev, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix unbuffered writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2602344.1740576046.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Feb 2025 13:20:46 +0000
Message-ID: <2602345.1740576046@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix netfs_wait_for_request() so that it doesn't check the outcome of a
synchronous unbuffered write and emit error -EIO and a netfs_failure trace
line if the write appears to be short.  This will affect both 9p and cifs,
depending on the mount options; it does not affect DIO writes.

This check is a problem because the write side doesn't set rreq->submitted=
,
but rather ->issued_to (the two ought to be merged as one is superfluous).
This now occurs because the code was generalised from just the read side t=
o
the write side as well.

Fixes: 9dc06eff2097 ("netfs: Fix wait/wake to be consistent about the wait=
queue used")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Ihor Solodrai <ihor.solodrai@pm.me>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 6a5a7704e983..77e7f7c79d27 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -461,6 +461,7 @@ static ssize_t netfs_wait_for_request(struct netfs_io_=
request *rreq,
 		case NETFS_DIO_READ:
 		case NETFS_DIO_WRITE:
 		case NETFS_READ_SINGLE:
+		case NETFS_UNBUFFERED_WRITE:
 			break;
 		default:
 			if (rreq->submitted < rreq->len) {


