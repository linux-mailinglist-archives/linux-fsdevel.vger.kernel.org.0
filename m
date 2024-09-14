Return-Path: <linux-fsdevel+bounces-29393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C7D979360
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 23:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59741B21927
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DA13BC35;
	Sat, 14 Sep 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsNV1AE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A637D417
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726348332; cv=none; b=I/pPk4K5L5O3p+pqd5Nc/NHmEHX2MQ+SZwmVV3eVR5AXym4JQtaOe6Ca9vmDiH+jS+JpIFL0YS8Hqg42Okxm/ZKmBeKvlGeyZHDThuPdV/hSEt1FS17tSs8irzipHQI+Dl65tv0wuQbucyCCVcAz02jV+diDH6TzPzKBVtBUIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726348332; c=relaxed/simple;
	bh=KDSJlGjyDFAPixTANxC4S4eELSkUWFc9TAU6WNEPEU4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=qH9iyptfnsIszWJ5zT1KGVlIbzGGqDqjiuAS8NPYSl2S/YZpqfPKGOLf+mWsJC6YJluEHtulEhD6JQJQ8Aqvx5v1qAivarx5Ey5xNe95omFeE/hAL1DXyIxhalDQDZ/dYoC5K2xh1t+jvX/Eh6o2UU6gSKViibrke/RGlkzQ9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsNV1AE4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726348329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yZfhfCLx5kZfZDyC5QoEq7U/ErCYMZjd0CDLrVpR0I=;
	b=GsNV1AE4VEZ8++RckfK1K1c99l0DEAgciwHEUZcKPFQLwl0xXSzMLVPXVI1wUsvZX/iYda
	C9VDKCtGf40ARhAElFh6T6l4m8uBpKl5AbTX6WDnVTq6MjO0P0X0Tbd9DHjemaFfUHLE7g
	UvztxkZAD53gIj9eoxF91Nd7yt0btRQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-7GUP28TBNfuGqtOlTMbBHg-1; Sat,
 14 Sep 2024 17:12:07 -0400
X-MC-Unique: 7GUP28TBNfuGqtOlTMbBHg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94A921955BC1;
	Sat, 14 Sep 2024 21:12:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A46F619560A3;
	Sat, 14 Sep 2024 21:12:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240906134019.131553-1-marc.dionne@auristor.com>
References: <20240906134019.131553-1-marc.dionne@auristor.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    Markus Suvanto <markus.suvanto@gmail.com>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] afs: Fix possible infinite loop with unresponsive servers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1694190.1726348322.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Sep 2024 22:12:02 +0100
Message-ID: <1694191.1726348322@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Marc Dionne <marc.dionne@auristor.com>

afs: Fix possible infinite loop with unresponsive servers

A return code of 0 from afs_wait_for_one_fs_probe is an indication
that the endpoint state attached to the operation is stale and has
been superseded.  In that case the iteration needs to be restarted
so that the newer probe result state gets used.

Failure to do so can result in an tight infinite loop around the
iterate_address label, where all addresses are thought to be responsive
and have been tried, with nothing to refresh the enpoint state.

[DH: Changed the priority of the returns from afs_wait_for_one_fs_probe(),
 Made the first caller iterate the address if 1 is returned, refetch the
 database records and begin again from the beginning if 0 is returned and
 otherwise deal with an error.  Altered the second caller to also handle t=
he
 "1" return.

Fixes: 495f2ae9e355 ("afs: Fix fileserver rotation")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://lists.infradead.org/pipermail/linux-afs/2024-July/008628.htm=
l
cc: linux-afs@lists.infradead.org
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240906134019.131553-1-marc.dionne@aurist=
or.com/
---
 fs/afs/fs_probe.c |    4 ++--
 fs/afs/rotate.c   |   11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 580de4adaaf6..b516d05b0fef 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -506,10 +506,10 @@ int afs_wait_for_one_fs_probe(struct afs_server *ser=
ver, struct afs_endpoint_sta
 	finish_wait(&server->probe_wq, &wait);
 =

 dont_wait:
-	if (estate->responsive_set & ~exclude)
-		return 1;
 	if (test_bit(AFS_ESTATE_SUPERSEDED, &estate->flags))
 		return 0;
+	if (estate->responsive_set & ~exclude)
+		return 1;
 	if (is_intr && signal_pending(current))
 		return -ERESTARTSYS;
 	if (timo =3D=3D 0)
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index ed09d4d4c211..d612983d6f38 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -632,8 +632,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 wait_for_more_probe_results:
 	error =3D afs_wait_for_one_fs_probe(op->server, op->estate, op->addr_tri=
ed,
 					  !(op->flags & AFS_OPERATION_UNINTR));
-	if (!error)
+	if (error =3D=3D 1)
 		goto iterate_address;
+	if (!error)
+		goto restart_from_beginning;
 =

 	/* We've now had a failure to respond on all of a server's addresses -
 	 * immediately probe them again and consider retrying the server.
@@ -644,10 +646,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 		error =3D afs_wait_for_one_fs_probe(op->server, op->estate, op->addr_tr=
ied,
 						  !(op->flags & AFS_OPERATION_UNINTR));
 		switch (error) {
-		case 0:
+		case 1:
 			op->flags &=3D ~AFS_OPERATION_RETRY_SERVER;
-			trace_afs_rotate(op, afs_rotate_trace_retry_server, 0);
+			trace_afs_rotate(op, afs_rotate_trace_retry_server, 1);
 			goto retry_server;
+		case 0:
+			trace_afs_rotate(op, afs_rotate_trace_retry_server, 0);
+			goto restart_from_beginning;
 		case -ERESTARTSYS:
 			afs_op_set_error(op, error);
 			goto failed;


