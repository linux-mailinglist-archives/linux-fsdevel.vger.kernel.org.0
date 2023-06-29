Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACE741FF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 07:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjF2Fgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 01:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjF2Fgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A92724
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688016941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jJ0/BJRAKh86CGVE8eVjDakBNpW0exbUqMmw1eTFdw=;
        b=RpqQAS/LCNugO+SYd4PzyAwlAwo2bwWlz54HEcsDYTZlH2pIgxpI+Xr3fp+LaFlnjrRlVb
        dlYTxnGC3vvKXC+bR5xzf3hjoBnIodWwfZyxIBKQl0jcmi0vRSOFqO6vQeBZ7Gdgi5UW5H
        UcvybBTIeVj15NEyk7Y/PXtWpwuOFKI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587--uSkoGkbONuDXYaJv9UlUw-1; Thu, 29 Jun 2023 01:35:40 -0400
X-MC-Unique: -uSkoGkbONuDXYaJv9UlUw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a341efd9aso27605666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 22:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688016939; x=1690608939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jJ0/BJRAKh86CGVE8eVjDakBNpW0exbUqMmw1eTFdw=;
        b=JuT73miC5dYWhcgP5RJTZRwL3Ilj/nSADBmeUP0qfKiFEcAEOYyPnoi/lJdpCGgtmI
         HLmVs8C3csJqSB2d9/uh9bDw9J/FoxAOcz/FeC/R1+RaM3+nNPbuMgm+k32wmeCQB3Ao
         YmoUsxysZUk6Aw9o6TDbvPN2/SBZRKrhMoDOG+4jZH7VSoWOqqQJ9onj62FEY2wY6txp
         0iOpmZu9bmeaefDOYExoOmc3hslfb3vB79R2IG33cbZUN56cTTAIulSMLrE2DmqZpuMP
         73hPouZgsMJ9qy3HXx2yXwDEaPXqBRJ0NqRIVi8Cbs5/eOvHwcBCwKpLFGW36VMIGZyM
         M+qQ==
X-Gm-Message-State: AC+VfDw/FlWk49fsK5hjxk/j/VssdrSlyED9rCXAK5Iga6jw3NurYUWh
        dxztJVGTljrXRBtjseBNk/LqCVgTQEn1WYsYpKV8HvcuFl17gOre3UzThLaYMK5/7fCX41AmUVx
        xOartrMjfJ1oT+6sinO+wcKnuZbRTz/PWYQ==
X-Received: by 2002:a17:906:9b84:b0:989:5aad:ebce with SMTP id dd4-20020a1709069b8400b009895aadebcemr25508474ejc.13.1688016938992;
        Wed, 28 Jun 2023 22:35:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UBm117Rb8IHSHnFBk3XTWG+HCAp94vJ2O0EbxEUWZzKT3A0GUFAk/Q9ClC/O4h5cGnJZn5g==
X-Received: by 2002:a17:906:9b84:b0:989:5aad:ebce with SMTP id dd4-20020a1709069b8400b009895aadebcemr25508465ejc.13.1688016938723;
        Wed, 28 Jun 2023 22:35:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e8-20020a1709062c0800b0098822e05539sm6406904ejh.191.2023.06.28.22.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 22:35:38 -0700 (PDT)
Message-ID: <e055b3e4-22c3-c0e2-fb8b-81ba8b97382d@redhat.com>
Date:   Thu, 29 Jun 2023 07:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
References: <20230627135115.GA452832@sumitra.com>
 <ZJsg5GL79MIOzbRf@casper.infradead.org> <20230629043031.GA455425@sumitra.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230629043031.GA455425@sumitra.com>
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

Hi Sumitra,

On 6/29/23 06:30, Sumitra Sharma wrote:
> On Tue, Jun 27, 2023 at 06:48:20PM +0100, Matthew Wilcox wrote:
>> On Tue, Jun 27, 2023 at 06:51:15AM -0700, Sumitra Sharma wrote:
>>> +++ b/fs/vboxsf/file.c
>>> @@ -234,7 +234,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
>>>  	u8 *buf;
>>>  	int err;
>>>  
>>> -	buf = kmap(page);
>>> +	buf = kmap_local_folio(folio, off);
>>
>> Did you test this?  'off' is the offset in the _file_.  Whereas
>> kmap_local_folio() takes the offset within the _folio_.  They have
>> different types (loff_t vs size_t) to warn you that they're different
>> things.
>>
> 
> Hi Matthew,
> 
> When creating this patch, I read and searched about the loff_t vs size_t.
> By mistake, I implemented it in the wrong way.
> 
> Also, I did not test it and just compiled it. I apologise for doing so.
> 
> And for the other points you have put as feedback. I will take some time to understand
> it. And would like to work on the changes you suggest.

If you work further on this please make sure that you actually test your
changes. Submitting untested fs changes is a really bad idea. People don't
like it when their data gets corrupted.

Note vboxsf can be tested easily by setting up a VirtualBox guest and then
using the shared folder features. Note do *not* use the VirtualBox provided
guest utils they contain their own out of tree vboxsf implementation and
will use that.

To avoid this you could e.g. use Fedora inside the guest and install
the Fedora packaged vbox guest utils which does not replace the mainline
vboxsf.

Regards,

Hans



