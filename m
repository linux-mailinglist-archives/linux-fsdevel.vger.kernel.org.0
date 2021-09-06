Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88250401617
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 07:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhIFF4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 01:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhIFF4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 01:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630907696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXUj74/nW7Dop13kd56Tk5oKTffqICUe0M10X4WaPl4=;
        b=GUdZ1eZQlzCOGh1NwV8LtGH2T8rzYVbjGWgYpiIJXoRpQ92bQe12hhNowOqoFXtPMxzW5u
        aP3PYHxyAmwSjUySiwvrIceX1TPdj2cz/H7djZxQi1eHPdnARmD4QnZmPJUGR8BF2LTKWC
        5MAZc/xWES7JWGitNVqcR86RsKXi2zg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-NaQp_-otOt-BXKrF6kAU1g-1; Mon, 06 Sep 2021 01:54:55 -0400
X-MC-Unique: NaQp_-otOt-BXKrF6kAU1g-1
Received: by mail-wr1-f70.google.com with SMTP id t15-20020a5d42cf000000b001565f9c9ee8so853210wrr.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Sep 2021 22:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXUj74/nW7Dop13kd56Tk5oKTffqICUe0M10X4WaPl4=;
        b=GjVEBDNC+STfRb5YmAXradD26ecsRsBh3+uxycoiSZ+zdfPKm2t3S50Z3kMgelPuHz
         C32ECLYMlEIOqbhupea9n/q8uwTnG2Au3UUZaKJDuxhVe7cVhSdO8dObBhlxLkzfWj/k
         QxiH63X34JjO7XooVNf5ZyNYRoMQEG6kkvIGHKEmK4Q7PqEEHRY03wZRtWpxF7ep54+u
         ZIPDeElEUwJ3w2ZByM7If8Qb6Mj8y0PNpLHk+vjlAfciUPuYXbO0LIqAVPyHKouF2vDw
         reXaKznQjwNFZjDaK7Gijgn3MVJZai01K1OwuY3hb+N5p2RI/lm9IFA2mRSZVByPH+pA
         rrwQ==
X-Gm-Message-State: AOAM5313fl7XRdqg4vJ2XJkVq8O9EcIMba50IJfqQcISrNQyUchtNPdJ
        nImMJ+c7KHcvcUbNfATTaoSp2CuTwKzcIXqCKHGWbjA1mzNz69a8uFFDHWUdVtph0OGCeEMnF5/
        H1bwB6ph2zEm8+dCFVo5mpjRtiQ==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr11478492wre.115.1630907694506;
        Sun, 05 Sep 2021 22:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR1O2bgM/VI9yvbWaSh3BRtvaI+DJ+X6rHFaklEn67szHR3xlYEE2NCPwCA7NsX4rJPFqdkg==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr11478480wre.115.1630907694360;
        Sun, 05 Sep 2021 22:54:54 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
        by smtp.gmail.com with ESMTPSA id h8sm6166143wmb.35.2021.09.05.22.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 22:54:53 -0700 (PDT)
Date:   Mon, 6 Sep 2021 01:54:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com,
        will@kernel.org, john.garry@huawei.com, songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 05/13] vdpa: Add reset callback in vdpa_config_ops
Message-ID: <20210906015243-mutt-send-email-mst@kernel.org>
References: <20210830141737.181-1-xieyongji@bytedance.com>
 <20210830141737.181-6-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830141737.181-6-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:17:29PM +0800, Xie Yongji wrote:
> This adds a new callback to support device specific reset
> behavior. The vdpa bus driver will call the reset function
> instead of setting status to zero during resetting.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

This does gloss over a significant change though:

> @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>  	return vdev->dma_dev;
>  }
>  
> -static inline void vdpa_reset(struct vdpa_device *vdev)
> +static inline int vdpa_reset(struct vdpa_device *vdev)
>  {
>  	const struct vdpa_config_ops *ops = vdev->config;
>  
>  	vdev->features_valid = false;
> -	ops->set_status(vdev, 0);
> +	return ops->reset(vdev);
>  }
>  
>  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)

Unfortunately this breaks virtio_vdpa:


static void virtio_vdpa_reset(struct virtio_device *vdev)
{
        struct vdpa_device *vdpa = vd_get_vdpa(vdev);

        vdpa_reset(vdpa);
}


and there's no easy way to fix this, kernel can't recover
from a reset failure e.g. during driver unbind.

Find a way to disable virtio_vdpa for now?

> -- 
> 2.11.0

