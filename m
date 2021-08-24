Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B1B3F6A30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 22:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhHXUC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 16:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHXUCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:02:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6DC061757;
        Tue, 24 Aug 2021 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FYaDQz3WXMafrdPOH+jBu7t6CM5IN56m+9lLa8Z9mro=; b=pZqym/K4FkqCcx0j8hZ4dbgx8r
        /wYknUVZpHFrpweFZlbVDhG7BcOWmVlTwYfFXBHWo+kfG/iOTwZIv8mgTv9knzSmtBGNlK9IiD4xc
        u7f0XoYNuNxI7XeaxQOwuLRKdCK1tjrNXXOHgJNwWxnxle6byWvVg/48uoDuDtY3wUnmmbTquEjkg
        caATO6kd0GLHslkSKw9qxhzyIVRLHua2R2jn+j230P6OK2M1ReC+8QMEZttY6a2C04YNp3eEf7bC/
        ixDSOzchYz5z72uFxNgd94E2S575z/ipN3hqVD4jfUG93nU7PFaH18JK/MM1BAgTnKouCLzW3pPDQ
        dpEDnpaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIcat-00BVIy-UI; Tue, 24 Aug 2021 20:00:48 +0000
Date:   Tue, 24 Aug 2021 21:00:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSVP14doJ0wwb11x@casper.infradead.org>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <YSVCAJDYShQke6Sy@casper.infradead.org>
 <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
 <YSVHI9iaamxTGmI7@casper.infradead.org>
 <YSVMMMrzqxyFjHlw@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSVMMMrzqxyFjHlw@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 03:44:48PM -0400, Theodore Ts'o wrote:
> On Tue, Aug 24, 2021 at 08:23:15PM +0100, Matthew Wilcox wrote:
> > > So when you mention "slab" as a name example, that's not the argument
> > > you think it is. That's a real honest-to-goodness operating system
> > > convention name that doesn't exactly predate Linux, but is most
> > > certainly not new.
> > 
> > Sure, but at the time Jeff Bonwick chose it, it had no meaning in
> > computer science or operating system design.
> 
> I think the big difference is that "slab" is mostly used as an
> internal name.  In Linux it doesn't even leak out to the users, since
> we use kmem_cache_{create,alloc,free,destroy}().  So the "slab"
> doesn't even show up in the API.

/proc/slabinfo
/proc/sys/vm/min_slab_ratio
/sys/kernel/slab
include/linux/slab.h
cpuset.memory_spread_slab
failslab=
slab_merge
slab_max_order=

$ git grep slab fs/ext4 |wc -l
30
(13 of which are slab.h)

> The problem is whether we use struct head_page, or folio, or mempages,
> we're going to be subsystem users' faces.  And people who are using it
> every day will eventually get used to anything, whether it's "folio"
> or "xmoqax", we sould give a thought to newcomers to Linux file system
> code.  If they see things like "read_folio()", they are going to be
> far more confused than "read_pages()" or "read_mempages()".
> 
> Sure, one impenetrable code word isn't that bad.  But this is a case
> of a death by a thousand cuts.  At $WORK, one time we had welcomed an
> intern to our group, I had to stop everyone each time that they used
> an acronym, or a codeword, and asked them to define the term.
> 
> It was really illuminating what an insider takes for granted, but when
> it's one cutsy codeword after another, with three or more such
> codewords in a sentence, it's *really* a less-than-great initial
> experience for a newcomer.
> 
> So if someone sees "kmem_cache_alloc()", they can probably make a
> guess what it means, and it's memorable once they learn it.
> Similarly, something like "head_page", or "mempages" is going to a bit
> more obvious to a kernel newbie.  So if we can make a tiny gesture
> towards comprehensibility, it would be good to do so while it's still
> easier to change the name.

I completely agree that it's good to use something which is not jargon,
or is at least widely-understood jargon.  And I loathe acronyms (you'll
notice I haven't suggested a single one).  Folio/ream/quire/sheaf were
all attempts to get across "collection of pages".  Another direction
would be something that is associated with memory (but I don't have
a good example).  Or a non-English word (roman?  seite?  sidor?)

We're going to end up with hpage, aren't we?
