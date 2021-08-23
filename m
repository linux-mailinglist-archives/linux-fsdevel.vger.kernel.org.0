Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F303F44F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 08:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhHWGcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 02:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230294AbhHWGcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629700289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUHa3Avm2+6fKkcYKeAqHdN474qgV/5/pGdz9tfcqgE=;
        b=Pr0urgQ6OLnNrE99zLSew6QXJSMfG8Is0JGyilij7CycTKtSrtiL9+b4UAgkQpvSl6pAeU
        WJL1a2PiZqrzC5azvFX8luQKm0PEMrcTtxtKgIwmX4xYD/XIi+ONmYft45v76nniuZtpRB
        qR5jpO2uo+jY2LnrQNUVD4pbw3T22kU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-cCGuUBqzP4yxCQBivkfubA-1; Mon, 23 Aug 2021 02:31:27 -0400
X-MC-Unique: cCGuUBqzP4yxCQBivkfubA-1
Received: by mail-pf1-f199.google.com with SMTP id n27-20020a056a000d5b00b003e147fb595eso8177775pfv.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Aug 2021 23:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AUHa3Avm2+6fKkcYKeAqHdN474qgV/5/pGdz9tfcqgE=;
        b=rvsrOx/uPFo20f43PngWb9S42JuYT6ZNaQfzOBWS6NmWEuCz17MPOpFOFc9XtRKqtE
         +Kw5WoPh6VNbtH7/nBk40rhCrT7UZiFAUCNZIqCZHjN9QjCIhDDhWXzBq5WcH5/CcRL/
         lUFgqU5M5u5leasRzn1fKRSRcXzd/wXG8A4Rw1nP1cXi3Rhi6h1TVmXWudgRH6EeVTgf
         ZW5+cnAUA7AK99w5WJujagfRru+uXTaRjG33M7ftFewIWt102fPQGvsTA5OFvnRXiCJs
         cA54iB4S45fW0BcpJ0b6eKME6SKv1dwewZKrmByEbMXCVh1kdlPOQWbyTjP2lJzJSO9y
         /W0A==
X-Gm-Message-State: AOAM5335nnvWnYhzGebOVc0dDAJ/12pbxH40LYS6ZQwQzA2RMftqPbsH
        bAraZ5Z9M4un5Aqxg6QV7WYDlji7wV8qzry5a0fTm5Q9E8JPUgjiW8jFfA332TsBKE5yw6fy9aO
        pqguzCjgYL2kmgUZI2dqBGjBOEg==
X-Received: by 2002:aa7:8b0a:0:b0:3e1:2df9:d827 with SMTP id f10-20020aa78b0a000000b003e12df9d827mr31726453pfd.67.1629700286607;
        Sun, 22 Aug 2021 23:31:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz38m1FHbtQPPoBW5Z1aB8WuAIQK8sTxgnijH4Tg0S/NrYwdHny5cJXtC/iUOPx4pNk0Ak/A==
X-Received: by 2002:aa7:8b0a:0:b0:3e1:2df9:d827 with SMTP id f10-20020aa78b0a000000b003e12df9d827mr31726432pfd.67.1629700286415;
        Sun, 22 Aug 2021 23:31:26 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g85sm6392736pfb.172.2021.08.22.23.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 23:31:25 -0700 (PDT)
Subject: Re: [PATCH v11 04/12] vdpa: Add reset callback in vdpa_config_ops
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
 <20210818120642.165-5-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4470fdac-89fb-1216-78d7-6335c3bfeb22@redhat.com>
Date:   Mon, 23 Aug 2021 14:31:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-5-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2021/8/18 ÏÂÎç8:06, Xie Yongji Ð´µÀ:
> This adds a new callback to support device specific reset
> behavior. The vdpa bus driver will call the reset function
> instead of setting status to zero during resetting if device
> driver supports the new callback.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/vhost/vdpa.c |  9 +++++++--
>   include/linux/vdpa.h | 11 ++++++++++-
>   2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b07aa161f7ad..b1c91b4db0ba 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -157,7 +157,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   	struct vdpa_device *vdpa = v->vdpa;
>   	const struct vdpa_config_ops *ops = vdpa->config;
>   	u8 status, status_old;
> -	int nvqs = v->nvqs;
> +	int ret, nvqs = v->nvqs;
>   	u16 i;
>   
>   	if (copy_from_user(&status, statusp, sizeof(status)))
> @@ -172,7 +172,12 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
>   		return -EINVAL;
>   
> -	ops->set_status(vdpa, status);
> +	if (status == 0 && ops->reset) {
> +		ret = ops->reset(vdpa);
> +		if (ret)
> +			return ret;
> +	} else
> +		ops->set_status(vdpa, status);
>   
>   	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
>   		for (i = 0; i < nvqs; i++)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 8a645f8f4476..af7ea5ad795f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -196,6 +196,9 @@ struct vdpa_iova_range {
>    *				@vdev: vdpa device
>    *				Returns the iova range supported by
>    *				the device.
> + * @reset:			Reset device (optional)
> + *				@vdev: vdpa device
> + *				Returns integer: success (0) or error (< 0)


It looks to me we'd better make this mandatory. This help to reduce the 
confusion for the parent driver.

Thanks


>    * @set_map:			Set device memory mapping (optional)
>    *				Needed for device that using device
>    *				specific DMA translation (on-chip IOMMU)
> @@ -263,6 +266,7 @@ struct vdpa_config_ops {
>   			   const void *buf, unsigned int len);
>   	u32 (*get_generation)(struct vdpa_device *vdev);
>   	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> +	int (*reset)(struct vdpa_device *vdev);
>   
>   	/* DMA ops */
>   	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> @@ -351,12 +355,17 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>   	return vdev->dma_dev;
>   }
>   
> -static inline void vdpa_reset(struct vdpa_device *vdev)
> +static inline int vdpa_reset(struct vdpa_device *vdev)
>   {
>   	const struct vdpa_config_ops *ops = vdev->config;
>   
>   	vdev->features_valid = false;
> +	if (ops->reset)
> +		return ops->reset(vdev);
> +
>   	ops->set_status(vdev, 0);
> +
> +	return 0;
>   }
>   
>   static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)

