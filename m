Return-Path: <linux-fsdevel+bounces-38864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE6A08FBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919A2188B4A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC720C001;
	Fri, 10 Jan 2025 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLILecPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E7204C11
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509919; cv=none; b=pZFpODpO5H57h9twtJerh2hQxsINauUevttyz5Aec8g2f8xvw3z86aUTN9gGejUSJtSQTi0YMPBNRnhPBF3XdJMlOnS/CiNEIOU82bXhLh5TGRbiIcDZy57LlFGBTr/MvxDt/ORRUqYcluIMH/CBDNqryJSIRIzJkK/ZK53SL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509919; c=relaxed/simple;
	bh=YV7GmQKqg7lNtZgyhSg6UFYi73qjEM3setYvQpJ1qVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtIIGKmNAqnScNc8cOChDeA4XVH3mqAX6BjQkFJu54BhByLKGW8yzaEWSIUfkgwI20EXnKFkvudoX8bHObON49xG+xXIzOXWV56N9XonpozMz6MYsM1TrW5wvn5bL2dDdZgXOM/ZQind9L7IPqvl+odZYbkoCsVL9z9ofaBtq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fLILecPY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436a03197b2so14269345e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 03:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736509916; x=1737114716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5CDjoH/Bj4sC3csaucGOxK7bWFGpVLWDds1mIa0onws=;
        b=fLILecPY9NeA+AS3t5ue8chMv1Ob/pcKEuOzaL+Li3wos9F4qCPZkgmMHmjWhoK8Qd
         p+2ItSSR5D389y9/c3VXtc2WP2WlnwTP4myLUHbXvgK/YnM2qt8u3M+AeS7g+ZConJuQ
         +1vupOA7g/0QvJCiuUOc8nJXyuNrsiUcBHSM6fxlkY3Yjo9cF6rzOxQJTo1NpabEYvc2
         jHUg/gbscT1HVFBhp87fSAcUuEvYsQYoPr4DZwNUOi9MQcGgEuYrDW0GPARHSD5mlyUl
         mcwc8bh4l64q5NtbrrZ4hyqOO1d/WeXXqsy8yylhOnWewB7NBuvMfb1gsmZ7EY9RQAgD
         4ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509916; x=1737114716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CDjoH/Bj4sC3csaucGOxK7bWFGpVLWDds1mIa0onws=;
        b=xJUgearRu/cB/PH4xC0Pi+desCXYPEhAbuEiKgdbzXDRB/WDcYhboFvePSuMhjoyJ3
         JiLs9fBO+dyYSwzzxndbtiUO1alxJEL58mGmIYREU390/CwRVLrjkGWXnrDlruMY0bqm
         M3L+FJcM6iimqL5dG1UEoyts9D3T3XFS1vlC0Xu/oZtTiSqWL2dWNec18GGvmvNjMs3z
         CGUO/MqQR5G8FdVeRDWvbF3I//t4plvOzBHqKHurSi54MxrU/6L+E3wyhgq1EkgDT6Bn
         rmx8GE95ymdVDhNMD146J0mRsAf+6PgqGgPjPosUdij8fDtxyT3L30UetKXD8+3OtIBr
         u8VA==
X-Forwarded-Encrypted: i=1; AJvYcCXfCJ681d2XIKqO8FkY6Tq7At/5Uh3uKq4VTbpSJJhM6brq13jyG1d59lZOi2tBhxKh9hRvnFDliDhvoP4Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyWEjw5ZBGb2Bdq76nARMb3naGDREDy3/ZTQra+nBD01qsxtvtJ
	Q9cD/QoM2Y6A2y6sTZJWsxwHevv1QdtI7x4US0wctQsUwDjNuJvQKs3DqWTm5yA=
X-Gm-Gg: ASbGnctUzPtm4c9JBWTIWcYc7kinGc3MOkb0tsV2mLbMWlUN9eE2eDEBq7650l2hQ+z
	+J2CS6hGH9AfED8VDVpLEMqH2q7tN4/E9lNp+jD3wJpaQzfPagsuEpNGMkMy9ZOORzrebd7XlFi
	JtCpT/dHecnb83clvqKijw4o9SStj0XbuCsdv2vSoozKI8LEbFPU06FigSjOjXCwusaxA5ZcxKx
	WOMXb4iUCIADzxewYfZUTbMCtwwX4uaKHH4OlwVt4/bX3GcWG/27h7pMl2ZbA==
X-Google-Smtp-Source: AGHT+IHKediC199TcMSxu21acE0CN/02tK8RHMMIB+sspKStxvJN02qDARg/u2Qf3U6RMNr9mfLUwA==
X-Received: by 2002:adf:a44e:0:b0:38a:36a5:ff81 with SMTP id ffacd0b85a97d-38a8730e0admr7718927f8f.40.1736509916395;
        Fri, 10 Jan 2025 03:51:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c990sm4384653f8f.56.2025.01.10.03.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:51:55 -0800 (PST)
Date: Fri, 10 Jan 2025 14:51:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] binfmt_flat: Fix integer overflow bug on 32 bit systems
Message-ID: <f946074f-60ed-455f-bcc7-4364f15b9603@stanley.mountain>
References: <5be17f6c-5338-43be-91ef-650153b975cb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be17f6c-5338-43be-91ef-650153b975cb@stanley.mountain>

Ping.

regards,
dan carpenter

On Wed, Dec 04, 2024 at 03:07:15PM +0300, Dan Carpenter wrote:
> Most of these sizes and counts are capped at 256MB so the math doesn't
> result in an integer overflow.  The "relocs" count needs to be checked
> as well.  Otherwise on 32bit systems the calculation of "full_data"
> could be wrong.
> 
> 	full_data = data_len + relocs * sizeof(unsigned long);
> 
> Fixes: c995ee28d29d ("binfmt_flat: prevent kernel dammage from corrupted executable headers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/binfmt_flat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index 390808ce935d..b5b5ca1a44f7 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -478,7 +478,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>  	 * 28 bits (256 MB) is way more than reasonable in this case.
>  	 * If some top bits are set we have probable binary corruption.
>  	*/
> -	if ((text_len | data_len | bss_len | stack_len | full_data) >> 28) {
> +	if ((text_len | data_len | bss_len | stack_len | relocs | full_data) >> 28) {
>  		pr_err("bad header\n");
>  		ret = -ENOEXEC;
>  		goto err;
> -- 
> 2.45.2

