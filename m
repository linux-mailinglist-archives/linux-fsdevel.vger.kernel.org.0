Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261B239F146
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 10:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhFHIrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 04:47:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32892 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFHIrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:47:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C9B71219D1;
        Tue,  8 Jun 2021 08:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623141944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ID1bWZyEeEYFe3Gi87astaP82RqRwCiiT0XcxH56fxI=;
        b=0WEOmP8SOwAOt39qT/z5az300cOjhJG0AqGFTMiuIAirfHD5c93CfZWdp6d1AiD9h7RkB5
        WDaL+vvLmyz5/sT8uxWQ25HH83bb6sRpu+Y17OY5TMtZRSXhig35z4euQJ58FFLmJaSTEW
        IGbx1g8bKVAjtqFhJpdSwnExi/vzMPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623141944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ID1bWZyEeEYFe3Gi87astaP82RqRwCiiT0XcxH56fxI=;
        b=YgVgGDWs3dTKUfzCXl3Cx0JSeLvr+YL/LLV7pJzTCIJxVVpx81ornHaz8zkGxRklYfGFaZ
        8SWpo1fOSKjeWeBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id BE02FA3B99;
        Tue,  8 Jun 2021 08:45:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8BE491F2C94; Tue,  8 Jun 2021 10:45:44 +0200 (CEST)
Date:   Tue, 8 Jun 2021 10:45:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH v8 3/8] writeback, cgroup: increment isw_nr_in_flight
 before grabbing an inode
Message-ID: <20210608084544.GB5562@quack2.suse.cz>
References: <20210608013123.1088882-1-guro@fb.com>
 <20210608013123.1088882-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608013123.1088882-4-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-06-21 18:31:18, Roman Gushchin wrote:
> isw_nr_in_flight is used do determine whether the inode switch queue
> should be flushed from the umount path. Currently it's increased
> after grabbing an inode and even scheduling the switch work. It means
> the umount path can be walked past cleanup_offline_cgwb() with active
> inode references, which can result in a "Busy inodes after unmount."
> message and use-after-free issues (with inode->i_sb which gets freed).
> 
> Fix it by incrementing isw_nr_in_flight before doing anything with
> the inode and decrementing in the case when switching wasn't scheduled.
> 
> The problem hasn't yet been seen in the real life and was discovered
> by Jan Kara by looking into the code.
> 
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/fs-writeback.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 3564efcc4b78..e2cc860a001b 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -505,6 +505,8 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	if (!isw)
>  		return;
>  
> +	atomic_inc(&isw_nr_in_flight);
> +
>  	/* find and pin the new wb */
>  	rcu_read_lock();
>  	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
> @@ -535,11 +537,10 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
>  	 */
>  	call_rcu(&isw->rcu_head, inode_switch_wbs_rcu_fn);
> -
> -	atomic_inc(&isw_nr_in_flight);
>  	return;
>  
>  out_free:
> +	atomic_dec(&isw_nr_in_flight);
>  	if (isw->new_wb)
>  		wb_put(isw->new_wb);
>  	kfree(isw);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
