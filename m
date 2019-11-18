Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01DCFFCA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 02:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfKRBAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 20:00:52 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60376 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfKRBAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 20:00:52 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 333503A1F83;
        Mon, 18 Nov 2019 12:00:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iWVPL-0004U1-Vm; Mon, 18 Nov 2019 12:00:47 +1100
Date:   Mon, 18 Nov 2019 12:00:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/28] xfs: rework unreferenced inode lookups
Message-ID: <20191118010047.GS4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-29-david@fromorbit.com>
 <20191106221846.GE37080@bfoster>
 <20191114221602.GJ4614@dread.disaster.area>
 <20191115172600.GC55854@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115172600.GC55854@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=ETrtCZpq2FqVuZsvotgA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 12:26:00PM -0500, Brian Foster wrote:
> On Fri, Nov 15, 2019 at 09:16:02AM +1100, Dave Chinner wrote:
> > On Wed, Nov 06, 2019 at 05:18:46PM -0500, Brian Foster wrote:
> > If so, most of this patch will go away....
> > 
> > > > +	 * attached to the buffer so we don't need to do anything more here.
> > > >  	 */
> > > > -	if (ip != free_ip) {
> > > > -		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> > > > -			rcu_read_unlock();
> > > > -			delay(1);
> > > > -			goto retry;
> > > > -		}
> > > > -
> > > > -		/*
> > > > -		 * Check the inode number again in case we're racing with
> > > > -		 * freeing in xfs_reclaim_inode().  See the comments in that
> > > > -		 * function for more information as to why the initial check is
> > > > -		 * not sufficient.
> > > > -		 */
> > > > -		if (ip->i_ino != inum) {
> > > > +	if (__xfs_iflags_test(ip, XFS_ISTALE)) {
> > > 
> > > Is there a correctness reason for why we move the stale check to under
> > > ilock (in both iflush/ifree)?
> > 
> > It's under the i_flags_lock, and so I moved it up under the lookup
> > hold of the i_flags_lock so we don't need to cycle it again.
> > 
> 
> Yeah, but in both cases it looks like it moved to under the ilock as
> well, which comes after i_flags_lock. IOW, why grab ilock for stale
> inodes when we're just going to skip them?

Because I was worrying about serialising against reclaim before
changing the state of the inode. i.e. if the inode has already been
isolated by not yet disposed of, we shouldn't touch the inode state
at all. Serialisation against reclaim in this patch is via the
ILOCK, hence we need to do that before setting ISTALE....

IOWs, ISTALE is not protected by ILOCK, we just can't modify the
inode state until after we've gained the ILOCK to protect against
reclaim....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
