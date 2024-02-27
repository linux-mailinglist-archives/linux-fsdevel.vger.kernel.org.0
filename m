Return-Path: <linux-fsdevel+bounces-12952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4F8691D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 14:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF72A1F23BF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76359145B07;
	Tue, 27 Feb 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqhMdDGw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B0145320;
	Tue, 27 Feb 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040514; cv=none; b=f4ja+QGoqSJj1lKCJzLieSsdgGR/diefmiTST77ICljb7gMlD9dv1ro2CqfR9FmaswTneEVqXimVbEJUqMVhDCW8W37qjUjND1gqnhlV4KCe8fZGBj3nAM711qHG96/NG2DJLaT0k8QTuGnk5Di4QEG6StQwsg8HihJfAi3jyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040514; c=relaxed/simple;
	bh=zru7ObNNKkQqccBKGdjO4JlNuuwVy5ujT0QSm0dUZfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOTITVbzkRWM3JQgmlgPldnVEEqlW3XUqz956DbjDsn2K91/Hyr0lmKWRTwM6KMJ7+l1gGdjoHt2b+jdZsldaqyrAWtND9+md0qh4yAF5SUBVDOVROxXF0AplSNTecDvN3Xe3szJrLZOlxUgob9fPJuDQc3hq0OCb6fT1pyxUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqhMdDGw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42e7e8e7c09so5959381cf.1;
        Tue, 27 Feb 2024 05:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040510; x=1709645310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sA3eGpdy0V1trjnCYXdrUG6FXIcsye2wJjLbDY0NJk8=;
        b=XqhMdDGwh8qeJuw5TKIfabet8iRADsTgCEWViON/4WPjJbZDOe8h/NDobRN1wZQdUq
         +Y7p795dCNDcwH7f0F20HHz9SmOcJPcGiloAaUqbZ2Hxp8nambdOSG3nCaaXGEZETwrB
         BzZr73CjF1LEqHiPG8Il17bfLxzO3Ab9D9YM5wGOHoa3AX3fLtdzwbjbCrYpqZhGVzU1
         DeZRwm///ooTMDHZC8/LI4r6GRatsfmrie38CBmHmdEz2L4LyCg1RY29L4DsJsInepgZ
         oZ+wPmdceobvJjfwxcWJCwWPM9e/fQdJZ034prVwjvLq0i+o3QoNI4+W8x/V5WrkwSnm
         3Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040510; x=1709645310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA3eGpdy0V1trjnCYXdrUG6FXIcsye2wJjLbDY0NJk8=;
        b=Me92wfj+UPknIJtr4k6NmfkLZg/ELobuXnDuSoukYFoAqNVfNDAyseKByNVAKKBgip
         mNEmRZH35KO8zrkEQHaIlnET+LCV9rcV3jsMy7+ubMGD6MWuKzz1kXUU0fmTj/sa+HMm
         Sp3klKAhqd7CSLGqLhAZYlcYwh101oD2//oNZyKKvkkBIF6A6sAHDIpuXbI6gtPkFtNf
         VYexkoiuTxQ1aoJ63GWhPKJe65BH6S4pmuowP9M9Dk9iXuFVqxD6UmvUx5GlLntpcfX7
         ichoRmn9881T+/1XcWXDvELjxJYl9MeO5MUDvns09EAbEQPc05DW5nTY7QDpj2kb87jq
         aSsA==
X-Forwarded-Encrypted: i=1; AJvYcCXZXq/A7TYlBqpY2xdTxBE4F8CeMR22DaT/5m+y2blYiFoNwfSGKTeF9kkG2NTKJXQyme+7jm3pEpA/OS7kA2aivu/stKthYxT0G5qbRKFOkJBAXU42xWa0JcLHe628ta+/0jYl7/Zw4fQXOxfOrRMrQ6HOj/rfCdX2VDbrukacNQN/Q9lYkUeJF4Y5NgqTAUqTnDLHQDvZj0UDEIOkiGaLd2ouYu0ZaURUB/zu4REdSZntts+Crfr0Adb4Z8BfbdnL++teniDceORYkm9l+Z8E8PupZ90J4MZE68EoSZfJn5KgNttFfoLeU5MNcmq0zLf8sNlar5DD89zZSsw0OVVqKGqolTk1zxqXr32aPeTQ1P3vR9WrfA6i7o9cF8U=
X-Gm-Message-State: AOJu0YwNr0XY4GJw0tMeZryvjZ2m5kGzO8U7ILUDtcAfI8IxU31VehxK
	oVCTEUIBBmePyHxVO95rML3jOno09dMe0rTlq9tGGYs66ybiXjmezP1VV9j8KlR+PaYbSDSH34e
	kiI1JSQ1q8zfD2MiEtFCHLWILWx0=
X-Google-Smtp-Source: AGHT+IHd1fYGCovL5jMrwGyPD3t9BUZlBl4i58kM3c7T6/2cjncdv2UjHD2jwvbN+FNdJ7hm/vJBg7tdpkEc9efldco=
X-Received: by 2002:ac8:5bd2:0:b0:42e:8a6b:5d00 with SMTP id
 b18-20020ac85bd2000000b0042e8a6b5d00mr4856001qtb.26.1709040510180; Tue, 27
 Feb 2024 05:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org> <20240221-idmap-fscap-refactor-v2-20-3039364623bd@kernel.org>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-20-3039364623bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Feb 2024 15:28:18 +0200
