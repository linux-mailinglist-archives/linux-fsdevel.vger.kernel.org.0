Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B5462BB9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 12:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiKPLZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 06:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiKPLZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:25:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326917AA2;
        Wed, 16 Nov 2022 03:15:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31F21336F1;
        Wed, 16 Nov 2022 11:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668597340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRsvv2N68GG7QuqFWAP5P+w/pp3yJ3QWPI8mKF2+uhY=;
        b=c0bAmVILOmDHSQKf+RTYhak1iqsy+HxmYYqIFSrYFhSw1vkm+wly7wd5I9kkac+F6p1GAO
        33EWIgZVYdo7NvO1W0cDJUGprZD2xBVRafPmGV4v/vg71lTG0kVOb/8/81zWtdbA4UlrF4
        Kw8odmtTPz15SQUGnYxluI4sZT+77p8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668597340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRsvv2N68GG7QuqFWAP5P+w/pp3yJ3QWPI8mKF2+uhY=;
        b=i1Ltb32uVzSu9mloUB3HrUUGwGcWYCSNNa2f9Il1zkq3BjE45aSAM0Gy2Zhvqmn8wc1G3u
        1Fd+f/nFEvyLbyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23357134CE;
        Wed, 16 Nov 2022 11:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XcaRCFzGdGPfZwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Nov 2022 11:15:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A929BA0709; Wed, 16 Nov 2022 12:15:39 +0100 (CET)
Date:   Wed, 16 Nov 2022 12:15:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        Svyatoslav Feldsherov <feldsherov@google.com>,
        Jan Kara <jack@suse.cz>,
        syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: do not update freeing inode i_io_list
Message-ID: <20221116111539.i7xi7is7rn62prf5@quack3>
References: <20221115202001.324188-1-feldsherov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115202001.324188-1-feldsherov@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-11-22 20:20:01, Svyatoslav Feldsherov wrote:
> After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
> already has I_DIRTY_INODE") writeback_single_inode can push inode with
> I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
> I_DIRTY_TIME set this can happen after deletion of inode from i_io_list
> at evict. Stack trace is following.
> 
> evict
> fat_evict_inode
> fat_truncate_blocks
> fat_flush_inodes
> writeback_inode
> sync_inode_metadata(inode, sync=0)
> writeback_single_inode(inode, wbc) <- wbc->sync_mode == WB_SYNC_NONE
> 
> This will lead to use after free in flusher thread.
> 
> Similar issue can be triggered if writeback_single_inode in the
> stack trace update inode->i_io_list. Add explicit check to avoid it.
> 
> Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
> Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>

Ted, I guess you will merge this patch since you've merged the one from
Lukas this patch is fixing?

								Honza

> ---
>  V2 -> V3:
>  - fix grammar in commit message and comments
> 
>  V1 -> V2: 
>  - address review comments
>  - skip inode_cgwb_move_to_attached for freeing inode 
> 
>  fs/fs-writeback.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 443f83382b9b..9958d4020771 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1712,18 +1712,26 @@ static int writeback_single_inode(struct inode *inode,
>  	wb = inode_to_wb_and_lock_list(inode);
>  	spin_lock(&inode->i_lock);
>  	/*
> -	 * If the inode is now fully clean, then it can be safely removed from
> -	 * its writeback list (if any).  Otherwise the flusher threads are
> -	 * responsible for the writeback lists.
> +	 * If the inode is freeing, its i_io_list shoudn't be updated
> +	 * as it can be finally deleted at this moment.
>  	 */
> -	if (!(inode->i_state & I_DIRTY_ALL))
> -		inode_cgwb_move_to_attached(inode, wb);
> -	else if (!(inode->i_state & I_SYNC_QUEUED)) {
> -		if ((inode->i_state & I_DIRTY))
> -			redirty_tail_locked(inode, wb);
> -		else if (inode->i_state & I_DIRTY_TIME) {
> -			inode->dirtied_when = jiffies;
> -			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
> +	if (!(inode->i_state & I_FREEING)) {
> +		/*
> +		 * If the inode is now fully clean, then it can be safely
> +		 * removed from its writeback list (if any). Otherwise the
> +		 * flusher threads are responsible for the writeback lists.
> +		 */
> +		if (!(inode->i_state & I_DIRTY_ALL))
> +			inode_cgwb_move_to_attached(inode, wb);
> +		else if (!(inode->i_state & I_SYNC_QUEUED)) {
> +			if ((inode->i_state & I_DIRTY))
> +				redirty_tail_locked(inode, wb);
> +			else if (inode->i_state & I_DIRTY_TIME) {
> +				inode->dirtied_when = jiffies;
> +				inode_io_list_move_locked(inode,
> +							  wb,
> +							  &wb->b_dirty_time);
> +			}
>  		}
>  	}
>  
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
