Return-Path: <linux-fsdevel+bounces-41484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C04A2FC72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 22:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA531886A4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5970424CEFF;
	Mon, 10 Feb 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F5u+MBba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B69924C695;
	Mon, 10 Feb 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223573; cv=none; b=qn0pmiWZDKQdbN7J6fiMxU96Wsopb1tBCFnozm4aLnPqzQGG5+kIHHaE7apT6u5BBRoFcYsIctPm6WARCRkuevJQH0kWq26kaP8QqYCU5TSJrqWgawIf3QrBCay2I33LIixym61GuCREJXwoGvKKPhOqgdjsmz4JEykL29a/nMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223573; c=relaxed/simple;
	bh=pUd8G1lEHIr4FyqRhYKWcC0X0a1TUfs3GscBx3Y8kfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r5FYi3RDC9J1XZmmmzY4XEaW4jkrMlQY/JlBaQguGitZZdhyEpzMCWye9sMh+ZyFJQ1d9WpOPCtLbaTNEJSLIGSnF543sZK4LP4qnrGutZMf0JuyTpww+r2KJTxv8QtTWXRK558aElla3a+lhAModIKi6tDvgbUC8jYzmKVmNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F5u+MBba; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LXu9fiu+mUqGI1GuzBd2KNs6r7deHhqAfb3igrUF3No=; b=F5u+MBbaL47TNeo4+8Xmh7hue8
	UnMD9bAm06+PfPBcJBZ9OZgIbPqYZI1c/6GE91TLTJtYKY42X5QieIOPTUenXdT+Jw43qHw4PCmDR
	4i7npP4CiKsCirs1pQo5RAl9qxYKAI2dfnIxBsM1HMDHV1qKZfLVPz8HG59dQm7zbovFzxYp7ijd+
	UgFbU8+htaHnNb/UJD4pYzWtJM8qPDEuPV9hD5Lx90LQpkRsghQnBR1UQ36Rw9JI3OGTg5vPb1B6D
	M+BYgjSk5G9SXiyFekVVzgpNrcyUQsqpAMmiEGCcjXgEY/lqGPlw/EUsg8gmQn6+lrgoAnShpAk/9
	FiSY0rZA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1thbUr-007RfQ-D4; Mon, 10 Feb 2025 22:39:23 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Joanne Koong <joannelkoong@gmail.com>,  Miklos Szeredi
 <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>
Subject: Re: [RFC PATCH v3] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <a5c3eb63-0fab-4751-af2f-8cb48c06b47f@ddn.com> (Bernd Schubert's
	message of "Mon, 10 Feb 2025 20:06:55 +0000")
References: <20250210143351.31119-1-luis@igalia.com>
	<2b65778e-7d26-4168-9346-6c1e01de350b@gmail.com>
	<a5c3eb63-0fab-4751-af2f-8cb48c06b47f@ddn.com>
Date: Mon, 10 Feb 2025 21:39:14 +0000
Message-ID: <871pw5zdh9.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Joanne

Bernd has already added a few comments.  I'm just adding a few more on
top.

On Mon, Feb 10 2025, Bernd Schubert wrote:

