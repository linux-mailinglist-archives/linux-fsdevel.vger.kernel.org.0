Return-Path: <linux-fsdevel+bounces-61386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A26B57BEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EF92071DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE24230C37B;
	Mon, 15 Sep 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="hcO1pnFt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241AC3074B2;
	Mon, 15 Sep 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940826; cv=none; b=o38qtZZgswcCrTslikT/JIX79PjMrQ9+3iKZl+fF+EFG9WWYb9xfbPPRFkr5I+a4Fx8iyqxwd7ecv2VBlwbBnRL5yq+aA25nM4Egj63lJnFLR+Ts6NnqM0FKvI3xWjAro6RuS7Dmh8hmBwx+SZuDE+imRryQq1aun4YRaEJ6WYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940826; c=relaxed/simple;
	bh=hSQtf2xZ9VZMBMIMCULgMm7F4vxjQpzd06Vkz1GnatM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ol9J94wM0T7QwdUarLOonvnc3x24xPbs4kg7zcmWxCBnl9HLQnz14Wa/AxMbbzRk+BX+6tz7ctfgz8e2b5dbvP9Is3t+xntXrCUd9+Im7chLhyNpC8VwWmKrsUJ1LiTNAbknPKYze+2DZS/VP2LnvAqtJlgqQGVsjXUMcjugB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=hcO1pnFt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1F28614C2D3;
	Mon, 15 Sep 2025 14:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1757940815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3eQubYbU03SDvmqC/cwpB/svZp0T/fBlcYKKr0v3+0=;
	b=hcO1pnFtfnahPJjEVqG8XBEUztGYBKj6orke8pTJqyHW2kGZXwyurBe6ag0JRV5LGn9GnI
	Aq8slkexoD8rnTuLfswB/4zZ97jAgYTa00OZ7qRcYzWzHVL6CdaUeeQWVK36g413HCbKYc
	U2IskcILYzDbCXIDBR0Xcs40uBT86pmptVXZYufWYLe7ThryRrFVYCYyB3e48KbCopG4cE
	J1o546mAmBjWhauwIEWFToZibqSYqxQ900XGNFpmKeU5tvW8mXrinokScguQeu0CG8xan9
	mVBMFmFukW0jmca8eaj1DDdiavqc52DtM3D0h6E3pCIupDR0rwbeDoTJGZja4Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id bdece2e9;
	Mon, 15 Sep 2025 12:53:29 +0000 (UTC)
Date: Mon, 15 Sep 2025 21:53:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <aMgMOnrAOrwQyVbp@codewreck.org>
References: <cover.1756935780.git.m@maowtm.org>
 <2acd6ae7-caf5-4fe7-8306-b92f5903d9c0@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2acd6ae7-caf5-4fe7-8306-b92f5903d9c0@maowtm.org>

Hi Tingmao,

thanks for pushing this forward, I still have very little time so
haven't been able to review this properly

Tingmao Wang wrote on Sun, Sep 14, 2025 at 10:25:02PM +0100:
> I had a chat with Mickaël earlier this week and some discussion following
> that, and we thought of a potential alternative to what I was proposing
> here that might work for Landlock: using the inode number (or more
> correctly, qid.path) directly as the keys for Landlock rules when
> accessing 9p files.  I'm not sure how sound this is from the perspective
> of 9pfs (there are pros and caveats), and I would like to gather some
> thoughts on this idea.

I'm honestly split on this:
- I really don't like tracking the full path of each file around;
there are various corner cases with files being removed (possibly server
side!) or hard links; and it's potentially slowing down all operations a
bit...
- OTOH as you pointed out qid isn't as reliable, and having file paths
around opens the way to rebuilding fids on reconnect for non-local
servers, which could potentially be interesting (not that I ever see
myself having time to work on this as I no longer have any stake there,
I just know that would have interested my previous employer when they
were still using 9p/rdma...)

