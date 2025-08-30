Return-Path: <linux-fsdevel+bounces-59709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8CDB3CAC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 14:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96E856621C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459A27A446;
	Sat, 30 Aug 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ40vDFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92342065;
	Sat, 30 Aug 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756556591; cv=none; b=k85vx1ryDG+8uBcN/+5qoUeebmMdjEPl/g/saHXk+Ke6MsA/NbS3SYTG1aVKiQA2/EfHekC6v6Eviztn9rwc2gul0+O7gw7+QkgThAaZAxoYQ78fTWeVPjS1LYSFLp1DqyvG3eSJ3uNVCZiFt6A0VdH4g9sBQNBl9IeMTrUvYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756556591; c=relaxed/simple;
	bh=SoN9dBf3Izbt4t232toRwWwIivJ8TeDGto62fx0RuLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqTFy5vkd0wDiG5dtGC0r3K2EFUG1xe/PFP/c6d1Ds6FssJquU/hNUKUG4141HfnBaku+rjK9CVTluI25hXcEVHamvlcBb9B2c/AuIQf0AAjD2wacut27aQJsdFaa0T3R3RQbSDGBrqTkbc8yfh8DQO84mTXeFtffoWhh8J6h4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ40vDFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08627C4CEEB;
	Sat, 30 Aug 2025 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756556591;
	bh=SoN9dBf3Izbt4t232toRwWwIivJ8TeDGto62fx0RuLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ40vDFN1gWwhiwIP2RtrDA6BQt/gApzzCxqyt9ewJlEmwxIWYfN1K4M3rMJb6Ti2
	 fA3QzOVtdFqNz4MuzR/2pn5r06IUpEsH5jrcDGgFQHUHjCIz4CzUqPhhUgPJ/M/hC4
	 gfjQMFCIMiK5NNWPvvwQZvtble0EVoMcgEaiBrwvTopsPdhmrI3ZtkxhPgEREaDbH4
	 Au026SjvsurYZJ5OR58KveR3f0PHKdS2nSzoM5htgdeEgL2dlPTVgI5O20q0sHhbWZ
	 oGjcibj9l94gTbdd6MJnYsVsoqnO6RS9t2kAC5Uzih0h8iXsy3DjzGSnJb6ildZ6Sh
	 r2+65xD0W5HCA==
Date: Sat, 30 Aug 2025 20:23:01 +0800
From: Gao Xiang <xiang@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Byron Stanoszek <gandalf@winds.org>, Christoph Hellwig <hch@lst.de>,
	gregkh <gregkh@linuxfoundation.org>,
	"julian.stecklina" <julian.stecklina@cyberus-technology.de>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	rafael <rafael@kernel.org>,
	torvalds <torvalds@linux-foundation.org>,
	viro <viro@zeniv.linux.org.uk>,
	=?utf-8?Q?=22Thomas_Wei=C3=9Fschuh=22?= <thomas.weissschuh@linutronix.de>,
	Christian Brauner <brauner@kernel.org>,
	systemd-devel <systemd-devel@lists.freedesktop.org>,
	Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH] initrd: support erofs as initrd
Message-ID: <aLLtJcHt0NcaZeDm@debian>
Mail-Followup-To: Askar Safin <safinaskar@zohomail.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Byron Stanoszek <gandalf@winds.org>, Christoph Hellwig <hch@lst.de>,
	gregkh <gregkh@linuxfoundation.org>,
	"julian.stecklina" <julian.stecklina@cyberus-technology.de>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	rafael <rafael@kernel.org>,
	torvalds <torvalds@linux-foundation.org>,
	viro <viro@zeniv.linux.org.uk>,
	=?utf-8?Q?=22Thomas_Wei=C3=9Fschuh=22?= <thomas.weissschuh@linutronix.de>,
	Christian Brauner <brauner@kernel.org>,
	systemd-devel <systemd-devel@lists.freedesktop.org>,
	Lennart Poettering <mzxreary@0pointer.de>
References: <20250826075910.GA22903@lst.de>
 <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org>
 <6b77eda9-142e-44fa-9986-77ac0ed5382f@linux.alibaba.com>
 <198ead62fff.fc7d206346787.2754614060206901867@zohomail.com>
 <d820951e-f5df-4ddb-a657-5f0cc7c3493a@linux.alibaba.com>
 <81788d65-968a-4225-ba1b-8ede4deb0f61@linux.alibaba.com>
 <198f1915a27.10415eef562419.6441525173245870022@zohomail.com>
 <18d15255-2a6f-4fe8-bbf7-c4e5cc51692c@linux.alibaba.com>
 <79315382-5ba8-42c1-ad03-5cb448b23b72@linux.alibaba.com>
 <198facfefe8.11982931078232.326054837204882979@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <198facfefe8.11982931078232.326054837204882979@zohomail.com>

On Sat, Aug 30, 2025 at 03:49:48PM +0400, Askar Safin wrote:
>  ---- On Thu, 28 Aug 2025 21:14:34 +0400  Gao Xiang <hsiangkao@linux.alibaba.com> wrote --- 
>  > Which part of the running system check the cpio signature.
> 
> You mean who checks cpio signature at boot?
> Ideally, bootloader should do this.

The kernel shouldn't trust the bootloader even the bootloader
checked before, it should re-check itself to re-ensure that.

Ideally, the running system should have a way to check itself
is in a safe environment and the data provided by the bootloader
is genuine, otherwise some dedicated malicious bootloader could
have a way to do some bad behavior.

> 
> For example, as well as I understand, UKI's EFI stub checks
> initramfs signature. (See
> https://github.com/systemd/systemd/blob/main/docs/ROOTFS_DISCOVERY.md
> ).
> 
> It seems that this document (ROOTFS_DISCOVERY) covers
> zillions of use cases, so I hope you will find something for you.

I've said I have no time to look into this.

> 
> I also added to CC Poettering and systemd, hopefully they have some
> ideas.
> 

...

> 
>  > Personally I just don't understand why cpio stands out considering it
>  > even the format itself doesn't support xattrs and more.
> 
> As I said above, initramfs should not be feature-rich.
> 
> (But xattrs can be added to it, if needed.)

The point is:

AFAIK, There is no formal standard for POSIX cpio to implement xattrs,
IOWs, it will be some non-standard cpio just for kernel initramfs
cases, and the new added xattr code has no other usage: just for
temporary booting use case.

Take a look at `init/initramfs.c`, the entire file is just for
unpacking an unaligned/in-random-accessable cpio even it cannot be
called as `cpiofs`.

There are many real filesystems with enough features in the kernel
can help on the same use cases and data doesn't need to be moved
from unaligned cpio to tmpfs. It just sounds like a net win to me.

As for your initramfs size assumption, I don't want to comment on
this, because I'm not distribution guy, I don't know but since
users already claimed they use compressed initrd and they don't want
to unpack them all in one shot, it sounds to me that it may not be
so small.

Thanks,
Gao Xiang

> 
> -- 
> Askar Safin
> https://types.pl/@safinaskar
> 

