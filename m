Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5537427C73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfEWMKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 08:10:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:60136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbfEWMKK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 08:10:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9B79AF3E;
        Thu, 23 May 2019 12:10:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 62FA31E3C4B; Thu, 23 May 2019 14:10:08 +0200 (CEST)
Date:   Thu, 23 May 2019 14:10:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        dsterba@suse.cz, nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 08/18] dax: memcpy page in case of IOMAP_DAX_COW for mmap
 faults
Message-ID: <20190523121008.GA2949@quack2.suse.cz>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-9-rgoldwyn@suse.de>
 <20190521174625.GF5125@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521174625.GF5125@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-05-19 10:46:25, Darrick J. Wong wrote:
> On Mon, Apr 29, 2019 at 12:26:39PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Change dax_iomap_pfn to return the address as well in order to
> > use it for performing a memcpy in case the type is IOMAP_DAX_COW.
> > We don't handle PMD because btrfs does not support hugepages.
> > 
> > Question:
> > The sequence of bdev_dax_pgoff() and dax_direct_access() is
> > used multiple times to calculate address and pfn's. Would it make
> > sense to call it while calculating address as well to reduce code?
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/dax.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 610bfa861a28..718b1632a39d 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -984,7 +984,7 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
> >  }
> >  
> >  static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> > -			 pfn_t *pfnp)
> > +			 pfn_t *pfnp, void **addr)
> >  {
> >  	const sector_t sector = dax_iomap_sector(iomap, pos);
> >  	pgoff_t pgoff;
> > @@ -996,7 +996,7 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> >  		return rc;
> >  	id = dax_read_lock();
> >  	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> > -				   NULL, pfnp);
> > +				   addr, pfnp);
> >  	if (length < 0) {
> >  		rc = length;
> >  		goto out;
> > @@ -1286,6 +1286,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
> >  	struct inode *inode = mapping->host;
> >  	unsigned long vaddr = vmf->address;
> > +	void *addr;
> >  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
> >  	struct iomap iomap = { 0 };
> 
> Ugh, I had forgotten that fs/dax.c open-codes iomap_apply, probably
> because the actor returns vm_fault_t, not bytes copied.  I guess that
> makes it a tiny bit more complicated to pass in two (struct iomap *) to
> the iomap_begin function...

Hum, right. We could actually reimplement dax_iomap_{pte|pmd}_fault() using
iomap_apply(). We would just need to propagate error code out of our
'actor' inside the structure pointed to by 'data'. But that's doable.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
