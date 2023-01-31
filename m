Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8880D682FD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 15:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjAaOzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 09:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAaOzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:55:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098C23321
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 06:55:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D094C61546
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 14:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2190C433EF;
        Tue, 31 Jan 2023 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675176906;
        bh=NLOAbpL8t3hD1V6YF7Q+d3LVix9mGDdoB6bxLi0xucc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSxMpFyR1xwAIfrd1drG4xP3D3/QoSvcqpMN+C3/YJSNjRNU493MIA3FwjskSV6vK
         v1hjrYDJgzml+bwhE+dt0myHhUSo93SQjvb16Q2AfPlNusYj9cfj3Ba3aDLzGZPL0Y
         vgxlrh1Il3+2mSq9IETT4Sy5Ib/5i3RUC8uizFj2T4vCrPwJANPkk72RYY/GrnQAeN
         HP2/DBDvfiuf8+0+AT84/Mc8r5rXXg5XotFSXhM5xrc6nvLQ5Pmd66TgR+2ee3hzDG
         VaxhUCMpF49AzoantF27hkl4gUH9+4/sQj6Gq+9SiyS1kHG2f+CGKbvcPZVCu95K3U
         CrZjYYyp6DGiQ==
Date:   Tue, 31 Jan 2023 15:55:01 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH v2 1/8] fs: don't use IOP_XATTR for posix acls
Message-ID: <20230131145501.cscah5qujqh4e36k@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
 <20230125-fs-acl-remove-generic-xattr-handlers-v2-1-214cfb88bb56@kernel.org>
 <20230130165053.GA8357@lst.de>
 <20230130180902.mo6vfudled25met4@wittgenstein>
 <20230131113642.4ivzuxvnfrfjbmhk@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230131113642.4ivzuxvnfrfjbmhk@wittgenstein>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:36:47PM +0100, Christian Brauner wrote:
