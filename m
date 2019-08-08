Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E206B85E15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfHHJUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:20:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36624 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbfHHJUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:20:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so8950675ljj.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OCitiiIQARt2srQdTEp8HHKk2MswJS9hy+qm/HN3L5Q=;
        b=eGiX9Khh6PGwyt3vEDZS5i+7Ttn3dev6cKijGsAKu98PEo2SOHWYpChGzAR8G6rqiH
         jzgQRh6WatLMuo4AbNf4LAJr20oUT+cZdU/1CJnSqTguKc+Ybw4jmkdw0OadBReXodeF
         ebkbMHm8MDy0PwD/pEvqEAPbq07rO3qstGtOj2YxInvoyEp2nXA39FzVCr7+4l19jsYI
         3s9hm6A/4KWKEqwiGw05Tvffpb0A0mj+ayAeSD24M3N45J6I7gHbT2TjJqBsaCxM8sqn
         rQPLBU1qx5jTkktaKHQLtADroikDfkHoEs6q4//nMMWQlm8Px3F2v3VdsnP0ZIgPpvGb
         4l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OCitiiIQARt2srQdTEp8HHKk2MswJS9hy+qm/HN3L5Q=;
        b=eFLh0anpnXguklLTNKkLONVfx+ycsZwxrtZVxKbX1dAMm4ot2wEkdwNIjXTXTG49wb
         TBB3nD0QsckeVT3GhgL3I7sB5+AsSiwVn7AkVJXEkyQQXDv1Go9rfA44lbOSkmGPTAqs
         NmR15tTFsbXQfmV9o6HWhzv8dGjyAEL977aNr79o4v7sNq3ZtIX8unFpPmIrpSAuNW1V
         A/kcOygWp9gQjoTphCHoSWHkPNjdXFSNDFFsyeonhDBDk2EhktLOlL7dLXW4/n9/TsEw
         L3X2vHIoq5Il6uRgkInnwnCnfpPKVxAQNu0e95KUffrBRADD8D1LqBPVXfJu29yK9vSp
         xiZw==
X-Gm-Message-State: APjAAAWSn85ZscuJ0kpa67MLSyr6dAt5Xz3IDfg5yIgZwLMMfblaPibA
        z+KVn04g5FOmD7QXtEkyvTc3Fw==
X-Google-Smtp-Source: APXvYqwAgmAyvFxsvAFzBlQwmsh/xeHT2UOBWqRNNJ6VrtKLtOr+7Myij8Z/3eE0oJPU4/4mQFntnQ==
X-Received: by 2002:a2e:9685:: with SMTP id q5mr6063276lji.227.1565256009622;
        Thu, 08 Aug 2019 02:20:09 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8c7:ada9:25b2:24d8:3973:eb87? ([2a00:1fa0:8c7:ada9:25b2:24d8:3973:eb87])
        by smtp.gmail.com with ESMTPSA id u27sm17024138lfn.87.2019.08.08.02.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 02:20:08 -0700 (PDT)
Subject: Re: [PATCH v6 11/14] mips: Adjust brk randomization offset to fit
 generic version
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20190808061756.19712-1-alex@ghiti.fr>
 <20190808061756.19712-12-alex@ghiti.fr>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <68ec5cf6-6ba3-68ab-aa01-668b701c642f@cogentembedded.com>
Date:   Thu, 8 Aug 2019 12:19:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808061756.19712-12-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 08.08.2019 9:17, Alexandre Ghiti wrote:

> This commit simply bumps up to 32MB and 1GB the random offset
> of brk, compared to 8MB and 256MB, for 32bit and 64bit respectively.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: Paul Burton <paul.burton@mips.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   arch/mips/mm/mmap.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index a7e84b2e71d7..ff6ab87e9c56 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
[...]
> @@ -189,11 +190,11 @@ static inline unsigned long brk_rnd(void)
>   	unsigned long rnd = get_random_long();
>   
>   	rnd = rnd << PAGE_SHIFT;
> -	/* 8MB for 32bit, 256MB for 64bit */
> +	/* 32MB for 32bit, 1GB for 64bit */
>   	if (TASK_IS_32BIT_ADDR)
> -		rnd = rnd & 0x7ffffful;
> +		rnd = rnd & (SZ_32M - 1);
>   	else
> -		rnd = rnd & 0xffffffful;
> +		rnd = rnd & (SZ_1G - 1);

    Why not make these 'rnd &= SZ_* - 1', while at it anyways?

[...]

MBR, Sergei
