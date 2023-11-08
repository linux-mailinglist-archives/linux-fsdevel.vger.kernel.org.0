Return-Path: <linux-fsdevel+bounces-2444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED07E5FAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 22:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E393A1C20C0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EA374F2;
	Wed,  8 Nov 2023 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji+sddoG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228B374C8;
	Wed,  8 Nov 2023 21:09:49 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA12581;
	Wed,  8 Nov 2023 13:09:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso30942266b.1;
        Wed, 08 Nov 2023 13:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699477787; x=1700082587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KazIzduS9BidB+bNmstAcrQgF6siENXwi+iuOkkoB0A=;
        b=ji+sddoGPucfnsMYY5Ui15x9+OiqhSiP9hmgCMWPq+9HfVGseChXyXm3XJG+UAqVwI
         xpJu3E2MaKcv06nmgZ3TJ4yQ/Xixy5r5e9iQL4GGB+n/9ydyn5yNH6JS/LCyxcbHesnb
         V/lTd8PYKx4bjr1F9sWc5fvb4yUC45lufh4Y1NnrfLXdNUSQMtGV1CK5ITWmhhOIkQ9Y
         Bg582GU3NiRZVO2L9BaeomU0G4O5Dsr6ptWZgVW8QxgxljacI+a5VD9M5qBYvqEi9rDI
         JwpDKggQekKmf3A3WmhA8+gGHRGwVSllkUoa9o7o8NvHLtzBTJ70SX/X3heEzQb8EkYS
         VztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477787; x=1700082587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KazIzduS9BidB+bNmstAcrQgF6siENXwi+iuOkkoB0A=;
        b=snj7vR9N5F3InbuBNpxRQ8vZccP4U9k0yM1bn+cOVr5AhdxXmqbmfJNIVa4DsRzAik
         gS4/a5F6gjWW1cGxcyRtf2vWSzZjmtIsXR9hJsszssQbeL+RiSXeQU3Ztp7PWjoDyOwu
         qTnzVM4oyYN8egXUmldhYgYZaphzkiyrz9QpaBkItjdKDDMDdFO8n7xGdROmSK5m8InE
         Quws21YMov3p99N+d9ZVQXwuZupgjtRhIuljxpYj25xB6Y3ItidZoveaa38oJdFfyfrp
         ZfTcswRaPrbMzElz9y8z02OtMBY/T8VgDGxo7eRz0mWf1o0bDcIVkMuR277zsPfZ87vu
         0CRA==
X-Gm-Message-State: AOJu0YzOOwxxCyP4x6F2gwDAnEoF4XfR41hm7qbJlKFwxPoEIvzaslZd
	IYGVmttTBzT6AQb9q2mTwKQuIeEEh3AP71UA4js=
X-Google-Smtp-Source: AGHT+IGW85Rh+rAMkRglZRCOSxXfOd+5RIr+08ebXPpTcAJNErxjXHV3uER6A0yMTCKj2M+ow15o2uJ/GAScSrKP5MU=
X-Received: by 2002:a17:907:a03:b0:9bd:a738:2bfe with SMTP id
 bb3-20020a1709070a0300b009bda7382bfemr2337139ejc.38.1699477786877; Wed, 08
 Nov 2023 13:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103190523.6353-1-andrii@kernel.org> <20231103190523.6353-4-andrii@kernel.org>
 <20231108-verbuchen-unteilbar-9005061e2b48@brauner>
