Return-Path: <linux-fsdevel+bounces-58972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64525B338BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 246C24E2455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9161329B8FE;
	Mon, 25 Aug 2025 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIUodZK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F125A2BB;
	Mon, 25 Aug 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110518; cv=none; b=rbvKLdo9B1O1xuFzK6dlILO7FxlRMQiIgcqnDG7aE2TqTXWCkvSfe5Cguob6WHu8BQTmEq5o5em/9sicndtwm5zEIJeYK+iw4V0iRqy7ECIL8i4VF7WcTx/mQR75nEasxX6jJqnZu/+LiV89KCgNlS3zX/E6tHJTgGudwc2wSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110518; c=relaxed/simple;
	bh=IHsMzM7WVmkwk55If4TiWPyrHsMUTorRjQL5rrsrON0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLG37n9qa9aK0o7xRyrtJFMREWzrsfa0cOM4s06z9tfBLZfTi4hMNVX571whGmx0WjHmgNC4B81cdC39RaFwtvD4yjbAkVP0OVy+UPJoMxB8mIM9TYVN0cGSnLekXUr05ac0T7FhXap8iJ7A4622wYeaOUPYtBw4dnZlYob0nWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIUodZK1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b09990aso1085595e9.2;
        Mon, 25 Aug 2025 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756110515; x=1756715315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuTeQU4Njb/2ZMYYaooMFVFoD4AT11+hDbQbFo5ygGE=;
        b=IIUodZK1OukbTxp5UUA19tCiMyyQkbDb6xWeOqPoz2gteW0kU6octIebmv0XF8h5EA
         TkZtQOo4OipxhCqhhO3+CjIRoFsXptz/f6klmeM55V9EXV39EViFWq45HVxpj1OsC6JI
         t23kZzeB/HuBL2NjOEeiv4c/qvaLUdMNfo7llg1D/lyKxHTwAuG59c27jts7HYDxJTV7
         l/NrtFT+B8dv4Ws3/L8aJYzA749ws8Jb3uXsJvCJ8rrGJ3VkV1WmydonMq83242zpy3d
         E5CziyclVOwysmWc3fgbaHVlF7MFBEO9X+AVpqwZYp97Ny0E5taB1wsS9oUuUIakkEOv
         bGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756110515; x=1756715315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuTeQU4Njb/2ZMYYaooMFVFoD4AT11+hDbQbFo5ygGE=;
        b=n0v1XjC2YNIOlaPRl29Y5YMxbk8LBDdMLIQYrHY0BwoK6laLQrDewB50lHolg2AINr
         14ul2oGqM6g06vdZ/KxN5vJGVKdbW0C+4e5pWup1RPBqdeO/vIUxAsuAIFkc4PovmGkW
         om9FTP/ZXZkcIAFrliQUkWeuwao7S3L1/pmxziue9LeA5ZTu8ii/sddLL6IrfX9ceP46
         b2GsTSqcmNoC5dlxrYHaPdlew43vQ3Tv+WDCMUnIcgp0/z/RN3X1ofVIWQots25xzMyI
         B+idp0fIVh+PEXj+NFEw0e5RSewEe8zYpBcqvna2UiPi94oulLGE4s8jvrKrqT59XBVP
         niTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+U/pPh2yyXpPKSDWsAFfs5o0qmICKcftSoiHnPNnFfIrthuKifMoMdNAUvKI2A60BEfkMY9mxka0qeD6z@vger.kernel.org, AJvYcCWseVvh1plWZV+nqqwFU/cOz8QjvMFg/SpVjp1GZRH0ahKC+9jw0DrUEjbhZCONruc+pTQkS+1jI6ODA8Zk@vger.kernel.org
X-Gm-Message-State: AOJu0YyvLW9Uzv3o5MKiWXPkTsP07UpKqnosksypaBMU6urNyX0ikXoq
	NbK18xpGY6IYzIcbIj3M/1YTx1i+Xf9vsHG8PlNkSW2dRIFQfE004sY6ptmebOxS4kQ=
X-Gm-Gg: ASbGncuno2koHYaeCMfYoXeJ+SrLfI6FMmZfLAC8Zkh+r8uWfdyj4XkcJkGSXG7ArHQ
	yxIGS3HYVJPPjWRt0DJIBFJMA3O+YvzyDx6IpGfDND0PacljQOvH+ilfB47aBtE8PLLyrPStG4E
	iLR5AyjJ4NJ4Vclhhjie8Gj0LbZWGyf4ZDRmkzoWQyez1WJ5fzpgcVTjhZegnwTLXeao7qEf89M
	hC6w0qZgU8hskMxn/kXL3vMRxVBygu57XcxCgif2O/RcAdpdoaJdXcJyGsH0G01vj5EwVb5u1oe
	MUtDQ++P4SedQlicH582CeL8uD1Y+qA+y4CXq/vUN1fLj4CbP+gZCq/+2ZYORYiDXEVdP/SXPL8
	Q3cdRISB988zmF3sDFI8u/Rit9igIR3QOFt6s+RKZ3w2lUppjMkaO
X-Google-Smtp-Source: AGHT+IHPqLQ+oRqyvjisbJ8+67UMxUp+cFZGaQxEbT3zSRUP9vA/CB8qpHqjka6+1r8W+L8S9uq/iw==
X-Received: by 2002:a05:600c:3223:b0:45b:6269:d24a with SMTP id 5b1f17b1804b1-45b6269d622mr3184445e9.5.1756110514399;
        Mon, 25 Aug 2025 01:28:34 -0700 (PDT)
Received: from [192.168.100.2] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57535439sm106215545e9.4.2025.08.25.01.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 01:28:34 -0700 (PDT)
Message-ID: <39e80575-f024-43e4-8760-0a535f84b4ca@gmail.com>
Date: Mon, 25 Aug 2025 12:28:29 +0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Fix incorrect type for ret
To: Xichao Zhao <zhao.xichao@vivo.com>, kees@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org
Cc: jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250825073609.219855-1-zhao.xichao@vivo.com>
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <20250825073609.219855-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

LGTM

On 8/25/2025 11:36 AM, Xichao Zhao wrote:
> In the setup_arg_pages(), ret is declared as an unsigned long.
> The ret might take a negative value. Therefore, its type should
> be changed to int.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>   fs/exec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 2a1e5e4042a1..5d236bb87df5 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -599,7 +599,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
>   		    unsigned long stack_top,
>   		    int executable_stack)
>   {
> -	unsigned long ret;
> +	int ret;
>   	unsigned long stack_shift;
>   	struct mm_struct *mm = current->mm;
>   	struct vm_area_struct *vma = bprm->vma;


