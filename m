Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873AA262D70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 12:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgIIKvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 06:51:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:52316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIIKvg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:51:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FD05ABD2;
        Wed,  9 Sep 2020 10:51:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 79C291E12E1; Wed,  9 Sep 2020 12:51:33 +0200 (CEST)
Date:   Wed, 9 Sep 2020 12:51:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, hch@lst.de
Subject: Re: [PATCH v3] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200909105133.GC24207@quack2.suse.cz>
References: <20200909013251.GG7955@magnolia>
 <20200909014933.GC6583@casper.infradead.org>
 <20200909022909.GI7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909022909.GI7955@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-09-20 19:29:09, Darrick J. Wong wrote:
> On Wed, Sep 09, 2020 at 02:49:33AM +0100, Matthew Wilcox wrote:
> > On Tue, Sep 08, 2020 at 06:32:51PM -0700, Darrick J. Wong wrote:
> > > +static inline void copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
> > > +		__s32 *timer_lo, __s8 *timer_hi, s64 timer)
> > > +{
> > > +	*timer_lo = timer;
> > > +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> > > +		*timer_hi = timer >> 32;
> > > +	else
> > > +		*timer_hi = 0;
> > > +}
> > 
> > I'm still confused by this.  What breaks if you just do:
> > 
> > 	*timer_lo = timer;
> > 	*timer_hi = timer >> 32;
> 
> "I don't know."
> 
> The manpage for quotactl doesn't actually specify the behavior of the
> padding fields.  The /implementation/ is careful enough to zero
> everything, but the interface specification doesn't explicitly require
> software to do so.
> 
> Because the contents of the padding fields aren't defined by the
> documentation, the kernel cannot simply start using the d_padding2 field
> because there could be an old kernel that doesn't zero the padding,
> which would lead to confusion if the new userspace were mated to such a
> kernel.
> 
> Therefore, we have to add a flag that states explicitly that we are
> using the timer_hi fields.  This is also the only way that an old
> program can detect that it's being fed a structure that it might not
> recognise.

Well, this is in the direction from kernel to userspace and what Matthew
suggests would just make kernel posssibly store non-zero value in *timer_hi
without setting FS_DQ_BIGTIME flag (for negative values of timer). I don't
think it would break anything but I agree the complication isn't big so
let's be careful and only set *timer_hi to non-zero if FS_DQ_BIGTIME is
set.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
