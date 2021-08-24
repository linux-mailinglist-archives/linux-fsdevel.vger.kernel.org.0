Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1E63F6A0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhHXTpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:45:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37950 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229907AbhHXTpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:45:42 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17OJimCa011074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 15:44:49 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 333F915C3DBB; Tue, 24 Aug 2021 15:44:48 -0400 (EDT)
Date:   Tue, 24 Aug 2021 15:44:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSVMMMrzqxyFjHlw@mit.edu>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <YSVCAJDYShQke6Sy@casper.infradead.org>
 <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
 <YSVHI9iaamxTGmI7@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSVHI9iaamxTGmI7@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 08:23:15PM +0100, Matthew Wilcox wrote:
> > So when you mention "slab" as a name example, that's not the argument
> > you think it is. That's a real honest-to-goodness operating system
> > convention name that doesn't exactly predate Linux, but is most
> > certainly not new.
> 
> Sure, but at the time Jeff Bonwick chose it, it had no meaning in
> computer science or operating system design.

I think the big difference is that "slab" is mostly used as an
internal name.  In Linux it doesn't even leak out to the users, since
we use kmem_cache_{create,alloc,free,destroy}().  So the "slab"
doesn't even show up in the API.

The problem is whether we use struct head_page, or folio, or mempages,
we're going to be subsystem users' faces.  And people who are using it
every day will eventually get used to anything, whether it's "folio"
or "xmoqax", we sould give a thought to newcomers to Linux file system
code.  If they see things like "read_folio()", they are going to be
far more confused than "read_pages()" or "read_mempages()".

Sure, one impenetrable code word isn't that bad.  But this is a case
of a death by a thousand cuts.  At $WORK, one time we had welcomed an
intern to our group, I had to stop everyone each time that they used
an acronym, or a codeword, and asked them to define the term.

It was really illuminating what an insider takes for granted, but when
it's one cutsy codeword after another, with three or more such
codewords in a sentence, it's *really* a less-than-great initial
experience for a newcomer.

So if someone sees "kmem_cache_alloc()", they can probably make a
guess what it means, and it's memorable once they learn it.
Similarly, something like "head_page", or "mempages" is going to a bit
more obvious to a kernel newbie.  So if we can make a tiny gesture
towards comprehensibility, it would be good to do so while it's still
easier to change the name.

Cheers,

					- Ted
