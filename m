Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11627402E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjF0SLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF0SLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E23F10CE
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687889428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1oQi2KaYXrd+f3vuquWTL1ELXYHBXVTrRL2XLD93Lo=;
        b=C8x3+YDONAmwV3uTMWE8smtoha7DMK+oGdMvrUwh2jPmuT7CQt0RWiIuEhcNPa+Ceg3XT+
        BD0VkR0CvY8rhGZbXIZibCroRxwQoCRxtOR5pUcE0kSpbkSJUatMNoOgryIXqT7o0a0d2+
        PKhL3bDdnYRa8p7F2h2n8enFWDEcR/Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-ggfyZrebP5KmAaa9F-PKhg-1; Tue, 27 Jun 2023 14:10:27 -0400
X-MC-Unique: ggfyZrebP5KmAaa9F-PKhg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9877da14901so352216766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889426; x=1690481426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1oQi2KaYXrd+f3vuquWTL1ELXYHBXVTrRL2XLD93Lo=;
        b=EouOfogdHIxa5id9OFthVSWrFo66c0ge0Mp3a69jOCnLM52xumBIeOpTSC/7e2r0zb
         A4p9St7igatkTbp2lG/N/EwCGSv0dxYy2GbTC09+DLfzPJDtI1OmchsjCHzdVGJPoITn
         glo7F0BxqjH2wpzSuWF8OxZSQ+1RXJLDpfoFOdZXqX/V3+Ok52lvOMP6jSFA6Ian4Ng2
         oGo5HU1Bonnojg8svkP1V9+r+mQATQEe2K58ctarSGNDlunhPCZvdS2NnMwxGBJNkok5
         mYUb7fex19wCimoW5+HMrGE4eWGo3zUQ3gOBedIw0aU8u69BK27G/n0mDzFzCHAgf+zO
         4Y7A==
X-Gm-Message-State: AC+VfDzWeA2nyDJOvaqwrKVIeBEsr2a8Fx866eE4jF3OzLenN/7o9yDZ
        v8wXIi/0mIGtgcOGKgpwoRNaHlpGxkQRpIw9E4h3ab9k/uiYLeG3crb0TflfZepLUCC7F8Lp/Gi
        0X5jljXSkWYF5j56q1YUrIln8MFWjBYKs6Q==
X-Received: by 2002:a17:907:983:b0:96f:a935:8997 with SMTP id bf3-20020a170907098300b0096fa9358997mr29234333ejc.12.1687889425895;
        Tue, 27 Jun 2023 11:10:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6INRW2y8Q5zI6TRLagxBRL2eTS9hWLifUjpylvWUa307GQqhEPkpQptCzCXUsdzhMwGqBArw==
X-Received: by 2002:a17:907:983:b0:96f:a935:8997 with SMTP id bf3-20020a170907098300b0096fa9358997mr29234317ejc.12.1687889425568;
        Tue, 27 Jun 2023 11:10:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906170f00b00986211f35bdsm4765742eje.80.2023.06.27.11.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 11:10:25 -0700 (PDT)
Message-ID: <3baed0e0-db2c-906c-5256-1d83d59794e9@redhat.com>
Date:   Tue, 27 Jun 2023 20:10:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Content-Language: en-US, nl
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
References: <20230627135115.GA452832@sumitra.com>
 <6a566e51-6288-f782-2fa5-f9b0349b6d7c@redhat.com>
 <ZJsgWQb+tOqtQuKL@casper.infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZJsgWQb+tOqtQuKL@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On 6/27/23 19:46, Matthew Wilcox wrote:
> On Tue, Jun 27, 2023 at 04:34:51PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 6/27/23 15:51, Sumitra Sharma wrote:
>>> kmap() has been deprecated in favor of the kmap_local_page() due to high
>>> cost, restricted mapping space, the overhead of a global lock for
>>> synchronization, and making the process sleep in the absence of free
>>> slots.
>>>
>>> kmap_local_{page, folio}() is faster than kmap() and offers thread-local
>>> and CPU-local mappings, can take pagefaults in a local kmap region and
>>> preserves preemption by saving the mappings of outgoing tasks and
>>> restoring those of the incoming one during a context switch.
>>>
>>> The difference between kmap_local_page() and kmap_local_folio() consist
>>> only in the first taking a pointer to a page and the second taking two
>>> arguments, a pointer to a folio and the byte offset within the folio which
>>> identifies the page.
>>>
>>> The mappings are kept thread local in the functions 'vboxsf_read_folio',
>>> 'vboxsf_writepage', 'vboxsf_write_end' in file.c
>>>
>>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
>>
>> Thanks, patch looks good to me:
> 
> It doesn't look great to me, tbh.  It's generally an antipattern to map
> the page/folio up at the top and then pass the virtual address down to
> the bottom.  Usually we want to work in terms of physical addresses
> as long as possible.  I see the vmmdev_hgcm_function_parameter can
> take physical addresses; does it work to simply use the phys_addr
> instead of the linear_addr?  I see this commentary:
> 
>        /** Deprecated Doesn't work, use PAGELIST. */
>         VMMDEV_HGCM_PARM_TYPE_PHYSADDR           = 3,
> 
> so, um, can we use
>         /** Physical addresses of locked pages for a buffer. */
>         VMMDEV_HGCM_PARM_TYPE_PAGELIST           = 10,
> 
> and convert vboxsf_read_folio() to pass the folio down to vboxsf_read()
> which converts it to a PAGELIST (however one does that)?


It has been a long time since I looked at this code in detail. I don't
think you can just use different types when making virtualbox hypervisor
calls and then expect the hypervisor to say sure that another way to
represent a memory buffer, I'll take that instead.

After I upstreamed vboxsf support VirtualBox upstream did do some
further optimizations to speed up vboxsf. So there may be something
there which allows passing a physical address to the hypervisor,
but I don't have the time to dive into this.

When I upstreamed this the idea was that VirtualBox upstream
would see the benefits of having the guest drivers upstream and would
help with upstream maintenance. But unfortunately this never materialized
and they are still doing their own out of tree thing even for
their guest drivers.

TL;DR: for now I believe that it is best to just keep the code as
is and do a straight forward folio conversion.

Regards,

Hans




