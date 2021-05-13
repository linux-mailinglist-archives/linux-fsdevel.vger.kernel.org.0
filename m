Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A50137F566
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 12:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhEMKNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 06:13:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhEMKNu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 06:13:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5D77AFD5;
        Thu, 13 May 2021 10:12:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AAE351F2C62; Thu, 13 May 2021 12:12:39 +0200 (CEST)
Date:   Thu, 13 May 2021 12:12:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <20210513101239.GE2734@quack2.suse.cz>
References: <20210513004258.1610273-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513004258.1610273-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-05-21 17:42:58, Roman Gushchin wrote:
> When an inode is getting dirty for the first time it's associated
> with a wb structure (see __inode_attach_wb()). It can later be
> switched to another wb (if e.g. some other cgroup is writing a lot of
> data to the same inode), but otherwise stays attached to the original
> wb until being reclaimed.
> 
> The problem is that the wb structure holds a reference to the original
> memory and blkcg cgroups. So if an inode has been dirty once and later
> is actively used in read-only mode, it has a good chance to pin down
> the original memory and blkcg cgroups. This is often the case with
> services bringing data for other services, e.g. updating some rpm
> packages.
> 
> In the real life it becomes a problem due to a large size of the memcg
> structure, which can easily be 1000x larger than an inode. Also a
> really large number of dying cgroups can raise different scalability
> issues, e.g. making the memory reclaim costly and less effective.
> 
> To solve the problem inodes should be eventually detached from the
> corresponding writeback structure. It's inefficient to do it after
> every writeback completion. Instead it can be done whenever the
> original memory cgroup is offlined and writeback structure is getting
> killed. Scanning over a (potentially long) list of inodes and detach
> them from the writeback structure can take quite some time. To avoid
> scanning all inodes, attached inodes are kept on a new list (b_attached).
> To make it less noticeable to a user, the scanning is performed from a
> work context.
> 
> Big thanks to Jan Kara and Dennis Zhou for their ideas and
> contribution to the previous iterations of this patch.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Thanks for the patch! On a general note maybe it would be better to split
this patch into two - the first one which introduces b_attached list and
its handling and the second one which uses it to detach inodes from
bdi_writeback structures. Some more comments below.

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e91980f49388..3deba686d3d4 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -123,12 +123,17 @@ static bool inode_io_list_move_locked(struct inode *inode,
>  
>  	list_move(&inode->i_io_list, head);
>  
> -	/* dirty_time doesn't count as dirty_io until expiration */
> -	if (head != &wb->b_dirty_time)
> -		return wb_io_lists_populated(wb);
> +	if (head == &wb->b_dirty_time || head == &wb->b_attached) {
> +		/*
> +		 * dirty_time doesn't count as dirty_io until expiration,
> +		 * attached list keeps a list of clean inodes, which are
> +		 * attached to wb.
> +		 */
> +		wb_io_lists_depopulated(wb);
> +		return false;
> +	}
>  
> -	wb_io_lists_depopulated(wb);
> -	return false;
> +	return wb_io_lists_populated(wb);
>  }
>  
>  /**
> @@ -545,6 +550,37 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	kfree(isw);
>  }

I suppose the list_empty(&inode->i_io_list) case in
inode_switch_wbs_work_fn() is impossible with your changes now? Can you
perhaps add a WARN_ON_ONCE there for this? Also I don't think we want to
move clean inodes to dirty list so perhaps we need to be more careful about
the selection of target writeback list in that function?

> +/**
> + * cleanup_offline_wb - detach attached clean inodes
> + * @wb: target wb
> + *
> + * Clear the ->i_wb pointer of the attached inodes and drop
> + * the corresponding wb reference. Skip inodes which are dirty,
> + * freeing, switching or in the active writeback process.
> + *
> + */
> +void cleanup_offline_wb(struct bdi_writeback *wb)
> +{
> +	struct inode *inode, *tmp;
> +
> +	spin_lock(&wb->list_lock);
> +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> +		if (!spin_trylock(&inode->i_lock))
> +			continue;
> +		xa_lock_irq(&inode->i_mapping->i_pages);
> +		if (!(inode->i_state &
> +		      (I_FREEING | I_CLEAR | I_SYNC | I_DIRTY | I_WB_SWITCH))) {

Use I_DIRTY_ALL here instead of I_DIRTY? We don't want to touch
I_DIRTY_TIME inodes either I'd say... Also I think you don't want to touch
I_WILL_FREE inodes either.

> +			WARN_ON_ONCE(inode->i_wb != wb);
> +			inode->i_wb = NULL;
> +			wb_put(wb);
> +			list_del_init(&inode->i_io_list);

So I was thinking about this and I'm still a bit nervous that setting i_wb
to NULL is going to cause subtle crashes somewhere. Granted you are very
careful when not to touch the inode but still, even stuff like
inode_to_bdi() is not safe to call with inode->i_wb is NULL. So I'm afraid
that some place in the writeback code will be looking at i_wb without
having any of those bits set and boom. E.g. inode_to_wb() call in
test_clear_page_writeback() - what protects that one?

I forgot what possibilities did we already discuss in the past but cannot
we just switch inode->i_wb to inode_to_bdi(inode)->wb (i.e., root cgroup
writeback structure)? That would be certainly safer...

> +		}
> +		xa_unlock_irq(&inode->i_mapping->i_pages);
> +		spin_unlock(&inode->i_lock);
> +	}
> +	spin_unlock(&wb->list_lock);
> +}
> +
...
> @@ -386,6 +395,10 @@ static void cgwb_release_workfn(struct work_struct *work)
>  	mutex_lock(&wb->bdi->cgwb_release_mutex);
>  	wb_shutdown(wb);
>  
> +	spin_lock_irq(&cgwb_lock);
> +	list_del(&wb->offline_node);
> +	spin_unlock_irq(&cgwb_lock);
> +
>  	css_put(wb->memcg_css);
>  	css_put(wb->blkcg_css);
>  	mutex_unlock(&wb->bdi->cgwb_release_mutex);
> @@ -413,6 +426,7 @@ static void cgwb_kill(struct bdi_writeback *wb)
>  	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
>  	list_del(&wb->memcg_node);
>  	list_del(&wb->blkcg_node);
> +	list_add(&wb->offline_node, &offline_cgwbs);
>  	percpu_ref_kill(&wb->refcnt);
>  }

I think you need to be a bit more careful with the wb->offline_node.
cgwb_create() can end up destroying half-created bdi_writeback structure on
error and then you'd see cgwb_release_workfn() called without cgwb_kill()
called and you'd likely crash or corrupt memory.

>  
> @@ -633,6 +647,48 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
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
> +
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
> +		wb_put(wb);
> +	}
> +
> +	if (!list_empty(&processed))
> +		list_splice_tail(&processed, &offline_cgwbs);
> +
> +	spin_unlock_irq(&cgwb_lock);

Shouldn't we reschedule this work with some delay if offline_cgwbs is
non-empty? Otherwise we can end up with non-empty &offline_cgwbs and no
cleaning scheduled...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
