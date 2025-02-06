Return-Path: <linux-fsdevel+bounces-41124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7343CA2B3C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C197A36CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3F31DE4E9;
	Thu,  6 Feb 2025 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrZBVxoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103121DE2A7;
	Thu,  6 Feb 2025 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738875994; cv=none; b=GhfTTqhojRv5TJhsXZJC4j4YysRJ5KS6IWQvlfZC0VaFtyHdo3tNh4KyUfUhdz3IQ37Y1bLPpOYf+nG1rjULkQ/FxnqMtSi8yvtZYj9RjUeSZkVzQTBEZAV21OMvepaJ9XlQrlkKFTg0xpw25IGPeFJNfLbsimOnHmQR9TBnp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738875994; c=relaxed/simple;
	bh=WnxIsln6SeTusJyOWF0V7uWhxW3uWu/uAV3yLKwXn1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbKNG7Z3Kv+EVo+sPbAwCNKKyKVbVwx2KVgentKKUdQPAODbbar/ZYRHwEofet0ir2vYKch0Aj79Rk1KRiL4IWD7hhvsz4lnCXry8M9m74GGsDMn7xakl3LXJa2CJqf9gZOer7M9p1r1DkvKvVTWxxEQ95D0TST4EYeyoRRYAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrZBVxoE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa1e25e337so847324a91.1;
        Thu, 06 Feb 2025 13:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738875992; x=1739480792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjMZZDjHtCceqfzd+zK9UkArZCmEsWhxxeyu2AQZCbw=;
        b=nrZBVxoEjU27zzPZVHK3dJorygFxhdsnBeAYM9qcH2w4ah9U5mBKNSsjw3rcR/2M04
         xEX8F5T+JuLJAgu7EeMAvQS3e1ClYXc4qPZs/RFF5C8YWEVGxyjd9ZpGUw6uZyPH3NEu
         yYdj5XM/QXXw0nyZT+h0lRMyRlKAw0ArgypHAY/3pLW5BmdIql2Y80wrBEqg5Xckp3Ot
         rHQBwG16q2jslG5nT8uwVtSh8uibg6a0WXzF6rBVFtsDbQetdEwmu67Y5hgbwFD8e3vs
         yp5lEUcQuTywY3+iN08L2YjiK+Itp5twc4uuNa8IcSc+lVizjV72c6DSrYujnpCQR9jR
         ei5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738875992; x=1739480792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjMZZDjHtCceqfzd+zK9UkArZCmEsWhxxeyu2AQZCbw=;
        b=uL3ElFZpaYQ8mPEdQAcl7h0NzZrYua25YZPFVBuT5lwjA1LhUF+xe6nwhGBkhfEAxW
         tNYcTpHaAdkvk2i752Zf0tS0beuvUhiNyob3kwo6FZSQ7wJPRrhc3T6AGW7Z2MvZtabf
         EbOwyHzDNyv2tx32jxogmLxGDxum+e5iuv1HCxwIJBz6QODibfGKjTDLpWzdtZK8S0G1
         S+Pk+3PXEuZM33qfffT2YmTGI+3dhn2FcDj88Cv5vXfITe9jvBhs1ziVbrB6k0Z56kiZ
         3nk1K7YZV48hG+zySsqpcH3NK/1J6pwjsbKdYjMBD/mjIt2m4BfczuXppH2T8fJqxQwW
         raxg==
