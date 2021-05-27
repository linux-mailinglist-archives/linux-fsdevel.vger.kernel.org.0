Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60B43925EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 06:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhE0EOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 00:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhE0EOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 00:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622088791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3igEycLd8J73C7Vxb8Ui44QuvOprk+cULPfcPtYoIg=;
        b=BQehTt0BN7shr/lvvpwbSbCxdzqrIQgr3kKOYZ2ydE6KskuW+AJsn1I+Lr62u1xZif/Ft8
        dgo5yfWC/n/v2gRhEhso8F1E0Vuf/YiDzCLr1n0txvWMkpZt448/dHW1qop0i36g6CBkF4
        G7w8FoIgjxhlZz4vzwJEi704VWwNF10=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-OTriBpnwO26tIoQ0HbYurA-1; Thu, 27 May 2021 00:13:08 -0400
X-MC-Unique: OTriBpnwO26tIoQ0HbYurA-1
Received: by mail-pj1-f72.google.com with SMTP id o1-20020a17090a4201b029015c8f11f550so1742629pjg.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 21:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=q3igEycLd8J73C7Vxb8Ui44QuvOprk+cULPfcPtYoIg=;
        b=lyFhbJ32w5wIkID8SHp8GfGJMy1KwUvXpgit/0UTX581Uik2mCCaPilAbJw0sI0Cyj
         tc4wV+k6CvB31tafPUPpKfVx7jKYaF18/pdvDsNTFjnVb5aiz2+/ksqhbdDIbXT6L1MB
         zQCAB9E14zLnRSC/ZiVMpRZrNsddVcp9e/hDZF+UpSHH3eyAG6rciugGqH43pkw3WBiK
         irR8jDL8czPEhWDHPohdD5kUfH8TkCsdn9Hrbv3VXIlOf4qFapxF5OJZfVjMGXWyzWA/
         YJgJNCT/7MN2DRbjuIv0CabIRJSOQ82F/k2my0iB/wZ+8e3SnWDykdh3mAizQDOCHOeW
         mW5A==
X-Gm-Message-State: AOAM5301ty33+Mn71qMBvsoBT/QS72UT2EU/ejLIWUQJ6zeDwaFnB1Si
        07JD5HRbuuQMHzQoGaD7L3GiHCsDO7FQbQGp5h5g3CjtHjwbQiuV7bs9yOhJ1DmUNqKkaHb0kvW
        VSxZrZMK7yvU6V38mroLqle8giA==
X-Received: by 2002:a63:3c0e:: with SMTP id j14mr1842302pga.427.1622088787569;
        Wed, 26 May 2021 21:13:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNWCYMnMC1HxMoP07R/3S3m3jilU3dNCIEmruTMAtVdxqR2yiJbYdkUNhO/NZQxyTwe/4ddA==
X-Received: by 2002:a63:3c0e:: with SMTP id j14mr1842274pga.427.1622088787269;
        Wed, 26 May 2021 21:13:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c134sm622801pfb.135.2021.05.26.21.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 21:13:06 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
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
 <20210517095513.850-12-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
Date:   Thu, 27 May 2021 12:12:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517095513.850-12-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2021/5/17 ÏÂÎç5:55, Xie Yongji Ð´µÀ:
> +
> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
> +			      struct vduse_dev_msg *msg)
> +{
> +	init_waitqueue_head(&msg->waitq);
> +	spin_lock(&dev->msg_lock);
> +	vduse_enqueue_msg(&dev->send_list, msg);
> +	wake_up(&dev->waitq);
> +	spin_unlock(&dev->msg_lock);
> +	wait_event_killable(msg->waitq, msg->completed);


What happens if the userspace(malicous) doesn't give a response forever?

It looks like a DOS. If yes, we need to consider a way to fix that.

Thanks


> +	spin_lock(&dev->msg_lock);
> +	if (!msg->completed) {
> +		list_del(&msg->list);
> +		msg->resp.result = VDUSE_REQUEST_FAILED;
> +	}
> +	spin_unlock(&dev->msg_lock);
> +
> +	return (msg->resp.result == VDUSE_REQUEST_OK) ? 0 : -1;
> +}