Message-ID: <CAOQ4uxjvrFuz2iCiO9dsOnear+qN=M+GFW-eEOZU5uCzBkTwLQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/25] ovl: add fscaps handlers
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:25=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
>
> Add handlers which read fs caps from the lower or upper filesystem and
> write/remove fs caps to the upper filesystem, performing copy-up as
> necessary.
>
> While fscaps only really make sense on regular files, the general policy
> is to allow most xattr namespaces on all different inode types, so
> fscaps handlers are installed in the inode operations for all types of
> inodes.
>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  fs/overlayfs/dir.c       |  2 ++
>  fs/overlayfs/inode.c     | 72 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/overlayfs/overlayfs.h |  5 ++++
>  3 files changed, 79 insertions(+)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 0f8b4a719237..4ff360fe10c9 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1307,6 +1307,8 @@ const struct inode_operations ovl_dir_inode_operati=
ons =3D {
>         .get_inode_acl  =3D ovl_get_inode_acl,
>         .get_acl        =3D ovl_get_acl,
>         .set_acl        =3D ovl_set_acl,
> +       .get_fscaps     =3D ovl_get_fscaps,
> +       .set_fscaps     =3D ovl_set_fscaps,
>         .update_time    =3D ovl_update_time,
>         .fileattr_get   =3D ovl_fileattr_get,
>         .fileattr_set   =3D ovl_fileattr_set,
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index c63b31a460be..7a8978ea6fe1 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -568,6 +568,72 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dent=
ry *dentry,
>  }
>  #endif
>
> +int ovl_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +                  struct vfs_caps *caps)
> +{
> +       int err;
> +       const struct cred *old_cred;
> +       struct path realpath;
> +
> +       ovl_path_real(dentry, &realpath);
> +       old_cred =3D ovl_override_creds(dentry->d_sb);
> +       err =3D vfs_get_fscaps(mnt_idmap(realpath.mnt), realpath.dentry, =
caps);
> +       revert_creds(old_cred);
> +       return err;
> +}
> +
> +int ovl_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +                  const struct vfs_caps *caps, int setxattr_flags)
> +{
> +       int err;
> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> +       struct dentry *upperdentry =3D ovl_dentry_upper(dentry);
> +       struct dentry *realdentry =3D upperdentry ?: ovl_dentry_lower(den=
try);
> +       const struct cred *old_cred;
> +
> +       /*
> +        * If the fscaps are to be remove from a lower file, check that t=
hey
> +        * exist before copying up.
> +        */

Don't you need to convert -ENODATA to 0 return value in this case?

> +       if (!caps && !upperdentry) {
> +               struct path realpath;
> +               struct vfs_caps lower_caps;
> +
> +               ovl_path_lower(dentry, &realpath);
> +               old_cred =3D ovl_override_creds(dentry->d_sb);
> +               err =3D vfs_get_fscaps(mnt_idmap(realpath.mnt), realdentr=
y,
> +                                    &lower_caps);
> +               revert_creds(old_cred);
> +               if (err)
> +                       goto out;
> +       }
> +
> +       err =3D ovl_want_write(dentry);
> +       if (err)
> +               goto out;
> +

ovl_want_write() should after ovl_copy_up(), see:
162d06444070 ("ovl: reorder ovl_want_write() after ovl_inode_lock()")


> +       err =3D ovl_copy_up(dentry);
> +       if (err)
> +               goto out_drop_write;
> +       upperdentry =3D ovl_dentry_upper(dentry);
> +
> +       old_cred =3D ovl_override_creds(dentry->d_sb);
> +       if (!caps)
> +               err =3D vfs_remove_fscaps(ovl_upper_mnt_idmap(ofs), upper=
dentry);
> +       else
> +               err =3D vfs_set_fscaps(ovl_upper_mnt_idmap(ofs), upperden=
try,
> +                                    caps, setxattr_flags);
> +       revert_creds(old_cred);
> +
> +       /* copy c/mtime */
> +       ovl_copyattr(d_inode(dentry));
> +
> +out_drop_write:
> +       ovl_drop_write(dentry);
> +out:
> +       return err;
> +}
> +
>  int ovl_update_time(struct inode *inode, int flags)
>  {
>         if (flags & S_ATIME) {
> @@ -747,6 +813,8 @@ static const struct inode_operations ovl_file_inode_o=
perations =3D {
>         .get_inode_acl  =3D ovl_get_inode_acl,
>         .get_acl        =3D ovl_get_acl,
>         .set_acl        =3D ovl_set_acl,
> +       .get_fscaps     =3D ovl_get_fscaps,
> +       .set_fscaps     =3D ovl_set_fscaps,
>         .update_time    =3D ovl_update_time,
>         .fiemap         =3D ovl_fiemap,
>         .fileattr_get   =3D ovl_fileattr_get,
> @@ -758,6 +826,8 @@ static const struct inode_operations ovl_symlink_inod=
e_operations =3D {
>         .get_link       =3D ovl_get_link,
>         .getattr        =3D ovl_getattr,
>         .listxattr      =3D ovl_listxattr,
> +       .get_fscaps     =3D ovl_get_fscaps,
> +       .set_fscaps     =3D ovl_set_fscaps,
>         .update_time    =3D ovl_update_time,
>  };
>
> @@ -769,6 +839,8 @@ static const struct inode_operations ovl_special_inod=
e_operations =3D {
>         .get_inode_acl  =3D ovl_get_inode_acl,
>         .get_acl        =3D ovl_get_acl,
>         .set_acl        =3D ovl_set_acl,
> +       .get_fscaps     =3D ovl_get_fscaps,
> +       .set_fscaps     =3D ovl_set_fscaps,
>         .update_time    =3D ovl_update_time,
>  };
>


Sorry, I did not understand the explanation why fscaps ops are needed
for non regular files. It does not look right to me.

Thanks,
Amir.

