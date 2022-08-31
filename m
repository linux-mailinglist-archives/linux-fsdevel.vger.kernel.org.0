Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671F75A7BCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 12:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiHaK6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHaK6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:58:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1693CAC8D;
        Wed, 31 Aug 2022 03:58:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89F7E221B9;
        Wed, 31 Aug 2022 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661943525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HxNI+0U0e7Zv/ZQHFt2fp30OwTNw2GytjeLFyfJkdIU=;
        b=1Rkdwb83KNKvKUChKM30xnpI9fdc070PjGzSDpFKJ9pFkPivo3n7huQ5Y/108sFshlV/X6
        zFQjUao1mx5Qt3nEwSLNw0PDPgLJ5OR8RlVkGyMOYxBCGErOztR/lcxLLJbzroBtOHQY2o
        lrUNBRNdwYPfqFM+YuvV4im5BBN3Fao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661943525;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HxNI+0U0e7Zv/ZQHFt2fp30OwTNw2GytjeLFyfJkdIU=;
        b=V7Ur8DkjErbMDQRtHW0w61RoZg4YjQhUNRZuOOsXbxACyBWNaFnCBi4IchRNFWWSX1ZoZf
        9yj5numh7SEw5EAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7640313A7C;
        Wed, 31 Aug 2022 10:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 64nUHOU+D2O5cAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 10:58:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0F038A067B; Wed, 31 Aug 2022 12:58:45 +0200 (CEST)
Date:   Wed, 31 Aug 2022 12:58:45 +0200
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
Subject: Re: [PATCH 06/14] jbd2: replace ll_rw_block()
Message-ID: <20220831105845.mwfkh2prb557ajyr@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-7-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-7-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:21:03, Zhang Yi wrote:
> ll_rw_block() is not safe for the sync read path because it cannot
> guarantee that submitting read IO if the buffer has been locked. We
> could get false positive EIO after wait_on_buffer() if the buffer has
> been locked by others. So stop using ll_rw_block() in
> journal_get_superblock(). We also switch to new bh_readahead_batch()
> for the buffer array readahead path.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c  |  7 +++----
>  fs/jbd2/recovery.c | 16 ++++++++++------
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 6350d3857c89..5a903aae6aad 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1893,15 +1893,14 @@ static int journal_get_superblock(journal_t *journal)
>  {
>  	struct buffer_head *bh;
>  	journal_superblock_t *sb;
> -	int err = -EIO;
> +	int err;
>  
>  	bh = journal->j_sb_buffer;
>  
>  	J_ASSERT(bh != NULL);
>  	if (!buffer_uptodate(bh)) {
> -		ll_rw_block(REQ_OP_READ, 1, &bh);
> -		wait_on_buffer(bh);
> -		if (!buffer_uptodate(bh)) {
> +		err = bh_read(bh, 0);
> +		if (err) {
>  			printk(KERN_ERR
>  				"JBD2: IO error reading journal superblock\n");
>  			goto out;
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index f548479615c6..ee56a30b71cf 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -100,7 +100,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  		if (!buffer_uptodate(bh) && !buffer_locked(bh)) {
>  			bufs[nbufs++] = bh;
>  			if (nbufs == MAXBUF) {
> -				ll_rw_block(REQ_OP_READ, nbufs, bufs);
> +				bh_readahead_batch(bufs, nbufs, 0);
>  				journal_brelse_array(bufs, nbufs);
>  				nbufs = 0;
>  			}
> @@ -109,7 +109,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  	}
>  
>  	if (nbufs)
> -		ll_rw_block(REQ_OP_READ, nbufs, bufs);
> +		bh_readahead_batch(bufs, nbufs, 0);
>  	err = 0;
>  
>  failed:
> @@ -152,9 +152,14 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
>  		return -ENOMEM;
>  
>  	if (!buffer_uptodate(bh)) {
> -		/* If this is a brand new buffer, start readahead.
> -                   Otherwise, we assume we are already reading it.  */
> -		if (!buffer_req(bh))
> +		/*
> +		 * If this is a brand new buffer, start readahead.
> +		 * Otherwise, we assume we are already reading it.
> +		 */
> +		bool need_readahead = !buffer_req(bh);
> +
> +		bh_read_nowait(bh, 0);
> +		if (need_readahead)
>  			do_readahead(journal, offset);
>  		wait_on_buffer(bh);
>  	}
> @@ -687,7 +692,6 @@ static int do_one_pass(journal_t *journal,
>  					mark_buffer_dirty(nbh);
>  					BUFFER_TRACE(nbh, "marking uptodate");
>  					++info->nr_replays;
> -					/* ll_rw_block(WRITE, 1, &nbh); */
>  					unlock_buffer(nbh);
>  					brelse(obh);
>  					brelse(nbh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
