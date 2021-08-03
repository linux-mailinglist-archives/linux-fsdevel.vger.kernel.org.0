Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7B3DE7A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhHCH6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 03:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234277AbhHCH6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627977523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4067Q/uBr5whrrksAorpAMgFNv8fx79XPkLrnKf4gpY=;
        b=GsYFhZt0eeN7o6OmcSp59Y3ZBqGFQJPDhZgS3Z0hWFoJuGkoqWS9w+upgFHXJGjMTDac++
        XAJ07zL6HQiAkQFSyyinvydU+J0PqWiaSmmyB/Zve7namqIHO+533Mw5BDqK/aVe3BLYu/
        nBo96LvmrcVOXaI23SHi/QClOF8f+Vo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-5-2tttlQMSupwGM3gbZXbQ-1; Tue, 03 Aug 2021 03:58:41 -0400
X-MC-Unique: 5-2tttlQMSupwGM3gbZXbQ-1
Received: by mail-pj1-f71.google.com with SMTP id h21-20020a17090adb95b029017797967ffbso2771841pjv.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 00:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4067Q/uBr5whrrksAorpAMgFNv8fx79XPkLrnKf4gpY=;
        b=BtWKXdokiPLWsy8pVWZebe2nJlj3I1a1XC70rLQPDJf+tDgQOGFy4IHgZrXOFrTnuD
         bmFFjaX9QF4NJxJzxiEg0GslEkVJEtl+WipeuQc500f2V6oygSMpxktpMey952PmY6F4
         GclPfYRgvqCXLs+90mszGbj76jGZbs5CIJ2oACYH8CCGLOY6lGPp0SUuXZYS7E02Pq3x
         2f+SJzewfo7ZHMBl6MfYUaWGjhwquNmaEbi5KhPePwXFAS9QSWdF73CvTtjOfs8XTrTT
         1D08qevuIxoefp5/w0atpjEgMvDLcUoIGyt3ZVpsmJk+p7FHVz45uDK2npkt+4GA9XFh
         ECgQ==
X-Gm-Message-State: AOAM533mELS/otaJF8KCn2xEuWjioalkNLw9jYS/w7JvoF5NRmxBYyMT
        D9nF6uwj34Wa9jZb8qA8lrZl5ADEd0VaJxxVekEXYnJ0iAcPy3bIJD7OmbYYeQ+SedbcXlrp2JF
        L7EaXruOxeckGLtaWOnX0Z9BVtA==
X-Received: by 2002:a62:64ce:0:b029:3b8:90c:6eec with SMTP id y197-20020a6264ce0000b02903b8090c6eecmr13054225pfb.9.1627977520778;
        Tue, 03 Aug 2021 00:58:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjX5wUayvV2kr5HqNyIW/IueFG/FKVhos2G8U/pZi0sFBb3YPj3+qYU1BLVJyBkEZqQdqW6A==
X-Received: by 2002:a62:64ce:0:b029:3b8:90c:6eec with SMTP id y197-20020a6264ce0000b02903b8090c6eecmr13054211pfb.9.1627977520538;
        Tue, 03 Aug 2021 00:58:40 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s133sm4953282pfs.190.2021.08.03.00.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 00:58:40 -0700 (PDT)
Subject: Re: [PATCH v10 04/17] vdpa: Fail the vdpa_reset() if fail to set
 device status to zero
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-5-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <39a191f6-555b-d2e6-e712-735b540526d0@redhat.com>
Date:   Tue, 3 Aug 2021 15:58:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-5-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2021/7/29 ÏÂÎç3:34, Xie Yongji Ð´µÀ:
> Re-read the device status to ensure it's set to zero during
> resetting. Otherwise, fail the vdpa_reset() after timeout.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   include/linux/vdpa.h | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 406d53a606ac..d1a80ef05089 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -6,6 +6,7 @@
>   #include <linux/device.h>
>   #include <linux/interrupt.h>
>   #include <linux/vhost_iotlb.h>
> +#include <linux/delay.h>
>   
>   /**
>    * struct vdpa_calllback - vDPA callback definition.
> @@ -340,12 +341,24 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>   	return vdev->dma_dev;
>   }
>   
> -static inline void vdpa_reset(struct vdpa_device *vdev)
> +#define VDPA_RESET_TIMEOUT_MS 1000
> +
> +static inline int vdpa_reset(struct vdpa_device *vdev)
>   {
>   	const struct vdpa_config_ops *ops = vdev->config;
> +	int timeout = 0;
>   
>   	vdev->features_valid = false;
>   	ops->set_status(vdev, 0);
> +	while (ops->get_status(vdev)) {
> +		timeout += 20;
> +		if (timeout > VDPA_RESET_TIMEOUT_MS)
> +			return -EIO;
> +
> +		msleep(20);
> +	}


I wonder if it's better to do this in the vDPA parent?

Thanks


> +
> +	return 0;
>   }
>   
>   static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)

