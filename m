Return-Path: <linux-fsdevel+bounces-45715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C5A7B711
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 07:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C239C176395
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 05:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1AB155C82;
	Fri,  4 Apr 2025 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLdGWt69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CC2E62B2;
	Fri,  4 Apr 2025 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743743663; cv=none; b=g3U7Zii97RZGg5ui3SJGTjsrPQmQptcC7VnDCW2Ra2PBa+h/Hh5BRv8tk7xki4zfE5IAKD6rVLy7l7EvhdLC8+Q0kZ54rUSB/7vz5b+EXN3d+XhHt8oe3ultfAu+pvS3UbXr18w71lQlFtgztuWhGaU4Q+QGRb+Zg9hMTTwgPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743743663; c=relaxed/simple;
	bh=ghZW4/xzBLPOmeaSqKF9FEmsw1FKrBfT42BFRILX8bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ/i1ZyPjTKE3C8v4AAP2y9MD7nYJt3nr6Egspe/jsCJ7E5lMeg0THLbp2xBt9ezraM6cmovwUG2t66ENbR9GDI2Y+GGjU+hikcm1hmtmoO6K2evw94MnzoyTB1GaL0ySjEpTKptqlrJXNEJsAtc8Ho09jaeFywxEoCOtTCU9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLdGWt69; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso4977244a12.1;
        Thu, 03 Apr 2025 22:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743743659; x=1744348459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH5VvbuT5ANGi2NKdXE1cVfO+Z2M+F1fr9TYCsTFmp4=;
        b=YLdGWt69M+J0VK+P+b26Cbf7/nQbzjqjr2aPALoSKqCNgT8LbngJ/cNe1127++HTFb
         an/yABVVjj+1aCEVHoN7h3xDJRM4QND+U3IEZXGIgO4MeYst6/rlM8tOf4UASTuyG0mJ
         1W32Cxn2pE3r83vyVB97u8Zb3VEu+Yx0TqebgK8zZvTDkgO82lBJgaU6QbGXQRGdfaXR
         hma5TF/wz0v2w28PE0q3rDN33nNaOLC5h2JqEUlqclSbgFmXTepiKw1hOHGm1YTdJLvp
         /EN1ByYgppedr/xeD8odbOeUqGZhZ4o8vXFROCat9b6QRXVRZPwdK+ak/Gf8dbrLCUBG
         2t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743743659; x=1744348459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH5VvbuT5ANGi2NKdXE1cVfO+Z2M+F1fr9TYCsTFmp4=;
        b=DtXBztNydB8SZuPywk80sklclYO+B6yQ0QykBouSnYBtu+FrVdrxTJ68+Te21aMDoF
         28W40d9z3XqYCPi7h3t97svEZGIric6lxJ9yCae4Ky49MMusGK1WzsaV66QexlRe3nuN
         KeBTjJgupY07ZjgMKevPQqDcDg9emAFh1zKX7VCaKloZUCU+03ThGLmCtYJ8Q3DimS8K
         4t3IuMzd7PUJYkZsqG9C/0PRrgyHERPiJaDB26a5mqSl1hrmgf7vdukGK3QbJpp0g9ZH
         iZZZgKdXRkpM7aLCD0lXcBJe1RMKmqdutgNScsRPjiOkFJ0gqwMDAoX9L5zclEK+6wWT
         1BZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCkJzoLu/nqATEdDRMnkHkPsmeZ8jdgkdKUMSnTN5D9cJ6mmFYF6eRvy1eLcJfAUjNwFg/uXGSNOLYfvBl@vger.kernel.org, AJvYcCURi7EpEb1AYnX4gIQfHpwXWiRwTT1/dDhW7V+uVz3MkDCBJ4rIOdGVFOOOqnoRCTUFv1XW44ZevIrkdR0z@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3IDHz+rBF/ha9P8UhHSQMYP28gS/hWSkJMgdiQ2NO7PGWwPS
	qbYLIU/XKKJtj+vHD0AKYA4vMTITMsuhhCFZuTqH0HORcLjcJ2JBGKmajK9DFQ687zxaV3afVH4
	RBSjVyjA4HzUYRXagw9+t6kDUPZE=
X-Gm-Gg: ASbGncueZYOx/0BOk7RjnHjYje7EC1oABQiHoQuiXE882FHMT3msqE21OmKoE2anFcg
	mIFm3pvKcNFxLys+ehHO5iZkAa3QWFUlvGCxS1O3JTsgQOp0mqUapy0pnPX2YFcnpCSiOZ+GhYy
	uGGjKOSLfdrpl8cXW4pPxqbhuY
X-Google-Smtp-Source: AGHT+IFo01rbFUEC5L75f3YJ7CKD87p2zcskAu4TJ1zTtI294NzJf2Gvon5nWcoHmnNLofVH7HPvk6e3PQ+yxJlBGow=
X-Received: by 2002:a05:6402:358c:b0:5e0:6e6c:e2b5 with SMTP id
 4fb4d7f45d1cf-5f08416d6a3mr4575343a12.9.1743743658824; Thu, 03 Apr 2025
 22:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <iufbqsvdp52sgpsjkyulfqgfpvksev3guds5hd556q7zxestgq@ixog46pumnry> <20250404032938.76632-1-superman.xpt@gmail.com>
