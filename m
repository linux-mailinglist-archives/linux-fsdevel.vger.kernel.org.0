Return-Path: <linux-fsdevel+bounces-13935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFCB8759EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D738BB24F0B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F213EFEE;
	Thu,  7 Mar 2024 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJdiae6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFDD13E7FB;
	Thu,  7 Mar 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849170; cv=none; b=SK1yLjZA8VLBJ3HpBrMTS/M1niGgnY4Hif8AbShnbZfIBKfrXPbz7uBeS2xsYBluXYr5tPuU1H5QqRYI7nfM2TtE7QmcdFAQnwhtsqetbTt3VD1+PIDGsH+90PWB51k4EKw25e68UtxH3g0DcvkY1HW/TxLrhkkBTK/WXEKuwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849170; c=relaxed/simple;
	bh=3WUDYkcHl8rWSU8JixT9wxsVcPD+MtMgAzpTNdiqdDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mr49DUpAkLX7YrHCe91TB+OWPFEdDcnDbcZFl3twFCQpR7lId4gJBDau4fCIepKTF8S16tFEwOtQsst9mKVZhfWMk0jnasW2gEHuXN17pQW6+zc7k2d72J94iHhHk9csAEArnL7v9Oabu2SzQZoIbqoWdp/y0FwLAqfHSDAPQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJdiae6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5059C433F1;
	Thu,  7 Mar 2024 22:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849169;
	bh=3WUDYkcHl8rWSU8JixT9wxsVcPD+MtMgAzpTNdiqdDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJdiae6pmGl2ERLSl6607BBxjBGrOFdVxy+G9D29+qg3+azF9lOQWjmgnfDjl/OIF
	 +FW+kDGtsovMUPjSlsaHXtT+17CjxUmt8cRGv5MG2KZepOhcHqq16E42JBJM/edq/R
	 h/HGriusUiqEfRfFVn/EXiD2faOt+mfCZKSWqHwFBCZzjrMmrngIGRgrPwAF7Aat0A
	 q4VUV+d8Gf3IfqnZ78TcGR2WZZoKJxl0iaJKM90+YK9gGcZPnDh2ruXowdIjMGUV59
	 zqxQ5JLOwwqrrom6t62B72MdBJs7pcXCjfhuarZ+4KmDmPnyIk0kTJGDUXcOs6X6b4
	 fRXd2w7HWdC8w==
Date: Thu, 7 Mar 2024 14:06:08 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20240307220608.GT1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-12-aalbersh@redhat.com>
 <20240304233927.GC17145@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304233927.GC17145@sol.localdomain>

On Mon, Mar 04, 2024 at 03:39:27PM -0800, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 08:10:33PM +0100, Andrey Albershteyn wrote:
> > +#ifdef CONFIG_FS_VERITY
> > +struct iomap_fsverity_bio {
> > +	struct work_struct	work;
> > +	struct bio		bio;
> > +};
> 
> Maybe leave a comment above that mentions that bio must be the last field.
> 
> > @@ -471,6 +529,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
> >   * iomap_readahead - Attempt to read pages from a file.
> >   * @rac: Describes the pages to be read.
> >   * @ops: The operations vector for the filesystem.
> > + * @wq: Workqueue for post-I/O processing (only need for fsverity)
> 
> This should not be here.
> 
> > +#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
> > +
> >  static int __init iomap_init(void)
> >  {
> > -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> > -			   offsetof(struct iomap_ioend, io_inline_bio),
> > -			   BIOSET_NEED_BVECS);
> > +	int error;
> > +
> > +	error = bioset_init(&iomap_ioend_bioset, IOMAP_POOL_SIZE,
> > +			    offsetof(struct iomap_ioend, io_inline_bio),
> > +			    BIOSET_NEED_BVECS);
> > +#ifdef CONFIG_FS_VERITY
> > +	if (error)
> > +		return error;
> > +
> > +	error = bioset_init(&iomap_fsverity_bioset, IOMAP_POOL_SIZE,
> > +			    offsetof(struct iomap_fsverity_bio, bio),
> > +			    BIOSET_NEED_BVECS);
> > +	if (error)
> > +		bioset_exit(&iomap_ioend_bioset);
> > +#endif
> > +	return error;
> >  }
> >  fs_initcall(iomap_init);
> 
> This makes all kernels with CONFIG_FS_VERITY enabled start preallocating memory
> for these bios, regardless of whether they end up being used or not.  When
> PAGE_SIZE==4096 it comes out to about 134 KiB of memory total (32 bios at just
> over 4 KiB per bio, most of which is used for the BIO_MAX_VECS bvecs), and it
> scales up with PAGE_SIZE such that with PAGE_SIZE==65536 it's about 2144 KiB.
> 
> How about allocating the pool when it's known it's actually going to be used,
> similar to what fs/crypto/ does for fscrypt_bounce_page_pool?  For example,
> there could be a flag in struct fsverity_operations that says whether filesystem
> wants the iomap fsverity bioset, and when fs/verity/ sets up the fsverity_info
> for any file for the first time since boot, it could call into fs/iomap/ to
> initialize the iomap fsverity bioset if needed.

I was thinking the same thing.

Though I wondered if you want to have a CONFIG_IOMAP_FS_VERITY as well?
But that might be tinykernel tetrapyloctomy.

--D

> BTW, errors from builtin initcalls such as iomap_init() get ignored.  So the
> error handling logic above does not really work as may have been intended.
> 
> - Eric
> 

