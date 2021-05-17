Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E313832D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbhEQOvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 10:51:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242085AbhEQOtu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 10:49:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5415FAEBB;
        Mon, 17 May 2021 14:48:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E23711F2C63; Mon, 17 May 2021 16:48:32 +0200 (CEST)
Date:   Mon, 17 May 2021 16:48:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, amir73il@gmail.com, wangyugui@e16-tech.com
Subject: Re: [PATCH v3] fsnotify: rework unlink/rmdir notify events
Message-ID: <20210517144832.GC25760@quack2.suse.cz>
References: <568db8243e9faa0efb9ffb545ffac5a2f87e65ef.1620999079.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568db8243e9faa0efb9ffb545ffac5a2f87e65ef.1620999079.git.josef@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

Thanks for the patch but I think you missed Amir's comments to your v2 [1]?
Also ...

> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index 42e5a766d33c..714e6f9b74f5 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -617,12 +617,17 @@ void *devpts_get_priv(struct dentry *dentry)
>   */
>  void devpts_pty_kill(struct dentry *dentry)
>  {
> +	struct inode *dir = d_inode(dentry->d_parent);
> +	struct inode *inode = d_inode(dentry);
> +
>  	WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
>  
> +	ihold(inode);
>  	dentry->d_fsdata = NULL;
>  	drop_nlink(dentry->d_inode);
> -	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
>  	d_drop(dentry);
> +	fsnotify_delete(dir, dentry, inode);
> +	iput(inode);
>  	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
>  }

AFAICT d_drop() actually doesn't make the dentry negative so there's no
need for this inode reference game? And similarly for d_invalidate() below?
Or am I missing something?

								Honza

[1] https://lore.kernel.org/linux-btrfs/CAOQ4uxhWz_J4fir9ft5XpRVHoNCdk_bP1y-a=MhBqRYSf3N8gA@mail.gmail.com

>  
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e9b29c6ffccb..189e12dc5d9b 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -271,7 +271,7 @@ void simple_recursive_removal(struct dentry *dentry,
>  	struct dentry *this = dget(dentry);
>  	while (true) {
>  		struct dentry *victim = NULL, *child;
> -		struct inode *inode = this->d_inode;
> +		struct inode *inode = this->d_inode, *victim_inode;
>  
>  		inode_lock(inode);
>  		if (d_is_dir(this))
> @@ -283,19 +283,19 @@ void simple_recursive_removal(struct dentry *dentry,
>  			clear_nlink(inode);
>  			inode_unlock(inode);
>  			victim = this;
> +			victim_inode = d_inode(victim);
> +			ihold(victim_inode);
>  			this = this->d_parent;
>  			inode = this->d_inode;
>  			inode_lock(inode);
>  			if (simple_positive(victim)) {
>  				d_invalidate(victim);	// avoid lost mounts
> -				if (d_is_dir(victim))
> -					fsnotify_rmdir(inode, victim);
> -				else
> -					fsnotify_unlink(inode, victim);
> +				fsnotify_delete(inode, victim, victim_inode);
>  				if (callback)
>  					callback(victim);
>  				dput(victim);		// unpin it
>  			}
> +			iput(victim_inode);
>  			if (victim == dentry) {
>  				inode->i_ctime = inode->i_mtime =
>  					current_time(inode);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
