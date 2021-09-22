Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B634150A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhIVTtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 15:49:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237233AbhIVTs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:48:59 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MJdOMa031093;
        Wed, 22 Sep 2021 15:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=Xn5kaHlxC1t6hBYGmqMTm6+qiz4j73N8Po8GIgKcQnM=;
 b=tMzsMvhCf3M0S/D6cMXPTnFETfwHXohJFOdMjJgEJxn/egC7eZoBT0chvE2XKuZjrhx7
 6rRzJEHB9LXryq7dsGHLb6uYNbwqAuUf70QktaR98ByTg+3StAW5sCBKgLI37xZloRJX
 zdPkl86yhy/lvPELkqyJ2Q6v1Ne4tTEYPhGDHpqqHF2A1YcGb5rsW7Wnplh+KZn47mTY
 nh+V5pvTuy3IUfjdjtRHi29q3oVgv72EH0SR/zZWzhXPjFnT+dlK2702xANXloPl0TMF
 rHPRFJ3zqsr43UmmdekLlN7PVqBJ4mJyhA3StveFJ37gsFYqyTlZcRGka9+1h9/aNkyw OA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b8au3g4gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 15:47:22 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18MJbnOC018600;
        Wed, 22 Sep 2021 19:47:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3b7q6k275y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 19:47:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18MJlHgs52560150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 19:47:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A51E44204B;
        Wed, 22 Sep 2021 19:47:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4234F4204D;
        Wed, 22 Sep 2021 19:47:17 +0000 (GMT)
Received: from localhost (unknown [9.43.105.212])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Sep 2021 19:47:17 +0000 (GMT)
Date:   Thu, 23 Sep 2021 01:17:16 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] dax: prepare pmem for use by zero-initializing
 contents and clearing poisons
Message-ID: <20210922194716.4qbp6bpeuhwpml3c@riteshh-domain>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865031.417973.8372869475521627214.stgit@magnolia>
 <20210918165408.ivsue463wpiitzjw@riteshh-domain>
 <20210920172225.GA570615@magnolia>
 <20210921040708.ojbbbt6i524wgsaj@riteshh-domain>
 <20210922182642.GJ570615@magnolia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922182642.GJ570615@magnolia>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ytK7pLpwIG7dvfoonIUiFzUsMyka_5MV
