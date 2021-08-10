Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2D83E5142
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 05:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhHJDCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 23:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236294AbhHJDCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 23:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628564548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oaO6ycaF20ZgcRI3wGSVNh4K2MMhBW7g6tA5PypVq9o=;
        b=bagKjRKoJldUOmEUH9H0R9LTfci0nvSg95s7XZjN/aACXXcxKIHgw0Iy7CJvp8TpZF3jLc
        EPR7W9SBNyzTsCdtkaJbHnmikE/evwmXD2/dBr8L7et4aTThsYgzgSuCSd1J6qqn9sWIt0
        Gsd9BTE3qz+AMdfr5GIInToyNWoXxTQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-vEfjIpNcPBerWTXYOBWjUQ-1; Mon, 09 Aug 2021 23:02:27 -0400
X-MC-Unique: vEfjIpNcPBerWTXYOBWjUQ-1
Received: by mail-pl1-f200.google.com with SMTP id f17-20020a170902ab91b029012c3bac8d81so9573949plr.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 20:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oaO6ycaF20ZgcRI3wGSVNh4K2MMhBW7g6tA5PypVq9o=;
        b=XXS3V5Zn2EdoUAb0viMyjoVSm0s/shvXbpK/hVrHslIhWKxBvK3ATxrE8G179+VB+g
         8yutFHwHRk4ikblxkND46rrqmSViPp1a0/QSUsIeTY0dZLuV2G/zIRNj/zkUraiodO+p
         zJMlSd0fdhZeJ8pfB1tz50bEPduSAOz6s25lVxNwnYBea/SD3Kspfe7SD3xT7pXk6b+R
         DAigFzkTG0Te6FGi/4v+2TIdec7cqoBWNZ7KQAD8i1juHuEMpvOysPeV9t9opIUncWzz
         PHK9aSweKZrolt4SS4ZwS3uqpJSKwzR9rCh/amxmNOHichZdIAIrzrwn622Zd38uLr1f
         BysQ==
X-Gm-Message-State: AOAM530v4oHUV9vUJzwzXg75WnZyrtX7Vq/ZU72AbBD3n2B13otWaRad
        ofGk/cG5jRHWyHllg4txp91ml31LnED8j7rE7YKffjEf/MTdM7eYtKlb95pBEWN26o2/gm9KYxm
        OXoLKPju87MF08xBFB4ov8/EvFw==
X-Received: by 2002:a63:f754:: with SMTP id f20mr131595pgk.385.1628564546407;
        Mon, 09 Aug 2021 20:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4iIBidP48y9gv61bBqE2YoRFI1FZjnrIQXCCS9iv1FkdxvVNARb2MOe/u6xBBvn1K8bmYbw==
X-Received: by 2002:a63:f754:: with SMTP id f20mr131560pgk.385.1628564546126;
        Mon, 09 Aug 2021 20:02:26 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z18sm17386165pfn.88.2021.08.09.20.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 20:02:25 -0700 (PDT)
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To:     Yongji Xie <xieyongji@bytedance.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Joe Perches <joe@perches.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
        He Zhe <zhe.he@windriver.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, bcrl@kvack.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
 <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
 <6e05e25e-e569-402e-d81b-8ac2cff1c0e8@arm.com>
 <CACycT3sm2r8NMMUPy1k1PuSZZ3nM9aic-O4AhdmRRCwgmwGj4Q@mail.gmail.com>
 <417ce5af-4deb-5319-78ce-b74fb4dd0582@arm.com>
 <CACycT3vARzvd4-dkZhDHqUkeYoSxTa2ty0z0ivE1znGti+n1-g@mail.gmail.com>
 <8c381d3d-9bbd-73d6-9733-0f0b15c40820@redhat.com>
 <CACycT3steXFeg7NRbWpo2J59dpYcumzcvM2zcPJAVe40-EvvEg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b427cf12-2ff6-e5cd-fe6a-3874d8622a29@redhat.com>
Date:   Tue, 10 Aug 2021 11:02:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3steXFeg7NRbWpo2J59dpYcumzcvM2zcPJAVe40-EvvEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/8/9 下午1:56, Yongji Xie 写道:
> On Thu, Aug 5, 2021 at 9:31 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/8/5 下午8:34, Yongji Xie 写道:
>>>> My main point, though, is that if you've already got something else
>>>> keeping track of the actual addresses, then the way you're using an
>>>> iova_domain appears to be something you could do with a trivial bitmap
>>>> allocator. That's why I don't buy the efficiency argument. The main
>>>> design points of the IOVA allocator are to manage large address spaces
>>>> while trying to maximise spatial locality to minimise the underlying
>>>> pagetable usage, and allocating with a flexible limit to support
>>>> multiple devices with different addressing capabilities in the same
>>>> address space. If none of those aspects are relevant to the use-case -
>>>> which AFAICS appears to be true here - then as a general-purpose
>>>> resource allocator it's rubbish and has an unreasonably massive memory
>>>> overhead and there are many, many better choices.
>>>>
>>> OK, I get your point. Actually we used the genpool allocator in the
>>> early version. Maybe we can fall back to using it.
>>
>> I think maybe you can share some perf numbers to see how much
>> alloc_iova_fast() can help.
>>
> I did some fio tests[1] with a ram-backend vduse block device[2].
>
> Following are some performance data:
>
>                              numjobs=1   numjobs=2    numjobs=4   numjobs=8
> iova_alloc_fast    145k iops      265k iops      514k iops      758k iops
>
> iova_alloc            137k iops     170k iops      128k iops      113k iops
>
> gen_pool_alloc   143k iops      270k iops      458k iops      521k iops
>
> The iova_alloc_fast() has the best performance since we always hit the
> per-cpu cache. Regardless of the per-cpu cache, the genpool allocator
> should be better than the iova allocator.


I think we see convincing numbers for using iova_alloc_fast() than the 
gen_poll_alloc() (45% improvement on job=8).

Thanks


>
> [1] fio jobfile:
>
> [global]
> rw=randread
> direct=1
> ioengine=libaio
> iodepth=16
> time_based=1
> runtime=60s
> group_reporting
> bs=4k
> filename=/dev/vda
> [job]
> numjobs=..
>
> [2]  $ qemu-storage-daemon \
>        --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
>        --monitor chardev=charmonitor \
>        --blockdev
> driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0
> \
>        --export type=vduse-blk,id=test,node-name=disk0,writable=on,name=vduse-null,num-queues=16,queue-size=128
>
> The qemu-storage-daemon can be builded based on the repo:
> https://github.com/bytedance/qemu/tree/vduse-test.
>
> Thanks,
> Yongji
>

