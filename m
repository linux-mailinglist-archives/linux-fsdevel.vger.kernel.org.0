Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A743F6816E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbjA3QvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbjA3QvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:51:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABB742BD9
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 08:50:57 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B696268D0D; Mon, 30 Jan 2023 17:50:53 +0100 (CET)
Date:   Mon, 30 Jan 2023 17:50:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH v2 1/8] fs: don't use IOP_XATTR for posix acls
Message-ID: <20230130165053.GA8357@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v2-1-214cfb88bb56@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v2-1-214cfb88bb56@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 05:41:57PM +0100, Christian Brauner wrote:
> The POSIX ACL api doesn't use the xattr handler infrastructure anymore.
> If we keep relying on IOP_XATTR we will have to find a way to raise
> IOP_XATTR during inode_init_always() if a filesystem doesn't implement
> any xattrs other than POSIX ACLs. That's not done today but is in
> principle possible. A prior version introduced SB_I_XATTR to this end.
> Instead of this affecting all filesystems let those filesystems that
> explicitly disable xattrs for some inodes disable POSIX ACLs by raising
> IOP_NOACL.

I'm still a little confused about this, and also about
inode_xattr_disable.  More below:

> -	if (!(old->d_inode->i_opflags & IOP_XATTR) ||
> -	    !(new->d_inode->i_opflags & IOP_XATTR))
> +	if (inode_xattr_disabled(old->d_inode) ||
> +	    inode_xattr_disabled(new->d_inode))

This code shouldn't care about ACLs because the copy up itself
should be all based around the ACL API, no?

> +	if (!(inode->i_opflags & IOP_NOACL))
>  		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
>  	else if (unlikely(is_bad_inode(inode)))
>  		error = -EIO;
> @@ -1205,7 +1205,7 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
>  	if (error)
>  		goto out_inode_unlock;
>  
> -	if (inode->i_opflags & IOP_XATTR)
> +	if (!(inode->i_opflags & IOP_NOACL))
>  		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);

And here the lack of get/set methods should be all we need unless
I'm missing something?

> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index c7d1fa526dea..2a7037b165f0 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -2089,7 +2089,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
>  	 */
>  	if (IS_PRIVATE(dir) || dentry == REISERFS_SB(sb)->priv_root) {
>  		inode->i_flags |= S_PRIVATE;
> -		inode->i_opflags &= ~IOP_XATTR;
> +		inode_xattr_disable(inode);

I'll need to hear from the reiserfs maintainers, but this also seems
like something that would be better done based on method presence.

> diff --git a/fs/xattr.c b/fs/xattr.c
> index adab9a70b536..89b6c122056d 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -468,7 +468,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
>  	error = security_inode_listxattr(dentry);
>  	if (error)
>  		return error;
> -	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
> +	if (inode->i_op->listxattr && !inode_xattr_disabled(inode)) {
>  		error = inode->i_op->listxattr(dentry, list, size);

So once listing ACLs is moved out of ->listxattr there should be no
need to check anything for ACLs here either.
