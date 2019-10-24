Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE6CE3E49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 23:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfJXVfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 17:35:16 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45749 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbfJXVfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:35:16 -0400
Received: from dread.disaster.area (pa49-181-161-154.pa.nsw.optusnet.com.au [49.181.161.154])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7386F43F07B;
        Fri, 25 Oct 2019 08:35:09 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iNklA-0006Nu-K4; Fri, 25 Oct 2019 08:35:08 +1100
Date:   Fri, 25 Oct 2019 08:35:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
Message-ID: <20191024213508.GB4614@dread.disaster.area>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
 <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
 <20191023221332.GE2044@dread.disaster.area>
 <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
 <20191024073446.GA4614@dread.disaster.area>
 <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=l3vQdJ1SkhDHY1nke8Lmag==:117 a=l3vQdJ1SkhDHY1nke8Lmag==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=Qt9MKOuts2txuSNu_AQA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:05:45PM +0300, Boaz Harrosh wrote:
> On 24/10/2019 10:34, Dave Chinner wrote:
> > On Thu, Oct 24, 2019 at 05:31:13AM +0300, Boaz Harrosh wrote:
> <>
> > 
> > The on disk DAX flag is inherited from the parent directory at
> > create time. Hence an admin only need to set it on the data
> > directory of the application when first configuring it, and
> > everything the app creates will be configured for DAX access
> > automatically.
> > 
> 
> Yes I said that as well.

You said "it must be set between creation and first write",
stating the requirement for an on-disk flag to work. I'm
decribing how that requirement is actually implemented. i.e. what
you are stating is something we actually implemented years ago...

> > I also seem
> > to recall that there was a need to take some vm level lock to really
> > prevent page fault races, and that we can't safely take that in a
> > safe combination with all the filesystem locks we need.
> > 
> 
> We do not really care with page fault races in the Kernel as long

Oh yes we do. A write fault is a 2-part operation - a read fault to
populate the pte and mapping, then a write fault (->page_mkwrite) to 
do all the filesystem work needed to dirty the page and pte.

The read fault sets up the state for the write fault, and if we
change the aops between these two operations, then the
->page_mkwrite implementation goes kaboom.

This isn't a theoretical problem - this is exactly the race
condition that lead us to disabling the flag in the first place.
There is no serialisation between the read and write parts of the
page fault iand the filesystem changing the DAX flag and ops vector,
and so fixing this problem requires hold yet more locks in the
filesystem path to completely lock out page fault processing on the
inode's mapping.

> as I protect the xarray access and these are protected well if we
> take truncate locking. But we have a bigger problem that you pointed
> out with the change of the operations vector pointer.
> 
> I was thinking about this last night. One way to do this is with
> file-exclusive-lock. Correct me if I'm wrong:
> file-exclusive-readwrite-lock means any other openers will fail and
> if there are openers already the lock will fail. Which is what we want
> no?

The filesystem ioctls and page faults have no visibility of file
locks.  They don't know and can't find out in a sane manner that an
inode has a single -user- reference.

And it introduces a new problem for any application using the
fssetxattr() ioctl - accidentally not setting the S_DAX flag to be
unmodified will now fail, and that means such a change breaks
existing applications. Sure, you can say they are "buggy
applications", but the fact is this user API change breaks them.

Hence I don't think we can change the user API for setting/clearing
this flag like this.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
