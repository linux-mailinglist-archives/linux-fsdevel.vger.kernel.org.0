Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372996FEDCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 10:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjEKIXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjEKIXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 04:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6C230CD
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683793349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gk+R+YkjF963S2SpF4BsdMdE47AkKmd4xwPaX4Oi4+k=;
        b=jRWL/k4f5CslsaWj22QP6Rsh4zJ2YmKgfCShbyOo4iWEWo4jyKyXQ4h7n/6ZXL/ChDAbkb
        FcWHXs0QQrpSt8mSDXrj88zBYtGW8LST7vWJlxfadbuseABqTs1IbrdD1hYrSynBo22aGC
        8yO5Xrg/4tSD6J7mtLiu79+D5GSDvkc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-4MQFJaBMN5mqwDaAoKYPsA-1; Thu, 11 May 2023 04:22:28 -0400
X-MC-Unique: 4MQFJaBMN5mqwDaAoKYPsA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-95f6f291b9aso1033464066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 01:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683793347; x=1686385347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk+R+YkjF963S2SpF4BsdMdE47AkKmd4xwPaX4Oi4+k=;
        b=XyOJfKMYDguXyZNYP3v9J+vmKsUrxEHUfY+hwxBwW7GOnc7NFtlDe9BCtPsj95krTn
         Y9B3grUDf+oBN1jVFwt6yP2laqhHaI5nBBKvq9Mvskw9Q4OO8wgwjhzTe0xu5MCPafJQ
         tyEnB0elaYJ7Ega3wYk9LwGVjTBEVF9VD7cHGMwHkyra/0ElpKZYdVbeYUI1wtZVVza4
         nPfeIJdPM/j9OUctzpJCzxbA5zammbwlZDa3McMV3NqjpNALWQFUDkoUPXaIijVavmqS
         GyTEayypXiFEyIxRjl4cxqBysO72fRv+ama0db11JyKm7YXky6rpnnu0ZpxOrz+OggN/
         mkow==
X-Gm-Message-State: AC+VfDy3nSvnoTPFdQ+6wRbZATzVttYqpOlil3MKbQyz55rRUGTpdPDa
        Nrwpbuuud7cW2n8MnlvSVlVYL6D3RQY3HmWL/DktxH6RSBSsAcu4ZqkydxAUjdx+Rj399TLe3X7
        VhR1P9H0h0LR2fuYeYnzEjnSBZvajcnAGUQ==
X-Received: by 2002:a17:906:478f:b0:96a:3b67:40bb with SMTP id cw15-20020a170906478f00b0096a3b6740bbmr4004891ejc.40.1683793346900;
        Thu, 11 May 2023 01:22:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zc4nyULHOnur3f+oxT8ygqFitbgjgoYUQJ4s85VdQCqWOCPEtYkKW/BM86bhB+vNheUGeNg==
X-Received: by 2002:a17:906:478f:b0:96a:3b67:40bb with SMTP id cw15-20020a170906478f00b0096a3b6740bbmr4004876ejc.40.1683793346524;
        Thu, 11 May 2023 01:22:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906285900b0096a5d341b50sm582560ejc.111.2023.05.11.01.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 01:22:26 -0700 (PDT)
Message-ID: <7b406485-83dd-f3d9-4e82-6ca42d2f4b5a@redhat.com>
Date:   Thu, 11 May 2023 10:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] vboxsf: Replace all non-returning strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 5/10/23 23:11, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/super.c |    2 +-
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

