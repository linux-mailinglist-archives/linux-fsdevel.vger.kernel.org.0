Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36CC5E7DEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiIWPIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiIWPIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:08:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B411CB29;
        Fri, 23 Sep 2022 08:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77141B82749;
        Fri, 23 Sep 2022 15:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564A7C433D6;
        Fri, 23 Sep 2022 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663945680;
        bh=QXzziggvr6Wmh9wduUsbpBFpEL9M1V7XMVKQpo5MAXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIOpE1qKA88bPQni75aXIiTY0yCtHkIGKmI479jy015kNaQukRJenCjwfD2UJOpGs
         fLXTmixa98hDcjvvVt30burZ55MKUNg7VzxBT6G0JbP+RRDsvk1GZ6OBpqIWtuC/Qu
         l9PJwkbq+R0nFTyLMZWatPdMMqcGLeg1ZYFZiehGRfaLji3Jekw8WDBBnpvDYFyVX6
         6QFmxlqY7EFQXMrqb1+Y5xjHUX8K4TIulwmGWYTjREhDKbCBzTk2kqrPgd9xFKdlCQ
         UOexAfmxbShMQCJtfYFWtZb7ejACIPMNGgrY356mCQ7F1oe4x3M9uAz8tH42Yzi23Z
         47XLJ0XxXKfBw==
Date:   Fri, 23 Sep 2022 17:07:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 21/29] ovl: implement get acl method
Message-ID: <20220923150755.ce5ajjmnck6tvz2l@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-22-brauner@kernel.org>
 <CAJfpegu0xgSuvcY9zwEMDsb9PC3_AYPXvvE61fdHYEssVSf-tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegu0xgSuvcY9zwEMDsb9PC3_AYPXvvE61fdHYEssVSf-tA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 04:59:42PM +0200, Miklos Szeredi wrote:
> On Thu, 22 Sept 2022 at 17:18, Christian Brauner <brauner@kernel.org> wrote:
> >
> > The current way of setting and getting posix acls through the generic
> > xattr interface is error prone and type unsafe. The vfs needs to
> > interpret and fixup posix acls before storing or reporting it to
> > userspace. Various hacks exist to make this work. The code is hard to
> > understand and difficult to maintain in it's current form. Instead of
> > making this work by hacking posix acls through xattr handlers we are
> > building a dedicated posix acl api around the get and set inode
> > operations. This removes a lot of hackiness and makes the codepaths
> > easier to maintain. A lot of background can be found in [1].
> >
> > In order to build a type safe posix api around get and set acl we need
> > all filesystem to implement get and set acl.
> >
> > Now that we have added get and set acl inode operations that allow easy
> > access to the dentry we give overlayfs it's own get and set acl inode
> > operations.
> >
> > Since overlayfs is a stacking filesystem it will use the newly added
> > posix acl api when retrieving posix acls from the relevant layer.
> >
> > Since overlayfs can also be mounted on top of idmapped layers. If
> > idmapped layers are used overlayfs must take the layer's idmapping into
> > account after it retrieved the posix acls from the relevant layer.
> >
> > Note, until the vfs has been switched to the new posix acl api this
> > patch is a non-functional change.
> >
> > Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >  fs/overlayfs/dir.c       |  3 +-
> >  fs/overlayfs/inode.c     | 63 ++++++++++++++++++++++++++++++++++++----
> >  fs/overlayfs/overlayfs.h | 10 +++++--
> >  3 files changed, 67 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 7bece7010c00..eb49d5d7b56f 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -1311,7 +1311,8 @@ const struct inode_operations ovl_dir_inode_operations = {
> >         .permission     = ovl_permission,
> >         .getattr        = ovl_getattr,
> >         .listxattr      = ovl_listxattr,
> > -       .get_inode_acl  = ovl_get_acl,
> > +       .get_inode_acl  = ovl_get_inode_acl,
> > +       .get_acl        = ovl_get_acl,
> >         .update_time    = ovl_update_time,
> >         .fileattr_get   = ovl_fileattr_get,
> >         .fileattr_set   = ovl_fileattr_set,
> > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> > index ecb51c249466..dd11e13cd288 100644
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/fileattr.h>
> >  #include <linux/security.h>
> >  #include <linux/namei.h>
> > +#include <linux/posix_acl.h>
> > +#include <linux/posix_acl_xattr.h>
> >  #include "overlayfs.h"
> >
> >
> > @@ -460,9 +462,9 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
> >   * of the POSIX ACLs retrieved from the lower layer to this function to not
> >   * alter the POSIX ACLs for the underlying filesystem.
> >   */
> > -static void ovl_idmap_posix_acl(struct inode *realinode,
> > -                               struct user_namespace *mnt_userns,
> > -                               struct posix_acl *acl)
> > +void ovl_idmap_posix_acl(struct inode *realinode,
> > +                        struct user_namespace *mnt_userns,
> > +                        struct posix_acl *acl)
> >  {
> >         struct user_namespace *fs_userns = i_user_ns(realinode);
> >
> > @@ -495,7 +497,7 @@ static void ovl_idmap_posix_acl(struct inode *realinode,
> >   *
> >   * This is obviously only relevant when idmapped layers are used.
> >   */
> > -struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
> > +struct posix_acl *ovl_get_inode_acl(struct inode *inode, int type, bool rcu)
> >  {
> >         struct inode *realinode = ovl_inode_real(inode);
> >         struct posix_acl *acl, *clone;
> > @@ -547,6 +549,53 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
> >         posix_acl_release(acl);
> >         return clone;
> >  }
> > +
> > +static struct posix_acl *ovl_get_acl_path(const struct path *path,
> > +                                         const char *acl_name)
> > +{
> > +       struct posix_acl *real_acl, *clone;
> > +       struct user_namespace *mnt_userns;
> > +
> > +       mnt_userns = mnt_user_ns(path->mnt);
> > +
> > +       real_acl = vfs_get_acl(mnt_userns, path->dentry, acl_name);
> > +       if (IS_ERR(real_acl))
> > +               return real_acl;
> > +       if (!real_acl)
> > +               return NULL;
> 
> if (IS_ERR_OR_NULL(real_acl))
>     return real_acl;

Thanks.

> 
> > +
> > +       if (!is_idmapped_mnt(path->mnt))
> > +               return real_acl;
> > +
> > +       /*
> > +        * We cannot alter the ACLs returned from the relevant layer as that
> > +        * would alter the cached values filesystem wide for the lower
> > +        * filesystem. Instead we can clone the ACLs and then apply the
> > +        * relevant idmapping of the layer.
> > +        */
> 
> Can't vfs_get_acl() return 'const posix_acl *' to enforce that?

The problem is that struct posix_acl is reference counted and often has
to be passed to functions such as posix_acl_release() or
posix_acl_dup().
