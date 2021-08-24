Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505A63F6A25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhHXUAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 16:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbhHXUAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629835192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9VSM6gqyDWtwHQvlYNdt1S13CwVzIFODYDm3psHYFeU=;
        b=dc6f1JuM3RNWdbh6b1tBF2p4MBBv1nDeZJ9SDJB/1Wt56uWKL0F+lfqJZgrRIs91ahbrNq
        43Iw5y1Y0ADtKAigHzs3rtRdypCCu7ZEzVH7ohhIWTL9LIx4lNQYRmfe7pmT55DLh8fPJo
        Sesrcq+8s9C1KJvslvrq4pvkcjZE2Bc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-lOJE0O4IOQi10dUnKpcJUg-1; Tue, 24 Aug 2021 15:59:51 -0400
X-MC-Unique: lOJE0O4IOQi10dUnKpcJUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE466760C0;
        Tue, 24 Aug 2021 19:59:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ED2160C0F;
        Tue, 24 Aug 2021 19:59:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whd8ugrzMS-3bupkPQz9VS+dWHPpsVssrDfuFgfff+n5A@mail.gmail.com>
References: <CAHk-=whd8ugrzMS-3bupkPQz9VS+dWHPpsVssrDfuFgfff+n5A@mail.gmail.com> <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com> <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org> <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org> <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com> <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com> <1966106.1629832273@warthog.procyon.org.uk> <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1968459.1629835187.1@warthog.procyon.org.uk>
Date:   Tue, 24 Aug 2021 20:59:47 +0100
Message-ID: <1968460.1629835187@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Something like "page_group" or "pageset" sound reasonable to me as type
> > names.
> 
> "pageset" is such a great name that we already use it, so I guess that
> doesn't work.

Heh.  I tried grepping for "struct page_set" and that showed nothing.  Maybe
"pagegroup"?  Here's a bunch of possible alternatives to set/group:

	https://en.wiktionary.org/wiki/Thesaurus:group

Maybe consider it a sequence of pages, "struct pageseq"?  page_aggregate
sounds like a possibility, but it's quite long.

Though from an fs point of view, I'd be okay hiding the fact that pages are
involved.  It's a buffer; a chunk of memory or chunk of pagecache with
metadata - maybe something on that theme?

David

