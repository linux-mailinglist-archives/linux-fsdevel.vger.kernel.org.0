Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D53386DA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 01:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhEQXX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 19:23:59 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39953 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231318AbhEQXX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 19:23:59 -0400
Received: from dread.disaster.area (pa49-195-118-180.pa.nsw.optusnet.com.au [49.195.118.180])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2AE1E86326F;
        Tue, 18 May 2021 09:22:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1limZJ-002Bw0-76; Tue, 18 May 2021 09:22:37 +1000
Date:   Tue, 18 May 2021 09:22:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Message-ID: <20210517232237.GE2893@dread.disaster.area>
References: <206078.1621264018@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206078.1621264018@warthog.procyon.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=xcwBwyABtj18PbVNKPPJDQ==:117 a=xcwBwyABtj18PbVNKPPJDQ==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=7-415B0cAAAA:8
        a=C_5rSjyteTE79hNBMgUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 04:06:58PM +0100, David Howells wrote:
> Hi,
> 
> With filesystems like ext4, xfs and btrfs, what are the limits on directory
> capacity, and how well are they indexed?
> 
> The reason I ask is that inside of cachefiles, I insert fanout directories
> inside index directories to divide up the space for ext2 to cope with the
> limits on directory sizes and that it did linear searches (IIRC).

Don't do that for XFS. XFS directories have internal hashed btree
indexes that are far more space efficient than using fanout in
userspace. i.e. The XFS hash index uses 8 bytes per dirent, and so
in a 4kB directory block size structure can index about 500 entries
per block. And being O(log N) for lookup, insert and remove, the
fan-out within the directory hash per IO operation is an aorder of
magnitude higher than using directories in userspace....

The capacity limit for XFS is 32GB of dirent data, which generally
equates to somewhere around 300-500 million dirents depending on
filename size. The hash index is separate from this limit (has it's
own 32GB address segment, as does the internal freespace map for the
directory....

The other directory design characterisitic of XFs directories is
that readdir is always a sequential read through the dirent data
with built in readahead. It does not need to look up the hash index
to determine where to read the next dirents from - that's a straight
"file offset to physical location" lookup in the extent btree, which
is always cached in memory. So that's generally not a limiting
factor, either.

> For some applications, I need to be able to cache over 1M entries (render
> farm) and even a kernel tree has over 100k.

Not a problem for XFS with a single directory, but could definitely
be a problem for others especially as the directory grows and
shrinks. Last I measured, ext4 directory perf drops off at about
80-90k entries using 40 byte file names, but you can get an idea of
XFS directory scalability with large entry counts in commit
756c6f0f7efe ("xfs: reverse search directory freespace indexes").
I'll reproduce the table using a 4kB directory block size here:

     File count	      create time(sec) / rate (files/s)
      10k			  0.41 / 24.3k
      20k			  0.75 / 26.7k
     100k			  3.27 / 30.6k
     200k			  6.71 / 29.8k
       1M			 37.67 / 26.5k
       2M			 79.55 / 25.2k
      10M			552.89 / 18.1k

So that's single threaded file create, which shows the rough limits
of insert into the large directory. There really isn't a major
drop-off in performance until there are several million entries in
the directory. Remove is roughly the same speed for the same dirent
count.

> What I'd like to do is remove the fanout directories, so that for each logical
> "volume"[*] I have a single directory with all the files in it.  But that
> means sticking massive amounts of entries into a single directory and hoping
> it (a) isn't too slow and (b) doesn't hit the capacity limit.

Note that if you use a single directory, you are effectively single
threading modifications to your file index. You still need to use
fanout directories if you want concurrency during modification for
the cachefiles index, but that's a different design criteria
compared to directory capacity and modification/lookup scalability.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
