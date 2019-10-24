Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558F2E2B37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 09:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408615AbfJXHe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 03:34:57 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42322 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727635AbfJXHe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:34:56 -0400
Received: from dread.disaster.area (pa49-181-161-154.pa.nsw.optusnet.com.au [49.181.161.154])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7528843E54F;
        Thu, 24 Oct 2019 18:34:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iNXdu-0001Nj-RS; Thu, 24 Oct 2019 18:34:46 +1100
Date:   Thu, 24 Oct 2019 18:34:46 +1100
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
Message-ID: <20191024073446.GA4614@dread.disaster.area>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
 <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
 <20191023221332.GE2044@dread.disaster.area>
 <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=l3vQdJ1SkhDHY1nke8Lmag==:117 a=l3vQdJ1SkhDHY1nke8Lmag==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=Tfe4Wh1HrYWVbsmHChwA:9
        a=eAQsJKfVFY_lWVYV:21 a=XZNTOILeClruhaqN:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:31:13AM +0300, Boaz Harrosh wrote:
> On 24/10/2019 01:13, Dave Chinner wrote:
> > On Wed, Oct 23, 2019 at 04:09:50PM +0300, Boaz Harrosh wrote:
> >> On 22/10/2019 14:21, Boaz Harrosh wrote:
> >>> On 20/10/2019 18:59, ira.weiny@intel.com wrote:
> >> Please explain the use case behind your model?
> > 
> > No application changes needed to control whether they use DAX or
> > not. It allows the admin to control the application behaviour
> > completely, so they can turn off DAX if necessary. Applications are
> > unaware of constraints that may prevent DAX from being used, and so
> > admins need a mechanism to prevent DAX aware application from
> > actually using DAX if the capability is present.
> > 
> > e.g. given how slow some PMEM devices are when it comes to writing
> > data, especially under extremely high concurrency, DAX is not
> > necessarily a performance win for every application. Admins need a
> > guaranteed method of turning off DAX in these situations - apps may
> > not provide such a knob, or even be aware of a thing called DAX...
> > 
> 
> Thank you Dave for explaining. Forgive my slowness. I now understand
> your intention.
> 
> But if so please address my first concern. That in the submitted implementation
> you must set the flag-bit after the create of the file but before the write.
> So exactly the above slow writes must always be DAX if I ever want the file
> to be DAX accessed in the future.

The on disk DAX flag is inherited from the parent directory at
create time. Hence an admin only need to set it on the data
directory of the application when first configuring it, and
everything the app creates will be configured for DAX access
automatically.

Or, alternatively, mkfs sets the flag on the root dir so that
everything in the filesystem uses DAX by default (through
inheritance) unless the admin turns off the flag on a directory
before it starts to be used or on a set of files after they have
been created (because DAX causes problems)...

So, yeah, there's another problem with the basic assertion that we
only need to allow the on disk flag to be changed on zero length
files: we actually want to be able to -clear- the DAX flag when the
file has data attached to it, not just when it is an empty file...

> What if, say in XFS when setting the DAX-bit we take all the three write-locks
> same as a truncate. Then we check that there are no active page-cache mappings
> ie. a single opener. Then allow to set the bit. Else return EBUISY. (file is in use)

DAX doesn't have page cache mappings, so anything that relies on
checking page cache state isn't going to work reliably. I also seem
to recall that there was a need to take some vm level lock to really
prevent page fault races, and that we can't safely take that in a
safe combination with all the filesystem locks we need.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
