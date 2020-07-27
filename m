Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6397322F931
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 21:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgG0TiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 15:38:17 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:43836 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0TiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:38:17 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id D7F071A40175; Mon, 27 Jul 2020 12:38:16 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:38:16 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [QUESTION] Sharing a `struct page` across multiple `struct
 address_space` instances
Message-ID: <20200727193816.cialb45mbf6okkba@shells.gnugeneration.com>
References: <20200725002221.dszdahfhqrbz43cz@shells.gnugeneration.com>
 <20200725031158.GD23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725031158.GD23808@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 25, 2020 at 04:11:58AM +0100, Matthew Wilcox wrote:
> On Fri, Jul 24, 2020 at 05:22:21PM -0700, Vito Caputo wrote:
> > Prior to looking at the code, conceptually I was envisioning the pages
> > in the reflink source inode's address_space would simply get their
> > refcounts bumped as they were added to the dest inode's address_space,
> > with some CoW flag set to prevent writes.
> > 
> > But there seems to be a fundamental assumption that a `struct page`
> > would only belong to a single `struct address_space` at a time, as it
> > has single `mapping` and `index` members for reverse mapping the page
> > to its address_space.
> > 
> > Am I completely lost here or does it really look like a rather
> > invasive modification to support this feature?
> > 
> > I have vague memories of Dave Chinner mentioning work towards sharing
> > pages across address spaces in the interests of getting reflink copies
> > more competitive with overlayfs in terms of page cache utilization.
> 
> It's invasive.  Dave and I have chatted about this in the past.  I've done
> no work towards it (... a little busy right now with THPs in the page
> cache ...) but I have a design in mind.
> 
> The fundamental idea is to use the DAX support to refer to pages which
> actually belong to a separate address space.  DAX entries are effectively
> PFN entries.  So there would be a clear distinction between "I looked
> up a page which actually belongs to this address space" and "I looked
> up a page which is shared with a different address space".  My thinking
> has been that if files A and B are reflinked, both A and B would see
> DAX entries in their respective page caches.  The page would belong to
> a third address space which might be the block device's address space,
> or maybe there would be an address space per shared fragment (since
> files can share fragments that are at different offsets from each other).
> 
> There are a lot of details to get right around this approach.
> Importantly, there _shouldn't_ be a refcount from each of file A and
> B on the page.  Instead the refcount from files A and B should be on
> the fragment.  When the fragment's refcount goes to zero, we know there
> are no more references to the fragment and all its pages can be freed.
> 
> That means that if we reflink B to C, we don't have to walk every page
> in the file and increase its refcount again.
> 
> So, are you prepared to do a lot of work, or were you thinking this
> would be a quick hack?  Because I'm willing to advise on a big project,
> but if you're thinking this will be quick, and don't have time for a
> big project, it's probably time to stop here.
> 

Thanks for the thoughtful response.  For the time being I'll just poke
at the code and familiarize myself with how DAX works.  If it gets to
where I'm effectively spending full-time on it anyways and feeling
determined to run it to ground, I'll reach out.

> ---
> 
> Something that did occur to me while writing this is that if you just want
> read-only duplicates of files to work, you could make inode->i_mapping
> point to a different address_space instead of &inode->i_data.  There's
> probabyl a quick hack solution there.

I wonder if it's worth implementing something like this to at least
get reflink enabled with file-granular CoW on tmpfs, then iterate from
there to make things more granular.

Regards,
Vito Caputo
