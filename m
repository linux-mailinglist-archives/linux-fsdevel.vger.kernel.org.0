Return-Path: <linux-fsdevel+bounces-47526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A9A9F545
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4B67A2DB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40427A130;
	Mon, 28 Apr 2025 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZUiobds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA68269808;
	Mon, 28 Apr 2025 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856755; cv=none; b=ce5orsm8Nfj/CWGDkEjtmn4J0Tk3qJEP8SSKnz+8x/bJ6n71IL3JQ31rxb6trCKvEpxG47nwSlW6vlqdofBeK4QQ6CVxE4SkcZD1wYRuTq0DexUlgiUCfm9/X6ltrD7XLmjHVwlHgzfQqeIHEAXHKbY9Zle8A99YLFZXRJLDkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856755; c=relaxed/simple;
	bh=Rltkj6RM0kMKiS9Ebpe+lThG3DA7XH72dO3RYED0F/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l16wnD/86XcdGeMB2Uq5iR7WtN731VNe16QCUzvSgTH0ZwojkiHA1+/AHiv/DBujiRSbpnoZ4q1Tj7HZ3RxoF7VcsN27CVx8nI7EBqXz7nv/XMQWGbhAB2W2wMixC96EY4c0P95402NS7n41Jip1G+5kDnHmlrSw1cNoyJrSca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZUiobds; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73972a54919so4201927b3a.3;
        Mon, 28 Apr 2025 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745856753; x=1746461553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWj5SIZmOjmmhEqZu/8t07TH6D4TeoZU34p2IG7HkhY=;
        b=IZUiobdscBSB351AWbDQGLjc/I9UCh15s6+dYjJKBEQxGzuO6b8R36YO3SsESP71yV
         tZ7t10tRRwS4Fz62++i7Mt0WAYmqTNDmIpgiJdRHaNErIel/dlfc3s1bTvWDLKuwKJHQ
         PHB6zgWJuypQBrVJUi1ZutPPKAEYoSCXNFFEuqRhfegEs7IA0chTB2PNdux4AKVs9VxS
         0ALk58HovPaMO4CWtNoL2iT7/y2SJ9+ceOPYoANh9R6/PoWZ8bRJsRUG8pyCdEAfGRxx
         0up+GhcMW2WNio3G67u8eKVxxOLuFFMrODGj19uie9cSSUMcAUVEhjeCiuzhNmgVuvZM
         66xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745856753; x=1746461553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWj5SIZmOjmmhEqZu/8t07TH6D4TeoZU34p2IG7HkhY=;
        b=JrRUOFt8NVM8vjx87rN9cxcVMPTyeoxRBJ84B49nimrIRibYD6Xcm42nwcDGDWtHun
         W0MRRrFQxc94ViKzF6p2bGYzTjW0JV1MSRs82J7y1v1qO5ZHm/Zr4YG+8jcXE1wBzhOc
         kF+OJJbdRvDcUd2Ya060ncaoxihj5oeJEFp0oofXrA0GOOay27G1K0nx5ahC7VEtTvwo
         fqrBNoeC796Z2D4pLTOBzS34smPTLH2WOyW2CS+XkiqnUx8P+TKI3MruQcP0uQRk38qm
         S8hUPlEsfu3RHWZs37JswRRkLKbu9tUUW7fcS5CgEyQ8RooS5LY2yFJ6LjBF1hE9c7YF
         NCxA==
