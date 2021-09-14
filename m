Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0541140A3E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbhINCyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 22:54:23 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:43766 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbhINCyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:54:22 -0400
Received: by mail-pf1-f170.google.com with SMTP id f65so10756661pfb.10;
        Mon, 13 Sep 2021 19:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n9QXTYQ7gFuOAX5ceoQmW2i5wwUUt7ZoVGuJ1Q+ByGg=;
        b=Xu7WPbsrPN/H+b1DejJAqwAADVjtRHXlZNzHN3jFdg2o21KfB3RwROJdeCtCJbXLlB
         65edHKblIYVM9SHpma6ysixqv5C2xNhWbnpdzk2xKTwmM8vGdTyDguIi/r/rdVnDoESH
         nHk4vKq2q9iPgUlYZSEdqlNVQKhzgLr5EJ3hLl5k0Vca6astmsBN/ehG3/X+8C3X18EL
         zloK1YPTt4IwSokWVD5XUMv6niZR+/mVoBB2DFSEd0IGfHEyiD0BHE52JB/wp5d+qtyG
         dMlba5viScpxoxQKS8xkMqPJ9R0M7qVN2nYVZnWHUAgh/FOcSLbWG45MEyy/ZFgQ9xAl
         UT4Q==
X-Gm-Message-State: AOAM531or95cbgc9Kb3zRcIlhiP613AfKSCydnBxum4dSE63iaduCJSM
        uc8cq+hciMVCkGIzZcVoGo4Wwpe4W3M=
X-Google-Smtp-Source: ABdhPJzCjlQBAM65nrozLAPtaHZ9hK+go73Jw+Nd11yG0bcOtFL3vUliYNYADVorc5fyGErB4WJf2w==
X-Received: by 2002:aa7:9e4b:0:b0:43d:fb1d:39cb with SMTP id z11-20020aa79e4b000000b0043dfb1d39cbmr1736166pfq.69.1631587985821;
        Mon, 13 Sep 2021 19:53:05 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:e47e:ab85:4d9e:deba? ([2601:647:4000:d7:e47e:ab85:4d9e:deba])
        by smtp.gmail.com with ESMTPSA id o22sm8168010pji.18.2021.09.13.19.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 19:53:04 -0700 (PDT)
Message-ID: <2bd7d03e-c2d0-0cb5-76fc-f5601324a18d@acm.org>
Date:   Mon, 13 Sep 2021 19:53:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: start switching sysfs attributes to expose the seq_file
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210913054121.616001-1-hch@lst.de>
 <21413ac5-f934-efe2-25ee-115c4dcc86a5@acm.org> <YT+AbumufeL6nRss@kroah.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YT+AbumufeL6nRss@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/13/21 09:46, Greg Kroah-Hartman wrote:
> On Mon, Sep 13, 2021 at 09:39:56AM -0700, Bart Van Assche wrote:
>> On 9/12/21 10:41 PM, Christoph Hellwig wrote:
>>> Al pointed out multiple times that seq_get_buf is highly dangerous as
>>> it opens up the tight seq_file abstractions to buffer overflows.  The
>>> last such caller now is sysfs.
>>>
>>> This series allows attributes to implement a seq_show method and switch
>>> the block and XFS code as users that I'm most familiar with to use
>>> seq_files directly after a few preparatory cleanups.  With this series
>>> "leaf" users of sysfs_ops can be converted one at at a time, after that
>>> we can move the seq_get_buf into the multiplexers (e.g. kobj, device,
>>> class attributes) and remove the show method in sysfs_ops and repeat the
>>> process until all attributes are converted.  This will probably take a
>>> fair amount of time.
>>
>> Hi Christoph,
>>
>> Thanks for having done this work. In case you would need it, some time ago
>> I posted the following sysfs patch but did not receive any feedback:
>> "[PATCH] kernfs: Improve lockdep annotation for files which implement mmap"
>> (https://lore.kernel.org/linux-kernel/20191004161124.111376-1-bvanassche@acm.org/).
>>
> 
> That was from back in 2019, sorry I must have missed it.
> 
> Care to rebase and resend it if it is still needed?

Hi Greg,

I think that patch is still relevant. It removes some ugly code from 
sysfs. I will rebase, retest and resend it.

Thanks,

Bart.
