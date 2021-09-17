Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BB040F6CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 13:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbhIQLkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 07:40:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47996 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhIQLkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:40:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 320E422412;
        Fri, 17 Sep 2021 11:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631878764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bni8e3fnFoOJorcwpT1UhKwgT+OvUwStsDf695sKm9w=;
        b=fTXsxIn+00pe96AKSUprCPkRI/m43OBsBiEjt+R7vGI74+rejTijBPo1EbibuLoD4phfK4
        1uOARXiSnegsjbmkhQ+wCQtxAIKm9deIy6/mw/q6Swak/IExaUiXEOvhOjvo72H/WNCCKH
        ObXKooZpvdB/TvUhiIteC9zcgrKwhFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631878764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bni8e3fnFoOJorcwpT1UhKwgT+OvUwStsDf695sKm9w=;
        b=49TBC5FCtI3PNWnjB+rlgwVnZlIfrNtEfSGwhVbPcoJHXSWxUjhqASm4TnomKHF4lJsIMN
        1XPyd3tusVkEnzCA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 212D0A3B8A;
        Fri, 17 Sep 2021 11:39:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 898001E0CA7; Fri, 17 Sep 2021 13:39:21 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:39:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Fully initialize invalidate_lock, amend lock class
 later
Message-ID: <20210917113920.GD5284@quack2.suse.cz>
References: <20210901084403.g4fezi23cixemlhh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901084403.g4fezi23cixemlhh@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-09-21 10:44:03, Sebastian Andrzej Siewior wrote:
> The function __init_rwsem() is not part of the official API, it just a helper
> function used by init_rwsem().
> Changing the lock's class and name should be done by using
> lockdep_set_class_and_name() after the has been fully initialized. The overhead
> of the additional class struct and setting it twice is negligible and it works
> across all locks.
> 
> Fully initialize the lock with init_rwsem() and then set the custom class and
> name for the lock.
> 
> Fixes: 730633f0b7f95 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Fine by me, thanks for the fix. I'll queue it to my tree and push it to
Linus.

								Honza

> ---
>  fs/inode.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index cb41f02d8cedf..a49695f57e1ea 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -190,8 +190,10 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>  	mapping->private_data = NULL;
>  	mapping->writeback_index = 0;
> -	__init_rwsem(&mapping->invalidate_lock, "mapping.invalidate_lock",
> -		     &sb->s_type->invalidate_lock_key);
> +	init_rwsem(&mapping->invalidate_lock);
> +	lockdep_set_class_and_name(&mapping->invalidate_lock,
> +				   &sb->s_type->invalidate_lock_key,
> +				   "mapping.invalidate_lock");
>  	inode->i_private = NULL;
>  	inode->i_mapping = mapping;
>  	INIT_HLIST_HEAD(&inode->i_dentry);	/* buggered by rcu freeing */
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
