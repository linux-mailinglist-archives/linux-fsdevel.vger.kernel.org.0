Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D128756DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfGYS1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 14:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfGYS1E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:27:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B1E21734;
        Thu, 25 Jul 2019 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564079223;
        bh=9oxP8U7mgBf002tZ4PZF1DTXox9G1gTALMrim3Fxlzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFiFUxV/mTzC0oYE/9gO+4Kzsb/cAklpqkUhHQk/LwGLxSlItD8NE0NBPPS7Ns0w4
         3ziwO1uqTtc1FkaqiR6f6sxhrnI5VA57r/bWofYojvWM9sxJoi7U4ssXrERo0HvAI2
         qRUSkN4RRXttJU3Jv5n6moYPaH5huZ+n2lotiQE4=
Date:   Thu, 25 Jul 2019 20:27:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190725182701.GA11547@kroah.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:14:33PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 12:08 p.m., Greg Kroah-Hartman wrote:
> > On Thu, Jul 25, 2019 at 11:53:20AM -0600, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2019-07-25 11:40 a.m., Greg Kroah-Hartman wrote:
> >>> On Thu, Jul 25, 2019 at 11:23:21AM -0600, Logan Gunthorpe wrote:
> >>>> cdev_get_by_path() attempts to retrieve a struct cdev from
> >>>> a path name. It is analagous to blkdev_get_by_path().
> >>>>
> >>>> This will be necessary to create a nvme_ctrl_get_by_path()to
> >>>> support NVMe-OF passthru.
> >>>
> >>> Ick, why?  Why would a cdev have a "pathname"?
> >>
> >> So we can go from "/dev/nvme0" (which points to a char device) to its
> >> struct cdev and eventually it's struct nvme_ctrl. Doing it this way also
> >> allows supporting symlinks that might be created by udev rules.
> > 
> > Why do you have a "string" within the kernel and are not using the
> > normal open() call from userspace on the character device node on the
> > filesystem in your namespace/mount/whatever?
> 
> NVMe-OF is configured using configfs. The target is specified by the
> user writing a path to a configfs attribute. This is the way it works
> today but with blkdev_get_by_path()[1]. For the passthru code, we need
> to get a nvme_ctrl instead of a block_device, but the principal is the same.

Why isn't a fd being passed in there instead of a random string?

Seems odd, but oh well, that ship sailed a long time ago for block
devices I guess.

So what do you actually _do_ with that char device once you have it?

greg k-h
