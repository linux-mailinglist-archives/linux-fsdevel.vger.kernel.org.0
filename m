Return-Path: <linux-fsdevel+bounces-34735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A7F9C833E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 07:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C71B25E06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 06:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203B41F26EA;
	Thu, 14 Nov 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEttJNDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2821EBA13;
	Thu, 14 Nov 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566253; cv=none; b=BVRtdzLouscKmYNKyRty2ZEkLmshh3JIa/MoFCzy/+vFnxAt8cXPEvf8zNtfVUlYxTLsFl7rLCyWQrb/VRC4tL6s24tg1lkwoQiTi2dXFZJHymhygk3j2myW0wwT3AvA/Fxvl4oznhEkbNlQtDojNUgaFxXouXcNPcc+Pn1PWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566253; c=relaxed/simple;
	bh=t0fAVzOYyF5qw89A/dIpuz1Zzf7e7o3ntxpTY6PixW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3whceerDfb4iXYY2ZLkaHutz3tl8JZhsz1K1rhUZRvM0Dq/sI4Ws+mZUMzWr8zXPpjWsoa00FGG3Gdr4ly4r8quzYLwwiAwFPHJCPEvUlPHoM8M4WbndMmxu6jNWZuyd7Yjf98VTN4OjtiewBlCnJb42vDCQEvlrr2j6bc1nP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEttJNDx; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84fc21ac668so110540241.1;
        Wed, 13 Nov 2024 22:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731566251; x=1732171051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txC1n0omKiC4TZQQxbVecT/EBICb8M4xgYoqoUnU1Mg=;
        b=LEttJNDx/G/gPaoQGuMd/YktT0ZvOVfClixcFLjHNVYZTvK3lZTJ04eLBEFlxjAIg+
         /5Qe+sx41YIKmAJOQjuTcemjQVNMZ2Hqs5qhtoFzI/sjSFRXcIy3vV7HiIRt+Ly5sxBt
         vUzR2rBChZR/f4GIIXvCY0MYsbBUeg16pDIVFcTlnOcIxIGN/RMsQwyNeRfA3ODLjvn+
         lr5YHqBixewoVJPEDnBNrNIE8aDOGr3QpfrL8CXwas8PNuASSfT5omsdtNkamfeaKh+/
         uMB0hI0o1IYmI9CzSRTJ62rYs+e7zyT1Faf81NKyA72xNdYQguT9nWDBmzmgtXF+m7Sr
         RS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731566251; x=1732171051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txC1n0omKiC4TZQQxbVecT/EBICb8M4xgYoqoUnU1Mg=;
        b=TKWgHskmg0LBtdBz8KVidEWsDl6VvgoswqTaZ5Xq9WC4yvyn9BWZzRPeiOVpO87LTu
         U3pnzjovQjq29GgMKRowTLbQYTmnphUz17+oeKA8Tf7qh/erOSE6tIS8UK4kNCgjz/PG
         wCrRIGQHsoxtVzqnjvhrVwn0+DTXE+uPjqOrmh4pE4qlinJoif4aasH6qkTyCRm4nXvY
         +/3AbD089+fXIScAxscADynQznzsGDJb6prLqGbh/wk+cbC1UaWe3FsW+VpYF3Lp57mi
         6qmTeAfdCzHeWprN6HHuYLTtMjQcCOIgcUN5pg2kkyOht6EyEv9gc99YstZHASv6TVTQ
         /5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUz+yOc2opKOebZluGtACBPIjotg3AWtqbObZunyEqOyXCDZ5G0rWVRKQKWUO5pQaWbQubUnBCnHlMQvVZc@vger.kernel.org, AJvYcCVQifhG2GXBCf4pVFUCNnUHyqA7vYNy2huZ95u1C87o1XBd4VByE+DWLzBg1Z3Ck+zL1baGL1aHGDR2@vger.kernel.org, AJvYcCWwGIWCm0hxzKya/HNTJC+rmFmC1C+Du2XT0fmbHl3PxLvDEXoqsEYdF+CSDgd7HwgDxEIYHbXET6f77BlD@vger.kernel.org
X-Gm-Message-State: AOJu0YzE02utyn6uv7+nqwl1q87hOlcBYC0DHOAUTtsT1l4b56Go5lyx
	R7wVgVLPaVVLEmT/5ro7kanedfnzeZDJ6B4tlKDniG3aHZhBNkO4VNm57dlN2hvQtFuYbJWMQ3N
	UN0Rs6x7EXjZJ0tJAbpsTQjSSOaU=
