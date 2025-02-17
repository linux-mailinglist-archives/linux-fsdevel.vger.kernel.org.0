Return-Path: <linux-fsdevel+bounces-41847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3996EA38235
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F663A6960
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23799219A66;
	Mon, 17 Feb 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="W7ceVPNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E5217658;
	Mon, 17 Feb 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792847; cv=none; b=h69YkleSjVXA5R7W3QmVgwEeNk+szhTNHz2MVLmTMVLBAlLgbIMZgMc8uRNJi1c5U6XTdpMZXDoF3GcSaLlVfzAcK7kfeVVTu9lQuuK8NT87uzjnDc92j0jWpk9IR0HdYQak9DOmUr236CEsTMjMv+SEaYcejWi+NoV8D75hRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792847; c=relaxed/simple;
	bh=Il7tAuv1+o/Rgah2OsNYKIONSog4emk/AfdvgwD24gQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kg2DRKmPrSuquu865UfZk/1VYv+amB9B3ViHxr0ddUUVzAf1/qU+cvlODjbdkmwkuOve9MB3XkZ9/Y6m5jIoq0yMU9X1mD2piWMkupo/rN8hgZbF5TdBcfvq3J66ETwKcGq8n9wzjtk7IKewiVJgQnwBpEuj+ncHvMeNjJhc3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=W7ceVPNH; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WW+jlNZQwR6ON4RwN88Lnc81jUel2BnuIXGB0NXqJS0=; b=W7ceVPNHXjFqQbuyxsRl9uBVDM
	l7/YFqd//TevDy2SmLxEuQR7Qud5S7YTRCn+QsGdoqcCfBMF/rppsBvmAIL6jrFm0tucoPCq+KHL2
	XZg7yAE+BWykTnpVq4x9rs7jLTeSZCZfucgpS3L921o3hPJUgEcMKOiBo6QnkRGzWPSLmfcjG1EdO
	xL0WA9czq/219JEmk9uuqBUtXa2NPw0UOhTaCJ4Bh7uwD4t4v3qWAItfCufD/cMkLyO3mjhGfH17l
	dsqACZi2CAcQikgqhMD7WZ4ehahMnTP6a40pZ/uctqA00TACxjUawADg41TM8J/DHtKvOyGuO8Oo4
	Row5q28Q==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tjzaZ-0065DD-Dv; Mon, 17 Feb 2025 12:47:09 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Dave Chinner <david@fromorbit.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Matt Harvey
 <mharvey@jumptrading.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <847288fa-b66a-4f3d-9f50-52fa293a1189@ddn.com> (Bernd Schubert's
	message of "Mon, 17 Feb 2025 10:29:32 +0000")
References: <20250216165008.6671-1-luis@igalia.com>
	<20250216165008.6671-3-luis@igalia.com>
	<3fac8c84-2c41-461d-92f1-255903fc62a9@ddn.com>
	<87r03wx4th.fsf@igalia.com>
	<847288fa-b66a-4f3d-9f50-52fa293a1189@ddn.com>
Date: Mon, 17 Feb 2025 11:47:09 +0000
Message-ID: <87ldu4x076.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17 2025, Bernd Schubert wrote:

> On 2/17/25 11:07, Luis Henriques wrote:
>> On Mon, Feb 17 2025, Bernd Schubert wrote:
>>=20
>>> On 2/16/25 17:50, Luis Henriques wrote:
>>>> Currently userspace is able to notify the kernel to invalidate the cac=
he
>>>> for an inode.  This means that, if all the inodes in a filesystem need=
 to
