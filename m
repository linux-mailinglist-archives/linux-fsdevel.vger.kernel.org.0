Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993C12C8C9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 19:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbgK3SVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 13:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbgK3SVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:21:10 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06860C0613D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 10:20:30 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id n137so10958732pfd.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W1NrjPFaGFEB9QOlsuahkMCoJvGNm1r5tLMGb5uM/tY=;
        b=JSVCK1kkpb3XMVNYwDnLlRRXW1WX0e9sx3G0lBIFfmz5cor9lo5lfqrU2pk46ttHeg
         V4DDn3Wixk200//QTmR9OnAM/L3ocNiO/M/kGj7DXKPjTT9O1YJfPQnmj23Q7XuyIh4Y
         aeCv+ctYCDl+TdZ+1rJsbBN7a+fOkCU3Lt/NE/pehDKYh0GOTPWZO9rUisWBcbk1tFhm
         O9mwG+9AALXvbxnAb7aKDWqGFHyIvScoWStdnmOIE2DXTJs7X8GYq8CVKMu6Re/YN/V1
         CkBxHQRkHs06xKHQID5TPCVSWZBy9ep2bZ1kiDZz4Pw7Kgg4xviLbYc8vYxuZPgEOGld
         02RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W1NrjPFaGFEB9QOlsuahkMCoJvGNm1r5tLMGb5uM/tY=;
        b=c7tJoTopFwGyS3KGTatg29/bIVpxW+wGPiPNO3qb/spl4o49FLF8WWcLUBZNy11fCP
         tJO84NDFAjtAT1Xn72gD3hEhUFOGC/ZkKeq7unnszsL/ggjRuooi9x0fK5nnZlmeBnUQ
         K01+ORNXPfO8pqq4X01WnAHne30582kcIdYFBt5pqAzQHdsZ0l6LMAaJGQMwtcTlxFA5
         SkW1PFKyc+J5lyhw5KmE6cuBuvS7LLuOVeLCfY9D1wEDcaN7rReG6ti3a/x4UaWtxTJq
         tIWfHYYz+UbfEBy0ZHwvUYV0wUm8rP9HEhaFnKTdrq0stacmLLXqyzvS5gJsXZ+9uPSs
         G+Zw==
X-Gm-Message-State: AOAM531KGENML/SfSBJidgssKPbITrtzMjDgdrrxLIM73hsP9yON3iuE
        6qhz8ClSEIBzme+vY/DSQ38ybw==
X-Google-Smtp-Source: ABdhPJyw/KmiB8O8DdPqPJhGR2d+CI1RIMY5qRiED/DN0E/ABDEt0l37qdAo2zFTmjB5KfwW6WnYBw==
X-Received: by 2002:a63:c26:: with SMTP id b38mr19083311pgl.333.1606760429534;
        Mon, 30 Nov 2020 10:20:29 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g14sm83722pji.32.2020.11.30.10.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:20:28 -0800 (PST)
Subject: Re: [RFC PATCH 07/13] fs/userfaultfd: support read_iter to use
 io_uring
To:     Nadav Amit <nadav.amit@gmail.com>, linux-fsdevel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201129004548.1619714-1-namit@vmware.com>
 <20201129004548.1619714-8-namit@vmware.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dcf0ca71-c3e3-a813-b04f-d3e86bcddd48@kernel.dk>
Date:   Mon, 30 Nov 2020 11:20:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201129004548.1619714-8-namit@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:45 PM, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> iouring with userfaultfd cannot currently be used fixed buffers since
> userfaultfd does not provide read_iter(). This is required to allow
> asynchronous (queued) reads from userfaultfd.
> 
> To support async-reads of userfaultfd provide read_iter() instead of
> read().
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: io-uring@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  fs/userfaultfd.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index b6a04e526025..6333b4632742 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1195,9 +1195,9 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
>  	return ret;
>  }
>  
> -static ssize_t userfaultfd_read(struct file *file, char __user *buf,
> -				size_t count, loff_t *ppos)
> +static ssize_t userfaultfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> +	struct file *file = iocb->ki_filp;
>  	struct userfaultfd_ctx *ctx = file->private_data;
>  	ssize_t _ret, ret = 0;
>  	struct uffd_msg msg;
> @@ -1207,16 +1207,18 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
>  		return -EINVAL;
>  
>  	for (;;) {
> -		if (count < sizeof(msg))
> +		if (iov_iter_count(to) < sizeof(msg))
>  			return ret ? ret : -EINVAL;
>  		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg);

'no_wait' should be changed to factor in iocb->ki_flags & IOCB_NOWAIT as well,
not just f_flags & O_NONBLOCK.

I didn't check your write_iter, but if appropriate, that should do that
too.

-- 
Jens Axboe

