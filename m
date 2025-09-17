Return-Path: <linux-fsdevel+bounces-61963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C2BB8107B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0397A2A5E81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B32FAC00;
	Wed, 17 Sep 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="y7dfMZII"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464212F3C3F
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126616; cv=none; b=VCMZARQptQZiWzKonO4RpG8Ucz3T2RsGjLPHZ9wGFCX04Gym+X6azv8oEURsSeXsVOwcjPGzpIf7VEBHD58NQrFHFvxONiEvR8k3D+/h9SvbalaTKLOlC1/v9qwSp9rVIaiy5eFITAa1qvaz06h7o6MqtQR9XyauHrA5qB4FJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126616; c=relaxed/simple;
	bh=hEeziQot0vBjqaii0OlztAOOx169xCFGd3aiQcDgMVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut7v1YIYXHHZ6EPJtxHaC8CIQVNedwmwHDINnFW7M/pEdOK7OPWqjDhLi9/kuqu1RXoQIjO3fNZeku2MATUffAiSrCfK7VOwg+mTaUFiq1V2Jnm+xINSfFvW/+w9E/4WogIR+HuvyGO09BVMDiZwz9WS2UNHC2kji/voYz+jadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=y7dfMZII; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cRhl72X5bzC9h;
	Wed, 17 Sep 2025 17:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758121203;
	bh=rL7Wz/OzT+h4BNs1HqM2gnwP58YKoyxzpcyYZtg3OCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y7dfMZIIs/M7kUdhPB/zCQ3CtUyfYRCZ3SdMHWhiFUFPMETzMoLSqMCw3BwYtKu83
	 db529S2qHb+Zbtzkl62qOoVb1xJmsBF1iO5Q2tyf7mtCg4RXqdl+mD6nUailw7BEg0
	 f3XnWjetxQIRJjAhlr4jCd6YkklsdleOOC5KqXDE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cRhl60h5fzW6c;
	Wed, 17 Sep 2025 17:00:02 +0200 (CEST)
Date: Wed, 17 Sep 2025 17:00:00 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <20250917.Ung8aukeiz9i@digikod.net>
References: <cover.1756935780.git.m@maowtm.org>
 <2acd6ae7-caf5-4fe7-8306-b92f5903d9c0@maowtm.org>
 <aMgMOnrAOrwQyVbp@codewreck.org>
 <14530343.U1M6xoFM3Z@silver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14530343.U1M6xoFM3Z@silver>
X-Infomaniak-Routing: alpha

On Mon, Sep 15, 2025 at 04:10:07PM +0200, Christian Schoenebeck wrote:
> On Monday, September 15, 2025 2:53:14 PM CEST Dominique Martinet wrote:
> [...]
> > > 1. The qid is 9pfs internal data, and we may need extra API for 9pfs to
> > > 
> > >    expose this to Landlock.  On 64bit, this is easy as it's just the inode
> > >    number (offset by 2), which we can already get from the struct inode.
> > >    But perhaps on 32bit we need a way to expose the full 64bit server-sent
> > >    qid to Landlock (or other kernel subsystems), if we're going to do
> > >    this.
> > 
> > I'm not sure how much effort we want to spend on 32bit: as far as I
> > know, if we have inode number collision on 32 bit we're already in
> > trouble (tools like tar will consider such files to be hardlink of each
> > other and happily skip reading data, producing corrupted archives);
> > this is not a happy state but I don't know how to do better in any
> > reasonable way, so we can probably keep a similar limitation for 32bit
> > and use inode number directly...
> 
> I agree, on 32-bit the game is lost.
> 
> One way that would come to my mind though: exposing the full qid path as xattr 
> on 32-bit, e.g. via "system.9pfs_qid" or something like that.

Another way to always deal with 64-bit values, even on 32-bit
architectures, would be to implement inode->i_op->getattr(), but that
could have side effects for 9p users expecting the current behavior.

> 
> > > 2. Even though qids are supposed to be unique across the lifetime of a
> > > 
> > >    filesystem (including deleted files), this is not the case even for
> > >    QEMU in multidevs=remap mode, when running on ext4, as tested on QEMU
> > >    10.1.0.
> > 
> > I'm not familiar with the qid remap implementation in qemu, but I'm
> > curious in what case you hit that.
> > Deleting and recreating files? Or as you seem to say below the 'qid' is
> > "freed" when fd is closed qemu-side and re-used by later open of other
> > files?
> 
> The inode remap algorithm in QEMU's 9p server was designed to prevent inode 
> number collisions of equally numbered inodes of *different* *devices* on host, 
> exposed to guest via the same 9p mount (which appears as only one 9pfs device 
> on guest). Basis for this however is still the underlying filesystem's inode 
> number on host.
> 
> So yes, ext4 re-uses inode numbers of deleted files, and when that happens, a 
> new file appears with the same qid path as the previously deleted file with 
> QEMU.
> 
> /Christian
> 
> 
> 

