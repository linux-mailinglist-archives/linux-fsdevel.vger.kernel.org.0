Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6793FD185
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 04:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbhIACxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 22:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231588AbhIACxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630464723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22daRUQV9U4yr6Wt0e3afK9IF5RqMvZ3yQMarWKzKaw=;
        b=JxkWfQ7EGfdRby2Hd9j56rPsXil9S4cm2C3FAZXX5OO7cUDSxFTYinqBbb3iSpD6TdXSJT
        6PrikPnEDTcBMAOb1V26OPOx1bsNDR+/Rg4qYR1bHBBiYO3xsUrVrBd9lpGTuUWxbipX6o
        bPgZ3hpHWHlyTA3A+VvZuKPecQT/dm4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-_LfhgiX3NBSCD2k7_6HMJw-1; Tue, 31 Aug 2021 22:52:02 -0400
X-MC-Unique: _LfhgiX3NBSCD2k7_6HMJw-1
Received: by mail-pg1-f198.google.com with SMTP id g6-20020a655946000000b00255ef826275so789177pgu.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 19:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=22daRUQV9U4yr6Wt0e3afK9IF5RqMvZ3yQMarWKzKaw=;
        b=JWyGDIhLjXcCc7xJWhpO14TWcuwwLI6+ZRp4St7OM6nofuVigkguGPku5Z21gYH4sN
         W/9SG4mE4mesByeAVh2w5uaQIr/PqkQfv4s5fAmVB5iaKqpiUi76BS1Qqg/r04TitrbD
         8m9KjP9jM1MtczAfkJRq9IC0zfXDrpH8xcL18llngQ/smZSTLnSn+wJbbym2269nGB2A
         9YoFOvMo6lfbK2iD6aNl7ejWXJ1ZPp1fr644iRyHzwc0bkHmmxLT/Xfe1D1zEIQzRmZo
         934bHRI+g9rky8g5nX1wNGnM4H6FG6bgSRq3vvU3zpr5DmEsQRCpYakWzEE6TBUrQ4SQ
         DCig==
X-Gm-Message-State: AOAM532HgNKdSjGMh4MUtt4TnSWcWqFpRPGfWC+JDKQrJH/KuQB/qAC2
        fD80k8qbU6yQByPx6J50gB0gx7YBcIj5MJiRF2A1CJBssUDND3XL87isqAVSD1P1vZ3oYrpkZIp
        4abrYjR+Q44GdldUPicxAnIHPqQ==
X-Received: by 2002:a17:902:ea89:b0:134:7eb7:b4d7 with SMTP id x9-20020a170902ea8900b001347eb7b4d7mr7633957plb.43.1630464721014;
        Tue, 31 Aug 2021 19:52:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTWS6gU6vtbRqrdbv/Yqpra3725hn41k3JbwUi9Z5AqTrEe2L3d1WI2eNmIrtm6tnQdkeYWQ==
X-Received: by 2002:a17:902:ea89:b0:134:7eb7:b4d7 with SMTP id x9-20020a170902ea8900b001347eb7b4d7mr7633932plb.43.1630464720692;
        Tue, 31 Aug 2021 19:52:00 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b7sm19703920pgs.64.2021.08.31.19.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 19:51:59 -0700 (PDT)
Subject: Re: [PATCH v13 02/13] eventfd: Export eventfd_wake_count to modules
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com,
        will@kernel.org, john.garry@huawei.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-3-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0e486c0a-0055-e698-ffd2-31c4b75dae5d@redhat.com>
Date:   Wed, 1 Sep 2021 10:50:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831103634.33-3-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/8/31 下午6:36, Xie Yongji 写道:
> Export eventfd_wake_count so that some modules can use
> the eventfd_signal_count() to check whether the
> eventfd_signal() call should be deferred to a safe context.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


And this matches the comment inside eventfd_signal():

         /*
          * Deadlock or stack overflow issues can happen if we recurse here
          * through waitqueue wakeup handlers. If the caller users 
potentially
          * nested waitqueues with custom wakeup handlers, then it should
          * check eventfd_signal_count() before calling this function. If
          * it returns true, the eventfd_signal() call should be 
deferred to a
          * safe context.
          */


So:

Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   fs/eventfd.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index e265b6dd4f34..1b3130b8d6c1 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -26,6 +26,7 @@
>   #include <linux/uio.h>
>   
>   DEFINE_PER_CPU(int, eventfd_wake_count);
> +EXPORT_PER_CPU_SYMBOL_GPL(eventfd_wake_count);
>   
>   static DEFINE_IDA(eventfd_ida);
>   

