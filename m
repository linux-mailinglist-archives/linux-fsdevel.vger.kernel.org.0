Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312E51FF68D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbgFRPYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgFRPYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:24:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB05C06174E
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 08:24:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q22so197684pgk.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=57vHaiJ1z2Z+B6kffIaWqG5PKqCuhVgYJgvWdR2P1mU=;
        b=DUNL3Tro95sEbRGk1k9182cC3jStTGoNgKewAglJ6YRNlHJv87uK1t1hRNtaQEhV5L
         UTfj1GpvRmmyA1B50ZcYrWpgiFOcwWnKq2nXWTEZwrFFTNXGymBVxNRFka/68NlJ2dTG
         qfIjIYmNPyT62lJwvHbbdQhPYaZQAJagTnkZTuAhHtO5KfsR0g9wzBLXQfxfHsV6GHN6
         624iEklbDzR+9xIIXd5GYyQv5IbY5SFbJuPhTfj2/PA36ccdpVyi2vUq3QFFfc+Ubw2V
         AH6WRctLz7qByC57MT+eoT/ewS7naR0XN7qYj300Tz5IjdKy2nzjJXr72q397zinrHI/
         C+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=57vHaiJ1z2Z+B6kffIaWqG5PKqCuhVgYJgvWdR2P1mU=;
        b=tJ/1vtVN0BRQsTqox2eIxXBnomleh3wJtIFFSNlJYNXcZIvXFp0JUR7mFwnI/VwybD
         zhqHalSMRri3yzbQ7DTGZmTKgq4SIBKMvohOqGtMj6sOOCKGyghUGGY0rrRn8xmNhVON
         5Hk1SsthW/lLZgTkoG5lbhz+WkD8T4UMcx1g8BeRjQxg03MlHbzN19LlP2Lm6aHj9Lkj
         1FvTL0G5LbQ/j3vZfZn8f/5oBVaCJCLRAyEPMSunOskF4S5Iz3Nk2u6qqWKqQNfXg8/M
         zr7wxUsgo/CVpyXlHHXbxq15bgnh94YcdXaD3TMDMAKWxDGTMltSyNdHEta/6PR/D3oA
         X1JQ==
X-Gm-Message-State: AOAM530d09z6/L97vT/bPnSFR/nXgMn6bL7KJH+NLmCYbgVdvhMpjAfi
        ErW1caIwnyBVsF9D9nJDz1+jta1k3HpybQ==
X-Google-Smtp-Source: ABdhPJwMIf0SfezQ0GrtwoEg2e+XOj/fVZ1pbA7uq3769PZ3tvRMFjSVUgXFvAyB6WvFBwS+/oiD+g==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr4105037pfd.248.1592493894149;
        Thu, 18 Jun 2020 08:24:54 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 85sm3255834pfz.145.2020.06.18.08.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:24:53 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] loop: replace kill_bdev with invalidate_bdev
To:     Zheng Bin <zhengbin13@huawei.com>, hch@infradead.org,
        bvanassche@acm.org, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     houtao1@huawei.com, yi.zhang@huawei.com
References: <20200618042138.2094266-1-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22da0c3f-6656-1c1c-9b6f-6069392de719@kernel.dk>
Date:   Thu, 18 Jun 2020 09:24:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618042138.2094266-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/17/20 10:21 PM, Zheng Bin wrote:
> v1->v2: modify comment, and make function 'kill_bdev' static
> v2->v3: adapt code for commit 0c3796c24459
> ("loop: Factor out configuring loop from status")
> 
> Zheng Bin (2):
>   loop: replace kill_bdev with invalidate_bdev
>   block: make function 'kill_bdev' static
> 
>  drivers/block/loop.c | 8 ++++----
>  fs/block_dev.c       | 5 ++---
>  include/linux/fs.h   | 2 --
>  3 files changed, 6 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Jens Axboe

