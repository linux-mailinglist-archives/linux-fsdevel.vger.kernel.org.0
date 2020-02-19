Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9A163C6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 06:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgBSFWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 00:22:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgBSFWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 00:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v3wjYvTxIvyqdBjcTZbZ6V6XXTZeeNXrItglyOMcggo=; b=Auyp6lhSbAEYNk7jcncbMkY0Ws
        XinG1c/KH2WIappKRapF9o4axpn9L8oQskBlHlBLw9XQ0nXbJnkDsqfh2SkyzmQK0YhzpKp/QBFO0
        bpEGyHFQ+YA3qxJU00WEU/tiwjkGuEnVYcW0g3zXVubgFDKWaDvoJvN6VkjVPrCo/uQ+QP9jf8QO3
        9qiXCqAzx7Awla3qaJlBefBlwM8EQeYBIUB12k8qt69YC/AIm0vwjb3K/41acVQTK6Lg81YYNgtrt
        gWZkFfEHpJDHCeifbBhNb09jKli8nY0l/0Vau09mO9a0Cb/TiGxAZcwsAaM0Zi6C3GyPPjl+GKcMg
        Evj5uHjQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Hoc-0008Pr-3p; Wed, 19 Feb 2020 05:22:30 +0000
Date:   Tue, 18 Feb 2020 21:22:30 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v6 19/19] mm: Use memalloc_nofs_save in readahead path
Message-ID: <20200219052230.GM24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-33-willy@infradead.org>
 <20200219034324.GG10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219034324.GG10776@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 02:43:24PM +1100, Dave Chinner wrote:
> On Mon, Feb 17, 2020 at 10:46:13AM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Ensure that memory allocations in the readahead path do not attempt to
> > reclaim file-backed pages, which could lead to a deadlock.  It is
> > possible, though unlikely this is the root cause of a problem observed
> > by Cong Wang.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/readahead.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 94d499cfb657..8f9c0dba24e7 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/mm_inline.h>
> >  #include <linux/blk-cgroup.h>
> >  #include <linux/fadvise.h>
> > +#include <linux/sched/mm.h>
> >  
> >  #include "internal.h"
> >  
> > @@ -174,6 +175,18 @@ void page_cache_readahead_limit(struct address_space *mapping,
> >  		._nr_pages = 0,
> >  	};
> >  
> > +	/*
> > +	 * Partway through the readahead operation, we will have added
> > +	 * locked pages to the page cache, but will not yet have submitted
> > +	 * them for I/O.  Adding another page may need to allocate memory,
> > +	 * which can trigger memory reclaim.  Telling the VM we're in
> > +	 * the middle of a filesystem operation will cause it to not
> > +	 * touch file-backed pages, preventing a deadlock.  Most (all?)
> > +	 * filesystems already specify __GFP_NOFS in their mapping's
> > +	 * gfp_mask, but let's be explicit here.
> > +	 */
> > +	unsigned int nofs = memalloc_nofs_save();
> > +
> 
> So doesn't this largely remove the need for all the gfp flag futzing
> in the readahead path? i.e. almost all readahead allocations are now
> going to be GFP_NOFS | GFP_NORETRY | GFP_NOWARN ?

I don't think it ensures the GFP_NORETRY | GFP_NOWARN, just the GFP_NOFS
part.  IOW, we'll still need a readahead_gfp() macro at some point ... I
don't want to add that to this already large series though.

Michal also wants to kill mapping->gfp_mask, btw.
