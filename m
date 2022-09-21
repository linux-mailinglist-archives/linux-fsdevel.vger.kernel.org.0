Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E235E5627
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiIUWOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 18:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiIUWOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:14:22 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21C81A74FE;
        Wed, 21 Sep 2022 15:14:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8CFEF11009AD;
        Thu, 22 Sep 2022 08:14:17 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ob7yy-00AYcI-1G; Thu, 22 Sep 2022 08:14:16 +1000
Date:   Thu, 22 Sep 2022 08:14:16 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <20220921221416.GT3600936@dread.disaster.area>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=632b8cbc
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=kcSw2F0C3OlGkMnRgwgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:44:52AM -0700, Dan Williams wrote:
> Dave Chinner wrote:
> > On Mon, Sep 19, 2022 at 09:11:48AM -0700, Dan Williams wrote:
> > > Dave Chinner wrote:
> > > > That all said, this really looks like a bit of a band-aid.
> > > 
> > > It definitely is since DAX is in this transitory state between doing
> > > some activities page-less and others with page metadata. If DAX was
> > > fully committed to behaving like a typical page then
> > > unmap_mapping_range() would have already satisfied this reference
> > > counting situation.
> > > 
> > > > I can't work out why would we we ever have an actual layout lease
> > > > here that needs breaking given they are file based and active files
> > > > hold a reference to the inode. If we ever break that, then I suspect
> > > > this change will cause major problems for anyone using pNFS with XFS
> > > > as xfs_break_layouts() can end up waiting for NFS delegation
> > > > revocation. This is something we should never be doing in inode
> > > > eviction/memory reclaim.
> > > > 
> > > > Hence I have to ask why this lease break is being done
> > > > unconditionally for all inodes, instead of only calling
> > > > xfs_break_dax_layouts() directly on DAX enabled regular files?  I
> > > > also wonder what exciting new system deadlocks this will create
> > > > because BREAK_UNMAP_FINAL can essentially block forever waiting on
> > > > dax mappings going away. If that DAX mapping reclaim requires memory
> > > > allocations.....
> > > 
> > > There should be no memory allocations in the DAX mapping reclaim path.
> > > Also, the page pins it waits for are precluded from being GUP_LONGTERM.
> > 
> > So if the task that holds the pin needs memory allocation before it
> > can unpin the page to allow direct inode reclaim to make progress?
> 
> No, it couldn't, and I realize now that GUP_LONGTERM has nothing to do
> with this hang since any GFP_KERNEL in a path that took a DAX page pin
> path could run afoul of this need to wait.
> 
> So, this has me looking at invalidate_inodes() and iput_final(), where I
> did not see the reclaim entanglement, and thinking DAX has the unique
> requirement to make sure that no access to a page outlives the hosting
> inode.
> 
> Not that I need to tell you, but to get my own thinking straight,
> compare that to typical page cache as the pinner can keep a pinned
> page-cache page as long as it wants even after it has been truncated.

Right, because the page pin prevents the page from being freed
after the page references the page cache keeps have been released.

But page cache page != DAX page. The DAX page is a direct reference
to the storage media, not a generic reference counted kernel page
that the kernel will keep alive as long as there is a reference to
it.

Hence for a DAX page, we have to revoke all access to the page
before the controlling owner context is torn down, otherwise we have
a use-after-free scenario at the storage media level. For a FSDAX
file data page, that owner context is the inode...

> DAX needs to make sure that truncate_inode_pages() ceases all access to
> the page synchronous with the truncate.

Yes, exactly.

>
> The typical page-cache will
> ensure that the next mapping of the file will get a new page if the page
> previously pinned for that offset is still in use, DAX can not offer
> that as the same page that was previously pinned is always used.

Yes, because the new DAX ipage lookup will return the original page
in the storage media, not a newly instantiated page cache page.

> So I think this means something like this:
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 6462276dfdf0..ab16772b9a8d 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -784,6 +784,11 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
>                         continue;
>                 }
>  
> +               if (dax_inode_busy(inode)) {
> +                       busy = 1;
> +                       continue;
> +               }

That this does more than a check (i.e. it runs whatever
dax_zap_pages() does) means it cannot be run under the inode
spinlock.

As this is called from the block device code when a bdev is being
removed (i.e. will only find a superblock and inodes to invalidate
on hot-unplug), shouldn't this DAX mapping invalidation actually be
handled by the pmem failure notification infrastructure we've just
added for reflink?

> +
>                 inode->i_state |= I_FREEING;
>                 inode_lru_list_del(inode);
>                 spin_unlock(&inode->i_lock);
> @@ -1733,6 +1738,8 @@ static void iput_final(struct inode *inode)
>                 spin_unlock(&inode->i_lock);
>  
>                 write_inode_now(inode, 1);
> +               if (IS_DAX(inode))
> +                       dax_break_layouts(inode);
>  
>                 spin_lock(&inode->i_lock);
>                 state = inode->i_state;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9eced4cc286e..e4a74ab310b5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3028,8 +3028,20 @@ extern struct inode * igrab(struct inode *);
>  extern ino_t iunique(struct super_block *, ino_t);
>  extern int inode_needs_sync(struct inode *inode);
>  extern int generic_delete_inode(struct inode *inode);
> +
> +static inline bool dax_inode_busy(struct inode *inode)
> +{
> +       if (!IS_DAX(inode))
> +               return false;
> +
> +       return dax_zap_pages(inode) != NULL;
> +}
> +
>  static inline int generic_drop_inode(struct inode *inode)
>  {
> +       if (dax_inode_busy(inode))
> +               return 0;
> +
>         return !inode->i_nlink || inode_unhashed(inode);
>  }

I don't think that's valid. This can result in unreferenced unlinked
inodes that should be torn down immediately being placed in the LRU
and cached in memory and potentially not processed until there is
future memory pressure or an unmount....

i.e. dropping the final reference on an unlinked inode needs to
reclaim the inode immediately and allow the filesystem to free the
inode, regardless of any other factor. Nothing should have an active
reference to the inode or inode related data/metadata at this point
in time.

Honestly, this still seems like a band-aid because it doesn't appear
to address that something has pinned the storage media without
having an active reference to the object that arbitrates access to
that storage media (i.e. the inode and, by proxy, then filesystem).
Where are these DAX page pins that don't require the pin holder to
also hold active references to the filesystem objects coming from?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
