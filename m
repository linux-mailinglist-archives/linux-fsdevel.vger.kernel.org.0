Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F6E756A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 20:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfGYSPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 14:15:05 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40934 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfGYSPF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:15:05 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqiGB-0002Q2-AE; Thu, 25 Jul 2019 12:14:36 -0600
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
Date:   Thu, 25 Jul 2019 12:14:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725180816.GA32305@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: viro@zeniv.linux.org.uk, sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
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



On 2019-07-25 12:08 p.m., Greg Kroah-Hartman wrote:
> On Thu, Jul 25, 2019 at 11:53:20AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2019-07-25 11:40 a.m., Greg Kroah-Hartman wrote:
>>> On Thu, Jul 25, 2019 at 11:23:21AM -0600, Logan Gunthorpe wrote:
>>>> cdev_get_by_path() attempts to retrieve a struct cdev from
>>>> a path name. It is analagous to blkdev_get_by_path().
>>>>
>>>> This will be necessary to create a nvme_ctrl_get_by_path()to
>>>> support NVMe-OF passthru.
>>>
>>> Ick, why?  Why would a cdev have a "pathname"?
>>
>> So we can go from "/dev/nvme0" (which points to a char device) to its
>> struct cdev and eventually it's struct nvme_ctrl. Doing it this way also
>> allows supporting symlinks that might be created by udev rules.
> 
> Why do you have a "string" within the kernel and are not using the
> normal open() call from userspace on the character device node on the
> filesystem in your namespace/mount/whatever?

NVMe-OF is configured using configfs. The target is specified by the
user writing a path to a configfs attribute. This is the way it works
today but with blkdev_get_by_path()[1]. For the passthru code, we need
to get a nvme_ctrl instead of a block_device, but the principal is the same.

> Where is this random string coming from?  

configfs

> Why is this so special that no
> one else has ever needed it?

People have needed the same functionality for block devices and
blkdev_get_by_path() has multiple users (iscsi, drbd, nvme-of, etc)
which are doing similar things. Nobody has needed to do the same with a
chardev until we wanted the NVMe-of to support targeting an NVMe
controller which is represented in userspace by a char device.

Logan


[1]
https://elixir.bootlin.com/linux/latest/source/drivers/nvme/target/io-cmd-bdev.c#L15
