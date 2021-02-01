Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5100430A630
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 12:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhBALHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 06:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233520AbhBALGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612177527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6CC4m3ZKiHoeJ4vm73j2nwZCcKHfss+LOR/CL/RX4k=;
        b=MC+FWyFwkO9XE0TI/UVXO0Yy0KHyJQMAbpIWq0u8yzUn5SMoINCDk8DRXzOc9oPt8VeqiA
        qRj++yC1J6XeRxsCllbEobPYv/v08DaSMs+lsdxLICEOlciMZpAtIQQuAjQsUIdCCzeqgp
        4YBMOpmbrxmkYzRZeVnVb9VzwfrLXy0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-seZgmEYXN2ObxFiBMCHC2Q-1; Mon, 01 Feb 2021 06:05:26 -0500
X-MC-Unique: seZgmEYXN2ObxFiBMCHC2Q-1
Received: by mail-wr1-f71.google.com with SMTP id u15so621838wrn.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 03:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y6CC4m3ZKiHoeJ4vm73j2nwZCcKHfss+LOR/CL/RX4k=;
        b=W0R6sm1o0XXzAipOsShg5mr9QE1nDYtFQnX9DirNm1TvK5grj/sQ/VT5UlvZk1/NXR
         chnT1+942aUGvSsOOWejoI2/bbizzgt7c+9F0h2fAMz8X3zSxWnSb9CZJfeuP+/zUg2I
         +g7d5RERT+zTsGsS/v/eVu2jjtk2f9Kjd7tbn3mFjA0CMoWvuYETZK7zAu1kjBdxzu2/
         ZdlDB24kDjWPk1qBWb8Gdjja3lZVECgNFEjQy8z7NGTYJNxZRhU1nEuQ9EQKrPDu9cHU
         9bq8Dm37x/eiaRcQiMMXdOEbNtbMSFJDLxilrGOKoNmr/bAy6LzOtcYgX3FmzyoRgSUN
         qH9w==
X-Gm-Message-State: AOAM533If1wLGlFuPcRXlqLrEBt6DTtHgThH90XA3MbliGrknxV5Dydu
        xMubtCjxN6jz0hv9ZTBhzB5oJcWJCBapnX7IvSk195+QiWOKRKJ9zZarF84/h3S8mrRWdJhCqY9
        Eq6qFP4D6ve5tPzU3Fl6rVAubdA==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr17214341wri.278.1612177525192;
        Mon, 01 Feb 2021 03:05:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMK79Mkew2h7U0GFOcmTtXkC8lH41EmCO+/jdmYzyRwl+sN2j7/Tb0HGWZdqr6tf0uwtKU+w==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr17214306wri.278.1612177524950;
        Mon, 01 Feb 2021 03:05:24 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id s23sm20251966wmc.35.2021.02.01.03.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:05:23 -0800 (PST)
Date:   Mon, 1 Feb 2021 12:05:21 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
Message-ID: <20210201110521.o3m6temcw3nmkiea@steredhat>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
 <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
 <20210120110832.oijcmywq7pf7psg3@steredhat>
 <1979cffc-240e-a9f9-b0ab-84a1f82ac81e@redhat.com>
 <20210127085728.j6x5yzrldp2wp55c@steredhat>
 <3cb239f5-fdd5-8311-35a0-c0f50b552521@redhat.com>
 <20210129150359.caitcskrfhqed73z@steredhat>
 <CACycT3sTx+NGg1iB8gmFbOPfzCvnq5F0nd2ePGs2_BUeU=-2_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACycT3sTx+NGg1iB8gmFbOPfzCvnq5F0nd2ePGs2_BUeU=-2_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 30, 2021 at 07:33:08PM +0800, Yongji Xie wrote:
>On Fri, Jan 29, 2021 at 11:04 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Jan 28, 2021 at 11:11:49AM +0800, Jason Wang wrote:
>> >
>> >On 2021/1/27 下午4:57, Stefano Garzarella wrote:
>> >>On Wed, Jan 27, 2021 at 11:33:03AM +0800, Jason Wang wrote:
>> >>>
>> >>>On 2021/1/20 下午7:08, Stefano Garzarella wrote:
>> >>>>On Wed, Jan 20, 2021 at 11:46:38AM +0800, Jason Wang wrote:
>> >>>>>
>> >>>>>On 2021/1/19 下午12:59, Xie Yongji wrote:
>> >>>>>>With VDUSE, we should be able to support all kinds of virtio devices.
>> >>>>>>
>> >>>>>>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>> >>>>>>---
>> >>>>>> drivers/vhost/vdpa.c | 29 +++--------------------------
>> >>>>>> 1 file changed, 3 insertions(+), 26 deletions(-)
>> >>>>>>
>> >>>>>>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> >>>>>>index 29ed4173f04e..448be7875b6d 100644
>> >>>>>>--- a/drivers/vhost/vdpa.c
>> >>>>>>+++ b/drivers/vhost/vdpa.c
>> >>>>>>@@ -22,6 +22,7 @@
>> >>>>>> #include <linux/nospec.h>
>> >>>>>> #include <linux/vhost.h>
>> >>>>>> #include <linux/virtio_net.h>
>> >>>>>>+#include <linux/virtio_blk.h>
>> >>>>>> #include "vhost.h"
>> >>>>>>@@ -185,26 +186,6 @@ static long
>> >>>>>>vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user
>> >>>>>>*statusp)
>> >>>>>>     return 0;
>> >>>>>> }
>> >>>>>>-static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
>> >>>>>>-                      struct vhost_vdpa_config *c)
>> >>>>>>-{
>> >>>>>>-    long size = 0;
>> >>>>>>-
>> >>>>>>-    switch (v->virtio_id) {
>> >>>>>>-    case VIRTIO_ID_NET:
>> >>>>>>-        size = sizeof(struct virtio_net_config);
>> >>>>>>-        break;
>> >>>>>>-    }
>> >>>>>>-
>> >>>>>>-    if (c->len == 0)
>> >>>>>>-        return -EINVAL;
>> >>>>>>-
>> >>>>>>-    if (c->len > size - c->off)
>> >>>>>>-        return -E2BIG;
>> >>>>>>-
>> >>>>>>-    return 0;
>> >>>>>>-}
>> >>>>>
>> >>>>>
>> >>>>>I think we should use a separate patch for this.
>> >>>>
>> >>>>For the vdpa-blk simulator I had the same issues and I'm adding
>> >>>>a .get_config_size() callback to vdpa devices.
>> >>>>
>> >>>>Do you think make sense or is better to remove this check in
>> >>>>vhost/vdpa, delegating the boundaries checks to
>> >>>>get_config/set_config callbacks.
>> >>>
>> >>>
>> >>>A question here. How much value could we gain from
>> >>>get_config_size() consider we can let vDPA parent to validate the
>> >>>length in its get_config().
>> >>>
>> >>
>> >>I agree, most of the implementations already validate the length,
>> >>the only gain is an error returned since get_config() is void, but
>> >>eventually we can add a return value to it.
>> >
>> >
>> >Right, one problem here is that. For the virito path, its get_config()
>> >returns void. So we can not propagate error to virtio drivers. But it
>> >might not be a big issue since we trust kernel virtio driver.
>> >
>> >So I think it makes sense to change the return value in the vdpa config ops.
>>
>> Thanks for your feedback!
>>
>> @Xie do you plan to do this?
>>
>> Otherwise I can do in my vdpa-blk-sim series, where for now I used this
>> patch as is.
>>
>
>Hi Stefano, please do in your vdpa-blk-sim series. I have no plan for 
>it now.

Okay, I'll do it.

Thanks,
Stefano

