Return-Path: <linux-fsdevel+bounces-41802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E5A3776E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 21:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A8C1891284
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07E1A238D;
	Sun, 16 Feb 2025 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUzi0kl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56681442E8;
	Sun, 16 Feb 2025 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739737303; cv=none; b=gqCfdHA0KPeYXhL1R5UPChtjPNXZtp0LzM2l22dlcMEJxD/P3GEvZVdctwGAIsBNZEA/1UH3TK2yU4kbu5LrVouHM95BMAWQ4HgtESu+LAskqLeiLKZGKIjtb7T8En0csS1LiT/qGy8Sb8/m0yPHj4ZSR42JS7Tz1GU6NKoEOOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739737303; c=relaxed/simple;
	bh=LfNDI1P1KowU5C5OqLLo70LwPQufsQrlW4d2uOkCci4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxexfhJ6U0FrxNEurtb2m64cKoTznzvMKDsaG6t5WUyX586EKm9VHCrVHfw3bZvWuXbkP0Oc0LcwvR3msXzSXHIg/k8mDrpijK+bkMUvASRBDAS/fzY9HNY07er5OmBeTBbGpp5CXz7ktPt1dyUaXqq7a0Q61p5t+qJx6OqgfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUzi0kl7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7f539c35so230162566b.1;
        Sun, 16 Feb 2025 12:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739737299; x=1740342099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWbr3zFJD8Ro2h91kFhVjBQgjVkeJCC/8pEY/8TNXog=;
        b=GUzi0kl7RAwEgbhNpU5BaPJNl41/3ZdfAU9elHZ2bb2eyrxdf55QRpUEe7Njm4r8bJ
         tkY2YeHiQ4HreotYtwC351q9SMbUVtxlI+JYNT+/K1dTx79nEbG221XAXXw+M/fiNi07
         FGwykkV8w2NFaXw7nW9ky/tzrB8MJH+Id5E86r9glT5ilIfWDciAjIf7E8ZC2eMF64UO
         pRvjVRgtiMWOkV3jAWuFd/hq0/1HnCOZJNReUfZh6nuJIi42NJf/e430o88wi9+J1nSd
         k9yjPO/HL/weCH/02RLfeeLhiEnCzdtbLndgfeqG+jvLcF4e2kfHpGec8yX+6ql/FGQJ
         gV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739737299; x=1740342099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWbr3zFJD8Ro2h91kFhVjBQgjVkeJCC/8pEY/8TNXog=;
        b=GGe/PctQVoNrtaE/3gF2KdC7Q0Q2pRPm26+kb017MGgQ5SYOVymRE//mI6il/xIRGq
         WEQWiJ6bcZw/PWU4KG6ZqJi/khnWy61TSO9IAW08nCTrzdmkkAqwv6rT8NxdENKOwy5D
         ozJdPKyqHoatPgGSSIxgS19aUZxTVJKzOzyWQDM3w2BTkD6AR6TbzsDor5gDjMb8PYGm
         KCZSeSVDWu7YkUxJDiE+BAim+n28nJf/6X5iTISC/2cmzz/Z0h6jTlXQz9nZF+xBg/AI
         GGS1cISV8AVKdOmEmZRiT2VAND721aaySVCXimEV5gZG6SItgfm5ZFbExRMEM4qfyH++
         EeaA==
X-Forwarded-Encrypted: i=1; AJvYcCU949dEXl6t+ZyBe30OpTJbD7a2PTTMJwEOGQ4nknt231aeaH02yxpc9mpnK1GbKC1z+3VHZnGJJab0@vger.kernel.org, AJvYcCUh8J6tsh+48k+AiJazV2wbOkzp3iuuSQo5d3qKe9VNdzXU33gezxD4ANlOJR6RpWMVCICXXFsUUs7fnvkTiQ==@vger.kernel.org, AJvYcCV8x+3zwQ9bdJ21xzhKxbMy8JEUQxSfR5oRInApHnQQJidCiZWBJlPRe70DSPSlTsomQ+5KoH+PxfnI5s1r@vger.kernel.org
X-Gm-Message-State: AOJu0YwouD8468PbOWY7WKVqu8gGFmDfzmAaLw2V9kGDthgQeWBYbk/H
	ENtCwzMoBLY6GXrxfvTfOkc0yYMr2itST7yhudlVhjnHnZii7JUy2bxypTH9w3ps3purxYhxyc1
	fhtwc3dr4fxqQz+CS9GVbX/21P44=
