Return-Path: <linux-fsdevel+bounces-34738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C39C83CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEDE286211
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7B1F4FC4;
	Thu, 14 Nov 2024 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOakZ1//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5921EBA1A;
	Thu, 14 Nov 2024 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568086; cv=none; b=OEtQsPeshrmAKGLmHDinnpCRVzCIsPwYr3F2oR7CTucA9JO9GCHt6xjbVzPf/Lbu5VG2E9baVVdDl7nr0y0xPTNOdzGMshWRtUwXM1EtbxLfsyudJP/MXd1QZw3umC+3KJ5QWOyZ8AaCp1ZKO+BI9Jq8Q/qBBifUBZZ9/q1IwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568086; c=relaxed/simple;
	bh=USaJ9TKLIITQYM06sc442Xnr6FLSqpXvaxlsuiBHCx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9YNVxPOwT+DEwRKR06RDrqJmwarjyLdQe1tcBtfIi8kJLiXrz4q3Cek6qXuHIQmiCvRGVanO9khD2eZBB7Q9vJnljWCWUrd2vL0r54LhorOQ25Ns3VBNlni1l0KVHWCJ5IhoU+H34I7W/Oc2SNC9i6Fl07PZsEIMsg/6n4xQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOakZ1//; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84ff612ca93so156042241.0;
        Wed, 13 Nov 2024 23:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568084; x=1732172884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZP2UtkUiMuuO8ctVNh2CbqEJUiU2189veCM3C4kakw=;
        b=KOakZ1//f14/icnJ/Cg1K/Blx/1vlnVtA2urlN/tWRM8Fmc3ZQru5Jc+Jg581qTldT
         RHO80MdfL730sPc0XNTkDI9EFr/xHUfRjNPqx/pj4KNTgn4hq7DbQbI5AziCk/14JSwS
         5aXXx1I4rC5uE9slxr8RSL6zufqQ/h8tsQBeBDXUUMSnfygWpww3mjYUaeYVU3nQnS7q
         ksT9BnwsmrNitSo/5JjQEhvGgkxSIBb7Bjv7HA6qBNhzr3Uaf+ON6GUI5dkOuWiVe+eW
         GP/nhHLJ7aBNRG5iLlbzR1dBqxsLXXHf3P2rxsU2BnfiYDIwtxPYnwgQmu5FIfcvClYh
         psHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568084; x=1732172884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZP2UtkUiMuuO8ctVNh2CbqEJUiU2189veCM3C4kakw=;
        b=xPqkHImjjVsPzjHpAIOIrWpIUWkINyOc1HlgGBZRyRzLk0n9Q6081bza+Oc14nEOqu
         zrwuVGf9znd2MvrlDSRh1t1PF47A/nxDzSD2JaV4lZB/0nESLlN8kPs1snLZX6iVDd5Y
         48C+NXtQXtLGnfWDAwAongrE0VlUJzmpp3kaIAz8gChjoXYyGaWx3HdpPlaK2j4QxmOJ
         EOi0HAkPbIQ7tAZqcCtQFnu7r6xlLTiyVW5b6UkTp07vtLFjKK7DzaFqJ7jE+pz8fIaE
         8CIVMcZhT9KkQG3++ZqjdZDwYwrLcZ+WNYiRiLiQ3u0bAdmISpQ3b8VJgaEsjDhl2OrR
         s1JA==
X-Forwarded-Encrypted: i=1; AJvYcCUyBTjk5/KhCQ1k300p56yYY1jsWpCUJS/ctjkoAEGIwUFXQU2hHnkbJBcnlE29Fkj0WAuhc4vPZ6134GwY@vger.kernel.org, AJvYcCV8LGvZQ48zUc2w3Ndb1mcgzzsN8GKJXse7Z0p46C//m1P4i0B4CPR20wHCfRyA1/BFziMJYUDCcEha@vger.kernel.org, AJvYcCWZ5FfxBMuJb2G8DJVvWP5tczWCb2nSIMLpO/yO5uYYOXUlfrYtdDfkEu7epErvL51y4TN/WYkERVSR8+Er@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cUN/yFxZt4+dL67qp9Fe0MmS7X2ulYP5vH+Tcu3nNwHUosMs
	pR0GxjHybRkWLdnZywGDy4SuBQkCwTthqSgmR7PhnEkoAvhcT/LHUR0L7e8sHY2xFGajbZRwzBu
	HvkoKbmwii4EhXfNrQSnRa+XJSAU=
