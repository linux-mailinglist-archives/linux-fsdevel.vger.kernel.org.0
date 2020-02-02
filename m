Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15114FF6D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 22:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgBBVq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 16:46:29 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57025 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbgBBVq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:46:29 -0500
Received: from dread.disaster.area (pa49-181-161-120.pa.nsw.optusnet.com.au [49.181.161.120])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 757227EA635;
        Mon,  3 Feb 2020 08:46:22 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iyN4O-0005tx-MD; Mon, 03 Feb 2020 08:46:20 +1100
Date:   Mon, 3 Feb 2020 08:46:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Allison Collins <allison.henderson@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200202214620.GA20628@dread.disaster.area>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=SkgQWeG3jiSQFIjTo4+liA==:117 a=SkgQWeG3jiSQFIjTo4+liA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=yPCof4ZbAAAA:8 a=VlmzTjhvAAAA:8 a=7-415B0cAAAA:8 a=fJ0nBAgzBULzsgNbrLIA:9
        a=5Y_2ujE4nDxRVm0g:21 a=9x76spwRDswDgojx:21 a=CjuIK1q_8ugA:10
        a=DWPK8KkkzkCXmqKYfE4-:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:20:37PM -0700, Allison Collins wrote:
> 
> 
> On 1/31/20 12:30 AM, Amir Goldstein wrote:
> > On Fri, Jan 31, 2020 at 7:25 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > 
> > > Hi everyone,
> > > 
> > > I would like to discuss how to improve the process of shepherding code
> > > into the kernel to make it more enjoyable for maintainers, reviewers,
> > > and code authors.  Here is a brief summary of how we got here:
> > > 
> > > Years ago, XFS had one maintainer tending to all four key git repos
> > > (kernel, userspace, documentation, testing).  Like most subsystems, the
> > > maintainer did a lot of review and porting code between the kernel and
> > > userspace, though with help from others.
> > > 
> > > It turns out that this didn't scale very well, so we split the
> > > responsibilities into three maintainers.  Like most subsystems, the
> > > maintainers still did a lot of review and porting work, though with help
> > > from others.
> > > 
> > > It turns out that this system doesn't scale very well either.  Even with
> > > three maintainers sharing access to the git trees and working together
> > > to get reviews done, mailing list traffic has been trending upwards for
> > > years, and we still can't keep up.  I fear that many maintainers are
> > > burning out.  For XFS, the biggest pain point (AFAICT) is not assembly and
> > > testing of the git trees, but keeping up with the mail and the reviews.
> > > 
> > > So what do we do about this?  I think we (the XFS project, anyway)
> > > should increase the amount of organizing in our review process.  For
> > > large patchsets, I would like to improve informal communication about
> > > who the author might like to have conduct a review, who might be
> > > interested in conducting a review, estimates of how much time a reviewer
> > > has to spend on a patchset, and of course, feedback about how it went.
> > > This of course is to lay the groundwork for making a case to our bosses
> > > for growing our community, allocating time for reviews and for growing
> > > our skills as reviewers.
> > > 
> > 
> > Interesting.
> > 
> > Eryu usually posts a weekly status of xfstests review queue, often with
> > a call for reviewers, sometimes with specific patch series mentioned.
> > That helps me as a developer to monitor the status of my own work
> > and it helps me as a reviewer to put the efforts where the maintainer
> > needs me the most.
> > 
> > For xfs kernel patches, I can represent the voice of "new blood".
> > Getting new people to join the review effort is quite a hard barrier.
> > I have taken a few stabs at doing review for xfs patch series over the
> > year, but it mostly ends up feeling like it helped me (get to know xfs code
> > better) more than it helped the maintainer, because the chances of a
> > new reviewer to catch meaningful bugs are very low and if another reviewer
> > is going to go over the same patch series, the chances of new reviewer to
> > catch bugs that novice reviewer will not catch are extremely low.
> That sounds like a familiar experience.  Lots of times I'll start a review,
> but then someone else will finish it before I do, and catch more things
> along the way.  So I sort of feel like if it's not something I can get
> through quickly, then it's not a very good distribution of work effort and I
> should shift to something else. Most of the time, I'll study it until I feel
> like I understand what the person is trying to do, and I might catch stuff
> that appears like it may not align with that pursuit, but I don't
> necessarily feel I can deem it void of all unforeseen bugs.

