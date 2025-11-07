Return-Path: <linux-fsdevel+bounces-67474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD63C41963
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43D57350AF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CCE30CDAB;
	Fri,  7 Nov 2025 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5EGbW91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A274309EEC
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547359; cv=none; b=Hg2OX1RSHOd/nAHgEjlQApoWrtxuTirm77lUBlbLyTO8nuwxaR7M8TNZ2a8KpXxZu3U08EhCPI4eIRJ2hTqSX07EmzP5Mwu/gY43Ay99bdIGYbs8D6H+6fM3A+v0FsqQibs7Cagy3hmahCY9/Sw/jUWvClLp76poJbsLmflf478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547359; c=relaxed/simple;
	bh=xrNMcMljnkU4shizQu6E/3fnfyrJLUbYnYB9foY90B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMBC7oj0G2ALrnvH82xNaZageKq7761hzyrGH1g9oZ2sAyv/9330+KdcDGkzH0n3zzv5UAxJXcmF0YOF5+Ju49fVnMxXElZJ+ZGNTuyC4YXRpCTRaE4oOI1T85AYIcGQtvH4a8DHaMsfxC1AkCQmUOaVn9cYgbXtpbkNHwWnvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5EGbW91; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed69197d32so16411791cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 12:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762547355; x=1763152155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUU1NRMFjEAu/Jp6zbFkzbopK3BLE+djAoRc+VPripk=;
        b=c5EGbW913pg58PWfy7KAVBrAUazdPSXudmCIK0NB2rm1aWidFBoy5DtRpClRg9jNTT
         dVHu1OzWy+OOLMqMqiMZClZlGMa3SwDF3toIhcZNsIC8MjPtpbLPrkqgvy8i8IQQKVXx
         qgHp9IBbOYk8SwRA1ixuOHG6264kMF1wV2N+TNshW7ibxwgv0zOJgx0DDvENF8J1WHDL
         WUeQt3JaYkykozCUc9ioi6jFEIZTy7jh17uZEuxUwnTI9yJ6p6WKirNP2u+GSTNg9G80
         wMvUIvvTSUyP1+fmf93Bf/PWQJm3Xrev/kogoczl+t3rYRzGafpllCuh3i5JGU+gSVXu
         lvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762547355; x=1763152155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUU1NRMFjEAu/Jp6zbFkzbopK3BLE+djAoRc+VPripk=;
        b=eZ8trg6aCOSkO44v8rZ31486IH2RCudFtafDtW0R56i5EE3jt8V9ktKKeV9GmnGBB4
         TB8pxJ9FwT/clX3X64FkgMg+/DldWCNQY8z4cJ4E9RQuh9mOl3Y0kkO1pLLX3FF5MsQh
         bKfmudKOthA4utFbx/gObx7QM9v1ow1y3FUO9+iSh2sl7rI0P0mcfrWBFGZ6Z1Vx5VRQ
         dHgWZ2OrYVJ4tbIAm1BMWZeRsc9tT9Bq6tPHZYFzJvojDh063Ksse62an/O3pDcwecq5
         yEQRm0rWiwO8JlKF7CTFAymINCgJkKAsS70olwZKp6y1daTyRQI6I59IbpbxhKY0uzU+
         xaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW16ATV5wPmCF7b+PISkHtWBYRl9nwzvfxn95cfzb0kDDpLgKFWEcMTJNdPGZIzXqhGZ+Y8Kb4SdDewdXmg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9bAeetySP16Rh9tLH5535jgzdzPolHdIxPZ1zKmjhg5WMVEr
	r+hP4Cw/VHqFShdsGes62hkELWFI3RvESmHGs+g7rsoSjVMgcBD69m/6V9+iYhPZXqCHDm/JNUF
	vFeKfoY4nkgL0fMwzXnLVIj/T+UOdhWA=
X-Gm-Gg: ASbGncvrgcl3jvRHVTJmFBE3fPTxo0TArv6nMWxyurzFNDnkW9RuBFFqGKKM/860FLk
	eCvvCyxWLmlf6EuSvNXWdXPH3fxpjU0wxscjpk3gQmoTdfAYXqKTgOcQITixNVc1cdVvtXRoahr
	TIwG7aUWKMy99itwo1JC0Bloo63XqQXivkjm+z571mtCvauI7WPpPB0iELNLCjttrupZHekYruK
	AUjamwqZFTgoTi+FA23WiNxq8RL6xZBwOTaT3awwRAmQQNsaGcxpqmTVq0GE6eqeLuf1WGykncR
	61SMnBNJCJXvlb0zwBqlwPxY7EJu3T3+rLam
