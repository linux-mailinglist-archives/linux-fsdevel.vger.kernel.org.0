Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C139551AE04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354802AbiEDTm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 15:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbiEDTm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 15:42:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C674D256
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 12:38:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 236E31F745;
        Wed,  4 May 2022 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651693128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0ywWG6KuOia0hi/fRUgL0/3h1a8n8p/hCmKUHQdGaY=;
        b=F1ohq1JkNv5TKeq9AL7HcBZG633xr7WNkmLI9SoIulbAyURVOYKjASXma6JCJt+Qd3hSfp
        Iv7afkJj46V7TyYlSLeNkenzsY0iMMg67EbzVnUXtD8PM9vtuO9cZ7CzZ3flilIqMnOF/a
        LqIm7U46auAFuicx0LVYAO7rd4Jsk6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651693128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0ywWG6KuOia0hi/fRUgL0/3h1a8n8p/hCmKUHQdGaY=;
        b=1sXlwZpElOepJqH1RL3CCKltLb37I22key72u9GRHecfVS7LvH+ntrnluzP+Dcyf2eTVWG
        Xkfi+pWyR4Er6KDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 179972C141;
        Wed,  4 May 2022 19:38:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A5725A061E; Wed,  4 May 2022 21:38:47 +0200 (CEST)
Date:   Wed, 4 May 2022 21:38:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jchao Sun <sunjunchao2870@gmail.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] writeback: Fix inode->i_io_list not be protected by
 inode->i_lock error
Message-ID: <20220504193847.lx4eqcnqzqqffbtm@quack3.lan>
References: <20220504143924.ix2m3azbxdmx67u6@quack3.lan>
 <20220504182514.25347-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504182514.25347-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-05-22 11:25:14, Jchao Sun wrote:
> Commit b35250c0816c ("writeback: Protect inode->i_io_list with
> inode->i_lock") made inode->i_io_list not only protected by
> wb->list_lock but also inode->i_lock, but inode_io_list_move_locked()
> was missed. Add lock there and also update comment describing things
> protected by inode->i_lock.
> 
> Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
> Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>

Almost there :). A few comments below:

> @@ -2402,6 +2404,9 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			inode->i_state &= ~I_DIRTY_TIME;
>  		inode->i_state |= flags;
>  
> +		wb = locked_inode_to_wb_and_lock_list(inode);
> +		spin_lock(&inode->i_lock);
> +

We don't want to lock wb->list_lock if the inode was already dirty (which
is a common path). So you want something like:

		if (was_dirty)
			wb = locked_inode_to_wb_and_lock_list(inode);

(and initialize wb to NULL to make sure it does not contain stale value).

> @@ -2409,7 +2414,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  		 * list, based upon its state.
>  		 */
>  		if (inode->i_state & I_SYNC_QUEUED)
> -			goto out_unlock_inode;
> +			goto out_unlock;
>  
>  		/*
>  		 * Only add valid (hashed) inodes to the superblock's
> @@ -2417,22 +2422,19 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  		 */
>  		if (!S_ISBLK(inode->i_mode)) {
>  			if (inode_unhashed(inode))
> -				goto out_unlock_inode;
> +				goto out_unlock;
>  		}
>  		if (inode->i_state & I_FREEING)
> -			goto out_unlock_inode;
> +			goto out_unlock;
>  
>  		/*
>  		 * If the inode was already on b_dirty/b_io/b_more_io, don't
>  		 * reposition it (that would break b_dirty time-ordering).
>  		 */
>  		if (!was_dirty) {
> -			struct bdi_writeback *wb;
>  			struct list_head *dirty_list;
>  			bool wakeup_bdi = false;
>  
> -			wb = locked_inode_to_wb_and_lock_list(inode);
> -
>  			inode->dirtied_when = jiffies;
>  			if (dirtytime)
>  				inode->dirtied_time_when = jiffies;
> @@ -2446,6 +2448,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  							       dirty_list);
>  
>  			spin_unlock(&wb->list_lock);
> +			spin_unlock(&inode->i_lock);
>  			trace_writeback_dirty_inode_enqueue(inode);
>  
>  			/*
> @@ -2460,6 +2463,8 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			return;
>  		}
>  	}
> +out_unlock:
> +	spin_unlock(&wb->list_lock);

wb->list lock will not be locked in some cases here. So you have to be more
careful about when you need to unlock it. Probably something like:

	if (wb)
		spin_unlock(&wb->list_lock);

and you can put this at the end inside the block "if ((inode->i_state &
flags) != flags)".

Also I'd note it is good to test your changes (it would likely uncover the
locking problem). For these filesystem related things xfstests are useful:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
