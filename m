Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC54E8C75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 17:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbfJ2QLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 12:11:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38320 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390313AbfJ2QLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:11:05 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so15387373iom.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F6ER53BgOcOjbbASqksGEOGLpbaFeVJy95CCofNvLlk=;
        b=wedfLyUog88ghsfUG9ng4sLf1z/0VkWmVqCXwEabMblSAUIbJwdmrGPd7Ankmm1wJ2
         MRaQY7cEyNQ704VjmmdbgVmcgQedQhFQa1iQjkdzFwl4co5Q/5AzIzh1iLGjmaU1opiI
         QB9H3VXcCBtKOp0CP1xKiGhav1LWQ1KEEjHvhD9cLz1qqdZG4BqEOlKf++lL2LFE0ln4
         XqILHG9eF2S4lJ7wId87UW2m8VCZ3s7J5lcQ9QFnXb+xTdDSr+2RZwKboyKFa1xUjPy6
         BMeZi37D7mmnlqjCLFCuj3fHmkEY9ZeTWFtK2l4tHi4+81RlDOiV4b+Pr19sXKGJowcZ
         xALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F6ER53BgOcOjbbASqksGEOGLpbaFeVJy95CCofNvLlk=;
        b=bjs8DAyGEulBjp4B/JMzgB73las1oZDYJRduZJRwcN/lNgXMX+P2w3n4HCDQA6yUV7
         enMjGvT08pD5YMxjW4XJi1TJTTFkusR5SRqaaHyCakfPEyDYE3yH7ElUHQPAl5F7TMJA
         9Id92c6CDrzFwWTpSOwadfJ4ER5+GuVyr7XwH2ilTInGt2ZaHCv5+W/XhW7l6HC/M5DC
         q91s/PhBTQrnz/vcDvz+ND18yJIR5KrMC9EQe3Oes8gdMWXs6T1FTBy2EgaMiYDVgJbl
         ZOg8nj4mihMQeaXFT5fzGG7/JWQ7KqJbtIx1Ycpw4cKtRd8spJyN80ClpyuwO05SigX1
         t3gA==
X-Gm-Message-State: APjAAAXGRcA+URKFBTPlzmbUCdGq95tDxYO7Fi2ZEws71BlgewGDmuUZ
        /45sytSFDz5gBWwMqkAXOgqioA==
X-Google-Smtp-Source: APXvYqyhZskMd8k1bAZr4oT8JlZ3SnlIevkxMe0j+YZP1JrfvqIqI+ZeA56Fhi9q5xKNTv9G4Gse1A==
X-Received: by 2002:a02:cac5:: with SMTP id f5mr23340042jap.113.1572365463018;
        Tue, 29 Oct 2019 09:11:03 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x17sm735843ilh.22.2019.10.29.09.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 09:11:02 -0700 (PDT)
Subject: Re: [PATCH] fs/iomap: remove redundant check in iomap_dio_rw()
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1572342047-99933-1-git-send-email-joseph.qi@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c373998d-9edb-8071-3440-71c41a7bb546@kernel.dk>
Date:   Tue, 29 Oct 2019 10:11:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572342047-99933-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/29/19 3:40 AM, Joseph Qi wrote:
> We've already check if it is READ iov_iter, no need check again.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>   fs/iomap/direct-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1fc28c2..9712648 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -430,7 +430,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>   		if (pos >= dio->i_size)
>   			goto out_free_dio;
>   
> -		if (iter_is_iovec(iter) && iov_iter_rw(iter) == READ)
> +		if (iter_is_iovec(iter))
>   			dio->flags |= IOMAP_DIO_DIRTY;
>   	} else {
>   		flags |= IOMAP_WRITE;
> 

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

