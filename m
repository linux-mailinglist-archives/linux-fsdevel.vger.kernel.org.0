Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC7B3B6DD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 07:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhF2FO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 01:14:27 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:47829 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231244AbhF2FO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 01:14:26 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 0DEF168DBD;
        Tue, 29 Jun 2021 15:11:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ly62H-000dmT-B3; Tue, 29 Jun 2021 15:11:49 +1000
Date:   Tue, 29 Jun 2021 15:11:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-fsdevel@vger.kernel.org, dai.ngo@oracle.com,
        linux-nfs@vger.kernel.org
Subject: Re: automatic freeing of space on ENOSPC
Message-ID: <20210629051149.GP2419729@dread.disaster.area>
References: <20210628194908.GB6776@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628194908.GB6776@fieldses.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=07d9gI8wAAAA:8 a=7-415B0cAAAA:8
        a=3lns27HCGDEbDcNwDR0A:9 a=CjuIK1q_8ugA:10 a=e2CUPOnPG4QKp8I52DXD:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 03:49:08PM -0400, J. Bruce Fields wrote:
> Is there anything analogous to a "shrinker", but for disk space?  So,
> some hook that a filesystem could call to say "I'm running out of space,
> could you please free something?", before giving up and returning
> ENOSPC?

The only thing the filesystem can do at this point is run internal
garbage collection operations to free up space that it has either
speculatively allocated or has deferred the freeing and/or cleanupi
of. In general, filesystems already do this when they are
approaching/at ENOSPC, so it seems to me like there's little scope
for an external "free some space" trigger to be able to make much
difference.

I mean, we do have an ioctl in XFS to trigger garbage collection of
speculative preallocation from userspace (XFS_IOC_FREE_EOFBLOCKS
and the prealloc command in xfs_spaceman(8)) but this was written
because some people want accurate space accounting for things like
quota reports....

Regardless, we run these same GC triggers internally before we
declare ENOSPC, so there's no real need for applications to run them
when they get an ENOSPC error....

> The NFS server currently revokes a client's state if the client fails to
> contact it within a lease period (90 seconds by default).  That's
> harsher than necessary--if a network partition lasts longer than a lease
> period, but if nobody else needs that client's resources, it'd be nice
> to be able to hang on to them so that the client could resume normal
> operation after the network comes back.  So we'd delay revoking the
> client's state until there's an actual conflict.  But that means we need
> a way to clean up the client as soon as there is a conflict, to avoid
> unnecessarily failing operations that conflict with resources held by an
> expired client.

I'm not sure what you are asking for filesystems to do here.  This
seems like an application problem - revoking the client's open file
state and cleaning up silly rename files is application level
garbage collection, not filesystem level stuff. Maybe I've
misunderstood what you are trying to do, perhaps you could clarify
what you're expecting the filesystems to be able to clean up here?

> I searched around and found this discussion of volatile ranges
> https://lwn.net/Articles/522135/, which seems close, but I don't know if
> anything came of that in the end.

Nothing that I know of.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
