Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF302DC20B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 15:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgLPOT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 09:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgLPOTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:19:55 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71BCC06179C
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 06:19:15 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z136so24100347iof.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 06:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ziA5Om5HHx0wYwmSShJIoUMVU/JHbHbLYBXb6IBP1r0=;
        b=CAmg/IDik4QYb9lUz9HPb7wfijsUU567H+u4dxOK83Nd4YSVc/5WwYFO8VMkXIP693
         O3sBjWgiSRijIeU4auB9Hbbv5XnjmKyJm5tihTwnFQD70L5VTl3JJrF0alxDnbfQ/7Dx
         Yks8ek75EQXiHL2ViQdDCcc5xtZSWTlw/E5aKTaQ6W997zKTnMkFOfD5h/kvxueA8leF
         TIanv9pCtLHrie0MkieJaf4qM1CMHgtlYZIBaFa7QJT9vqO2qsNwGQ2MPdiPhfe375ev
         QKmO3kAPyDz6L03IpCiJ1Zdy7/V6t6z3qORKq1lzPv48AAX90cU5h2We76OJWWzQjWqS
         FG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ziA5Om5HHx0wYwmSShJIoUMVU/JHbHbLYBXb6IBP1r0=;
        b=PfLRM65MjHsCMD+FfduZlBxvY9xFCFBzha3iv/yXI4aAdkfs+dev++FDZcDgwuXWmA
         KW1Zdr79zCePIe/dIHc1oL3ht2TuK3cW9NAq9twV+51A7p4+z9KYRJQQIXEuAs+POiOj
         2cQdGKWj6dTiJJXf4MBJPdhx8uCr3NgA8SdAEfslSd46lgK4LX36l7LyI1L7zJqCII7H
         z0+BYM+YT+1Q0AqB0Yti0d/EYeD4Nd/bd16M2L92i7ijfj+KhOtoyza4y0wsPzhS9dWc
         c3Syo8OPYmzG20Flpcfzyy9MIsVc9BStDmqNYRF6TnjtTe9XcP9WGqLbP2kGY8b+/bXH
         XcPw==
X-Gm-Message-State: AOAM533Q88Y9ZwOyirnkmj2HJWojxzBXTB+WH7tXB7H9YOxF9SSET/XO
        kjA3+eH8Mh0PfEdddgM5XNJx874UdxLoFw==
X-Google-Smtp-Source: ABdhPJxbik0NYeYtNw8F5U0rzsXi5uZlb1hsGtc5WEnZL0ecekLSs1jMewzBcM5CjY0sqdAEJbkvLw==
X-Received: by 2002:a05:6638:296:: with SMTP id c22mr43948661jaq.65.1608128354895;
        Wed, 16 Dec 2020 06:19:14 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z4sm7692233ioh.32.2020.12.16.06.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 06:19:14 -0800 (PST)
Subject: Re: [PATCH] writeback: don't warn on an unregistered BDI in
 __mark_inode_dirty
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org
References: <20200928122613.434820-1-hch@lst.de>
 <20201209163536.GA2587@quack2.suse.cz> <20201209174750.GA20352@lst.de>
 <20201216105732.GF21258@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6a6c5eb5-6712-e53e-d93b-2d6b4440015b@kernel.dk>
Date:   Wed, 16 Dec 2020 07:19:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216105732.GF21258@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/16/20 3:57 AM, Jan Kara wrote:
> On Wed 09-12-20 18:47:50, Christoph Hellwig wrote:
>> On Wed, Dec 09, 2020 at 05:35:36PM +0100, Jan Kara wrote:
>>>> I have a vague memory someone else sent this patch alredy, but couldn't
>>>> find it in my mailing list folder.  But given that my current NVMe
>>>> tests trigger it easily I'd rather get it fixed ASAP.
>>>
>>> Did this patch get lost? I don't see it upstream or in Jens' tree. FWIW I
>>> agree the warning may result in false positive so I'm OK with removing it.
>>> So feel free to add:
>>>
>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>> Yes, it looks like this patch got lost somewhere again.
> 
> Since Jens didn't reply, I've just picked up the patch to my tree and will
> push it to Linus tomorrow.

Sorry about that... That sounds fine to me, thanks Jan.

-- 
Jens Axboe

