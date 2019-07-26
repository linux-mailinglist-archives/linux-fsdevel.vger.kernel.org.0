Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D875F84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGZHNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 03:13:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZHNx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:13:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE3D21852;
        Fri, 26 Jul 2019 07:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564125232;
        bh=VrTKOPYQ4HevC0cVrTz5SGKbFtEejWwaJ8pBbPkg/j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huB1ORI4N12VUC0fNW6uNLHOn5vLfWYsWaRC+/e3+uBS4MBhu+NXCvAz2Tj+aExM0
         cNbramMdyLsieqUEcwnT0gsWasve8Q33uTxStleFq9aiEtuV/RQT3XsYj9eePkyFpp
         ZqxmsodmlPazTR0Ka52GZ7RJRe8oFIg/+sBS0eWk=
Date:   Fri, 26 Jul 2019 09:13:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190726071349.GA16265@kroah.com>
References: <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
 <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
 <20190725191124.GE30641@bombadil.infradead.org>
 <425dd2ac-333d-a8c4-ce49-870c8dadf436@deltatee.com>
 <20190725235502.GJ1131@ZenIV.linux.org.uk>
 <7f48a40c-6e0f-2545-a939-45fc10862dfd@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f48a40c-6e0f-2545-a939-45fc10862dfd@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:29:40PM -0700, Sagi Grimberg wrote:
> 
> > > > > > > > NVMe-OF is configured using configfs. The target is specified by the
> > > > > > > > user writing a path to a configfs attribute. This is the way it works
> > > > > > > > today but with blkdev_get_by_path()[1]. For the passthru code, we need
> > > > > > > > to get a nvme_ctrl instead of a block_device, but the principal is the same.
> > > > > > > 
> > > > > > > Why isn't a fd being passed in there instead of a random string?
> > > > > > 
> > > > > > I suppose we could echo a string of the file descriptor number there,
> > > > > > and look up the fd in the process' file descriptor table ...
> > > > > 
> > > > > Assuming that there is a open handle somewhere out there...
> > > 
> > > Yes, that would be a step backwards from an interface. The user would
> > > then need a special process to open the fd and pass it through configfs.
> > > They couldn't just do it with basic bash commands.
> > 
> > First of all, they can, but... WTF not have filp_open() done right there?
> > Yes, by name.  With permission checks done.  And pick your object from the
> > sodding struct file you'll get.
> > 
> > What's the problem?  Why do you need cdev lookups, etc., when you are
> > dealing with files under your full control?  Just open them and use
> > ->private_data or whatever you set in ->open() to access the damn thing.
> > All there is to it...
> Oh this is so much simpler. There is really no point in using anything
> else. Just need to remember to compare f->f_op to what we expect to make
> sure that it is indeed the same device class.

That is good, that solves the "/dev/random/" issue I was talking about
earlier as well.

Odds are you all can do the same for the blockdev interface as well.

thanks,

greg k-h
