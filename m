Return-Path: <linux-fsdevel+bounces-20529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A208D4EB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780EE2864B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BD617D8AB;
	Thu, 30 May 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="MxYxJJi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A7186E38
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081805; cv=none; b=C5OKtM72FAdiXv3bfDUWR8nyzzGep/p4rNrSGBiPAtvbbfZ79cA9DJsSQjH8w49fg+KvqKct6mdEk+f1TFVMzm1NUmOgXAyMsbPMJI3SZr6Yr4O9orFkp84cpCFHyAfOCuWvDLl982BDSxx1s0Xs961JbIZdQ+nj8Jwf+hjrdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081805; c=relaxed/simple;
	bh=aN2FGb10UwzIaqlWvr+5bXB+lbd0DnxeL6eXZB0aq3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmswQDeNoFQ1kbyRKUJm9xNJOroPjAvIQ4ahYv2InCWP8phlKu564NgaiSZjLgbUBrY8AYegoOGAoX/2Qd6C2iYlGIu13ij3Glo/jUGEe73ulC05cJbQR1I3S5fzENEAFKR3dKAVV7SeNw2E1cMtgLlE/U53e9Q3pOGA7mz/vpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=MxYxJJi2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7948b50225bso365985a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717081803; x=1717686603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1h+yJpIPUnfHN2elftbTXHU8+8yB5j/+qieJyJU0zw=;
        b=MxYxJJi28iWvfYIfmfWDPTQwNLKKotTv2spbnwElzQVoemDdyZ3mlRcXNQ+apRBUXK
         f1Fg4pXyk32MfbxMSE/WvkOnjrbsCxSaccK731iqcu0gqoVIcdnVwABYmeXpfLU+FxUj
         582vz7nbaczUNl0NogEHS04QwWm6suOc3frbyF8+rm92DyDBZ9E0Tx5CG4bWEVi9eSuY
         Rt+FM5zpMROPHTU88WYrSlZQOgNmRsb1qAXNbqOe8i9u+AGYFjBJj5rNvb8cJYr5cREb
         kja7iwb41WvSezqseLvhajhmG3raA+5MsvS3TNkVJUY4DDZLosgmd3dn+ECrF8veqGbr
         yBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081803; x=1717686603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1h+yJpIPUnfHN2elftbTXHU8+8yB5j/+qieJyJU0zw=;
        b=YzaNx8xAbM2rXVRYSgJkaQDRMX5pt4TP+hdYDL5/xtngOrWQpMGkBhS21PTauevmNO
         BW1jIVhxd8JOXahzdY9hFB4eWtrr/Vi+7wxbtShep9DdXssoyPVNxh1SY6KoEP0osFlG
         tnUiXUPL9A1hLRXNw3DpqCmq6HjoEkNtb27SYdz0Io7GPOb4O2jd+Hj4SEKr3e0EVnsz
         I8llVTRn86EF8x5+A5djppk1Km1xIBRsOxTTJy6f3r35LYv0a8jr68nGsXN8QhFSl30T
         3bmm4iG/gaidmr33T4RWFDTf/blITHpgIbY4VwTo45NE1IRtq3b78tySsBuv257bXhb3
         wJTg==
X-Forwarded-Encrypted: i=1; AJvYcCUpoz13Fckm9RpvhmZjwBPKMQ+MDn+pCO/v3td2+4mHfRiTLaMFTW++WF+srrl1+oSXfg/1ZQ6J/f65Z0oRIOh61pVh1Nc9bAE9BWsCYQ==
X-Gm-Message-State: AOJu0YwL0dUuTOmLMiD1P/8Bsr7ALhyuFb+aiVhkWzZPl/hDTbYPhyAa
	w22cTpzu8gvvVqZhOJbhMWgPziLZytfX+ZG1LOCCOpHNDFwdv7v1dq/zElqMcuo=
X-Google-Smtp-Source: AGHT+IE9GPmruKEUfq6P93JSBKNuh0HAuSj2mAje54FwOuTmaQpcBN9srFhsmHk8oE+z8lmBmzAosg==
X-Received: by 2002:a05:620a:28d5:b0:78d:5065:c5df with SMTP id af79cd13be357-794e9daa82cmr302588585a.18.1717081802736;
        Thu, 30 May 2024 08:10:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcc0f04sm561568685a.42.2024.05.30.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:10:02 -0700 (PDT)
Date: Thu, 30 May 2024 11:10:01 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Message-ID: <20240530151001.GC2205585@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:41PM +0200, Bernd Schubert wrote:
> This is to have a numa aware vmalloc function for memory exposed to
> userspace. Fuse uring will allocate queue memory using this
> new function.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: linux-mm@kvack.org
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/vmalloc.h |  1 +
>  mm/nommu.c              |  6 ++++++
>  mm/vmalloc.c            | 41 +++++++++++++++++++++++++++++++++++++----
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 98ea90e90439..e7645702074e 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -141,6 +141,7 @@ static inline unsigned long vmalloc_nr_pages(void) { return 0; }
>  extern void *vmalloc(unsigned long size) __alloc_size(1);
>  extern void *vzalloc(unsigned long size) __alloc_size(1);
>  extern void *vmalloc_user(unsigned long size) __alloc_size(1);
> +extern void *vmalloc_node_user(unsigned long size, int node) __alloc_size(1);
>  extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vmalloc_32(unsigned long size) __alloc_size(1);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 5ec8f44e7ce9..207ddf639aa9 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -185,6 +185,12 @@ void *vmalloc_user(unsigned long size)
>  }
>  EXPORT_SYMBOL(vmalloc_user);
>  
> +void *vmalloc_node_user(unsigned long size, int node)
> +{
> +	return __vmalloc_user_flags(size, GFP_KERNEL | __GFP_ZERO);
> +}
> +EXPORT_SYMBOL(vmalloc_node_user);
> +
>  struct page *vmalloc_to_page(const void *addr)
>  {
>  	return virt_to_page(addr);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 68fa001648cc..0ac2f44b2b1f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3958,6 +3958,25 @@ void *vzalloc(unsigned long size)
>  }
>  EXPORT_SYMBOL(vzalloc);
>  
> +/**
> + * _vmalloc_node_user - allocate zeroed virtually contiguous memory for userspace
> + * on the given numa node
> + * @size: allocation size
> + * @node: numa node
> + *
> + * The resulting memory area is zeroed so it can be mapped to userspace
> + * without leaking data.
> + *
> + * Return: pointer to the allocated memory or %NULL on error
> + */
> +static void *_vmalloc_node_user(unsigned long size, int node)
> +{
> +	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
> +				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
> +				    VM_USERMAP, node,
> +				    __builtin_return_address(0));
> +}
> +

Looking at the rest of vmalloc it seems like adding an extra variant to do the
special thing is overkill, I think it would be fine to just have

void *vmalloc_nod_user(unsigned long size, int node)
{
	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
				    VM_USERMAP, node,
				    __builtin_return_address(0));
}

instead of creating a _vmalloc_node_user().

Also as an aside, this is definitely being used by this series, but I think it
would be good to go ahead and send this by itself with just the explanation that
it's going to be used by the fuse iouring stuff later, that way you can get this
merged and continue working on the iouring part.

This also goes for the other prep patches earlier this this series, but since
those are fuse related it's probably fine to just keep shipping them with this
series.  Thanks,

Josef

