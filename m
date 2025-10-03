Return-Path: <linux-fsdevel+bounces-63381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF53BB7666
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43BAC346B23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DCB2877DA;
	Fri,  3 Oct 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="Z+yqM3ok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34B23D7C3;
	Fri,  3 Oct 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506718; cv=none; b=gMnW1VRrp6Gr6FDM05T0j1k1cR1eyJdoBvARolKRikAhJ0/Ed2rJIRcfETML6qqSnfbF+0dpDouhvzktpEzhYo2bbrcth6MSFjesUFcfEzpGrXk8p2hCnpFcADT1tflaEjY/0coP+/PmDd7/iaEzAjU0zlVmP9xzbl63afEfrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506718; c=relaxed/simple;
	bh=9pCaQ9eleNJKkeLow+y8AK0mrzTtpQpjvo8DIPU77Pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkEMdEw7FNP6N9/U74mRfefgggqoZYMmbzlK7tibP8oA+3CtguJI2/1lPZn2+IWcUvbCEYPIrIp4/SAX3Adu/Kv7SzEQEyqye6CUBvTRO3OAIXwwVXVNS6kehzatq+WsHDAkSEKWR6aWiqn9bs6nSL+tCR09xwlTijj/XwoHflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=Z+yqM3ok; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id B319B582D7D;
	Fri,  3 Oct 2025 15:24:42 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C38E20600;
	Fri,  3 Oct 2025 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1759505075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QR3ZpSOLIDp70PvJfbBtRgrrtI2159ZpUNG20vj4flQ=;
	b=Z+yqM3okRv15nZZyg4785s23hHUa/7pWrEzp6NacO7Fzf1PRWtW4xOYKT0HNTZEclcjan3
	dFVOrD7Ca05H3saKvlCbZFSXq6dpkYM4GhriaqZs0EmHCzrTWvOBrB46qoRa8yqlP2enuy
	nXaMrrT5ZAnsPDUdR8oECMFS/2NXczibgsEmHuMOjjy0R85AVaLMyMj0LjBqsKSuWzkDA8
	G7VQV59g/UpVyQkZDnJ5ZeC0E3uF0fVaa+dpSkM7ybvEIM9kOzEnZLgx3t+s0LyaKXauzW
	p6z0o+kSpdn2NZVRz6nTaghnVUx9zU67B0HjWMnmgrvTp1wx1QltCv5aD3Cyew==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chuck Lever <cel@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-nfs@vger.kernel.org,  Chuck Lever <chuck.lever@oracle.com>,  Jeff
 Layton <jlayton@kernel.org>,  Volker Lendecke <Volker.Lendecke@sernet.de>,
  CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
