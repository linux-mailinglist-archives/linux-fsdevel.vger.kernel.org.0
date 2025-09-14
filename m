Return-Path: <linux-fsdevel+bounces-61263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37000B56C91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 23:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D021898274
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 21:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AB2E5B1F;
	Sun, 14 Sep 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="o4y5fW7x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HrInNQFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6715E5DC;
	Sun, 14 Sep 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757885111; cv=none; b=ggn59VTv+huJJsgwcx6QNV0AJAsRSwokjHNEV2P7ldbNKnYu8MJxxtowigOWlvSnk2EezyrDamDIpQRW8NJW6y5x0uVAevqYR6YUBgTJweBuzWQ6NjFE8SLcPh8iQutuR+302HL+pf9ZIUQYpMpvFrt8kDG5PvIZAX9jayA+Xfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757885111; c=relaxed/simple;
	bh=R+3pfshVT1lSGsyaLxJi/4XIjqo6zl+0e/pcO0vSeLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udrHuxoxF5MSzlT0rT1ANbPNbU+xB2kbY0IjhqDpSt45NhnXIQZePjbxjk8xyObpZHUt4f6+SflbeTX8KPAasR4LZ5XUGe5vYThKCzpYY1yOBbAsLLoPETGFGgI4bcBpiJuAwUDwzmFAgV667epKaDfUoAKyOelAjUxf9ZbSd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=o4y5fW7x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HrInNQFK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 879EF1D00104;
	Sun, 14 Sep 2025 17:25:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 14 Sep 2025 17:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757885107;
	 x=1757971507; bh=OXNfFITD0Z2WLNrlGuGJH8lsgEiqKtnk1fe1/UjtTYc=; b=
	o4y5fW7xS7sTP3ASBxGhhpgq9O/cEq9HsybOPwgc3xgqzHAajds8Q2sJx9wwr6wt
	d82xbiKdCO7TidoOgpoVQ0c0qNcC4c/IOYBCGU5B5vZiM3CyaEHc6BPFPerYyfg3
	5dix6vXHRa0/ZcCri0HQTyu9x1pgcYqo3OT3bfkcEa0tkYfHLWZ2XkkMuiL8FSwK
	lB6XkolL0zFY0PiFufsUPNNwKEzoXqc497aznopHmZLNWwLHRVGAWAC/DB+s+MlI
	YXBSlE7/87h34/wvqrYDCSVkcOYB9lLqSaRourb6OUuorlfJHvUQtnzB1sJqVQHT
	90ztsLiziAB2P4uv2N08zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757885107; x=
	1757971507; bh=OXNfFITD0Z2WLNrlGuGJH8lsgEiqKtnk1fe1/UjtTYc=; b=H
	rInNQFKxJBTLKxNkU5H+OOI0ZqZiwIQ1YOi5lcEGx9zPW4keDGEZxebYRg0b1vx4
	gpcvI3/jLUHybrZBBR0ysGhChSmbfh5SKRF/PEe+IARieXjbXDWjItrSxO8OL3Uh
	iGMVwwf+khvkxDDuP8xNOc6aLhd4BQRQpbzwVg+zIIy8HUUnKYdjU1DZdBggn+p3
	YvqKCl3J9n4UKk7SgkSMfpPUnchxYmCMiDP5SA+0zq58BLu17o0hfzVi8W07sjE4
	KepWBxa04j43nhs8xeIAPBSO0hMosfzCJOKigAZ4EmFGiUEfwUz2Y+g7hhukPktt
	tia2+lyVttTePGQYnfbUA==
X-ME-Sender: <xms:sjLHaG5sxU8lbcviElxnwZQ3FOzZpv8fTbuCj-uOtw0i4c9iSbMHkg>
    <xme:sjLHaPUiSctmGP-q5_9DwS29XyLnJYXF_yAvX3-d-ug-4QWGCNru41lnU9mt1QhJ-
    wLKrCtiHvqhZbffVHQ>
X-ME-Received: <xmr:sjLHaGgFk4fhxjSwwe0oYffE0xip4HUFZPETEZWQIWd7xeOQEbAtgMC3ddS0GN6O_W-w_pinzEdz4bV8S1sMW3QE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkffggfgfuvfevfhfhjggtgfes
    thekredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifth
    hmrdhorhhgqeenucggtffrrghtthgvrhhnpeetueejjeelleduuefhvdeuhedvffeivdfh
    teektdettdegudfhgeetfeelvedtffenucffohhmrghinhepghhithhhuhgsrdhiohenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrgho
    fihtmhdrohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepvghrihgtvhhhsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphht
    thhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepvh
    elfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhnohgrtghksehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoug
    hulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhs
    vgdrtgii
X-ME-Proxy: <xmx:sjLHaHcw_y87jd_aWaVxIS4iQXfjlsQvBehUiZklvIeC05p7ZMhc3g>
    <xmx:sjLHaN38yfXFqE7qp2EaBVYH-LKGE0tjg6S980NvxO3lWgZj2R4j9Q>
    <xmx:sjLHaLoHfTjunrnBOVVyJ7QLZhqMmmTmOXjs8A94NM18-bSXzxcnew>
    <xmx:sjLHaNhwUOjE2c3Fa3zLPXJzvTN3yJpnqNJdRAA7UskFN-YWgDjuZg>
    <xmx:szLHaEUlPvC7f5808YY5K0Z7lk2hQ4nyu7bsuWsiao0nHnRNqPFRwcjF>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 17:25:04 -0400 (EDT)
