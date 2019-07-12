Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E30367255
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfGLP2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 11:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfGLP2R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:28:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B8FC208E4;
        Fri, 12 Jul 2019 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562945296;
        bh=kvRwMmpPgKOBlahNaD54ocvg9pjHc1Q2YXUDFky0kr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuPtoDzXrtSzfwjdLXCa6q4tqctFFJF+IOTDsZwpWFkNsxXGsrBvmLjCtgEyG6LLa
         ZMXS3sNvcP8O1y4t7tmsxRxmv1Td+pv1T78xM6hkhWURRSFGe2Mdn0Y5DMLLrHxxBk
         OddT+Jv3/rbiOjAYquBZXjJA/xE+m3U7/IjH2NnY=
Date:   Fri, 12 Jul 2019 17:28:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Max Kellermann <mk@cm4all.com>
Cc:     zhangliguang@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "NFS: readdirplus optimization by cache
 mechanism" (memleak)
Message-ID: <20190712152813.GB13940@kroah.com>
References: <20190712141806.3063-1-mk@cm4all.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712141806.3063-1-mk@cm4all.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 04:18:06PM +0200, Max Kellermann wrote:
> This reverts commit be4c2d4723a4a637f0d1b4f7c66447141a4b3564.
> 
> That commit caused a severe memory leak in nfs_readdir_make_qstr().
> 
> When listing a directory with more than 100 files (this is how many
> struct nfs_cache_array_entry elements fit in one 4kB page), all
> allocated file name strings past those 100 leak.
> 
> The root of the leakage is that those string pointers are managed in
> pages which are never linked into the page cache.
> 
> fs/nfs/dir.c puts pages into the page cache by calling
> read_cache_page(); the callback function nfs_readdir_filler() will
> then fill the given page struct which was passed to it, which is
> already linked in the page cache (by do_read_cache_page() calling
> add_to_page_cache_lru()).
> 
> Commit be4c2d4723a4 added another (local) array of allocated pages, to
> be filled with more data, instead of discarding excess items received
> from the NFS server.  Those additional pages can be used by the next
> nfs_readdir_filler() call (from within the same nfs_readdir() call).
> 
> The leak happens when some of those additional pages are never used
> (copied to the page cache using copy_highpage()).  The pages will be
> freed by nfs_readdir_free_pages(), but their contents will not.  The
> commit did not invoke nfs_readdir_clear_array() (and doing so would
> have been dangerous, because it did not track which of those pages
> were already copied to the page cache, risking double free bugs).
> 
> How to reproduce the leak:
> 
> - Use a kernel with CONFIG_SLUB_DEBUG_ON.
> 
> - Create a directory on a NFS mount with more than 100 files with
>   names long enough to use the "kmalloc-32" slab (so we can easily
>   look up the allocation counts):
> 
>   for i in `seq 110`; do touch ${i}_0123456789abcdef; done
> 
> - Drop all caches:
> 
>   echo 3 >/proc/sys/vm/drop_caches
> 
> - Check the allocation counter:
> 
>   grep nfs_readdir /sys/kernel/slab/kmalloc-32/alloc_calls
>   30564391 nfs_readdir_add_to_array+0x73/0xd0 age=534558/4791307/6540952 pid=370-1048386 cpus=0-47 nodes=0-1
> 
> - Request a directory listing and check the allocation counters again:
> 
>   ls
>   [...]
>   grep nfs_readdir /sys/kernel/slab/kmalloc-32/alloc_calls
>   30564511 nfs_readdir_add_to_array+0x73/0xd0 age=207/4792999/6542663 pid=370-1048386 cpus=0-47 nodes=0-1
> 
> There are now 120 new allocations.
> 
> - Drop all caches and check the counters again:
> 
>   echo 3 >/proc/sys/vm/drop_caches
>   grep nfs_readdir /sys/kernel/slab/kmalloc-32/alloc_calls
>   30564401 nfs_readdir_add_to_array+0x73/0xd0 age=735/4793524/6543176 pid=370-1048386 cpus=0-47 nodes=0-1
> 
> 110 allocations are gone, but 10 have leaked and will never be freed.
> 
> Unhelpfully, those allocations are explicitly excluded from KMEMLEAK,
> that's why my initial attempts with KMEMLEAK were not successful:
> 
> 	/*
> 	 * Avoid a kmemleak false positive. The pointer to the name is stored
> 	 * in a page cache page which kmemleak does not scan.
> 	 */
> 	kmemleak_not_leak(string->name);
> 
> It would be possible to solve this bug without reverting the whole
> commit:
> 
> - keep track of which pages were not used, and call
>   nfs_readdir_clear_array() on them, or
> - manually link those pages into the page cache
> 
> But for now I have decided to just revert the commit, because the real
> fix would require complex considerations, risking more dangerous
> (crash) bugs, which may seem unsuitable for the stable branches.
> 
> Signed-off-by: Max Kellermann <mk@cm4all.com>
> ---
>  fs/nfs/dir.c      | 90 ++++-------------------------------------------
>  fs/nfs/internal.h |  3 +-
>  2 files changed, 7 insertions(+), 86 deletions(-)

No cc: stable@vger on this patch to get it backported?

thanks,

greg k-h
