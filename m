Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3A3F7F91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 02:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhHZBAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 21:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234396AbhHZBAA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 21:00:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 636B660F6F;
        Thu, 26 Aug 2021 00:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629939554;
        bh=EXrb+gVpKlIS/8zNJQMeoK/jfDFoPwPN7MIaRo88m5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZalcFUQZA0ontYQPUcmHKUZnISqknge/El2n25Na0epoWdBEIgCMlcECF4n5nan5D
         9rxjCAMiBuVX+E0WQvgvzkYNmSJjil/P515Ff1oLc0UrsnKXK6vEeIhzRCtIL4Ih0n
         PYAHN/bnaEGbTEeR/8+zIrlkWphfB0+M8INYGZOSmE/mJfeljMn0TAB8UX8pesIp9S
         ECB637/fIlSkPc5J/w+AG4bRJQ1CDut2VB6dQyOhOcka7jUovRM3EcPaUbmYU+p4QA
         tN2yfOSZVveKrHPJwqhuM7aPvub1htWL7NcS+OzmSrAxfRdZjcHEBSkf+fnpzmCWCW
         JhWIAXMDIApTw==
Date:   Wed, 25 Aug 2021 17:59:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <20210826005914.GG12597@magnolia>
References: <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <YSVCAJDYShQke6Sy@casper.infradead.org>
 <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
 <YSVHI9iaamxTGmI7@casper.infradead.org>
 <YSVMMMrzqxyFjHlw@mit.edu>
 <YSXkDFNkgAhQGB0E@infradead.org>
 <cf30c0e8d1eecf08b2651c5984ff09539e2266f9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf30c0e8d1eecf08b2651c5984ff09539e2266f9.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 25, 2021 at 08:03:18AM -0400, Jeff Layton wrote:
> On Wed, 2021-08-25 at 07:32 +0100, Christoph Hellwig wrote:
> > On Tue, Aug 24, 2021 at 03:44:48PM -0400, Theodore Ts'o wrote:
> > > The problem is whether we use struct head_page, or folio, or mempages,
> > > we're going to be subsystem users' faces.  And people who are using it
> > > every day will eventually get used to anything, whether it's "folio"
> > > or "xmoqax", we sould give a thought to newcomers to Linux file system
> > > code.  If they see things like "read_folio()", they are going to be
> > > far more confused than "read_pages()" or "read_mempages()".
> > 
> > Are they?  It's not like page isn't some randomly made up term
> > as well, just one that had a lot more time to spread.
> > 
> 
> Absolutely.  "folio" is no worse than "page", we've just had more time
> to get used to "page".

I /like/ the name 'folio'.  My privileged education :P informed me (when
Matthew talked to me the very first time about this patchset) that it's
a wonderfully flexible word that describes both a collection of various
pages and a single large sheet of paper folded in half.  Or in the case
of x86, folded in half nine times.

That's *exactly* the usage that Matthew is proposing.

English already had a word ready for us to use, so let's use it.

--D

(Well, ok, the one thing I dislike is that my brain keeps typing out
'fileio' instead of 'folio', but it's still better than struct xmoqax or
remembering if we do camel_case or PotholeCase.)

> > > So if someone sees "kmem_cache_alloc()", they can probably make a
> > > guess what it means, and it's memorable once they learn it.
> > > Similarly, something like "head_page", or "mempages" is going to a bit
> > > more obvious to a kernel newbie.  So if we can make a tiny gesture
> > > towards comprehensibility, it would be good to do so while it's still
> > > easier to change the name.
> > 
> > All this sounds really weird to me.  I doubt there is any name that
> > nicely explains "structure used to manage arbitrary power of two
> > units of memory in the kernel" very well.  So I agree with willy here,
> > let's pick something short and not clumsy.  I initially found the folio
> > name a little strange, but working with it I got used to it quickly.
> > And all the other uggestions I've seen s far are significantly worse,
> > especially all the odd compounds with page in it.
> 
> Same here. Compound words are especially bad, as newbies will
> continually have to look at whether it's "page_set" or "pageset".
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
