Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9768E305666
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 10:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhA0JEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 04:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234614AbhA0JA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611737972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8F3p75SyEOVyX3ahfiz9umwfm5OOcgRN90TvZg1YzTg=;
        b=YQ37sOpTPh9Wfptv1+7I4yQwqbvrNyQZwCf7QRK2/HGhOSdR/7nlGuOSkSm+pWRlp2nvuz
        OY4awsgESh6aMfTtYyhshDYH6weBQ9DtKVjrUPOrPd8z7VyPDsAUl65GgBxct7DePIOZWn
        dPW61iDhpG5ZiI95mehxbI5zsG8oEcU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-NvukApzzOhCibNzvxorVLw-1; Wed, 27 Jan 2021 03:59:28 -0500
X-MC-Unique: NvukApzzOhCibNzvxorVLw-1
Received: by mail-wr1-f71.google.com with SMTP id r5so583660wrx.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 00:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8F3p75SyEOVyX3ahfiz9umwfm5OOcgRN90TvZg1YzTg=;
        b=G/R6dNpsmoypJeNbCSCYqKUCufVbeoIp3nBb2hS/8H3jFwx3PHek5tt8ehBnfYnFrk
         VAwKrxJ43Y6yj8jF9cNtNKwOQfTbtEjC4jM3/HPCM+KrEwf8u2pt405omQqfrU7Zhr0f
         lv/OadcSTm3maA2QVBCYJ/lZdmRa+4o7t6IFopgiZ3z+F3UZhIUK0dnUI80M6ylgLDbO
         9ACMMn/ZeEkY5rRJRANx+EswzzW8jvdvjVcFpKQmHi4Vrs4/U1SlnDde8BdpEhPG9T6U
         CBrSSJDFa8jYSeQ+MwMIiohuckUgQ5oE7p483JMPugowAZ2RT8uIWVOUuZaoOR/KJMKe
         k73g==
X-Gm-Message-State: AOAM5302FqzAMIx4Vt+FjJXpYXkbs53APPHx5aBw8gAjTkofcoGF2j79
        +EbDOSy5pCEa1Cd28kFdMziSQBeVGmiUEv88GFLGXv2LJFiVQcGak9L/IMpjNA6kcHkxgxDPzUZ
        1EeuEv5s4bTR9dtCcpUM852TuOQ==
X-Received: by 2002:a7b:cbd5:: with SMTP id n21mr3389399wmi.5.1611737967365;
        Wed, 27 Jan 2021 00:59:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6IR+GVVU30LyX9/KtKDCb/OF5xsvG/DpsrTzfFCkbaLPd/jhOGfpVe/ATCJ4R5nOCfXI/lQ==
X-Received: by 2002:a7b:cbd5:: with SMTP id n21mr3389372wmi.5.1611737967139;
        Wed, 27 Jan 2021 00:59:27 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id w126sm1817491wma.43.2021.01.27.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 00:59:26 -0800 (PST)
Date:   Wed, 27 Jan 2021 09:59:24 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        parav@nvidia.com, bob.liu@oracle.com, hch@infradead.org,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
Message-ID: <20210127085924.ktgmsgn6k3zegd67@steredhat>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210119045920.447-4-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:59:12PM +0800, Xie Yongji wrote:
>With VDUSE, we should be able to support all kinds of virtio devices.
>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vhost/vdpa.c | 29 +++--------------------------
> 1 file changed, 3 insertions(+), 26 deletions(-)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 29ed4173f04e..448be7875b6d 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -22,6 +22,7 @@
> #include <linux/nospec.h>
> #include <linux/vhost.h>
> #include <linux/virtio_net.h>
>+#include <linux/virtio_blk.h>

Is this inclusion necessary?

Maybe we can remove virtio_net.h as well.

Thanks,
Stefano

>
> #include "vhost.h"
>
>@@ -185,26 +186,6 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> 	return 0;
> }
>
>-static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
>-				      struct vhost_vdpa_config *c)
>-{
>-	long size = 0;
>-
>-	switch (v->virtio_id) {
>-	case VIRTIO_ID_NET:
>-		size = sizeof(struct virtio_net_config);
>-		break;
>-	}
>-
>-	if (c->len == 0)
>-		return -EINVAL;
>-
>-	if (c->len > size - c->off)
>-		return -E2BIG;
>-
>-	return 0;
>-}
>-
> static long vhost_vdpa_get_config(struct vhost_vdpa *v,
> 				  struct vhost_vdpa_config __user *c)
> {
>@@ -215,7 +196,7 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
>
> 	if (copy_from_user(&config, c, size))
> 		return -EFAULT;
>-	if (vhost_vdpa_config_validate(v, &config))
>+	if (config.len == 0)
> 		return -EINVAL;
> 	buf = kvzalloc(config.len, GFP_KERNEL);
> 	if (!buf)
>@@ -243,7 +224,7 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
>
> 	if (copy_from_user(&config, c, size))
> 		return -EFAULT;
>-	if (vhost_vdpa_config_validate(v, &config))
>+	if (config.len == 0)
> 		return -EINVAL;
> 	buf = kvzalloc(config.len, GFP_KERNEL);
> 	if (!buf)
>@@ -1025,10 +1006,6 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> 	int minor;
> 	int r;
>
>-	/* Currently, we only accept the network devices. */
>-	if (ops->get_device_id(vdpa) != VIRTIO_ID_NET)
>-		return -ENOTSUPP;
>-
> 	v = kzalloc(sizeof(*v), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> 	if (!v)
> 		return -ENOMEM;
>-- 
>2.11.0
>

