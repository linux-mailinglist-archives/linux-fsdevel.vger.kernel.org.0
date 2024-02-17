Return-Path: <linux-fsdevel+bounces-11902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B281858D1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 05:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B611C2133F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 04:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1E51CA9B;
	Sat, 17 Feb 2024 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v2eKsfr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DBD1C68D
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 04:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708142682; cv=none; b=e4K7qIMBPVJdbaXMsDHX/EAsDigrMW93s3CWr8IqQ+20QPnuQF5XVJE71N0kORc8L1KPXAV0asVJXDgOV7hMqvdH6sZXHz/z7owtCtHnRQAvzhSPjVSjinf2+A87yheqaEcVbRSOhcwlnaL9HHKx4ZKWUiNeCt/sQvE1ONckcgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708142682; c=relaxed/simple;
	bh=2JsnIW9Dfqx/Kpyym0cyn0LZDbDtWBPrNM0fZ46Ie2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDy8Eg66Qt/J8fxef9GrNLmLq7ua9PzOw35Quuy7KRLBCh3FtWKORKufoZtVmeB/20vYjq/q4tBv/uGlSWIaVUpDx2qKVd7Q8XedJZ+dgybG1Fa156+uTK+mdHKgJdxmq0pOu/6Gux/fFY7f6MKq8c5YnemdXIxRUD48lHQhhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v2eKsfr4; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Feb 2024 23:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708142677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4r5aIV7VuIBs+wO/sCkDN27DEyy8EZefu5EInHNYN4=;
	b=v2eKsfr4RqJiPyoh2Vo0edhLedLN1wz4yD9ORWOpRo9yJFXqX4BKGIZpRKN+FPclQD/Enc
	Q32XVIPBwxtM+OUDrbBQc1VlgMToH0H5+lxWd7l7rEFIXmYoqzJRTFkh9PKsjgMd+RXgYd
	ZILDKHzg/QofJ0EzNQR7JGLKUctiiKQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <h5wq7dsi6r7cjjmkpo2dvn5x662eseluzd2kmzbkzegntzlptd@ncjzyaurmiwb>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 16, 2024 at 11:50:32AM +0100, Christian Brauner wrote:
> Hey,
> 
> I'm not sure this even needs a full LSFMM discussion but since I
> currently don't have time to work on the patch I may as well submit it.
> 
> Gnome recently got awared 1M Euro by the Sovereign Tech Fund (STF). The
> STF was created by the German government to fund public infrastructure:
> 
> "The Sovereign Tech Fund supports the development, improvement and
>  maintenance of open digital infrastructure. Our goal is to sustainably
>  strengthen the open source ecosystem. We focus on security, resilience,
>  technological diversity, and the people behind the code." (cf. [1])
> 
> Gnome has proposed various specific projects including integrating
> systemd-homed with Gnome. Systemd-homed provides various features and if
> you're interested in details then you might find it useful to read [2].
> It makes use of various new VFS and fs specific developments over the
> last years.
> 
> One feature is encrypting the home directory via LUKS. An approriate
> image or device must contain a GPT partition table. Currently there's
> only one partition which is a LUKS2 volume. Inside that LUKS2 volume is
> a Linux filesystem. Currently supported are btrfs (see [4] though),
> ext4, and xfs.
> 
> The following issue isn't specific to systemd-homed. Gnome wants to be
> able to support locking encrypted home directories. For example, when
> the laptop is suspended. To do this the luksSuspend command can be used.
> 
> The luksSuspend call is nothing else than a device mapper ioctl to
> suspend the block device and it's owning superblock/filesystem. Which in
> turn is nothing but a freeze initiated from the block layer:
> 
> dm_suspend()
> -> __dm_suspend()
>    -> lock_fs()
>       -> bdev_freeze()
> 
> So when we say luksSuspend we really mean block layer initiated freeze.
> The overall goal or expectation of userspace is that after a luksSuspend
> call all sensitive material has been evicted from relevant caches to
> harden against various attacks. And luksSuspend does wipe the encryption
> key and suspend the block device. However, the encryption key can still
> be available clear-text in the page cache. To illustrate this problem
> more simply:
> 
> truncate -s 500M /tmp/img
> echo password | cryptsetup luksFormat /tmp/img --force-password
> echo password | cryptsetup open /tmp/img test
> mkfs.xfs /dev/mapper/test
> mount /dev/mapper/test /mnt
> echo "secrets" > /mnt/data
> cryptsetup luksSuspend test
> cat /mnt/data
> 
> This will still happily print the contents of /mnt/data even though the
> block device and the owning filesystem are frozen because the data is
> still in the page cache.
> 
> To my knowledge, the only current way to get the contents of /mnt/data
> or the encryption key out of the page cache is via
> /proc/sys/vm/drop_caches which is a big hammer.
> 
> My initial reaction is to give userspace an API to drop the page cache
> of a specific filesystem which may have additional uses. I initially had
> started drafting an ioctl() and then got swayed towards a
> posix_fadvise() flag. I found out that this was already proposed a few
> years ago but got rejected as it was suspected this might just be
> someone toying around without a real world use-case. I think this here
> might qualify as a real-world use-case.
> 
> This may at least help securing users with a regular dm-crypt setup
> where dm-crypt is the top layer. Users that stack additional layers on
> top of dm-crypt may still leak plaintext of course if they introduce
> additional caching. But that's on them.
> 
> Of course other ideas welcome.

This isn't entirely unlike snapshot deletion, where we also need to
shoot down the pagecache.

Technically, the code I have now for snapshot deletion isn't quite what
I want; snapshot deletion probably wants something closer to revoke()
instead of waiting for files to be closed. But maybe the code I have is
close to what you need - maybe we could turn this into a common shared
API?

https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs.c#n1569

The need for page zeroing is pretty orthogonal; if you want page zeroing
you want that enabled for all page cache folios at all times.

