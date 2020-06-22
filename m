Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B26202DED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 02:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgFVAcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 20:32:22 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57844 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726407AbgFVAcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 20:32:22 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0804D82229B;
        Mon, 22 Jun 2020 10:32:17 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jnANj-0001RI-85; Mon, 22 Jun 2020 10:32:15 +1000
Date:   Mon, 22 Jun 2020 10:32:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        agruenba@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200622003215.GC2040@dread.disaster.area>
References: <20200619155036.GZ8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619155036.GZ8681@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=0py_wnm_iWKtagbpVocA:9 a=p7nhVbAf7fyorWVF:21 a=KqMQ5NIseWXE2gGM:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 08:50:36AM -0700, Matthew Wilcox wrote:
> 
> This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> The advantage of this patch is that we can avoid taking any filesystem
> lock, as long as the pages being accessed are in the cache (and we don't
> need to readahead any pages into the cache).  We also avoid an indirect
> function call in these cases.

What does this micro-optimisation actually gain us except for more
complexity in the IO path?

i.e. if a filesystem lock has such massive overhead that it slows
down the cached readahead path in production workloads, then that's
something the filesystem needs to address, not unconditionally
bypass the filesystem before the IO gets anywhere near it.

> This could go horribly wrong if filesystems rely on doing work in their
> ->read_iter implementation (eg checking i_size after acquiring their
> lock) instead of keeping the page cache uptodate.  On the other hand,
> the ->map_pages() method is already called without locks, so filesystems
> should already be prepared for this.

Oh, gawd, we have *yet another* unlocked page cache read path that
can race with invalidations during fallocate() operations?

/me goes and looks at filemap_map_pages()

Yup, filemap_map_pages() is only safe against invalidations beyond
EOF (i.e. truncate) and can still race with invalidations within
EOF. So, yes, I'm right in that this path is not safe to run without
filesystem locking to serialise the IO against fallocate()...

Darrick, it looks like we need to wrap filemap_map_pages() with the
XFS_MMAPLOCK_SHARED like we do for all the other page fault paths
that can call into the IO path.

> Arguably we could do something similar for writes.  I'm a little more
> scared of that patch since filesystems are more likely to want to do
> things to keep their fies in sync for writes.

Please, no.  We can have uptodate cached pages over holes, unwritten
extents, shared extents, etc but they all require filesystem level
serialisation and space/block allocation work *before* we copy data
into the page. i.e. if allocation/space reservation fails, we need
to abort before changing data.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
