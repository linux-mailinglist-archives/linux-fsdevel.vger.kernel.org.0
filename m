Return-Path: <linux-fsdevel+bounces-13945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4D875A28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CD72823D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD408140380;
	Thu,  7 Mar 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN/CqVqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7413F00A;
	Thu,  7 Mar 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849953; cv=none; b=beaR9MUqCd+1U7p9lKpPSQy5cYuvVPsvL9Fhu2muZ+NKThmxN8qkOZzEaLx79y08ZM3DJCkuSIQmip22dnBJv6f4lU/Eg7CRaLEMgodcoZS57EzNiSaE3qFbSU3LFVAODvMAadkuv+MfGdmsA/gAZgp5CzNMbb33qlm2Xf1PJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849953; c=relaxed/simple;
	bh=z7exu4gC4bvKF7lsnRppR9kl1w+xqNclW40ax468+U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLL7FjStWcPWZhdgqGoa1h83rb9hPUrB1kLLwJO0qu1TsoN3RBPhWi3KxzF4Y4Gr0L+tHSIurHfnoGnDFwLwQosQFyZPz4sb7wA4jfTpOf+LQ2MjhQ0u2EFY8LmCkmxTQ/dgcOKLZ3+/3xRax13LxUkTdIiNJxRdqRkIC6j3IGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN/CqVqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C517C433C7;
	Thu,  7 Mar 2024 22:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849952;
	bh=z7exu4gC4bvKF7lsnRppR9kl1w+xqNclW40ax468+U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VN/CqVqR0XjwaV3P9eupQQehsB+3pzAz3XvmAJ9htT2ZRwknSvDYLcjtziUq1R3tN
	 nfFkyMsBCeGzZJfNM7di13qR+XDZUUqo5V84Yiqg8hI4OID/CCs4UQUHfSUva/8iw/
	 kjPGCoD2B0vPt4KOBznvs4v0KC7AZLb8EMKXJ7lueCkDSHTpLasbv7zbkrtO6NhRn7
	 QXQijgq3A7pL6uNb7EgOQv+D7lFCYiliWLEa41uIOdiFSFzLD9sGB97hH8X3H6i8VU
	 +9AujjPnCyOH+FL1dICfyb4A8eMgmDjVwtRDhOHYRScFgz9cuNeVIrXSKtaBiHZU9D
	 yosjvFwmtYnXA==
Date: Thu, 7 Mar 2024 14:19:10 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20240307221910.GC1799@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-12-aalbersh@redhat.com>
 <20240304233927.GC17145@sol.localdomain>
 <20240307220608.GT1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307220608.GT1927156@frogsfrogsfrogs>

On Thu, Mar 07, 2024 at 02:06:08PM -0800, Darrick J. Wong wrote:
> On Mon, Mar 04, 2024 at 03:39:27PM -0800, Eric Biggers wrote:
> > On Mon, Mar 04, 2024 at 08:10:33PM +0100, Andrey Albershteyn wrote:
> > > +#ifdef CONFIG_FS_VERITY
> > > +struct iomap_fsverity_bio {
> > > +	struct work_struct	work;
> > > +	struct bio		bio;
> > > +};
> > 
> > Maybe leave a comment above that mentions that bio must be the last field.
> > 
> > > @@ -471,6 +529,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
> > >   * iomap_readahead - Attempt to read pages from a file.
> > >   * @rac: Describes the pages to be read.
> > >   * @ops: The operations vector for the filesystem.
> > > + * @wq: Workqueue for post-I/O processing (only need for fsverity)
> > 
> > This should not be here.
> > 
> > > +#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
> > > +
> > >  static int __init iomap_init(void)
> > >  {
> > > -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> > > -			   offsetof(struct iomap_ioend, io_inline_bio),
> > > -			   BIOSET_NEED_BVECS);
> > > +	int error;
> > > +
> > > +	error = bioset_init(&iomap_ioend_bioset, IOMAP_POOL_SIZE,
> > > +			    offsetof(struct iomap_ioend, io_inline_bio),
> > > +			    BIOSET_NEED_BVECS);
> > > +#ifdef CONFIG_FS_VERITY
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	error = bioset_init(&iomap_fsverity_bioset, IOMAP_POOL_SIZE,
> > > +			    offsetof(struct iomap_fsverity_bio, bio),
> > > +			    BIOSET_NEED_BVECS);
> > > +	if (error)
> > > +		bioset_exit(&iomap_ioend_bioset);
> > > +#endif
> > > +	return error;
> > >  }
> > >  fs_initcall(iomap_init);
> > 
> > This makes all kernels with CONFIG_FS_VERITY enabled start preallocating memory
> > for these bios, regardless of whether they end up being used or not.  When
> > PAGE_SIZE==4096 it comes out to about 134 KiB of memory total (32 bios at just
> > over 4 KiB per bio, most of which is used for the BIO_MAX_VECS bvecs), and it
> > scales up with PAGE_SIZE such that with PAGE_SIZE==65536 it's about 2144 KiB.
> > 
> > How about allocating the pool when it's known it's actually going to be used,
> > similar to what fs/crypto/ does for fscrypt_bounce_page_pool?  For example,
> > there could be a flag in struct fsverity_operations that says whether filesystem
> > wants the iomap fsverity bioset, and when fs/verity/ sets up the fsverity_info
> > for any file for the first time since boot, it could call into fs/iomap/ to
> > initialize the iomap fsverity bioset if needed.
> 
> I was thinking the same thing.
> 
> Though I wondered if you want to have a CONFIG_IOMAP_FS_VERITY as well?
> But that might be tinykernel tetrapyloctomy.
> 

I'd prefer just doing the alloc-on-first-use optimization, and not do
CONFIG_IOMAP_FS_VERITY.  CONFIG_IOMAP_FS_VERITY would serve a similar purpose,
but only if XFS is not built into the kernel, and only before the other
filesystems that support fsverity convert their buffered reads to use iomap.

For tiny kernels there's always the option of CONFIG_FS_VERITY=n.

- Eric

