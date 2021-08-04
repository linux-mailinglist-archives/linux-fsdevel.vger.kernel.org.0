Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7078C3DFCE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhHDIbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 04:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236320AbhHDIbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628065860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+iBXiMp+0i0kwjToWGA8/FOLua2xKY/IasSPwlB2ug=;
        b=SIOcMys6eqGi4oT1OUGcy7Rk7zFUzXliGyJqrEntREDryOfgYnJqb39Hx9IE3drzoGhEGR
        hWstrU5OB1MvSvn8P3P7w+kz90G90LOTFjvOjo4zUIrffHN0up8qznCh2nPbKuvXQf5O5y
        o+o1WzYgo/fiq52H2NCR04A3hKjgZwc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-Uhet01h-PzSs_9NLfWN24Q-1; Wed, 04 Aug 2021 04:30:58 -0400
X-MC-Unique: Uhet01h-PzSs_9NLfWN24Q-1
Received: by mail-pj1-f72.google.com with SMTP id r13-20020a17090a4dcdb0290176dc35536aso1427782pjl.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 01:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R+iBXiMp+0i0kwjToWGA8/FOLua2xKY/IasSPwlB2ug=;
        b=AO66MiSN7JlUGi1JC6EZGzZEJ/SPUO20WWiP3OO82KrFM8M3z8hmRjSv5LrozaPT0r
         2Z8VA+SbmTg0DJe9JBATwxKs+TKIM5lbgkH8tzM3oYB1auY4PLIOliILliuiO4eTr8CU
         o/Ny8++uEAb3JHSoWC67BlRakLMz+XNNS6iNUYgQSGM2gFAwcVIqn/1QMpvrGypZ/lyA
         rEew4xQzGjA/0MKZ3dNkgDlnwhmHVGN2Nrm/aepbBL8W0qYUgKPNCGnIlSSgFBRHRRUI
         B61rpG0gG2uh+BZlEimJuFaPcp38fXQQKNXTbP24Hcq/GzHyzpIlhr4/8CESOTHZ42Yh
         0XSA==
X-Gm-Message-State: AOAM531uQms7kwPt3TDGNY0pMRAfhqlD/+aubSQAYgptMzKAxtkvFXqR
        NEa2Ljdo1NjtemkiqssRt3z4QImUZTqJOTlWkDt59KjzoDuZ0xtq/G1CsMfyarg5BxzLkfP1FZe
        nIOIX6S3Bkv/dyHaT3CLYWQCLFw==
X-Received: by 2002:a17:90a:5886:: with SMTP id j6mr27687751pji.34.1628065857833;
        Wed, 04 Aug 2021 01:30:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnH9lVsulyqPnREH97Ou07tfmz86+gb2/y1eNG5JuTtEooMRamySZ0IC743fc1pY8YcAbbnQ==
X-Received: by 2002:a17:90a:5886:: with SMTP id j6mr27687725pji.34.1628065857537;
        Wed, 04 Aug 2021 01:30:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i14sm2040290pgh.79.2021.08.04.01.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 01:30:57 -0700 (PDT)
Subject: Re: [PATCH v10 04/17] vdpa: Fail the vdpa_reset() if fail to set
 device status to zero
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Joe Perches <joe@perches.com>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-5-xieyongji@bytedance.com>
 <39a191f6-555b-d2e6-e712-735b540526d0@redhat.com>
 <CACycT3sdH3zVzznsaMb0+3mzrLF7FjmB89U11fZv_23Y4_WbEw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <31d11097-dab8-578b-402e-a0e55949ce66@redhat.com>
Date:   Wed, 4 Aug 2021 16:30:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sdH3zVzznsaMb0+3mzrLF7FjmB89U11fZv_23Y4_WbEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/8/3 下午5:31, Yongji Xie 写道:
> On Tue, Aug 3, 2021 at 3:58 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/7/29 下午3:34, Xie Yongji 写道:
>>> Re-read the device status to ensure it's set to zero during
>>> resetting. Otherwise, fail the vdpa_reset() after timeout.
>>>
>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>> ---
>>>    include/linux/vdpa.h | 15 ++++++++++++++-
>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index 406d53a606ac..d1a80ef05089 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -6,6 +6,7 @@
>>>    #include <linux/device.h>
>>>    #include <linux/interrupt.h>
>>>    #include <linux/vhost_iotlb.h>
>>> +#include <linux/delay.h>
>>>
>>>    /**
>>>     * struct vdpa_calllback - vDPA callback definition.
>>> @@ -340,12 +341,24 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>>>        return vdev->dma_dev;
>>>    }
>>>
>>> -static inline void vdpa_reset(struct vdpa_device *vdev)
>>> +#define VDPA_RESET_TIMEOUT_MS 1000
>>> +
>>> +static inline int vdpa_reset(struct vdpa_device *vdev)
>>>    {
>>>        const struct vdpa_config_ops *ops = vdev->config;
>>> +     int timeout = 0;
>>>
>>>        vdev->features_valid = false;
>>>        ops->set_status(vdev, 0);
>>> +     while (ops->get_status(vdev)) {
>>> +             timeout += 20;
>>> +             if (timeout > VDPA_RESET_TIMEOUT_MS)
>>> +                     return -EIO;
>>> +
>>> +             msleep(20);
>>> +     }
>>
>> I wonder if it's better to do this in the vDPA parent?
>>
>> Thanks
>>
> Sorry, I didn't get you here. Do you mean vDPA parent driver (e.g.
> VDUSE)?


Yes, since the how it's expected to behave depends on the specific hardware.

Even for the spec, the behavior is transport specific:

PCI: requires reread until 0
MMIO: doesn't require but it might not work for the hardware so we 
decide to change
CCW: the succeed of the ccw command means the success of the reset

Thanks


> Actually I didn't find any other place where I can do
> set_status() and get_status().
>
> Thanks,
> Yongji
>

