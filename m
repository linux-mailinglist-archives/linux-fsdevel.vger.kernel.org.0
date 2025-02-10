Return-Path: <linux-fsdevel+bounces-41413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C2A2F259
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 16:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62D31886C5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8F4244E97;
	Mon, 10 Feb 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oCpARjO5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8E23DE95;
	Mon, 10 Feb 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203141; cv=none; b=tQ4DIjAQqhn3xo1JHni24BzCcBj5Gl/7wqoRlMHPzslbqEpKCWu68Jvy7+lVTLeaczm+86U3mQZtTWQrhWGVTKFp1l6Sg8UrLJMbFxCuOIBKsk8Z+pgRJGWHAFVLmABgl4MlMl6lQWKIuwOf8kWwhAMTVX3BCESWRUvcVd3MgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203141; c=relaxed/simple;
	bh=t9SogXVxL/5WPzfiLBOGrtGLBPCTLCQqLO9guXUl1mI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UrQDwROwOIgVCwEv2ql86uhPMLeSii60dTDUcJK7UQ81DATdR/S+ICtvAIi3ls3kehWEVLN8vef9KakQ8CAtea5s0djzYBx7J7cfVwIs3LMHJqb8tcI6dkwG885EKHh6syCYvfcai9X4qlQXU8TU8Di5+9tV8yJFV3CLmJfhsso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oCpARjO5; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qG5JSe/MUA8/F3lXIvVyeYzuIarTiII9ZoFYq4BQaKw=; b=oCpARjO5x5JDPDqTOABX1Kkwig
	2NRefj2TJAM0KRJ1wW2lBlJo792WS/ycXtR7Pa6GXFxu08cD9pq8ZsFt2G3gPD8DI/9wWRmj6YNf5
	E96PeBb8PovVe7yS7Nx5rDwqSpAXHeVc+XM/0oXIjjuC52+ezmDtlsYIV1flWYSPfzYkoflEL34AV
	WjCyIxtEI39xMsor/TosVve1jVmReLGY/xU1p36AvcM+jyPhxeiHmiN+P8RuJ1NiF6VplBPn5nbZk
	SN0mdT07mJKL0rpxQwNs3PAJLv7TkSKHUQguyTfWEH4zqnRyo4t9uUjo83wgI+0rktn3OpwjwAbUS
	y667BFIQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1thWBI-007Jn0-FE; Mon, 10 Feb 2025 16:58:50 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>,  Miklos Szeredi <miklos@szeredi.hu>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <400ffcf9-9b98-4e94-81eb-3e33177ba334@bsbernd.com> (Bernd
	Schubert's message of "Mon, 10 Feb 2025 16:18:30 +0100")
References: <20250210094840.5627-1-luis@igalia.com>
	<b5db41a7-1b26-4d12-b99f-c630f3054585@ddn.com>
	<87pljqyt10.fsf@igalia.com>
	<400ffcf9-9b98-4e94-81eb-3e33177ba334@bsbernd.com>
Date: Mon, 10 Feb 2025 15:58:41 +0000
Message-ID: <877c5xzt8u.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10 2025, Bernd Schubert wrote:

> On 2/10/25 11:48, Luis Henriques wrote:
>> [re-sending -- for some reason I did a simple 'reply', not a 'reply-all'=
.]
>>=20
>> On Mon, Feb 10 2025, Bernd Schubert wrote:
>>=20
>>> On 2/10/25 10:48, Luis Henriques wrote:
>>>> Currently userspace is able to notify the kernel to invalidate the cac=
he for
>>>> an inode.  This means that, if all the inodes in a filesystem need to =
be
>>>> invalidated, then userspace needs to iterate through all of them and d=
o this
>>>> kernel notification separately.
>>>>
>>>> This patch adds a new option that allows userspace to invalidate all t=
he
>>>> inodes with a single notification operation.  In addition to invalidat=
e all
>>>> the inodes, it also shrinks the sb dcache.
>>>>
>>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>>> ---
>>>> Hi!
>>>>
>>>> As suggested by Bernd, this patch v2 simply adds an helper function th=
at
>>>> will make it easier to replace most of it's code by a call to function
>>>> super_iter_inodes() when Dave Chinner's patch[1] eventually gets merge=
d.
>>>>
>>>> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit=
.com
>>>>
>>>>  fs/fuse/inode.c           | 59 +++++++++++++++++++++++++++++++++++++++
>>>>  include/uapi/linux/fuse.h |  3 ++
>>>>  2 files changed, 62 insertions(+)
>>>>
>>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>>> index e9db2cb8c150..be51b53006d8 100644
>>>> --- a/fs/fuse/inode.c
>>>> +++ b/fs/fuse/inode.c
>>>> @@ -547,6 +547,62 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, =
u64 nodeid,
>>>>  	return NULL;
>>>>  }
>>>>=20=20
>>>> +static void inval_single_inode(struct inode *inode, struct fuse_conn =
*fc)
>>>> +{
>>>> +	struct fuse_inode *fi;
>>>> +
>>>> +	fi =3D get_fuse_inode(inode);
>>>> +	spin_lock(&fi->lock);
>>>> +	fi->attr_version =3D atomic64_inc_return(&fc->attr_version);
>>>> +	spin_unlock(&fi->lock);
>>>> +	fuse_invalidate_attr(inode);
>>>> +	forget_all_cached_acls(inode);
>>>
>>>
>>> Thank you, much easier to read.
>>>
>>> Could fuse_reverse_inval_inode() call into this?
>>=20
>> Yep, it could indeed.  I'll do that in the next iteration, thanks!
>>=20
>>> What are the semantics=20
>>> for  invalidate_inode_pages2_range() in this case? Totally invalidate?
>>> No page cache invalidation at all as right now? If so, why?
>>=20
>> So, if I change fuse_reverse_inval_inode() to use this help, it will sti=
ll
>> need to keep the call to invalidate_inode_pages2_range().  But in the new
>> function fuse_reverse_inval_all(), I'm not doing it explicitly.  Instead,
>> that function calls into shrink_dcache_sb().  I *think* that by doing so
>> the invalidation will eventually happen.  Or am I wrong assuming that?
>
> I think it will drop it, if the dentry cache is the last user/reference
> of the inode. My issue is that it changes semantics a bit - without
> FUSE_INVAL_ALL_INODES the page cache is invalidated based on the given
> offset. Obviously we cannot give the offset for all inodes, but we
> at least document the different semantics in a comment above
> FUSE_INVAL_ALL_INODES? Sorry, should have asked earlier for it, just
> busy with multiple things in parallel...

Yep, that makes sense.  In fact, my initial approach was to add a
completely different API with a FUSE_NOTIFY_INVAL_INODE_ALL operation.
But then I realized that I could simply hijack FUSE_NOTIFY_INVAL_INODE.
This would make things a lot easier, specially in the userspace side --
libfuse could even be used without *any* change at all.  (Obviously, I
expect to send a PR with the new flag and some documentation once this
patch is acceptable.)

Anyway, I'll also add some comments to this patch.  Thanks for your
feedback, Bernd.

Cheers,
--=20
Lu=C3=ADs

