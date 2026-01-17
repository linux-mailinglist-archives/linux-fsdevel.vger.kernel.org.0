Return-Path: <linux-fsdevel+bounces-74281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D649D38B4D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 02:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E2F30581DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 01:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D262A29E0E7;
	Sat, 17 Jan 2026 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Sz/eX9zE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QxM1Bwd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E52C1598;
	Sat, 17 Jan 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768613120; cv=none; b=LXWr+5UsE9U3V8O+6iwVxCHqFPSFczK+mRg3rBNzRlPVLHVWCc9OMmP4DUC5+iT6Gi54igLS8yFg7tFN3vt088kFd228FcIs6FlJuIQ8bGRAHYNbHcnnjc3XYX+wrS6eS5bRt/PyGM47u13j4juFxLTkA3zsv1mXqvLX7izo6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768613120; c=relaxed/simple;
	bh=25BjdNvkd/QJV2qq5wIrGc5STP+h1APA4/ncDfBLEOg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=W7dMx+2y0W7fLFY62WpLzxemeYiMvdrBWY7rFUjv80i6jB4nfgaFlZB6Kyov5pAZx/DwFM6w5I+GohiEzSTsQhVOG+WcK4h2T2zh0Wi14AGsh27n2J6s1PJpjkrdFa44Wsjy+O2SPOwVXjCEel7jdEczP8lcWTtuQ8eZUmMheFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Sz/eX9zE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxM1Bwd5; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF3EE7A0129;
	Fri, 16 Jan 2026 20:25:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 16 Jan 2026 20:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768613104; x=1768699504; bh=daNR05VqrcPspOst4PbWUlRurctie+9QvyA
	UlztMOmY=; b=Sz/eX9zEz/I8hrMd0xazFKV3U4eoQEXhMHy82+qJTH98gibUnwB
	6Sk1dnqUQoxeCms1WcZv8CRpHeCD4vuUMtOgXCBxzb2n7h20fy8iBdcYO/t1cc9K
	HrlC390/2EviByl/t8OkA18ZchJbGWwF/uN4OqHIQbQZSMXEHPlQucwDwUFtPacO
	y6ZWRTHY5EB5hN1IaahpxQ1a4ckzyCW/hqh+SwnYpVFecowvTZz/ro4yrngbTvY5
	WX3I11FqrSxtfBX5I9Lr/WmcviAI8ybab1zhncA2AY9Ix0NMpYQ1Z7DU+zwKcozi
	6WwCYgS67xJ4oSbV3Cfn1a7s/tQ7jO/xdNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768613104; x=
	1768699504; bh=daNR05VqrcPspOst4PbWUlRurctie+9QvyAUlztMOmY=; b=Q
	xM1Bwd5EMbwZGi27GPnHU4GJq61ZYZ8PGd/ozhBjnJz8fES0nGKjlFu/Hzia78Kr
	enfCMCnrr/H8Lovwy5685i+SI0e+OSlP0hB9Td2yTR5M8IRDEW2DUXRc/pILY8x4
	0OKK3mLD/JTNtgv6IG0t49/O2CfFUUFaMXK4u8r4hWi51O14Ul5FEg+6BjRCPIT7
	qUYfM8FoegPy/9SLbA0EEWgdEDBJJ/pPRGsx66o34SmJXOta88RXj6gfoMEEM4oj
	E8JjuyEcGrZ1a2bk4T5M0xNDhqYuIISP6XLhncJQnxiQooVzQjF6RHrVqj8fgvmc
	BwWOGliMl++jtaR+4b+Vw==
X-ME-Sender: <xms:8ORqaQ_ttQv8DHKKv7WVcrUfKS8K4o7dWn1xMq-bKWg-azkCAze3dg>
    <xme:8ORqaevgR9QixUMwyks4wtA3Dcg-rJyWUpl3QtlNImFSmGOOE9YWcaPa3Eun5nP4V
    FMEo_xKGLN-9d7cfRWUJSASeQcTA0aWZ-Fpvzg8gcv1Pmwd>
