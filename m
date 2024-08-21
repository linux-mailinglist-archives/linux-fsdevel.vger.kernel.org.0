Return-Path: <linux-fsdevel+bounces-26577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1195A880
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B92B21D66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F617DFE1;
	Wed, 21 Aug 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4UaTkZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951411779BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284136; cv=none; b=Ih6nZz+6pcTr+3OLJLktfhSeFNsMmWS0J2CBjEads2we331beDrJEzBtoFlF48GcBdATroFt80lLAuEHAPsHpYPN0pXxIQfq3L7OS10elWZ4NhR34GBBWogZRYZXWX4ZMWM4bxvIEfe+1Y2qpyh+PrQswZDsscVUxywqsqBUvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284136; c=relaxed/simple;
	bh=lW7ckBhu6iBq5dInfxH5nTkypN5Kael4yIgcWvTsE6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o76KAcPNQa4F9dup+ZC0e9DyKy8t8J+J75XflRML7pwom7HqHQIrmDKLGYzvG+ZBs36K+zxV5iZHAOvPrVQqcRUXyRQ8QDy28Zxcoat9inbg7yUHI+WJ5bPWOOSlWSpZA6+f5Y8bFhl5HuzeBvkugJuZd54a9j4sPCWsh2AfXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4UaTkZg; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4fce23b0e32so107385e0c.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724284133; x=1724888933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvBevw1bhQRbBrOnaYoAJ6EwtUVfWRiUsqO0hTMY8ek=;
        b=H4UaTkZgaCdKaKAnGy1tDsuwnwbC+f+rf1hsYAoXeq+zdwg5fd5G5za4Ky8U14SzNO
         CoMfkVXDmOi3hVJYRfB3yCN6ebwsK8Ln4IfJioASbDiYjK/J5vuOVAmWv9pCoB5hv/lH
         4P5PK8HwqVr5sOL/amDlMeykAOCQZXImyDZg3bry3DCw1V6OV5AlwWC+vzb7ee4aogfJ
         u+nRIIonI9bJ6JNbadc1YdvDRP0AAYVldaVf/JhkMWqewQncHaLvJlM4MNqdpm1gWSEs
         VwUZbXON1cDi1twpUtpayW+dMpQ/GAJsM8DTzweznm9Bzaf2gLe3Nd7U7o/1bJJTiFAe
         G/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724284133; x=1724888933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvBevw1bhQRbBrOnaYoAJ6EwtUVfWRiUsqO0hTMY8ek=;
        b=TUvmBkswyXS24A0tQo+GPq6T++B583OEzt9/XVllMEpIb/0lqiZ1D2eVpq3HHPhN/H
         El0QOgX1JTlBDfafLyvnDVZsalXXSDML5O1+0RwfkdYb8E5/vxaJX+Oh0tLHFm8Q2EME
         8XEz/JiXqVZunkVjcMg/aDB7SHexNgn5QFVer2T9MROp/vsHwgla3qhTOKw2tlhQvYEI
         A1DntEGHc6uSeO6iIebfmP2eVnKlK+Se/9YLeIll74E8Cmv3IHOOf1cBm7aa/DewaMjz
         e5CBv17Xubcab1gt9peb2qWoEgVfcsaMrVSN8ejcG6ZK4ddPwe843U0D2+JKnPWtsn12
         vtZg==
X-Forwarded-Encrypted: i=1; AJvYcCWfyziyBw2e+v9CDH5rvhK2NQOqab0WaONB7QxokvVRlpwUSjLlBp5lMFL1OR7H6BRPUuhIJs1KlPDReJKz@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYGgVocp1DxfoZ9gTWdQxPDMspZByC+4NGbHDXiKrohgMJA1k
	4UbL4ri4S34IqecmTON2Ynz9rqbHg180eYsrV+qZtt6ZfFkI7izN8kAq1vKkwS/ztIJNvotkBaG
	MNl6K3+zp5miDjmymDmdYmtkKXTg=
X-Google-Smtp-Source: AGHT+IEr1LLKFBtNtcXC8go+s5wsawuiX9ZOi/s+b+PgTCJbU9DhtroHzeH1EQAhvKukP9DDEa2MT+hfK5Lpcls8tEw=
X-Received: by 2002:a05:6122:3125:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-4fcf1b64a4fmr6241639e0c.12.1724284133293; Wed, 21 Aug 2024
 16:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820211735.2098951-1-bschubert@ddn.com>
