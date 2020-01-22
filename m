Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70D9145E38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 22:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgAVVmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 16:42:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33596 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725924AbgAVVmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579729350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sq0QraWPDpkXsBf/Rma/gL22oexCpF9Izn7HjkCvoE=;
        b=Nu8qszLTbEOgl/zsGpU/d32La/LFsij8iSx6K27EEpPyrQYFYnvv/XKQrdrVvpOWBPvD6i
        IydPZ3WeeU30YmwTd6cEWBKEMsVQyhkIG1I7tfvcvPA6wMJv+cQjbk3FGofsNj2oIQX/Qs
        JAV8H9xEJ6XxgsUESxHnaPf2pWIJDSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-6Rm_4Rr4NsuN0Tp4M90w4g-1; Wed, 22 Jan 2020 16:42:26 -0500
X-MC-Unique: 6Rm_4Rr4NsuN0Tp4M90w4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3694918C8C04;
        Wed, 22 Jan 2020 21:42:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EE9F1001B11;
        Wed, 22 Jan 2020 21:42:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200122193306.GB4675@bombadil.infradead.org>
References: <20200122193306.GB4675@bombadil.infradead.org> <3577430.1579705075@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] iov_iter: Add ITER_MAPPING
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3695538.1579729342.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 22 Jan 2020 21:42:22 +0000
Message-ID: <3695539.1579729342@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> =

> > +	rcu_read_lock();						\
> > +	for (page =3D xas_load(&xas); page; page =3D xas_next(&xas)) {	\
> > +		if (xas_retry(&xas, page))				\
> > +			continue;					\
> > +		if (xa_is_value(page))					\
> > +			break;						\
> =

> Do you also want to check for !page?  That would be a bug in the caller.

Well, I stated that one of the preconditions for using this was that the
caller made sure that segment of the mapping was fully populated, so the c=
heck
ought to be unnecessary.

> > +		if (PageCompound(page))					\
> > +			break;						\
> =

> It's perfectly legal to have compound pages in the page cache.  Call
> find_subpage(page, xas.xa_index) unconditionally.

Yeah, I'm just not sure how to deal with them.

> > +		if (page_to_pgoff(page) !=3D xas.xa_index)		\
> > +			break;						\
> =

> ... and you can ditch this if the pages are pinned as find_subpage()
> will bug in this case.

Ok.

> > +		__v.bv_page =3D page;					\
> > +		offset =3D (i->mapping_start + skip) & ~PAGE_MASK;	\
> > +		seg =3D PAGE_SIZE - offset;			\
> > +		__v.bv_offset =3D offset;				\
> > +		__v.bv_len =3D min(n, seg);			\
> > +		(void)(STEP);					\
> > +		n -=3D __v.bv_len;				\
> > +		skip +=3D __v.bv_len;				\
> =

> Do we want STEP to be called with PAGE_SIZE chunks, or if they have a
> THP, can we have it called with larger than a PAGE_SIZE chunk?

It would mean that the STEP function would have to handle multiple pages, =
some
part(s) of which might need to be ignored and wouldn't be able to simply c=
all
memcpy_from/to_page().

> > +#define iterate_all_kinds(i, n, v, I, B, K, M) {		\
> >  	if (likely(n)) {					\
> >  		size_t skip =3D i->iov_offset;			\
> >  		if (unlikely(i->type & ITER_BVEC)) {		\
> > @@ -86,6 +119,9 @@
> >  			struct kvec v;				\
> >  			iterate_kvec(i, n, v, kvec, skip, (K))	\
> >  		} else if (unlikely(i->type & ITER_DISCARD)) {	\
> > +		} else if (unlikely(i->type & ITER_MAPPING)) {	\
> > +			struct bio_vec v;			\
> > +			iterate_mapping(i, n, v, skip, (M));	\
> =

> bio_vec?

Yes - as a strictly temporary thing.  I need a struct contains a page poin=
ter,
a start and a length, and constructing a struct bio_vec on the fly here al=
lows
the caller to potentially share code.  For example:

    size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_it=
er *i)
    {
	char *to =3D addr;
	if (unlikely(iov_iter_is_pipe(i))) {
		WARN_ON(1);
		return 0;
	}
	iterate_and_advance(i, bytes, v,
		__copy_from_user_inatomic_nocache((to +=3D v.iov_len) - v.iov_len,
					 v.iov_base, v.iov_len),
		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
				 v.bv_offset, v.bv_len),
ITER_BVEC ^^^^
		memcpy((to +=3D v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
		memcpy_from_page((to +=3D v.bv_len) - v.bv_len, v.bv_page,
				 v.bv_offset, v.bv_len)
ITER_MAPPING ^^^^
	)

	return bytes;
    }

David

