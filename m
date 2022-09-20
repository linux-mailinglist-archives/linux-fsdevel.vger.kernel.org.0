Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42705BDFB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 10:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiITITP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 04:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiITISQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705C696DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663661724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/e/evqGTFru+f3l3LD+eG8BtO8WljnsYCWvP+vFWoVo=;
        b=gJQTRcanVExgz9n6/+0BVIEZAXSTpBbwLFuPsbYoA5yQipnzhvQCuJ2131/TyP1UWvSLLx
        2LnDLL802JxUHK8fRmMMn39M6XoPKCMJEwanuyS77zaMWDq+18GKBavbwisY5Q+voSUdh7
        jrSJu330HMuyfNP8/SY9G9kFfNZUS04=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-307-Kqbi026KPKm6IsgCmeG5ew-1; Tue, 20 Sep 2022 04:15:23 -0400
X-MC-Unique: Kqbi026KPKm6IsgCmeG5ew-1
Received: by mail-wr1-f70.google.com with SMTP id o7-20020adfba07000000b00228663f217fso826041wrg.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 01:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/e/evqGTFru+f3l3LD+eG8BtO8WljnsYCWvP+vFWoVo=;
        b=3zJ5xyQZEw63qY9dFwNZGI2i8IumMd5pBZrcvWMbBGFq7EhNiwRWTtS2gdF23kQzdy
         8bGYMrmq2azvia+lb62UUNBMw6/yrkPBkyAuIM6/K8N1qdFdQGJh1JcPob19VzHc9ld2
         DgvfFfjCKY5bWg1eo9piWCNUtgUSROmu5yDInC/vVVdO8nt+RIHg5JO4FwwO9qnI9cqA
         1eMX/iNGiO0MBS22tQprUq5wPkGq/XgK/xsHxDm574WH6B0312gzCoVg/t6HmIIBPkN/
         ElTscSTjj27/pCWaHVstpaO/+Rb+Az4IAL8KRUJxESybcgC14TfHOHMe37Wdl5Rhi56C
         KKxg==
X-Gm-Message-State: ACrzQf3DKuzZ32wTH7TgWufHkklX8gCMexTGG185UYcXa8uHcLd1bWug
        P57iTWmvadAqYKs08Iz528M76v1o1+79iPKwfD0l81jdqtviLq7X/xOE+Q2tPKIFNbn2a0IuHzO
        RYJPBKQZ/4DwkHaifG4JEa7Tspg==
X-Received: by 2002:a05:600c:23ca:b0:3b4:6199:8ab9 with SMTP id p10-20020a05600c23ca00b003b461998ab9mr1396447wmb.20.1663661722199;
        Tue, 20 Sep 2022 01:15:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pb0rzdBr6watv2OP+RIFajUY8ofPhVTXwU2pExV8u2gef6cxMTASlsrhhKQd0N+G4n5cOww==
X-Received: by 2002:a05:600c:23ca:b0:3b4:6199:8ab9 with SMTP id p10-20020a05600c23ca00b003b461998ab9mr1396424wmb.20.1663661721920;
        Tue, 20 Sep 2022 01:15:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:2300:e82d:5a58:4fd8:c1e6? (p200300cbc7122300e82d5a584fd8c1e6.dip0.t-ipconnect.de. [2003:cb:c712:2300:e82d:5a58:4fd8:c1e6])
        by smtp.gmail.com with ESMTPSA id a5-20020adfe5c5000000b00228de58ae2bsm901775wrn.12.2022.09.20.01.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:15:21 -0700 (PDT)
Message-ID: <749470a3-e1c7-dc60-d7b7-4e5e3ffde8dd@redhat.com>
Date:   Tue, 20 Sep 2022 10:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 2/3] lib/notifier-error-inject: fix error when writing
 -errno to debugfs file
Content-Language: en-US
To:     Akinobu Mita <akinobu.mita@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        corbet@lwn.net, osalvador@suse.de, shuah@kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org
References: <20220919172418.45257-1-akinobu.mita@gmail.com>
 <20220919172418.45257-3-akinobu.mita@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220919172418.45257-3-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.09.22 19:24, Akinobu Mita wrote:
> The simple attribute files do not accept a negative value since the
> commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()").
> 
> This restores the previous behaviour by using newly introduced
> DEFINE_SIMPLE_ATTRIBUTE_SIGNED instead of DEFINE_SIMPLE_ATTRIBUTE.
> 
> Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>   lib/notifier-error-inject.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
> index 21016b32d313..2b24ea6c9497 100644
> --- a/lib/notifier-error-inject.c
> +++ b/lib/notifier-error-inject.c
> @@ -15,7 +15,7 @@ static int debugfs_errno_get(void *data, u64 *val)
>   	return 0;
>   }
>   
> -DEFINE_SIMPLE_ATTRIBUTE(fops_errno, debugfs_errno_get, debugfs_errno_set,
> +DEFINE_SIMPLE_ATTRIBUTE_SIGNED(fops_errno, debugfs_errno_get, debugfs_errno_set,
>   			"%lld\n");
>   
>   static struct dentry *debugfs_create_errno(const char *name, umode_t mode,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

