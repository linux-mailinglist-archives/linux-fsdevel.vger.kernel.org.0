Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17EB2D90FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 23:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgLMWvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 17:51:07 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:60541 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727958AbgLMWvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 17:51:07 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 86A15105527;
        Mon, 14 Dec 2020 09:50:23 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1koaC6-003fjv-HP; Mon, 14 Dec 2020 09:50:22 +1100
Date:   Mon, 14 Dec 2020 09:50:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file
 open
Message-ID: <20201213225022.GF3913616@dread.disaster.area>
References: <20201212165105.902688-1-axboe@kernel.dk>
 <20201212165105.902688-5-axboe@kernel.dk>
 <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com>
 <8c4e7013-2929-82ed-06f6-020a19b4fb3d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c4e7013-2929-82ed-06f6-020a19b4fb3d@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=tx7JToRLIvlhprAR0ZkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 12, 2020 at 02:25:00PM -0700, Jens Axboe wrote:
> On 12/12/20 11:57 AM, Linus Torvalds wrote:
> > On Sat, Dec 12, 2020 at 8:51 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> We handle it for the path resolution itself, but we should also factor
> >> it in for open_last_lookups() and tmpfile open.
> > 
> > So I think this one is fundamentally wrong, for two reasons.
> > 
> > One is that "nonblock" shouldn't necessarily mean "take no locks at
> > all". That directory inode lock is very very different from "go down
> > to the filesystem to do IO". No other NONBLOCK thing has ever been "no
> > locks at all", they have all been about possibly long-term blocking.
> 
> Do we ever do long term IO _while_ holding the direcoty inode lock? If
> we don't, then we can probably just ignore that side alltogether.

Yes - "all the time" is the simple answer.

Readdir is a simple example, but that is just extent mapping tree
and directory block IO you'd have to wait for, just like regular
file IO.

The big problem is that modifications to directories are atomic and
transactional in most filesystems, which means we might block a
create/unlink/attr/etc in a transaction start for an indefinite
amount of time while we wait for metadata writeback to free up
journal/reservation space. And while we are doing this, nothing else
can access the directory because the VFS holds the directory inode
lock....

We also have metadata IO within transactions, but in most
journalling filesystems once we've started the transaction we can't
back out and return -EAGAIN. So once we are in a transaction
context, the filesystem will block as necessary to run the operation
to completion.

So, really, at the filesystem level I don't see much value in trying
to push non-blocking directory modifications down to the filesystem.
The commonly used filesystems will mostly have to return -EAGAIN
immediately without being able to do anything at all because they
simply aren't architected with the modification rollback
capabilities needed to run fully non-blocking transactional
modification operations.

> > Why does that code care about O_WRONLY | O_RDWR? That has *nothing* to
> > do with the open() wanting to write to the filesystem. We don't even
> > hold that lock after the open - we'll always drop it even for a
> > successful open.
> > 
> > Only O_CREAT | O_TRUNC should matter, since those are the ones that
> > cause writes as part of the *open*.

And __O_TMPFILE, which is the same as O_CREAT.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
