Return-Path: <linux-fsdevel+bounces-41994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A20A39DA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 14:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF6189640A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399D270ED1;
	Tue, 18 Feb 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T1XgF5GJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C39270EB9;
	Tue, 18 Feb 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885362; cv=none; b=T5NW9eox9U0IRGHTuC+d6UARaUbCcjjgGqvksdZmw1OgolKRPlUUzlgvhoeu3CNkjdXtuVjG2fDfE126deURcBPpyqm7NCsLP8QmFlvZA3yvoRSkh5Mt6YNH/Rcj1Raq0g/jlMwXXHzZpBcHKTayLdBkWWovC3GX4Lese/F9Ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885362; c=relaxed/simple;
	bh=rYjXngdQ0dbFzgwgn7WGaRs5H4t0BPJlZAYlLdGZ3MY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cvFmZD4WCHPzE+mC7m5yydKvLYb/acwmS96vG67uRBh0ppsKOlDlsxkMIK0NkPbWNcL9khAwnJxL+w6ff9Pe7+B0MYdgWpp84OOpmU+UZ9AX2NaI+b+pdA8R6Og7NXsnTs6OodpIJtl/CVnHWaPQQyt5J/cvLFqJUo8vqPkTpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=T1XgF5GJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=R9zhQrQxExKFJv3fYFW1IElfhSiSEpY6hem10hrKIVc=; b=T1XgF5GJTFc7sFp9yg3KuIyNhu
	MhzngxTkzJPcwWXf2K7zTycetZEIxkXJTrC65pGlgkQVN75mFxiKkqqT/ofRZ/5sV3bqjOXlQokOM
	ZSJIRtb4yEfo8w0o0/ssCp5l//pqLNpL0f3OZugQlNqHKrmBQ87KwpcT6osG30gddCPKTxKNsvrUt
	FZYVxaZs3XZKj7w86gVIswcvr8z0pjXnu77b1pb+MG5m21FSuzERou+6LEKQSa6uor22L0XgfhkMI
	rEqJI8LL6cMDcrooDk974GXUBpJDWyLcnWuCwzCEd/Vo9Y/d5qzbEjcXZ0yx7ZBJjEuvBgXctDaN6
	ASIDVTeA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkNeg-00AOyU-AF; Tue, 18 Feb 2025 14:29:00 +0100
