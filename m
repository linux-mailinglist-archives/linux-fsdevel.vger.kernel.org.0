Return-Path: <linux-fsdevel+bounces-16372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91ED89C8FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DD2879FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7888E1422A6;
	Mon,  8 Apr 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3pQiY5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807A1422A8
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591613; cv=none; b=VWlA6m8BlT8dziLbj49RieVSrBS6w4jGe8XUEPTIbu1xWEj9UpQXxDun4OuvxG+V88UChgirpLcUwkfnfAzpN5K/67dcWyiiiB+VPLY7ZetMPG5g3hX6e3NMQJxKWrqRRqbuTgGWlrmG84Z+tVZQ9cPrrZAMjEczvtYXP16HQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591613; c=relaxed/simple;
	bh=c7hBMA4mXgWP8KpfW/frrWt9OAipSAHQsJKBjgulmnE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Cdl9lmOVeP2vM6melZz8DMCVZMsKKvwoITz8/9ZA9UP/EJzC7w+3Ivo2aTl5oyp5gIa7yn094rWsQ2f727xY3/KGZyHMyggryQnlxaLjP2sCRDfVwup/b6EkgeFImMgzM9KiHhGhGOrELt1Z64H3SaD5PfZm53QYNJ8hugeDxB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3pQiY5l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712591610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFuGX1yyoTN69ecCATsVj4UhORzkDiRUWoktVVAJ3+Q=;
	b=M3pQiY5lqBUvg/LGShdu13XW38l8ONsKhdxdh35Uw1RJ4HmupW3rKYJQQQtzHVfogfJsZg
	jN1+dVINASTXemnr+GMMM0vgjrM/Cm1i39jGpulL+JwbQVIyNQ30SYwdjwsR8465a/7k1L
	yNNvp6exSFMjDPkt8+eZF6zmaIORk88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-HJAhESVFMaKi_61YaghcgA-1; Mon, 08 Apr 2024 11:53:27 -0400
X-MC-Unique: HJAhESVFMaKi_61YaghcgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEA2C90ACC7;
	Mon,  8 Apr 2024 15:53:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 084C62033AC1;
	Mon,  8 Apr 2024 15:53:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-24-dhowells@redhat.com>
References: <20240328163424.2781320-24-dhowells@redhat.com> <20240328163424.2781320-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 23/26] netfs: Cut over to using new writeback code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <877901.1712591597.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Apr 2024 16:53:17 +0100
Message-ID: <877902.1712591597@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

David Howells <dhowells@redhat.com> wrote:

> +		/* Wait for writeback to complete.  The writeback engine owns
> +		 * the info in folio->private and may change it until it
> +		 * removes the WB mark.
> +		 */
> +		if (folio_wait_writeback_killable(folio)) {
> +			ret =3D written ? -EINTR : -ERESTARTSYS;
> +			goto error_folio_unlock;
> +		}
> +

It turns out that this really kills performance with fio with as many jobs=
 as
cpus.  It's taking up to around 8x longer to complete a pwrite() on averag=
e
and perf shows a 30% of the CPU cycles are being spent in contention on th=
e
i_rwsem.

The reason this was added here is that writeback cannot take the folio loc=
k in
order to clean up folio->private without risking deadlock vs the truncatio=
n
routines (IIRC).

I can mitigate this by skipping the wait if folio->private is not set and =
if
we're not going to attach anything there (see attached).  Note that if
writeout is ongoing and there is nothing attached to ->private, then we sh=
ould
not be engaging write-streaming mode and attaching a new netfs_folio (and =
if
we did, we'd flush the page and wait for it anyway).

The other possibility is if we have a writeback group to set.  This only
applies to ceph for the moment and is something that will need dealing wit=
h
if/when ceph is made to use this code.

David
---

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 1eff9413eb1b..279b296f8014 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -255,7 +255,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct=
 iov_iter *iter,
 		 * the info in folio->private and may change it until it
 		 * removes the WB mark.
 		 */
-		if (folio_wait_writeback_killable(folio)) {
+		if (folio_get_private(folio) &&
+		    folio_wait_writeback_killable(folio)) {
 			ret =3D written ? -EINTR : -ERESTARTSYS;
 			goto error_folio_unlock;
 		}


