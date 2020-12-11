Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3562D6EDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 04:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395227AbgLKDqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 22:46:54 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54079 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395221AbgLKDqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:46:24 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A8F6558C72C;
        Fri, 11 Dec 2020 14:45:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1knZNF-002i1i-J6; Fri, 11 Dec 2020 14:45:41 +1100
Date:   Fri, 11 Dec 2020 14:45:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/2] fs: expose LOOKUP_NONBLOCK through openat2()
 RESOLVE_NONBLOCK
Message-ID: <20201211034541.GE3913616@dread.disaster.area>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-3-axboe@kernel.dk>
 <20201210222934.GI4170059@dread.disaster.area>
 <CAHk-=wiee7xKitbX74NvjcKDHLiE21=SbO9_urWBnvm=nSZAFQ@mail.gmail.com>
 <20201211005830.GD3913616@dread.disaster.area>
 <CAHk-=whQTK74ZwP7W9oMZFYZH=_t-1po75ajxQQAf-R945zhRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whQTK74ZwP7W9oMZFYZH=_t-1po75ajxQQAf-R945zhRA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=r-QAs7MFpWqf1LBFxywA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:01:44PM -0800, Linus Torvalds wrote:
> On Thu, Dec 10, 2020 at 4:58 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > Umm, yes, that is _exactly_ what I just said. :/
> 
> .,. but it _sounded_ like you would actually want to do the whole
> filesystem thing, since why would you have piped up otherwise. I just
> wanted to clarify that the onle sane model is the one that patch
> actually implements.

<sigh>

Is that really what you think motivates me, Linus? It sounds like
you've created an Evil Dave strawman and you simply cannot see past
the taint Evil Dave has created in your head. :/

I commented because Jens has recently found several issues with
inconsistencies in "non-blocking" APIs that we have in the IO path.
He's triggered bugs in the non-blocking behaviour in filesystem code
through io_uring that we've had to fix (e.g. see commit 883a790a8440
("xfs: don't allow NOWAIT DIO across extent boundaries"). Then there
are the active discussions about the limited ability to use
IOCB_NOWAIT for full stack non-blocking IO behaviour w/ REQ_NOWAIT
in the block layer because the semantics of IOCB_NOWAIT are directly
tied to the requirements of the RWF_NOWAIT preadv2/pwritev2 flag and
using REQ_NOWAIT in the block layer will break them.

Part of the problem we have with the non-blocking behaviour is that
the user interfaces have been under specified, poorly reviewed and
targetted a single specific use case on a single filesystem rather
than generic behaviour. And mostly they lack the necessary test
coverage to ensure all filesystems behave the same way and to inform
us of a regression that *would break userspace applications*.

Yes, I recognise and accept that some of the problems are partially
my fault. I also have a habit of trying to learn from the mistakes
I've made and then take steps to ensure that *we do not make those
same mistakes again*.

> Otherwise, your email was just nit-picking about a single word in a
> comment in a header file.
> 
> Was that really what you wanted to do?

So for all your talk about "don't break userspace", you think that
actively taking steps during reviews to avoid a poor userspace API
is "nit-picking"? FYI, having a reviewer ask for a userspace API
modification to:

	- have clearly specified and documented behaviour,
	- be provided with user documentation, and
	- be submitted with regression tests

is not at all unusual or unexpected. Asking for these things during
review on -fsdevel and various filesystem lists is a normal part of
the process for getting changes to user APIs reviewed and merged.
The fact that Jens replied with "yep, no problems, let's make sure
we nail down the semantics" and Al has replied "what does
RESOLVE_NONBLOCK actually mean for all the blocking stuff that open
does /after/ the pathwalk?" shows that these semantics really do
matter Hence they need to be defined, specified, documented and
carefully exercised by regression tests. i.e. the patch that
introduces the RESOLVE_NONBLOCK flag is the -easy part-, filling in
the rest of the blanks is where all the hard work is...

Hence calling these requests "nit picking" sets entirely the wrong
tone for the wider community. You may not care about things like
properly documenting interfaces, but application developers and
users sure do and hence it's something we need to pay attention to
and encourage.

Leaders are supposed to encourage and support good development
practices, not be arseholes to the people who ask for good practices
to be followed.

Please start behaving more like a leader should when I'm around,
Linus.

-Dave.
(Not really Evil.)
-- 
Dave Chinner
david@fromorbit.com
