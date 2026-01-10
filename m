Return-Path: <linux-fsdevel+bounces-73140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A1BD0DE37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 22:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DEEA30378B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C42C17B3;
	Sat, 10 Jan 2026 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="bBJFBrVp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArSOpvaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D5D19D071;
	Sat, 10 Jan 2026 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768081984; cv=none; b=J0fPQUmdPF1DOtTUqAmJMJ9csx4t9oB/iezxf1cxV9dqr1D77mO8+YT9U7qaoUbSnhcKkheNpS0n6bQFPBbX8yv/RtFtDsSx0modW7Tq9VyxHMpdyJcm+LoW2BtAY4Ionwr7Yu10wivc+F477D59IndAIfBEofwngt0Mw39FuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768081984; c=relaxed/simple;
	bh=m3iskH270aGwbfj4CJgFyU6cFVbjs18Dtx80r9IQXYo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aQYHIwu2A8gHYOlNU+uqsC9hT8ANfHEOBGzjMqthUBVma2ODiTquKRSLg5H+0/exaXbAm3vceArvZmilE6Lucxou40I/1Mdn+N26mo3JlAB6isX08PcDgUY/7xkNZ6vgwjR38Mhssi2IpUiLO/Wb3fcCkdB+KUtrqly6Djwl6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=bBJFBrVp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArSOpvaE; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 822A47A004D;
	Sat, 10 Jan 2026 16:53:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 10 Jan 2026 16:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768081981; x=1768168381; bh=cQ46TQUnSNBVIE39WilVLzyeb/Asqn99Pxn
	vlCkyYjA=; b=bBJFBrVpRo6twoggM3Ca6h49vTl5nujfswZxu58t4XC9Ii6hrR8
	KB9uydebh5wmuyNqY90qo8yVmDp4i9un63PszmZdzDLtVXtw+ODTcdTiJV7W2eIQ
	gncbClnom8zq30t7XmtxnxT4SOYPv6Kh11rHqhoW9CAaAKDweTAvymTE4zHCLA9Y
	uTh394U+NTS1gOmqcbQoKlS5Upu8o0FLNx0Ey8FOq0HVbPbqwp4Emv7Qi61eDT4K
	tAKsyVNoWoyY7BdofhDetJgfgy2KdeN0XXMw/UjlACE/8Doy895JCZfxTmyYCCgE
	vHSXuu90rR/W4ZFUJCuLekPns/j04bTAYcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768081981; x=
	1768168381; bh=cQ46TQUnSNBVIE39WilVLzyeb/Asqn99PxnvlCkyYjA=; b=A
	rSOpvaELncSZcSVLx8anU64nZojds6xHAaolw3zt+BfIFFX7i54aV4p6Qq36nIrV
	oUh/iXg4jrOhh5r5s25u0k4GONTEIpNZZt/K4YiMRbweeFIf33Nqvx3WhE805lnY
	JA+9OMeE/LW70NWNNL3bGQoF2OT+Xj/Pfo9hTFkXNTpZfeYvwW9uFbVfnVRbnBXy
	5E5PXzyc2TgaSvRtXkjfDTjJ0Xz/hulGIgdZooJsDnLYFe3NfJM8HdVc2OTU8mUY
	ypYMxlLS6hT8Nag5h5ub2FEeskQOc+JR2inymO3C/lIKKuV8zMJJFtMXu++qqGPG
	2s2ArdR80iisBJKPwEJpQ==
X-ME-Sender: <xms:Pcpiaeusxngdf5J_tJfCHXO-8Eb32hgMOhRnxS-b4fb5ArsQyAgZ_g>
    <xme:PcpiafL6PJIEqXHA_s-NFtJTQClK68iAPwCUnl80HzVxdakTpEpYS3Pu2ZQUcmi73
    N1mHubwCINmjiOUJBe_kTSer9iOUqeq7Q27ftOcwaOy6WItCA>
