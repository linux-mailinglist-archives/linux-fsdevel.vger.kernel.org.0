Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB477820C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 02:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjHUAKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Aug 2023 20:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHUAKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Aug 2023 20:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD13AA
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Aug 2023 17:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692576586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9tC0PKOWAzpOk8xpgzmC08xuNXgU/3kPpzPnOABqlM=;
        b=QUxcujN12NiWXmAQzBTew1UmuPokHNwRC7/D3hfDcdCOjuGAzw7HX37tDGQIKBTb72jJ43
        xdjlrgtVKc8J21UlGFhw8JbSL43hWeBvAxmhYPQf9M75So++zHXQJJOsjhf23fZuL0pJMz
        +CLZBtLM2rQYLiLPrMf8uzebfKXdh7M=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-i_5bILhmOZWukP-09k9tDw-1; Sun, 20 Aug 2023 20:09:41 -0400
X-MC-Unique: i_5bILhmOZWukP-09k9tDw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26A4B2A59549;
        Mon, 21 Aug 2023 00:09:41 +0000 (UTC)
Received: from rh (unknown [10.64.138.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28B1E403161;
        Mon, 21 Aug 2023 00:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <dchinner@redhat.com>)
        id 1qXsUC-00025A-1A;
        Mon, 21 Aug 2023 10:09:36 +1000
Date:   Mon, 21 Aug 2023 10:09:34 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, sandeen@redhat.com,
        willy@infradead.org, josef@toxicpanda.com, tytso@mit.edu,
        bfoster@redhat.com, jack@suse.cz, andreas.gruenbacher@gmail.com,
        brauner@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZOKrPoGnmI6UHvXT@rh>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230810223942.GG11336@frogsfrogsfrogs>
 <20230811034526.itwk7h6ibzje6tfr@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811034526.itwk7h6ibzje6tfr@moria.home.lan>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Been on PTO this last week and a half]

On Thu, Aug 10, 2023 at 11:45:26PM -0400, Kent Overstreet wrote:
> On Thu, Aug 10, 2023 at 03:39:42PM -0700, Darrick J. Wong wrote:
> > Nowadays we have all these people running bots and AIs throwing a steady
> > stream of bug reports and CVE reports at Dave [Chinner] and I.  Most of
> > these people *do not* help fix the problems they report.  Once in a
> > while there's an actual *user* report about data loss, but those
> > (thankfully) aren't the majority of the reports.
> > 
> > However, every one of these reports has to be triaged, analyzed, and
> > dealt with.  As soon as we clear one, at least one more rolls in.  You
> > know what that means?  Dave and I are both in a permanent state of
> > heightened alert, fear, and stress.  We never get to settle back down to
> > calm.  Every time someone brings up syzbot, CVEs, or security?  I feel
> > my own stress response ramping up.  I can no longer have "rational"
> > conversations about syzbot because those discussions push my buttons.
> > 
> > This is not healthy!
> 
> Yeah, we really need to take a step back and ask ourselves what we're
> trying to do here.
> 
> At this point, I'm not so sure hardening xfs/ext4 in all the ways people
> are wanting them to be hardened is a realistic idea: these are huge, old
> C codebases that are tricky to work on, and they weren't designed from
> the start with these kinds of considerations. Yes, in a perfect world
> all code should be secure and all bugs should be fixed, but is this the
> way to do it?

Look at it this way: For XFS we've already done the hardening work -
we started that way back in 2008 when we started planning for the V5
filesystem format to avoid all the random bit failures that were
occuring out there in the real world and from academic fuzzer
research.

The problem with syzbot has been that has been testing the old V4
format and it keeps tripping over different symptoms of the same
problems the v5 format either isn't susceptible to or it detects
and fixes/shuts down the filesystem.

Since syzbot finally turned off v4 format testing on the 3rd July,
we haven't had a single new syzbot bug report on XFS. I don't expect
syzbot to find a significant amount of new issues on XFS from this
point onwards...

So, yeah, I think we did the bulk of the possible format
verification/hardening work in XFS a decade ago, and the stream of
bugs we've been seeing is due to intentionally ignoring the format
that actually provides some defences against random bit manipulation
based failures...

