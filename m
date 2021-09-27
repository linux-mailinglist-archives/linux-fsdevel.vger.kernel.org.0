Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1293D418D77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 03:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhI0B1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Sep 2021 21:27:10 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:45811 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232246AbhI0B1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Sep 2021 21:27:09 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 1969EA6C1;
        Mon, 27 Sep 2021 11:25:27 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mUfOZ-00H8ch-4e; Mon, 27 Sep 2021 11:25:27 +1000
Date:   Mon, 27 Sep 2021 11:25:27 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, hch@lst.de,
        trond.myklebust@primarydata.com, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] mm: Remove swap BIO paths and only use DIO paths
Message-ID: <20210927012527.GF1756565@dread.disaster.area>
References: <YU84rYOyyXDP3wjp@casper.infradead.org>
 <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163250396319.2330363.10564506508011638258.stgit@warthog.procyon.org.uk>
 <2396106.1632584202@warthog.procyon.org.uk>
 <YU9X2o74+aZP4iWV@casper.infradead.org>
 <5fde9167-6f8b-c698-f34d-d7fafd4219f7@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fde9167-6f8b-c698-f34d-d7fafd4219f7@opensource.wdc.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=9mJ4K6JeBK9rWth2XkwA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 08:08:53AM +0900, Damien Le Moal wrote:
> On 2021/09/26 2:09, Matthew Wilcox wrote:
> > On Sat, Sep 25, 2021 at 04:36:42PM +0100, David Howells wrote:
> >> Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >>> On Fri, Sep 24, 2021 at 06:19:23PM +0100, David Howells wrote:
> >>>> Delete the BIO-generating swap read/write paths and always use ->swap_rw().
> >>>> This puts the mapping layer in the filesystem.
> >>>
> >>> Is SWP_FS_OPS now unused after this patch?
> >>
> >> Ummm.  Interesting question - it's only used in swap_set_page_dirty():
> >>
> >> int swap_set_page_dirty(struct page *page)
> >> {
> >> 	struct swap_info_struct *sis = page_swap_info(page);
> >>
> >> 	if (data_race(sis->flags & SWP_FS_OPS)) {
> >> 		struct address_space *mapping = sis->swap_file->f_mapping;
> >>
> >> 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
> >> 		return mapping->a_ops->set_page_dirty(page);
> >> 	} else {
> >> 		return __set_page_dirty_no_writeback(page);
> >> 	}
> >> }
> > 
> > I suspect that's no longer necessary.  NFS was the only filesystem
> > using SWP_FS_OPS and ...
> > 
> > fs/nfs/file.c:  .set_page_dirty = __set_page_dirty_nobuffers,
> > 
> > so it's not like NFS does anything special to reserve memory to write
> > back swap pages.
> > 
> >>> Also, do we still need ->swap_activate and ->swap_deactivate?
> >>
> >> f2fs does quite a lot of work in its ->swap_activate(), as does btrfs.  I'm
> >> not sure how necessary it is.  cifs looks like it intends to use it, but it's
> >> not fully implemented yet.  zonefs and nfs do some checking, including hole
> >> checking in nfs's case.  nfs also does some setting up for the sunrpc
> >> transport.
> >>
> >> btrfs, cifs, f2fs and nfs all supply ->swap_deactivate() to undo the effects
> >> of the activation.
> > 
> > Right ... so my question really is, now that we're doing I/O through
> > aops->direct_IO (or ->swap_rw), do those magic things need to be done?
> > After all, open(O_DIRECT) doesn't do these same magic things.  They're
> > really there to allow the direct-to-BIO path to work, and you're removing
> > that here.
> 
> For zonefs, ->swap_activate() checks that the user is not trying to use a
> sequential write only file for swap. Swap cannot work on these files as there
> are no guarantees that the writes will be sequential.

iomap_swapfile_activate() is used by ext4, XFS and zonefs. It checks
there are no holes in the file, no shared extents, no inline
extents, the swap info block device matches the block device the
extent is mapped to (i.e. filesystems can have more than one bdev,
swapfile only supports files on sb->s_bdev), etc.

Also, I noticed, iomap_swapfile_add_extent() filters out extents
that are smaller than PAGE_SIZE, and aligns larger extents to
PAGE_SIZE. This allows ensures that when fs block size != PAGE_SIZE
that only a single IO per page being swapped is required. i.e. the
DIO path may change the "one page, one bio, one IO" behaviour that
the current swapfile mapping guarantees.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
