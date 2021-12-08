Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278F46D13C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 11:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhLHKsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 05:48:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39690 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLHKsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:48:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E08DAB8208C;
        Wed,  8 Dec 2021 10:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCCEC00446;
        Wed,  8 Dec 2021 10:44:57 +0000 (UTC)
Date:   Wed, 8 Dec 2021 11:44:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] tracefs: Have new files inherit the ownership of their
 parent
Message-ID: <20211208104454.nhxyvmmn6d2qhpwl@wittgenstein>
References: <20211207144828.3d356e26@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207144828.3d356e26@gandalf.local.home>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 02:48:28PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> If the tracefs system is set to a specific owner and group, then the files
> and directories that are created under them should inherit the owner and
> group of the parent.

The description reads like the owner of new directories and files is to
be always taken from the {g,u}id mount options. It doesn't look like
tracefs currently supports .setattr but if it ever wants to e.g. to
allow the system administrator to delegate specific directories or
files, the patch below will cause inheritance based on directory
ownership not on the {g,u}id mount option. So if I were to write this
I'd rather initialize based on mount option directly.

So sm along the - completely untested, non-prettified - lines of:

	static inline struct tracefs_fs_info *TRACEFS_SB(const struct super_block *sb)
	{
		return sb->s_fs_info;
	}

	struct tracefs_info *info;
	[...]

	inode = tracefs_get_inode(dentry->d_sb);
	if (unlikely(!inode))
		return failed_creating(dentry);

	[...]
	
	struct tracefs_info *info = TRACEFS_SB(inode->i_sb);

	[...]
	
	inode->i_uid = info.mount_opts.uid;
	inode->i_gid = info.mount_opts.gid;

this clearly gets the semantics across, the caller doens't need to know
that parent can be NULL and why it is retrieved via dentry->d_parent,
and is robust even if you allow changes in ownership in different ways
later on.

> 
> Cc: stable@vger.kernel.org
> Fixes: 4282d60689d4f ("tracefs: Add new tracefs file system")
> Reported-by: Kalesh Singh <kaleshsingh@google.com>
> Reported: https://lore.kernel.org/all/CAC_TJve8MMAv+H_NdLSJXZUSoxOEq2zB_pVaJ9p=7H6Bu3X76g@mail.gmail.com/
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  fs/tracefs/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index f20f575cdaef..6b16d89cf187 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -488,6 +488,8 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  	inode->i_mode = mode;
>  	inode->i_fop = fops ? fops : &tracefs_file_operations;
>  	inode->i_private = data;
> +	inode->i_uid = dentry->d_parent->d_inode->i_uid;
> +	inode->i_gid = dentry->d_parent->d_inode->i_gid;

I you stick with this I'd use the d_inode() accessor we have.

inode->i_uid = d_inode(dentry->d_parent)->i_uid;
inode->i_gid = d_inode(dentry->d_parent)->i_gid;

>  	d_instantiate(dentry, inode);
>  	fsnotify_create(dentry->d_parent->d_inode, dentry);
>  	return end_creating(dentry);
> @@ -510,6 +512,8 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
>  	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
>  	inode->i_op = ops;
>  	inode->i_fop = &simple_dir_operations;
> +	inode->i_uid = dentry->d_parent->d_inode->i_uid;
> +	inode->i_gid = dentry->d_parent->d_inode->i_gid;
>  
>  	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>  	inc_nlink(inode);
> -- 
> 2.31.1
> 
