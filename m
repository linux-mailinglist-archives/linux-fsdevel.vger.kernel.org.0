Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE029305751
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 10:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhA0Jsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 04:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233939AbhA0I7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611737855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPgcywD0j5awyWVQ+snyVyf/6e4yZ9nFi++5lgI6S2I=;
        b=fC+l0q8tkyRLyjAdW4JReu+Fgd5zy/gJriszLUafNNh+Sg8UJLMyMGJQEEmH6vHkSg6EPJ
        tKP+T6lTfi/do7o95gr+4h1AzjBMhZaAvl2akPYtRGsduKxsnjkoT4iEWxCGFhQW+agR9D
        3n4LHfC0W7smAgy2pRh3m+xl9yDJhUQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-CHDCrWvxMKOw2FbgxoGmhw-1; Wed, 27 Jan 2021 03:57:34 -0500
X-MC-Unique: CHDCrWvxMKOw2FbgxoGmhw-1
Received: by mail-wm1-f71.google.com with SMTP id h25so554507wmb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 00:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZPgcywD0j5awyWVQ+snyVyf/6e4yZ9nFi++5lgI6S2I=;
        b=RAzKsvpvYHlBtCijEp2ztIbvErZ0GaqW8VBfv6k465gYvTagw0FaIRPrlQ2HD+sk4T
         VntxcgNhJVvjiDMe9WZBrz/GH9VQo8mz3zSmXBBsGZL/tO9RPhmMli92VtpIeCNdFSOL
         FbvW1ZwuYd/mCb2QrrkTIf1J2veq9n44eOJgTkQoAvcqlY+ph3KwhwL8Fph+lJHhudHI
         MQNd/TuJH111xRUIOXNGxORroenkYm79zVw03A4HtincHXWfVPu5H0RN920PRe+JzS6a
         5Av/FO62a4KXxTyrpkHTy81PoZptmtYmwTmpkJ5t2sLCRWUB0vAO8rhcgp4ochExDAqz
         waeQ==
X-Gm-Message-State: AOAM5315h2vN31unbr2gc4FKJ14K2VMRIJ+4zi2eNyFDElv+S1PfYR2g
        rQNNnjc+tycGAwENd34tl/Q6K/bbNWtwhHLz7uq4Y6vo2IaZtyzkNdGJ31uh7Pz3uxSgZUUWw7G
        q79zpxtuhhgur+2NiP3DHNwjSYw==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr3232751wmh.47.1611737852671;
        Wed, 27 Jan 2021 00:57:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW8VjlyEjOrzyTn/DAveR4W/k8WYqN3LUc8WsqpWp1qpUrs5jsivjNxY6wkqg60gGYjfDUZg==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr3232732wmh.47.1611737852463;
        Wed, 27 Jan 2021 00:57:32 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id d2sm2259357wre.39.2021.01.27.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 00:57:31 -0800 (PST)
Date:   Wed, 27 Jan 2021 09:57:28 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, parav@nvidia.com, bob.liu@oracle.com,
        hch@infradead.org, rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
Message-ID: <20210127085728.j6x5yzrldp2wp55c@steredhat>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
 <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
 <20210120110832.oijcmywq7pf7psg3@steredhat>
 <1979cffc-240e-a9f9-b0ab-84a1f82ac81e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1979cffc-240e-a9f9-b0ab-84a1f82ac81e@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:33:03AM +0800, Jason Wang wrote:
>
>On 2021/1/20 下午7:08, Stefano Garzarella wrote:
>>On Wed, Jan 20, 2021 at 11:46:38AM +0800, Jason Wang wrote:
>>>
>>>On 2021/1/19 下午12:59, Xie Yongji wrote:
>>>>With VDUSE, we should be able to support all kinds of virtio devices.
>>>>
>>>>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>>>---
>>>> drivers/vhost/vdpa.c | 29 +++--------------------------
>>>> 1 file changed, 3 insertions(+), 26 deletions(-)
>>>>
>>>>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>index 29ed4173f04e..448be7875b6d 100644
>>>>--- a/drivers/vhost/vdpa.c
>>>>+++ b/drivers/vhost/vdpa.c
>>>>@@ -22,6 +22,7 @@
>>>> #include <linux/nospec.h>
>>>> #include <linux/vhost.h>
>>>> #include <linux/virtio_net.h>
>>>>+#include <linux/virtio_blk.h>
>>>> #include "vhost.h"
>>>>@@ -185,26 +186,6 @@ static long vhost_vdpa_set_status(struct 
>>>>vhost_vdpa *v, u8 __user *statusp)
>>>>     return 0;
>>>> }
>>>>-static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
>>>>-                      struct vhost_vdpa_config *c)
>>>>-{
>>>>-    long size = 0;
>>>>-
>>>>-    switch (v->virtio_id) {
>>>>-    case VIRTIO_ID_NET:
>>>>-        size = sizeof(struct virtio_net_config);
>>>>-        break;
>>>>-    }
>>>>-
>>>>-    if (c->len == 0)
>>>>-        return -EINVAL;
>>>>-
>>>>-    if (c->len > size - c->off)
>>>>-        return -E2BIG;
>>>>-
>>>>-    return 0;
>>>>-}
>>>
>>>
>>>I think we should use a separate patch for this.
>>
>>For the vdpa-blk simulator I had the same issues and I'm adding a 
>>.get_config_size() callback to vdpa devices.
>>
>>Do you think make sense or is better to remove this check in 
>>vhost/vdpa, delegating the boundaries checks to 
>>get_config/set_config callbacks.
>
>
>A question here. How much value could we gain from get_config_size() 
>consider we can let vDPA parent to validate the length in its 
>get_config().
>

I agree, most of the implementations already validate the length, the 
only gain is an error returned since get_config() is void, but 
eventually we can add a return value to it.

Thanks,
Stefano

