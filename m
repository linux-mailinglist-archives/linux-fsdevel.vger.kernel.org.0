Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120586399EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Nov 2022 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiK0KhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Nov 2022 05:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK0KhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Nov 2022 05:37:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40AEE01
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Nov 2022 02:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669545315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/FKhEJUKr4Au5jEDV0nA39boCfv1uOAmeL78/XZzlw=;
        b=KAY1ggBja+xLxU+qgBSmoeX+1QRRXnyvIIrzKncszqGvUmNHx20HFOOM1hXSj16SDqXx2p
        wGiUlKpAsQLFo2n/TSrCv2ZoaLiVaX+DPLc/8zKOoAVdiyKNldV7f/GzaIlas0yf+PCk4e
        p22wLw4D791CTinA0LF6VWd6Etozys8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-219-M64FiH4yMfKTB6eO3cDKBQ-1; Sun, 27 Nov 2022 05:35:13 -0500
X-MC-Unique: M64FiH4yMfKTB6eO3cDKBQ-1
Received: by mail-wm1-f70.google.com with SMTP id m17-20020a05600c3b1100b003cf9cc47da5so4811528wms.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Nov 2022 02:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/FKhEJUKr4Au5jEDV0nA39boCfv1uOAmeL78/XZzlw=;
        b=ccTrJ5c/pxmaNEAn89OZK2eiQYhdPO26Vd3fX4MjOGrsemKlkycC95iHw6WV6gYaOS
         Z4S+R/u5yKUeb4IAOtRRqlhoTOABClplxI/Q7SFf8djmsw8yw462TXBG5gsE95UfOQKR
         9upo32hPO8nUwt4Jv1X9oq7hLUX8sN4AfZYIpFbtUU3FalnwZtvFF5LnvMU+mw44f/YE
         oDwsIatYJaS+a6wBm7+FdM7grJvQvMAGznplrMl1ZjPU6rZUoCxJLB9PL+ZK+2CIjvM4
         oK6toWO5H7pg247mahL5ychWKd4+GJxWETvvK1BZU659d7B4hFu5EUA2+lV0Esz2Hk4q
         Xy+w==
X-Gm-Message-State: ANoB5pm1Ugq07tou/sKmROpIIYdZFvwLvIxmjWpbgqXHKDSpYFYTEbkQ
        PX/uqmlQrrwUolFhT/V8lHmbU4tnqJ37WT5KEyaVr84W0LspXQGpcNexU4ef/XjiiH7aCU1Qi/g
        CZCXxDeStceqTnFzk3p3ZOKageQ==
X-Received: by 2002:a05:600c:4e88:b0:3b5:477:1e80 with SMTP id f8-20020a05600c4e8800b003b504771e80mr34594854wmq.200.1669545311990;
        Sun, 27 Nov 2022 02:35:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf44zTk6J1KBaqs1seffTqR2+v9TqwwPSmjBWI2JrtJKUPaYELfhGu32bDJHUXiVwBKDfUuj3g==
X-Received: by 2002:a05:600c:4e88:b0:3b5:477:1e80 with SMTP id f8-20020a05600c4e8800b003b504771e80mr34594816wmq.200.1669545311706;
        Sun, 27 Nov 2022 02:35:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c724:dc00:5ea8:da59:8609:7da? (p200300cbc724dc005ea8da59860907da.dip0.t-ipconnect.de. [2003:cb:c724:dc00:5ea8:da59:8609:7da])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c19ca00b003c5571c27a1sm14797024wmq.32.2022.11.27.02.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 02:35:11 -0800 (PST)
Message-ID: <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
Date:   Sun, 27 Nov 2022 11:35:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
In-Reply-To: <20221116102659.70287-17-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.11.22 11:26, David Hildenbrand wrote:
> FOLL_FORCE is really only for ptrace access. According to commit
> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
> writable"), get_vaddr_frames() currently pins all pages writable as a
> workaround for issues with read-only buffers.
> 
> FOLL_FORCE, however, seems to be a legacy leftover as it predates
> commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
> always writable"). Let's just remove it.
> 
> Once the read-only buffer issue has been resolved, FOLL_WRITE could
> again be set depending on the DMA direction.
> 
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   drivers/media/common/videobuf2/frame_vector.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
> index 542dde9d2609..062e98148c53 100644
> --- a/drivers/media/common/videobuf2/frame_vector.c
> +++ b/drivers/media/common/videobuf2/frame_vector.c
> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>   	start = untagged_addr(start);
>   
>   	ret = pin_user_pages_fast(start, nr_frames,
> -				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +				  FOLL_WRITE | FOLL_LONGTERM,
>   				  (struct page **)(vec->ptrs));
>   	if (ret > 0) {
>   		vec->got_ref = true;


Hi Andrew,

see the discussion at [1] regarding a conflict and how to proceed with
upstreaming. The conflict would be easy to resolve, however, also
the patch description doesn't make sense anymore with [1].


On top of mm-unstable, reverting this patch and applying [1] gives me
an updated patch:


 From 1e66c25f1467c1f1e5f275312f2c6df29308d4df Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 16 Nov 2022 11:26:55 +0100
Subject: [PATCH] mm/frame-vector: remove FOLL_FORCE usage

GUP now supports reliable R/O long-term pinning in COW mappings, such
that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
far in one corner case (DAXFS file with holes), which can be ignored
because GUP does not support long-term pinning in fsdax (see
check_vma_flags()).

Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
using FOLL_FORCE, which is really only for ptrace access.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  drivers/media/common/videobuf2/frame_vector.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
index aad72640f055..8606fdacf5b8 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -41,7 +41,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool write,
  	int ret_pin_user_pages_fast = 0;
  	int ret = 0;
  	int err;
-	unsigned int gup_flags = FOLL_FORCE | FOLL_LONGTERM;
+	unsigned int gup_flags = FOLL_LONGTERM;
  
  	if (nr_frames == 0)
  		return 0;
-- 
2.38.1



Please let me know how you want to proceed. Ideally, you'd pick up
[1] and apply this updated patch. Also, please tell me if I should
send this updated patch in a separate mail (e.g., as reply to this mail).


[1] https://lkml.kernel.org/r/71bdd3cf-b044-3f12-df58-7c16d5749587@xs4all.nl

-- 
Thanks,

David / dhildenb

