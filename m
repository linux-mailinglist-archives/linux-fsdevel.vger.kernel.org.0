Return-Path: <linux-fsdevel+bounces-16034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D3D8971FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 16:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B2E1C25F70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603BB1494AD;
	Wed,  3 Apr 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyJL8Y5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149F1494A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153389; cv=none; b=MgzOjrqzhDif2+xVrqyulHLeMzcLB1bERy7GAOvEvvgKVwasml+72Oz8zQ+t4qA/svuq5e3xLc6iMb3hZqkMAYvWMo9n9yW60wkxfNEe+6Ny+CIOgSvV1yHaTL69QjR4qguyEHgwom3BrgImdwI6L6refgXVTMGSNanhx7qnYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153389; c=relaxed/simple;
	bh=uaBB+wQsNV6UWh9EWCIicCJ/cZxkRwz+9E3hPzTRRxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOXIbV3njhIScxF7w75sL7CJvheDiNmR23saPbyvSNy7VcFn8CNWM01Ak0kpyLXprXYqg7NMy1/44syz5N5LWXfEIDxbfw0tIjEny+7Im0lGdPAQFZCE7V/sgVMOznq4D7vaMs7skfZ2gOw2jvGYphn6QjM/DzEG2xIBpdJ3aOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyJL8Y5f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712153387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dbCAJSaH9jFId+0gZzIqDck5z9baO02AHMcYssDIEM=;
	b=IyJL8Y5fm1JzQ0EnLxXFdeJEsUWJ/7M7gcCuJW9WGNcap55omrMLIsNOOyxaj5uB8nKZxd
	YfXCMMlpXAcQjLU/yK61bqIPYA5WUEBGcgZURxfksrMjdEGG/4OfJFCtLgBz6N5dWIR24a
	+20zVrsL+TcIx4dkZu0sA4iD3dMIVi8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-nE09X9HcM3GIj8L_1a8yZA-1; Wed, 03 Apr 2024 10:09:42 -0400
X-MC-Unique: nE09X9HcM3GIj8L_1a8yZA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56c25ebc347so2278116a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 07:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153381; x=1712758181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dbCAJSaH9jFId+0gZzIqDck5z9baO02AHMcYssDIEM=;
        b=VEMp3ksUWg1VT8T3xLUbYoE+z/n6HsnEveB8Vt9ZEuDSGNZYiQXelFzCXP1PpLIJeo
         WQk05KAuSM1miCBaG6N7V9IiHIB2CAxqvUO3X/pCZzbfH9y+/x7qOKM1/XQXkwznAcjq
         xcMAH5NwD/YS4ClzT7x9Mh9sQF3DVrJd+GD+PSqvN2/fB03HnUAQeFarBspa2wSq5I/j
         7D+rCY8M9MvF028+QBf/aGSgrPmXzapJy+9uaorQjlLjbItQTN80OiSSLoo5WecmTzUa
         iQaD++475ycbekou6KCWL7reRPwQeGfVIiwxndftdI/wi74JAf7UJ+CGEbGpqsz7WbbK
         5heg==
X-Forwarded-Encrypted: i=1; AJvYcCXNtr6bVpZinpPxvun4o6oAEPXEcovpvFhY/xsy4zl8nEEoZ5GwpYFd6nGj9Y0KcRQ8OyyMXZuEqD7V31LTe9Kut89lY5CPB4t9mDA1oQ==
X-Gm-Message-State: AOJu0YzeSaqW4V/UK1/4pdA1RumUdNxtSpj7r9CBBxjRQghVyWpRgizR
	sEsFnnyb/+fnu5QLQw95L+6VdCo+euf+8pTic5JYjC3yAMWpPMhYFvW6qJrbrLjKq+LuYcTz0gV
	kpSxm5+YSr1CQzNXthp2sAu5owYaTXUWvN/Gs6LRv2RxvOQtW9fjcK+uC7CifUJ0=
X-Received: by 2002:a05:6402:518f:b0:566:ca0:4a91 with SMTP id q15-20020a056402518f00b005660ca04a91mr12828055edd.2.1712153381707;
        Wed, 03 Apr 2024 07:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5knLeof+HgcpRtumWCQlmMftyzct6dVwSxv5H+k5eapOlsocG/j7R3Dvj1z53sLwMEafApw==
X-Received: by 2002:a05:6402:518f:b0:566:ca0:4a91 with SMTP id q15-20020a056402518f00b005660ca04a91mr12828043edd.2.1712153381364;
        Wed, 03 Apr 2024 07:09:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b0056c4a0ccaacsm8024402edv.83.2024.04.03.07.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 07:09:40 -0700 (PDT)
Message-ID: <7591adba-0603-4843-b228-a0bf20fd116f@redhat.com>
Date: Wed, 3 Apr 2024 16:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] vboxsf: remove redundant variable out_len
To: Colin Ian King <colin.i.king@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229225138.351909-1-colin.i.king@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240229225138.351909-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/29/24 11:51 PM, Colin Ian King wrote:
> The variable out_len is being used to accumulate the number of
> bytes but it is not being used for any other purpose. The variable
> is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> fs/vboxsf/utils.c:443:9: warning: variable 'out_len' set but not
> used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have added this to my local vboxsf branch now and I'll send
out a pull-request with this and a couple of other vboxsf fixes
soon.

Regards,

Hans



> ---
>  fs/vboxsf/utils.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index 72ac9320e6a3..9515bbf0b54c 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -440,7 +440,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  {
>  	const char *in;
>  	char *out;
> -	size_t out_len;
>  	size_t out_bound_len;
>  	size_t in_bound_len;
>  
> @@ -448,7 +447,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  	in_bound_len = utf8_len;
>  
>  	out = name;
> -	out_len = 0;
>  	/* Reserve space for terminating 0 */
>  	out_bound_len = name_bound_len - 1;
>  
> @@ -469,7 +467,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  
>  		out += nb;
>  		out_bound_len -= nb;
> -		out_len += nb;
>  	}
>  
>  	*out = 0;


