Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E789A3207A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 00:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBTXZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 18:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBTXYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 18:24:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B8C061574;
        Sat, 20 Feb 2021 15:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xnmiLm8tdpM9+Jk2sYnWQ2UbZ/lY3c2/h+Vei+isFXA=; b=OTAKTWtY1QKfL63r7IlXDDYKKj
        Oc+wPHCJJW6NIO4mmXNZnNJi7U2toSCHEpPaKvHiVEzI0tB10sxWr4peuOZDCTXbME/2fTofc/G/V
        MFrIpZObA8KezP8dXBhDKjLHsiplcpE9CMymaYSRBUUk2Hj22+vY7JkgsplReYcjwf9qfiXFOXh0g
        8j7tejpFx6rMLDXWQVJvARCcmT+7HmszJx/GmDZwCJWyuHd8seooEbvbaZGTnq11PMnKeSLgX05MG
        R4PNi3Mpp3Fkhbj3G9GhE1/KOVMWKDBdd+RXpeIaZn5ymeW71Z7F9tUwc6B0sO3wARf+Y5A68i18W
        3YtjMRTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDbZw-004aFP-5z; Sat, 20 Feb 2021 23:22:37 +0000
Date:   Sat, 20 Feb 2021 23:22:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210220232224.GF2858050@casper.infradead.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
 <b3e40749-a30d-521a-904f-8182c6d0e258@rkjnsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3e40749-a30d-521a-904f-8182c6d0e258@rkjnsn.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 03:02:26PM -0800, Erik Jensen wrote:
> On 2/18/21 5:39 AM, Matthew Wilcox wrote:
> > On Thu, Feb 18, 2021 at 08:42:14PM +0800, Qu Wenruo wrote:
> > > [...]
> > > BTW, what would be the extra cost by converting page::index to u64?
> > > I know tons of printk() would cause warning, but most 64bit systems
> > > should not be affected anyway.
> > 
> > No effect for 64-bit systems, other than the churn.
> > 
> > For 32-bit systems, it'd have some pretty horrible overhead.  You don't
> > just have to touch the page cache, you have to convert the XArray.
> > It's doable (I mean, it's been done), but it's very costly for all the
> > 32-bit systems which don't use a humongous filesystem.  And we could
> > minimise that overhead with a typedef, but then the source code gets
> > harder to work with.
> 
> Out of curiosity, would it be at all feasible to use 64-bits for the page
> offset *without* changing XArray, perhaps by indexing by the lower 32-bits,
> and evicting the page that's there if the top bits don't match (vaguely like
> how the CPU cache works)? Or, if there are cases where a page can't be
> evicted (I don't know if this can ever happen), use chaining?
> 
> I would expect index contention to be extremely uncommon, and it could only
> happen for inodes larger than 16 TiB, which can't be used at all today. I
> don't know how many data structures store page offsets today, but it seems
> like this should significantly reduce the performance impact versus upping
> XArray to 64-bit indexes.

Again, you're asking for significant development work for a dying
platform.

Did you try the bootlin patch?
