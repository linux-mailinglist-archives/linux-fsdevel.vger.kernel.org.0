Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248AF68185A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 19:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjA3SJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 13:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjA3SJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:09:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6312131
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 10:09:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C56CEB8159F
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 18:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1083C4339B;
        Mon, 30 Jan 2023 18:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675102147;
        bh=hN4t+BF68xlXFdKrKFW26jgawQisINUOgnEUW/jbg3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFWRpO5nu47+pawFiM2jbQuoclx627K+4B46h4/1ZGB3QUcK7D5XAHDZNOTKoR7zM
         K6ZosK9a+JKM9M/o21yonJrWhGk1Mk9ao/ERPzwr27yMU9Tm6BSEe2zK5bh6XhXTs8
         wuK4SnHM6MR9UqNO9eccsPKYIkWfgHOaYwh4nOB45WwCw4kWevrWdCC66dF6bqNa5Y
         RWHcmXX1WKgA1MxI0iV/wBHvrj1Nfw+rlDYFIGtDV84HN+USIEx0kemA8vQY+ZCb8H
         lysQllyrxXay3fv/ceDggseWoxZLySAFZKIs5mghTcNT7dSHbdx4Y375GBWM8iDhfR
         +DEMG3WJHEEZA==
Date:   Mon, 30 Jan 2023 19:09:02 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH v2 1/8] fs: don't use IOP_XATTR for posix acls
Message-ID: <20230130180902.mo6vfudled25met4@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
 <20230125-fs-acl-remove-generic-xattr-handlers-v2-1-214cfb88bb56@kernel.org>
 <20230130165053.GA8357@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230130165053.GA8357@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 05:50:53PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 30, 2023 at 05:41:57PM +0100, Christian Brauner wrote:
> > The POSIX ACL api doesn't use the xattr handler infrastructure anymore.
> > If we keep relying on IOP_XATTR we will have to find a way to raise
> > IOP_XATTR during inode_init_always() if a filesystem doesn't implement
> > any xattrs other than POSIX ACLs. That's not done today but is in
> > principle possible. A prior version introduced SB_I_XATTR to this end.
> > Instead of this affecting all filesystems let those filesystems that
> > explicitly disable xattrs for some inodes disable POSIX ACLs by raising
> > IOP_NOACL.
> 
> I'm still a little confused about this, and also about
> inode_xattr_disable.  More below:
> 
> > -	if (!(old->d_inode->i_opflags & IOP_XATTR) ||
> > -	    !(new->d_inode->i_opflags & IOP_XATTR))
> > +	if (inode_xattr_disabled(old->d_inode) ||
> > +	    inode_xattr_disabled(new->d_inode))
> 
> This code shouldn't care about ACLs because the copy up itself
> should be all based around the ACL API, no?

The loop copies up all xattrs. It retrieves all xattrs via
vfs_listxattr() then walks through all of them and copies them up. But
it's nothing that we couldn't work around if it buys as less headaches
overall.

> 
> > +	if (!(inode->i_opflags & IOP_NOACL))
> >  		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
> >  	else if (unlikely(is_bad_inode(inode)))
> >  		error = -EIO;
> > @@ -1205,7 +1205,7 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> >  	if (error)
> >  		goto out_inode_unlock;
> >  
> > -	if (inode->i_opflags & IOP_XATTR)
> > +	if (!(inode->i_opflags & IOP_NOACL))
> >  		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
> 
> And here the lack of get/set methods should be all we need unless
> I'm missing something?

For setting acl that should work, yes.

> 
> > diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> > index c7d1fa526dea..2a7037b165f0 100644
> > --- a/fs/reiserfs/inode.c
> > +++ b/fs/reiserfs/inode.c
> > @@ -2089,7 +2089,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
> >  	 */
> >  	if (IS_PRIVATE(dir) || dentry == REISERFS_SB(sb)->priv_root) {
> >  		inode->i_flags |= S_PRIVATE;
> > -		inode->i_opflags &= ~IOP_XATTR;
> > +		inode_xattr_disable(inode);
> 
> I'll need to hear from the reiserfs maintainers, but this also seems
> like something that would be better done based on method presence.

I mean, since this is locked I would think we could just:

inode->i_op->{g,s}et_acl = NULL

and for btrfs it should work to as it uses simple_dir_inode_operations
which doesn't implement get/set posix acl methods.

> 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index adab9a70b536..89b6c122056d 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -468,7 +468,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
> >  	error = security_inode_listxattr(dentry);
> >  	if (error)
> >  		return error;
> > -	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
> > +	if (inode->i_op->listxattr && !inode_xattr_disabled(inode)) {
> >  		error = inode->i_op->listxattr(dentry, list, size);
> 
> So once listing ACLs is moved out of ->listxattr there should be no
> need to check anything for ACLs here either.

I think so...

But that would mean we'd need to change the ->listxattr() inode
operation to not return POSIX ACLs anymore. Instead vfs_listxattr()
would issue two vfs_get_acl() calls to check whether POSIX ACLs are
supported and if so append them to the buffer. That seems doable as
vfs_listxattr() is rarely used in the fs/ and nowhere in security/
luckily. Wdyt?

The only thing potentially wrong with that is that's two more filesystem
calls which probably doesn't matter for listing xattrs as that isn't
really that fast anyway and the ->listxattr() api is broken beyond
repair for userspace anyway.

I would need to check tomorrow whether we run into any real issues with
this idea but it could work.

If we're lucky it might mean that we could get rid of the generic POSIX
ACL handler dependency even for ext2/ext4/erofs/f2fs/reiserfs/jffs2/ocfs2.
