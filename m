Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C395E63F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 15:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiIVNpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 09:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiIVNpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:45:25 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E205FF4E
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 06:45:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c19so6143123qkm.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lTLxj593wgb0rSkyx/kVpkcZN0XitEmW0vMjErWHotA=;
        b=FyJaKv2cOaRg6P7yvu8zs1jVRm/8RMTbc6dfECJ+ZO5o/HmyZWXx30/9G58nVbrc5b
         uilHyUda0dD/kYG1qtguthEwDaL9y8JeP+HPCBHfMWclRlKZoOK/NXZxzGUfoaxervvy
         D0TcePhLr6rEHe3E5Hlf5A5QN/T9th71F+ymU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lTLxj593wgb0rSkyx/kVpkcZN0XitEmW0vMjErWHotA=;
        b=r44WkjQUpRGAI1va2SdYXAWmEstlKmt5aMa+5nzduTDxl3nt00CBnC/Zm5vVDiliSJ
         70b2c7DN/SpyZ6ydaoGj9ZiwvXo9FIpFcnj+5iTIm6CMoeobSFIFXxFtm61wdyZ044ms
         vs6LZSXqLKFupQNkjL0Kf+0OBEEdI/+61rLDBCOyU4cbZUElGJpsGA3MKqnVacUISLhp
         olEOxAui0dYlxJ37dLccJypBEIF8W60rXZgkMgl1NqGYr7ett8PlZjg7Fdgimt/LJzTd
         Ek7aoNsQkvHCgoYLN8L1svPAGWkZ7IsfPxNOjPB8OnPXAG8KFzqm3tN20EucXOEYcVTT
         U9cQ==
X-Gm-Message-State: ACrzQf3v3Db77nUW1QLA5YK5O8j4Q+T3BgRDVrpOEtJS6uq6dJVBp57E
        Wa+6fSp9IfIYR9BF99PETaNZ6Q==
X-Google-Smtp-Source: AMsMyM6DBqbYqDsHBnddfGDZuwycGpoIY7LinhBIG4+l+K0bdEu/uf1UKptO3KnL1trAn9LU6bZY/Q==
X-Received: by 2002:a05:620a:f15:b0:6cf:2130:88e3 with SMTP id v21-20020a05620a0f1500b006cf213088e3mr2093263qkl.519.1663854322211;
        Thu, 22 Sep 2022 06:45:22 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id w7-20020ac857c7000000b0035bbb6268e2sm3902332qta.67.2022.09.22.06.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 06:45:21 -0700 (PDT)
Message-ID: <4d75a9fd-1b94-7208-9de8-5a0102223e68@ieee.org>
Date:   Thu, 22 Sep 2022 08:45:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/12] net: ipa: Proactively round up to kmalloc bucket
 size
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jacob Shin <jacob.shin@amd.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, dev@openvswitch.org,
        x86@kernel.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20220922031013.2150682-1-keescook@chromium.org>
 <20220922031013.2150682-4-keescook@chromium.org>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20220922031013.2150682-4-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/22 10:10 PM, Kees Cook wrote:
> Instead of discovering the kmalloc bucket size _after_ allocation, round
> up proactively so the allocation is explicitly made for the full size,
> allowing the compiler to correctly reason about the resulting size of
> the buffer through the existing __alloc_size() hint.
> 
> Cc: Alex Elder <elder@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/net/ipa/gsi_trans.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
> index 18e7e8c405be..cec968854dcf 100644
> --- a/drivers/net/ipa/gsi_trans.c
> +++ b/drivers/net/ipa/gsi_trans.c
> @@ -89,6 +89,7 @@ int gsi_trans_pool_init(struct gsi_trans_pool *pool, size_t size, u32 count,
>   			u32 max_alloc)
>   {
>   	void *virt;
> +	size_t allocate;

I don't care about this but the reverse Christmas tree
convention would put the "allocate" variable definition
above "virt".

Whether you fix that or not, this patch looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

>   	if (!size)
>   		return -EINVAL;
> @@ -104,13 +105,15 @@ int gsi_trans_pool_init(struct gsi_trans_pool *pool, size_t size, u32 count,
>   	 * If there aren't enough entries starting at the free index,
>   	 * we just allocate free entries from the beginning of the pool.
>   	 */
> -	virt = kcalloc(count + max_alloc - 1, size, GFP_KERNEL);
> +	allocate = size_mul(count + max_alloc - 1, size);
> +	allocate = kmalloc_size_roundup(allocate);
> +	virt = kzalloc(allocate, GFP_KERNEL);
>   	if (!virt)
>   		return -ENOMEM;
>   
>   	pool->base = virt;
>   	/* If the allocator gave us any extra memory, use it */
> -	pool->count = ksize(pool->base) / size;
> +	pool->count = allocate / size;
>   	pool->free = 0;
>   	pool->max_alloc = max_alloc;
>   	pool->size = size;

