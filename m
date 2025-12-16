Return-Path: <linux-fsdevel+bounces-71482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D434CC48AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB6563009240
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60317329C4F;
	Tue, 16 Dec 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TIdIIvK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B1450FE;
	Tue, 16 Dec 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904813; cv=none; b=oiOYiU0VF7HlaqRwoZIR3+BLtNpzR8166luFnuTpAU3C5wjI2goQEE95z9ZJxSi7/vT5pCMR0pJOEfjb/Bg/rsfxvs38tdBvvloreheqxuIjiF6ynhf7JmmhQ+BLAflMPwYYQXXbe4RHrYqI8TKjKdzIkBXkUhzrI9NmVl/VgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904813; c=relaxed/simple;
	bh=irmVnNOONfLIc6CSL9QmxHxieekeXvXwvMwCFbMWh5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDPIyt4kLIyE+ZRdqCN110pNIiH/adHAcUSkE9bpNqyR738gugy52G57AYZKH8Gx+XB0U6VYAUcO6n33CeGGVXvr3W/oOHS9KKsTHBlymthsUMVJln4LyqgJ9+Uahf6Xy05GYyerGU06uyiqIFYRPBbp8I5GAM+LqcMLLDQUgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TIdIIvK1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/9LILEw8XOurCqsAIfkiqbEK6i5+72LbMax72w6dgmQ=; b=TIdIIvK1gkZcMXUyB8TLm54PaW
	me5FeuupygLlMENDt4XuAeoiL8Rz4uqJ27yRotO+LkWYBM3CRNRFIVtN3pnosuLn2GSWPUfmWmPO0
	NAAlZudPZn+2hW9IAb0enM5FKW0fdzzYBYJwRKCrTa2kCnVvwfpfEYyMNzk0vnePf2DnkOxR/vSqO
	qARNo7EmafWpJXGOjbyPH7oDMrCEFq2yfrVW+738HZQ8geSYY0z5SlAhdkRD+pMRW4HS2oKFtJZ79
	UuMm+l2bkQR8aTdP9reYCF5LJugD/u+/3tUQpYIqyvsNxnuz13OwfVFWo8D6yWAey4uP8rcJbWhZX
	1jokRZng==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVYVF-00DTaK-QQ; Tue, 16 Dec 2025 18:06:25 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Bernd Schubert <bschubert@ddn.com>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 6/6] fuse: implementation of export_operations
 with FUSE_LOOKUP_HANDLE
In-Reply-To: <CAJfpegu8-ddQeE9nnY5NH64KQHzr1Zfb=187Pb2uw14oTEPdOw@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 16 Dec 2025 11:58:25 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-7-luis@igalia.com>
	<CAJfpegu8-ddQeE9nnY5NH64KQHzr1Zfb=187Pb2uw14oTEPdOw@mail.gmail.com>
Date: Tue, 16 Dec 2025 17:06:25 +0000
Message-ID: <874ipqcq5q.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16 2025, Miklos Szeredi wrote:

> On Fri, 12 Dec 2025 at 19:13, Luis Henriques <luis@igalia.com> wrote:
>>
>> This patch allows the NFS handle to use the new file handle provided by =
the
>> LOOKUP_HANDLE operation.  It still allows the usage of nodeid+generation=
 as
>> an handle if this operation is not supported by the FUSE server or if no
>> handle is available for a specific inode.  I.e. it can mix both file han=
dle
>> types FILEID_INO64_GEN{_PARENT} and FILEID_FUSE_WITH{OUT}_PARENT.
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
>
> I think it should be either
>
>   - encode nodeid + generation (backward compatibility),
>
>   - or encode file handle for servers that support it
>
> but not both.

OK, in fact v1 was trying to do something like that, by defining the
handle with this:

struct fuse_inode_handle {
	u32 type;
	union {
		struct {
			u64 nodeid;
			u32 generation;
		};
		struct fuse_file_handle fh;
	};
};

(The 'type' is likely to be useless, as we know if the server supports fh
or not.)

> Which means that fuse_iget() must be able to search the cache based on
> the handle as well, but that should not be too difficult to implement
> (need to hash the file handle).

Right, I didn't got that far in v1.  I'll see what I can come up to.
Doing memcmp()s would definitely be too expensive, so using hashes is the
only way I guess.

Cheers,
--=20
Lu=C3=ADs

