Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA729D4A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 22:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgJ1Vxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 17:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727827AbgJ1Vxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603922017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/CEDYM98JgXCxM3nau3BhO1AzT+ER9RnJI9yDKsTOQ=;
        b=AO978dlqNlSwDS2/ji63yTxrXpZpmjK8N4kbOtbYzGQeT1Y9RK4RkAx510Y4oJYbBj/adW
        sjbhsPPDR2LKJyoIcQ8FnqF/e40TfwtCVDoXA8qWvl1FPHvnMMGGXxU+UiDfiKP+sR9ZtY
        sMU+bZE7JyfrDgy2KWOkX5SbZtc2PuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-GZHC4amIP2eEWsNtbuZ6BQ-1; Wed, 28 Oct 2020 12:53:04 -0400
X-MC-Unique: GZHC4amIP2eEWsNtbuZ6BQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22DFF57212;
        Wed, 28 Oct 2020 16:53:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7DB45C22D;
        Wed, 28 Oct 2020 16:53:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201028143442.GA20115@casper.infradead.org>
References: <20201028143442.GA20115@casper.infradead.org> <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk> <160389426655.300137.17487677797144804730.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        kernel test robot <lkp@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] afs: Fix dirty-region encoding on ppc32 with 64K pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <541368.1603903981.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 28 Oct 2020 16:53:01 +0000
Message-ID: <541369.1603903981@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +static inline unsigned int afs_page_dirty_resolution(void)
> =

> I've been using size_t for offsets within a struct page.  I don't know
> that we'll ever support pages larger than 2GB (they're completely
> impractical with today's bus speeds), but I'd rather not be the one
> who has to track down all the uses of 'int' in the kernel in fifteen
> years time.

Going beyond 2G page size won't be fun and a lot of our APIs will break -
write_begin, write_end, invalidatepage to name a few.

It would probably require an analysis program to trace all the usages of s=
uch
information within the kernel.

> > +{
> > +	if (PAGE_SIZE - 1 <=3D __AFS_PAGE_PRIV_MASK)
> > +		return 1;
> > +	else
> > +		return PAGE_SIZE / (__AFS_PAGE_PRIV_MASK + 1);
> =

> Could this be DIV_ROUND_UP(PAGE_SIZE, __AFS_PAGE_PRIV_MASK + 1); avoidin=
g
> a conditional?  I appreciate it's calculated at compile time today, but
> it'll be dynamic with THP.

That seems to work.

> >  static inline unsigned int afs_page_dirty_to(unsigned long priv)
> >  {
> > -	return ((priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK) + 1;
> > +	unsigned int x =3D (priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV=
_MASK;
> > +
> > +	/* The upper bound is exclusive */
> =

> I think you mean 'inclusive'.

The returned upper bound points immediately beyond the range.  E.g. 0-0 is=
 an
empty range.  Changing that is way too big an overhaul outside the merge
window.

> > +	return (x + 1) * afs_page_dirty_resolution();
> >  }
> >  =

> >  static inline unsigned long afs_page_dirty(unsigned int from, unsigne=
d int to)
> >  {
> > +	unsigned int res =3D afs_page_dirty_resolution();
> > +	from /=3D res; /* Round down */
> > +	to =3D (to + res - 1) / res; /* Round up */
> >  	return ((unsigned long)(to - 1) << __AFS_PAGE_PRIV_SHIFT) | from;
> =

> Wouldn't it produce the same result to just round down?  ie:
> =

> 	to =3D (to - 1) / res;
> 	return ((unsigned long)to << __AFS_PAGE_PRIV_SHIFT) | from;

Actually, yes, because res/res=3D=3D1, which I then subtract afterwards.

David

