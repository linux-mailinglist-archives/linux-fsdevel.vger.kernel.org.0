Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F163DFCE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 10:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhHDIdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 04:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236477AbhHDIdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628065975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Mht9KhrSAoC5vXTThxE4PNfv46coChGKCgMCqOMEH8=;
        b=dyOpaIwGpzWoc8ZuRFP7YDpMwK02/4zEOi0VVeq1KF0LCbagYbLPAgsMqOIiju/QXpCJzP
        TguirhqwFZ4Gz0F0JO1ya4/KweC7eP9K5VitKlezybrNtCl0hanbDYmJ1elW8hurfrrVWW
        3NHgcCZRnmYxeV7/tannE9nzxI7Dqq8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-xPwJULvGNsW7vejPG0rljA-1; Wed, 04 Aug 2021 04:32:54 -0400
X-MC-Unique: xPwJULvGNsW7vejPG0rljA-1
Received: by mail-pj1-f72.google.com with SMTP id f62-20020a17090a28c4b02901733dbfa29cso5848410pjd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 01:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8Mht9KhrSAoC5vXTThxE4PNfv46coChGKCgMCqOMEH8=;
        b=oo2CputfweaCl7qAkImrihP+8sguIF/RBd04QB2Rx3pb9ucl1FedevlQWmTufQ65uv
         ICi3H74XRLzsPfmh4C3tz2xBo6Z2bIQOevebswxvzY/DtHmbt1uWPNK7twI/Yfby2B8R
         XBAr67xJvW1LuZfnRQtxpznemkwZ++2gqdvGeSTi433D+Bzt2UQVu17KwA4PR2Y6hWDI
         XybfTT/neAEG7XGpXGH9J/Kw9vBsYNANjNCRnKfsueiu0mnxk+Cf96sNG+vNkhDUppYG
         jsfH+usR0tPHddEIxNbGc3MeH/z7hc0KGC/k/M3L/mh/GIH4EgSAioPFCEFIhUvLgaXi
         IxmQ==
X-Gm-Message-State: AOAM531k6qEYKwyOi3qSY9RlVz/zjkoR0xM6sWhlW/I6pOfDOWchmGns
        VZew0/4FFiDif6EnXokpLWrZrJrDDwVOj3XOtlUxVdLTNZ+AVaWISDrr7/rx1rknlkMD61ETEwt
        PSsEafuAwnRvNc10LxHydS4Ws5w==
X-Received: by 2002:a17:903:2448:b029:12c:cbce:8f86 with SMTP id l8-20020a1709032448b029012ccbce8f86mr5117569pls.72.1628065973003;
        Wed, 04 Aug 2021 01:32:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0IqxY2soH2Uz1iq8mrB6lhygXB67xl2gJSTSu+DC+/FQJJ+3UJPurBSvXJuePHIlHPLAFsQ==
X-Received: by 2002:a17:903:2448:b029:12c:cbce:8f86 with SMTP id l8-20020a1709032448b029012ccbce8f86mr5117546pls.72.1628065972803;
        Wed, 04 Aug 2021 01:32:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d65sm1065176pjk.45.2021.08.04.01.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 01:32:52 -0700 (PDT)
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in
 register_virtio_device()
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
 <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
 <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fdcb0224-11f9-caf2-a44e-e6406087fd50@redhat.com>
Date:   Wed, 4 Aug 2021 16:32:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/8/3 下午5:38, Yongji Xie 写道:
> On Tue, Aug 3, 2021 at 4:09 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/7/29 下午3:34, Xie Yongji 写道:
>>> The device reset may fail in virtio-vdpa case now, so add checks to
>>> its return value and fail the register_virtio_device().
>>
>> So the reset() would be called by the driver during remove as well, or
>> is it sufficient to deal only with the reset during probe?
>>
> Actually there is no way to handle failure during removal. And it
> should be safe with the protection of software IOTLB even if the
> reset() fails.
>
> Thanks,
> Yongji


If this is true, does it mean we don't even need to care about reset 
failure?

Thanks


