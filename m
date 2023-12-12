Return-Path: <linux-fsdevel+bounces-5601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4B80E041
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE60428278C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F8647;
	Tue, 12 Dec 2023 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpWetFEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD348A2;
	Mon, 11 Dec 2023 16:26:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce94f62806so2865700b3a.1;
        Mon, 11 Dec 2023 16:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702340816; x=1702945616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSQyFr2oOPN4eJKATcaaKNeRdXLlB+uMHIeYmedc82w=;
        b=RpWetFEPDqRP6m14yFSAA1TnG6sajGueoR/JZWYzKGLv0CeT7h6GDuRin35dKUphu4
         Ci4SblY7YDf8Mx4g01au8rIv2Hg8rtx2PpplxYDPnEqkaUCkB0SzoZv/Cvly5RUJ3hsc
         1NUom1grgtc0GJT3eVP4ooKpJjjLTFRAjTsy75ZxWiP6CDQ1VvORIofMByXUK/5F3YDV
         5qZ9FjyH/MyAsmMoxKOj7wQKqU9icuDoMESrJukqz+hDw5YP7mnY34StHesGOJXm34Fc
         22N7rvbXtbmHLdUojczz1c6o5Py1bAL0vRfzIwi87oKFdZF+Pt/+L7SNMCkeaIfolrU9
         aSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702340816; x=1702945616;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jSQyFr2oOPN4eJKATcaaKNeRdXLlB+uMHIeYmedc82w=;
        b=FXtlLKISfxN+3BJsknA02cYi+hr1+zpQDfiilml8PX4wHxXfSR88daQaH16bLpZr+v
         nUdmuuKT8eU5AHWkx6Ss0dcaQWx4Ed76+T9aR4G7DDURCEI/aFLTxZzkY45uzUIgmBqw
         R+rbnNaVwd5HkDTkavrk0GJqqfsCgscg30c/XLOvzMe8ggjM8JT3Rv1gWM56Y7oSW63P
         oJY05/LMzzc33wmPWxzp2fDSlp6C+2DAaMxDFmE0fwKM3vQgRjb/WpOwNemvZPrhT92B
         lW09fJ3NvaStY51pJfR8yM3HYb6Esz3z9KpCMiILBQq1lQCkwfn/c/+ZW6/yMhugkCJW
         DeYw==
X-Gm-Message-State: AOJu0YxUAytdHNzI6O2Xz8Kdh/yTyr2zjo+dhGe7TPIhRqzZ/NEBDGKl
	JMbYWoAMFRwBQjKYdJtjlGw=
X-Google-Smtp-Source: AGHT+IE9bubbYpMbmSeuNhsCa9D4nLlifwvJI5f8ivdhlvLDMDlxjL6HtD236PupYxryjevy5xZzVA==
X-Received: by 2002:a05:6a20:918d:b0:190:46c8:a3dc with SMTP id v13-20020a056a20918d00b0019046c8a3dcmr2647560pzd.5.1702340816197;
        Mon, 11 Dec 2023 16:26:56 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001cc2ebd2c2csm7285851pls.256.2023.12.11.16.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:26:55 -0800 (PST)
Date: Mon, 11 Dec 2023 16:26:54 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 paul@paul-moore.com, 
 brauner@kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 keescook@chromium.org, 
 kernel-team@meta.com, 
 sargun@sargun.me
Message-ID: <6577a8ce777d9_1449c20858@john.notmuch>
In-Reply-To: <CAEf4BzYZ0Xkme8pwWoXE5wvQhp+DzUixn3ueJMFmDqUk9Dox7A@mail.gmail.com>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-7-andrii@kernel.org>
 <657793942699a_edaa208bc@john.notmuch>
 <CAEf4BzYZ0Xkme8pwWoXE5wvQhp+DzUixn3ueJMFmDqUk9Dox7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/8] libbpf: wire up BPF token support at BPF
 object level
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko wrote:
> On Mon, Dec 11, 2023 at 2:56=E2=80=AFPM John Fastabend <john.fastabend@=
gmail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > Add BPF token support to BPF object-level functionality.
> > >
> > > BPF token is supported by BPF object logic either as an explicitly
> > > provided BPF token from outside (through BPF FS path or explicit BP=
F
> > > token FD), or implicitly (unless prevented through
> > > bpf_object_open_opts).
> > >
> > > Implicit mode is assumed to be the most common one for user namespa=
ced
> > > unprivileged workloads. The assumption is that privileged container=

> > > manager sets up default BPF FS mount point at /sys/fs/bpf with BPF =
token
> > > delegation options (delegate_{cmds,maps,progs,attachs} mount option=
s).
> > > BPF object during loading will attempt to create BPF token from
> > > /sys/fs/bpf location, and pass it for all relevant operations
> > > (currently, map creation, BTF load, and program load).
> > >
> > > In this implicit mode, if BPF token creation fails due to whatever
> > > reason (BPF FS is not mounted, or kernel doesn't support BPF token,=

> > > etc), this is not considered an error. BPF object loading sequence =
will
> > > proceed with no BPF token.
> > >
> > > In explicit BPF token mode, user provides explicitly either custom =
BPF
> > > FS mount point path or creates BPF token on their own and just pass=
es
> > > token FD directly. In such case, BPF object will either dup() token=
 FD
