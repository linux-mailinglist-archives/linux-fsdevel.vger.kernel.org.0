Return-Path: <linux-fsdevel+bounces-31624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB65C99926A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6073B2B0EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747D51CEE8D;
	Thu, 10 Oct 2024 19:28:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB4198E75;
	Thu, 10 Oct 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588527; cv=none; b=AjvmeGXF+rKQB9HN6zxilKhwgmzfxd9DoGQLWhITfSq018le06nUkjtz9g/YQ8IAc/hZj83pDDn7KnEPhdbokluXIl6CxO2+8GGmE13YHv+1R7ggIX8XnlELebX3RS03eeq/I5revTZ+87WAKDRpOtwBrKk12eF959RHyhPoxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588527; c=relaxed/simple;
	bh=9f+uPORL3QH6MhLko8f+K1sxyN1ZmCusxqQ3u/NGhLg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caW758n+NVLgnZt3XAZ54cXHprarFZlFTjdXEj+Iee/yX7gaEuvmXg3kbRP+ziNMEVyFTyIeIptgEceCLh+XLfG6IsmQo+oSEQw1OxyVul3R5gM5uHYz1pTYsGhheJ3yO1EgKQFZkSku2a2yB6uBEEoAAarFg3Mz1AdNpSmFFwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a39cabb9faso4961875ab.3;
        Thu, 10 Oct 2024 12:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588524; x=1729193324;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbM2TvxpGTsKXfcUXNXSabUBNZW6OXcwsb89tZuKTqQ=;
        b=Fk9UYIcIX8snOiLktjQY7iEAwEsJ2urv7d4FT14it9d/+7Kn8dMoASVPEZOvd334ch
         j8SG0tbrICm6MEvT93QOHSze1DuadoohxlUVe/xIvIlvfHl78eX7DLo4ZewU22GeZj16
         0TkogYfUaYvqswYMSGbAlJ4ys5lGu1T+ebdqnF8LzCP1VGCEbY4jGboXm6P+zO1DnbH5
         N7/1/hnbSBPbyw0l1Dtv5w4YYZnP3jiJ+7o376WnvI/dOFcvv0CJfqLeFky1vMKNPiI8
         i8d2R0VxUNZFiXWkZdWZDzfxEoxOKO45xf6qWlX5xBIzTFRLdmRdlGyI7X6H0EP7XcQ6
         Qnuw==
X-Forwarded-Encrypted: i=1; AJvYcCU7KV4bDYGGW0JNhrKW1VEfBHlud+bDeAGO+dYz6OlBJEzM+quNbtZkOdgAY0MCE91/8IyBeZmi5NqgCn2nYOZ2CIVD7zn1@vger.kernel.org, AJvYcCXXPJZWfSebtPZXb+1Ogm8xMLBQGRwr0idXVRoPfwwP5tDb0O7KwRd/ToARsqzTZIrzkwyyp8myrKhO@vger.kernel.org, AJvYcCXqEKxhs6XzE7b5axqZjh6oOZ4CV78pX6V9pWB9OOXrgKM65MUxFrBfL0IXF33CGWYoUavkjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwduJz+DSiPrbbaCvG/LM08FaTxKm3AYZEfQzpPAZVyStCqC8mn
	E7Yel2KnV4OqoKH1kOBraUFuqUHI96YzzOxrs7jvs6m5nifO3TE=
X-Google-Smtp-Source: AGHT+IHwqSeYYNAJcLFr3vXgoAjvi8VpAQ68Ry5qAG/NHW5XsrSYOCBRL0q+478GeLbFRGJljw3mCg==
X-Received: by 2002:a05:6e02:1986:b0:3a0:9a32:dedc with SMTP id e9e14a558f8ab-3a3b5f863fbmr329185ab.6.1728588524554;
        Thu, 10 Oct 2024 12:28:44 -0700 (PDT)
Received: from [192.168.75.138] (104-63-89-173.lightspeed.livnmi.sbcglobal.net. [104.63.89.173])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afde4667sm3837435ab.58.2024.10.10.12.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:28:43 -0700 (PDT)
Message-ID: <fd90d5d173a47732da87d31aed8a955f73ea086e.camel@kernel.org>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
From: Trond Myklebust <trondmy@kernel.org>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Christian Brauner
	 <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, Anna
 Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>
Date: Thu, 10 Oct 2024 15:28:12 -0400
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 17:26 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> When a filesystem manages its own inode numbers, like NFS's fileid
> shown
> to user space with getattr(), other part of the kernel may still
> expose
> the private inode->ino through kernel logs and audit.
>=20
> Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> whereas the user space's view of an inode number can still be 64
> bits.
>=20
> Add a new inode_get_ino() helper calling the new struct
> inode_operations' get_ino() when set, to get the user space's view of
> an
> inode number.=C2=A0 inode_get_ino() is called by generic_fillattr().
>=20
> Implement get_ino() for NFS.
>=20
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>=20
> I'm not sure about nfs_namespace_getattr(), please review carefully.
>=20
> I guess there are other filesystems exposing inode numbers different
> than inode->i_ino, and they should be patched too.
> ---
> =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++--
> =C2=A0fs/nfs/internal.h=C2=A0 | 1 +
> =C2=A0fs/nfs/namespace.c | 2 ++
> =C2=A0fs/stat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2=
 +-
