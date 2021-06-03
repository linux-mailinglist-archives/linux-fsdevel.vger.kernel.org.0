Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61D9399E60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCKEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 06:04:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCKET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:04:19 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 964611FD4D;
        Thu,  3 Jun 2021 10:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622714553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dh0UDqgtoIpaCnDNzgxe583YJhS7IyJNOaKi3jLR8xQ=;
        b=zTNkr1I7SLhfgokuQ4HQ9Wf462nHXNIXolgssVNpQB9zbLgA6ldHls1lXZ4v5zJZnJ/AkA
        qoVWqAPczQzrYaP4rnwBrHW8jYHiw6gXaL+h2l5K2+sLYwk8UdHwFVrllpQmDkAkfPPoQQ
        Xm1woH4QUV4jfLVyMQEWg7TXNi0e1SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622714553;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dh0UDqgtoIpaCnDNzgxe583YJhS7IyJNOaKi3jLR8xQ=;
        b=msHeINMzZkvrUzsy2h43G3xxhnKK/3JcTrBqPvgIIQMnMl3xTPlbGJU7YmNEsh0a0dCsk0
        qClACpit26eIUqCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 6A474A3B88;
        Thu,  3 Jun 2021 10:02:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 45C961F2C98; Thu,  3 Jun 2021 12:02:33 +0200 (CEST)
Date:   Thu, 3 Jun 2021 12:02:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 5/5] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <20210603100233.GG23647@quack2.suse.cz>
References: <20210603005517.1403689-1-guro@fb.com>
 <20210603005517.1403689-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603005517.1403689-6-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-06-21 17:55:17, Roman Gushchin wrote:
> Asynchronously try to release dying cgwbs by switching attached inodes
> to the bdi's wb. It helps to get rid of per-cgroup writeback
> structures themselves and of pinned memory and block cgroups, which
> are significantly larger structures (mostly due to large per-cpu
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

I think we are getting close :). Some comments are below.

> ---
>  fs/fs-writeback.c                | 68 ++++++++++++++++++++++++++++++++
>  include/linux/backing-dev-defs.h |  1 +
>  include/linux/writeback.h        |  1 +
>  mm/backing-dev.c                 | 58 ++++++++++++++++++++++++++-
>  4 files changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 49d7b23a7cfe..e8517ad677eb 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -225,6 +225,8 @@ void wb_wait_for_completion(struct wb_completion *done)
>  					/* one round can affect upto 5 slots */
>  #define WB_FRN_MAX_IN_FLIGHT	1024	/* don't queue too many concurrently */
>  
> +#define WB_MAX_INODES_PER_ISW	116	/* maximum inodes per isw */
> +

Why this number? Please add an explanation here...

>  static atomic_t isw_nr_in_flight = ATOMIC_INIT(0);
>  static struct workqueue_struct *isw_wq;
>  
> @@ -552,6 +554,72 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	kfree(isw);
>  }
>  
> +/**
> + * cleanup_offline_cgwb - detach associated inodes
> + * @wb: target wb
> + *
> + * Switch all inodes attached to @wb to the bdi's root wb in order to eventually
> + * release the dying @wb.  Returns %true if not all inodes were switched and
> + * the function has to be restarted.
> + */
> +bool cleanup_offline_cgwb(struct bdi_writeback *wb)
> +{
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
> +	/* no need to call wb_get() here: bdi's root wb is not refcounted */
> +	isw->new_wb = &wb->bdi->wb;
> +
> +	nr = 0;
> +	spin_lock(&wb->list_lock);
> +	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
> +		spin_lock(&inode->i_lock);
> +		if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> +		    inode->i_state & (I_WB_SWITCH | I_FREEING) ||
> +		    inode_to_wb(inode) == isw->new_wb) {
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
> +		inode->i_state |= I_WB_SWITCH;
> +		__iget(inode);
> +		spin_unlock(&inode->i_lock);

This hunk is identical with the one in inode_switch_wbs(). Maybe create a
helper for it like inode_prepare_wb_switch() or something like that. Also
we need to check for I_WILL_FREE flag as well as I_FREEING (see the code in
iput_final()) - that's actually a bug in inode_switch_wbs() as well so
probably a separate fix for that should come earlier in the series.

> +
> +		isw->inodes[nr++] = inode;

At first it seemed a bit silly to allocate an array of inode pointers when
we have them in the list. But after some thought I agree that dealing with
other switching being triggered from other sources in parallel would be
really difficult so your decision makes sense. Just maybe add an
explanation in a comment somewhere about this design decision.

> +
> +		if (nr >= WB_MAX_INODES_PER_ISW - 1) {
> +			restart = true;
> +			break;
> +		}
> +	}
> +	spin_unlock(&wb->list_lock);

...

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

Maybe explain in a comment why skipping wbs with dirty inodes is fine?
Because honestly, I'm not sure... I guess the rationale is that inodes
should get cleaned eventually and if they are getting redirtied, they will
be switched to another wb anyway?

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

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
