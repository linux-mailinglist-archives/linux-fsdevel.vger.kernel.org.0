Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9295A444539
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 17:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhKCQGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 12:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232713AbhKCQGA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C2CA60E05;
        Wed,  3 Nov 2021 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635955404;
        bh=VdzyOXIa72ehsiwx9jkfJlFTSTYwgaxaCrEufr0H8+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/RyYNRzZxjmfm928yxBHS1y19UyxKFRieUV6DaFDhlxkec7YbIl2TnLw8L/JKUJt
         QEhM/8XP1W0wkwkc9pgZW5vvhP0KvEtbYAigNLuOlH2yOhaF6+DpOLdMSRtFn7IRrg
         lK6mFqZD9nqJzZFotqKlBrLVGAp6FNhjGKs5ntzBjksF5Of7eNPGl1pQMZUyhjus6b
         B36nlzBYubR3s3FZQgWshheURZrYH2TMEYpyzY/Ej9J+2HPRQiBky9RVVspJZiuZXl
         oGLxTFy3tlnEaAIs6DCK0X/Njas7Zxm9kzLO7mmgBzR/QzmAJSwRoJAw6Fv5IbedGt
         XZUXINn331a7A==
Date:   Wed, 3 Nov 2021 09:03:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 20/21] iomap: Support multi-page folios in invalidatepage
Message-ID: <20211103160323.GM24307@magnolia>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-21-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:28PM +0000, Matthew Wilcox (Oracle) wrote:
> If we're punching a hole in a multi-page folio, we need to remove the
> per-folio iomap data as the folio is about to be split and each page will
> need its own.  If a dirty folio is only partially-uptodate, the iomap
> data contains the information about which blocks cannot be written back,
> so assert that a dirty folio is fully uptodate.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3b93fdfedb72..9d7c91f9ec1d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -470,13 +470,18 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
>  	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
>  
>  	/*
> -	 * If we're invalidating the entire page, clear the dirty state from it
> -	 * and release it to avoid unnecessary buildup of the LRU.
> +	 * If we're invalidating the entire folio, clear the dirty state
> +	 * from it and release it to avoid unnecessary buildup of the LRU.
>  	 */
>  	if (offset == 0 && len == folio_size(folio)) {
>  		WARN_ON_ONCE(folio_test_writeback(folio));
>  		folio_cancel_dirty(folio);
>  		iomap_page_release(folio);
> +	} else if (folio_test_multi(folio)) {
> +		/* Must release the iop so the page can be split */
> +		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
> +			     folio_test_dirty(folio));
> +		iomap_page_release(folio);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
> -- 
> 2.33.0
> 
