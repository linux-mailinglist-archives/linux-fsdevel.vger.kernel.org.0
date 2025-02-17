Return-Path: <linux-fsdevel+bounces-41831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550A6A37F8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0490170458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB221764D;
	Mon, 17 Feb 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UkcCxTKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603E216E21;
	Mon, 17 Feb 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786870; cv=none; b=Rtdf4kGVfhP/MNP5D32nCFlk9cnEp2G+9jEsyKpBCgSoXkZzToTzb2jN5YidouCyL8fHOq+BItVkx6ebjUT77Zkl17N7z1y1FTktsD6bjR+NMK1XtmzPM4O2OJrjTtZ/G6IEvi9fTF1umUZm0GuBX5d8LzhZRoWRoaOEJch1sAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786870; c=relaxed/simple;
	bh=5/IjQkeBYD4d/cStPiejZlDt7vodPXq6xmtKi1k3FDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L9fqCjFoaddFxzoXIXJNxNOFoqaKa3oMnkmd0bBNPp1bJRfKjO/tRUzLvSrvt6ZDIr4chHT9I9itE4sQ5NZpsutJXObkaJFgoT+NQG0xZsSoGG2sjWF+7bOkztzdpbYfO3JkuMfwHjF3jtHAqJQmMy5Uqju6zUdt/ETBnqzBZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UkcCxTKk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=H9lvACYDcTxnetMlGUOowkbj5mIBN+ekAx2TaiKBiFo=; b=UkcCxTKkT2RuCEj6hXJJ5q20l4
	Sx87WVXExvqt1ecSanyYUWi1KsGYgNlxWp/phHWO5ugGhEUu9TAbOwXQ70uiqYGq9h7zyJNRNeeTn
	/U2rDZHASiHE59JnO6+oeaE5jVeYbDlghR/m3UfZNQQmxZne8ZH2/OwAtuD+WQ+1ff86Kgd7nJQLf
	LgWZcKpDfq0+R051/opg1W2MZmBRmiKeTTd8Jjb5IQeCHvAcFI5UzzUPzih/2hLYKr4PTakRFDdyA
	Gh9+PERxy1zmjpfri0Z+BT6QfObdu82PjHBZJMc+StM5nejqH3Occo2g3YL+cexZcsJAIAzfqcO0t
	O71LdIAw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tjy27-0060Q5-U9; Mon, 17 Feb 2025 11:07:29 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Dave Chinner <david@fromorbit.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Matt Harvey
 <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <3fac8c84-2c41-461d-92f1-255903fc62a9@ddn.com> (Bernd Schubert's
	message of "Mon, 17 Feb 2025 01:40:06 +0100")
References: <20250216165008.6671-1-luis@igalia.com>
	<20250216165008.6671-3-luis@igalia.com>
	<3fac8c84-2c41-461d-92f1-255903fc62a9@ddn.com>
Date: Mon, 17 Feb 2025 10:07:22 +0000
Message-ID: <87r03wx4th.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17 2025, Bernd Schubert wrote:

> On 2/16/25 17:50, Luis Henriques wrote:
>> Currently userspace is able to notify the kernel to invalidate the cache
>> for an inode.  This means that, if all the inodes in a filesystem need to
>> be invalidated, then userspace needs to iterate through all of them and =
do
>> this kernel notification separately.
>>=20
>> This patch adds a new option that allows userspace to invalidate all the
>> inodes with a single notification operation.  In addition to invalidate
>> all the inodes, it also shrinks the sb dcache.
>>=20
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>  fs/fuse/inode.c           | 33 +++++++++++++++++++++++++++++++++
>>  include/uapi/linux/fuse.h |  3 +++
>>  2 files changed, 36 insertions(+)
>>=20
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index e9db2cb8c150..01a4dc5677ae 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -547,6 +547,36 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u6=
4 nodeid,
>>  	return NULL;
>>  }
>>=20=20
>> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
>> +{
>> +	struct fuse_mount *fm;
>> +	struct inode *inode;
>> +
>> +	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
>> +	if (!inode || !fm)
>> +		return -ENOENT;
>> +
>> +	/* Remove all possible active references to cached inodes */
>> +	shrink_dcache_sb(fm->sb);
>> +
>> +	/* Remove all unreferenced inodes from cache */
>> +	invalidate_inodes(fm->sb);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Notify to invalidate inodes cache.  It can be called with @nodeid se=
t to
>> + * either:
>> + *
>> + * - An inode number - Any pending writebacks within the rage [@offset =
@len]
>> + *   will be triggered and the inode will be validated.  To invalidate =
the whole
>> + *   cache @offset has to be set to '0' and @len needs to be <=3D '0'; =
if @offset
>> + *   is negative, only the inode attributes are invalidated.
>> + *
>> + * - FUSE_INVAL_ALL_INODES - All the inodes in the superblock are inval=
idated
>> + *   and the whole dcache is shrinked.
>> + */
>>  int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>>  			     loff_t offset, loff_t len)
>>  {
>> @@ -555,6 +585,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u=
64 nodeid,
>>  	pgoff_t pg_start;
>>  	pgoff_t pg_end;
>>=20=20
>> +	if (nodeid =3D=3D FUSE_INVAL_ALL_INODES)
>> +		return fuse_reverse_inval_all(fc);
>> +
>>  	inode =3D fuse_ilookup(fc, nodeid, NULL);
>>  	if (!inode)
>>  		return -ENOENT;
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index 5e0eb41d967e..e5852b63f99f 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -669,6 +669,9 @@ enum fuse_notify_code {
>>  	FUSE_NOTIFY_CODE_MAX,
>>  };
>>=20=20
>> +/* The nodeid to request to invalidate all inodes */
>> +#define FUSE_INVAL_ALL_INODES 0
>> +
>>  /* The read buffer is required to be at least 8k, but may be much large=
r */
>>  #define FUSE_MIN_READ_BUFFER 8192
>>=20=20
>
>
> I think this version might end up in=20
>
> static void fuse_evict_inode(struct inode *inode)
> {
> 	struct fuse_inode *fi =3D get_fuse_inode(inode);
>
> 	/* Will write inode on close/munmap and in all other dirtiers */
> 	WARN_ON(inode->i_state & I_DIRTY_INODE);
>
>
> if the fuse connection has writeback cache enabled.
>
>
> Without having it tested, reproducer would probably be to run
> something like passthrough_hp (without --direct-io), opening
> and writing to a file and then sending FUSE_INVAL_ALL_INODES.

Thanks, Bernd.  So far I couldn't trigger this warning.  But I just found
that there's a stupid bug in the code: a missing iput() after doing the
fuse_ilookup().

I'll spend some more time trying to understand how (or if) the warning you
mentioned can triggered before sending a new revision.

Cheers,
--=20
Lu=C3=ADs

