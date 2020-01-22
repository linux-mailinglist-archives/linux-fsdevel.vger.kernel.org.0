Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D63A144997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 02:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAVByR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 20:54:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgAVByQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:54:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so2469385pfg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 17:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1XK4Ony62q0qYCnmXBgxpfnUcnSnUtNFwu//NBpHxT4=;
        b=lUi4mdfgEh6SrLHZeN6m78Vcslz6pj9bZ2sQ97+imdXSrxlCUfAqG/IUH4+u9gsNWm
         +T0PisZcqv8v/pyXOCWR5sIIf9cwBFXnHhi6ABzhld1+WTWUEJTI/4+oo2t25Kmd7Nzb
         PDkWFhMk3szstmlduOoko+QJclNvx4quL/rqbkHMdciWp5iqb5bZtmIHEYIGKWxK3WlB
         P/dONJXy8T+NCMvrgD/HsdegKjrIcdv44fVedH/8DAIUwFIWlu/23GRgQleAvTCwq6PK
         eEbRNbp8zp6CB1BPQfHedLnWl3W7sJY/5Wr5jSdAguuolCY8O9ta/8WcpTgorMtu7EbU
         ukpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1XK4Ony62q0qYCnmXBgxpfnUcnSnUtNFwu//NBpHxT4=;
        b=t7i10pr60sBsxRO6yXsLhY4iGZJExJyuC3Ryrqq6lHcMcW2hMIoQeW8S2f/rgwaGxF
         kGj0wQaQ6gPf8MJr9ZrrNt5ZOwc/fbxWdEz80qD15JfJBxkcpCS5/dvA6nCuSWbC4/0l
         QzMCxu//2HzUGVlixJMLIdNyCU+d8QTFD4gFxz7zWY8ugS4UokahCPGICn+/AW6KS/o7
         yMHYTobq6Y8oSvOoO3PY5exiahSmU8wrTcvwXT484hIBH9/HqCmGdS7jU131+XaUnsbn
         v//TEaEWcg2jGB5pY7ypoUCsywfyxUZu4ixwcqFTlacFPyetCzZDXrOlPUN6JFTN04H6
         JCqQ==
X-Gm-Message-State: APjAAAX/ixJIOrU9nuyTZsRwVIfOSUThMMvNCFf9Bynpoh9xonhCWGGe
        kzd38lDSF0/jxXoEt3afLOK1SA==
X-Google-Smtp-Source: APXvYqyHPZGoI0DOJX188jpo4oSvQ7q0zhBrnRPd+20XuSAAKqHU+Ag8LXQUVUpyVPb6gNP1OuIwwg==
X-Received: by 2002:a62:6805:: with SMTP id d5mr414576pfc.125.1579658056278;
        Tue, 21 Jan 2020 17:54:16 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id x18sm45635790pfr.26.2020.01.21.17.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 17:54:15 -0800 (PST)
Subject: Re: [PATCH 2/3] io_uring: add interface for getting files
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1579649589.git.asml.silence@gmail.com>
 <96dc9d5a58450f462a62679e67db85850370a9f6.1579649589.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74320473-6f9f-7b10-4d5c-850c6f3af5ae@kernel.dk>
Date:   Tue, 21 Jan 2020 18:54:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <96dc9d5a58450f462a62679e67db85850370a9f6.1579649589.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/20 5:05 PM, Pavel Begunkov wrote:
> Preparation without functional changes. Adds io_get_file(), that allows
> to grab files not only into req->file.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 66 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 8f7846cb1ebf..e9e4aee0fb99 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1161,6 +1161,15 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>  	return NULL;
>  }
>  
> +static inline void io_put_file(struct io_ring_ctx *ctx, struct file *file,
> +			  bool fixed)
> +{
> +	if (fixed)
> +		percpu_ref_put(&ctx->file_data->refs);
> +	else
> +		fput(file);
> +}

Just make this take struct io_kiocb?

Apart from that, looks fine to me.

-- 
Jens Axboe

