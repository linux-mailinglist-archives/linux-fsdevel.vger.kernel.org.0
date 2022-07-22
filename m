Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12C57E970
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jul 2022 00:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiGVWBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 18:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVWBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:01:10 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7BD12AD3;
        Fri, 22 Jul 2022 15:01:09 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id 17so5573573pfy.0;
        Fri, 22 Jul 2022 15:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ajABxSWxUsCKK9Od/qyGt1skys7+Os0a1j5QneotZAc=;
        b=pHTVnlr0j8aazre/ckFL9Ibpo2RrF48v+q9azJxE6tMLk1jPDzLet2UIZSOajgLbvL
         KNuzEAGlfy17au3yClIknYryV7aA1wdQgK286ienNuI9sAUvjoQY2AJm7yojGXB21oLU
         6db3XQL1OM6syNcGt1Z9j8BTr/jXg2tGwKpSohuexEmkuADi3TMZV37rReY5Tdyt5w9J
         wlVQyt4tZ6t+/U5mwtHW+pdxNHuYj2eoEEOMe/DoQCH4nyVRarHuYgZwharKcDDhxts7
         G977jhODVOlhWhJQqVai6+5pJ50DbgH8fTXc1fZo9d+AgtxTgxSvXS9nCuVquxyubPEE
         dNIQ==
X-Gm-Message-State: AJIora/QoTqcRb0nJLywOgBx34AJUav/TqDyBooXyRIsB3Bga9UhUvjS
        iuPCyW7d9Hn6koKOuQgQNXDxB1N9aDkUOQ==
X-Google-Smtp-Source: AGRyM1vg+HIfwhtPL+PdWNr+gthVaYVrLjl4aYh4LyhLKIfuUmvhrIx/NVwQSMMB+QOUIwNSw5D80g==
X-Received: by 2002:a63:5b5f:0:b0:416:1e31:5704 with SMTP id l31-20020a635b5f000000b004161e315704mr1494610pgm.523.1658527269253;
        Fri, 22 Jul 2022 15:01:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:805b:3c64:6a1f:424c? ([2620:15c:211:201:805b:3c64:6a1f:424c])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b0016c46ff1973sm4220464pla.228.2022.07.22.15.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 15:01:08 -0700 (PDT)
Message-ID: <a1cceb79-c72c-5a76-ed7a-156c09505692@acm.org>
Date:   Fri, 22 Jul 2022 15:01:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv6 07/11] block/bounce: count bytes instead of sectors
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-8-kbusch@fb.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220610195830.3574005-8-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/22 12:58, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Individual bv_len's may not be a sector size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   block/bounce.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index 8f7b6fe3b4db..fbadf179601f 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -205,19 +205,26 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>   	int rw = bio_data_dir(*bio_orig);
>   	struct bio_vec *to, from;
>   	struct bvec_iter iter;
> -	unsigned i = 0;
> +	unsigned i = 0, bytes = 0;
>   	bool bounce = false;
> -	int sectors = 0;
> +	int sectors;
>   
>   	bio_for_each_segment(from, *bio_orig, iter) {
>   		if (i++ < BIO_MAX_VECS)
> -			sectors += from.bv_len >> 9;
> +			bytes += from.bv_len;
>   		if (PageHighMem(from.bv_page))
>   			bounce = true;
>   	}
>   	if (!bounce)
>   		return;
>   
> +	/*
> +	 * Individual bvecs might not be logical block aligned. Round down
> +	 * the split size so that each bio is properly block size aligned,
> +	 * even if we do not use the full hardware limits.
> +	 */
> +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >>
> +			SECTOR_SHIFT;
>   	if (sectors < bio_sectors(*bio_orig)) {
>   		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
>   		bio_chain(bio, *bio_orig);

Do I see correctly that there are two changes in this patch: counting 
bytes instead of sectors and also splitting at logical block boundaries 
instead of a 512-byte boundary? Should this patch perhaps be split?

Thanks,

Bart.
