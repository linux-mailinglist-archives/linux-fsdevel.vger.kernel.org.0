Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5883A758B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 22:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfGYUMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 16:12:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42354 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfGYUMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:12:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so52962159otn.9;
        Thu, 25 Jul 2019 13:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upMmfHcaeRgVvK81CCV//tdiGx+ZtNGeUUY24jsfROs=;
        b=gvQtENRn5rpL/dvfsFbVIQjibLT2YJy1FT/4/LYeVG0ahJ+hKL02+pLi+aGuJ8A1FO
         Xwz7wmutD74ykaWjS2fPLsa4LmjlIkHouoyn0jvvADggoldar5AZeeAqxWvpzkrR0Bja
         Dn9j1pdVC+gvo+33qYzQ4o4TIZ7WX32eciF4jeSkKVj7sIsvYAjvEY+gBZlQ5/QLVtC/
         70Fe6ldmc4qdA8Y+cbK9noaIh3xQpJfTRJnGYYM7Hf4z3fenNh8aIWTC1OPsO6NBe2nZ
         ylIHKI5XWaG49w4kiKUV49dUgrU/8ln5cSwujFGPexrNu9xUHC87JuzFqh5Mu2E3HrB0
         nerA==
X-Gm-Message-State: APjAAAXSNq1om+lgTfoKAlCxsUbD1aWbVnJBvCydXlkT68ls2Mf47+SO
        C42tDcNjHspMFSFmyHFYV6Q=
X-Google-Smtp-Source: APXvYqwoBViFnDcf+6pZDHGyFoMwEdvzaHQEty7ZB96NCnpf03fgmpW+suC4/aEJXauiaGWPDAcRcQ==
X-Received: by 2002:a05:6830:6:: with SMTP id c6mr3006263otp.14.1564085559039;
        Thu, 25 Jul 2019 13:12:39 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id 20sm8615958oth.43.2019.07.25.13.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 13:12:38 -0700 (PDT)
Subject: Re: [PATCH v6 04/16] nvme-core: introduce nvme_get_by_path()
To:     Keith Busch <kbusch@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-5-logang@deltatee.com>
 <20190725175023.GA30641@bombadil.infradead.org>
 <da58f91e-6cfa-02e0-dd89-3cfa23764a0e@deltatee.com>
 <20190725195835.GA7317@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0b7e5d9f-207c-ee4e-a992-024c178cdd49@grimberg.me>
Date:   Thu, 25 Jul 2019 13:12:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725195835.GA7317@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>> nvme_get_by_path() is analagous to blkdev_get_by_path() except it
>>>> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
>>>>
>>>> The purpose of this function is to support NVMe-OF target passthru.
>>>
>>> I can't find anywhere that you use this in this patchset.
>>>
>>
>> Oh sorry, the commit message is out of date the function was actually
>> called nvme_ctrl_get_by_path() and it's used in Patch 10.
> 
> Instead of by path, could we have configfs take something else, like
> the unique controller instance or serial number? I know that's different
> than how we handle blocks and files, but that way nvme core can lookup
> the cooresponding controller without adding new cdev dependencies.

We could... but did we find sufficient justification to have the user
handle passthru devices differently than any other backend?
once we commit to an interface its very hard to change.

