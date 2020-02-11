Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A66159D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 00:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgBKXom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 18:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgBKXom (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:44:42 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099E62070A;
        Tue, 11 Feb 2020 23:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581464679;
        bh=W4c9i/00+OtJRA6RYvyTVANvmlPmRkbl7HuwUCwLBIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gy5vZsucUuM1PKBvB9kViGEU0b/gfONXogIow6rQWkeafiuuquAX8xhsXk6Dm2kjk
         aDFAaHIulCLRA7ettmmWHza/yOXG1IXx2hpht0OCZF4FO/8r53o52twLJ5CRBlsFRU
         WyANiUs409HVXmI0frzjTFYdptz4wVzOzCWB2Ig0=
Date:   Tue, 11 Feb 2020 15:44:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Rik van Riel <riel@surriel.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-Id: <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
In-Reply-To: <20200211193101.GA178975@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
        <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
        <20200211193101.GA178975@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Feb 2020 14:31:01 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Tue, Feb 11, 2020 at 02:05:38PM -0500, Rik van Riel wrote:
> > On Tue, 2020-02-11 at 12:55 -0500, Johannes Weiner wrote:
> > > The VFS inode shrinker is currently allowed to reclaim inodes with
> > > populated page cache. As a result it can drop gigabytes of hot and
> > > active page cache on the floor without consulting the VM (recorded as
> > > "inodesteal" events in /proc/vmstat).
> > > 
> > > This causes real problems in practice. Consider for example how the
> > > VM
> > > would cache a source tree, such as the Linux git tree. As large parts
> > > of the checked out files and the object database are accessed
> > > repeatedly, the page cache holding this data gets moved to the active
> > > list, where it's fully (and indefinitely) insulated from one-off
> > > cache
> > > moving through the inactive list.
> > 
> > > This behavior of invalidating page cache from the inode shrinker goes
> > > back to even before the git import of the kernel tree. It may have
> > > been less noticeable when the VM itself didn't have real workingset
> > > protection, and floods of one-off cache would push out any active
> > > cache over time anyway. But the VM has come a long way since then and
> > > the inode shrinker is now actively subverting its caching strategy.
> > 
> > Two things come to mind when looking at this:
> > - highmem
> > - NUMA
> > 
> > IIRC one of the reasons reclaim is done in this way is
> > because a page cache page in one area of memory (highmem,
> > or a NUMA node) can end up pinning inode slab memory in
> > another memory area (normal zone, other NUMA node).
> 
> That's a good point, highmem does ring a bell now that you mention it.

Yup, that's why this mechanism exists.  Here:

https://marc.info/?l=git-commits-head&m=103646757213266&w=2

> If we still care, I think this could be solved by doing something
> similar to what we do with buffer_heads_over_limit: allow a lowmem
> allocation to reclaim page cache inside the highmem zone if the bhs
> (or inodes in this case) have accumulated excessively.

Well, reclaiming highmem pagecache at random would be a painful way to
reclaim lowmem inodes.  Better to pick an inode then shoot down all its
pagecache.  Perhaps we could take its pagecache's aging into account.

Testing this will be a challenge, but the issue was real - a 7GB
highmem machine isn't crazy and I expect the inode has become larger
since those days.

> AFAICS, we haven't done anything similar for NUMA, so it might not be
> much of a problem there. I could imagine this is in part because NUMA
> nodes tend to be more balanced in size, and the ratio between cache
> memory and inode/bh memory means that these objects won't turn into a
> significant externality. Whereas with extreme highmem:lowmem ratios,
> they can.
