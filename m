Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33D143517A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhJTRla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJTRl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:41:29 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF15BC06161C;
        Wed, 20 Oct 2021 10:39:14 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id z3so2519026qvl.9;
        Wed, 20 Oct 2021 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3furhS+g28o/FlyVYnv8OctYtvS+EaHkG1XvHDmariI=;
        b=Z+MjEeTDOWoIto4OQ994dhyr30PwwrRltgHjk6trkVCUpwgVe0dDe7HplgvQ1KvAxK
         7iVBZK14YWuYqIpzruku7g+M4EgmqJ32HILYABKs5MfH3GXNDnUGJ+qJoLUpWQ8Q6oAN
         HD+HcRn1YhFxYsj3HiEVYOBAP3ciIRf5CYoqfgvkgrPPHpQFVlj/zUlNbpXylxYy5ysV
         B/ll72wlYmg8vPEmZ6ltPM/atWY8OjiQeFKE38OBt8/KfJDr2R8sGYX2ixk9PG2j69xX
         uqnzj3J8MCkWo3peXfyqktdcfx9jag5jfZl5i/sxGROLmxzxfuTf/oBQU7zP5yqljM3x
         DaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3furhS+g28o/FlyVYnv8OctYtvS+EaHkG1XvHDmariI=;
        b=lULVd+DK5put5k6aMWi6+XEdHAWzBb9u/+5BBRX17/lTcTTKRcrUl5QUF0J101DoAK
         A1cnJx2ptSX9NJQLAcXiS2A4wpiknrflcBhnbhTHfBSwm33SqrcWsfXILDW7Efu2h7mQ
         jTPZMq4vDYGHpXDPQosLW4xIX5W7f13kEMrYNyNWSji0ooT52KD3jTCwY/o60DoUOr2R
         id9bVC0gNZvygklC1aLPMsxJfxm+rveA0k/Nvntch+SnO1ulWe1/WbBwstXkjsDS4K+L
         /twAPik/A8b9DDAsUUB3F/S+v4qu5zooVBU16XjUoPO8PCX+I6AFyuEUX9Bl/Bb8RKTL
         8esg==
X-Gm-Message-State: AOAM533PKzn1hyUoWinAaWAMFRUioMDuvullR4M3waXZWr6haz6bMoyl
        sG9GuHEvAEQlygEbpBv90tPO8SXOKc2r
X-Google-Smtp-Source: ABdhPJw+j7O2QsBTA8ZCg6i51bekZXHFwApQn11PTEJU2HW7ePOePlxmt9hcWc364zTiQio4yPe64Q==
X-Received: by 2002:a05:6214:29eb:: with SMTP id jv11mr71517qvb.9.1634751553856;
        Wed, 20 Oct 2021 10:39:13 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b2sm1213931qtg.88.2021.10.20.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:39:12 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:39:10 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXBUPguecSeSO6UD@moria.home.lan>
References: <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7hQlny+Go1K3LT@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 11:16:18AM -0400, Johannes Weiner wrote:
> On Tue, Oct 19, 2021 at 02:16:27AM +0300, Kirill A. Shutemov wrote:
> > On Mon, Oct 18, 2021 at 05:56:34PM -0400, Johannes Weiner wrote:
> > > > I don't think there will ever be consensus as long as you don't take
> > > > the concerns of other MM developers seriously.  On Friday's call, several
> > > > people working on using large pages for anon memory told you that using
> > > > folios for anon memory would make their lives easier, and you didn't care.
> > > 
> > > Nope, one person claimed that it would help, and I asked how. Not
> > > because I'm against typesafety, but because I wanted to know if there
> > > is an aspect in there that would specifically benefit from a shared
> > > folio type. I don't remember there being one, and I'm not against type
> > > safety for anon pages.
> > > 
> > > What several people *did* say at this meeting was whether you could
> > > drop the anon stuff for now until we have consensus.
> > 
> > My read on the meeting was that most of people had nothing against anon
> > stuff, but asked if Willy could drop anon parts to get past your
> > objections to move forward.
> > 
> > You was the only person who was vocal against including anon pars. (Hugh
> > nodded to some of your points, but I don't really know his position on
> > folios in general and anon stuff in particular).
> 
> Nobody likes to be the crazy person on the soapbox, so I asked Hugh in
> private a few weeks back. Quoting him, with permission:
> 
> : To the first and second order of approximation, you have been
> : speaking for me: but in a much more informed and constructive and
> : coherent and rational way than I would have managed myself.
> 
> It's a broad and open-ended proposal with far reaching consequences,
> and not everybody has the time (or foolhardiness) to engage on that. I
> wouldn't count silence as approval - just like I don't see approval as
> a sign that a person took a hard look at all the implications.
> 
> My only effort from the start has been working out unanswered
> questions in this proposal: Are compound pages the reliable, scalable,
> and memory-efficient way to do bigger page sizes? What's the scope of
> remaining tailpages where typesafety will continue to lack? How do we
> implement code and properties shared by folios and non-folio types
> (like mmap/fault code for folio and network and driver pages)?
> 
> There are no satisfying answers to any of these questions, but that
> also isn't very surprising: it's a huge scope. Lack of answers isn't
> failure, it's just a sign that the step size is too large and too
> dependent on a speculative future. It would have been great to whittle
> things down to a more incremental and concrete first step, which would
> have allowed us to keep testing the project against reality as we go
> through all the myriad of uses and cornercases of struct page that no
> single person can keep straight in their head.
> 
> I'm grateful for the struct slab spinoff, I think it's exactly all of
> the above. I'm in full support of it and have dedicated time, effort
> and patches to help work out kinks that immediately and inevitably
> surfaced around the slab<->page boundary.

Thank you for at least (belatedly) voicing your appreciation of the struct slab
patches, that much wasn't at all clear to me or Matthew during the initial
discussion.

> I only hoped we could do the same for file pages first, learn from
> that, and then do anon pages; if they come out looking the same in the
> process, a unified folio would be a great trailing refactoring step.
> 
> But alas here we are months later at the same impasse with the same
> open questions, and still talking in circles about speculative code.
> I don't have more time to invest into this, and I'm tired of the
> vitriol and ad-hominems both in public and in private channels.
> 
> I'm not really sure how to exit this. The reasons for my NAK are still
> there. But I will no longer argue or stand in the way of the patches.

Johannes, what I gathered from the meeting on Friday is that all you seem to
care about at this point is whether or not file and anonymous pages are the same
type. You got most of what you wanted regarding the direction of folios -
they're no longer targeted at all compound pages! We're working on breaking
struct page up into multiple types!

But I'm frustrated by you disengaging like this, after I went to a lot of effort
to bring you and your ideas into the discussion, but... if you're going to
stubbornly cling to this point and refuse to hear other ideas the way you have
been, I honestly don't know what to tell you.

And after all this it's hard to see the wider issues with struct page actually
getting tackled.

Shame.
