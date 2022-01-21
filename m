Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE15496463
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 18:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381640AbiAURrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 12:47:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41474 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbiAURra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:47:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3D03B82069;
        Fri, 21 Jan 2022 17:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E3DC340E1;
        Fri, 21 Jan 2022 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642787247;
        bh=oKkPWd9txk9tE7fz7famX/0zcd82lrEm08j+OdI1AT4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XNye038kVucvuvASSDWSFeJ+KZjUERhEx5LppAPprw3yBD6/Cd7Eo8MJ9P+a/V9sw
         hDDeuPayw2/9OplJ332k3lNGLFVd6YgiY5/W9i5SXQ3Cqe6h8vqu1qkE4h6aO6FZL0
         qJ/Qxf77uvE6rAqq1//DYm9TPlWUBmpIoVnrLg+hCBHSVlWpjJoK4lMjg9Q7CxhBBj
         5WBBsM7YbDBeeXKzcyTCosgZm8h6X83oeNrjLK7kM7GFOtGucuS4oIootz8JR9c2DE
         rkjfgPtMT9xkYOz8yHHR+gqtJqrz+lhN3cjrvMxIH5bq9u1e0rpFTKyn67xD0nnOgF
         sHVmGmcXMTGQg==
Message-ID: <725c4bcacded089553341003117a3f49104c971b.camel@kernel.org>
Subject: Re: [PATCH 02/11] cachefiles: Calculate the blockshift in terms of
 bytes, not pages
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Jan 2022 12:47:24 -0500
In-Reply-To: <164251398954.3435901.7138806620218474123.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
         <164251398954.3435901.7138806620218474123.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-01-18 at 13:53 +0000, David Howells wrote:
> Cachefiles keeps track of how much space is available on the backing
> filesystem and refuses new writes permission to start if there isn't enough
> (we especially don't want ENOSPC happening).  It also tracks the amount of
> data pending in DIO writes (cache->b_writing) and reduces the amount of
> free space available by this amount before deciding if it can set up a new
> write.
> 
> However, the old fscache I/O API was very much page-granularity dependent
> and, as such, cachefiles's cache->bshift was meant to be a multiplier to
> get from PAGE_SIZE to block size (ie. a blocksize of 512 would give a shift
> of 3 for a 4KiB page) - and this was incorrectly being used to turn the
> number of bytes in a DIO write into a number of blocks, leading to a
> massive over estimation of the amount of data in flight.
> 
> Fix this by changing cache->bshift to be a multiplier from bytes to
> blocksize and deal with quantities of blocks, not quantities of pages.
> 
> Fix also the rounding in the calculation in cachefiles_write() which needs
> a "- 1" inserting.
> 
> Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> ---
> 
>  fs/cachefiles/cache.c    |    7 ++-----
>  fs/cachefiles/internal.h |    2 +-
>  fs/cachefiles/io.c       |    2 +-
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
> index ce4d4785003c..1e9c71666c6a 100644
> --- a/fs/cachefiles/cache.c
> +++ b/fs/cachefiles/cache.c
> @@ -84,9 +84,7 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
>  		goto error_unsupported;
>  
>  	cache->bsize = stats.f_bsize;
> -	cache->bshift = 0;
> -	if (stats.f_bsize < PAGE_SIZE)
> -		cache->bshift = PAGE_SHIFT - ilog2(stats.f_bsize);
> +	cache->bshift = ilog2(stats.f_bsize);
>  
>  	_debug("blksize %u (shift %u)",
>  	       cache->bsize, cache->bshift);
> @@ -106,7 +104,6 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
>  	       (unsigned long long) cache->fcull,
>  	       (unsigned long long) cache->fstop);
>  
> -	stats.f_blocks >>= cache->bshift;
>  	do_div(stats.f_blocks, 100);
>  	cache->bstop = stats.f_blocks * cache->bstop_percent;
>  	cache->bcull = stats.f_blocks * cache->bcull_percent;
> @@ -209,7 +206,7 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
>  		return ret;
>  	}
>  
> -	b_avail = stats.f_bavail >> cache->bshift;
> +	b_avail = stats.f_bavail;
>  	b_writing = atomic_long_read(&cache->b_writing);
>  	if (b_avail > b_writing)
>  		b_avail -= b_writing;
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 8dd54d9375b6..c793d33b0224 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -86,7 +86,7 @@ struct cachefiles_cache {
>  	unsigned			bcull_percent;	/* when to start culling (% blocks) */
>  	unsigned			bstop_percent;	/* when to stop allocating (% blocks) */
>  	unsigned			bsize;		/* cache's block size */
> -	unsigned			bshift;		/* min(ilog2(PAGE_SIZE / bsize), 0) */
> +	unsigned			bshift;		/* ilog2(bsize) */
>  	uint64_t			frun;		/* when to stop culling */
>  	uint64_t			fcull;		/* when to start culling */
>  	uint64_t			fstop;		/* when to stop allocating */
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 60b1eac2ce78..04eb52736990 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -264,7 +264,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
>  	ki->term_func		= term_func;
>  	ki->term_func_priv	= term_func_priv;
>  	ki->was_async		= true;
> -	ki->b_writing		= (len + (1 << cache->bshift)) >> cache->bshift;
> +	ki->b_writing		= (len + (1 << cache->bshift) - 1) >> cache->bshift;
>  
>  	if (ki->term_func)
>  		ki->iocb.ki_complete = cachefiles_write_complete;
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
