Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6867F185402
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 03:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCNC1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 22:27:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52452 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCNC1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 22:27:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCwW4-00BARd-OM; Sat, 14 Mar 2020 02:27:08 +0000
Date:   Sat, 14 Mar 2020 02:27:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v4)
Message-ID: <20200314022708.GS23230@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200313235303.GP23230@ZenIV.linux.org.uk>
 <CAHk-=whainTcvgF01vsSmN+y7s7U1qMA-QbM5qFQ3s4xQHwaJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whainTcvgF01vsSmN+y7s7U1qMA-QbM5qFQ3s4xQHwaJw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:50:51PM -0700, Linus Torvalds wrote:
> On Fri, Mar 13, 2020 at 4:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Review and testing would be _very_ welcome;
> 
> I didn't notice anythign else than the few things I sent out to
> individual patches.
> 
> But I have to say, 69 patches is too long of a series to review. I
> think you could send them out as multiple series (you describe them
> that way anyway - parts 1-7) with a day in between.

A week of fun?  OK...

> Because my eyes were starting to glaze over about halfway in the series.
> 
> But don't do it for this version. If you do a #5. But it would be good
> to be in -next regardless of whether you do a #5 or not.

FWIW, I've dealt with bisect hazards and I'll probably reorder #56 after
#57/#58, to get the stuff that deals with stack allocation (#56, #59..61)
together, without "reduce the exposure to weird struct path instances"
(57 and 58) mixed in the middle of that.

As for the rest...  I'm not sure that choose_mountpoint{,_rcu}()
is inserted into the right place in text - might be better next to
follow_up().  There's also a couple of pick_link() pieces worth separate
helpers, but I'd rather leave that for the next cycle - the series is
bloody long as it is.

I'm not going to throw the immediate prereqs for ->atomic_open() calling
conventions change into that pile - they don't harm anything, but they
are unmotivated without the next step (method signature change) and it's
really too late in the cycle for that.  That's going to be a separate
series, probably for the next cycle.  Changes to instances are not
huge; ceph is the worst by far and that's only +27/-22 lines.  So I don't
think there will be a lot of conflicts to cope with in the next cycle,
especially since ceph side of things looks like we want to do some
refactoring first, with much smaller changeover on top of that.  That
refactoring itself won't have prereqs at all, so that can be dealt with
sanely and that'll soak most of the potential conflicts in.

There are other potential refactorings/cleanups, but that's definitely
not for this cycle.  So... short of regressions found in that series
that's probably close to what I'll have for the coming window in
this branch.  If I see something else in there that can be usefully
cleaned up, I'll keep it for after -rc1...

Next: context switch to uaccess series and getting that patchbomb ready.
Oh, well...
