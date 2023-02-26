Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5806A35A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 00:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBZXsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 18:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZXsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:48:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344347ED6
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 15:48:18 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so4519097pjp.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 15:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUzHg3p43WL7jOgI2v/BTnjBO1ETSQzor61M+y8jjg0=;
        b=aWsv5/k02BJETyKcZvegOimTR55JOf4IMnDqAXaMzqi2SLZ4bV5idZBmIIAheCwuc9
         bb4H0e99CNJxD+cFkTHRZCofnXfNj5+X+2FhWRCOWaMshilKuQiy4q+T2zPMUReBONQR
         t3k52iQ0cxQP1whoFPQyo281Onb7MAV52qNeAnicPXvg39yRwCBxp69MuJithGZoPQqK
         Of3eZPZR/Qvpe61lLUnu4tJAerl1vhZh00pJ7JR40s/vxAxOBeyeU1gkDEoeIOpt7izu
         wgBq2nqzcVTgWYPOuC+tGraYulZjSAuxFh/CrGHBfuk1lBALEp1PVdyU9Z5nvATXPwSP
         JuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUzHg3p43WL7jOgI2v/BTnjBO1ETSQzor61M+y8jjg0=;
        b=YJiQfzItX8kV1pFdjxEu0S04qFgDcwSACfhxjRXCtY1vdjb4dLq3GnP9nLah92QyaY
         v/orSIglTZdcr9GGmiyBu5KP+3dtpBXE+ZR/MAdkSB2xxxMKPxUukRfp5jwic08P/sSJ
         jzIK/UO4bugysGmUBatKZ+Kv+E+etMSFl6e9K01eJsHjy1XkwYlm1XmAOzNkBZv0VPl+
         IVKPxWKf6YYgU+r+3UpbGdAGye05NH8B3tkxie0Y4mTD32JAFCIi14BjzPmnTaab8/k0
         jCWAsX1QIEiGl5q5UqDjpoxKmep6I2gM2Pc4pGzy+PZDI+hJRix6Cc1Zis/kFljYnmy7
         /V2A==
X-Gm-Message-State: AO0yUKWBwMlCgdkJi4LyBYPoR0RdsY1+CwBysWHI1Ag/3RdV2Y/VNIKl
        VHZ74jupmj3VRWXtwe0SddUQC/xOsH2wuo2R
X-Google-Smtp-Source: AK7set9eWiuwAJ/DfmjFd/kyMq+rGS1NjmXFSiZhP4mmobTmdErrGBiN5SQ4ChEFcwVdCjkIVWoWHw==
X-Received: by 2002:a17:903:6ce:b0:19c:d663:a31b with SMTP id kj14-20020a17090306ce00b0019cd663a31bmr7986252plb.24.1677455297638;
        Sun, 26 Feb 2023 15:48:17 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b00189ac5a2340sm3157554plb.124.2023.02.26.15.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 15:48:17 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pWQkY-002WYt-6L; Mon, 27 Feb 2023 10:48:14 +1100
Date:   Mon, 27 Feb 2023 10:48:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv3 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <20230226234814.GX360264@dread.disaster.area>
References: <cover.1677428794.git.ritesh.list@gmail.com>
 <9650ef88e09c6227b99bb5793eef2b8e47994c7d.1677428795.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9650ef88e09c6227b99bb5793eef2b8e47994c7d.1677428795.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:13:32AM +0530, Ritesh Harjani (IBM) wrote:
