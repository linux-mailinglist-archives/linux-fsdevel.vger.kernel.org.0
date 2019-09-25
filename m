Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E002ABD975
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 10:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442682AbfIYIAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 04:00:41 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57379 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442663AbfIYIAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:00:41 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7FE0E43E145;
        Wed, 25 Sep 2019 18:00:36 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iD2Dy-0000zC-Ou; Wed, 25 Sep 2019 18:00:34 +1000
Date:   Wed, 25 Sep 2019 18:00:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
Message-ID: <20190925080034.GD804@dread.disaster.area>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
 <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
 <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru>
 <20190924073940.GM6636@dread.disaster.area>
 <CAHk-=whf2BQ8xqVBF8YuxRznByrP-oTgcHSY9DgDnrFTxpsrVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whf2BQ8xqVBF8YuxRznByrP-oTgcHSY9DgDnrFTxpsrVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=714uhUuBiEYtG38rzikA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:08:04PM -0700, Linus Torvalds wrote:
> On Tue, Sep 24, 2019 at 12:39 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > Stupid question: how is this any different to simply winding down
> > our dirty writeback and throttling thresholds like so:
> >
> > # echo $((100 * 1000 * 1000)) > /proc/sys/vm/dirty_background_bytes
> 
> Our dirty_background stuff is very questionable, but it exists (and
> has those insane defaults) because of various legacy reasons.

That's not what I was asking about.  The context is in the previous
lines you didn't quote:

> > > > Is the faster speed reproducible?  I don't quite understand why this
> > > > would be.
> > >
> > > Writing to disk simply starts earlier.
> >
> > Stupid question: how is this any different to simply winding down
> > our dirty writeback and throttling thresholds like so:

i.e. I'm asking about the reasons for the performance differential
not asking for an explanation of what writebehind is. If the
performance differential really is caused by writeback starting
sooner, then winding down dirty_background_bytes should produce
exactly the same performance because it will start writeback -much
faster-.

If it doesn't, then the assertion that the difference is caused by
earlier writeout is questionable and the code may not actually be
doing what is claimed....

Basically, I'm asking for proof that the explanation is correct.

> > to start background writeback when there's 100MB of dirty pages in
> > memory, and then:
> >
> > # echo $((200 * 1000 * 1000)) > /proc/sys/vm/dirty_bytes
> 
> The thing is, that also accounts for dirty shared mmap pages. And it
> really will kill some benchmarks that people take very very seriously.

Yes, I know that. I'm not suggesting that we do this,

[snip]

> Anyway, the end result of all this is that we have that
> balance_dirty_pages() that is pretty darn complex and I suspect very
> few people understand everything that goes on in that function.

I'd agree with you there - most of the ground work for the
balance_dirty_pages IO throttling feedback loop was all based on
concepts I developed to solve dirty page writeback thrashing
problems on Irix back in 2003.  The code we have in Linux was
written by Fenguang Wu with help for a lot of people, but the
underlying concepts of delegating IO to dedicated writeback threads
that calculate and track page cleaning rates (BDI writeback rates)
and then throttling incoming page dirtying rate to the page cleaning
rate all came out of my head....

So, much as it may surprise you, I am one of the few people who do
actually understand how that whole complex mass of accounting and
feedback is supposed to work. :)

> Now, whether write-behind really _does_ help that, or whether it's
> just yet another tweak and complication, I can't actually say.

Neither can I at this point - I lack the data and that's why I was
asking if there was a perf difference with the existing limits wound
right down. Knowing whether the performance difference is simply a
result of starting writeback IO sooner tells me an awful lot about
what other behaviour is happening as a result of the changes in this
patch.

> But I
> don't think 'dirty_background_bytes' is really an argument against
> write-behind, it's just one knob on the very complex dirty handling we
> have.

Never said it was - just trying to determine if a one line
explanation is true or not.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