> On 2/10/25 20:33, Joanne Koong wrote:
>> On 2/10/25 6:33 AM, Luis Henriques wrote:
>>> Currently userspace is able to notify the kernel to invalidate the cache
>>> for an inode.=C2=A0 This means that, if all the inodes in a filesystem =
need to
>>> be invalidated, then userspace needs to iterate through all of them
>>> and do
>>> this kernel notification separately.
>>>
>>> This patch adds a new option that allows userspace to invalidate all the
>>> inodes with a single notification operation.=C2=A0 In addition to
>>> invalidate all
>>> the inodes, it also shrinks the sb dcache.
>>>
>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>> ---
>>> * Changes since v2
>>> Use the new helper from fuse_reverse_inval_inode(), as suggested by
>>> Bernd.
>>>
>>> Also updated patch description as per checkpatch.pl suggestion.
>>>
>>> * Changes since v1
>>> As suggested by Bernd, this patch v2 simply adds an helper function that
>>> will make it easier to replace most of it's code by a call to function
>>> super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.
>>>
>>> [1] https://lore.kernel.org/r/20241002014017.3801899-3-
>>> david@fromorbit.com
>>>
>>> =C2=A0 fs/fuse/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 67 +++++++++++++++++++++++++++++++++++----
>>> =C2=A0 include/uapi/linux/fuse.h |=C2=A0 3 ++
>>> =C2=A0 2 files changed, 63 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index e9db2cb8c150..45b9fbb54d42 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -547,25 +547,78 @@ struct inode *fuse_ilookup(struct fuse_conn *fc,
>>> u64 nodeid,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> =C2=A0 }
>>> =C2=A0 +static void inval_single_inode(struct inode *inode, struct
>>> fuse_conn *fc)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct fuse_inode *fi;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 fi =3D get_fuse_inode(inode);
>>> +=C2=A0=C2=A0=C2=A0 spin_lock(&fi->lock);
>>> +=C2=A0=C2=A0=C2=A0 fi->attr_version =3D atomic64_inc_return(&fc->attr_=
version);
>>> +=C2=A0=C2=A0=C2=A0 spin_unlock(&fi->lock);
>>> +=C2=A0=C2=A0=C2=A0 fuse_invalidate_attr(inode);
>>> +=C2=A0=C2=A0=C2=A0 forget_all_cached_acls(inode);
>>> +}
>>> +
>>> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct fuse_mount *fm;
>>> +=C2=A0=C2=A0=C2=A0 struct super_block *sb;
>>> +=C2=A0=C2=A0=C2=A0 struct inode *inode, *old_inode =3D NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, NULL);
>>> +=C2=A0=C2=A0=C2=A0 if (!inode)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 fm =3D get_fuse_mount(inode);
>>=20
>> I think if you pass in &fm as the 3rd arg to fuse_ilookup(), it'll pass
>> back the fuse mount and we won't need get_fuse_mount().

Yeah, good catch!  That makes sense, I didn't noticed that this third
argument could be used that way.  I'll make sure next rev simplifies this
code.

>>> +=C2=A0=C2=A0=C2=A0 iput(inode);
>>> +=C2=A0=C2=A0=C2=A0 if (!fm)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
>>> +=C2=A0=C2=A0=C2=A0 sb =3D fm->sb;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 spin_lock(&sb->s_inode_list_lock);
>>> +=C2=A0=C2=A0=C2=A0 list_for_each_entry(inode, &sb->s_inodes, i_sb_list=
) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&inode->i_lock);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((inode->i_state & (I_FR=
EEING|I_WILL_FREE|I_NEW)) ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !at=
omic_read(&inode->i_count)) {
>>=20
>> Will inode->i_count ever be 0? AFAIU, inode->i_count tracks the inode
>> refcount, so if this is 0, doesn't this mean it wouldn't be on the sb-
>>>s_inodes list?

My point in having this check is that, while iterating the inodes list,
the inode may be iput()'ed before we actually have the chance to lock it.
This is simply to skip the (unlikely) case when this happens.  Maybe it's
not really necessary, maybe the previous checks (the ->i_state) are
enough.  But I've seen this pattern in other places (for example, in
evict_inodes()).

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
n_unlock(&inode->i_lock);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __iget(inode);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&inode->i_lock);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&sb->s_inode_li=
st_lock);
>>=20
>> Maybe worth adding a comment here since there can be inodes added after
>> the s_inode_list_lock is dropped and before it's acquired again that
>> when inodes get added to the head of sb->s_inodes, it's always for I_NEW
>> inodes.
>>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iput(old_inode);
>>=20
>> Maybe a dumb question but why is old_inode needed? Why can't iput()just
>> be called right after inval_single_inode()?
>
> I had wondered the same in v1. Issue is that there is a list iteration
> that releases the locks - if the put would be done immediately it could
> not continue on "old_inode" as it might not exist anymore.

Exactly, thanks Bernd.  We release the locks and do the cond_resched()
below for the cases where we have a huge amount of inodes to invalidate.

I'll prepare a new rev with some extra code comments (including those
suggested by Bernd before) and remove the call to get_fuse_mount().

Thank you both for your feedback.  Much appreciated!

Cheers,
--=20
Lu=C3=ADs

>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inval_single_inode(inode, f=
c);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_inode =3D inode;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cond_resched();
>>=20
>> Could you explain why a cond_resched() is needed here?
>
> Give other threads a chance to work? The list might be huge?
>
>
>
> Thanks,
> Bernd


