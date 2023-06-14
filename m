Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131AE730084
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245164AbjFNNte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245183AbjFNNtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:49:11 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23722100;
        Wed, 14 Jun 2023 06:49:09 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-789ca7e52d4so674323241.0;
        Wed, 14 Jun 2023 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686750549; x=1689342549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgmN305Wj0VktfD8rD9oW6+ePHLMd6mOL3Sd4UaWnI0=;
        b=p81G1Jf2579C38xZnBX6gMdZ9YZWlzudLwMP7orB7Z60xv/CPD08w5rDcfm4mCpFyC
         v1xGSHxNso5a1pyx36NwdINr9gJpyNrojn/UyrPMmw7Qe06PujKeRp4pi7uKjDVQVGze
         ohipMF2jF73lpTGfrq0CSm0zlQJ9Ph3kQcqW8/IEOGDrxj7IFdud0ilKU042R7ELr1QV
         n94xTBGdJFoCk1kAxvZCrakVOClLCkkBlF9g6enNQY7/6XGezlm98axxuZ1sduxHHpQn
         qUzf62+xdobBvpa5tE352jzdPLJvZhrIJ1itZLjragfNSdidzg1F6kx/U2G8MUKfL3Le
         TIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750549; x=1689342549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgmN305Wj0VktfD8rD9oW6+ePHLMd6mOL3Sd4UaWnI0=;
        b=froMGv1S5XtjWSCYXxhQibor8DzVss9hLP72s/sr0PJMAXz1/qS7+7pnqLis8VWq3l
         r1YxAJnQ0V1Om3tmyilwzNQtvrqyiP7clITh8lQ2nyNKww45MA8JTyKmy+JUdX7aIzRD
         K9u2j+D3NQxOF0SRAGg51cjQE3rZ0Guwc7Grz7JCg6ORApkyTDxgnkU2mjTsDOg2FLB4
         rFbYnHnTVT3dT4VH8+mwAFyqKOpGwekJcbKH1jCx6tExE4Y/mr8JJx9cUtvyVzkmlH08
         BZthmaKu9hR2h+Sb5Km1+O41JHDnzarDlgoGY/8IYLLqgkLc3nPC7CAcwzx6XVH11e86
         wEjQ==
X-Gm-Message-State: AC+VfDyp+5deXLl0y9Y4tg+wA1rj7yg5UVI0tLIP+6rYVg66IaeycD7L
        PBoWgxYAl0q9FEAThUv6U1K5RRNKs1hgfAnR2BI=
X-Google-Smtp-Source: ACHHUZ4DXAhmvNdojQdOSxTiILri07BloeJIZu3E/ALspY+ee76S0oGx+Sr1gI4DzmLW/IeYs2GlptXe0nV6MqaE83w=
X-Received: by 2002:a67:b342:0:b0:43b:ee9f:69dd with SMTP id
 b2-20020a67b342000000b0043bee9f69ddmr4465754vsm.10.1686750548930; Wed, 14 Jun
 2023 06:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230614074907.1943007-1-amir73il@gmail.com> <20230614074907.1943007-2-amir73il@gmail.com>
 <20230614-kilowatt-kindgerecht-46c7210ee82e@brauner>
In-Reply-To: <20230614-kilowatt-kindgerecht-46c7210ee82e@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 14 Jun 2023 16:48:57 +0300
Message-ID: <CAOQ4uxgjKUm9-khLsmWAMqfKk03C2FYbJ-Dp75KZ0LJbqbsRdw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fs: use backing_file container for internal files
 with "fake" f_path
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Wed, Jun 14, 2023 at 4:26=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Jun 14, 2023 at 10:49:06AM +0300, Amir Goldstein wrote:
> > Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> > files, where overlayfs also puts a "fake" path in f_path - a path which
> > is not on the same fs as f_inode.
> >
> > Allocate a container struct backing_file for those internal files, that
> > is used to hold the "fake" ovl path along with the real path.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/cachefiles/namei.c |  4 +--
> >  fs/file_table.c       | 74 +++++++++++++++++++++++++++++++++++++------
> >  fs/internal.h         |  5 +--
> >  fs/open.c             | 30 +++++++++++-------
> >  fs/overlayfs/file.c   |  4 +--
> >  include/linux/fs.h    | 24 +++++++++++---
> >  6 files changed, 109 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index 82219a8f6084..283534c6bc8d 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -560,8 +560,8 @@ static bool cachefiles_open_file(struct cachefiles_=
object *object,
> >        */
> >       path.mnt =3D cache->mnt;
> >       path.dentry =3D dentry;
> > -     file =3D open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRE=
CT,
> > -                                d_backing_inode(dentry), cache->cache_=
cred);
> > +     file =3D open_backing_file(&path, O_RDWR | O_LARGEFILE | O_DIRECT=
,
> > +                              &path, cache->cache_cred);
> >       if (IS_ERR(file)) {
> >               trace_cachefiles_vfs_error(object, d_backing_inode(dentry=
),
> >                                          PTR_ERR(file),
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 372653b92617..138d5d405df7 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -44,18 +44,40 @@ static struct kmem_cache *filp_cachep __read_mostly=
;
> >
> >  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> >
> > +/* Container for backing file with optional real path */
> > +struct backing_file {
> > +     struct file file;
> > +     struct path real_path;
> > +};
> > +
> > +static inline struct backing_file *backing_file(struct file *f)
> > +{
> > +     return container_of(f, struct backing_file, file);
> > +}
> > +
> > +struct path *backing_file_real_path(struct file *f)
> > +{
> > +     return &backing_file(f)->real_path;
> > +}
> > +EXPORT_SYMBOL_GPL(backing_file_real_path);
> > +
> >  static void file_free_rcu(struct rcu_head *head)
> >  {
> >       struct file *f =3D container_of(head, struct file, f_rcuhead);
> >
> >       put_cred(f->f_cred);
> > -     kmem_cache_free(filp_cachep, f);
> > +     if (unlikely(f->f_mode & FMODE_BACKING))
> > +             kfree(backing_file(f));
> > +     else
> > +             kmem_cache_free(filp_cachep, f);
> >  }
> >
> >  static inline void file_free(struct file *f)
> >  {
> >       security_file_free(f);
> > -     if (!(f->f_mode & FMODE_NOACCOUNT))
> > +     if (unlikely(f->f_mode & FMODE_BACKING))
> > +             path_put(backing_file_real_path(f));
> > +     else
> >               percpu_counter_dec(&nr_files);
>
> I think this needs to be:
>
> if (unlikely(f->f_mode & FMODE_BACKING))
>         path_put(backing_file_real_path(f));
>
> if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
>         percpu_counter_dec(&nr_files);
>
> as we do have FMODE_NOACCOUNT without FMODE_BACKING.
>

Ouch! good catch!

Thanks,
Amir.
