Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443B45BD65D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiISVaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 17:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiISVaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:30:05 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3491B23151;
        Mon, 19 Sep 2022 14:30:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-183-60.pa.nsw.optusnet.com.au [49.180.183.60])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A5ABA110098A;
        Tue, 20 Sep 2022 07:30:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oaOL1-009kv2-DN; Tue, 20 Sep 2022 07:29:59 +1000
Date:   Tue, 20 Sep 2022 07:29:59 +1000
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
Message-ID: <20220919212959.GL3600936@dread.disaster.area>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6328df5a
        a=mj5ET7k2jFntY++HerHxfg==:117 a=mj5ET7k2jFntY++HerHxfg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=xuJ1WRtAoSBjHkJDGakA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:11:48AM -0700, Dan Williams wrote:
> Dave Chinner wrote:
> > On Thu, Sep 15, 2022 at 08:35:38PM -0700, Dan Williams wrote:
> > > In preparation for moving DAX pages to be 0-based rather than 1-based
> > > for the idle refcount, the fsdax core wants to have all mappings in a
> > > "zapped" state before truncate. For typical pages this happens naturally
> > > via unmap_mapping_range(), for DAX pages some help is needed to record
> > > this state in the 'struct address_space' of the inode(s) where the page
> > > is mapped.
> > > 
> > > That "zapped" state is recorded in DAX entries as a side effect of
> > > xfs_break_layouts(). Arrange for it to be called before all truncation
> > > events which already happens for truncate() and PUNCH_HOLE, but not
> > > truncate_inode_pages_final(). Arrange for xfs_break_layouts() before
> > > truncate_inode_pages_final().
....
> > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > index 9ac59814bbb6..ebb4a6eba3fc 100644
> > > --- a/fs/xfs/xfs_super.c
> > > +++ b/fs/xfs/xfs_super.c
> > > @@ -725,6 +725,27 @@ xfs_fs_drop_inode(
> > >  	return generic_drop_inode(inode);
> > >  }
> > >  
> > > +STATIC void
> > > +xfs_fs_evict_inode(
> > > +	struct inode		*inode)
> > > +{
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > +	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> > > +	long			error;
> > > +
> > > +	xfs_ilock(ip, iolock);
> > 
> > I'm guessing you never ran this through lockdep.
> 
> I always run with lockdep enabled in my development kernels, but maybe my
> testing was insufficient? Somewhat moot with your concerns below...

I'm guessing your testing doesn't generate inode cache pressure and
then have direct memory reclaim inodes. e.g. on a directory inode
this will trigger lockdep immediately because readdir locks with
XFS_IOLOCK_SHARED and then does GFP_KERNEL memory reclaim. If we try
to take XFS_IOLOCK_EXCL from memory reclaim of directory inodes,
lockdep will then shout from the rooftops...

> > > +
> > > +	truncate_inode_pages_final(&inode->i_data);
> > > +	clear_inode(inode);
> > > +
> > > +	xfs_iunlock(ip, iolock);
> > > +}
> > 
> > That all said, this really looks like a bit of a band-aid.
> 
> It definitely is since DAX is in this transitory state between doing
> some activities page-less and others with page metadata. If DAX was
> fully committed to behaving like a typical page then
> unmap_mapping_range() would have already satisfied this reference
> counting situation.
> 
> > I can't work out why would we we ever have an actual layout lease
> > here that needs breaking given they are file based and active files
> > hold a reference to the inode. If we ever break that, then I suspect
> > this change will cause major problems for anyone using pNFS with XFS
> > as xfs_break_layouts() can end up waiting for NFS delegation
> > revocation. This is something we should never be doing in inode
> > eviction/memory reclaim.
> > 
> > Hence I have to ask why this lease break is being done
> > unconditionally for all inodes, instead of only calling
> > xfs_break_dax_layouts() directly on DAX enabled regular files?  I
> > also wonder what exciting new system deadlocks this will create
> > because BREAK_UNMAP_FINAL can essentially block forever waiting on
> > dax mappings going away. If that DAX mapping reclaim requires memory
> > allocations.....
> 
> There should be no memory allocations in the DAX mapping reclaim path.
> Also, the page pins it waits for are precluded from being GUP_LONGTERM.

So if the task that holds the pin needs memory allocation before it
can unpin the page to allow direct inode reclaim to make progress?

> > /me looks deeper into the dax_layout_busy_page() stuff and realises
> > that both ext4 and XFS implementations of ext4_break_layouts() and
> > xfs_break_dax_layouts() are actually identical.
> > 
> > That is, filemap_invalidate_unlock() and xfs_iunlock(ip,
> > XFS_MMAPLOCK_EXCL) operate on exactly the same
> > inode->i_mapping->invalidate_lock. Hence the implementations in ext4
> > and XFS are both functionally identical.
> 
> I assume you mean for the purposes of this "final" break since
> xfs_file_allocate() holds XFS_IOLOCK_EXCL over xfs_break_layouts().

No, I'm just looking at the two *dax* functions - we don't care what
locks xfs_break_layouts() requires - dax mapping manipulation is
covered by the mapping->invalidate_lock and not the inode->i_rwsem.
This is explicitly documented in the code by the the asserts in both
ext4_break_layouts() and xfs_break_dax_layouts().

XFS holds the inode->i_rwsem over xfs_break_layouts() because we
have to break *file layout leases* from there, too. These are
serialised by the inode->i_rwsem, not the mapping->invalidate_lock.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
