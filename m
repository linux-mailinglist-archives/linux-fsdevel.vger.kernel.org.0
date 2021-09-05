Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267D8401160
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 21:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhIETaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 15:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238126AbhIETaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630870151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJhftX7KdnJxCNtt1OcYAAeR/bKh9VnXaLjpPXlfeQg=;
        b=Q62/opboh1PtOd4gBsJ7QkDXmFOJ3lgkEkK6iLlsIlvvk1HaZVzbMLh+puDcDxLB9OUuYJ
        mYlm8XmdHNYkZiYERsINLg/yRtMmgvjgezrcCUhlCVt+q4k9iRura8x9z+Ap61xhI2UWRA
        gNU+NwWjNPAzxO5zZvXNoFKGj5Y7UmU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-EN3wMWYHNMyMB_dEn5CvCw-1; Sun, 05 Sep 2021 15:29:10 -0400
X-MC-Unique: EN3wMWYHNMyMB_dEn5CvCw-1
Received: by mail-wr1-f69.google.com with SMTP id h15-20020adff18f000000b001574654fbc2so653418wro.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Sep 2021 12:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VJhftX7KdnJxCNtt1OcYAAeR/bKh9VnXaLjpPXlfeQg=;
        b=ue7NfFNxN4vEPPLwbVhpS6uZEaB0CERZeDYSTjmaPkkt2TBYHW9TCFG4yCzc/VE0HL
         dJDLFrocabpiF2XjZgjqf6DLq9TGbFL2P3gkWntEbuUih9u/vJ3/odDmSID7aiJ1MKp7
         9bC/SjbA85y9nhv4hWmKlktdUVfsQxV7GrhbOXBBllx+8dNZ3H5DPpAn/TkpQ4raNdRn
         ZXVu6+BM5gUIFUHtYPj73uAPw2XDDi8mo8oqR3PFtQ60eJ2Mq4Jb58De7USHb7aH3Tlo
         JekFeGapa/j4t0KCcS3bB7X+DNTppwLhtJ2FdTYNgbmO2PzwZSiCB2AtUGjay/B50Cs4
         shfg==
X-Gm-Message-State: AOAM531shDv+Nv4bX8i2k6smMOHR38+vx2Q/KWkKzv0RTJIS1yGRdt4D
        DJPYULpcf0h3WWLyfi6Mx5iysQ9qhhbdMiMTYmlhWDLYvmCDk0FeX+KCauuNYLN31X48F3FwQL/
        TwtPfiwvC16vkzDKZ6bKZa1v2YA==
X-Received: by 2002:a5d:438a:: with SMTP id i10mr9720554wrq.285.1630870145993;
        Sun, 05 Sep 2021 12:29:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu2FTA+hrPwFqGf7dCn9mHcjQyvE9QSkO6Avx438vyzALqkqRc4eOOXzTeN2CgcYcEllBK9w==
X-Received: by 2002:a5d:438a:: with SMTP id i10mr9720544wrq.285.1630870145830;
        Sun, 05 Sep 2021 12:29:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6f04.dip0.t-ipconnect.de. [91.12.111.4])
        by smtp.gmail.com with ESMTPSA id l7sm5166459wmj.9.2021.09.05.12.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 12:29:05 -0700 (PDT)
Subject: Re: [PATCH] binfmt: a.out: Fix bogus semicolon
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        noreply@ellerman.id.au
References: <20210905093034.470554-1-geert@linux-m68k.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7a9e8a5e-df3d-0ecd-1396-450b50ce2937@redhat.com>
Date:   Sun, 5 Sep 2021 21:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210905093034.470554-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.09.21 11:30, Geert Uytterhoeven wrote:
>      fs/binfmt_aout.c: In function ‘load_aout_library’:
>      fs/binfmt_aout.c:311:27: error: expected ‘)’ before ‘;’ token
>        311 |    MAP_FIXED | MAP_PRIVATE;
> 	  |                           ^
>      fs/binfmt_aout.c:309:10: error: too few arguments to function ‘vm_mmap’
>        309 |  error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
> 	  |          ^~~~~~~
>      In file included from fs/binfmt_aout.c:12:
>      include/linux/mm.h:2626:35: note: declared here
>       2626 | extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
> 	  |                                   ^~~~~~~
> 
> Fix this by reverting the accidental replacement of a comma by a
> semicolon.
> 
> Fixes: 42be8b42535183f8 ("binfmt: don't use MAP_DENYWRITE when loading shared libraries via uselib()")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   fs/binfmt_aout.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
> index a47496d0f123355c..0dcfc691e7e218bc 100644
> --- a/fs/binfmt_aout.c
> +++ b/fs/binfmt_aout.c
> @@ -308,7 +308,7 @@ static int load_aout_library(struct file *file)
>   	/* Now use mmap to map the library into memory. */
>   	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
>   			PROT_READ | PROT_WRITE | PROT_EXEC,
> -			MAP_FIXED | MAP_PRIVATE;
> +			MAP_FIXED | MAP_PRIVATE,
>   			N_TXTOFF(ex));
>   	retval = error;
>   	if (error != start_addr)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for reporting and fixing that quickly!

-- 
Thanks,

David / dhildenb

