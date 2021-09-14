Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5400F40B34D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhINPnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 11:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234803AbhINPm5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:42:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CD3A60E9B;
        Tue, 14 Sep 2021 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631634099;
        bh=V6SyrZ3vPVHh40d+w/uevjVMUXwmNmk4y04a1VhSuNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMsNilTIuECmzmoxX++29DydrSWX03iJ65SmrVPT0kvIf75zOd6/O+QOvp4m4hLSD
         7J1Usmf/DbcoyV7w7RYk9WKK6qCxjjSjVCMXpiAx8Kkl6/J3Jz/J+OjyOGSl8sUHkN
         1VKuQGCf1ViTtBu0RQEflFYd76oJdVBPoZWOng/4=
Date:   Tue, 14 Sep 2021 17:41:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <YUDCsXXNFfUyiMCk@kroah.com>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-14-hch@lst.de>
 <YT7vZthsMCM1uKxm@kroah.com>
 <20210914073003.GA31077@lst.de>
 <YUC/iH9yLlxblM09@kroah.com>
 <20210914153011.GA815@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914153011.GA815@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:30:11PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 14, 2021 at 05:28:08PM +0200, Greg Kroah-Hartman wrote:
> > We can "force" it by not allowing buffers to be bigger than that, which
> > is what the code has always done.  I think we want to keep that for now
> > and not add the new seq_show api.
> 
> The buffer already is not larger than that.  The problem is that
> sysfs_emit does not actually work for the non-trivial attributes,
> which generally are the source of bugs.

They huge majority of sysfs attributes are "trivial".  So for maybe at
least 95% of the users, if not more, using sysfs_emit() is just fine as
all you "should" be doing is emitting a single value.

For those that are non-trivial, yes, that will be harder, but as the xfs
discussion shows, those are not normal at all, and I do not want to make
creating them easier as that is not the model that sysfs was designed
for if at all possible.

thanks,

greg k-h
