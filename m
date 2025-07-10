Return-Path: <linux-fsdevel+bounces-54465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D42EAFFF97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB704880C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB82E3AFC;
	Thu, 10 Jul 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKk6Jbww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1142E0B4B
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144442; cv=none; b=UX9guHQ9xyeb7vdydso8uOPtVFsj8+vHhJllaaWXRcwYsA0nsfD3MZO7iXogGL++CFzFtZqROSJh0WHxH5X5gVvdU+2ghTTnoQFWtLQxzQWwloMSan78jvrJEfLY8dTGQ7F1y9cDVTUfZFf0OhoNKxlUXKWLO+N+5eqOmDuMWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144442; c=relaxed/simple;
	bh=SOep39LCruQJ5eUJmcxYU0zPt7Rxb5VZwOl88D+y7tQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=C8c/ZAMG3Bw+jwh/VAvVYW8lqrD/pYmsRWNzc29krbZyTznHUkzE7iJ2kCKQlcbssb+rCfYvmsMmaU13b6mlUK0FT+tT23DjDPf/oXa04Nnl038Vbr9/NvdY4ftm8jAWZ4fvcVwADUh/CAWXV+e4TJs6t/xw1q/mSTYbN2pd6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKk6Jbww; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752144439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0u3HIoTZyqgg631O8XZeTrysi+dlK3ZJXgoQ/uYQ84=;
	b=BKk6Jbww2FSrepC5BeSV/XFncmwRmMhgnhmgTd7M6V+y0Cfv53s1qBnI0dfw5iNsxOvxjy
	4CRZJ1ypVF3lPJFGe3oml2St1AFYiBPvOUw/I8wgjmrXrzNb1pOvRJUvI8liGyCBvsv4mp
	yMI7fW12/dStW9Eqfuz8Z8M6JK418is=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-Qs5apeF0MfKwPreNiR2KRQ-1; Thu,
 10 Jul 2025 06:47:16 -0400
X-MC-Unique: Qs5apeF0MfKwPreNiR2KRQ-1
X-Mimecast-MFC-AGG-ID: Qs5apeF0MfKwPreNiR2KRQ_1752144434
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D985519560B0;
	Thu, 10 Jul 2025 10:47:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 488C719373D8;
	Thu, 10 Jul 2025 10:47:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
References: <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com> <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com> <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com> <2738562.1752092552@warthog.procyon.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Viacheslav Dubeyko <slava@dubeyko.com>,
    Alex Markuze <amarkuze@redhat.com>, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2807749.1752144428.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Jul 2025 11:47:08 +0100
Message-ID: <2807750.1752144428@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Max,

I managed to reproduce it on my test machine with ceph + fscache.

Does this fix the problem for you?

David
---
netfs: Fix copy-to-cache so that it performs collection with ceph+fscache

The netfs copy-to-cache that is used by Ceph with local caching sets up a
new request to write data just read to the cache.  The request is started
and then left to look after itself whilst the app continues.  The request
gets notified by the backing fs upon completion of the async DIO write, bu=
t
then tries to wake up the app because NETFS_RREQ_OFFLOAD_COLLECTION isn't
set - but the app isn't waiting there, and so the request just hangs.

Fix this by setting NETFS_RREQ_OFFLOAD_COLLECTION which causes the
notification from the backing filesystem to put the collection onto a work
queue instead.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use =
one work item")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=3DshxyGLwfe-L=
7AV3DhebS3w@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/netfs/read_pgpriv2.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 5bbe906a551d..080d2a6a51d9 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -110,6 +110,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_co=
py_to_cache(
 	if (!creq->io_streams[1].avail)
 		goto cancel_put;
 =

+	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
 	rreq->copy_to_cache =3D creq;


