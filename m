Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B243F6215
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhHXPzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 11:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238474AbhHXPzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629820475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ax6zjB8FCNgsQYLqgNFMq9OeoawxxmOPV3+aTibAsX4=;
        b=XohOedQZTjfsBZdK2/2wpseAJNI9lszdSQf5soGi8cnSE+PX7c4QFRr8f8/ACXOzf3/jz9
        4fcjgI5imvFPNE/kIPdXEHMgnKx9yFdmIqE4hC7Vs+oOapVsSJb9RkbUzgLQkaZq4qwVEq
        4OgiUS5r0v2MyMCVWw0BRFKv0A1vQoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-sL2lRNboPTWorPFJiNMLBA-1; Tue, 24 Aug 2021 11:54:32 -0400
X-MC-Unique: sL2lRNboPTWorPFJiNMLBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92BDA800493;
        Tue, 24 Aug 2021 15:54:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA77A10016F5;
        Tue, 24 Aug 2021 15:54:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com> <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1957059.1629820467.1@warthog.procyon.org.uk>
Date:   Tue, 24 Aug 2021 16:54:27 +0100
Message-ID: <1957060.1629820467@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Yeah, honestly, I would have preferred to see this done the exact
> reverse way: make the rule be that "struct page" is always a head
> page, and anything that isn't a head page would be called something
> else.
> ...
> That said, I see why Willy did it the way he did - it was easier to do
> it incrementally the way he did. But I do think it ends up with an end
> result that is kind of topsy turvy where the common "this is the core
> allocation" being called that odd "folio" thing, and then the simpler
> "page" name is for things that almost nobody should even care about.

From a filesystem pov, it may be better done Willy's way.  There's a lot of
assumption that "struct page" corresponds to a PAGE_SIZE patch of RAM and is
equivalent to a hardware page, so using something other than struct page seems
a better idea.  It's easier to avoid the assumption if it's called something
different.

We're dealing with variable-sized clusters of things that, in the future,
could be, say, a combination of typical 4K pages and higher order pages
(depending on what the arch supports), so I think using "page" is the wrong
name to use.

There are some pieces, kmap being a prime example, that might be tricky to
make handle a transparently variable-sized multipage object, so careful
auditing will likely be required if we do stick with "struct page".

Further, there's the problem that there are a *lot* of places where
filesystems access struct page members directly, rather than going through
helper functions - and all of these need to be fixed.  This is much easier to
manage if we can get the compiler to do the catching.  Hiding them all within
struct page would require a humongous single patch.

One question does spring to mind, though: do filesystems even need to know
about hardware pages at all?  They need to be able to access source data or a
destination buffer, but that can be stitched together from disparate chunks
that have nothing to do with pages (eg. iov_iter); they need access to the
pagecache, and may need somewhere to cache pieces of information, and they
need to be able to pass chunks of pagecache, data or bufferage to crypto
(scatterlists) and I/O routines (bio, skbuff) - but can we hide "paginess"
from filesystems?

The main point where this matters, at the moment, is, I think, mmap - but
could more of that be handled transparently by the VM?

> Because, as you say, head pages are the norm. And "folio" may be a
> clever term, but it's not very natural. Certainly not at all as
> intuitive or common as "page" as a name in the industry.

That's mostly because no one uses the term... yet, and that it's not commonly
used.  I've got used to it in building on top of Willy's patches and have no
problem with it - apart from the fact that I would expect something more like
a plural or a collective noun ("sheaf" or "ream" maybe?) - but at least the
name is similar in length to "page".

And it's handy for grepping ;-)

> I'd have personally preferred to call the head page just a "page", and
> other pages "subpage" or something like that. I think that would be
> much more intuitive than "folio/page".

As previously stated, I think we need to leave "struct page" as meaning
"hardware page" and build some other concept on top for aggregation/buffering.

David

