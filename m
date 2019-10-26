Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96BE5FAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2019 22:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJZU4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Oct 2019 16:56:12 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:42451 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbfJZU4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:56:12 -0400
Received: from dread.disaster.area (pa49-181-161-154.pa.nsw.optusnet.com.au [49.181.161.154])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4FA223A0606;
        Sun, 27 Oct 2019 07:56:10 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iOT6X-00068M-N6; Sun, 27 Oct 2019 07:56:09 +1100
Date:   Sun, 27 Oct 2019 07:56:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: add generic UNRESVSP and ZERO_RANGE ioctl
 handlers
Message-ID: <20191026205609.GJ4614@dread.disaster.area>
References: <20191025023609.22295-1-hch@lst.de>
 <20191025023609.22295-3-hch@lst.de>
 <20191025054452.GF913374@magnolia>
 <20191025095005.GA9613@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025095005.GA9613@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=l3vQdJ1SkhDHY1nke8Lmag==:117 a=l3vQdJ1SkhDHY1nke8Lmag==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=b_qk7ts0-XUPVcVpBZMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:50:05AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 24, 2019 at 10:44:52PM -0700, Darrick J. Wong wrote:
> > >  	case XFS_IOC_FREESP:
> > > -	case XFS_IOC_UNRESVSP:
> > >  	case XFS_IOC_ALLOCSP64:
> > > -	case XFS_IOC_FREESP64:
> > > -	case XFS_IOC_UNRESVSP64:
> > > -	case XFS_IOC_ZERO_RANGE: {
> > > +	case XFS_IOC_FREESP64: {
> > 
> > Ok, so this hoists everything to the vfs except for ALLOCSP and FREESP,
> > which seems to be ... "set new size; allocate between old and new EOF if
> > appropriate"?
> > 
> > I'm asking because I was never really clear on what those things are
> > supposed to do. :)
> 
> Yes. ALLOCSP/FREESP have so weird semantics that we never added the
> equivalent functionality to fallocate.

We should plan to deprecate and remove ALLOCSP/FREESP - they just
aren't useful APIs anymore, and nobody has used them in preference
to the RESVSP/UNRESVSP ioctls since they were introduced in ~1998
with unwritten extents. We probably should have deprecated then 10
years ago....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
