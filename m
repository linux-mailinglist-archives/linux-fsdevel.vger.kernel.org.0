Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4346D7BFCFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjJJNKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJJNKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:10:53 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75657B4;
        Tue, 10 Oct 2023 06:10:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7741b18a06aso403062885a.1;
        Tue, 10 Oct 2023 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696943449; x=1697548249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jms1ujwJI1idg8bEU/bR57E7ZINisVAtSz1uRROW3vM=;
        b=Io8dSZfeHtJVq8ieMHnmYjOUr/LT0TpuR5lP9ddgR0GVuFazKqKKI5AuTsfDLvfWKn
         tkF8PypCMGq1cg1pfvFBCmwwIUWn5l/BPcpBf5lBrrcf9d2uCT73oHCFH43QhXnGzeJQ
         1nsLOqJpav7oQxdGkRYlUPmNf48/bGend4eVv84KAlHn/LjPYS17E84J5muOdd1cnFJs
         tsltSv/IocxOy5jL51q65H6icxGhBS0bAAafrSeHH+zke2G+5lrV46LnsVe9wsOrOHSH
         L6bP03gnTGhXA6w3wrERpYYd4M0wrkUEMyzQrIU+KBfhf2wyv0cnYLna7m1CTIwnMvzR
         9+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696943449; x=1697548249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jms1ujwJI1idg8bEU/bR57E7ZINisVAtSz1uRROW3vM=;
        b=QGO09BACMI21aBX16FclAJ5X02GmQXqmRJOwppAQfBbs3CT1V1VVjY0IDKQUVufE9M
         zM4YkrfKdg5m11kT/Y/lrKdg6MDXlxV7MNvn1cZGWUeWA4eCE8TjAolhpijFY3mmC76w
         BMOSL0Jyp4V6K6/F6r+QFD2QtoameKxj4vO8Cz9KSnsXe4GSEE9uz9p/g+gVjQ82HTe2
         OA2tHJLaU5BVSxIOWuEZCGfUw9MbNk0cqXzstdVXWTPwJWvEwgzggU5t5aAco9OvcWKH
         mEa8WMgrYwJCmtgrRTcjXl09j72vjTDXl/042pFBB/Ifijr6FK90KwPdtOi9SnWq6Spj
         M0sQ==
X-Gm-Message-State: AOJu0YzW92wsz15RgJO9NK7vwYFne7//slB+CDrpR/U0eDGCzNBRJNmq
        DOgv+poHNLoVXiZm7PaElumcDMiXtVrNXLztuoO4/JzyZ24=
X-Google-Smtp-Source: AGHT+IFLqu0IqXrBR6lQHGq2TiA5N5N2syJweqMa/sIE/Dp8x1INKuggrmUc1Bv7DalwhQeYmayZh/F0ZbHyXWrBQ9E=
X-Received: by 2002:a0c:df88:0:b0:651:65f4:31fa with SMTP id
 w8-20020a0cdf88000000b0065165f431famr20854019qvl.39.1696943449441; Tue, 10
 Oct 2023 06:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
In-Reply-To: <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Oct 2023 16:10:38 +0300
Message-ID: <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
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

On Tue, Oct 10, 2023 at 2:59=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 9 Oct 2023 at 17:37, Amir Goldstein <amir73il@gmail.com> wrote:
>
> >  static inline void put_file_access(struct file *file)
> > diff --git a/fs/open.c b/fs/open.c
> > index fe63e236da22..02dc608d40d8 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -881,7 +881,7 @@ static inline int file_get_write_access(struct file=
 *f)
> >         if (unlikely(error))
> >                 goto cleanup_inode;
> >         if (unlikely(f->f_mode & FMODE_BACKING)) {
> > -               error =3D mnt_get_write_access(backing_file_real_path(f=
)->mnt);
> > +               error =3D mnt_get_write_access(backing_file_user_path(f=
)->mnt);
> >                 if (unlikely(error))
> >                         goto cleanup_mnt;
> >         }
>
> Do we really need write access on the overlay mount?
>

I'd rather this vfs code be generic and not assume things about
ovl private mount.
These assumptions may not hold for fuse passthough backing files.

That said, if we have an open(O_RDWR),mmap(PROT_WRITE),close()
sequence on overlayfs, don't we need the write access on ovl_upper_mnt
in order to avoid upper sb from being remounted RO?

> If so, should the order of getting write access not be the other way
> round (overlay first, backing second)?
>

Why is the order important?
What am I missing?

Thanks,
Amir.
