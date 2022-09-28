Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C086A5EE05A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiI1P1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiI1P1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:27:21 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A897B32
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 08:27:19 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1318106fe2cso6557418fac.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Rf50TA1sJ3J1430aPOmsrdjMBJhIfNX96SYfuJttBoQ=;
        b=HVGNrG7n9MSfLxP/Zp6SJ7WcyFZBMPTJX9XCNnG9PFnfPvze2jEzVIU7iJci8l66bt
         C6w/CX1T/A0TLSwcxChWfQNoKlGOCHygTFuD+TS0YuXlFpeZS6pOVqCM5pDiGZXCD8Z7
         KIauPLP7+Iy2dahhXc2Tuv/T/lmkycT0nB+p8Cv3va1Rwngwzd/bCJ+3K7cV7kJCYhMJ
         XmTvLBWRy1wUzL5P1gNZC4S+TS0nGmZhGgFVgSaWrAD9Jt+GLUPaNvsD+wcEhQZE68Jw
         Cl3PQMDNzzkSvle3mMeIvGe7R9KB83LR0q8c+gs9AqjhIoM8PvyJGioBKcFkxeIHkB7l
         yRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Rf50TA1sJ3J1430aPOmsrdjMBJhIfNX96SYfuJttBoQ=;
        b=5JsImtTMHnMF1jvzwQS3PI6bkrKgGHU8dZwCjZg4gScwcBLmE+yFEZV61hkdxC2Zqa
         FS794e5XnJQvTBKCAx1v3oZPhtB9+nOIqAmyR+T/7z8WuOobqvhCKGQcObe++uhGXAGW
         w0ECTq578jQMkeUHtPrb151eTyPD5yuh/kLNZEH5ib0rrgPTstTETsMZ3Hl/jrutISKe
         Mq0IrV8ba8e+sPPGWuTE5t6aV0Rg0HjSN2jmevYicwB8fVXR9wM8XiSQdUReTJrboVLs
         Jf+jNsxNzqWUP9INOGuL2BXzu0npcBeYF3VkoN0XIU6sbN/7xpIb6ZD7LqCUbkmy8Mvh
         mgMw==
X-Gm-Message-State: ACrzQf3uldYMSXH5WBUc0jSpFB2um45xq/r0ViCbBNaO6mNNjHaaPchr
        ZSENd4IFLdi6j5uuD1Peu9jNovDJMPqzytfJ/rKu
X-Google-Smtp-Source: AMsMyM7ELhIx0UOBkRgbPjMZmlxwnQETYJfuvkP/i9gTNQyq9+ScFpUq/jrWM6J3sfo7H98f18FdnpeSsM9J2GAWrAU=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr4058749oab.172.1664378838382; Wed, 28
 Sep 2022 08:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-17-brauner@kernel.org>
 <CAHC9VhSyf9c-EtD_V856ZGTbFamwWh=bxPh7aPdarkqhdE7WZw@mail.gmail.com>
 <20220928074030.3dnytkvt7fibytlu@wittgenstein> <CAHC9VhSNOPCOjZ3ucqzrTd01a_o54xfnA137893TkHQMpQXoPw@mail.gmail.com>
 <20220928151233.f7iqegfk4q6v22fe@wittgenstein>
