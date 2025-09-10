Return-Path: <linux-fsdevel+bounces-60830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0959EB51E99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925BE5E4590
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99F314A98;
	Wed, 10 Sep 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR3Hcz44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027622C11C0;
	Wed, 10 Sep 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524057; cv=none; b=AplV0hNH5v0bUfQWnNuVbNfzOOjzjBXJsUth1yhBejw831Y2Yk72fmtb+4gZ0Nbb27+DOarjyaiA49w46irne+I00GXlUfQ1TzdTATxIJAF6XWMcOWRlNu51gKeXD+kj9CMb1Fp75W3E4AnZAVM4vI+Pg9M1MIRNHvCHzmMyHgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524057; c=relaxed/simple;
	bh=YWoom1+054/5jRVYGHQmXa1uDmT0Iy5UzJhbzNTORGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOMIecLfBnSHL8R8p6U05uWe0f7QkyTtqtj2uDSo7rCCsYh4z1JMlhuCChhZc/edZ33MxNK+TjSFxGc73ZQjc8kJFegi0umJiWy5dWXgIspoJInGPt33J6cU6uXFC5bU+9yv+ESwkL9VCWjgIf/x4rjrhKi219SGR74nV09eu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR3Hcz44; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso10884000a12.2;
        Wed, 10 Sep 2025 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757524054; x=1758128854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9gl8boVwEXv9hUGRSaYumN8gHsUo/khQdpwWdU60yA=;
        b=lR3Hcz447JfhXZt0JNjxxrJ/wMmL3Y32G662iXWHTyanLuo5HaGAqhSk/7ys0FGZfg
         usMpBt+3jTbv4/GAq0mVUfm6SrO6Et4dSRc355e4J6cDEq5TU3MeQqfNZMWDxDnSogYM
         fcAWNegdC11bJc2baYCpu6iDuzA3TNZhHY+25R+COj1InANm02vlLjLhHWYEdRoEAGqQ
         CNCL+kY71F5+4Vj3z0wpqbF9hQBGAotwq5WplKoSLYoVN3jUZu4AcipLgOJyS/++oC56
         FfmymWPYd6G4cNMx6S+tSvmFOUSTg/q4gTzKQ+nRTC+nCv5PG5mo8khnMkmfK1kKffoi
         gWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524054; x=1758128854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9gl8boVwEXv9hUGRSaYumN8gHsUo/khQdpwWdU60yA=;
        b=eqRC7Wqt1CQaajHDoafcbq97JuTQoQO97HPcB8lRoC+nMPhGb6xVbXb0VoEtH/1te/
         O+rCruln96rJPx0vAWrOalL0/bUk8bu7hKnG4RQoSU6jaSCiwgTtGfOdjhOAaeqfKFHY
         sxfBmRxMw/ymOk4Jo7CVOvkyGW+3J2BEHr4zNk+yQT+0DrlZRosn1Py+98++/q6SvHdL
         upcr0iBuDV036vFH8KyDlHWpm8AGa+IxYP08IV7v3m3jeJ4bSwEM2QI7WtS+JseQcJ+c
         ZqlDk1tnZ0DoCOLhajQFBK5Dw/khyZE4h6aJCVcky/VHyOZUQLRd4I0pInUtxeiomunc
         Go1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5ek3kac5JTGWzKxDthpRP1E/7Nz13xUxeYKJ2SE0jYchtks1noXNt3AJqyr53XeIJ6qvYUgnd@vger.kernel.org, AJvYcCURZpeBs6qIbnk8rkOkC4b3BpqDoudBoflQwlJRoIZyh6IVprF0gBdRCubkEfrh/hZjnjPK5mLKpt3+@vger.kernel.org, AJvYcCVWbjlD5SRwaCfNySsRvdj21Skrudhpxop8cuINJZ+RnPTRyzU9ds+xIoWCJti8/RTjkSDYtkUs@vger.kernel.org, AJvYcCVwBX4i/LxUwtp5rHOadlK1rDLAUdjVLsj1gMLV6H57DoGYJVL89B7uUOnzMDQG6JISh5R6Xmj9MXgjdPwBrQm3@vger.kernel.org, AJvYcCWFCNLIyn8jsLNrpoloVSawZSgluF9q5p+aEHmWBn6mVYEXJXYpsnaO+aWeqZEweRhZvBSrgVh5X6+E07n3@vger.kernel.org, AJvYcCX++mhZUzYecYB0ftX6drn7IxiL5hJblf9feqSppkCKIQvy7+c7Gda2p3IAKzGZKso0D+shX/8/UMXb9Gcc7Q==@vger.kernel.org, AJvYcCXSGmZ1WLRBuUPMgrcT83G1pFodlTsIU6vwDPE8g74tTlCbJ8S42JOY5WeTTMxm/FV1kwWgqFHKmydZfSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVs9vRiMieIiN5VuLc8G82aEbsPhq0ynGSMWRE33BI+6+wvmk
	2B8ClwCyCCOBFBY/hR49IukpxABv+mUB0Jo7RjvWOxHklqYvBrrHHBO7M4eES8+kfP5Dph46Z1O
	kdOIs8sYMRWzh5kz8FrOz9zfl0sB4cGM=
