Return-Path: <linux-fsdevel+bounces-24009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA493791C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 16:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD351F22256
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3194E13C9A9;
	Fri, 19 Jul 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMlFHEUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C61DFCF
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398837; cv=none; b=s8pEsJ66TyLbQWWfGaoyTXIJ593zMJJQzH5mROMpjOlc8ckGVZAwZdrlHv8/Bi3/gPvzw6XV9s6ryEJiIF/uZRjAQ0ZmilP8gPtOgFRiIGuNoEbaRZeseR8PirQJQKBMbFZMhFAgtEGMKW4s49knIEKJCG71DlNZyXIgulDPn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398837; c=relaxed/simple;
	bh=wYfoc3euZwO7f2o0ZV7TuuI7uV/8oH91RNhxnrSqyXY=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=fleHJunOqD27QGzD8Tl3c0LVkBn33fa6jlMd2gbX5HJd8po22ovpPVT3L8xmFKQJgyc4SEXwkf/8jlIN3BhB+n4HC8bVAfyiKYg4UB5NKbIwHm2mv+ayILtIFeBFsCmOvNZ+F/bnOihlcVK4g16sALenp4atdrlgmvm05eAydWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMlFHEUA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721398835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+1BlHh1YdajEvAS82fygx9/tSgTTxiKou02g3iVdT40=;
	b=YMlFHEUAHVMAK0kpAuI+N5I9t9fMVZuB5jEne9F7kB8xr6tqeL6PqQNi4yF3Gx0oaT+oTP
	J4NBFgdV711mZQDrLCNN7xfxT5XapHee5AfZTVZL6+GkFxAS514euu5U4Tyqiq7D/s2aq1
	oZoOSPanl7q0GM1i9qwYRGJKYFrXEGU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-g3N79YRMMFK6rtoXNG4QEg-1; Fri,
 19 Jul 2024 10:20:31 -0400
X-MC-Unique: g3N79YRMMFK6rtoXNG4QEg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 580B31944A84;
	Fri, 19 Jul 2024 14:20:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86C871955E7D;
	Fri, 19 Jul 2024 14:20:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix writeback that needs to go to both server and cache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1599052.1721398818.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jul 2024 15:20:18 +0100
Message-ID: <1599053.1721398818@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When netfslib is performing writeback (ie. ->writepages), it maintains two
parallel streams of writes, one to the server and one to the cache, but it
doesn't mark either stream of writes as active until it gets some data tha=
t
needs to be written to that stream.

This is done because some folios will only be written to the cache
(e.g. copying to the cache on read is done by marking the folios and
letting writeback do the actual work) and sometimes we'll only be writing
to the server (e.g. if there's no cache).

Now, since we don't actually dispatch uploads and cache writes in parallel=
,
but rather flip between the streams, depending on which has the lowest
so-far-issued offset, and don't wait for the subreqs to finish before
flipping, we can end up in a situation where, say, we issue a write to the
server and this completes before we start the write to the cache.

But because we only activate a stream when we first add a subreq to it, th=
e
result collection code may run before we manage to activate the stream -
resulting in the folio being cleaned and having the writeback-in-progress
mark removed.  At this point, the folio no longer belongs to us.

This is only really a problem for folios that need to be written to both
streams - and in that case, the upload to the server is started first,
followed by the write to the cache - and the cache write may see a bad
folio.

Fix this by activating the cache stream up front if there's a cache
available.  If there's a cache, then all data is going to be written to it=
.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index ec6cf8707fb0..9258d30cffe3 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -122,6 +122,7 @@ struct netfs_io_request *netfs_create_write_req(struct=
 address_space *mapping,
 	wreq->io_streams[1].transferred		=3D LONG_MAX;
 	if (fscache_resources_valid(&wreq->cache_resources)) {
 		wreq->io_streams[1].avail	=3D true;
+		wreq->io_streams[1].active	=3D true;
 		wreq->io_streams[1].prepare_write =3D wreq->cache_resources.ops->prepar=
e_write_subreq;
 		wreq->io_streams[1].issue_write =3D wreq->cache_resources.ops->issue_wr=
ite;
 	}


