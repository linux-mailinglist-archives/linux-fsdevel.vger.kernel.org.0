Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E8D7579D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfGYTLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:11:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NZgArJ4A0rpRQ2joOKkTtaW1dVOFPQo4qCltbvtRjM0=; b=k6oy9kzv+K54qnV0e8oy+G/G+
        1D2KwDE/vwlTF/3p+8yfyLo5EYeB5rWN7JTp/UCF5yw8ni5L76UvzuQp7ukje5XUPRDiX+Odgz5sf
        PN9Rjw8eL0qYyLSCy/nX6alOZy3oFHlWDt3MTE2kyU86O0PL6nuQkDXJS0CJoC0ffOVm0pkVe5687
        LXpoSDmF4mHpFgp8FtWIewV7cTVpNEFVJLLm9Ivg00/D4nuJSBcsX1vgCAkyGoiSPyFFFO1tqGYIN
        9g9HwW+d/0J0Zy7HB6HtHV+biDDu/DX7tsSA1TbElJ0S/I3CaP/9v477akFFDlHppKjEsbuOq2Wsg
        DmLS72UuQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqj9B-0005NS-Ma; Thu, 25 Jul 2019 19:11:25 +0000
Date:   Thu, 25 Jul 2019 12:11:25 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190725191124.GE30641@bombadil.infradead.org>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
 <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:05:29PM -0700, Sagi Grimberg wrote:
> 
> > > > NVMe-OF is configured using configfs. The target is specified by the
> > > > user writing a path to a configfs attribute. This is the way it works
> > > > today but with blkdev_get_by_path()[1]. For the passthru code, we need
> > > > to get a nvme_ctrl instead of a block_device, but the principal is the same.
> > > 
> > > Why isn't a fd being passed in there instead of a random string?
> > 
> > I suppose we could echo a string of the file descriptor number there,
> > and look up the fd in the process' file descriptor table ...
> 
> Assuming that there is a open handle somewhere out there...

Well, that's how we'd know that the application echoing /dev/nvme3 into
configfs actually has permission to access /dev/nvme3.  Think about
containers, for example.  It's not exactly safe to mount configfs in a
non-root container since it can access any NVMe device in the system,
not just ones which it's been given permission to access.  Right?
