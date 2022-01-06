Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8374868B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 18:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiAFRhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiAFRhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:37:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9ACC061245;
        Thu,  6 Jan 2022 09:37:06 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l10so6234042wrh.7;
        Thu, 06 Jan 2022 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ry/dF88PTy02tpmQFCDT4lut/V2odoR2lVy1eBjvFOM=;
        b=TwTt5e/bkrr+wupAzj3tvQ1jkAt/WrTFkAxHBvC939gqG+TpULELbrK+zK2XEv3G7W
         GK0eXbJRTvRsT55vMO+hIRCs+bc8De4+CJUdjQID/aLfipfzxOHQToJ40fq71Kdlcmfg
         7i+Fziwy/4YsIqI2sgsaVnE2I090/QIEp7Bln4BOGxIkFL2zh+ff9gF1HRkFsmVjI35B
         FEPly37vOgQ8Kjs774COjjpWU0dBhI2yWxhqnBd9nOChZBRBFt1OQTYiB+Ra9k3BXdwQ
         Nu2aZtEK1fiB0Xu7lbCT4L4hYCFd1bYMibIkH4wZo3nXQXIXI4DqZ/AKJciC4nicR36M
         Axhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ry/dF88PTy02tpmQFCDT4lut/V2odoR2lVy1eBjvFOM=;
        b=bBBCKlVc3A2Th/LpxQkja0ug9zSzf3YyMaKP6JCF/dhGvSt3I/9fjgLyTZidZZOD8a
         i2HKHVn6oXUz4BJnLSeyIEw6y5+TFk0SAMkIKpRV1wIApO3XewuUU+rp4zc2P2PLtgqW
         ISo7NlL/JZkBpUwo9A4mJo3JLw4dDmCmZjd2rF8YjPTm913WKohpFWrnAhxCtRIJT/8q
         f1zbnCw9/2Yy7V7onaG98ldG2vjx1cXa8+OxOWEy1KtDxrBeCsdigko+VahEaQdKmvvK
         3bMRD/OObKEn9dkjZJoYjbBfRYO+31oeUayoFomiyWJ1NzA+MW4pRKkzsL7FUI+nZqu8
         Ep+Q==
X-Gm-Message-State: AOAM530jGDdipIYuFxFmoP24hK8rmy2qkMN8m4bRQou9qaXzo8/wejaI
        02g18YNOM6HCn6vaA0bfRoxje/KOHjM=
X-Google-Smtp-Source: ABdhPJzSbjwbuSrhJMIj7kP/McRnBrqbUod/sggbFruV8Aju6efyojnp8xMG78570N9BHK/ZAdFfyA==
X-Received: by 2002:a5d:5887:: with SMTP id n7mr51262442wrf.510.1641490624860;
        Thu, 06 Jan 2022 09:37:04 -0800 (PST)
Received: from ?IPV6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id s22sm5960468wmc.1.2022.01.06.09.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 09:37:04 -0800 (PST)
Message-ID: <cbe26979-15cd-a460-7f9d-6035f8862073@gmail.com>
Date:   Thu, 6 Jan 2022 17:37:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs/pipe: use kvcalloc to allocate a pipe_buffer array
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20220104171058.22580-1-avagin@gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <20220104171058.22580-1-avagin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/4/22 17:10, Andrei Vagin wrote:
> Right now, kcalloc is used to allocate a pipe_buffer array.  The size of
> the pipe_buffer struct is 40 bytes. kcalloc allows allocating reliably
> chunks with sizes less or equal to PAGE_ALLOC_COSTLY_ORDER (3). It means
> that the maximum pipe size is 3.2MB in this case.
> 
> In CRIU, we use pipes to dump processes memory. CRIU freezes a target
> process, injects a parasite code into it and then this code splices
> memory into pipes. If a maximum pipe size is small, we need to
> do many iterations or create many pipes.
> 
> kvcalloc attempt to allocate physically contiguous memory, but upon
> failure, fall back to non-contiguous (vmalloc) allocation and so it
> isn't limited by PAGE_ALLOC_COSTLY_ORDER.
> 
> The maximum pipe size for non-root users is limited by
> the /proc/sys/fs/pipe-max-size sysctl that is 1MB by default, so only
> the root user will be able to trigger vmalloc allocations.
> 
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>


> ---
>  fs/pipe.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 6d4342bad9f1..45565773ec33 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -802,7 +802,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
>  	if (too_many_pipe_buffers_hard(user_bufs) && pipe_is_unprivileged_user())
>  		goto out_revert_acct;
>  
> -	pipe->bufs = kcalloc(pipe_bufs, sizeof(struct pipe_buffer),
> +	pipe->bufs = kvcalloc(pipe_bufs, sizeof(struct pipe_buffer),
>  			     GFP_KERNEL_ACCOUNT);
>  
>  	if (pipe->bufs) {
> @@ -845,7 +845,7 @@ void free_pipe_info(struct pipe_inode_info *pipe)
>  	}
>  	if (pipe->tmp_page)
>  		__free_page(pipe->tmp_page);
> -	kfree(pipe->bufs);
> +	kvfree(pipe->bufs);
>  	kfree(pipe);
>  }
>  
> @@ -1260,8 +1260,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>  	if (nr_slots < n)
>  		return -EBUSY;
>  
> -	bufs = kcalloc(nr_slots, sizeof(*bufs),
> -		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +	bufs = kvcalloc(nr_slots, sizeof(*bufs), GFP_KERNEL_ACCOUNT);
>  	if (unlikely(!bufs))
>  		return -ENOMEM;
>  
> @@ -1288,7 +1287,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>  	head = n;
>  	tail = 0;
>  
> -	kfree(pipe->bufs);
> +	kvfree(pipe->bufs);
>  	pipe->bufs = bufs;
>  	pipe->ring_size = nr_slots;
>  	if (pipe->max_usage > nr_slots)


Thanks,
          Dmitry
