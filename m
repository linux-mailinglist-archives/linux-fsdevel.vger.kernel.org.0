Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267DA76A12C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 21:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjGaTZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 15:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGaTZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D341139
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690831495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5CUnfZP+S7tdgqkwbTN9sv+JPGzfKmiz3Vk6Jfh0/bU=;
        b=bABRa5uaNhTE0OJ9azCU/gdq3IX1MbtC59yyE4BTkQ8Jp4lje6XRyLP6TdrJZxPqu0lGMy
        Ea4TMbbFYrZ9Rb8+R/kVounDzFLsf2aOMXRqkMhTfHg3oVpl2XxrKeMJZ7v8Of8WoXaLSI
        RcFdrqu4fYLmkSHshTnhQuBynoAQaT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-hGNIo7iXM66LuisrzR3fPg-1; Mon, 31 Jul 2023 15:24:53 -0400
X-MC-Unique: hGNIo7iXM66LuisrzR3fPg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe15547164so16313105e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831492; x=1691436292;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CUnfZP+S7tdgqkwbTN9sv+JPGzfKmiz3Vk6Jfh0/bU=;
        b=OYk06Ha+juNzmlbdTXBNMVzQ9NArltmQm8ymFKiiMxL3akrQZE6TtJ7tKa8SYEY9HE
         Ce2aFqf6hhp6+V23l9QOApvmM3A5jRppWCK3W2bwdWSYKokb/LIHuC8HPNlOLR1gL3km
         OOtos0rNyrFz+znkx8yEZrwobmprCVTUpgBlLT2b3Cw7OkjHOX0KVfvRHBDdJNZKLR5J
         ho0FkXaknVmJ2p9uTQY3jIEjGNLsr4pVThFqC3iqN8Sm/pTTZBFkzxxrqbD/HlSK1xh0
         NVtLQ0rQMkSW8Q7dyzPfJmaAOXnzDC1QzOGtql7shXtXV/5tGqy0ALJCwSENJ7r7uflQ
         i+Rg==
X-Gm-Message-State: ABy/qLaAkQGMSWfsvhBkZ9Qrat1xvxfBLgTG2g46oqWMsg4OvpacKmbU
        pv1G55HarD+yHX+4zRF2ztLpFdEOw0EDzV8ll9tvgN/FqK/ZwfjIcXzHk4Smh3eJzfsWVDg9/sq
        xeecPIDKYVJP+fC6rInTJHaFjsw==
X-Received: by 2002:a7b:cb59:0:b0:3fe:1fdb:cf5 with SMTP id v25-20020a7bcb59000000b003fe1fdb0cf5mr739806wmj.1.1690831492238;
        Mon, 31 Jul 2023 12:24:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHsWBDSCkoRnhyTW73rPEgOGlgL9o0XiF6DQz6a+CPQR5PR8P8WeMdfHhHAWGMEwMa6CINjQ==
X-Received: by 2002:a7b:cb59:0:b0:3fe:1fdb:cf5 with SMTP id v25-20020a7bcb59000000b003fe1fdb0cf5mr739794wmj.1.1690831491829;
        Mon, 31 Jul 2023 12:24:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id z10-20020a1c4c0a000000b003fe2397c17fsm2352867wmf.17.2023.07.31.12.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:24:51 -0700 (PDT)
Message-ID: <32b8c5e4-c8e3-0244-1b1a-ca33bd44f38a@redhat.com>
Date:   Mon, 31 Jul 2023 21:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Baoquan He <bhe@redhat.com>, Jiri Olsa <olsajiri@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava> <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
 <f10f06d4-9c82-41d3-a62a-09c62f254cfc@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f10f06d4-9c82-41d3-a62a-09c62f254cfc@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.07.23 21:21, Lorenzo Stoakes wrote:
> On Mon, Jul 24, 2023 at 08:23:55AM +0200, David Hildenbrand wrote:
>> Hi,
>>
>>>
>>> I met this too when I executed below command to trigger a kcore reading.
>>> I wanted to do a simple testing during system running and got this.
>>>
>>>     makedumpfile --mem-usage /proc/kcore
>>>
>>> Later I tried your above objdump testing, it corrupted system too.
>>>
>>
>> What do you mean with "corrupted system too" --  did it not only fail to
>> dump the system, but also actually harmed the system?
>>
>> @Lorenzo do you plan on reproduce + fix, or should we consider reverting
>> that change?
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> Apologies I mised this, I have been very busy lately not least with book :)
> 
> Concerning, I will take a look as I get a chance. I think the whole series
> would have to be reverted which would be... depressing... as other patches
> in series eliminates the bounce buffer altogether.
> 

I spotted

https://lkml.kernel.org/r/069dd40aa71e634b414d07039d72467d051fb486.camel@gmx.de

today, maybe that's related.

-- 
Cheers,

David / dhildenb

