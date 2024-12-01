Return-Path: <linux-fsdevel+bounces-36197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D49DF575
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C1BB20E4B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52415821A;
	Sun,  1 Dec 2024 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ5gzYFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581115572C;
	Sun,  1 Dec 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733054973; cv=none; b=o6ngCmNApd4VgXdrBoZ4J5llF2pJRPQD0WcZaWyg83bMySmbn6sSqaLsVvE3CSMBm9FXfPtk8tCcxAdNnrT7ORcYWcy7qLMnvhAiaE9JAYf57yG/273qneqsA3bFPkmIi8B8xM5hsJLFvvlDt8Sc/FOrM95ao2UYF6es+CwbFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733054973; c=relaxed/simple;
	bh=wJnH5lnF9226a8d14bSDCAFrN1Rpjd6Z4RXZytlFhss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM5iFU0/sQSodEjzLdm7dSm0h/6Nm041D9YM8z2Tih3epbZGJLsXkCDjLt2G5RE51x1nzb6b4Fj6hYsuboCA20iw/19+XTmJyvhBIg4muNoYL0Ubr/0v42pHw0znjkEWiT5C54ZwxrsPiPGvI9NPDDeKUDIfBoX0SWkwDkxwzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ5gzYFU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e1f12c82so1542295f8f.2;
        Sun, 01 Dec 2024 04:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733054969; x=1733659769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFJMNCCjPlSbyTOXrpT0Z4rsWK1ZWqK+KCtJoJ/N1cs=;
        b=HJ5gzYFU6bW+PfPHjPUNU3jvqMeLo+t20/mzs2KXn3ZauOmAYYo00nBrnsooZYYcSi
         m/hJ8mKjCHlQSXAMHxqqw+qW5gWPJub0TaCQYzU5GylE8VSTO+mI1vLF66mTHlD0elrS
         1FiLUSzS+e0sV25vgdXCfZB820zIDU89sk0bseWcKsidkKz3bqfcSJiQleb9Gg0MieAo
         e60d4b3HHw3xyiqlOo3TideUZzGnRZgAokWJpd0CzWBhjQSb31eDHv97A0I3NxMmQIov
         r9s53dHgSHBu7jaPxZLGtBZ5QnIEBB8yI8x8Ki2zZaDqxtesvHRPTxpzndNPNWd5p9Df
         fl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733054969; x=1733659769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFJMNCCjPlSbyTOXrpT0Z4rsWK1ZWqK+KCtJoJ/N1cs=;
        b=c9B3WyOTcVI1fAO+1bbHtzWxF4BnYZk2WDj28u+GqIW6W1TVxsn/mv5BzZSvTiewt0
         6Esbnb9yImb3pwrQkYICvYrMWRPux5mEei3RmMgR1thPJFgjrMtIIls03qk5KhwEfr4J
         qqYiCd5EULleBoX90SMHa2ujel1PD0JIXhfimGwcmpOOXSA4+qi0K1WHIr1umyRSIYZU
         Pwc3z9VQ+lMxS3eAMF2ut9Sg5Y2Rgi6xijVMlneuoYsXvd6lphLPoiuVIlYOq1PJeu2/
         EG9291AScIt2prsl/KGS5A04LrbXKwO7hLfiTKEoxUbciZZmZjPcgRZbPymDBbLCOp+e
         45Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUGSp0k3VRPZ53CspbgKrHBZLaUiSthq77kFdxJRlcj1XO0v4I20QYYaSm+9XefAuZ03jEU5QvmDKUN@vger.kernel.org, AJvYcCUHUUtZ1/RcmuTQsSK3bj6FEeA8vZjHmvQMgTzC41YOGma/ZHs+iqHnx1Qp1nhGQ+gGbsGpX6ltbdGl7Iq9@vger.kernel.org, AJvYcCWe47LmSmGMrQOEOZIJr36nJJEeBZuUCRzYrgEcU9tqmOb8g+ERXyH7JleWLLlEAlYX6xJ+/XBpsSDQLIK0@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPsFVtVaYRQgaSIBx2BYAAnLtWAxC/U/LR+zvtMZfJfvI8lNP
	CoQDp7NYhUuxGpLmKeQMQu79ahFC0ayPEpMmiHKKMF/k24Yg1hUMh7lhTOQL8ZH7rcFIIyXiYWr
	Jkb0Tgb9Yhnq9ias7VzRuXDilbwddc5N+Euc=
