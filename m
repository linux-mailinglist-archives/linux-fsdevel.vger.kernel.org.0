Return-Path: <linux-fsdevel+bounces-13956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB6875B30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 00:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8765B1C2127D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444CF47A7D;
	Thu,  7 Mar 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqunHwWa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8E2D050;
	Thu,  7 Mar 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855123; cv=none; b=UxLdgrTbiyghhzhelAGpLhHR8/IJnVSmRx3HLR4tQHxRAKEmwTphrAMYlq+9tMz4oEYBP4aWSKCXhCWLr+TLhcV1H6JwmPQj2qyu1pE88qPirSp3tnatgOlob985f88X4q3OlPkZMVSpSl9d8AbyEIxsQ8xv5nI5P6a6BRkbc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855123; c=relaxed/simple;
	bh=oA06qcDoEvHpe8TMJ0oaAha03dVKQEp2aYwDa6ezK2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuIwP0MptpRTzANnYGuhzzHK1PpwIiw0d5LMMuE6eoeh/FxxBcjH6nJ9ekT03yyxKqfKlzotoz9pNxp2kfWsJpaWSDLgylmc1OzPh0ydy3SXeF28SyD8l54f/KGeVmDAcbspUx24IOEIwKBzDIPx2dMkVXRKEPQlzwirbXsiRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqunHwWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DADC433C7;
	Thu,  7 Mar 2024 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709855122;
	bh=oA06qcDoEvHpe8TMJ0oaAha03dVKQEp2aYwDa6ezK2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqunHwWaOO/SVpsIp+bapHMXJQsVHxFY0/LEVKleEJu9tmL2A1cHG6HVRneb0KivF
	 c8ydNrhfTjjAyf1D+TncufadLLA3gevHsvuLD5F+CPiE7zeTNMZ+xe996f9wNQiSEq
	 KhNoho/Davr/f160voj6So7sD1M8+MqyNYHXD52FCYXeHa+0GFDuild7ITBn79b3a/
	 r2XzTKKVReM68y5+2xu4XNy8Fjk06ViPJfYY76R3K8HUzdqWMa31CXhtjAQSKIPtcW
	 A3Du5bnW/utsIycuno9MxWS8SVlOF70DuQiSslm33VjxilKPMivABt/coifAyEQWox
	 f7RS2M612avmA==
Date: Thu, 7 Mar 2024 15:45:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20240307234522.GJ1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-12-aalbersh@redhat.com>
 <20240304233927.GC17145@sol.localdomain>
 <ZepP3iAmvQhbbA2t@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZepP3iAmvQhbbA2t@dread.disaster.area>

On Fri, Mar 08, 2024 at 10:38:06AM +1100, Dave Chinner wrote:
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
> 
> Honestly: I don't think we care about this.
> 
> Indeed, if a system is configured with iomap and does not use XFS,
> GFS2 or zonefs, it's not going to be using the iomap_ioend_bioset at
> all, either. So by you definition that's just wasted memory, too, on
> systems that don't use any of these three filesystems. But we
> aren't going to make that one conditional, because the complexity
> and overhead of checks that never trigger after the first IO doesn't
> actually provide any return for the cost of ongoing maintenance.

I've occasionally wondered if I shouldn't try harder to make iomap a
module so that nobody pays the cost of having it until they load an fs
driver that uses it.

> Similarly, once XFS has fsverity enabled, it's going to get used all
> over the place in the container and VM world. So we are *always*
> going to want this bioset to be initialised on these production
> systems, so it falls into the same category as the
> iomap_ioend_bioset. That is, if you don't want that overhead, turn
> the functionality off via CONFIG file options.

<nod> If someone really cares I guess we could employ that weird
cmpxchg trick that the dio workqueue setup function uses.  But... let's
let someone complain first, eh? ;)

> > How about allocating the pool when it's known it's actually going to be used,
> > similar to what fs/crypto/ does for fscrypt_bounce_page_pool?  For example,
> > there could be a flag in struct fsverity_operations that says whether filesystem
> > wants the iomap fsverity bioset, and when fs/verity/ sets up the fsverity_info
> > for any file for the first time since boot, it could call into fs/iomap/ to
> > initialize the iomap fsverity bioset if needed.
> > 
> > BTW, errors from builtin initcalls such as iomap_init() get ignored.  So the
> > error handling logic above does not really work as may have been intended.
> 
> That's not an iomap problem - lots of fs_initcall() functions return
> errors because they failed things like memory allocation. If this is
> actually problem, then fix the core init infrastructure to handle
> errors properly, eh?

Soooo ... the kernel crashes if iomap cannot allocate its bioset?

I guess that's handling it, FSVO handle. :P

(Is that why I can't boot with mem=60M anymore?)

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

