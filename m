Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BA7D4F82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 14:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfJLMGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Oct 2019 08:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJLMGB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Oct 2019 08:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 725B018C8910;
        Sat, 12 Oct 2019 12:06:00 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4EE05D713;
        Sat, 12 Oct 2019 12:05:59 +0000 (UTC)
Date:   Sat, 12 Oct 2019 08:05:58 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191012120558.GA3307@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191011123939.GD61257@bfoster>
 <20191011231323.GK16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011231323.GK16973@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Sat, 12 Oct 2019 12:06:00 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 12, 2019 at 10:13:23AM +1100, Dave Chinner wrote:
> On Fri, Oct 11, 2019 at 08:39:39AM -0400, Brian Foster wrote:
> > On Wed, Oct 09, 2019 at 02:21:02PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > The buffer cache shrinker frees more than just the xfs_buf slab
> > > objects - it also frees the pages attached to the buffers. Make sure
> > > the memory reclaim code accounts for this memory being freed
> > > correctly, similar to how the inode shrinker accounts for pages
> > > freed from the page cache due to mapping invalidation.
> > > 
> > > We also need to make sure that the mm subsystem knows these are
> > > reclaimable objects. We provide the memory reclaim subsystem with a
> > > a shrinker to reclaim xfs_bufs, so we should really mark the slab
> > > that way.
> > > 
> > > We also have a lot of xfs_bufs in a busy system, spread them around
> > > like we do inodes.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > 
> > Seems reasonable, but for inodes we also spread the ili zone. Should we
> > not be consistent with bli's as well?
> 
> bli's are reclaimed when the buffer is cleaned. ili's live for the
> live of the inode in cache. Hence bli's are short term allocations
> (much shorter than xfs_bufs they attach to) and are reclaimed much
> faster than inodes and their ilis. There's also a lot less blis than
> ili's, so the spread of their footprint across memory nodes doesn't
> matter that much. Local access for the memcpy during formatting is
> probably more important than spreading the memory usage of them
> these days, anyway.
> 

Yes, the buffer/inode lifecycle difference is why why I presume bli
zones are not ZONE_RECLAIM like ili zones. This doesn't tell me anything
about why buffers should be spread around as such and buffer log items
not, though..

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
