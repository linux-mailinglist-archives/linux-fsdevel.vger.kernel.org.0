Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347D4EB8F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 22:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfJaVZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 17:25:22 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:39365 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbfJaVZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:25:22 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 821823A2478;
        Fri,  1 Nov 2019 08:25:18 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQHwT-0006PA-1p; Fri, 01 Nov 2019 08:25:17 +1100
Date:   Fri, 1 Nov 2019 08:25:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs/log: protect xc_cil in xlog_cil_push()
Message-ID: <20191031212517.GU4614@dread.disaster.area>
References: <1572416980-25274-1-git-send-email-kernelfans@gmail.com>
 <20191030125316.GC46856@bfoster>
 <20191030133327.GA29340@mypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030133327.GA29340@mypc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=7a3DnHZax8hR2wX84hUA:9 a=p36_3V06hZ0PtfoS:21 a=KtddtDzuOCae2heH:21
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 09:33:27PM +0800, Pingfan Liu wrote:
> On Wed, Oct 30, 2019 at 08:53:16AM -0400, Brian Foster wrote:
> > On Wed, Oct 30, 2019 at 02:29:40PM +0800, Pingfan Liu wrote:
> > > xlog_cil_push() is the reader and writer of xc_cil, and should be protected
> > > against xlog_cil_insert_items().
> > > 
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > > To: linux-xfs@vger.kernel.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > ---
> > >  fs/xfs/xfs_log_cil.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
> > > index ef652abd..004af09 100644
> > > --- a/fs/xfs/xfs_log_cil.c
> > > +++ b/fs/xfs/xfs_log_cil.c
> > > @@ -723,6 +723,7 @@ xlog_cil_push(
> > >  	 */
> > >  	lv = NULL;
> > >  	num_iovecs = 0;
> > > +	spin_lock(&cil->xc_cil_lock);
> > >  	while (!list_empty(&cil->xc_cil)) {
> > >  		struct xfs_log_item	*item;
> > >  
> > > @@ -737,6 +738,7 @@ xlog_cil_push(
> > >  		item->li_lv = NULL;
> > >  		num_iovecs += lv->lv_niovecs;
> > >  	}
> > > +	spin_unlock(&cil->xc_cil_lock);
> > 
> > The majority of this function executes under exclusive ->xc_ctx_lock.
> > xlog_cil_insert_items() runs with the ->xc_ctx_lock taken in read mode.
> > The ->xc_cil_lock spinlock is used in the latter case to protect the
> > list under concurrent transaction commits.
> > 
> I think the logic of xc_ctx_lock should be at a higher level of file
> system. But on the fundamental level, reader and writer should be
> protected against each other. And there is no protection for the list
> ops here.

Yes there is. The locking here is complex and unique, so takes some
understanding.

These are two different sets of operations that are being serialised
- high level operation is that transaction commits can run
concurrently (and must for performance), while CIL pushes must run
exclusively (for correctness).

So, yes, there is only one data structure we are accessing here and
it has two locks protecting it. They _nest_ to provide different
levels of exclusion: multiple producers vs single consumer via a
rwsem, and producer vs producer via a spin lock inside the shared
rwsem context. i.e.:

commit 1		commit 2		push

down_read(ctx_lock)
			down_read(ctx_lock)
						down_write(ctx_lock)
						<blocks>
spin_lock(cil_lock)
add to CIL		spin_lock(cil_lock)
			<spins>
spin_unlock(cil_lock)
			<gets cil_lock)
			add to CIL
up_read(ctx_lock)
			spin_unlock(cil_lock)
			up_read(ctx_lock)
						<gets ctx_lock>
						Processes CIL

As you can see, the CIL can only be accessed by a single thread at a
time, despite the fact there are multiple locks involved.

And the implied unlock->lock memory barriers ensure that list state
does not leak incorrectly between the different contexts....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
