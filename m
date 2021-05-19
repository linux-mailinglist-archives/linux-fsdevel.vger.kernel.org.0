Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92CC388E76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 14:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353495AbhESM7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 08:59:12 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:57824 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353494AbhESM7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 08:59:08 -0400
Received: from dread.disaster.area (pa49-195-118-180.pa.nsw.optusnet.com.au [49.195.118.180])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 7F83080BA7C;
        Wed, 19 May 2021 22:57:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ljLlf-002mpn-8h; Wed, 19 May 2021 22:57:43 +1000
Date:   Wed, 19 May 2021 22:57:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Avi Kivity <avi@scylladb.com>
Cc:     David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Message-ID: <20210519125743.GP2893@dread.disaster.area>
References: <206078.1621264018@warthog.procyon.org.uk>
 <20210517232237.GE2893@dread.disaster.area>
 <ad2e8757-41ce-41e3-a22e-0cf9e356e656@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2e8757-41ce-41e3-a22e-0cf9e356e656@scylladb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=xcwBwyABtj18PbVNKPPJDQ==:117 a=xcwBwyABtj18PbVNKPPJDQ==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=7-415B0cAAAA:8
        a=JUdNrTaQNZjwa7RRXdQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 11:00:03AM +0300, Avi Kivity wrote:
> 
> On 18/05/2021 02.22, Dave Chinner wrote:
> > 
> > > What I'd like to do is remove the fanout directories, so that for each logical
> > > "volume"[*] I have a single directory with all the files in it.  But that
> > > means sticking massive amounts of entries into a single directory and hoping
> > > it (a) isn't too slow and (b) doesn't hit the capacity limit.
> > Note that if you use a single directory, you are effectively single
> > threading modifications to your file index. You still need to use
> > fanout directories if you want concurrency during modification for
> > the cachefiles index, but that's a different design criteria
> > compared to directory capacity and modification/lookup scalability.
> 
> Something that hit us with single-large-directory and XFS is that
> XFS will allocate all files in a directory using the same
> allocation group.  If your entire filesystem is just for that one
> directory, then that allocation group will be contended.

There is more than one concurrency problem that can arise from using
single large directories. Allocation policy is just another aspect
of the concurrency picture.

Indeed, you can avoid this specific problem simply by using the
inode32 allocator - this policy round-robins files across allocation
groups instead of trying to keep files physically local to their
parent directory. Hence if you just want one big directory with lots
of files that index lots of data, using the inode32 allocator will
allow the files in the filesytsem to allocate/free space at maximum
concurrency at all times...

> We saw spurious ENOSPC when that happened, though that
> may have related to bad O_DIRECT management by us.

You should not see spurious ENOSPC at all.

The only time I've recall this sort of thing occurring is when large
extent size hints are abused by applying them to every single file
and allocation regardless of whether they are needed, whilst
simultaneously mixing long term and short term data in the same
physical locality. Over time the repeated removal and reallocation
of short term data amongst long term data fragments the crap out of
free space until there are no large contiguous free spaces left to
allocate contiguous extents from.

> We ended up creating files in a temporary directory and moving them to the
> main directory, since for us the directory layout was mandated by
> compatibility concerns.

inode32 would have done effectively the same thing but without
needing to change the application....

> We are now happy with XFS large-directory management, but are nowhere close
> to a million files.

I think you are conflating directory scalability with problems
arising from file allocation policies not being ideal for your data
set organisation, layout and longevity characteristics.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
