Return-Path: <linux-fsdevel+bounces-14469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86287CF66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6267C2823BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555643BB46;
	Fri, 15 Mar 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQZWXKLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16938FB2
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514116; cv=none; b=c/bV7z2TO2ty8xocbYExgb+mmmWY6kJId0peXY6I+j9NS3aTSAEIPzhymPfp3o+6XM2l25ySmOG6KWQIKcZhCMUKjjRTrmedZ9nnj/4ojWAvg1Gxy+HmKbuQDQTr+HhxjHzB9m+GK63jyCqr9OeTTkRtDHvRVBV2UK5R/R5wKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514116; c=relaxed/simple;
	bh=X+y0adXc1BsVlZJYHdd66wA7pdot+WAKXfOFF0KkMeM=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=bq8gXcBf2pXJo4wsvO8cYz+BlXKTX7/NModie7B+fAvsfvy6CAUDKiCaBw5XC3C9hOAWVHyCX1YK+XDqWKrMMwmmN6hSh0CIPaoY88MApv5a9B6POTDFp07DCHxZcgW3mdduKXEI1uXT8f92PMUzABSXu60HxdpZW1SK+FCu8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQZWXKLc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710514114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ts2VjbtwUxmJJrZ7EGdHyLvxyDp1Z48Z8fRhoERt8Xk=;
	b=bQZWXKLcCU1vwvUMdgpVlo1QlsRnjQbG2LRz/5DygVv7hXpJ26zxIcaAblgEV1EaJJUygN
	rlsaOHsX/qEdz+4n6rLTce3i87sFMYx+7/E1/qOtWKryNlMJocPUTkcicx9vGvH3QD5pc1
	i1f36CyR4cfZtzvmdsP495TzZvq+PUo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-REgTXwg3MoGsMWgnL_yV1g-1; Fri,
 15 Mar 2024 10:48:32 -0400
X-MC-Unique: REgTXwg3MoGsMWgnL_yV1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF4133C01DB1;
	Fri, 15 Mar 2024 14:48:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EDB0A1121306;
	Fri, 15 Mar 2024 14:48:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fscache: Fix error handling in fscache_begin_operation()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3933236.1710514106.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Mar 2024 14:48:26 +0000
Message-ID: <3933237.1710514106@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

    =

Fix fscache_begin_operation() to clear cres->cache_priv on error, otherwis=
e
fscache_resources_valid() will report it as being valid.

Signed-off-by: David Howells <dhowells@redhat.com>
Reported-by: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/fscache_io.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index ad57e4412c6d..cfd58ad95e7c 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -83,8 +83,10 @@ static int fscache_begin_operation(struct netfs_cache_r=
esources *cres,
 	cres->debug_id		=3D cookie->debug_id;
 	cres->inval_counter	=3D cookie->inval_counter;
 =

-	if (!fscache_begin_cookie_access(cookie, why))
+	if (!fscache_begin_cookie_access(cookie, why)) {
+		cres->cache_priv =3D NULL;
 		return -ENOBUFS;
+	}
 =

 again:
 	spin_lock(&cookie->lock);


