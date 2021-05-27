Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB051392BE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 12:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbhE0Kgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 06:36:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:35468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235950AbhE0Kgw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 06:36:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622111718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKeWyMslRymydNZYkpyt3KIJnWWdPC8N5vsKLAeXxkk=;
        b=MrOVRApbXSfo3sXyu/0I4+/xFzkBPqDuDMHEqn4RsvKGQLzvHR0Ji664xDCzrkldu85/PR
        SIAMXq7ewXoXHbGtLQzRH/5glKs3uEgb4Y7e8Ny6N5wmOVY67juJa2P4m0jz4wn4R2hFG1
        eylXN5PREwmXm37BNlzAdVmTFCyLwaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622111718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKeWyMslRymydNZYkpyt3KIJnWWdPC8N5vsKLAeXxkk=;
        b=5IsU0rzvPUrM8nmqDbmT11uJJLru3+b1xDtsPVTkTSeqx5Ui9HWCk7SoytjfsiCZzb+jwO
        JOqpkM2qJSN0kKCg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A41BABC1;
        Thu, 27 May 2021 10:35:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D95901F2C9A; Thu, 27 May 2021 12:35:17 +0200 (CEST)
Date:   Thu, 27 May 2021 12:35:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 1/2] writeback, cgroup: keep list of inodes attached
 to bdi_writeback
Message-ID: <20210527103517.GA24486@quack2.suse.cz>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210526222557.3118114-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526222557.3118114-2-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-05-21 15:25:56, Roman Gushchin wrote:
> Currently there is no way to iterate over inodes attached to a
> specific cgwb structure. It limits the ability to efficiently
> reclaim the writeback structure itself and associated memory and
> block cgroup structures without scanning all inodes belonging to a sb,
> which can be prohibitively expensive.
> 
> While dirty/in-active-writeback an inode belongs to one of the
> bdi_writeback's io lists: b_dirty, b_io, b_more_io and b_dirty_time.
> Once cleaned up, it's removed from all io lists. So the
> inode->i_io_list can be reused to maintain the list of inodes,
> attached to a bdi_writeback structure.
> 
> This patch introduces a new wb->b_attached list, which contains all
> inodes which were dirty at least once and are attached to the given
> cgwb. Inodes attached to the root bdi_writeback structures are never
> placed on such list. The following patch will use this list to try to
> release cgwbs structures more efficiently.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Looks good. Just some minor nits below:

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e91980f49388..631ef6366293 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -135,18 +135,23 @@ static bool inode_io_list_move_locked(struct inode *inode,
>   * inode_io_list_del_locked - remove an inode from its bdi_writeback IO list
>   * @inode: inode to be removed
>   * @wb: bdi_writeback @inode is being removed from
> + * @final: inode is going to be freed and can't reappear on any IO list
>   *
>   * Remove @inode which may be on one of @wb->b_{dirty|io|more_io} lists and
>   * clear %WB_has_dirty_io if all are empty afterwards.
>   */
>  static void inode_io_list_del_locked(struct inode *inode,
> -				     struct bdi_writeback *wb)
> +				     struct bdi_writeback *wb,
> +				     bool final)
>  {
>  	assert_spin_locked(&wb->list_lock);
>  	assert_spin_locked(&inode->i_lock);
>  
>  	inode->i_state &= ~I_SYNC_QUEUED;
> -	list_del_init(&inode->i_io_list);
> +	if (final)
> +		list_del_init(&inode->i_io_list);
> +	else
> +		inode_cgwb_move_to_attached(inode, wb);
>  	wb_io_lists_depopulated(wb);
>  }

With these changes the naming is actually somewhat confusing and the bool
argument makes it even worse. Looking into the code I'd just fold
inode_io_list_del_locked() into inode_io_list_del() and make it really
delete inode from all IO lists. There are currently three other
inode_io_list_del_locked() users:

requeue_inode(), writeback_single_inode() - these should just call
inode_cgwb_move_to_attached() unconditionally
(inode_cgwb_move_to_attached() just needs to clear I_SYNC_QUEUED and call
wb_io_lists_depopulated() in addition to what it currently does).

inode_switch_wbs_work_fn() - I don't think it needs
inode_io_list_del_locked() at all. See below...

> @@ -278,6 +283,25 @@ void __inode_attach_wb(struct inode *inode, struct page *page)
>  }
>  EXPORT_SYMBOL_GPL(__inode_attach_wb);
>  
> +/**
> + * inode_cgwb_move_to_attached - put the inode onto wb->b_attached list
> + * @inode: inode of interest with i_lock held
> + * @wb: target bdi_writeback
> + *
> + * Remove the inode from wb's io lists and if necessarily put onto b_attached
> + * list.  Only inodes attached to cgwb's are kept on this list.
> + */
> +void inode_cgwb_move_to_attached(struct inode *inode, struct bdi_writeback *wb)
> +{
> +	assert_spin_locked(&wb->list_lock);
> +	assert_spin_locked(&inode->i_lock);
> +
> +	if (wb != &wb->bdi->wb)
> +		list_move(&inode->i_io_list, &wb->b_attached);
> +	else
> +		list_del_init(&inode->i_io_list);
> +}

I think this can be static and you can drop the declarations from header
files below. At least I wasn't able to find where this would be used
outside of fs/writeback.c.

>  /**
>   * locked_inode_to_wb_and_lock_list - determine a locked inode's wb and lock it
>   * @inode: inode of interest with i_lock held
> @@ -419,21 +443,29 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
>  	wb_get(new_wb);
>  
>  	/*
> -	 * Transfer to @new_wb's IO list if necessary.  The specific list
> -	 * @inode was on is ignored and the inode is put on ->b_dirty which
> -	 * is always correct including from ->b_dirty_time.  The transfer
> -	 * preserves @inode->dirtied_when ordering.
> +	 * Transfer to @new_wb's IO list if necessary.  If the @inode is dirty,
> +	 * the specific list @inode was on is ignored and the @inode is put on
> +	 * ->b_dirty which is always correct including from ->b_dirty_time.
> +	 * The transfer preserves @inode->dirtied_when ordering.  If the @inode
> +	 * was clean, it means it was on the b_attached list, so move it onto
> +	 * the b_attached list of @new_wb.
>  	 */
>  	if (!list_empty(&inode->i_io_list)) {
> -		struct inode *pos;
> -
> -		inode_io_list_del_locked(inode, old_wb);
> +		inode_io_list_del_locked(inode, old_wb, true);

Do we need inode_io_list_del_locked() here at all? Below we are careful
enough to always use list_move() which does the deletion for us anyway.

>  		inode->i_wb = new_wb;
> -		list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
> -			if (time_after_eq(inode->dirtied_when,
> -					  pos->dirtied_when))
> -				break;
> -		inode_io_list_move_locked(inode, new_wb, pos->i_io_list.prev);
> +
> +		if (inode->i_state & I_DIRTY_ALL) {
> +			struct inode *pos;
> +
> +			list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
> +				if (time_after_eq(inode->dirtied_when,
> +						  pos->dirtied_when))
> +					break;
> +			inode_io_list_move_locked(inode, new_wb,
> +						  pos->i_io_list.prev);
> +		} else {
> +			inode_cgwb_move_to_attached(inode, new_wb);
> +		}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