X-Proofpoint-ORIG-GUID: ytK7pLpwIG7dvfoonIUiFzUsMyka_5MV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_07,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220128
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/09/22 11:26AM, Darrick J. Wong wrote:
> On Tue, Sep 21, 2021 at 09:37:08AM +0530, riteshh wrote:
> > On 21/09/20 10:22AM, Darrick J. Wong wrote:
> > > On Sat, Sep 18, 2021 at 10:24:08PM +0530, riteshh wrote:
> > > > On 21/09/17 06:30PM, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > Our current "advice" to people using persistent memory and FSDAX who
> > > > > wish to recover upon receipt of a media error (aka 'hwpoison') event
> > > > > from ACPI is to punch-hole that part of the file and then pwrite it,
> > > > > which will magically cause the pmem to be reinitialized and the poison
> > > > > to be cleared.
> > > > >
> > > > > Punching doesn't make any sense at all -- the (re)allocation on pwrite
> > > > > does not permit the caller to specify where to find blocks, which means
> > > > > that we might not get the same pmem back.  This pushes the user farther
> > > > > away from the goal of reinitializing poisoned memory and leads to
> > > > > complaints about unnecessary file fragmentation.
> > > > >
> > > > > AFAICT, the only reason why the "punch and write" dance works at all is
> > > > > that the XFS and ext4 currently call blkdev_issue_zeroout when
> > > > > allocating pmem ahead of a write call.  Even a regular overwrite won't
> > > > > clear the poison, because dax_direct_access is smart enough to bail out
> > > > > on poisoned pmem, but not smart enough to clear it.  To be fair, that
> > > > >
> > > > >
> > > > > function maps pages and has no idea what kinds of reads and writes the
> > > > > caller might want to perform.
> > > > >
> > > > > Therefore, create a dax_zeroinit_range function that filesystems can to
> > > > > reset the pmem contents to zero and clear hardware media error flags.
> > > > > This uses the dax page zeroing helper function, which should ensure that
> > > > > subsequent accesses will not trip over any pre-existing media errors.
> > > >
> > > > Thanks Darrick for such clear explaination of the problem and your solution.
> > > > As I see from this thread [1], it looks like we are heading in this direction,
> > > > so I thought of why not review this RFC patch series :)
> > > >
> > > > [1]: https://lore.kernel.org/all/CAPcyv4iAr_Vwwgqw+4wz0RQUXhUUJGGz7_T+p+W6tC4T+k+zNw@mail.gmail.com/
> > > >
> > > > >
> > > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > > ---
> > > > >  fs/dax.c            |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/dax.h |    7 ++++
> > > > >  2 files changed, 100 insertions(+)
> > > > >
> > > > >
> > > > > diff --git a/fs/dax.c b/fs/dax.c
> > > > > index 4e3e5a283a91..765b80d08605 100644
> > > > > --- a/fs/dax.c
> > > > > +++ b/fs/dax.c
> > > > > @@ -1714,3 +1714,96 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
> > > > >  	return dax_insert_pfn_mkwrite(vmf, pfn, order);
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> > > > > +
> > > > > +static loff_t
> > > > > +dax_zeroinit_iter(struct iomap_iter *iter)
> > > > > +{
> > > > > +	struct iomap *iomap = &iter->iomap;
> > > > > +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > > > > +	const u64 start = iomap->addr + iter->pos - iomap->offset;
> > > > > +	const u64 nr_bytes = iomap_length(iter);
> > > > > +	u64 start_page = start >> PAGE_SHIFT;
> > > > > +	u64 nr_pages = nr_bytes >> PAGE_SHIFT;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!iomap->dax_dev)
> > > > > +		return -ECANCELED;
> > > > > +
> > > > > +	/*
> > > > > +	 * The physical extent must be page aligned because that's what the dax
> > > > > +	 * function requires.
> > > > > +	 */
> > > > > +	if (!PAGE_ALIGNED(start | nr_bytes))
> > > > > +		return -ECANCELED;
> > > > > +
> > > > > +	/*
> > > > > +	 * The dax function, by using pgoff_t, is stuck with unsigned long, so
> > > > > +	 * we must check for overflows.
> > > > > +	 */
> > > > > +	if (start_page >= ULONG_MAX || start_page + nr_pages > ULONG_MAX)
> > > > > +		return -ECANCELED;
> > > > > +
> > > > > +	/* Must be able to zero storage directly without fs intervention. */
> > > > > +	if (iomap->flags & IOMAP_F_SHARED)
> > > > > +		return -ECANCELED;
> > > > > +	if (srcmap != iomap)
> > > > > +		return -ECANCELED;
> > > > > +
> > > > > +	switch (iomap->type) {
> > > > > +	case IOMAP_MAPPED:
> > > > > +		while (nr_pages > 0) {
> > > > > +			/* XXX function only supports one page at a time?! */
> > > > > +			ret = dax_zero_page_range(iomap->dax_dev, start_page,
> > > > > +					1);
> > > > > +			if (ret)
> > > > > +				return ret;
> > > > > +			start_page++;
> > > > > +			nr_pages--;
> > > > > +		}
> > > > > +
> > > > > +		fallthrough;
> > > > > +	case IOMAP_UNWRITTEN:
> > > > > +		return nr_bytes;
> > > > > +	}
> > > > > +
> > > > > +	/* Reject holes, inline data, or delalloc extents. */
> > > > > +	return -ECANCELED;
> > > >
> > > > We reject holes here, but the other vfs plumbing patch [2] mentions
> > > > "Holes and unwritten extents are left untouched.".
> > > > Shouldn't we just return nr_bytes for IOMAP_HOLE case as well?
> > >
> > > I'm not entirely sure what we should do for holes and unwritten extents,
> > > as you can tell from the gross inconsistency between the comment and the
> > > code. :/
> > >
> > > On block devices, I think we rely on the behavior that writing to disk
> > > will clear the device's error state (via LBA remapping or some other
> > > strategy).  I think this means iomap_zeroinit can skip unwritten extents
> > > because reads and read faults will be satisfied from the zero page and
> > > writeback (or direct writes) will trigger the drive firmware.
> > >
> > > On FSDAX devices, reads are fulfilled by zeroing the user buffer, and
> > > read faults with the (dax) zero page.  Writes and write faults won't
> > > clear the poison (unlike disks).  So I guess this means that
> > > dax_zeroinit *does* have to act on unwritten areas.
>
> I was confused when I wrote this -- before writing, dax filesystems are
> required to allocate written zeroed extents and/or zero unwritten
> extents and mark them written.  So we don't actually need to zero
> unwritten extents.

