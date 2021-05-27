Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3EC392C9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhE0LZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 07:25:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:55712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhE0LZi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 07:25:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622114644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCzWseyOGBi3z4zUiXurCHvAdbdxl07NG4gokJyQHA8=;
        b=R8/ZidV+yvu/KKQ4OzSg8KTRZFUZFys8A0QyIL18evZSYIYBAudLWL35WTMX0ZDRe70bVW
        UaxMtcVIhiub5/bMGgJn2pVb6Z6rOWe5cVkRVgEIr9QwicwG3a42JFnkuEdh8ytnfv6XjJ
        YO6JK3aA/zrALdazpTlWBjS/LLOlmeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622114644;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCzWseyOGBi3z4zUiXurCHvAdbdxl07NG4gokJyQHA8=;
        b=VorQAZiK9xkcwZVYHHsk6WE3MPRxb/f8fR7qg3r872Y9XvN+BwGA3kuO0fJBff23Md0fuK
        lbXbhZ5dwAFgUVCA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22CD2AD05;
        Thu, 27 May 2021 11:24:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C9BC61F2C9A; Thu, 27 May 2021 13:24:03 +0200 (CEST)
Date:   Thu, 27 May 2021 13:24:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 2/2] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <20210527112403.GC24486@quack2.suse.cz>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210526222557.3118114-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526222557.3118114-3-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-05-21 15:25:57, Roman Gushchin wrote:
> Asynchronously try to release dying cgwbs by switching clean attached
> inodes to the bdi's wb. It helps to get rid of per-cgroup writeback
> structures themselves and of pinned memory and block cgroups, which
> are way larger structures (mostly due to large per-cpu statistics
> data). It helps to prevent memory waste and different scalability
> problems caused by large piles of dying cgroups.
> 
> A cgwb cleanup operation can fail due to different reasons (e.g. the
> cgwb has in-glight/pending io, an attached inode is locked or isn't
> clean, etc). In this case the next scheduled cleanup will make a new
> attempt. An attempt is made each time a new cgwb is offlined (in other
> words a memcg and/or a blkcg is deleted by a user). In the future an
> additional attempt scheduled by a timer can be implemented.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  fs/fs-writeback.c                | 35 ++++++++++++++++++
>  include/linux/backing-dev-defs.h |  1 +
>  include/linux/writeback.h        |  1 +
>  mm/backing-dev.c                 | 61 ++++++++++++++++++++++++++++++--
>  4 files changed, 96 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 631ef6366293..8fbcd50844f0 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -577,6 +577,41 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	kfree(isw);
>  }
>  
> +/**
> + * cleanup_offline_wb - detach associated clean inodes
> + * @wb: target wb
> + *
> + * Switch the inode->i_wb pointer of the attached inodes to the bdi's wb and
> + * drop the corresponding per-cgroup wb's reference. Skip inodes which are
> + * dirty, freeing, in the active writeback process or are in any way busy.

I think the comment doesn't match the function anymore.

> + */
> +void cleanup_offline_wb(struct bdi_writeback *wb)
> +{
> +	struct inode *inode, *tmp;
> +
> +	spin_lock(&wb->list_lock);
> +restart:
> +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> +		if (!spin_trylock(&inode->i_lock))
> +			continue;
> +		xa_lock_irq(&inode->i_mapping->i_pages);
> +		if ((inode->i_state & I_REFERENCED) != I_REFERENCED) {

Why the I_REFERENCED check here? That's just inode aging bit and I have
hard time seeing how it would relate to whether inode should switch wbs...

> +			struct bdi_writeback *bdi_wb = &inode_to_bdi(inode)->wb;
> +
> +			WARN_ON_ONCE(inode->i_wb != wb);
> +
> +			inode->i_wb = bdi_wb;
> +			list_del_init(&inode->i_io_list);
> +			wb_put(wb);

I was kind of hoping you'll use some variant of inode_switch_wbs() here.
That way we have single function handling all the subtleties of switching
inode->i_wb of an active inode. Maybe it isn't strictly needed here because
you detach only from b_attached list and move to bdi_wb so things are
indeed simpler here. But you definitely miss transferring WB_WRITEBACK stat
and I'd also like to have a comment here explaining why this cannot race
with other writeback handling or wb switching in a harmful way.

> +		}
> +		xa_unlock_irq(&inode->i_mapping->i_pages);
> +		spin_unlock(&inode->i_lock);
> +		if (cond_resched_lock(&wb->list_lock))
> +			goto restart;
> +	}
> +	spin_unlock(&wb->list_lock);
> +}
> +
>  /**
>   * wbc_attach_and_unlock_inode - associate wbc with target inode and unlock it
>   * @wbc: writeback_control of interest
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index e5dc238ebe4f..07d6b6d6dbdf 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -155,6 +155,7 @@ struct bdi_writeback {
>  	struct list_head memcg_node;	/* anchored at memcg->cgwb_list */
>  	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
>  	struct list_head b_attached;	/* attached inodes, protected by list_lock */
> +	struct list_head offline_node;	/* anchored at offline_cgwbs */
>  
>  	union {
>  		struct work_struct release_work;
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 572a13c40c90..922f15fe6ad4 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -222,6 +222,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
>  int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
>  			   enum wb_reason reason, struct wb_completion *done);
>  void cgroup_writeback_umount(void);
> +void cleanup_offline_wb(struct bdi_writeback *wb);
>  
>  /**
>   * inode_attach_wb - associate an inode with its wb
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 54c5dc4b8c24..92a00bcaa504 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -371,12 +371,16 @@ static void wb_exit(struct bdi_writeback *wb)
>  #include <linux/memcontrol.h>
>  
>  /*
> - * cgwb_lock protects bdi->cgwb_tree, blkcg->cgwb_list, and memcg->cgwb_list.
> - * bdi->cgwb_tree is also RCU protected.
> + * cgwb_lock protects bdi->cgwb_tree, blkcg->cgwb_list, offline_cgwbs and
> + * memcg->cgwb_list.  bdi->cgwb_tree is also RCU protected.
>   */
>  static DEFINE_SPINLOCK(cgwb_lock);
>  static struct workqueue_struct *cgwb_release_wq;
>  
> +static LIST_HEAD(offline_cgwbs);
> +static void cleanup_offline_cgwbs_workfn(struct work_struct *work);
> +static DECLARE_WORK(cleanup_offline_cgwbs_work, cleanup_offline_cgwbs_workfn);
> +
>  static void cgwb_release_workfn(struct work_struct *work)
>  {
>  	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
> @@ -395,6 +399,7 @@ static void cgwb_release_workfn(struct work_struct *work)
>  
>  	fprop_local_destroy_percpu(&wb->memcg_completions);
>  	percpu_ref_exit(&wb->refcnt);
> +	WARN_ON(!list_empty(&wb->offline_node));

Hum, cannot this happen when when wb had originally some attached inodes,
we added it to offline_cgwbs but then normal inode reclaim cleaned all the
inodes (and thus all wb refs were dropped) before
cleanup_offline_cgwbs_workfn() was executed? So either the offline_cgwbs
list has to hold its own wb ref or we have to remove cgwb from the list
in cgwb_release_workfn().

>  	wb_exit(wb);
>  	WARN_ON_ONCE(!list_empty(&wb->b_attached));
>  	kfree_rcu(wb, rcu);
> @@ -414,6 +419,10 @@ static void cgwb_kill(struct bdi_writeback *wb)
>  	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
>  	list_del(&wb->memcg_node);
>  	list_del(&wb->blkcg_node);
> +	if (!list_empty(&wb->b_attached))
> +		list_add(&wb->offline_node, &offline_cgwbs);
> +	else
> +		INIT_LIST_HEAD(&wb->offline_node);
>  	percpu_ref_kill(&wb->refcnt);
>  }
>  
> @@ -635,6 +644,50 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
>  	mutex_unlock(&bdi->cgwb_release_mutex);
>  }
>  
> +/**
> + * cleanup_offline_cgwbs - try to release dying cgwbs
> + *
> + * Try to release dying cgwbs by switching attached inodes to the wb
> + * belonging to the root memory cgroup. Processed wbs are placed at the
> + * end of the list to guarantee the forward progress.
> + *
> + * Should be called with the acquired cgwb_lock lock, which might
> + * be released and re-acquired in the process.
> + */
> +static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> +{
> +	struct bdi_writeback *wb;
> +	LIST_HEAD(processed);
> +
> +	spin_lock_irq(&cgwb_lock);
> +
> +	while (!list_empty(&offline_cgwbs)) {
> +		wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
> +				      offline_node);
> +		list_move(&wb->offline_node, &processed);
> +
> +		if (wb_has_dirty_io(wb))
> +			continue;
> +
> +		if (!percpu_ref_tryget(&wb->refcnt))
> +			continue;
> +
> +		spin_unlock_irq(&cgwb_lock);
> +		cleanup_offline_wb(wb);
> +		spin_lock_irq(&cgwb_lock);
> +
> +		if (list_empty(&wb->b_attached))
> +			list_del_init(&wb->offline_node);

But the cgwb can still have inodes in its dirty lists which will eventually
move to b_attached. So you can delete cgwb here prematurely, cannot you?

> +
> +		wb_put(wb);
> +	}
> +
> +	if (!list_empty(&processed))
> +		list_splice_tail(&processed, &offline_cgwbs);
> +
> +	spin_unlock_irq(&cgwb_lock);
> +}
> +
>  /**
>   * wb_memcg_offline - kill all wb's associated with a memcg being offlined
>   * @memcg: memcg being offlined
> @@ -650,6 +703,10 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
>  	list_for_each_entry_safe(wb, next, memcg_cgwb_list, memcg_node)
>  		cgwb_kill(wb);
>  	memcg_cgwb_list->next = NULL;	/* prevent new wb's */
> +
> +	if (!list_empty(&offline_cgwbs))
> +		schedule_work(&cleanup_offline_cgwbs_work);
> +
>  	spin_unlock_irq(&cgwb_lock);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
