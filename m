Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28DA119FFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 01:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfLKA2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 19:28:21 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54936 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbfLKA2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:28:21 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 459837EA491;
        Wed, 11 Dec 2019 11:28:19 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ieprT-0006Z1-IC; Wed, 11 Dec 2019 11:28:15 +1100
Date:   Wed, 11 Dec 2019 11:28:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Message-ID: <20191211002815.GD19213@dread.disaster.area>
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191210162454.8608-4-axboe@kernel.dk>
 <20191211002349.GC19213@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211002349.GC19213@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=YySyZI0ml3ss4FvGJbkA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:23:49AM +1100, Dave Chinner wrote:
> On Tue, Dec 10, 2019 at 09:24:52AM -0700, Jens Axboe wrote:
> > If RWF_UNCACHED is set for io_uring (or pwritev2(2)), we'll drop the
> > cache instantiated for buffered writes. If new pages aren't
> > instantiated, we leave them alone. This provides similar semantics to
> > reads with RWF_UNCACHED set.
> 
> So what about filesystems that don't use generic_perform_write()?
> i.e. Anything that uses the iomap infrastructure (i.e.
> iomap_file_buffered_write()) instead of generic_file_write_iter())
> will currently ignore RWF_UNCACHED. That's XFS and gfs2 right now,
> but there are likely to be more in the near future as more
> filesystems are ported to the iomap infrastructure.

Hmmm - I'm missing part of this patchset, and I see a second version
has been posted that has iomap stuff in it. I'll go look at that
now...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
