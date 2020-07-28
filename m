Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC2230BBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgG1Nrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgG1Nrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:47:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300A3C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 06:47:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k20so10607433wmi.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OSYCNcv6QP2AWZFnDz1ZVHwamWh5TYh+zB48uW5Y4DQ=;
        b=W9t6FUnEBxNdxzQkcI6C5vxznK+5Tw3KTYBIVhixHAh+sAb6y8UhXGXlzr/SGihqte
         F6hpgjqVMIrdZpC+4ktbEv7UWr9OKGLRapVd7eS9llpwcqGP8kebukn6vPGRqXl/rSCC
         QYD0jdPKy9gApjlshFJ6qfgWNeXy72CrL+pcqFFg8p51K60EqodMhfMf0Yv+XGDSjchH
         pb67f9j43q1TEw1kSqf/kNaqHDgepcbknKr0xdZcuVXxwSKExHgyjL3oBSjnEhZwZCuQ
         GfW4t1O9niZ2WI30NGGM2nrWrnxexC9ornnCw4bxwgkgxkmnX4A9IYhcL82g67N8v8an
         K4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=OSYCNcv6QP2AWZFnDz1ZVHwamWh5TYh+zB48uW5Y4DQ=;
        b=XpLeNGew0g/93UTcWn2caINJ4Ayy3Uc3WjxSiTkBSjmZ1R0tFT4UE6HZSWc5i2p5Sb
         mR3i5tlUnm4cklQUyOvDsxRWDyvLx50edZE3fzrw1PnXLi7aykbEiIkhRsPnrym2mcGE
         IGnYM7M8jd0rRodbP8vfxhMOpBHlo9zAqs30rAzu6u0ARLb25ww+9coGwOHhvqb0//Mj
         prY0eBq4W6CJYtxYDJGOoen660Obb/DaIMJbjQnYJXC0M1UOnGewZkwJPszmuWIkBEO3
         BV6xmPinv2qbkubXDXq2qs+DOVEVVDQRT2yawyDk37TztvHUthPKvs2SHXZGzwgaXMNq
         DF8w==
X-Gm-Message-State: AOAM531JA4N7IlP4vxc+ln4khEXhWmnuPnhbX6gaMnDzM7a7eoo0X2vv
        bhPHQD5OL0D+pLKMEpWS7OhBV2yLu1MEZA==
X-Google-Smtp-Source: ABdhPJx91in5EEc3IpixReo9N4W729c2SiIfr1wd1gODBHkvBBy0FdGnQYRyZJ2Mp71Op/nCYOZyXw==
X-Received: by 2002:a1c:43c3:: with SMTP id q186mr1021703wma.144.1595944067883;
        Tue, 28 Jul 2020 06:47:47 -0700 (PDT)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id m20sm4242256wmc.1.2020.07.28.06.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 06:47:47 -0700 (PDT)
Subject: Re: [PATCH] fs: Return EOPNOTSUPP if block layer does not support
 REQ_NOWAIT
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
References: <20181213115306.fm2mjc3qszjiwkgf@merlin>
 <833af9cb-7c94-9e69-65cb-abd3cee5af65@scylladb.com>
 <20200728133817.lurap7lucjx7q7bw@fiona>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
Message-ID: <20a90311-0c3a-7055-d227-cd394dbb590b@scylladb.com>
Date:   Tue, 28 Jul 2020 16:47:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728133817.lurap7lucjx7q7bw@fiona>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 28/07/2020 16.38, Goldwyn Rodrigues wrote:
> On 19:08 22/07, Avi Kivity wrote:
>> On 13/12/2018 13.53, Goldwyn Rodrigues wrote:
>>> For AIO+DIO with RWF_NOWAIT, if the block layer does not support REQ_NOWAIT,
>>> it returns EIO. Return EOPNOTSUPP to represent the correct error code.
>>>
>>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>> ---
>>>    fs/direct-io.c | 11 +++++++----
>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/direct-io.c b/fs/direct-io.c
>>> index 41a0e97252ae..77adf33916b8 100644
>>> --- a/fs/direct-io.c
>>> +++ b/fs/direct-io.c
>>> @@ -542,10 +542,13 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
>>>    	blk_status_t err = bio->bi_status;
>>>    	if (err) {
>>> -		if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
>>> -			dio->io_error = -EAGAIN;
>>> -		else
>>> -			dio->io_error = -EIO;
>>> +		dio->io_error = -EIO;
>>> +		if (bio->bi_opf & REQ_NOWAIT) {
>>> +			if (err == BLK_STS_AGAIN)
>>> +				dio->io_error = -EAGAIN;
>>> +			else if (err == BLK_STS_NOTSUPP)
>>> +				dio->io_error = -EOPNOTSUPP;
>>> +		}
>>>    	}
>>>    	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
>>
>> In the end, did this or some alternative get applied? I'd like to enable
>> RWF_NOWAIT support, but EIO scares me and my application.
>>
> No, it was not. There were lot of objections to return error from the
> block layer for a filesystem nowait request.
>

I see. For me, it makes RWF_NOWAIT unusable, since I have no way to 
distinguish between real EIO and EIO due to this bug.


Maybe the filesystem should ask the block device if it supports nowait 
ahead of time (during mounting), and not pass REQ_NOWAIT at all in those 
cases.

