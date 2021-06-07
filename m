Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744A939D8A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 11:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFGJ0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 05:26:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51572 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFGJ0T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:26:19 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5C98021A77;
        Mon,  7 Jun 2021 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623057867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOGqKzhgYBJUkisx6oR/UwgWtkESGg4b4M95r4DmGTI=;
        b=RHJf4Ncr9dO+xsOPBtLRHE1rorrlDHdCJJd7DFdJMbVN7t6sajjX1WUKCkU/cXqj7aumpD
        ypKijwCm3L7FH663RzmWVnu78qAPyoo6UpPzb79Mmyn7UXPxxUg0yQVqz2o+qe3bDsKARn
        VB+f25tYzJLQIsrygL+mZa4GCzzqJec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623057867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOGqKzhgYBJUkisx6oR/UwgWtkESGg4b4M95r4DmGTI=;
        b=kCa0g89MrqPSIr0lJH3aSBO0+i1rwcBuOCWK+iyzQiYcDpMAv6LCcUJ3nYp3TQ8UmcoBal
        X1sGKzfbjppGizCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 107E3A3B83;
        Mon,  7 Jun 2021 09:24:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DE08D1F2CA8; Mon,  7 Jun 2021 11:24:26 +0200 (CEST)
Date:   Mon, 7 Jun 2021 11:24:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v7 6/6] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <20210607092426.GC30275@quack2.suse.cz>
References: <20210604013159.3126180-1-guro@fb.com>
 <20210604013159.3126180-7-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604013159.3126180-7-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-06-21 18:31:59, Roman Gushchin wrote:
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

Hum, your comment about unmount made me think... Isn't all that stuff racy?
generic_shutdown_super() has:
                sync_filesystem(sb);
                sb->s_flags &= ~SB_ACTIVE;

                cgroup_writeback_umount();

and cgroup_writeback_umount() is:
        if (atomic_read(&isw_nr_in_flight)) {
                /*
                 * Use rcu_barrier() to wait for all pending callbacks to
                 * ensure that all in-flight wb switches are in the workqueue.
                 */
                rcu_barrier();
                flush_workqueue(isw_wq);
	}

So we are clearly missing a smp_mb() here (likely in
cgroup_writeback_umount()) as clearing of SB_ACTIVE needs to be reliably
happing before atomic_read(&isw_nr_in_flight).

Also ...

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
> +	atomic_inc(&isw_nr_in_flight);

... the increment of isw_nr_in_flight needs to happen before we start to
grab any inodes. Otherwise unmount can pass past cgroup_writeback_umount()
while we are still holding inode references in cleanup_offline_cgwb() the
result will be "Busy inodes after unmount." message and use-after-free
issues (with inode->i_sb which gets freed).

Frankly, I think much safer option would be to wait in evict() for
I_WB_SWITCH similarly as we wait for I_SYNC (through
inode_wait_for_writeback()). And with that we can do away with
cgroup_writeback_umount() altogether. But I guess that's out of scope of
this series.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
