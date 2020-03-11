Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16311810DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 07:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCKGjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 02:39:51 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:49925 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbgCKGjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:39:51 -0400
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 623EF7E9D25;
        Wed, 11 Mar 2020 17:39:44 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jBv1r-0007cE-0A; Wed, 11 Mar 2020 17:39:43 +1100
Date:   Wed, 11 Mar 2020 17:39:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200311063942.GE10776@dread.disaster.area>
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com>
 <20200311033614.GQ1752567@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311033614.GQ1752567@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=7-415B0cAAAA:8 a=6_jS5YWjWD2_AzFwGG8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:36:14PM -0700, Darrick J. Wong wrote:
> There are still other things that need to be ironed out WRT pmem:
> 
> a) reflink and page/pfn/whatever sharing -- fix the mm or (ab)use the
> xfs buffer cache, or something worse?

I don't think we need either. We just need to remove the DAX page
association for hwpoison that requires the struct page to store the
mapping and index. Get rid of that and we should be able to  safely
map the same page into different inode address spaces at the same
time. When we write a shared page, we COW it immediately and replace
the page in the inode's mapping tree, so we can't actually write to
a shared page...

IOWs, the dax_associate_page() related functionality probably needs
to be a filesystem callout - part of the aops vector, I think, so
that device dax can still use it. That way XFS can go it's own way,
while ext4 and device dax can continue to use the existing mechanism
mechanisn that is currently implemented....

XFS can then make use of rmapbt to find the owners on a bad page
notification, and run the "kill userspace dead dead dead" lookup on
each mapping/index tuple rather than pass it around on a struct
page. i.e. we'll do a kill scan for each mapping/index owner tuple
we find, not just one.

That requires converting all the current vma killer code to pass
mapping/index tuples around rather than the struct page. That kill
code doesn't actually need the struct page, it just needs the
mapping/index tuple to match to the vmas that have it mapped into
userspace.

> b) getting our stories straight on how to clear poison, and whether or
> not we can come up with a better story for ZERO_FILE_RANGE on pmem.  In
> the ideal world I'd love to see Z_F_R actually memset(0) the pmem and
> clear poison, at least if the file->pmem mappings were contiguous.

Are you talking about ZFR from userspace through the filesystem (how
do you clear poison in free space?) or ZFR on the dax device fro
either userspace or the kernel filesystem code?

> c) wiring up xfs to hwpoison, or wiring up hwpoison to xfs, or otherwise
> figuring out how to get storage to tell xfs that it lost something so
> that maybe xfs can fix it quickly

Yup, I think that's a dax device callback into the filesystem. i.e
the hwpoison gets delivered to the dax device, which then calls the
fs function rather than do it's current "dax_lock_page(), kill
userspace dead dead dead, dax_unlock_page()" dance. The filesystem
can do a much more intricate dance and wreak far more havoc on
userspace than what the dax device can do.....

Copious amounts of unused time are things I don't have,
unfortunately. Only having 7 fingers to type with right now doesn't
help, either.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
