Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA393B6ECC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhF2Hgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 03:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232233AbhF2Hga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624952043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7aRa/ari9ndRrZW6yGfSw3dQvpOEYQN4vmyoY/ZeNU=;
        b=PaeUHSNwzMQZ14BH1pFNKYn7ckPwKSohKiDO2zI5Famymc61YLnpNzriV4YitMaO3p2AyI
        dnMoZH2k1hxwQ+EdRxdqVH/qJBsxIOss9qCAFeops7ha2JX3VLZXDhG0lh40X9r+9eKY5h
        Sc9S0PvHeLH5wMCrVq8uLUIuiThmC1U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-5a8KK73bM9G46G3aWZrjCg-1; Tue, 29 Jun 2021 03:34:01 -0400
X-MC-Unique: 5a8KK73bM9G46G3aWZrjCg-1
Received: by mail-pj1-f70.google.com with SMTP id q9-20020a17090a0649b029016ffc6b9665so1257717pje.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 00:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X7aRa/ari9ndRrZW6yGfSw3dQvpOEYQN4vmyoY/ZeNU=;
        b=g12Q3BtGM5P9wCNrcc/EKZ387mCc/RPTlT4NDBK3oPpU/GUdWGSB25UEWNE0B0AA5O
         4/HsiLKzVQ/lR/r9thmmYEOM0Kmy6qVArIsZHc59rYBEQYd5G1QmxlyZByJRJU2p0pmU
         dnMrVsg6ZnHxg3HHBwziBk5m7qoZSwx95OI7yYtbfPT/rLMXl30AWkwP/10QBLCOXL/O
         IeqpwDFUWAB80YKf73fvp+3Dh6gEfWKci6zq2uurYA1BTbQHjtFJ87bURhZ5di+1wdHI
         UB89oeVdPPgOIiCAQ/Yzzxy5/pgJmLXTMVDEqt/aoSZJS2FhSJgNS+/eynE6+2Y0aQ2p
         37GA==
X-Gm-Message-State: AOAM533YxT+tJlqGhtCaFv0oE0k290MCO//6Bz4rZg2WT+VAvizt8Jgf
        +0OpB9cjX3Pj+z9EcXIroj4jD4CtUlZv4F81W7IkoNMCmLNU755LFrPGLCSnnf4kmyfYnbv61tW
        +xtBHUJT0QS9DMYCztS/faZgaZVtQCRQv1RWYh7TzcF5229ZWi7D53L9dwqjEzSaLFl3SE86AqA
        V73g==
X-Received: by 2002:a63:43c4:: with SMTP id q187mr12256887pga.172.1624952040150;
        Tue, 29 Jun 2021 00:34:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7prtHQtaiL3wMVzoCQQ1u9za913WVNoujdQYVZqZ/2wS5MelCYOe6dyArhR9IgMLsZIzYyg==
X-Received: by 2002:a63:43c4:: with SMTP id q187mr12256834pga.172.1624952039684;
        Tue, 29 Jun 2021 00:33:59 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c2sm17127924pjv.10.2021.06.29.00.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 00:33:59 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Yongji Xie <elohimes@gmail.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
        kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        iommu@lists.linux-foundation.org, songmuchun@bytedance.com,
        linux-fsdevel@vger.kernel.org
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
 <CAONzpcbjr2zKOAQrWa46Tv=oR1fYkcKLcqqm_tSgO7RkU20yBA@mail.gmail.com>
 <d5321870-ef29-48e2-fdf6-32d99a5fa3b9@redhat.com>
 <CACycT3vVhNdhtyohKJQuMXTic5m6jDjEfjzbzvp=2FJgwup8mg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <90e30d9e-5709-2a0b-0449-858eea9dfec9@redhat.com>
Date:   Tue, 29 Jun 2021 15:33:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vVhNdhtyohKJQuMXTic5m6jDjEfjzbzvp=2FJgwup8mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/6/29 下午2:40, Yongji Xie 写道:
> On Tue, Jun 29, 2021 at 12:13 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/6/28 下午6:32, Yongji Xie 写道:
>>>> The large barrier is bounce-buffer mapping: SPDK requires hugepages
>>>> for NVMe over PCIe and RDMA, so take some preallcoated hugepages to
>>>> map as bounce buffer is necessary. Or it's hard to avoid an extra
>>>> memcpy from bounce-buffer to hugepage.
>>>> If you can add an option to map hugepages as bounce-buffer,
>>>> then SPDK could also be a potential user of vduse.
>>>>
>>> I think we can support registering user space memory for bounce-buffer
>>> use like XDP does. But this needs to pin the pages, so I didn't
>>> consider it in this initial version.
>>>
>> Note that userspace should be unaware of the existence of the bounce buffer.
>>
> If so, it might be hard to use umem. Because we can't use umem for
> coherent mapping which needs physical address contiguous space.
>
> Thanks,
> Yongji


We probably can use umem for memory other than the virtqueue (still via 
mmap()).

Thanks


