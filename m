Return-Path: <linux-fsdevel+bounces-39354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92713A13224
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6143A5B75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 04:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA513C8E8;
	Thu, 16 Jan 2025 04:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="QpSTGUo6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gZf2x1Kj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE62EC4
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737003144; cv=none; b=rRueVx3Z4pmtO3XlTG7pOFWE29co350M6swWurliqNscpDpVPEt0FtvNqn6m4MzYowSGxKv/hDOyeAsdEIkj+/WDgia/UaKnQQAlsQpNG0d+SyxW5u2gWpYDLG5m5nD1ae0IUR5Yly2GyzFx6qUygeT06lnJOUuq8UjX+5/oTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737003144; c=relaxed/simple;
	bh=mN+JjihbRJcvGehK+OrqkbWr3ZX2MoSltuxkrGP8nC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCpcOsoJRckOZ4nrM2HaBe2BII4UjR7Jwee4SlQ0GgTGY6ua1DmeFVORoNqrni3KaOpRDpAkZ1lU5U7+2d4NR2yD3qOcLCgkTkRwV/kscCCIueu5jQRB3OgNo7ZVBbBqTm7tnauagTvEzNGx3sm92dxeS5LFCLlBCPzqdFXfRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=QpSTGUo6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gZf2x1Kj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96670114019F;
	Wed, 15 Jan 2025 23:52:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jan 2025 23:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737003140; x=1737089540; bh=dAImxP9kH7
	wVJ/7YaTkljdT1vWhiUwfiwbjl4IwASmg=; b=QpSTGUo6MnWwWJ1wYBTLssKmBb
	AJaNKUyiaRbcED4flnmxCI6/C1Yuj/R62wEX4FehREKuCpmEeQhtwx2Jths6DwfE
	UKPQQlh11uuI2hoIPLmX/CDcO2KMpevr/5qhRu57rSBsRFhnxw2tVGLgebeFedEK
	cShY9N6yCEtwItSqvUmxUDgZHeTTkIP24tuB0PDqltq7MhCULywQTAZWDMWrSZn8
	BjqxggoswVyLnPj5jqNndJS3VqrMiEpdvCV6NLLAqhygJRKBFu6m25tSohQOvuX0
	d4l8VK5/GXB4AvYUVxCrodlb5zRAUcQj0++t1qC4msoHQUsd1xsH6gvc12yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737003140; x=1737089540; bh=dAImxP9kH7wVJ/7YaTkljdT1vWhiUwfiwbj
	l4IwASmg=; b=gZf2x1KjyIZ0xhtvvLoDIkz0ms/ijj9e2CVc9mDvB32U9C5EPZD
	BuvuOU+bqQH/y6PFKcrsCi5IsB1l8JnD6ZwHbYTO5bFLnTD+UW+pPXO4WsLk78ST
	EjXZSjYTBHb0Dsc9LF3kkDICFa/CnUAy9r7IbiLJB9IBDwctgop/QXHmX+bourIw
	s93TqlEdWYvFXEci4O/1oTecyFC/tyyRamnjWpxxWPOokfRXQpxNpUYinu1d71Av
	LHtf1pUcP9lYEmriRv/HPEacyLCRsUHL9lQ292M7VCsiCNMxxUrM2UGxXm88r7/0
	DDmpYB4i9q2eaj4koX5Yy4w2siZekevVOfA==
X-ME-Sender: <xms:hJCIZ4U4X1cT5PfFjqZFVYg0cakoigZgA1UE_oOEVOFQgS1-kDbitQ>
    <xme:hJCIZ8mq5HjhPPetxTn1PX-BYJ6zT5GT6XRmSI3opcF_EUHiiMjMZ3gq9FGzUY2h9
    fVlwwc-twgM4i1rEbI>
