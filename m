Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7787015C13E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgBMPTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 10:19:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51039 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbgBMPTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581607176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rOVeNBVmp5n6jx2uesy/jP1X8fypL1Y2WTFzlRwHizI=;
        b=c0x4LRNJZchEVD8O8NzhBEfsOf1K/70upNLXyLAkXBQi2JJNdXDv6M3SLy6k5lq9C6SVTN
        a1VdJhRHqjgXQrB2KsoZHEv4OdvJIZzk/zowCMnlKRD+nYwNn1XRlwr1oQ0LfK39T5L69J
        a6SD66FSA0OMNd37G3AUNDhqym6hTMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-vmyKEAMTMQucWHfC-7AsrQ-1; Thu, 13 Feb 2020 10:19:34 -0500
X-MC-Unique: vmyKEAMTMQucWHfC-7AsrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50479477;
        Thu, 13 Feb 2020 15:19:33 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C941E5C100;
        Thu, 13 Feb 2020 15:19:29 +0000 (UTC)
Date:   Thu, 13 Feb 2020 10:19:28 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Allison Collins <allison.henderson@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200213151928.GD6548@bfoster>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
 <20200212233929.GS10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212233929.GS10776@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:39:29AM +1100, Dave Chinner wrote:
> Hi Allison,
> 
> These are some very good observations and questions. I've found it
> hard to write a meaningful response because there are many things I
> just take for granted having done this for many many years...
> 
> I don't have all the answers. Lots of what I say is opinion (see my
> comments about opinions below!) based on experience and the best I
> can do to help improve the situation is to share what I think and
> let people reading this decide what might be useful to their own
> situations.
> 
> On Sun, Feb 09, 2020 at 10:12:03AM -0700, Allison Collins wrote:
> > On 2/2/20 2:46 PM, Dave Chinner wrote:
> > > On Fri, Jan 31, 2020 at 08:20:37PM -0700, Allison Collins wrote:
> > > > On 1/31/20 12:30 AM, Amir Goldstein wrote:
> > > > > On Fri, Jan 31, 2020 at 7:25 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > > Bottom line - a report of the subsystem review queue status, call for
> > > > > reviewers and highlighting specific areas in need of review is a good idea.
> > > > > Developers responding to that report publicly with availability for review,
> > > > > intention and expected time frame for taking on a review would be helpful
> > > > > for both maintainers and potential reviewers.
> > > > I definitely think that would help delegate review efforts a little more.
> > > > That way it's clear what people are working on, and what still needs
> > > > attention.
> > > 
> > > It is not the maintainer's repsonsibility to gather reviewers. That
> > > is entirely the responsibility of the patch submitter. That is, if
> > > the code has gone unreviewed, it is up to the submitter to find
> > > people to review the code, not the maintainer. If you, as a
> > > developer, are unable to find people willing to review your code
> > > then it's a sign you haven't been reviewing enough code yourself.
> > > 
> > > Good reviewers are a valuable resource - as a developer I rely on
> > > reviewers to get my code merged, so if I don't review code and
> > > everyone else behaves the same way, how can I possibly get my code
> > > merged? IOWs, review is something every developer should be spending
> > > a significant chunk of their time on. IMO, if you are not spending
> > > *at least* a whole day a week reviewing code, you're not actually
> > > doing enough code review to allow other developers to be as
> > > productive as you are.
> > > 
> > > The more you review other people's code, the more you learn about
> > > the code and the more likely other people will be to review your
> > > code because they know you'll review their code in turn.  It's a
> > > positive reinforcement cycle that benefits both the individual
> > > developers personally and the wider community.
> > > 
> > > But this positive reinforcemnt cycle just doesn't happen if people
> > > avoid reviewing code because they think "I don't know anything so my
> > > review is not going to be worth anything".  Constructive review, not
> > > matter whether it's performed at a simple or complex level, is
> > > always valuable.
> > > 
> > > Cheers,
> > > 
> > > Dave.
> > > 
> > Well, I can see the response is meant to be encouraging, and you are right
> > that everyone needs to give to receive :-)
> > 
> > I have thought a lot about this, and I do have some opinions about it how
> > the process is described to work vs how it ends up working though. There has
> > quite been a few times I get conflicting reviews from multiple reviewers. I
> > suspect either because reviewers are not seeing each others reviews, or
> > because it is difficult for people to recall or even find discussions on
> > prior revisions.  And so at times, I find myself puzzling a bit trying to
> > extrapolate what the community as a whole really wants.
> 
> IMO, "what the community wants" really doesn't matter in the end;
> the community really doesn't know what it wants.  Note: I'm not
> saying that "the community doesn't matter", what I'm trying to say
> is that the community is full of diverse opinions and that they are
> just that: opinions. And in the end, it's the code that is preserved
> forever and the opinions get forgotten.
> 
> It's also worth reminding yourself that the author of the code is
> also part of the community, and that they are the only community
> member that has direct control of the changes that will be made to
> the code.  Hence, to me, the only thing that really matters is
> answering this question: "What am I, the author of this code,
> willing to compromise on to get this code merged?"
> 
> That comes down to separating fact from opinion - review comments
> are often opinion. e.g. A reviewer finds a bug then suggests how to
> fix it.  There are two things here - the bug is fact, the suggested
> fix is opinion. The fact needs to be addressed (i.e. the bug must be
> fixed), but it does not need to be fixed the way the reviewer
> suggested as that is an opinion.
> 
> Hence it can be perfectly reasonable to both agree with and disagree
> with the reviewer on the same topic. Separate the fact from the
> opinion, address the facts and then decide if the opinion improves
> the code you have or not.  You may end up may using some, all or
> none of the reviewer's suggestion, but just because it was suggested
> it doesn't mean you have to change the code that way. The code
> author is ultimately in control of the process here.
> 
> IMO, people need to be better at saying "no" and accepting "no" as a
> valid answer (both code authors and reviewers). "No" is not a
> personal rejection, it's just a simple, clear statement that
> further progress will not be made by continuing down that path and a
> different solution/compromise will have to be found.
> 
> > For example: a reviewer may propose a minor change, perhaps a style change,
> > and as long as it's not terrible I assume this is just how people are used
> > to seeing things implemented.  So I amend it, and in the next revision
> > someone expresses that they dislike it and makes a different proposition.
> 
> At which point you need to say "no". :) Probably with the
> justification that this is "rearranging the deck chairs/painting the
> bikeshed again".
> 
> I do understand that it might be difficult to ignore suggestions
> that people like Darrick, myself, Christoph, etc might make.
> However, you should really ignore who the suggestion came from while
> thinking about whether it is actually a valuable or necessary
> change. ie. don't make a change just because of the _reputation_ of
> the person who suggested it.
> 
> > Generally I'll mention that this change was requested, but if
> > anyone feels particularly strongly about it, to please chime in.
> > Most of the time I don't hear anything, I suspect because either
> > the first reviewer isn't around, or they don't have time to
> > revisit it?  Maybe they weren't strongly opinionated about it to
> > begin with?  It could have been they were feeling pressure to
> > generate reviews, or maybe an employer is measuring their
> > engagement?  In any case, if it goes around a third time, I'll
> > usually start including links to prior reviews to try and get
> > people on the same page, but most of the time I've found the
> > result is that it just falls silent.
> > 
> > At this point though it feels unclear to me if everyone is happy?
> 
> IMO, "everyone is happy" is not acheivable. Trying to make everyone
> happy simply leads to stalemate situations where the necessary
> compromises to make progress cannot be made because they'll always
> make someone "unhappy".
> 
> Hence for a significant patchset I always strive for "everyone is
> a bit unhappy" as the end result. If everyone is unhappy, it means
> everyone has had to compromise in some way to get the work merged.
> And I most certainly include myself in the "everyone is unhappy"
> group, too.
> 
> To reinforce that point, I often issue rvb tags for code that is
> functionally correct and does what is needed, but I'm not totally
> happy with for some reason (e.g. structure, not the way I'd solve
> the problem, etc).  Preventing that code from being merged because
> it's not written exactly the way I'd write/solve it is petty and
> nobody wins when that happens. Yes, I'd be happier if it was
> different, but it's unreasonable to expect the author to do things
> exactly the way I'd like it to be done.
> 
> This sort of "unhappy but OK" compromise across the board is
> generally the best you can hope for. And it's much easier to deal
> with competing reviews if you aim for such an "everyone unhappy"
> compromise rather than searching for the magic "everyone happy"
> unicorn.
> 
> > Did we have a constructive review?  Maybe it's not a very big deal
> > and I should just move on.  And in many scenarios like the one
> > above, the exact outcome appears to be of little concern to people
> > in the greater scheme of things.
> 
> Exactly - making everyone happy about the code doesn't really
> matter. What matters is finding the necessary compromise that will
> get the code merged. Indeed, it's a bit of a conundrum - getting the
> code merged is what makes people happy, but before that happens you
> have to work to share the unhappiness around. :/
> 
> > But this pattern does not always
> > scale well in all cases.  Complex issues that persist over time
> > generally do so because no one yet has a clear idea of what a
> > correct solution even looks like, or perhaps cannot agree on one.
> > In my experience, getting people to come together on a common goal
> > requires a sort of exploratory coding effort. Like a prototype
> > that people can look at, learn from, share ideas, and then adapt
> > the model from there.
> 
> Right, that's pretty common. Often I'll go through 3 or 4 private
> prototypes before I even get to posting something on the mailing
> list, and then it will take another couple of iterations because
> other people start to understand the code. And then another couple
> of iterations for them to become comfortable with the code and start
> to have really meaningful suggestions for improvement.
> 
> > But for that to work, they need to have
> > been engaged with the history of it.  They need the common
> > experience of seeing what has worked and what hasn't.  It helps
> > people to let go of theories that have not performed well in
> > practice, and shift to alternate approaches that have.  In a way,
> > reviewers that have been historically more involved with a
> > particular effort start to become a little integral to it as its
> > reviewers.
> 
> "reviewers turn into collaborators".
> 
> That, in itself, is not a bad thing.
> 
> However if you get no other reviewers you'll never get a fresh
> persepective, and if your reviewers don't have the necessary
> expertise the collaboration won't result in better code. It also
> tends to sideline people who think the problem should be tackled a
> different way. We don't want review to be a rubber stamp issued by
> "yes people". We want people who disagree to voice their
> disagreement and ask for change because that's how we improve the
> code.
> 
> Personally, I do not review every version of every patchset simply
> because I don't have the time to do that.  Hence I tend to do design
> review on early patchset iterations rather than code reviews.
> I need to understand the design and structure of the
> change before I'll be able to look at the detail of the code and
> understand whether it is correct or not. Hence I might do an early
> design review from reading the patches and make high level comments,
> then skip the next 3-4 iterations where the code changes
> significantly as bugs are fixed and code is cleaned up. Then I'll go
> back and look at the code in detail and perform an actual code
> review, and I will not have any idea about what was said in the
> previous review iterations. And I'll come back every 3-4 versions of
> the patchset, too.
> 
> IMO, expecting reviewers to know everything that happened in all the
> previous reviews is unrealistic.  If there is some reason for the
> code being the way it is and it is not documented in the patch, then
> the change needs more work. "Why is the code like this?" followed
> by "please document this in a comment" is a reasonable review
> request and you won't get those questions from reviewers who look at
> every version of the patchset because they are familiary with the
> history of the code.
> 
> If this sort of question is not asked during review, we end up in
> the situation where someone looks at the code a year after it is
> merged and there's no documentation in the code or commit messages
> that explains why the code is written the way it is. This is what
> makes drive-by reviews valuable - people unfamiliar with the code
> see it differently and ask different questions....
> 
> IOWs, everyone is free to review code at any time with no
> constraints, past requirements or future liabilities.  If the code
> author wants someone to review every version of a patchset, then
> they need to co-ordinate those people to set aside the time to
> review the code in a prompt and efficient manner. However, expecting
> that other developers cannot review a V5 patchset without first
> having read all of the reviews of v1-v4 is unrealistic, especially
> as this reduces the value of their review substantially as their
> viewpoint is now "tainted" by knowing the history of the code up to
> this point....
> 
> > Which I *think* is what Darrick may be eluding to in
> > his initial proposition.  People request for certain reviewers, or
> > perhaps the reviewers can volunteer to be sort of assigned to it
> > in an effort to provide more constructive reviews.  In this way,
> > reviewers allocate their efforts where they are most effective,
> > and in doing so better distribute the work load as well.  Did I
> > get that about right?  Thoughts?
> 
> [ speaking as someone who was almost completely burnt out by
> having to perform most of the review, testing and maintanence tasks
> for kernel, userspace and test infrastructue for several years ]
> 
> Again, I don't think the maintainer should have anything to do with
> this process. Distributed development requires peers to collaborate
> and self organise without central coordination of their efforts.
> Hence it is the responsibility of the code author to organise review
> for code they are working on. The code author wants the code merged,
> therefore they are the people with the motivation to get the code
> reviewed promptly.
> 
> And, quite frankly, the maintainer has no power to force someone to
> review code. Hence asking the maintainer to manage reviewers on
> behalf of code authors won't work any better than
> distributing/delegating that responsibility to the code author...
> 
> Historically speaking, the XFS maintainer's prime reponsibility has
> been to merge community reviewed code into the upstream tree, not to
> review code or tell people what code they should be reviewing. The
> fact that we are still placing the burden of review and
> co-ordinating review on the maintainer despite ample evidence that
> it causes burn-out is a failure of our community to self-organise
> and protect our valuable resources....
> 

I agree with just about all of this mail, but I do have a question for
Darrick and Dave.. in what ways do we (XFS community) place the burden
on the maintainer to garner/coordinate review? I get the impression that
some of this is implied or unintentional simply by reviews coming in
slow or whatever, and the maintainer feeling the need to fill the gap. I
can sort of understand that behavior as being human nature, but OTOH
there's only so many developers with so much time available for review.

That's not generally something we can control. Given that, I don't think
it's necessarily useful to say that review throughput is the fundamental
problem vs. this unfortunate dynamic of limited reviews not meeting
demand leading to excess maintainer pressure. I'm trying to think about
how we can deal with this more fundamentally beyond just saying "do more
review" or having some annoying ownership process, but I think this
requires more input from you guys who have experienced it...

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

