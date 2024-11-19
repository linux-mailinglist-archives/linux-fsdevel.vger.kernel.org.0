Return-Path: <linux-fsdevel+bounces-35171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F229D2006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 07:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4A3282908
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F3158874;
	Tue, 19 Nov 2024 06:08:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E521154BE2;
	Tue, 19 Nov 2024 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996509; cv=none; b=DJqdxTLd8dgDJfxj2P/WQjBvW8gLu+ASGirHVflyQxKk33yuvUZqGNtcZz0/3fujgWogusL0y2LdxZeiejDSpWOXiO8uUiOhRmsNYxQE/ldtJAMqSAbuwd4AT6SmHeEaMFw7OLdzjnDxfB3/WXKADGiQee3cpA6moeXVAE7iEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996509; c=relaxed/simple;
	bh=OSPxx2KXtuR8U7uBsWjVmrwaV1AdQN3dxr3DcC17eWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odC8SSdtP39R+ZPcQwTjBvmt/23Mcb6sWNNgb+9mg4gxFW1eVlIbZlFXZOoAv3fPlBUSjmLmTyyGcnL/eMq05pCHxyyA0GZkY+s41oKllrAxMr7Ixvc9Gfthwa5jrzuAyxkldqsiEpZjOoTiHoMMirVnTgPDgpge6eBDy2kWHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5370168D4F; Tue, 19 Nov 2024 07:08:16 +0100 (CET)
Date: Tue, 19 Nov 2024 07:08:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, willy@infradead.org, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com, nilay@linux.ibm.com
Subject: Re: [RFC 8/8] bdev: use bdev_io_min() for statx block size
Message-ID: <20241119060815.GA7159@lst.de>
References: <20241113094727.1497722-1-mcgrof@kernel.org> <20241113094727.1497722-9-mcgrof@kernel.org> <20241118070805.GA932@lst.de> <ZzuutQp5HzZp-lCQ@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzuutQp5HzZp-lCQ@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 18, 2024 at 01:16:37PM -0800, Luis Chamberlain wrote:
> On Mon, Nov 18, 2024 at 08:08:05AM +0100, Christoph Hellwig wrote:
> > On Wed, Nov 13, 2024 at 01:47:27AM -0800, Luis Chamberlain wrote:
> > >  	if (S_ISBLK(stat->mode))
> > > -		bdev_statx(path, stat, request_mask);
> > > +		bdev_statx(path, stat, request_mask | STATX_DIOALIGN);
> > 
> > And this is both unrelated and wrong.
> 
> I knew this was an eyesore, but was not sure if we really wanted to
> go through the trouble of adding a new field for blksize alone, but come
> to think of it, with it at least userspace knows for sure its
> getting where as befault it was not.

Huh?  The only think this does is forcing to fill out the dio align
fields when not requested.  It has nothing to do with block sizes.

> So how about:
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3a5fd65f6c8e..f5d7cda97616 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1277,7 +1277,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
>  	struct inode *backing_inode;
>  	struct block_device *bdev;
>  
> -	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
> +	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC |
> +			      STATX_BLKSIZE)))

Just drop this conditional entirely and you're fine.


