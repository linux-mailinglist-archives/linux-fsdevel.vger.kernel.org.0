Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F026C656B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCWKnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCWKmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C73C78B
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679567939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TFhcV6GkMvFSJzY1Kq9CdLM3RnvV0Xngxwo6M9TXoA=;
        b=RUogVWjYyM23zoCg9KGhGsDbiHYPKS04VHmrUKm4UKlIEj7w3G4HCA8flWuPJ5J3pGTyMn
        WX59ckQUdKTLr8nS2Lhh92UhbMqiszwPgLaXbmTDZYdu1qVbhsGWv5wS63SdD9G1OdGjd+
        f8tNB4ibt+qIzizlvRrrrqpYuUvw248=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-2VZFMN3FOV6kW4K4TS2bqw-1; Thu, 23 Mar 2023 06:38:55 -0400
X-MC-Unique: 2VZFMN3FOV6kW4K4TS2bqw-1
Received: by mail-wm1-f72.google.com with SMTP id d11-20020a05600c34cb00b003ee89ce8cc3so674922wmq.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 03:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567934;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TFhcV6GkMvFSJzY1Kq9CdLM3RnvV0Xngxwo6M9TXoA=;
        b=mN0s+UmKSWxpD83MFj16cdrj4LQ/Opti//8J5gZOYm+Wq3JCXPceWPt6ryYa4FasHW
         Ewb2XRiKb8P8qlifRHVqAUkGSa0jaUrsfGtEeUUPBfXjMCTQSkA+uyID+s8/gOEcY/Z8
         Ybt59XBtIJMa3MjzgPnBhUPFenz7T1h/HhZ4JqnBFyIjUqxFamHmL0IEVrpMxYWuD1Rf
         yqBsZudFGVvwdn3MCqZK3+fHBHELVSKT7ThknCktWMQlIokYBFz/D3tWM7TGRHQTFR/V
         sDAka2qWijzGjnHPwF0aVfavfOL8qRSFjnHvJS0Owy6fLlpVxPmGstXjg2mgwGHP9opB
         urzw==
X-Gm-Message-State: AO0yUKVJLvfZBPbz0UacU7idmrBHSwAkLimnPcJa87e07gexHfbB2QUM
        hklx0UzVx+fxfpUTrayIPKwypt8J/E6UPSyBGbgFA3pkX3NWr6Vd4U4a66awPyh3Fv69BPQ66EW
        Zigg/WKXzzXj6ppcJhCZFo+CehQ==
X-Received: by 2002:a05:600c:211a:b0:3e1:374:8b66 with SMTP id u26-20020a05600c211a00b003e103748b66mr1663821wml.40.1679567934037;
        Thu, 23 Mar 2023 03:38:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set+tFuJvzVjW7ADCFdILrSW/DQrT2iRfpJdx3s1pAztu95TXy7RgGzThnezTLOXKYBwhqAxn4A==
X-Received: by 2002:a05:600c:211a:b0:3e1:374:8b66 with SMTP id u26-20020a05600c211a00b003e103748b66mr1663806wml.40.1679567933651;
        Thu, 23 Mar 2023 03:38:53 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c204400b003ee4e99a8f6sm1484570wmg.33.2023.03.23.03.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 03:38:53 -0700 (PDT)
Message-ID: <7aee68e9-6e31-925f-68bc-73557c032a42@redhat.com>
Date:   Thu, 23 Mar 2023 11:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 4/4] mm: vmalloc: convert vread() to vread_iter()
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1679511146.git.lstoakes@gmail.com>
 <941f88bc5ab928e6656e1e2593b91bf0f8c81e1b.1679511146.git.lstoakes@gmail.com>
 <ZBu+2cPCQvvFF/FY@MiWiFi-R3L-srv>
 <ff630c2e-42ff-42ec-9abb-38922d5107ec@lucifer.local>
 <ZBwroYh22pEqJYhv@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBwroYh22pEqJYhv@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.03.23 11:36, Baoquan He wrote:
> On 03/23/23 at 06:44am, Lorenzo Stoakes wrote:
>> On Thu, Mar 23, 2023 at 10:52:09AM +0800, Baoquan He wrote:
>>> On 03/22/23 at 06:57pm, Lorenzo Stoakes wrote:
>>>> Having previously laid the foundation for converting vread() to an iterator
>>>> function, pull the trigger and do so.
>>>>
>>>> This patch attempts to provide minimal refactoring and to reflect the
>>>> existing logic as best we can, for example we continue to zero portions of
>>>> memory not read, as before.
>>>>
>>>> Overall, there should be no functional difference other than a performance
>>>> improvement in /proc/kcore access to vmalloc regions.
>>>>
>>>> Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
>>>> we dispense with it, and try to write to user memory optimistically but
>>>> with faults disabled via copy_page_to_iter_nofault(). We already have
>>>> preemption disabled by holding a spin lock. We continue faulting in until
>>>> the operation is complete.
>>>
>>> I don't understand the sentences here. In vread_iter(), the actual
>>> content reading is done in aligned_vread_iter(), otherwise we zero
>>> filling the region. In aligned_vread_iter(), we will use
>>> vmalloc_to_page() to get the mapped page and read out, otherwise zero
>>> fill. While in this patch, fault_in_iov_iter_writeable() fault in memory
>>> of iter one time and will bail out if failed. I am wondering why we
>>> continue faulting in until the operation is complete, and how that is done.
>>
>> This is refererrring to what's happening in kcore.c, not vread_iter(),
>> i.e. the looped read/faultin.
>>
>> The reason we bail out if failt_in_iov_iter_writeable() is that would
>> indicate an error had occurred.
>>
>> The whole point is to _optimistically_ try to perform the operation
>> assuming the pages are faulted in. Ultimately we fault in via
>> copy_to_user_nofault() which will either copy data or fail if the pages are
>> not faulted in (will discuss this below a bit more in response to your
>> other point).
>>
>> If this fails, then we fault in, and try again. We loop because there could
>> be some extremely unfortunate timing with a race on e.g. swapping out or
>> migrating pages between faulting in and trying to write out again.
>>
>> This is extremely unlikely, but to avoid any chance of breaking userland we
>> repeat the operation until it completes. In nearly all real-world
>> situations it'll either work immediately or loop once.
> 
> Thanks a lot for these helpful details with patience. I got it now. I was
> mainly confused by the while(true) loop in KCORE_VMALLOC case of read_kcore_iter.
> 
> Now is there any chance that the faulted in memory is swapped out or
> migrated again before vread_iter()? fault_in_iov_iter_writeable() will
> pin the memory? I didn't find it from code and document. Seems it only
> falults in memory. If yes, there's window between faluting in and
> copy_to_user_nofault().
> 

See the documentation of fault_in_safe_writeable():

"Note that we don't pin or otherwise hold the pages referenced that we 
fault in.  There's no guarantee that they'll stay in memory for any 
duration of time."

-- 
Thanks,

David / dhildenb

