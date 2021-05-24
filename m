Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E938F1CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhEXQyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 12:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233244AbhEXQye (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 12:54:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21E9B61405;
        Mon, 24 May 2021 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621875186;
        bh=eatiY2VwYI6jMYMQPjWcFVSnWA1ru41S8Ad5ObeDT+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIN8bW+P2zkyyLXx7bxzWELDzPupPeVmdVLq+f3dCwuE8QZQqXtrAvQRg1KUzNXP5
         Q1/5uER24+vhIpVNboCToHB0aVHAnUs3n/8/k4GZq/XKrajlFzLhx+IGUcrELQQCLl
         QTBjJxpZmDKbGMoIZOYgBioj+svfd4EjHRGepxpR74EKoztAYFBbnTH830ngHjqzVv
         StijQ+QAzyhcv6G1ty69qpf59gVuSOLAOGSU76MzGSdu/6e0tEXVQk3Isc5cYqUtSO
         lw5ULSnErQf/w7k6Fqj+cPDghppnblPE/z9caO8uIj83/odQ/tCR5vtlGXJHgj/s1a
         6PFQVK6+bSNjw==
Date:   Mon, 24 May 2021 09:53:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iomap: resched ioend completion when in
 non-atomic context
Message-ID: <20210524165305.GA202078@locust>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-2-bfoster@redhat.com>
 <YKKt2isZwu0qJK/C@casper.infradead.org>
 <YKOnGSJ9NR+cSRRc@bfoster>
 <20210520215858.GZ9675@magnolia>
 <YKuUqzEmt5/yZMt1@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKuUqzEmt5/yZMt1@bfoster>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 07:57:31AM -0400, Brian Foster wrote:
> On Thu, May 20, 2021 at 02:58:58PM -0700, Darrick J. Wong wrote:
> > On Tue, May 18, 2021 at 07:38:01AM -0400, Brian Foster wrote:
> > > On Mon, May 17, 2021 at 06:54:34PM +0100, Matthew Wilcox wrote:
> > > > On Mon, May 17, 2021 at 01:17:20PM -0400, Brian Foster wrote:
> > > > > @@ -1084,9 +1084,12 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
> > > > >  			next = bio->bi_private;
> > > > >  
> > > > >  		/* walk each page on bio, ending page IO on them */
> > > > > -		bio_for_each_segment_all(bv, bio, iter_all)
> > > > > +		bio_for_each_segment_all(bv, bio, iter_all) {
> > > > >  			iomap_finish_page_writeback(inode, bv->bv_page, error,
> > > > >  					bv->bv_len);
> > > > > +			if (!atomic)
> > > > > +				cond_resched();
> > > > > +		}
> > > > 
> > > > I don't know that it makes sense to check after _every_ page.  I might
> > > > go for every segment.  Some users check after every thousand pages.
> > > > 
> > > 
> > > The handful of examples I come across on a brief scan (including the
> > > other iomap usage) have a similar pattern as used here. I don't doubt
> > > there are others, but I think I'd prefer to have more reasoning behind
> > > adding more code than might be necessary (i.e. do we expect additional
> > > overhead to be measurable here?). As it is, the intent isn't so much to
> > > check on every page as much as this just happens to be the common point
> > > of the function to cover both long bio chains and single vector bios
> > > with large numbers of pages.
> > 
> > It's been a while since I waded through the macro hell to find out what
> > cond_resched actually does, but iirc it can do some fairly heavyweight
> > things (disable preemption, call the scheduler, rcu stuff) which is why
> > we're supposed to be a little judicious about amortizing each call over
> > a few thousand pages.
> > 
> 
> It looks to me it just checks some state bit and only does any work if
> actually necessary. I suppose not doing that less often is cheaper than
> doing it more, but it's not clear to me it's enough that it really
> matters and/or warrants more code to filter out calls..
> 
> What exactly did you have in mind for logic? I suppose we could always
> stuff a 'if (!(count++ % 1024)) cond_resched();' or some such in the
> inner loop, but that might have less of an effect on larger chains
> constructed of bios with fewer pages (depending on whether that might
> still be possible).

I /was/ thinking about a function level page counter until I noticed
that iomap_{write,unshare}_actor call cond_resched for every page it
touches.  I withdraw the comment. :)

--D

> 
> Brian
> 
> > --D
> > 
> > > Brian
> > > 
> > 
> 
