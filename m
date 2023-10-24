Return-Path: <linux-fsdevel+bounces-1111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C1A7D582F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 18:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C21C20C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECAB3A262;
	Tue, 24 Oct 2023 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tZKJPTUm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB5200CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 16:26:01 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9358B10D4;
	Tue, 24 Oct 2023 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b4w9aRyrS+9I1Nc5GJ428AZWRpJVCoZGZd7zMybYBaw=; b=tZKJPTUmDGV+PL6Z4HbvGgkm0T
	MVGRUPIGDLJ3+T23gKpqolCVsty3W5rl7cc/DRgxyyWKqROabY6TCBLV7vXXfvHgeOtMs/KS/qu07
	BIuFXVHVtKbhz8H0pDKdNPIpMqjTr9OlHwWYGr4/+7EM9tRD8AiuQUcylF/BxWXkwhAotiUzsnC7a
	VAXOZgKqWlH8yHk+Tv80+xEQcVpcmaRVofLneCZE5JPJFywxBPYcTXYIEwnpyfwlXUh83bgPH+9zL
	F3ycEbmIlohHNboqntPVz6AzYpzlMYxUksXX2nfAWu2nRK5i/VKAbk0fonkYnZQyyomoxHYGnKufT
	BAT6PjdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qvKDz-003UvN-Rd; Tue, 24 Oct 2023 16:25:47 +0000
Date: Tue, 24 Oct 2023 17:25:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
	Hui Zhu <teawater@antgroup.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-mm@kvack.org
Subject: Include __GFP_NOWARN in GFP_NOWAIT
Message-ID: <ZTfwC3hJJufpNrH/@casper.infradead.org>
References: <7bc6ad16-9a4d-dd90-202e-47d6cbb5a136@google.com>
 <20231024100318.muhq5omspyegli4c@quack3>
 <20231024075343.e5f0bd0d99962a4f0e32d1a0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024075343.e5f0bd0d99962a4f0e32d1a0@linux-foundation.org>

On Tue, Oct 24, 2023 at 07:53:43AM -0700, Andrew Morton wrote:
> On Tue, 24 Oct 2023 12:03:18 +0200 Jan Kara <jack@suse.cz> wrote:
> 
> > On Mon 23-10-23 23:26:08, Hugh Dickins wrote:
> > > Since mm-hotfixes-stable commit e509ad4d77e6 ("ext4: use bdev_getblk() to
> > > avoid memory reclaim in readahead path") rightly replaced GFP_NOFAIL
> > > allocations by GFP_NOWAIT allocations, I've occasionally been seeing
> > > "page allocation failure: order:0" warnings under load: all with
> > > ext4_sb_breadahead_unmovable() in the stack.  I don't think those
> > > warnings are of any interest: suppress them with __GFP_NOWARN.
> > > 
> > > Fixes: e509ad4d77e6 ("ext4: use bdev_getblk() to avoid memory reclaim in readahead path")
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > 
> > Yeah, makes sense. Just the commit you mention isn't upstream yet so I'm
> > not sure whether the commit hash is stable.
> 
> e509ad4d77e6 is actually in mm-stable so yes, the hash should be stable.

GFP_NOWAIT is a loaded gun pointing at our own feet.  It's almost
expected to fail (and that's documented in a few places, eg
Documentation/core-api/memory-allocation.rst)

Why do we do this to ourselves?  There's precedent for having
__GFP_NOWARN included in the flags, eg GFP_TRANSHUGE_LIGHT has it.
There are ~400 occurrences of GFP_NOWAIT in the kernel (many in
comments, it must be said!) and ~350 of them do not have GFP_NOWARN
attached to them.  At least not on the same line.  To choose a random
example, fs/iomap/buffered-io.c:

        if (flags & IOMAP_NOWAIT)
                gfp = GFP_NOWAIT;
        else
                gfp = GFP_NOFS | __GFP_NOFAIL;

That should clearly have had a NOWARN attached to it, but it's not
a code path that's commonly used, so we won't fix it for a few years.

Similarly, in Ceph:

                        if (IS_ENCRYPTED(inode)) {
                                pages[locked_pages] =
                                        fscrypt_encrypt_pagecache_blocks(page,
                                                PAGE_SIZE, 0,
                                                locked_pages ? GFP_NOWAIT : GFP_NOFS);

... actually, this one looks fine because it goes to mempool_alloc()
which adds __GFP_NOWARN itself!

There are a bunch of places which use it as an argument to idr_alloc(),
generally after having called idr_prealloc() and then taken a spinlock.
Those don't care whether NOWARN is set or not because they won't
allocate.

Anyway, are there good arguments against this?

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 6583a58670c5..ae994534a12a 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -274,7 +274,8 @@ typedef unsigned int __bitwise gfp_t;
  * accounted to kmemcg.
  *
  * %GFP_NOWAIT is for kernel allocations that should not stall for direct
- * reclaim, start physical IO or use any filesystem callback.
+ * reclaim, start physical IO or use any filesystem callback.  It is very
+ * likely to fail to allocate memory, even for very small allocations.
  *
  * %GFP_NOIO will use direct reclaim to discard clean pages or slab pages
  * that do not require the starting of any physical IO.
@@ -325,7 +326,7 @@ typedef unsigned int __bitwise gfp_t;
 #define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
 #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
-#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
+#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
 #define GFP_NOIO	(__GFP_RECLAIM)
 #define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
 #define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)