From: Luis Henriques <luis@igalia.com>
To: Jan Kara <jack@suse.cz>
Cc: Bernd Schubert <bschubert@ddn.com>,  Miklos Szeredi <miklos@szeredi.hu>,
  Dave Chinner <david@fromorbit.com>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Matt
 Harvey <mharvey@jumptrading.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <bpevrif4k5h2l4pscsnsj3flwmwdw6w5nge5n7ji2yshk5pz6z@tngefti6stld>
	(Jan Kara's message of "Tue, 18 Feb 2025 12:57:28 +0100")
References: <20250216165008.6671-1-luis@igalia.com>
	<20250216165008.6671-3-luis@igalia.com>
	<3fac8c84-2c41-461d-92f1-255903fc62a9@ddn.com>
	<87r03wx4th.fsf@igalia.com>
	<847288fa-b66a-4f3d-9f50-52fa293a1189@ddn.com>
	<87ldu4x076.fsf@igalia.com>
	<bpevrif4k5h2l4pscsnsj3flwmwdw6w5nge5n7ji2yshk5pz6z@tngefti6stld>
Date: Tue, 18 Feb 2025 13:28:59 +0000
Message-ID: <877c5n8jqc.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18 2025, Jan Kara wrote:

> On Mon 17-02-25 11:47:09, Luis Henriques wrote:
>> On Mon, Feb 17 2025, Bernd Schubert wrote:
>> > On 2/17/25 11:07, Luis Henriques wrote:
>> >> On Mon, Feb 17 2025, Bernd Schubert wrote:
>> >>=20
>> >>> On 2/16/25 17:50, Luis Henriques wrote:
>> >>>> Currently userspace is able to notify the kernel to invalidate the =
cache
>> >>>> for an inode.  This means that, if all the inodes in a filesystem n=
eed to
>> >>>> be invalidated, then userspace needs to iterate through all of them=
 and do
>> >>>> this kernel notification separately.
>> >>>>
>> >>>> This patch adds a new option that allows userspace to invalidate al=
l the
>> >>>> inodes with a single notification operation.  In addition to invali=
date
>> >>>> all the inodes, it also shrinks the sb dcache.
>> >>>>
>> >>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> >>>> ---
>> >>>>  fs/fuse/inode.c           | 33 +++++++++++++++++++++++++++++++++
>> >>>>  include/uapi/linux/fuse.h |  3 +++
>> >>>>  2 files changed, 36 insertions(+)
>> >>>>
>> >>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> >>>> index e9db2cb8c150..01a4dc5677ae 100644
>> >>>> --- a/fs/fuse/inode.c
>> >>>> +++ b/fs/fuse/inode.c
>> >>>> @@ -547,6 +547,36 @@ struct inode *fuse_ilookup(struct fuse_conn *f=
c, u64 nodeid,
>> >>>>  	return NULL;
>> >>>>  }
>> >>>>=20=20
>> >>>> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
>> >>>> +{
>> >>>> +	struct fuse_mount *fm;
>> >>>> +	struct inode *inode;
>> >>>> +
>> >>>> +	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
>> >>>> +	if (!inode || !fm)
>> >>>> +		return -ENOENT;
>> >>>> +
>> >>>> +	/* Remove all possible active references to cached inodes */
>> >>>> +	shrink_dcache_sb(fm->sb);
>> >>>> +
>> >>>> +	/* Remove all unreferenced inodes from cache */
>> >>>> +	invalidate_inodes(fm->sb);
>> >>>> +
>> >>>> +	return 0;
>> >>>> +}
>> >>>> +
>> >>>> +/*
>> >>>> + * Notify to invalidate inodes cache.  It can be called with @node=
id set to
>> >>>> + * either:
>> >>>> + *
>> >>>> + * - An inode number - Any pending writebacks within the rage [@of=
fset @len]
>> >>>> + *   will be triggered and the inode will be validated.  To invali=
date the whole
>> >>>> + *   cache @offset has to be set to '0' and @len needs to be <=3D =
'0'; if @offset
>> >>>> + *   is negative, only the inode attributes are invalidated.
>> >>>> + *
>> >>>> + * - FUSE_INVAL_ALL_INODES - All the inodes in the superblock are =
invalidated
>> >>>> + *   and the whole dcache is shrinked.
>> >>>> + */
>> >>>>  int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>> >>>>  			     loff_t offset, loff_t len)
>> >>>>  {
>> >>>> @@ -555,6 +585,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *=
fc, u64 nodeid,
>> >>>>  	pgoff_t pg_start;
>> >>>>  	pgoff_t pg_end;
>> >>>>=20=20
>> >>>> +	if (nodeid =3D=3D FUSE_INVAL_ALL_INODES)
>> >>>> +		return fuse_reverse_inval_all(fc);
>> >>>> +
>> >>>>  	inode =3D fuse_ilookup(fc, nodeid, NULL);
>> >>>>  	if (!inode)
>> >>>>  		return -ENOENT;
>> >>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> >>>> index 5e0eb41d967e..e5852b63f99f 100644
>> >>>> --- a/include/uapi/linux/fuse.h
>> >>>> +++ b/include/uapi/linux/fuse.h
>> >>>> @@ -669,6 +669,9 @@ enum fuse_notify_code {
>> >>>>  	FUSE_NOTIFY_CODE_MAX,
>> >>>>  };
>> >>>>=20=20
>> >>>> +/* The nodeid to request to invalidate all inodes */
>> >>>> +#define FUSE_INVAL_ALL_INODES 0
>> >>>> +
>> >>>>  /* The read buffer is required to be at least 8k, but may be much =
larger */
>> >>>>  #define FUSE_MIN_READ_BUFFER 8192
>> >>>>=20=20
>> >>>
>> >>>
>> >>> I think this version might end up in=20
>> >>>
>> >>> static void fuse_evict_inode(struct inode *inode)
>> >>> {
>> >>> 	struct fuse_inode *fi =3D get_fuse_inode(inode);
>> >>>
>> >>> 	/* Will write inode on close/munmap and in all other dirtiers */
>> >>> 	WARN_ON(inode->i_state & I_DIRTY_INODE);
>> >>>
>> >>>
>> >>> if the fuse connection has writeback cache enabled.
>> >>>
>> >>>
>> >>> Without having it tested, reproducer would probably be to run
>> >>> something like passthrough_hp (without --direct-io), opening
>> >>> and writing to a file and then sending FUSE_INVAL_ALL_INODES.
>> >>=20
>> >> Thanks, Bernd.  So far I couldn't trigger this warning.  But I just f=
ound
>> >> that there's a stupid bug in the code: a missing iput() after doing t=
he
>> >> fuse_ilookup().
>> >>=20
>> >> I'll spend some more time trying to understand how (or if) the warnin=
g you
>> >> mentioned can triggered before sending a new revision.
>> >>=20
>> >
>> > Maybe I'm wrong, but it calls=20
>> >
>> >    invalidate_inodes()
>> >       dispose_list()
>> >         evict(inode)
>> >            fuse_evict_inode()
>> >
>> > and if at the same time something writes to inode page cache, the
>> > warning would be triggered?=20
>> > There are some conditions in evict, like inode_wait_for_writeback()
>> > that might protect us, but what is if it waited and then just
>> > in the right time the another write comes and dirties the inode
>> > again?
>>=20
>> Right, I have looked into that too but my understanding is that this can
>> not happen because, before doing that wait, the code does:
>>=20
>> 	inode_sb_list_del(inode);
>>=20
>> and the inode state will include I_FREEING.
>>=20
>> Thus, before writing to it again, the inode will need to get added back =
to
>> the sb list.  Also, reading the comments on evict(), if something writes
>> into the inode at that point that's likely a bug.  But this is just my
>> understanding, and I may be missing something.
>
> Yes. invalidate_inodes() checks i_count =3D=3D 0 and sets I_FREEING. Once
> I_FREEING is set nobody can acquire inode reference until the inode is
> fully destroyed. So nobody should be writing to the inode or anything like
> that.

Awesome, it's good to have that confirmed.  Thank you, Jan!

Cheers,
--=20
Lu=C3=ADs

