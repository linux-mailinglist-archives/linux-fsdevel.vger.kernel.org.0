Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F313EF56A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhHQWHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 18:07:14 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:40734 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhHQWHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:07:13 -0400
Received: by mail-pg1-f178.google.com with SMTP id y23so111942pgi.7;
        Tue, 17 Aug 2021 15:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d1NvDBzspxxyRi/JU6mkO/Y9RX6b8XmFBQ7KZDZMOrI=;
        b=sJq+5LwyhRFt6iUi1hi913vFnmbtpAP129u4skq1nmYopowCUdRqvp3Zh/tZ8tES2n
         hr5ETmK+Wx6U33kN+C0xHUXDVHRQXVFtLR7SpQSjYxxeTF0bGp9oke06B3AtcW/Xn1c3
         FiUkpEFlf4ZyvPB6KKR47oq83QAbIJvh6SCAlhsxc/HrXgE1v1lsopC523dIjj9B3rHf
         xwPouEk31kOohP5Y/1t0w59qNvyNbH3x3VeqJinc1BAjx3ifyM3b2+nMqjHakiCLWxXo
         5CVZduMrmqlT+KsoQylw4r92GmI1rrBjBZ3wMsgkffffq4EXOM6lq4/ux5PE4OumgJDE
         jGTA==
X-Gm-Message-State: AOAM5308vRoOqIeC5VeZIx/LDQ5CUqj6wyST6rQbXKpUjPT38hU2kgxk
        FRjPX9U9rCvi/WbFcmsfvlY=
X-Google-Smtp-Source: ABdhPJw7LqAAu3ADrUe4x5xcX+IpGVCRdOJivZhoDJHTeIj8/NmXs+jjll6YxWczOsAmKfPaM7OZQQ==
X-Received: by 2002:a05:6a00:884:b029:346:8678:ce15 with SMTP id q4-20020a056a000884b02903468678ce15mr5735112pfj.75.1629237999882;
        Tue, 17 Aug 2021 15:06:39 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ae3f:1e44:e6d0:4a44])
        by smtp.gmail.com with ESMTPSA id y5sm4244890pgs.27.2021.08.17.15.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 15:06:39 -0700 (PDT)
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To:     dgilbert@interlog.com, Mikulas Patocka <mpatocka@redhat.com>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        djwong@kernel.org, Mike Snitzer <snitzer@redhat.com>,
        agk@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, nitheshshetty@gmail.com,
        joshi.k@samsung.com, javier.gonz@samsung.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
 <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
 <alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com>
 <bbecc7e7-8bf5-3fe3-6c24-883c79fb7517@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <53b14381-101f-209b-382c-67d88af9647d@acm.org>
Date:   Tue, 17 Aug 2021 15:06:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <bbecc7e7-8bf5-3fe3-6c24-883c79fb7517@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/21 2:53 PM, Douglas Gilbert wrote:
> On 2021-08-17 4:41 p.m., Mikulas Patocka wrote:
>> On Tue, 17 Aug 2021, Bart Van Assche wrote:
>>> On 8/17/21 3:14 AM, SelvaKumar S wrote:
>>>> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
>>>> bio with control information as payload and submit to the device.
>>>> Larger copy operation may be divided if necessary by looking at device
>>>> limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
>>>> submitted to zoned device.
>>>> Native copy offload is not supported for stacked devices.
>>>
>>> Using a single operation for copy-offloading instead of separate 
>>> operations
>>> for reading and writing is fundamentally incompatible with the device 
>>> mapper.
>>> I think we need a copy-offloading implementation that is compatible 
>>> with the
>>> device mapper.
>>
>> I once wrote a copy offload implementation that is compatible with device
>> mapper. The copy operation creates two bios (one for reading and one for
>> writing), passes them independently through device mapper and pairs them
>> at the physical device driver.
>>
>> It's here: 
>> http://people.redhat.com/~mpatocka/patches/kernel/xcopy/current
> 
> In my copy solution the read-side and write-side bio pairs share the 
> same storage (i.e. ram) This gets around the need to copy data between 
> the bio_s.
> See:
>     https://sg.danny.cz/sg/sg_v40.html
> in Section 8 on Request sharing. This technique can be efficiently 
> extend to
> source --> destination1,destination2,...      copies.
> 
> Doug Gilbert
> 
>> I verified that it works with iSCSI. Would you be interested in 
>> continuing
>> this work?

Hi Mikulas and Doug,

Yes, I'm interested in continuing Mikulas' work on copy offloading. I 
will take a look at Doug's approach too for sharing buffers between 
read-side and write-side bios. It may take a few months however before I 
can find the time to work on this.

Thanks,

Bart.
