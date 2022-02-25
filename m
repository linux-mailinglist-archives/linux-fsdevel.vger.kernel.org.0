Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D144C415D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 10:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbiBYJZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 04:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbiBYJZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:25:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7ADE26F4EF
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 01:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645781074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g96ZVNvLrOLa+/sOTt4MsYn0WW+lDjtbFUs1A2su27M=;
        b=AIarqR4SaNeeJjrHTQMhSZqU1VJ2yNQg5dLjoMisGbuYc52nMqROp/X96tBToW3AEi+3om
        t0n6YmICCDaaE5pdZLSmcBD2j91XwYWDCdBDWWONW5CsVRRhY8iF5o5xEOqdEAFGTQYc9w
        baZ1dOwO1R4pPOEqEiZuByDChygLBKg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-OGOphgPmOTqs8mbfeVV0Vw-1; Fri, 25 Feb 2022 04:24:33 -0500
X-MC-Unique: OGOphgPmOTqs8mbfeVV0Vw-1
Received: by mail-ed1-f70.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so2058610edb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 01:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g96ZVNvLrOLa+/sOTt4MsYn0WW+lDjtbFUs1A2su27M=;
        b=mSyqFNmCOdKecUyuhNZMKE4WXTJ3eBMi8OCLH0qc1j2Kl8wIljvb3X0jIihmy57HnX
         hUBFdCEMFEb8cxeJ+/YZI/MYEljQs3KAd9HqfF86Eq1IwjqXluc4kvlYa/OGD9guOxwq
         VsJ3duSm+2DeA3gdesK6j7iUqjlkVwk8rUrgKdcKezdyUIjA0l5iHAWT6AmGtG/sg4Ap
         I8s/0ts5tjLPIR+yAk4kQvTBnQ9CkKcXsH4KNbBZfwu87ngqcFAlxcxUDk4lg8AmKNca
         YZv91bK/11n61MUp5i53a7EmOsM78C52d7MSqYExffyAxI3wGXMdaxNBKJsa3zqmON3v
         yzhQ==
X-Gm-Message-State: AOAM53059VO+O0E/uEiKkOGGOKN89CLKtStwTdff1/UBQ09Yh0JGebi9
        rtjcmQe8+icds10F80sJOxtY6wu9r0KqCQhFVaI/Tm9WcZFFAzQZNmMMwweIZfGkHxpIcMNfYFb
        OwLlnuMfPjQa5Em2iFgPCnod52g==
X-Received: by 2002:a05:6402:4495:b0:410:a171:4444 with SMTP id er21-20020a056402449500b00410a1714444mr6216767edb.20.1645781072035;
        Fri, 25 Feb 2022 01:24:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0eYLNyrWUAkPpwNRuhHc6bulLWQnInGVAT//ekRVG8G32hyLnRX9/+ykMmoIWE+zm2NAjdw==
X-Received: by 2002:a05:6402:4495:b0:410:a171:4444 with SMTP id er21-20020a056402449500b00410a1714444mr6216756edb.20.1645781071846;
        Fri, 25 Feb 2022 01:24:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id y18-20020a056402271200b0041110d6b80asm1075169edd.39.2022.02.25.01.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 01:24:31 -0800 (PST)
Message-ID: <f54a44e7-1ae5-1e09-9e62-2039dd5639dc@redhat.com>
Date:   Fri, 25 Feb 2022 10:24:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] vboxsf: Remove redundant assignment to out_len
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220225074838.553-1-jiapeng.chong@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220225074838.553-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2/25/22 08:48, Jiapeng Chong wrote:
> Clean up the following clang-w1 warning:
> 
> fs/vboxsf/utils.c:442:9: warning: variable 'out_len' set but not used
> [-Wunused-but-set-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Changes in v2:
>   -Delete " out_len += nb;".
> 
>  fs/vboxsf/utils.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index e1db0f3f7e5e..7f2838c42dcc 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -439,7 +439,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  {
>  	const char *in;
>  	char *out;
> -	size_t out_len;
>  	size_t out_bound_len;
>  	size_t in_bound_len;
>  
> @@ -447,7 +446,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  	in_bound_len = utf8_len;
>  
>  	out = name;
> -	out_len = 0;
>  	/* Reserve space for terminating 0 */
>  	out_bound_len = name_bound_len - 1;
>  
> @@ -468,7 +466,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  
>  		out += nb;
>  		out_bound_len -= nb;
> -		out_len += nb;
>  	}
>  
>  	*out = 0;

