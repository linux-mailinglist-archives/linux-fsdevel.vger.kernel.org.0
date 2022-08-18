Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A309598593
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiHROQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 10:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiHROQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:16:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB1861CC;
        Thu, 18 Aug 2022 07:16:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F37FD37ABB;
        Thu, 18 Aug 2022 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660832162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GpYi5kcB7vtNPJ/5AspONSGAjwP/p8OVH1B6C5LznKQ=;
        b=OFgpA0ZBjKabpg3z110AmJ8jzy/U/tFq7VhbMfB35zC9BdU5GFZhbEWr3y4G0cWvMhSwy8
        2m2DkejS/+6vBeyDVYxUzC4dQ9D0n05JwoyrbPNby/1RQx7BoVTHAiSeTpeZwYn4lnBY/z
        QlnBH6TYIYoR5/utubHZ98l3Z6BqS7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660832162;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GpYi5kcB7vtNPJ/5AspONSGAjwP/p8OVH1B6C5LznKQ=;
        b=A5fRpnAdGBcZsbPFXW9+z0b0TxPKR/QSrQKadPAh34ThEXZtC5+665CxpD2WqJpa24djlq
        0ODq/3Q8q9byr4BQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B452D2C188;
        Thu, 18 Aug 2022 14:16:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7076CA066C; Thu, 18 Aug 2022 16:15:49 +0200 (CEST)
Date:   Thu, 18 Aug 2022 16:15:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCHv3 3/4] fs/buffer: Drop useless return value of submit_bh
Message-ID: <20220818141549.5db4qxcnkr2miqo2@quack3>
References: <cover.1660788334.git.ritesh.list@gmail.com>
 <a98a6ddfac68f73d684c2724952e825bc1f4d238.1660788334.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98a6ddfac68f73d684c2724952e825bc1f4d238.1660788334.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-08-22 10:34:39, Ritesh Harjani (IBM) wrote:
> submit_bh always returns 0. This patch drops the useless return value of
> submit_bh from __sync_dirty_buffer(). Once all of submit_bh callers are
> cleaned up, we can make it's return type as void.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 55e762a58eb6..c21b72c06eb0 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2801,8 +2801,6 @@ EXPORT_SYMBOL(write_dirty_buffer);
>   */
>  int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  {
> -	int ret = 0;
> -
>  	WARN_ON(atomic_read(&bh->b_count) < 1);
>  	lock_buffer(bh);
>  	if (test_clear_buffer_dirty(bh)) {
> @@ -2817,14 +2815,14 @@ int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  
>  		get_bh(bh);
>  		bh->b_end_io = end_buffer_write_sync;
> -		ret = submit_bh(REQ_OP_WRITE | op_flags, bh);
> +		submit_bh(REQ_OP_WRITE | op_flags, bh);
>  		wait_on_buffer(bh);
> -		if (!ret && !buffer_uptodate(bh))
> -			ret = -EIO;
> +		if (!buffer_uptodate(bh))
> +			return -EIO;
>  	} else {
>  		unlock_buffer(bh);
>  	}
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL(__sync_dirty_buffer);
>  
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
