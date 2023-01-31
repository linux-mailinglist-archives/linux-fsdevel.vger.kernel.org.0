Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45374683154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjAaPVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjAaPUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:20:43 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797B613D64;
        Tue, 31 Jan 2023 07:18:36 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D2F168BEB; Tue, 31 Jan 2023 16:18:32 +0100 (CET)
Date:   Tue, 31 Jan 2023 16:18:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        Jeff Mahoney <jeffm@suse.com>, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] fs: don't use IOP_XATTR for posix acls
Message-ID: <20230131151832.GA30960@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v2-1-214cfb88bb56@kernel.org> <20230130165053.GA8357@lst.de> <20230130180902.mo6vfudled25met4@wittgenstein> <20230131113642.4ivzuxvnfrfjbmhk@wittgenstein> <20230131145501.cscah5qujqh4e36k@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131145501.cscah5qujqh4e36k@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for not keeping up with your flow of ideas, so chiming in now:

> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index c7d1fa526dea..e293eaaed185 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -2090,6 +2090,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
>  	if (IS_PRIVATE(dir) || dentry == REISERFS_SB(sb)->priv_root) {
>  		inode->i_flags |= S_PRIVATE;
>  		inode->i_opflags &= ~IOP_XATTR;
> +		inode->i_op = &reiserfs_privdir_inode_operations;

I wonder if there is any way to set this where reiserfs assigns
the other ops. 

> +const struct inode_operations reiserfs_privdir_inode_operations = {
> +	.create = reiserfs_create,
> +	.lookup = reiserfs_lookup,
> +	.link = reiserfs_link,
> +	.unlink = reiserfs_unlink,
> +	.symlink = reiserfs_symlink,
> +	.mkdir = reiserfs_mkdir,
> +	.rmdir = reiserfs_rmdir,
> +	.mknod = reiserfs_mknod,
> +	.rename = reiserfs_rename,
> +	.setattr = reiserfs_setattr,
> +	.permission = reiserfs_permission,
> +	.fileattr_get = reiserfs_fileattr_get,
> +	.fileattr_set = reiserfs_fileattr_set,
> +};

I suspect many other ops aren't need either, but I really need input
from people that known reiserfs better.

> +	if (likely(!is_bad_inode(inode)))
>  		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
>  	else
> +		error = -EIO;

I wonder if the is_bad_inode check should simplify move into
get/set_posix_acl.  But otherwise this patch looks good.
