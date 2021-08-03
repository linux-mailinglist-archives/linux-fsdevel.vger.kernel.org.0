Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE83DE807
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhHCILL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 04:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234344AbhHCILJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627978258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zY0Qm6avJnx4fVfjFEoZtBf+5KuAldMVTd58ZzB3Cto=;
        b=bNJ8lizq6MiVd9yH+5iGVvJdM2MBgBdV3O5VgUZbEql+yQF676e3dZ49eIaq2BIJWz0P52
        /AzS+jJZu93WpHGBBdn83coKWzv0YRQeM/FMnZjm87eRaISJ9C32LXr3hPDUQoPvJpS4Eq
        30yfgQynOZJ4/Dwse2Fc1K9e710zVDw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-nBmYZa1wPxSBBxQ33AkWKQ-1; Tue, 03 Aug 2021 04:10:57 -0400
X-MC-Unique: nBmYZa1wPxSBBxQ33AkWKQ-1
Received: by mail-pl1-f197.google.com with SMTP id a17-20020a170902ecd1b029012c22956f93so16006754plh.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 01:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zY0Qm6avJnx4fVfjFEoZtBf+5KuAldMVTd58ZzB3Cto=;
        b=r6hjC0nLwH4isDUel9iYYYQdn6DaGTHUrsCGl0uSJPPenXnkDvvMaYLiagXqtv0IUt
         8M2pwlL8IaDq4ZIgZ6rHyHrCsC7UxqkuVY9GWC0VK3krFc12QDYum/0eeYUhDeEEZR+l
         7WxtJalLVgUSXzRZWP/8DtSznYCLUSQsrwu30Kvr+SM9dl3nAv8zB9vjkO/DKGl2JT5X
         E+wd/aUeEEAlx0sXykjV7xM9lsna1mtuGda6g8DvMYLiM9iKuVMYfrXVyYDRsfQ2uKzD
         vnCk2MFgYFN4BbdCaOoIkt05aE7QQhpKec+xysdL9tjzD44ugLsE+SeuUfpxm1uZ5TWq
         43+Q==
X-Gm-Message-State: AOAM5332nRA9eZY0WSBduEyasNHLchVZBrf8X+sGgFQnPrrD786o/SYS
        co0qfYLLI66At+Ux5UVVVMQeZkla7alHFKdBdQ47CT7vQ2x0wOmyc/uAIvbNp3Z0liNwHDtZ7Sy
        rpcHlolTQfGRY6O+wckg2h/dtpw==
X-Received: by 2002:a63:f904:: with SMTP id h4mr2936175pgi.238.1627978255984;
        Tue, 03 Aug 2021 01:10:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH8hbLkAijKqHClsGdxbrFT2e5OFHsYSjNhxOgbwifClMzXSHDtPi9YbQ4DmXvoCPE/e8DcA==
X-Received: by 2002:a63:f904:: with SMTP id h4mr2936146pgi.238.1627978255811;
        Tue, 03 Aug 2021 01:10:55 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u21sm14097827pfh.163.2021.08.03.01.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 01:10:55 -0700 (PDT)
Subject: Re: [PATCH v10 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on
 reset failure
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
 <20210729073503.187-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <55191de0-1a03-ff0d-1a49-afc419014bab@redhat.com>
Date:   Tue, 3 Aug 2021 16:10:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-6-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


�� 2021/7/29 ����3:34, Xie Yongji д��:
> Re-read the device status to ensure it's set to zero during
> resetting. Otherwise, fail the vhost_vdpa_set_status() after timeout.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/vhost/vdpa.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b07aa161f7ad..dd05c1e1133c 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -157,7 +157,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   	struct vdpa_device *vdpa = v->vdpa;
>   	const struct vdpa_config_ops *ops = vdpa->config;
>   	u8 status, status_old;
> -	int nvqs = v->nvqs;
> +	int timeout = 0, nvqs = v->nvqs;
>   	u16 i;
>   
>   	if (copy_from_user(&status, statusp, sizeof(status)))
> @@ -173,6 +173,15 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   		return -EINVAL;
>   
>   	ops->set_status(vdpa, status);
> +	if (status == 0) {
> +		while (ops->get_status(vdpa)) {
> +			timeout += 20;
> +			if (timeout > VDPA_RESET_TIMEOUT_MS)
> +				return -EIO;
> +
> +			msleep(20);
> +		}


Spec has introduced the reset a one of the basic facility. And consider 
we differ reset here.

This makes me think if it's better to introduce a dedicated vdpa ops for 
reset?

Thanks


> +	}
>   
>   	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
>   		for (i = 0; i < nvqs; i++)

