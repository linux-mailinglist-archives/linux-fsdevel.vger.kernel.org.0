Return-Path: <linux-fsdevel+bounces-31842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E444399C066
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A841B281117
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B581459F6;
	Mon, 14 Oct 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIEtZZuh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F2145324
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888691; cv=none; b=lD0rIRnjNGFJxmjJYNOe9wdbmZ4fu3N4422KT9lsKgQayEU5YApWBlUz5DaBVH7Oc6zgU/FFPhqAqBJ9tSFuD6/2BlfP3d7UhHiHZkMotu3W0rGFCg+8eu+8b34dhjD5Yhls20TG76DEHlfCs3czLVFjQG4SNRXZdVSgMHw2Fco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888691; c=relaxed/simple;
	bh=qnsUnlV73v4zNOIo78pUcFKwtyG4f1FbjArRnu2tg/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz0WYnA7UcdexJodJWVU6Yd/9UR2lgGHXNj9WmTADOKQlNrP0k2+Fmp8bT/NxiIpKdhiOb96Esnfts+UEr7FdXklPn/+4/uxMcK0Cd34ujUfIQDHqk292vSKCL5UdaGyHWr7bBafIl0u3sRYqJShRB56ng6Mpe31Wlb+nBjI4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIEtZZuh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Oct 2024 02:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728888687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHSBhZCpcgyB4w8AIuTjUDpg1rpWx0hAt2uVhJfIjUU=;
	b=uIEtZZuhbKdFYjKbnFCF3yuBDvFYfrbiYc8T5bW7uBlRfl8SymNkQwfZS8sY9XNft1a/0X
	VhuEHxidJ3QIMjZiefbip4miEyw7Cfbi+mSi9QN13eiAhimGx1sNCQQKHlq/khRRPSSlLk
	9JYBH1R2L9QJ4QRnHdSz23K1wlQBUvI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] bcachefs: Fix sysfs warning in fstests generic/730,731
Message-ID: <xboxb6r7ggimmzvwpfxqbzt3gsocwujbzkolostwhe777yo4mt@5uo65x6hh6qb>
References: <20241012184239.3785089-1-kent.overstreet@linux.dev>
 <20241014061019.GA20775@lst.de>
 <2024101421-panning-challenge-c159@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024101421-panning-challenge-c159@gregkh>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 08:34:06AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 14, 2024 at 08:10:19AM +0200, Christoph Hellwig wrote:
> > On Sat, Oct 12, 2024 at 02:42:39PM -0400, Kent Overstreet wrote:
> > > sysfs warns if we're removing a symlink from a directory that's no
> > > longer in sysfs; this is triggered by fstests generic/730, which
> > > simulates hot removal of a block device.
> > > 
> > > This patch is however not a correct fix, since checking
> > > kobj->state_in_sysfs on a kobj owned by another subsystem is racy.
> > > 
> > > A better fix would be to add the appropriate check to
> > > sysfs_remove_link() - and sysfs_create_link() as well.
> > 
> > The proper fix is to not link to random other subsystems with
> > object lifetimes you can't know.  I'm not sure why you think adding
> > this link was ever allowed.
> > 
> 
> Odd, I never got the original patch that was sent here in the first
> place...
> 
> Anyway, Christoph is right, this patch isn't ok.  You can't link outside
> of the subdirectory in which you control in sysfs without a whole lot of
> special cases and control.  The use of sysfs for filesystems is almost
> always broken and tricky and full of race conditions (see many past
> threads about this.)  Ideally we would fix this up by offering common
> code for filesystems to use for sysfs (like we do for the driver
> subsystems), but no one has gotten around to it for various reasons.

There was already past precedent with the block/holder.c code, and
userspace does depend on that for determining the topology of virtual
block devices.

And that really is what sysfs is for, determining the actual topology
and relationships between various devices - so if there's a relationship
between devices we need to be able to expose that.

I don't know why bcache never used the block/holder.c code (predates it,
perhaps?) - but that code has been carried over basically unchanged, and
we likely still depend on it (I'd have to dig around in tools...).

Re: the safety issues, I don't agree - provided you have a stable
reference to the underlying kobject, which we do, since we have the
block device open. The race is only w.r.t. kobj->state_in_sysfs, and
that could be handled easily within the sysfs/kobject code.
 
> The only filesystem that I can see that attempts to do much like what
> bcachefs does in sysfs is btrfs, but btrfs only seems to have one
> symlink, while you have multiple ones pointing to the same block device.

Not sure where you're seeing that? It's just a single backreference from
the block device to the filesystem object.

> I can't find any sysfs documentation in Documentation/ABI/ so I don't
> really understand what it's attempting to do (and why isn't the tools
> that check this screaming about that lack of documentation, that's
> odd...)  Any hints as to what you are wishing to show here?

Basically, it's the cleanest way (by far) for userspace to look up the
filesystem from the block device: given a path to a block device, stat
it to get the major:minor, then try to open
/sys/dev/block/major:minor/bcachefs/.

The alternative would be scanning through /proc/mounts, which is really
nasty - the format isn't particularly cleanly specified, it's racy, and
with containers systems are getting into the thousands of mounts these
days.

