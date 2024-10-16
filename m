Return-Path: <linux-fsdevel+bounces-32081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8959A0615
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 11:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671A21C22829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D420820F;
	Wed, 16 Oct 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dTeO47Nh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95057207A05
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072176; cv=none; b=PFMwNGfLI32TcdDQ7fMq/SH+KLH81KJbI6Xv1hsHC6EkDs41f3eJ7dRQbkizBqQiB6xx6A+8Ki3z4WlaU5ptXOEhCR+Iuk974qLJSIqhSrXBP7nLumIHDhIvLmEWa7CCIQkAWWVMqtXqPU2nEZvJyoCuNjTLN9L83n5Kxc7mtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072176; c=relaxed/simple;
	bh=D/iOdkl0AW9qhMSlWYQfIhAtgrWHo82x23P8cBcPkdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS58AmnanQJxTbTeGlhGmzxyDu3QkmG8vHzkhYsD7IYUwNQuQ1+yi6q4+0+n8u3NgzfhEZQNtd2R82IIoRBUHJH/op2JOdHMdAi4d2XGjOxPt+sd6y4ukHHbD/EPId+CHItxjWIBCBNlar4iZR05RCPk87dlcZeleWsj3QsjnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dTeO47Nh; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Oct 2024 05:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729072171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnzrshuwWz3tauk6FeHaVI1gp0KPdigX4+rB6qCSRZw=;
	b=dTeO47Nhkcg8mztLMxhBXHX7YEk7CUP+IKOsN1hHxHBqq48TKpEwG+gJ60+Wz7btwAjLH7
	VmwiRqg6zCRbIcr5U54sxVVIAMiyr0rpm1sC34EEjt7LseBYNYTqlMSj7JhurVfqBgzlAm
	EoKj9NGmhyS3KvWXhuOypHwvNh5rSik=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] bcachefs: Fix sysfs warning in fstests generic/730,731
Message-ID: <qjrvr2icigrhft3fma7en4stlunwlna4262bdbzqbrr4tjl4vb@3sqgjoymzz3m>
References: <20241012184239.3785089-1-kent.overstreet@linux.dev>
 <20241014061019.GA20775@lst.de>
 <2024101421-panning-challenge-c159@gregkh>
 <xboxb6r7ggimmzvwpfxqbzt3gsocwujbzkolostwhe777yo4mt@5uo65x6hh6qb>
 <2024101637-approval-repossess-7a3a@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024101637-approval-repossess-7a3a@gregkh>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 16, 2024 at 09:00:42AM +0200, Greg Kroah-Hartman wrote:
> [meta comment, Kent, I'm not getting your emails sent to me at all, they
> aren't even showing up in the gmail spam box, so something is really off
> on your server such that google is just rejecting them all?]

I'm just using Migadu, if it persists it'll have to be escalated with
both Google and Migadu to get anything done, most likely.

On Wed, Oct 16, 2024 at 09:00:42AM +0200, Greg Kroah-Hartman wrote:
> > There was already past precedent with the block/holder.c code, and
> > userspace does depend on that for determining the topology of virtual
> > block devices.
> 
> What tools use that?  What sysfs links are being created for it?
> 
> And yes, filesystems do poke around in sysfs, but they almost always do
> so in a racy way, see this old link for examples of common problems:
> 	https://lore.kernel.org/all/20230406120716.80980-1-frank.li@vivo.com/#r

That doesn't appear to be at all relevant to this discussion. Most/all
of the major filesystems today do have objects in sysfs under /sys/fs,
which is what that thread was describing, and I know some of those
people are going to take issue if you're calling their code buggy.

> > And that really is what sysfs is for, determining the actual topology
> > and relationships between various devices - so if there's a relationship
> > between devices we need to be able to expose that.
> 
> I totally agree, that is what sysfs is for, but at the filesystem layer
> you all are having to deal with "raw" kobjects and doing that gets
> tricky and is easy to get wrong.

Well, you're the person who created the API.

> > Re: the safety issues, I don't agree - provided you have a stable
> > reference to the underlying kobject, which we do, since we have the
> > block device open. The race is only w.r.t. kobj->state_in_sysfs, and
> > that could be handled easily within the sysfs/kobject code.
> 
> Handled how?

Per-kobject lock, taken by kobject_add() and kobject_del(), to
synchronize kobj->state_in_sysfs and the actual VFS state;
sysfs_create_link() and sysfs_remove_link() takes the same lock. It's
not hard...

> > The alternative would be scanning through /proc/mounts, which is really
> > nasty - the format isn't particularly cleanly specified, it's racy, and
> > with containers systems are getting into the thousands of mounts these
> > days.
> 
> How does all other filesystems do this?  Surely we are not relying on
> each filesystem to create these symlinks, that's just not going to
> work...

Sysfs code is currently in no way standardized across filesystems. I
recently introduced standard vfs-layer ioctls for getting the UUID and
sysfs paths of mounted filesystems, but we're a long ways from any real
standardization.

