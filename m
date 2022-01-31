Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C73E4A47DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 14:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378155AbiAaNP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 08:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiAaNP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:15:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BCBC061714;
        Mon, 31 Jan 2022 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ga26PmbdXqYDqvVXaK1iI74r5/HqT8MBfA8idE9wScU=; b=qXzilONXk19jBd4Ilqxk8QCaLJ
        7o0uoHrdjaLowius3SJRLCJnI3u6WzTJ5HK0+KN3ESSMH4OSh1zw8M/nLoowRK+BaqDrW8SWGeQef
        U1XvPUT6CcIwLNPB4LZNRc/9L3dj81xiZmBFhg9lXLYUWSifAyDYU72NWHAxo4/42BswWf8IE5s1L
        SVlqgKSXYwWxJGrJPmWTEVgjC9REqrYIcuiWw8TOcoD2viZVCm4zYWNQrN0x4RNtk1FUKOtA72DmN
        PPWwAAfVQ+Z8zfo+wlfsu3g+soPdEaycW6pwFjjYJrUCQsY7CuTIMIriPffKFxrtVtCF7nNxYklQp
        SZPJidEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEWX7-009t5N-NH; Mon, 31 Jan 2022 13:15:49 +0000
Date:   Mon, 31 Jan 2022 13:15:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nfs: remove reliance on bdi congestion
Message-ID: <YffhBYZ+6pgWeF71@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
 <164360183350.4233.691070075155620959.stgit@noble.brown>
 <YfdkCsxyu0jpo+98@casper.infradead.org>
 <164360492268.18996.14760090171177015570@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164360492268.18996.14760090171177015570@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 03:55:22PM +1100, NeilBrown wrote:
> On Mon, 31 Jan 2022, Matthew Wilcox wrote:
> > On Mon, Jan 31, 2022 at 03:03:53PM +1100, NeilBrown wrote:
> > >  - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
> > >     and the flag is set.
> > 
> > Is this actually useful?  I ask because Dave Chinner believes
> > the call to ->writepage in vmscan to be essentially unused.
> 
> He would be wrong ...  unless "essentially" means "mostly" rather than
> "totally".
> swap-out to NFS results in that ->writepage call.

For writes, SWP_FS_OPS uses ->direct_IO, not ->writepage.  Confused.

> Of course swap_writepage ignores sync_mode, so this might not be
> entirely relevant.
> 
> But the main point of the patch is not to return AOP_WRITEPAGE_ACTIVATE
> to vmscan.  It is to avoid writing at all when WB_SYNC_NONE and
> congested.  e.g. for POSIX_FADV_DONTNEED
> It is also to allow the removal of congestion tracking with minimal
> changes to behaviour.
> 
> If I end up changing some dead code into different dead code, I really
> don't care.  I'm not here to clean up all dead code - only the dead code
> specifically related to congestion.
> 
> NeilBrown
> 
> 
> > See commit 21b4ee7029c9, and I had a followup discussion with him
> > on IRC:
> > 
> > <willy> dchinner: did you gather any stats on how often ->writepage was
> > 	being called by pageout() before "xfs: drop ->writepage completely"
> > 	was added?
> > <dchinner> willy: Never saw it on XFS in 3 years in my test environment...
> > <dchinner> I don't ever recall seeing the memory reclaim guards we put on
> > 	->writepage in XFS ever firing - IIRC they'd been there for the best
> > 	part of a decade.
> > <willy> not so much the WARN_ON firing but the case where it actually calls
> > 	iomap_writepage
> > <dchinner> willy: I mean both - I was running with a local patch that warned
> > 	on writepage for a long time, regardless of where it was called from.
> > 
> > I can believe things are different for a network filesystem, or maybe
> > XFS does background writeback better than other filesystems, but it
> > would be intriguing to be able to get rid of ->writepage altogether
> > (or at least from pageout(); migrate.c may be a thornier proposition).
> > 
> > 
