Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6992A28D6B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 00:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgJMWxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 18:53:50 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:44087 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbgJMWxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 18:53:49 -0400
Received: from dread.disaster.area (pa49-195-69-88.pa.nsw.optusnet.com.au [49.195.69.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2EC8058C18F;
        Wed, 14 Oct 2020 09:53:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kSTAu-000F8P-Uh; Wed, 14 Oct 2020 09:53:44 +1100
Date:   Wed, 14 Oct 2020 09:53:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: use page dirty state to seek data over
 unwritten extents
Message-ID: <20201013225344.GA7391@dread.disaster.area>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-2-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012140350.950064-2-bfoster@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=5g0Hk5519kQvxAqikqd8LA==:117 a=5g0Hk5519kQvxAqikqd8LA==:17
        a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=7-415B0cAAAA:8
        a=a9yReRmkddMy0O4uLK4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:03:49AM -0400, Brian Foster wrote:
> iomap seek hole/data currently uses page Uptodate state to track
> data over unwritten extents. This is odd and unpredictable in that
> the existence of clean pages changes behavior. For example:
> 
>   $ xfs_io -fc "falloc 0 32k" -c "seek -d 0" \
> 	    -c "pread 16k 4k" -c "seek -d 0" /mnt/file
>   Whence  Result
>   DATA    EOF
>   ...
>   Whence  Result
>   DATA    16384

I don't think there is any way around this, because the page cache
lookup done by the seek hole/data code is an
unlocked operation and can race with other IO and operations. That
is, seek does not take IO serialisation locks at all so
read/write/page faults/fallocate/etc all run concurrently with it...

i.e. we get an iomap that is current at the time the iomap_begin()
call is made, but we don't hold any locks to stabilise that extent
range while we do a page cache traversal looking for cached data.
That means any region of the unwritten iomap can change state while
we are running the page cache seek.

We cannot determine what the data contents without major overhead,
and if we are seeking over a large unwritten extent covered by clean
pages that then gets partially written synchronously by another
concurrent write IO then we might trip across clean uptodate pages
with real data in them by the time the page cache scan gets to it.

Hence the only thing we are looking at here is whether there is data
present in the cache or not. As such, I think assuming that only
dirty/writeback pages contain actual user data in a seek data/hole
operation is a fundametnally incorrect premise.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
