Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9939FC18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 18:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhFHQMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 12:12:31 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:34672 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhFHQKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:10:55 -0400
Received: by mail-io1-f52.google.com with SMTP id 5so22819167ioe.1;
        Tue, 08 Jun 2021 09:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cTE4/AnO6H2Ubcv28KDqQHb6TT9D2l5yY2mDXkdJZdM=;
        b=IR6RsZjP4hKgq0quvwGieiX7Pkz0MkbkK+hV1aLUhCIoOI0i9OJjLcve5AjQ9QOINM
         ttWQ4AM3B2NE58XJq7j7zHEUaZpxXyCVpE0q/BkUrmOmpFLMyPUJ0brhF04rfB8Xo98s
         RbbfUE3jjm9pQRXUhcs/ipgJxeLqpnS3ckOJmUrdYMeD1B7uUXZjmHBhA6BGPvtDqESb
         98C5rnsxgcRlOujSICKGeU0cplxEfaa4WizfMcXF8BIF5hxb0oicFjqrCnBOJh0Akt9x
         +WmaxA+5WuyE+MrfBzy+lEJrJSZ6mvM/c636bpRjBoLIfoi4KIFdriNxiJqKqfoRdngO
         YtYw==
X-Gm-Message-State: AOAM531DjiPV8WRCkfZAHwjlQ+7SJcGIA/WIfHJozZV7Qkw574n5565q
        RPiSZirLbEpnQ8aI8sW55sM=
X-Google-Smtp-Source: ABdhPJxOERLYOpwhW5mLUOKuZBk+R2Ah85/DTaMSXWZOTPWD8Q4uvD3nTpFs35KPKbsT8rV/HYjRqg==
X-Received: by 2002:a02:6f57:: with SMTP id b23mr17689166jae.55.1623168524928;
        Tue, 08 Jun 2021 09:08:44 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id r11sm67330ilo.10.2021.06.08.09.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:08:44 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:08:43 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v8 8/8] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YL+WC5beBH/N0ddz@google.com>
References: <20210608013123.1088882-1-guro@fb.com>
 <20210608013123.1088882-9-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608013123.1088882-9-guro@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Jun 07, 2021 at 06:31:23PM -0700, Roman Gushchin wrote:
