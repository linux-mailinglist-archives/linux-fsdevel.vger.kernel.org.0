Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89B6266638
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgIKRXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgIKRX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:23:27 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B80C061786
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 10:23:27 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a19so5105838ilq.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 10:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=69/MIdTNBXtljk9O8CO0dWSDv8qzVuAfM6FGYy8egG0=;
        b=J9DhvQOicouxRDyUSKh47GW2ozyvtioXpkK+4oAqexRfz3hSdCCyUaahRUUhiL9Au6
         lMZA+ZkJS3NdgJwZuNWv4LhmY+9hg13PksG21pkbCRi8WddjPTMcimJuOtBV5zP3plxj
         bZpQB8vPhUhgZNH4GrbrmSNCtCE7JpSD6SYeFfNFzntpOrQzc/zBqyz7G9uZnyaFzMvV
         EElXcs/vmgNFURY1nCt0MHN6pwxmhnSsoiY7UPwPHiLruUJNaREk/tmeAwGpndJoWz8h
         3y4YLJGkAm9Ux/LVKbVPFfhf5S2p6y9AtqxL5gevLpty5Zbn65SnGgfJVyNaIshY2uoy
         j99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=69/MIdTNBXtljk9O8CO0dWSDv8qzVuAfM6FGYy8egG0=;
        b=VYZa9Evp1xRVePFkxpUVqZqc2qf1qPYmNNDY4f3MJavJybRWfBLvgE2BBHCfV4yWQm
         MM0zAzicnfu9r1foK0UiVmKcsi13ka7jegveA9flbYNrNOJ/k++nKoC6IWn4NyhyUCp6
         1EKKl+wRjyduYWvOV/AWSwxcjcQ0/AQLNa03bwqLmxQJdOOk4Rt0G2Kyg4zGNN+HCkMV
         VANURENGdTN1i2rHnB7lSRpXN7LX2bmXZ9gd4YkLlLA2JDyirLrxrS1e8Tyt49Vpm5vK
         ftC5bNYF4kOJSGSnkjGnSGkfVDMlAkb8IywNzH85XoCzYI17A8MNL9Ko1QTp2W0avaQy
         rdOg==
X-Gm-Message-State: AOAM5339RuIIBYDFa7OZ2c/KGDl12m34TOlPjtxO9mdmUJ1c5+OOsYt2
        DR9oz8s+IDcRBCfMBf5O9H1l9g==
X-Google-Smtp-Source: ABdhPJw4CnPCdQGZu9QaWio440R39IKmwLQwT77gudoENSxfTHMAEP4M+Vi2ycgo4S87EAmAA/NZtg==
X-Received: by 2002:a92:3007:: with SMTP id x7mr2682114ile.48.1599845004743;
        Fri, 11 Sep 2020 10:23:24 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t10sm1518014ilf.34.2020.09.11.10.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:23:23 -0700 (PDT)
Subject: Re: [PATCH V8 3/3] fuse: Handle AIO read and write in passthrough
To:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200911163403.79505-1-balsini@android.com>
 <20200911163403.79505-4-balsini@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f83b1074-3f20-771f-7b2f-a2fd3ffb4e44@kernel.dk>
Date:   Fri, 11 Sep 2020 11:23:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911163403.79505-4-balsini@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/20 10:34 AM, Alessio Balsini wrote:
> Extend the passthrough feature by handling asynchronous IO both for read
> and write operations.
> When an AIO request is received, targeting a FUSE file with passthrough
> functionality enabled, a new identical AIO request is created, the file
> pointer of which is updated with the file pointer of the lower file system,
> and the completion handler is set with a special AIO passthrough handler.
> The lower file system AIO request is allocated in dynamic kernel memory
> and, when it completes, the allocated memory is freed and the completion
> signal is propagated to the FUSE AIO request by triggering its completion
> callback as well.
> 
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/passthrough.c | 66 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 44a78e02f45d..87b57b26fd8a 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -2,10 +2,16 @@
>  
>  #include "fuse_i.h"
>  
> +#include <linux/aio.h>

What is this include for? It's not using any aio parts at all.

-- 
Jens Axboe

