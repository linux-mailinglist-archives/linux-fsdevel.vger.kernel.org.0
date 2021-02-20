Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD96320673
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBTRim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 12:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTRil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 12:38:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF41C061574;
        Sat, 20 Feb 2021 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ncte2IIQTeBtTyvUJS/06d8GB/UyYxf4MK1I86Ykfdg=; b=WHSmTU/+aeltzFU2z1bHDTHrOX
        x+6nt/0qPi5tEnpS2rLDQR7aG25ogU50uzXjlDuFqObweO3e66UnWdTwzc/VeCUoDnsR0Yg05IUVz
        qKja4x36gCYsSIkMjxs3K0eCChqiLjBKDTSyoMDzKNxTSjp+Jzfr5p8VvISV5KUuhRPe+YtgAhIql
        kJf6C/FZopt3SHEpq9xNPi3JJ6m299a50q92TuVifbZ+M5EfN9VJVLNHgKYBsU8HyM2wRnwa5zhbJ
        AQjCHFQjF8Tskgm9rvY6ZnLR9ypqhcrzk1QkHGyktm3AdSe4gFZE9Q4fQ4/bEgPAw+PlFWeu0anNd
        Wfk8BSyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDWAn-004H31-V2; Sat, 20 Feb 2021 17:36:25 +0000
Date:   Sat, 20 Feb 2021 17:36:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [BUG] page allocation failure reading procfs ipv6 configuration
 files with cgroups
Message-ID: <20210220173605.GD2858050@casper.infradead.org>
References: <d2d3e617-17bf-8d43-f4a2-e4a7a2d421bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2d3e617-17bf-8d43-f4a2-e4a7a2d421bd@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 12:29:18PM -0500, Peter Geis wrote:
> Good Afternoon,
> 
> I have been tracking down a regular bug that triggers when running OpenWRT in a lxd container.
> Every ten minutes I was greeted with the following splat in the kernel log:
> 
> [2122311.383389] warn_alloc: 3 callbacks suppressed
> [2122311.383403] cat: page allocation failure: order:5, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=lxc.payload.openwrt,mems_allowed=0

You want this patch:

https://lore.kernel.org/linux-fsdevel/6345270a2c1160b89dd5e6715461f388176899d1.1612972413.git.josef@toxicpanda.com/
