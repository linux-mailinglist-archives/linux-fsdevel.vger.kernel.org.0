Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1424A1056E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfKUQV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 11:21:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:57794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727225AbfKUQVz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:21:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3AB9B399;
        Thu, 21 Nov 2019 16:21:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6FA2C1E484C; Thu, 21 Nov 2019 17:21:53 +0100 (CET)
Date:   Thu, 21 Nov 2019 17:21:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/3] fs: remove redundant cache invalidation after
 async direct-io write
Message-ID: <20191121162153.GA18158@quack2.suse.cz>
References: <157270037850.4812.15036239021726025572.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157270037850.4812.15036239021726025572.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 02-11-19 16:12:58, Konstantin Khlebnikov wrote:
> Function generic_file_direct_write() invalidates cache at entry. Second
> time this should be done when request completes. But this function calls
> second invalidation at exit unconditionally even for async requests.
> 
> This patch skips second invalidation for async requests (-EIOCBQUEUED).
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 85b7d087eb45..288e38199068 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3218,9 +3218,11 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	 * Most of the time we do not need this since dio_complete() will do
>  	 * the invalidation for us. However there are some file systems that
>  	 * do not end up with dio_complete() being called, so let's not break
> -	 * them by removing it completely
> +	 * them by removing it completely.
> +	 *
> +	 * Skip invalidation for async writes or if mapping has no pages.
>  	 */
> -	if (mapping->nrpages)
> +	if (written > 0 && mapping->nrpages)
>  		invalidate_inode_pages2_range(mapping,
>  					pos >> PAGE_SHIFT, end);
>  
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
