Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26E03B6D59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 06:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhF2ENn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 00:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232027AbhF2ENn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 00:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624939875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=artctqxsXOBji6dZlUYYfDDilnt3HH/T60QvobzscDY=;
        b=We19Fku9V8xXXivjfT9EQVeUVWAE8t1V+u3NR3raiiYArV4iEaQRh6nZQl4nwQ/IQgHqrm
        7qUpO70CJKY/F/dXT67MMRMNk+BuiAyPA2zoWs8oa9EGI4s1pjuQYrZ0LJjYPGStm+X9BL
        dSFNRZ6J2ghXVHoG0ZQNgnqZo89/zqg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-m06uXPlaNhmMsE_vzd8lWA-1; Tue, 29 Jun 2021 00:11:05 -0400
X-MC-Unique: m06uXPlaNhmMsE_vzd8lWA-1
Received: by mail-pf1-f200.google.com with SMTP id d22-20020a056a0024d6b0290304cbae6fdcso10664009pfv.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 21:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=artctqxsXOBji6dZlUYYfDDilnt3HH/T60QvobzscDY=;
        b=oLFKQOIB2nfYimuRMwlINFwlR2r+MhFKH2wbPjvp9Yd6q2a+WpZqzVDyDPQvqdWyvd
         3zDCUUI5iNQei0o3oTjnissuNlSYkwPmlEMg1gkuo7HGtzfyIfI2/ePqLXF9Wst97Grv
         bZoJFhyxu+ziVBaN4Mq0QhMdt3bG8Tp6Ym2jNqc4DiwsPH0xLhqryGo8AIARW8V8T8eC
         drPK/bHsdqe2JfsTyXVDSvaTqqwKU7UI87aLwl8ABvhIFW9edjd3N86g8c/PlWjiLtBl
         zhRyPS1VjEbSosVo5PUKfWr1995iXPb7o/cNllFScL3NMq9btmxO4FGqZ46FAoEbQtQt
         q6Lg==
X-Gm-Message-State: AOAM530seUD+W2SoOJbBj9sop+UAa4Bif5e8nVAw5qafZZ3IwiY1xR6l
        4nxL5tquyicjY3ynuhTYUG4kpScJ/dafAHTUAGDGpJuyUUN+/2rvAWbzq37kujqoKuhYi5z1gTe
        bCJa+XOLINy2S214u/5aiyTM28Q==
X-Received: by 2002:a62:b616:0:b029:303:aa7b:b2e0 with SMTP id j22-20020a62b6160000b0290303aa7bb2e0mr28469447pff.21.1624939864872;
        Mon, 28 Jun 2021 21:11:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEtTsRWTzX+1HKlyYauA7LaEp1VCLZNHRfy5MStjoYEhho4d0zuZ1s0SoSqwSCB7kvsITcEw==
X-Received: by 2002:a62:b616:0:b029:303:aa7b:b2e0 with SMTP id j22-20020a62b6160000b0290303aa7bb2e0mr28469429pff.21.1624939864605;
        Mon, 28 Jun 2021 21:11:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id cs1sm1085868pjb.56.2021.06.28.21.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 21:11:04 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To:     "Liu, Xiaodong" <xiaodong.liu@intel.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "parav@nvidia.com" <parav@nvidia.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "christian.brauner@canonical.com" <christian.brauner@canonical.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mika.penttila@nextfour.com" <mika.penttila@nextfour.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
 <bdbe3a79-e5ce-c3a5-4c68-c11c65857377@redhat.com>
 <BYAPR11MB2662FFF6140A4C634648BB2E8C039@BYAPR11MB2662.namprd11.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <41cc419e-48b5-6755-0cb0-9033bd1310e4@redhat.com>
Date:   Tue, 29 Jun 2021 12:10:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB2662FFF6140A4C634648BB2E8C039@BYAPR11MB2662.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/6/28 下午1:54, Liu, Xiaodong 写道:
>> Several issues:
>>
>> - VDUSE needs to limit the total size of the bounce buffers (64M if I was not
>> wrong). Does it work for SPDK?
> Yes, Jason. It is enough and works for SPDK.
> Since it's a kind of bounce buffer mainly for in-flight IO, so limited size like
> 64MB is enough.


Ok.


>
>> - VDUSE can use hugepages but I'm not sure we can mandate hugepages (or we
>> need introduce new flags for supporting this)
> Same with your worry, I'm afraid too that it is a hard for a kernel module
> to directly preallocate hugepage internal.
> What I tried is that:
> 1. A simple agent daemon (represents for one device)  `preallocates` and maps
>      dozens of 2MB hugepages (like 64MB) for one device.
> 2. The daemon passes its mapping addr&len and hugepage fd to kernel
>      module through created IOCTL.
> 3. Kernel module remaps the hugepages inside kernel.


Such model should work, but the main "issue" is that it introduce  
overheads in the case of vhost-vDPA.

Note that in the case of vhost-vDPA, we don't use bounce buffer, the  
userspace pages were shared directly.

And since DMA is not done per page, it prevents us from using tricks  
like vm_insert_page() in those cases.


> 4. Vhost user target gets and maps hugepage fd from kernel module
>      in vhost-user msg through Unix Domain Socket cmsg.
> Then kernel module and target map on the same hugepage based
> bounce buffer for in-flight IO.
>
> If there is one option in VDUSE to map userspace preallocated memory, then
> VDUSE should be able to mandate it even it is hugepage based.
>

As above, this requires some kind of re-design since VDUSE depends on  
the model of mmap(MAP_SHARED) instead of umem registering.

Thanks

