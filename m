Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE81633F29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 15:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiKVOpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 09:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiKVOpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:45:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A1D3C6F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 06:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669128254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOTrbU/zp22wPSskCmpvwxHNiz91TXL6UQP9VfM7zZI=;
        b=afvh0ZdS3eZNis/acyO5gGCNjh5BydAm+JF7VztMexaN/ZtsfinzzumuqFT0kGTlmUwI/7
        m+jtgpFVDEycJnI9WClYB96bJt6p2Rqtfz850V1jUeZtrfqKneoBvpWtBYIkzBfxiNP2x6
        4ckJOY9GA/Qe2T2iZgGn0dherjvmCXk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-412-Kg-O5iGiO7e_GFNxufrt8A-1; Tue, 22 Nov 2022 09:44:13 -0500
X-MC-Unique: Kg-O5iGiO7e_GFNxufrt8A-1
Received: by mail-ej1-f70.google.com with SMTP id gt15-20020a1709072d8f00b007aaac7973fbso8418570ejc.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 06:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOTrbU/zp22wPSskCmpvwxHNiz91TXL6UQP9VfM7zZI=;
        b=yAWVh9bCxxK2oSq0qHnYa32MEUCJjgHKwcnD3jvA2JRDVgW7iedZDMGXQCxtDMRL2r
         SPiO9pq4SVRQx7L+IGk6WFPHIlZ96JrDNlMruYztsS8o/ri6zWJQ8QTRKFwOLFpL6WuQ
         dk3q5ZhGvc2MPkFrfOUteGVjg1lbiYZI2IrLRJVfFBrgDSJwFgE8rjbujsDpyaCOKDIq
         4IrG8sUjgUiDuxx4G5ufoi0eE7xI6fcjWcUK+sWEQbyt+ZikE5IKu1nkWdHeClkuUwq1
         kxlUg0z5G5kJAmTCyqt5izHIcq2A0t5wcsDKxlcHlOrB+nSpQA45qpnJ2hjme7dcfUbC
         s19Q==
X-Gm-Message-State: ANoB5pl2VpOr7I8UOYQYf0+hySKZNF1rUe/TQloVgvjCtyWZE8lzJLFm
        sK+Lbd+ky9QUA4Gegp3UXcRiY/rfC3MgY6AU8RH7+qU2bInhL+X+L2L1PJKJHkDifQi0BUUFbWK
        Z7xCn53Flh2jmJyMjZS60m7tKcw==
X-Received: by 2002:a17:906:eb04:b0:7ae:77ef:d048 with SMTP id mb4-20020a170906eb0400b007ae77efd048mr3812871ejb.740.1669128252357;
        Tue, 22 Nov 2022 06:44:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf72PFdgk+/lBfsLT/u6KTtWXMDQcVEwzELUErmlK8MzhONJFc1zB3wqW5q26zETlXANiPDbnA==
X-Received: by 2002:a17:906:eb04:b0:7ae:77ef:d048 with SMTP id mb4-20020a170906eb0400b007ae77efd048mr3812860ejb.740.1669128252117;
        Tue, 22 Nov 2022 06:44:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f24-20020a17090631d800b0078db18d7972sm6105509ejf.117.2022.11.22.06.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:44:11 -0800 (PST)
Message-ID: <8648a01c-ee70-7c69-f24c-3a30866ae08f@redhat.com>
Date:   Tue, 22 Nov 2022 15:44:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH linux-next] vboxfs: use strscpy() is more robust and safer
To:     yang.yang29@zte.com.cn
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
References: <202211220858139474929@zte.com.cn>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202211220858139474929@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 11/22/22 01:58, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>

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