> Personally, I think we'd be better served by putting what manpower we
> can spare into starting on an incremental Rust rewrite; at least that's
> my plan for bcachefs, and something I've been studying for awhile (as
> soon as the gcc rust stuff lands I'll be adding Rust code to
> fs/bcachefs, some code already exists). For xfs/ext4, teasing things
> apart and figuring out how to restructure data structures in a way to
> pass the borrow checker may not be realistic, I don't know the codebases
> well enough to say - but clearly the current approach is not working,
> and these codebases are almost definitely still going to be in use 50
> years from now, we need to be coming up with _some_ sort of plan.

For XFS, my plan for the past couple of years has been to start with
rewriting chunks of the userspace code in rust. That shares the core
libxfs code with the kernel, so the idea is that we slowly
reimplement bits of libxfs in userspace in rust where we have the
freedom to just rip and tear the code apart. Then when we have
something that largely works we can pull that core libxfs rust code
back into the kernel as rust support improves.

Of course, that's been largely put on the back burner over the past
year or so because of all the other demands on my time stuff like
dealing with 1-2 syzbot bug reports a week have resulted in....

> And if we had a coherent long term plan, maybe that would help with the
> funding and headcount issues...

I don't think a lack of a plan is the problem with funding and
headcount. At it's core, the problem is inherent in the capitalism
model that is "funding" the "community" - squeeze the most you can
from as little as possible and externalise the costs as much as
possible. Burning people out is essentially externalising the human
cost of corporate bean counter optimisation of the bottom line...

If I had a dollar for every time I'd been told "we don't have the
money for more resources" whilst both company revenue and profits
are continually going up, we could pay for another engineer...

[....]

> > A broader dynamic here is that I ask people to review the code so that I
> > can merge it; they say they will do it; and then an entire cycle goes by
> > without any visible progress.
> > 
> > When I ask these people why they didn't follow through on their
> > commitments, the responses I hear are pretty uniform -- they got buried
> > in root cause analysis of a real bug report but lol there were no other
> > senior people available; their time ended up being spent on backports or
> > arguing about backports; or they got caught up in that whole freakout
> > thing I described above.
> 
> Yeah, that set of priorities makes sense when we're talking about
> patches that modify existing code; if you can't keep up with bug reports
> then you have to slow down on changes, and changes to existing code
> often do need the meticulous review - and hopefully while people are
> waiting on code review they'll be helping out with bug reports.
> 
> But for new code that isn't going to upset existing users, if we trust
> the author to not do crazy things then code review is really more about
> making sure someone else understands the code. But if they're putting in
> all the proper effort to document, to organize things well, to do things
> responsibly, does it make sense for that level of code review to be an
> up front requirement? Perhaps we could think a _bit_ more about how we
> enable people to do good work.

That's pretty much the review rationale I'm using for the online
fsck code. I really only care in detail about how it interfaces with
the core XFS infrastructure, and as long as the rest of it makes
sense and doesn't make my eyes bleed then it's good enough.

That doesn't change the fact that it takes me at least a week to
read through 10,000 lines of code in sufficient rigour to form an
opinion on it, and that's before I know what I need to look at in
more detail.

So however you look at it, even a "good enough" review of 50,000
lines of new code (the size of online fsck) still requires a couple
of months of review time for someone who knows the subsystem
intimately...

> I'm sure the XFS people have thought about this more than I have, but
> given how long this has been taking you and the amount of pushback I
> feel it ought to be asked.

Certainly we have, and for a long time the merge criteria for code
that is tagged as EXPERIMENTAL has been lower (i.e. good enough) and
that's how we merged things like the v5 format, reflink support,
rmap support, etc without huge amounts of review friction. The
problem is that drive over the past few years for more intense
review because CI and bot driven testing with no regression policies
has really pushed common sense out the window.

These days it feels like we're only allowed to merge "perfect" code
otherwise the code is "insecure" (e.g. the policies being advocated
by syzbot developers). Hence review over the past few years got more
finicky and picky because of the fear that regressions will be
introduced with new code. This is a direct result of it being
drummed into developers that regressions and CI failures must be
avoided at -all costs-.

i.e. the policies and testing infrastructure that is being used to
"validate" these large software projects is pushing us hard towards
the "code must be perfect at first attempt" side of the coin rather
than more the more practical (and achievable) "good enough" bar.
CI is useful and good for code quality, but common sense has to
prevail at some point....

-Dave.
-- 
Dave Chinner
dchinner@redhat.com

