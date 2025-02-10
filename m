Return-Path: <linux-fsdevel+bounces-41384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECADA2E9EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 11:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8911884B39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62371D61B5;
	Mon, 10 Feb 2025 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K+JwDkOF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E51CB337;
	Mon, 10 Feb 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184529; cv=none; b=XY+7l+6+Fcu/395GY+sdPnGewpOlHzYUkcBc7/clsz4zDGQQi0zRDp0hR5F7Zbzu+1fkU5WU8sCYrvL1m7LFCRJxiPpiM25ZQxhilSt0egAMJupjeADVNidVWvoKLeuwTeNu/2IFtpeLMY7BRTwTpadVR8iEakLKOJapS0F01Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184529; c=relaxed/simple;
	bh=+++62FqyJUpu4h0Fs4qZYksjMnaHxdrYV6EtX0OnlUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QTPlndfs2qlhxKkz02GtSErKw5QeR1n+X3rOpP1z9dhsDvdXM9q9ssjwGyORLSF3ZqhxeG62WwyYnLWmhVq37iuxs8TfdYo0wMvjlXOY52TXvztOgY+eUqJrSQCXUTzRSqAaua88osZOPKxW4AXsCH5RL5YgtrwQJ7FTa5w/GbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K+JwDkOF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eNMrZugY6p5xhcNydkrbdN20xj//vuU8bkAAB3XLH8g=; b=K+JwDkOFl897vvO9tGmmPmO++b
	Q/Cer33anVwvEsluArYzuifBVNI/zf6NZRLciRzGagddmVUO7KVJ5iuegPbVHEXV7WM0jRXCLk0db
	E+IWx3raJpQ5jdhaxB6rX63GKGx7EOnf27hbPy1HenzQhWptnG8FVDBDNiWBiw4OW3MhBEl93FSQu
	V5gOw12sHDbpX56oXyaWz+NM6Ee0pRO/d112ZhYtSLPuPjijxW9G93RNDe7VY0kczKszDh7Uej4dp
	9PQgh1Q5NGPt/HpStepyvyRoNaGSkPvqLexwrOqL7uWXDg7WcUgGP6anzqbo5uF/ZYsjOi5IcJ3qN
	7XXCBWXg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1thRLB-007CVp-Ra; Mon, 10 Feb 2025 11:48:43 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <b5db41a7-1b26-4d12-b99f-c630f3054585@ddn.com> (Bernd Schubert's
	message of "Mon, 10 Feb 2025 09:58:21 +0000")
References: <20250210094840.5627-1-luis@igalia.com>
	<b5db41a7-1b26-4d12-b99f-c630f3054585@ddn.com>
Date: Mon, 10 Feb 2025 10:48:43 +0000
Message-ID: <87pljqyt10.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[re-sending -- for some reason I did a simple 'reply', not a 'reply-all'.]

On Mon, Feb 10 2025, Bernd Schubert wrote:

> On 2/10/25 10:48, Luis Henriques wrote:
>> Currently userspace is able to notify the kernel to invalidate the cache=
 for
>> an inode.  This means that, if all the inodes in a filesystem need to be
>> invalidated, then userspace needs to iterate through all of them and do =
this
>> kernel notification separately.
>>=20
>> This patch adds a new option that allows userspace to invalidate all the
>> inodes with a single notification operation.  In addition to invalidate =
all
>> the inodes, it also shrinks the sb dcache.
>>=20
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>> Hi!
>>=20
>> As suggested by Bernd, this patch v2 simply adds an helper function that
>> will make it easier to replace most of it's code by a call to function
>> super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.
>>=20
>> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.c=
om
>>=20
>>  fs/fuse/inode.c           | 59 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/fuse.h |  3 ++
>>  2 files changed, 62 insertions(+)
>>=20
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index e9db2cb8c150..be51b53006d8 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -547,6 +547,62 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u6=
4 nodeid,
>>  	return NULL;
>>  }
>>=20=20
>> +static void inval_single_inode(struct inode *inode, struct fuse_conn *f=
c)
>> +{
>> +	struct fuse_inode *fi;
>> +
>> +	fi =3D get_fuse_inode(inode);
>> +	spin_lock(&fi->lock);
>> +	fi->attr_version =3D atomic64_inc_return(&fc->attr_version);
>> +	spin_unlock(&fi->lock);
>> +	fuse_invalidate_attr(inode);
>> +	forget_all_cached_acls(inode);
>
>
> Thank you, much easier to read.
>
> Could fuse_reverse_inval_inode() call into this?

Yep, it could indeed.  I'll do that in the next iteration, thanks!

> What are the semantics=20
> for  invalidate_inode_pages2_range() in this case? Totally invalidate?
> No page cache invalidation at all as right now? If so, why?

So, if I change fuse_reverse_inval_inode() to use this help, it will still
need to keep the call to invalidate_inode_pages2_range().  But in the new
function fuse_reverse_inval_all(), I'm not doing it explicitly.  Instead,
that function calls into shrink_dcache_sb().  I *think* that by doing so
the invalidation will eventually happen.  Or am I wrong assuming that?

Cheers,
--=20
Lu=C3=ADs

