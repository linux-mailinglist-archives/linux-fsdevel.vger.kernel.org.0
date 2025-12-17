Return-Path: <linux-fsdevel+bounces-71576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94ECC8F73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 18:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8C33035A05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AE6346789;
	Wed, 17 Dec 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T5M8keVY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFAE33C53F;
	Wed, 17 Dec 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990420; cv=none; b=t21+GmEVhocJw2W3ekwlpYF4a4A2d+c53cImmuE5txobQ6ByWsm0iDQBcuMCvt54C2fuB7RW8yrcYcVCdLu6Paw5T6qofy8p/StUHnmYlWvbVnkNPwiuxwBNXE2a7CrdEIy5s1cp83zWwShUnI3XggWeUKYHaZDFppDDS2yeAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990420; c=relaxed/simple;
	bh=1Nm7H9Npf37HXJ1h3uoYbni8FdeTUcfbroF+Dyw8oeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrvCR3FOYRLhao8ztYn/MZX8oK/t6rcdVMfnBXGbj3Znndn/AxhgP8e5Vm5v7JIvXfz81jV1cXoE91Sw9Q5lp38BmG32vF606YFDX04lMSs9Q26H7yqjybEL43N+hcoWrU3YRz1eXifL/kl/lGwPCNZI/SG86SGelz4Bk3aaNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=T5M8keVY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7TOF7/HXI2rQXV5JYYlMFJa/rQn9kZ00GodTLpABSig=; b=T5M8keVYsqBua0nxatUMqZC8o5
	dwZ61ookowQ3iDjiPYmcVXTr3hAVxDfeCp8R3g2m4E34kpiW2Bymh0wl8WXxWNWew0+bclm9T0BlJ
	3rOO6iI+QxFOGeqDfIl5FW5b5NcvF9KFWwjgMDmm3frXaZJgDlK57Oc9qDEkgQEVLur24s3i5iqUG
	Ica5gb+uACXnIlgUId2enoZ36UEw4fsdTeac8AuD6d7MY3ICA4LG2WcnXDMbCz7n9MHsJdmK2Eytw
	88As4mEHjLeFVBBR2mOuw9gQ9bJxnlwZ7SORJU4K66Xhz2sPPi1vF9ouyPlCd+rqRfLCv6jv1nlyq
	UWPdHVig==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVumF-00Dvrc-5w; Wed, 17 Dec 2025 17:53:27 +0100
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
In-Reply-To: <5d08a442-fd74-432f-a5da-4fa9db65e815@ddn.com> (Bernd Schubert's
	message of "Wed, 17 Dec 2025 16:02:58 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<76f21528-9b14-4277-8f4c-f30036884e75@ddn.com>
	<87ike6d4vx.fsf@wotan.olymp>
	<5d08a442-fd74-432f-a5da-4fa9db65e815@ddn.com>
Date: Wed, 17 Dec 2025 16:53:21 +0000
Message-ID: <87o6nxoxry.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17 2025, Bernd Schubert wrote:

> On 12/16/25 12:48, Luis Henriques wrote:
>> On Mon, Dec 15 2025, Bernd Schubert wrote:
>>=20
>>> On 12/12/25 19:12, Luis Henriques wrote:
>>>> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to i=
nclude
>>>> an extra inarg: the file handle for the parent directory (if it is
>>>> available).  Also, because fuse_entry_out now has a extra variable size
>>>> struct (the actual handle), it also sets the out_argvar flag to true.
>>>>
>>>> Most of the other modifications in this patch are a fallout from these
>>>> changes: because fuse_entry_out has been modified to include a variabl=
e size
>>>> struct, every operation that receives such a parameter have to take th=
is
>>>> into account:
>>>>
>>>>    CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
>>>>
>>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>>> ---
>>>>   fs/fuse/dev.c             | 16 +++++++
>>>>   fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++-------=
--
>>>>   fs/fuse/fuse_i.h          | 34 +++++++++++++--
>>>>   fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
>>>>   fs/fuse/readdir.c         | 10 ++---
>>>>   include/uapi/linux/fuse.h |  8 ++++
>>>>   6 files changed, 189 insertions(+), 35 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>>> index 629e8a043079..fc6acf45ae27 100644
>>>> --- a/fs/fuse/dev.c
>>>> +++ b/fs/fuse/dev.c
>>>> @@ -606,6 +606,22 @@ static void fuse_adjust_compat(struct fuse_conn *=
fc, struct fuse_args *args)
>>>>   	if (fc->minor < 4 && args->opcode =3D=3D FUSE_STATFS)
>>>>   		args->out_args[0].size =3D FUSE_COMPAT_STATFS_SIZE;
>>>>=20=20=20
>>>> +	if (fc->minor < 45) {
>>>
>>> Could we use fc->lookup_handle here? Numbers are hard with backports
>>=20
>> To be honest, I'm not sure this code is correct.  I just followed the
>> pattern.  I'll need to dedicate some more time looking into this,
>> specially because the READDIRPLUS op handling is still TBD.
>>=20
>> <snip>
>>=20
>>>> @@ -505,6 +535,30 @@ struct inode *fuse_iget(struct super_block *sb, u=
64 nodeid,
>>>>   	if (!inode)
>>>>   		return NULL;
>>>>=20=20=20
>>>> +	fi =3D get_fuse_inode(inode);
>>>> +	if (fc->lookup_handle) {
>>>> +		if ((fh =3D=3D NULL) && (nodeid !=3D FUSE_ROOT_ID)) {
>>>> +			pr_err("NULL file handle for nodeid %llu\n", nodeid);
>>>> +			iput(inode);
>>>> +			return NULL;
>>>
>>> Hmm, so there are conditions like "if (fi && fi->fh) {" in lookup and I
>>> was thinking "nice, fuse-server can decide to skip the fh for some
>>> inodes like FUSE_ROOT_ID. But now it gets forbidden here. In combination
>>> with the other comment in fuse_inode_handle_alloc(), could be allocate
>>> here to the needed size and allow fuse-server to not send the handle
>>> for some files?
>>=20
>> I'm not sure the code is consistent with this regard, but here I'm doing
>> exactly that: allowing the fh to be NULL only for FUSE_ROOT_ID.  Or did I
>> misunderstood your comment?
>
> Sorry for late reply.
>
> Yeah sorry, what I meant is that the file handle size might be different
> for any of the inodes, in between 0 and max-size for any of the inodes?

So, as per the other discussion of this patch, Miklos was suggesting the
maximum size negotiation could be totally removed, and the allocation
would be done on-demand [1].  (But probably still keeping an hard limit on
MAX_HANDLE_SZ.)

In that case, different inodes could indeed have different file handle
sizes, defined by the server.  Which would be nice, I guess.

But as I also mentioned in other places, there are already a bunch of
changes, and I need going back to the drawing board :-)

[1] https://lore.kernel.org/all/CAJfpegszP+2XA=3DvADK4r09KU30BQd-r9sNu2Dog8=
8yLG8iV7WQ@mail.gmail.com

Cheers,
--=20
Lu=C3=ADs