In-Reply-To: <20250404032938.76632-1-superman.xpt@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 4 Apr 2025 07:14:05 +0200
X-Gm-Features: ATxdqUF-LDnRlZ_0uAku0KYRdzTwn8eDIPo6CqbUhdzPXEDhWRP7YVf7-pAr4pY
Message-ID: <CAGudoHGPzqdwVc8fvY0E00avYerFZ2b4g0GMHu6d=cCkSiizzw@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: Fix anon_inode triggering VFS_BUG_ON_INODE in may_open()
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 5:30=E2=80=AFAM Penglei Jiang <superman.xpt@gmail.co=
m> wrote:
>
> Some anon_inodes do not set the S_IFLNK, S_IFDIR, S_IFBLK, S_IFCHR,
> S_IFIFO, S_IFSOCK, or S_IFREG flags after initialization. As a result,
> opening these files triggers VFS_BUG_ON_INODE in the may_open() function.
>
> Here is the relevant code snippet:
>
>     static int may_open(struct mnt_idmap *idmap, const struct path *path,
>                 int acc_mode, int flag)
>     {
>             ...
>             switch (inode->i_mode & S_IFMT) {
>             case S_IFLNK:
>             case S_IFDIR:
>             case S_IFBLK:
>             case S_IFCHR:
>             case S_IFIFO:
>             case S_IFSOCK:
>             case S_IFREG:
>             default:
>                     VFS_BUG_ON_INODE(1, inode);
>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~
>             }
>             ...
>     }
>
> To address this, we modify the code so that only non-anon_inodes trigger
> VFS_BUG_ON_INODE, and we also check MAY_EXEC.
>
> To determine if an inode is an anon_inode, we consider two cases:
>
>   1. If the inode is the same as anon_inode_inode, it is the default
>      anon_inode.
>   2. Anonymous inodes created with alloc_anon_inode() set the S_PRIVATE
>      flag. If S_PRIVATE is set, we consider it an anonymous inode.
>
> The bug can be reproduced with the following code:
>
>     #include <stdio.h>
>     #include <unistd.h>
>     #include <fcntl.h>
>     #include <sys/timerfd.h>
>     int main(int argc, char **argv) {
>             int fd =3D timerfd_create(CLOCK_MONOTONIC, 0);
>             if (fd !=3D -1) {
>                     char path[256];
>                     sprintf(path, "/proc/self/fd/%d", fd);
>                     open(path, O_RDONLY);
>             }
>             return 0;
>     }
>
> Finally, after testing, anon_inodes no longer trigger VFS_BUG_ON_INODE.
>
> Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
> Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@goo=
gle.com"
> Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
> ---
> V1 -> V2: added MAY_EXEC check, added some comments
>
>  fs/anon_inodes.c            | 12 ++++++++++++
>  fs/namei.c                  |  8 +++++++-
>  include/linux/anon_inodes.h |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 583ac81669c2..bf124d53973e 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -303,6 +303,18 @@ int anon_inode_create_getfd(const char *name, const =
struct file_operations *fops
>         return __anon_inode_getfd(name, fops, priv, flags, context_inode,=
 true);
>  }
>
> +/**
> + * is_default_anon_inode - Checks if the given inode is the default
> + * anonymous inode (anon_inode_inode)
> + *
> + * @inode: [in] the inode to be checked
> + *
> + * Returns true if the given inode is anon_inode_inode, otherwise return=
s false.
> + */
> +inline bool is_default_anon_inode(const struct inode *inode)
> +{
> +       return anon_inode_inode =3D=3D inode;
> +}
>

I would drop the inline.

>  static int __init anon_inode_init(void)
>  {
> diff --git a/fs/namei.c b/fs/namei.c
> index 360a86ca1f02..e8cc00a7c31a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -40,6 +40,7 @@
>  #include <linux/bitops.h>
>  #include <linux/init_task.h>
>  #include <linux/uaccess.h>
> +#include <linux/anon_inodes.h>
>
>  #include "internal.h"
>  #include "mount.h"
> @@ -3429,7 +3430,12 @@ static int may_open(struct mnt_idmap *idmap, const=
 struct path *path,
>                         return -EACCES;
>                 break;
>         default:
> -               VFS_BUG_ON_INODE(1, inode);
> +               if (!is_default_anon_inode(inode)
> +                       && !(inode->i_flags & S_PRIVATE))
> +                       VFS_BUG_ON_INODE(1, inode);
> +               if (acc_mode & MAY_EXEC)
> +                       return -EACCES;
> +               break;
>         }

Semantically this looks ok to me.

It may be this happens to still be too restrictive, but then we are
erroring on the side of some test suite blowing up, as opposed to
something in production, so I think it's fine.

I would fold these conditions into the debug macro though, as in:
VFS_BUG_ON_INODE(!is_default_anon_inode(inode) && !(inode->i_flags &
S_PRIVATE)), inode);

>
>         error =3D inode_permission(idmap, inode, MAY_OPEN | acc_mode);
> diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
> index edef565c2a1a..eca4a3913ba7 100644
> --- a/include/linux/anon_inodes.h
> +++ b/include/linux/anon_inodes.h
> @@ -30,6 +30,7 @@ int anon_inode_create_getfd(const char *name,
>                             const struct file_operations *fops,
>                             void *priv, int flags,
>                             const struct inode *context_inode);
> +bool is_default_anon_inode(const struct inode *inode);
>
>  #endif /* _LINUX_ANON_INODES_H */
>
> --
> 2.17.1
>


--=20
Mateusz Guzik <mjguzik gmail.com>

