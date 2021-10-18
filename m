Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1B432967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 23:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJRV6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJRV6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 17:58:48 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CCCC06161C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 14:56:36 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id i1so16607750qtr.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BAQbz5Ra9jEJpIzYB/gxA7VNtBbVODtM9YPERq+aYcU=;
        b=6ObYmgmqUdV6WEBk+prwNIxffxFSUOyNyMdQqzqVASzxhvse80sueDBIqERhVU92ce
         vN3a34bNudX/Iur6kJBLxqDelKaj5eiqZT5Qsot6DKJrgveeLoWrOmaUDJ4g4tjdIAzL
         ypYXrUwUXTZfWMhqs6Q7HF6KqAVYXhTEbCNV1z4xluq8gSddG0s+K1eFh6N3HzB5PZKV
         8bW9eF+Lk1UbAEdMF23yGAwodMymMFdoaHTLHHWGABcktYOUhnR8PTgC6nE3ujuvG0k7
         lo1PwM0gAStY7RtlvKHgyGJdP59+0smx1IGY+F02ic85gvfxCkY+OpCKX9zLh6Vbdvpx
         SJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAQbz5Ra9jEJpIzYB/gxA7VNtBbVODtM9YPERq+aYcU=;
        b=6V3+22V74w59KBns3RCJDrGTmc319UvoQkBOLSm79yiGWKv6QUh/My58PIJGrBFyeo
         rPur79bAXzc7+9R1R0WTmZBXj4R45maKSH26Hfcmf7aJgcDB/DW2yoIXMH3jQRxEyA4Y
         gDpZdcvt30i4Pz7cLvr03/9CRpSBukUYMI/Ga3kXGoA6sJPZwbtcCsEH29BtEGpdEuC/
         uQrIcsRezZU3d7MGReUKez6rXMGzTkgGA+mPJom84EB9Rhw6VUVuS4F3gafBXwn9daQf
         svjUbv27GFBGsLXWcMVhX3oWfkdoxo5hGnogENYj/7TtVBGZpZvFJEucY9pa7WrDVJxt
         QzWA==
X-Gm-Message-State: AOAM533pSqjSKhZo02Ed6JxkOdawTG/cjFRslmZtF8rhNz9i4H1O0UkU
        GT8dpq4vl6omchxz2FoJfGk/Ig==
X-Google-Smtp-Source: ABdhPJxvM18mDwncIwCs2iCaZ6sicnW27rBif+0ZXBMUK/e/6E7h03u9MQ/Ehr88dTJwdT5QDSWT0w==
X-Received: by 2002:ac8:4f14:: with SMTP id b20mr32948683qte.252.1634594196058;
        Mon, 18 Oct 2021 14:56:36 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id ay34sm5800774qkb.24.2021.10.18.14.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 14:56:35 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:56:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YW3tkuCUPVICvMBX@cmpxchg.org>
References: <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW28vaoW7qNeX3GP@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 07:28:13PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 18, 2021 at 12:47:37PM -0400, Johannes Weiner wrote:
> > On Sat, Oct 16, 2021 at 04:28:23AM +0100, Matthew Wilcox wrote:
> > > On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
> > > > 		As per the other email, no conceptual entry point for
> > > > 		tail pages into either subsystem, so no ambiguity
> > > > 		around the necessity of any compound_head() calls,
> > > > 		directly or indirectly. It's easy to rule out
> > > > 		wholesale, so there is no justification for
> > > > 		incrementally annotating every single use of the page.
> > > 
> > > The justification is that we can remove all those hidden calls to
> > > compound_head().  Hundreds of bytes of text spread throughout this file.
> > 
> > I find this line of argument highly disingenuous.
> > 
> > No new type is necessary to remove these calls inside MM code. Migrate
> > them into the callsites and remove the 99.9% very obviously bogus
> > ones. The process is the same whether you switch to a new type or not.
> > 
> > (I'll send more patches like the PageSlab() ones to that effect. It's
> > easy. The only reason nobody has bothered removing those until now is
> > that nobody reported regressions when they were added.)
> 
> That kind of change is actively dangerous.  Today, you can call
> PageSlab() on a tail page, and it returns true.  After your patch,
> it returns false.  Sure, there's a debug check in there that's enabled
> on about 0.1% of all kernel builds, but I bet most people won't notice.
> 
> We're not able to catch these kinds of mistakes at review time:
> https://lore.kernel.org/linux-mm/20211001024105.3217339-1-willy@infradead.org/
> 
> which means it escaped the eagle eyes of (at least):
>     Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>     Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>     Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>     Cc: Christoph Lameter <cl@linux.com>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Will Deacon <will.deacon@arm.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> I don't say that to shame these people.  We need the compiler's help
> here.  If we're removing the ability to ask for whether a tail page
> belongs to the slab allocator, we have to have the compiler warn us.
> 
> I have a feeling your patch also breaks tools/vm/page-types.c

