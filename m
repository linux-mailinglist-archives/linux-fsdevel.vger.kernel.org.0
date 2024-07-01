Return-Path: <linux-fsdevel+bounces-22837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C7391D636
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 04:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D261C21078
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 02:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8DDDB3;
	Mon,  1 Jul 2024 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NrV5CDNg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE58F66
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801436; cv=none; b=rLKkYeCG8bEd4IFouJLX0g2IDRrCYK5L+VpPpQtIMuYf9WDqGOSbE5ynJFeP6NydGsSsq3hCQCupSv2OfR90AtFWaMHGdyIuvrOrB4Qd6xlkgbN3yg1+sKKIw+Ow7T82wtRpdlCurMUEyDmuWjGL72FWmmFWMZsFV4JdqIhi25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801436; c=relaxed/simple;
	bh=lqwELc+8R6n7oIAYBPBASK/w4I25XITcOSCEwq6tAxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLUFpv6z1H8O06d8v02LLKkxRj0lzsvT1ls0btnWXJw8ihWnuxQz0Y40IKawP+fPO11F53enxifu5r0AsHuCe6GZxzOe/YqZPGJHmp48w5dKVp5gKeQ99af9i1EWPipvc8jTD9kn0KdF4IPSGRF/kPFZ2dEGoOP0ftKvHz2+NMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NrV5CDNg; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c21ef72be3so1408746eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jun 2024 19:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719801434; x=1720406234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0rcRCi2FGvgQgr9Zpkb36TAwmq6Gr7fbHDsnURXNUg=;
        b=NrV5CDNgIRrGPzcNNOjfnQ/zuIwjUg9MzCf8pvoPTUMDsp46T4C5UmZgSoqCwY6Jky
         qcKzIGy9GohMuMkwp/8leAYEGBDDRzSekcEXYK2+aco3iGs3QkUJc4AVZTFDpK9gLREx
         etFTC47NGkOr3rj8sHbMbB5b2H75gN3eiJqnDUxQcU2alRcRvHqZXIF2jJhxJ0eapaMm
         eCrlJo46a/7Mcspx0wneCyA7jFTZ27W1iYI8EeakGzYIxlCTDaYWOKeQE2jTkZKoAjgw
         O9i4WY6d1p0xBom9g9Wd+SIg8RCsPwsmAJJWFE+FqmL1WCEszljK5sPvXx285sEz5yEc
         3XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719801434; x=1720406234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0rcRCi2FGvgQgr9Zpkb36TAwmq6Gr7fbHDsnURXNUg=;
        b=nrG6XUDU2z5x65nubRwPGyqoNVfkNo2Ki6UnANzfvK/ixoO5EkoiEi3OTI3YBb9s0T
         n6vu8ZemW9YZLBAL1VjzKWQUX9v1W/AEC/i86A+c5xUZJXB/3uhqopkHZpGSAGiUgAk7
         34qdNlljDqV0vS22RBWwoid/GzqFp+YXYm1BBNfI8l3fc2eKtb4ZDXQNc6qtLotA8joA
         Zko2ldHctjaxv4HaSWGFPdBIA6pK1qE4YqYNUqL0XaNqR/4DrsVD0N6MpLypVlLB47mI
         WTN8aTpp61IurItN8sbzzv2yrfrzpGsf/L96TPObXLQ3SWFgL0BPEyj/wWREwWZpQ5S0
         tF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMhN7uoHwePvtopmL1UF7qm/8JBrbC1JR8pcKtZcnKFeTWdV5kWzhOsDET7NQpG+DyVcjBZcE/5yf7XX8m8bh4nwvU8gbjlUMXEc4xQA==
X-Gm-Message-State: AOJu0YzUF/TqkAxH1+ivtzWAQT8LAqFjv160ekqLCcB4X2yjQ3Se9if7
	3YpKK96kG/VsTocbbV9xqvDKhqexdfmp4nuRVgviB/whRl2NgxUFb1dWU8/3izI=
X-Google-Smtp-Source: AGHT+IEKU7/ErAzsurHPsktSpR5wwiSvxcXhKtFFLIUsLHdEdFgaLynxClPU/fi5/wA2tx9Ll0sAmg==
X-Received: by 2002:a05:6358:9201:b0:1a4:b69d:a197 with SMTP id e5c5f4694b2df-1a6acef5ae5mr474319155d.29.1719801434005;
        Sun, 30 Jun 2024 19:37:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a77sm5548654a91.6.2024.06.30.19.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 19:37:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sO6uk-00HR7V-2U;
	Mon, 01 Jul 2024 12:37:10 +1000
Date: Mon, 1 Jul 2024 12:37:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZoIWVthXmtZKesSO@dread.disaster.area>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-7-kernel@pankajraghav.com>

On Tue, Jun 25, 2024 at 11:44:16AM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Looks fine, so:

Reviewed-by: Dave Chinner <dchinner@redhat.com>

but....

> +/*
> + * Used for sub block zeroing in iomap_dio_zero()
> + */
> +#define ZERO_PAGE_64K_SIZE (65536)
> +#define ZERO_PAGE_64K_ORDER (get_order(ZERO_PAGE_64K_SIZE))
> +static struct page *zero_page_64k;

.....

> @@ -753,3 +765,17 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	return iomap_dio_complete(dio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> +
> +static int __init iomap_dio_init(void)
> +{
> +	zero_page_64k = alloc_pages(GFP_KERNEL | __GFP_ZERO,
> +				    ZERO_PAGE_64K_ORDER);
> +
> +	if (!zero_page_64k)
> +		return -ENOMEM;
> +
> +	set_memory_ro((unsigned long)page_address(zero_page_64k),
> +		      1U << ZERO_PAGE_64K_ORDER);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^
isn't that just ZERO_PAGE_64K_SIZE?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

