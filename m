Return-Path: <linux-fsdevel+bounces-71484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6352DCC4A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 18:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3C9D303410D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405BB330678;
	Tue, 16 Dec 2025 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pwKcZb5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87933065D;
	Tue, 16 Dec 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906008; cv=none; b=D/t3RtlmCxyCLEWORCEFOw9uDHs7hcgHsbv6QZILH4wC0j6oAhSP904tWXEeIDD5q+69Xkq24XvX8h2mHUiWGobv2sO5mqHtSDpeWOTRdZy4CmPCLeFEqOJ4NYAbzVMbmG6dSE+Y7vnx+gPWKY6dhBzJU4RPVQlYDNEuxbAfl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906008; c=relaxed/simple;
	bh=FHYisUG2myQFoZQIM7EtugYhU4niufuVsKkTaEmN3zc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=falaYdjexCjQAZt9m8A9ckF15aKMvBYQPGchSo9RnUFFJAw/54obFG15YxBwjuJHfhV7452iLxK+YOuRxUZGiGJTI4daMKmY+EQdxw5fayQRWsyFRUJkHdzA+a7hFa/1fnRoc8z+ekfYQb+PtINCghjlA1Lzd5fVUlRP22Py4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pwKcZb5t; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=X7q6eNqg6rZSyFIM66ynB4oB/2UpAFS9eeRViJC/yAE=; b=pwKcZb5tYTL0eC1+M/1f411d/L
	s9nAT83o0SAhzCHvm8FXxTMBXmhgLBq89+p6wJuRmjxfrOB+eXbe4DWdgQ4c6WQYzfRkOcol9t0dg
	Mm6LMogUaHK7gem8rI8AS8Ff6MvcavjAaKeiBj0TRgb8ZgqXRRsLE6DqnvKbyc1OdFxH8LyObRwDZ
	ddBgjKxKt97jjthZ2ui0F93SEzH3gjFtbyegYQ9qRUzbk3Ca1031PVAPWeZp7vQkHDciMg8e8JnVK
	gOYO72seAedSUimXh+SkU196vJPcpsH+1hx1MauB1QpoFKZgfauBHdYPB9Q3tpyADI39GHbmdHECE
	IDKphVsQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVYom-00DU9U-Hw; Tue, 16 Dec 2025 18:26:36 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Bernd Schubert <bschubert@ddn.com>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 6/6] fuse: implementation of export_operations
 with FUSE_LOOKUP_HANDLE
