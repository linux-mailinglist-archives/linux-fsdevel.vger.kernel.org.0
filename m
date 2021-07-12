Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F53C59E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 13:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351881AbhGLJMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 05:12:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39144 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356380AbhGLJJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:09:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7FAAA22130;
        Mon, 12 Jul 2021 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626080786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izU/w0ojrKIk9f0Qlt3E1Z7ABTszZ26JSf37sawJ7ik=;
        b=D+uNSSCiQrN5TfkBHQ8EpfB0GYISFcZMi4KUrzK4nnlsrkuosxZPZB/f7BrdNqGCqAfR+S
        TJRsLO8W8cSAOqgNKwRYqpRjkfczP1G+8p0gO5hGOPLMgC4KuZ7ZqKFZBdnlpLBdpUj2zQ
        NhsC4YlTn7afYrHbcj/iYniNsgXrF+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626080786;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izU/w0ojrKIk9f0Qlt3E1Z7ABTszZ26JSf37sawJ7ik=;
        b=egBeRoFLR8TB2MA2tea/XLqqMk4u1Y4sae9oo6cA7NZ/ZfM9CnNgR/IddnHet4jnaCHsBh
        29h1QEhzSy/S6EDw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 498A7A3B88;
        Mon, 12 Jul 2021 09:06:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1B13D1E62D6; Mon, 12 Jul 2021 11:06:26 +0200 (CEST)
Date:   Mon, 12 Jul 2021 11:06:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] fs, mm: fix race in unlinking swapfile
Message-ID: <20210712090626.GB27936@quack2.suse.cz>
References: <e17b91ad-a578-9a15-5e3-4989e0f999b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17b91ad-a578-9a15-5e3-4989e0f999b5@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 07-07-21 13:48:31, Hugh Dickins wrote:
> We had a recurring situation in which admin procedures setting up
> swapfiles would race with test preparation clearing away swapfiles;
> and just occasionally that got stuck on a swapfile "(deleted)" which
> could never be swapped off.  That is not supposed to be possible.
> 
> 2.6.28 commit f9454548e17c ("don't unlink an active swapfile") admitted
> that it was leaving a race window open: now close it.
> 
> may_delete() makes the IS_SWAPFILE check (amongst many others) before
> inode_lock has been taken on target: now repeat just that simple check
> in vfs_unlink() and vfs_rename(), after taking inode_lock.
> 
> Which goes most of the way to fixing the race, but swapon() must also
> check after it acquires inode_lock, that the file just opened has not
> already been unlinked.
> 
> Fixes: f9454548e17c ("don't unlink an active swapfile")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c    | 8 +++++++-
>  mm/swapfile.c | 6 ++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index bf6d8a738c59..ff866c07f4d2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4024,7 +4024,9 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
>  		return -EPERM;
>  
>  	inode_lock(target);
> -	if (is_local_mountpoint(dentry))
> +	if (IS_SWAPFILE(target))
> +		error = -EPERM;
> +	else if (is_local_mountpoint(dentry))
>  		error = -EBUSY;
>  	else {
>  		error = security_inode_unlink(dir, dentry);
> @@ -4526,6 +4528,10 @@ int vfs_rename(struct renamedata *rd)
>  	else if (target)
>  		inode_lock(target);
>  
> +	error = -EPERM;
> +	if (IS_SWAPFILE(source) || (target && IS_SWAPFILE(target)))
> +		goto out;
> +
>  	error = -EBUSY;
>  	if (is_local_mountpoint(old_dentry) || is_local_mountpoint(new_dentry))
>  		goto out;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1e07d1c776f2..7527afd95284 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3130,6 +3130,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	struct filename *name;
>  	struct file *swap_file = NULL;
>  	struct address_space *mapping;
> +	struct dentry *dentry;
>  	int prio;
>  	int error;
>  	union swap_header *swap_header;
> @@ -3173,6 +3174,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  
>  	p->swap_file = swap_file;
>  	mapping = swap_file->f_mapping;
> +	dentry = swap_file->f_path.dentry;
>  	inode = mapping->host;
>  
>  	error = claim_swapfile(p, inode);
> @@ -3180,6 +3182,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		goto bad_swap;
>  
>  	inode_lock(inode);
> +	if (d_unlinked(dentry) || cant_mount(dentry)) {
> +		error = -ENOENT;
> +		goto bad_swap_unlock_inode;
> +	}
>  	if (IS_SWAPFILE(inode)) {
>  		error = -EBUSY;
>  		goto bad_swap_unlock_inode;
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
