Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A910599834
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 11:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346935AbiHSJBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 05:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346456AbiHSJBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F49F14EB
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660899711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrT3slIrGR+Wi5eJUyxjf9Z5bWJXC3nzxIbxu7wbVnw=;
        b=FFHrppgyuXWaI3pRrnQVrMRNPRZcQOUZvAeK0oKWzP3d0hpkxnwA0+wjGrafLWOiVdmYFp
        dbGUaDt/L+RZ02Lspv+lvyQA5t+3ybdPjsPRIVTD4RWtvCcmOhQaLqgLQhYLx1Ss5PHGUp
        iRvelkactlC6N6GjEkMr1i2sqlTttxI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-548-aQlMIy9KNxCBOeIcGqyttg-1; Fri, 19 Aug 2022 05:01:47 -0400
X-MC-Unique: aQlMIy9KNxCBOeIcGqyttg-1
Received: by mail-ed1-f69.google.com with SMTP id j19-20020a05640211d300b0043ddce5c23aso2487325edw.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 02:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CrT3slIrGR+Wi5eJUyxjf9Z5bWJXC3nzxIbxu7wbVnw=;
        b=iJ3NghKON8tWxK3WpNKP8Z6O7Os171HVSupJzp6qST9KY1pLBcC1dALeMSHSXvsfZz
         e9XBwPgUaI/M420AV2M0CYcS1WR53nrkoT35DVXc1IdT+MOG1T34g4pjXOp2jeBH7YeS
         2C3ihzFhwLGZiBYP1+X4447Cnvg03fZPQwP8hfvAIQy9mIYaxRU+Tk2wNZiCf2k+Y4bg
         Ozq/RMXESfQ2U8UQSFwofaihYaUrEE8nP6M1x9QMIcifUmuWjjeisVBL61seEc0M4AAd
         J308znUGcSADHdfS8yrBXV4phpq7/F2kz/NW7Ay4hoCuCkqfro0uuoBmdlLPfOuzGCV3
         ELtQ==
X-Gm-Message-State: ACgBeo1TftrpTTLAsSw3274ai2tarD27he+LHbLa9DcGvqWw/dGCCI2B
        HCT3kkAkif1dY0u64RCLwOKIDxkKr2zAf39UCXFTnYSYlWURhQMPMwlfQzh3m/SAO7tuo/5hPl8
        1Z178G1uCHDXMeKdAqyb4ZtGeDg==
X-Received: by 2002:a17:907:9710:b0:731:67b1:dc3b with SMTP id jg16-20020a170907971000b0073167b1dc3bmr4297290ejc.709.1660899706340;
        Fri, 19 Aug 2022 02:01:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6CKxALS09Z3BsqpKyFa/xJwSbl1/25PfL3hUiAA8X/A0+o+81dmJop4GIVtogOnofX76HMKg==
X-Received: by 2002:a17:907:9710:b0:731:67b1:dc3b with SMTP id jg16-20020a170907971000b0073167b1dc3bmr4297279ejc.709.1660899706110;
        Fri, 19 Aug 2022 02:01:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ss28-20020a170907c01c00b00730a18a8b68sm2014654ejc.130.2022.08.19.02.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:01:45 -0700 (PDT)
Message-ID: <0d44fb03-0481-2f0d-eeb5-63cbddeffc62@redhat.com>
Date:   Fri, 19 Aug 2022 11:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 01/14] vboxsf: move from strlcpy with unused retval to
 strscpy
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
References: <20220818210123.7637-1-wsa+renesas@sang-engineering.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220818210123.7637-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Note you send this one twice. Since I'm not sure which one
will end up getting merged, I'm going to just reply to both...

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

