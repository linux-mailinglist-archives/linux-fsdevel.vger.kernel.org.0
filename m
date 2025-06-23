Return-Path: <linux-fsdevel+bounces-52607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FBAAE47F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191543A5BEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C1C26FDA8;
	Mon, 23 Jun 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofuqf63q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2D72624
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691205; cv=none; b=ME4rkUcBAfeOfoB5KkbCS2Ite0cQ2Z/lXhJ5k+j4XRvWpvs0tE7B5750ZqYpLXlu91KgYAnGMLRndgGVUYFED8e8Ymgb6u9PvDbksipY2olJ2dqLiEZN3/mEnocjxhnoVMMZABAPo8XDAQndGuDtYbF/JoeSh0oRJIN0/7doniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691205; c=relaxed/simple;
	bh=wuFXrwwjjmEMgA8swF0EHEAsKQSn7YRia6AOViQcc2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcnosvmBh2vwL0cR2aELfYqE3DoLpUxs2loxNsnB+wHPwhI0AZDmA/N0n+fQYm0i8n+hjO5pWofRYu0juvOxywc+pxARUSykPEjJutj2xRdfrXAhiAb/tCNTmisfdSdl8C+HzBfQ7pNYBeDKfknbqj2OrLeOmpitjpWlPfQ6a1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ofuqf63q; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4067106dd56so2857690b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750691203; x=1751296003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/j2ABvQkeCCIY5OdnUsm4f6l2yn5EMgYcd1gCoSvvo=;
        b=ofuqf63qV7wvQ1Ggu+d1azimjAgztFr8vMiAndlSU8PajIHg2bdy6A5/5k8FU0A04o
         S151GjJEFyoRNgLY4jvBj5Msu7/s+NYsyvbWUO+3gIbe+4+mYLVRn3/sU29LM50Xtug/
         VP0OoBhYJsNvPXDmuKk6DWCYOhdW1SfnvGgvX+3DczM/Q81oFEHNd+g86CBBple0dfb9
         de4xyS/XPxxMmY41JVBZyf+nOD3gjqe4FQgPf50DUsO1PTa4+EQE//YFmp+HxV5PBpt7
         S2RSBYJvh/cHAIhZM9Eu81h5+DDf/1jw+D6hhFiw7vLpAdP4UEmal7pS+d2BHxIWXa0N
         yyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691203; x=1751296003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/j2ABvQkeCCIY5OdnUsm4f6l2yn5EMgYcd1gCoSvvo=;
        b=LzFQpISRQNd9eS1NFPqTtRZICWy+XF2xtI55qj4bze7ZKiCiIH4L2wyFjmtlO1bvvW
         YouNt8TwFgzMr9RjjbZ1I6HO22RcHbCo87Rhe1hDLqgPI+WIK4R7m+6567ezclGmsyvo
         /ciFB8e/M5mE71KlN8cWzpa/SbmUYeJ6KBHWfAoR3dlpc+ZYJnfGzBhtQS04dcovlm8S
         ka8hHwE/QtFWhjCWHFOkXHjT+zzrPWNCCXc73kYxcX430A9T2CXI5qlTend+fGImS0oR
         4aKnjwDbUZ84RM5D6cWgHKLiiXXmAboBpQCiJBcelCiq9l0bZl4WkFRkbKDRozED0nwr
         403A==
X-Forwarded-Encrypted: i=1; AJvYcCUQm1PPKraxaZ9gqszfPo4E5XJJMhDCcH8cVgi1dXN9W3BVQiFSHnl//AFhqhtpDtsNi2QhyPEnYEgAf/XI@vger.kernel.org
X-Gm-Message-State: AOJu0YyawtR1vkjEjASlhH1PqqfmH3yvcke/gH9NHgIBq1WOIQlcu5Ah
	AvbCtnexIRLLkQS0Zpdq7aspNieN1ZwT/UV2+xQmEp5u1QJBy49gFAXLHpg+1oR3L3w=
