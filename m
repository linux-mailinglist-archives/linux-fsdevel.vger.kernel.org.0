Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD235A9C08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiIAPph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiIAPp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:45:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B67DE8A;
        Thu,  1 Sep 2022 08:45:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F778201C0;
        Thu,  1 Sep 2022 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662047123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ooz3dCva7w6jx/i3dpZqqR47QA7PhzwOtiLya/TEJY0=;
        b=C6Lpcd7xASxf1cssBBMPcpooT8fI7+WWu1lp17jzmswseiWsUsSDpVLmYp+aytuaVPKGJV
        zBlbet/HYxzWqJ8islEoE8uoBdB495OdcWxvOjdBA6guagzH/ONpmsCfdImj7QjwvhJIfa
        1Y3W/9Mtiot7rG2cI1eGzxQO9qbz5QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662047123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ooz3dCva7w6jx/i3dpZqqR47QA7PhzwOtiLya/TEJY0=;
        b=UERgtbcz5w5Rq640BVo73B/v9AGy87UcJRye91hKPcs95E0D5kauEfPg5cnHzSGsCqQu3Y
        nYEW6NAJM4kNLLCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CFDB13A89;
        Thu,  1 Sep 2022 15:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /ocSB5PTEGOyAQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Sep 2022 15:45:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4C82EA067C; Thu,  1 Sep 2022 17:45:22 +0200 (CEST)
Date:   Thu, 1 Sep 2022 17:45:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        akpm@linux-foundation.org, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, rpeterso@redhat.com, agruenba@redhat.com,
        almaz.alexandrovich@paragon-software.com, mark@fasheh.com,
        dushistov@mail.ru, hch@infradead.org, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 03/14] fs/buffer: replace ll_rw_block()
Message-ID: <20220901154522.r37xszonxutm6bsk@quack3>
References: <20220901133505.2510834-1-yi.zhang@huawei.com>
 <20220901133505.2510834-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901133505.2510834-4-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-09-22 21:34:54, Zhang Yi wrote:
> ll_rw_block() is not safe for the sync IO path because it skip buffers
> which has been locked by others, it could lead to false positive EIO
> when submitting read IO. So stop using ll_rw_block(), switch to use new
> helpers which could guarantee buffer locked and submit IO if needed.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index a6bc769e665d..aec568b3ae52 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -562,7 +562,7 @@ void write_boundary_block(struct block_device *bdev,
>  	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
>  	if (bh) {
>  		if (buffer_dirty(bh))
> -			ll_rw_block(REQ_OP_WRITE, 1, &bh);
> +			write_dirty_buffer(bh, 0);
>  		put_bh(bh);
>  	}
>  }
> @@ -1342,7 +1342,7 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
>  {
>  	struct buffer_head *bh = __getblk(bdev, block, size);
>  	if (likely(bh)) {
> -		ll_rw_block(REQ_OP_READ | REQ_RAHEAD, 1, &bh);
> +		bh_readahead(bh, REQ_RAHEAD);
>  		brelse(bh);
>  	}
>  }
> @@ -2022,7 +2022,7 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>  		if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
>  		    !buffer_unwritten(bh) &&
>  		     (block_start < from || block_end > to)) {
> -			ll_rw_block(REQ_OP_READ, 1, &bh);
> +			bh_read_nowait(bh, 0);
>  			*wait_bh++=bh;
>  		}
>  	}
> @@ -2582,11 +2582,9 @@ int block_truncate_page(struct address_space *mapping,
>  		set_buffer_uptodate(bh);
>  
>  	if (!buffer_uptodate(bh) && !buffer_delay(bh) && !buffer_unwritten(bh)) {
> -		err = -EIO;
> -		ll_rw_block(REQ_OP_READ, 1, &bh);
> -		wait_on_buffer(bh);
> +		err = bh_read(bh, 0);
>  		/* Uhhuh. Read error. Complain and punt. */
> -		if (!buffer_uptodate(bh))
> +		if (err < 0)
>  			goto unlock;
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
