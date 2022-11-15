Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6396C629680
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 11:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKOK5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 05:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbiKOK4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:56:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D97286FA;
        Tue, 15 Nov 2022 02:55:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81B972257D;
        Tue, 15 Nov 2022 10:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668509714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6d1al7iVPZvy8XyqxGKVTzEvm8pG/L2/H7QzcMYZ+c=;
        b=lnbpfBfgPj9v+blxlSnc9baHKOvd9curpSWJvUtLpFs/1EiYp0z1Z+xGHo2FxFRhg+LnTY
        Jv/2xHXYDAcGhAAc0FMnZdbSs8C83EX3UEIAYHV9lZ/npdxSMhII1mkM1Nk/mLPpuFR/gw
        vmGj0EDranmfeSaYDYfEMDi48CcmYlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668509714;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6d1al7iVPZvy8XyqxGKVTzEvm8pG/L2/H7QzcMYZ+c=;
        b=XAgI9VUW51QYd4hI7eR9x1Upr9E8+OUavkhq8zJ6tz9myGrsZUWknqUg6KAEZIEn1SWxtk
        h4t0FEU5qOmVZYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7210513A91;
        Tue, 15 Nov 2022 10:55:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZZfNGxJwc2PDDQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 15 Nov 2022 10:55:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F025FA0709; Tue, 15 Nov 2022 11:55:13 +0100 (CET)
Date:   Tue, 15 Nov 2022 11:55:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Svyatoslav Feldsherov <feldsherov@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: do not update freeing inode io_list
Message-ID: <20221115105513.6qqyxj4klci6hozl@quack3>
References: <20221114192129.zkmubc6pmruuzkc7@quack3>
 <20221114212155.221829-1-feldsherov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114212155.221829-1-feldsherov@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-11-22 21:21:55, Svyatoslav Feldsherov wrote:
> After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
> already has I_DIRTY_INODE") writeiback_single_inode can push inode with
				^^^ writeback

> I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
> I_DIRTY_TIME set this can happened after deletion of inode io_list at
				^^ happen		^^^ deletion of
inode *from i_io_list*

> evict. Stack trace is following.
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
> stack trace update inode->io_list. Add explicit check to avoid it.
			^^ inode->i_io_list
 
> Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
> Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
> Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>

Besides these gramatical nits the patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!

								Honza

> ---
>  V1 -> V2: 
>  - address review comments
>  - skip inode_cgwb_move_to_attached for freeing inode 
> 
>  fs/fs-writeback.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 443f83382b9b..c4aea096689c 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1712,18 +1712,26 @@ static int writeback_single_inode(struct inode *inode,
>  	wb = inode_to_wb_and_lock_list(inode);
>  	spin_lock(&inode->i_lock);
>  	/*
> -	 * If the inode is now fully clean, then it can be safely removed from
> -	 * its writeback list (if any).  Otherwise the flusher threads are
> -	 * responsible for the writeback lists.
> +	 * If the inode is freeing, it's io_list shoudn't be updated
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
