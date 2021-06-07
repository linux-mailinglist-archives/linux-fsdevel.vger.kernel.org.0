Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CFF39D816
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFGJCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 05:02:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39942 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGJCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:02:42 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0E2811FDA1;
        Mon,  7 Jun 2021 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623056451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DFwjE+z0lEnHuGuwIYHSS4DoT9tAvhOIoQsNTyBPlnM=;
        b=VuRCo59JDusjwHbv+PStigZT0YwYXb/tebQ1vXZ0UVQnqBo5rqB/hFPdQ06Fqg6AjxPWcy
        8bps4sK7FRMUnTGuDqO04nD55v4L9g4AY4+h5uRRVh4RDXRHeZFrFiilL41cMM1FJzDX2Z
        fTvU4dBVVGT3u1yvLS8spxbEpBVSz9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623056451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DFwjE+z0lEnHuGuwIYHSS4DoT9tAvhOIoQsNTyBPlnM=;
        b=dvuqxgkOnkTb3+9ojbmnjKhQmf56EjBAmcKknZ9R4oLVY96dmknVeGlsSgs+dH/VdzYupR
        tktAfWrOLyy6DfCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id D23F9A3B89;
        Mon,  7 Jun 2021 09:00:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AC05B1F2CA8; Mon,  7 Jun 2021 11:00:50 +0200 (CEST)
Date:   Mon, 7 Jun 2021 11:00:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v7 5/6] writeback, cgroup: support switching multiple
 inodes at once
Message-ID: <20210607090050.GB30275@quack2.suse.cz>
References: <20210604013159.3126180-1-guro@fb.com>
 <20210604013159.3126180-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604013159.3126180-6-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-06-21 18:31:58, Roman Gushchin wrote:
> Currently only a single inode can be switched to another writeback
> structure at once. That means to switch an inode a separate
> inode_switch_wbs_context structure must be allocated, and a separate
> rcu callback and work must be scheduled.
> 
> It's fine for the existing ad-hoc switching, which is not happening
> that often, but sub-optimal for massive switching required in order to
> release a writeback structure. To prepare for it, let's add a support
> for switching multiple inodes at once.
> 
> Instead of containing a single inode pointer, inode_switch_wbs_context
> will contain a NULL-terminated array of inode pointers.
> inode_do_switch_wbs() will be called for each inode.
> 
> To optimize the locking bdi->wb_switch_rwsem, old_wb's and new_wb's
> list_locks will be acquired and released only once altogether for all
> inodes. wb_wakeup() will be also be called only once. Instead of
> calling wb_put(old_wb) after each successful switch, wb_put_many()
> is introduced and used.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Looks good except for one small issue:

> +	for (inodep = isw->inodes; *inodep; inodep++) {
> +		WARN_ON_ONCE((*inodep)->i_wb != old_wb);
> +		if (inode_do_switch_wbs(*inodep, old_wb, new_wb))
> +			nr_switched++;
> +		iput(*inodep);
> +	}

You have to be careful here as iput() can be dropping last inode reference
and in that case it can sleep and do a lot of heavylifting (which cannot
happen under the locks you hold). So you need another loop after dropping
all the locks to do iput() on all inodes. After fixing this feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