X-Gm-Gg: ASbGnctMHWwC8MsUZwbs/qWCRIzjp2xkGO8b4Z/WCEQgsKdX45pWAKt27ak0GU9BYMG
	w3hTcY4otzecIQ7P38ggoURJuwKPAB8I50NuAJjEg1z6bnZSSTDAlSoKUloy6Y1r46EWv9ufwby
	O6eyOjHxjTFrFT6LtQ14ef65lDyoHbQkU3kTU+RU+YZ+CqgrT6GZTkLjXd3r9dBRPcjMYAjAttc
	2p4hmLzWDTKuU+jap5zp1ftc8Ctq14WHleTPwcEXs2jc4M4tcsRUjdM38cnZDykagbxkf8lQrJS
	8uZ8FqzcTJlrb/McZGHD95VQCcPMXwYM1B7G5Mq+q3XoNxJlDvzr9AnMZIOiqNjO0axfBw==
X-Google-Smtp-Source: AGHT+IFnVBRfIjftIm0z+2nD3hcauMaTIzLigckSJhjmKqki1siCULVluA8fvloI9HOD+FViAKSc5g==
X-Received: by 2002:a05:6808:1890:b0:406:7704:b2e9 with SMTP id 5614622812f47-40ac6fe36d7mr9778035b6e.9.1750691202870;
        Mon, 23 Jun 2025 08:06:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8c3f:8b5f:5c74:76a9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d394dfsm1419658b6e.43.2025.06.23.08.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:06:42 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:06:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Message-ID: <33a9a2a5-a725-4ab0-865c-1d26e941e054@suswa.mountain>
References: <20250623104704.3489471-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623104704.3489471-1-suhui@nfschina.com>

On Mon, Jun 23, 2025 at 06:47:05PM +0800, Su Hui wrote:
> There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
> type from 'size_t' to 'unsigned int' for the consistency of data->size.
> Return -ENOMEM directly rather than goto the label to simplify the code.
> Using scoped_guard() to simplify the lock/unlock code.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/proc/vmcore.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 10d01eb09c43..9ac2863c68d8 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1477,7 +1477,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  {
>  	struct vmcoredd_node *dump;
>  	void *buf = NULL;
> -	size_t data_size;
> +	unsigned int data_size;
>  	int ret;

This was in reverse Christmas tree order before.  Move the data_size
declaration up a line.

	long long_variable_name;
	medium variable_name;
	short name;

>  
>  	if (vmcoredd_disabled) {
> @@ -1490,10 +1490,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  		return -EINVAL;
>  
>  	dump = vzalloc(sizeof(*dump));
> -	if (!dump) {
> -		ret = -ENOMEM;
> -		goto out_err;
> -	}
> +	if (!dump)
> +		return -ENOMEM;
>  
>  	/* Keep size of the buffer page aligned so that it can be mmaped */
>  	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
> @@ -1519,21 +1517,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	dump->size = data_size;
>  
>  	/* Add the dump to driver sysfs list and update the elfcore hdr */
> -	mutex_lock(&vmcore_mutex);
> -	if (vmcore_opened)
> -		pr_warn_once("Unexpected adding of device dump\n");
> -	if (vmcore_open) {
> -		ret = -EBUSY;
> -		goto unlock;
> -	}
> -
> -	list_add_tail(&dump->list, &vmcoredd_list);
> -	vmcoredd_update_size(data_size);
> -	mutex_unlock(&vmcore_mutex);
> -	return 0;
> +	scoped_guard(mutex, &vmcore_mutex) {
> +		if (vmcore_opened)
> +			pr_warn_once("Unexpected adding of device dump\n");
> +		if (vmcore_open) {
> +			ret = -EBUSY;
> +			goto out_err;
> +		}
>  
> -unlock:
> -	mutex_unlock(&vmcore_mutex);
> +		list_add_tail(&dump->list, &vmcoredd_list);
> +		vmcoredd_update_size(data_size);
> +		return 0;

Please, move this "return 0;" out of the scoped_guard().  Otherwise
it's not obvious that we return zero on the success path.

regards,
dan carpenter

> +	}
>  
>  out_err:
>  	vfree(buf);
> -- 
> 2.30.2
> 

