Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707CE40EA26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbhIPSpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 14:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbhIPSpD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:45:03 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477F5C0F9C91;
        Thu, 16 Sep 2021 10:15:19 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g11so4631049qvd.2;
        Thu, 16 Sep 2021 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F1dJN61v4a5HavamkHN7ACFSKiKkM/zUmpKZlIwuGio=;
        b=HdcVwodHBTqTcKj9a4KQNQ9TZ9py7/8rywZo2MLdkVpA5JTYsTHiPcov76FAibXmEV
         rItqYaYOlklvI4WrzkJOFWUMWZVbk/ripAAflVeHPjQaiHdKWrV0vhGs6qQmpYbwcssd
         E8GfTlwjmytE8+mgKgiAbxc8uOUDKowD6lbt7jBtxFOTm30nn8VT+9mvWWeKdGJ6hV2/
         z0NbQOvWY8H/etz8+xSrEhmqdBhzTL8CZqftMTMpielYegSMCKCw1fzBEKDGODEfEQcf
         HmGek3GjnTiRZQJHqMPWL6aBy5vb0tmX+xXzOH2zNmVt1Lna5U23cdrXWox9t6OzGvi0
         hFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F1dJN61v4a5HavamkHN7ACFSKiKkM/zUmpKZlIwuGio=;
        b=YP0d2rMEDYwtNjOf+zVM4mdZk53WLgnNyrOBVGNcbtpIZxkGhsN6aPO3LLzRekL3Yu
         3/pfWg7EQITmTALv2q0yJGj06FFiq/uneLijCNRn1KMHNeHO+w8aaWCkQ8kkVpVhvnXb
         0GAHl4XDIdz6YThgBCcJlHL1HAlfjvG8ul5CksKZYHOrVLmCnP6EprDsmVnLtDbZH4Eg
         4JqbjEz6kEuNg77KokzjfoVH0tvR6IyEy00Qf6nL+fNWElD9dFk8VuO0bXsHE1UVEytO
         C28CM4yl78oGiZm0dl1uWba6vDIOWv9rqkSMlT+vj31sMs7oNNmi9/PjDGpSSjMych4Q
         FpBg==
X-Gm-Message-State: AOAM533w4wGchsLs3uGXQMmqzyqoKd/dpATY4Zie7SkxZhqocWOqulWn
        XgHzxY9MnVZg3PkV0Cbalg==
X-Google-Smtp-Source: ABdhPJxPfI06sAVkGTy6viKv9UCBKipVm8L7Phjt+5w05y5+F9R58r0HFB7zZMJz+R9x59xlOaqZCw==
X-Received: by 2002:ad4:4a21:: with SMTP id n1mr6387082qvz.22.1631812517789;
        Thu, 16 Sep 2021 10:15:17 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id i14sm2632326qka.66.2021.09.16.10.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:15:16 -0700 (PDT)
Date:   Thu, 16 Sep 2021 13:15:14 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Chris Mason <clm@fb.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Message-ID: <YUN7oiFs5JHgQNop@moria.home.lan>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu>
 <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
 <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:46:25PM +0000, Chris Mason wrote:
> It feels like these patches are moving forward, but with a pretty heavy
> emotional cost for the people involved.  I'll definitely agree this has been
> our process for a long time, but I'm struggling to understand why we'd call it
> working.
> 
> In general, we've all come to terms with huge changes being a slog through
> consensus building, design compromise, the actual technical work, and the
> rebase/test/fix iteration cycle.  It's stressful, both because of technical
> difficulty and because the whole process is filled with uncertainty.
> 
> With folios, we don't have general consensus on:
> 
> * Which problems are being solved?  Kent's writeup makes it pretty clear
> filesystems and memory management developers have diverging opinions on this.
> Our process in general is to put this into patch 0.  It mostly works, but
> there's an intermediate step between patch 0 and the full lwn article that
> would be really nice to have.
> 
> * Who is responsible for accepting the design, and which acks must be obtained
> before it goes upstream?  Our process here is pretty similar to waiting for
> answers to messages in bottles.  We consistently leave it implicit and poorly
> defined.
> 
> * What work is left before it can go upstream?  Our process could be
> effectively modeled by postit notes on one person's monitor, which they may or
> may not share with the group.  Also, since we don't have agreement on which
> acks are required, there's no way to have any certainty about what work is
> left.  It leaves authors feeling derailed when discussion shifts and reviewers
> feeling frustrated and ignored.
> 
> * How do we divide up the long term future direction into individual steps
> that we can merge?  This also goes back to consensus on the design.  We can't
> decide which parts are going to get layered in future merge windows until we
> know if we're building a car or a banana stand.
> 
> * What tests will we use to validate it all?  Work this spread out is too big
> for one developer to test alone.  We need ways for people sign up and agree on
> which tests/benchmarks provide meaningful results.
> 
> The end result of all of this is that missing a merge window isn't just about
> a time delay.  You add N months of total uncertainty, where every new email
> could result in having to start over from scratch.  Willy's
> do-whatever-the-fuck-you-want-I'm-going-on-vacation email is probably the
> least surprising part of the whole thread.
> 
> Internally, we tend to use a simple shared document to nail all of this down.
> A two page google doc for folios could probably have avoided a lot of pain
> here, especially if we’re able to agree on stakeholders.
> 
> -chris

