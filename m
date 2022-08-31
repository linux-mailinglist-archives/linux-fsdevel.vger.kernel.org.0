Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1775A7BDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 13:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiHaLEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 07:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaLEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:04:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9051A614C;
        Wed, 31 Aug 2022 04:04:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4591121E98;
        Wed, 31 Aug 2022 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661943888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7rUfy2mjgKSZvW8Hv+C3XQ3MWeegbpsZkXWtmcFePxA=;
        b=cN2bfJUKQAFYmP5lfcBq7Xllkrj98P3EGVrNed2TEDWPt+4B+jNWMWMPYksfasqywozxQl
        mL8EMZ6a66b5xJbd4UlfD2MNL6uTjYXxHO/9CYo89r7wcfHQeaKVaHhcVHojSU+ksOT0kk
        +7K2U+exV2KwTs7YfMEcA1DAIvKh6uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661943888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7rUfy2mjgKSZvW8Hv+C3XQ3MWeegbpsZkXWtmcFePxA=;
        b=IfQPklv0XIl0V4DwmvZuLeaWytRl8KT5euyQIi2kPBMZ6NVEGmXYMwS1+tudUmennmbg5a
        OAGjG2rZvG7tIWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E68F13A7C;
        Wed, 31 Aug 2022 11:04:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FO5ZC1BAD2NVcwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:04:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 83F66A067B; Wed, 31 Aug 2022 13:04:47 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:04:47 +0200
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
Subject: Re: [PATCH 09/14] reiserfs: replace ll_rw_block()
Message-ID: <20220831110447.4qm5cme3kenfa5cd@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-10-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-10-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:21:06, Zhang Yi wrote:
> ll_rw_block() is not safe for the sync read/write path because it cannot
> guarantee that submitting read/write IO if the buffer has been locked.
> We could get false positive EIO after wait_on_buffer() in read path if
> the buffer has been locked by others. So stop using ll_rw_block() in
> reiserfs. We also switch to new bh_readahead_batch() helper for the
> buffer array readahead path.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/journal.c | 11 ++++++-----
>  fs/reiserfs/stree.c   |  4 ++--
>  fs/reiserfs/super.c   |  4 +---
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 94addfcefede..699b1b8d5b73 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -868,7 +868,7 @@ static int write_ordered_buffers(spinlock_t * lock,
>  		 */
>  		if (buffer_dirty(bh) && unlikely(bh->b_page->mapping == NULL)) {
>  			spin_unlock(lock);
> -			ll_rw_block(REQ_OP_WRITE, 1, &bh);
> +			write_dirty_buffer(bh, 0);
>  			spin_lock(lock);
>  		}
>  		put_bh(bh);
> @@ -1054,7 +1054,7 @@ static int flush_commit_list(struct super_block *s,
>  		if (tbh) {
>  			if (buffer_dirty(tbh)) {
>  		            depth = reiserfs_write_unlock_nested(s);
> -			    ll_rw_block(REQ_OP_WRITE, 1, &tbh);
> +			    write_dirty_buffer(tbh, 0);
>  			    reiserfs_write_lock_nested(s, depth);
>  			}
>  			put_bh(tbh) ;
> @@ -2240,7 +2240,7 @@ static int journal_read_transaction(struct super_block *sb,
>  		}
>  	}
>  	/* read in the log blocks, memcpy to the corresponding real block */
> -	ll_rw_block(REQ_OP_READ, get_desc_trans_len(desc), log_blocks);
> +	bh_read_batch(log_blocks, get_desc_trans_len(desc));
>  	for (i = 0; i < get_desc_trans_len(desc); i++) {
>  
>  		wait_on_buffer(log_blocks[i]);
> @@ -2342,10 +2342,11 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
>  		} else
>  			bhlist[j++] = bh;
>  	}
> -	ll_rw_block(REQ_OP_READ, j, bhlist);
> +	bh = bhlist[0];
> +	bh_read_nowait(bh, 0);
> +	bh_readahead_batch(&bhlist[1], j - 1, 0);
>  	for (i = 1; i < j; i++)
>  		brelse(bhlist[i]);
> -	bh = bhlist[0];
>  	wait_on_buffer(bh);
>  	if (buffer_uptodate(bh))
>  		return bh;
> diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
> index 9a293609a022..84c12a1947b2 100644
> --- a/fs/reiserfs/stree.c
> +++ b/fs/reiserfs/stree.c
> @@ -579,7 +579,7 @@ static int search_by_key_reada(struct super_block *s,
>  		if (!buffer_uptodate(bh[j])) {
>  			if (depth == -1)
>  				depth = reiserfs_write_unlock_nested(s);
> -			ll_rw_block(REQ_OP_READ | REQ_RAHEAD, 1, bh + j);
> +			bh_readahead(bh[j], REQ_RAHEAD);
>  		}
>  		brelse(bh[j]);
>  	}
> @@ -685,7 +685,7 @@ int search_by_key(struct super_block *sb, const struct cpu_key *key,
>  			if (!buffer_uptodate(bh) && depth == -1)
>  				depth = reiserfs_write_unlock_nested(sb);
>  
> -			ll_rw_block(REQ_OP_READ, 1, &bh);
> +			bh_read_nowait(bh, 0);
>  			wait_on_buffer(bh);
>  
>  			if (depth != -1)
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index c88cd2ce0665..8b1db82b6949 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1702,9 +1702,7 @@ static int read_super_block(struct super_block *s, int offset)
>  /* after journal replay, reread all bitmap and super blocks */
>  static int reread_meta_blocks(struct super_block *s)
>  {
> -	ll_rw_block(REQ_OP_READ, 1, &SB_BUFFER_WITH_SB(s));
> -	wait_on_buffer(SB_BUFFER_WITH_SB(s));
> -	if (!buffer_uptodate(SB_BUFFER_WITH_SB(s))) {
> +	if (bh_read(SB_BUFFER_WITH_SB(s), 0)) {
>  		reiserfs_warning(s, "reiserfs-2504", "error reading the super");
>  		return 1;
>  	}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