In-Reply-To: <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
	(Amir Goldstein's message of "Thu, 25 Sep 2025 17:50:48 +0200")
References: <20250925151140.57548-1-cel@kernel.org>
	<CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
Date: Fri, 03 Oct 2025 11:24:32 -0400
Message-ID: <87tt0gqa8f.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Amir Goldstein <amir73il@gmail.com> writes:

> On Thu, Sep 25, 2025 at 5:21=E2=80=AFPM Chuck Lever <cel@kernel.org> wrot=
e:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Both the NFSv3 and NFSv4 protocols enable NFS clients to query NFS
>> servers about the case sensitivity and case preservation behaviors
>> of shared file systems. Today, the Linux NFSD implementation
>> unconditionally returns "the export is case sensitive and case
>> preserving".
>>
>> However, a few Linux in-tree file system types appear to have some
>> ability to handle case-folded filenames. Some of our users would
>> like to exploit that functionality from their non-POSIX NFS clients.
>>
>> Enable upper layers such as NFSD to retrieve case sensitivity
>> information from file systems by adding a statx API for this
>> purpose. Introduce a sample producer and a sample consumer for this
>> information.
>>
>> If this mechanism seems sensible, a future patch might add a similar
>> field to the user-space-visible statx structure. User-space file
>> servers already use a variety of APIs to acquire this information.
>>
>> Suggested-by: Jeff Layton <jlayton@kernel.org>
>> Cc: Volker Lendecke <Volker.Lendecke@sernet.de>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/fat/file.c             |  5 +++++
>>  fs/nfsd/nfs3proc.c        | 35 +++++++++++++++++++++++++++--------
>>  include/linux/stat.h      |  1 +
>>  include/uapi/linux/stat.h | 15 +++++++++++++++
>>  4 files changed, 48 insertions(+), 8 deletions(-)
>>
>> I'm certain this RFC patch has a number of problems, but it should
>> serve as a discussion point.
>>
>>
>> diff --git a/fs/fat/file.c b/fs/fat/file.c
>> index 4fc49a614fb8..8572e36d8f27 100644
>> --- a/fs/fat/file.c
>> +++ b/fs/fat/file.c
>> @@ -413,6 +413,11 @@ int fat_getattr(struct mnt_idmap *idmap, const stru=
ct path *path,
>>                 stat->result_mask |=3D STATX_BTIME;
>>                 stat->btime =3D MSDOS_I(inode)->i_crtime;
>>         }
>> +       if (request_mask & STATX_CASE_INFO) {
>> +               stat->result_mask |=3D STATX_CASE_INFO;
>> +               /* STATX_CASE_PRESERVING is cleared */
>> +               stat->case_info =3D statx_case_ascii;
>> +       }
>>
>>         return 0;
>>  }
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index b6d03e1ef5f7..b319d1c4385c 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -697,6 +697,31 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
>>         return rpc_success;
>>  }
>>
>> +static __be32
>> +nfsd3_proc_case(struct svc_fh *fhp, struct nfsd3_pathconfres *resp)
>> +{
>> +       struct path p =3D {
>> +               .mnt            =3D fhp->fh_export->ex_path.mnt,
>> +               .dentry         =3D fhp->fh_dentry,
>> +       };
>> +       u32 request_mask =3D STATX_CASE_INFO;
>> +       struct kstat stat;
>> +       __be32 nfserr;
>> +
>> +       nfserr =3D nfserrno(vfs_getattr(&p, &stat, request_mask,
>> +                                     AT_STATX_SYNC_AS_STAT));
>> +       if (nfserr !=3D nfs_ok)
>> +               return nfserr;
>> +       if (!(stat.result_mask & STATX_CASE_INFO))
>> +               return nfs_ok;
>> +
>> +       resp->p_case_insensitive =3D
>> +               stat.case_info & STATX_CASE_FOLDING_TYPE ? 0 : 1;
>> +       resp->p_case_preserving =3D
>> +               stat.case_info & STATX_CASE_PRESERVING ? 1 : 0;
>> +       return nfs_ok;
>> +}
>> +
>>  /*
>>   * Get pathconf info for the specified file
>>   */
>> @@ -722,17 +747,11 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
>>         if (resp->status =3D=3D nfs_ok) {
>>                 struct super_block *sb =3D argp->fh.fh_dentry->d_sb;
>>
>> -               /* Note that we don't care for remote fs's here */
>> -               switch (sb->s_magic) {
>> -               case EXT2_SUPER_MAGIC:
>> +               if (sb->s_magic =3D=3D EXT2_SUPER_MAGIC) {
>>                         resp->p_link_max =3D EXT2_LINK_MAX;
>>                         resp->p_name_max =3D EXT2_NAME_LEN;
>> -                       break;
>> -               case MSDOS_SUPER_MAGIC:
>> -                       resp->p_case_insensitive =3D 1;
>> -                       resp->p_case_preserving  =3D 0;
>> -                       break;
>>                 }
>> +               resp->status =3D nfsd3_proc_case(&argp->fh, resp);
>>         }
>>
>>         fh_put(&argp->fh);
>> diff --git a/include/linux/stat.h b/include/linux/stat.h
>> index e3d00e7bb26d..abb47cbb233a 100644
>> --- a/include/linux/stat.h
>> +++ b/include/linux/stat.h
>> @@ -59,6 +59,7 @@ struct kstat {
>>         u32             atomic_write_unit_max;
>>         u32             atomic_write_unit_max_opt;
>>         u32             atomic_write_segments_max;
>> +       u32             case_info;
>>  };
>>
>>  /* These definitions are internal to the kernel for now. Mainly used by=
 nfsd. */
>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>> index 1686861aae20..e929b30d64b6 100644
>> --- a/include/uapi/linux/stat.h
>> +++ b/include/uapi/linux/stat.h
>> @@ -219,6 +219,7 @@ struct statx {
>>  #define STATX_SUBVOL           0x00008000U     /* Want/got stx_subvol */
>>  #define STATX_WRITE_ATOMIC     0x00010000U     /* Want/got atomic_write=
_* fields */
>>  #define STATX_DIO_READ_ALIGN   0x00020000U     /* Want/got dio read ali=
gnment info */
>> +#define STATX_CASE_INFO                0x00040000U     /* Want/got case=
 folding info */
>>
>>  #define STATX__RESERVED                0x80000000U     /* Reserved for =
future struct statx expansion */
>>
>> @@ -257,4 +258,18 @@ struct statx {
>>  #define STATX_ATTR_WRITE_ATOMIC                0x00400000 /* File suppo=
rts atomic write operations */
>>
>>
>> +/*
>> + * File system support for case folding is available via a bitmap.
>> + */
>> +#define STATX_CASE_PRESERVING          0x80000000 /* File name case is =
preserved */
>> +
>> +/* Values stored in the low-order byte of .case_info */
>> +enum {
>> +       statx_case_sensitive =3D 0,
>> +       statx_case_ascii,
>> +       statx_case_utf8,
>> +       statx_case_utf16,
>> +};
>> +#define STATX_CASE_FOLDING_TYPE                0x000000ff

Does the protocol care about unicode version?  For userspace, it would
be very relevant to expose it, as well as other details such as
decomposition type.

>> +
>>  #endif /* _UAPI_LINUX_STAT_H */
>> --
>> 2.51.0
>>
>
> CC unicode maintainer and SMB list.

Thanks for the CC, Amir!
>
> Thanks,
> Amir.

--=20
Gabriel Krisman Bertazi

