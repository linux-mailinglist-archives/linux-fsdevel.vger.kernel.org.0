Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39A3C205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 06:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfFKELv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 00:11:51 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48278 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfFKELv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:11:51 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5765E1ED746;
        Tue, 11 Jun 2019 14:11:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1haY7R-0004JE-8B; Tue, 11 Jun 2019 14:10:45 +1000
Date:   Tue, 11 Jun 2019 14:10:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker
 merged)
Message-ID: <20190611041045.GA14363@dread.disaster.area>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=m6GSVp5TBz7OGOtiG6UA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:46:35AM -1000, Linus Torvalds wrote:
> I also get the feeling that the "intent" part of the six-locks could
> just be done as a slight extension of the rwsem, where an "intent" is
> the same as a write-lock, but without waiting for existing readers,
> and then the write-lock part is just the "wait for readers to be
> done".

Please, no, let's not make the rwsems even more fragile than they
already are. I'm tired of the ongoing XFS customer escalations that
end up being root caused to yet another rwsem memory barrier bug.

> Have you talked to Waiman Long about that?

Unfortunately, Waiman has been unable to find/debug multiple rwsem
exclusion violations we've seen in XFS bug reports over the past 2-3
years. Those memory barrier bugs have all been fixed by other people
long after Waiman has said "I can't reproduce any problems in my
testing" and essentially walked away from the problem. We've been
left multiple times wondering how the hell we even prove it's a
rwsem bug because there's no way to reproduce the inconsistent rwsem
state we see in the kernel crash dumps.

Hence, as a downstream rwsem user, I have relatively little
confidence in upstream's ability to integrate new functionality into
rwsems without introducing yet more subtle regressions that are only
exposed by heavy rwsem users like XFS. As such, I consider rwsems to
be extremely fragile and are now a prime suspect whenever see some
one-off memory corruption in a structure protected by a rwsem.

As such, please keep SIX locks separate to rwsems to minimise the
merge risk of bcachefs.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