X-Gm-Gg: ASbGncuqNfLa/K7xIVni8iWbmTfhxObTvxAiopgTimem376UyPRWJOM+w6JxdsYlXaw
	cMMtMbrJGfGi2vIAPN7j475fL3yZSVgc=
X-Google-Smtp-Source: AGHT+IEUQugGfv/drUdFvQDe4YPxJEvQ/l+1PGq/yv7o88jyFCYbP+LdhTNkqesJsJ7MXhkMWwoamMrOjedTQXk/qAg=
X-Received: by 2002:a5d:59af:0:b0:37d:4833:38f5 with SMTP id
 ffacd0b85a97d-385c6ebb8c7mr17872578f8f.30.1733054969085; Sun, 01 Dec 2024
 04:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
 <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
 <CAOQ4uxhKVkaWm_Vv=0zsytmvT0jCq1pZ84dmrQ_buhxXi2KEhw@mail.gmail.com> <20241130-witzbold-beiwagen-9b14358b7b17@brauner>
In-Reply-To: <20241130-witzbold-beiwagen-9b14358b7b17@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Dec 2024 13:09:17 +0100
Message-ID: <CAOQ4uxh2yfa_OeUYgrxc6nZqyZF4edx3pswPJkHPh5x=KOzj8w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] pidfs: implement file handle support
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 9:43=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sat, Nov 30, 2024 at 01:22:05PM +0100, Amir Goldstein wrote:
> > On Fri, Nov 29, 2024 at 2:39=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > Hey,
> > >
> > > Now that we have the preliminaries to lookup struct pid based on its
> > > inode number alone we can implement file handle support.
> > >
> > > This is based on custom export operation methods which allows pidfs t=
o
> > > implement permission checking and opening of pidfs file handles clean=
ly
> > > without hacking around in the core file handle code too much.
> > >
> > > This is lightly tested.
> >
> > With my comments addressed as you pushed to vfs-6.14.pidfs branch
> > in your tree, you may add to the patches posted:
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > HOWEVER,
> > IMO there is still one thing that has to be addressed before merge -
> > We must make sure that nfsd cannot export pidfs.
> >
> > In principal, SB_NOUSER filesystems should not be accessible to
> > userspace paths, so exportfs should not be able to configure nfsd
> > export of pidfs, but maybe this limitation can be worked around by
> > using magic link paths?
>
> I don't see how. I might be missing details.

AFAIK, nfsd gets the paths to export from userspace via
svc_export_parse() =3D>  kern_path(buf, 0, &exp.ex_path)
afterwards check_export() validates exp.ex_path and I see that regular
files can be exported.
I suppose that a pidfs file can have a magic link path no?
The question is whether this magic link path could be passed to nfsd
via the exportfs UAPI.

>
> > I think it may be worth explicitly disallowing nfsd export of SB_NOUSER
> > filesystems and we could also consider blocking SB_KERNMOUNT,
> > but may there are users exporting ramfs?
>
> No need to restrict it if it's safe, I guess.
>
> > Jeff has mentioned that he thinks we are blocking export of cgroupfs
> > by nfsd, but I really don't see where that is being enforced.
> > The requirement for FS_REQUIRES_DEV in check_export() is weak
> > because user can overrule it with manual fsid argument to exportfs.
> > So maybe we disallow nfsd export of kernfs and backport to stable kerne=
ls
> > to be on the safe side?
>
> File handles and nfs export have become two distinct things and there
> filesystems based on kernfs, and pidfs want to support file handles
> without support nfs export.
>
> So I think instead of having nfs check what filesystems may be exported
> we should let the filesystems indicate that they cannot be exported and
> make nfs honour that.

Yes, I agree, but...

>
> So something like the untested sketch:
>
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index 1358c21837f1..a5c75cb1c812 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -154,6 +154,7 @@ static const struct export_operations kernfs_export_o=
ps =3D {
>         .fh_to_dentry   =3D kernfs_fh_to_dentry,
>         .fh_to_parent   =3D kernfs_fh_to_parent,
>         .get_parent     =3D kernfs_get_parent_dentry,
> +       .flags          =3D EXPORT_OP_FILE_HANDLE,
>  };
>
>  /**
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index eacafe46e3b6..170c5729e7f2 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -417,6 +417,7 @@ static struct svc_export *svc_export_lookup(struct sv=
c_export *);
>  static int check_export(struct path *path, int *flags, unsigned char *uu=
id)
>  {
>         struct inode *inode =3D d_inode(path->dentry);
> +       const struct export_operations *nop;
>
>         /*
>          * We currently export only dirs, regular files, and (for v4
> @@ -449,11 +450,16 @@ static int check_export(struct path *path, int *fla=
gs, unsigned char *uuid)
>                 return -EINVAL;
>         }
>
> -       if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> +       if (!exportfs_can_decode_fh(nop)) {
>                 dprintk("exp_export: export of invalid fs type.\n");
>                 return -EINVAL;
>         }
>
> +       if (nop && nop->flags & EXPORT_OP_FILE_HANDLE) {
> +               dprintk("exp_export: filesystem only supports non-exporta=
ble file handles.\n");
> +               return -EINVAL;
> +       }
> +
>         if (is_idmapped_mnt(path->mnt)) {
>                 dprintk("exp_export: export of idmapped mounts not yet su=
pported.\n");
>                 return -EINVAL;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 9aa7493b1e10..d1646c0789e1 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -83,10 +83,15 @@ void ovl_revert_creds(const struct cred *old_cred)
>   */
>  int ovl_can_decode_fh(struct super_block *sb)
>  {
> +       const struct export_operations *nop =3D sb->s_export_op;
> +
>         if (!capable(CAP_DAC_READ_SEARCH))
>                 return 0;
>
> -       if (!exportfs_can_decode_fh(sb->s_export_op))
> +       if (!exportfs_can_decode_fh(nop))
> +               return 0;
> +
> +       if (nop && nop->flags & EXPORT_OP_FILE_HANDLE)
>                 return 0;
>
>         return sb->s_export_op->encode_fh ? -1 : FILEID_INO32_GEN;
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index dde3e4e90ea9..9d98b5461dc7 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -570,6 +570,7 @@ static const struct export_operations pidfs_export_op=
erations =3D {
>         .fh_to_dentry   =3D pidfs_fh_to_dentry,
>         .open           =3D pidfs_export_open,
>         .permission     =3D pidfs_export_permission,
> +       .flags          =3D EXPORT_OP_FILE_HANDLE,
>  };
>
>  static int pidfs_init_inode(struct inode *inode, void *data)
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index a087606ace19..98f7cb17abee 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -280,6 +280,7 @@ struct export_operations {
>                                                 */
>  #define EXPORT_OP_FLUSH_ON_CLOSE       (0x20) /* fs flushes file data on=
 close */
>  #define EXPORT_OP_ASYNC_LOCK           (0x40) /* fs can do async lock re=
quest */
> +#define EXPORT_OP_FILE_HANDLE          (0x80) /* fs only supports file h=
andles, no proper export */

This is a bad name IMO, since pidfs clearly does support file handles
and supports the open_by_handle_at() UAPI.

I was going to suggest EXPORT_OP_NO_NFS_EXPORT, but it also
sounds silly, so maybe:

#define EXPORT_OP_LOCAL_FILE_HANDLE          (0x80) /* fs only
supports local file handles, no nfs export */

With that you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

