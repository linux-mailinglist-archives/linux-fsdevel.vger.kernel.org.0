Return-Path: <linux-fsdevel+bounces-39317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFEBA12A74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454F818811A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF8D1D5ACD;
	Wed, 15 Jan 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bA+FOa7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7E155C96;
	Wed, 15 Jan 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736964521; cv=none; b=lnIMBzoBn6gtFYWNOTavAtkhA6IjdHRuzZRvgk6f+GV0qwpOH38CuiYw60H6M7UGdxxomyBdqwlaICqvdDkctJFyVgBHKczIs8ifpn9L18SO+Y95YXheqtWopasYu122cs2VrIyLWlslK1xrCL8teH5c+sb85VnwvOl20yuhY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736964521; c=relaxed/simple;
	bh=Q7Yl41Spkx2NMr1UAKJjSoCfRY1mnM1RmnqZ5CqEd38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSS4o3WRG3lV8A/fPYouee/v7di0oakrVU9iuhbZ6CszB9CqY279DJhkBWajYniaerl8v8VAFoXXxSjPbW7b0E6DtsgD2KdLe/nLKAjmEpQSR9GfXSCbU67FsUeMsTh8vl9Qc5Jw5ir71UozTQkP+NkuNhtx2Kp3YnzY22ivXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bA+FOa7U; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CB9dybXLSuemdc03Jitv4DsVkXDoDvpXraN4s3zQDRE=; b=bA+FOa7UKQjqbN3dok6Nmzh6Cp
	8MLh06KCCHinuArjbf4yDO7nqFVpUkQqC/yXC/VBI9fMV1I4CsMQWuzcz3GFpSl8KibJGxxCogEhZ
	3J2kksJuzrOdc1TYebl52gA7tEulhNAltTl9FdQHv8aC6iDdWiAIxAfBbrycwGwIdrWQnx/Upxzoc
	5jjpy1qYFnxnwQbseX02+J4Fh5/GhJ2nloBHsk5dhVq2Uc4dSTp+jCguuejeAnDAi4GYMfjSF5ly8
	nuL3O1KfY3Lc1ut/xaA6p4UIKXJ81fa0TG+gz1l0QmP42e1NYHoxo397BpNN4t8s5Z4RNNXB/ab9F
	lxhl1ZuQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tY7oe-00GCL0-BK; Wed, 15 Jan 2025 19:08:32 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>
Subject: Re: [RFC PATCH] fuse: add new function to invalidate cache for all
 inodes
In-Reply-To: <9e876952-4603-4bf4-a3a0-9369d99d74c6@bsbernd.com> (Bernd
	Schubert's message of "Wed, 15 Jan 2025 17:43:35 +0100")
References: <20250115163253.8402-1-luis@igalia.com>
	<9e876952-4603-4bf4-a3a0-9369d99d74c6@bsbernd.com>
Date: Wed, 15 Jan 2025 18:07:48 +0000
Message-ID: <87h660lzm3.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

On Wed, Jan 15 2025, Bernd Schubert wrote:

> On 1/15/25 17:32, Luis Henriques wrote:
>> Currently userspace is able to notify the kernel to invalidate the cache
>> for an inode.  This means that, if all the inodes in a filesystem need to
>> be invalidated, then userspace needs to iterate through all of them and =
do
>> this kernel notification separately.
>>=20
>> This patch adds a new option that allows userspace to invalidate all the
>> inodes with a single notification operation.  In addition to invalidate =
all
>> the inodes, it also shrinks the superblock dcache.
>
> Out of interest, what is the use case?

This is for a read-only filesystem.  However, the filesystem objects
(files, directories, ...) may change dramatically in an atomic way, so
that a totally different set of objects replaces the old one.

Obviously, this patch would help with the process of getting rid of the
old generation of the filesystem.

>>=20
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>> Just an additional note that this patch could eventually be simplified if
>> Dave Chinner patch to iterate through the superblock inodes[1] is merged.
>>=20
>> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.c=
om
>>=20
>>  fs/fuse/inode.c           | 53 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/fuse.h |  3 +++
>>  2 files changed, 56 insertions(+)
>>=20
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 3ce4f4e81d09..1fd9a5f303da 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -546,6 +546,56 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u6=
4 nodeid,
>>  	return NULL;
>>  }
>>=20=20
>> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
>> +{
>> +	struct fuse_mount *fm;
>> +	struct super_block *sb;
>> +	struct inode *inode, *old_inode =3D NULL;
>> +	struct fuse_inode *fi;
>> +
>> +	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, NULL);
>> +	if (!inode)
>> +		return -ENOENT;
>> +
>> +	fm =3D get_fuse_mount(inode);
>> +	iput(inode);
>> +	if (!fm)
>> +		return -ENOENT;
>> +	sb =3D fm->sb;
>> +
>> +	spin_lock(&sb->s_inode_list_lock);
>> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>
> Maybe list_for_each_entry_safe() and then you can iput(inode) before the
> next iteration?

I can rework this loop, but are you sure it's safe to use that?  (Genuine
question!)

I could only find two places where list_for_each_entry_safe() is being
used to walk through the sb inodes.  And they both use an auxiliary list
that holds the inodes to be processed later.  All other places use the
pattern I'm following here.

Or did I misunderstood your suggestion?

Cheers,
--=20
Lu=C3=ADs


>> +		spin_lock(&inode->i_lock);
>> +		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
>> +		    !atomic_read(&inode->i_count)) {
>> +			spin_unlock(&inode->i_lock);
>> +			continue;
>> +		}
>> +
>> +		__iget(inode);
>> +		spin_unlock(&inode->i_lock);
>> +		spin_unlock(&sb->s_inode_list_lock);
>> +		iput(old_inode);
>> +
>> +		fi =3D get_fuse_inode(inode);
>> +		spin_lock(&fi->lock);
>> +		fi->attr_version =3D atomic64_inc_return(&fm->fc->attr_version);
>> +		spin_unlock(&fi->lock);
>> +		fuse_invalidate_attr(inode);
>> +		forget_all_cached_acls(inode);
>> +
>> +		old_inode =3D inode;
>> +		cond_resched();
>> +		spin_lock(&sb->s_inode_list_lock);
>> +	}
>> +	spin_unlock(&sb->s_inode_list_lock);
>> +	iput(old_inode);
>
>
> Thanks,
> Bernd


