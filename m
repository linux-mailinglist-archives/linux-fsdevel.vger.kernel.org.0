Return-Path: <linux-fsdevel+bounces-43763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E24A5D71C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574391888AE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50D01E9B35;
	Wed, 12 Mar 2025 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RYPjBWmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0A1E9B03;
	Wed, 12 Mar 2025 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763624; cv=none; b=nU0ncxz3C9MaIf4CwoecA2vMu3Xrz32radpx7zSlDOvImwokRf5ud7poggm4XaAcPtNTQ/LpQ1Y2L+2ROqSz/G8YNQcRwSFlbxGZMR4eV1YbnBaPhjv/xwAvhztPHyKaR0rePKvAWjo3cnPkePOofK1KhzFkvANQ3TM/PqP+9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763624; c=relaxed/simple;
	bh=KqBpjelnFqR7IYQV3qZ7nR8rsGn6f0+jyxydzmKvmfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ1/gX7mRfvCdt5AzZTVNkkgOyYFwdKiiZIla4WJc/5zFQ/z4VfbVG5IjL1krcr1m5uL3fcv1IyL+T5RvzAYl//HH2+DiMO1B6dTyaqqQXrOnImF3EE2XpcHJPqzD4l4KdCP1GuK8WdI2IUBO7Uz2694AGL2kXulDwYHowH/g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RYPjBWmU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wC1y5D3fhfw2mX05dkCvjFc+X6ljXrZsVRIT6DJwfRo=; b=RYPjBWmUccgbZ2bEVCNKDp7ojS
	OFLrDSNDuxXA+8lJp7icp+NAQtc5djoZFvgR0hXBqi7xEUmKANVlTY79Od02zwyBBc9JU8Ri2GCAm
	G4pdTP7+9bfWhW5FXtJy0UuBkkqTeS0w3iCNc3GqovHEfzB68wMnlQERBs87rUylJPlEGcz2P2kt8
	lel3tBSJN/FBxcrBxRn/kJGQRLVqPD9m0+GeNEPyFNazWTgxRXxzGdxL2DveWi0qQERUdGRmmqmx9
	paxVMF84lBmx+MT8O8UwTPcyTQRynbVu5HaRXD8A9KqOgeeTefz+XwU8E4U8WTXn5jNbnMxYT5eW6
	xfjAaypg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGHe-00000007g6a-2IJ0;
	Wed, 12 Mar 2025 07:13:42 +0000
Date: Wed, 12 Mar 2025 00:13:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
Message-ID: <Z9E0JqQfdL4nPBH-@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183946.932054-11-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 10, 2025 at 06:39:46PM +0000, John Garry wrote:
> Dave Chinner thought that names IOMAP_ATOMIC_HW and IOMAP_ATOMIC_SW were
> not appropopiate. Specifically because IOMAP_ATOMIC_HW could actually be
> realised with a SW-based method in the block or md/dm layers.
> 
> So rename to IOMAP_ATOMIC_BIO and IOMAP_ATOMIC_FS.

Looking over the entire series and the already merged iomap code:
there should be no reason at all for having IOMAP_ATOMIC_FS.
The only thing it does is to branch out to
xfs_atomic_write_sw_iomap_begin from xfs_atomic_write_iomap_begin.

You can do that in a much simpler and nicer way by just having
different iomap_ops for the bio based vs file system based atomics.

I agree with dave that bio is a better term for the bio based
atomic, but please use the IOMAP_ATOMIC_BIO name above instead
of the IOMAP_BIO_ATOMIC actually used in the code if you change
it.

>   */
>  static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> -		const struct iomap *iomap, bool use_fua, bool atomic_hw)
> +		const struct iomap *iomap, bool use_fua, bool bio_atomic)

Not new here, but these two bools are pretty ugly.

I'd rather have a

    blk_opf_t extra_flags;

in the caller that gets REQ_FUA and REQ_ATOMIC assigned as needed,
and then just clear 

>  
> -	if (atomic_hw && length != iter->len)
> +	if (bio_atomic && length != iter->len)
>  		return -EINVAL;

This could really use a comment explaining what the check is for.

> -		if (WARN_ON_ONCE(atomic_hw && n != length)) {
> +		if (WARN_ON_ONCE(bio_atomic && n != length)) {

Same.

> -#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
> -#define IOMAP_DONTCACHE		(1 << 10)
> -#define IOMAP_ATOMIC_SW		(1 << 11)/* SW-based torn-write protection */
> +#define IOMAP_DONTCACHE		(1 << 9)
> +#define IOMAP_BIO_ATOMIC	(1 << 10) /* Use REQ_ATOMIC on single bio */
> +#define IOMAP_FS_ATOMIC		(1 << 11) /* FS-based torn-write protection */

Please also fix the overly long lines here by moving the comments
above the definitions.  That should also give you enough space to
expand the comment into a full sentence describing the flag fully.


