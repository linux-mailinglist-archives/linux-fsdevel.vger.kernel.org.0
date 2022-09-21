Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530CC5C0031
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIUOoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 10:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiIUOou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:44:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E3B11C09
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:44:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z97so9011505ede.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qGFU/5VhUefW7XBzQV1VrVnJM9+Ut+QbpEPjRFsby2c=;
        b=mp/jqn3BLYYuTAvbmO13SqtWSps3eeeA7LCmCAo6k7xUkd1X1cxr1cKwSPzkmNR11T
         t7GNu+hAfBwuhXcwIGtKpBL8E2vYrcvmuwc+lQHB+g7i/VAvuZEsF4m5w5j+wuPwahZq
         LoMIqw3roldlV+6dywPNvhaBpEVn0JwacMygI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qGFU/5VhUefW7XBzQV1VrVnJM9+Ut+QbpEPjRFsby2c=;
        b=6mR1IEoyWTZCz9dfKP7m2oRoqnpKgQ0Fh8H/Kgn0TtWdam24pra2xnB0L+uhvRyDmi
         1ewkPM5qvEVv8Hvh19FAiA4ezUuIxtMALr+vVOx5V2L9RgG83PVv46AqafQLV1QT3inq
         3wIegjqmfzknbWSoZb2EXhBN26BSWz97em13u2QelJlo3oxwioMRzDKQoax/lIX++y7w
         rwjOoCc7JcEEAyes10LX7gbM44j8bEiwWCtLoD7L2uuK5rmJi7p0EfB1Jd0Fu7VSWO2v
         8qgcHf42oT+117kNs/Kzr8QhTOqDpjmgE3RnyUIEemAc6X/if3/qXtg51yy5CQ8LD6bk
         NhSQ==
X-Gm-Message-State: ACrzQf2hbH0dbyj5cI2PvcxmYxM5Q7PaYf2jIBNwTzdx846/9r+CJL6V
        c+4vgis5x3P2wKZcioeyATwTbIuCz0WbNSiyaGHOBg==
X-Google-Smtp-Source: AMsMyM6yP8UusPKTggbSJfTHVJAy/Ga3VQKqz9d63IdUNsUkniA+ijTZCgEp/UeQxmz9zF2+G4SB1K/IkylgKYKeyHk=
X-Received: by 2002:a50:ef03:0:b0:44e:82bf:28e6 with SMTP id
 m3-20020a50ef03000000b0044e82bf28e6mr24218282eds.270.1663771479243; Wed, 21
 Sep 2022 07:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220920193632.2215598-1-mszeredi@redhat.com> <20220920193632.2215598-5-mszeredi@redhat.com>
 <20220921082612.n5z43657f6t3z37s@wittgenstein>
In-Reply-To: <20220921082612.n5z43657f6t3z37s@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Sep 2022 16:44:28 +0200
Message-ID: <CAJfpegsAGr4o50dsArzUPuaU1KF7vi3rgAYt4ES1-80QxXqyiw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] cachefiles: use tmpfile_open() helper
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

On Wed, 21 Sept 2022 at 10:27, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Sep 20, 2022 at 09:36:27PM +0200, Miklos Szeredi wrote:
> > Use the tmpfile_open() helper instead of doing tmpfile creation and opening
> > separately.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/cachefiles/namei.c | 26 ++++++++++----------------
> >  1 file changed, 10 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index d3a5884fe5c9..44f575328af4 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -451,18 +451,19 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
> >       const struct cred *saved_cred;
> >       struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
> >       struct file *file;
> > -     struct path path;
> > +     struct path path = { .mnt = cache->mnt, .dentry = fan };
> >       uint64_t ni_size;
> >       long ret;
>
> Maybe we shouldn't use struct path to first refer to the parent path and
> then to the tmp path to avoid any potential confusion and instead rely
> on a compount initializer for the tmpfile_open() call (__not tested__)?:
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 44f575328af4..979b2f173ac3 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -451,7 +451,7 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
>         const struct cred *saved_cred;
>         struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
>         struct file *file;
> -       struct path path = { .mnt = cache->mnt, .dentry = fan };
> +       struct path path;
>         uint64_t ni_size;
>         long ret;
>
> @@ -460,8 +460,10 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
>
>         ret = cachefiles_inject_write_error();
>         if (ret == 0) {
> -               file = tmpfile_open(&init_user_ns, &path, S_IFREG,
> -                                   O_RDWR | O_LARGEFILE | O_DIRECT,
> +               file = tmpfile_open(&init_user_ns,
> +                                   &{const struct path} {.mnt = cache->mnt,
> +                                                         .dentry = fan},

This doesn't look nice.   I fixed it with a separate "parentpath" variable.

Thanks,
Miklos