> =C2=A0include/linux/fs.h | 9 +++++++++
> =C2=A05 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 542c7d97b235..5dfc176b6d92 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -83,18 +83,19 @@ EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
> =C2=A0
> =C2=A0/**
> =C2=A0 * nfs_compat_user_ino64 - returns the user-visible inode number
> - * @fileid: 64-bit fileid
> + * @inode: inode pointer
> =C2=A0 *
> =C2=A0 * This function returns a 32-bit inode number if the boot paramete=
r
> =C2=A0 * nfs.enable_ino64 is zero.
> =C2=A0 */
> -u64 nfs_compat_user_ino64(u64 fileid)
> +u64 nfs_compat_user_ino64(const struct *inode)
> =C2=A0{
> =C2=A0#ifdef CONFIG_COMPAT
> =C2=A0	compat_ulong_t ino;
> =C2=A0#else=09
> =C2=A0	unsigned long ino;
> =C2=A0#endif
> +	u64 fileid =3D NFS_FILEID(inode);
> =C2=A0
> =C2=A0	if (enable_ino64)
> =C2=A0		return fileid;
> @@ -103,6 +104,7 @@ u64 nfs_compat_user_ino64(u64 fileid)
> =C2=A0		ino ^=3D fileid >> (sizeof(fileid)-sizeof(ino)) * 8;
> =C2=A0	return ino;
> =C2=A0}
> +EXPORT_SYMBOL_GPL(nfs_compat_user_ino64);
> =C2=A0
> =C2=A0int nfs_drop_inode(struct inode *inode)
> =C2=A0{
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 430733e3eff2..f5555a71a733 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -451,6 +451,7 @@ extern void nfs_zap_acl_cache(struct inode
> *inode);
> =C2=A0extern void nfs_set_cache_invalid(struct inode *inode, unsigned lon=
g
> flags);
> =C2=A0extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
> =C2=A0extern int nfs_wait_bit_killable(struct wait_bit_key *key, int
> mode);
> +extern u64 nfs_compat_user_ino64(const struct *inode);
> =C2=A0
> =C2=A0#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> =C2=A0/* localio.c */
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index e7494cdd957e..d9b1e0606833 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -232,11 +232,13 @@ nfs_namespace_setattr(struct mnt_idmap *idmap,
> struct dentry *dentry,
> =C2=A0const struct inode_operations nfs_mountpoint_inode_operations =3D {
> =C2=A0	.getattr	=3D nfs_getattr,
> =C2=A0	.setattr	=3D nfs_setattr,
> +	.get_ino	=3D nfs_compat_user_ino64,
> =C2=A0};
> =C2=A0
> =C2=A0const struct inode_operations nfs_referral_inode_operations =3D {
> =C2=A0	.getattr	=3D nfs_namespace_getattr,
> =C2=A0	.setattr	=3D nfs_namespace_setattr,
> +	.get_ino	=3D nfs_compat_user_ino64,
> =C2=A0};
> =C2=A0
> =C2=A0static void nfs_expire_automounts(struct work_struct *work)
> diff --git a/fs/stat.c b/fs/stat.c
> index 41e598376d7e..05636919f94b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -50,7 +50,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32
> request_mask,
> =C2=A0	vfsgid_t vfsgid =3D i_gid_into_vfsgid(idmap, inode);
> =C2=A0
> =C2=A0	stat->dev =3D inode->i_sb->s_dev;
> -	stat->ino =3D inode->i_ino;
> +	stat->ino =3D inode_get_ino(inode);
> =C2=A0	stat->mode =3D inode->i_mode;
> =C2=A0	stat->nlink =3D inode->i_nlink;
> =C2=A0	stat->uid =3D vfsuid_into_kuid(vfsuid);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e3c603d01337..0eba09a21cf7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2165,6 +2165,7 @@ struct inode_operations {
> =C2=A0			=C2=A0=C2=A0=C2=A0 struct dentry *dentry, struct fileattr
> *fa);
> =C2=A0	int (*fileattr_get)(struct dentry *dentry, struct fileattr
> *fa);
> =C2=A0	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> +	u64 (*get_ino)(const struct inode *inode);
> =C2=A0} ____cacheline_aligned;
> =C2=A0
> =C2=A0static inline int call_mmap(struct file *file, struct vm_area_struc=
t
> *vma)
> @@ -2172,6 +2173,14 @@ static inline int call_mmap(struct file *file,
> struct vm_area_struct *vma)
> =C2=A0	return file->f_op->mmap(file, vma);
> =C2=A0}
> =C2=A0
> +static inline u64 inode_get_ino(struct inode *inode)
> +{
> +	if (unlikely(inode->i_op->get_ino))
> +		return inode->i_op->get_ino(inode);
> +
> +	return inode->i_ino;
> +}
> +
> =C2=A0extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_=
t
> *);
> =C2=A0extern ssize_t vfs_write(struct file *, const char __user *, size_t=
,
> loff_t *);
> =C2=A0extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct
> file *,

There should be no need to add this callback to generic_fillattr().

generic_fillattr() is a helper function for use by the filesystems
themselves. It should never be called from any outside functions, as
the inode number would be far from the only attribute that will be
incorrect.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



