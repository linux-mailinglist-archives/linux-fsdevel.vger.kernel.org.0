Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9273B2D91A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 02:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437824AbgLNBxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 20:53:31 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:60531 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437812AbgLNBxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 20:53:31 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 50ECA1AD745;
        Mon, 14 Dec 2020 12:52:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kod2e-003iQ2-2T; Mon, 14 Dec 2020 12:52:48 +1100
Date:   Mon, 14 Dec 2020 12:52:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file
 open
Message-ID: <20201214015248.GG3913616@dread.disaster.area>
References: <20201212165105.902688-1-axboe@kernel.dk>
 <20201212165105.902688-5-axboe@kernel.dk>
 <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com>
 <8c4e7013-2929-82ed-06f6-020a19b4fb3d@kernel.dk>
 <20201213225022.GF3913616@dread.disaster.area>
 <CAHk-=wg5AXnXE3bjqj0fgH2os1ptKeF-ee6i0p5GCw1o63EdgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5AXnXE3bjqj0fgH2os1ptKeF-ee6i0p5GCw1o63EdgQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=KhBIYd2v22FBfhuVGIcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 04:45:39PM -0800, Linus Torvalds wrote:
> On Sun, Dec 13, 2020 at 2:50 PM Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > Only O_CREAT | O_TRUNC should matter, since those are the ones that
> > > > cause writes as part of the *open*.
> >
> > And __O_TMPFILE, which is the same as O_CREAT.
> 
> This made me go look at the code, but we seem to be ok here -
> __O_TMPFILE should never get to the do_open() logic at all, because it
> gets caught before that and does off to do_tmpfile() and then
> vfs_tmpfile() instead.
> 
> And then it's up to the filesystem to do the inode locking if it needs
> to - it has a separate i_io->tempfile function for that.

Sure, and then it blocks. Guaranteed, for the same reasons that
O_CREAT will block when calling ->create() after the path lookup:
the filesystem runs a transaction to allocate an inode and track it
on the orphan list so that it gets cleaned up by recovery after a
crash while the tmpfile is still open.

So it doesn't matter if the lookup is non-blocking, the tmpfile
creation is guaranteed to block for the same reason O_CREAT and
O_TRUNCATE will block....

> From a LOOKUP_NONBLOCK standpoint, I think we should just disallow
> O_TMPFILE the same way Jens disallowed O_TRUNCATE.

*nod*

I just don't think it makes sense to try to make any of the
filesystem level stuff open() might do non-blocking. The moment we
start a filesystem modification, we have to be able to block because
it is the only way to guarantee forwards progress. So if we know we
are going to call into the filesystem to make a modification if the
pathwalk is successful, why even bother starting the pathwalk?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
