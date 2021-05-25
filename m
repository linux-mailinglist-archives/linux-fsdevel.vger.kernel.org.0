Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA32390C0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhEYWTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232514AbhEYWTW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:19:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A761613D2;
        Tue, 25 May 2021 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621981072;
        bh=WDYe4wXn7eUjM5C32cO832fX/btSTLyy60ptnCxqzQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGZHuBwgpzurmbJAYffUKSaOQ8RQO9M9+ITG5+loT417RjO/uIWiVwgS8e3nOvNkE
         K0VVTlOLv7U1vW/N1nx+jD6EG5z7SiT5RW3rru8syZ5V4rv8xLfQctczLfzZSWpmtn
         zpJ8cvXmqJSBtIMGoXJZm9zO8+4acewGi1eATIiR7HFP28Q9UHKp3PKI4YWcR/ZeAp
         sznb7kwf9LP7svUMv/DhxjaidgRdi0N1R3VG95ygGeqJTJQmVtdF4NoE33teJ9SKlV
         G4/gwYc3YHU0spOfFcKJBJrEDZsVv9hnM7tSM8g8SBlbmxKFtGeqWOf+vL0aE2olWh
         aWvmik33uAVPw==
Date:   Tue, 25 May 2021 15:17:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Message-ID: <20210525221751.GQ202121@locust>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-4-ruansy.fnst@fujitsu.com>
 <20210512011738.GT8582@magnolia>
 <OSBPR01MB2920F14C201E24027A38204AF4529@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2920F14C201E24027A38204AF4529@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 01:37:24AM +0000, ruansy.fnst@fujitsu.com wrote:
> > -----Original Message-----
> > From: Darrick J. Wong <djwong@kernel.org>
> > Subject: Re: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for
> > dax_iomap_zero
> > 
> > On Tue, May 11, 2021 at 11:09:29AM +0800, Shiyang Ruan wrote:
> > > Punch hole on a reflinked file needs dax_copy_edge() too.  Otherwise,
> > > data in not aligned area will be not correct.  So, add the srcmap to
> > > dax_iomap_zero() and replace memset() as dax_copy_edge().
> > >
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >  fs/dax.c               | 25 +++++++++++++++----------
> > >  fs/iomap/buffered-io.c |  2 +-
> > >  include/linux/dax.h    |  3 ++-
> > >  3 files changed, 18 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index ef0e564e7904..ee9d28a79bfb 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -1186,7 +1186,8 @@ static vm_fault_t dax_pmd_load_hole(struct
> > > xa_state *xas, struct vm_fault *vmf,  }  #endif /* CONFIG_FS_DAX_PMD
> > > */
> > >
> > > -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> > > +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> > > +		struct iomap *srcmap)
> > >  {
> > >  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
> > >  	pgoff_t pgoff;
> > > @@ -1208,19 +1209,23 @@ s64 dax_iomap_zero(loff_t pos, u64 length,
> > > struct iomap *iomap)
> > >
> > >  	if (page_aligned)
> > >  		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> > > -	else
> > > +	else {
> > >  		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> > > -	if (rc < 0) {
> > > -		dax_read_unlock(id);
> > > -		return rc;
> > > -	}
> > > -
> > > -	if (!page_aligned) {
> > > -		memset(kaddr + offset, 0, size);
> > > +		if (rc < 0)
> > > +			goto out;
> > > +		if (iomap->addr != srcmap->addr) {
> > 
> > Why isn't this "if (srcmap->type != IOMAP_HOLE)" ?
> > 
> > I suppose it has the same effect, since @iomap should never be a hole and we
> > should never have a @srcmap that's the same as @iomap, but still, we use
> > IOMAP_HOLE checks in most other parts of fs/iomap/.
> 
> According to its caller `iomap_zero_range_actor()`, whether
> srcmap->type is IOMAP_HOLE has already been checked before
> `dax_iomap_zero()`.  So the check you suggested will always be true...

Ah right, so it is.  I'll go review the newest version of this patch.

--D

> 
> 
> --
> Thanks,
> Ruan Shiyang.
> 
> > 
> > Other than that, the logic looks decent to me.
> > 
> > --D
> > 
> > > +			rc = dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
> > > +						kaddr);
> > > +			if (rc < 0)
> > > +				goto out;
> > > +		} else
> > > +			memset(kaddr + offset, 0, size);
> > >  		dax_flush(iomap->dax_dev, kaddr + offset, size);
> > >  	}
> > > +
> > > +out:
> > >  	dax_read_unlock(id);
> > > -	return size;
> > > +	return rc < 0 ? rc : size;
> > >  }
> > >
> > >  static loff_t
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c index
> > > f2cd2034a87b..2734955ea67f 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -933,7 +933,7 @@ static loff_t iomap_zero_range_actor(struct inode
> > *inode, loff_t pos,
> > >  		s64 bytes;
> > >
> > >  		if (IS_DAX(inode))
> > > -			bytes = dax_iomap_zero(pos, length, iomap);
> > > +			bytes = dax_iomap_zero(pos, length, iomap, srcmap);
> > >  		else
> > >  			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
> > >  		if (bytes < 0)
> > > diff --git a/include/linux/dax.h b/include/linux/dax.h index
> > > b52f084aa643..3275e01ed33d 100644
> > > --- a/include/linux/dax.h
> > > +++ b/include/linux/dax.h
> > > @@ -237,7 +237,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault
> > > *vmf,  int dax_delete_mapping_entry(struct address_space *mapping,
> > > pgoff_t index);  int dax_invalidate_mapping_entry_sync(struct
> > address_space *mapping,
> > >  				      pgoff_t index);
> > > -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
> > > +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> > > +		struct iomap *srcmap);
> > >  static inline bool dax_mapping(struct address_space *mapping)  {
> > >  	return mapping->host && IS_DAX(mapping->host);
> > > --
> > > 2.31.1
> > >
> > >
> > >
> > 
> 
