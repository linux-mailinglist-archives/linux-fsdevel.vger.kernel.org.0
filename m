Return-Path: <linux-fsdevel+bounces-71469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE0CC2B62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 13:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FEF31B85F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A3434A77A;
	Tue, 16 Dec 2025 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fvhwrgFL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBC2E9EB5;
	Tue, 16 Dec 2025 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885709; cv=none; b=So1PbE4+cqkMYluuBuP6eNwJoSO2mM1fQeJDlmaY1PXBzjhUCodoBkjB+q/KskjJkGN1wicrjfW6G84nsTF9hqc/9Epr39k0eK5p5XII/8i1t63unDGh/2iGuzSPXBw5O3s6upwnXDAqAT603iZq4XvXWqhH3NHZPKMQPncJ9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885709; c=relaxed/simple;
	bh=XoUxJlD9WOjxAkU6DHlmiQFh2axyhB6GCIIrxm5nfHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iTsIAJuzHxYVUxLWKBmH0n+aJDhmyRK3Z2riiBDKPJSFX7rG5eFJGoATnM1wKM2LrBvmNN09UHOv6Ol22eJ7tFWp7DwDMYXBKMVhzQkfhANppjG95iQvApdKXgbZ+J7J/5zZ5wM/brJZF28Zpck0JtRpczYAO4DlV5Qtw4IuDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fvhwrgFL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=K/fhvhkiEktnk/2Z7WHoZ3hMxclF75DfHmLMCpuN3Oc=; b=fvhwrgFLuzlDd5RQkXaU43rMYL
	yNrhlSpIvMPFk2/I00MgP+MJ8qa0weMD4DLDQNMKVRNpFSrLqEd+UPDs2C1L9AtlrLXY0Q4i/kVxZ
	Sy/62pVY+BT+pvebbEY2wtYe1lgYaTzF1p4jNiXUbsnkfRC6WgafLhIGHUCjeE0mOUrAQgIbCy+Lq
	6ftI5jYNLdWV6oYRf0+rK6quM7iO4upi810Md2FzCrWToj4bDZafrImgfnjQqSGsAep6UWU5Ti90a
	YZMMNnl9wndrysRJjvG5L9LX0KaD+rldboIAzNzmGPZr4Pk4VXIraCznexyYUrDIZuss8WHv/yzwG
	KDNsKYbg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVTXO-00DMw8-Cy; Tue, 16 Dec 2025 12:48:18 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  "Darrick J. Wong" <djwong@kernel.org>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Matt
 Harvey <mharvey@jumptrading.com>,  "kernel-dev@igalia.com"
 <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <76f21528-9b14-4277-8f4c-f30036884e75@ddn.com> (Bernd Schubert's
	message of "Mon, 15 Dec 2025 17:39:22 +0000")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<76f21528-9b14-4277-8f4c-f30036884e75@ddn.com>
Date: Tue, 16 Dec 2025 11:48:18 +0000
Message-ID: <87ike6d4vx.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15 2025, Bernd Schubert wrote:

> On 12/12/25 19:12, Luis Henriques wrote:
>> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to inc=
lude
>> an extra inarg: the file handle for the parent directory (if it is
>> available).  Also, because fuse_entry_out now has a extra variable size
>> struct (the actual handle), it also sets the out_argvar flag to true.
>>=20
>> Most of the other modifications in this patch are a fallout from these
>> changes: because fuse_entry_out has been modified to include a variable =
size
>> struct, every operation that receives such a parameter have to take this
>> into account:
>>=20
>>    CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
>>=20
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>   fs/fuse/dev.c             | 16 +++++++
>>   fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++---------
>>   fs/fuse/fuse_i.h          | 34 +++++++++++++--
>>   fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
>>   fs/fuse/readdir.c         | 10 ++---
>>   include/uapi/linux/fuse.h |  8 ++++
>>   6 files changed, 189 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 629e8a043079..fc6acf45ae27 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -606,6 +606,22 @@ static void fuse_adjust_compat(struct fuse_conn *fc=
, struct fuse_args *args)
>>   	if (fc->minor < 4 && args->opcode =3D=3D FUSE_STATFS)
>>   		args->out_args[0].size =3D FUSE_COMPAT_STATFS_SIZE;
>>=20=20=20
>> +	if (fc->minor < 45) {
>
> Could we use fc->lookup_handle here? Numbers are hard with backports

To be honest, I'm not sure this code is correct.  I just followed the
pattern.  I'll need to dedicate some more time looking into this,
specially because the READDIRPLUS op handling is still TBD.

<snip>

>> @@ -505,6 +535,30 @@ struct inode *fuse_iget(struct super_block *sb, u64=
 nodeid,
>>   	if (!inode)
>>   		return NULL;
>>=20=20=20
>> +	fi =3D get_fuse_inode(inode);
>> +	if (fc->lookup_handle) {
>> +		if ((fh =3D=3D NULL) && (nodeid !=3D FUSE_ROOT_ID)) {
>> +			pr_err("NULL file handle for nodeid %llu\n", nodeid);
>> +			iput(inode);
>> +			return NULL;
>
> Hmm, so there are conditions like "if (fi && fi->fh) {" in lookup and I
> was thinking "nice, fuse-server can decide to skip the fh for some
> inodes like FUSE_ROOT_ID. But now it gets forbidden here. In combination
> with the other comment in fuse_inode_handle_alloc(), could be allocate
> here to the needed size and allow fuse-server to not send the handle
> for some files?

I'm not sure the code is consistent with this regard, but here I'm doing
exactly that: allowing the fh to be NULL only for FUSE_ROOT_ID.  Or did I
misunderstood your comment?

Regarding the comment in fuse_inode_handle_alloc(), I believe I'll need to
rethink about it anyway, specially after some of the comments I've already
seen from Miklos (which I'm still going through).

Cheers,
--=20
Lu=C3=ADs

