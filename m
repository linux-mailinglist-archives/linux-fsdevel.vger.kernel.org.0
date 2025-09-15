Return-Path: <linux-fsdevel+bounces-61424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA7B57FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EB57B36DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74C345758;
	Mon, 15 Sep 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="oRQlaXvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D330C347;
	Mon, 15 Sep 2025 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947860; cv=none; b=oTo81Yv37OSk7wemsYnEas/9VZZFexXU3n6B3qReSS9ZTMJO9aoE7cotdunnQcciB4CudFOBQjOblKtZRS9PKsx7znfhcNpD6wbSQynOUg8b/dU2uxFNBAGrt4dtNbKjtogZdQIepilTAqk6FO/3bjbo7cBs4g/I/u/ldako5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947860; c=relaxed/simple;
	bh=Y+PNaf1gaLlN/lJujMJdcSqSWuyrJH89S2pZODpFWD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhqZSqCT7u/M1ReOctdyqWzDBbg1Jnznh7dw6BFf4KxP5QZ2blrlmnhj/fy46NMcw3Ewr2pRZbswa/7/kdQsxMjQ7LIQgMhK9pl8o2dtqsqXhkSUGig/TFWBTNzy4ltH8/XFcEK4pfkMKNGOiHHGJ3zvrMozZBC6TGzi/bpc0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=oRQlaXvX; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=3jkOVW4UeMu2h/64thZ8lLTfUx9zG1iEi3pX48Qe014=; b=oRQlaXvXWcyVDew8Y8gV2aL6T/
	y5yLg04UjWJK9x6QleWQskJJDo+YM7XdRKnxcTuuZq7Pti0i2PotnrCbc3RsPhnpG+fQ0z80pdygS
	E4AafemYOUvKbFgO52FwVPp2JNAP8KK+uNX6S+zHOq+ZEaahXa9lMjxuxcHWHYmHyOJcEcLuLyrz1
	ioLMZWpjU6pmA6Ss6mhz2MQRdxNtH5SBuCx0LI6vESbS06+1hPoL7DDFeMbYEYCbxgih0WmPKoXEN
	6eq7lKzGl1HS8sLHAL82RFp25u/EyYg7ywSpAOSDYxV4s9yRDzaSpr3jHIhhpPAbwCnXMX5x+66Js
	E3ZOypkPV03sTaGMpK21dNyjWGB+m6svP44N7JMjK565UM8I/hcV0aPXebCua7s+yjla5iAZqU0xt
	XLaHeg1mNCOxVVNjVf287qSn33tizgOCPdpXVKhygn78frYkodPMFAJ8I+rrnemo3FA7WODnJeTnr
	9uN7yapbLbwVgkZzgQrWNKGcEHNn42Y0uvz6IYc6yC0mMgzzu6WP66Ga6mK7a7tVwDZp+LPy/bun2
	Z7LPZFaMC+6Vu1kJoI0dZELKSthhOVRs94Tn/uV7Vz5MbcVksMIc2u07vBjqID1+d2JDsvD3YBm2h
	rrpApdtml982tzK59fgTDhh15buFGugooJ19hmIYs=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Tingmao Wang <m@maowtm.org>, Dominique Martinet <asmadeus@codewreck.org>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 v9fs@lists.linux.dev, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to qid)
Date: Mon, 15 Sep 2025 16:10:07 +0200
Message-ID: <14530343.U1M6xoFM3Z@silver>
In-Reply-To: <aMgMOnrAOrwQyVbp@codewreck.org>
References:
 <cover.1756935780.git.m@maowtm.org>
 <2acd6ae7-caf5-4fe7-8306-b92f5903d9c0@maowtm.org>
 <aMgMOnrAOrwQyVbp@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, September 15, 2025 2:53:14 PM CEST Dominique Martinet wrote:
[...]
> > 1. The qid is 9pfs internal data, and we may need extra API for 9pfs to
> > 
> >    expose this to Landlock.  On 64bit, this is easy as it's just the inode
> >    number (offset by 2), which we can already get from the struct inode.
> >    But perhaps on 32bit we need a way to expose the full 64bit server-sent
> >    qid to Landlock (or other kernel subsystems), if we're going to do
> >    this.
> 
> I'm not sure how much effort we want to spend on 32bit: as far as I
> know, if we have inode number collision on 32 bit we're already in
> trouble (tools like tar will consider such files to be hardlink of each
> other and happily skip reading data, producing corrupted archives);
> this is not a happy state but I don't know how to do better in any
> reasonable way, so we can probably keep a similar limitation for 32bit
> and use inode number directly...

I agree, on 32-bit the game is lost.

One way that would come to my mind though: exposing the full qid path as xattr 
on 32-bit, e.g. via "system.9pfs_qid" or something like that.

> > 2. Even though qids are supposed to be unique across the lifetime of a
> > 
> >    filesystem (including deleted files), this is not the case even for
> >    QEMU in multidevs=remap mode, when running on ext4, as tested on QEMU
> >    10.1.0.
> 
> I'm not familiar with the qid remap implementation in qemu, but I'm
> curious in what case you hit that.
> Deleting and recreating files? Or as you seem to say below the 'qid' is
> "freed" when fd is closed qemu-side and re-used by later open of other
> files?

The inode remap algorithm in QEMU's 9p server was designed to prevent inode 
number collisions of equally numbered inodes of *different* *devices* on host, 
exposed to guest via the same 9p mount (which appears as only one 9pfs device 
on guest). Basis for this however is still the underlying filesystem's inode 
number on host.

So yes, ext4 re-uses inode numbers of deleted files, and when that happens, a 
new file appears with the same qid path as the previously deleted file with 
QEMU.

/Christian



