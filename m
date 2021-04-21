Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35036694D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhDUKfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 06:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234554AbhDUKfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619001290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBXxha+Xkzm2yOamN1VQ5k3GDjBF25oS570HlOsYhjc=;
        b=hwxc1YLJQmhzcKBAhuP6RA68lw+VOG44Y7PZ575lVtDJSRWG2EIrY/qMXzGzB0B+GPfPbt
        UOM/0/UPnqvGZ3Rn7LQM7XmG4ZCVMg79XOgQmNjGX/eZdd+bz5x+rKEtFtH4Zz9CPaEkfa
        gNSz/WERVNY8gTdszhdPLs9GkMid3pE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-OtESsXq8NL2Z_Qs5TIJs1Q-1; Wed, 21 Apr 2021 06:34:47 -0400
X-MC-Unique: OtESsXq8NL2Z_Qs5TIJs1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A1CD83DD23;
        Wed, 21 Apr 2021 10:34:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-33.rdu2.redhat.com [10.10.112.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CA155D9C0;
        Wed, 21 Apr 2021 10:34:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210420210328.GD3596236@casper.infradead.org>
References: <20210420210328.GD3596236@casper.infradead.org> <20210420200116.3715790-1-willy@infradead.org> <3675c1d23577dded6ca97e0be78c153ce3401e10.camel@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: Handle ractl nr_pages being modified
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 21 Apr 2021 11:34:44 +0100
Message-ID: <2159218.1619001284@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Apr 20, 2021 at 04:12:57PM -0400, Jeff Layton wrote:
> > > @@ -210,6 +208,7 @@ void page_cache_ra_unbounded(struct readahead_con=
trol *ractl,
> > > =C2=A0			 * not worth getting one just for that.
> > > =C2=A0			 */
> > > =C2=A0			read_pages(ractl, &page_pool, true);
> > > +			i =3D ractl->_index + ractl->_nr_pages - index;
>=20
> 			i =3D ractl->_index + ractl->_nr_pages - index - 1;
>=20
> > > @@ -223,6 +222,7 @@ void page_cache_ra_unbounded(struct readahead_con=
trol *ractl,
> > > =C2=A0					gfp_mask) < 0) {
> > > =C2=A0			put_page(page);
> > > =C2=A0			read_pages(ractl, &page_pool, true);
> > > +			i =3D ractl->_index + ractl->_nr_pages - index;
>=20
> 			i =3D ractl->_index + ractl->_nr_pages - index - 1;
>=20
> > Thanks Willy, but I think this may not be quite right. A kernel with
> > this patch failed to boot for me:
>=20
> Silly off-by-one errors.  xfstests running against xfs is up to generic/2=
78
> with the off-by-one fixed.

You can add my Tested-by - or do you want me to add it to my patchset?

David