Oh yes, thanks for catching that.

ext4 has this flag set for DAX inode in ext4_iomap_alloc()
ext4_iomap_begin() -> ext4_iomap_alloc() ->
	if (IS_DAX(inode))
		m_flags = EXT4_GET_BLOCKS_CREATE_ZERO;

Also,
#define EXT4_GET_BLOCKS_CREATE_ZERO		(EXT4_GET_BLOCKS_CREATE | EXT4_GET_BLOCKS_ZERO)

if EXT4_GET_BLOCKS_ZERO is set then we call
ext4_map_blocks -> ext4_issue_zeroout() -> blkdev_issue_zeroout()

>
> > >
> > > Ok.  I'll make those changes.
> >
> > Yes, I guess unwritten extents still have extents blocks allocated with
> > generally a bit marked (to mark it as unwritten). So there could still be
> > a need to clear the poison for this in case of DAX.
> >
> > >
> > > As for holes -- on the one hand, one could argue that zero-initializing
> > > a hole makes no sense and should be an error.  OTOH one could make an
> > > equally compelling argument that it's merely a nop.  Thoughts?
> >
> > So in case of holes consider this case (please correct if any of my
> > understanding below is wrong/incomplete).
> > If we have a large hole and if someone tries to do write to that area.
> > 1. Then from what I understood from the code FS will try and allocate some disk
> >    blocks (could these blocks be marked with HWpoison as FS has no way of
> >    knowing it?).
>
> Freshly allocated extents are zeroed via blkdev_issue_zeroout before
> being mapped into the file, which will clear the poison.  That last bit
> is only the reason why the punch-and-rewrite dance ever worked at all.

Frankly speaking, this discussion actually got me thinking about what is special
about punch and write (w/o making any assumptions) that it clears the poison?

What about just punch hole alone?
So I guess this too can clear the HWpoison on the next write (after fault ->
allocating blocks for DAX -> this will call blkdev_issue_zeroout())
but I guess the problem with this approach, as you mentioned, it may cause file
fragmentation. Thisis since we may not get the same block back on next write
after punch hole.

Looking at the code of pmem driver, it is actually pmem_do_write() which
clears the pmem HWpoison.

And I guess the offset and size should be page_aligned because that's what calls
dax_zero_page_range() which can clear the HWpoison in dax_iomap_zero().

