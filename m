Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF051B817
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 08:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbiEEGnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 02:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiEEGnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 02:43:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6CE1A3A7;
        Wed,  4 May 2022 23:39:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e5so2945924pgc.5;
        Wed, 04 May 2022 23:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFzgWSvicZ/XoDlji2B9QYRgUw7KCo17xjfB3tjep9E=;
        b=jLSw7SKqlxTKrMtC0kT8DIYT2fZEiKS9oxY35xXiosLrHYj0dzGA8tMzqUJn2Cq/9S
         5pdZzppf5oqvLLkXa/H389PbLWWLZ+cl7KAYALf9SCbZzKzvDSl7vBlFqPJXCE6qM+3q
         lJa0DoJptozdvI8tgeHjqCn7cWwdxXo96bRYBV3CH0i/v+Vj/fxIEdsy8F50zoXpBBXL
         ap+sgOESNa8a7ZA2XPVlIo8EwD+IEVOMI3vCKL+gn7H3AzxJ0Vi1px9VyzsWYNMWUP5Z
         qvLHLmt1ldCRdjj8h8bYbLFrn2SGkBHxd5n97t4B6WESb4qJWVdBl+TOPG1ac7qq1SdX
         n3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFzgWSvicZ/XoDlji2B9QYRgUw7KCo17xjfB3tjep9E=;
        b=Z6mmNot/8lDTgCepH2nVurMfJ8rid/oc5HXLXYaQsKdp8QCRycfU6RvTJEL1U6GCoU
         4uwukLhhkD7dBcl04bjvP+lRQAcTjOoQPtMXrPaYp/SsTOGX1GSgblAyyY9aIacKYW5I
         PVP8W9DlsmnT1+ULq7VKw+eM/7xpthvZcRIdCvADwMj31wLgYzKlmrboNuxuXR4ympmR
         3jPtltHY8MRmhjYv8OB3i9eIySPdCpJwXzdCgT3qv39Tgnbg3xSTjDAjfgKgF587PqNq
         ixQs/Sac7jY+BAn5eKjseXHhVtYarnO+kMlGZN8mOHx8R+FQ7xnUA3AsLb6jytmOLn+C
         bfbQ==
X-Gm-Message-State: AOAM532GKB4rTflMRtxTd9q8Kwpn5iQ0MQXhiKysIpoXYhPNxtT2uVS7
        v0ZDqxZAKs7ZZIfV0KvBKn3tlfcOdC8B7p6xWYLwiUnrGoJAgw==
X-Google-Smtp-Source: ABdhPJw/Jpj/qGebD65QWYSYNM9nQ5k7SijJHYd3PBPYsmwPPR6hlYShQmeOHZ/RS+ePjwIoOOEnW46XMB6Qjyl459I=
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id
 d16-20020a056a0010d000b004f75af447b6mr24926907pfu.6.1651732761849; Wed, 04
 May 2022 23:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-3-dharamhans87@gmail.com> <YnLD1ibtU0FM5nlS@redhat.com>
In-Reply-To: <YnLD1ibtU0FM5nlS@redhat.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Thu, 5 May 2022 12:09:10 +0530
Message-ID: <CACUYsyGOwTjyOZYuAK1sxO9VFFBp-qPOjbQXJgQj2DK-_X1ynA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] FUSE: Implement atomic lookup + open
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 4, 2022 at 11:50 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, May 02, 2022 at 03:55:20PM +0530, Dharmendra Singh wrote:
> > From: Dharmendra Singh <dsingh@ddn.com>
> >
> > We can optimize aggressive lookups which are triggered when
> > there is normal open for file/dir (dentry is new/negative).
> >
> > Here in this case since we are anyway going to open the file/dir
> > with USER SPACE, avoid this separate lookup call into libfuse
> > and combine it with open call into libfuse.
> >
> > This lookup + open in single call to libfuse has been named
> > as atomic open. It is expected that USER SPACE opens the file
> > and fills in the attributes, which are then used to make inode
> > stand/revalidate in the kernel cache.
> >
> > Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> > ---
> >  fs/fuse/dir.c             | 78 ++++++++++++++++++++++++++++++---------
> >  fs/fuse/fuse_i.h          |  3 ++
> >  fs/fuse/inode.c           |  4 +-
> >  include/uapi/linux/fuse.h |  2 +
> >  4 files changed, 69 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index cad3322a007f..6879d3a86796 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -516,18 +516,18 @@ static int get_security_context(struct dentry *entry, umode_t mode,
> >  }
> >
> >  /*
> > - * Atomic create+open operation
> > - *
> > - * If the filesystem doesn't support this, then fall back to separate
> > - * 'mknod' + 'open' requests.
> > + * This is common function for initiating atomic operations into libfuse.
> > + * Currently being used by Atomic create(atomic lookup + create) and
> > + * Atomic open(atomic lookup + open).
> >   */
> > -static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > -                         struct file *file, unsigned int flags,
> > -                         umode_t mode, uint32_t opcode)
> > +static int fuse_atomic_do_common(struct inode *dir, struct dentry *entry,
> > +                              struct dentry **alias, struct file *file,
> > +                              unsigned int flags, umode_t mode, uint32_t opcode)
>
> If this common function is really useful for atomic create + atomic open,
> I will first add a patch which adds a common function and makes FUSE_CREATE_EXT use that function. And in later patch add functionality to do atomic open.
> Just makes code more readable.

