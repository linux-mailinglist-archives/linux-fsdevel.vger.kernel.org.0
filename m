Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83D124D7AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHUOty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHUOtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:49:50 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF17AC061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 07:49:50 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t13so1594546ile.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cxwNFKr8C4GxHwwirPDVBn5gDOlxq9kCMJ9FIhV/7GY=;
        b=Tnzci+Hswj7hMTc7vA1mGeQReoVIr0yEMvnV9YEI5ZNO8EHi/EbODtgB9IZ8O9e0r4
         5331vH21P4cphP7O8x7DdidRe968kxztCR0wbRdQ90uXkHhFT2ZRndHIEd3zEwpOlUxf
         QZQ9oFO/A1IF8zu3FRLvxEqDaK6oW4Et07rabfta86yhpF5RHI90s1nuNQn1o6aGpgZV
         6dfBuucnLTzNOK1OgSpfAA8AdxMGWMlPlaxsE5B9zKCqy6CSOjIU10aRS80g9IFdlWOM
         o76/Fvv/zvyzxhhP5bsQ97og1Fcl2CciSIwyYBzZvEg5saoRAbQ8DXZ/L4UxgVmzZQTm
         SvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxwNFKr8C4GxHwwirPDVBn5gDOlxq9kCMJ9FIhV/7GY=;
        b=mjdkv2ozrcHBaKN1lzL4Xh16aWU7LOQwp05aiY2jAquRQvt+hW/MYiu+KRgOqN44L+
         rZrjJIw/+rNtd4IIcyuKnZEyk2QcQz3vpbh5rkBUODhcMT8z1r+a3qhwr+FR5XUKZep9
         aLuQdCZ2kF3y3F7OfOGmflIAjdiQ3VVa1Vh06PmoKpY1MgU/8DIBSQJWsO/7MjTW1w1L
         IFEqJadrb9OFcBSuOzoTopJldbEhzYmqyte1ccoI8J+OuNfWHSOf9qymNSpTvGNsetXl
         tJJCu5uoHnBbciu4XBif62uGSTzKY2eEWfLrwFvyrjifJ0Z/6ZpgXOU02tkl1AmZEKUa
         QBQw==
X-Gm-Message-State: AOAM532awEEzUIRQSShayNnVQy4+hZykbO9cxmyCEqGNVZDHLUje3QcT
        7Iiy7nah2iR4EIJ3RzFVz2qELg==
X-Google-Smtp-Source: ABdhPJxsuZGimz71cVC5o58/Sc9i/i1CQIN3kGd8VVPNvdqeDBYWjghwtjziXi83vGSc+UxIgacbpA==
X-Received: by 2002:a92:660e:: with SMTP id a14mr2868783ilc.290.1598021389768;
        Fri, 21 Aug 2020 07:49:49 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p20sm1331088iod.27.2020.08.21.07.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:49:49 -0700 (PDT)
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
To:     Christoph Hellwig <hch@infradead.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, riteshh@linux.ibm.com,
        linux-block@vger.kernel.org
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200821060710.GC31091@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9bf274cb-15ec-f389-42b3-b8469402af3d@kernel.dk>
Date:   Fri, 21 Aug 2020 08:49:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821060710.GC31091@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 12:07 AM, Christoph Hellwig wrote:
> On Wed, Aug 19, 2020 at 03:58:41PM +0530, Anju T Sudhakar wrote:
>> From: Ritesh Harjani <riteshh@linux.ibm.com>
>>
>> __bio_try_merge_page() may return same_page = 1 and merged = 0. 
>> This could happen when bio->bi_iter.bi_size + len > UINT_MAX. 
>> Handle this case in iomap_add_to_ioend() by incrementing write_count.
>> This scenario mostly happens where we have too much dirty data accumulated. 
>>
>> w/o the patch we hit below kernel warning,
> 
> I think this is better fixed in the block layer rather than working
> around the problem in the callers.  Something like this:
> 
> diff --git a/block/bio.c b/block/bio.c
> index c63ba04bd62967..ef321cd1072e4e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -879,8 +879,10 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>  
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> -			if (bio->bi_iter.bi_size > UINT_MAX - len)
> +			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> +				*same_page = false;
>  				return false;
> +			}
>  			bv->bv_len += len;
>  			bio->bi_iter.bi_size += len;
>  			return true;
> 

This looks good to me.

-- 
Jens Axboe

