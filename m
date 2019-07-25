Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA01C757F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGYTeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGYTeS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:34:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1FDC218EA;
        Thu, 25 Jul 2019 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564083257;
        bh=XmYuwxHf0VVKO+yWC7+GNQPhvgKyB5pGg9W5noBtV5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3PTiS9N52mYF5DGcUuY4yOnuzZS4zliBNIktBb8T/57DhVRGzhaH7j5HmmWgnryx
         C9l2UR21v5CIglf+hjNiv28E1LxVTEO0pmbHVRsvvVILqePuJLvSGSQ2VGdYSU4UX3
         7o7ICHpuPnOeHJyd0e42GVoe16EdvBsM6kt32IU8=
Date:   Thu, 25 Jul 2019 21:34:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190725193415.GA12117@kroah.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <a3262a7f-b78e-05ba-cda3-a7587946bd91@deltatee.com>
 <5951e0f5-cc90-f3de-0083-088fecfd43bb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5951e0f5-cc90-f3de-0083-088fecfd43bb@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:02:30PM -0700, Sagi Grimberg wrote:
> 
> > > > > Why do you have a "string" within the kernel and are not using the
> > > > > normal open() call from userspace on the character device node on the
> > > > > filesystem in your namespace/mount/whatever?
> > > > 
> > > > NVMe-OF is configured using configfs. The target is specified by the
> > > > user writing a path to a configfs attribute. This is the way it works
> > > > today but with blkdev_get_by_path()[1]. For the passthru code, we need
> > > > to get a nvme_ctrl instead of a block_device, but the principal is the same.
> > > 
> > > Why isn't a fd being passed in there instead of a random string?
> > 
> > I wouldn't know the answer to this but I assume because once we decided
> > to use configfs, there was no way for the user to pass the kernel an fd.
> 
> That's definitely not changing. But this is not different than how we
> use the block device or file configuration, this just happen to need the
> nvme controller chardev now to issue I/O.

So, as was kind of alluded to in another part of the thread, what are
you doing about permissions?  It seems that any user/group permissions
are out the window when you have the kernel itself do the opening of the
char device, right?  Why is that ok?  You can pass it _any_ character
device node and away it goes?  What if you give it a "wrong" one?  Char
devices are very different from block devices this way.

thanks,

greg k-h