This func is commonly used by atomic create and atomic open, both.
atomic open has fuse_do_atomic_open wrapper over it. I just renamed
this func except doing it in a separate patch (just to avoid another
patch though I understand that it might be a little hard to read the
code).


>
> >  {
> >       int err;
> >       struct inode *inode;
> >       struct fuse_mount *fm = get_fuse_mount(dir);
> > +     struct fuse_conn *fc = get_fuse_conn(dir);
> >       FUSE_ARGS(args);
> >       struct fuse_forget_link *forget;
> >       struct fuse_create_in inarg;
> > @@ -539,9 +539,13 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >       void *security_ctx = NULL;
> >       u32 security_ctxlen;
> >       bool atomic_create = (opcode == FUSE_ATOMIC_CREATE ? true : false);
> > +     bool create_op = (opcode == FUSE_CREATE ||
> > +                       opcode == FUSE_ATOMIC_CREATE) ? true : false;
> > +     if (alias)
> > +             *alias = NULL;
> >
> >       /* Userspace expects S_IFREG in create mode */
> > -     BUG_ON((mode & S_IFMT) != S_IFREG);
> > +     BUG_ON(create_op && (mode & S_IFMT) != S_IFREG);
> >
> >       forget = fuse_alloc_forget();
> >       err = -ENOMEM;
> > @@ -553,7 +557,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >       if (!ff)
> >               goto out_put_forget_req;
> >
> > -     if (!fm->fc->dont_mask)
> > +     if (!fc->dont_mask)
> >               mode &= ~current_umask();
> >
> >       flags &= ~O_NOCTTY;
> > @@ -642,8 +646,9 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >                               err = PTR_ERR(res);
> >                               goto out_err;
> >                       }
> > -                     /* res is expected to be NULL since its REG file */
> > -                     WARN_ON(res);
> > +                     entry = res;
> > +                     if (alias)
> > +                             *alias = res;
> >               }
> >       }
> >       fuse_change_entry_timeout(entry, &outentry);
> > @@ -681,8 +686,8 @@ static int fuse_atomic_create(struct inode *dir, struct dentry *entry,
> >       if (fc->no_atomic_create)
> >               return -ENOSYS;
> >
> > -     err = fuse_create_open(dir, entry, file, flags, mode,
> > -                            FUSE_ATOMIC_CREATE);
> > +     err = fuse_atomic_do_common(dir, entry, NULL, file, flags, mode,
> > +                                 FUSE_ATOMIC_CREATE);
> >       /* If atomic create is not implemented then indicate in fc so that next
> >        * request falls back to normal create instead of going into libufse and
> >        * returning with -ENOSYS.
> > @@ -694,6 +699,29 @@ static int fuse_atomic_create(struct inode *dir, struct dentry *entry,
> >       return err;
> >  }
> >
> > +static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
> > +                             struct dentry **alias, struct file *file,
> > +                             unsigned int flags, umode_t mode)
> > +{
> > +     int err;
> > +     struct fuse_conn *fc = get_fuse_conn(dir);
> > +
> > +     if (!fc->do_atomic_open)
> > +             return -ENOSYS;
> > +
> > +     err = fuse_atomic_do_common(dir, entry, alias, file, flags, mode,
> > +                                 FUSE_ATOMIC_OPEN);
> > +     /* Atomic open imply atomic trunc as well i.e truncate should be performed
> > +      * as part of atomic open call itself.
> > +      */
> > +     if (!fc->atomic_o_trunc) {
> > +             if (fc->do_atomic_open)
> > +                     fc->atomic_o_trunc = 1;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> >  static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
> >                     umode_t, dev_t);
> >  static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> > @@ -702,12 +730,23 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> >  {
> >       int err;
> >       struct fuse_conn *fc = get_fuse_conn(dir);
> > -     struct dentry *res = NULL;
> > +     struct dentry *res = NULL, *alias = NULL;
> >       bool create = flags & O_CREAT ? true : false;
> >
> >       if (fuse_is_bad(dir))
> >               return -EIO;
> >
> > +     if (!create) {
> > +             err = fuse_do_atomic_open(dir, entry, &alias,
> > +                                       file, flags, mode);
>
> So this is the core change of behavior. As of now, if we are not doing
> create operation, we just lookup and return. But now you are doing
> open + lookup in a single operation. Interesting. I am not sure if
> it breaks anything in VFS.

Yes, here we are handling optimizing lookups for open calls. If atomic
open is implemented underlying we use it otherwise falls back to
normal open.

>
> > +             res = alias;
> > +             if (!err || err != -ENOSYS)
> > +                     goto out_dput;
> > +     }
> > +      /*
> > +       * ENOSYS fall back for open- user space does not have full
> > +       * atomic open.
> > +       */
>
> This ENOSYS stuff all the place is making these patches look very unclean
> to me. A part of me says that should we negotiate these as feature bits.
> Having said that feature bits are precious and should not be used for
> trivial purposes. Hmm..., may be we can make handle ENOSYS little better
> in general.

Actually atomic open is based upon init bits considering the 3rd patch
which optimizes lookups in d_revalidate(). I would see if I can clean
ENOSYS a bit.
>
> >       if ((!create || fc->no_atomic_create) && d_in_lookup(entry)) {
> >               res = fuse_lookup(dir, entry, 0);
> >               if (IS_ERR(res))
> > @@ -730,9 +769,14 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> >       /* Libfuse/user space has not implemented atomic create, therefore
> >        * fall back to normal create.
> >        */
> > -     if (err == -ENOSYS)
> > -             err = fuse_create_open(dir, entry, file, flags, mode,
> > -                                    FUSE_CREATE);
> > +     /* Atomic create+open operation
> > +      * If the filesystem doesn't support this, then fall back to separate
> > +      * 'mknod' + 'open' requests.
> > +      */
> > +     if (err == -ENOSYS) {
> > +             err = fuse_atomic_do_common(dir, entry, NULL, file, flags,
> > +                                         mode, FUSE_CREATE);
> > +     }
> >       if (err == -ENOSYS) {
> >               fc->no_create = 1;
> >               goto mknod;
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index d577a591ab16..24793b82303f 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -669,6 +669,9 @@ struct fuse_conn {
> >       /** Is open/release not implemented by fs? */
> >       unsigned no_open:1;
> >
> > +     /** Is atomic open implemented by fs ? */
> > +     unsigned do_atomic_open : 1;
> > +
> >       /** Is atomic create not implemented by fs? */
> >       unsigned no_atomic_create:1;
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index ee846ce371d8..5f667de69115 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1190,6 +1190,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >                               fc->setxattr_ext = 1;
> >                       if (flags & FUSE_SECURITY_CTX)
> >                               fc->init_security = 1;
> > +                     if (flags & FUSE_DO_ATOMIC_OPEN)
> > +                             fc->do_atomic_open = 1;
>
> Hey you are negotiating FUSE_DO_ATOMIC_OPEN flag. If that's the case why
> do you have to deal with -ENOSYS in fuse_do_atomic_open(). You should
> be able to just check.
>
> if (!create && fc->do_atomic_open) {
>         fuse_do_atomic_open().
> }

You are right. This happens due to the reason that we have auto atomic
create check in atomic create but yes, we do not need ENOSYS here. I
will clean it.


> I have yet to check what happens if file does not exist.
>
> >               } else {
> >                       ra_pages = fc->max_read / PAGE_SIZE;
> >                       fc->no_lock = 1;
> > @@ -1235,7 +1237,7 @@ void fuse_send_init(struct fuse_mount *fm)
> >               FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
> >               FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> >               FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
> > -             FUSE_SECURITY_CTX;
> > +             FUSE_SECURITY_CTX | FUSE_DO_ATOMIC_OPEN;
> >  #ifdef CONFIG_FUSE_DAX
> >       if (fm->fc->dax)
> >               flags |= FUSE_MAP_ALIGNMENT;
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index e4b56004b148..ab91e391241a 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -391,6 +391,7 @@ struct fuse_file_lock {
> >  /* bits 32..63 get shifted down 32 bits into the flags2 field */
> >  #define FUSE_SECURITY_CTX    (1ULL << 32)
> >  #define FUSE_HAS_INODE_DAX   (1ULL << 33)
> > +#define FUSE_DO_ATOMIC_OPEN  (1ULL << 34)
> >
> >  /**
> >   * CUSE INIT request/reply flags
> > @@ -540,6 +541,7 @@ enum fuse_opcode {
> >       FUSE_REMOVEMAPPING      = 49,
> >       FUSE_SYNCFS             = 50,
> >       FUSE_ATOMIC_CREATE      = 51,
> > +     FUSE_ATOMIC_OPEN        = 52,
> >
> >       /* CUSE specific operations */
> >       CUSE_INIT               = 4096,
> > --
> > 2.17.1
> >
>
