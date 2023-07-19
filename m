Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323BF759024
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 10:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGSIWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 04:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGSIWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F77B172E
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689754875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHNdzhJYXIyEvVVXeSxx/4ftxohEVfyVH2IVByUb0ic=;
        b=H+85tU3l/XL2ySiw1RieVnRnd6OaOXcXMdxqg8OZbdp7J3klrQm/jrs9qEseqh4gA5bo04
        sIapRpQfiAJMLpDN63kSjdesp2Yq5gp+i5V8RVQd7I6RlHmIqjuEyYLzFcNKps/wIZvV+f
        BX1dVl8n3OyO6l0yLwelTperNImAVrQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Prp3iTBiP-i8FZ9ko--G3w-1; Wed, 19 Jul 2023 04:21:14 -0400
X-MC-Unique: Prp3iTBiP-i8FZ9ko--G3w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb76659d44so5671772e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 01:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754873; x=1692346873;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHNdzhJYXIyEvVVXeSxx/4ftxohEVfyVH2IVByUb0ic=;
        b=bXNtKWBPrP33gXGuVSy4FM3bRpHVKQ/VMtoFKIwztUQKHyJO0ZpliYGkIM/34c/9XF
         vmZC/b9xoHxvfVy/ImL+/nILZRQRcumcnDOwe/OCu9YsBzaaalI3lr7bNuiBP+5i4bb/
         ocrqCb36MBlSTc2zbyyqSLSHpstyt8Qk3Hhf/aP90b1TwbDPlI8sheSooHenjM37OY6b
         Uyvr7+Ly33brd3lhzzgsN4ILW/Xeh/J/6b5mhVo2SKfZtGiCoeVboC4iHGZEScSt6Y+t
         fVKgmA8L4WXTecM6IgtfM79TzcZyRvAkvs3rZbPwfi5t3Z6DYiitkxdzdxgV2jEh1CO8
         Y/Sw==
X-Gm-Message-State: ABy/qLboZCmyR1hJA0Sft91A8YmHpg/UDY6c0C5Gxi7Y3h3QP/yNKfOe
        Szgme28dPxHXpSZCJ3iAVc325z0ccFtVo6/Dg0s0D/LyB55pg+TP8dgwndu1K4G5Le4eWFMGK1v
        atrS1kN8Ar4F3c8YueZZRihI5ysp21/QK1w==
X-Received: by 2002:a05:6512:750:b0:4fb:8cc0:57e3 with SMTP id c16-20020a056512075000b004fb8cc057e3mr1188127lfs.62.1689754872990;
        Wed, 19 Jul 2023 01:21:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFai0n0RcKXdiYpXZ+aojTS7Ksd/OHMwbJ10bIJdz+36AnhayvLRUmFZjEcfE4R/uLtmx1AWQ==
X-Received: by 2002:a05:6512:750:b0:4fb:8cc0:57e3 with SMTP id c16-20020a056512075000b004fb8cc057e3mr1188110lfs.62.1689754872632;
        Wed, 19 Jul 2023 01:21:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63? (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de. [2003:cb:c74b:4f00:b030:1632:49f2:63])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c230700b003fba6709c68sm1048356wmo.47.2023.07.19.01.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 01:21:12 -0700 (PDT)
Message-ID: <0dc0e6b5-4c07-2ae3-80d3-99a5386c8f7d@redhat.com>
Date:   Wed, 19 Jul 2023 10:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/4] perf/core: use vma_is_initial_stack() and
 vma_is_initial_heap()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-5-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230719075127.47736-5-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.07.23 09:51, Kefeng Wang wrote:
> Use the helpers to simplify code, also kill unneeded goto cpy_name.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   kernel/events/core.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 78ae7b6f90fd..d59f6327472f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8685,22 +8685,14 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
>   		}
>   
>   		name = (char *)arch_vma_name(vma);
> -		if (name)
> -			goto cpy_name;
> -
> -		if (vma->vm_start <= vma->vm_mm->start_brk &&
> -				vma->vm_end >= vma->vm_mm->brk) {
> -			name = "[heap]";
> -			goto cpy_name;
> +		if (!name) {
> +			if (vma_is_initial_heap(vma))
> +				name = "[heap]";
> +			else if (vma_is_initial_stack(vma))
> +				name = "[stack]";
> +			else
> +				name = "//anon";
>   		}
> -		if (vma->vm_start <= vma->vm_mm->start_stack &&
> -				vma->vm_end >= vma->vm_mm->start_stack) {
> -			name = "[stack]";
> -			goto cpy_name;
> -		}
> -
> -		name = "//anon";
> -		goto cpy_name;

If you're removing that goto, maybe also worth removing the goto at the 
end of the previous if branch.

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb

