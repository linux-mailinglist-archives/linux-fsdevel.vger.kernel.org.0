Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E871DD4AC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 01:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfJKXN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 19:13:28 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55425 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfJKXN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:13:28 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B8102361FE7;
        Sat, 12 Oct 2019 10:13:25 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iJ467-0007it-WD; Sat, 12 Oct 2019 10:13:24 +1100
Date:   Sat, 12 Oct 2019 10:13:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191011231323.GK16973@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191011123939.GD61257@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011123939.GD61257@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=KXxIyV-1b6rYZK5WPMkA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:39:39AM -0400, Brian Foster wrote:
> On Wed, Oct 09, 2019 at 02:21:02PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > The buffer cache shrinker frees more than just the xfs_buf slab
> > objects - it also frees the pages attached to the buffers. Make sure
> > the memory reclaim code accounts for this memory being freed
> > correctly, similar to how the inode shrinker accounts for pages
> > freed from the page cache due to mapping invalidation.
> > 
> > We also need to make sure that the mm subsystem knows these are
> > reclaimable objects. We provide the memory reclaim subsystem with a
> > a shrinker to reclaim xfs_bufs, so we should really mark the slab
> > that way.
> > 
> > We also have a lot of xfs_bufs in a busy system, spread them around
> > like we do inodes.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> 
> Seems reasonable, but for inodes we also spread the ili zone. Should we
> not be consistent with bli's as well?

bli's are reclaimed when the buffer is cleaned. ili's live for the
live of the inode in cache. Hence bli's are short term allocations
(much shorter than xfs_bufs they attach to) and are reclaimed much
faster than inodes and their ilis. There's also a lot less blis than
ili's, so the spread of their footprint across memory nodes doesn't
matter that much. Local access for the memcpy during formatting is
probably more important than spreading the memory usage of them
these days, anyway.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