X-Google-Smtp-Source: AGHT+IHixkARPlTHHvCp/UKGr0JQOjtmSbXhYfVUl8tLacVauUj/Le+z4WvhwByMUHWQJ+gNyOVStCKnkQA7oyXy8h4=
X-Received: by 2002:a05:622a:389:b0:4e8:a1eb:3e2d with SMTP id
 d75a77b69052e-4eda4e733e4mr6276641cf.2.1762547355148; Fri, 07 Nov 2025
 12:29:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs> <176169809339.1424347.12261722424900811903.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809339.1424347.12261722424900811903.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 7 Nov 2025 12:29:04 -0800
X-Gm-Features: AWmQ_bmXVow5z-6eczbqjoGM2gOJ-0n5euhSkho1W4aXUrHDv--HLfbvcpvqMQc
Message-ID: <CAJnrk1apJbki7aZq2tNnnBcbkGKUmWDfmXVBD5YaMKUH2Fd-FA@mail.gmail.com>
Subject: Re: [PATCH 4/5] fuse: update file mode when updating acls
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:43=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> If someone sets ACLs on a file that can be expressed fully as Unix DAC
> mode bits, most local filesystems will then update the mode bits and
> drop the ACL xattr to reduce inefficiency in the file access paths.
> Let's do that too.  Note that means that we can setacl and end up with
> no ACL xattrs, so we also need to tolerate ENODATA returns from
> fuse_removexattr.
>
> Note that here we define a "local" fuse filesystem as one that uses
> fuseblk mode; we'll shortly add fuse servers that use iomap for the file
> IO path to that list.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    2 +-
>  fs/fuse/acl.c    |   43 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 8c47d103c8ffa6..d550937770e16e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1050,7 +1050,7 @@ static inline struct fuse_mount *get_fuse_mount(str=
uct inode *inode)
>         return get_fuse_mount_super(inode->i_sb);
>  }
>
> -static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> +static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
>  {
>         return get_fuse_mount_super(inode->i_sb)->fc;
>  }
> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index 8f484b105f13ab..72bb4c94079b7b 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c
> @@ -11,6 +11,18 @@
>  #include <linux/posix_acl.h>
>  #include <linux/posix_acl_xattr.h>
>
> +/*
> + * If this fuse server behaves like a local filesystem, we can implement=
 the
> + * kernel's optimizations for ACLs for local filesystems instead of pass=
ing
> + * the ACL requests straight through to another server.
> + */
> +static inline bool fuse_inode_has_local_acls(const struct inode *inode)
> +{
> +       const struct fuse_conn *fc =3D get_fuse_conn(inode);
> +
> +       return fc->posix_acl && fuse_inode_is_exclusive(inode);
> +}
> +
>  static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
>                                         struct inode *inode, int type, bo=
ol rcu)
>  {
> @@ -98,6 +110,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentr=
y *dentry,
>         struct inode *inode =3D d_inode(dentry);
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
>         const char *name;
> +       umode_t mode =3D inode->i_mode;
>         int ret;
>
>         if (fuse_is_bad(inode))
> @@ -113,6 +126,18 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>         else
>                 return -EINVAL;
>
> +       /*
> +        * If the ACL can be represented entirely with changes to the mod=
e
> +        * bits, then most filesystems will update the mode bits and dele=
te
> +        * the ACL xattr.
> +        */
> +       if (acl && type =3D=3D ACL_TYPE_ACCESS &&
> +           fuse_inode_has_local_acls(inode)) {
> +               ret =3D posix_acl_update_mode(idmap, inode, &mode, &acl);
> +               if (ret)
> +                       return ret;
> +       }

nit: this could be inside the if (acl) block below.

I'm not too familiar with ACLs so i'll abstain from adding my
Reviewed-by to this.

Thanks,
Joanne

> +
>         if (acl) {
>                 unsigned int extra_flags =3D 0;
>                 /*
> @@ -143,7 +168,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dent=
ry *dentry,
>                  * through POSIX ACLs. Such daemons don't expect setgid b=
its to
>                  * be stripped.
>                  */
> -               if (fc->posix_acl &&
> +               if (fc->posix_acl && mode =3D=3D inode->i_mode &&
>                     !in_group_or_capable(idmap, inode,
>                                          i_gid_into_vfsgid(idmap, inode))=
)
>                         extra_flags |=3D FUSE_SETXATTR_ACL_KILL_SGID;
> @@ -152,6 +177,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>                 kfree(value);
>         } else {
>                 ret =3D fuse_removexattr(inode, name);
> +               /* If the acl didn't exist to start with that's fine. */
> +               if (ret =3D=3D -ENODATA)
> +                       ret =3D 0;
> +       }
> +
> +       /* If we scheduled a mode update above, push that to userspace no=
w. */
> +       if (!ret) {
> +               struct iattr attr =3D { };
> +
> +               if (mode !=3D inode->i_mode) {
> +                       attr.ia_valid |=3D ATTR_MODE;
> +                       attr.ia_mode =3D mode;
> +               }
> +
> +               if (attr.ia_valid)
> +                       ret =3D fuse_do_setattr(idmap, dentry, &attr, NUL=
L);
>         }
>
>         if (fc->posix_acl) {
>