> On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
> filesystem blocksize, this patch should improve the performance by doing
> only the subpage dirty data write.
> 
> This should also reduce the write amplification since we can now track
> subpage dirty status within state bitmaps. Earlier we had to
> write the entire 64k page even if only a part of it (e.g. 4k) was
> updated.
> 
> Performance testing of below fio workload reveals ~16x performance
> improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> 
> 1. <test_randwrite.fio>
> [global]
> 	ioengine=psync
> 	rw=randwrite
> 	overwrite=1
> 	pre_read=1
> 	direct=0
> 	bs=4k
> 	size=1G
> 	dir=./
> 	numjobs=8
> 	fdatasync=1
> 	runtime=60
> 	iodepth=64
> 	group_reporting=1
> 
> [fio-run]
> 
> 2. Also our internal performance team reported that this patch improves there
>    database workload performance by around ~83% (with XFS on Power)
> 
> Reported-by: Aravinda Herle <araherle@in.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/gfs2/aops.c         |   2 +-
>  fs/iomap/buffered-io.c | 104 +++++++++++++++++++++++++++++++++++++----
>  fs/xfs/xfs_aops.c      |   2 +-
>  fs/zonefs/super.c      |   2 +-
>  include/linux/iomap.h  |   1 +
>  5 files changed, 99 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index e782b4f1d104..b9c35288a5eb 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -741,7 +741,7 @@ static const struct address_space_operations gfs2_aops = {
>  	.writepages = gfs2_writepages,
>  	.read_folio = gfs2_read_folio,
>  	.readahead = gfs2_readahead,
> -	.dirty_folio = filemap_dirty_folio,
> +	.dirty_folio = iomap_dirty_folio,
>  	.release_folio = iomap_release_folio,
>  	.invalidate_folio = iomap_invalidate_folio,
>  	.bmap = gfs2_bmap,
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e0b0be16278e..fb55183c547f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -44,8 +44,8 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>  static struct bio_set iomap_ioend_bioset;
> 
>  /*
> - * Accessor functions for setting/clearing/checking uptodate bits in
> - * iop->state bitmap.
> + * Accessor functions for setting/clearing/checking uptodate and
> + * dirty bits in iop->state bitmap.
>   * nrblocks is i_blocks_per_folio() which is passed in every
>   * function as the last argument for API consistency.
>   */
> @@ -75,8 +75,29 @@ static inline bool iop_full_uptodate(struct iomap_page *iop,
>  	return bitmap_full(iop->state, nrblocks);
>  }
> 
> +static inline void iop_set_range_dirty(struct iomap_page *iop,
> +				unsigned int start, unsigned int len,
> +				unsigned int nrblocks)
> +{
> +	bitmap_set(iop->state, start + nrblocks, len);
> +}
> +
> +static inline void iop_clear_range_dirty(struct iomap_page *iop,
> +				unsigned int start, unsigned int len,
> +				unsigned int nrblocks)
> +{
> +	bitmap_clear(iop->state, start + nrblocks, len);
> +}
> +
> +static inline bool iop_test_dirty(struct iomap_page *iop, unsigned int pos,
> +			     unsigned int nrblocks)
> +{
> +	return test_bit(pos + nrblocks, iop->state);
> +}
> +
>  static struct iomap_page *
> -iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
> +iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags,
> +		  bool is_dirty)
>  {
>  	struct iomap_page *iop = to_iomap_page(folio);
>  	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> @@ -90,12 +111,18 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>  	else
>  		gfp = GFP_NOFS | __GFP_NOFAIL;
> 
> -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> +	/*
> +	 * iop->state tracks 2 types of bitmaps i.e. uptodate & dirty
> +	 * for bs < ps.
> +	 */

PLease write comments out in full. Also "bs < ps" is actually
wrong because we have large folios in the page cache and they will
need to use sub-folio state tracking if they are dirtied.

	/*
	 * iop->state tracks two sets of state flags when the
	 * filesystem block size is smaller than the folio size.
	 * state. The first tracks per-filesystem block uptodate
	 * state, the second tracks per-filesystem block dirty
	 * state.
	 */

> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
>  		      gfp);
>  	if (iop) {
>  		spin_lock_init(&iop->state_lock);
>  		if (folio_test_uptodate(folio))
>  			iop_set_range_uptodate(iop, 0, nr_blocks, nr_blocks);
> +		if (is_dirty)
> +			iop_set_range_dirty(iop, 0, nr_blocks, nr_blocks);
>  		folio_attach_private(folio, iop);
>  	}
>  	return iop;
> @@ -202,6 +229,48 @@ static void iomap_set_range_uptodate(struct folio *folio,
>  		folio_mark_uptodate(folio);
>  }
> 
> +static void iomap_iop_set_range_dirty(struct folio *folio,
> +		struct iomap_page *iop, size_t off, size_t len)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> +	unsigned first = (off >> inode->i_blkbits);
> +	unsigned last = ((off + len - 1) >> inode->i_blkbits);

first_bit, last_bit if we are leaving this code unchanged.


> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	iop_set_range_dirty(iop, first, last - first + 1, nr_blocks);
                                        ^^^^^^^^^^^^^^^^ nr_bits

I dislike all the magic "- 1" and "+ 1" sprinkles that end up in
this code because of the closed ranges nomenclature infecting this
code. If we use closed start/open ended ranges like we do all
through XFS, we have:

offset_to_start_bit()
{
	return off >> bits;			// round_down
}

offset_to_end_bit()
{
	return (off + (1 << bits) - 1) >> bits; // round_up
}

	unsigned start_bit = offset_to_start_bit(off, inode->i_blkbits);
	unsigned end_bit = offset_to_end_bit(off + len, inode->i_blkbits);
	unsigned nr_bits = end_bit - start_bit;

	iop_set_range_dirty(iop, start_bit, nr_bits, nr_blocks);

And we don't have to add magic "handle the off by one"
sprinkles everywhere that maths on closed ranges requires to get
correct...


> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void iomap_set_range_dirty(struct folio *folio,
> +		struct iomap_page *iop, size_t off, size_t len)
> +{
> +	if (iop)
> +		iomap_iop_set_range_dirty(folio, iop, off, len);
> +}
> +
> +static void iomap_iop_clear_range_dirty(struct folio *folio,
> +		struct iomap_page *iop, size_t off, size_t len)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> +	unsigned first = (off >> inode->i_blkbits);
> +	unsigned last = ((off + len - 1) >> inode->i_blkbits);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	iop_clear_range_dirty(iop, first, last - first + 1, nr_blocks);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);

Same here with the magic off by one sprinkles.

FWIW, this is exactly the same code as
iomap_iop_clear_range_uptodate(), is it not? The only difference is
the offset into the state bitmap and that is done by
iop_clear_range_dirty() vs iop_clear_range_uptodate()? Seems like a
layer of wrappers could be taken out of here simply by placing the
start offset correctly here for a common iop_clear_range() helper...

> +static void iomap_clear_range_dirty(struct folio *folio,
> +		struct iomap_page *iop, size_t off, size_t len)
> +{
> +	if (iop)
> +		iomap_iop_clear_range_dirty(folio, iop, off, len);
> +}

Or even here at this layer, and we squash out two layers of
very similar wrappers.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
