Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309CF73FDF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 16:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjF0OgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 10:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjF0OgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A910FC
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2I4RPsehThqnH3/y9cWZQKNuT4LiknWjJr+uizynBV8=;
        b=byj2+trWF8nMsy4fxP9dmHUSmZ/Rtr71VF1THDLeTB+fDAXxEc4537UxfrITM63KcebKX7
        NRFsBf+Ldapzbnn0FzPetvHtLjYuJnmmt/XgNCC1NbdptYvx+tiQvPUeNUnlI/Nlervk5n
        47MhN6DBa5ZAV0q3qEYFzjBi/n6SSFs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-1fmGpbEBO02flg1cadU5dw-1; Tue, 27 Jun 2023 10:34:56 -0400
X-MC-Unique: 1fmGpbEBO02flg1cadU5dw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9874fbf5c95so525482466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 07:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876492; x=1690468492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2I4RPsehThqnH3/y9cWZQKNuT4LiknWjJr+uizynBV8=;
        b=KQM9u31luzGUaaVNc66W6hLm475dlAO5cKqPTlL4Yzr7/3/Bhuz0sTWJknswTII9o4
         mQTHzEQUzzT2dGCnLDZrofvwS5qS/Ok8XSz8bUV6AVZKE+UY3a7fM6S622EvKLvrQxcL
         BwRXiA8Ehwe/ljwXP+mHUPOX41l+CHp6XL+tPUiiss2jrjW3PFleAxscRteKaT1vKLTS
         lab+aqnP12fJ/jcQNvfUq1aLwp/NXC99CUHeTM7Z9nw743y34pwopPiR6coePoIeGu+f
         1yuA4BWCS9iNNBAax7FbQCiqD1CC03dUQrgmzdNm4G00RERmkrnl7cmBVmxiWe3R9b3f
         YoKg==
X-Gm-Message-State: AC+VfDwZgO0jdSJNx79xpvXOUMfrLkhj08ZhWU9c7zXDSDVgjPc7Wqq8
        zYkARAJsyOtMwT915vox+cYkG4wA6kFH9w7a+eBZ8Ea+hXGK7ZLApTLS4JXmf/JJsydWh3SHIJU
        LrrLuL8QHEDUjE/KwnduWcax+MIGY5nHvbw==
X-Received: by 2002:a17:907:8686:b0:987:d0c3:e300 with SMTP id qa6-20020a170907868600b00987d0c3e300mr28330429ejc.26.1687876492626;
        Tue, 27 Jun 2023 07:34:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7j3siesSuwDDTtjYEMoIX15DvUDbPq20AHtUXQVahommtxFi3hAAB5BjCBJEb1dI9s6am0ng==
X-Received: by 2002:a17:907:8686:b0:987:d0c3:e300 with SMTP id qa6-20020a170907868600b00987d0c3e300mr28330412ejc.26.1687876492365;
        Tue, 27 Jun 2023 07:34:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906948e00b00988b86d6c7csm4607674ejx.132.2023.06.27.07.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 07:34:51 -0700 (PDT)
Message-ID: <6a566e51-6288-f782-2fa5-f9b0349b6d7c@redhat.com>
Date:   Tue, 27 Jun 2023 16:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Content-Language: en-US, nl
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>
References: <20230627135115.GA452832@sumitra.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230627135115.GA452832@sumitra.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 6/27/23 15:51, Sumitra Sharma wrote:
> kmap() has been deprecated in favor of the kmap_local_page() due to high
> cost, restricted mapping space, the overhead of a global lock for
> synchronization, and making the process sleep in the absence of free
> slots.
> 
> kmap_local_{page, folio}() is faster than kmap() and offers thread-local
> and CPU-local mappings, can take pagefaults in a local kmap region and
> preserves preemption by saving the mappings of outgoing tasks and
> restoring those of the incoming one during a context switch.
> 
> The difference between kmap_local_page() and kmap_local_folio() consist
> only in the first taking a pointer to a page and the second taking two
> arguments, a pointer to a folio and the byte offset within the folio which
> identifies the page.
> 
> The mappings are kept thread local in the functions 'vboxsf_read_folio',
> 'vboxsf_writepage', 'vboxsf_write_end' in file.c
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 572aa1c43b37..5190619bc3c5 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -234,7 +234,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
>  	u8 *buf;
>  	int err;
>  
> -	buf = kmap(page);
> +	buf = kmap_local_folio(folio, off);
>  
>  	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
>  	if (err == 0) {
> @@ -245,7 +245,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
>  		SetPageError(page);
>  	}
>  
> -	kunmap(page);
> +	kunmap_local(buf);
>  	unlock_page(page);
>  	return err;
>  }
> @@ -286,10 +286,10 @@ static int vboxsf_writepage(struct page *page, struct writeback_control *wbc)
>  	if (!sf_handle)
>  		return -EBADF;
>  
> -	buf = kmap(page);
> +	buf = kmap_local_page(page);
>  	err = vboxsf_write(sf_handle->root, sf_handle->handle,
>  			   off, &nwrite, buf);
> -	kunmap(page);
> +	kunmap_local(buf);
>  
>  	kref_put(&sf_handle->refcount, vboxsf_handle_release);
>  
> @@ -320,10 +320,10 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
>  	if (!PageUptodate(page) && copied < len)
>  		zero_user(page, from + copied, len - copied);
>  
> -	buf = kmap(page);
> +	buf = kmap_local_page(page);
>  	err = vboxsf_write(sf_handle->root, sf_handle->handle,
>  			   pos, &nwritten, buf + from);
> -	kunmap(page);
> +	kunmap_local(buf);
>  
>  	if (err) {
>  		nwritten = 0;