Agreed on all points. We don't have a culture of talking about design changes
before doing them, and maybe we should - the Rust RFC process is another
alternate model.

That isn't always a bad thing: I have often found that my best improvements to
my own code have come from doing a lot of exploratory refactoring, keeping what
works and discarding what doesn't, trusting my intuiting and then then looking
afterwards at what got better, and asking myself what that tells me about what
the design wants to be.

In hindsight I feel like Willy must have been doing the same thing; I think the
folio work is opening up _really_ interesting new avenues to explore - I was one
of the people talking about compound pages in the page cache early on, yet I did
not and would not have guessed where the work was actually going to lead, and I
find myself _really_ liking it.

But more than the question of whether we write design docs up front, I frankly
think we have a _broken_ culture with respect to supporting and enabling cross
subsystem refactorings and improvements. Instead of collectively coming up with
ideas for improvements, a lot of the discussions I see end up feeling like turf
wars and bikeshedding where everyone has their pet idea they want the thing to
be and no one is taking a step back and saying "look at this mess we created,
how are we going to simplify and clean it up."

And we have created some unholy messes, especially in MM land. I've been digging
into the rmap code and trying to figure out what the _inherent, fundamental_
differences between file and anonymous pages are - I think folios should also
include anonymous pages, but not yet - and I keep finding stuff that's just
gross. Endless if (old thing) if (new thing) where literally no effort has ever
been made to figure out if these things maybe should be the same thing.

It's like - seriously people, it's ok to create messes when we're doing new
things and figuring them out for the first time, but we have to go back and
clean up our messes or we end up with an unmaintainable Cthulian horror no one
can untangle, and a lot of the MM code is just about that point.

And if you look at our culture for how these kinds of deep invasive new features
gets developed and reviewed and added, is it really any surprise? We bikeshed
things to death, which scares people off and means they make the minimal changes
they need to core code - which means not touching the existing paths any more
than necessary, and people don't want to come back when they're done. Our
process is not encouraging good work!

And when Willy comes along with folios - which by introducing a new data type
for our main subtype of pages, are a starting point to taming this insanity - he
gets hit with the most ridiculous objections, like whether folios are a
replacement for compound pages (answer: no, compound pages belong to the other
side of the allocator/allocatee divide). It's like no one has ever heard of
separation of concerns.

To everyone involved: if you want to do competent design work you have to be
able to separate yourself from the specific problems you've been staring at and
look at the wider picture, and ask yourself if this thing you want is a good
idea for the wider ecosystem, or whether your specific problem _matters_ in this
instance.

MM people: I know you care about fragmentation, and that a lot of your work days
is spent dealing with it. But it's not a concern for folios, because we can
always _fail the allocation and allocate a smaller one_. And I have specifically
pushed back when filesystem people wanted fixed size folios because they thought
it would make their lives easier: to restate my answer to that publically,
folios are basically extents, and part of being a filesystem developer and
dealing with extents is that you have to get used to dealing with arbitrary
sized extents - i.e. processing them incrementally, you have to be more flexible
in your thinking then when you were writing code that was working with fixed
size blocks or pages. But you'll deal.

/end rant

I apologize in advance if anyone feels I've been unfair to them; we are all,
after all, figuring this out as we go along. But we've got room for improvement!
