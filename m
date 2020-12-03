Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE842CE227
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 23:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgLCWx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 17:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731866AbgLCWxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:53:25 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B91C061A4F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 14:52:45 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8F6D24D3;
        Thu,  3 Dec 2020 22:52:04 +0000 (UTC)
Date:   Thu, 3 Dec 2020 15:52:03 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     info@democraticnet.de
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joris Gutjahr <joris.gutjahr@protonmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Updating the documentation of struct file_system_type
Message-ID: <20201203155203.4dd2736c@lwn.net>
In-Reply-To: <20201201210551.8306-1-info@democraticnet.de>
References: <20201201210551.8306-1-info@democraticnet.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue,  1 Dec 2020 22:05:51 +0100
info@democraticnet.de wrote:

> From: Joris Gutjahr <joris.gutjahr@protonmail.com>
> 
> In the documentation of struct file_system_type,
> using the definition of the struct of the kernel v5.10-rc6.
> 
> Signed-off-by: Joris Gutjahr <joris.gutjahr@protonmail.com>

So I applaud any effort to update this file, but I have a couple of
requests.  First is that any patch like this needs to be run past the
filesystem folks; I've added Al and the fsdevel list to CC as a starting
point.

>  Documentation/filesystems/vfs.rst | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index ca52c82e5bb5..364ef3dcb649 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -107,22 +107,30 @@ file /proc/filesystems.
>  struct file_system_type
>  -----------------------
>  
> -This describes the filesystem.  As of kernel 2.6.39, the following
> -members are defined:
> +This describes the filesystem.  As of kernel v5.10, the following
> +members are defined: (compare: include/linux/fs.h)
>  
>  .. code-block:: c
>  
> -	struct file_system_operations {
> +	struct file_system_type {
>  		const char *name;
>  		int fs_flags;
> +        int (*init_fs_context)(struct fs_context*);
> +        const struct fs_parameter_spec *parameters;
>  		struct dentry *(*mount) (struct file_system_type *, int,
>  					 const char *, void *);
>  		void (*kill_sb) (struct super_block *);
>  		struct module *owner;
>  		struct file_system_type * next;
> -		struct list_head fs_supers;
> +		struct hlist_head fs_supers;
>  		struct lock_class_key s_lock_key;
>  		struct lock_class_key s_umount_key;
> +        struct lock_class_key s_vfs_rename_key;
> +        struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
> +
> +        struct lock_class_key i_lock_key;
> +        struct lock_class_key i_mutex_key;
> +        struct lock_class_key i_mutex_dir_key;
>  	};
>  
>  ``name``
> @@ -132,6 +140,12 @@ members are defined:
>  ``fs_flags``
>  	various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
>  
> +``init_fs_context``
> +    TODO
> +
> +``fs_parameter_spec``
> +    TODO

These are ... not particularly helpful.  If we're going to update the
documentation for this structure, we should actually update the
documentation, methinks.

>  ``mount``
>  	the method to call when a new instance of this filesystem should
>  	be mounted
> @@ -148,7 +162,11 @@ members are defined:
>  ``next``
>  	for internal VFS use: you should initialize this to NULL
>  
> -  s_lock_key, s_umount_key: lockdep-specific
> +``fs_supers``
> +    TODO
> +
> +
> +  s_lock_key, s_umount_key, s_vfs_rename_key, s_writers_key, i_lock_key, i_mutex_key, i_mutex_dir_key: lockdep-specific

You should maintain the RST description-list formatting here.

>  The mount() method has the following arguments:

Thanks,

jon