In-Reply-To: <CAOQ4uxh++mVfJXpPt0UH2Xf87Y9qwhJvtTAU=bXvZk0yR0QUEQ@mail.gmail.com>
	(Amir Goldstein's message of "Tue, 16 Dec 2025 12:01:58 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-7-luis@igalia.com>
	<CAOQ4uxh++mVfJXpPt0UH2Xf87Y9qwhJvtTAU=bXvZk0yR0QUEQ@mail.gmail.com>
Date: Tue, 16 Dec 2025 17:26:31 +0000
Message-ID: <87zf7ibans.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16 2025, Amir Goldstein wrote:

> On Fri, Dec 12, 2025 at 7:13=E2=80=AFPM Luis Henriques <luis@igalia.com> =
wrote:
>>
>> This patch allows the NFS handle to use the new file handle provided by =
the
>> LOOKUP_HANDLE operation.  It still allows the usage of nodeid+generation=
 as
>> an handle if this operation is not supported by the FUSE server or if no
>> handle is available for a specific inode.  I.e. it can mix both file han=
dle
>> types FILEID_INO64_GEN{_PARENT} and FILEID_FUSE_WITH{OUT}_PARENT.
>
> Why the mix? I dont get it.

Well, my thought was that if we have a nodeid for which we don't have a
file handle (FUSE_NODE_ID is the only example I can think of), we still
need to encode it.  And the idea was to use the old FILEID_INO64_GEN in
those cases, even if all other nodeids use the new FILEID.  But I guess we
can simply use the nodeid+gen file handle with the new FILEID anyway.

>>
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>  fs/fuse/export.c         | 162 ++++++++++++++++++++++++++++++++++++---
>>  include/linux/exportfs.h |   7 ++
>>  2 files changed, 160 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fuse/export.c b/fs/fuse/export.c
>> index 4a9c95fe578e..b40d146a32f2 100644
>> --- a/fs/fuse/export.c
>> +++ b/fs/fuse/export.c
>> @@ -3,6 +3,7 @@
>>   * FUSE NFS export support.
>>   *
>>   * Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
>> + * Copyright (C) 2025 Jump Trading LLC, author: Luis Henriques <luis@ig=
alia.com>
>>   */
>>
>>  #include "fuse_i.h"
>> @@ -10,7 +11,8 @@
>>
>>  struct fuse_inode_handle {
>>         u64 nodeid;
>> -       u32 generation;
>> +       u32 generation; /* XXX change to u64, and use fid->i64.ino in en=
code/decode? */
>> +       struct fuse_file_handle fh;
>
> If anything this should be a union
> or maybe I don't understand what you were trying to accomplish.
> Please try to explain the design better in the commit message.

As Miklos also suggested using either nodeid+gen or the new fh, I guess it
makes sense to use a union here.

>>  };
>>
>>  static struct dentry *fuse_get_dentry(struct super_block *sb,
>> @@ -67,8 +69,8 @@ static struct dentry *fuse_get_dentry(struct super_blo=
ck *sb,
>>         return ERR_PTR(err);
>>  }
>>
>> -static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>> -                          struct inode *parent)
>> +static int fuse_encode_gen_fh(struct inode *inode, u32 *fh, int *max_le=
n,
>> +                             struct inode *parent)
>>  {
>>         int len =3D parent ? 6 : 3;
>>         u64 nodeid;
>> @@ -96,38 +98,180 @@ static int fuse_encode_fh(struct inode *inode, u32 =
*fh, int *max_len,
>>         }
>>
>>         *max_len =3D len;
>> +
>>         return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>>  }
>>
>> -static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
>> -               struct fid *fid, int fh_len, int fh_type)
>> +static int fuse_encode_fuse_fh(struct inode *inode, u32 *fh, int *max_l=
en,
>> +                              struct inode *parent)
>> +{
>> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>> +       struct fuse_inode *fip =3D NULL;
>> +       struct fuse_inode_handle *handle =3D (void *)fh;
>> +       int type =3D FILEID_FUSE_WITHOUT_PARENT;
>> +       int len, lenp =3D 0;
>> +       int buflen =3D *max_len << 2; /* max_len: number of words */
>> +
>> +       len =3D sizeof(struct fuse_inode_handle) + fi->fh->size;
>> +       if (parent) {
>> +               fip =3D get_fuse_inode(parent);
>> +               if (fip->fh && fip->fh->size) {
>> +                       lenp =3D sizeof(struct fuse_inode_handle) +
>> +                               fip->fh->size;
>> +                       type =3D FILEID_FUSE_WITH_PARENT;
>> +               }
>> +       }
>> +
>> +       if (buflen < (len + lenp)) {
>> +               *max_len =3D (len + lenp) >> 2;
>> +               return  FILEID_INVALID;
>> +       }
>> +
>> +       handle[0].nodeid =3D fi->nodeid;
>> +       handle[0].generation =3D inode->i_generation;
>> +       memcpy(&handle[0].fh, fi->fh, len);
>> +       if (lenp) {
>> +               handle[1].nodeid =3D fip->nodeid;
>> +               handle[1].generation =3D parent->i_generation;
>> +               memcpy(&handle[1].fh, fip->fh, lenp);
>> +       }
>> +
>> +       *max_len =3D (len + lenp) >> 2;
>> +
>> +       return type;
>> +}
>> +
>> +static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>> +                          struct inode *parent)
>> +{
>> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
>> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>> +
>> +       if (fc->lookup_handle && fi->fh && fi->fh->size)
>> +               return fuse_encode_fuse_fh(inode, fh, max_len, parent);
>> +
>> +       return fuse_encode_gen_fh(inode, fh, max_len, parent);
>> +}
>> +
>> +static struct dentry *fuse_fh_gen_to_dentry(struct super_block *sb,
>> +                                           struct fid *fid, int fh_len)
>>  {
>>         struct fuse_inode_handle handle;
>>
>> -       if ((fh_type !=3D FILEID_INO64_GEN &&
>> -            fh_type !=3D FILEID_INO64_GEN_PARENT) || fh_len < 3)
>> +       if (fh_len < 3)
>
> I dont understand why this was changed.

The reason is because fuse_fh_to_dentry() is the only caller of this
function.  Since we already know the type is correct (fuse_fh_to_dentry()
checks it), there's not point checking it again here.

>>                 return NULL;
>>
>>         handle.nodeid =3D (u64) fid->raw[0] << 32;
>>         handle.nodeid |=3D (u64) fid->raw[1];
>>         handle.generation =3D fid->raw[2];
>> +
>>         return fuse_get_dentry(sb, &handle);
>>  }
>>
>> -static struct dentry *fuse_fh_to_parent(struct super_block *sb,
>> +static struct dentry *fuse_fh_fuse_to_dentry(struct super_block *sb,
>> +                                            struct fid *fid, int fh_len)
>> +{
>> +       struct fuse_inode_handle *handle;
>> +       struct dentry *dentry;
>> +       int len =3D sizeof(struct fuse_file_handle);
>> +
>> +       handle =3D (void *)fid;
>> +       len +=3D handle->fh.size;
>> +
>> +       if ((fh_len << 2) < len)
>> +               return NULL;
>> +
>> +       handle =3D kzalloc(len, GFP_KERNEL);
>> +       if (!handle)
>> +               return NULL;
>> +
>> +       memcpy(handle, fid, len);
>> +
>> +       dentry =3D fuse_get_dentry(sb, handle);
>> +       kfree(handle);
>> +
>> +       return dentry;
>> +}
>> +
>> +static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
>>                 struct fid *fid, int fh_len, int fh_type)
>> +{
>> +       switch (fh_type) {
>> +       case FILEID_INO64_GEN:
>> +       case FILEID_INO64_GEN_PARENT:
>> +               return fuse_fh_gen_to_dentry(sb, fid, fh_len);
>> +       case FILEID_FUSE_WITHOUT_PARENT:
>> +       case FILEID_FUSE_WITH_PARENT:
>> +               return fuse_fh_fuse_to_dentry(sb, fid, fh_len);
>> +       }
>> +
>> +       return NULL;
>> +
>> +}
>> +
>> +static struct dentry *fuse_fh_gen_to_parent(struct super_block *sb,
>> +                                           struct fid *fid, int fh_len)
>>  {
>>         struct fuse_inode_handle parent;
>>
>> -       if (fh_type !=3D FILEID_INO64_GEN_PARENT || fh_len < 6)
>> +       if (fh_len < 6)
>>                 return NULL;
>>
>>         parent.nodeid =3D (u64) fid->raw[3] << 32;
>>         parent.nodeid |=3D (u64) fid->raw[4];
>>         parent.generation =3D fid->raw[5];
>> +
>>         return fuse_get_dentry(sb, &parent);
>>  }
>>
>> +static struct dentry *fuse_fh_fuse_to_parent(struct super_block *sb,
>> +                                            struct fid *fid, int fh_len)
>> +{
>> +       struct fuse_inode_handle *handle;
>> +       struct dentry *dentry;
>> +       int total_len;
>> +       int len;
>> +
>> +       handle =3D (void *)fid;
>> +       total_len =3D len =3D sizeof(struct fuse_inode_handle) + handle-=
>fh.size;
>> +
>> +       if ((fh_len << 2) < total_len)
>> +               return NULL;
>> +
>> +       handle =3D (void *)(fid + len);
>> +       len =3D sizeof(struct fuse_file_handle) + handle->fh.size;
>> +       total_len +=3D len;
>> +
>> +       if ((fh_len << 2) < total_len)
>> +               return NULL;
>> +
>> +       handle =3D kzalloc(len, GFP_KERNEL);
>> +       if (!handle)
>> +               return NULL;
>> +
>> +       memcpy(handle, fid, len);
>> +
>> +       dentry =3D fuse_get_dentry(sb, handle);
>> +       kfree(handle);
>> +
>> +       return dentry;
>> +}
>> +
>> +static struct dentry *fuse_fh_to_parent(struct super_block *sb,
>> +               struct fid *fid, int fh_len, int fh_type)
>> +{
>> +       switch (fh_type) {
>> +       case FILEID_INO64_GEN:
>> +       case FILEID_INO64_GEN_PARENT:
>> +               return fuse_fh_gen_to_parent(sb, fid, fh_len);
>> +       case FILEID_FUSE_WITHOUT_PARENT:
>> +       case FILEID_FUSE_WITH_PARENT:
>> +               return fuse_fh_fuse_to_parent(sb, fid, fh_len);
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>>  static struct dentry *fuse_get_parent(struct dentry *child)
>>  {
>>         struct inode *child_inode =3D d_inode(child);
>> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
>> index f0cf2714ec52..db783f6b28bc 100644
>> --- a/include/linux/exportfs.h
>> +++ b/include/linux/exportfs.h
>> @@ -110,6 +110,13 @@ enum fid_type {
>>          */
>>         FILEID_INO64_GEN_PARENT =3D 0x82,
>>
>> +       /*
>> +        * 64 bit nodeid number, 32 bit generation number,
>> +        * variable length handle.
>> +        */
>> +       FILEID_FUSE_WITHOUT_PARENT =3D 0x91,
>> +       FILEID_FUSE_WITH_PARENT =3D 0x92,
>> +
>
>
> Do we even need a handle with inode+gen+server specific handle?
> I didn't think we would. If we do, please explain why.

I *think* I've addressed this my other comments above.  Basically, I agree
that we don't need it.  FUSE_ROOT_ID would be the only exception, but
there's no need for this nodeid+gen+fh just because of that.  (Or maybe I
misunderstood this comment?)

(Oh, and thanks a lot everyone for the comments!  Much appreciated.)

Cheers,
--=20
Lu=C3=ADs