> In discussion with Mickaël he thought that it would be acceptable for
> Landlock to assume that the server is well-behaved, and Landlock could
> specialize for 9pfs to allow access if the qid matches what's previously
> seen when creating the Landlock ruleset (by using the qid as the key of
> the rule, instead of a pointer to the inode).

I'm not familiar at all with landlock so forgive this question: what is
this key about exactly?
When a program loads a ruleset, paths referred in that ruleset are
looked up by the kernel and the inodes involved kept around in some hash
table for lookup on further accesses?

I'm fuzzy on the details but I don't see how inode pointers would be
stable for other filesystems as well, what prevents
e.g. vm.drop_caches=3 to drop these inodes on ext4?

In general I'd see the file handle (as exposed to userspace by
name_to_handle_at) as a stable key, that works for all filesystems
supporting fhandles (... so, not 9p, right... But in general it's
something like inode number + generation, and we could expose that as
handle and "just" return ENOTSUP on open_by_handle_at if that helps)

Although looking at the patches what 9p seems to need isn't a new stable
handle, but "just" not allocating new inodes in iget5...
This was attempted in 724a08450f74 ("fs/9p: simplify iget to remove
unnecessary paths"), but later reverted in be2ca3825372 ("Revert "fs/9p:
simplify iget to remove unnecessary paths"") because it broke too many
users, but if you're comfortable with a new mount option for the lookup
by path I think we could make a new option saying
"yes_my_server_has_unique_qids"... Which I assume would work for
landlock/fsnotify?

If you'd like to try, you can re-revert these 4 patches:
Fixes: be2ca3825372 ("Revert "fs/9p: simplify iget to remove unnecessary paths"")
Fixes: 26f8dd2dde68 ("Revert "fs/9p: fix uaf in in v9fs_stat2inode_dotl"")
Fixes: fedd06210b14 ("Revert "fs/9p: remove redundant pointer v9ses"")
Fixes: f69999b5f9b4 ("Revert " fs/9p: mitigate inode collisions"")

If that works, and having this only work when a non-default option is
set is acceptable, I think that's as good a way forward as we'll find.

> 1. The qid is 9pfs internal data, and we may need extra API for 9pfs to
>    expose this to Landlock.  On 64bit, this is easy as it's just the inode
>    number (offset by 2), which we can already get from the struct inode.
>    But perhaps on 32bit we need a way to expose the full 64bit server-sent
>    qid to Landlock (or other kernel subsystems), if we're going to do
>    this.

I'm not sure how much effort we want to spend on 32bit: as far as I
know, if we have inode number collision on 32 bit we're already in
trouble (tools like tar will consider such files to be hardlink of each
other and happily skip reading data, producing corrupted archives);
this is not a happy state but I don't know how to do better in any
reasonable way, so we can probably keep a similar limitation for 32bit
and use inode number directly...

> 2. Even though qids are supposed to be unique across the lifetime of a
>    filesystem (including deleted files), this is not the case even for
>    QEMU in multidevs=remap mode, when running on ext4, as tested on QEMU
>    10.1.0.

I'm not familiar with the qid remap implementation in qemu, but I'm
curious in what case you hit that.
Deleting and recreating files? Or as you seem to say below the 'qid' is
"freed" when fd is closed qemu-side and re-used by later open of other
files?

If this is understood I think this can be improved, reusing the qid on
different files could yield problems with caching as well so I think
it's something that warrants investigations.

>    Unfortunately, holding a dentry in Landlock prevents the filesystem
>    from being unmounted (causes WARNs), with no (proper) chance for
>    Landlock to release those dentries.  We might do it in
>    security_sb_umount, but then at that point it is not guaranteed that
>    the unmount will happen - perhaps we would need a new security_ hooks
>    in the umount path?

Hmm yeah that is problematic, I don't see how to take "weak" refs that
wouldn't cause a warning for the umount to free yet still prevent
recycling the inode, so another hook to free up resources when really
umounting sounds appropriate if we go that way... At least umount isn't
usually performance sensitive so it would probably be acceptable?


-- 
Dominique Martinet | Asmadeus

