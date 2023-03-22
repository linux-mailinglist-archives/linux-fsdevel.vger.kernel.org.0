Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581EA6C51CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 18:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCVREw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 13:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjCVREQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32189279A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679504565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kti/JzF4VrmbjBlfDUl4YhHuHDPglfNgmyzJ2qiaCg8=;
        b=VAZT38OcbCpxalM6hR4iHSL2PtviyRjEd96QnNQVaDjv64E4oO2KGTwXUqHluGP1cjw3Dl
        m32URpiGj16ukgiAWBgRCCOmeeKQzlLDX+LM2zJdtKYuSLoKDinSTWe7GRxaczm1ddSXbQ
        CPvSsGV97+CtUOV3Q67izMOnRKWG8XA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-uH9Q7VgoN3Ctd2ihdcF_-g-1; Wed, 22 Mar 2023 13:02:38 -0400
X-MC-Unique: uH9Q7VgoN3Ctd2ihdcF_-g-1
Received: by mail-wm1-f71.google.com with SMTP id l17-20020a05600c1d1100b003ed29ba093cso7687003wms.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 10:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504556;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kti/JzF4VrmbjBlfDUl4YhHuHDPglfNgmyzJ2qiaCg8=;
        b=2prqCGPiPaRRdY8Ltd86Dew3bwHQ68dwUUCb36TYyCZyNCNJTpmjjDUAs6oWOph9PA
         07v+SReU/S8/p6RBsgMTp9viUDYGFvhHdQ3PTgE2Q0AJZNdRjvucPiTwnnw+B+R2PG2i
         XakdWmJXT+zxj6Uay4r4Iwoo8ixIZ5hFffZI7rVdXdc8ApHoQJanhlJkJsI77ztkMPEg
         FbBACgtM9IZ0tb5rbPmD53jzuXIAKxap0SNlglwFHd5rhVq0HHD0oKNUC0FrG+cnuOYU
         02bM+YNWTGiEtET5tHd9NmsOqzG6R0zgKXO0Vr3gY9UWKSW3QqDA8tHHWTIBeQstQxTp
         dFrQ==
X-Gm-Message-State: AO0yUKXSJKpEym2fPJZhjz5IXoHllGO2KepNk6Ohpr/O+G9kz3SLsBPj
        Tuki8gx30NZl0BJOwuMMQgztj+07BVIn3WxVEtohkdYFe3L7JUPxZaonobLZoo9gkt9cn7iecdA
        yTsPyR4KQBV9UUjxvYOCtFRzBRA==
X-Received: by 2002:a7b:c3d9:0:b0:3ed:9212:b4fe with SMTP id t25-20020a7bc3d9000000b003ed9212b4femr226876wmj.0.1679504556817;
        Wed, 22 Mar 2023 10:02:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set9dJZMsZOALzIB5M3pFL0KeOCwU/SYEhVYAv7bjUiaycrkDQ6K8T+5vVFFkHWfhMUYDnRvCcA==
X-Received: by 2002:a7b:c3d9:0:b0:3ed:9212:b4fe with SMTP id t25-20020a7bc3d9000000b003ed9212b4femr226838wmj.0.1679504556502;
        Wed, 22 Mar 2023 10:02:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm8066858wrp.42.2023.03.22.10.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:02:36 -0700 (PDT)
Message-ID: <3e2d1f69-5cd8-8824-0a2e-a1c2c9029f66@redhat.com>
Date:   Wed, 22 Mar 2023 18:02:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 4/4] mm: vmalloc: convert vread() to vread_iter()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1679496827.git.lstoakes@gmail.com>
 <4f1b394f96a4d1368d9a5c3784ebee631fb8d101.1679496827.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4f1b394f96a4d1368d9a5c3784ebee631fb8d101.1679496827.git.lstoakes@gmail.com>
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

On 22.03.23 15:55, Lorenzo Stoakes wrote:
> Having previously laid the foundation for converting vread() to an iterator
> function, pull the trigger and do so.
> 
> This patch attempts to provide minimal refactoring and to reflect the
> existing logic as best we can, for example we continue to zero portions of
> memory not read, as before.
> 
> Overall, there should be no functional difference other than a performance
> improvement in /proc/kcore access to vmalloc regions.
> 
> Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
> we dispense with it, and try to write to user memory optimistically but
> with faults disabled via copy_page_to_iter_nofault(). We already have
> preemption disabled by holding a spin lock.
> 
> If this fails, we fault in and retry a single time. This is a conservative
> approach intended to avoid spinning on vread_iter() if we repeatedly
> encouter issues reading from it.

I have to ask again: Can you comment why that is ok? You might end up 
signaling -EFAULT to user space simply because swapping/page 
migration/whatever triggered at the wrong time.

That could break existing user space or which important part am I missing?

-- 
Thanks,

David / dhildenb

