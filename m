Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB71262FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 16:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgIIOdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgIIMw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:52:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9760AC061573;
        Wed,  9 Sep 2020 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=58sG1vYlJHBFQDIUCtJjWtgRiAocEReWIPrRe4T7EjY=; b=GplkHj3Pyv32sC6XZQP+CbuD71
        +XFTuyNH3iTpSSRnPFsJ3LlOBz4IiKxff5aiBnq4ksixeRMQZomEqhCbX+bsH9AK+YkgAnry+9hYf
        f3OW1pf4L5B9ddAE4ciXiHsiLeRGFYazHwac+I6m6H6F2JU2RMV31wJP+zdNoBuXGQWjjMmcwPEkq
        aEIyazl5FR6+DqBkN5Bza9YnHBbEXU9YFzpXpZpALRUBlMvRko7V8gkcGXo5gJmE3/QWIdGPFWJGJ
        Pz+L4EfmpuBRDSEntIxFajSMUP3FSmUYsSiz1+NrVF+NDKSbcYw436TXyL8xhxRS6UJcvSBUyvYPK
        ZQG0nsHw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFzR6-0000zj-AE; Wed, 09 Sep 2020 12:42:52 +0000
Date:   Wed, 9 Sep 2020 13:42:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, hch@lst.de
Subject: Re: [PATCH v3] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200909124252.GE6583@casper.infradead.org>
References: <20200909013251.GG7955@magnolia>
 <20200909014933.GC6583@casper.infradead.org>
 <20200909022909.GI7955@magnolia>
 <20200909105133.GC24207@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909105133.GC24207@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 09, 2020 at 12:51:33PM +0200, Jan Kara wrote:
> On Tue 08-09-20 19:29:09, Darrick J. Wong wrote:
> > On Wed, Sep 09, 2020 at 02:49:33AM +0100, Matthew Wilcox wrote:
> > > On Tue, Sep 08, 2020 at 06:32:51PM -0700, Darrick J. Wong wrote:
> > > > +static inline void copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
> > > > +		__s32 *timer_lo, __s8 *timer_hi, s64 timer)
> > > > +{
> > > > +	*timer_lo = timer;
> > > > +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> > > > +		*timer_hi = timer >> 32;
> > > > +	else
> > > > +		*timer_hi = 0;
> > > > +}
> > > 
> > > I'm still confused by this.  What breaks if you just do:
> > > 
> > > 	*timer_lo = timer;
> > > 	*timer_hi = timer >> 32;
> > 
> > "I don't know."
> > 
> > The manpage for quotactl doesn't actually specify the behavior of the
> > padding fields.  The /implementation/ is careful enough to zero
> > everything, but the interface specification doesn't explicitly require
> > software to do so.
> > 
> > Because the contents of the padding fields aren't defined by the
> > documentation, the kernel cannot simply start using the d_padding2 field
> > because there could be an old kernel that doesn't zero the padding,
> > which would lead to confusion if the new userspace were mated to such a
> > kernel.
> > 
> > Therefore, we have to add a flag that states explicitly that we are
> > using the timer_hi fields.  This is also the only way that an old
> > program can detect that it's being fed a structure that it might not
> > recognise.
> 
> Well, this is in the direction from kernel to userspace and what Matthew
> suggests would just make kernel posssibly store non-zero value in *timer_hi
> without setting FS_DQ_BIGTIME flag (for negative values of timer). I don't
> think it would break anything but I agree the complication isn't big so
> let's be careful and only set *timer_hi to non-zero if FS_DQ_BIGTIME is
> set.

OK, thanks.  I must admit, I'd completely forgotten about the negative
values ... and the manpage (quotactl(2)) could be clearer:

                      int32_t  d_itimer;    /* Zero if within inode limits */
                                            /* If not, we refuse service */
                      int32_t  d_btimer;    /* Similar to above; for
                                               disk blocks */

I can't tell if this is a relative time or seconds since 1970 since we
exceeded the quota.