In-Reply-To: <20231108-verbuchen-unteilbar-9005061e2b48@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 Nov 2023 13:09:35 -0800
Message-ID: <CAEf4BzZVNj=hR_TBOU5YsBM3iurqi9igSO=JZXkgXZReXfdACQ@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 03/17] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 6:28=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Nov 03, 2023 at 12:05:09PM -0700, Andrii Nakryiko wrote:
> > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > allow delegating privileged BPF functionality, like loading a BPF
> > program or creating a BPF map, from privileged process to a *trusted*
> > unprivileged process, all while have a good amount of control over whic=
h
> > privileged operations could be performed using provided BPF token.
> >
> > This is achieved through mounting BPF FS instance with extra delegation
> > mount options, which determine what operations are delegatable, and als=
o
> > constraining it to the owning user namespace (as mentioned in the
> > previous patch).
> >
> > BPF token itself is just a derivative from BPF FS and can be created
> > through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts
> > a path specification (using the usual fd + string path combo) to a BPF
> > FS mount. Currently, BPF token "inherits" delegated command, map types,
> > prog type, and attach type bit sets from BPF FS as is. In the future,
> > having an BPF token as a separate object with its own FD, we can allow
> > to further restrict BPF token's allowable set of things either at the c=
reation
> > time or after the fact, allowing the process to guard itself further
> > from, e.g., unintentionally trying to load undesired kind of BPF
> > programs. But for now we keep things simple and just copy bit sets as i=
s.
> >
> > When BPF token is created from BPF FS mount, we take reference to the
> > BPF super block's owning user namespace, and then use that namespace fo=
r
> > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> > capabilities that are normally only checked against init userns (using
> > capable()), but now we check them using ns_capable() instead (if BPF
> > token is provided). See bpf_token_capable() for details.
> >
> > Such setup means that BPF token in itself is not sufficient to grant BP=
F
> > functionality. User namespaced process has to *also* have necessary
> > combination of capabilities inside that user namespace. So while
> > previously CAP_BPF was useless when granted within user namespace, now
> > it gains a meaning and allows container managers and sys admins to have
> > a flexible control over which processes can and need to use BPF
> > functionality within the user namespace (i.e., container in practice).
> > And BPF FS delegation mount options and derived BPF tokens serve as
> > a per-container "flag" to grant overall ability to use bpf() (plus furt=
her
> > restrict on which parts of bpf() syscalls are treated as namespaced).
> >
> > Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
> > within the BPF FS owning user namespace, rounding up the ns_capable()
> > story of BPF token.
> >
> > The alternative to creating BPF token object was:
> >   a) not having any extra object and just pasing BPF FS path to each
> >      relevant bpf() command. This seems suboptimal as it's racy (mount
> >      under the same path might change in between checking it and using =
it
> >      for bpf() command). And also less flexible if we'd like to further
>
> I don't understand "mount under the same path might change in between
> checking it and using it for bpf() command".
>
> Just require userspace to open() the bpffs instance and pass that fd to
> bpf() just as you're doing right now. If that is racy then the current
> implementation is even more so because it is passing:
>
> bpffs_path_fd
> bpffs_pathname
>
> and then performs a lookup. More on that below.

Yes, this is a result of my initial confusion with how O_PATH-based
open() works. You are right that it's not racy, I'll update the
message.

>
> I want to point out that most of this code here is unnecessary if you
> use the bpffs fd itself as a token. But that's your decision. I'm just
> saying that I'm not sure the critique that it's racy is valid.

Ack.

>
> >      restrict ourselves compared to all the delegated functionality
> >      allowed on BPF FS.
> >   b) use non-bpf() interface, e.g., ioctl(), but otherwise also create
> >      a dedicated FD that would represent a token-like functionality. Th=
is
> >      doesn't seem superior to having a proper bpf() command, so
> >      BPF_TOKEN_CREATE was chosen.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  41 +++++++
> >  include/uapi/linux/bpf.h       |  39 +++++++
> >  kernel/bpf/Makefile            |   2 +-
> >  kernel/bpf/inode.c             |  17 ++-
> >  kernel/bpf/syscall.c           |  17 +++
> >  kernel/bpf/token.c             | 197 +++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  39 +++++++
> >  7 files changed, 342 insertions(+), 10 deletions(-)
> >  create mode 100644 kernel/bpf/token.c
> >

[...]

> > +
> > +#define BPF_TOKEN_INODE_NAME "bpf-token"
> > +
> > +static const struct inode_operations bpf_token_iops =3D { };
> > +
> > +static const struct file_operations bpf_token_fops =3D {
> > +     .release        =3D bpf_token_release,
> > +     .show_fdinfo    =3D bpf_token_show_fdinfo,
> > +};
> > +
> > +int bpf_token_create(union bpf_attr *attr)
> > +{
> > +     struct bpf_mount_opts *mnt_opts;
> > +     struct bpf_token *token =3D NULL;
> > +     struct user_namespace *userns;
> > +     struct inode *inode;
> > +     struct file *file;
> > +     struct path path;
> > +     umode_t mode;
> > +     int err, fd;
> > +
> > +     err =3D user_path_at(attr->token_create.bpffs_path_fd,
> > +                        u64_to_user_ptr(attr->token_create.bpffs_pathn=
ame),
> > +                        LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);
>
> Do you really need bpffs_path_fd and bpffs_pathname?
> This seems unnecessar as you're forcing a lookup that's best done in
> userspace through regular open() apis. So I would just make this:
>
> struct { /* struct used by BPF_TOKEN_CREATE command */
>         __u32           flags;
>         __u32           bpffs_path_fd;
> } token_create;
>
> In bpf_token_create() you can then just do:
>
>         struct fd f;
>         struct path path;
>
>         f =3D fdget(attr->token_create.bpffs_path_fd);
>         if (!f.file)
>                 return -EBADF;
>
>         *path =3D f.file->f_path;
>         path_get(path);
>         fdput(f);
>

Yes, you are right. I'll simplify this part, thanks.


> > +     if (err)
> > +             return err;
> > +
> > +     if (path.mnt->mnt_root !=3D path.dentry) {
> > +             err =3D -EINVAL;
> > +             goto out_path;
> > +     }
> > +     if (path.mnt->mnt_sb->s_op !=3D &bpf_super_ops) {
> > +             err =3D -EINVAL;
> > +             goto out_path;
> > +     }

[...]

