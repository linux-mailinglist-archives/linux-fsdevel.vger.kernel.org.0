Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA5840B309
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhINP32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 11:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233202AbhINP32 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:29:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3706460234;
        Tue, 14 Sep 2021 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631633290;
        bh=uIk3pIzYCj67iKBpiYBKsYeqo7a5UjJ13ORlR6ji/Kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jox5mamjWIxKYyEisZVncK1fTvx+5gWa1WND1w4SoytDRknTu9MYjxjTEnG+mhOv+
         0XUnGtNOHzMT2NlfWzzFfv5ploG8qeiY883t2qP8WCy5soxs7BaIwDPaes1YFaPdxo
         C9qeh3acGxvxRIpViddaJuziiuwiq+ZeiFav7m4s=
Date:   Tue, 14 Sep 2021 17:28:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <YUC/iH9yLlxblM09@kroah.com>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-14-hch@lst.de>
 <YT7vZthsMCM1uKxm@kroah.com>
 <20210914073003.GA31077@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914073003.GA31077@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 09:30:03AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 13, 2021 at 08:27:50AM +0200, Greg Kroah-Hartman wrote:
> > Anyway, I like the idea, but as you can see here, it could lead to even
> > more abuse of sysfs files.  We are just now getting people to use
> > sysfs_emit() and that is showing us where people have been abusing the
> > api in bad ways.
> 
> To be honest I've always seen sysfs_emit as at best a horrible band aid
> to enforce the PAGE_SIZE bounds checking.  Better than nothing, but
> not a solution at all, as you can't force anyone to actually use it.

We can "force" it by not allowing buffers to be bigger than that, which
is what the code has always done.  I think we want to keep that for now
and not add the new seq_show api.

I've taken patches 2-6 in this series now, as those were great sysfs
and kernfs cleanups, thanks for those.

I can also take patch 1 if no one objects (I can edit the typo.)

I agree that getting rid of seq_get_buf() is good, and can work on
getting rid of the use here in sysfs if it's annoying people.

thanks,

greg k-h
