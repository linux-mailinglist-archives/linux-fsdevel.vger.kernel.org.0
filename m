Return-Path: <linux-fsdevel+bounces-20384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257CB8D28D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 01:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9F71F22ECA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 23:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC713F45D;
	Tue, 28 May 2024 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nqrMqUvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6713F437
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939902; cv=none; b=Z1ts8Gg5D2oPMY3oLFJg4vMW0/M2O2/i9QzytgHXjEliWiC6S2HyaeyMzwW0MEBV7sWc9CUZUzKfZkiCx4IiChH5mSG+v+V9cCV2PRBlqpQzr8ukAMMak90XWjmPP/yDyA/ClayOMrOvBHDrvoK1Ss14iP/ZLxD+P+bik/+U0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939902; c=relaxed/simple;
	bh=mr/MO+fNkNgg4F8Y4uGadmn2Vsgt2BU9+rJyJC9Z5Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNiGVt5jpDmSlRvbjKYPNq/LAi9ksJRctxrbvFhXf1D27cavCmEGjO/unCi5+zbLdwne+noc/IBSDyJvu4agvOxHzi7J73v1pURqEaJQpMWf1QexbKr00ToxuxUHO9qxpCAReBCgYrsrq4VEd+JnjXmKLl/zX7dtfNFG9ORZauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=nqrMqUvk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f4a52b9589so13091495ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 16:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716939900; x=1717544700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rV73vuix245isCSLYh7PCMFUHcN9E8Ebwy5VWHsQjBI=;
        b=nqrMqUvk0OEq/fR+nSJe1stpa6ot3Xx+lSa1FZibFHxkduO0xh9yIIx0IShzKNxYEu
         h9nGaXsvpV8ewA3iuKCJvXIpVmvxkhQabFsqSFmN0oaG5pEjrOlsGnQ76vLB9ZNUTnM/
         XxCNU3gYVlkJM4f6Std82HOTyKGm2mnnxn+xHdISqmHTD/BL4x+qmJZ4AhzfEFcgDeCM
         sUTbS8OHUJGnucJmrMdJXfe3nDUvLSlHUTf1YYpQfRarmUebAfl1FBdyHFx0Qg/p2sGn
         8jReFVVJ0Tp3seM1zsk8ST1NuuoYUXoj3BVTl9MWhTT90/91uoXRqmsEOf5FK9cIFuM9
         wGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716939900; x=1717544700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV73vuix245isCSLYh7PCMFUHcN9E8Ebwy5VWHsQjBI=;
        b=vW3IRwYzDPBaDftL66eoly7gNXuYeMM1e0fbVmCQFTZI/1K1Lzc3UEEEY1OGrX5aD6
         Lk9L1JGXZhTtWAwmjs/1Fw0pzDQlCVfJy4nCZCBRoEYMCzjjSy//OoazWTi/D8+QDHRD
         UJw7YPi4imaBmMYR/AzqHcXbS70yOOddAE5Xbenynj71Rul0G5aG6g1HfBCP3b8POuAk
         j5O/nxo5J9NEsA3v/ROD20LUPuX3dAKuxkRCVMi2/edXOKre1pXKSbh3niJfhG4rg+ku
         kgUf4ylkbGalq4hXZeVMibHG7j8iOM0YWby+4/oLbiUQJZAPI9PYNSyMlP5BmA53xdnW
         tRFA==
X-Forwarded-Encrypted: i=1; AJvYcCVfVxgPHrZXdzj9S1Ka26IFopfbA+vNnPnbj9veyzVfsd0W+uHYnHE6utvbE0zTyNF+RnxJtn8UAeNFqFxJHmxY6aFFGQ90GJfRXfDDoA==
X-Gm-Message-State: AOJu0YxoMS0oCeKPYfA0JhnXBgJDQ78YsBd9ET+RSERF2PDX3UxAdJuQ
	Mdkfkn5wS6EihpVB19/Ald4816SHxMZe9bw6E1ovyJG9iqbGUn2wLORqfRCGWGk=
X-Google-Smtp-Source: AGHT+IGz85Svjfg+B724cWX5DrqXY9hBYAD5efVSdGipF1RKxUjlbPVtp2UHcihevi1+D2sE20yrCw==
X-Received: by 2002:a17:902:f788:b0:1f4:26e1:56d2 with SMTP id d9443c01a7336-1f4497d7a4emr136998195ad.45.1716939900168;
        Tue, 28 May 2024 16:45:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9bb73asm85705415ad.267.2024.05.28.16.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:44:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sC6Uy-00E0l3-0j;
	Wed, 29 May 2024 09:44:56 +1000
Date: Wed, 29 May 2024 09:44:56 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] iomap: Return the folio from iomap_write_begin()
Message-ID: <ZlZseEfwzD0m7bOC@dread.disaster.area>
References: <20240528164829.2105447-1-willy@infradead.org>
 <20240528164829.2105447-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528164829.2105447-8-willy@infradead.org>

On Tue, May 28, 2024 at 05:48:28PM +0100, Matthew Wilcox (Oracle) wrote:
> Use an ERR_PTR to return any error that may have occurred, otherwise
> return the folio directly instead of returning it by reference.  This
> mirrors changes which are going into the filemap ->write_begin callbacks.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c5802a459334..f0c40ac425ce 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -764,27 +764,27 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
>  	return iomap_read_inline_data(iter, folio);
>  }
>  
> -static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> -		size_t len, struct folio **foliop)
> +static struct folio *iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> +		size_t len)
>  {
>  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct folio *folio;
> -	int status = 0;
> +	int status;

Uninitialised return value.

>  
>  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
>  	if (srcmap != &iter->iomap)
>  		BUG_ON(pos + len > srcmap->offset + srcmap->length);
>  
>  	if (fatal_signal_pending(current))
> -		return -EINTR;
> +		return ERR_PTR(-EINTR);
>  
>  	if (!mapping_large_folio_support(iter->inode->i_mapping))
>  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
>  
>  	folio = __iomap_get_folio(iter, pos, len);
>  	if (IS_ERR(folio))
> -		return PTR_ERR(folio);
> +		return folio;
>  
>  	/*
>  	 * Now we have a locked folio, before we do anything with it we need to
> @@ -801,7 +801,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  							 &iter->iomap);
>  		if (!iomap_valid) {
>  			iter->iomap.flags |= IOMAP_F_STALE;
> -			status = 0;
>  			goto out_unlock;
>  		}
>  	}

That looks wrong - status is now uninitialised when we jump to
the error handling. This case needs to return "no error, no folio"
so that the caller can detect the IOMAP_F_STALE flag and do the
right thing....

> @@ -819,13 +818,12 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	if (unlikely(status))
>  		goto out_unlock;
>  
> -	*foliop = folio;
> -	return 0;
> +	return folio;
>  
>  out_unlock:
>  	__iomap_put_folio(iter, pos, 0, folio);
>  
> -	return status;
> +	return ERR_PTR(status);

This returns the uninitialised status value....

>  }
>  
>  static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> @@ -940,9 +938,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			break;
>  		}
>  
> -		status = iomap_write_begin(iter, pos, bytes, &folio);
> -		if (unlikely(status)) {
> +		folio = iomap_write_begin(iter, pos, bytes);
> +		if (IS_ERR(folio)) {
>  			iomap_write_failed(iter->inode, pos, bytes);
> +			status = PTR_ERR(folio);
>  			break;
>  		}
>  		if (iter->iomap.flags & IOMAP_F_STALE)

So this will now fail the write rather than iterating again at the
same offset with a new iomap.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

