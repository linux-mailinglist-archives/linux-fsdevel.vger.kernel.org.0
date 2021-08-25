Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F29E3F74BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 14:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbhHYMEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 08:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232681AbhHYMEF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:04:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A6516112D;
        Wed, 25 Aug 2021 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629893000;
        bh=zBJ8+9ku38bfHUh58Fx3TVL+5MVfv6XNhkYjTSMb0cA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NLzUGNiYNcL+ekext3l75EV5XpugcrM+fZxM7I8FLeilj3c4UswndH7llwCf+uMJ+
         nBIfkMPb97vJrw4aeQFCOUGJx7JyRIGZ9VF+dwAkBYEC1emwoBTwhwKgAwE9P7CWpS
         0Rq0pSoLhTHS9WgB6b+kgpd6X3u8PcgDqlnfwZgcgAjVl2Nw+B+5MDRNY4D15xLnlh
         zcbqm1eRlzTrtXip2Fbp0v5dpgd6yEaRO3z3xiRANCqA5GyEHw2RHjJkqtL2ZISNAR
         Vykknz1PP13CKjOseJinTl0V02kzRwJ362IqsXdfCO/GLq2xvbXQvFEXLl6GCKaeIz
         hRIh8fdFefCAw==
Message-ID: <cf30c0e8d1eecf08b2651c5984ff09539e2266f9.camel@kernel.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
From:   Jeff Layton <jlayton@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 25 Aug 2021 08:03:18 -0400
In-Reply-To: <YSXkDFNkgAhQGB0E@infradead.org>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
         <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
         <1957060.1629820467@warthog.procyon.org.uk>
         <YSUy2WwO9cuokkW0@casper.infradead.org>
         <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
         <YSVCAJDYShQke6Sy@casper.infradead.org>
         <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
         <YSVHI9iaamxTGmI7@casper.infradead.org> <YSVMMMrzqxyFjHlw@mit.edu>
         <YSXkDFNkgAhQGB0E@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-08-25 at 07:32 +0100, Christoph Hellwig wrote:
> On Tue, Aug 24, 2021 at 03:44:48PM -0400, Theodore Ts'o wrote:
> > The problem is whether we use struct head_page, or folio, or mempages,
> > we're going to be subsystem users' faces.  And people who are using it
> > every day will eventually get used to anything, whether it's "folio"
> > or "xmoqax", we sould give a thought to newcomers to Linux file system
> > code.  If they see things like "read_folio()", they are going to be
> > far more confused than "read_pages()" or "read_mempages()".
> 
> Are they?  It's not like page isn't some randomly made up term
> as well, just one that had a lot more time to spread.
> 

Absolutely.  "folio" is no worse than "page", we've just had more time
to get used to "page".

> > So if someone sees "kmem_cache_alloc()", they can probably make a
> > guess what it means, and it's memorable once they learn it.
> > Similarly, something like "head_page", or "mempages" is going to a bit
> > more obvious to a kernel newbie.  So if we can make a tiny gesture
> > towards comprehensibility, it would be good to do so while it's still
> > easier to change the name.
> 
> All this sounds really weird to me.  I doubt there is any name that
> nicely explains "structure used to manage arbitrary power of two
> units of memory in the kernel" very well.  So I agree with willy here,
> let's pick something short and not clumsy.  I initially found the folio
> name a little strange, but working with it I got used to it quickly.
> And all the other uggestions I've seen s far are significantly worse,
> especially all the odd compounds with page in it.

Same here. Compound words are especially bad, as newbies will
continually have to look at whether it's "page_set" or "pageset".

-- 
Jeff Layton <jlayton@kernel.org>

