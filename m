Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6474331FA7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 15:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhBSOXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 09:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSOXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:23:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CC3C061574;
        Fri, 19 Feb 2021 06:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wz2Nx7ok9lIMmSB/ZDAfj7FZQpYP3BsNpceZvExmG8g=; b=oJ27mjRsxdwn++86shGQQ0Ca8/
        OuU2704ESLy2oaUOwstVOYpQPuKy/GEixxBwJx00zH0W7fjw20AY63bV65/Oa0ur4NyzjoWasYihe
        t4ko8q6a7kGbySkINIkluQrF/ux1c4t4e/wB3a/MW1KwL/zxKbfsY5U0mIIkMesz1qtsOPrBSOBBW
        SMcPJ2PPdtR2JZSleCxBfkjuN+Fh2QMx7pYzOtDRsL24S1PJRL2Y2HFEFkZXV19sewaSQD1SyOorw
        21itSWWa8cC/GBLC1dL9BJhUYPs2lMJjckRrI/O6Oz4Akkm1lLkBNyEuPVOuDzs98bdC6jUH7g+Ky
        zV9MigZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lD6fR-002xwD-Bj; Fri, 19 Feb 2021 14:22:27 +0000
Date:   Fri, 19 Feb 2021 14:22:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210219142201.GU2858050@casper.infradead.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <927c018f-c951-c44c-698b-cb76d15d67bb@rkjnsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927c018f-c951-c44c-698b-cb76d15d67bb@rkjnsn.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 01:27:09PM -0800, Erik Jensen wrote:
> On 2/18/21 4:15 AM, Matthew Wilcox wrote:
> 
> > On Thu, Feb 18, 2021 at 04:54:46PM +0800, Qu Wenruo wrote:
> > > Recently we got a strange bug report that, one 32bit systems like armv6
> > > or non-64bit x86, certain large btrfs can't be mounted.
> > > 
> > > It turns out that, since page->index is just unsigned long, and on 32bit
> > > systemts, that can just be 32bit.
> > > 
> > > And when filesystems is utilizing any page offset over 4T, page->index
> > > get truncated, causing various problems.
> > 4TB?  I think you mean 16TB (4kB * 4GB)
> > 
> > Yes, this is a known limitation.  Some vendors have gone to the trouble
> > of introducing a new page_index_t.  I'm not convinced this is a problem
> > worth solving.  There are very few 32-bit systems with this much storage
> > on a single partition (everything should work fine if you take a 20TB
> > drive and partition it into two 10TB partitions).
> For what it's worth, I'm the reporter of the original bug. My use case is a
> custom NAS system. It runs on a 32-bit ARM processor, and has 5 8TB drives,
> which I'd like to use as a single, unified storage array. I chose btrfs for
> this project due to the filesystem-integrated snapshots and checksums.
> Currently, I'm working around this issue by exporting the raw drives using
> nbd and mounting them on a 64-bit system to access the filesystem, but this
> is very inconvenient, only allows one machine to access the filesystem at a
> time, and prevents running any tools that need access to the filesystem
> (such as backup and file sync utilities) on the NAS itself.
> 
> It sounds like this limitation would also prevent me from trying to use a
> different filesystem on top of software RAID, since in that case the logical
> filesystem would still be over 16TB.
> 
> > As usual, the best solution is for people to stop buying 32-bit systems.
> I purchased this device in 2018, so it's not exactly ancient. At the time,
> it was the only SBC I could find that was low power, used ECC RAM, had a
> crypto accelerator, and had multiple sata ports with port-multiplier
> support.

I'm sorry you bought unsupported hardware.

This limitation has been known since at least 2009:
https://lore.kernel.org/lkml/19041.4714.686158.130252@notabene.brown/

In the last decade, nobody's tried to fix it in mainline that I know of.
As I said, some vendors have tried to fix it in their NAS products,
but I don't know where to find that patch any more.

https://bootlin.com/blog/large-page-support-for-nas-systems-on-32-bit-arm/
might help you, but btrfs might still contain assumptions that will trip
you up.
