Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC6755E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 19:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfGYRkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 13:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfGYRkg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:40:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79AF422BE8;
        Thu, 25 Jul 2019 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564076435;
        bh=v5yXlm0ySbjH9KYVN6Nqcko2ymh4rZfsF2TdFPmyY7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cf0NrbzxwN1M9j7L43mP+u3u8SJKAyjDsM0cOYEdgJvIpWskctistAzocLZjDHkEN
         ba/45n2CQ0Z0Vu5YE8bZ1WQSq7k3lFsVvFslO0EgJItOxPoN3cpbF0XLhnLZMiHACv
         SqahQYWRTwQbD+2RwOPjk7Yu0qf8B7tBjUz8+4cA=
Date:   Thu, 25 Jul 2019 19:40:32 +0200
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
Message-ID: <20190725174032.GA27818@kroah.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725172335.6825-3-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:23:21AM -0600, Logan Gunthorpe wrote:
> cdev_get_by_path() attempts to retrieve a struct cdev from
> a path name. It is analagous to blkdev_get_by_path().
> 
> This will be necessary to create a nvme_ctrl_get_by_path()to
> support NVMe-OF passthru.

Ick, why?  Why would a cdev have a "pathname"?

What is "NVMe-OF passthru"?  Why does a char device node have anything
to do with NVMe?

We have way too many ways to abuse cdevs today, my long-term-wish has
always been to clean this interface up to make it more sane and unified,
and get rid of the "outliers" (all created at the time for a good
reason, that's not the problem.)  But to add "just one more" seems
really odd to me.

thanks,

greg k-h
