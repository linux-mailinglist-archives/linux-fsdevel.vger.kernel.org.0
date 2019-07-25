Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4297569F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfGYSKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 14:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfGYSKo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:10:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B9FB218F0;
        Thu, 25 Jul 2019 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564078243;
        bh=x+ORaQJeKgS3j+rdkVUxb78f2fEXbMS5Q2oS/qDLRjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2WeOieaFmoBq89MT9udtoPLN34+nsgmch91w02bA4td9R4/cEQgRmb7lZhWMKW1A
         l5E5M61NIfcaDSZmsX37Wv5yAHX5Z7sMH2djshb0kxmJJL84DUzaGilW0Pbc17ey6w
         pJsVMG1J1e8yqgwBOfIg8z9YWW7vfgCEpiGsOkWQ=
Date:   Thu, 25 Jul 2019 20:10:41 +0200
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
Message-ID: <20190725181041.GB32305@kroah.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:53:20AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 11:40 a.m., Greg Kroah-Hartman wrote:
> > On Thu, Jul 25, 2019 at 11:23:21AM -0600, Logan Gunthorpe wrote:
> >> cdev_get_by_path() attempts to retrieve a struct cdev from
> >> a path name. It is analagous to blkdev_get_by_path().
> >>
> >> This will be necessary to create a nvme_ctrl_get_by_path()to
> >> support NVMe-OF passthru.
> > 
> > Ick, why?  Why would a cdev have a "pathname"?
> 
> So we can go from "/dev/nvme0" (which points to a char device) to its
> struct cdev and eventually it's struct nvme_ctrl. Doing it this way also
> allows supporting symlinks that might be created by udev rules.
> 
> This is very similar to blkdev_get_by_path() that lets regular NVMe-OF
> obtain the struct block_device from a path.
> 
> I didn't think this would be all that controversial.
> 
> > What is "NVMe-OF passthru"?  Why does a char device node have anything
> > to do with NVMe?
> 
> NVME-OF passthru is support for NVME over fabrics to directly target a
> regular NVMe controller and thus export an entire NVMe device to a
> remote system. We need to be able to tell the kernel which controller to
> use and IMO a path to the device file is the best way as it allows us to
> support symlinks created by udev.

open() in userspace handles symlinks just fine, what crazy interface
passes a string to try to find a char device node that is not open()?

And why do you need a char device at all anyway?  Is this just the
"normal" nvme controller's character device node?

> > We have way too many ways to abuse cdevs today, my long-term-wish has
> > always been to clean this interface up to make it more sane and unified,
> > and get rid of the "outliers" (all created at the time for a good
> > reason, that's not the problem.)  But to add "just one more" seems
> > really odd to me.
> 
> Well it doesn't seem all that much like an outlier to me.

Everyone is special, just like everyone else :)

Seriously, as no one else has ever needed this, you are an outlier.

thanks,

greg k-h
