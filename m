Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38DBCBF2A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfIZMON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 08:14:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36475 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfIZMON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:14:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so1528774lff.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HxmJw9dmwOmUpSMCqEkLBVzIwTXQ9sN0mqmrf5PISjc=;
        b=Z3tMSPBQpthOduFIpYEw/QsUGEuPp4hvaijkNHmYcUB/NhsHBXmVU1k8CIoVjZuZT2
         DrP9E551AmwNzhFR1KFUGPM1Ddg2VjBFaz8/d0M6BKjaGb4hZvfnSoao0llkUc8TxG1/
         KvWoPWBhqcuz9/E3N0iU7UPoDxFCOV/60Nhc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HxmJw9dmwOmUpSMCqEkLBVzIwTXQ9sN0mqmrf5PISjc=;
        b=fM89GIgS0r0V9RlxAiKr0JqDEZxYi9bfZ4FEo+9euh1sUjtSAwX4kXQUlj9rkqXGYG
         lDE1WIKBXbFS0gGRNvWiOriIuozvT9TJ/8kGL/icgvY0k5s4Rl8Q1YzOWAeiaC+ONtJo
         IuFyV7mbAQli816Jk3dnDG0p0o2frPqpXpGSo4AOy2AEluZw9z3DZjmTnYp0CpVHl85R
         88bvKauXbPYYweabQ8I+4q8HqDfeNc7WW1XtORqa/O7M4jx++J4LtIWEvHd4XrtgN+vV
         yExceradbUm9w9VK+uN/4hYNtTPvgoCpS6ZzuG0S/8yew2uCHt1LuADzv7oLflTENisD
         YMqQ==
X-Gm-Message-State: APjAAAVGFtzf69CJLurEwp/4fCxvvu1zTyYKQ8c3vMBbRpdShsTZlxws
        bypTIxXYf1gfj7tv69V0iRiEllrMK7MjaYIh
X-Google-Smtp-Source: APXvYqxj08u1D9pH/PR1ybjpV0jEmy0AvvI4NI6cTqKsv0ckuKm+9vFi/zeXe7qtlQx59r/lIqNlJw==
X-Received: by 2002:a19:c002:: with SMTP id q2mr1113325lff.62.1569500051593;
        Thu, 26 Sep 2019 05:14:11 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g27sm473044lja.33.2019.09.26.05.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 05:14:10 -0700 (PDT)
Subject: Re: [PATCH][next] io_uring: ensure variable ret is initialized to
 zero
To:     Jens Axboe <axboe@kernel.dk>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190926095012.31826-1-colin.king@canonical.com>
 <3aa821ea-3041-fb56-2458-ec643963c511@kernel.dk>
 <20190926113329.GE27389@kadam>
 <04262621-68fd-a4bb-ab0c-83954c03fbb0@kernel.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2de0eb45-3abc-3ccd-f3d3-346d899ba50d@rasmusvillemoes.dk>
Date:   Thu, 26 Sep 2019 14:14:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <04262621-68fd-a4bb-ab0c-83954c03fbb0@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/09/2019 13.42, Jens Axboe wrote:
> On 9/26/19 1:33 PM, Dan Carpenter wrote:
>> On Thu, Sep 26, 2019 at 11:56:30AM +0200, Jens Axboe wrote:
>>> On 9/26/19 11:50 AM, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> In the case where sig is NULL the error variable ret is not initialized
>>>> and may contain a garbage value on the final checks to see if ret is
>>>> -ERESTARTSYS.  Best to initialize ret to zero before the do loop to
>>>> ensure the ret does not accidentially contain -ERESTARTSYS before the
>>>> loop.
>>>
>>> Oops, weird it didn't complain. I've folded in this fix, as that commit
>>> isn't upstream yet. Thanks!
>>
>> There is a bug in GCC where at certain optimization levels, instead of
>> complaining, it initializes it to zero.
> 
> That's awfully nice of it ;-)
> 
> Tried with -O0 and still didn't complain for me.
> 
> $ gcc --version
> gcc (Ubuntu 9.1.0-2ubuntu2~18.04) 9.1.0
> 
> Tried gcc 5/6/7/8 as well. Might have to go look at what code it's
> generating.
> 

I think it's essentially the same as
https://lore.kernel.org/lkml/CAHk-=whP-9yPAWuJDwA6+rQ-9owuYZgmrMA9AqO3EGJVefe8vg@mail.gmail.com/
(thread "tmpfs: fix uninitialized return value in shmem_link").

Rasmus