> On Mon, Jan 30, 2023 at 07:09:09PM +0100, Christian Brauner wrote:
> > On Mon, Jan 30, 2023 at 05:50:53PM +0100, Christoph Hellwig wrote:
> > > On Mon, Jan 30, 2023 at 05:41:57PM +0100, Christian Brauner wrote:
> > > > The POSIX ACL api doesn't use the xattr handler infrastructure anymore.
> > > > If we keep relying on IOP_XATTR we will have to find a way to raise
> > > > IOP_XATTR during inode_init_always() if a filesystem doesn't implement
> > > > any xattrs other than POSIX ACLs. That's not done today but is in
> > > > principle possible. A prior version introduced SB_I_XATTR to this end.
> > > > Instead of this affecting all filesystems let those filesystems that
> > > > explicitly disable xattrs for some inodes disable POSIX ACLs by raising
> > > > IOP_NOACL.
> > > 
> > > I'm still a little confused about this, and also about
> > > inode_xattr_disable.  More below:
> > > 
> > > > -	if (!(old->d_inode->i_opflags & IOP_XATTR) ||
> > > > -	    !(new->d_inode->i_opflags & IOP_XATTR))
> > > > +	if (inode_xattr_disabled(old->d_inode) ||
> > > > +	    inode_xattr_disabled(new->d_inode))
> > > 
> > > This code shouldn't care about ACLs because the copy up itself
> > > should be all based around the ACL API, no?
> > 
> > The loop copies up all xattrs. It retrieves all xattrs via
> > vfs_listxattr() then walks through all of them and copies them up. But
> > it's nothing that we couldn't work around if it buys as less headaches
> > overall.
> > 
> > > 
> > > > +	if (!(inode->i_opflags & IOP_NOACL))
> > > >  		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
> > > >  	else if (unlikely(is_bad_inode(inode)))
> > > >  		error = -EIO;
> > > > @@ -1205,7 +1205,7 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > > >  	if (error)
> > > >  		goto out_inode_unlock;
> > > >  
> > > > -	if (inode->i_opflags & IOP_XATTR)
> > > > +	if (!(inode->i_opflags & IOP_NOACL))
> > > >  		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
> > > 
> > > And here the lack of get/set methods should be all we need unless
> > > I'm missing something?
> > 
> > For setting acl that should work, yes.
> > 
> > > 
> > > > diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> > > > index c7d1fa526dea..2a7037b165f0 100644
> > > > --- a/fs/reiserfs/inode.c
> > > > +++ b/fs/reiserfs/inode.c
> > > > @@ -2089,7 +2089,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
> > > >  	 */
> > > >  	if (IS_PRIVATE(dir) || dentry == REISERFS_SB(sb)->priv_root) {
> > > >  		inode->i_flags |= S_PRIVATE;
> > > > -		inode->i_opflags &= ~IOP_XATTR;
> > > > +		inode_xattr_disable(inode);
> > > 
> > > I'll need to hear from the reiserfs maintainers, but this also seems
> > > like something that would be better done based on method presence.
> > 
> > I mean, since this is locked I would think we could just:
> > 
> > inode->i_op->{g,s}et_acl = NULL
> > 
> > and for btrfs it should work to as it uses simple_dir_inode_operations
> > which doesn't implement get/set posix acl methods.
> > 
> > > 
> > > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > > index adab9a70b536..89b6c122056d 100644
> > > > --- a/fs/xattr.c
> > > > +++ b/fs/xattr.c
> > > > @@ -468,7 +468,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
> > > >  	error = security_inode_listxattr(dentry);
> > > >  	if (error)
> > > >  		return error;
> > > > -	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
> > > > +	if (inode->i_op->listxattr && !inode_xattr_disabled(inode)) {
> > > >  		error = inode->i_op->listxattr(dentry, list, size);
> > > 
> > > So once listing ACLs is moved out of ->listxattr there should be no
> > > need to check anything for ACLs here either.
> > 
> > I think so...
> > 
> > But that would mean we'd need to change the ->listxattr() inode
> > operation to not return POSIX ACLs anymore. Instead vfs_listxattr()
> > would issue two vfs_get_acl() calls to check whether POSIX ACLs are
> 
> So I see a few issues with this:
> * Network filesystems like 9p or cifs retrieve xattrs for ->listxattr()
>   in a batch from the server and dump them into the provided buffer.
>   If we want to stop listing POSIX ACLs in ->listxattr() that would mean
>   we would need to filter them out of the buffer for such filesystems.
>   From a cursory glance this might affect more than just 9p and cifs.
> * The fuse_listxattr() implementation has different permission
>   requirements than fuse_get_acl() which would mean we would potentially
>   refuse to list POSIX ACLs where we would have before or vica versa.
> * We risk losing returning a consistent snapshot of all xattr names for
>   a given inode if we split ->listxattr() and POSIX ACLs apart.
> 
> So I'm not sure that we can do it this way.

So I've experimented a bit. Really, the remaining issue to remove the
dependency of POSIX ACLs on IOP_XATTR is the check in vfs_listxattr()
for IOP_XATTR. Removing IOP_XATTR from vfs_listxattr() from is really
only a problem if there is any filesystems that removes IOP_XATTR
without also assigning a dedicated set of inode_operations that either
leaves ->listxattr() unimplement or makes it a NOP.

The only filesystems for which this is true is reiserfs. But I believe
we can fix this by forcing reiserfs to use a dedicated set of inode
operations with ->listxattr(), and the POSIX ACL inode operations
unimplemented.

So here's what I have which would allows us to proceed with the removal.
@Christoph, do you think that's doable or is there anything I'm still
missing?:

From 765c56cba40fb42e7e7a319cf3cbcc9d5abd7c11 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 31 Jan 2023 15:13:53 +0100
Subject: [PATCH 1/3] reiserfs: use simplify IOP_XATTR handling

Reiserfs is the only filesystem that removes IOP_XATTR without also
using a set of dedicated inode operations at the same time that nop all
xattr related inode operations. This means we need to have a IOP_XATTR
check in vfs_listxattr() instead of just being able to check for
->listxattr() being implemented.

Introduce a dedicated set of nop inode operations that are used when
IOP_XATTR is removed allowing us to remove that check from
vfs_listxattr().

Cc: reiserfs-devel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/reiserfs/inode.c    |  1 +
 fs/reiserfs/namei.c    | 17 +++++++++++++++++
 fs/reiserfs/reiserfs.h |  1 +
 fs/reiserfs/xattr.c    |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c7d1fa526dea..e293eaaed185 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2090,6 +2090,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 	if (IS_PRIVATE(dir) || dentry == REISERFS_SB(sb)->priv_root) {
 		inode->i_flags |= S_PRIVATE;
 		inode->i_opflags &= ~IOP_XATTR;
+		inode->i_op = &reiserfs_privdir_inode_operations;
 	}
 
 	if (reiserfs_posixacl(inode->i_sb)) {
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 0b8aa99749f1..19aca1684fd1 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -384,6 +384,7 @@ static struct dentry *reiserfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (IS_PRIVATE(dir)) {
 			inode->i_flags |= S_PRIVATE;
 			inode->i_opflags &= ~IOP_XATTR;
+			inode->i_op = &reiserfs_privdir_inode_operations;
 		}
 	}
 	reiserfs_write_unlock(dir->i_sb);
@@ -1669,6 +1670,22 @@ const struct inode_operations reiserfs_dir_inode_operations = {
 	.fileattr_set = reiserfs_fileattr_set,
 };
 
+const struct inode_operations reiserfs_privdir_inode_operations = {
+	.create = reiserfs_create,
+	.lookup = reiserfs_lookup,
+	.link = reiserfs_link,
+	.unlink = reiserfs_unlink,
+	.symlink = reiserfs_symlink,
+	.mkdir = reiserfs_mkdir,
+	.rmdir = reiserfs_rmdir,
+	.mknod = reiserfs_mknod,
+	.rename = reiserfs_rename,
+	.setattr = reiserfs_setattr,
+	.permission = reiserfs_permission,
+	.fileattr_get = reiserfs_fileattr_get,
+	.fileattr_set = reiserfs_fileattr_set,
+};
+
 /*
  * symlink operations.. same as page_symlink_inode_operations, with xattr
  * stuff added
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 14726fd353c4..9d3a9c0df43b 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -3160,6 +3160,7 @@ static inline int reiserfs_proc_info_global_done(void)
 
 /* dir.c */
 extern const struct inode_operations reiserfs_dir_inode_operations;
+extern const struct inode_operations reiserfs_privdir_inode_operations;
 extern const struct inode_operations reiserfs_symlink_inode_operations;
 extern const struct inode_operations reiserfs_special_inode_operations;
 extern const struct file_operations reiserfs_dir_operations;
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 1864a35853a9..01dc07fb60a4 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -912,6 +912,8 @@ static int create_privroot(struct dentry *dentry)
 
 	d_inode(dentry)->i_flags |= S_PRIVATE;
 	d_inode(dentry)->i_opflags &= ~IOP_XATTR;
+	d_inode(dentry)->i_op = &reiserfs_privdir_inode_operations;
+
 	reiserfs_info(dentry->d_sb, "Created %s - reserved for xattr "
 		      "storage.\n", PRIVROOT_NAME);
 
@@ -984,6 +986,7 @@ int reiserfs_lookup_privroot(struct super_block *s)
 		if (d_really_is_positive(dentry)) {
 			d_inode(dentry)->i_flags |= S_PRIVATE;
 			d_inode(dentry)->i_opflags &= ~IOP_XATTR;
+			d_inode(dentry)->i_op = &reiserfs_privdir_inode_operations;
 		}
 	} else
 		err = PTR_ERR(dentry);
-- 
2.34.1

From 3002147142b2558f9e642da38a567f7ce1fdd2e5 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 31 Jan 2023 15:17:11 +0100
Subject: [PATCH 2/3] acl: don't depend on IOP_XATTR

All codepaths that don't want to implement POSIX ACLs should simply not
implement the associated inode operations instead of relying on
IOP_XATTR. That's the case for all filesystems today.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 7a4d89897c37..881a7fd1cacb 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1132,12 +1132,10 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	if (inode->i_opflags & IOP_XATTR)
+	if (likely(!is_bad_inode(inode)))
 		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
-	else if (unlikely(is_bad_inode(inode)))
-		error = -EIO;
 	else
-		error = -EOPNOTSUPP;
+		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
 		evm_inode_post_set_acl(dentry, acl_name, kacl);
@@ -1242,12 +1240,10 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	if (inode->i_opflags & IOP_XATTR)
+	if (likely(!is_bad_inode(inode)))
 		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
-	else if (unlikely(is_bad_inode(inode)))
-		error = -EIO;
 	else
-		error = -EOPNOTSUPP;
+		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
 		evm_inode_post_remove_acl(mnt_userns, dentry, acl_name);
-- 
2.34.1

From 303bcb6a2da513e7d904bc8f9915b992b33ab661 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 31 Jan 2023 15:25:10 +0100
Subject: [PATCH 3/4] xattr: don't rely on IOP_XATTR in vfs_listxattr()

Filesystems that explicitly turn of xattrs for a given inode all set
inode->i_op to a dedicated set of inode operations that doesn't
implement ->listxattr().  Removing this dependency will allow us to
decouple POSIX ACLs from IOP_XATTR and they can still be listed even if
no other xattr handlers are implemented.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 8743402a5e8b..aed1cacb97c6 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -466,7 +466,8 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	error = security_inode_listxattr(dentry);
 	if (error)
 		return error;
-	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
+
+	if (inode->i_op->listxattr) {
 		error = inode->i_op->listxattr(dentry, list, size);
 	} else {
 		error = security_inode_listsecurity(inode, list, size);
-- 
2.34.1

