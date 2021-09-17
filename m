Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9840F5FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242620AbhIQKfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 06:35:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53682 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhIQKfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:35:47 -0400
Date:   Fri, 17 Sep 2021 12:34:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631874864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DnOSY8HvqVDpNLR+/c5sW5ERFtOOy6bLGXEJ5xoVrPk=;
        b=Ws5eY3VgH9W5mRhHKt2WngPEbk6X8c+2lefKVOeXwLU6DKO28V3EREyHNbQh5HR7Jgslxl
        vxTX2NgDFVqrsiDtetm4x4apJlCv3WF4eJ+fBb3Ip5pmIplBan3rqjZJPy3VZ1EAOjV4Xw
        Nz5pdcclShIbcmZwDitPjHy5XzgUodx9h1eLHoCwtiGC+zKKRwrY8VnrIN5wy7vK0dIm9p
        lYnGCao/v1jLs5Jx3BZN8YnsvVOtKl+GfPfv/cZ/VdU9NoUCZZvDS8DfWjb+i0gEoeyEvZ
        QHyuSfETRC6xnlyr1BnJNB8d36sw1LGKK6m2hVv3HcrxV6Gbgj/Y+onxNagiYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631874864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DnOSY8HvqVDpNLR+/c5sW5ERFtOOy6bLGXEJ5xoVrPk=;
        b=9Lw03QJQWqavKN8n9U0UUnAIZYBeCXOOZM+2Ip421749ZgQWn2oy4fmxy/taHn9IjovJqb
        4pOgl9NxIZyLZZCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-fsdevel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Fully initialize invalidate_lock, amend lock class
 later
Message-ID: <20210917103423.gin4i6rr6vcy7zbw@linutronix.de>
References: <20210901084403.g4fezi23cixemlhh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901084403.g4fezi23cixemlhh@linutronix.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-09-01 10:44:04 [+0200], To linux-fsdevel@vger.kernel.org wrote:
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

ping.

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

Sebastian
