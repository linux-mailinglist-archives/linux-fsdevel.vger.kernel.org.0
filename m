Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AF246ED82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbhLIQx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 11:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237385AbhLIQx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639068623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1GcNbc9O5U5G8LlnP/kK4YsVg9drcvikjSXrTjTmMo=;
        b=XXcMufcf1A33ShGEcu/cIiaLPiMTGL16gdDSZZIBBRLuNK6gCt7C6kbEkAQDdYz2GDVqCt
        BRYwonIPl1rZj9eQ2SEenlK5PYNAmfteUR14vezEphkjYokNCs/mV95PEaEkrLtju5jwIq
        XjDFkce+O3/381oebL8x0EgnavuTqfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-JHLalODTOZi6-eTunFrpGg-1; Thu, 09 Dec 2021 11:50:21 -0500
X-MC-Unique: JHLalODTOZi6-eTunFrpGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79DE718C89DF;
        Thu,  9 Dec 2021 16:50:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24DE25ED39;
        Thu,  9 Dec 2021 16:49:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d4167c15-b3ce-73b2-1d66-97d651723305@linux.alibaba.com>
References: <d4167c15-b3ce-73b2-1d66-97d651723305@linux.alibaba.com> <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk> <163819612321.215744.9738308885948264476.stgit@warthog.procyon.org.uk>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/64] netfs: Pass more information on how to deal with a hole in the cache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <143691.1639068593.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 09 Dec 2021 16:49:53 +0000
Message-ID: <143692.1639068593@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

JeffleXu <jefflexu@linux.alibaba.com> wrote:

> > @@ -466,7 +466,7 @@ static void netfs_rreq_short_read(struct netfs_rea=
d_request *rreq,
> >  	netfs_get_read_subrequest(subreq);
> >  	atomic_inc(&rreq->nr_rd_ops);
> >  	if (subreq->source =3D=3D NETFS_READ_FROM_CACHE)
> > -		netfs_read_from_cache(rreq, subreq, true);
> > +		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
> =

> Hi I'm not sure why NETFS_READ_HOLE_CLEAR style should be used in 'short
> read' case.

The cache backing filesystem (eg. ext4) might have excised a chunk of zero=
s
from the cache in order to optimise its extent list.  This instructs the c=
ache
to zero over the cracks.  Actually, I need to think a bit further on this.
This was written assuming that the cache tracks its content independently =
-
but those patches are not in with this set.

> I'm not sure why 'subreq->start' is not incremented with
> 'subreq->transferred' when calling cres->ops->read() in 'short read' cas=
e.

subreq->start shouldn't get changed.  subreq->transferred is sufficient.

David

