Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD40343FBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCVL27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 07:28:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCVL2u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:28:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5D30ADD7;
        Mon, 22 Mar 2021 11:28:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9CBE91F2BA4; Mon, 22 Mar 2021 12:28:47 +0100 (CET)
Date:   Mon, 22 Mar 2021 12:28:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jack Qiu <jack.qiu@huawei.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: direct-io: fix missing sdio->boundary
Message-ID: <20210322112847.GB31783@quack2.suse.cz>
References: <20210322042253.38312-1-jack.qiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322042253.38312-1-jack.qiu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-03-21 12:22:53, Jack Qiu wrote:
> Function dio_send_cur_page may clear sdio->boundary,
> so save it to avoid boundary missing.
> 
> Fixes: b1058b981272 ("direct-io: submit bio after boundary buffer is
> added to it")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jack Qiu <jack.qiu@huawei.com>

Indeed. The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/direct-io.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 9fe721dc04e0..c9023f0bb20a 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -812,6 +812,7 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
>  		    struct buffer_head *map_bh)
>  {
>  	int ret = 0;
> +	int boundary = sdio->boundary;	/* dio_send_cur_page may clear it */
> 
>  	if (dio->op == REQ_OP_WRITE) {
>  		/*
> @@ -850,10 +851,10 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
>  	sdio->cur_page_fs_offset = sdio->block_in_file << sdio->blkbits;
>  out:
>  	/*
> -	 * If sdio->boundary then we want to schedule the IO now to
> +	 * If boundary then we want to schedule the IO now to
>  	 * avoid metadata seeks.
>  	 */
> -	if (sdio->boundary) {
> +	if (boundary) {
>  		ret = dio_send_cur_page(dio, sdio, map_bh);
>  		if (sdio->bio)
>  			dio_bio_submit(dio, sdio);
> --
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
