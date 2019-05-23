Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857C927C22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 13:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfEWLvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 07:51:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:56770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729361AbfEWLvO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 07:51:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 851F9AD17;
        Thu, 23 May 2019 11:51:12 +0000 (UTC)
Date:   Thu, 23 May 2019 06:51:09 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190523115109.2o4txdjq2ft7fzzc@fiona>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-5-rgoldwyn@suse.de>
 <20190521165158.GB5125@magnolia>
 <1e9951c1-d320-e480-3130-dc1f4b81ef2c@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e9951c1-d320-e480-3130-dc1f4b81ef2c@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17:05 23/05, Shiyang Ruan wrote:
> 
> 
> On 5/22/19 12:51 AM, Darrick J. Wong wrote:
> > On Mon, Apr 29, 2019 at 12:26:35PM -0500, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > 
> > > The IOMAP_DAX_COW is a iomap type which performs copy of
> > > edges of data while performing a write if start/end are
> > > not page aligned. The source address is expected in
> > > iomap->inline_data.
> > > 
> > > dax_copy_edges() is a helper functions performs a copy from
> > > one part of the device to another for data not page aligned.
> > > If iomap->inline_data is NULL, it memset's the area to zero.
> > > 
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > ---
> > >   fs/dax.c              | 46 +++++++++++++++++++++++++++++++++++++++++++++-
> > >   include/linux/iomap.h |  1 +
> > >   2 files changed, 46 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index e5e54da1715f..610bfa861a28 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -1084,6 +1084,42 @@ int __dax_zero_page_range(struct block_device *bdev,
> > >   }
> > >   EXPORT_SYMBOL_GPL(__dax_zero_page_range);
> > > +/*
> > > + * dax_copy_edges - Copies the part of the pages not included in
> > > + * 		    the write, but required for CoW because
> > > + * 		    offset/offset+length are not page aligned.
> > > + */
> > > +static int dax_copy_edges(struct inode *inode, loff_t pos, loff_t length,
> > > +			   struct iomap *iomap, void *daddr)
> > > +{
> > > +	unsigned offset = pos & (PAGE_SIZE - 1);
> > > +	loff_t end = pos + length;
> > > +	loff_t pg_end = round_up(end, PAGE_SIZE);
> > > +	void *saddr = iomap->inline_data;
> > > +	int ret = 0;
> > > +	/*
> > > +	 * Copy the first part of the page
> > > +	 * Note: we pass offset as length
> > > +	 */
> > > +	if (offset) {
> > > +		if (saddr)
> > > +			ret = memcpy_mcsafe(daddr, saddr, offset);
> > > +		else
> > > +			memset(daddr, 0, offset);
> > > +	}
> > > +
> > > +	/* Copy the last part of the range */
> > > +	if (end < pg_end) {
> > > +		if (saddr)
> > > +			ret = memcpy_mcsafe(daddr + offset + length,
> > > +			       saddr + offset + length,	pg_end - end);
> > > +		else
> > > +			memset(daddr + offset + length, 0,
> > > +					pg_end - end);
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > >   static loff_t
> > >   dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > >   		struct iomap *iomap)
> > > @@ -1105,9 +1141,11 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > >   			return iov_iter_zero(min(length, end - pos), iter);
> > >   	}
> > > -	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
> > > +	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED
> > > +			 && iomap->type != IOMAP_DAX_COW))
> > 
> > I reiterate (from V3) that the && goes on the previous line...
> > 
> > 	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
> > 			 iomap->type != IOMAP_DAX_COW))
> > 
> > >   		return -EIO;
> > > +
> > >   	/*
> > >   	 * Write can allocate block for an area which has a hole page mapped
> > >   	 * into page tables. We have to tear down these mappings so that data
> > > @@ -1144,6 +1182,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > >   			break;
> > >   		}
> > > +		if (iomap->type == IOMAP_DAX_COW) {
> > > +			ret = dax_copy_edges(inode, pos, length, iomap, kaddr);
> > > +			if (ret)
> > > +				break;
> > > +		}
> > > +
> > >   		map_len = PFN_PHYS(map_len);
> > >   		kaddr += offset;
> > >   		map_len -= offset;
> > > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > > index 0fefb5455bda..6e885c5a38a3 100644
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -25,6 +25,7 @@ struct vm_fault;
> > >   #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
> > >   #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
> > >   #define IOMAP_INLINE	0x05	/* data inline in the inode */
> > 
> > > +#define IOMAP_DAX_COW	0x06
> > 
> > DAX isn't going to be the only scenario where we need a way to
> > communicate to iomap actors the need to implement copy on write.
> > 
> > XFS also uses struct iomap to hand out file leases to clients.  The
> > lease code /currently/ doesn't support files with shared blocks (because
> > the only user is pNFS) but one could easily imagine a future where some
> > client wants to lease a file with shared blocks, in which case XFS will
> > want to convey the COW details to the lessee.
> > 
> > > +/* Copy data pointed by inline_data before write*/
> > 
> > A month ago during the V3 patchset review, I wrote (possibly in an other
> > thread, sorry) about something that I'm putting my foot down about now
> > for the V4 patchset, which is the {re,ab}use of @inline_data for the
> > data source address.
> > 
> > We cannot use @inline_data to convey the source address.  @inline_data
> > (so far) is used to point to the in-memory representation of the storage
> > described by @addr.  For data writes, @addr is the location of the write
> > on disk and @inline_data is the location of the write in memory.
> > 
> > Reusing @inline_data here to point to the location of the source data in
> > memory is a totally different thing and will likely result in confusion.
> > On a practical level, this also means that we cannot support the case of
> > COW && INLINE because the type codes collide and so would the users of
> > @inline_data.  This isn't required *right now*, but if you had a pmem
> > filesystem that stages inode updates in memory and flips a pointer to
> > commit changes then the ->iomap_begin function will need to convey two
> > pointers at once.
> > 
> > So this brings us back to Dave's suggestion during the V1 patchset
> > review that instead of adding more iomap flags/types and overloading
> > fields, we simply pass two struct iomaps into ->iomap_begin:
> > 
> >   - Change iomap_apply() to "struct iomap iomap[2] = 0;" and pass
> >     &iomap[0] into the ->iomap_begin and ->iomap_end functions.  The
> >     first iomap will be filled in with the destination for the write (as
> >     all implementations do now), and the second iomap can be filled in
> >     with the source information for a COW operation.
> > 
> >   - If the ->iomap_begin implementation decides that COW is necessary for
> >     the requested operation, then it should fill out that second iomap
> >     with information about the extent that the actor must copied before
> >     returning.  The second iomap's offset and length must match the
> >     first.  If COW isn't necessary, the ->iomap_begin implementation
> 
> Hi,
> 
> I'm working on reflink & dax in XFS, here are some thoughts on this:
> 
> As mentioned above: the second iomap's offset and length must match the
> first.  I thought so at the beginning, but later found that the only
> difference between these two iomaps is @addr.  So, what about adding a
> @saddr, which means the source address of COW extent, into the struct iomap.
> The ->iomap_begin() fills @saddr if the extent is COW, and 0 if not.  Then
> handle this @saddr in each ->actor().  No more modifications in other
> functions.

Yes, I started of with the exact idea before being recommended this by Dave.
I used two fields instead of one namely cow_pos and cow_addr which defined
the source details. I had put it as a iomap flag as opposed to a type
which of course did not appeal well.

We may want to use iomaps for cases where two inodes are involved.
An example of the other scenario where offset may be different is file
comparison for dedup: vfs_dedup_file_range_compare(). However, it would
need two inodes in iomap as well.

> 
> My RFC patchset[1] is implemented in this way and works for me, though it is
> far away from perfectness.
> 
> [1]: https://patchwork.kernel.org/cover/10904307/
> 

-- 
Goldwyn
