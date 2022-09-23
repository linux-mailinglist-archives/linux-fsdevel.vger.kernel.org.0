Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506045E7E82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiIWPfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWPfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:35:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA5AE36A0;
        Fri, 23 Sep 2022 08:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 178F5B838C4;
        Fri, 23 Sep 2022 15:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C127BC433C1;
        Fri, 23 Sep 2022 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663947317;
        bh=djVBjQKSdLhWOfDh1F/yLuKjrIOcK3jQ4fEKO4jut8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPRH9J4OclSilnkXZpNAUCQGdjA6u/XBZBMsVl0LWsgcROvzuZe86v+R4ykqJ3FNX
         1aw6nUfZRV8p3ovSxqse8wJQH+M2iCffEyMxeotc5rEceCyiJz6xZbuof+G8AtHwpv
         z50x9HmHeD2BfpI3OqzsZmxeD6ZKk+sGiojBrWI5slAyOPepydDcS2Q2YM+xh93+/5
         2ue2tIqHMT2a9mA/BdWDJVvprej/CejxH+0BmQt8IQJIGfedr7q6ABorctQmd35HzN
         NusTNjal+ED3zjhMvnOAr9crqbDDJXAi38SdkmLoHMb4xKJMBDsaHvTtimSa++J9xR
         efin3X7mz3xtA==
Date:   Fri, 23 Sep 2022 17:35:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 22/29] ovl: implement set acl method
Message-ID: <20220923153512.mp4fgxj3l3ew4xff@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-23-brauner@kernel.org>
 <CAJfpegstf+gUMm0iqrMSSzXKY6f8-U3vHK+hp+O7UuVR7oYCGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegstf+gUMm0iqrMSSzXKY6f8-U3vHK+hp+O7UuVR7oYCGA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:18:42PM +0200, Miklos Szeredi wrote:
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
> > The set acl inode operation is duplicates most of the ovl posix acl
> > xattr handler. The main difference being that the set acl inode
> > operation relies on the new posix acl api. Once the vfs has been
> > switched over the custom posix acl xattr handler will be removed
> > completely.
> >
> > Note, until the vfs has been switched to the new posix acl api this
> > patch is a non-functional change.
> >
> > Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >  fs/overlayfs/dir.c       |  1 +
> >  fs/overlayfs/inode.c     | 81 ++++++++++++++++++++++++++++++++++++++++
> >  fs/overlayfs/overlayfs.h | 17 +++++++++
> >  3 files changed, 99 insertions(+)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index eb49d5d7b56f..0e817ebce92c 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -1313,6 +1313,7 @@ const struct inode_operations ovl_dir_inode_operations = {
> >         .listxattr      = ovl_listxattr,
> >         .get_inode_acl  = ovl_get_inode_acl,
> >         .get_acl        = ovl_get_acl,
> > +       .set_acl        = ovl_set_acl,
> >         .update_time    = ovl_update_time,
> >         .fileattr_get   = ovl_fileattr_get,
> >         .fileattr_set   = ovl_fileattr_set,
> > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> > index dd11e13cd288..b0a19f9deaf1 100644
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -596,6 +596,85 @@ struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
> >         revert_creds(old_cred);
> >         return acl;
> >  }
> > +
> > +int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > +               struct posix_acl *acl, int type)
> > +{
> > +       int err;
> > +       struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
> > +       struct inode *inode = d_inode(dentry);
> > +       struct dentry *upperdentry = ovl_dentry_upper(dentry);
> > +       struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
> > +       struct dentry *workdir = ovl_workdir(dentry);
> > +       struct inode *realinode = ovl_inode_real(inode);
> > +       struct path realpath;
> > +       const struct cred *old_cred;
> > +       const char *acl_name;
> > +
> > +       if (!IS_POSIXACL(d_inode(workdir)))
> > +               return -EOPNOTSUPP;
> > +       if (!realinode->i_op->set_acl)
> > +               return -EOPNOTSUPP;
> > +       if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
> > +               return acl ? -EACCES : 0;
> > +       if (!inode_owner_or_capable(&init_user_ns, inode))
> > +               return -EPERM;
> > +
> > +       /*
> > +        * Check if sgid bit needs to be cleared (actual setacl operation will
> > +        * be done with mounter's capabilities and so that won't do it for us).
> > +        */
> > +       if (unlikely(inode->i_mode & S_ISGID) && type == ACL_TYPE_ACCESS &&
> > +           !in_group_p(inode->i_gid) &&
> > +           !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID)) {
> > +               struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
> > +
> > +               err = ovl_setattr(&init_user_ns, dentry, &iattr);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> 
> I'd split this function up here (same as was done in the original
> xattr based one).

Ok, will do.

> 
> > +       err = ovl_want_write(dentry);
> > +       if (err)
> > +               goto out;
> > +
> > +       acl_name = posix_acl_xattr_name(type);
> 
> My bad, but this really deserves a comment:  /* If ACL is to be
> removed from a lower file, check if it exists in the first place
> before copying it up */

Ok, will add.
