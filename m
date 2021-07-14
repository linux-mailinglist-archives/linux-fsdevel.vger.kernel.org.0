Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3E3C801A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 10:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhGNIdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 04:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238501AbhGNIdo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:33:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A755B600CD;
        Wed, 14 Jul 2021 08:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626251453;
        bh=euppiBAb1TCaHtHEZSN+NxnO0d8QDKvdtQRCg2BVPrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lh2cjcPcCavHb3Byn/tLJ/CeIVuK+V3kYIvfDkhfFT6BJ0TzwcUAJ1F3F5phnas/4
         HaXaDTSMPP+AOkeaIJce8hWJFIoqlyIexDkiBN1NJ2lX2SqTYKXNfm5KQV3HeXYBiR
         udU347oWlmR+yqdu5r70BdWGSHr/xsCtmzDNWzOur3EagUuGCKC6jxFCc5WSe6waGU
         26sTm2LXqBrrCaAfjebEsfCulXE85OSFQ5FC8BQoJnsm76hkN9ZHphUvobRj4hfBhI
         7bCNzhGQupS+bgcgDOfduYzma5J6lutelJXv/vwFrbJXQjnXf+PnF1TyhqfQBfig7L
         XVajDNs112abw==
Date:   Wed, 14 Jul 2021 11:30:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanko Kaneti <yaneti@declera.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [5.14-rc1 regression] 7fe1e79b59ba configfs: implement the
 .read_iter and .write_iter methods - affects targetcli restore
Message-ID: <YO6guXuG5fTfCxZ1@unreal>
References: <9e3b381a04fd7f7dfbf5e2395d127ab4ef554f99.camel@declera.com>
 <070508e7-d7d1-cec7-8dda-28dca3dc2f63@acm.org>
 <YO6DenDIUy0I3fXh@unreal>
 <cd770f435008ef80fbd7193f5e79cc48dae0d480.camel@declera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd770f435008ef80fbd7193f5e79cc48dae0d480.camel@declera.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 11:11:52AM +0300, Yanko Kaneti wrote:
> On Wed, 2021-07-14 at 09:26 +0300, Leon Romanovsky wrote:
> > On Mon, Jul 12, 2021 at 05:35:16PM -0700, Bart Van Assche wrote:
> > > On 7/12/21 12:10 PM, Yanko Kaneti wrote:
> > > > Bisected a problem that I have with targetcli restore to:
> > > > 
> > > > 7fe1e79b59ba configfs: implement the .read_iter and .write_iter methods
> > > > 
> > > > With it reads of /sys/kernel/config/target/dbroot  go on infinitely,
> > > > returning  the config value over and over again.
> > > > 
> > > > e.g.
> > > > 
> > > > $ modprobe target_core_user
> > > > $ head -n 2 /sys/kernel/config/target/dbroot
> > > > /etc/target
> > > > /etc/target
> > > > 
> > > > Don't know if that's a problem with the commit or the target code, but
> > > > could perhaps be affecting other places.
> > > 
> > > The dbroot show method looks fine to me:
> > > 
> > > static ssize_t target_core_item_dbroot_show(struct config_item *item,
> > > 					    char *page)
> > > {
> > > 	return sprintf(page, "%s\n", db_root);
> > > }
> > > 
> > > Anyway, I can reproduce this behavior. I will take a look at this.
> > 
> > The problem exists for all configs users, we (RDMA) experience the same
> > issue with default_roce_mode and default_roce_tos files.
> > 
> > The configfs_read_iter() doesn't indicate to the upper layer that it
> > should stop reread. In my case, the iov_iter_count(to) is equal to 131072,
> > which is huge comparable to real buffer->count.
> > 
> > ....
> > [  192.077873] configfs: configfs_read_iter: count = 131072, pos = 15880, buf = RoCE v2
> > [  192.078146] configfs: configfs_read_iter: count = 131072, pos = 15888, buf = RoCE v2
> > [  192.078510] configfs: configfs_read_iter: count = 131072, pos = 15896, buf = RoCE v2
> > ....
> 
> The fix Bart posted yesterday works for me here
> 
> https://git.infradead.org/users/hch/configfs.git/commit/420405ecde061fde76d67bd3a67577a563ea758e

Thanks a lot, I came mostly to the same fix.
