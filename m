Return-Path: <linux-fsdevel+bounces-19026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A9C8BF736
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77483281348
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D242C86A;
	Wed,  8 May 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CetLzvWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD33E48F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153957; cv=none; b=ReyyCM3mduMDXA/4oOYnhPaPxCN5FKwzkfA+rIX+vn5hLiiHIzM6cS1K+OYLQMFR9vB1MjrBM71hM3axINm/n51dvjTH8GtZuMHUBT84vfvaZiOKAug8LuqKOdhzdJJuewyGhuKpy702zQ+iI+a85urvlP8ggVV2JO3WTdNOVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153957; c=relaxed/simple;
	bh=0Y+cdAgVJ5Wzm/Bku8fZNhaN9C0JgQPsf4IAnxXoyhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2dCuQIyThOq5OZXTegSlFgdEP7E5B1MctYbn37H1NVFiIy6WGPK2xJTTYRL9lnYO7bldivmay2fFqWnqLC+6dD/7erlLtuU/QwLsPmwFm/5jgtGdx9UPiaAPaOjuNpUwbyNdZbMtB3zVC+KcqQX2Deqa/OQMVP/WDVNj7MkWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CetLzvWV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715153955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FVpdoIP5MsYXu7rCIo+E46n/SCgmwnPBP9uox/R7iyQ=;
	b=CetLzvWVVdgP3y8/0UBS7cjydgDjZ3BQihZu1oY80/0j1kH9VlpykYYXe++28vNuUT/Nr+
	nZflPywS64PZPUPpJS/3vZsxZY6Qm8zqKke6zxkSr1BId4cOoAsDXOttg99M4X0nnpYSmN
	5hPU87+8AluwvPbfnvFIAUy3bESzEag=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-v1_ZJ-1VP1m8gsTN-lDKmw-1; Wed, 08 May 2024 03:39:13 -0400
X-MC-Unique: v1_ZJ-1VP1m8gsTN-lDKmw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34c99c419e7so2560089f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 00:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153952; x=1715758752;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FVpdoIP5MsYXu7rCIo+E46n/SCgmwnPBP9uox/R7iyQ=;
        b=jN9HswfA9Ygg4Q1tGrJsAP4rquUJ3lcueWzm4lvM065QdDhDvHAFP9hImcdewaRMeB
         qK0ABxU0ZSG3CjyUGb7SBHvmKH3/O63D2t+GJbmh4MuAGfTitOIj0aekXrDOwngUpLu9
         mECnNDRTTTHifGu1aYsDla5D5D0x0MPx7Ftr6RPwTHnZI1UIMHW05oyTJJ7Wley5klYw
         N7gLqEOIgwYDIcwnBeSivuzDsfLHkUjtVNRW3bP2QHB4xRAkc3rmYa+ZPtald6mCMWVF
         N3L6sQSjrC6q31SsgF3nOmYiZqd5rYoHcqqa6rYgN1fxwIQwvgfUxd8xG+rs8oueXFwO
         3akA==
X-Forwarded-Encrypted: i=1; AJvYcCXEsyXn7LEu1T0ESSHQ/Bd3C2WLei/lzEyRtLOKuRgwukpA7daKMwKaFlhB2WScntF57OOKuWUDcuhRANPJGupgX1/tFx+lYQmT/28ncQ==
X-Gm-Message-State: AOJu0YxvrXD1vLEKOV6fzOAPMlikJp6DGZthUIh2GcG5MHSub0nvNXx4
	VSqACMvBGfZWoiJQL1GA4DjmjbYoY7IqX0P1JP+Fww5gxnGbP79FCgTYhQzvrfl5Hi2JoCyIEFn
	WJ/acxI8Cesp3Cp0489QNLf270HseBIPCNp32GsK9xDhJigkQ9CFJgJCbvF1M1Xw=
X-Received: by 2002:a05:6000:4599:b0:34a:5d79:dfe2 with SMTP id ffacd0b85a97d-34fca054a97mr1258203f8f.13.1715153952354;
        Wed, 08 May 2024 00:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTOmHrKa5pFWDvRNcu/CVISPqg6g122HMr+o9Dj0SfD8mYWtCmGCyLsjc6SMQ+kU1VxmAlIw==
X-Received: by 2002:a05:6000:4599:b0:34a:5d79:dfe2 with SMTP id ffacd0b85a97d-34fca054a97mr1258175f8f.13.1715153951852;
        Wed, 08 May 2024 00:39:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3100:35c3:fc4b:669f:9ff9? (p200300cbc707310035c3fc4b669f9ff9.dip0.t-ipconnect.de. [2003:cb:c707:3100:35c3:fc4b:669f:9ff9])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d58e6000000b0034dd063e8dasm14604835wrd.86.2024.05.08.00.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 00:39:11 -0700 (PDT)
Message-ID: <939a16f2-7b66-45a6-a043-4821bd3c71dc@redhat.com>
Date: Wed, 8 May 2024 09:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Fix userfaultfd_api to return EINVAL as expected
To: Audra Mitchell <audra@redhat.com>, viro@zeniv.linux.org.uk
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, raquini@redhat.com,
 Peter Xu <peterx@redhat.com>
References: <20240507195510.283744-1-audra@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240507195510.283744-1-audra@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.24 21:55, Audra Mitchell wrote:
> Currently if we request a feature that is not set in the Kernel
> config we fail silently and return the available features. However, the
> documentation indicates we should return an EINVAL.

I assume you are referencing

"EINVAL The API version requested in the api field is not supported by 
this kernel, or  the  features  field passed to the kernel includes 
feature bits that are not supported by the current kernel version."

and

"To  enable  userfaultfd features the application should set a bit 
corresponding to each feature it wants to enable in the features field. 
If the kernel supports all the requested features it will enable them. 
Otherwise it will zero out the returned uffdio_api structure and return 
EINVAL.
"

in which case I agree.

> 
> We need to fix this issue since we can end up with a Kernel warning
> should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
> a kernel with the config not set with this feature.

Can you mention which exact one? Is it a WARN* or a pr_warn() ?

Likely we want "Fixes:" here.

> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>
> ---
>   fs/userfaultfd.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 60dcfafdc11a..17210558de79 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2073,6 +2073,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>   	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
>   	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
>   #endif
> +
> +	ret = -EINVAL;
> +	if (features & ~uffdio_api.features)
> +		goto err_out;
> +
>   	uffdio_api.ioctls = UFFD_API_IOCTLS;
>   	ret = -EFAULT;
>   	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))

CCing Peter.

-- 
Cheers,

David / dhildenb


