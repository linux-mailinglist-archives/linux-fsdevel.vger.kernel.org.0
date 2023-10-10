Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB47BFD1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJJNRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 09:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjJJNRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:17:31 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1556B91;
        Tue, 10 Oct 2023 06:17:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-419b628e990so38199711cf.0;
        Tue, 10 Oct 2023 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696943848; x=1697548648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19tt6EBsUHemMRLgYoqS6RYoR8mb9TYTwnOJ7ItB/BU=;
        b=PB0BZ4sH6gS+wxjY4Va1xEsFsZiDm6SgbxWTc4cOhTXtxzvaVpI/1Z7bMaGEE1wTP7
         6gCH/VrTVZm5PDOSMpWcnJsAw9wqHPCBr46rgY6lZhG9uGIdtDXILcnPLE6aIPqzE7cC
         AwktcywbINB6sT/sGWB3jhVlRuaV+55HBC+56E+hyCFv4TCVeXHiRz/ylqZFFninpjaT
         SdR6st22UXx7UaBMrRbBe7rkej4PnOd+TH0wbJyE0Wt4t4+FqFCZtnNjoHWEPmYLL/Lc
         21qOuR4dGYejUwM4CJKXPWpitsjtl1h35OgxTl7cmfvGNurSYVgW8UBZyZVZFHcQnEv0
         XS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696943848; x=1697548648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19tt6EBsUHemMRLgYoqS6RYoR8mb9TYTwnOJ7ItB/BU=;
        b=l+tpRCXkTnjYFrCDuADVezRbtPCGz4YkYxSQU0/AgOuYGMHoJdgB5Q+iYqvjYVCJGI
         QdgeRCZ/3mOLSRytyTmK5jvj2UC6BOuX1wOa29H99LWL3yj3YmatYV6JQL3PX42mcod3
         9Tm8WKCwh4qanN5R79MQOV+IQhlwV8i3o5KVlxdBP4tcnHQFc3Ik4ZOZbdFIvMhuXC36
         zUTyS1em5vPbBU0Y2hNnTwN7agATKBbDXLE3RMasI+EC8nAR0dyS5ciJ2k3gIQ1Wq+2V
         bJKOzlG5ZoyAv3BSjfm7pzm+8qs2iEPWA1NebJoy/joZFHN20Bq6r6fIZERw+qpkDI0F
         ocoQ==
X-Gm-Message-State: AOJu0YyrQYkH4GCAvU6EF180UaUoBFVi4JWKQLY/SZYJ7y6mIrYLxiC3
        HYvhV7DtdACe9Ie5oK1bnDJglGrdrFrThvog3kxMBrsn
X-Google-Smtp-Source: AGHT+IFh+6p2SOLFlFFdw1/UiCm3eDtMFN95jIrH9kDdkpmmq+E/SNG8PpdIuzAGfgp1FeCzzVe4twPBoppBkY5BRRc=
X-Received: by 2002:a05:622a:1aa0:b0:412:1926:3365 with SMTP id
 s32-20020a05622a1aa000b0041219263365mr22167506qtc.47.1696943847939; Tue, 10
 Oct 2023 06:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com> <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Oct 2023 16:17:17 +0300
Message-ID: <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 10, 2023 at 4:10=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Oct 10, 2023 at 2:59=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Mon, 9 Oct 2023 at 17:37, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > >  static inline void put_file_access(struct file *file)
> > > diff --git a/fs/open.c b/fs/open.c
> > > index fe63e236da22..02dc608d40d8 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -881,7 +881,7 @@ static inline int file_get_write_access(struct fi=
le *f)
> > >         if (unlikely(error))
> > >                 goto cleanup_inode;
> > >         if (unlikely(f->f_mode & FMODE_BACKING)) {
> > > -               error =3D mnt_get_write_access(backing_file_real_path=
(f)->mnt);
> > > +               error =3D mnt_get_write_access(backing_file_user_path=
(f)->mnt);
> > >                 if (unlikely(error))
> > >                         goto cleanup_mnt;
> > >         }
> >
> > Do we really need write access on the overlay mount?
> >
>
> I'd rather this vfs code be generic and not assume things about
> ovl private mount.
> These assumptions may not hold for fuse passthough backing files.
>
> That said, if we have an open(O_RDWR),mmap(PROT_WRITE),close()
> sequence on overlayfs, don't we need the write access on ovl_upper_mnt
> in order to avoid upper sb from being remounted RO?
>

Sorry, you asked about ovl mount.
To me it makes sense that if users observe ovl paths in writable mapped
memory, that ovl should not be remounted RO.
Anyway, I don't see a good reason to allow remount RO for ovl in that case.
Is there?

> > If so, should the order of getting write access not be the other way
> > round (overlay first, backing second)?
> >
>
> Why is the order important?
> What am I missing?
>
> Thanks,
> Amir.
