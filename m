Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CE844555A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 15:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhKDOfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 10:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231129AbhKDOfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636036360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPjgKPP44SXIrxLx8CNgjbtemUL2QQQynBIl4LnWo2g=;
        b=HhWKadzg/tLnrtT+RskucLhmJhKnJHdP41++LpzMlJ2wiXu4FWBsN+IHAg+ygmt8gWM4eD
        eH0lXZ94KOabjqsotct2l4uAmECMXUvE7a9y3jRy7sbuDrMBNOYrq+Wdvw2yzUM77v+WGh
        bxoz6WofEPzCdK+aY+CZyty4urm8a/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-jIvx4JasMH27MVkeYdVBDA-1; Thu, 04 Nov 2021 10:32:37 -0400
X-MC-Unique: jIvx4JasMH27MVkeYdVBDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5890F87D548;
        Thu,  4 Nov 2021 14:32:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22BD856A94;
        Thu,  4 Nov 2021 14:32:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YYK4YKCnDyoJx5eW@casper.infradead.org>
References: <YYK4YKCnDyoJx5eW@casper.infradead.org> <YYKa3bfQZxK5/wDN@casper.infradead.org> <163584174921.4023316.8927114426959755223.stgit@warthog.procyon.org.uk> <163584187452.4023316.500389675405550116.stgit@warthog.procyon.org.uk> <1038257.1635951492@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] netfs, 9p, afs, ceph: Use folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1760414.1636036338.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 04 Nov 2021 14:32:18 +0000
Message-ID: <1760415.1636036338@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Nov 03, 2021 at 02:58:12PM +0000, David Howells wrote:
> > Matthew Wilcox <willy@infradead.org> wrote:
> > =

> > > > +	len =3D (size >=3D start + gran) ? gran : size - start;
> > > =

> > > This seems like the most complicated way to write this ... how about=
:
> > > =

> > >         size_t len =3D min_t(loff_t, isize - start, folio_size(folio=
));
> > =

> > I was trying to hedge against isize-start going negative.  Can this co=
de race
> > against truncate?  truncate_setsize() changes i_size *before* invalida=
ting the
> > pages.
> =

> We should check for isize < start separately, and skip the writeback
> entirely.

So, something like the following

	static int v9fs_vfs_write_folio_locked(struct folio *folio)
	{
		struct inode *inode =3D folio_inode(folio);
		struct v9fs_inode *v9inode =3D V9FS_I(inode);
		loff_t start =3D folio_pos(folio);
		loff_t i_size =3D i_size_read(inode);
		struct iov_iter from;
		size_t len =3D folio_size(folio);
		int err;

		if (start >=3D i_size)
			return 0; /* Simultaneous truncation occurred */

		len =3D min_t(loff_t, i_size - start, len);

		iov_iter_xarray(&from, ..., start, len);
		...
	}

David

