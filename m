Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6B5BC076
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 00:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIRW5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 18:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIRW5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:57:39 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ADAF15801;
        Sun, 18 Sep 2022 15:57:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-149-49.pa.vic.optusnet.com.au [49.186.149.49])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3A6768AA12E;
        Mon, 19 Sep 2022 08:57:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oa3EB-009NqD-TU; Mon, 19 Sep 2022 08:57:31 +1000
Date:   Mon, 19 Sep 2022 08:57:31 +1000
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
Message-ID: <20220918225731.GG3600936@dread.disaster.area>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=6327a260
        a=XTRC1Ovx3SkpaCW1YxGVGA==:117 a=XTRC1Ovx3SkpaCW1YxGVGA==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
        a=Ikd4Dj_1AAAA:8 a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=JTt2V5vggUH6KL8W9poA:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:35:38PM -0700, Dan Williams wrote:
> In preparation for moving DAX pages to be 0-based rather than 1-based
> for the idle refcount, the fsdax core wants to have all mappings in a
> "zapped" state before truncate. For typical pages this happens naturally
> via unmap_mapping_range(), for DAX pages some help is needed to record
> this state in the 'struct address_space' of the inode(s) where the page
> is mapped.
> 
> That "zapped" state is recorded in DAX entries as a side effect of
> xfs_break_layouts(). Arrange for it to be called before all truncation
> events which already happens for truncate() and PUNCH_HOLE, but not
> truncate_inode_pages_final(). Arrange for xfs_break_layouts() before
> truncate_inode_pages_final().

Ugh. That's nasty and awful.



> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/xfs/xfs_file.c  |   13 +++++++++----
>  fs/xfs/xfs_inode.c |    3 ++-
>  fs/xfs/xfs_inode.h |    6 ++++--
>  fs/xfs/xfs_super.c |   22 ++++++++++++++++++++++
>  4 files changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 556e28d06788..d3ff692d5546 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -816,7 +816,8 @@ xfs_wait_dax_page(
>  int
>  xfs_break_dax_layouts(
>  	struct inode		*inode,
> -	bool			*retry)
> +	bool			*retry,
> +	int			state)
>  {
>  	struct page		*page;
>  
> @@ -827,8 +828,8 @@ xfs_break_dax_layouts(
>  		return 0;
>  
>  	*retry = true;
> -	return ___wait_var_event(page, dax_page_idle(page), TASK_INTERRUPTIBLE,
> -				 0, 0, xfs_wait_dax_page(inode));
> +	return ___wait_var_event(page, dax_page_idle(page), state, 0, 0,
> +				 xfs_wait_dax_page(inode));
>  }
>  
>  int
> @@ -839,14 +840,18 @@ xfs_break_layouts(
>  {
>  	bool			retry;
>  	int			error;
> +	int			state = TASK_INTERRUPTIBLE;
>  
>  	ASSERT(xfs_isilocked(XFS_I(inode), XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL));
>  
>  	do {
>  		retry = false;
>  		switch (reason) {
> +		case BREAK_UNMAP_FINAL:
> +			state = TASK_UNINTERRUPTIBLE;
> +			fallthrough;
>  		case BREAK_UNMAP:
> -			error = xfs_break_dax_layouts(inode, &retry);
> +			error = xfs_break_dax_layouts(inode, &retry, state);
>  			if (error || retry)
>  				break;
>  			fallthrough;
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 28493c8e9bb2..72ce1cb72736 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -3452,6 +3452,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
>  	struct xfs_inode	*ip1,
>  	struct xfs_inode	*ip2)
>  {
> +	int			state = TASK_INTERRUPTIBLE;
>  	int			error;
>  	bool			retry;
>  	struct page		*page;
> @@ -3463,7 +3464,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
>  	retry = false;
>  	/* Lock the first inode */
>  	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
> -	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
> +	error = xfs_break_dax_layouts(VFS_I(ip1), &retry, state);
>  	if (error || retry) {
>  		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
>  		if (error == 0 && retry)
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index fa780f08dc89..e4994eb6e521 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -454,11 +454,13 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
>   * layout-holder has a consistent view of the file's extent map. While
>   * BREAK_WRITE breaks can be satisfied by recalling FL_LAYOUT leases,
>   * BREAK_UNMAP breaks additionally require waiting for busy dax-pages to
> - * go idle.
> + * go idle. BREAK_UNMAP_FINAL is an uninterruptible version of
> + * BREAK_UNMAP.
>   */
>  enum layout_break_reason {
>          BREAK_WRITE,
>          BREAK_UNMAP,
> +        BREAK_UNMAP_FINAL,
>  };
>  
>  /*
> @@ -531,7 +533,7 @@ xfs_itruncate_extents(
>  }
>  
>  /* from xfs_file.c */
> -int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
> +int	xfs_break_dax_layouts(struct inode *inode, bool *retry, int state);
>  int	xfs_break_layouts(struct inode *inode, uint *iolock,
>  		enum layout_break_reason reason);
>  
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 9ac59814bbb6..ebb4a6eba3fc 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -725,6 +725,27 @@ xfs_fs_drop_inode(
>  	return generic_drop_inode(inode);
>  }
>  
> +STATIC void
> +xfs_fs_evict_inode(
> +	struct inode		*inode)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> +	long			error;
> +
> +	xfs_ilock(ip, iolock);

I'm guessing you never ran this through lockdep.

The general rule is that XFS should not take inode locks directly in
the inode eviction path because lockdep tends to throw all manner of
memory reclaim related false positives when we do this. We most
definitely don't want to be doing this for anything other than
regular files that are DAX enabled, yes?

We also don't want to arbitrarily block memory reclaim for long
periods of time waiting on an inode lock.  People seem to get very
upset when we introduce unbound latencies into the memory reclaim
path...

Indeed, what are you actually trying to serialise against here?
Nothing should have a reference to the inode, nor should anything be
able to find and take a new reference to the inode while it is being
evicted....

> +	error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP_FINAL);
> +
> +	/* The final layout break is uninterruptible */
> +	ASSERT_ALWAYS(!error);

We don't do error handling with BUG(). If xfs_break_layouts() truly
can't fail (what happens if the fs is shut down and some internal
call path now detects that and returns -EFSCORRUPTED?), theni
WARN_ON_ONCE() and continuing to tear down the inode so the system
is not immediately compromised is the appropriate action here.

> +
> +	truncate_inode_pages_final(&inode->i_data);
> +	clear_inode(inode);
> +
> +	xfs_iunlock(ip, iolock);
> +}

That all said, this really looks like a bit of a band-aid.

I can't work out why would we we ever have an actual layout lease
here that needs breaking given they are file based and active files
hold a reference to the inode. If we ever break that, then I suspect
this change will cause major problems for anyone using pNFS with XFS
as xfs_break_layouts() can end up waiting for NFS delegation
revocation. This is something we should never be doing in inode
eviction/memory reclaim.

Hence I have to ask why this lease break is being done
unconditionally for all inodes, instead of only calling
xfs_break_dax_layouts() directly on DAX enabled regular files?  I
also wonder what exciting new system deadlocks this will create
because BREAK_UNMAP_FINAL can essentially block forever waiting on
dax mappings going away. If that DAX mapping reclaim requires memory
allocations.....

/me looks deeper into the dax_layout_busy_page() stuff and realises
that both ext4 and XFS implementations of ext4_break_layouts() and
xfs_break_dax_layouts() are actually identical.

That is, filemap_invalidate_unlock() and xfs_iunlock(ip,
XFS_MMAPLOCK_EXCL) operate on exactly the same
inode->i_mapping->invalidate_lock. Hence the implementations in ext4
and XFS are both functionally identical. Further, when the inode is
in the eviction path there is no reason for needing to take that
mapping->invalidation_lock to invalidate remaining stale DAX
mappings before truncate blasts them away.

IOWs, I don't see why fixing this problem needs to add new code to
XFS or ext4 at all. The DAX mapping invalidation and waiting can be
done enitrely within truncate_inode_pages_final() (conditional on
IS_DAX()) after mapping_set_exiting() has been set with generic code
and it should not require locking at all. I also think that
ext4_break_layouts() and xfs_break_dax_layouts() should be merged
into a generic dax infrastructure function so the filesystems don't
need to care about the internal details of DAX mappings at all...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
