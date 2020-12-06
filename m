Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0078D2D05D2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 17:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgLFQFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 11:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgLFQFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:05:17 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A402C0613D0;
        Sun,  6 Dec 2020 08:04:31 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so10326630wrx.5;
        Sun, 06 Dec 2020 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IBXg1US7km+pm4VNhYfA62jAGF7YeEfx9ZaGb/6t6U0=;
        b=WzWteGEivpn/0WZmjktuP9pz9n+e2egi4MBJRL845j45E6IQgn9QOLwzI6CpqJxhu9
         1wmHulmhcXViXo8sBB1JdZMALp5PxfgHPahiPTMyUYmHCAEPNk1Bsopu5kcKM7p5A3nU
         BRnEWrUgtzQ//Ama/qN8WLOIzaRKhlqP3DNb7+eIM2QdgQc4bTyHKAjJ0S9OqV7Sa1KS
         qKSOSlGBfNaSVEYz8s41Tu2gqUJ71zA09G57OgrY/AJbT3Zn9l5G+BfYrXsa+8FEiad3
         1VLnwCqGFfqVYEgkCISL0GlBVVOHBLNZQ1yOHwCsyOFTmCRGQ710qV+RU0m9aSicom6A
         8SFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IBXg1US7km+pm4VNhYfA62jAGF7YeEfx9ZaGb/6t6U0=;
        b=TXDtljEF0NA7HQvIQnAhjNnpu06eR53tkOA60aDWPY97rMC1PpdNciABAr+JCX85n6
         Tx/bz0UFOHOXp16iUMLR9ugKD3BuBip1UExwnUtDXgZy/kfk0dA30F9FkVMh3NmJO5UO
         Kbrv3zw2jQ9FHvYLb8+UBUPvvd4J4sm9yMNXWNdrF+2MJ0d7nluBu5pSmRkWjcgyXWfL
         U9N2627zMuZyhmgBWFzY2mN0b9hMuJUb/wgBNH2WHRfeNqiYdmMT7RO2K8q2hyYOCCiU
         Wb/QnguVjcy1lN+eQZfiO6IyNYFqR1fOCAJVQmDjfS9rpBBlXZaLnhNj8AkWwY4k3Th5
         4a4w==
X-Gm-Message-State: AOAM531oR1jG6PUQqo5cX3HLAX4l8YV4BcgrQkzavWLXVZlZgVDuXywh
        /V734HY4AVi/FfgsfDNXdgUnM2ZeuakRgA==
X-Google-Smtp-Source: ABdhPJxm93FySARedMcqy+SPq8L0SURscsdiMTicglQxiJL/85BssFlRzja+gVvBPiAPqc8fokZ/lQ==
X-Received: by 2002:adf:c986:: with SMTP id f6mr8544968wrh.361.1607270669742;
        Sun, 06 Dec 2020 08:04:29 -0800 (PST)
Received: from [192.168.8.100] ([185.69.145.92])
        by smtp.gmail.com with ESMTPSA id l3sm11609876wrr.89.2020.12.06.08.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 08:04:29 -0800 (PST)
Subject: Re: [PATCH] iov_iter: optimise iter type checking
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
Date:   Sun, 6 Dec 2020 16:01:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/11/2020 14:37, Pavel Begunkov wrote:
> The problem here is that iov_iter_is_*() helpers check types for
> equality, but all iterate_* helpers do bitwise ands. This confuses
> compilers, so even if some cases were handled separately with
> iov_iter_is_*(), corresponding ifs in iterate*() right after are not
> eliminated.
> 
> E.g. iov_iter_npages() first handles discards, but iterate_all_kinds()
> still checks for discard iter type and generates unreachable code down
> the line.

Ping. This one should be pretty simple

> 
>            text    data     bss     dec     hex filename
> before:   24409     805       0   25214    627e lib/iov_iter.o
> after:    23977     805       0   24782    60ce lib/iov_iter.o
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/linux/uio.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 72d88566694e..c5970b2d3307 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -57,27 +57,27 @@ static inline enum iter_type iov_iter_type(const struct iov_iter *i)
>  
>  static inline bool iter_is_iovec(const struct iov_iter *i)
>  {
> -	return iov_iter_type(i) == ITER_IOVEC;
> +	return iov_iter_type(i) & ITER_IOVEC;
>  }
>  
>  static inline bool iov_iter_is_kvec(const struct iov_iter *i)
>  {
> -	return iov_iter_type(i) == ITER_KVEC;
> +	return iov_iter_type(i) & ITER_KVEC;
>  }
>  
>  static inline bool iov_iter_is_bvec(const struct iov_iter *i)
>  {
> -	return iov_iter_type(i) == ITER_BVEC;
> +	return iov_iter_type(i) & ITER_BVEC;
>  }
>  
>  static inline bool iov_iter_is_pipe(const struct iov_iter *i)
>  {
> -	return iov_iter_type(i) == ITER_PIPE;
> +	return iov_iter_type(i) & ITER_PIPE;
>  }
>  
>  static inline bool iov_iter_is_discard(const struct iov_iter *i)
>  {
> -	return iov_iter_type(i) == ITER_DISCARD;
> +	return iov_iter_type(i) & ITER_DISCARD;
>  }
>  
>  static inline unsigned char iov_iter_rw(const struct iov_iter *i)
> 

-- 
Pavel Begunkov
