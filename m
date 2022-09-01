Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0E5A9C55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiIAP6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiIAP6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:58:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0338E0EA;
        Thu,  1 Sep 2022 08:58:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84A7E22B10;
        Thu,  1 Sep 2022 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662047919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ZHzkmvovrbUUNg7omW+A+uLbWs5jnT10RXVkkl6wFY=;
        b=p/HoZKGQ+Chf8aIZwmQEIpDzJkxuKlTPTzJLwChS5aMHA/ud76xS+P4Pk8KzIcoW+5/3Eb
        AeK/HYfcVwN5y+svRwYg23MnrmWilnjsmT2vy7Tu/e69J2Og2bFhLCM7z0oy4eGa9LhCt/
        DiwPnrcUrzS6SeDOb1Pux/BZHMN2hkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662047919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ZHzkmvovrbUUNg7omW+A+uLbWs5jnT10RXVkkl6wFY=;
        b=9ZRLqgMKoOF3e0PR9VpKkxfW/7/iQpv6TftC2aYuMTvDhiE8g67tMvprr0Hqx4cACz6+I6
        bI5hmGqJGZE9OfBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E2AC13A89;
        Thu,  1 Sep 2022 15:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YhzfGq/WEGO1BwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Sep 2022 15:58:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E78B9A067C; Thu,  1 Sep 2022 17:58:38 +0200 (CEST)
Date:   Thu, 1 Sep 2022 17:58:38 +0200
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
Subject: Re: [PATCH v2 10/14] udf: replace ll_rw_block()
Message-ID: <20220901155838.24kdcxwaduc4c7pr@quack3>
References: <20220901133505.2510834-1-yi.zhang@huawei.com>
 <20220901133505.2510834-11-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901133505.2510834-11-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-09-22 21:35:01, Zhang Yi wrote:
> ll_rw_block() is not safe for the sync read path because it cannot
> guarantee that submitting read IO if the buffer has been locked. We
> could get false positive EIO after wait_on_buffer() if the buffer has
> been locked by others. So stop using ll_rw_block(). We also switch to
> new bh_readahead_batch() helper for the buffer array readahead path.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me.

								Honza

> ---
>  fs/udf/dir.c       | 2 +-
>  fs/udf/directory.c | 2 +-
>  fs/udf/inode.c     | 8 +-------
>  3 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/udf/dir.c b/fs/udf/dir.c
> index cad3772f9dbe..be640f4b2f2c 100644
> --- a/fs/udf/dir.c
> +++ b/fs/udf/dir.c
> @@ -130,7 +130,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
>  					brelse(tmp);
>  			}
>  			if (num) {
> -				ll_rw_block(REQ_OP_READ | REQ_RAHEAD, num, bha);
> +				bh_readahead_batch(num, bha, REQ_RAHEAD);
>  				for (i = 0; i < num; i++)
>  					brelse(bha[i]);
>  			}
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index a2adf6293093..16bcf2c6b8b3 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -89,7 +89,7 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
>  					brelse(tmp);
>  			}
>  			if (num) {
> -				ll_rw_block(REQ_OP_READ | REQ_RAHEAD, num, bha);
> +				bh_readahead_batch(num, bha, REQ_RAHEAD);
>  				for (i = 0; i < num; i++)
>  					brelse(bha[i]);
>  			}
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 8d06daed549f..dce6ae9ae306 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1211,13 +1211,7 @@ struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
>  	if (!bh)
>  		return NULL;
>  
> -	if (buffer_uptodate(bh))
> -		return bh;
> -
> -	ll_rw_block(REQ_OP_READ, 1, &bh);
> -
> -	wait_on_buffer(bh);
> -	if (buffer_uptodate(bh))
> +	if (bh_read(bh, 0) >= 0)
>  		return bh;
>  
>  	brelse(bh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
