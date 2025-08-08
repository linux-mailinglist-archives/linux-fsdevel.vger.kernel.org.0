Return-Path: <linux-fsdevel+bounces-57053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FBCB1E66F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA2B24E38B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1AC2741D0;
	Fri,  8 Aug 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sRc44Oza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C34156228;
	Fri,  8 Aug 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648866; cv=none; b=D9V5BLxd18AfhwZTQnfnznihxN+6ikYD8mW/mc5nmZbPR9RdjCE+RbBScofzq4aKVJOI+GPRil+JQAABL7f4HD6V1av19yEZANWQQ9uLxmXzfu0pHsw8OwSaVUwBd1ZUAjvscefXRNjFQmWRBAcbubhzDUUhCRyQt9pdl8CZ9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648866; c=relaxed/simple;
	bh=IOa2BR4LpvfZrae90RszxtU1ig3d5u2WB2gxD1gy0SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNIYGElsN2NzaUZ+CLt8MJ+X8vdL7joTD3mTqZFMF7mPv9nhojWCscMNK0rth/AZKZanmCa9cYBy2VvSR26pxgZzADDZ70cEEVkNuSSmWS0/HU7+d1jwzySZMfn/ig21INJ6q6/TeiaKI1UFPE8YrjlOxyfUKEmHFGX+AVLOC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sRc44Oza; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 50B1814C2D3;
	Fri,  8 Aug 2025 12:27:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1754648855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bqUxzr3feljf19Z74jNSXA0Vn9kV/vutqFw9326ggZ0=;
	b=sRc44OzaMabfqv8JbDv//0noQ7tTRtsJakABMEJm5Dk0LDi1I/f0lBxwOCd2UbJTahwi1U
	Q1MuGOx4HKsYRYsGVb8R4WmO+hcFn8AD9ZxD9FeBoub3MFLNtZiLezNFJlOcQUh/2muGSQ
	o/sy8i4BcxQqIOGUdq+ETopn8WpvY6/Tgnz8su/vut0Bo+hcrwd7TdhovG3ekdorqBiBIG
	Rgz2aDezJb9DIGHIOBIGnVwUoBUU913sGEjjtep5Tel4weiVZx2aLyOBfbMyCgnl3JMaj4
	128nexclltaoWNE1jkSlj7rCBhuJhh4Gjlr1UXAPXs9h0RL4SuiVvYfF/bfRDQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c66f225c;
	Fri, 8 Aug 2025 10:27:30 +0000 (UTC)
Date: Fri, 8 Aug 2025 19:27:15 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <aJXRAzCqTrY4aVEP@codewreck.org>
References: <cover.1743971855.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1743971855.git.m@maowtm.org>

Sorry for the delay...

Tingmao Wang wrote on Sun, Apr 06, 2025 at 09:43:01PM +0100:
> Unrelated to the above problem, it also seems like even with the revert in
> [2], because in cached mode inode are still reused based on qid (and type,
> version (aka mtime), etc), the setup mentioned in [2] still causes
> problems in th latest kernel with cache=loose:

cache=loose is "you're on your own", I think it's fine to keep as is,
especially given qemu can handle it with multidevs=remap if required

> With the above in mind, I have a proposal for 9pfs to:
> 1. Reuse inodes even in uncached mode
> 2. However, reuse them based on qid.path AND the actual pathname, by doing
>    the appropriate testing in v9fs_test(_new)?_inode(_dotl)?

I think that's fine for cache=none, but it breaks hardlinks on
cache=loose so I think this ought to only be done without cache
(I haven't really played with the cache flag bits, not check pathname if
any of loose, writeback or metadata are set?)

> The main problem here is how to store the pathname in a sensible way and
> tie it to the inode.  For now I opted with an array of names acquired with
> take_dentry_name_snapshot, which reuses the same memory as the dcache to
> store the actual strings, but doesn't tie the lifetime of the dentry with
> the inode (I thought about holding a reference to the dentry in the
> v9fs_inode, but it seemed like a wrong approach and would cause dentries
> to not be evicted/released).

That's pretty hard to get right and I wish we had more robust testing
there... But I guess that's appropriate enough.

I know Atos has done an implementation that keeps the full path
somewhere to re-open fids in case of server reconnections, but that code
has never been submitted upstream that I can see so I can't check how
they used to store the path :/ Ohwell.

> Storing one pathname per inode also means we don't reuse the same inode
> for hardlinks -- maybe this can be fixed as well in a future version, if
> this approach sounds good?

Ah, you pointed it out yourself. I don't see how we could fix that, as
we have no way other than the qid to identify hard links; so this really
ought to depend on cache level if you want to support landlock/*notify
in cache=none.

Frankly the *notify use-case is difficult to support properly, as files
can change from under us (e.g. modifying the file directly on the host
in qemu case, or just multiple mounts of the same directory), so it
can't be relied on in the general case anyway -- 9p doesn't have
anything like NFSv4 leases to get notified when other clients write a
file we "own", so whatever we do will always be limited...
But I guess it can make sense for limited monitoring e.g. rebuilding
something on change and things like that?


-- 
Dominique Martinet | Asmadeus