>>>> be invalidated, then userspace needs to iterate through all of them an=
d do
>>>> this kernel notification separately.
>>>>
>>>> This patch adds a new option that allows userspace to invalidate all t=
he
>>>> inodes with a single notification operation.  In addition to invalidate
>>>> all the inodes, it also shrinks the sb dcache.
>>>>
>>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>>> ---
>>>>  fs/fuse/inode.c           | 33 +++++++++++++++++++++++++++++++++
>>>>  include/uapi/linux/fuse.h |  3 +++
>>>>  2 files changed, 36 insertions(+)
>>>>
>>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>>> index e9db2cb8c150..01a4dc5677ae 100644
>>>> --- a/fs/fuse/inode.c
>>>> +++ b/fs/fuse/inode.c
>>>> @@ -547,6 +547,36 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, =
u64 nodeid,
>>>>  	return NULL;
>>>>  }
>>>>=20=20
>>>> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
>>>> +{
>>>> +	struct fuse_mount *fm;
>>>> +	struct inode *inode;
>>>> +
>>>> +	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
>>>> +	if (!inode || !fm)
>>>> +		return -ENOENT;
>>>> +
>>>> +	/* Remove all possible active references to cached inodes */
>>>> +	shrink_dcache_sb(fm->sb);
>>>> +
>>>> +	/* Remove all unreferenced inodes from cache */
>>>> +	invalidate_inodes(fm->sb);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Notify to invalidate inodes cache.  It can be called with @nodeid =
set to
>>>> + * either:
>>>> + *
>>>> + * - An inode number - Any pending writebacks within the rage [@offse=
t @len]
>>>> + *   will be triggered and the inode will be validated.  To invalidat=
e the whole
>>>> + *   cache @offset has to be set to '0' and @len needs to be <=3D '0'=
; if @offset
>>>> + *   is negative, only the inode attributes are invalidated.
>>>> + *
>>>> + * - FUSE_INVAL_ALL_INODES - All the inodes in the superblock are inv=
alidated
>>>> + *   and the whole dcache is shrinked.
>>>> + */
>>>>  int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>>>>  			     loff_t offset, loff_t len)
>>>>  {
>>>> @@ -555,6 +585,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc,=
 u64 nodeid,
>>>>  	pgoff_t pg_start;
>>>>  	pgoff_t pg_end;
>>>>=20=20
>>>> +	if (nodeid =3D=3D FUSE_INVAL_ALL_INODES)
>>>> +		return fuse_reverse_inval_all(fc);
>>>> +
>>>>  	inode =3D fuse_ilookup(fc, nodeid, NULL);
>>>>  	if (!inode)
>>>>  		return -ENOENT;
>>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>>> index 5e0eb41d967e..e5852b63f99f 100644
>>>> --- a/include/uapi/linux/fuse.h
>>>> +++ b/include/uapi/linux/fuse.h
>>>> @@ -669,6 +669,9 @@ enum fuse_notify_code {
>>>>  	FUSE_NOTIFY_CODE_MAX,
>>>>  };
>>>>=20=20
>>>> +/* The nodeid to request to invalidate all inodes */
>>>> +#define FUSE_INVAL_ALL_INODES 0
>>>> +
>>>>  /* The read buffer is required to be at least 8k, but may be much lar=
ger */
>>>>  #define FUSE_MIN_READ_BUFFER 8192
>>>>=20=20
>>>
>>>
>>> I think this version might end up in=20
>>>
>>> static void fuse_evict_inode(struct inode *inode)
>>> {
>>> 	struct fuse_inode *fi =3D get_fuse_inode(inode);
>>>
>>> 	/* Will write inode on close/munmap and in all other dirtiers */
>>> 	WARN_ON(inode->i_state & I_DIRTY_INODE);
>>>
>>>
>>> if the fuse connection has writeback cache enabled.
>>>
>>>
>>> Without having it tested, reproducer would probably be to run
>>> something like passthrough_hp (without --direct-io), opening
>>> and writing to a file and then sending FUSE_INVAL_ALL_INODES.
>>=20
>> Thanks, Bernd.  So far I couldn't trigger this warning.  But I just found
>> that there's a stupid bug in the code: a missing iput() after doing the
>> fuse_ilookup().
>>=20
>> I'll spend some more time trying to understand how (or if) the warning y=
ou
>> mentioned can triggered before sending a new revision.
>>=20
>
> Maybe I'm wrong, but it calls=20
>
>    invalidate_inodes()
>       dispose_list()
>         evict(inode)
>            fuse_evict_inode()
>
> and if at the same time something writes to inode page cache, the
> warning would be triggered?=20
> There are some conditions in evict, like inode_wait_for_writeback()
> that might protect us, but what is if it waited and then just
> in the right time the another write comes and dirties the inode
> again?

Right, I have looked into that too but my understanding is that this can
not happen because, before doing that wait, the code does:

	inode_sb_list_del(inode);

and the inode state will include I_FREEING.

Thus, before writing to it again, the inode will need to get added back to
the sb list.  Also, reading the comments on evict(), if something writes
into the inode at that point that's likely a bug.  But this is just my
understanding, and I may be missing something.

Cheers,
--=20
Lu=C3=ADs