X-Google-Smtp-Source: AGHT+IGrcBld05U+5d5DC5hjOPJVXl2Eom2ykIjoK9+tfez3tbRGjLskRKvZhchbOuniV0XARXgJri/fVvLJVkgyG7s=
X-Received: by 2002:a05:6102:2911:b0:4a5:b3e1:f28b with SMTP id
 ada2fe7eead31-4aae1351d90mr22025827137.1.1731568084106; Wed, 13 Nov 2024
 23:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu> <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>
In-Reply-To: <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 08:07:52 +0100
Message-ID: <CAOQ4uxh2HWkVE_aMeYSTsYRO9_sKMPH7V2uksWFSo3ucWOoJ2g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pidfs: implement file handle support
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 7:11=E2=80=AFPM Erin Shepherd <erin.shepherd@e43.eu=
> wrote:
>
> On 64-bit platforms, userspace can read the pidfd's inode in order to
> get a never-repeated PID identifier. On 32-bit platforms this identifier
> is not exposed, as inodes are limited to 32 bits. Instead expose the
> identifier via export_fh, which makes it available to userspace via
> name_to_handle_at
>
> In addition we implement fh_to_dentry, which allows userspace to
> recover a pidfd from a PID file handle.

"In addition" is a good indication that a separate patch was a good idea..

>
> We stash the process' PID in the root pid namespace inside the handle,
> and use that to recover the pid (validating that pid->ino matches the
> value in the handle, i.e. that the pid has not been reused).
>
> We use the root namespace in order to ensure that file handles can be
> moved across namespaces; however, we validate that the PID exists in
> the current namespace before returning the inode.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

This patch has changed enough that you should not have kept my RVB.

BTW, please refrain from using the same subject for the cover letter and
a single patch. They are not the same thing, so if they get the same
name, one of them has an inaccurate description.

> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> ---
>  fs/pidfs.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 80675b6bf88459c22787edaa68db360bdc0d0782..0684a9b8fe71c5205fb153b27=
14bc9c672045fd5 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/anon_inodes.h>
> +#include <linux/exportfs.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/magic.h>
> @@ -347,11 +348,69 @@ static const struct dentry_operations pidfs_dentry_=
operations =3D {
>         .d_prune        =3D stashed_dentry_prune,
>  };
>
> +#define PIDFD_FID_LEN 3
> +
> +struct pidfd_fid {
> +       u64 ino;
> +       s32 pid;
> +} __packed;
> +
> +static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +                          struct inode *parent)
> +{
> +       struct pid *pid =3D inode->i_private;
> +       struct pidfd_fid *fid =3D (struct pidfd_fid *)fh;
> +
> +       if (*max_len < PIDFD_FID_LEN) {
> +               *max_len =3D PIDFD_FID_LEN;
> +               return FILEID_INVALID;
> +       }
> +
> +       fid->ino =3D pid->ino;
> +       fid->pid =3D pid_nr(pid);
> +       *max_len =3D PIDFD_FID_LEN;
> +       return FILEID_INO64_GEN;
> +}
> +
> +static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> +                                        struct fid *gen_fid,
> +                                        int fh_len, int fh_type)
> +{
> +       int ret;
> +       struct path path;
> +       struct pidfd_fid *fid =3D (struct pidfd_fid *)gen_fid;
> +       struct pid *pid;
> +
> +       if (fh_type !=3D FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
> +               return NULL;
> +
> +       scoped_guard(rcu) {
> +               pid =3D find_pid_ns(fid->pid, &init_pid_ns);
> +               if (!pid || pid->ino !=3D fid->ino || pid_vnr(pid) =3D=3D=
 0)
> +                       return NULL;
> +
> +               pid =3D get_pid(pid);
> +       }
> +
> +       ret =3D path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
> +       if (ret < 0)
> +               return ERR_PTR(ret);

How come no need to put_pid() in case of error?

> +
> +       mntput(path.mnt);
> +       return path.dentry;
> +}
> +
> +static const struct export_operations pidfs_export_operations =3D {
> +       .encode_fh =3D pidfs_encode_fh,
> +       .fh_to_dentry =3D pidfs_fh_to_dentry,
> +       .flags =3D EXPORT_OP_UNRESTRICTED_OPEN,
> +};
> +
>  static int pidfs_init_inode(struct inode *inode, void *data)
>  {
>         inode->i_private =3D data;
>         inode->i_flags |=3D S_PRIVATE;
> -       inode->i_mode |=3D S_IRWXU;
> +       inode->i_mode |=3D S_IRWXU | S_IRWXG | S_IRWXO;

This change is not explained.
Why is it here?

Thanks,
Amir.

