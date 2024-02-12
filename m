Return-Path: <linux-fsdevel+bounces-11244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B018521A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F92C1F22DE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F534F885;
	Mon, 12 Feb 2024 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lZIRA38y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CA4EB4C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777806; cv=none; b=LHyBdmi6e4XLSzsRCcmfCf15T0Psbs7kVQ1gUlmKQvnmEPhJVe2V1Kzs9O5h4M/gKREf480ij71ksYHsB5OAC5MK1WOeHUPV8HA/uYah91IjdBt8LJ7ZCc/duOemLmbKmUHrjg6lSARVQw9t6Qkflmj7Xd7owGMyoXbhM+Y0SCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777806; c=relaxed/simple;
	bh=ZRXcT6h1io+pAz7R5dW+T/d2U31m8Pyk0TbI2mbrBog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sH+eHZgHnqeg8honaAsB4oORHHTO3t3EvB+2tQUGO+ayNTZJbNZl5+PQt+R3fKBEujYjmXv2Kmui9wq3bhxixPeECyKtGCfdrOvGEtgl1B62gQiBbhCTpbPsU/p/w3lUZPQJchdq/C/aDZHK2DEeGEapsgCFI9/9I1kdDHxd+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lZIRA38y; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso1569195b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 14:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707777804; x=1708382604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHfbSvdCb97XCfftcH6VJtR+XcLQrp5kkgikwsWfekY=;
        b=lZIRA38yhH4sVSnXUtFKw6wI5cs0/CdNpabdM36ZqJHOc2wkKgmadNElm1JkkmTDBA
         a49m3Ao84M5nRf9uC9Uc3RI2Mye5RUXZlGOioiCIvedOw9beMcHEfoGQMn2X34q27Nii
         6BzR2ohKvwWcgX0ToaNy4jGxlncFdXHkzeab8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777804; x=1708382604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHfbSvdCb97XCfftcH6VJtR+XcLQrp5kkgikwsWfekY=;
        b=AFnIjvQ1k5XHFRN867jM4NvzZYCPjeDBYeEeQc1ssb5eAvvP5KZY+Ooy65I8/gcDSQ
         uRdtje5sfvIzxOz24vqNMv7EOJwB1MSZSDDSsKtVrKMd0jr/261bUYtsdLe81JBiC6v0
         qf+wkH1koM5qwEwCjSNoYBSJQ54cokhojzGJEUaSuXAveCjCGW6zlBHn05Y0yEnMU+Cw
         AneSpJsoa/f2yibJrawtq3cSmNgValjJLBKsuUKzv3KzK3FPu1LY4Q1v1bd+rOaK2o6t
         B6XXBj0VVT+eLXzWn8tk7yfpjw+h0MDe9+2ffKSYxJHbqLgu8w3BXInrazR9G+jW9hji
         Mbbw==
X-Forwarded-Encrypted: i=1; AJvYcCXoGQuOpujK6V+xDVcy9kt/DjiW6vk0/cN9LPcuB6RiRbfL63sFHCM1XbLVOTpP2spzejEwyfSQLXdOpyLmTcP2U1YcCWaG4eCXyKiBmw==
X-Gm-Message-State: AOJu0YzyDPLBM+H/sGbiPofL4uuo6qN7sL868R7TKVsx1huElr4zkBYs
	mpawo7CuvkvT6D4mlmqydoU4NCuq2N4nzXiL5ES4WyKFvIOevV3Fvw3nvnv7ig==
X-Google-Smtp-Source: AGHT+IE1SUWbi7xbPMjzdFosvgBZwOYGjAgNpaBRfn1FeSiVT2f0mVT31t9sRlHoWVQBsJKxte0gDA==
X-Received: by 2002:a05:6a20:9f06:b0:19e:a3da:7199 with SMTP id mk6-20020a056a209f0600b0019ea3da7199mr6793407pzb.57.1707777803818;
        Mon, 12 Feb 2024 14:43:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVw2sYVJTSy8mTs4gLDRJJ8x6daiYTcqQV4AOqAc4AZrdWyoi6sVmXghyKPYB/yl0jgjMrp5uzTHB3mEPgTng1/keWfLYlsgax6bhlEVKPPbSPWbRudgsXKaj5srGLDsbluUL6CTivqVH4yeswYovvlFoLTG5xxP9FSE01Rt8ekhJbYBPfAqZcybccklpohUxN8Jmi2Z+mryKjfWFqG8cz7hBAwDXG2/CKA7ixcoyDbUKyRIHv5ipb6PqLkFrE4X6Y60iJBYeTXbtgKpwF2F+CON95Q9TWgRX5oDPk5hZCsjblvzwzllW+sXe7AhESfRHDlwYRbaEKHsuKY19Vpv34euKQwV/avHQqW6P5xp6TmS9dxmjZ364wtvlTKK+HSQowZnZ+uxopskDHQsV0qLNa/0x0DfSFTsOEbVYTvyhoQRFWFuun/EWKXMuy1qBhGEd3Kxl1AlUHjJ5Yb0VK4DfhkL5a2H4B5EOXwxjGISfD3fNakcZHAGDDlo+fstSMuq7U3l1JjZ4VUd2yoyf4zRLShIeKzdplmtj4FDAM+uNCU2VvR6rMQ8hXSukrN7GcnT4nxCtqxPtR54+04pNmdOBnUw3Mf14xsdK9A2hpHGvF8gStLe+kD+4ZUQEd4nkPRSUtC3zyGWFgRq++5pE47tyamw5Uc/RemgBCL5sTV/51AlKmkMNQyK0JnKzcMJrPpE01p+0Qr25Wo2ooot1he55Q5+UCuNsDNzLex4908ESZTGV1rwHz3BQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je17-20020a170903265100b001d9351f63d4sm836249plb.68.2024.02.12.14.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:43:23 -0800 (PST)
Date: Mon, 12 Feb 2024 14:43:22 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 35/35] MAINTAINERS: Add entries for code tagging and
 memory allocation profiling
Message-ID: <202402121443.C131BA80@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-36-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-36-surenb@google.com>

On Mon, Feb 12, 2024 at 01:39:21PM -0800, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> The new code & libraries added are being maintained - mark them as such.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73d898383e51..6da139418775 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5210,6 +5210,13 @@ S:	Supported
>  F:	Documentation/process/code-of-conduct-interpretation.rst
>  F:	Documentation/process/code-of-conduct.rst
>  
> +CODE TAGGING
> +M:	Suren Baghdasaryan <surenb@google.com>
> +M:	Kent Overstreet <kent.overstreet@linux.dev>
> +S:	Maintained
> +F:	include/linux/codetag.h
> +F:	lib/codetag.c
> +
>  COMEDI DRIVERS
>  M:	Ian Abbott <abbotti@mev.co.uk>
>  M:	H Hartley Sweeten <hsweeten@visionengravers.com>
> @@ -14056,6 +14063,15 @@ F:	mm/memblock.c
>  F:	mm/mm_init.c
>  F:	tools/testing/memblock/
>  
> +MEMORY ALLOCATION PROFILING
> +M:	Suren Baghdasaryan <surenb@google.com>
> +M:	Kent Overstreet <kent.overstreet@linux.dev>
> +S:	Maintained
> +F:	include/linux/alloc_tag.h
> +F:	include/linux/codetag_ctx.h
> +F:	lib/alloc_tag.c
> +F:	lib/pgalloc_tag.c

Any mailing list to aim at? linux-mm maybe?

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>


> +
>  MEMORY CONTROLLER DRIVERS
>  M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

-- 
Kees Cook

