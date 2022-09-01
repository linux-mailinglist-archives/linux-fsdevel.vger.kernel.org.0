Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7035A9C09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiIAPqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiIAPqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:46:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD97F134;
        Thu,  1 Sep 2022 08:46:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA02E22AB1;
        Thu,  1 Sep 2022 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662047204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ER5/wzctY1JkhCLGtz3EQTHmS/rSylXbZsr8bP56n58=;
        b=pYpvEB1TmGjm8w9ZO025ZJi1mKJ5APp3kAmy6ytuh7FOsOF4aT2GnAY5QPFTbV78lJf3i6
        S6owfPABPJ7q8tVDcvQhOhAD9xrqNabulW59Ye+JNuQPSEu3Hc/F5Fm+XiXmcXqODVUWQg
        QBCOoh/GgMlVi4vLG7nrbaTVJuZHykU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662047204;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ER5/wzctY1JkhCLGtz3EQTHmS/rSylXbZsr8bP56n58=;
        b=CQHn61+Ymblc4OV77OAZiRc+28mY55tAzplOZrHAIEIhFvwR7MSOVwzpIrthiIC6RR5nTj
        AZXQC1qsdzYhkRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF78413A89;
        Thu,  1 Sep 2022 15:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QuS8LuTTEGNdAgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Sep 2022 15:46:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1F613A067C; Thu,  1 Sep 2022 17:46:44 +0200 (CEST)
Date:   Thu, 1 Sep 2022 17:46:44 +0200
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
Subject: Re: [PATCH v2 04/14] gfs2: replace ll_rw_block()
Message-ID: <20220901154644.uxxzwa7gvzlnbw7j@quack3>
References: <20220901133505.2510834-1-yi.zhang@huawei.com>
 <20220901133505.2510834-5-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901133505.2510834-5-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-09-22 21:34:55, Zhang Yi wrote:
> ll_rw_block() is not safe for the sync read path because it cannot
> guarantee that always submitting read IO if the buffer has been locked,
> so stop using it. We also switch to new bh_readahead() helper for the
> readahead path.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/meta_io.c | 7 ++-----
>  fs/gfs2/quota.c   | 8 ++------
>  2 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 7e70e0ba5a6c..6ed728aae9a5 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -525,8 +525,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
>  
>  	if (buffer_uptodate(first_bh))
>  		goto out;
> -	if (!buffer_locked(first_bh))
> -		ll_rw_block(REQ_OP_READ | REQ_META | REQ_PRIO, 1, &first_bh);
> +	bh_read_nowait(first_bh, REQ_META | REQ_PRIO);
>  
>  	dblock++;
>  	extlen--;
> @@ -534,9 +533,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
>  	while (extlen) {
>  		bh = gfs2_getbuf(gl, dblock, CREATE);
>  
> -		if (!buffer_uptodate(bh) && !buffer_locked(bh))
> -			ll_rw_block(REQ_OP_READ | REQ_RAHEAD | REQ_META |
> -				    REQ_PRIO, 1, &bh);
> +		bh_readahead(bh, REQ_RAHEAD | REQ_META | REQ_PRIO);
>  		brelse(bh);
>  		dblock++;
>  		extlen--;
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index f201eaf59d0d..1ed17226d9ed 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -745,12 +745,8 @@ static int gfs2_write_buf_to_page(struct gfs2_inode *ip, unsigned long index,
>  		}
>  		if (PageUptodate(page))
>  			set_buffer_uptodate(bh);
> -		if (!buffer_uptodate(bh)) {
> -			ll_rw_block(REQ_OP_READ | REQ_META | REQ_PRIO, 1, &bh);
> -			wait_on_buffer(bh);
> -			if (!buffer_uptodate(bh))
> -				goto unlock_out;
> -		}
> +		if (bh_read(bh, REQ_META | REQ_PRIO) < 0)
> +			goto unlock_out;
>  		if (gfs2_is_jdata(ip))
>  			gfs2_trans_add_data(ip->i_gl, bh);
>  		else
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
