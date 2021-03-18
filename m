Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E471F340938
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 16:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhCRPwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 11:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231779AbhCRPwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616082738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0P/Vrxzie1x3w476DReMGEIFvpcpGMDppxg7+CGwcHo=;
        b=CpCzlyrKrSEdA3ieDaQpZj0Oib1CArt5T8aebF1gJzTiBMRlxMFUO+tDEeRNo0NOFLHHuN
        z+72ndHMGGXZk7vippkIelQFZcVj6pZBXdVPoqQoXk9iP9kvliCPLP3kr4ryiJIJfZB1mD
        +nvsSvjVbOKQg6jDgmuqsEEs4oYS064=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-rqOlXLGqNqW79GjswjAD2A-1; Thu, 18 Mar 2021 11:52:16 -0400
X-MC-Unique: rqOlXLGqNqW79GjswjAD2A-1
Received: by mail-oo1-f72.google.com with SMTP id l19so21223545oov.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 08:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0P/Vrxzie1x3w476DReMGEIFvpcpGMDppxg7+CGwcHo=;
        b=BGDZzLmQRdkZR4/oX/owaoSv9E6VEGvUq3Y1bTZgHp0CkaTzWiZ0wvN7ke8EAfQPE6
         KgkS6fR1qJ8nBWIAMgoWjB1Xw0d6eDVUz/sqBZwEOU6PWOy+JC06wTkCbJC0cjUmB2MP
         700NwV8TSMqWoj8A+KJgzpAShQG+XZwUlqqzXJ5KMIR+6JrS2spRos36y/9YU9Vno11V
         6POsLB+ABYgHSu8NN1m5SVouuyYrlgI89v7eEVqV2A/WuauFtIgNRzcv0DyX5sLNMxar
         RlAk+oPnH+CXCyVDjUMFBAYc0jcWH199VrzxapbbwG3pYU9TWqSD4W2n2KqHr7QOmcMw
         gyQQ==
X-Gm-Message-State: AOAM532LTxx2AsODsRBlx7IdCqdVK5H1fDXixpULr/c3kRQ4rqLEKCXK
        8Mx69hpZ6Mgb9P4FAYyEmHBCrGyrEhDU+ms0w6jFJCAUUmb1UFxoA6kC8VewrxTdzcxh6suSEGp
        MlPA/PMMIoCrUxNg1wrXHIv3Sdg==
X-Received: by 2002:aca:4acd:: with SMTP id x196mr3437838oia.34.1616082735758;
        Thu, 18 Mar 2021 08:52:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhJHdKiaGXJ8MuzmCbjxjarByEJ4cWNP+nZ4GdhXLr78M+x82KwR6XdnJXbEdlP7tV/S/HxA==
X-Received: by 2002:aca:4acd:: with SMTP id x196mr3437833oia.34.1616082735653;
        Thu, 18 Mar 2021 08:52:15 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id n17sm596142oic.8.2021.03.18.08.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 08:52:15 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, jasowang@redhat.com, mst@redhat.com
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <00c5dce8-fc2d-6e68-e3bc-a958ca5d2342@redhat.com>
Date:   Thu, 18 Mar 2021 10:52:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/18/21 10:17 AM, Miklos Szeredi wrote:
> I removed the conditional compilation and renamed the limit.  Also made
> virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.

Thanks, Miklos. I think it looks better with those changes.

> The virtio_ring patch in this series should probably go through the respective
> subsystem tree.

Makes sense. I've CC'd everyone that ./scripts/get_maintainers.pl 
suggested for that patch on this entire series as well. Should I resend 
patch #1 through just that subsystem to avoid confusion or wait to see 
if it gets picked out of this series?

Thanks again,

Connor

