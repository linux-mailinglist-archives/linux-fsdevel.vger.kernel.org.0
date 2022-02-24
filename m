Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1EF4C2E74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 15:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiBXOaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 09:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiBXOaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:30:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71D211637FC
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 06:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645712969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+rrF8JUub4OBg9MyDm/2REtxx0IIbE/BeW/5erIvm0=;
        b=YJYKHEI9kTboQT2+LrEIgfPuoULZKPlWtU70TY8jcSEgwzOeHTHRYVmbHZHV+sm72kWT93
        eKRNDvQ8w6aAuCedPzAWb6xP7vQI494BdGOxdJS0+s0Q5DDhW+YAbrMmrU3ahhp2QwR6f5
        /+Mp86pxuXMxrfWxxXNhFaMzAnFlDWI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-4KT2kAoNNQWkoJqe4c1Z4g-1; Thu, 24 Feb 2022 09:29:28 -0500
X-MC-Unique: 4KT2kAoNNQWkoJqe4c1Z4g-1
Received: by mail-ej1-f70.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso1296757ejj.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 06:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g+rrF8JUub4OBg9MyDm/2REtxx0IIbE/BeW/5erIvm0=;
        b=pB4Wsn0TpMbyrHHJMbT6s0WThPY3c1a7PUM96oAWhSl6FKiRzU8NcPNeMuPZ+gYh2N
         NUqgUAYh71N0lDpwnq1c6HluJkTJRD0Ay8mR8Ck+eOskeZP+vw4sTXxIdRkypAZgZ0Z3
         NVcJH0Ok+LSpyb7eMC7hbFV0WZkqnjQ5BJSTqc7/erCx0eB/66vp1OnYC+Aq10cg4Vok
         RKdc4wozDXoa4GRrtj9MPZ7TFKIztRMx8FPrdjzUkjbDlp267crcWriSBEsvLeDvMCIZ
         LkjXrQsonGIu96n/g7x04+LJaRggWuhUtrEefL43hQhYARusdXMwnyS1hoTA+r9TEOG5
         02lw==
X-Gm-Message-State: AOAM530Hw4xMEs9nTZJjhgu2eBKCJusxwi10/gpSdArFjXtxyKBy6xaQ
        g9RSib1GHSKmH5LN08OvEHoD6tKf79MktajYyaHIyC/YUzTJESz5xHteZnBMWqR3FinOemy4jAR
        c5V4x3as4TLxsJqKQIr8ykhgxnA==
X-Received: by 2002:a17:906:edb5:b0:6b8:1a5a:f3a0 with SMTP id sa21-20020a170906edb500b006b81a5af3a0mr2569833ejb.501.1645712966833;
        Thu, 24 Feb 2022 06:29:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjZMkWgbXyLCpjc8uqWGsi03sjuHBM8goCnZK40Hcr3xl8F7jTXXvNZQBGS3MZsj62ipbJbA==
X-Received: by 2002:a17:906:edb5:b0:6b8:1a5a:f3a0 with SMTP id sa21-20020a170906edb500b006b81a5af3a0mr2569822ejb.501.1645712966649;
        Thu, 24 Feb 2022 06:29:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id 23sm1421805ejf.215.2022.02.24.06.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:29:26 -0800 (PST)
Message-ID: <ce8652bc-ad1d-b158-2822-33681ac3ea91@redhat.com>
Date:   Thu, 24 Feb 2022 15:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] vboxsf: Remove redundant assignment to out_len
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220224104853.71844-1-jiapeng.chong@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220224104853.71844-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2/24/22 11:48, Jiapeng Chong wrote:
> Clean up the following clang-w1 warning:
> 
> fs/vboxsf/utils.c:442:9: warning: variable 'out_len' set but not used
> [-Wunused-but-set-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

This is not the correct fix out_len indeed is never read
anywhere in this function, so the correct fix is to
completely remove the out_len variable .

Regards,

Hans



> ---
>  fs/vboxsf/utils.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index e1db0f3f7e5e..865fe5ddc993 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -439,7 +439,7 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  {
>  	const char *in;
>  	char *out;
> -	size_t out_len;
> +	size_t out_len = 0;
>  	size_t out_bound_len;
>  	size_t in_bound_len;
>  
> @@ -447,7 +447,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  	in_bound_len = utf8_len;
>  
>  	out = name;
> -	out_len = 0;
>  	/* Reserve space for terminating 0 */
>  	out_bound_len = name_bound_len - 1;
>  

