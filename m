Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127B42D48A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbgLISMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 13:12:31 -0500
Received: from verein.lst.de ([213.95.11.211]:51014 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731010AbgLISMa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:12:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B262868B02; Wed,  9 Dec 2020 19:11:48 +0100 (CET)
Date:   Wed, 9 Dec 2020 19:11:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] zonefs: fix page reference and BIO leak
Message-ID: <20201209181148.GA21836@lst.de>
References: <20201209113738.300930-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209113738.300930-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:37:38PM +0900, Damien Le Moal wrote:
> In zonefs_file_dio_append(), the pages obtained using
> bio_iov_iter_get_pages() are not released on completion of the
> REQ_OP_APPEND BIO and when bio_iov_iter_get_pages() fails. Fix this by
> adding the missing calls to bio_release_pages() before returning.
> Furthermore, a call to bio_put() is missing when
> bio_iov_iter_get_pages() fails. Add it to avoid leaking the BIO
> allocated. The call to bio_io_error() is removed from this error path
> as the error code is returned directly to the caller.
> 
> Reported-by: Christoph Hellwig <hch@lst.de>
> Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  fs/zonefs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index ff5930be096c..eb5d1db018e1 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -692,7 +692,8 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
>  
>  	ret = bio_iov_iter_get_pages(bio, from);
>  	if (unlikely(ret)) {
> -		bio_io_error(bio);
> +		bio_release_pages(bio, false);
> +		bio_put(bio);
>  		return ret;
>  	}
>  	size = bio->bi_iter.bi_size;
> @@ -703,6 +704,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
>  
>  	ret = submit_bio_wait(bio);
>  
> +	bio_release_pages(bio, false);
>  	bio_put(bio);
>  
>  	zonefs_file_write_dio_end_io(iocb, size, ret, 0);

I think it might be a good idea to move the calls to bio_release_pages
and bio_put after zonefs_file_write_dio_end_io and then jump to them
from the above error case.  That keeps the resource unwinding in a
single place.