> > > (to not require caller to hold onto it for entire duration of BPF o=
bject
> > > lifetime) or will attempt to create BPF token from provided BPF FS
> > > location. If BPF token creation fails, that is considered a critica=
l
> > > error and BPF object load fails with an error.
> > >
> > > Libbpf provides a way to disable implicit BPF token creation, if it=

> > > causes any troubles (BPF token is designed to be completely optiona=
l and
> > > shouldn't cause any problems even if provided, but in the world of =
BPF
> > > LSM, custom security logic can be installed that might change outco=
me
> > > dependin on the presence of BPF token). To disable libbpf's default=
 BPF
> > > token creation behavior user should provide either invalid BPF toke=
n FD
> > > (negative), or empty bpf_token_path option.
> > >
> > > BPF token presence can influence libbpf's feature probing, so if BP=
F
> > > object has associated BPF token, feature probing is instructed to u=
se
> > > BPF object-specific feature detection cache and token FD.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/lib/bpf/btf.c             |   7 +-
> > >  tools/lib/bpf/libbpf.c          | 120 ++++++++++++++++++++++++++++=
++--
> > >  tools/lib/bpf/libbpf.h          |  28 +++++++-
> > >  tools/lib/bpf/libbpf_internal.h |  17 ++++-
> > >  4 files changed, 160 insertions(+), 12 deletions(-)
> > >
> >
> > ...
> >
> > >
> > > +static int bpf_object_prepare_token(struct bpf_object *obj)
> > > +{
> > > +     const char *bpffs_path;
> > > +     int bpffs_fd =3D -1, token_fd, err;
> > > +     bool mandatory;
> > > +     enum libbpf_print_level level =3D LIBBPF_DEBUG;
> >
> > redundant set on level?
> >
> =

> yep, removed initialization
> =

> > > +
> > > +     /* token is already set up */
> > > +     if (obj->token_fd > 0)
> > > +             return 0;
> > > +     /* token is explicitly prevented */
> > > +     if (obj->token_fd < 0) {
> > > +             pr_debug("object '%s': token is prevented, skipping..=
.\n", obj->name);
> > > +             /* reset to zero to avoid extra checks during map_cre=
ate and prog_load steps */
> > > +             obj->token_fd =3D 0;
> > > +             return 0;
> > > +     }
> > > +
> > > +     mandatory =3D obj->token_path !=3D NULL;
> > > +     level =3D mandatory ? LIBBPF_WARN : LIBBPF_DEBUG;
> > > +
> > > +     bpffs_path =3D obj->token_path ?: BPF_FS_DEFAULT_PATH;
> > > +     bpffs_fd =3D open(bpffs_path, O_DIRECTORY, O_RDWR);
> > > +     if (bpffs_fd < 0) {
> > > +             err =3D -errno;
> > > +             __pr(level, "object '%s': failed (%d) to open BPF FS =
mount at '%s'%s\n",
> > > +                  obj->name, err, bpffs_path,
> > > +                  mandatory ? "" : ", skipping optional step...");=

> > > +             return mandatory ? err : 0;
> > > +     }
> > > +
> > > +     token_fd =3D bpf_token_create(bpffs_fd, 0);
> >
> > Did this get tested on older kernels? In that case TOKEN_CREATE will
> > fail with -EINVAL.
> =

> yep, I did actually test, it will generate expected *debug*-level
> "failed to create BPF token" message

Great.

> =

> >
> > > +     close(bpffs_fd);
> > > +     if (token_fd < 0) {
> > > +             if (!mandatory && token_fd =3D=3D -ENOENT) {
> > > +                     pr_debug("object '%s': BPF FS at '%s' doesn't=
 have BPF token delegation set up, skipping...\n",
> > > +                              obj->name, bpffs_path);
> > > +                     return 0;
> > > +             }
> >
> > Isn't there a case here we should give a warning about?  If BPF_TOKEN=
_CREATE
> > exists and !mandatory, but default BPFFS failed for enomem, or eperm =
reasons?
> > If the user reall/y doesn't want tokens here they should maybe overri=
de with
> > -1 token? My thought is if you have delegations set up then something=
 on the
> > system is trying to configure this and an error might be ok? I'm aski=
ng just
> > because I paused on it for a bit not sure either way at the moment. I=
 might
> > imagine a lazy program not specifying the default bpffs, but also rea=
lly
> > thinking its going to get a valid token.
> =

> Interesting perspective! I actually came from the direction that BPF
> token is not really all that common and expected thing, and so in
> majority of cases (at least for some time) we won't be expecting to
> have BPF FS with delegation options. So emitting a warning that
> "something something BPF token failed" would be disconcerting to most
> users.
> =

> What's the worst that would happen if BPF token was expected but we
> failed to instantiate it? You'll get a BPF object load failure with
> -EPERM, so it will be a pretty clear signal that whatever delegation
> was supposed to happen didn't happen.
> =

> Also, if a user wants a BPF token for sure, they can explicitly set
> bpf_token_path =3D "/sys/fs/bpf" and then it becomes mandatory.
> =

> So tl;dr, my perspective is that most users won't know or care about
> BPF tokens. If sysadmin set up BPF FS correctly, it should just work
> without the BPF application being aware. But for those rare cases
> where a BPF token is expected and necessary, explicit bpf_token_path
> or bpf_token_fd is the way to fail early, if something is not set up
> the way it is expected.

Works for me. I don't have a strong opinion either way.=

