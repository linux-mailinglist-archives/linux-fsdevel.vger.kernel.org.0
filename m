Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F95E40A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 02:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfJYAgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 20:36:11 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59287 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729728AbfJYAgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:36:10 -0400
Received: from dread.disaster.area (pa49-181-161-154.pa.nsw.optusnet.com.au [49.181.161.154])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E39F73634F1;
        Fri, 25 Oct 2019 11:36:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iNnaF-0007Qb-GX; Fri, 25 Oct 2019 11:36:03 +1100
Date:   Fri, 25 Oct 2019 11:36:03 +1100
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
Message-ID: <20191025003603.GE4614@dread.disaster.area>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
 <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
 <20191023221332.GE2044@dread.disaster.area>
 <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
 <20191024073446.GA4614@dread.disaster.area>
 <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
 <20191024213508.GB4614@dread.disaster.area>
 <ab101f90-6ec1-7527-1859-5f6309640cfa@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab101f90-6ec1-7527-1859-5f6309640cfa@plexistor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=l3vQdJ1SkhDHY1nke8Lmag==:117 a=l3vQdJ1SkhDHY1nke8Lmag==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=wNVn5hzRuzmDeAh33toA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 02:29:04AM +0300, Boaz Harrosh wrote:
> On 25/10/2019 00:35, Dave Chinner wrote:
> > On Thu, Oct 24, 2019 at 05:05:45PM +0300, Boaz Harrosh wrote:
> > This isn't a theoretical problem - this is exactly the race
> > condition that lead us to disabling the flag in the first place.
> > There is no serialisation between the read and write parts of the
> > page fault iand the filesystem changing the DAX flag and ops vector,
> > and so fixing this problem requires hold yet more locks in the
> > filesystem path to completely lock out page fault processing on the
> > inode's mapping.
> > 
> 
> Again sorry that I do not explain very good.
> 
> Already on the read fault we populate the xarray,

On a write fault we can have an empty xarray slot so the write fault
needs to both populate the xarray slot (read fault) and process the
write fault.

> My point was that if I want to set the DAX mode I must enforce that
> there are no other parallel users on my inode. The check that the
> xarray is empty is my convoluted way to check that there are no other
> users except me. If xarray is not empty I bail out with EBUISY

Checking the xarray being empty is racy. The moment you drop the
mapping lock, the page fault can populate a slot in the mapping that
you just checked was empty. And then you swap the aops between the
population and the ->page-mkwrite() call in the page fault
that is running, and things go boom.

Unless there's something new in the page fault path that nobody has
noticed in the past couple of years, this TOCTOU race hasn't been
solved....

> Perhaps we always go by the directory. And then do an mv dir_DAX/foo dir_NODAX/foo

The inode is instatiated before the rename is run, so it's set up
with it's old dir config, not the new one. So this ends up with the
same problem of haivng to change the S_DAX flag and aops vector
dynamically on rename. Same problem, not a solution.

> to have an effective change. In hard links the first one at iget time before populating
> the inode cache takes affect.

If something like a find or backup program brings the inode into
cache, the app may not even get the behaviour it wants, and it can't
change it until the inode is evicted from cache, which may be never.
Nobody wants implicit/random/uncontrollable/unchangeable behaviour
like this.

> (And never change the flag on the fly)
> (Just brain storming here)

We went over all this ground when we disabled the flag in the first
place. We disabled the flag because we couldn't come up with a sane
way to flip the ops vector short of tracking the number of aops
calls in progress at any given time. i.e. reference counting the
aops structure, but that's hard to do with a const ops structure,
and so it got disabled rather than allowing users to crash
kernels....

Cheers,

-Dave.
-- 
Dave Chinner
david@fromorbit.com
