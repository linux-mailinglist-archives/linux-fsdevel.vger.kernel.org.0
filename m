Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847D47564C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfGYRxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 13:53:40 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40494 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbfGYRxk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:53:40 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqhvg-0001pD-6S; Thu, 25 Jul 2019 11:53:25 -0600
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
Date:   Thu, 25 Jul 2019 11:53:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725174032.GA27818@kroah.com>
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



On 2019-07-25 11:40 a.m., Greg Kroah-Hartman wrote:
> On Thu, Jul 25, 2019 at 11:23:21AM -0600, Logan Gunthorpe wrote:
>> cdev_get_by_path() attempts to retrieve a struct cdev from
>> a path name. It is analagous to blkdev_get_by_path().
>>
>> This will be necessary to create a nvme_ctrl_get_by_path()to
>> support NVMe-OF passthru.
> 
> Ick, why?  Why would a cdev have a "pathname"?

So we can go from "/dev/nvme0" (which points to a char device) to its
struct cdev and eventually it's struct nvme_ctrl. Doing it this way also
allows supporting symlinks that might be created by udev rules.

This is very similar to blkdev_get_by_path() that lets regular NVMe-OF
obtain the struct block_device from a path.

I didn't think this would be all that controversial.

> What is "NVMe-OF passthru"?  Why does a char device node have anything
> to do with NVMe?

NVME-OF passthru is support for NVME over fabrics to directly target a
regular NVMe controller and thus export an entire NVMe device to a
remote system. We need to be able to tell the kernel which controller to
use and IMO a path to the device file is the best way as it allows us to
support symlinks created by udev.

> We have way too many ways to abuse cdevs today, my long-term-wish has
> always been to clean this interface up to make it more sane and unified,
> and get rid of the "outliers" (all created at the time for a good
> reason, that's not the problem.)  But to add "just one more" seems
> really odd to me.

Well it doesn't seem all that much like an outlier to me.

Logan
