Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D979B999
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjIKU4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244159AbjIKTUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:20:52 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE71B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 12:20:46 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-573921661a6so3003161eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694460046; x=1695064846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGPsvpQjUEMIdQOzFdJ9vJo67U/s7GQIjWlcPJNV6YA=;
        b=fv8roNBXPi5mgYvP5vTbiP18A6RTDl7g58gwlasVDyy4GUpwipGyRjIZfuW+WdUiXa
         Xjyn+ZnTmGxJIztp5qRo18n1IWDnXy58kFRO8Z+j5HqRHVeB4Ezy/phcFGDZDERJW2dm
         FlFs9H0YsfhuX2DPlOvS+ALEdY5rWz+0xTZetqHa9rLTynx0/Oe69+GAXPpE2M2pgSdF
         eQmtjlslg506OnwPy3LLFzacIUJRpQ4nE5uIPogvq5k7Ev5X4/5gotgIlIcFYqU3Jwi/
         tvy0At/XRK7JU6RqqrEv2/T5NSUBsr0d3JXUyIq8XkPTWimiD3PReapds1YeUjsJnSwy
         kqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460046; x=1695064846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGPsvpQjUEMIdQOzFdJ9vJo67U/s7GQIjWlcPJNV6YA=;
        b=W3kDgWrfuoziMLzIQdWiHJg7KnDAvZM5lEjqBKR3VP2tnM7YhCp+JZgnffmkIKEA5a
         FKdg+NN4d917bdytYuyHl7Bo455Xr6iUYwstWvbKo3k44E2gShSYR8j2YXl2o0J2Pryq
         NwyhYFgd5Rg3qzEuuAGmKlcUsDOWd74xI9tt8Ua1Ilbvebx0YFXCn4loWYzfdSCjAkIV
         Yc5X/wjveM2dnFTFbKXYCnlvoH40R+R83a36gM98yBlXos3pFYTihVa7uiVu8U4ZY8pY
         awvEgH/3fkSGC92575yQPi37zmtkfyh+91SEemJyq1NURK5xHs4/eVJIWb086A/Eg4aR
         QbdQ==
X-Gm-Message-State: AOJu0YxV4BnGkN/fDBRL1B1yXffrLC8j/Bz7ygJDQXCV+6+HW61hDer5
        W8syKLsavKtlaMtJZOrl2PTPSC7Op8KhNGc9Wj08
X-Google-Smtp-Source: AGHT+IH96yo1MzMdmWLefgxTsJbhc0nUrndVLDy3So17nfp7l4Zrw4DTX0vQ9IskY0ltFBWcnOEUGmtAq7DSUwfe5og=
X-Received: by 2002:a05:6870:2150:b0:1b7:3fd5:87cd with SMTP id
 g16-20020a056870215000b001b73fd587cdmr12282617oae.48.1694460046149; Mon, 11
 Sep 2023 12:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <20230815-feigling-kopfsache-56c2d31275bd@brauner> <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
 <CAJqdLrpx4v4To=XSK0gyM4Ks2+c=Jrni2ttw4ZViKv-jK=tJKQ@mail.gmail.com> <20230904-harfe-haargenau-4c6cb31c304a@brauner>
In-Reply-To: <20230904-harfe-haargenau-4c6cb31c304a@brauner>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Sep 2023 15:20:35 -0400
Message-ID: <CAHC9VhRJ8iw7EXDqLdWEaj+EZSwHS0ytSWy+W-BoKVvw0EWA5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
To:     Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gyroidos@aisec.fraunhofer.de, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 4, 2023 at 7:44=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> On Tue, Aug 29, 2023 at 03:35:46PM +0200, Alexander Mikhalitsyn wrote:
> > On Fri, Aug 18, 2023 at 12:11=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Aug 15, 2023 at 10:59:22AM +0200, Christian Brauner wrote:
> > > > On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Wei=C3=9F wrote:
> > > > > Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
> > > > > which allows to set a cgroup device program to be a device guard.
> > > >
> > > > Currently we block access to devices unconditionally in may_open_de=
v().
> > > > Anything that's mounted by an unprivileged containers will get
> > > > SB_I_NODEV set in s_i_flags.
> > > >
> > > > Then we currently mediate device access in:
> > > >
> > > > * inode_permission()
> > > >   -> devcgroup_inode_permission()
> > > > * vfs_mknod()
> > > >   -> devcgroup_inode_mknod()
> > > > * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block=
 devices and friends
