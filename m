Return-Path: <linux-fsdevel+bounces-36810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AF49E994A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0CA1888E21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A091C5CB4;
	Mon,  9 Dec 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJpHo+HS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861841B0430
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755572; cv=none; b=fj3AtzsEWq4J0krGGYa1hRL7lG7ajcTLU/HBpJWkB7+Ug8oJ4bFfLTPh88gn+SMLXjUgh11fGdjYYmv9r3HRO8dHaVaG0feK8PM1zM22wXWk9zfsZJy2qRG1na/2cLawRWuJyvcWlpnT6YfIgJuLgQlcozuzXqM/Pz0nzJBKMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755572; c=relaxed/simple;
	bh=gxoqf3V6MNwR8Jxtgxg0q1RTCN9bxCAoFnFNdWxak4w=;
	h=From:In-Reply-To:References:To:cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=m2xgYaIYArzY6zB8bqRLrJvNF6XEQQ79i4mzzpFSr+x0Xo3NJo9FxQq4EtTIdgKv8V9R0jc8tc3Qt5aCB7DGC8dVfHvpl4p19rkqRrs+SpUQJmiBHPA0b+kz3kxQX4gC8wg8rjAO6uE4hFMEWRRCKaegZClzUjbZGHOTRvpkXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJpHo+HS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733755569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3G/ATOlFkQtH54MeWdYZh8GPQakhI+3TwZChdXPPqtI=;
	b=DJpHo+HS1Da3ft4P8wiBHtWAuSVbf1LGbc4dRIy/VFdqHkzYHh2Y54e8gQ0Vi1kT+sX37n
	S/1nu8NwPata9H9S6YkbAsh3prpxDTnb9lBv7xVpfW7eWpYv4ZOI2fE53IRPKEEFTbwv2w
	ZkB5Zp57bWY+WOMNId7HaqxJgtNo5ig=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-THTru4SJMFGT1J6xnwPHdQ-1; Mon,
 09 Dec 2024 09:46:06 -0500
X-MC-Unique: THTru4SJMFGT1J6xnwPHdQ-1
X-Mimecast-MFC-AGG-ID: THTru4SJMFGT1J6xnwPHdQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC9B2195607D;
	Mon,  9 Dec 2024 14:46:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE361195605A;
	Mon,  9 Dec 2024 14:46:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+986mTt1i9xGBXiQPVOmu4ZJTskrCt6f-99EL_s0rhz_A@mail.gmail.com>
References: <CAKPOu+986mTt1i9xGBXiQPVOmu4ZJTskrCt6f-99EL_s0rhz_A@mail.gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
cc: dhowells@redhat.com, Trond Myklebust <trondmy@kernel.org>,
    Anna Schumaker <anna@kernel.org>,
    Dave Wysochanski <dwysocha@redhat.com>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: Fix oops in nfs_netfs_init_request() when copying to cache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2128543.1733755560.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Dec 2024 14:46:00 +0000
Message-ID: <2128544.1733755560@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Max,

Does this fix the issue?

David
---
nfs: Fix oops in nfs_netfs_init_request() when copying to cache

When netfslib wants to copy some data that has just been read on behalf of
nfs, it creates a new write request and calls nfs_netfs_init_request() to
initialise it, but with a NULL file pointer.  This causes
nfs_file_open_context() to oops - however, we don't actually need the nfs
context as we're only going to write to the cache.

Fix this by just returning if we aren't given a file pointer and emit a
warning if the request was for something other than copy-to-cache.

Further, fix nfs_netfs_free_request() so that it doesn't try to free the
context if the pointer is NULL.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+986mTt1i9xGBXiQPVOmu4ZJTskrCt6f-9=
9EL_s0rhz_A@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trondmy@kernel.org>
cc: Anna Schumaker <anna@kernel.org>
cc: Dave Wysochanski <dwysocha@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-nfs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/nfs/fscache.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 810269ee0a50..d49e4ce27999 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -263,6 +263,12 @@ int nfs_netfs_readahead(struct readahead_control *rac=
tl)
 static atomic_t nfs_netfs_debug_id;
 static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct f=
ile *file)
 {
+	if (!file) {
+		if (WARN_ON_ONCE(rreq->origin !=3D NETFS_PGPRIV2_COPY_TO_CACHE))
+			return -EIO;
+		return 0;
+	}
+
 	rreq->netfs_priv =3D get_nfs_open_context(nfs_file_open_context(file));
 	rreq->debug_id =3D atomic_inc_return(&nfs_netfs_debug_id);
 	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cach=
e. */
@@ -274,7 +280,8 @@ static int nfs_netfs_init_request(struct netfs_io_requ=
est *rreq, struct file *fi
 =

 static void nfs_netfs_free_request(struct netfs_io_request *rreq)
 {
-	put_nfs_open_context(rreq->netfs_priv);
+	if (rreq->netfs_priv)
+		put_nfs_open_context(rreq->netfs_priv);
 }
 =

 static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subreque=
st *sreq)


