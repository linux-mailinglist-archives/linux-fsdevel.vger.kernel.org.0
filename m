Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7EA359763
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 10:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhDIIOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 04:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhDIIOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617956075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YraNPigCCa2QjWFUNdLS4ExsZNHhjTNhXM21Vxjs0s=;
        b=iJChKhVkUCP1rBz+XPVkh7PCBL8WNYEFM/rwwWA3XR6txE1Ydf17DkGxKS3ueL6Yi2y49W
        K7L82Ox2YVI6xkHO/v2Uu5glFLjeUc12gpIoLbt61xxSwGGr6rutiOi+Y7r/pzhNfWbxw+
        duzG6zgQfXHa0+3H7svN/1sKdn8S06Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-01GEC8DGP-Cp7uL9zOpe3g-1; Fri, 09 Apr 2021 04:14:33 -0400
X-MC-Unique: 01GEC8DGP-Cp7uL9zOpe3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A5510054F6;
        Fri,  9 Apr 2021 08:14:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C66C160BE5;
        Fri,  9 Apr 2021 08:14:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com>
References: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com> <20210408145057.GN2531743@casper.infradead.org> <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk> <161789066013.6155.9816857201817288382.stgit@warthog.procyon.org.uk> <46017.1617897451@warthog.procyon.org.uk> <136646.1617916529@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] mm: Split page_has_private() in two to better handle PG_private_2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <184802.1617956064.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 09 Apr 2021 09:14:24 +0100
Message-ID: <184803.1617956064@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> >  #define PAGE_FLAGS_PRIVATE                             \
> >         (1UL << PG_private | 1UL << PG_private_2)
>
> I think this should be re-named to be PAGE_FLAGS_CLEANUP, because I
> don't think it makes any other sense to "combine" the two PG_private*
> bits any more. No?

Sure.  Do we even want it still, or should I just fold it into
page_needs_cleanup()?  It seems to be the only place it's used.

> > +static inline int page_private_count(struct page *page)
> > +{
> > +       return test_bit(PG_private, &page->flags) ? 1 : 0;
> > +}
>
> Why is this open-coding the bit test, rather than just doing
>
>         return PagePrivate(page) ? 1 : 0;
>
> instead? In fact, since test_bit() _should_ return a 'bool', I think eve=
n just
>
>         return PagePrivate(page);

Sorry, yes, it should be that.  I was looking at transforming the "1 <<
PG_private" and completely overlooked that this should be PagePrivate().

> should work and give the same result, but I could imagine that some
> architecture version of "test_bit()" might return some other non-zero
> value (although honestly, I think that should be fixed if so).

Yeah.  I seem to recall that test_bit() on some arches used to return the
datum just with the other bits masked off, but I may be misremembering.

In asm-generic/bitops/non-atomic.h:

static inline int test_bit(int nr, const volatile unsigned long *addr)
{
	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
}

should perhaps return bool?

I wonder, should:

	static __always_inline int PageTail(struct page *page)
	static __always_inline int PageCompound(struct page *page)
	static __always_inline int Page##uname(struct page *page)
	static __always_inline int TestSetPage##uname(struct page *page)
	static __always_inline int TestClearPage##uname(struct page *page)

also all return bool?

David

