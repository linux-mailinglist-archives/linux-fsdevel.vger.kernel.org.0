Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3640274B343
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 16:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjGGOta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjGGOt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:49:28 -0400
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [IPv6:2001:41d0:1004:224b::18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83D91FEC
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 07:49:18 -0700 (PDT)
Date:   Fri, 7 Jul 2023 10:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688741356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZ6YpKEyEZa3qGDR76cm8NZULJ6rPjSqaCd+/nJZoMQ=;
        b=Vmkj5euKZmKImMUPTK1pEygW6LL+WUoKPqH6QvNc29PmqC0UK2e9ndcca7bO5Fws7PVtrj
        4WGEF2HFZ90niPscStN6ud+x4H3ToNO+W2yz9KiewdUYs/YjRUXz76zuLu8NWQUeYroNk1
        Ast7uTyJWgXlI1wifPdYfKwg932FnvQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, jack@suse.cz, andreas.gruenbacher@gmail.com,
        brauner@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230707144910.4dvzm3agx7jn65ng@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <ZKgClE9AnmLZpXTM@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKgClE9AnmLZpXTM@bfoster>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 08:18:28AM -0400, Brian Foster wrote:
> As it is, I have been able to dig into various areas of the code, learn
> some of the basic principles, diagnose/fix issues and get some of those
> fixes merged without too much trouble. IMO, the code is fairly well
> organized at a high level, reasonably well documented and
> debuggable/supportable. That isn't to say some of those things couldn't
> be improved (and I expect they will be), but these are more time and
> resource constraints than anything and so I don't see any major red
> flags in that regard. Some of my bigger personal gripes would be a lot
> of macro code generation stuff makes it a bit harder (but not
> impossible) for a novice to come up to speed,

Yeah, we use x-macros extensively for e.g. enums so we can also generate
string arrays. Wonderful for the to_text functions, annoying for
breaking ctags/cscope.

> and similarly a bit more
> introductory/feature level documentation would be useful to help
> navigate areas of code without having to rely on Kent as much. The
> documentation that is available is still pretty good for gaining a high
> level understanding of the fs data structures, though I agree that more
> content on things like on-disk format would be really nice.

A thought I'd been meaning to share anyways: when there's someone new
getting up to speed on the codebase, I like to use it as an opportunity
to write documentation.

If anyone who's working on the code asks for a section of code to be
documented - just tell me what you're looking at and give me an idea of
what your questions are and I'll write out a patch adding kdoc comments.
For me, this is probably the lowest stress way to get code documentation
written, and that way it's added to the code for the next person too.

In the past we've also done meetings where we looked at source code
together and I walked people through various codepaths - I think those
were effective at getting people some grounding, and especially if
there's more people interested I'd be happy to do that again.

Also, I'm pretty much always on IRC - don't hesitate to use me as a
resource!

> Functionality wise I think it's inevitable that there will be some
> growing pains as user and developer base grows. For that reason I think
> having some kind of experimental status for a period of time is probably
> the right approach. Most of the issues I've dug into personally have
> been corner case type things, but experience shows that these are the
> sorts of things that eventually arise with more users. We've also
> briefly discussed things like whether bcachefs could take more advantage
> of some of the test coverage that btrfs already has in fstests, since
> the feature sets should largely overlap. That is TBD, but is something
> else that might be a good step towards further proving out reliability.

Yep, bcachefs implements essentially the same basic user interface for
subvolumes/snapshots, and test coverage for snapshots is an area where
we're still somewhat weak.

> Related to that, something I'm not sure I've seen described anywhere is
> the functional/production status of the filesystem itself (not
> necessarily the development status of the various features). For
> example, is the filesystem used in production at any level? If so, what
> kinds of deployments, workloads and use cases do you know about? How
> long have they been in use, etc.? I realize we may not have knowledge or
> permission to share details, but any general info about usage in the
> wild would be interesting.

I don't have any hard numbers, I can only try to infer. But it has been
used in production (by paying customers) at least a few sites for
several years; I couldn't say how many because I only find out when
something breaks :) In the wider community, it's at least hundreds,
likely thousands based on distinct users reporting bugs, the ammount of
hammering on my git server since it got packaged in nixos, etc.

There's users in the IRC channel who've been running it on multiple
machines for probably 4-5 years, and generally continuously upgrading
them (I've never done an on disk format change that required a mkfs);
I've been running it on my laptops for about that long as well.

Based on the types of bug reports I've been seeing, things have been
stabilizing quite nicely - AFAIK no one's losing data; we do have some
outstanding filesystem corruption bugs but they're little things that
fsck can easily repair and don't lead to data loss (e.g. the erasure
coding tests are complaining about disk space utilization counters being
wrong, some of our tests are still finding the occasional backpointers
bug - Brian just started looking at that one :)

