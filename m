Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65E939D7DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 10:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFGIuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 04:50:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48628 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGIuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:50:24 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4BB2021A86;
        Mon,  7 Jun 2021 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623055712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2naVyNld0ZhkvsKE1x+NGtELQ4K5HYayJF8p+hq+SbA=;
        b=tlwLnyGH7VawMI7TcGGozb5AZI4f7IC46ovtT2AQ/LyWGYibtVAvNF61Pouzn6rmQe9dnK
        XB60/c9yqXN5aYWMOfzBtQqDArsCUjRLtBa9BYxnUdt+gGzSHAfHj4zcmH3Tls8GUWaGSZ
        NKxENUvyEJ91B0t2QNZlD3DoWNZyw+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623055712;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2naVyNld0ZhkvsKE1x+NGtELQ4K5HYayJF8p+hq+SbA=;
        b=VO25FqWanA88lV8Aezh36mNO3tBqzGfACUq9loSFJ3S7BQUk14Om3e22ixlhnFVZDCMHfi
        2L0GG4lBbKUVk4DQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 31231A3B81;
        Mon,  7 Jun 2021 08:48:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E41891F2CA8; Mon,  7 Jun 2021 10:48:31 +0200 (CEST)
Date:   Mon, 7 Jun 2021 10:48:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v7 1/6] writeback, cgroup: do not switch inodes with
 I_WILL_FREE flag
Message-ID: <20210607084831.GA30275@quack2.suse.cz>
References: <20210604013159.3126180-1-guro@fb.com>
 <20210604013159.3126180-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604013159.3126180-2-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-06-21 18:31:54, Roman Gushchin wrote:
> If an inode's state has I_WILL_FREE flag set, the inode will be
> freed soon, so there is no point in trying to switch the inode
> to a different cgwb.
> 
> I_WILL_FREE was ignored since the introduction of the inode switching,
> so it looks like it doesn't lead to any noticeable issues for a user.
> This is why the patch is not intended for a stable backport.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e91980f49388..bd99890599e0 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -389,10 +389,10 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
>  	xa_lock_irq(&mapping->i_pages);
>  
>  	/*
> -	 * Once I_FREEING is visible under i_lock, the eviction path owns
> -	 * the inode and we shouldn't modify ->i_io_list.
> +	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
> +	 * path owns the inode and we shouldn't modify ->i_io_list.
>  	 */
> -	if (unlikely(inode->i_state & I_FREEING))
> +	if (unlikely(inode->i_state & (I_FREEING | I_WILL_FREE)))
>  		goto skip_switch;
>  
>  	trace_inode_switch_wbs(inode, old_wb, new_wb);
> @@ -517,7 +517,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	/* while holding I_WB_SWITCH, no one else can update the association */
>  	spin_lock(&inode->i_lock);
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> -	    inode->i_state & (I_WB_SWITCH | I_FREEING) ||
> +	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
>  	    inode_to_wb(inode) == isw->new_wb) {
>  		spin_unlock(&inode->i_lock);
>  		goto out_free;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
