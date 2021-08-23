Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2A43F44F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 08:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhHWGdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 02:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231749AbhHWGc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629700337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F427DPlADbCH/M2u7fz/h7ndiMrb6AVw4qTHSvYRC+w=;
        b=DCzM5i35ExJMLNvv7UguV+GarRVqJ2FxcZh4qwMW8Eg8Sj/CeSAuoAUKWCLjq8ccDIRm9K
        g21Aj2IPQEdGm5sk8DT4dwsVpqWp+C0tmkWJJuw5WSKnquBemqwVLcgP6TF1T+8kwNGbRa
        u/ryfb+7i9IOS0oJyT5//OkA6p9sU2o=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-t-PcmFmfPASgNI7gqwGxMw-1; Mon, 23 Aug 2021 02:32:15 -0400
X-MC-Unique: t-PcmFmfPASgNI7gqwGxMw-1
Received: by mail-pf1-f197.google.com with SMTP id g17-20020aa781910000b0290360a5312e3eso8167982pfi.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Aug 2021 23:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F427DPlADbCH/M2u7fz/h7ndiMrb6AVw4qTHSvYRC+w=;
        b=McVQfZ2+NUMV6VsfDR/Aiea4C9oa+lghE097v0K+dPTT2e5AIGaULA/q5rQnv4mrn3
         62NhQyBmiz971IVYnvSsftrwgcTObiHWGrZfa25IYg4L5/4DBJU46hKnTf5/9WXfnN4L
         48sWWfkdWMlBAGH9CcY8x/tIWZNTYEoeQ2n39AOkwAlf7hFJ9eN5JdURK8JkD9D556a0
         +y2qe/MRJwsSw00m1gmPLBU+x8P4Ua4UVHL3bKwB5RaNkgjDM7SqHCcwfdK8lq/+/g8K
         xWKR6cWpGhTNGlo7AB8DqOkg2mY72wogCt0iBXIqkFlyuVvxE3Aup1FOboosHofAXclZ
         njIQ==
X-Gm-Message-State: AOAM530TfXHRC7BAnKYtijZZhhrNWymmbv0XkAJ/LSYHubt7aE3Fklja
        YgVENMwE7b0nBcHjkAzfhgx997Gvp+os8/zmUi2bC/C57Lr+0TGEMiwdxsVfJ94umXKFAWEfbmT
        eiYuVc3xgh/KhXcNIP8weMUosyA==
X-Received: by 2002:a65:40c4:: with SMTP id u4mr30729299pgp.186.1629700333945;
        Sun, 22 Aug 2021 23:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMdGRZ8bEDFR6mhq5hnskFTgOQcLb0mODJnisTe/klfXgBImg93E0Jn9mD7e+X41rM+h1P3A==
X-Received: by 2002:a65:40c4:: with SMTP id u4mr30729265pgp.186.1629700333764;
        Sun, 22 Aug 2021 23:32:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d7sm17831032pgu.78.2021.08.22.23.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 23:32:13 -0700 (PDT)
Subject: Re: [PATCH v11 05/12] vhost-vdpa: Handle the failure of vdpa_reset()
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
 <20210818120642.165-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a9283bf7-bf24-b092-e79d-37c5c4f9e087@redhat.com>
Date:   Mon, 23 Aug 2021 14:32:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-6-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2021/8/18 ÏÂÎç8:06, Xie Yongji Ð´µÀ:
> The vdpa_reset() may fail now. This adds check to its return
> value and fail the vhost_vdpa_open().
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vhost/vdpa.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b1c91b4db0ba..d99d75ad30cc 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -116,12 +116,13 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
>   	irq_bypass_unregister_producer(&vq->call_ctx.producer);
>   }
>   
> -static void vhost_vdpa_reset(struct vhost_vdpa *v)
> +static int vhost_vdpa_reset(struct vhost_vdpa *v)
>   {
>   	struct vdpa_device *vdpa = v->vdpa;
>   
> -	vdpa_reset(vdpa);
>   	v->in_batch = 0;
> +
> +	return vdpa_reset(vdpa);
>   }
>   
>   static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
> @@ -868,7 +869,9 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>   		return -EBUSY;
>   
>   	nvqs = v->nvqs;
> -	vhost_vdpa_reset(v);
> +	r = vhost_vdpa_reset(v);
> +	if (r)
> +		goto err;
>   
>   	vqs = kmalloc_array(nvqs, sizeof(*vqs), GFP_KERNEL);
>   	if (!vqs) {

