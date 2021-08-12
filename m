Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB51D3EAC12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhHLUs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229703AbhHLUs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628801283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaXJ+kisbU7RF44zBuHYJFOtJx6fm37DGb251FmYx3Q=;
        b=NgzWg6t2j6NdfAt2wll6K4u94LPjP03Ik7bmcK1ZMdrTXt01gzRc+j/Q1DV4pJHGd3wIKG
        cpC2M6rDiY4KsuNpdxmHL3+wXO68RKZCskaf2kMgZnhu58TSJmQ3NsRFvE0DQP0+5QLJxm
        P0d7Cm4/ZgAYEsg28U3dXVH1p9NqLds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-vrcMW8cdOh2glB2SgLT-hA-1; Thu, 12 Aug 2021 16:48:02 -0400
X-MC-Unique: vrcMW8cdOh2glB2SgLT-hA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D3A487D541;
        Thu, 12 Aug 2021 20:48:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 158125D9D5;
        Thu, 12 Aug 2021 20:47:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YRVHLu3OAwylCONm@casper.infradead.org>
References: <YRVHLu3OAwylCONm@casper.infradead.org> <2408234.1628687271@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] netfs, afs, ceph: Use folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3308342.1628801274.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 12 Aug 2021 21:47:54 +0100
Message-ID: <3308343.1628801274@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> >  (*) Can page_endio() be split into two separate functions, one for re=
ad
> >      and one for write?  If seems a waste of time to conditionally swi=
tch
> >      between two different branches.
> =

> At this point I'm thinking ...
> =

> static inline void folio_end_read(struct folio *folio, int err)
> {
> 	if (!err)
> 		folio_set_uptodate(folio);
> 	folio_unlock(folio);
> }
> =

> Clearly the page isn't uptodate at this point, or ->readpage wouldn't've
> been called.  So there's no need to clear it.  And PageError is
> completely useless.

Seems reasonable.

> > -	*_page =3D page;
> > +	*_page =3D &folio->page;
> =

> Can't do anything about this one; the write_begin API needs to be fixed.

That's fine.  I expected things like this at this stage.

> > @@ -174,40 +175,32 @@ static void afs_kill_pages(struct address_space =
*mapping,
> [...]
> > +		folio_clear_uptodate(folio);
> > +		folio_end_writeback(folio);
> > +		folio_lock(folio);
> > +		generic_error_remove_page(mapping, &folio->page);
> > +		folio_unlock(folio);
> > +		folio_put(folio);
> =

> This one I'm entirely missing.  It's awkward.  I'll work on it.

afs_kill_pages() is just a utility to end writeback, clear uptodate and do
generic_error_remove_page() over a range of pages and afs_redirty_pages() =
is a
utility that to end writeback and redirty a range of pages - hence why I w=
as
thinking it might make sense to put them into common code.

> > -			index +=3D thp_nr_pages(page);
> > -			if (!pagevec_add(&pvec, page))
> > +			index +=3D folio_nr_pages(folio);
> > +			if (!pagevec_add(&pvec, &folio->page))
> =

> Pagevecs are also awkward.  I haven't quite figured out how to
> transition them to folios.

Maybe provide pagevec_add_folio(struct pagevec *, struct folio *)?

> >  zero_out:
> > -	zero_user_segments(page, 0, offset, offset + len, thp_size(page));
> > +	zero_user_segments(&folio->page, 0, offset, offset + len, folio_size=
(folio));
> =

> Yeah, that's ugly.

Maybe:

	folio_clear_around(folio, keep_from, keep_to);

clearing the bits of the folio outside the specified section?

David

