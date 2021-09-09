Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3DB405F0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 23:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347576AbhIIVnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 17:43:23 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:48728 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347347AbhIIVnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:43:19 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 0D78D1B9E7B;
        Fri, 10 Sep 2021 07:42:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mORo5-00Ad4S-EJ; Fri, 10 Sep 2021 07:42:05 +1000
Date:   Fri, 10 Sep 2021 07:42:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <20210909214205.GH1756565@dread.disaster.area>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=JUD6rjD155hWDKwpWEIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 03:19:56PM -0600, Jens Axboe wrote:
> On 9/9/21 1:37 PM, Linus Torvalds wrote:
> > I'd like the comments expanded too. In particular that
> > 
> >                 /* some cases will consume bytes even on error returns */
> 
> That comment is from me, and it goes back a few years. IIRC, it was the
> iomap or xfs code that I hit this with, but honestly I don't remember
> all the details at this point. I can try and play with it and see if it
> still reproduces.

You might well be thinking of the problem fixed by commit
883a790a8440 ("xfs: don't allow NOWAIT DIO across extent
boundaries").

This fix was indicative of a whole class of issues with IOCB_NOWAIT
being used for multi-IO operations at the filesystem level and being
applied to each sub-segment of the IO that was constructed, rather
than the IO as a whole. Hence a failure on the second or subsequent
segments could return -EAGAIN (and potentially other errors) to the
caller after the segments we successfully submitted consumed part of
the iov...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