X-Gm-Gg: ASbGncuECQWpVxiHjmoK/hnVexNTVhfuyq6yfdBjlG0BrbnJyepWz80gsHOpgyO38zM
	+BnmZWJpmVfE3WpS4ciiLJZp5ceHpKqcpW3CdJIDEKns7QfyMlpTFmjBJtFZlTTowYBPSPtJm
X-Google-Smtp-Source: AGHT+IHqyAJ9weaIOD6EdJyyd0PnL1RhkL5NcQPoctNFIOQpOl2snDZj3y5vPscLW1KzrVf5mWF1etq7+PwsWzj1f8M=
X-Received: by 2002:a17:906:4786:b0:aa6:9503:aa73 with SMTP id
 a640c23a62f3a-abb70df5273mr646869166b.51.1739737298505; Sun, 16 Feb 2025
 12:21:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216164029.20673-1-pali@kernel.org> <20250216164029.20673-5-pali@kernel.org>
In-Reply-To: <20250216164029.20673-5-pali@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 16 Feb 2025 21:21:27 +0100
X-Gm-Features: AWEUYZlooaU13fSnXqioMBRNB0K9fo1GIEDERMnyZjMMpzMJ3uOEWe-ci0RV4LA
Message-ID: <CAOQ4uxg+DnrOPcGpgS3fO7t8BgabQGdfaCY9t2mMzTD7Ek+wEg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] cifs: Implement FS_IOC_FS[GS]ETXATTR API for
 Windows attributes
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 5:42=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>

No empty commit message please

> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  fs/smb/client/cifsfs.c    |   4 +
>  fs/smb/client/cifsfs.h    |   2 +
>  fs/smb/client/cifsglob.h  |   4 +-
>  fs/smb/client/cifsproto.h |   2 +-
>  fs/smb/client/cifssmb.c   |   4 +-
>  fs/smb/client/inode.c     | 181 ++++++++++++++++++++++++++++++++++++++
>  fs/smb/client/ioctl.c     |   8 +-
>  fs/smb/client/smb1ops.c   |   4 +-
>  fs/smb/client/smb2ops.c   |   8 +-
>  fs/smb/client/smb2pdu.c   |   4 +-
>  fs/smb/client/smb2proto.h |   2 +-
>  fs/smb/common/smb2pdu.h   |   2 +
>  12 files changed, 209 insertions(+), 16 deletions(-)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index ea31d693ea9f..b441675f9afd 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1182,6 +1182,8 @@ const struct inode_operations cifs_dir_inode_ops =
=3D {
>         .listxattr =3D cifs_listxattr,
>         .get_acl =3D cifs_get_acl,
>         .set_acl =3D cifs_set_acl,
> +       .fileattr_get =3D cifs_fileattr_get,
> +       .fileattr_set =3D cifs_fileattr_set,
>  };
>
>  const struct inode_operations cifs_file_inode_ops =3D {
> @@ -1192,6 +1194,8 @@ const struct inode_operations cifs_file_inode_ops =
=3D {
>         .fiemap =3D cifs_fiemap,
>         .get_acl =3D cifs_get_acl,
>         .set_acl =3D cifs_set_acl,
> +       .fileattr_get =3D cifs_fileattr_get,
> +       .fileattr_set =3D cifs_fileattr_set,
>  };
>
>  const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
> diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
> index 831fee962c4d..b1e6025e2cbc 100644
> --- a/fs/smb/client/cifsfs.h
> +++ b/fs/smb/client/cifsfs.h
> @@ -77,6 +77,8 @@ extern int cifs_setattr(struct mnt_idmap *, struct dent=
ry *,
>                         struct iattr *);
>  extern int cifs_fiemap(struct inode *, struct fiemap_extent_info *, u64 =
start,
>                        u64 len);
> +extern int cifs_fileattr_get(struct dentry *dentry, struct fileattr *fa)=
;
> +extern int cifs_fileattr_set(struct mnt_idmap *idmap, struct dentry *den=
try, struct fileattr *fa);
>
>  extern const struct inode_operations cifs_file_inode_ops;
>  extern const struct inode_operations cifs_symlink_inode_ops;
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index b764bfe916b4..233a0a13b0e2 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -426,7 +426,7 @@ struct smb_version_operations {
>         int (*set_file_info)(struct inode *, const char *, FILE_BASIC_INF=
O *,
>                              const unsigned int);
>         int (*set_compression)(const unsigned int, struct cifs_tcon *,
> -                              struct cifsFileInfo *);
> +                              struct cifsFileInfo *, bool);
>         /* check if we can send an echo or nor */
>         bool (*can_echo)(struct TCP_Server_Info *);
>         /* send echo request */
> @@ -538,7 +538,7 @@ struct smb_version_operations {
>         int (*calc_signature)(struct smb_rqst *, struct TCP_Server_Info *=
,
>                                 bool allocate_crypto);
>         int (*set_integrity)(const unsigned int, struct cifs_tcon *tcon,
> -                            struct cifsFileInfo *src_file);
> +                            struct cifsFileInfo *src_file, bool enable);
>         int (*enum_snapshots)(const unsigned int xid, struct cifs_tcon *t=
con,
>                              struct cifsFileInfo *src_file, void __user *=
);
>         int (*notify)(const unsigned int xid, struct file *pfile,
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index 47ecc0884a74..f5f6be6f343e 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -506,7 +506,7 @@ extern struct inode *cifs_create_reparse_inode(struct=
 cifs_open_info_data *data,
>                                                struct kvec *reparse_iov,
>                                                struct kvec *xattr_iov);
>  extern int CIFSSMB_set_compression(const unsigned int xid,
> -                                  struct cifs_tcon *tcon, __u16 fid);
> +                                  struct cifs_tcon *tcon, __u16 fid, boo=
l enable);
>  extern int CIFS_open(const unsigned int xid, struct cifs_open_parms *opa=
rms,
>                      int *oplock, FILE_ALL_INFO *buf);
>  extern int SMBOldOpen(const unsigned int xid, struct cifs_tcon *tcon,
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index 3dbff55b639d..643a55db3ca9 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -3454,7 +3454,7 @@ struct inode *cifs_create_reparse_inode(struct cifs=
_open_info_data *data,
>
>  int
>  CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
> -                   __u16 fid)
> +                   __u16 fid, bool enable)
>  {
>         int rc =3D 0;
>         int bytes_returned;
> @@ -3467,7 +3467,7 @@ CIFSSMB_set_compression(const unsigned int xid, str=
uct cifs_tcon *tcon,
>         if (rc)
>                 return rc;
>
> -       pSMB->compression_state =3D cpu_to_le16(COMPRESSION_FORMAT_DEFAUL=
T);
> +       pSMB->compression_state =3D cpu_to_le16(enable ? COMPRESSION_FORM=
AT_DEFAULT : COMPRESSION_FORMAT_NONE);
>
>         pSMB->TotalParameterCount =3D 0;
>         pSMB->TotalDataCount =3D cpu_to_le32(2);
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index dfad9284a87c..d07ebb99c262 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/wait_bit.h>
>  #include <linux/fiemap.h>
> +#include <linux/fileattr.h>
>  #include <asm/div64.h>
>  #include "cifsfs.h"
>  #include "cifspdu.h"
> @@ -83,6 +84,7 @@ static void cifs_set_ops(struct inode *inode)
>                 inode->i_op =3D &cifs_symlink_inode_ops;
>                 break;
>         default:
> +               inode->i_op =3D &cifs_file_inode_ops;
>                 init_special_inode(inode, inode->i_mode, inode->i_rdev);
>                 break;
>         }
> @@ -3282,3 +3284,182 @@ cifs_setattr(struct mnt_idmap *idmap, struct dent=
ry *direntry,
>         /* BB: add cifs_setattr_legacy for really old servers */
>         return rc;
>  }
> +
> +int cifs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> +{
> +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(dentry->d_sb);
> +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> +       struct inode *inode =3D d_inode(dentry);
> +       u32 attrs =3D CIFS_I(inode)->cifsAttrs;
> +       u32 fsattrs =3D le32_to_cpu(tcon->fsAttrInfo.Attributes);
> +       u32 xflags =3D 0;
> +       u32 xflags_mask =3D FS_XFLAG_IMMUTABLEUSER;
> +       u16 xflags2 =3D 0;
> +       u16 xflags2_mask =3D FS_XFLAG2_HIDDEN | FS_XFLAG2_SYSTEM | FS_XFL=
AG2_ARCHIVE |
> +                          FS_XFLAG2_TEMPORARY | FS_XFLAG2_NOTINDEXED |
> +                          FS_XFLAG2_NOSCRUBDATA | FS_XFLAG2_OFFLINE |
> +                          FS_XFLAG2_PINNED | FS_XFLAG2_UNPINNED;
> +
> +       if (fsattrs & FILE_FILE_COMPRESSION)
> +               xflags_mask |=3D FS_XFLAG_COMPRESSED;
> +       if (fsattrs & FILE_SUPPORTS_ENCRYPTION)
> +               xflags_mask |=3D FS_XFLAG_COMPRESSED;
> +       if (fsattrs & FILE_SUPPORT_INTEGRITY_STREAMS)
> +               xflags_mask |=3D FS_XFLAG_CHECKSUMS;
> +
> +       if (attrs & FILE_ATTRIBUTE_READONLY)
> +               xflags |=3D FS_XFLAG_IMMUTABLEUSER;
> +       if (attrs & FILE_ATTRIBUTE_HIDDEN)
> +               xflags2 |=3D FS_XFLAG2_HIDDEN;
> +       if (attrs & FILE_ATTRIBUTE_SYSTEM)
> +               xflags2 |=3D FS_XFLAG2_SYSTEM;
> +       if (attrs & FILE_ATTRIBUTE_ARCHIVE)
> +               xflags2 |=3D FS_XFLAG2_ARCHIVE;
> +       if (attrs & FILE_ATTRIBUTE_TEMPORARY)
> +               xflags2 |=3D FS_XFLAG2_TEMPORARY;
> +       if (attrs & FILE_ATTRIBUTE_COMPRESSED)
> +               xflags |=3D FS_XFLAG_COMPRESSED;
> +       if (attrs & FILE_ATTRIBUTE_OFFLINE)
> +               xflags2 |=3D FS_XFLAG2_OFFLINE;
> +       if (attrs & FILE_ATTRIBUTE_NOT_CONTENT_INDEXED)
> +               xflags2 |=3D FS_XFLAG2_NOTINDEXED;
> +       if (attrs & FILE_ATTRIBUTE_ENCRYPTED)
> +               xflags |=3D FS_XFLAG_ENCRYPTED;
> +       if (attrs & FILE_ATTRIBUTE_INTEGRITY_STREAM)
> +               xflags |=3D FS_XFLAG_CHECKSUMS;
> +       if (attrs & FILE_ATTRIBUTE_NO_SCRUB_DATA)
> +               xflags2 |=3D FS_XFLAG2_NOSCRUBDATA;
> +       if (attrs & FILE_ATTRIBUTE_PINNED)
> +               xflags2 |=3D FS_XFLAG2_PINNED;
> +       if (attrs & FILE_ATTRIBUTE_UNPINNED)
> +               xflags2 |=3D FS_XFLAG2_UNPINNED;
> +
> +       fileattr_fill_xflags(fa, xflags, xflags_mask, xflags2, xflags2_ma=
sk);
> +       return 0;
> +}
> +
> +#define MODIFY_ATTRS_COND(attrs, xflags, xflag, attr) (attrs) ^=3D ((-(!=
!((xflags) & (xflag))) ^ (attrs)) & (attr))
> +
> +int cifs_fileattr_set(struct mnt_idmap *idmap,
> +                     struct dentry *dentry, struct fileattr *fa)
> +{
> +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(dentry->d_sb);
> +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> +       struct inode *inode =3D d_inode(dentry);
> +       u32 attrs =3D CIFS_I(inode)->cifsAttrs;
> +       struct cifsFileInfo open_file_tmp =3D {};
> +       struct cifsFileInfo *open_file =3D NULL;
> +       struct cifs_open_parms oparms;
> +       FILE_BASIC_INFO info_buf =3D {};
> +       bool do_close =3D false;
> +       const char *full_path;
> +       unsigned int xid;
> +       __u32 oplock;
> +       void *page;
> +       int rc;
> +
> +       if ((fa->fsx_xflags_mask & ~(FS_XFLAG_IMMUTABLEUSER | FS_XFLAG_CO=
MPRESSED |
> +                                FS_XFLAG_ENCRYPTED | FS_XFLAG_CHECKSUMS)=
) ||
> +           (fa->fsx_xflags2_mask & ~(FS_XFLAG2_HIDDEN | FS_XFLAG2_SYSTEM=
 | FS_XFLAG2_ARCHIVE |
> +                                 FS_XFLAG2_TEMPORARY | FS_XFLAG2_NOTINDE=
XED |
> +                                 FS_XFLAG2_NOSCRUBDATA | FS_XFLAG2_OFFLI=
NE |
> +                                 FS_XFLAG2_PINNED | FS_XFLAG2_UNPINNED))=
 ||
> +           (fa->flags & ~FS_COMMON_FL))
> +               return -EOPNOTSUPP;
> +
> +       if (fa->fsx_xflags_mask & FS_XFLAG_IMMUTABLEUSER)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags, FS_XFLAG_IMMUTAB=
LEUSER, FILE_ATTRIBUTE_READONLY);
> +       if (fa->fsx_xflags2_mask & FS_XFLAG2_HIDDEN)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_HIDDE=
N, FILE_ATTRIBUTE_HIDDEN);
> +       if (fa->fsx_xflags2_mask & FS_XFLAG2_SYSTEM)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_SYSTE=
M, FILE_ATTRIBUTE_SYSTEM);
> +       if (fa->fsx_xflags2_mask & FS_XFLAG2_ARCHIVE)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_ARCHI=
VE, FILE_ATTRIBUTE_ARCHIVE);
> +       if (fa->fsx_xflags2_mask & FS_XFLAG2_TEMPORARY)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_TEMPO=
RARY, FILE_ATTRIBUTE_TEMPORARY);
> +       if (fa->fsx_xflags2_mask & FS_XFLAG2_NOTINDEXED)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_NOTIN=
DEXED, FILE_ATTRIBUTE_NOT_CONTENT_INDEXED);
> +       if (fa->fsx_xflags2_mask & FS_XFLAG2_NOSCRUBDATA)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_NOSCR=
UBDATA, FILE_ATTRIBUTE_NO_SCRUB_DATA);
> +       if (fa->fsx_xflags2_mask & FS_XFLAG2_OFFLINE)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_OFFLI=
NE, FILE_ATTRIBUTE_OFFLINE);
> +       if (fa->fsx_xflags2_mask & FS_XFLAG2_PINNED)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_PINNE=
D, FILE_ATTRIBUTE_PINNED);
> +       if (fa->fsx_xflags2_mask & FS_XFLAG2_UNPINNED)
> +               MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_UNPIN=
NED, FILE_ATTRIBUTE_UNPINNED);
> +
> +       page =3D alloc_dentry_path();
> +
> +       full_path =3D build_path_from_dentry(dentry, page);
> +       if (IS_ERR(full_path)) {
> +               rc =3D PTR_ERR(full_path);
> +               goto out_page;
> +       }
> +
> +       xid =3D get_xid();
> +
> +       if (attrs !=3D CIFS_I(inode)->cifsAttrs) {
> +               info_buf.Attributes =3D cpu_to_le32(attrs);
> +               if (tcon->ses->server->ops->set_file_info)
> +                       rc =3D tcon->ses->server->ops->set_file_info(inod=
e, full_path, &info_buf, xid);
> +               else
> +                       rc =3D -EOPNOTSUPP;
> +               if (rc)
> +                       goto out_xid;
> +               CIFS_I(inode)->cifsAttrs =3D attrs;
> +       }
> +
> +       if (fa->fsx_xflags_mask & (FS_XFLAG_COMPRESSED | FS_XFLAG_ENCRYPT=
ED | FS_XFLAG_CHECKSUMS)) {
> +               open_file =3D find_writable_file(CIFS_I(inode), FIND_WR_F=
SUID_ONLY);
> +               if (!open_file) {
> +                       oparms =3D CIFS_OPARMS(cifs_sb, tcon, full_path, =
FILE_WRITE_DATA, FILE_OPEN, 0, ACL_NO_MODE);
> +                       oparms.fid =3D &open_file_tmp.fid;
> +                       oplock =3D 0;
> +                       oparms.create_options =3D cifs_create_options(cif=
s_sb, 0);
> +                       rc =3D tcon->ses->server->ops->open(xid, &oparms,=
 &oplock, NULL);
> +                       if (rc)
> +                               goto out_file;
> +                       do_close =3D true;
> +                       open_file =3D &open_file_tmp;
> +               }
> +       }
> +
> +       if (fa->fsx_xflags_mask & FS_XFLAG_COMPRESSED) {
> +               if (tcon->ses->server->ops->set_compression)
> +                       rc =3D tcon->ses->server->ops->set_compression(xi=
d, tcon, open_file, fa->fsx_xflags & FS_XFLAG_COMPRESSED);
> +               else
> +                       rc =3D -EOPNOTSUPP;
> +               if (rc)
> +                       goto out_file;
> +               CIFS_I(inode)->cifsAttrs |=3D FILE_ATTRIBUTE_COMPRESSED;
> +       }
> +
> +       if (fa->fsx_xflags_mask & FS_XFLAG_ENCRYPTED) {
> +               /* TODO */
> +               rc =3D -EOPNOTSUPP;
> +               if (rc)
> +                       goto out_file;
> +               CIFS_I(inode)->cifsAttrs |=3D FILE_ATTRIBUTE_ENCRYPTED;
> +       }
> +
> +       if (fa->fsx_xflags_mask & FS_XFLAG_CHECKSUMS) {
> +               if (tcon->ses->server->ops->set_integrity)
> +                       rc =3D tcon->ses->server->ops->set_integrity(xid,=
 tcon, open_file, fa->fsx_xflags & FS_XFLAG_CHECKSUMS);
> +               else
> +                       rc =3D -EOPNOTSUPP;
> +               if (rc)
> +                       goto out_file;
> +               CIFS_I(inode)->cifsAttrs |=3D FILE_ATTRIBUTE_INTEGRITY_ST=
REAM;
> +       }
> +
> +out_file:
> +       if (do_close)
> +               tcon->ses->server->ops->close(xid, tcon, oparms.fid);
> +       else if (open_file)
> +               cifsFileInfo_put(open_file);
> +out_xid:
> +       free_xid(xid);
> +out_page:
> +       free_dentry_path(page);
> +       return rc;
> +}
> diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
> index 56439da4f119..7c245085f891 100644
> --- a/fs/smb/client/ioctl.c
> +++ b/fs/smb/client/ioctl.c
> @@ -356,12 +356,14 @@ long cifs_ioctl(struct file *filep, unsigned int co=
mmand, unsigned long arg)
>         struct cifs_tcon *tcon;
>         struct tcon_link *tlink;
>         struct cifs_sb_info *cifs_sb;
> +#if 0
>         __u64   ExtAttrBits =3D 0;
>  #ifdef CONFIG_CIFS_POSIX
>  #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
>         __u64   caps;
>  #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
>  #endif /* CONFIG_CIFS_POSIX */
> +#endif
>
>         xid =3D get_xid();
>
> @@ -372,6 +374,7 @@ long cifs_ioctl(struct file *filep, unsigned int comm=
and, unsigned long arg)
>                 trace_smb3_ioctl(xid, pSMBFile->fid.persistent_fid, comma=
nd);
>
>         switch (command) {
> +#if 0
>                 case FS_IOC_GETFLAGS:
>                         if (pSMBFile =3D=3D NULL)
>                                 break;
> @@ -429,10 +432,11 @@ long cifs_ioctl(struct file *filep, unsigned int co=
mmand, unsigned long arg)
>                         /* Try to set compress flag */
>                         if (tcon->ses->server->ops->set_compression) {
>                                 rc =3D tcon->ses->server->ops->set_compre=
ssion(
> -                                                       xid, tcon, pSMBFi=
le);
> +                                                       xid, tcon, pSMBFi=
le, true);
>                                 cifs_dbg(FYI, "set compress flag rc %d\n"=
, rc);
>                         }
>                         break;
> +#endif
>                 case CIFS_IOC_COPYCHUNK_FILE:
>                         rc =3D cifs_ioctl_copychunk(xid, filep, arg);
>                         break;
> @@ -445,7 +449,7 @@ long cifs_ioctl(struct file *filep, unsigned int comm=
and, unsigned long arg)
>                         tcon =3D tlink_tcon(pSMBFile->tlink);
>                         if (tcon->ses->server->ops->set_integrity)
>                                 rc =3D tcon->ses->server->ops->set_integr=
ity(xid,
> -                                               tcon, pSMBFile);
> +                                               tcon, pSMBFile, true);
>                         else
>                                 rc =3D -EOPNOTSUPP;
>                         break;
> diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
> index ba6452d89df3..2e854bde67de 100644
> --- a/fs/smb/client/smb1ops.c
> +++ b/fs/smb/client/smb1ops.c
> @@ -1245,9 +1245,9 @@ smb_set_file_info(struct inode *inode, const char *=
full_path,
>
>  static int
>  cifs_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
> -                  struct cifsFileInfo *cfile)
> +                  struct cifsFileInfo *cfile, bool enable)
>  {
> -       return CIFSSMB_set_compression(xid, tcon, cfile->fid.netfid);
> +       return CIFSSMB_set_compression(xid, tcon, cfile->fid.netfid, enab=
le);
>  }
>
>  static int
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index f8445a9ff9a1..9c66e413c59c 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -2106,20 +2106,20 @@ smb2_duplicate_extents(const unsigned int xid,
>
>  static int
>  smb2_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
> -                  struct cifsFileInfo *cfile)
> +                  struct cifsFileInfo *cfile, bool enable)
>  {
>         return SMB2_set_compression(xid, tcon, cfile->fid.persistent_fid,
> -                           cfile->fid.volatile_fid);
> +                           cfile->fid.volatile_fid, enable);
>  }
>
>  static int
>  smb3_set_integrity(const unsigned int xid, struct cifs_tcon *tcon,
> -                  struct cifsFileInfo *cfile)
> +                  struct cifsFileInfo *cfile, bool enable)
>  {
>         struct fsctl_set_integrity_information_req integr_info;
>         unsigned int ret_data_len;
>
> -       integr_info.ChecksumAlgorithm =3D cpu_to_le16(CHECKSUM_TYPE_UNCHA=
NGED);
> +       integr_info.ChecksumAlgorithm =3D cpu_to_le16(enable ? CHECKSUM_T=
YPE_CRC64 : CHECKSUM_TYPE_NONE);
>         integr_info.Flags =3D 0;
>         integr_info.Reserved =3D 0;
>
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index a75947797d58..57d716cfc800 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -3537,14 +3537,14 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tc=
on *tcon, u64 persistent_fid,
>
>  int
>  SMB2_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
> -                    u64 persistent_fid, u64 volatile_fid)
> +                    u64 persistent_fid, u64 volatile_fid, bool enable)
>  {
>         int rc;
>         struct  compress_ioctl fsctl_input;
>         char *ret_data =3D NULL;
>
>         fsctl_input.CompressionState =3D
> -                       cpu_to_le16(COMPRESSION_FORMAT_DEFAULT);
> +                       cpu_to_le16(enable ? COMPRESSION_FORMAT_DEFAULT :=
 COMPRESSION_FORMAT_NONE);
>
>         rc =3D SMB2_ioctl(xid, tcon, persistent_fid, volatile_fid,
>                         FSCTL_SET_COMPRESSION,
> diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
> index cec5921bfdd2..6086bbdeeae0 100644
> --- a/fs/smb/client/smb2proto.h
> +++ b/fs/smb/client/smb2proto.h
> @@ -250,7 +250,7 @@ extern int SMB2_set_ea(const unsigned int xid, struct=
 cifs_tcon *tcon,
>                        u64 persistent_fid, u64 volatile_fid,
>                        struct smb2_file_full_ea_info *buf, int len);
>  extern int SMB2_set_compression(const unsigned int xid, struct cifs_tcon=
 *tcon,
> -                               u64 persistent_fid, u64 volatile_fid);
> +                               u64 persistent_fid, u64 volatile_fid, boo=
l enable);
>  extern int SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *t=
con,
>                              const u64 persistent_fid, const u64 volatile=
_fid,
>                              const __u8 oplock_level);
> diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
> index ab902b155650..a24194bef849 100644
> --- a/fs/smb/common/smb2pdu.h
> +++ b/fs/smb/common/smb2pdu.h
> @@ -1077,6 +1077,8 @@ struct smb2_server_client_notification {
>  #define FILE_ATTRIBUTE_ENCRYPTED               0x00004000
>  #define FILE_ATTRIBUTE_INTEGRITY_STREAM                0x00008000
>  #define FILE_ATTRIBUTE_NO_SCRUB_DATA           0x00020000
> +#define FILE_ATTRIBUTE_PINNED                  0x00080000
> +#define FILE_ATTRIBUTE_UNPINNED                        0x00100000
>  #define FILE_ATTRIBUTE__MASK                   0x00007FB7
>
>  #define FILE_ATTRIBUTE_READONLY_LE              cpu_to_le32(0x00000001)
> --
> 2.20.1
>