X-Forwarded-Encrypted: i=1; AJvYcCUYBgIiYnNBnTx2KDzoR5JRf2CeWCgzg5bh/nHurAnY1xvvi6CB9V7WX+XvLyI8o115Cd6xF9LXhyzSs4FR@vger.kernel.org, AJvYcCV9HSDSNLF6ifOAfC5RNiOFtD5qnCbe/+7qkGcGYBr2yoXoYbEDav5nBeawOoyQ/9jKXRJwQxsL@vger.kernel.org, AJvYcCVRTwd487JxnSUr3sUhAjmseh8FcRf7jj35cMiVvVM+khdajeDrItHcc8RHJMP5kLm5dZr1XKIz++q7@vger.kernel.org, AJvYcCVbCVfe6nIuye8Nc9fPQIiqHRwG0qAwkAQOUfPtypkJXhRBbn1Q/obMwGyP5AA6qTc6aj7VdhP8t9CDosOSjEKWq/8qiExD@vger.kernel.org, AJvYcCXXya2Rqtp0U82MChiI1rC5rMH2zmSU6rpjez+pc0W9f2W3h7s7ZOihkADUvDkFl5lnXsUfWIjBsw==@vger.kernel.org, AJvYcCXylG0sSndxsb/mYqm2Olk9uV2N9tafw+3C4ThQBwGrENj3zmTGwaGNG5OWltslo+h2CFApgIus4bAFG0Gf@vger.kernel.org
X-Gm-Message-State: AOJu0YyFGziQmoHsA9vwZ/EwIRzojuPuPwNI7AJ60oBye4u0enCNSkZ3
	fIx9J+a/QWLXKoAKxFUp358/8+a16G08fZG/FBo8iGYi988+SR0OafvbpXszF3nP5DZ8wEjCx0/
	ROK4L0KY+AzKsBBwvT/FCFxARaCE=
X-Gm-Gg: ASbGncs/lqL8fBExrjmTKlp0Tp8omONXiayLCP+M8efGMjKod6hbXjO9Ym3yZ7Bx6F2
	KX9L313rLf28DIMq2WVOSVDuRdvOVE3/NFlJBVrdDNhGklpgnrWDg386iu92hvPjy/2tvUWGbz6
	EmUlLdNVJcXX3O5Nam7mA/ZqHUJMG4Y4vf
X-Google-Smtp-Source: AGHT+IGxWi7UwQNMvXh+m7DRcsTCH55YcMVjC3Qqr2LbHDgQyhvIhmo2pzUsmjobOWiItVALU0XvCvDO7zm6jM3f97U=
X-Received: by 2002:a05:6a20:9f4f:b0:1f5:7f56:a649 with SMTP id
 adf61e73a8af0-2093c6ea613mr115975637.13.1745856753106; Mon, 28 Apr 2025
 09:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428155535.6577-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250428155535.6577-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Apr 2025 12:12:21 -0400