The exception is snapshots, there's a user in China who's been throwing
crazy database workloads at bcachefs - that's still seeing some data
corruption (he sent me a filesystem metadata dump with 2k snapshots that
hit O(n^3) algorithms in fsck, fixes for that are mostly done) - once I
get back to that work and doing more proper torture testing that should
be ironed out soon, we know where the issue is now.

> The development process is fairly ad hoc, so I suspect that is something
> that would have to evolve if this lands upstream. Kent, did you have
> thoughts/plans around that? I don't mind contributing reviews where I
> can, but that means patches would be posted somewhere for feedback, etc.
> I suppose that has potential to slow things down, but also gives people
> a chance to see what's happening, review or ask questions, etc., which
> is another good way to learn or simply keep up with things.

Yeah, that's a good discussion.

I wouldn't call the current development process "ad hoc", it's the
process that's evolved to let me write code the fastest without making
users unhappy :) and that mostly revolves around good test
infrastructure, and a well structured codebase with excellent assertions
so that we can make changes with high confidence that if the tests pass
it's good.

Regarding code review: We do need to do more of that going forward, and
probably talk about what's most comfortable for people, but I'm also not
a big fan of how I see code review typically happening on the kernel
mailing lists and I want to try to push things in a different direction
for bcachefs.

In my opinion, the way we tend to do code review tends to be on the very
fastidious/nitpicky side of things; and this made sense historically
when kernel testing was _hard_ and we depended a lot more on human
review to catch errors. But the downside of that kind of code review is
it's a big time sink, and it burns people out (both the reviewers, and
the people who are trying to get reviews!) - and when the discussion is
mostly about nitpicky things, that takes away energy that could be going
into the high level "what do we want to do and what ideas do we have for
how to get there" discussions.

When we're doing code review for bcachefs, I don't want to see people
nitpicking style and complaining about the style of if statements, and I
don't want people poring over every detail trying to catch bugs that our
test infrastructure will catch. Instead, save that energy for:

 - identifying things that are legitimately tricky or have a high
   probability of introducing errors that won't be caught by tests:
   that's something we do want to talk about, that's being proactive

 - looking at the code coverage analysis to see where we're missing
   tests (we have automated code coverage analysis now!)

 - making sure changes are sane and _understandable_

 - and just keeping abreast of each other's work. We don't need to get
   every detail, just the gist so we can understand each other's goals.

The interactions in engineering teams that I've found to be the most
valuable has never been code review, it's the more abstract discussions
that happen _after_ we all understand what we're trying to do. That's
what I want to see more of.

Now, getting back to "how are we going to do code review" discussion - I
personally prefer to do code review over IRC with a link to their git
repository; I find a conversational format and quick feedback to be very
valuable (I do not want people blocked because they're waiting on code
review).

But the mailing list sees a wider audience, so I see no reason why we
can't start sending all our patches to the linux-bcachefs mailing list
as well.

Regarding the "more abstract, what are we trying to do" discussions: I'm
currently hosting a bcachefs cabal meeting every other week, and I might
bump it up to once a week soon - email me if you'd like an invite, the
wider fs community is definitely meant to be included.

I've also experimented in the past with an open voice chat/conference
call (hosted via the matrix channel); most of us aren't in office
environments anymore, but the shared office with people working on
similar things was great for quickly getting people up to speed, and the
voice chat seemed to work well for that - I'm inclined to start doing
that again.

> All in all I pretty much agree with Josef wrt to the merge request. ISTM
> the main issues right now are the external dependencies and
> development/community situation (i.e. bus factor). As above, I plan to
> continue contributions at least in terms of fixes and whatnot so long as
> $employer continues to allow me to dedicate at least some time to it and
> the community is functional ;), but it's not clear to me if that is
> sufficient to address the concerns here. WRT the dependencies, I agree
> it makes sense to be deliberate and for anything that is contentious,
> either just drop it or lift it into bcachefs for now to avoid the need
> to debate on these various fronts in the first place (and simplify the
> pull request as much as possible).

I'd hoped we can table the discussion on "dependencies" in the abstract.
Prior consensus, from multiple occasions when I was feeding in bcachefs
prep work, was that patches that were _only_ needed for bcachefs should
be part of the bcachefs pull request - that's what I've been sticking
to.

Slimming down the dependencies any further will require non-ideal
engineering tradeoffs, so any request/suggestion to do so needs to come
with some specifics. And Jens already ok'd the 4 block patches, which
were the most significant. 

> With those issues addressed, perhaps it would be helpful if other
> interested fs maintainers/devs could chime in with any thoughts on what
> they'd want to see in order to ack (but not necessarily "review") a new
> filesystem pull request..? I don't have the context of the off list
> thread, but from this thread ISTM that perhaps Josef and Darrick are
> close to being "soft" acks provided the external dependencies are worked
> out. Christoph sent a nak based on maintainer status. Kent, you can add
> me as a reviewer if 1. you think that will help and 2. if you plan to
> commit to some sort of more formalized development process that will
> facilitate review..?

That sounds agreeable :)
