Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB75F599849
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348062AbiHSJCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 05:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347758AbiHSJCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE63F23CC
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660899724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEfW7ReoLmryNEcARNfg07Sg9GJahxErmaUt7dgovGs=;
        b=Oo1LpavUTaBdW8wB+hctihaNpYVwkJqMrnon5+ozZn736QkTwDeGPrz+Fp+2slhAbPVKho
        yLYv/MiMVWoqHdzk2z1cF+LahZz3f8IadP4EFHznSpi6BOB8SflLR+nyAdn714vpn2o5mi
        q4HjcY2P0jqPcRmZf0fIK4SZWs0fCWo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-ff185qT4Pki9Hjn6lyBgZg-1; Fri, 19 Aug 2022 05:02:00 -0400
X-MC-Unique: ff185qT4Pki9Hjn6lyBgZg-1
Received: by mail-ed1-f69.google.com with SMTP id i5-20020a05640242c500b0043e50334109so2501580edc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 02:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eEfW7ReoLmryNEcARNfg07Sg9GJahxErmaUt7dgovGs=;
        b=NTf7vvqbNLVmxmHdPEdrz7X4IZgVopuQ9Sr4+zseqNl5JJEAoOhdBRrl3P3/smWnW6
         WVSgUame5pOEqod/XDzIAJpDb3LOo9WeR3VJIZGFRqMHYx2xR3NMgEyCNsRu8OAEbMb4
         W4/eDsM5pfeKEs5FKkpHTpzJMQeySur4waPt7umITNY0oWIKLGKIGrar9VxEJNo/dw39
         ArOiDKfpkJ/Wqebgy59pwP6ouBEez0joq679L59aaVAkbSLod4sL/g1GiIjgyeeTFPgE
         GJxv0bWxveU6jZPPEo8iwIvRYbkrvLhqxmi9HJDGOEMyotpLzwpJjfUDsxhAQpf2fkJk
         y+nQ==
X-Gm-Message-State: ACgBeo3RRI2PZq/UqBj6iK12mw2qkI2MLsD2n6boc3FI/VVJ58nq78Ij
        KQbZvZxHbjJp7xAb9DHPCkiJmnRMGkNL4jMiWQWsXypidhYho4F5SkeT86MXhcl6ixxzcQxVWTx
        AjnERdhHrhfNNQkaQEXUK134QnQ==
X-Received: by 2002:a17:907:87b0:b0:731:3dfd:bc8d with SMTP id qv48-20020a17090787b000b007313dfdbc8dmr4123143ejc.607.1660899719731;
        Fri, 19 Aug 2022 02:01:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7E0ua2jt56jCJhgZ1Zi+E94qUCOPgqarmfIh3Ahk9122KuW6NdZk8QZSutvBvVehFspEl3hQ==
X-Received: by 2002:a17:907:87b0:b0:731:3dfd:bc8d with SMTP id qv48-20020a17090787b000b007313dfdbc8dmr4123128ejc.607.1660899719497;
        Fri, 19 Aug 2022 02:01:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c22-20020aa7df16000000b0043bbcd94ee4sm2774290edy.51.2022.08.19.02.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:01:59 -0700 (PDT)
Message-ID: <db332252-9077-cdf6-27f8-53bb0007f6ea@redhat.com>
Date:   Fri, 19 Aug 2022 11:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] vboxsf: move from strlcpy with unused retval to strscpy
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
References: <20220818210154.8119-1-wsa+renesas@sang-engineering.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220818210154.8119-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 8/18/22 23:01, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  fs/vboxsf/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index d2f6df69f611..1fb8f4df60cb 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -176,7 +176,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  	}
>  	folder_name->size = size;
>  	folder_name->length = size - 1;
> -	strlcpy(folder_name->string.utf8, fc->source, size);
> +	strscpy(folder_name->string.utf8, fc->source, size);
>  	err = vboxsf_map_folder(folder_name, &sbi->root);
>  	kfree(folder_name);
>  	if (err) {

