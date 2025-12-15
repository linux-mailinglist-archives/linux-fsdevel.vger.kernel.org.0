Return-Path: <linux-fsdevel+bounces-71326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F9BCBDBAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 13:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CA583035A75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5F2C15BA;
	Mon, 15 Dec 2025 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VOEgTWrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63E2874F8;
	Mon, 15 Dec 2025 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800354; cv=none; b=n3wmL5Rrye6pVs/hrB/57tDgyuh9asq6TmwVs1IG2Fic5XoV1hoyr0q+WCciH0v5Ar7gQw2iTKatbmge74LSVAd0tZK2zzskjvpclfY/UuQmsSch5OrOlU+2RN+MqLriZmpyonKugwC2LGchnCpwfK3txBPft12uMHE3ycdljy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800354; c=relaxed/simple;
	bh=oiHECL9l14QhufIeCuC4BVFpdI86psH/EZaZbiZ6dTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UfmTIYctpU5OKZX4iKaJpvOVjCsNh+YFRZdTEhKH5fVFgkKBauaIKNkWhahjHGu2m7oD6z0mfASPzznqB2A1BM4+BLChwKvqUbh0lyZ7pSrzd6u3lQg5AkGnYM0TfxMM6fkAWMZR6/5mMRDcdKnrAjDpGgurPW3JmLIF8/LqhKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VOEgTWrP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tvAkG8GmKC/cUEWyVQ1n51s4lpN0UNsYYiSW3c3ggIk=; b=VOEgTWrP9jr5LzJ/i/mJuO6/m/
	Swvgxdj0g6wHVnttwBPw/HWfzi9pHap1pU1QvzjkBHprn80DFMNrbazPy9pYsWbqUpZDMQ2uikTtu
	ICue/EIhSTrct0OrlkRt3F0xU2ZoESjT2tHSzFNtiL0hRSrQYXrL9b8VpR8QSaGWd1M73ISr3jhVH
	WjBG6YEMQBGmpi8pBYJzs8bNRFVEOu3PBkd/EC+tXTtqbs1fGgj+4F1NDB+4cG7nDGMMMssOkjFrT
	yOW+1VRf71+jNQh5DtnN1OUHgM5Ked9HzgDNQiPNx+fbVc2kWPuXUmWx+WhLDGEgk4G4Y21KqlOXg
	IXlwjqgw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vV7KX-00CvWw-LF; Mon, 15 Dec 2025 13:05:33 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong"
 <djwong@kernel.org>, Bernd Schubert <bschubert@ddn.com>, Kevin Chen
 <kchen@ddn.com>, Horst Birthelmer <hbirthelmer@ddn.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Harvey
 <mharvey@jumptrading.com>, kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 5/6] fuse: factor out NFS export related code
In-Reply-To: <CAOQ4uxgXdOpr_qYH9hg-nKMLFj06XJP4c1yZ8ZJzCvdCtUok9A@mail.gmail.com>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-6-luis@igalia.com>
 <CAOQ4uxgXdOpr_qYH9hg-nKMLFj06XJP4c1yZ8ZJzCvdCtUok9A@mail.gmail.com>
Date: Mon, 15 Dec 2025 12:05:26 +0000
Message-ID: <87h5ts2bnd.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14 2025, Amir Goldstein wrote:

> On Fri, Dec 12, 2025 at 7:13=E2=80=AFPM Luis Henriques <luis@igalia.com> =
wrote:
>>
>> Move all the NFS-related code into a different file.  This is just
>> preparatory work to be able to use the LOOKUP_HANDLE file handles as the=
 NFS
>> handles.
>>
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>
> Very nice.
> Apart from minor nit below, feel free to add:

Thanks!

> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
>> ---
>>  fs/fuse/Makefile |   2 +-
>>  fs/fuse/dir.c    |   1 +
>>  fs/fuse/export.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/fuse/fuse_i.h |   6 ++
>>  fs/fuse/inode.c  | 167 +--------------------------------------------
>>  5 files changed, 183 insertions(+), 167 deletions(-)
>>  create mode 100644 fs/fuse/export.c
>>
>> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
>> index 22ad9538dfc4..1d1401658278 100644
>> --- a/fs/fuse/Makefile
>> +++ b/fs/fuse/Makefile
>> @@ -12,7 +12,7 @@ obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
>>
>>  fuse-y :=3D trace.o      # put trace.o first so we see ftrace errors so=
oner
>>  fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.=
o ioctl.o
>> -fuse-y +=3D iomode.o
>> +fuse-y +=3D iomode.o export.o
>>  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
>>  fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
>>  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index a6edb444180f..a885f1dc61eb 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -190,6 +190,7 @@ static void fuse_lookup_init(struct fuse_conn *fc, s=
truct fuse_args *args,
>>
>>                 args->opcode =3D FUSE_LOOKUP_HANDLE;
>>                 args->out_argvar =3D true;
>> +               args->out_argvar_idx =3D 0;
>>
>
> This change looks out of place.

Oops! Indeed, not sure how that happen.  This change belongs to patch

  fuse: store index of the variable length argument

> Keep in mind that it may take me some time to get to the rest of the patc=
hes,
> but this one was a low hanging review.

Sure, no problem.  I just wanted to send a new rev before everyone goes
off for EOY break.  But I understand  it'll probably take some time before
anyone has a look into it.

[ And maybe this -- FUSE restartability -- is even a topic for LSFMM. ]

Cheers,
--=20
Lu=C3=ADs

