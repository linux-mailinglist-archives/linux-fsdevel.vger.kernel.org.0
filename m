Return-Path: <linux-fsdevel+bounces-57239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5961B1FAD2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 17:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5456A170FEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5967F2652B2;
	Sun, 10 Aug 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbD8hvdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29FA1C6FE5;
	Sun, 10 Aug 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840473; cv=none; b=GoYleGV2J5b59j3CNEh2fuxddDFADb1XFnIorlqLv1cwCzRvZ6DW1Di78YHz0x54uxujf1BA4CgiMfq2pFNADKau2jIXRVZ3ci/Iti3ONwae2e7e4xXl4sTJq5fvgAS7Cfjh8obxAGT1gszEXXQkc5w0qtmus6ngpUYQmCAj8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840473; c=relaxed/simple;
	bh=cd5Tgk8Mo6g7p+ZC2FNbBxHc2ZQwyzXQAqvzcRIiLw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYNaeteTHj4NGCXkoCFbvrCsuGGY4BU6tMYAC7PhKl7o03UYdckwwem3fy4vNBKF/sK7xZ5z1As+73i8F5Qaz4pbXuw4iYTSdnpf+lbzFIex4qkdgaPrd4ABIxXjTrDHc1MBS6OEqk9CwDxX+0kSD6N8hW3zmPV015a/nZsl4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbD8hvdM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso5599728a12.3;
        Sun, 10 Aug 2025 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754840470; x=1755445270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mejj4aPrlCi05329X0roMdHpCsqIV7FxwoEslb0IgQk=;
        b=DbD8hvdMsZ27syaZDk/ysiH2C/eHVzPIW+pgBq8sRWxUInKD7tGy84rgeKbFuh+naC
         tW9Xg3dXwmhWyuSV+f1EbqIyCVBshB0DWPaNYel+yWxhXSFgwjinQEkrPe4eb9FGTW80
         RMm529Zz1WICOITo06AL6vfHBT9l7llN9qD9nwLx/Kxi6VIgxj1MpNhdZz1B+Gkd5RyC
         MsYFa9ghtFhp7KRA/b7dqMLeuxKl4HWyCkJnb/4HaCyy7q2Qpd5oOHR0+VAPzJjIOoKz
         yjy/FIljabeTNdxyVcLAfRu/K2OVGapvblVCl88LCBLmQQUyZYHDKalbsTu/P4s1XB4n
         kYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754840470; x=1755445270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mejj4aPrlCi05329X0roMdHpCsqIV7FxwoEslb0IgQk=;
        b=HV2XqWqj10I1SvNm7f/9ADd04InvbN0kyIjSwDwzlv3f6pI55qXHXakic8tyGnI1vO
         Q/OTJbJ5H+g7pNBaliVGa+9J9kUGY2vxV8DOn6KV8Gpc3ediBHJaKD9IjaKGWTwcUjPs
         GCSYMhrY7ou1Hza+2wT2iWJd26ncp97wRLQ2kI/BNcjxJAmZChLeoJyov+LjcNG10yKW
         x7QwaPm9Nbgj4Jc9dvBvSP+1ONYPTHkuonQB0+v7hrXhuLiJCRjkbBcAMzpl8gav5iX/
         sUWe0EZLpG2ZUy7hESMB7swkzpZoVqt03/++DRpxqD3HiFlYmOWGoi4AxjGLhM694E0f
         f+9w==
X-Forwarded-Encrypted: i=1; AJvYcCUqkVtoMqLVCPSKQea4sBji099YI+n8M5n4ANGMzdA54B3VLn9XKF/edANvt2Zsa1pJnANkXPfq/w3MkR5b@vger.kernel.org, AJvYcCVcd7hic9FwbnKrs7mFPgfVCKFVwSDU/3x4ugIkHARsQ/M/Yh/yKP4qmwTzS8JuQm95bLqHffZr/6A+DVY1@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2OkQ+8pbRUQkmWvYIZ3mBPiVlnsidTu3t+AMaBzQxYzsoItY
	pUrv1cfX9B081kiA30YvR65iwKD4VHHIKJ2SW50PbTKdav9PhMPEL/R+hew0Qj5emRno9BdyNgm
	ePSAatS147fYQcMId1P8C+oaVQeIayY0=
