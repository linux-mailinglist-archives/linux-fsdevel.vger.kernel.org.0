Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC1204F23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbgFWKgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 06:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732172AbgFWKgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:36:33 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07616C061573;
        Tue, 23 Jun 2020 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=42UbjTntj/fc5rojlRsUj9PMNMNzEe9xi7G1okFFxjk=; b=EnoQoqMrou48OOkI6I3f5cTFZx
        OAWRwgmhrIW58xLv4TNeX8XSr9xp2Rz4UJ314aWs3JDt2LsXp4sY0e9dFGvUr2DylbDDnR5oNrb/W
        ly9CcXg4YMECRCa1NG3Kxq/ZVY2nImfGgu8gHn88DinD9tHv3NOEi2tCdLD6pH9tSngw8T24DjYhd
        4LpQJqSTN37bMmhwqe1EcCYAjj6kHAWU8Qd0WvycEmlEvEp/MbWMvTzn0d3RIyreWpNDLQNBc46yH
        YqQGVpcRGiz9niG5OkuTsm2pRmLrE7Nmx5qDI661fkVdgLYJUC3Agzcy/9ezc1EoD6lV8FbjY/NMN
        oj+vWVPQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jngHe-0005M1-0o; Tue, 23 Jun 2020 10:36:06 +0000
Date:   Tue, 23 Jun 2020 11:36:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH v2] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200623103605.GA20464@infradead.org>
References: <20200618122408.1054092-1-agruenba@redhat.com>
 <20200619131347.GA22412@infradead.org>
 <CAHc6FU7uKUV-R+qJ9ifLAJkS6aPoG_6qWe7y7wJOb7EbWRL4dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7uKUV-R+qJ9ifLAJkS6aPoG_6qWe7y7wJOb7EbWRL4dQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:07:59AM +0200, Andreas Gruenbacher wrote:
> On Fri, Jun 19, 2020 at 3:25 PM Christoph Hellwig <hch@infradead.org> wrote:
> > On Thu, Jun 18, 2020 at 02:24:08PM +0200, Andreas Gruenbacher wrote:
> > > Make sure iomap_end is always called when iomap_begin succeeds.
> > >
> > > Without this fix, iomap_end won't be called when a filesystem's
> > > iomap_begin operation returns an invalid mapping, bypassing any
> > > unlocking done in iomap_end.  With this fix, the unlocking would
> > > at least still happen.
> > >
> > > This iomap_apply bug was found by Bob Peterson during code review.
> > > It's unlikely that such iomap_begin bugs will survive to affect
> > > users, so backporting this fix seems unnecessary.
> > >
> > > Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > ---
> > >  fs/iomap/apply.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> > > index 76925b40b5fd..32daf8cb411c 100644
> > > --- a/fs/iomap/apply.c
> > > +++ b/fs/iomap/apply.c
> > > @@ -46,10 +46,11 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
> > >       ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
> > >       if (ret)
> > >               return ret;
> > > -     if (WARN_ON(iomap.offset > pos))
> > > -             return -EIO;
> > > -     if (WARN_ON(iomap.length == 0))
> > > -             return -EIO;
> > > +     if (WARN_ON(iomap.offset > pos) ||
> > > +         WARN_ON(iomap.length == 0)) {
> > > +             written = -EIO;
> > > +             goto out;
> > > +     }
> >
> > As said before please don't merge these for no good reason.
> 
> I really didn't expect this tiny patch to require much discussion at
> all, but just to be clear ... do you actually object to this very
> patch that explicitly doesn't merge the two checks and keeps them on
> two separate lines so that the warning messages will report different
> line numbers, or are you fine with that?

Yes, it merges the WARN_ONs, and thus reduces their usefulness.  How
about a patch that just fixes your reported issue insted of messing up
other things for no good reason?
