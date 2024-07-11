Return-Path: <linux-fsdevel+bounces-23571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E01592E92C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 15:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9631C214CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C9158216;
	Thu, 11 Jul 2024 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWSyveEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5336B15E5A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703998; cv=none; b=oP4j5pDhlpVlpgb9TVuT+8lMh4vQxl1iRFx0GnInb1Po9DYITP6tCv8PB/uZZQZG6tCjVFHFU8lpEHTa8w8gTHu7vWQiArtYQ7bd7amlY/+CNYXOSxb3QU3vNaMpRGBquopZCncbvGXqdOkX1/i/S8E0lu/cel3D+04jgjGhRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703998; c=relaxed/simple;
	bh=gCwTYbQeabb3GfeJU/oEEubSclUQQgWDiIn0ljKgsxM=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=o5TRJ5c0AUvvWVxOgYBBsTd8AXxsggXTS8mndDM0DntGpdd0Vp5iPKD+4dGp9pIcBasW8c79QWIh9rSqw+3MDVlYVVZXpT8ru6sIRQ6Qe1f7KnuZWGImCbbqFMyVTzeN/KrRN7wclZPjMQ+g35I5LeGVomt91TD3U7YaN+p6pjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWSyveEX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720703995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KQAneCFk7IMzHAKN9/AEAYz+zztVPj5RlKnWcmXPprE=;
	b=fWSyveEX2pDKopsfQ84jgbkJx2t4fd5BVK9ElHuF/1f6KHxNaR6YGBgi4iTn8/dRyGczb9
	yhtsouJxRj7brAv7eW75m8iOw4FDPduE5jRF56mrbCOoxMSQgab+wkH0e3PTZuVgFXoPbs
	rGW5M4QjwTtWQ7aWJDfMqpAWbm9zk/Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-RhZZrTalNhum6sBZHdVoig-1; Thu,
 11 Jul 2024 09:19:45 -0400
X-MC-Unique: RhZZrTalNhum6sBZHdVoig-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0A7019560B1;
	Thu, 11 Jul 2024 13:19:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC31E1956046;
	Thu, 11 Jul 2024 13:19:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>
cc: dhowells@redhat.com, Christian Schoenebeck <linux_oss@crudebyte.com>,
    v9fs@lists.linux.dev, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: Fix O_NONBLOCK read behaviour in P9L_DIRECT mode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4058792.1720703979.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jul 2024 14:19:39 +0100
Message-ID: <4058793.1720703979@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

With the 9p filesystem, in P9L_DIRECT mode, if O_NONBLOCK is set, a read
should terminate after doing one piece of I/O.

Fixes: 80105ed2fd27 ("9p: Use netfslib read/write_iter")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218916
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a97ceb105cd8..b443024bf715 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -77,6 +77,10 @@ static void v9fs_issue_read(struct netfs_io_subrequest =
*subreq)
 	 * cache won't be on server and is zeroes */
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 =

+	if ((fid->mode & P9L_DIRECT) &&
+	    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
+		set_bit(NETFS_RREQ_BLOCKED, &rreq->flags);
+
 	netfs_subreq_terminated(subreq, err ?: total, false);
 }
 =