X-Gm-Gg: ASbGnctUsM03Gdorr61lq1z10cyZRI9ua7j1xzqg2pV4M1SfGiX2D78AT/jNOljC3xa
	jtYC+CQwwlIIb3r7RDXP+JibF6Poczu7bpGX64Hgm10lc40j3Jd3jLkgrBPQimoJODMOK9wCfyM
	HEoSVHvyguP1ueSYTQfALvhy1njk0ZXdikWtI9OwOK6veeLviBZZQY6w5ewmnhHvYJDCQY2fQBr
	rg+KJg=
X-Google-Smtp-Source: AGHT+IF3lcmRKWDH/MYklRjPNK/zFnCs17T7JnfRQQbHe073iTnP9IsrMTCAfJgSYBiKgg14uv5jC/vBH4KjQ0K6Cq8=
X-Received: by 2002:a17:906:7954:b0:af9:5260:9ed6 with SMTP id
 a640c23a62f3a-af9c6342062mr958543466b.3.1754840470026; Sun, 10 Aug 2025
 08:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
 <20250804173228.1990317-1-paullawrence@google.com> <20250804173228.1990317-3-paullawrence@google.com>
In-Reply-To: <20250804173228.1990317-3-paullawrence@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 10 Aug 2025 17:40:58 +0200
X-Gm-Features: Ac12FXyNpAHINVcs1Y5kQVMGzum-nmkvpofAmReSnfn3w7z1p9EZFZ-hCgaeCGc
Message-ID: <CAOQ4uxjL6=__pg5RKjv+39M5BWKCpENwiNr5ZwCXeSXHHE=m1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Add passthrough for mkdir and rmdir (WIP)
To: Paul Lawrence <paullawrence@google.com>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 7:32=E2=80=AFPM Paul Lawrence <paullawrence@google.c=
om> wrote:
>
> As proof of concept of setting a backing file at lookup, implement mkdir
> and rmdir which work off the nodeid only and do not open the file.
>
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> ---
>  fs/fuse/dir.c             |  8 +++++++-
>  fs/fuse/fuse_i.h          | 11 +++++++++--
>  fs/fuse/passthrough.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fuse.h |  2 ++
>  4 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index c0bef93dd078..25d6929d600a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -129,7 +129,7 @@ void fuse_invalidate_attr(struct inode *inode)
>         fuse_invalidate_attr_mask(inode, STATX_BASIC_STATS);
>  }
>
> -static void fuse_dir_changed(struct inode *dir)
> +void fuse_dir_changed(struct inode *dir)
>  {
>         fuse_invalidate_attr(dir);
>         inode_maybe_inc_iversion(dir, false);
> @@ -951,6 +951,9 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *id=
map, struct inode *dir,
>         if (!fm->fc->dont_mask)
>                 mode &=3D ~current_umask();
>
> +       if (fuse_inode_passthrough_op(dir, FUSE_MKDIR))
> +               return fuse_passthrough_mkdir(idmap, dir, entry, mode);
> +
>         memset(&inarg, 0, sizeof(inarg));
>         inarg.mode =3D mode;
>         inarg.umask =3D current_umask();
> @@ -1058,6 +1061,9 @@ static int fuse_rmdir(struct inode *dir, struct den=
try *entry)
>         if (fuse_is_bad(dir))
>                 return -EIO;
>
> +       if (fuse_inode_passthrough_op(dir, FUSE_RMDIR))
> +               return fuse_passthrough_rmdir(dir, entry);
> +
>         args.opcode =3D FUSE_RMDIR;
>         args.nodeid =3D get_node_id(dir);
>         args.in_numargs =3D 2;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index aebd338751f1..d8df2d5a73ac 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1279,6 +1279,7 @@ void fuse_check_timeout(struct work_struct *work);
>  #define FUSE_STATX_MODSIZE     (FUSE_STATX_MODIFY | STATX_SIZE)
>
>  void fuse_invalidate_attr(struct inode *inode);
> +void fuse_dir_changed(struct inode *dir);
>  void fuse_invalidate_attr_mask(struct inode *inode, u32 mask);
>
>  void fuse_invalidate_entry_cache(struct dentry *entry);
> @@ -1521,7 +1522,8 @@ void fuse_file_release(struct inode *inode, struct =
fuse_file *ff,
>
>  /* Passthrough operations for directories */
>  #define FUSE_PASSTHROUGH_DIR_OPS \
> -       (FUSE_PASSTHROUGH_OP_READDIR)
> +       (FUSE_PASSTHROUGH_OP_READDIR | FUSE_PASSTHROUGH_OP_MKDIR | \
> +        FUSE_PASSTHROUGH_OP_RMDIR)
>
>  /* Inode passthrough operations for backing file attached to inode */
>  #define FUSE_PASSTHROUGH_INODE_OPS \
> @@ -1532,7 +1534,8 @@ void fuse_file_release(struct inode *inode, struct =
fuse_file *ff,
>         ((map)->ops_mask & FUSE_PASSTHROUGH_OP(op))
>
>  #define FUSE_BACKING_MAP_VALID_OPS \
> -       (FUSE_PASSTHROUGH_RW_OPS | FUSE_PASSTHROUGH_INODE_OPS)
> +       (FUSE_PASSTHROUGH_RW_OPS | FUSE_PASSTHROUGH_INODE_OPS |\
> +        FUSE_PASSTHROUGH_DIR_OPS)
>
>  static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode =
*fi)
>  {
> @@ -1626,6 +1629,10 @@ ssize_t fuse_passthrough_getxattr(struct inode *in=
ode, const char *name,
>                                   void *value, size_t size);
>  ssize_t fuse_passthrough_listxattr(struct dentry *entry, char *list,
>                                    size_t size);
> +struct dentry *fuse_passthrough_mkdir(struct mnt_idmap *idmap,
> +                                     struct inode *dir, struct dentry *e=
ntry,
> +                                     umode_t mode);
> +int fuse_passthrough_rmdir(struct inode *dir, struct dentry *entry);
>
>  #ifdef CONFIG_SYSCTL
>  extern int fuse_sysctl_register(void);
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index cee40e1c6e4a..acb06fbbd828 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -7,6 +7,7 @@
>
>  #include "fuse_i.h"
>
> +#include "linux/namei.h"
>  #include <linux/file.h>
>  #include <linux/backing-file.h>
>  #include <linux/splice.h>
> @@ -497,3 +498,40 @@ ssize_t fuse_passthrough_listxattr(struct dentry *en=
try, char *list,
>         revert_creds(old_cred);
>         return res;
>  }
> +
> +struct dentry *fuse_passthrough_mkdir(struct mnt_idmap *idmap,
> +                                     struct inode *dir, struct dentry *e=
ntry,
> +                                     umode_t mode)
> +{
> +       struct fuse_backing *fb =3D fuse_inode_backing(get_fuse_inode(dir=
));
> +       struct dentry *backing_entry, *new_entry;
> +       const struct cred *old_cred;
> +
> +       old_cred =3D override_creds(fb->cred);
> +       backing_entry =3D lookup_one_unlocked(idmap, &entry->d_name,
> +               fb->file->f_path.dentry);
> +       new_entry =3D vfs_mkdir(idmap, fb->file->f_inode, backing_entry, =
mode);

vfs_mkdir() needs to be called with inode_lock_nested(dir, I_MUTEX_PARENT)
held and you need to call lookup_one() (not _unlocked) under the same lock
and handle all the error cases properly.

idmap use is incorrect. need to use mnt_idmap(fb->file->f_path.mnt)

Same problems with rmdir.

Please look at existing stacked fs code like overalyfs and ecryptfs for
reference when implementing the passthrough inode operations.

> +       d_drop(entry);

I don't think this is a viable way to implement passthorugh mkdir or
any other creation op.

I think we need to instantiate the fuse inode from the created real
inode attributes.

Is the new created directory auto passthrough or not?

Should the server be notified on the new instantiated inode?

And what about mkdir in a directory which is not passthrough
but server wants to return the created new entry with backing_id?

So many questions are left unanswered in this RFC.

Paul,

I think I have asked for a design overview every time that I looked
at a version of fuse directory ops passthrough patches.

There is so much complexity in the design that needs to be sorted
out before starting with implementation.
I really don't see what you envision as the end goal.
Please post a design overview RFC in the cover letter
if you send another revision of the patches.

Thanks,
Amir.

