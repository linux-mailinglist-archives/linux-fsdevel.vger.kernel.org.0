Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8F1FDA47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 02:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFRAew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 20:34:52 -0400
Received: from [211.29.132.42] ([211.29.132.42]:35218 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbgFRAew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:34:52 -0400
Received: from dread.disaster.area (unknown [49.180.124.177])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 54D5C5AE81A;
        Thu, 18 Jun 2020 10:34:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jliVf-0001VT-H7; Thu, 18 Jun 2020 10:34:27 +1000
Date:   Thu, 18 Jun 2020 10:34:27 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in
 ->writepages
Message-ID: <20200618003427.GZ2040@dread.disaster.area>
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <20200616081628.GC9499@dhcp22.suse.cz>
 <CALOAHbDsCB1yZE6m96xiX1KiUWJW-8Hn0eqGcuEipkf9R6_L2A@mail.gmail.com>
 <20200616092727.GD9499@dhcp22.suse.cz>
 <CALOAHbD8x3sULHpGe=t58cBU2u1vuqrBRtAB3-+oR7TQNwOxwg@mail.gmail.com>
 <20200616104806.GE9499@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616104806.GE9499@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=RKaNVZAroByeIuNqgEYA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 12:48:06PM +0200, Michal Hocko wrote:
> On Tue 16-06-20 17:39:33, Yafang Shao wrote:
> > The history is complicated, but it doesn't matter.
> > Let's  turn back to the upstream kernel now. As I explained in the commit log,
> > xfs_vm_writepages
> >   -> iomap_writepages.
> >      -> write_cache_pages
> >         -> lock_page <<<< This page is locked.
> >         -> writepages ( which is  iomap_do_writepage)
> >            -> xfs_map_blocks
> >               -> xfs_convert_blocks
> >                  -> xfs_bmapi_convert_delalloc
> >                     -> xfs_trans_alloc
> >                          -> kmem_zone_zalloc //It should alloc page
> > with GFP_NOFS
> > 
> > If GFP_NOFS isn't set in xfs_trans_alloc(), the kmem_zone_zalloc() may
> > trigger the memory reclaim then it may wait on the page locked in
> > write_cache_pages() ...
> 
> This cannot happen because the memory reclaim backs off on locked pages.

->writepages can hold a bio with multiple PageWriteback pages
already attached to it. Direct GFP_KERNEL page reclaim can wait on
them - if that happens the the bio will never be issued and so
reclaim will deadlock waiting for the writeback state to clear...

> > That means the ->writepages should be set with GFP_NOFS to avoid this
> > recursive filesystem reclaim.

Indeed. We already have parts of the IO submission path under
PF_MEMALLOC_NOFS so we can do transaction allocation, etc. See
xfs_prepare_ioend(), which is called from iomap via:

iomap_submit_ioend()
  ->prepare_ioend()
    xfs_prepare_ioend()

we can get there from:

iomap_writepage()
  iomap_do_writepage()
    iomap_writepage_map()
      iomap_submit_ioend()
  iomap_submit_ioend()

and:

iomap_writepages()
  write_cache_pages()
    iomap_do_writepage()
      iomap_writepage_map()
	iomap_submit_ioend()
  iomap_submit_ioend()

Which says that we really should be putting both iomap_writepage()
and iomap_writepages() under PF_MEMALLOC_NOFS context so that
filesystem callouts don't have to repeatedly enter and exit
PF_MEMALLOC_NOFS context to avoid memory reclaim recursion...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
