Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29DE263E17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgIJHJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 03:09:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbgIJHHM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:07:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41023AF9C;
        Thu, 10 Sep 2020 07:07:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DB811E12EB; Thu, 10 Sep 2020 09:07:09 +0200 (CEST)
Date:   Thu, 10 Sep 2020 09:07:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, hch@lst.de
Subject: Re: [PATCH v3] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200910070709.GA17540@quack2.suse.cz>
References: <20200909013251.GG7955@magnolia>
 <20200909014933.GC6583@casper.infradead.org>
 <20200909022909.GI7955@magnolia>
 <20200909105133.GC24207@quack2.suse.cz>
 <20200909124252.GE6583@casper.infradead.org>
 <20200909135645.GB29150@quack2.suse.cz>
 <20200909172701.GK7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909172701.GK7955@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-09-20 10:27:01, Darrick J. Wong wrote:
> On Wed, Sep 09, 2020 at 03:56:45PM +0200, Jan Kara wrote:
> > On Wed 09-09-20 13:42:52, Matthew Wilcox wrote:
> > > On Wed, Sep 09, 2020 at 12:51:33PM +0200, Jan Kara wrote:
> > > > On Tue 08-09-20 19:29:09, Darrick J. Wong wrote:
> > > > > On Wed, Sep 09, 2020 at 02:49:33AM +0100, Matthew Wilcox wrote:
> > > > > > On Tue, Sep 08, 2020 at 06:32:51PM -0700, Darrick J. Wong wrote:
> > > > > > > +static inline void copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
> > > > > > > +		__s32 *timer_lo, __s8 *timer_hi, s64 timer)
> > > > > > > +{
> > > > > > > +	*timer_lo = timer;
> > > > > > > +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> > > > > > > +		*timer_hi = timer >> 32;
> > > > > > > +	else
> > > > > > > +		*timer_hi = 0;
> > > > > > > +}
> > > > > > 
> > > > > > I'm still confused by this.  What breaks if you just do:
> > > > > > 
> > > > > > 	*timer_lo = timer;
> > > > > > 	*timer_hi = timer >> 32;
> > > > > 
> > > > > "I don't know."
> > > > > 
> > > > > The manpage for quotactl doesn't actually specify the behavior of the
> > > > > padding fields.  The /implementation/ is careful enough to zero
> > > > > everything, but the interface specification doesn't explicitly require
> > > > > software to do so.
> > > > > 
> > > > > Because the contents of the padding fields aren't defined by the
> > > > > documentation, the kernel cannot simply start using the d_padding2 field
> > > > > because there could be an old kernel that doesn't zero the padding,
> > > > > which would lead to confusion if the new userspace were mated to such a
> > > > > kernel.
> > > > > 
> > > > > Therefore, we have to add a flag that states explicitly that we are
> > > > > using the timer_hi fields.  This is also the only way that an old
> > > > > program can detect that it's being fed a structure that it might not
> > > > > recognise.
> > > > 
> > > > Well, this is in the direction from kernel to userspace and what Matthew
> > > > suggests would just make kernel posssibly store non-zero value in *timer_hi
> > > > without setting FS_DQ_BIGTIME flag (for negative values of timer). I don't
> > > > think it would break anything but I agree the complication isn't big so
> > > > let's be careful and only set *timer_hi to non-zero if FS_DQ_BIGTIME is
> > > > set.
> > > 
> > > OK, thanks.  I must admit, I'd completely forgotten about the negative
> > > values ... and the manpage (quotactl(2)) could be clearer:
> > > 
> > >                       int32_t  d_itimer;    /* Zero if within inode limits */
> > >                                             /* If not, we refuse service */
> > >                       int32_t  d_btimer;    /* Similar to above; for
> > >                                                disk blocks */
> > > 
> > > I can't tell if this is a relative time or seconds since 1970 since we
> > > exceeded the quota.
> > 
> > In fact, it is time (in seconds since epoch) when softlimit becomes
> > enforced (i.e. when you cannot write any more blocks/inodes if you are
> > still over softlimit). I agree the comment incomplete at best. Something
> > like attached patch?
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> > From 3e3260a337ff444e3a1396834b20da63d7b87ccb Mon Sep 17 00:00:00 2001
> > From: Jan Kara <jack@suse.cz>
> > Date: Wed, 9 Sep 2020 15:54:46 +0200
> > Subject: [PATCH] quota: Expand comment describing d_itimer
> > 
> > Expand comment describing d_itimer in struct fs_disk_quota.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  include/uapi/linux/dqblk_xfs.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
> > index 16d73f54376d..e4b3fd7f0a50 100644
> > --- a/include/uapi/linux/dqblk_xfs.h
> > +++ b/include/uapi/linux/dqblk_xfs.h
> > @@ -62,7 +62,8 @@ typedef struct fs_disk_quota {
> >  	__u64		d_bcount;	/* # disk blocks owned by the user */
> >  	__u64		d_icount;	/* # inodes owned by the user */
> >  	__s32		d_itimer;	/* zero if within inode limits */
> > -					/* if not, we refuse service */
> > +					/* if not, we refuse service at this
> > +					 * time (in seconds since epoch) */
> 
> "since Unix epoch"?
> 
> Otherwise looks fine to me...

Thanks for having a look. Patch updated and added to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
