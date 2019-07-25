Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31ACE75BB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 01:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGYXzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 19:55:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57542 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfGYXzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:55:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqnZe-0004a0-QJ; Thu, 25 Jul 2019 23:55:02 +0000
Date:   Fri, 26 Jul 2019 00:55:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190725235502.GJ1131@ZenIV.linux.org.uk>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425dd2ac-333d-a8c4-ce49-870c8dadf436@deltatee.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 01:24:22PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 1:11 p.m., Matthew Wilcox wrote:
> > On Thu, Jul 25, 2019 at 12:05:29PM -0700, Sagi Grimberg wrote:
> >>
> >>>>> NVMe-OF is configured using configfs. The target is specified by the
> >>>>> user writing a path to a configfs attribute. This is the way it works
> >>>>> today but with blkdev_get_by_path()[1]. For the passthru code, we need
> >>>>> to get a nvme_ctrl instead of a block_device, but the principal is the same.
> >>>>
> >>>> Why isn't a fd being passed in there instead of a random string?
> >>>
> >>> I suppose we could echo a string of the file descriptor number there,
> >>> and look up the fd in the process' file descriptor table ...
> >>
> >> Assuming that there is a open handle somewhere out there...
> 
> Yes, that would be a step backwards from an interface. The user would
> then need a special process to open the fd and pass it through configfs.
> They couldn't just do it with basic bash commands.

First of all, they can, but... WTF not have filp_open() done right there?
Yes, by name.  With permission checks done.  And pick your object from the
sodding struct file you'll get.

What's the problem?  Why do you need cdev lookups, etc., when you are
dealing with files under your full control?  Just open them and use
->private_data or whatever you set in ->open() to access the damn thing.
All there is to it...
