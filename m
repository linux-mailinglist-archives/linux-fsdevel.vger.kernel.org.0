Return-Path: <linux-fsdevel+bounces-42085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC9A3C513
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5730F189D10A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA881FE463;
	Wed, 19 Feb 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ihJ2db4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47BD1FBEB0;
	Wed, 19 Feb 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982704; cv=none; b=EGdsU5aMzBZ90jl7As6BYOrlx9HTwqPQHf8Dh3iZTXqIkBRsn+gXoVnI+1Neg6DUwvQNjBt1RuLosNnlIIFp1pj86O9GkkzUkSQLORkQOdKivuF+9XoCZSMjQE3wF0+lIES2LSBnzRsDHDbpHzsr42yORuIpbPlFkAdOdXttSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982704; c=relaxed/simple;
	bh=kScvtj0CmiaIsaBdVp7RnRZK3qaIvSEdNfxOqJe1nMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZbsiVBgKqLLgIlFGXkhpGFU7kUMrL4uMo+irTmvmM10KgJy/A9MTbAIvWJZ/iMXNHvO7X5SEHbC+QWwR6o3+LgJp9Xe2kfvRkrdZrIm5uVYUvwUpQsPZg97d7mpGRgHOZN5/zy5ccWYG+ot9D59BQPK+sIwSjP1vdUt1JRpOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ihJ2db4y; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Wh2NiKlrRJHAhrnRgglxjzPK0JRgg6l5YPt+TAPLTkg=; b=ihJ2db4yilg1wMgpDIQWHpnHFR
	QRjjZ6J/st+F7DB4W4p45H4sqkhh4RHX/ntUI7O0lCTFM0LPWwDmziOlvR07nk48seL2rA+ZopTiA
	KbRhblx6HTbumnMKeITZkyNDtQ1oKO0EZ5O/d9gF+8aS1IDt9UErkeWeYERosGWYjUVoJIEZ6Ik8j
	/saK+ui2iyX/5A+pxFn+DKUk1thM+H7b6N1wNp8vC1mdRfIbNa2bli1AVCO10lFxe/q1sJ1kK0lSk
	ro6ZZWmmYPuf4SHG5RG2LW4vc+ZAltKJRTtESFejMVdIsuoBf0VD7NHFhiQo96jGfKJyV9493iKuK
	iiv983Hg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkmyh-00ErAp-Te; Wed, 19 Feb 2025 17:31:21 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dave Chinner <david@fromorbit.com>,  Bernd Schubert <bschubert@ddn.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Matt Harvey
 <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Valentin Volkl <valentin.volkl@cern.ch>,
  Laura Promberger <laura.promberger@cern.ch>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <CAJfpegs-_sFPnMBwEa-2OSiaNriH6ZvEnM73vNZBiwzrSWFraw@mail.gmail.com>
	(Miklos Szeredi's message of "Wed, 19 Feb 2025 16:39:53 +0100")
References: <20250217133228.24405-1-luis@igalia.com>
	<20250217133228.24405-3-luis@igalia.com>
	<Z7PaimnCjbGMi6EQ@dread.disaster.area>
	<CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
	<87r03v8t72.fsf@igalia.com>
	<CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
	<87frkb8o94.fsf@igalia.com>
	<CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>
	<87tt8r6s3e.fsf@igalia.com> <Z7UED8Gh7Uo-Yj6K@dread.disaster.area>
	<87eczu41r9.fsf@igalia.com>
	<CAJfpegs-_sFPnMBwEa-2OSiaNriH6ZvEnM73vNZBiwzrSWFraw@mail.gmail.com>
Date: Wed, 19 Feb 2025 16:31:21 +0000
Message-ID: <87a5ah521y.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19 2025, Miklos Szeredi wrote:

> On Wed, 19 Feb 2025 at 12:23, Luis Henriques <luis@igalia.com> wrote:
>
>> +static int fuse_notify_update_epoch(struct fuse_conn *fc)
>> +{
>> +       struct fuse_mount *fm;
>> +       struct inode *inode;
>> +
>> +       inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
>> +       if (!inode) || !fm)
>> +               return -ENOENT;
>> +
>> +       iput(inode);
>> +       atomic_inc(&fc->epoch);
>> +       shrink_dcache_sb(fm->sb);
>
> This is just an optimization and could be racy, kicking out valid
> cache (harmlessly of course).  I'd leave it out of the first version.

OK, will do.

> There could be more than one fuse_mount instance.  Wondering if epoch
> should be per-fm not per-fc...

Good question.  Because the cache is shared among the several fuse_mount
instances the epoch may eventually affect all of them even if it's a
per-fm attribute.  But on the other hand, different mounts could focus on
a different set of filesystem subtrees so... yeah, I'll probably leave it
in fc for now while thinking about it some more.

>> @@ -204,6 +204,12 @@ static int fuse_dentry_revalidate(struct inode *dir=
, const struct qstr *name,
>>         int ret;
>>
>>         inode =3D d_inode_rcu(entry);
>> +       if (inode) {
>> +               fm =3D get_fuse_mount(inode);
>> +               if (entry->d_time < atomic_read(&fm->fc->epoch))
>> +                       goto invalid;
>> +       }
>
> Negative dentries need to be invalidated too.

Ack.

>> @@ -446,6 +452,12 @@ static struct dentry *fuse_lookup(struct inode *dir=
, struct dentry *entry,
>>                 goto out_err;
>>
>>         entry =3D newent ? newent : entry;
>> +       if (inode) {
>> +               struct fuse_mount *fm =3D get_fuse_mount(inode);
>> +               entry->d_time =3D atomic_read(&fm->fc->epoch);
>> +       } else {
>> +               entry->d_time =3D 0;
>> +       }
>
> Again, should do the same for positive and negative dentries.
>
> Need to read out fc->epoch before sending the request to the server,
> otherwise might get a stale dentry with an updated epoch.

Ah, good point.

> This also needs to be done in fuse_create_open(), create_new_entry()
> and fuse_direntplus_link().

Yeah I suspected there were a few other places where this would be
required.  I'll look closer into that.

Thanks a lot for your feedback, Miklos.  I'll work on this new approach,
so that I can send a real patch soon.

Cheers,
--=20
Lu=C3=ADs