>
> We'll have to make sure this poison clearing still happens even after
> the dax/block layer divorce.
>
> > 2. If yes, then after allocating those blocks dax_direct_access will fail (as
> >    you had mentioned above). But it won't clear the HWposion.
> > 3. Then the user again will have to clear using this API. But that is only for
> >    a given extent which is some part of the hole which FS allocated.
> > Now above could be repeated until the entire hole range is covered.
> > Is that above understanding correct?
> >
> > If yes, then maybe it all depends on what sort of gurantee the API is providing.
> > If using the API on the given range guarantees that the entire file range will
> > not have any blocks with HWpoison then I guess we may have to cover the
> > IOMAP_HOLE case as well?
> > If not, then maybe we could explicitly mentioned this in the API documentation.
>
> Ok.  The short version is that zeroinit will ensure that subsequent
> reads, writes, or faults to allocated file ranges won't have problems
> with pre-existing poison flags.  If the user wants to fill sparse holes,
> they can do that with a separate fallocate call.

Yes, it is now clear to me.
Thanks for taking time and replying.

-ritesh

>
> --D
>
> > Please help correct if any of above does not make any sense. It will help me
> > understand this use case better.
> >
> > -ritesh
> >
> > >
> > > --D
> > >
> > > > [2]: "vfs: add a zero-initialization mode to fallocate"
> > > >
> > > > Although I am not an expert in this area, but the rest of the patch looks
> > > > very well crafted to me. Thanks again for such details :)
> > > >
> > > > -ritesh
> > > >
> > > > >
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Initialize storage mapped to a DAX-mode file to a known value and ensure the
> > > > > + * media are ready to accept read and write commands.  This requires the use of
> > > > > + * the dax layer's zero page range function to write zeroes to a pmem region
> > > > > + * and to reset any hardware media error state.
> > > > > + *
> > > > > + * The physical extents must be aligned to page size.  The file must be backed
> > > > > + * by a pmem device.  The extents returned must not require copy on write (or
> > > > > + * any other mapping interventions from the filesystem) and must be contiguous.
> > > > > + * @done will be set to true if the reset succeeded.
> > > > > + *
> > > > > + * Returns 0 if the zero initialization succeeded, -ECANCELED if the storage
> > > > > + * mappings do not support zero initialization, -EOPNOTSUPP if the device does
> > > > > + * not support it, or the usual negative errno.
> > > > > + */
> > > > > +int
> > > > > +dax_zeroinit_range(struct inode *inode, loff_t pos, u64 len,
> > > > > +		   const struct iomap_ops *ops)
> > > > > +{
> > > > > +	struct iomap_iter iter = {
> > > > > +		.inode		= inode,
> > > > > +		.pos		= pos,
> > > > > +		.len		= len,
> > > > > +		.flags		= IOMAP_REPORT,
> > > > > +	};
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!IS_DAX(inode))
> > > > > +		return -EINVAL;
> > > > > +	if (pos + len > i_size_read(inode))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	while ((ret = iomap_iter(&iter, ops)) > 0)
> > > > > +		iter.processed = dax_zeroinit_iter(&iter);
> > > > > +	return ret;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(dax_zeroinit_range);
> > > > > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > > > > index 2619d94c308d..3c873f7c35ba 100644
> > > > > --- a/include/linux/dax.h
> > > > > +++ b/include/linux/dax.h
> > > > > @@ -129,6 +129,8 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
> > > > >  struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> > > > >  dax_entry_t dax_lock_page(struct page *page);
> > > > >  void dax_unlock_page(struct page *page, dax_entry_t cookie);
> > > > > +int dax_zeroinit_range(struct inode *inode, loff_t pos, u64 len,
> > > > > +			const struct iomap_ops *ops);
> > > > >  #else
> > > > >  #define generic_fsdax_supported		NULL
> > > > >
> > > > > @@ -174,6 +176,11 @@ static inline dax_entry_t dax_lock_page(struct page *page)
> > > > >  static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
> > > > >  {
> > > > >  }
> > > > > +static inline int dax_zeroinit_range(struct inode *inode, loff_t pos, u64 len,
> > > > > +		const struct iomap_ops *ops)
> > > > > +{
> > > > > +	return -EOPNOTSUPP;
> > > > > +}
> > > > >  #endif
> > > > >
> > > > >  #if IS_ENABLED(CONFIG_DAX)
> > > > >
