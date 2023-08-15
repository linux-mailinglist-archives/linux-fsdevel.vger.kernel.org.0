Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6431F77CD84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbjHONre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 09:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbjHONrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:47:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0038819A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 06:47:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf91956cdso669483266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1692107230; x=1692712030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Unr4+ItpuKlIirZHj4iGptdbf8I+3LbFXo97iblwKyc=;
        b=f/PlbdLGdiLehPhw+jZl2CbgQDrf6h5t/XaFt6inhQRlxmRrN91HH20sXysigGUmhp
         svbvv0oqkBkUxXBFLN+QOEjDFxLKvAifHqrp0oeHf5G+0EHd+0JSZVUw/+EjyyNrwLF1
         /nwLD5xOysI0ILlsEYx43G0m6vuiUbqFKwOxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692107230; x=1692712030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Unr4+ItpuKlIirZHj4iGptdbf8I+3LbFXo97iblwKyc=;
        b=S+IxfGsqwtGneTK9QTBI8yOvQOyD/Kw+6jVGGWlQWV+otDXF2kqk7W205dWh6r3Of9
         4tjSHPzvSMPMRTuAin6UzTnbJsBr7uH8FLLiiK+TQJKG5rS0DiIMRf7k5sVexvJXhF5m
         Zto0a5s6fhSrfX4//KTp1SrIr1I63OY8vCJS1H9pj2Oq4IGsm7H7jZx4cdzI1KyqNJHw
         Jv9lSSU0Tn/fLLyJv1MfcDOc+AW4QyHgtOcIzZN+HV5Gof/MfGC/8oq9RhHdqFIXVj2A
         AK9oQvd7sUVtkBWaKCRkPhsI8+QNd1yIU55/JFQ2vCKVEhM0NuC4NSYN8vwJQjxYmjZJ
         dRjw==
X-Gm-Message-State: AOJu0YyOQDfuJZYoDfOGKC1wxhdUho1lh312V5bGGJoKQ99HyfWeh9v1
        FiAId/FzhrjsAATTZNlfMglSvnuIksTQ6FTf+bbIjg==
X-Google-Smtp-Source: AGHT+IGRk21b4lG7OdoQ5rBY2/KCbr8XWNydutcW06BmIydNi/uI/V0ofbVuNwwoMY0V2mg3J3CmxT+LYRYMOVcrEd4=
X-Received: by 2002:a17:907:2e19:b0:993:e9b8:90f5 with SMTP id
 ig25-20020a1709072e1900b00993e9b890f5mr9788154ejc.8.1692107230114; Tue, 15
 Aug 2023 06:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230810090044.1252084-1-sargun@sargun.me> <20230810090044.1252084-2-sargun@sargun.me>
 <20230815-ableisten-offiziell-9b4de6357f7c@brauner>
In-Reply-To: <20230815-ableisten-offiziell-9b4de6357f7c@brauner>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Tue, 15 Aug 2023 06:46:33 -0700
Message-ID: <CAMp4zn_RM+X8PBkAxXSuXrxbLTb2ndzVNXt10eaWj4uyWna30w@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs: Allow user to lock mount attributes with mount_setattr
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023 at 2:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Aug 10, 2023 at 02:00:43AM -0700, Sargun Dhillon wrote:
> > We support locking certain mount attributes in the kernel. This API
> > isn't directly exposed to users. Right now, users can lock mount
> > attributes by going through the process of creating a new user
> > namespaces, and when the mounts are copied to the "lower privilege"
> > domain, they're locked. The mount can be reopened, and passed around
> > as a "locked mount".
>
> Not sure if that's what you're getting at but you can actually fully
> create these locked mounts already:
>
> P1                                                 P2
> # init userns + init mountns                       # init userns + init m=
ountns
> sudo mount --bind /foo /bar
> sudo mount --bind -o ro,nosuid,nodev,noexec /bar
>
> # unprivileged userns + unprivileged mountns
> unshare --mount --user --map-root
>
> mount --bind -oremount
>
> fd =3D open_tree(/bar, OPEN_TREE_CLONE)
>
> send(fd_send, P2);
>
>                                                    recv(&fd_recv, P1)
>
>                                                    move_mount(fd_recv, /l=
ocked-mnt);
>
> and now you have a fully locked mount on the host for P2. Did you mean th=
at?
>

Yep. Doing this within a program without clone / fork is awkward. Forking a=
nd
unsharing in random C++ programs doesn't always go super well, so in my
mind it'd be nice to have an API to do this directly.

In addition, having the superblock continue to be owned by the userns that
its mounted in is nice because then they can toggle the other mount attribu=
tes
(nodev, nosuid, noexec are the ones we care about).

> >
> > Locked mounts are useful, for example, in container execution without
> > user namespaces, where you may want to expose some host data as read
> > only without allowing the container to remount the mount as mutable.
> >
> > The API currently requires that the given privilege is taken away
> > while or before locking the flag in the less privileged position.
> > This could be relaxed in the future, where the user is allowed to
> > remount the mount as read only, but once they do, they cannot make
> > it read only again.
>
> s/read only/read write/
>
> >
> > Right now, this allows for all flags that are lockable via the
> > userns unshare trick to be locked, other than the atime related
> > ones. This is because the semantics of what the "less privileged"
> > position is around the atime flags is unclear.
>
> I think that atime stuff doesn't really make sense to expose to
> userspace. That seems a bit pointless imho.
>
> >
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > ---
> >  fs/namespace.c             | 40 +++++++++++++++++++++++++++++++++++---
> >  include/uapi/linux/mount.h |  2 ++
> >  2 files changed, 39 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 54847db5b819..5396e544ac84 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -78,6 +78,7 @@ static LIST_HEAD(ex_mountpoints); /* protected by nam=
espace_sem */
> >  struct mount_kattr {
> >       unsigned int attr_set;
> >       unsigned int attr_clr;
> > +     unsigned int attr_lock;
>
> So when I originally noted down this crazy idea
> https://github.com/uapi-group/kernel-features
> I didn't envision a new struct member but rather a flag that could be
> raised in attr_set like MOUNT_ATTR_LOCK that would indicate for the
> other flags in attr_set to become locked.
>
> So if we could avoid growing the struct pointlessly I'd prefer that. Is
> there a reason that wouldn't work?
No reason. The semantics were just a little more awkward, IMHO.
Specifically:
* This attr could never be cleared, only set, which didn't seem to follow
the attr_set / attr_clr semantics
* If we ever introduced a mount_getattr call, you'd want to expose
each of the locked bits independently, I'd think, and exposing
that through one flag wouldn't give you the same fidelity.

>
> I have no strong feelings about this tbh. It seems useful overall to
> have this ability. But it deviates a bit from regular mount semantics in
> that you can lock mount properties for the lifetime of the mount
> explicitly.
