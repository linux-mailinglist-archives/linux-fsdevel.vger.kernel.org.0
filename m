Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C463F087A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbhHRPxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 11:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240179AbhHRPxU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:53:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8C8F6103E;
        Wed, 18 Aug 2021 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629301965;
        bh=vVeI3LiscroXKFqNQkaexJy8prZzkKcFh8YHE/6KTXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqA52zUDP1nh1QBVinxNq5599/7V41rnCUSxB8fXnl2F6SQp3hF4BNkVVIOSTz+UB
         9O/A8TqvdzhqohgNxF0N77HVbgUI/bX9DSFk+/rS9lrfLrUJvJ8DzydTeST7RAQCnN
         5p14ag/i6XR09m0rBz+Ek/r9xYAJkFXR/7TrjXQekKmR0Mpny1qAacSawqqZ0ThlgF
         svZSvvvg3YPXxNEHirQW1zj/2HRsM94qIxO+wygxRX7JHrbVnbZhsVPrTe/Xd3Lu3f
         KX9ve16noIoU322Atbm+cdYDPMjUSPY5s7ncO8ITgXseiCCRgsp57z0YKWkZLyomma
         UTDxvSrCsmEAA==
Date:   Wed, 18 Aug 2021 08:52:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        dan.j.williams@intel.com, david@fromorbit.com, hch@lst.de,
        agk@redhat.com, snitzer@redhat.com
Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
Message-ID: <20210818155245.GE12664@magnolia>
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
 <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
 <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com>
 <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:08:40PM -0700, Jane Chu wrote:
> 
> On 8/17/2021 10:43 PM, Jane Chu wrote:
> > More information -
> > 
> > On 8/16/2021 10:20 AM, Jane Chu wrote:
> > > Hi, ShiYang,
> > > 
> > > So I applied the v6 patch series to my 5.14-rc3 as it's what you
> > > indicated is what v6 was based at, and injected a hardware poison.
> > > 
> > > I'm seeing the same problem that was reported a while ago after the
> > > poison was consumed - in the SIGBUS payload, the si_addr is missing:
> > > 
> > > ** SIGBUS(7): canjmp=1, whichstep=0, **
> > > ** si_addr(0x(nil)), si_lsb(0xC), si_code(0x4, BUS_MCEERR_AR) **
> > > 
> > > The si_addr ought to be 0x7f6568000000 - the vaddr of the first page
> > > in this case.
> > 
> > The failure came from here :
> > 
> > [PATCH RESEND v6 6/9] xfs: Implement ->notify_failure() for XFS
> > 
> > +static int
> > +xfs_dax_notify_failure(
> > ...
> > +    if (!xfs_sb_version_hasrmapbt(&mp->m_sb)) {
> > +        xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
> > +        return -EOPNOTSUPP;
> > +    }
> > 
> > I am not familiar with XFS, but I have a few questions I hope to get
> > answers -
> > 
> > 1) What does it take and cost to make
> >     xfs_sb_version_hasrmapbt(&mp->m_sb) to return true?

mkfs.xfs -m rmapbt=1

> > 2) For a running environment that fails the above check, is it
> >     okay to leave the poison handle in limbo and why?
> > 
> > 3) If the above regression is not acceptable, any potential remedy?
> 
> How about moving the check to prior to the notifier registration?
> And register only if the check is passed?  This seems better
> than an alternative which is to fall back to the legacy memory_failure
> handling in case the filesystem returns -EOPNOTSUPP.

"return -EOPNOTSUPP;" is the branching point where a future patch could
probe the (DRAM) buffer cache to bwrite the contents to restore the pmem
contents.  Right now the focus should be on landing the core code
changes without drawing any more NAKs from Dan.

--D

> thanks,
> -jane
> 
> > 
> > thanks!
> > -jane
> > 
> > 
> > > 
> > > Something is not right...
> > > 
> > > thanks,
> > > -jane
> > > 
> > > 
> > > On 8/5/2021 6:17 PM, Jane Chu wrote:
> > > > The filesystem part of the pmem failure handling is at minimum built
> > > > on PAGE_SIZE granularity - an inheritance from general
> > > > memory_failure handling.  However, with Intel's DCPMEM
> > > > technology, the error blast
> > > > radius is no more than 256bytes, and might get smaller with future
> > > > hardware generation, also advanced atomic 64B write to clear the poison.
> > > > But I don't see any of that could be incorporated in, given that the
> > > > filesystem is notified a corruption with pfn, rather than an exact
> > > > address.
> > > > 
> > > > So I guess this question is also for Dan: how to avoid unnecessarily
> > > > repairing a PMD range for a 256B corrupt range going forward?
> > > > 
> > > > thanks,
> > > > -jane
> > > > 
> > > > 
> > > > On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
> > > > > When memory-failure occurs, we call this function which is implemented
> > > > > by each kind of devices.  For the fsdax case, pmem device driver
> > > > > implements it.  Pmem device driver will find out the
> > > > > filesystem in which
> > > > > the corrupted page located in.  And finally call filesystem handler to
> > > > > deal with this error.
> > > > > 
> > > > > The filesystem will try to recover the corrupted data if necessary.
> > > > 
> > > 
> > 