X-Gm-Features: ATxdqUGl7iDYnL9lQ8RWYbYu_N3VrAZnaB4SPyxF1Xku-b9uq2X_hc2uFrA76_0
Message-ID: <CAEjxPJ4fE2z27v+U28smRDKojKbF95dMKnQtustGjiyOrOJ0gA@mail.gmail.com>
Subject: Re: [PATCH] security,fs,nfs,net: update security_inode_listsecurity() interface
To: paul@paul-moore.com
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:00=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
>
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.small=
ey.work@gmail.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This patch is relative to the one linked above, which in theory is on
> vfs.fixes but doesn't appear to have been pushed when I looked.
>
>  fs/nfs/nfs4proc.c             |  9 +++++----
>  fs/xattr.c                    | 20 ++++++++------------
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  net/socket.c                  |  8 +-------
>  security/security.c           | 16 ++++++++--------
>  security/selinux/hooks.c      | 10 +++-------
>  security/smack/smack_lsm.c    | 13 ++++---------
>  8 files changed, 34 insertions(+), 51 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 970f28dbf253..a1d7cb0acb5e 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -8023,12 +8023,13 @@ static int nfs4_xattr_get_nfs4_label(const struct=
 xattr_handler *handler,
>  static ssize_t
>  nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_l=
en)
>  {
> -       int len =3D 0;
> +       ssize_t len =3D 0;
> +       int err;
>
>         if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
> -               len =3D security_inode_listsecurity(inode, list, list_len=
);
> -               if (len >=3D 0 && list_len && len > list_len)
> -                       return -ERANGE;
> +               err =3D security_inode_listsecurity(inode, &list, &len);
> +               if (err)
> +                       len =3D err;

That's obviously wrong, sorry for the noise. v2 coming.

>         }
>         return len;
>  }
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 2fc314b27120..fdd2f387bfd5 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -492,9 +492,12 @@ vfs_listxattr(struct dentry *dentry, char *list, siz=
e_t size)
>         if (inode->i_op->listxattr) {
>                 error =3D inode->i_op->listxattr(dentry, list, size);
>         } else {
> -               error =3D security_inode_listsecurity(inode, list, size);
> -               if (size && error > size)
> -                       error =3D -ERANGE;
> +               char *buffer =3D list;
> +               ssize_t len =3D 0;
> +
> +               error =3D security_inode_listsecurity(inode, &buffer, &le=
n);

Also wrong.

> +               if (!error)
> +                       error =3D len;
>         }
>         return error;
>  }
> @@ -1469,17 +1472,10 @@ ssize_t simple_xattr_list(struct inode *inode, st=
ruct simple_xattrs *xattrs,
>         if (err)
>                 return err;
>
> -       err =3D security_inode_listsecurity(inode, buffer, remaining_size=
);
> -       if (err < 0)
> +       err =3D security_inode_listsecurity(inode, &buffer, &remaining_si=
ze);
> +       if (err)
>                 return err;
>
> -       if (buffer) {
> -               if (remaining_size < err)
> -                       return -ERANGE;
> -               buffer +=3D err;
> -       }
> -       remaining_size -=3D err;
> -
>         read_lock(&xattrs->lock);
>         for (rbp =3D rb_first(&xattrs->rb_root); rbp; rbp =3D rb_next(rbp=
)) {
>                 xattr =3D rb_entry(rbp, struct simple_xattr, rb_node);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index bf3bbac4e02a..3c3919dcdebc 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -174,8 +174,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct =
mnt_idmap *idmap,
>          struct inode *inode, const char *name, void **buffer, bool alloc=
)
>  LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
>          const char *name, const void *value, size_t size, int flags)
> -LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
> -        size_t buffer_size)
> +LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char **buffer,
> +        ssize_t *remaining_size)
>  LSM_HOOK(void, LSM_RET_VOID, inode_getlsmprop, struct inode *inode,
>          struct lsm_prop *prop)
>  LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cc9b54d95d22..0efc6a0ab56d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -457,7 +457,7 @@ int security_inode_getsecurity(struct mnt_idmap *idma=
p,
>                                struct inode *inode, const char *name,
>                                void **buffer, bool alloc);
>  int security_inode_setsecurity(struct inode *inode, const char *name, co=
nst void *value, size_t size, int flags);
> -int security_inode_listsecurity(struct inode *inode, char *buffer, size_=
t buffer_size);
> +int security_inode_listsecurity(struct inode *inode, char **buffer, ssiz=
e_t *remaining_size);
>  void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *pro=
p);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(struct dentry *src, const char *name);
> @@ -1077,7 +1077,8 @@ static inline int security_inode_setsecurity(struct=
 inode *inode, const char *na
>         return -EOPNOTSUPP;
>  }
>
> -static inline int security_inode_listsecurity(struct inode *inode, char =
*buffer, size_t buffer_size)
> +static inline int security_inode_listsecurity(struct inode *inode,
> +                                       char **buffer, ssize_t *remaining=
_size)
>  {
>         return 0;
>  }
> diff --git a/net/socket.c b/net/socket.c
> index 9a0e720f0859..52e3670dc89b 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -562,15 +562,9 @@ static ssize_t sockfs_listxattr(struct dentry *dentr=
y, char *buffer,
>         ssize_t len;
>         ssize_t used =3D 0;
>
> -       len =3D security_inode_listsecurity(d_inode(dentry), buffer, size=
);
> +       len =3D security_inode_listsecurity(d_inode(dentry), &buffer, &us=
ed);

And likewise wrong.

>         if (len < 0)
>                 return len;
> -       used +=3D len;
> -       if (buffer) {
> -               if (size < used)
> -                       return -ERANGE;
> -               buffer +=3D len;
> -       }
>
>         len =3D (XATTR_NAME_SOCKPROTONAME_LEN + 1);
>         used +=3D len;
> diff --git a/security/security.c b/security/security.c
> index fb57e8fddd91..3985d040d5a9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2710,22 +2710,22 @@ int security_inode_setsecurity(struct inode *inod=
e, const char *name,
>  /**
>   * security_inode_listsecurity() - List the xattr security label names
>   * @inode: inode
> - * @buffer: buffer
> - * @buffer_size: size of buffer
> + * @buffer: pointer to buffer
> + * @remaining_size: pointer to remaining size of buffer
>   *
>   * Copy the extended attribute names for the security labels associated =
with
> - * @inode into @buffer.  The maximum size of @buffer is specified by
> - * @buffer_size.  @buffer may be NULL to request the size of the buffer
> - * required.
> + * @inode into *(@buffer).  The remaining size of @buffer is specified b=
y
> + * *(@remaining_size).  *(@buffer) may be NULL to request the size of th=
e
> + * buffer required. Updates *(@buffer) and *(@remaining_size).
>   *
> - * Return: Returns number of bytes used/required on success.
> + * Return: Returns 0 on success, or -errno on failure.
>   */
>  int security_inode_listsecurity(struct inode *inode,
> -                               char *buffer, size_t buffer_size)
> +                               char **buffer, ssize_t *remaining_size)
>  {
>         if (unlikely(IS_PRIVATE(inode)))
>                 return 0;
> -       return call_int_hook(inode_listsecurity, inode, buffer, buffer_si=
ze);
> +       return call_int_hook(inode_listsecurity, inode, buffer, remaining=
_size);
>  }
>  EXPORT_SYMBOL(security_inode_listsecurity);
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8115df536ab..e6c98ebbf7bc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3612,16 +3612,12 @@ static int selinux_inode_setsecurity(struct inode=
 *inode, const char *name,
>         return 0;
>  }
>
> -static int selinux_inode_listsecurity(struct inode *inode, char *buffer,=
 size_t buffer_size)
> +static int selinux_inode_listsecurity(struct inode *inode, char **buffer=
,
> +                               ssize_t *remaining_size)
>  {
> -       const int len =3D sizeof(XATTR_NAME_SELINUX);
> -
>         if (!selinux_initialized())
>                 return 0;
> -
> -       if (buffer && len <=3D buffer_size)
> -               memcpy(buffer, XATTR_NAME_SELINUX, len);
> -       return len;
> +       return xattr_list_one(buffer, remaining_size, XATTR_NAME_SELINUX)=
;
>  }
>
>  static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_pro=
p *prop)
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 99833168604e..3f7ac865532e 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1619,17 +1619,12 @@ static int smack_inode_getsecurity(struct mnt_idm=
ap *idmap,
>   * smack_inode_listsecurity - list the Smack attributes
>   * @inode: the object
>   * @buffer: where they go
> - * @buffer_size: size of buffer
> + * @remaining_size: size of buffer
>   */
> -static int smack_inode_listsecurity(struct inode *inode, char *buffer,
> -                                   size_t buffer_size)
> +static int smack_inode_listsecurity(struct inode *inode, char **buffer,
> +                                   ssize_t *remaining_size)
>  {
> -       int len =3D sizeof(XATTR_NAME_SMACK);
> -
> -       if (buffer !=3D NULL && len <=3D buffer_size)
> -               memcpy(buffer, XATTR_NAME_SMACK, len);
> -
> -       return len;
> +       return xattr_list_one(buffer, remaining_size, XATTR_NAME_SMACK);
>  }
>
>  /**
> --
> 2.49.0
>

