Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED682F27A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 06:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbhALFV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 00:21:58 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:44302 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbhALFV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:21:58 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8C2BE826077;
        Tue, 12 Jan 2021 16:21:15 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kzC7G-005aGL-IW; Tue, 12 Jan 2021 16:21:14 +1100
Date:   Tue, 12 Jan 2021 16:21:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 04/12] fat: only specify I_DIRTY_TIME when needed in
 fat_update_time()
Message-ID: <20210112052114.GS331610@dread.disaster.area>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-5-ebiggers@kernel.org>
 <20210111105201.GB2502@lst.de>
 <X/ysA8PuJ/+JXQYL@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/ysA8PuJ/+JXQYL@sol.localdomain>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=joOgMYZwUYIHNJ8tGMoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:50:27AM -0800, Eric Biggers wrote:
> On Mon, Jan 11, 2021 at 11:52:01AM +0100, Christoph Hellwig wrote:
> > On Fri, Jan 08, 2021 at 11:58:55PM -0800, Eric Biggers wrote:
> > > +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > > +		dirty_flags |= I_DIRTY_SYNC;
> > 
> > fat does not support i_version updates, so this bit can be skipped.
> 
> Is that really the case?  Any filesystem (including fat) can be mounted with
> "iversion", which causes SB_I_VERSION to be set.

That's a bug. Filesystems taht don't support persistent i_version on
disk need to clear SB_I_VERSION in their mount and remount paths
because the VFS iversion mount option was a complete screwup from
the start.

> A lot of filesystems (including fat) don't store i_version to disk, but it looks
> like it will still get updated in-memory.  Could anything be relying on that?

If they do, then they are broken by definition. i_version as
reported to observers is defined as monotonically increasing with
every change to the inode. i.e. it never goes backwards. Which, of
course, it will do if you crash or even just unmount/mount a
filesystem that doesn't persist it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