In-Reply-To: <20220928151233.f7iqegfk4q6v22fe@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Sep 2022 11:27:07 -0400
Message-ID: <CAHC9VhReWD=Ru+wqraT9+b8E-8FCoufmH-2z7zKz+sZhXQpMOA@mail.gmail.com>
Subject: Re: [PATCH v2 16/30] acl: add vfs_get_acl()
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:12 AM Christian Brauner <brauner@kernel.org> wrote:
> On Wed, Sep 28, 2022 at 10:58:33AM -0400, Paul Moore wrote:
> > On Wed, Sep 28, 2022 at 3:40 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, Sep 27, 2022 at 06:55:25PM -0400, Paul Moore wrote:
> > > > On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > >
> > > > > In previous patches we implemented get and set inode operations for all
> > > > > non-stacking filesystems that support posix acls but didn't yet
> > > > > implement get and/or set acl inode operations. This specifically
> > > > > affected cifs and 9p.
> > > > >
> > > > > Now we can build a posix acl api based solely on get and set inode
> > > > > operations. We add a new vfs_get_acl() api that can be used to get posix
> > > > > acls. This finally removes all type unsafety and type conversion issues
> > > > > explained in detail in [1] that we aim to get rid of.
> > > > >
> > > > > After we finished building the vfs api we can switch stacking
> > > > > filesystems to rely on the new posix api and then finally switch the
> > > > > xattr system calls themselves to rely on the posix acl api.
> > > > >
> > > > > Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> > > > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > > > ---
> > > > >
> > > > > Notes:
> > > > >     /* v2 */
> > > > >     unchanged
> > > > >
> > > > >  fs/posix_acl.c                  | 131 ++++++++++++++++++++++++++++++--
> > > > >  include/linux/posix_acl.h       |   9 +++
> > > > >  include/linux/posix_acl_xattr.h |  10 +++
> > > > >  3 files changed, 142 insertions(+), 8 deletions(-)
> > > >
> > > > ...
> > > >
> > > > > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > > > > index ef0908a4bc46..18873be583a9 100644
> > > > > --- a/fs/posix_acl.c
> > > > > +++ b/fs/posix_acl.c
> > > > > @@ -1369,3 +1439,48 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > > > >         return error;
> > > > >  }
> > > > >  EXPORT_SYMBOL(vfs_set_acl);
> > > > > +
> > > > > +/**
> > > > > + * vfs_get_acl - get posix acls
> > > > > + * @mnt_userns: user namespace of the mount
> > > > > + * @dentry: the dentry based on which to retrieve the posix acls
> > > > > + * @acl_name: the name of the posix acl
> > > > > + *
> > > > > + * This function retrieves @kacl from the filesystem. The caller must all
> > > > > + * posix_acl_release() on @kacl.
> > > > > + *
> > > > > + * Return: On success POSIX ACLs in VFS format, on error negative errno.
> > > > > + */
> > > > > +struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
> > > > > +                             struct dentry *dentry, const char *acl_name)
> > > > > +{
> > > > > +       struct inode *inode = d_inode(dentry);
> > > > > +       struct posix_acl *acl;
> > > > > +       int acl_type, error;
> > > > > +
> > > > > +       acl_type = posix_acl_type(acl_name);
> > > > > +       if (acl_type < 0)
> > > > > +               return ERR_PTR(-EINVAL);
> > > > > +
> > > > > +       /*
> > > > > +        * The VFS has no restrictions on reading POSIX ACLs so calling
> > > > > +        * something like xattr_permission() isn't needed. Only LSMs get a say.
> > > > > +        */
> > > > > +       error = security_inode_getxattr(dentry, acl_name);
> > > > > +       if (error)
> > > > > +               return ERR_PTR(error);
> > > >
> > > > I understand the desire to reuse the security_inode_getxattr() hook
> > > > here, it makes perfect sense, but given that this patchset introduces
> > > > an ACL specific setter hook I think it makes sense to have a matching
> > > > getter hook.  It's arguably a little silly given the current crop of
> > > > LSMs and their approach to ACLs, but if we are going to differentiate
> > > > on the write side I think we might as well be consistent and
> > > > differentiate on the read side as well.
> > >
> > > Sure, I don't mind doing that. I'll add the infrastructure and then the
> > > individual LSMs can add their own hooks.
> >
> > Adding the ACL hook infrastructure, including the call in
> > vfs_get_acl(), without the LSM implementations would result in an
> > access control regression for both SELinux and Smack.  Similar issues
> > with the removexattr hook, although that looks to have IMA/EVM calls
> > too (which may be noops in the case of an ACL, I haven't checked).
> >
> > The good news is that the individual LSM implementations should be
> > trivial, and if you wanted to just have the new ACL hook
> > implementations call into the existing xattr implementations inside
> > each LSM I think that would be okay to start.
>
> Yeah, I realized right after I sent the mail that I'd need to implement
> them. I think I came up with something fairly minimal for all lsms and
> the integrity modules. I folded the trivial patches for adding get, set,
> and remove hooks for the individual modules together to not needlessly
> inflate the security portion of the patchset.

I'll keep an eye out for v3.

-- 
paul-moore.com
