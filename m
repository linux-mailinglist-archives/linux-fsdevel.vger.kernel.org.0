Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4BB4099E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhIMQsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 12:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239346AbhIMQr4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:47:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E458960F25;
        Mon, 13 Sep 2021 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631551600;
        bh=1uB4QHUGCkCsNFzemazlCmu8yy4iTK1hIJ9NSZdlZxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0EW8/jTA7YqPKLBfaB2N/q3jPt5mZvK+1GIfSbQDlznFmX0+naTsPce2P51dQYWc
         GCnViXHj6DMql8nAaOWKw6ZSVAKP96QjD2GM7kGzZgAZ1jYHfErir0pThG+Hcx9nYF
         9hEbDmI3d+1i3iw+Jv5JJwFIc8om4/aUyQ6zFXFs=
Date:   Mon, 13 Sep 2021 18:46:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: start switching sysfs attributes to expose the seq_file
Message-ID: <YT+AbumufeL6nRss@kroah.com>
References: <20210913054121.616001-1-hch@lst.de>
 <21413ac5-f934-efe2-25ee-115c4dcc86a5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21413ac5-f934-efe2-25ee-115c4dcc86a5@acm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 09:39:56AM -0700, Bart Van Assche wrote:
> On 9/12/21 10:41 PM, Christoph Hellwig wrote:
> > Al pointed out multiple times that seq_get_buf is highly dangerous as
> > it opens up the tight seq_file abstractions to buffer overflows.  The
> > last such caller now is sysfs.
> > 
> > This series allows attributes to implement a seq_show method and switch
> > the block and XFS code as users that I'm most familiar with to use
> > seq_files directly after a few preparatory cleanups.  With this series
> > "leaf" users of sysfs_ops can be converted one at at a time, after that
> > we can move the seq_get_buf into the multiplexers (e.g. kobj, device,
> > class attributes) and remove the show method in sysfs_ops and repeat the
> > process until all attributes are converted.  This will probably take a
> > fair amount of time.
> 
> Hi Christoph,
> 
> Thanks for having done this work. In case you would need it, some time ago
> I posted the following sysfs patch but did not receive any feedback:
> "[PATCH] kernfs: Improve lockdep annotation for files which implement mmap"
> (https://lore.kernel.org/linux-kernel/20191004161124.111376-1-bvanassche@acm.org/).
> 

That was from back in 2019, sorry I must have missed it.

Care to rebase and resend it if it is still needed?

thanks,

greg k-h
