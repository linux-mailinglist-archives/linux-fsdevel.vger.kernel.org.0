Return-Path: <linux-fsdevel+bounces-58832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A993EB31D94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF177BB7BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F541C701F;
	Fri, 22 Aug 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGsTple6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB621B424D;
	Fri, 22 Aug 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875152; cv=none; b=jN1gqJ4CwPZjF7EiuZA0aJ5XtM6tDA5lsJ9IWwDRHjBg39aOqc8/jPvJtFCTluA8px2bjBVQMkEzE3Jvg2YSGMNVlyc5LCybCZhSC4J2KUb2JHrzFtheeaYVYOkQmxh5V+aJuriade69N+bbW/ZsbnhuDb0yxLqWsb89bhqdZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875152; c=relaxed/simple;
	bh=wjK2K3Ow/PI8/P+OwUgBRIiJhdfI9N9F3JWh9GptZyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix2sIp/1EFNeoqCPL7qFZ2BYLKS078oWyrs/sgihqrUCa3YGHkrJ/rueardgZFFFoqhZBag+mSm/qaN4JdR7lGJHJvwzTWF5TjWy6VtoX8sWyQOCS8dUdnd2hKweztLQvIWUkv1ID/NokbEm0KwF86g8vTDaxtkSwkODzzwiWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGsTple6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72408C4CEED;
	Fri, 22 Aug 2025 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755875151;
	bh=wjK2K3Ow/PI8/P+OwUgBRIiJhdfI9N9F3JWh9GptZyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGsTple6lLKrRaaLBCSH1gDq9v05VbahQt18k4z97s9FqeYYxCmEvR3lZsNneGGAX
	 I8X7WChAzsKPTThqSIVHOxmKKS4Kq4Mu5Q1kHudrjTSgZLwueC04v+jcXGsVlMD41V
	 GfuWpVDUy4jtwlT3HYILS9y6ok44TvIfWSSIY7ykFp3nrV1SU5Orz5lq0hlmfPn2qO
	 2CgXceGriLJye22Ez5QSXslnYHmzAThZUkkql40/mvRGVjYVIT2g+No8Uu4EX7liF3
	 U3ivFqexbdSWRhmf+Ebn90VC3+bQLH2OCbhJ5rbcTDSeelVCv6+txglZS/UWtH5xkj
	 CwQibbw0Aib1w==
Date: Fri, 22 Aug 2025 08:05:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
Message-ID: <20250822150550.GP7942@frogsfrogsfrogs>
References: <20250822082606.66375-1-changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822082606.66375-1-changfengnan@bytedance.com>

On Fri, Aug 22, 2025 at 04:26:06PM +0800, Fengnan Chang wrote:
> When use io_uring with direct IO, we could use per-cpu bio cache
> from bio_alloc_bioset, So pass IOCB_ALLOC_CACHE flag to alloc
> bio helper.
> 
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> ---
>  fs/iomap/direct-io.c  | 6 ++++++
>  include/linux/iomap.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 6f25d4cfea9f..85cc092a4004 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -341,6 +341,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
>  
> +	if (iter->flags & IOMAP_ALLOC_CACHE)
> +		bio_opf |= REQ_ALLOC_CACHE;

Is there a reason /not/ to use the per-cpu bio cache unconditionally?

--D

> +
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		bio_opf |= REQ_OP_WRITE;
>  
> @@ -636,6 +639,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> +	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
> +		iomi.flags |= IOMAP_ALLOC_CACHE;
> +
>  	if (iov_iter_rw(iter) == READ) {
>  		/* reads can always complete inline */
>  		dio->flags |= IOMAP_DIO_INLINE_COMP;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 73dceabc21c8..6cba9b1753ca 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -196,6 +196,7 @@ struct iomap_write_ops {
>  #endif /* CONFIG_FS_DAX */
>  #define IOMAP_ATOMIC		(1 << 9) /* torn-write protection */
>  #define IOMAP_DONTCACHE		(1 << 10)
> +#define IOMAP_ALLOC_CACHE	(1 << 11)
>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.20.1
> 
> 

