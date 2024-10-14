Return-Path: <linux-fsdevel+bounces-31839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC699C011
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42B51C2156C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0BC142E77;
	Mon, 14 Oct 2024 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QSk/2pLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBE33C9;
	Mon, 14 Oct 2024 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887650; cv=none; b=OmbRaDGpGVq2SK+PHEg0JefjhfMKR5mphysgDrv2LU3FVk6xoTaRlhIftJtR84/mSk9CLzGK+kMx6NEn/F88DeLY7AuvkDqCgtC4IbMUrx1feTInzUU/mZcDt72Brtcfz5bWhTGniSkl2DGPtpFAqwVusnYAuG0EbuwoZAuzhqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887650; c=relaxed/simple;
	bh=HfOpYMU9ZGdZrQ+wyjIDO2/uyhgNSmPvNBu45r6KC58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akxliynqLux7i+LlweiPrvzcE4VssFr5j+Fxd/KSMklcShKszHHaefqm/3GrLtQWyCRhR4Y1w22cd7K0ssfDTOzYa5GrUD0v/HbzJHjEYM/30PdZYQOMlksf/nhjPE7296kT0kWHbQ+RjpkJo/0hHCH9Y804dziI8PHZa3gjENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QSk/2pLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F121EC4CEC3;
	Mon, 14 Oct 2024 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728887649;
	bh=HfOpYMU9ZGdZrQ+wyjIDO2/uyhgNSmPvNBu45r6KC58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSk/2pLiK+J7tUx/nGCtwzvf8L32pFZboh/FLJ+30LHNSSGa4MA5P5VXe6c902iO4
	 gFec9rDwJbyCx78cHyNP/lYlLKSDqCF1PWSsVAgPp7NPe3uB7eU6cH/9zqDjxZs8iw
	 AuIosMGtL91HYjJ9VG2PeCyqaRkYrdEYzO2gXWGA=
Date: Mon, 14 Oct 2024 08:34:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] bcachefs: Fix sysfs warning in fstests generic/730,731
Message-ID: <2024101421-panning-challenge-c159@gregkh>
References: <20241012184239.3785089-1-kent.overstreet@linux.dev>
 <20241014061019.GA20775@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014061019.GA20775@lst.de>

On Mon, Oct 14, 2024 at 08:10:19AM +0200, Christoph Hellwig wrote:
> On Sat, Oct 12, 2024 at 02:42:39PM -0400, Kent Overstreet wrote:
> > sysfs warns if we're removing a symlink from a directory that's no
> > longer in sysfs; this is triggered by fstests generic/730, which
> > simulates hot removal of a block device.
> > 
> > This patch is however not a correct fix, since checking
> > kobj->state_in_sysfs on a kobj owned by another subsystem is racy.
> > 
> > A better fix would be to add the appropriate check to
> > sysfs_remove_link() - and sysfs_create_link() as well.
> 
> The proper fix is to not link to random other subsystems with
> object lifetimes you can't know.  I'm not sure why you think adding
> this link was ever allowed.
> 

Odd, I never got the original patch that was sent here in the first
place...

Anyway, Christoph is right, this patch isn't ok.  You can't link outside
of the subdirectory in which you control in sysfs without a whole lot of
special cases and control.  The use of sysfs for filesystems is almost
always broken and tricky and full of race conditions (see many past
threads about this.)  Ideally we would fix this up by offering common
code for filesystems to use for sysfs (like we do for the driver
subsystems), but no one has gotten around to it for various reasons.

The only filesystem that I can see that attempts to do much like what
bcachefs does in sysfs is btrfs, but btrfs only seems to have one
symlink, while you have multiple ones pointing to the same block device.

I can't find any sysfs documentation in Documentation/ABI/ so I don't
really understand what it's attempting to do (and why isn't the tools
that check this screaming about that lack of documentation, that's
odd...)  Any hints as to what you are wishing to show here?

thanks,

greg k-h

