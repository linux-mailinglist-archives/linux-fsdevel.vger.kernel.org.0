Return-Path: <linux-fsdevel+bounces-39793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66EA181F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 17:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F3E3AAFF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020461F4726;
	Tue, 21 Jan 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="So6dK0HQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB11F1527
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737476921; cv=none; b=UceQ+RmR3LQTm1cZQbuG7w5S/CrxjnmvnxIZlFYEcAH5MmNIvPZ6bWov2//3lYCcAmbciOHgTzEwK3SyECAyBG/zIlo/QICB0FDjaBNmN1xIpKzfnTpByCmTKdT83jHagcoRuUKghTqS6kDeT/1qECJWBGD1pGdsIlnP71ow+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737476921; c=relaxed/simple;
	bh=xm7P2Xj9F0lX1TUn6zaultfqdKWfNMJP3gmWrDgoe7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwjTlKCr38pQ+22gpMC+R+KsBxeX8FomKmH2rHrn7zR3hHFP0dKfN+yFRi+bzkIO6MGY90WsJnEwB8REqjYat4c3JaRwGkRGyxzNcKjcsUXYxXisc6mlKQJ96gli2In0DDiH5rlA3Jh3TBgl9ej81534B3JJJYrXvb3lwF6OVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=So6dK0HQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737476918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18AfannScfIY8EriR2EO/tvHIiDq19oOA7Fl7JCU7uk=;
	b=So6dK0HQTFNZCjCdFB2LkeUeaxqXofMQ3kpC6NVD22VWgU+UjHbF4l0P3N0RHwlAflMngW
	ZvWQs8jraOz44c5PH1vhvzG/oaTe6WJ7UB7ijwGaC+IgNMZMxlHyApLuoHVg65hzgsJGWe
	CQq2724+akwQuQkyZdmOgcEYPbm20YY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-85FXZSQRPL-wJJHVEOc_Kg-1; Tue, 21 Jan 2025 11:28:37 -0500
X-MC-Unique: 85FXZSQRPL-wJJHVEOc_Kg-1
X-Mimecast-MFC-AGG-ID: 85FXZSQRPL-wJJHVEOc_Kg
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aaf901a0ef9so451673666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 08:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737476916; x=1738081716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18AfannScfIY8EriR2EO/tvHIiDq19oOA7Fl7JCU7uk=;
        b=MEQU+jnULwoylaRkJpxUusQI71ENIBtLuB7N7Gu8NbFIy+aoR1uF9yBy7U5dP7z7rp
         v+T9Dr7uHi7hdUilIHKOpwvA3Tr5B1T2SXSaca/yG3EqImh2WhY+af7YF4S+3HwfWPbn
         4ZVwPHLj3wBmJt01r9zVnzc53zgY3FuU5EIuwFCuZ5C2cIRQT8mp8hUi8fpy9G79Opzk
         maFpGibmIZsNSg77djkIRjlaEjHKfdiz9jrGO9wa0/897zuxqiWbECBcZSZqy01vUS6g
         BAfwx1ba1P2908naB5V+n3rCwHd21qqWmlopg+GL+mWqYWByxXzenkq0aq0ubw3j1Awt
         vyAA==
X-Gm-Message-State: AOJu0YzDx7topkqkEI0++l4ubpyFsRZ3mTIHEV9HnZR1ySLLlryZ1PNs
	t6yF9cgpqU9UT8VZwPBhqLQad0XvcB2VZl8zWoE/v2unbgu0fNWJjiRm6PuabBtyhNEStxOqy/h
	+n37HqKea+MWugSDLhmnSM+HhYh3Ym8OOnPw5ck6BfNDjmdfgD7QLtT0bMRXZGvQ=
X-Gm-Gg: ASbGnct1d21KCH5KyC+phSoDw3LSUKviXw2Q5HmTfDx6I7ylSfU1KhTD671aA1jy/sw
	TZyGOjEILKB5CAeluYlqMavYNgzUZxtffucsr2xJ+vpBsFVXdhItFx9YSflCFKvnxow8R5sdHGN
	39yrXFGRnUVGXSVOkN1UrkjXFZwehTkg5A/Jte6BVqTjeW/WBgzPzQnFMff78lZy0Zmhh2Qv0Fp
	6BJi05LVfjqzEfAGKK7Cz1Za6y6vhSII2O2QZPmM+6jTgasAArnUEpZxe3qBMiKiaytupeBpDvk
	9MlUm/plcAD+j75qOl6/hnsxKWrXQoE77RXHFADpFYYTJSM90pmGBZ9GCG0/FpOqv2wl1QBqVVS
	BAOk8woDsOH1qsryhUmVMwmg3S5u0u3Hx+E7HEkpsrqWJ
X-Received: by 2002:a17:907:7b9d:b0:aa6:8bb4:503b with SMTP id a640c23a62f3a-ab38b4c9a56mr1380321266b.55.1737476915846;
        Tue, 21 Jan 2025 08:28:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGjbp0Ky/GAOO7K7OUz99Kavj698xWxLY2zZiStonj4KktjESdUbpCmo1dejqrT0OSxw61NA==
X-Received: by 2002:a17:907:7b9d:b0:aa6:8bb4:503b with SMTP id a640c23a62f3a-ab38b4c9a56mr1380319566b.55.1737476915450;
        Tue, 21 Jan 2025 08:28:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f87d86sm772274066b.146.2025.01.21.08.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 08:28:34 -0800 (PST)
Message-ID: <a234cb8b-ace8-4edf-add4-5034aa53595b@redhat.com>
Date: Tue, 21 Jan 2025 17:28:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] vboxsf: fix building with GCC 15
To: Brahmajit Das <brahmajit.xyz@gmail.com>, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121162648.1408743-1-brahmajit.xyz@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250121162648.1408743-1-brahmajit.xyz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 21-Jan-25 5:26 PM, Brahmajit Das wrote:
> Building with GCC 15 results in build error
> fs/vboxsf/super.c:24:54: error: initializer-string for array of ‘unsigned char’ is too long [-Werror=unterminated-string-initialization]
>    24 | static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
>       |                                                      ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Due to GCC having enabled -Werror=unterminated-string-initialization[0]
> by default. Separately initializing each array element of
> VBSF_MOUNT_SIGNATURE to ensure NUL termination, thus satisfying GCC 15
> and fixing the build error.
> 
> [0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization
> 
> Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index e95b8a48d8a0..1d94bb784108 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -21,7 +21,8 @@
>  
>  #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
>  
> -static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
> +static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
> +						       '\375' };
>  
>  static int follow_symlinks;
>  module_param(follow_symlinks, int, 0444);