As Hugh said in the meeting in response to this, "you'll look at
kernel code for any amount of time, you'll find bugs".

I already pointed out dangerous code from anon/file confusion
somewhere in this thread.

None of that is a reason not to fix it. But it should inform the
approach on how we fix it. I'm not against type safety, I'm for
incremental changes. And replacing an enormous subset of struct page
users with an unproven new type and loosely defined interaction with
other page subtypes is just not that.

> > But typesafety is an entirely different argument. And to reiterate the
> > main point of contention on these patches: there is no concensus among
> > MM people how (or whether) we want MM-internal typesafety for pages.
> 
> I don't think there will ever be consensus as long as you don't take
> the concerns of other MM developers seriously.  On Friday's call, several
> people working on using large pages for anon memory told you that using
> folios for anon memory would make their lives easier, and you didn't care.

Nope, one person claimed that it would help, and I asked how. Not
because I'm against typesafety, but because I wanted to know if there
is an aspect in there that would specifically benefit from a shared
folio type. I don't remember there being one, and I'm not against type
safety for anon pages.

What several people *did* say at this meeting was whether you could
drop the anon stuff for now until we have consensus.

> > Anyway, the email you are responding to was an offer to split the
> > uncontroversial "large pages backing filesystems" part from the
> > controversial "MM-internal typesafety" discussion. Several people in
> > both the fs space and the mm space have now asked to do this to move
> > ahead. Since you have stated in another subthread that you "want to
> > get back to working on large pages in the page cache," and you never
> > wanted to get involved that deeply in the struct page subtyping
> > efforts, it's not clear to me why you are not taking this offer.
> 
> I am.  This email was written after trying to do just this.  I dropped
> the patches you were opposed to and looked at the result.  It's not good.
>
> You seem wedded to this idea that "folios are just for file backed
> memory", and that's not my proposal at all.  folios are for everything.
> Maybe we specialise out other types of memory later, or during, or
> instead of converting something to use folios, but folios are an utterly
> generic concept.

That train left the station when several people said slab should not
be in the folio. Once that happened, you could no longer say it'll
work itself out around the edges. Now it needs a real approach to
coordinating with other subtypes, including shared properties and
implementation between them.

The "simple" folio approach only works when it really is a wholesale
replacement for *everything* that page is right now - modulo PAGE_SIZE
and modulo compound tail. But it isn't that anymore, is it?

Folio can't be everything and only some subtypes simultaneously. So
when you say folio is for everything, is struct slab dead? If not, how
is the relationship between them? How do you query shared property?

There really is no coherent proposal right now. These patches start an
open-ended conversion into a nebulous direction.

All I'm saying is: start with a reasonable, delineated scope (page
cache), and if that test balloon works out we can do the next one with
lessons learned from the first. Maybe that will converge to the
"simple" folio for all compound subtypes, maybe we'll move more toward
explicit subtyping that imply the head/tail thing anyway.

What is even the counter argument to that?
