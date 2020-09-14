Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78076268A35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 13:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgINLhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 07:37:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgINLfV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:35:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 350BAB10B;
        Mon, 14 Sep 2020 11:35:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ED0131E12EF; Mon, 14 Sep 2020 13:35:16 +0200 (CEST)
Date:   Mon, 14 Sep 2020 13:35:16 +0200
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
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: More filesystem need this fix (xfs: use MMAPLOCK around
 filemap_map_pages())
Message-ID: <20200914113516.GE4863@quack2.suse.cz>
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
> 
> It is interesting to look at how this bug came to be duplicated in so
> many filesystems, because there are lessons to be learned.
> 
> Commit f1820361f83d ("mm: implement ->map_pages for page cache")
> added to ->map_pages() operation and its commit message said:
> 
> "...It should be safe to use filemap_map_pages() for ->map_pages() if
>     filesystem use filemap_fault() for ->fault()."
> 
> At the time, all of the aforementioned filesystems used filemap_fault()
> for ->fault().
> 
> But since then, ext4, xfs, f2fs and just recently gfs2 have added a
> filesystem ->fault() operation.
> 
> orangefs has added vm_operations since and zonefs was added since,
> probably copying the mmap_sem handling from ext4. Both have a filesystem
> ->fault() operation.

A standard pattern of copying bug from one place into many. Sadly it's
happening all the time for stuff that's complex enough that only a few
people (if anybody) are carrying all the details in their head.

> It was surprising for me to see that some of the filesystem developers
> signed on the added ->fault() operations are not strangers to mm. The
> recent gfs2 change was even reviewed by an established mm developer
> [1].

Well, people do miss things... And this stuff is twisted maze so it is easy
to miss something even for an experienced developer.

> So what can we learn from this case study? How could we fix the interface to
> avoid repeating the same mistake in the future?

IMO the serialization between page cache and various fs operations is just
too complex with too many special corner cases. But that's difficult to
change while keeping all the features and performance. So the best
realistic answer I have (and this is not meant to discourage anybody from
trying to implement a simpler scheme of page-cache - filesystem interaction
:) is that we should have added a fstest when XFS fix landed which would
then hopefully catch attention of other fs maintainers (at least those that
do run fstest).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