X-ME-Received: <xmr:PcpiaWNG-XD3K_GUbaLmXTi8ROo2f_2qdmlF9qj4eydjppQVuaSaaii4maJXZcJC69hd3VxiAt6KH3gqSwoXQZoEGr1R-gcsZSPCysqGnPEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgv
    vhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrd
    gtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PcpiaSXCwSgTehl9v6uAm8IhnF2uU6iX7rBHVdAEj-7vHh-ju8rMUQ>
    <xmx:PcpiaUlfC1gLZwTZzmm6lLxYEGu2oeou7LJwPZYwbqFiX4FPp9dzig>
    <xmx:PcpiaRORf21xYLrGUxOhsSNECbdqTrZe7cBri29pGkjvrgpN7nGomg>
    <xmx:PcpiacLnnTWO7WqFU3N8wUFPHnVtknrziYyGDQ8rrW1vphWCS6WEhQ>
    <xmx:PcpiaeGeWAZ-XwrHV14nMTAAHsCmRfskPeh8WBzHC8KNSFGpiHGbJhc->
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 16:52:58 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 4/6] fs: invoke group_pin_kill() during mount teardown
In-reply-to: <0599548b-49c1-44e0-b0a8-a077cbdfbcce@kernel.org>
References: <20260108004016.3907158-1-cel@kernel.org>,
 <20260108004016.3907158-5-cel@kernel.org>,
 <176794792304.16766.452897252089076592@noble.neil.brown.name>,
 <50610e1c-7f09-4840-b2b2-f211dd6cdd5f@app.fastmail.com>,
 <20260110164946.GD3634291@ZenIV>,
 <0599548b-49c1-44e0-b0a8-a077cbdfbcce@kernel.org>
Date: Sun, 11 Jan 2026 08:52:56 +1100
Message-id: <176808197675.16766.18240422968401037143@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 11 Jan 2026, Chuck Lever wrote:
> On 1/10/26 11:49 AM, Al Viro wrote:
> > On Fri, Jan 09, 2026 at 11:04:49AM -0500, Chuck Lever wrote:
> > 
> >> Jeff mentioned to me privately that the fs_pin API may be deprecated,
> >> with its sole current consumer (BSD process accounting) destined for
> >> removal. I'm waiting for VFS maintainer review for confirmation on
> >> that before deciding how to address your comment. If fs_pin is indeed
> >> going away, building new NFSD infrastructure on top of it would be
> >> unwise, and we'll have to consider a shift in direction.
> > 
> > FWIW, fs_pin had never been a good API and experiments with using it
> > for core stuff had failed - we ended up with dput_to_list() and teaching
> > shrink lists to DTRT with mixed-fs lists instead.
> > 
> > TBH, I'd rather not see it growing more users.
> 
> Fair enough. I will look for a different solution.
> 
> 
> > Said that, more serious
> > problem is that you are mixing per-mount and per-fs things here.
> > 
> > Could you go over the objects you need to deal with?  What needs to be
> > hidden from the normal "mount busy" logics and revoked when a mount goes
> > away?
> > 
> > Opened files are obvious, but what about e.g. write count?
> 
> This is my understanding:
> 
> 1. Open/lock/delegation state in NFSv4 is represented to clients by an
> opaque token called a stateid. NFSv4 open, lock, and delegation stateids
> each have an open file associated with them.
> 
> 2. The "unexport" administrative interface on our NFS server does not
> revoke that state. It leaves it in place such that when the share is
> subsequently re-exported, the NFS client can present those stateids
> to the server and it will recognize and accept them. This makes a
> simple "re-export with new export options" operation non-disruptive.
> 
> 3. While the file system is unexported, I believe that those files are
> inaccessible from NFS clients: when an NFS client presents a file handle
> that resides on an unexported file system, the response is NFS4ERR_STALE
> until such a time when that share is re-exported.

There is also the complication that the in-kernel export information is
a cache while the authoritative information is in user-space.
It is perfectly OK to "exportfs -f" which flushed all export info from
the kernel and causes it to refill from user-space.  So the kernel
cannot drop state when its export tables are empty.

> 
> 4. The result is that if a share is unexported while NFSv4 clients still
> have that share mounted, open/lock/delegation state remains in place,
> and the underlying files remain open on the NFS server. That prevents
> the shared file system from being unmounted (which is sometimes the very
> next step after unexport). As long as the NFS client maintains its lease
> (perhaps because it has other shares mounted on that server), those
> files remain open.
> 
> The workaround is that the server administrator has to use NFSD's
> "unlock file system" UI first to revoke the state IDs and close the
> files. Then the file system can be unmounted cleanly.
> 

We could possible add a "--unmount" or similar option to "exportfs -u"
which invokes the "unlock file system" UI, and encourage people to use
that before unmount.

> 
> Help me understand what you mean by write count? Currently, IIUC, any
> outstanding writes are flushed when each of the files that backs a
> stateid is closed.

I think Al refers to the count managed by mnt_want_write() and
mnt_drop_write(). 

I think nfsd always balances these for a given transaction, so when all
nfsd threads have stopped the write count in neutral.

Obviously all files open for write will imply a writecount, but there
is no other write count to be managed.

NeilBrown

> 
> 
> -- 
> Chuck Lever
> 