> > > >   -> devcgroup_check_permission()
> > > > * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu i=
nfo afaict
> > > >   -> devcgroup_check_permission()
> > > >
> > > > All your new flag does is to bypass that SB_I_NODEV check afaict an=
d let
> > > > it proceed to the devcgroup_*() checks for the vfs layer.
> > > >
> > > > But I don't get the semantics yet.
> > > > Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs=
 or
> > > > is that a flag on random bpf programs? It looks like it would be th=
e
> > > > latter but design-wise I would expect this to be a property of the
> > > > device program itself.
> > >
> > > Looks like patch 4 attemps to bypass usual permission checks with:
> > > @@ -3976,9 +3979,19 @@ int vfs_mknod(struct mnt_idmap *idmap, struct =
inode *dir,
> > >         if (error)
> > >                 return error;
> > >
> > > -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
> > > -           !capable(CAP_MKNOD))
> > > -               return -EPERM;
> > > +       /*
> > > +        * In case of a device cgroup restirction allow mknod in user
> > > +        * namespace. Otherwise just check global capability; thus,
> > > +        * mknod is also disabled for user namespace other than the
> > > +        * initial one.
> > > +        */
> > > +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout) {
> > > +               if (devcgroup_task_is_guarded(current)) {
> > > +                       if (!ns_capable(current_user_ns(), CAP_MKNOD)=
)
> > > +                               return -EPERM;
> > > +               } else if (!capable(CAP_MKNOD))
> > > +                       return -EPERM;
> > > +       }
> > >
> >
> > Dear colleagues,
> >
> > > which pretty much sounds like authoritative LSM that was brought up i=
n the past
> > > and LSM folks didn't like it.
> >
> > Thanks for pointing this out, Alexei!
> > I've searched through the LKML archives and found a thread about this:
> > https://lore.kernel.org/all/CAEf4BzaBt0W3sWh_L4RRXEFYdBotzVEnQdqC7BO+PN=
WtD7eSUA@mail.gmail.com/
> >
> > As far as I understand, disagreement here is about a practice of
> > skipping kernel-built capability checks based
> > on LSM hooks, right?
> >
> > +CC Paul Moore <paul@paul-moore.com>
> >
> > >
> > > If vfs folks are ok with this special bypass of permissions in vfs_mk=
nod()
> > > we can talk about kernel->bpf api details.
> > > The way it's done with BPF_F_CGROUP_DEVICE_GUARD flag is definitely n=
o go,
> > > but no point going into bpf details now until agreement on bypass is =
made.
>
> Afaiu the original concern was specifically about an LSM allowing to
> bypass other LSMs or DAC permissions. But this wouldn't be the case
> here. The general inode access LSM permission mediation is separate from
> specific device access management: the security_inode_permission() LSM
> hook would still be called and thus LSMs restrictions would continue to
> apply exactly as they do now.
>
> For cgroup v1 device access management was a cgroup controller with
> management interface through files. It then was ported to an eBPF
> program attachable to cgroups for cgroup v2. Arguably, it should
> probably have been ported to an LSM hook or a separate LSM and untied
> from cgroups completely. The confusion here seems to indicate that that
> would have been the right way to go.
>
> Because right now device access management seems its own form of
> mandatory access control.

My apologies, I lost this thread in my inbox and I'm just reading it now.

Historically we haven't any real LSM controls around
cgroups/resource-management, but that is mostly because everything
that I recall being proposed has been very piecemeal and didn't
provide a comprehensive access control solution for resource
management.  If someone wanted to propose a proper set of access
control hooks for cgroups I think that is something we would be happy
to review, merge, etc.

Somewhat relatedly, we've been working on some docs around guidelines
for new LSM hooks; eventually the guidelines will work their way into
the kernel docs, but here they are now:

* https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm=
-hook-guidelines

--=20
paul-moore.com
