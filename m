Return-Path: <linux-fsdevel+bounces-61898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D96B7D314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8D41C07607
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0EB346A06;
	Wed, 17 Sep 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="BAH2dwGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A726B2DB;
	Wed, 17 Sep 2025 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102775; cv=none; b=hmmcJVoeZGh6FVNHZcG+8wSG36H25M10EFbjXNdgVKntG1DcLi4k7iiIyHyD/L+FPxzcG2drDATeWW1T44+hfrKaKOIztT6t3QluOAkihPdYiucXn0jLy/tguYgQwvSS/NL9dqoDsrzrx1ckXesLUcQ7Ku+KZNQyGk7m+0Qn3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102775; c=relaxed/simple;
	bh=jek3eQCrIIKVzpBPRXKe0t3upClBCOumFZr1JgMJHUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Knto+d545hM78xyvvYPKF7p0NLua5CSTk/06jfUQevOjRaYWbVTy0mbpfKnvKWmL7SUZv1aTtZG8G+Kw9+72sNvqtCf8l1Bldm5kyKfZqRC9RNji+/mrfSCOgiMv3eA+QJqFvziIOxEXlgVtf3e9hCY4CElYnXuzYFWPw+SiHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=BAH2dwGU; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=+cQHhW6VGH2OlTG9Et3G2MQsI3hAr+1+N7KUvAYnrXs=; b=BAH2dwGUm/DjXtwQPcfCNawXwX
	Cj8dXfc52wp5b4PAS6MYGk9f0lJ0k5/8G+MyWmJs/DBeZel165Y/Sq4bndiZJRb8X6P2D/6GUZw34
	oezHJ55H369eonRjjrRbLFGfOEsrHAIstTLnpxA+ALyJIzZyYOkWhqhrT51bmxKAT9BHWhQN5Qgo+
	5PIaCqFTrDl9FA3yAbhd/uqyV7chjkgvSCaUktnAEb/TXDg6FG6SodxrrF5Bs3tWy9E/JJF0WnqA5
	Wrd1VJRrOMomr8pSg+TTJXwU0Vd0aIbnyVioMpFtoylEh6aKXdJaUVnD2T4JXJjcBOTBQVn4w+ay2
	1kj6gYD+aPs091TphSqzOBfkkkjQcNrjmEIi87SVxbJD4W1FhvQMpkgUwePpmOM3OoBsmLenk7VUX
	sCWGH+DNPq0J5UIbvlW6l9ImOtti/ZpouFbvsgvVQTCznHyencl14tQIMVcaBo74kC5uz1jxWkr/I
	lY6+DDGLzoY8gKgJ7JfRbA/osSMN2y+mxTCPNOez/FW2IYqdYau/hlhSH4jfb+v/u0gdiwk7IsbNi
	VXoyB0qqY4JxOkJR6JNCyUOFNFNtIDx00YweILrczqZulo7Hzy6Ushopwh4Bh+8fzUVRZPB2PUgj0
	2BB/FSqNi9o+Ycd2m+vx5K9Wz/GKxU9qX59TeYYa0=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>, Tingmao Wang <m@maowtm.org>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 v9fs@lists.linux.dev, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to qid)
Date: Wed, 17 Sep 2025 11:52:35 +0200
Message-ID: <3774641.iishnSSGpB@silver>
In-Reply-To: <f2c94b0a-2f1e-425a-bda1-f2d141acdede@maowtm.org>
References:
 <aMih5XYYrpP559de@codewreck.org> <3070012.VW4agfvzBM@silver>
 <f2c94b0a-2f1e-425a-bda1-f2d141acdede@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, September 17, 2025 1:59:21 AM CEST Tingmao Wang wrote:
> On 9/16/25 20:22, Christian Schoenebeck wrote:
> > On Tuesday, September 16, 2025 4:01:40 PM CEST Tingmao Wang wrote:
[...]
> > I see that you are proposing an option for your proposed qid based
> > re-using of dentries. I don't think it should be on by default though,
> > considering what we already discussed (e.g. inodes recycled by ext4, but
> > also not all 9p servers handling inode collisions).
> 
> Just to be clear, this approach (Landlock holding a fid reference, then
> using the qid as a key to search for rules when a Landlocked process
> accesses the previously remembered file, possibly after the file has been
> moved on the server) would only be in Landlock, and would only affect
> Landlock, not 9pfs (so not sure what you meant by "re-using of dentries").
> 
> The idea behind holding a fid reference within Landlock is that, because
> we have the file open, the inode would not get recycled in ext4, and thus
> no other file will reuse the qid, until we close that reference (when the
> Landlock domain terminates, or when the 9p filesystem is unmounted)

So far I only had a glimpse on your kernel patches and had the impression that 
they are changing behaviour for all users, since you are touching dentry 
lookup.

> > For all open FIDs QEMU retains a descriptor to the file/directory.
> > 
> > Which 9p message do you see sent to server, Trename or Trenameat?
> > 
> > Does this always happen to you or just sometimes, i.e. under heavy load?
> 
> Always happen, see log: (no Trename since the rename is done on the host)
[...]
> Somehow if I rename in the guest, it all works, even though it's using the
> same fid 2 (and it didn't ask QEMU to walk the new path)

Got it. Even though QEMU *should* hold a file descriptor (or a DIR* stream, 
which should imply a file descriptor), there is still a path string stored at 
V9fsFidState and that path being processed at some places, probably because 
there are path based and FID based variants (e.g Trename vs. Trenameat). Maybe 
that clashes somewhere, not sure. So I fear you would need to debug this.

/Christian



