Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9976E3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfGZPqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 11:46:55 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34250 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfGZPqz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:46:55 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hr2Qh-0002Yy-EH; Fri, 26 Jul 2019 09:46:48 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
 <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
 <20190725191124.GE30641@bombadil.infradead.org>
 <425dd2ac-333d-a8c4-ce49-870c8dadf436@deltatee.com>
 <20190725235502.GJ1131@ZenIV.linux.org.uk>
 <7f48a40c-6e0f-2545-a939-45fc10862dfd@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fce9d627-3bf7-2c63-dbdc-5b252792cc36@deltatee.com>
Date:   Fri, 26 Jul 2019 09:46:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7f48a40c-6e0f-2545-a939-45fc10862dfd@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: hch@lst.de, maxg@mellanox.com, linux-fsdevel@vger.kernel.org, kbusch@kernel.org, linux-block@vger.kernel.org, sbates@raithlin.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, gregkh@linuxfoundation.org, willy@infradead.org, viro@zeniv.linux.org.uk, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-07-25 10:29 p.m., Sagi Grimberg wrote:
> 
>>>>>>>> NVMe-OF is configured using configfs. The target is specified by
>>>>>>>> the
>>>>>>>> user writing a path to a configfs attribute. This is the way it
>>>>>>>> works
>>>>>>>> today but with blkdev_get_by_path()[1]. For the passthru code,
>>>>>>>> we need
>>>>>>>> to get a nvme_ctrl instead of a block_device, but the principal
>>>>>>>> is the same.
>>>>>>>
>>>>>>> Why isn't a fd being passed in there instead of a random string?
>>>>>>
>>>>>> I suppose we could echo a string of the file descriptor number there,
>>>>>> and look up the fd in the process' file descriptor table ...
>>>>>
>>>>> Assuming that there is a open handle somewhere out there...
>>>
>>> Yes, that would be a step backwards from an interface. The user would
>>> then need a special process to open the fd and pass it through configfs.
>>> They couldn't just do it with basic bash commands.
>>
>> First of all, they can, but... WTF not have filp_open() done right there?
>> Yes, by name.  With permission checks done.  And pick your object from
>> the
>> sodding struct file you'll get.
>>
>> What's the problem?  Why do you need cdev lookups, etc., when you are
>> dealing with files under your full control?  Just open them and use
>> ->private_data or whatever you set in ->open() to access the damn thing.
>> All there is to it...
> Oh this is so much simpler. There is really no point in using anything
> else. Just need to remember to compare f->f_op to what we expect to make
> sure that it is indeed the same device class.

Yes, that sounds like a good idea. I'll do this for v2.

Thanks,

Logan
