Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22256248
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 08:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfFZGWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 02:22:21 -0400
Received: from verein.lst.de ([213.95.11.211]:40468 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZGWV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:22:21 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E1E1E68B05; Wed, 26 Jun 2019 08:21:48 +0200 (CEST)
Date:   Wed, 26 Jun 2019 08:21:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, david@fromorbit.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190626062148.GB23972@lst.de>
References: <20190621192828.28900-1-rgoldwyn@suse.de> <20190621192828.28900-2-rgoldwyn@suse.de> <20190622004624.GC1611011@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622004624.GC1611011@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:46:24PM -0700, Darrick J. Wong wrote:
> On Fri, Jun 21, 2019 at 02:28:23PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Introduces a new type IOMAP_COW, which means the data at offset
> > must be read from a srcmap and copied before performing the
> > write on the offset.
> > 
> > The srcmap is used to identify where the read is to be performed
> > from. This is passed to iomap->begin(), which is supposed to
> > put in the details for reading, typically set with type IOMAP_READ.
> 
> What is IOMAP_READ ?

The lack of flags.  Which reminds me that our IOMAP_* types have
pretty much gotten out of hand in how we use some flags that really
are different types vs others that are modifiers.  We'll need to clean
this up a bit eventually.

> 
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/dax.c              |  8 +++++---
> >  fs/ext2/inode.c       |  2 +-
> >  fs/ext4/inode.c       |  2 +-
> >  fs/gfs2/bmap.c        |  3 ++-
> >  fs/internal.h         |  2 +-
> >  fs/iomap.c            | 31 ++++++++++++++++---------------
> >  fs/xfs/xfs_iomap.c    |  9 ++++++---
> >  include/linux/iomap.h |  4 +++-
> >  8 files changed, 35 insertions(+), 26 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 2e48c7ebb973..80b9e2599223 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1078,7 +1078,7 @@ EXPORT_SYMBOL_GPL(__dax_zero_page_range);
> >  
> >  static loff_t
> >  dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > -		struct iomap *iomap)
> > +		struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct block_device *bdev = iomap->bdev;
> >  	struct dax_device *dax_dev = iomap->dax_dev;
> > @@ -1236,6 +1236,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	unsigned long vaddr = vmf->address;
> >  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
> >  	struct iomap iomap = { 0 };
> > +	struct iomap srcmap = { 0 };
> >  	unsigned flags = IOMAP_FAULT;
> >  	int error, major = 0;
> >  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > @@ -1280,7 +1281,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	 * the file system block size to be equal the page size, which means
> >  	 * that we never have to deal with more than a single extent here.
> >  	 */
> > -	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap);
> > +	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap, &srcmap);
> >  	if (iomap_errp)
> >  		*iomap_errp = error;
> >  	if (error) {
> > @@ -1460,6 +1461,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	struct inode *inode = mapping->host;
> >  	vm_fault_t result = VM_FAULT_FALLBACK;
> >  	struct iomap iomap = { 0 };
> > +	struct iomap srcmap = { 0 };
> >  	pgoff_t max_pgoff;
> >  	void *entry;
> >  	loff_t pos;
> > @@ -1534,7 +1536,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	 * to look up our filesystem block.
> >  	 */
> >  	pos = (loff_t)xas.xa_index << PAGE_SHIFT;
> > -	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap);
> > +	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap, &srcmap);
> 
> Line too long?
> 
> Also, I guess the DAX and directio write paths will just WARN_ON_ONCE if
> someone feeds them an IOMAP_COW type iomap?
> 
> Ah, right, I guess the only filesystems that use iomap directio and
> iomap dax don't support COW. :)

?  XFS does iomap based cow for direct I/O.  But we don't use IOMAP_COW
yey with this series as far as I can tell.
