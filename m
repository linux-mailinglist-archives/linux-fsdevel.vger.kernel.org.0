Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF84C3F983D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 12:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbhH0KuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 06:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244939AbhH0Kt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630061350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTjQSWWlrkaygcuBNYQesIo6nKr0wj832LS/mOrVz+A=;
        b=UkhYKk+dTPUy6iQjgSn/F7F1yo+ZNPt/A7lYrmYqw3pv83sqEov6BSiKvlJ4sG9fYaLvXE
        QjGE5cXockid3sW+ZgEyiP7ZBI7n8p5NBPunGA3qoQjhrHp8cQR6U0e42ZEbmUdYzVs6eN
        14XJrwbwaw5dnhQ9Az5w9kXIYDJhxgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-8exCeTxaPsGbTG1FG203PA-1; Fri, 27 Aug 2021 06:49:07 -0400
X-MC-Unique: 8exCeTxaPsGbTG1FG203PA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7187B1082922;
        Fri, 27 Aug 2021 10:49:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63CCC5D9DD;
        Fri, 27 Aug 2021 10:49:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YSi4bZ7myEMNBtlY@cmpxchg.org>
References: <YSi4bZ7myEMNBtlY@cmpxchg.org> <YSZeKfHxOkEAri1q@cmpxchg.org> <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org> <YSQeFPTMn5WpwyAa@casper.infradead.org> <YSU7WCYAY+ZRy+Ke@cmpxchg.org> <YSVMAS2pQVq+xma7@casper.infradead.org> <2101397.1629968286@warthog.procyon.org.uk>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2476940.1630061342.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 27 Aug 2021 11:49:02 +0100
Message-ID: <2476941.1630061342@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> wrote:

> =

> On Thu, Aug 26, 2021 at 09:58:06AM +0100, David Howells wrote:
> > One thing I like about Willy's folio concept is that, as long as every=
one uses
> > the proper accessor functions and macros, we can mostly ignore the fac=
t that
> > they're 2^N sized/aligned and they're composed of exact multiples of p=
ages.
> > What really matters are the correspondences between folio size/alignme=
nt and
> > medium/IO size/alignment, so you could look on the folio as being a to=
ol to
> > disconnect the filesystem from the concept of pages.
> >
> > We could, in the future, in theory, allow the internal implementation =
of a
> > folio to shift from being a page array to being a kmalloc'd page list =
or
> > allow higher order units to be mixed in.  The main thing we have to st=
op
> > people from doing is directly accessing the members of the struct.
> =

> In the current state of the folio patches, I agree with you. But
> conceptually, folios are not disconnecting from the page beyond
> PAGE_SIZE -> PAGE_SIZE * (1 << folio_order()). This is why I asked
> what the intended endgame is. And I wonder if there is a bit of an
> alignment issue between FS and MM people about the exact nature and
> identity of this data structure.

Possibly.  I would guess there are a couple of reasons that on the MM side
particularly it's dealt with as a strict array of pages: efficiency and
mmap-related faults.

It's most efficient to treat it as an array of contiguous pages as that
removes the need for indirection.  From the pov of mmap, faults happen
along the lines of h/w page divisions.

=46rom an FS point of view, at minimum, I just need to know the state of t=
he
folio.  If a page fault dirties several folios, that's fine.  If I can fin=
d
out that a folio was partially dirtied, that's useful, but not critical.  =
I am
a bit concerned about higher-order folios causing huge writes - but I do
realise that we might want to improve TLB/PT efficiency by using larger
entries and that that comes with consequences for mmapped writes.

> At the current stage of conversion, folio is a more clearly delineated
> API of what can be safely used from the FS for the interaction with
> the page cache and memory management. And it looks still flexible to
> make all sorts of changes, including how it's backed by
> memory. Compared with the page, where parts of the API are for the FS,
> but there are tons of members, functions, constants, and restrictions
> due to the page's role inside MM core code. Things you shouldn't be
> using, things you shouldn't be assuming from the fs side, but it's
> hard to tell which is which, because struct page is a lot of things.

I definitely like the API cleanup that folios offer.  However, I do think
Willy needs to better document the differences between some of the functio=
ns,
or at least when/where they should be used - folio_mapping() and
folio_file_mapping() being examples of this.

> However, the MM narrative for folios is that they're an abstraction
> for regular vs compound pages. This is rather generic. Conceptually,
> it applies very broadly and deeply to MM core code: anonymous memory
> handling, reclaim, swapping, even the slab allocator uses them. If we
> follow through on this concept from the MM side - and that seems to be
> the plan - it's inevitable that the folio API will grow more
> MM-internal members, methods, as well as restrictions again in the
> process. Except for the tail page bits, I don't see too much in struct
> page that would not conceptually fit into this version of the folio.
> =

> The cache_entry idea is really just to codify and retain that
> domain-specific minimalism and clarity from the filesystem side. As
> well as the flexibility around how backing memory is implemented,
> which I think could come in handy soon, but isn't the sole reason.

I can see while you might want the clarification.  However, at this point,=
 can
you live with this set of folio patches?  Can you live with the name?  Cou=
ld
you live with it if "folio" was changed to something else?

I would really like to see this patchset get in.  It's hanging over change=
s I
and others want to make that will conflict with Willy's changes.  If we ca=
n
get the basic API of folios in now, that's means I can make my changes on =
top
of them.

Thanks,
David