In-Reply-To: <20240820211735.2098951-1-bschubert@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Aug 2024 16:48:42 -0700
Message-ID: <CAJnrk1Z6P5vs-u2uJJBk7nkKHpD+a19xPCzJ+OmJ3qfiNbBUzg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, josef@toxicpanda.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:18=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> This is to update attributes on open to achieve close-to-open
> coherency even if an inode has a attribute cache timeout.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>
> ---
> libfuse patch:
> https://github.com/libfuse/libfuse/pull/1020
> (FUSE_OPENDIR_GETATTR still missing at time of writing)
>
> Note: This does not make use of existing atomic-open patches
> as these are more complex than two new opcodes for open-getattr.
>
> Note2: This is an alternative to Joannes patch that adds
> FOPEN_FETCH_ATTR, which would need to kernel/userspace transitions
> https://lore.kernel.org/all/20240813212149.1909627-1-joannelkoong@gmail.c=
om/
>
> Question for reviewers:
> - Should this better use statx fields? Probably not needed for
>   coherency?
> - Should this introduce a new struct that contains
>   struct fuse_open_out and struct fuse_attr_out, with
>   additional padding between them to avoid incompat issues
>   if either struct should be extended?
> ---
>  fs/fuse/file.c            | 94 ++++++++++++++++++++++++++++++++++++++-
>  fs/fuse/fuse_i.h          |  7 +++
>  fs/fuse/ioctl.c           |  2 +-
>  include/uapi/linux/fuse.h |  5 +++
>  4 files changed, 105 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..d470e6a2b3d4 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -51,6 +51,78 @@ static int fuse_send_open(struct fuse_mount *fm, u64 n=
odeid,
>         return fuse_simple_request(fm, &args);
>  }
>
> +/*
> + * Open the file and update inode attributes
> + */
> +static int fuse_file_open_getattr(struct fuse_mount *fm, u64 nodeid,
> +                                 struct inode *inode, unsigned int open_=
flags,
> +                                 int opcode,
> +                                 struct fuse_open_out *open_outargp)
> +{
> +       struct fuse_conn *fc =3D fm->fc;
> +       u64 attr_version =3D fuse_get_attr_version(fc);
> +       struct fuse_open_in inarg;
> +       struct fuse_attr_out attr_outarg;
> +       FUSE_ARGS(args);
> +       int err;
> +
> +       /* convert the opcode from plain open to open-with-getattr */
> +       if (opcode =3D=3D FUSE_OPEN) {
> +               if (fc->no_open_getattr)
> +                       return -ENOSYS;
> +               opcode =3D FUSE_OPEN_GETATTR;
> +       } else {
> +               if (fc->no_opendir_getattr)
> +                       return -ENOSYS;
> +               opcode =3D FUSE_OPENDIR_GETATTR;
> +       }
> +
> +       memset(&inarg, 0, sizeof(inarg));
> +       inarg.flags =3D open_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> +       if (!fm->fc->atomic_o_trunc)
> +               inarg.flags &=3D ~O_TRUNC;
> +
> +       if (fm->fc->handle_killpriv_v2 &&
> +           (inarg.flags & O_TRUNC) && !capable(CAP_FSETID)) {
> +               inarg.open_flags |=3D FUSE_OPEN_KILL_SUIDGID;
> +       }
> +
> +       args.opcode =3D opcode;
> +       args.nodeid =3D nodeid;
> +       args.in_numargs =3D 1;
> +       args.in_args[0].size =3D sizeof(inarg);
> +       args.in_args[0].value =3D &inarg;
> +       args.out_numargs =3D 2;
> +       args.out_args[0].size =3D sizeof(*open_outargp);
> +       args.out_args[0].value =3D open_outargp;
> +       args.out_args[1].size =3D sizeof(attr_outarg);
> +       args.out_args[1].value =3D &attr_outarg;
> +
> +       err =3D fuse_simple_request(fm, &args);
> +       if (err) {
> +               if (err =3D=3D -ENOSYS) {
> +                       if (opcode =3D=3D FUSE_OPEN)
> +                               fc->no_open_getattr =3D 1;
> +                       else
> +                               fc->no_opendir_getattr =3D 1;
> +               }
> +               return err;
> +       }
> +
> +       err =3D -EIO;
> +       if (fuse_invalid_attr(&attr_outarg.attr) ||
> +           inode_wrong_type(inode, attr_outarg.attr.mode)) {
> +               fuse_make_bad(inode);
> +               return err;
> +       }
> +
> +       fuse_change_attributes(inode, &attr_outarg.attr, NULL,
> +                              ATTR_TIMEOUT(&attr_outarg), attr_version);
> +

Hi Bernrd,

For my use case, it'd be preferred if this could be gated by an FOPEN
flag that the server can set in the reply if it doesn't want to opt
into the refreshed attributes (eg if this flag is set, then the
getattr values in the reply are blank and the kernel should skip
fuse_change_attributes()). For the use case I have, the attributes
only need to be fetched and changed for O_APPENDs where it'd be ideal
if we could skip this overhead for non O_APPENDs.

This flag can be added separately after your patch lands, but just
wanted to note this now as a heads-up. I'm also happy to add this in
later if it's better to do this later than as part of this patch.

Thanks,
Joanne

