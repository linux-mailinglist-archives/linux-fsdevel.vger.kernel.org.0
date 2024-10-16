Return-Path: <linux-fsdevel+bounces-32120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803F19A0D37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AED1F27456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B920E01E;
	Wed, 16 Oct 2024 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hype1UEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6820E00B
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090138; cv=none; b=SefwSqpjOYyWG2suORsNHyxV/FC9zAaaSRwo6wGkdVv8XTUUZwJpVPpwPV93iuAXvSyyqXGruYeVBgVjMUSwcdVjurd1lp5LIP45m5laInkHEllNG3sUh0Hq97eamL5uWp9anaXc/cbN2dOG7bmYHZxlRhAG/DjJ8jbCbELccG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090138; c=relaxed/simple;
	bh=y7HR7E/AiWUQKh2Np2csxIJ7irl6mp3h4jArGWUSsoU=;
	h=To:cc:Subject:From:MIME-Version:Content-Type:Date:Message-ID; b=ujqra2krSfjimXip2FRIU/X6Ar01zkQVdz+CHH7xe01+tDbaKrszEj6873Moc7fMDjmvz61t8Arw7QzV0iB4DqzZyTgv6PUTNCoox8G2DUnHjZd9dM0SptPHz+oGMxGyFvlmyONKzMl+5bOgg6hpYKSR2/1UON3qiK6cU7yXcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hype1UEs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729090135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kmWQtJ9zxBBaO8diigfr0ikB/S388owXxOSCpsgZC9w=;
	b=Hype1UEscswAYeUUDm9lw/XZj0I690/HeqcAYIiHeWPnx6uy6DiAPmE1Mes2hRHH6nHCnn
	EAyx/+xkfy/j1zF7TDflY4swLmQRw+py4EiZk/vt5BvfWOaWJ72dWOIBVRD0JxwzuAl/eT
	LnjZQREp56iZrTozu/ouyQba7xYapWg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186--svDiZtxPiaaRYwuiFdL9w-1; Wed,
 16 Oct 2024 10:48:52 -0400
X-MC-Unique: -svDiZtxPiaaRYwuiFdL9w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B7421955D9B;
	Wed, 16 Oct 2024 14:48:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3CBB19560A3;
	Wed, 16 Oct 2024 14:48:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [PATCH] netfs: Fix kdoc of netfs_read_subreq_progress()
From: David Howells <dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1292001.1729090128.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Oct 2024 15:48:48 +0100
Message-ID: <1292002.1729090128@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix missing param description in kdoc of netfs_read_subreq_progress().

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 266ec8d20d92..2ef54d83cf59 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -508,6 +508,7 @@ void netfs_wake_read_collector(struct netfs_io_request=
 *rreq)
 =

 /**
  * netfs_read_subreq_progress - Note progress of a read operation.
+ * @subreq: The I/O request that has made progress.
  *
  * This tells the read side of netfs lib that a contributory I/O operatio=
n has
  * made some progress and that it may be possible to unlock some folios.


