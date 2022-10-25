Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3343C60C94D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiJYKDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 06:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJYKDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00FCE5EE6
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666691753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFghtX8+5Z9fyNGGUmcZkMnf8mhBMEpYEBcGksRdv88=;
        b=aUiE212qlZ8qDHU0977lFmg5oUzRELL+XChpEjL/nW/poxRS6AqWmLhATj6I27M17zRuBL
        dEoTZEkg9ljIuxuJ2zeYWEW8TSsF6O121h0fKGsjUjeVugqv43TnroLSD41KbY50rDNL7y
        SNVNNY5e0Fjh9pkGFLhCJSyf4sdHYbA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92-fUsZN327MM2A-8gKsi_PRQ-1; Tue, 25 Oct 2022 05:55:52 -0400
X-MC-Unique: fUsZN327MM2A-8gKsi_PRQ-1
Received: by mail-ed1-f72.google.com with SMTP id w20-20020a05640234d400b0045d0d1afe8eso11546329edc.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 02:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFghtX8+5Z9fyNGGUmcZkMnf8mhBMEpYEBcGksRdv88=;
        b=W1k68bJhJQhOeorn21i5U0yuxsrbsd3ven0JGtnHKApyEO86ylqHzoFEfRGf30hEwt
         5hZwqTyT8OaH38jXy8GzfKtf1eiIK3P2X6QYpytZ1xQJsRhhNqA9YOLDYo42gjSB1ihF
         UYzAInbijE36hI2n/8D7jqK3wt0QXap8m0zJHXoZCxe9tPV3bXvJA9BVYjtJvS0h1inP
         dHVlKkDMQaSQax5KJTad++bm+hmmzCOUoJtViB6tGeV63CJoN5WHRQxz27t4/449S1OZ
         hR79NMAonXDHGvNEwhwN61v/Hv5ThcWNOgTSgLReUYCHVy3UyuIQASKW2mFJCXASR5Oy
         EhNA==
X-Gm-Message-State: ACrzQf25f1KLCIidq8F8zY++r9IhtCNJJuj+kr4xsbrbVBAa9seNbHcv
        z1gIvv1u7RxLSy1pfASSMEOwbjUP+5DUeeJzjL9Krm7D0t5hDokNw9SvOULvLrZkR5lO52U4379
        oFmx87+Kpr5TTXUJz0XTAA3DT0A==
X-Received: by 2002:a17:907:1ca7:b0:7a7:fc67:c85e with SMTP id nb39-20020a1709071ca700b007a7fc67c85emr8492258ejc.492.1666691750765;
        Tue, 25 Oct 2022 02:55:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6nTEpm7rexwYPAJkJJ33jDDIWe6Oh3747xhMJ+MVZs2Tv73syscStw0azryhlIMUnw8W7VGQ==
X-Received: by 2002:a17:907:1ca7:b0:7a7:fc67:c85e with SMTP id nb39-20020a1709071ca700b007a7fc67c85emr8492245ejc.492.1666691750556;
        Tue, 25 Oct 2022 02:55:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b00780982d77d1sm1114659ejb.154.2022.10.25.02.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:55:49 -0700 (PDT)
Message-ID: <b9110803-0bbe-1a54-6a29-c5e5603dc7a6@redhat.com>
Date:   Tue, 25 Oct 2022 11:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] vboxsf: Remove variable out_len
Content-Language: en-US, nl
To:     Colin Ian King <colin.i.king@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024164011.2173877-1-colin.i.king@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221024164011.2173877-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 10/24/22 18:40, Colin Ian King wrote:
> Variable out_len is just being incremented by nb and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
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

