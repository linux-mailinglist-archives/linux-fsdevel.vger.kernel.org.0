Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E41390E57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 04:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhEZCh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 22:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231961AbhEZChz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 22:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621996584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJC3K6l6gJPi4CUzLhheMs0LRbWxiui4b9xku04/3mg=;
        b=FLTML3az9GlmnIZWqYMuqNDvbo0kAbcKdtWA/qQOtP61hXvjCRvJbYxmobEYwQDKmY6umM
        CMe6gi/fjyBY5zthf+zP1YJl0HGmBeB1IAY7/x9edoBsTt7D8QmHGLw7N91wm00e1nbpex
        dp1rdxIvq45sG53RU8N+vKjVcPTav40=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-2xhRJHHbOAyxCsCO-HCP_Q-1; Tue, 25 May 2021 22:36:22 -0400
X-MC-Unique: 2xhRJHHbOAyxCsCO-HCP_Q-1
Received: by mail-pg1-f199.google.com with SMTP id 28-20020a63135c0000b029021b78388f01so6294750pgt.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 19:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IJC3K6l6gJPi4CUzLhheMs0LRbWxiui4b9xku04/3mg=;
        b=HRNoyZwV3387mHWi7yjsaccZKBqYTtv3UcLUGk+ymOT6Q4nUNNBmJ0ZNtXpWxarYjY
         QgHIYzFdLQLLGGDrsDRMQ5MUcqQosdQZg+VrxwpjHZFb4O4gT5vEwRyDrIL7UJvCwajt
         BEAPa7flJxskI7TwKjF8rCaA+8y1XqgCTQ8bNsW5hWwotx6UQkym5FFOoywxuGjYq9QI
         qkLV+AjQiN7HKtzjjgVOSrhF3nYPTa5tEF9fiBVUfADbD4WYFdEAdbm1xFOXAT8ejJC3
         X5LkPu1dade1ooDqKi9tDKTfuB2FV7pBPMSD0O6HTvzCw1fYztBiPZhxHwBnfSD+hydz
         3Alw==
X-Gm-Message-State: AOAM533Jns5AlRI/qax2jEkqnXxIn1+i7sDoCpmDfn3UKo/TyzVJrr8/
        zbtxh7nTbqws4Bh8AhFOQsaLYBgoUI+tNCNNJ3nnM4Cyl6P90+pVvSeHHEmfX636/Q4syHx9ofn
        cC6A2xM/gdiqSc1kHTf0ScoLRbg==
X-Received: by 2002:a17:902:f281:b029:f0:bdf2:2fe5 with SMTP id k1-20020a170902f281b02900f0bdf22fe5mr32724325plc.68.1621996581540;
        Tue, 25 May 2021 19:36:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylcchXGFUiLMl0CERc9pjyfUvd7s5BV6gdMSkLdsrvpEyh07CtgmlI9vttP0fXdJsLVzRn5Q==
X-Received: by 2002:a17:902:f281:b029:f0:bdf2:2fe5 with SMTP id k1-20020a170902f281b02900f0bdf22fe5mr32724300plc.68.1621996581246;
        Tue, 25 May 2021 19:36:21 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b12sm2984392pjd.22.2021.05.25.19.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 19:36:20 -0700 (PDT)
Subject: Re: [PATCH v7 01/12] iova: Export alloc_iova_fast()
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
 <20210517095513.850-2-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6ca337fe-2c8c-95c9-672e-0d4f104f66eb@redhat.com>
Date:   Wed, 26 May 2021 10:36:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517095513.850-2-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2021/5/17 ÏÂÎç5:55, Xie Yongji Ð´µÀ:
> Export alloc_iova_fast() so that some modules can use it
> to improve iova allocation efficiency.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/iommu/iova.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index e6e2fa85271c..317eef64ffef 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -450,6 +450,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   
>   	return new_iova->pfn_lo;
>   }
> +EXPORT_SYMBOL_GPL(alloc_iova_fast);
>   
>   /**
>    * free_iova_fast - free iova pfn range into rcache


Interesting, do we need export free_iova_fast() as well?

Thanks


