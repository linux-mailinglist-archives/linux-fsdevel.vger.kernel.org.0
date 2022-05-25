Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9A4533C7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiEYMOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 08:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiEYMOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 08:14:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74955A76D7
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 05:13:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2FE44219BB;
        Wed, 25 May 2022 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653480832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDn2jcOjILNzT5C5TbrbqAvZLA0JG5ArhG4Q2KPLEho=;
        b=Q65i8WNJuqU2Z+TpApgby3Z/mvDq/vlZ0F6k50X70UbuUoylXLL/EdHsIxx3JxNyxhleV4
        BCT7QEkuxVrzOzjo6Q6Q+m7W0+oIjPJw2AqBzDdwkhBsGOOB8l+qV/3IvEx1TajLWTtDYM
        BGMiZIveHxJTl2QYAF1DPK7iInhgW3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653480832;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDn2jcOjILNzT5C5TbrbqAvZLA0JG5ArhG4Q2KPLEho=;
        b=tBC0wnycGkp+0mpVvwCIyAs83zqQfibl7pRvw7rVw1SjIo+ve+mIzkOvn1antpRTpVMdEY
        ETUb33ECuRiRxiAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 055C72C141;
        Wed, 25 May 2022 12:13:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B8EACA0632; Wed, 25 May 2022 14:13:51 +0200 (CEST)
Date:   Wed, 25 May 2022 14:13:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jchao Sun <sunjunchao2870@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz
Subject: Re: [PATCH v5] writeback: Fix inode->i_io_list not be protected by
 inode->i_lock error
Message-ID: <20220525121351.ixs2yjcnk7ockvuv@quack3.lan>
References: <20220524150540.12552-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524150540.12552-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-05-22 08:05:40, Jchao Sun wrote:
> Commit b35250c0816c ("writeback: Protect inode->i_io_list with
> inode->i_lock") made inode->i_io_list not only protected by
> wb->list_lock but also inode->i_lock, but inode_io_list_move_locked()
> was missed. Add lock there and also update comment describing
> things protected by inode->i_lock. This also fixes a race where
> __mark_inode_dirty() could move inode under flush worker's hands
> and thus sync(2) could miss writing some inodes.
> 
> Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
> Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>

Thanks for the fix! It looks good to me now (modulo some too long comment
lines but I can wrap those on commit). I'll take the patch to my tree once
I push out stuff I have ready for the merge window.

								Honza

> ---
>  fs/fs-writeback.c | 37 ++++++++++++++++++++++++++++---------
>  fs/inode.c        |  2 +-
>  2 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 591fe9cf1659..99793bb838e5 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -120,6 +120,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
>  				      struct list_head *head)
>  {
>  	assert_spin_locked(&wb->list_lock);
> +	assert_spin_locked(&inode->i_lock);
>  
>  	list_move(&inode->i_io_list, head);
>  
> @@ -1365,9 +1366,9 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>  		inode = wb_inode(delaying_queue->prev);
>  		if (inode_dirtied_after(inode, dirtied_before))
>  			break;
> +		spin_lock(&inode->i_lock);
>  		list_move(&inode->i_io_list, &tmp);
>  		moved++;
> -		spin_lock(&inode->i_lock);
>  		inode->i_state |= I_SYNC_QUEUED;
>  		spin_unlock(&inode->i_lock);
>  		if (sb_is_blkdev_sb(inode->i_sb))
> @@ -1383,7 +1384,12 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>  		goto out;
>  	}
>  
> -	/* Move inodes from one superblock together */
> +	/*
> +	 * Although inode's i_io_list is moved from 'tmp' to 'dispatch_queue',
> +	 * we don't take inode->i_lock here because it is just a pointless overhead.
> +	 * Inode is already marked as I_SYNC_QUEUED so writeback list handling is
> +	 * fully under our control.
> +	 */
>  	while (!list_empty(&tmp)) {
>  		sb = wb_inode(tmp.prev)->i_sb;
>  		list_for_each_prev_safe(pos, node, &tmp) {
> @@ -1821,8 +1827,8 @@ static long writeback_sb_inodes(struct super_block *sb,
>  			 * We'll have another go at writing back this inode
>  			 * when we completed a full scan of b_io.
>  			 */
> -			spin_unlock(&inode->i_lock);
>  			requeue_io(inode, wb);
> +			spin_unlock(&inode->i_lock);
>  			trace_writeback_sb_inodes_requeue(inode);
>  			continue;
>  		}
> @@ -2351,6 +2357,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	int dirtytime = 0;
> +	struct bdi_writeback *wb = NULL;
>  
>  	trace_writeback_mark_inode_dirty(inode, flags);
>  
> @@ -2402,6 +2409,17 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			inode->i_state &= ~I_DIRTY_TIME;
>  		inode->i_state |= flags;
>  
> +		/*
> +		 * Grab inode's wb early because it requires dropping i_lock and we
> +		 * need to make sure following checks happen atomically with dirty
> +		 * list handling so that we don't move inodes under flush worker's
> +		 * hands.
> +		 */
> +		if (!was_dirty) {
> +			wb = locked_inode_to_wb_and_lock_list(inode);
> +			spin_lock(&inode->i_lock);
> +		}
> +
>  		/*
>  		 * If the inode is queued for writeback by flush worker, just
>  		 * update its dirty state. Once the flush worker is done with
> @@ -2409,7 +2427,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  		 * list, based upon its state.
>  		 */
>  		if (inode->i_state & I_SYNC_QUEUED)
> -			goto out_unlock_inode;
> +			goto out_unlock;
>  
>  		/*
>  		 * Only add valid (hashed) inodes to the superblock's
> @@ -2417,22 +2435,19 @@ void __mark_inode_dirty(struct inode *inode, int flags)
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
> @@ -2446,6 +2461,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  							       dirty_list);
>  
>  			spin_unlock(&wb->list_lock);
> +			spin_unlock(&inode->i_lock);
>  			trace_writeback_dirty_inode_enqueue(inode);
>  
>  			/*
> @@ -2460,6 +2476,9 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			return;
>  		}
>  	}
> +out_unlock:
> +	if (wb)
> +		spin_unlock(&wb->list_lock);
>  out_unlock_inode:
>  	spin_unlock(&inode->i_lock);
>  }
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d9b422504d1..bd4da9c5207e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -27,7 +27,7 @@
>   * Inode locking rules:
>   *
>   * inode->i_lock protects:
> - *   inode->i_state, inode->i_hash, __iget()
> + *   inode->i_state, inode->i_hash, __iget(), inode->i_io_list
>   * Inode LRU list locks protect:
>   *   inode->i_sb->s_inode_lru, inode->i_lru
>   * inode->i_sb->s_inode_list_lock protects:
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
