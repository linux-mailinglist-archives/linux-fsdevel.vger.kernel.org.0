Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946C926D0F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 04:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIQCCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 22:02:40 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55792 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbgIQCCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 22:02:39 -0400
X-Greylist: delayed 1051 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:02:37 EDT
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5E7083ABA7B;
        Thu, 17 Sep 2020 11:44:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kIiyk-0000tX-TM; Thu, 17 Sep 2020 11:44:54 +1000
Date:   Thu, 17 Sep 2020 11:44:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Theodore Tso <tytso@mit.edu>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, nborisov@suse.de
Subject: Re: More filesystem need this fix (xfs: use MMAPLOCK around
 filemap_map_pages())
Message-ID: <20200917014454.GZ12131@dread.disaster.area>
References: <20200623052059.1893966-1-david@fromorbit.com>
 <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916155851.GA1572@quack2.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=WUNWIZ5YbT-iWIgRcEcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 05:58:51PM +0200, Jan Kara wrote:
> On Sat 12-09-20 09:19:11, Amir Goldstein wrote:
> > On Tue, Jun 23, 2020 at 8:21 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > From: Dave Chinner <dchinner@redhat.com>
> > >
> > > The page faultround path ->map_pages is implemented in XFS via
> > > filemap_map_pages(). This function checks that pages found in page
> > > cache lookups have not raced with truncate based invalidation by
> > > checking page->mapping is correct and page->index is within EOF.
> > >
> > > However, we've known for a long time that this is not sufficient to
> > > protect against races with invalidations done by operations that do
> > > not change EOF. e.g. hole punching and other fallocate() based
> > > direct extent manipulations. The way we protect against these
> > > races is we wrap the page fault operations in a XFS_MMAPLOCK_SHARED
> > > lock so they serialise against fallocate and truncate before calling
> > > into the filemap function that processes the fault.
> > >
> > > Do the same for XFS's ->map_pages implementation to close this
> > > potential data corruption issue.
> > >
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 7b05f8fd7b3d..4b185a907432 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1266,10 +1266,23 @@ xfs_filemap_pfn_mkwrite(
> > >         return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
> > >  }
> > >
> > > +static void
> > > +xfs_filemap_map_pages(
> > > +       struct vm_fault         *vmf,
> > > +       pgoff_t                 start_pgoff,
> > > +       pgoff_t                 end_pgoff)
> > > +{
> > > +       struct inode            *inode = file_inode(vmf->vma->vm_file);
> > > +
> > > +       xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> > > +       filemap_map_pages(vmf, start_pgoff, end_pgoff);
> > > +       xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> > > +}
> > > +
> > >  static const struct vm_operations_struct xfs_file_vm_ops = {
> > >         .fault          = xfs_filemap_fault,
> > >         .huge_fault     = xfs_filemap_huge_fault,
> > > -       .map_pages      = filemap_map_pages,
> > > +       .map_pages      = xfs_filemap_map_pages,
> > >         .page_mkwrite   = xfs_filemap_page_mkwrite,
> > >         .pfn_mkwrite    = xfs_filemap_pfn_mkwrite,
> > >  };
> > > --
> > > 2.26.2.761.g0e0b3e54be
> > >
> > 
> > It appears that ext4, f2fs, gfs2, orangefs, zonefs also need this fix
> > 
> > zonefs does not support hole punching, so it may not need to use
> > mmap_sem at all.
> 
> So I've written an ext4 fix for this but before actually posting it Nikolay
> working on btrfs fix asked why exactly is filemap_map_pages() actually a
> problem and I think he's right it actually isn't a problem. The thing is:
> filemap_map_pages() never does any page mapping or IO. It only creates PTEs
> for uptodate pages that are already in page cache.

So....

P0					p1

hole punch starts
  takes XFS_MMAPLOCK_EXCL
  truncate_pagecache_range()
    unmap_mapping_range(start, end)
      <clears ptes>
					<read fault>
					do_fault_around()
					  ->map_pages
					    filemap_map_pages()
					      page mapping valid,
					      page is up to date
					      maps PTEs
					<fault done>
    truncate_inode_pages_range()
      truncate_cleanup_page(page)
        invalidates page
      delete_from_page_cache_batch(page)
        frees page
					<pte now points to a freed page>

That doesn't seem good to me.

Sure, maybe the page hasn't been freed back to the free lists
because of elevated refcounts. But it's been released by the
filesystem and not longer in the page cache so nothing good can come
of this situation...

AFAICT, this race condition exists for the truncate case as well
as filemap_map_pages() doesn't have a "page beyond inode size" check
in it. However, exposure here is very limited in the truncate case
because truncate_setsize()->truncate_pagecache() zaps the PTEs
again after invalidating the page cache.

Either way, adding the XFS_MMAPLOCK_SHARED around
filemap_map_pages() avoids the race condition for fallocate and
truncate operations for XFS...

> As such it is a rather
> different beast compared to the fault handler from fs POV and does not need
> protection from hole punching (current serialization on page lock and
> checking of page->mapping is enough).
> That being said I agree this is subtle and the moment someone adds e.g. a
> readahead call into filemap_map_pages() we have a real problem. I'm not
> sure how to prevent this risk...

Subtle, yes. So subtle, in fact, I fail to see any reason why the
above race cannot occur as there's no obvious serialisation in the
page cache between PTE zapping and page invalidation to prevent a
fault from coming in an re-establishing the PTEs before invalidation
occurs.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
