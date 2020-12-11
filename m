Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29532D6CD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 02:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394709AbgLKA7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 19:59:36 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:38212 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394708AbgLKA7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:59:21 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 8767F765018;
        Fri, 11 Dec 2020 11:58:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1knWlS-002fcc-Qb; Fri, 11 Dec 2020 11:58:30 +1100
Date:   Fri, 11 Dec 2020 11:58:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/2] fs: expose LOOKUP_NONBLOCK through openat2()
 RESOLVE_NONBLOCK
Message-ID: <20201211005830.GD3913616@dread.disaster.area>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-3-axboe@kernel.dk>
 <20201210222934.GI4170059@dread.disaster.area>
 <CAHk-=wiee7xKitbX74NvjcKDHLiE21=SbO9_urWBnvm=nSZAFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiee7xKitbX74NvjcKDHLiE21=SbO9_urWBnvm=nSZAFQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=zJOtU--gRZm0aBwq0xkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 03:29:23PM -0800, Linus Torvalds wrote:
> On Thu, Dec 10, 2020 at 2:29 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > So, really, this isn't avoiding IO at all - it's avoiding the
> > possibility of running a lookup path that might blocking on
> > something.
> 
> For pathname lookup, the only case that matters is the RCU lockless lookup.
> 
> That cache hits basically 100% of the time except for the first
> lookup, or under memory pressure.
> 
> And honestly, from a performance perspective, it's the lockless path
> lookup that matters most. By the time you have to go to the
> filesystem, take the directory locks etc, you've already lost.
> 
> So we're never going to bother with some kind of "lockless lookup for
> actual filesystems", because it's only extra work for no actual gain.
> 
> End result: LOOKUP_NONBLOCK is about not just avoiding IO, but about
> avoiding the filesystem and the inevitable locking that causes.

Umm, yes, that is _exactly_ what I just said. :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