X-ME-Received: <xmr:hJCIZ8aleaFlO7JL2qspZeFfaLaoQK_NqRh30ON9395R-rwJ6YWY5_NpQhQ2n7NMjizUFWVV7QF94vnhXOFqBtDeMS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeehvdeugfdvheehteetieeiiedvieehhfeitedvledugeetgefh
    ueeitdetlefggfenucffohhmrghinhepshhushgvrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhroh
    esiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurggrnhdrjh
    druggvmhgvhigvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:hJCIZ3XlJtdFKVYzbMTAeO_slB5ghHcB5jDlQ5rUPpjGW01EqBrfTg>
    <xmx:hJCIZymV1sfaoqfHsxuFIUjNmrScGhmDDmLU7d5o63OUM5nXgQai_w>
    <xmx:hJCIZ8f0EnFeNwHwvjVi14nUl1Zd17mEY7i_0exxgJwLPIA60wljpQ>
    <xmx:hJCIZ0GUDtkeF9M-qY2mmHeu1BBdIucA9qGlnD68B31Smnu3WzT7Aw>
    <xmx:hJCIZ0iM5DjhJUaZI9HARy17VvX8f3mYdI4bkilQ-CHExpcJv4a8N4RP>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 23:52:19 -0500 (EST)
Date: Wed, 15 Jan 2025 20:52:41 -0800
From: Boris Burkov <boris@bur.io>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, daan.j.demeyer@gmail.com
Subject: Re: Possible bug with open between unshare(CLONE_NEWNS) calls
Message-ID: <20250116045241.GA2456181@zen.localdomain>
References: <20250115185608.GA2223535@zen.localdomain>
 <20250116041459.GC1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116041459.GC1977892@ZenIV>

On Thu, Jan 16, 2025 at 04:14:59AM +0000, Al Viro wrote:
> On Wed, Jan 15, 2025 at 10:56:08AM -0800, Boris Burkov wrote:
> > Hello,
> > 
> > If we run the following C code:
> > 
> > unshare(CLONE_NEWNS);
> > int fd = open("/dev/loop0", O_RDONLY)
> > unshare(CLONE_NEWNS);
> > 
> > Then after the second unshare, the mount hierarchy created by the first
> > unshare is fully dereferenced and gets torn down, leaving the file
> > pointed to by fd with a broken dentry.
> 
> No, it does not.  dentry is just fine and so's mount - it is not
> attached to anything, but it's alive and well.
> 
> > Specifically, subsequent calls to d_path on its path resolve to
> > "/loop0".
> 
> > My question is:
> > Is this expected behavior with respect to mount reference counts and
> > namespace teardown?
> 
> Yes.  Again, mount is still alive; it is detached, but that's it.
> 
> > If I mount a filesystem and have a running program with an open file
> > descriptor in that filesystem, I would expect unmounting that filesystem
> > to fail with EBUSY, so it stands to reason that the automatic unmount
> > that happens from tearing down the mount namespace of the first unshare
> > should respect similar semantics and either return EBUSY or at least
> > have the lazy umount behavior and not wreck the still referenced mount
> > objects.
> 
> Lazy umount is precisely what is happening.  Referenced mount object is
> there as long as it is referenced.

Thank you for your reply and explanations.

So in your opinion, what is the bug here?

btrfs started using d_path and checking that the device source file was
in /dev, to avoid putting nonsense like /proc/self/fd/3 into the mount
table, where it makes userspace fall over. 
(https://bugzilla.suse.com/show_bug.cgi?id=1230641)

I'd be loathe to call the userspace program hitting the
'unshare; open; unshare' sequence buggy, as we don't fail any of the
syscalls in a particularly sensible way. And if you use unshare -m, you
now have to vet the program you call doesn't use unshare itself?

You've taught me that d_path is working as intended in the face of the
namespace lifetime, so we can't rely on it to produce the "real"
(original?) path, in general.

So, to me, that leaves the bug as
"btrfs shouldn't assume/validate that device files will be in /dev."

We can do the d_path resolution thing anyway to cover the common case,
in the bugzilla, but shouldn't fail on something like /loop0 when that
is what we get out of d_path?

Boris

