Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813B92C17C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 22:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgKWVhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 16:37:08 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57362 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730466AbgKWVhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:37:08 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D38B658B8C4;
        Tue, 24 Nov 2020 08:37:03 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1khJWA-00EJp0-PA; Tue, 24 Nov 2020 08:37:02 +1100
Date:   Tue, 24 Nov 2020 08:37:02 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     XiaoLi Feng <xifeng@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, ira.weiny@intel.com,
        Xiaoli Feng <fengxiaoli0714@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/stat: set attributes_mask for STATX_ATTR_DAX
Message-ID: <20201123213702.GV7391@dread.disaster.area>
References: <20201121003331.21342-1-xifeng@redhat.com>
 <21890103-fce2-bb50-7fc2-6c6d509b982f@infradead.org>
 <20201121011516.GD3837269@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121011516.GD3837269@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=zd7GPZmn2bw0TrGjmFEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 06:03:18PM -0800, Darrick J. Wong wrote:
> [Adding fsdevel to cc since this is a filesystems question]
> 
> On Fri, Nov 20, 2020 at 04:58:09PM -0800, Randy Dunlap wrote:
> > Hi,
> > 
> > I don't know this code, but:
> > 
> > On 11/20/20 4:33 PM, XiaoLi Feng wrote:
> > > From: Xiaoli Feng <fengxiaoli0714@gmail.com>
> > > 
> > > keep attributes and attributes_mask are consistent for
> > > STATX_ATTR_DAX.
> > > ---
> > >  fs/stat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/stat.c b/fs/stat.c
> > > index dacecdda2e79..914a61d256b0 100644
> > > --- a/fs/stat.c
> > > +++ b/fs/stat.c
> > > @@ -82,7 +82,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
> > >  
> > >  	if (IS_DAX(inode))
> > >  		stat->attributes |= STATX_ATTR_DAX;
> > > -
> > > +	stat->attributes_mask |= STATX_ATTR_DAX;
> > 
> > Why shouldn't that be:
> > 
> > 	if (IS_DAX(inode))
> > 		stat->attributes_mask |= STATX_ATTR_DAX;
> > 
> > or combine them, like this:
> > 
> > 	if (IS_DAX(inode)) {
> > 		stat->attributes |= STATX_ATTR_DAX;
> > 		stat->attributes_mask |= STATX_ATTR_DAX;
> > 	}
> > 
> > 
> > and no need to delete that blank line.
> 
> Some filesystems could support DAX but not have it enabled for this
> particular file, so this won't work.
> 
> General question: should filesystems that are /capable/ of DAX signal
> this by setting the DAX bit in the attributes mask?

I think so, yes. It could be set if the right bit on the inode is
set, but it currently isn't so the bit in the mask is set but the
bit in the attributes is not. i.e "DAX is valid status bit, but it
is not set for this file".

> Or is this a VFS
> feature and hence here is the appropriate place to be setting the mask?

Well, in the end it's a filesystem feature bit because the
filesystem policy that decides whether DAX is used or not. e.g. if
the block device is not DAX capable or dax=never mount option is
set, we should not ever set STATX_ATTR_DAX in statx for either the
attributes or attributes_mask field because the filesystem is not
DAX capable. And given that we have filesystems with multiple block
devices that can have different DAX capabilities, I think this
statx() attr state (and mask) really has to come from the
filesystem, not VFS...

> Extra question: should we only set this in the attributes mask if
> CONFIG_FS_DAX=y ?

IMO, yes, because it will always be false on CONFIG_FS_DAX=n and so
it may well as not be emitted as a supported bit in the mask.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
