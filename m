Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5B26CDAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIPVDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 17:03:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:60120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgIPQPB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A9E7AF72;
        Wed, 16 Sep 2020 15:59:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 402041E12E1; Wed, 16 Sep 2020 17:58:51 +0200 (CEST)
Date:   Wed, 16 Sep 2020 17:58:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20200916155851.GA1572@quack2.suse.cz>
References: <20200623052059.1893966-1-david@fromorbit.com>
 <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 12-09-20 09:19:11, Amir Goldstein wrote:
> On Tue, Jun 23, 2020 at 8:21 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > The page faultround path ->map_pages is implemented in XFS via
> > filemap_map_pages(). This function checks that pages found in page
> > cache lookups have not raced with truncate based invalidation by
> > checking page->mapping is correct and page->index is within EOF.
> >
> > However, we've known for a long time that this is not sufficient to
> > protect against races with invalidations done by operations that do
> > not change EOF. e.g. hole punching and other fallocate() based
> > direct extent manipulations. The way we protect against these
> > races is we wrap the page fault operations in a XFS_MMAPLOCK_SHARED
> > lock so they serialise against fallocate and truncate before calling
> > into the filemap function that processes the fault.
> >
> > Do the same for XFS's ->map_pages implementation to close this
> > potential data corruption issue.
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  fs/xfs/xfs_file.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 7b05f8fd7b3d..4b185a907432 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1266,10 +1266,23 @@ xfs_filemap_pfn_mkwrite(
> >         return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
> >  }
> >
> > +static void
> > +xfs_filemap_map_pages(
> > +       struct vm_fault         *vmf,
> > +       pgoff_t                 start_pgoff,
> > +       pgoff_t                 end_pgoff)
> > +{
> > +       struct inode            *inode = file_inode(vmf->vma->vm_file);
> > +
> > +       xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> > +       filemap_map_pages(vmf, start_pgoff, end_pgoff);
> > +       xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> > +}
> > +
> >  static const struct vm_operations_struct xfs_file_vm_ops = {
> >         .fault          = xfs_filemap_fault,
> >         .huge_fault     = xfs_filemap_huge_fault,
> > -       .map_pages      = filemap_map_pages,
> > +       .map_pages      = xfs_filemap_map_pages,
> >         .page_mkwrite   = xfs_filemap_page_mkwrite,
> >         .pfn_mkwrite    = xfs_filemap_pfn_mkwrite,
> >  };
> > --
> > 2.26.2.761.g0e0b3e54be
> >
> 
> It appears that ext4, f2fs, gfs2, orangefs, zonefs also need this fix
> 
> zonefs does not support hole punching, so it may not need to use
> mmap_sem at all.

So I've written an ext4 fix for this but before actually posting it Nikolay
working on btrfs fix asked why exactly is filemap_map_pages() actually a
problem and I think he's right it actually isn't a problem. The thing is:
filemap_map_pages() never does any page mapping or IO. It only creates PTEs
for uptodate pages that are already in page cache. As such it is a rather
different beast compared to the fault handler from fs POV and does not need
protection from hole punching (current serialization on page lock and
checking of page->mapping is enough).

That being said I agree this is subtle and the moment someone adds e.g. a
readahead call into filemap_map_pages() we have a real problem. I'm not
sure how to prevent this risk...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
