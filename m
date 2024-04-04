Return-Path: <linux-fsdevel+bounces-16098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99D8982B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 10:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0A928BA5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6E6BB29;
	Thu,  4 Apr 2024 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtAfNGWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0A75D8EB
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217721; cv=none; b=OLYIHThGwBaOLCjjTGtOGYwcbP7NiYwZkOzqLhlQZrowpHFggNXzICwfx/HNtzKwNYSgNwyJ9mj9qsve0+c3n92nNXEtwH9pc1MAA6z6F5Klt++SCcuyKfsjQMTB5RPtKhviTNpWIpfNWrnP8Pb71eXkvai/nbRZpS2Xs8vuzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217721; c=relaxed/simple;
	bh=nn75BfzRjv6UXMTe1POmsOm6uuisJffR5hjMsK9B4pM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HuYrmnTLsjsoYBRLWnGtaljBKr32IBynjUqsC62JRrbY6eK5PQjdWzzOW8BQ8zyZX3IFfcrgIaTH0Ej6ap5Oszvmd4oO7SN7KT1YHH3RI1VlQ6oOjsH4I6ZH4CNWNdjYFz2PoqzB+m+Vek0TGYUjWvSFZluvZ1z30DpskPjS6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtAfNGWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712217718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE/xA/cazcP+HXhdhjRdwQDAS2gMvpTgfIxHPPrU41I=;
	b=AtAfNGWpfWvXtWv2xyojYsBWjt97qcqzyhgP2H6Ar0mC9o4Kj1HX8ISudNj6sVHmPyTyjh
	zoAiUg2UFagj8sO29teLrp5wqQfQI+rviCoRdSn2c1YVu8ex605WlbVUEmkLNXRh516DDC
	Qt6gjDz/TGLz3TpPfXs2QGQwdYqjPO4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-c0jY6rVYNYiCi_bmX-evYA-1; Thu,
 04 Apr 2024 04:01:52 -0400
X-MC-Unique: c0jY6rVYNYiCi_bmX-evYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BF723C02748;
	Thu,  4 Apr 2024 08:01:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD1EAC1576F;
	Thu,  4 Apr 2024 08:01:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3655511.1712217111@warthog.procyon.org.uk>
References: <3655511.1712217111@warthog.procyon.org.uk> <20240328163424.2781320-22-dhowells@redhat.com> <20240328163424.2781320-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH 21/26] netfs, 9p: Implement helpers for new write code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3666290.1712217703.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2024 09:01:43 +0100
Message-ID: <3666291.1712217703@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

David Howells <dhowells@redhat.com> wrote:

> > +	size_t len =3D subreq->len - subreq->transferred;
> =

> This actually needs to be 'int len' because of the varargs packet format=
ter.

I think the attached change is what's required.

David
---
diff --git a/net/9p/client.c b/net/9p/client.c
index 844aca4fe4d8..04af2a7bf54b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1670,10 +1670,10 @@ p9_client_write_subreq(struct netfs_io_subrequest =
*subreq)
 	struct p9_client *clnt =3D fid->clnt;
 	struct p9_req_t *req;
 	unsigned long long start =3D subreq->start + subreq->transferred;
-	size_t len =3D subreq->len - subreq->transferred;
-	int written, err;
+	int written, len =3D subreq->len - subreq->transferred;
+	int err;
 =

-	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu len %zd\n",
+	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu len %d\n",
 		 fid->fid, start, len);
 =

 	/* Don't bother zerocopy for small IO (< 1024) */
@@ -1699,11 +1699,11 @@ p9_client_write_subreq(struct netfs_io_subrequest =
*subreq)
 	}
 =

 	if (written > len) {
-		pr_err("bogus RWRITE count (%d > %lu)\n", written, len);
+		pr_err("bogus RWRITE count (%d > %u)\n", written, len);
 		written =3D len;
 	}
 =

-	p9_debug(P9_DEBUG_9P, "<<< RWRITE count %zd\n", len);
+	p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", len);
 =

 	p9_req_put(clnt, req);
 	netfs_write_subrequest_terminated(subreq, written, false);


