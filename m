Return-Path: <linux-fsdevel+bounces-69035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D340C6C3CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 02:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DD414EFF4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 01:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764523B60A;
	Wed, 19 Nov 2025 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="QdclkoG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="toI0Qua+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD221AC44D;
	Wed, 19 Nov 2025 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515397; cv=none; b=Rjmjh/l/J2/3FkuK0902tQnqMtq/viBt710Xe6f+vIJZaCiK4Wksbpjwhj4vcC4YLkcBhUkFTxIvErDfbjYt8nuOnhGFxWnET+x+hV7z8m02moWMoWkguEOszuOyi71Of45ix0hZ20Gs2BTgk1X4XT65Z1CxOIpJlheuFeNm7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515397; c=relaxed/simple;
	bh=3BHJOsDDaOjY+Ze1ZaiDkI2nwvPFCAPbRYjw3SnvSQk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ksRUjFmWxoMYRMJ0zW61BRclsAVxxAZLxS8YrCBE9c4KR0DwIQ/Jonuxw1BanT41NP2DfCzWlGaLsx/BOcKsymLvL8q2JZLwmA5t449f053rPfT62cluLi9npxqEA21v/fPDtFWOdshzpTJFg2MPMgdXY85/h00g8iwQbDLgAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=QdclkoG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=toI0Qua+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8745B1D0017D;
	Tue, 18 Nov 2025 20:23:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 18 Nov 2025 20:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763515392; x=1763601792; bh=n2MGgKYiTWxHbSt+dHoU+fa1gyL54VHILoL
	P5RKKXLY=; b=QdclkoG1kvEF+kfN7YN/XcYFix+N5zo8Y/gHLU5KjHmZYSToJE0
	R5JtltQG5LjL2t1yGNIbYhVQMhykL6MMni9YA8Y5Atfeq2db0E1jopd5mDaDs4n9
	tUkwbWXLboFUReT7ONUntnIF8j17ilp2BoWwCKFNEKb6YyZbX8AP9sNdEcu1igSD
	UHxE8nsDmFyCCmwg5lFr0t/4aIpZCJhgREo5K8+BIVz+WBCxR8z88Ke3c3yf3y+r
	m1d4triTVmpyFchv/1zAlk5lHIhejFJMWUZYVzHik5rhlzAHipmnwkmnNRniKN05
	sazRpSAy7VyQHZrUf92QK5KnpMaWugvp8bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763515392; x=
	1763601792; bh=n2MGgKYiTWxHbSt+dHoU+fa1gyL54VHILoLP5RKKXLY=; b=t
	oI0Qua+riG7y8gKygXou/aYOBw5XGwk+DgAETOSTylr6z2uKy1XGRd5wAS0uyvnz
	4sYigzWLd0EjUg2f8V54dyt0OTKXYiDpOIlX/Ae/A0LO/854iJies3DUArWWVYR0
	KQJInc+SPOnAHCe7CjfkSXTjQxbj0Ay2eRJ+QajFBDfG7y9cQT0xhIXJRNVmUN1l
	C+c9050gyV+D9fHlMytvI3owvhXDhoH/+Gk8d0yaPbN5c28MRenD5OMzbTTwi7LT
	f9JlcI0O9794vccgGBen5ym+YUKK+i7OS7husePEp/ikwKM+FEl3bbob2pHlVOZC
	fNE8h8/ReNWI+EBKKs2Ug==
X-ME-Sender: <xms:_xsdaQKZdDm7ylRJQfWTKziJxcrt4ZlKhBkEyywWms2X9L8uUyV6kw>
    <xme:_xsdab-Ru66599RME46Fn9lJy41CL9eo_3wE6IzU63yF9BN1eWBMjMLc1mLT-O2cg
    _wbP9hUdzIIJMkS1W67QeYXoHuna4OADh6-kia5LYhXeqabGw>
X-ME-Received: <xmr:_xsdaXLMSQR0HDbm0t-I4PkU9peWbsmUzw1p-IjBHKzSxVSszoWDc3pgTDwrVoR5pAD4D2sn9IM2Gv0qAgp0cwzWF7KRT2yRrWerLwDkFJHG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtth
    hopegurghirdhnghhosehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:_xsdaaF9XQoTzVDEnKvzgqs5aB29bT4RpSbEPtLJyC2xAfZk31ok4Q>
    <xmx:_xsdabyWwwoiByplJZ9O1KcRcgxxBKVobqcVuVHGozjCQuOxt9xbrQ>
    <xmx:_xsdaT6G56xgELWalyX3zkqHWnYRBvVh-BzNd5hsgrxwPjvu7CIYgw>
    <xmx:_xsdaQes6XzKGWv6fg5EyZ_GrQOezJ7oVUnzY9jAUhlLBb8HJx38hA>
    <xmx:ABwdaVV8gI2AyT87anhxrpgiwOH85TwSNl_EomBS0-hFlpIawynUeFmq>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 20:23:07 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 "Trond Myklebust" <trondmy@kernel.org>, "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v1 0/3] Allow knfsd to use atomic_open()
In-reply-to: <cover.1763483341.git.bcodding@hammerspace.com>
References: <cover.1763483341.git.bcodding@hammerspace.com>
Date: Wed, 19 Nov 2025 12:23:00 +1100
Message-id: <176351538077.634289.8846523947369398554@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 19 Nov 2025, Benjamin Coddington wrote:
> We have workloads that will benefit from allowing knfsd to use atomic_open()
> in the open/create path.  There are two benefits; the first is the original
> matter of correctness: when knfsd must perform both vfs_create() and
> vfs_open() in series there can be races or error results that cause the
> caller to receive unexpected results.  The second benefit is that for some
> network filesystems, we can reduce the number of remote round-trip
> operations by using a single atomic_open() path which provides a performance
> benefit. 
> 
> I've implemented this with the simplest possible change - by modifying
> dentry_create() which has a single user: knfsd.  The changes cause us to
> insert ourselves part-way into the previously closed/static atomic_open()
> path, so I expect VFS folks to have some good ideas about potentially
> superior approaches.

I think using atomic_open is important - thanks for doing this.

I think there is another race this fixes.
If the client ends and unchecked v4 OPEN request, nfsd does a lookup and
finds the name doesn't exist, it will then (currently) use vfs_create()
requesting an exclusive create.  If this races with a create happening
from another client, this could result in -EEXIST which is not what the
client would expect.  Using atomic_open would fix this.

However I cannot see that you ever pass O_EXCL to atomic_open (or did I
miss something?).  So I don't think the code is quite right yet.  O_EXCL
should be passed is an exclusive or checked create was requested.

With a VFS hat on, I would rather there were more shared code between
dentry_create() and lookup_open().  I don't know exactly what this would
look like, and I wouldn't want that desire to hold up this patch, but it
might be worth thinking about to see if there are any easy similarities
to exploit.

Thanks,
NeilBrown


> 
> Thanks for any comment and critique.
> 
> Benjamin Coddington (3):
>   VFS: move dentry_create() from fs/open.c to fs/namei.c
>   VFS: Prepare atomic_open() for dentry_create()
>   VFS/knfsd: Teach dentry_create() to use atomic_open()
> 
>  fs/namei.c         | 84 ++++++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4proc.c |  8 +++--
>  fs/open.c          | 41 ----------------------
>  include/linux/fs.h |  2 +-
>  4 files changed, 83 insertions(+), 52 deletions(-)
> 
> -- 
> 2.50.1
> 
> 