X-Gm-Gg: ASbGncvFPAJzcaCdsKT/2Fk3O9ATD3z5tHA/8pbUIekcC3OSuGd7K1BIMQnY6ajzGTh
	xQ4nHsurC7xCMrt22uVPx+Z2PZKmvyq1DfhDIVQF8xiE3vc7muuNYM4vikHJc8zYofloi2xZ2+s
	Cm9BoAhNP4Q3bYOYkY0vL1ciM/9V1PnLXDRcNOBwfo/BcvUa3bKFfp20R0Xk7T0fx67651aBtbM
	lE0wQl7t007XgHVaQ==
X-Google-Smtp-Source: AGHT+IE+nh79NH7zsv87bURibrjZT5O0XqDSpQb84PYB+QCmTYKzJRYwXTG9gMJk9B2cZF1lqAXBrfmoiCdYZWxLuaU=
X-Received: by 2002:a05:6402:d0d:b0:628:79f4:b050 with SMTP id
 4fb4d7f45d1cf-62879f4b986mr9593215a12.30.1757524053896; Wed, 10 Sep 2025
 10:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org> <20250910-work-namespace-v1-28-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-28-4dd56e7359d8@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Sep 2025 19:07:22 +0200
X-Gm-Features: AS18NWDTXEcgCcD0eE9xaVZPBsGH-OZUi00zWx07R9YiNMR1y39U0KxcJZGX6E4
Message-ID: <CAOQ4uxhW-pfC8+FSZfvA63mM+Kv1oYOvtzV+KxLycrie1sqdXA@mail.gmail.com>
Subject: Re: [PATCH 28/32] nsfs: support exhaustive file handles
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:39=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Pidfd file handles are exhaustive meaning they don't require a handle on
> another pidfd to pass to open_by_handle_at() so it can derive the
> filesystem to decode in. Instead it can be derived from the file
> handle itself. The same is possible for namespace file handles.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> ---
>  fs/fhandle.c               |  6 ++++++
>  fs/internal.h              |  1 +
>  fs/nsfs.c                  | 10 ++++++++++
>  include/uapi/linux/fcntl.h |  1 +
>  4 files changed, 18 insertions(+)
>
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 7c236f64cdea..f18c855bb0c2 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -11,6 +11,7 @@
>  #include <linux/personality.h>
>  #include <linux/uaccess.h>
>  #include <linux/compat.h>
> +#include <linux/nsfs.h>
>  #include "internal.h"
>  #include "mount.h"
>
> @@ -189,6 +190,11 @@ static int get_path_anchor(int fd, struct path *root=
)
>                 return 0;
>         }
>
> +       if (fd =3D=3D FD_NSFS_ROOT) {
> +               nsfs_get_root(root);
> +               return 0;
> +       }
> +
>         return -EBADF;
>  }
>
> diff --git a/fs/internal.h b/fs/internal.h
> index 38e8aab27bbd..a33d18ee5b74 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -355,3 +355,4 @@ int anon_inode_getattr(struct mnt_idmap *idmap, const=
 struct path *path,
>  int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>                        struct iattr *attr);
>  void pidfs_get_root(struct path *path);
> +void nsfs_get_root(struct path *path);
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index a1585a2f4f03..3c6fcf652633 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -25,6 +25,14 @@
>
>  static struct vfsmount *nsfs_mnt;
>
> +static struct path nsfs_root_path =3D {};
> +
> +void nsfs_get_root(struct path *path)
> +{
> +       *path =3D nsfs_root_path;
> +       path_get(path);
> +}
> +
>  static long ns_ioctl(struct file *filp, unsigned int ioctl,
>                         unsigned long arg);
>  static const struct file_operations ns_file_operations =3D {
> @@ -616,4 +624,6 @@ void __init nsfs_init(void)
>         if (IS_ERR(nsfs_mnt))
>                 panic("can't set nsfs up\n");
>         nsfs_mnt->mnt_sb->s_flags &=3D ~SB_NOUSER;
> +       nsfs_root_path.mnt =3D nsfs_mnt;
> +       nsfs_root_path.dentry =3D nsfs_mnt->mnt_root;
>  }
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index f291ab4f94eb..3741ea1b73d8 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -111,6 +111,7 @@
>  #define PIDFD_SELF_THREAD_GROUP                -10001 /* Current thread =
group leader. */
>
>  #define FD_PIDFS_ROOT                  -10002 /* Root of the pidfs files=
ystem */
> +#define FD_NSFS_ROOT                   -10003 /* Root of the nsfs filesy=
stem */
>  #define FD_INVALID                     -10009 /* Invalid file descriptor=
: -10000 - EBADF =3D -10009 */
>
>  /* Generic flags for the *at(2) family of syscalls. */
>
> --
> 2.47.3
>

