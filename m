Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA19134644A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 17:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhCWQBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhCWQBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:01:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A186FC061574;
        Tue, 23 Mar 2021 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gZLsZmaUj7MP9DFHhIT+qX0xY3GcMrGAZzzfSLvYPHQ=; b=CIlQUqKFiXNUpG7ioNs2IRg+KR
        puiGG6OUEo/LBeGBlWWkkfnWPMtiqFpMHdhsha0RXh+X584qJQrdv5mNaitX2kRMt09kN7mxY2Neq
        tdlmhZwkkrYsxa2LQeZh9GnZjKO5yNys/tCgdo91WLha5dgJN0QAJDGjSDzgBsfY9+4xLLNxIpXB+
        LNbjefqsUhpvnhhCNa5sRXkqOduQAV/B8M85/BIE4z4PJmouWLNJ9zX6dY+2BXnW0FqbOWQqVZpB3
        N/osmT5lvztvSYDvqoAsPpAVzN7klcP7VSh2pfGWTbBMrPDTYgjcZviUBfRMYej6tRCdScSu1w97o
        a6HCdAfg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOjIu-00AF00-Ng; Tue, 23 Mar 2021 15:50:50 +0000
Date:   Tue, 23 Mar 2021 15:50:48 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <20210323155048.GB2438080@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFja/LRC1NI6quL6@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:59:24PM -0400, Johannes Weiner wrote:
> If that is the case, shouldn't there in the long term only be very
> few, easy to review instances of things like compound_head(),
> PAGE_SIZE etc. deep in the heart of MM? And everybody else should 1)
> never see tail pages and 2) never assume a compile-time page size?

Probably.

> But this part is already getting better, and has gotten better, with
> the page cache (largely?) going native for example.

As long as there is no strong typing it is going to remain a mess.

> So I fully agree with the motivation behind this patch. But I do
> wonder why it's special-casing the commmon case instead of the rare
> case. It comes at a huge cost. Short term, the churn of replacing
> 'page' with 'folio' in pretty much all instances is enormous.

The special case is in the eye of the beholder.  I suspect we'll end
up using the folio in most FS/VM interaction eventually, which makes it
the common.  But I don't see how it is the special case?  Yes, changing
from page to folio just about everywhere causes more change, but it also
allow to:

 a) do this gradually
 b) thus actually audit everything that we actually do the right thing

And I think willys whole series (the git branch, not just the few
patches sent out) very clearly shows the benefit of that.

> And longer term, I'm not convinced folio is the abstraction we want
> throughout the kernel. If nobody should be dealing with tail pages in
> the first place, why are we making everybody think in 'folios'? Why
> does a filesystem care that huge pages are composed of multiple base
> pages internally? This feels like an implementation detail leaking out
> of the MM code. The vast majority of places should be thinking 'page'
> with a size of 'page_size()'. Including most parts of the MM itself.

Why does the name matter?  While there are arguments both ways, the
clean break certainly helps every to remind everyone that this is not
your grandfathers fixed sized page.

> 
> The compile-time check is nice, but I'm not sure it would be that much
> more effective at catching things than a few centrally placed warns
> inside PageFoo(), get_page() etc. and other things that should not
> encounter tail pages in the first place (with __helpers for the few
> instances that do).

Eeek, no.  No amount of runtime checks is going to replace compile
time type safety.
