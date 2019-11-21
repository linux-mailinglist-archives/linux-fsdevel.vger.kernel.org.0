Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC831056EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 17:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKUQYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 11:24:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:59100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfKUQYA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:24:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28362B3BA;
        Thu, 21 Nov 2019 16:23:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 897F91E484C; Thu, 21 Nov 2019 17:23:58 +0100 (CET)
Date:   Thu, 21 Nov 2019 17:23:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 3/3] fs: warn if stale pagecache is left after direct
 write
Message-ID: <20191121162358.GC18158@quack2.suse.cz>
References: <157270037850.4812.15036239021726025572.stgit@buzz>
 <157270038294.4812.2238891109785106069.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157270038294.4812.2238891109785106069.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 02-11-19 16:13:03, Konstantin Khlebnikov wrote:
> Function generic_file_direct_write() tries to invalidate pagecache after
> O_DIRECT write. Unlike to similar code in dio_complete() this silently
> ignores error returned from invalidate_inode_pages2_range().
> 
> According to comment this code here because not all filesystems call
> dio_complete() to do proper invalidation after O_DIRECT write.
> Noticeable example is a blkdev_direct_IO().
> 
> This patch calls dio_warn_stale_pagecache() if invalidation fails.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 189b8f318da2..dc3b78db079b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3241,11 +3241,13 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	 * do not end up with dio_complete() being called, so let's not break
>  	 * them by removing it completely.
>  	 *
> +	 * Noticeable example is a blkdev_direct_IO().
> +	 *
>  	 * Skip invalidation for async writes or if mapping has no pages.
>  	 */
> -	if (written > 0 && mapping->nrpages)
> -		invalidate_inode_pages2_range(mapping,
> -					pos >> PAGE_SHIFT, end);
> +	if (written > 0 && mapping->nrpages &&
> +	    invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT, end))
> +		dio_warn_stale_pagecache(file);
>  
>  	if (written > 0) {
>  		pos += written;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
