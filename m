Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403A5758FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 22:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfGYUhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 16:37:21 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43852 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfGYUhU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:37:20 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqkU7-0005Lc-87; Thu, 25 Jul 2019 14:37:08 -0600
To:     Keith Busch <kbusch@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-5-logang@deltatee.com>
 <20190725175023.GA30641@bombadil.infradead.org>
 <da58f91e-6cfa-02e0-dd89-3cfa23764a0e@deltatee.com>
 <20190725195835.GA7317@localhost.localdomain>
 <5dd6a41d-21c4-cf8d-a81d-271549de6763@deltatee.com>
 <20190725203118.GB7317@localhost.localdomain>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3bb266ae-abf3-0146-5d93-e7a600453493@deltatee.com>
Date:   Thu, 25 Jul 2019 14:37:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725203118.GB7317@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, sagi@grimberg.me, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, willy@infradead.org, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v6 04/16] nvme-core: introduce nvme_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-07-25 2:31 p.m., Keith Busch wrote:
> On Thu, Jul 25, 2019 at 02:28:28PM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2019-07-25 1:58 p.m., Keith Busch wrote:
>>> On Thu, Jul 25, 2019 at 11:54:18AM -0600, Logan Gunthorpe wrote:
>>>>
>>>>
>>>> On 2019-07-25 11:50 a.m., Matthew Wilcox wrote:
>>>>> On Thu, Jul 25, 2019 at 11:23:23AM -0600, Logan Gunthorpe wrote:
>>>>>> nvme_get_by_path() is analagous to blkdev_get_by_path() except it
>>>>>> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
>>>>>>
>>>>>> The purpose of this function is to support NVMe-OF target passthru.
>>>>>
>>>>> I can't find anywhere that you use this in this patchset.
>>>>>
>>>>
>>>> Oh sorry, the commit message is out of date the function was actually
>>>> called nvme_ctrl_get_by_path() and it's used in Patch 10.
>>>
>>> Instead of by path, could we have configfs take something else, like
>>> the unique controller instance or serial number? I know that's different
>>> than how we handle blocks and files, but that way nvme core can lookup
>>> the cooresponding controller without adding new cdev dependencies.
>>
>> Well the previous version of the patchset just used the ctrl name
>> ("nvme1") and looped through all the controllers to find a match. But
>> this sucks because of the inconsistency and the fact that the name can
>> change if hardware changes and the number changes. Allowing the user to
>> make use of standard udev rules seems important to me.
> 
> Should we then create a new udev rule for persistent controller
> names? /dev/nvme1 may not be the same controller each time you refer
> to it.

Udev can only create symlinks from /dev/nvme0 to
/dev/nvme-persistent-name and users can do this as they need now. No
changes needed.

My point was if we use the ctrl name (nvme0) as a reference then the
kernel can't make use of these symlinks or anything udev does seeing
that name is internal to the kernel only.

If we use cdev_get_by_path()/nvme_ctrl_get_by_path() then this isn't a
problem as we can open a symlink to /dev/nvme0 without any issues.

Logan

