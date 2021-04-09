Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361B735A2CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhDIQQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232855AbhDIQQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617984959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ympzD91JBFEmUB8z07nEg3SFQfNcnSyyZ0Xyv2VW9mY=;
        b=TlzeXOtNuTnUvukhNQ2GH9MewsWRL+TUX+H15gXN9KQ5JfLSP9bcH/MZtSF5UemuwRZiDc
        jDbF5TQH+4dBNMB5fHU3SSEB58ObtgRxyTyK5rTz25rIawL25CZTe8fU7/CtfGiuT4Nn1e
        c1HNpKt3k9MSQrYPBdy/NnC47TPSRd4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-YAQdgp95PAyCylanxmyq7Q-1; Fri, 09 Apr 2021 12:15:57 -0400
X-MC-Unique: YAQdgp95PAyCylanxmyq7Q-1
Received: by mail-wr1-f71.google.com with SMTP id z17so2533760wru.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 09:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ympzD91JBFEmUB8z07nEg3SFQfNcnSyyZ0Xyv2VW9mY=;
        b=HEKnbYuoQoRutRmjM7SH2akOYUhCqPsnpG8rkeDymij9U/OE/k+txewdEKpYHZOsHx
         qHOJ1B3zc+JkSxytq5GEyqA9KMcj9G/PfTiepCEvl3b4ogvSutgBYgvhKM1cunTDGSki
         1zhmP2RnMV+FMA5cqzV/ZfO2UUw3lfZoqnxBI4WR1Ra44ady2ZrRCQFkp62TiwHW5c+9
         k56rsNcYRE8y/BrGpw+htGvvpzQMPhmjrnXQyifmKd5j/XbebqwB2H5L8VW9PDm88ZFL
         P9CpFz+RFyTveHk54FliL6WHBdvKpVfo/WoO53Io8RIgdrf2FsrNVVH7bnkB8lJnvAxR
         05Aw==
X-Gm-Message-State: AOAM531HMrHC2VtaAm7B1aHHgreWk64p2E5nk827QXqJ2r9ruVDjMIqs
        WFemaPrbt36BHKttMBaXfzU+kWldmUXCSoOW9DTE4BEWr16tKjDxR1UFwhwSVOdhtlWoNp1E5Q9
        vLE/RB5yNEeVe2K7typJTcrhM/w==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr18461076wrr.61.1617984956087;
        Fri, 09 Apr 2021 09:15:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7/KOvp7jfAdtHy4C2v6W8Sr5jADGDS1mDCv/rNxxuSfa3gCZY792heyfmCgnU+ZhCR5H7YQ==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr18461055wrr.61.1617984955917;
        Fri, 09 Apr 2021 09:15:55 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
        by smtp.gmail.com with ESMTPSA id 3sm5445635wma.45.2021.04.09.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:15:55 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:15:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] vhost-vdpa: protect concurrent access to vhost
 device iotlb
Message-ID: <20210409121512-mutt-send-email-mst@kernel.org>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-4-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331080519.172-4-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 04:05:12PM +0800, Xie Yongji wrote:
> Use vhost_dev->mutex to protect vhost device iotlb from
> concurrent access.
> 
> Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I could not figure out whether there's a bug there now.
If yes when is the concurrent access triggered?

> ---
>  drivers/vhost/vdpa.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3947fbc2d1d5..63b28d3aee7c 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -725,9 +725,11 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	int r = 0;
>  
> +	mutex_lock(&dev->mutex);
> +
>  	r = vhost_dev_check_owner(dev);
>  	if (r)
> -		return r;
> +		goto unlock;
>  
>  	switch (msg->type) {
>  	case VHOST_IOTLB_UPDATE:
> @@ -748,6 +750,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
>  		r = -EINVAL;
>  		break;
>  	}
> +unlock:
> +	mutex_unlock(&dev->mutex);
>  
>  	return r;
>  }
> -- 
> 2.11.0

