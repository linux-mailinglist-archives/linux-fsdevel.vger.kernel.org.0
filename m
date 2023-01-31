Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE0682B95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 12:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjAaLgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 06:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjAaLgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4545C7DA2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 03:36:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDDA0614C6
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 11:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC37C433EF;
        Tue, 31 Jan 2023 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675165007;
        bh=/oggMd1iICnlu/YGoFvVlTTiqqwPyBDBIGJLWSU9jVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OR2qKQ7MXc2kXJUf2vEu/xX3x5ZcYSW9NRWeWY6Dco98ENb579FnVxrksjh2IDZZZ
         VbkzC5dbw5yEf4Qj1aufPvkb+rZmzDS70/oK5nnpMQqsc9YsPHwSXSQPK9JWlWzSg4
         BEazopGJEf407Y5r8ljGTBQV7E5JYz1BDSVWWKb/tWMWJME9AJV9J2W99QRIYGIQT+
         BwgDXNTn+AXLxk8Vxzltb3K2qJ9cjUXTZldJRgR3UiwsKnc8VHP01wp9SzlVV+WMf9
         IzroEymjyLrlgSOWjNLbfD7w5ahye8pfbzdPeTaKv4N6VsFH+utbMNg8fdJgWQ5LmB
         wAWmFhcXA5ywg==
Date:   Tue, 31 Jan 2023 12:36:42 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH v2 1/8] fs: don't use IOP_XATTR for posix acls
Message-ID: <20230131113642.4ivzuxvnfrfjbmhk@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
 <20230125-fs-acl-remove-generic-xattr-handlers-v2-1-214cfb88bb56@kernel.org>
 <20230130165053.GA8357@lst.de>
 <20230130180902.mo6vfudled25met4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230130180902.mo6vfudled25met4@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 07:09:09PM +0100, Christian Brauner wrote:
> On Mon, Jan 30, 2023 at 05:50:53PM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 30, 2023 at 05:41:57PM +0100, Christian Brauner wrote:
> > > The POSIX ACL api doesn't use the xattr handler infrastructure anymore.
> > > If we keep relying on IOP_XATTR we will have to find a way to raise
> > > IOP_XATTR during inode_init_always() if a filesystem doesn't implement
> > > any xattrs other than POSIX ACLs. That's not done today but is in
> > > principle possible. A prior version introduced SB_I_XATTR to this end.
> > > Instead of this affecting all filesystems let those filesystems that
> > > explicitly disable xattrs for some inodes disable POSIX ACLs by raising
> > > IOP_NOACL.
> > 
> > I'm still a little confused about this, and also about
> > inode_xattr_disable.  More below:
> > 
> > > -	if (!(old->d_inode->i_opflags & IOP_XATTR) ||
> > > -	    !(new->d_inode->i_opflags & IOP_XATTR))
> > > +	if (inode_xattr_disabled(old->d_inode) ||
> > > +	    inode_xattr_disabled(new->d_inode))
> > 
> > This code shouldn't care about ACLs because the copy up itself
> > should be all based around the ACL API, no?
> 
> The loop copies up all xattrs. It retrieves all xattrs via
> vfs_listxattr() then walks through all of them and copies them up. But
> it's nothing that we couldn't work around if it buys as less headaches
> overall.
> 
> > 
> > > +	if (!(inode->i_opflags & IOP_NOACL))
> > >  		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
> > >  	else if (unlikely(is_bad_inode(inode)))
> > >  		error = -EIO;
> > > @@ -1205,7 +1205,7 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > >  	if (error)
> > >  		goto out_inode_unlock;
> > >  
> > > -	if (inode->i_opflags & IOP_XATTR)
> > > +	if (!(inode->i_opflags & IOP_NOACL))
> > >  		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
> > 
> > And here the lack of get/set methods should be all we need unless
> > I'm missing something?
> 
> For setting acl that should work, yes.
> 
> > 
> > > diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> > > index c7d1fa526dea..2a7037b165f0 100644
> > > --- a/fs/reiserfs/inode.c
> > > +++ b/fs/reiserfs/inode.c
> > > @@ -2089,7 +2089,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
> > >  	 */
> > >  	if (IS_PRIVATE(dir) || dentry == REISERFS_SB(sb)->priv_root) {
> > >  		inode->i_flags |= S_PRIVATE;
> > > -		inode->i_opflags &= ~IOP_XATTR;
> > > +		inode_xattr_disable(inode);
> > 
> > I'll need to hear from the reiserfs maintainers, but this also seems
> > like something that would be better done based on method presence.
> 
> I mean, since this is locked I would think we could just:
> 
> inode->i_op->{g,s}et_acl = NULL
> 
> and for btrfs it should work to as it uses simple_dir_inode_operations
> which doesn't implement get/set posix acl methods.
> 
> > 
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > index adab9a70b536..89b6c122056d 100644
> > > --- a/fs/xattr.c
> > > +++ b/fs/xattr.c
> > > @@ -468,7 +468,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
> > >  	error = security_inode_listxattr(dentry);
> > >  	if (error)
> > >  		return error;
> > > -	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
> > > +	if (inode->i_op->listxattr && !inode_xattr_disabled(inode)) {
> > >  		error = inode->i_op->listxattr(dentry, list, size);
> > 
> > So once listing ACLs is moved out of ->listxattr there should be no
> > need to check anything for ACLs here either.
> 
> I think so...
> 
> But that would mean we'd need to change the ->listxattr() inode
> operation to not return POSIX ACLs anymore. Instead vfs_listxattr()
> would issue two vfs_get_acl() calls to check whether POSIX ACLs are

So I see a few issues with this:
* Network filesystems like 9p or cifs retrieve xattrs for ->listxattr()
  in a batch from the server and dump them into the provided buffer.
  If we want to stop listing POSIX ACLs in ->listxattr() that would mean
  we would need to filter them out of the buffer for such filesystems.
  From a cursory glance this might affect more than just 9p and cifs.
* The fuse_listxattr() implementation has different permission
  requirements than fuse_get_acl() which would mean we would potentially
  refuse to list POSIX ACLs where we would have before or vica versa.
* We risk losing returning a consistent snapshot of all xattr names for
  a given inode if we split ->listxattr() and POSIX ACLs apart.

So I'm not sure that we can do it this way.
