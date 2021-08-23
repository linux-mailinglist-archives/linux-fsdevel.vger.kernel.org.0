Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20013F455B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhHWG5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 02:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234251AbhHWG5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629701810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6CVC1MYmQ2Yd0dGkq2W7I4r7P5G0FEqZECeGZvY4DU=;
        b=bGgS84DUOO9HZuvU4UuFplQU6CWUj6ZBx6nt8N8uyhMFtalN3AjQ7rc16CS59CxReRnJ2/
        qMTmSyKekUPcHdNFNp1JYcT9mMsCod++uTmko4h/TiqF1I2R2BEGr1UYYsLVJOiUXMaxne
        8wfxja4xDlmy/oWBXE+F0RIKJBoszlo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-GqqMqmUTMeC9xq75QpjDMw-1; Mon, 23 Aug 2021 02:56:48 -0400
X-MC-Unique: GqqMqmUTMeC9xq75QpjDMw-1
Received: by mail-pj1-f72.google.com with SMTP id z23-20020a17090abd97b0290176898bbb9cso7731033pjr.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Aug 2021 23:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=O6CVC1MYmQ2Yd0dGkq2W7I4r7P5G0FEqZECeGZvY4DU=;
        b=DrlUpyZ0Mukq/fMiPuAgFwqCtcBvnIAliwGAtXY3JXh/nDqUCz3ttE7HkNZp8sB6FX
         vlS7M04L1BI2brps3Prf1i8C5REKknC4gZ3eMveb/77M6Ta9dvZhEO4nETeWtqrSNEJs
         y1YY+FyLmYcyxGQV2Z++mR8863ok3P8jP6i7aLcSTWMosevgYIi7pGGqqAkZXC7ixuu4
         Nvaxm8tljX99/yj1iImzq5K6LguknKRSWBNRXnnwTpHKqRixbwxsH9ZW/Xl3GuRnEjON
         2hexgf+IqwIyzDWa3DHT2hFRgohMn0zgu1fEnRBGkYS7g6YhzmTdwY5sAfW0fWDoJMcU
         qzyg==
X-Gm-Message-State: AOAM532PlicNpU5JdEa1/Ab3UwRoXfQOQ7gWf2ZwrCLNsqQrnsACruCB
        o6lstsDITsDIXxa6AkmZf3aqf+I7R/TLA1uQc1SFOx01KrJpaQBAbgyii10KQ+pX9mvEENKc8ub
        LUzvZDjWTxJT6sP4W/Gj1W4dEDg==
X-Received: by 2002:aa7:9ddc:0:b0:3e1:5fc1:1d20 with SMTP id g28-20020aa79ddc000000b003e15fc11d20mr32664037pfq.48.1629701807253;
        Sun, 22 Aug 2021 23:56:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeDlxuu1bqct4xksqs7isW8FxpMxOH+GNhpdYUwjloBQhDlJbitQ/vFhNd4D+BhyIvDS4Fgg==
X-Received: by 2002:aa7:9ddc:0:b0:3e1:5fc1:1d20 with SMTP id g28-20020aa79ddc000000b003e15fc11d20mr32664016pfq.48.1629701807013;
        Sun, 22 Aug 2021 23:56:47 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n30sm14807096pfv.87.2021.08.22.23.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 23:56:46 -0700 (PDT)
Subject: Re: [PATCH v11 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-12-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <cfc11f6b-764b-7a52-2c4a-6fa22e6c1585@redhat.com>
Date:   Mon, 23 Aug 2021 14:56:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-12-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2021/8/18 ÏÂÎç8:06, Xie Yongji Ð´µÀ:
> This VDUSE driver enables implementing software-emulated vDPA
> devices in userspace. The vDPA device is created by
> ioctl(VDUSE_CREATE_DEV) on /dev/vduse/control. Then a char device
> interface (/dev/vduse/$NAME) is exported to userspace for device
> emulation.
>
> In order to make the device emulation more secure, the device's
> control path is handled in kernel. A message mechnism is introduced
> to forward some dataplane related control messages to userspace.
>
> And in the data path, the DMA buffer will be mapped into userspace
> address space through different ways depending on the vDPA bus to
> which the vDPA device is attached. In virtio-vdpa case, the MMU-based
> software IOTLB is used to achieve that. And in vhost-vdpa case, the
> DMA buffer is reside in a userspace memory region which can be shared
> to the VDUSE userspace processs via transferring the shmfd.
>
> For more details on VDUSE design and usage, please see the follow-on
> Documentation commit.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


