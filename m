Return-Path: <linux-fsdevel+bounces-37522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF439F3AE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC001885A66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FB91D4612;
	Mon, 16 Dec 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+XNgytB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE81D4340
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381300; cv=none; b=LrTYHaL1Ixn71uIgAJO4tKc1hpZpphNPEOaNvfAxLj/DpeAEfRwyuD++/isyjtWEN6iNdgPfUwuCqQ8uIU4pn07T/kJ/uMof2yFWfMH6ZrZFo+Z4X22y5DWIIw4PhKYm76JoTdHafiq5WmgoQyamPf9hpJhxX4Op6J0iPtMnJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381300; c=relaxed/simple;
	bh=SZDZJSjVc5zhdXXeycEYKDY+bf6/mxmwzv0HttjJEA0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=KdmV/JScaeD4gR3FBkryHUR1V7jN5jrW6Et6cq1vpha0BehKUBz9Imh8GbE+jMAb4DPkleIdRidmuzx0h3AefPiPWel9UQb5Cg5Im05+CV+667j3NpfZ0DODbiO+BEZvO1ydyEzGiWBjXc7Tnnn2ZhwIhGXW5DLy6iQoCrEwsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+XNgytB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uel8b3F42MjWx1FV4MNqrLkM5e1s0/oyCwTXY7gJWI=;
	b=B+XNgytB3gVcf1snhXo3wgvoyFWNGYnopas4t1JaW+Mt7WvNkHF3SAI7Y0GmuYzKTBew6c
	90anPQNnqc1ofrb3TFUS1GxIqEbtxTO7DayjBptP8kYtnAGiSJhS1rqMyPGcP/CHZYxGC1
	BQ6EIIqJ4Sgcc+N21O9S8SQuqHxW1nE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-PLpJV9waPvq0rsK0CpjcQA-1; Mon,
 16 Dec 2024 15:34:55 -0500
X-MC-Unique: PLpJV9waPvq0rsK0CpjcQA-1
X-Mimecast-MFC-AGG-ID: PLpJV9waPvq0rsK0CpjcQA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B245219560A3;
	Mon, 16 Dec 2024 20:34:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A88819560A2;
	Mon, 16 Dec 2024 20:34:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Trond Myklebust <trondmy@kernel.org>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH 11/10] netfs: Fix is-caching check in read-retry
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3752047.1734381285.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2024 20:34:45 +0000
Message-ID: <3752048.1734381285@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

netfs: Fix is-caching check in read-retry

The read-retry code checks the NETFS_RREQ_COPY_TO_CACHE flag to determine
if there might be failed reads from the cache that need turning into reads
from the server, with the intention of skipping the complicated part if it
can.  The code that set the flag, however, got lost during the read-side
rewrite.

Fix the check to see if the cache_resources are valid instead.  The flag
can then be removed.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c |    2 +-
 include/linux/netfs.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 0e72e9226fc8..21b4a54e545e 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -49,7 +49,7 @@ static void netfs_retry_read_subrequests(struct netfs_io=
_request *rreq)
 	 * up to the first permanently failed one.
 	 */
 	if (!rreq->netfs_ops->prepare_read &&
-	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
+	    !rreq->cache_resources.ops) {
 		struct netfs_io_subrequest *subreq;
 =

 		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 4083d77e3f39..ecdd5ced16a8 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -269,7 +269,6 @@ struct netfs_io_request {
 	size_t			prev_donated;	/* Fallback for subreq->prev_donated */
 	refcount_t		ref;
 	unsigned long		flags;
-#define NETFS_RREQ_COPY_TO_CACHE	1	/* Need to write to the cache */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on c=
ompletion */
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on com=
pletion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */


