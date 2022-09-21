Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B05C009C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiIUPBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIUPA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:00:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444392F39F
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:00:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a26so14313700ejc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KraO13od8Hlz+A1Q2cHmre427lMvb9k4Z/xR4oCqizc=;
        b=BRo4gUUqeyx84riYoM72b5EvsXMx/3h5l64fGQTtcjN+7tfLDLcZNKPM0XhmpsWSQG
         0n3srJV1vt3lYfpYqYN+Rt+JZaZP/r6cri2uqfjs9uFNEAkr37AASefjKDmCYzee7a4X
         3sFdwzLMVK3FQLlZbFeEYhTh6A4rcOWmgRVyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KraO13od8Hlz+A1Q2cHmre427lMvb9k4Z/xR4oCqizc=;
        b=KKjJ/ezfZFr/B86vownF6OX3mDxlB7R+3hc4lLiDH/kFztkCZ/b65ePu8UzATlZoST
         kgdW7kX9ZIZ1bcY0cZO+MeEN3yT8IpmmLYwvqSTX6FAc8d987LaJxmmpp3l4WA2jCghb
         i3IDyXl/4YZZgIjtyGcoAWltRkOB7X4mKCHuyMsoM2v6byOlre1Fj5bLaEczaqaEsCfS
         HRxPj8yM0rBrbAHzg+w3RRjYZ2Vd9u1P2ixQCYRoqUJtrHUZfZvgZ3F5fsliSJxGyY8s
         NnKLd0Rf3CiS+2wQEx1AVHdFJm3Tzvxfj1qwo6Da5v9KhHXWdxw+IMFhukM0KfOeUn64
         vRGw==
X-Gm-Message-State: ACrzQf1o2bLOubzRSvWuJVcDmFEmzVqGQFE73vrw+chID+kWJEKY5ug+
        XDQmBndB+TbapZN6+OfJDxMSk+o7H6JZ56CGC1KYWA==
X-Google-Smtp-Source: AMsMyM4IgaGtb0FpEsFq2Pz2+OPQ7xI7mrBMYs+rRS+Y+bt3/1M3YAjX93ESTN3/CL0d1kYj4DJ9meOazppCk1FtK5k=
X-Received: by 2002:a17:907:6093:b0:780:7671:2c97 with SMTP id
 ht19-20020a170907609300b0078076712c97mr21269376ejc.8.1663772456750; Wed, 21
 Sep 2022 08:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220920193632.2215598-1-mszeredi@redhat.com> <20220920193632.2215598-10-mszeredi@redhat.com>
 <20220921091553.6iawx562png2pmnk@wittgenstein>
In-Reply-To: <20220921091553.6iawx562png2pmnk@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Sep 2022 17:00:45 +0200
Message-ID: <CAJfpegt4eZ8SYhw3wVGN3+h7RA1yhR4ZNiuKtnpps8HtR1df1A@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: implement ->tmpfile()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Sept 2022 at 11:17, Christian Brauner <brauner@kernel.org> wrote:

>
> Hm, seems like this could avoid the goto into an if-block:
>
> static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
>                         struct file *file, umode_t mode)
> {
>         struct fuse_conn *fc = get_fuse_conn(dir);
>         int err;
>
>         if (fc->no_tmpfile)
>                 return -EOPNOTSUPP;
>
>         err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
>         if (err == -ENOSYS) {
>                 fc->no_tmpfile = 1;
>                 err = -EOPNOTSUPP;
>         }
>         return err;
> }

Okay.

> > +
> >  static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> >                     struct dentry *entry, umode_t mode)
> >  {
> > @@ -1913,6 +1931,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
> >       .setattr        = fuse_setattr,
> >       .create         = fuse_create,
> >       .atomic_open    = fuse_atomic_open,
> > +     .tmpfile        = fuse_tmpfile,
> >       .mknod          = fuse_mknod,
> >       .permission     = fuse_permission,
> >       .getattr        = fuse_getattr,
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 488b460e046f..98a9cf531873 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -784,6 +784,9 @@ struct fuse_conn {
> >       /* Does the filesystem support per inode DAX? */
> >       unsigned int inode_dax:1;
> >
> > +     /* Is tmpfile not implemented by fs? */
> > +     unsigned int no_tmpfile:1;
>
> Just a nit, it might be nicer to turn this into a positive, i.e.,
> unsigned int has_tmpfile:1. Easier to understand as people usually
> aren't great at processing negations.

Fuse has zillions of these no_foobar flags.  Turning this single one
into a positive would be much more confusing IMO.

Thanks,
Miklos
