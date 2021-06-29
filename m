Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1325A3B6CFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 05:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhF2DcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 23:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231799AbhF2DcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624937381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Pa1pOlVAvZjnb70QATIYkocaWNNRWiFDRdCDmMIsd8=;
        b=gDqfj9rX8rqZCojYY0oHCfBhS/e0zviI0vG5ixXtKXz9pa09e3jgiY93XCagKHEM9BwBvh
        LbJ+bSCFYjIsDMqIBjGafHHTTklf+NHwX4DKd4K9pdoePlVZeEqSngYs31FekOusBPMmV+
        rYqOLxQs0cHhMLR5XvXT3HssUYfLrmY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-vSNwoEicNAmwWACMJAevRA-1; Mon, 28 Jun 2021 23:29:39 -0400
X-MC-Unique: vSNwoEicNAmwWACMJAevRA-1
Received: by mail-pj1-f70.google.com with SMTP id cp14-20020a17090afb8eb029017094b4d856so1311768pjb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 20:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2Pa1pOlVAvZjnb70QATIYkocaWNNRWiFDRdCDmMIsd8=;
        b=If2KAeskXA6kaMs4OdjhhILLL5Yz27FYLEaR16EFiylUEt2jVKuxLxVDbB7O/e5rY1
         B5UCAof/aXXKfcmhKkx07mog3NyiDbL9cdfPqqXGXJyukAr/NeliIh2fwriB16Bu13gG
         ptNgkyhet92kIoYCrXv8cXPcKvcT7Yy9R9e3oATARW9Uszzyr/GF2rtUnywY6Iy/KnZt
         l5adyYxlce/3dnXAZUiQDTOrMVfhM8ObSJOSowfWRKsSM/K9KVtFqcZGp32mWMfmqXhX
         YpPt36BqrMKxK4Fv6sYKDC1b3R8fCmOhsWCnbPkBbWTIxNHDOqc8GDqNe5dPI9LmCST5
         r+xg==
X-Gm-Message-State: AOAM531p5e8FAUkSbzwdVL+jURS3CHSJwN0YoZFbh4CHkH8FGS+kHV3E
        O3pPcjjrfLFyX2trcQ3WmQrnuTWUxMjAhngaG5ZyEKe/We8yjAyoUsUtLS11ynNF/72RVuQwBL4
        J3Ejyv9QEn2W248XqMiSwKYEtCw==
X-Received: by 2002:a05:6a00:1742:b029:308:add4:e844 with SMTP id j2-20020a056a001742b0290308add4e844mr24162934pfc.18.1624937378556;
        Mon, 28 Jun 2021 20:29:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwry9N+QCFjvNGydIUFQnfZliYwOwU3q6M/FQals9i/JHLqA6RP5KnmC4UjhvxUQDox0iXaLQ==
X-Received: by 2002:a05:6a00:1742:b029:308:add4:e844 with SMTP id j2-20020a056a001742b0290308add4e844mr24162907pfc.18.1624937378357;
        Mon, 28 Jun 2021 20:29:38 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w21sm1920153pge.30.2021.06.28.20.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 20:29:37 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
 Userspace
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
        Greg KH <gregkh@linuxfoundation.org>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
 <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
 <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
 <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
 <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
 <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
 <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e82766ff-dc6b-2cbb-3504-0ef618d538e2@redhat.com>
Date:   Tue, 29 Jun 2021 11:29:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/6/29 上午10:26, Yongji Xie 写道:
> On Mon, Jun 28, 2021 at 12:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/6/25 下午12:19, Yongji Xie 写道:
>>>> 2b) for set_status(): simply relay the message to userspace, reply is no
>>>> needed. Userspace will use a command to update the status when the
>>>> datapath is stop. The the status could be fetched via get_stats().
>>>>
>>>> 2b looks more spec complaint.
>>>>
>>> Looks good to me. And I think we can use the reply of the message to
>>> update the status instead of introducing a new command.
>>>
>> Just notice this part in virtio_finalize_features():
>>
>>           virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
>>           status = dev->config->get_status(dev);
>>           if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>
>> So we no reply doesn't work for FEATURES_OK.
>>
>> So my understanding is:
>>
>> 1) We must not use noreply for set_status()
>> 2) We can use noreply for get_status(), but it requires a new ioctl to
>> update the status.
>>
>> So it looks to me we need synchronize for both get_status() and
>> set_status().
>>
> We should not send messages to userspace in the FEATURES_OK case. So
> the synchronization is not necessary.


As discussed previously, there could be a device that mandates some 
features (VIRTIO_F_RING_PACKED). So it can choose to not accept 
FEATURES_OK is packed virtqueue is not negotiated.

In this case we need to relay the message to userspace.

Thanks


>
> Thanks,
> Yongji
>

