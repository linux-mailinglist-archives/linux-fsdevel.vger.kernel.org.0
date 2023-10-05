Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538D77B9EB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjJEOLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjJEOJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:09:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887DD2100
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 21:02:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad8a822508so101518166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696478526; x=1697083326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKeghe/h+8V01N3C5F/CD+J6nuH9c3jaxycLuVcqFqY=;
        b=czzNcLA+d+be0YPPWCPcNRUQoH1t4/dkWhRiG9G2yNOnf29Kl9fM5DQ2C9x87AFSTa
         0LTFH4kmOAto8XZpPNnnHygxbhNwcaEXXewyJ7ZGx9eRsEizdjIYoYqPX4daYrM56kmO
         qK05bYILCCpxLlHkHgqIjFT84HCTO30ZkV5OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696478526; x=1697083326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKeghe/h+8V01N3C5F/CD+J6nuH9c3jaxycLuVcqFqY=;
        b=LCdNlu29hpBNSoui2ptSKTAGjU79myuySlJP5GLJcJZy0m0LlZwefcfO4EfxJiFdWZ
         220Uwd4GB4uGFjnHUzQzKn8X7fxJcAQK9QqjpRrlI8S+v3CVBQpfNukCRKkwaEEgExyR
         8/Du66kacBND1YnJIjOfO9vyNZp5KfmyZ7MD6Cepxwcw8C4nhya1a/9D+TdxJGpa8wtd
         ysSsxjuLBoVbeitoDVJOD+3n0mMd06nCM2Chd3gaXXWciQsYtIlVashP2D2c4guIlXoa
         QU5C09ryTWXdhTirZOHRd87KypnyAL877nVKiNzWNbygKYS6JZZeoutkl+zNwwEH3Sio
         ZVhw==
X-Gm-Message-State: AOJu0YyteGAKBFDVvEyAMQe4IxmvD2JB68dPz9K0vUQgkoF/iJ2KuUhX
        LPHhW6a7w5zhvUFbC0cuNTCoz4d6aSh3AsGHfsyVjg==
X-Google-Smtp-Source: AGHT+IFnG1g9sQjyctXSbGWbEKu4RwQsoZ0vWyIrU9Kgouq51lY/wQ2CPqAb/STCI8uDOSFPVONtcHqKEGrGTo4XbAc=
X-Received: by 2002:a17:906:ce:b0:9a6:426f:7dfd with SMTP id
 14-20020a17090600ce00b009a6426f7dfdmr3358227eji.66.1696478525910; Wed, 04 Oct
 2023 21:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
In-Reply-To: <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 5 Oct 2023 06:01:53 +0200
Message-ID: <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Paul Moore <paul@paul-moore.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 4 Oct 2023 at 21:38, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Sep 28, 2023 at 9:04=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.c=
om> wrote:
> >
> > Add way to query the children of a particular mount.  This is a more
> > flexible way to iterate the mount tree than having to parse the complet=
e
> > /proc/self/mountinfo.
> >
> > Lookup the mount by the new 64bit mount ID.  If a mount needs to be que=
ried
> > based on path, then statx(2) can be used to first query the mount ID
> > belonging to the path.
> >
> > Return an array of new (64bit) mount ID's.  Without privileges only mou=
nts
> > are listed which are reachable from the task's root.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  arch/x86/entry/syscalls/syscall_32.tbl |  1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
> >  fs/namespace.c                         | 69 ++++++++++++++++++++++++++
> >  include/linux/syscalls.h               |  3 ++
> >  include/uapi/asm-generic/unistd.h      |  5 +-
> >  include/uapi/linux/mount.h             |  3 ++
> >  6 files changed, 81 insertions(+), 1 deletion(-)
>
> ...
>
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 3326ba2b2810..050e2d2af110 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -4970,6 +4970,75 @@ SYSCALL_DEFINE4(statmount, const struct __mount_=
arg __user *, req,
> >         return ret;
> >  }
> >
> > +static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t=
 bufsize,
> > +                        const struct path *root, unsigned int flags)
> > +{
> > +       struct mount *r, *m =3D real_mount(mnt);
> > +       struct path rootmnt =3D {
> > +               .mnt =3D root->mnt,
> > +               .dentry =3D root->mnt->mnt_root
> > +       };
> > +       long ctr =3D 0;
> > +       bool reachable_only =3D true;
> > +       int err;
> > +
> > +       err =3D security_sb_statfs(mnt->mnt_root);
> > +       if (err)
> > +               return err;
> > +
> > +       if (flags & LISTMOUNT_UNREACHABLE) {
> > +               if (!capable(CAP_SYS_ADMIN))
> > +                       return -EPERM;
> > +               reachable_only =3D false;
> > +       }
> > +
> > +       if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &roo=
tmnt))
> > +               return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
> > +
> > +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
> > +               if (reachable_only &&
> > +                   !is_path_reachable(r, r->mnt.mnt_root, root))
> > +                       continue;
>
> I believe we would want to move the security_sb_statfs() call from
> above to down here; something like this I think ...
>
>   err =3D security_sb_statfs(r->mnt.mnt_root);
>   if (err)
>     /* if we can't access the mount, pretend it doesn't exist */
>     continue;

Hmm.  Why is this specific to listing mounts (i.e. why doesn't readdir
have a similar filter)?

Also why hasn't this come up with regards to the proc interfaces that
list mounts?

I just want to understand the big picture here.

Thanks,
Miklos