X-Forwarded-Encrypted: i=1; AJvYcCUkthufrsltSrAsY8YI1pYKkntlTTYwbUrHtf7G25dcVwMweStnFewz4sJdBnSsaLnndZMxXIDnJneJX2ZE@vger.kernel.org, AJvYcCUxhUdfSkZRoDpCsS/2oVlWuiOdj8lrKIZZv5Zmt34btzpcsTqNVUd8HDyMOg/lsMCtZbFp9WD7R6/Z@vger.kernel.org, AJvYcCVbR7hDuoN+9M9REGcegRg9E+j1do7BuAhv0ClikqM3ENNJbOpAh+VnVBbgBb95HjUuP/h5wjYiefx5roRwXw==@vger.kernel.org, AJvYcCWRh8At3ZZRKlt76jTjXztnlLTAtWO7WELIArZBML+J9G/uIJAZFDgOMcvHhsOaQshfwa7iKOeoVss=@vger.kernel.org, AJvYcCXHsSt5HFHYj9HcnhJHK6fgxFKxsL1ksIGdZuEkfr/XNLwkCMKltTcYbhBUmIhlTy6E6uYOZsTd9Ozrxw==@vger.kernel.org, AJvYcCXLfJy8PGeQTXXwmnYo0zgzgZJtcv73hrJXvKi8XxxHvrMC3CbtVKxUbRwtysRYvSseVp/OOWhPmx9z@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLXQ7fcbWOO4DzSOVFujwmoE/gIOlvhAMekIpUpfVdV+cq7OX
	W0SgOB8VqhSLlbLSKdf5d/4Uri5oj+GBQL8+dt6U2MLjbrrC1kA+
X-Gm-Gg: ASbGncs2zW6eOXT9meH4ZjwgqoYdq5SWOgT1ZyrG04QPmmmpbvV7VCUatO4owLXYQZH
	FYNRaGyiWVYgRfhx4/SztHjyPPLpDTfi4BuyIBdP0acx5uFoxmbjDOIvwksSm+fJfJF1gYPs5+s
	K5EqBzMgPPy6DRXmdpgTRU/7yxFYSaCLfJErmQHwbP9piVlucmuU2TwoFpWl9byMjhbjT56TtiX
	zgLz+R6n2vhurETyN1+pCanY2fx+zrhCuCRd+qkUOtO+IQpLO1W4V2mWqFPicPDBLf0zrge0L2f
	Zx3TP2yODm7rMv59tuQrJ96ur+0U
X-Google-Smtp-Source: AGHT+IH78/uCL9JiB7gG2UlgfTf9jp7yPy30ClKcc0/9tpp9zOrpumyNaOrCnZmQL5OMHTgXCvjCaA==
X-Received: by 2002:a17:90b:4b8c:b0:2fa:f8d:65e7 with SMTP id 98e67ed59e1d1-2fa23f43a0emr821750a91.2.1738875992197;
        Thu, 06 Feb 2025 13:06:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa17618064sm1089562a91.41.2025.02.06.13.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:06:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Feb 2025 13:06:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org,
	Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v7 19/20] fs/dax: Properly refcount fs dax pages
Message-ID: <f5e487d8-6466-442b-ae97-a7c294dc531e@roeck-us.net>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
 <b5c33b201b9dc0131d8bb33b31661645c68bf398.1738709036.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c33b201b9dc0131d8bb33b31661645c68bf398.1738709036.git-series.apopple@nvidia.com>

On Wed, Feb 05, 2025 at 09:48:16AM +1100, Alistair Popple wrote:
> Currently fs dax pages are considered free when the refcount drops to
> one and their refcounts are not increased when mapped via PTEs or
> decreased when unmapped. This requires special logic in mm paths to
> detect that these pages should not be properly refcounted, and to
> detect when the refcount drops to one instead of zero.
> 
> On the other hand get_user_pages(), etc. will properly refcount fs dax
> pages by taking a reference and dropping it when the page is
> unpinned.
> 
> Tracking this special behaviour requires extra PTE bits
> (eg. pte_devmap) and introduces rules that are potentially confusing
> and specific to FS DAX pages. To fix this, and to possibly allow
> removal of the special PTE bits in future, convert the fs dax page
> refcounts to be zero based and instead take a reference on the page
> each time it is mapped as is currently the case for normal pages.
> 
> This may also allow a future clean-up to remove the pgmap refcounting
> that is currently done in mm/gup.c.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ---
...
> -static inline unsigned long dax_page_share_put(struct page *page)
> +static inline unsigned long dax_folio_put(struct folio *folio)
>  {
> -	WARN_ON_ONCE(!page->share);
> -	return --page->share;
> +	unsigned long ref;
> +
> +	if (!dax_folio_is_shared(folio))
> +		ref = 0;
> +	else
> +		ref = --folio->share;
> +
> +	WARN_ON_ONCE(ref < 0);

Kind of unlikely for an unsigned long to ever be < 0.

[ thanks to coverity for noticing ]

Guenter