I think you are both underselling yourselves. Imposter syndrome and
all that jazz.

The reality is that we don't need more people doing the sorts of
"how does this work with the rest of XFS" reviews that people like
Darricki or Christoph do. What we really need is more people looking
at whether loops are correctly terminated, the right variable types
are used, we don't have signed vs unsigned issues, 32 bit overflows,
use the right 32/64 bit division functions, the error handling logic
is correct, etc.

It's those sorts of little details that lead to most bugs, and
that's precisely the sort of thing that is typically missed by an
experienced developer doing a "is this the best possible
implemenation of this functionality" review.

A recent personal example: look at the review of Matthew Wilcox's
->readahead() series that I recently did. I noticed problems in the
core change and the erofs and btfrs implementations not because I
knew anything about those filesystems, but because I was checking
whether the new loops iterated the pages in the page cache
correctly. i.e. all I was really looking at was variable counting
and loop initialisation and termination conditions. Experience tells
me this stuff is notoriously difficult to get right, so that's what
I looked at....

IOWs, you don't need to know anything about the subsystem to
perform such a useful review, and a lot of the time you won't find a
problem. But it's still a very useful review to perform, and in
doing so you've validated, to the best of your ability, that the
change is sound. Put simply:

	"I've checked <all these things> and it looks good to me.

	Reviewed-by: Joe Bloggs <joe@blogg.com>"

This is a very useful, valid review, regardless of whether you find
anything. It's also a method of review that you can use when you
have limited time - rather than trying to check everything and
spending hours on a pathset, pick one thing and get the entire
review done in 15 minutes. Then do the same thing for the next patch
set. You'll be surprised how many things you notice that aren't what
you are looking for when you do this.

Hence the fact that other people find (different) issues is
irrelevant - they'll be looking at different things to you, and
there may not even be any overlap in the focus/scope of the reviews
that have been performed. You may find the same things, but that is
also not a bad thing - I intentionally don't read other reviews
before I review a patch series, so that I don't taint my view of the
code before I look at it (e.g., darrick found a bug in this code, so
I don't need to look at it...).

IOWs, if you are starting from the premise that "I don't know this
code well enough to perform a useful review" then you are setting
yourself up for failure right at the start. Read the series
description, think about the change being made, use your experience
to answer the question "what's a mistake I could make performing
this change". Then go looking for that mistake through the
patch(es). In the process of performing this review, more than
likely, you'll notice bugs other than what you are actually looking
for...

This does not require any deep subsystem specific knowledge, but in
doing this sort of review you're going to notice things and learn
about the code and slowly build your knowledge and experience about
that subsystem.

> > However, there are quite a few cleanup and refactoring patch series,
> > especially on the xfs list, where a review from an "outsider" could still
> > be of value to the xfs community. OTOH, for xfs maintainer, those are
> > the easy patches to review, so is there a gain in offloading those reviews?
> > 
> > Bottom line - a report of the subsystem review queue status, call for
> > reviewers and highlighting specific areas in need of review is a good idea.
> > Developers responding to that report publicly with availability for review,
> > intention and expected time frame for taking on a review would be helpful
> > for both maintainers and potential reviewers.
> I definitely think that would help delegate review efforts a little more.
> That way it's clear what people are working on, and what still needs
> attention.

It is not the maintainer's repsonsibility to gather reviewers. That
is entirely the responsibility of the patch submitter. That is, if
the code has gone unreviewed, it is up to the submitter to find
people to review the code, not the maintainer. If you, as a
developer, are unable to find people willing to review your code
then it's a sign you haven't been reviewing enough code yourself.

Good reviewers are a valuable resource - as a developer I rely on
reviewers to get my code merged, so if I don't review code and
everyone else behaves the same way, how can I possibly get my code
merged? IOWs, review is something every developer should be spending
a significant chunk of their time on. IMO, if you are not spending
*at least* a whole day a week reviewing code, you're not actually
doing enough code review to allow other developers to be as
productive as you are.

The more you review other people's code, the more you learn about
the code and the more likely other people will be to review your
code because they know you'll review their code in turn.  It's a
positive reinforcement cycle that benefits both the individual
developers personally and the wider community.

But this positive reinforcemnt cycle just doesn't happen if people
avoid reviewing code because they think "I don't know anything so my
review is not going to be worth anything".  Constructive review, not
matter whether it's performed at a simple or complex level, is
always valuable.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
