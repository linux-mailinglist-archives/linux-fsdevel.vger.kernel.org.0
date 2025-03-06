Return-Path: <linux-fsdevel+bounces-43381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C997AA55530
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 19:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193DF188D593
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE85026B2C4;
	Thu,  6 Mar 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jyw+1nY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463191DE4EC
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286410; cv=none; b=My31N0kqk8+eupkFXvYBrkVbcdp2NzbPdlGQT4DTXQwYdnYRhPszMOAscY+6GkamOmkNf4GvOFzjG3hQl0R0HN47AY4m0iU2xbaAxWKm4YlBh4LQjKzkXtBkveSA8g3yFGG3naKbbOdPlhRPuJHo5Zmwx/gg/vlCnbkbGYYwYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286410; c=relaxed/simple;
	bh=2VADS6s3kjJiBocvDhk8hFEg79xaOXDP2At9HSKtPt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVO1rBkh1LD0cM64Rab83ncsJHVua6UU/InD3l6eJe4zsIadvYqOa2Cdxh6ffb7RENrAn09ltKW207ZSXWk3c7F+IGd0WiSc5ahw92uqKmc2gPb2G5s1c3bnY2zAELpsLT/rsT9SJbdf28Hk8iZGlhrvdEv7VJ4ayll6haRjoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jyw+1nY6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 13:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741286395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TFfstaBlNEfLcMLYxXQf1Hl9Qzdzi50aC/F0YKZsvXw=;
	b=Jyw+1nY6+ZQg3G4R0DrjiDqpvqHVyUl4gv16T5Oe1RTFc3l9+FRi8KknOXOkQ829y2GVTg
	uCfgfApkjCrK0CEgrhIpO+GG32I+QQf0/6QKNLgYdN98omiKD3tNT7LYJQS6+Ml212M4h2
	ZSbPIRIbINc8Hz+jTL0vkOWPr2k9t88=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, hare@suse.de, willy@infradead.org, 
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com, 
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	kernel@pankajraghav.com
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <bgqqfjiumcr5csde4qzom2vs2ktnneok3gdffvu6tlyc3ih7x3@tioflbnatc5w>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305015301.1610092-1-mcgrof@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 04, 2025 at 05:53:01PM -0800, Luis Chamberlain wrote:
> The commit titled "block/bdev: lift block size restrictions to 64k"
> lifted the block layer's max supported block size to 64k inside the
> helper blk_validate_block_size() now that we support large folios.
> However in lifting the block size we also removed the silly use
> cases many filesystems have to use sb_set_blocksize() to *verify*
> that the block size < PAGE_SIZE. The call to sb_set_blocksize() can
> happen in-kernel given mkfs utilities *can* create for example an
> ext4 32k block size filesystem on x86_64, the issue we want to prevent
> is mounting it on x86_64 unless the filesystem supports LBS.
> 
> While, we could argue that such checks should be filesystem specific,
> there are much more users of sb_set_blocksize() than LBS enabled
> filesystem on linux-next, so just do the easier thing and bring back
> the PAGE_SIZE check for sb_set_blocksize() users.
> 
> This will ensure that tests such as generic/466 when run in a loop
> against say, ext4, won't try to try to actually mount a filesystem with
> a block size larger than your filesystem supports given your PAGE_SIZE
> and in the worst case crash.
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

bcachefs doesn't use sb_set_blocksize() - but it appears it should, and
it does also support bs > ps in -next.

Can we get a proper helper for lbs filesystems?

> ---
> 
> Christian, a small fixup for a crash when running generic/466 on ext4
> in a loop. The issue is obvious, and we just need to ensure we don't
> break old filesystem expectations of sb_set_blocksize().
> 
> This still allows XFS with 32k block size and I even tested with XFS
> with 32k block size and a 32k sector size set.
> 
>  block/bdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3bd948e6438d..de9ebc3e5d15 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -181,7 +181,7 @@ EXPORT_SYMBOL(set_blocksize);
>  
>  int sb_set_blocksize(struct super_block *sb, int size)
>  {
> -	if (set_blocksize(sb->s_bdev_file, size))
> +	if (size > PAGE_SIZE || set_blocksize(sb->s_bdev_file, size))
>  		return 0;
>  	/* If we get here, we know size is validated */
>  	sb->s_blocksize = size;
> -- 
> 2.47.2
> 

