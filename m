Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD8611C83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJ1Vlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 17:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1Vlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:41:35 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866CF21CD41;
        Fri, 28 Oct 2022 14:41:34 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id f140so5874470pfa.1;
        Fri, 28 Oct 2022 14:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yLhokJ+UmxEJSZnnxkcKNalWhkKir6IRhNGBiNycOM=;
        b=mi2YALTULPLHB8iYZnXrokGQWwMQ0ol9pgH8EVaKWeBH82I+9fh6j0LVGYseK1kEGr
         K3I46ZEPGQnGXkNu2cCFBsrmdN4DEqTeBz6gu2RqT671pjw3wlF/Yi4XHsSSzaSjzqqa
         /7fLx0nzoU8XvOqqqKb4NpOsxFZsqtdxcR8VhoSWOXKKEYjYyqUTjpl4yrrrsuf73K3Y
         7TqNDLry+rrZ5VsngIKxVhtR6bOnD0MC8UlT6SWr4yyEZsVe3ujpLy/0MCXBX0rUAO2H
         k+6h6Ma3nU6AWFC1vPFDK9PxueSq0KzGjlcOMc8B9cKS5s7dKpOYrh0cs8lzp5sEFwVF
         yTig==
X-Gm-Message-State: ACrzQf22BZvqF4necfh0KxW/v7a0Y0oUgmwPyMYF8+jHZ2JilNT5ZTWu
        dneSZLCqfdlzneBzbVNWkhSIhtnXyu0=
X-Google-Smtp-Source: AMsMyM56cv/TcV/tu9kmdxb/UqlsxmUR9FTduV7e4wtPCj7AZzYHAujzM3H4DTcW77IwkDpjgzj9kw==
X-Received: by 2002:a63:5d12:0:b0:46e:cd38:3f76 with SMTP id r18-20020a635d12000000b0046ecd383f76mr1351032pgb.64.1666993293952;
        Fri, 28 Oct 2022 14:41:33 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090ac91300b002036006d65bsm2953369pjt.39.2022.10.28.14.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:41:33 -0700 (PDT)
Message-ID: <b69e7350-b4ec-a575-ee46-15198b9fea73@acm.org>
Date:   Fri, 28 Oct 2022 14:41:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] iomap: directly use logical block size
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.de, djwong@kernel.org,
        Keith Busch <kbusch@kernel.org>
References: <20221026165133.2563946-1-kbusch@meta.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221026165133.2563946-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/26/22 09:51, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Don't transform the logical block size to a bit shift only to shift it
> back to the original block size. Just use the size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   fs/iomap/direct-io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 4eb559a16c9e..503b97e5a115 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -240,7 +240,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>   {
>   	const struct iomap *iomap = &iter->iomap;
>   	struct inode *inode = iter->inode;
> -	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> +	unsigned int blksz = bdev_logical_block_size(iomap->bdev);
>   	unsigned int fs_block_size = i_blocksize(inode), pad;
>   	loff_t length = iomap_length(iter);
>   	loff_t pos = iter->pos;
> @@ -252,7 +252,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>   	size_t copied = 0;
>   	size_t orig_count;
>   
> -	if ((pos | length) & ((1 << blkbits) - 1) ||
> +	if ((pos | length) & (blksz - 1) ||
>   	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>   		return -EINVAL;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
