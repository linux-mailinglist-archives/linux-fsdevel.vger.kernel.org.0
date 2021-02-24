Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9B324324
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhBXRYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 12:24:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:49956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhBXRYR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:24:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 500ECAE56;
        Wed, 24 Feb 2021 17:23:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2DC341E14EE; Wed, 24 Feb 2021 18:23:35 +0100 (CET)
Date:   Wed, 24 Feb 2021 18:23:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] mm: use filemap_range_needs_writeback() for O_DIRECT
 reads
Message-ID: <20210224172335.GE849@quack2.suse.cz>
References: <20210224164455.1096727-1-axboe@kernel.dk>
 <20210224164455.1096727-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224164455.1096727-3-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-02-21 09:44:54, Jens Axboe wrote:
> For the generic page cache read helper, use the better variant of checking
> for the need to call filemap_write_and_wait_range() when doing O_DIRECT
> reads. This avoids falling back to the slow path for IOCB_NOWAIT, if there
> are no pages to wait for (or write out).
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  mm/filemap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 13338f877677..77f1b527541e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2645,8 +2645,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  
>  		size = i_size_read(inode);
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
> -			if (filemap_range_has_page(mapping, iocb->ki_pos,
> -						   iocb->ki_pos + count - 1))
> +			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
> +						iocb->ki_pos + count - 1))
>  				return -EAGAIN;
>  		} else {
>  			retval = filemap_write_and_wait_range(mapping,
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