X-ME-Received: <xmr:8ORqaQ1PEq3OxAZE6XZkVzB6E6QZ8nwSKQQU_BT3OGvqg8w1vmqGN-RLZYd8SqmlGidhwEj4ZMerZv4s9_umU71UJLsZi_tvf7ANPhOhUXDC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedtgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:8ORqaTRnPwyDMUb_KiZ0DHaTACdIBQa2-lIvub8BK5jmK6wXFmmlMQ>
    <xmx:8ORqaUdrIvO2P2-2KHeShWaVSqsMWg79pk5MU06TsaMtn7aCEFl2ZA>
    <xmx:8ORqaUf99UscKXecVMpjWjF9yPRwNzR1bbhUNxzkP9yE13bJgcfBRw>
    <xmx:8ORqae3kDGAVqtbciZkAcc4Xrke9JytZX_esnabd0ZWuHLefmzvZpA>
    <xmx:8ORqaUQLbXlO8JgWfxsZPr-RfzP3KlqJfnOG8Rcy6CyRxS6FCZEJ3YcF>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 20:25:00 -0500 (EST)
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
In-reply-to: <cover.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
Date: Sat, 17 Jan 2026 12:24:58 +1100
Message-id: <176861309837.16766.10645274004289940807@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 17 Jan 2026, Benjamin Coddington wrote:
> The following series enables the linux NFS server to add a Message
> Authentication Code (MAC) to the filehandles it gives to clients.  This
> provides additional protection to the exported filesystem against filehandle
> guessing attacks.
> 
> Filesystems generate their own filehandles through the export_operation
> "encode_fh" and a filehandle provides sufficient access to open a file
> without needing to perform a lookup.  An NFS client holding a valid
> filehandle can remotely open and read the contents of the file referred to
> by the filehandle.

A *trusted* NFS client holding a valid filehandle can remotely access
the corresponding file without reference to access-path restrictions
that might be imposed by the ancestor directories or the server exports.

I think that last part is key to understanding what you are trying to
do.  You are trying to enforce path-based restriction in NFS.  And due
to the various ways that a path and be traversed - e.g.  different
principles for different components, or some traversal on server, some
on client - this effectively means you need a capability framework.

So you are enhancing the filehandle to act as a capability by adding a
MAC.

> 
> In order to acquire a filehandle, you must perform lookup operations on the
> parent directory(ies), and the permissions on those directories may
> prohibit you from walking into them to find the files within.  This would
> normally be considered sufficient protection on a local filesystem to
> prohibit users from accessing those files, however when the filesystem is
> exported via NFS those files can still be accessed by guessing the correct,
> valid filehandles.
> 
> Filehandles are easy to guess because they are well-formed.  The
> open_by_handle_at(2) man page contains an example C program
> (t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
> an example filehandle from a fairly modern XFS:
> 
> # ./t_name_to_handle_at /exports/foo 
> 57
> 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
> 
>           ^---------  filehandle  ----------^
>           ^------- inode -------^ ^-- gen --^
> 
> This filehandle consists of a 64-bit inode number and 32-bit generation
> number.  Because the handle is well-formed, its easy to fabricate
> filehandles that match other files within the same filesystem.  You can
> simply insert inode numbers and iterate on the generation number.
> Eventually you'll be able to access the file using open_by_handle_at(2).
> For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
> protects against guessing attacks by unprivileged users.

Iterating a 32 bit generation number would be expected to take a long
time to succeed - except that they tend to cluster early.  Though in
your example the msb is 1!

Do you have exploit code which demonstrates unauthorised access to a
given inode number?  What runtime?  Could attack-detection in the server
be a simple effective counter-measure?  Should we do that anyway?

Supporting and encouraging the use of 64-bit generation numbers, and
starting at a random offset would do a lot to make guessing harder.
A crypto key could be part of making this number hard to guess.

> 
> In contrast to a local user using open_by_handle(2), the NFS server must
> permissively allow remote clients to open by filehandle without being able
> to check or trust the remote caller's access.

I find the above sufficiently vague and confusing that I cannot tell if
I agree...

open_by_handle_at(2) requires CAP_DAC_READ_SEARCH precisely because no
path-based restrictions are imposed.
The NFS server cannot require CAP_DAC_READ_SEARCH and assumes the trusted 
client performs the necessary path-based access checks.
When the client cannot be completely trusted, and path-based access
controls are depended on, extra support is needed for NFS.


>                                                        Therefore additional
> protection against this attack is needed for NFS case.  We propose to sign
> filehandles by appending an 8-byte MAC which is the siphash of the
> filehandle from a key set from the nfs-utilities.  NFS server can then
> ensure that guessing a valid filehandle+MAC is practically impossible
> without knowledge of the MAC's key.  The NFS server performs optional
> signing by possessing a key set from userspace and having the "sign_fh"
> export option.


NeilBrown

