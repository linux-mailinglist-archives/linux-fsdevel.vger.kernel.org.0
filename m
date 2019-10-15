Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AFAD71D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfJOJJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 05:09:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfJOJJi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:09:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5937AB39B;
        Tue, 15 Oct 2019 09:09:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 19D791E4A8A; Tue, 15 Oct 2019 11:09:33 +0200 (CEST)
Date:   Tue, 15 Oct 2019 11:09:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH v2] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <20191015090933.GA21104@quack2.suse.cz>
References: <20191010234036.2860655-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010234036.2860655-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-10-19 16:40:36, Roman Gushchin wrote:
> We've noticed that the number of dying cgroups on our production hosts
> tends to grow with the uptime. This time it's caused by the writeback
> code.
> 
> An inode which is getting dirty for the first time is associated
> with the wb structure (look at __inode_attach_wb()). It can later
> be switched to another wb under some conditions (e.g. some other
> cgroup is writing a lot of data to the same inode), but generally
> stays associated up to the end of life of the inode structure.
> 
> The problem is that the wb structure holds a reference to the original
> memory cgroup. So if an inode has been dirty once, it has a good chance
> to pin down the original memory cgroup.
> 
> An example from the real life: some service runs periodically and
> updates rpm packages. Each time in a new memory cgroup. Installed
> .so files are heavily used by other cgroups, so corresponding inodes
> tend to stay alive for a long. So do pinned memory cgroups.
> In production I've seen many hosts with 1-2 thousands of dying
> cgroups.
> 
> This is not the first problem with the dying memory cgroups. As
> always, the problem is with their relative size: memory cgroups
> are large objects, easily 100x-1000x larger that inodes. So keeping
> a couple of thousands of dying cgroups in memory without a good reason
> (what we easily do with inodes) is quite costly (and is measured
> in tens and hundreds of Mb).
> 
> To solve this problem let's perform a periodic scan of inodes
> attached to the dying wbs, and detach those of them, which are clean
> and don't have an active io operation.
> That will eventually release the wb structure and corresponding
> memory cgroup.
> 
> To make this scanning effective, let's keep a list of attached
> inodes. inode->i_io_list can be reused for this purpose.
> 
> The scan is performed from the cgroup offlining path. Dying wbs
> are placed on the global list. On each cgroup removal we traverse
> the whole list ignoring wbs with active io operations. That will
> allow the majority of io operations to be finished after the
> removal of the cgroup.
> 
> Big thanks to Jan Kara and Dennis Zhou for their ideas and
> contribution to this patch.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  fs/fs-writeback.c                | 52 +++++++++++++++++++++++---
>  include/linux/backing-dev-defs.h |  2 +
>  include/linux/writeback.h        |  1 +
>  mm/backing-dev.c                 | 63 ++++++++++++++++++++++++++++++--
>  4 files changed, 108 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e88421d9a48d..c792db951274 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -136,16 +136,21 @@ static bool inode_io_list_move_locked(struct inode *inode,
>   * inode_io_list_del_locked - remove an inode from its bdi_writeback IO list
>   * @inode: inode to be removed
>   * @wb: bdi_writeback @inode is being removed from
> + * @keep_attached: keep the inode on the list of inodes attached to wb
>   *
>   * Remove @inode which may be on one of @wb->b_{dirty|io|more_io} lists and
>   * clear %WB_has_dirty_io if all are empty afterwards.
>   */
>  static void inode_io_list_del_locked(struct inode *inode,
> -				     struct bdi_writeback *wb)
> +				     struct bdi_writeback *wb,
> +				     bool keep_attached)
>  {
>  	assert_spin_locked(&wb->list_lock);
>  
> -	list_del_init(&inode->i_io_list);
> +	if (keep_attached)
> +		list_move(&inode->i_io_list, &wb->b_attached);
> +	else
> +		list_del_init(&inode->i_io_list);
>  	wb_io_lists_depopulated(wb);
>  }

Rather than adding this (somewhat ugly) bool argument to
inode_io_list_del_locked() I'd teach inode_io_list_move_locked() about the
new b_attached list and use that function where needed...

> @@ -426,7 +431,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
>  	if (!list_empty(&inode->i_io_list)) {
>  		struct inode *pos;
>  
> -		inode_io_list_del_locked(inode, old_wb);
> +		inode_io_list_del_locked(inode, old_wb, false);
>  		inode->i_wb = new_wb;
>  		list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
>  			if (time_after_eq(inode->dirtied_when,

This bit looks wrong. Not the change you made as such but the fact that you
can now move inode from b_attached list of old wb to the dirty list of new
wb.

> @@ -544,6 +549,41 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	kfree(isw);
>  }
>  
> +/**
> + * cleanup_offline_wb - detach attached clean inodes
> + * @wb: target wb
> + *
> + * Clear the ->i_wb pointer of the attached inodes and drop
> + * the corresponding wb reference. Skip inodes which are dirty,
> + * freeing, switching or in the active writeback process.
> + */
> +void cleanup_offline_wb(struct bdi_writeback *wb)
> +{
> +	struct inode *inode, *tmp;
> +	bool ret = true;
> +
> +	spin_lock(&wb->list_lock);
> +	if (list_empty(&wb->b_attached))
> +		goto unlock;

What's the point of this check? list_for_each_entry_safe() below will just
do the same...

> +
> +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> +		if (!spin_trylock(&inode->i_lock))
> +			continue;
> +		xa_lock_irq(&inode->i_mapping->i_pages);
> +		if (!(inode->i_state &
> +		      (I_FREEING | I_CLEAR | I_SYNC | I_DIRTY | I_WB_SWITCH))) {
> +			WARN_ON_ONCE(inode->i_wb != wb);
> +			inode->i_wb = NULL;
> +			wb_put(wb);

Hum, currently the code assumes that once i_wb is set, it never becomes
NULL again. In particular the inode e.g. in
fs/fs-writeback.c:inode_congested() or generally unlocked_inode_to_wb_begin()
users could get broken by this. The i_wb switching code is so complex
exactly because of these interactions.

Maybe you thought through the interactions and things are actually fine but
if nothing else you'd need a big fat comment here explaining why this is
fine and update inode_congested() comments etc.

> +			list_del_init(&inode->i_io_list);
> +		}
> +		xa_unlock_irq(&inode->i_mapping->i_pages);
> +		spin_unlock(&inode->i_lock);
> +	}
> +unlock:
> +	spin_unlock(&wb->list_lock);
> +}
> +

...

> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 4fc87dee005a..68b167fda259 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -137,6 +137,7 @@ struct bdi_writeback {
>  	struct list_head b_io;		/* parked for writeback */
>  	struct list_head b_more_io;	/* parked for more writeback */
>  	struct list_head b_dirty_time;	/* time stamps are dirty */
> +	struct list_head b_attached;	/* attached inodes */

Maybe
	/* clean inodes pointing to this wb through inode->i_wb */
would be more explanatory?

>  	spinlock_t list_lock;		/* protects the b_* lists */
>  
>  	struct percpu_counter stat[NR_WB_STAT_ITEMS];

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