Message-ID: <2acd6ae7-caf5-4fe7-8306-b92f5903d9c0@maowtm.org>
Date: Sun, 14 Sep 2025 22:25:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
To: Dominique Martinet <asmadeus@codewreck.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
References: <cover.1756935780.git.m@maowtm.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <cover.1756935780.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dominique and others,

I had a chat with Mickaël earlier this week and some discussion following
that, and we thought of a potential alternative to what I was proposing
here that might work for Landlock: using the inode number (or more
correctly, qid.path) directly as the keys for Landlock rules when
accessing 9p files.  I'm not sure how sound this is from the perspective
of 9pfs (there are pros and caveats), and I would like to gather some
thoughts on this idea.

Technically a 9pfs server is not supposed to return colliding qid.paths
for different files.  In fact, according to [1], the qid must not be the
same even for files which are deleted then recreated using the same name
(whereas for e.g. ext4, inode number is reused if a file is deleted and
recreated, possibly with a different name, in the same directory).
However, this is in practice not the case for many actual 9pfs server
implementations (thus the reason for this patch series in the first
place).

This is a bad problem for the 9pfs client in Linux as it can lead to data
corruption if the wrong inode is used, but for Landlock, the only effect
of this is allowing access to more files then the sandboxing application
intended (and only in the presence of an "erroneous" 9pfs server).  Any
other alternative, including this patch series, has the opposite risk -
files that should be allowed might be denied (even if the server
implementation is fully correct in terms of no reusing of qids).  In
particular, this patch cannot correctly handle server-side renames of an
allowed file, or rename of a directory with children in it from the client
(although this might be solved, with the expense of adding more
complicated code in the rename path to rewrite all the struct ino_paths).

In discussion with Mickaël he thought that it would be acceptable for
Landlock to assume that the server is well-behaved, and Landlock could
specialize for 9pfs to allow access if the qid matches what's previously
seen when creating the Landlock ruleset (by using the qid as the key of
the rule, instead of a pointer to the inode).

There are, however, several immediate issues with this approach:

1. The qid is 9pfs internal data, and we may need extra API for 9pfs to
   expose this to Landlock.  On 64bit, this is easy as it's just the inode
   number (offset by 2), which we can already get from the struct inode.
   But perhaps on 32bit we need a way to expose the full 64bit server-sent
   qid to Landlock (or other kernel subsystems), if we're going to do
   this.

2. Even though qids are supposed to be unique across the lifetime of a
   filesystem (including deleted files), this is not the case even for
   QEMU in multidevs=remap mode, when running on ext4, as tested on QEMU
   10.1.0.  And thus in practice a Landlock ruleset would need to hold a
   reference to the file to keep it open, so that the server will not
   re-use the qid for other files (having a reference to the struct inode
   alone doesn't seem to do that).

   Unfortunately, holding a dentry in Landlock prevents the filesystem
   from being unmounted (causes WARNs), with no (proper) chance for
   Landlock to release those dentries.  We might do it in
   security_sb_umount, but then at that point it is not guaranteed that
   the unmount will happen - perhaps we would need a new security_ hooks
   in the umount path?

   Alternatively, I think if we could somehow tell 9pfs to keep a fid open
   (until either the Landlock domain is closed, or the filesystem is
   unmounted), it could also work.

   I'm not sure what's the best way to do this, it seems like unless we
   can get a new pre_umount / pre_sb_delete hook in which we can free
   dentries, 9pfs would need to expose some new API, or alternatively, in
   uncached mode, have the v9fs inode itself hold a (strong) reference to
   the fid, so that if Landlock has a reference to the inode, the file is
   kept open server-side.

The advantage of doing this is that, for a server with reasonable
behaviour, Landlock users would not get incorrect denials (i.e. things
"just work"), while still maintaining security if the 9p server is
"reasonable" (in particular, an application sandboxed under Landlock would
not get access to unrelated files if it does not have a way to somehow get
those files to be recreated with an allowed inode number), whereas the
current patch has the problem with server side renames and directory
renames (server or client side), and also can't deal with hard links.

I'm not sure how attractive this solution is to various people here -
Mickaël is happy with special-casing 9pfs in Landlock, and in fact he
suggested this idea in the first place, but I think this has the potential
to be quite complicated (but technically more correct).  It would also
only work for Landlock, and if e.g. fsnotify wants to have the same
behaviour, that would need its own changes too.

Apologies for the long-winded explanation, any thoughts on this?


[1]: https://ericvh.github.io/9p-rfc/rfc9p2000.html#msgs
     "If a file is deleted and recreated with the same name in the same
     directory, the old and new path components of the qids should be
     different."

---

Note: Even with the above, there's another potential problem - QEMU does
not, for some reason (I've not really investigated this very deeply, but
it's observation from /proc/.../fd), keep a directory open when the guest
has a fid to it.  This means that if a directory is deleted while we have
an active Landlock rule on it, a new file or directory may get the same
qid.  (However, at least this still correctly handles directory renames,
and the only effect is Landlock allowing more files than intended in the
presence of a buggy server.)

(The Hyper-V 9p server, used by WSL, seems to have the same problem, and a
bit worse since even client-side renames breaks opened dir fds on the
WSL-to-Windows 9pfs (/mnt/c/...))

(Another challenge is that Landlock would have to know when a file is on a
9pfs in uncached mode - we probably don't need this behaviour for cached
mode filesystems, as we assume no server changes in that case and the
inode is reused already.  We can certainly determine the FS of a file, but
not sure about specific 9pfs cache options)

