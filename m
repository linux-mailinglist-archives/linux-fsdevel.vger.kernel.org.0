Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B682729974
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjFIMU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFIMU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:20:28 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D9E50;
        Fri,  9 Jun 2023 05:20:26 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-78a03acc52aso655398241.3;
        Fri, 09 Jun 2023 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686313226; x=1688905226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Joeo2VGslW5nDPEMPNoLIcq82KBXhK3jduAZzFdQBkc=;
        b=mJYFJ6tGVL53YybXCBWce/nu7E+shNurbZciJg+RZHDEzDVHnduGSmoEAiCFq+mVfu
         15kvty21uJ/dyofssH3TWk6BJWz4N1OxnofkUu8rzOuGbuSMJ0ToaAv7VZK63rT/kSVj
         1lM8jpBtvSRia5zkFs/UmQkvvmoglSnypa6S4sQxz1zLvo3G3uCW9pc7kH0+Bbn73CZ4
         OyDU93HU6w46VgqEJEd3PgFAxLozY+hQXOZdLJ/0fz79ND4qIl2n9nJov5DeyiGs6yHO
         vf4CF7auA+nNAXe3I0DKDg3f4ajuAItv0gOsrQhSWRI2nOfXO6jrkxx5mfqH2kNDY/cF
         iKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686313226; x=1688905226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Joeo2VGslW5nDPEMPNoLIcq82KBXhK3jduAZzFdQBkc=;
        b=K5378zVBADw9sRlVU1/KoCuJUepXWJpPDq1I7WgGmQr0dgpdd3qQ94nsmLTrhhvhVX
         3iWDHrjnW0D2tzdL48i43PtqhGyigK+312CQFC8pkXnv42UYICjU2/ODzJwKnDY+nDo5
         9XlhuFxxw49kJOW/ViD4MlmjPXSN3Y0AHgefQJkeuk+P2hDgV+KQtQNVCONsIz3Xx1Ow
         ycglRJ7uwA1FQrGqw8ufwzODDHS3za7bSUHMjdgRVXJoQ7mbHhOQ7fMJ/H+wjKJTq9TJ
         A2ax1mrB+WMPlGJguDujp9WYYSbN81msDVi6yy+I+d4lFY3kVmwe79kIrrnb2yqUTGRi
         9huw==
X-Gm-Message-State: AC+VfDz55v9SVVEYcSjQ+k+DUYP7xkyVElzbpEg+Xc2+dv6A6v872ges
        cTHjT2A//VoP75uc4x85Gw2YxaTPFxUjjAzNSxc=
X-Google-Smtp-Source: ACHHUZ4KaT5ihVBu9DZ3VuW3QoLJWCx8Y8awcL3xPqh36eis7QMe7Gs1+bfWwXxl5wOA5Lo4VHRZFaZxmD7x716gF90=
X-Received: by 2002:a67:f803:0:b0:43b:16cf:1dda with SMTP id
 l3-20020a67f803000000b0043b16cf1ddamr790148vso.27.1686313225799; Fri, 09 Jun
 2023 05:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <20230609073239.957184-2-amir73il@gmail.com>
 <20230609-umwandeln-zuhalten-dc8b985a7ad1@brauner> <CAOQ4uxgR5z3yGqJ7jna=r45_Gru5LePU57XG++Ew_9pGWKcwCQ@mail.gmail.com>
 <20230609-fakten-bildt-4bda22b203f8@brauner>
In-Reply-To: <20230609-fakten-bildt-4bda22b203f8@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 15:20:14 +0300
Message-ID: <CAOQ4uxgfvXdkWWLnz=5s6JxP2L50JOsZv63f0P9-KhuHtCEaCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs: use fake_file container for internal files with
 fake f_path
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 3:12=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jun 09, 2023 at 02:57:20PM +0300, Amir Goldstein wrote:
> > On Fri, Jun 9, 2023 at 2:32=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Fri, Jun 09, 2023 at 10:32:37AM +0300, Amir Goldstein wrote:
> > > > Overlayfs and cachefiles use open_with_fake_path() to allocate inte=
rnal
> > > > files, where overlayfs also puts a "fake" path in f_path - a path w=
hich
> > > > is not on the same fs as f_inode.
> > > >
> > > > Allocate a container struct file_fake for those internal files, tha=
t
> > > > will be used to hold the fake path qlong with the real path.
> > > >
> > > > This commit does not populate the extra fake_path field and leaves =
the
> > > > overlayfs internal file's f_path fake.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/cachefiles/namei.c |  2 +-
> > > >  fs/file_table.c       | 85 +++++++++++++++++++++++++++++++++++----=
----
> > > >  fs/internal.h         |  5 ++-
> > > >  fs/namei.c            |  2 +-
> > > >  fs/open.c             | 11 +++---
> > > >  fs/overlayfs/file.c   |  2 +-
> > > >  include/linux/fs.h    | 13 ++++---
> > > >  7 files changed, 90 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > > > index 82219a8f6084..a71bdf2d03ba 100644
> > > > --- a/fs/cachefiles/namei.c
> > > > +++ b/fs/cachefiles/namei.c
> > > > @@ -561,7 +561,7 @@ static bool cachefiles_open_file(struct cachefi=
les_object *object,
> > > >       path.mnt =3D cache->mnt;
> > > >       path.dentry =3D dentry;
> > > >       file =3D open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_=
DIRECT,
> > > > -                                d_backing_inode(dentry), cache->ca=
che_cred);
> > > > +                                &path, cache->cache_cred);
> > > >       if (IS_ERR(file)) {
> > > >               trace_cachefiles_vfs_error(object, d_backing_inode(de=
ntry),
> > > >                                          PTR_ERR(file),
> > > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > > index 372653b92617..adc2a92faa52 100644
> > > > --- a/fs/file_table.c
> > > > +++ b/fs/file_table.c
> > > > @@ -44,18 +44,48 @@ static struct kmem_cache *filp_cachep __read_mo=
stly;
> > > >
> > > >  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> > > >
> > > > +/* Container for file with optional fake path to display in /proc =
files */
> > > > +struct file_fake {
> > > > +     struct file file;
> > > > +     struct path fake_path;
> > > > +};
> > > > +
> > > > +static inline struct file_fake *file_fake(struct file *f)
> > > > +{
> > > > +     return container_of(f, struct file_fake, file);
> > > > +}
> > > > +
> > > > +/* Returns fake_path if one exists, f_path otherwise */
> > > > +const struct path *file_fake_path(struct file *f)
> > > > +{
> > > > +     struct file_fake *ff =3D file_fake(f);
> > > > +
> > > > +     if (!(f->f_mode & FMODE_FAKE_PATH) || !ff->fake_path.dentry)
> > > > +             return &f->f_path;
> > > > +
> > > > +     return &ff->fake_path;
> > > > +}
> > > > +EXPORT_SYMBOL(file_fake_path);
> > > > +
> > > >  static void file_free_rcu(struct rcu_head *head)
> > > >  {
> > > >       struct file *f =3D container_of(head, struct file, f_rcuhead)=
;
> > > >
> > > >       put_cred(f->f_cred);
> > > > -     kmem_cache_free(filp_cachep, f);
> > > > +     if (f->f_mode & FMODE_FAKE_PATH)
> > > > +             kfree(file_fake(f));
> > > > +     else
> > > > +             kmem_cache_free(filp_cachep, f);
> > > >  }
> > > >
> > > >  static inline void file_free(struct file *f)
> > > >  {
> > > > +     struct file_fake *ff =3D file_fake(f);
> > > > +
> > > >       security_file_free(f);
> > > > -     if (!(f->f_mode & FMODE_NOACCOUNT))
> > > > +     if (f->f_mode & FMODE_FAKE_PATH)
> > > > +             path_put(&ff->fake_path);
> > > > +     else
> > > >               percpu_counter_dec(&nr_files);
> > > >       call_rcu(&f->f_rcuhead, file_free_rcu);
> > > >  }
> > > > @@ -131,20 +161,15 @@ static int __init init_fs_stat_sysctls(void)
> > > >  fs_initcall(init_fs_stat_sysctls);
> > > >  #endif
> > > >
> > > > -static struct file *__alloc_file(int flags, const struct cred *cre=
d)
> > > > +static int init_file(struct file *f, int flags, const struct cred =
*cred)
> > > >  {
> > > > -     struct file *f;
> > > >       int error;
> > > >
> > > > -     f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> > > > -     if (unlikely(!f))
> > > > -             return ERR_PTR(-ENOMEM);
> > > > -
> > > >       f->f_cred =3D get_cred(cred);
> > > >       error =3D security_file_alloc(f);
> > > >       if (unlikely(error)) {
> > > >               file_free_rcu(&f->f_rcuhead);
> > > > -             return ERR_PTR(error);
> > > > +             return error;
> > > >       }
> > > >
> > > >       atomic_long_set(&f->f_count, 1);
> > > > @@ -155,6 +180,22 @@ static struct file *__alloc_file(int flags, co=
nst struct cred *cred)
> > > >       f->f_mode =3D OPEN_FMODE(flags);
> > > >       /* f->f_version: 0 */
> > > >
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static struct file *__alloc_file(int flags, const struct cred *cre=
d)
> > > > +{
> > > > +     struct file *f;
> > > > +     int error;
> > > > +
> > > > +     f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> > > > +     if (unlikely(!f))
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +
> > > > +     error =3D init_file(f, flags, cred);
> > > > +     if (unlikely(error))
> > > > +             return ERR_PTR(error);
> > > > +
> > > >       return f;
> > > >  }
> > > >
> > > > @@ -201,18 +242,32 @@ struct file *alloc_empty_file(int flags, cons=
t struct cred *cred)
> > > >  }
> > > >
> > > >  /*
> > > > - * Variant of alloc_empty_file() that doesn't check and modify nr_=
files.
> > > > + * Variant of alloc_empty_file() that allocates a file_fake contai=
ner
> > > > + * and doesn't check and modify nr_files.
> > > >   *
> > > >   * Should not be used unless there's a very good reason to do so.
> > > >   */
> > > > -struct file *alloc_empty_file_noaccount(int flags, const struct cr=
ed *cred)
> > > > +struct file *alloc_empty_file_fake(const struct path *fake_path, i=
nt flags,
> > > > +                                const struct cred *cred)
> > > >  {
> > > > -     struct file *f =3D __alloc_file(flags, cred);
> > > > +     struct file_fake *ff;
> > > > +     int error;
> > > >
> > > > -     if (!IS_ERR(f))
> > > > -             f->f_mode |=3D FMODE_NOACCOUNT;
> > > > +     ff =3D kzalloc(sizeof(struct file_fake), GFP_KERNEL);
> > > > +     if (unlikely(!ff))
> > > > +             return ERR_PTR(-ENOMEM);
> > > >
> > > > -     return f;
> > > > +     error =3D init_file(&ff->file, flags, cred);
> > > > +     if (unlikely(error))
> > > > +             return ERR_PTR(error);
> > > > +
> > > > +     ff->file.f_mode |=3D FMODE_FAKE_PATH;
> > > > +     if (fake_path) {
> > > > +             path_get(fake_path);
> > > > +             ff->fake_path =3D *fake_path;
> > > > +     }
> > >
> > > Hm, I see that this check is mostly done for vfs_tmpfile_open() which
> > > only fills in file->f_path in vfs_tmpfile() but leaves ff->fake_path
> > > NULL.
> > >
> > > So really I think having FMODE_FAKE_PATH set but ff->fake_path be NUL=
L
> > > is an invitation for NULL derefs sooner or later. I would simply
> > > document that it's required to set ff->fake_path. For callers such as
> > > vfs_tmpfile_open() it can just be path itself. IOW, vfs_tmpfile_open(=
)
> > > should set ff->fake_path to file->f_path.
> >
> > Makes sense.
> > I also took the liberty to re-arrange vfs_tmpfile_open() without the
> > unneeded if (!error) { nesting depth.
>
> Yes, please. I had a rough sketch just for my own amusement...

Happy to make your Friday more amusing :-D

>
> fs/namei.c
>   struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
>                                 const struct path *parentpath, umode_t mo=
de,
>                                 int open_flag, const struct cred *cred)
>   {
>           struct file *file;
>           int error;
>
>           file =3D alloc_empty_file_fake(open_flag, cred);
>           if (IS_ERR(file))
>                   return file;
>
>           error =3D vfs_tmpfile(idmap, parentpath, file, mode);
>           if (error) {
>                   fput(file);
>                   return ERR_PTR(error);
>           }
>
>           return file_set_fake_path(file, &file->f_path);
>   }
>   EXPORT_SYMBOL(vfs_tmpfile_open);
>
> fs/internal.h
>   struct file *file_set_fake_path(struct file *file, const struct path *f=
ake_path);
>
> fs/open.c
>   struct file *open_with_fake_path(const struct path *fake_path, int flag=
s,
>                                    const struct path *path,
>                                    const struct cred *cred)
>   {
>           int error;
>           struct file *file;
>
>           file =3D alloc_empty_file_fake(flags, cred);
>           if (IS_ERR(file))
>                   return file;
>
>           file->f_path =3D *path;
>           error =3D do_dentry_open(file, d_inode(path->dentry), NULL);
>           if (error) {
>                   fput(file);
>                   return ERR_PTR(error);
>           }
>
>           return file_set_fake_path(file, fake_path);
>   }
>
> fs/file_table.c
>   struct file *alloc_empty_file_fake(int flags, const struct cred *cred)
>   {
>           struct file_fake *ff;
>           int error;
>
>           ff =3D kzalloc(sizeof(struct file_fake), GFP_KERNEL);
>           if (unlikely(!ff))
>                   return ERR_PTR(-ENOMEM);
>
>           error =3D init_file(&ff->file, flags, cred);
>           if (unlikely(error))
>                   return ERR_PTR(error);
>
>           ff->file.f_mode |=3D FMODE_FAKE_PATH;
>           return &ff->file;
>   }
>
>   struct file *file_set_fake_path(struct file *file, const struct path *f=
ake_path)
>   {
>           if (file->f_mode & FMODE_FAKE_PATH) {
>                   struct file_fake *ff =3D file_fake(file);
>                   ff->fake_path =3D *fake_path;
>           }
>
>           return file;
>   }
>

Heh, I also started with file_set_fake_path() but I decided that it's not
worth it, because no code should be messing with this and I just changed
file_fake_path() to be non-const and used *file_fake_path(file) =3D fake_pa=
th
in these two helpers.

I will add file_set_fake_path *only* if you insist.

Thanks,
Amir.
