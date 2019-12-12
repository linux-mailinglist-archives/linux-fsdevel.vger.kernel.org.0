Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80811CB6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 11:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfLLKzR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 05:55:17 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:55953 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728802AbfLLKzR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:55:17 -0500
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Dec 2019 05:55:16 EST
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 1A8D699848;
        Thu, 12 Dec 2019 11:45:07 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Date:   Thu, 12 Dec 2019 11:44:59 +0100
Message-ID: <63049728.ylUViGSH3C@merkaba>
In-Reply-To: <20191211152943.2933-1-axboe@kernel.dk>
References: <20191211152943.2933-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens.

Jens Axboe - 11.12.19, 16:29:38 CET:
> Recently someone asked me how io_uring buffered IO compares to mmaped
> IO in terms of performance. So I ran some tests with buffered IO, and
> found the experience to be somewhat painful. The test case is pretty
> basic, random reads over a dataset that's 10x the size of RAM.
> Performance starts out fine, and then the page cache fills up and we
> hit a throughput cliff. CPU usage of the IO threads go up, and we have
> kswapd spending 100% of a core trying to keep up. Seeing that, I was
> reminded of the many complaints I here about buffered IO, and the
> fact that most of the folks complaining will ultimately bite the
> bullet and move to O_DIRECT to just get the kernel out of the way.
> 
> But I don't think it needs to be like that. Switching to O_DIRECT
> isn't always easily doable. The buffers have different life times,
> size and alignment constraints, etc. On top of that, mixing buffered
> and O_DIRECT can be painful.
> 
> Seems to me that we have an opportunity to provide something that sits
> somewhere in between buffered and O_DIRECT, and this is where
> RWF_UNCACHED enters the picture. If this flag is set on IO, we get
> the following behavior:
> 
> - If the data is in cache, it remains in cache and the copy (in or
> out) is served to/from that.
> 
> - If the data is NOT in cache, we add it while performing the IO. When
> the IO is done, we remove it again.
> 
> With this, I can do 100% smooth buffered reads or writes without
> pushing the kernel to the state where kswapd is sweating bullets. In
> fact it doesn't even register.

A question from a user or Linux Performance trainer perspective:

How does this compare with posix_fadvise() with POSIX_FADV_DONTNEED that 
for example the nocache¹ command is using? Excerpt from manpage 
posix_fadvice(2):

       POSIX_FADV_DONTNEED
              The specified data will not be accessed  in  the  near
              future.

              POSIX_FADV_DONTNEED  attempts to free cached pages as‐
              sociated with the specified region.  This  is  useful,
              for  example,  while streaming large files.  A program
              may periodically request the  kernel  to  free  cached
              data  that  has already been used, so that more useful
              cached pages are not discarded instead.

[1] packaged in Debian as nocache or available herehttps://github.com/
Feh/nocache

In any way, would be nice to have some option in rsync… I still did not 
change my backup script to call rsync via nocache.

Thanks,
Martin

> Comments appreciated! This should work on any standard file system,
> using either the generic helpers or iomap. I have tested ext4 and xfs
> for the right read/write behavior, but no further validation has been
> done yet. Patches are against current git, and can also be found here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached
> 
>  fs/ceph/file.c          |  2 +-
>  fs/dax.c                |  2 +-
>  fs/ext4/file.c          |  2 +-
>  fs/iomap/apply.c        | 26 ++++++++++-
>  fs/iomap/buffered-io.c  | 54 ++++++++++++++++-------
>  fs/iomap/direct-io.c    |  3 +-
>  fs/iomap/fiemap.c       |  5 ++-
>  fs/iomap/seek.c         |  6 ++-
>  fs/iomap/swapfile.c     |  2 +-
>  fs/nfs/file.c           |  2 +-
>  include/linux/fs.h      |  7 ++-
>  include/linux/iomap.h   | 10 ++++-
>  include/uapi/linux/fs.h |  5 ++-
>  mm/filemap.c            | 95
> ++++++++++++++++++++++++++++++++++++----- 14 files changed, 181
> insertions(+), 40 deletions(-)
> 
> Changes since v2:
> - Rework the write side according to Chinners suggestions. Much
> cleaner this way. It does mean that we invalidate the full write
> region if just ONE page (or more) had to be created, where before it
> was more granular. I don't think that's a concern, and on the plus
> side, we now no longer have to chunk invalidations into 15/16 pages
> at the time.
> - Cleanups
> 
> Changes since v1:
> - Switch to pagevecs for write_drop_cached_pages()
> - Use page_offset() instead of manual shift
> - Ensure we hold a reference on the page between calling ->write_end()
> and checking the mapping on the locked page
> - Fix XFS multi-page streamed writes, we'd drop the UNCACHED flag
> after the first page


-- 
Martin


