Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E229390E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 04:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhEZCnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 22:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232307AbhEZCnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 22:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621996911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bc/2MmUW+pgbFW2qFMtYQUjTQyUaBFo1vkB8ZkWRL6s=;
        b=WYwuElLbt8HR3LiQAPzK6gFc9h355udPLg8pOk1tuxHJ4KDZefIsFd/oPL1mBbWYWvozB6
        w5lS9gyGatHMpZjcUADmUBDHMWjmyr6LzrjxcAPJbQY+i3znfjt9zCzunLo71u9RghrfCl
        rEmMGY6jNV+kw6tdSt5aYsCBtuJT6oU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-kaUA8s_KM16LcKV_SARK6Q-1; Tue, 25 May 2021 22:41:50 -0400
X-MC-Unique: kaUA8s_KM16LcKV_SARK6Q-1
Received: by mail-pg1-f199.google.com with SMTP id 30-20020a630a1e0000b029021a63d9d4cdso22345956pgk.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 19:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bc/2MmUW+pgbFW2qFMtYQUjTQyUaBFo1vkB8ZkWRL6s=;
        b=ZnA8ieLxiha0WrkOZFqVex3lbHDQeBMPhZM4qeUJrreIZUqeReNdMRFhEmLMf3BtI/
         Io0bYcC5IzoUU4U3aadW6/NuraJfQSx7tp6KP6nyabn0afmT15YwoIit+/tNoldE+kpP
         vHWn2cmublDMSyrSvkhz+ck8s/ReSG2pPFkmlTNsIVjFPdBXzxcAwqA3a5Mrem8PhKkZ
         x95P0FKWA18qcGVnE1PHOC3zPizdm+ft3te0EjB4UPOyNc0AtvYLuPfS6pNGEoXqPYJJ
         UJJKh0SiNnxv7WjIsRjRg45eUCl/tCxFT3W1W6QoUAlCv3uOKv0bLzl22nMrxCMhgG8w
         zt6w==
X-Gm-Message-State: AOAM530CDH/quR9wFVN9eQNNouY9iJO2DDoDzcaA9jzFd5hRDDV/+NCs
        HDbx/izpF0sUNILoE/8VpQtBFekA0CJ5GFCFXmjZnGKIJbpy5e+YZGofcl0SqeKzuX+p0p+Ba75
        zZA32GSI4hV/nC7/lBsMHfN/uMQ==
X-Received: by 2002:a62:ab10:0:b029:2e8:d5a8:d635 with SMTP id p16-20020a62ab100000b02902e8d5a8d635mr15164701pff.74.1621996909405;
        Tue, 25 May 2021 19:41:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdM51fqapZ+TAydQBf1YBCQBeMJGeM8QJFnRIR/jK472sF6Fh8jpb1mmntXjLVehm11MPEGA==
X-Received: by 2002:a62:ab10:0:b029:2e8:d5a8:d635 with SMTP id p16-20020a62ab100000b02902e8d5a8d635mr15164685pff.74.1621996909140;
        Tue, 25 May 2021 19:41:49 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a8sm14716088pfk.11.2021.05.25.19.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 19:41:48 -0700 (PDT)
Subject: Re: [PATCH v7 05/12] virtio_scsi: Add validation for residual bytes
 from response
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <94abb1de-921d-8bf2-4cfc-55c7fc86c5a0@redhat.com>
Date:   Wed, 26 May 2021 10:41:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517095513.850-6-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


�� 2021/5/17 ����5:55, Xie Yongji д��:
> This ensures that the residual bytes in response (might come
> from an untrusted device) will not exceed the data buffer length.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/scsi/virtio_scsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index efcaf0674c8d..ad7d8cecec32 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -97,7 +97,7 @@ static inline struct Scsi_Host *virtio_scsi_host(struct virtio_device *vdev)
>   static void virtscsi_compute_resid(struct scsi_cmnd *sc, u32 resid)
>   {
>   	if (resid)
> -		scsi_set_resid(sc, resid);
> +		scsi_set_resid(sc, min(resid, scsi_bufflen(sc)));
>   }
>   
>   /*


Acked-by: Jason Wang <jasowang@redhat.com>