> Asynchronously try to release dying cgwbs by switching attached inodes
> to the nearest living ancestor wb. It helps to get rid of per-cgroup
> writeback structures themselves and of pinned memory and block cgroups,
> which are significantly larger structures (mostly due to large per-cpu
> statistics data). This prevents memory waste and helps to avoid
> different scalability problems caused by large piles of dying cgroups.
> 
> Reuse the existing mechanism of inode switching used for foreign inode
> detection. To speed things up batch up to 115 inode switching in a
> single operation (the maximum number is selected so that the resulting
> struct inode_switch_wbs_context can fit into 1024 bytes). Because
> every switching consists of two steps divided by an RCU grace period,
> it would be too slow without batching. Please note that the whole
> batch counts as a single operation (when increasing/decreasing
> isw_nr_in_flight). This allows to keep umounting working (flush the
> switching queue), however prevents cleanups from consuming the whole
> switching quota and effectively blocking the frn switching.
> 
> A cgwb cleanup operation can fail due to different reasons (e.g. not
> enough memory, the cgwb has an in-flight/pending io, an attached inode
> in a wrong state, etc). In this case the next scheduled cleanup will
> make a new attempt. An attempt is made each time a new cgwb is offlined
> (in other words a memcg and/or a blkcg is deleted by a user). In the
> future an additional attempt scheduled by a timer can be implemented.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/fs-writeback.c                | 102 ++++++++++++++++++++++++++++---
>  include/linux/backing-dev-defs.h |   1 +
>  include/linux/writeback.h        |   1 +
>  mm/backing-dev.c                 |  67 +++++++++++++++++++-
>  4 files changed, 159 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 737ac27adb77..96eb6e6cdbc2 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -225,6 +225,12 @@ void wb_wait_for_completion(struct wb_completion *done)
>  					/* one round can affect upto 5 slots */
>  #define WB_FRN_MAX_IN_FLIGHT	1024	/* don't queue too many concurrently */
>  
> +/*
> + * Maximum inodes per isw.  A specific value has been chosen to make
> + * struct inode_switch_wbs_context fit into 1024 bytes kmalloc.
> + */
> +#define WB_MAX_INODES_PER_ISW	115
> +
>  static atomic_t isw_nr_in_flight = ATOMIC_INIT(0);
>  static struct workqueue_struct *isw_wq;
>  
> @@ -503,6 +509,24 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
>  	atomic_dec(&isw_nr_in_flight);
>  }
>  
> +static bool inode_prepare_wbs_switch(struct inode *inode,
> +				     struct bdi_writeback *new_wb)
> +{
> +	/* while holding I_WB_SWITCH, no one else can update the association */
> +	spin_lock(&inode->i_lock);
> +	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> +	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
> +	    inode_to_wb(inode) == new_wb) {
> +		spin_unlock(&inode->i_lock);
> +		return false;
> +	}
> +	inode->i_state |= I_WB_SWITCH;
> +	__iget(inode);
> +	spin_unlock(&inode->i_lock);
> +
> +	return true;
> +}
> +
>  /**
>   * inode_switch_wbs - change the wb association of an inode
>   * @inode: target inode
> @@ -540,17 +564,8 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	if (!isw->new_wb)
>  		goto out_free;
>  
> -	/* while holding I_WB_SWITCH, no one else can update the association */
> -	spin_lock(&inode->i_lock);
> -	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> -	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
> -	    inode_to_wb(inode) == isw->new_wb) {
> -		spin_unlock(&inode->i_lock);
> +	if (!inode_prepare_wbs_switch(inode, isw->new_wb))
>  		goto out_free;
> -	}
> -	inode->i_state |= I_WB_SWITCH;
> -	__iget(inode);
> -	spin_unlock(&inode->i_lock);
>  
>  	isw->inodes[0] = inode;
>  
> @@ -571,6 +586,73 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	kfree(isw);
>  }
>  
> +/**
> + * cleanup_offline_cgwb - detach associated inodes
> + * @wb: target wb
> + *
> + * Switch all inodes attached to @wb to a nearest living ancestor's wb in order
> + * to eventually release the dying @wb.  Returns %true if not all inodes were
> + * switched and the function has to be restarted.
> + */
> +bool cleanup_offline_cgwb(struct bdi_writeback *wb)
> +{
> +	struct cgroup_subsys_state *memcg_css;
> +	struct inode_switch_wbs_context *isw;
> +	struct inode *inode;
> +	int nr;
> +	bool restart = false;
> +
> +	isw = kzalloc(sizeof(*isw) + WB_MAX_INODES_PER_ISW *
> +		      sizeof(struct inode *), GFP_KERNEL);
> +	if (!isw)
> +		return restart;
> +
> +	atomic_inc(&isw_nr_in_flight);
> +
> +	for (memcg_css = wb->memcg_css->parent; memcg_css;
> +	     memcg_css = memcg_css->parent) {
> +		isw->new_wb = wb_get_lookup(wb->bdi, memcg_css);

Should this be wb_get_create()? I suspect intermediate cgroups wouldn't
have cgwb's due to the no internal process constraint. cgwb's aren't
like blkcgs where they pin the parent and maintain the tree hierarchy.

> +		if (isw->new_wb)
> +			break;
> +	}
> +	if (unlikely(!isw->new_wb))
> +		isw->new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
> +
> +	nr = 0;
> +	spin_lock(&wb->list_lock);
> +	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
> +		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
> +			continue;
> +
> +		isw->inodes[nr++] = inode;
> +
> +		if (nr >= WB_MAX_INODES_PER_ISW - 1) {
> +			restart = true;
> +			break;
> +		}
> +	}
> +	spin_unlock(&wb->list_lock);
> +
> +	/* no attached inodes? bail out */
> +	if (nr == 0) {
> +		atomic_dec(&isw_nr_in_flight);
> +		wb_put(isw->new_wb);
> +		kfree(isw);
> +		return restart;
> +	}
> +
> +	/*
> +	 * In addition to synchronizing among switchers, I_WB_SWITCH tells
> +	 * the RCU protected stat update paths to grab the i_page
> +	 * lock so that stat transfer can synchronize against them.
> +	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
> +	 */
> +	INIT_RCU_WORK(&isw->work, inode_switch_wbs_work_fn);
> +	queue_rcu_work(isw_wq, &isw->work);
> +
> +	return restart;
> +}
> +
>  /**
>   * wbc_attach_and_unlock_inode - associate wbc with target inode and unlock it
>   * @wbc: writeback_control of interest
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 63f52ad2ce7a..1d7edad9914f 100644
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
> index 8e5c5bb16e2d..95de51c10248 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -221,6 +221,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
>  int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
>  			   enum wb_reason reason, struct wb_completion *done);
>  void cgroup_writeback_umount(void);
> +bool cleanup_offline_cgwb(struct bdi_writeback *wb);
>  
>  /**
>   * inode_attach_wb - associate an inode with its wb
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 54c5dc4b8c24..faa45027c854 100644
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
> @@ -395,6 +399,11 @@ static void cgwb_release_workfn(struct work_struct *work)
>  
>  	fprop_local_destroy_percpu(&wb->memcg_completions);
>  	percpu_ref_exit(&wb->refcnt);
> +
> +	spin_lock_irq(&cgwb_lock);
> +	list_del(&wb->offline_node);
> +	spin_unlock_irq(&cgwb_lock);
> +
>  	wb_exit(wb);
>  	WARN_ON_ONCE(!list_empty(&wb->b_attached));
>  	kfree_rcu(wb, rcu);
> @@ -414,6 +423,7 @@ static void cgwb_kill(struct bdi_writeback *wb)
>  	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
>  	list_del(&wb->memcg_node);
>  	list_del(&wb->blkcg_node);
> +	list_add(&wb->offline_node, &offline_cgwbs);
>  	percpu_ref_kill(&wb->refcnt);
>  }
>  
> @@ -635,6 +645,57 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
>  	mutex_unlock(&bdi->cgwb_release_mutex);
>  }
>  
> +/**
> + * cleanup_offline_cgwbs - try to release dying cgwbs
> + *
> + * Try to release dying cgwbs by switching attached inodes to the nearest
> + * living ancestor's writeback. Processed wbs are placed at the end
> + * of the list to guarantee the forward progress.
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
> +		/*
> +		 * If wb is dirty, cleaning up the writeback by switching
> +		 * attached inodes will result in an effective removal of any
> +		 * bandwidth restrictions, which isn't the goal.  Instead,
> +		 * it can be postponed until the next time, when all io
> +		 * will be likely completed.  If in the meantime some inodes
> +		 * will get re-dirtied, they should be eventually switched to
> +		 * a new cgwb.
> +		 */
> +		if (wb_has_dirty_io(wb))
> +			continue;
> +
> +		if (!wb_tryget(wb))
> +			continue;
> +
> +		spin_unlock_irq(&cgwb_lock);
> +		while ((cleanup_offline_cgwb(wb)))
> +			cond_resched();
> +		spin_lock_irq(&cgwb_lock);
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
> @@ -651,6 +712,8 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
>  		cgwb_kill(wb);
>  	memcg_cgwb_list->next = NULL;	/* prevent new wb's */
>  	spin_unlock_irq(&cgwb_lock);
> +
> +	queue_work(system_unbound_wq, &cleanup_offline_cgwbs_work);
>  }
>  
>  /**
> -- 
> 2.31.1
> 

Thanks,
Dennis