X-Google-Smtp-Source: AGHT+IEkeFjbjONhEwNPEZyUsptP7QvNoOjs9BpAGNrb8Y/Eyr40baQALWAfEmTfjMIUTgrNqTUirj1PGigU3Ik4Y7U=
X-Received: by 2002:a05:6102:38d0:b0:498:f38a:2c80 with SMTP id
 ada2fe7eead31-4aae13cf756mr23396170137.10.1731566250589; Wed, 13 Nov 2024
 22:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu> <20241113-pidfs_fh-v2-2-9a4d28155a37@e43.eu>
In-Reply-To: <20241113-pidfs_fh-v2-2-9a4d28155a37@e43.eu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 07:37:19 +0100
Message-ID: <CAOQ4uxgoT34WXFYncvPCZHwd2y3viaXjR=j08jM9c3x20Ar8Tg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] exportfs: allow fs to disable CAP_DAC_READ_SEARCH check
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:11=E2=80=AFPM Erin Shepherd <erin.shepherd@e43.eu=
> wrote:
>
> For pidfs, there is no reason to restrict file handle decoding by
> CAP_DAC_READ_SEARCH. Introduce an export_ops flag that can indicate
> this
>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> ---
>  fs/fhandle.c             | 36 +++++++++++++++++++++---------------
>  include/linux/exportfs.h |  3 +++
>  2 files changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 82df28d45cd70a7df525f50bbb398d646110cd99..056116e58f43983bc7bb86da1=
70fb554c7a2fac7 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -235,26 +235,32 @@ static int do_handle_to_path(struct file_handle *ha=
ndle, struct path *path,
>         return 0;
>  }
>
> -/*
> - * Allow relaxed permissions of file handles if the caller has the
> - * ability to mount the filesystem or create a bind-mount of the
> - * provided @mountdirfd.
> - *
> - * In both cases the caller may be able to get an unobstructed way to
> - * the encoded file handle. If the caller is only able to create a
> - * bind-mount we need to verify that there are no locked mounts on top
> - * of it that could prevent us from getting to the encoded file.
> - *
> - * In principle, locked mounts can prevent the caller from mounting the
> - * filesystem but that only applies to procfs and sysfs neither of which
> - * support decoding file handles.
> - */
>  static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
>                                  unsigned int o_flags)
>  {
>         struct path *root =3D &ctx->root;
> +       struct export_operations *nop =3D root->mnt->mnt_sb->s_export_op;
> +
> +       if (nop && nop->flags & EXPORT_OP_UNRESTRICTED_OPEN)
> +               return true;
> +
> +       if (capable(CAP_DAC_READ_SEARCH))
> +               return true;
>
>         /*
> +        * Allow relaxed permissions of file handles if the caller has th=
e
> +        * ability to mount the filesystem or create a bind-mount of the
> +        * provided @mountdirfd.
> +        *
> +        * In both cases the caller may be able to get an unobstructed wa=
y to
> +        * the encoded file handle. If the caller is only able to create =
a
> +        * bind-mount we need to verify that there are no locked mounts o=
n top
> +        * of it that could prevent us from getting to the encoded file.
> +        *
> +        * In principle, locked mounts can prevent the caller from mounti=
ng the
> +        * filesystem but that only applies to procfs and sysfs neither o=
f which
> +        * support decoding file handles.
> +        *
>          * Restrict to O_DIRECTORY to provide a deterministic API that av=
oids a
>          * confusing api in the face of disconnected non-dir dentries.
>          *
> @@ -293,7 +299,7 @@ static int handle_to_path(int mountdirfd, struct file=
_handle __user *ufh,
>         if (retval)
>                 goto out_err;
>
> -       if (!capable(CAP_DAC_READ_SEARCH) && !may_decode_fh(&ctx, o_flags=
)) {
> +       if (!may_decode_fh(&ctx, o_flags)) {
>                 retval =3D -EPERM;
>                 goto out_path;
>         }
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 893a1d21dc1c4abc7e52325d7a4cf0adb407f039..459508b53e77ed0597cee217f=
fe3d82cc7cc11a4 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -247,6 +247,9 @@ struct export_operations {
>                                                 */
>  #define EXPORT_OP_FLUSH_ON_CLOSE       (0x20) /* fs flushes file data on=
 close */
>  #define EXPORT_OP_ASYNC_LOCK           (0x40) /* fs can do async lock re=
quest */
> +#define EXPORT_OP_UNRESTRICTED_OPEN    (0x80) /* FS allows open_by_handl=
e_at
> +                                                 without CAP_DAC_READ_SE=
ARCH
> +                                               */

Don't love the name, but I wonder, isn't SB_NOUSER already a good
enough indication that CAP_DAC_READ_SEARCH is irrelevant?

Essentially, mnt_fd is the user's proof that they can access the mount
and CAP_DAC_READ_SEARCH is the legacy "proof" that the user can
reach from mount the inode by path lookup.

Which reminds me, what is the mnt_fd expected for opening a pidfd
file by handle?

Thanks,
Amir.

