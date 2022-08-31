Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ABE5A7BBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 12:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiHaKwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 06:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiHaKwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:52:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3951C9EA6;
        Wed, 31 Aug 2022 03:52:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0652C1F8B4;
        Wed, 31 Aug 2022 10:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661943155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aV4GbEJHv4GUiycGvXX9VQqqdKb3fSgUfwxaOPsIBF4=;
        b=PRYWzd/0V29rFD/lWsz52Lt0OuT2f9LO3aKmg3FNGDjcIWECgNVeiUKviDDEgU9FQ1f0S7
        tBcH5xPN5Vvsv1CHdQ36ejgJV00plIjLpXu5HEytDKcazrypMPm2bWt2i+N17xwihsoTDp
        Kftx+Qdml/EOZW5sbd0MeaeVIcopkCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661943155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aV4GbEJHv4GUiycGvXX9VQqqdKb3fSgUfwxaOPsIBF4=;
        b=awjqDxapgMdgRxiPhamh5PF4pAsLYLJcaoyapMEqNq4rUetRfMnPJj7syOzPUqu5raEHle
        Vplg3xbSnI95jNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6EBE13A7C;
        Wed, 31 Aug 2022 10:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NVhbOHI9D2MKbgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 10:52:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7B48CA067B; Wed, 31 Aug 2022 12:52:34 +0200 (CEST)
Date:   Wed, 31 Aug 2022 12:52:34 +0200
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
Subject: Re: [PATCH 04/14] gfs2: replace ll_rw_block()
Message-ID: <20220831105234.suazqjzqnb2r65ow@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-5-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-5-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:21:01, Zhang Yi wrote:
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
>  fs/gfs2/meta_io.c | 6 ++----
>  fs/gfs2/quota.c   | 4 +---
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 7e70e0ba5a6c..07e882aa7ebd 100644
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
> @@ -535,8 +534,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
>  		bh = gfs2_getbuf(gl, dblock, CREATE);
>  
>  		if (!buffer_uptodate(bh) && !buffer_locked(bh))
> -			ll_rw_block(REQ_OP_READ | REQ_RAHEAD | REQ_META |
> -				    REQ_PRIO, 1, &bh);
> +			bh_readahead(bh, REQ_RAHEAD | REQ_META | REQ_PRIO);
>  		brelse(bh);
>  		dblock++;
>  		extlen--;
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index f201eaf59d0d..0c2ef4226aba 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -746,9 +746,7 @@ static int gfs2_write_buf_to_page(struct gfs2_inode *ip, unsigned long index,
>  		if (PageUptodate(page))
>  			set_buffer_uptodate(bh);
>  		if (!buffer_uptodate(bh)) {
> -			ll_rw_block(REQ_OP_READ | REQ_META | REQ_PRIO, 1, &bh);
> -			wait_on_buffer(bh);
> -			if (!buffer_uptodate(bh))
> +			if (bh_read(bh, REQ_META | REQ_PRIO))
>  				goto unlock_out;
>  		}
>  		if (gfs2_is_jdata(ip))
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
