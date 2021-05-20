Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1008B38B94C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhETWAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 18:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhETWAV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 18:00:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EFF861363;
        Thu, 20 May 2021 21:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621547939;
        bh=cr9cjPOGjSJo1JeuAfqWdjxUrbyclymJOAah1WYzXrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGabWJgBOH/sMH49BwyB0JMvb8NafpSx8D+qzkYl5SHYciNTu6ogZ8z6wTDzs/2n2
         FOsWRvxk5xwxY7dmioSDFEt8ddy9QNpZaLp0/ImqOxSFC/9vo7FkjC+Sqj2vtobIc5
         8Ic7xEcBjrDVTIrBHK8C0ebaduULFkTsMIfcoQoDAFmQmGqTcJYf3e6R/ozkkugPrA
         0tDF2A/SFlzgjemgNt9bp4EfcCUh2vxhwRbAQrG8c2ze2493e8G0T3JRPpe9jJd48H
         i+hZjd2nHj04UI91G/K1r83KmGIIHkj/bwDm/6MpKE2sPPMwMv2Dha79SaKiCylIL1
         5P0wjOliBfieg==
Date:   Thu, 20 May 2021 14:58:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iomap: resched ioend completion when in
 non-atomic context
Message-ID: <20210520215858.GZ9675@magnolia>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-2-bfoster@redhat.com>
 <YKKt2isZwu0qJK/C@casper.infradead.org>
 <YKOnGSJ9NR+cSRRc@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKOnGSJ9NR+cSRRc@bfoster>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 07:38:01AM -0400, Brian Foster wrote:
> On Mon, May 17, 2021 at 06:54:34PM +0100, Matthew Wilcox wrote:
> > On Mon, May 17, 2021 at 01:17:20PM -0400, Brian Foster wrote:
> > > @@ -1084,9 +1084,12 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
> > >  			next = bio->bi_private;
> > >  
> > >  		/* walk each page on bio, ending page IO on them */
> > > -		bio_for_each_segment_all(bv, bio, iter_all)
> > > +		bio_for_each_segment_all(bv, bio, iter_all) {
> > >  			iomap_finish_page_writeback(inode, bv->bv_page, error,
> > >  					bv->bv_len);
> > > +			if (!atomic)
> > > +				cond_resched();
> > > +		}
> > 
> > I don't know that it makes sense to check after _every_ page.  I might
> > go for every segment.  Some users check after every thousand pages.
> > 
> 
> The handful of examples I come across on a brief scan (including the
> other iomap usage) have a similar pattern as used here. I don't doubt
> there are others, but I think I'd prefer to have more reasoning behind
> adding more code than might be necessary (i.e. do we expect additional
> overhead to be measurable here?). As it is, the intent isn't so much to
> check on every page as much as this just happens to be the common point
> of the function to cover both long bio chains and single vector bios
> with large numbers of pages.

It's been a while since I waded through the macro hell to find out what
cond_resched actually does, but iirc it can do some fairly heavyweight
things (disable preemption, call the scheduler, rcu stuff) which is why
we're supposed to be a little judicious about amortizing each call over
a few thousand pages.

--D

> Brian
> 
