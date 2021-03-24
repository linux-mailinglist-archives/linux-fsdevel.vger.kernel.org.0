Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489F7347CAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 16:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhCXPcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 11:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236583AbhCXPby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616599914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8kn0B/D+pZ7zXWK7MZP4nFqRkdMczx4RoGNwPla3Io=;
        b=i7Yefys5GdQJo0zr4Lid9Gb8Gr9E8yHFWp8BOxJxLBuCtOSvePXI2x3khaUNY80UKugOiM
        otfo6/40zTGYaJPO/Sst+JI0WqnThlK5C+4HqPYeNNqrSlh8/9GxIccLN8yfVGo5fYTmUb
        Yfsv2AHQrv7bGKs56vWKevi4n8ynLQU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-Kq1ecjyxPjaYuuYrqxmP3g-1; Wed, 24 Mar 2021 11:31:52 -0400
X-MC-Unique: Kq1ecjyxPjaYuuYrqxmP3g-1
Received: by mail-oo1-f70.google.com with SMTP id h10so1463852ooj.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 08:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N8kn0B/D+pZ7zXWK7MZP4nFqRkdMczx4RoGNwPla3Io=;
        b=Sk1Xu8I22Y7dr9hW8i+8MEm037sl0tH7AVibNcYZOPIC2mlbeto6U43VjIndE6egJ8
         tVb1oy4UXYFSYr002LqCi+EImNrRIw1hclOYoEVf47XayRwBvsYa8eQgDHa0FwJi7yWR
         ooz7eloYvAxK+dHXgiAzWxqAqC+tFuK1ObwpWoLDikKEa2RTxnGoznCQLERhQRcyOAib
         J89GstRMos2buY5xRfHBPufJaMiNS1CLzEd1PbsPdBY2cMvG19jkqPRCe+ZaQH3IbV7A
         V+btbhomG+/XcAudMRGU4iDFrLzqcFxjWR+iTxXMAZs4xLkbuYtOLywjYVn7hMjdN8NY
         3rgA==
X-Gm-Message-State: AOAM533Ik1eyOmn7r76ByWeo9gG8FcSazgOjNb6Z1dRiY2X4K2sjxlSe
        p5UoFlINW2iIqrwtIDvVgOaCurVZj7ddrVZddcbadtkleWFj0R1zS/vI4GzaSn3Xv0iwaXRkTNt
        U/fXnKgSOwtwvrMzh+qfW02T9jQ==
X-Received: by 2002:a9d:6390:: with SMTP id w16mr3703292otk.178.1616599911302;
        Wed, 24 Mar 2021 08:31:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHcAMbU8Mdirt+zw6MDCjjmFcHf0Mz7Xosca571WY68Qps4nDv94Vb8jBdRKynlG/lxwuTWw==
X-Received: by 2002:a9d:6390:: with SMTP id w16mr3703287otk.178.1616599911158;
        Wed, 24 Mar 2021 08:31:51 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id k24sm457636oic.51.2021.03.24.08.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 08:31:50 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtio-fs-list <virtio-fs@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
 <04e46a8c-df26-3b58-71f8-c0b94c546d70@redhat.com>
 <CAJfpeguzdPV13LhXFL0U_bfKcpOHQCvg2wfxF6ryksp==tjVWA@mail.gmail.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <9879ca3f-548a-25d4-78f0-f307e1189231@redhat.com>
Date:   Wed, 24 Mar 2021 10:31:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpeguzdPV13LhXFL0U_bfKcpOHQCvg2wfxF6ryksp==tjVWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/24/21 10:30 AM, Miklos Szeredi wrote:
> On Wed, Mar 24, 2021 at 4:09 PM Connor Kuehl <ckuehl@redhat.com> wrote:
>>
>> On 3/18/21 10:17 AM, Miklos Szeredi wrote:
>>> I removed the conditional compilation and renamed the limit.  Also made
>>> virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.
>>
>> Hi Miklos,
>>
>> Has this patch been queued?
> 
> It's in my internal patch queue at the moment.   Will push to
> fuse.git#for-next in a couple of days.

Cool! Thank you :-)

Connor

