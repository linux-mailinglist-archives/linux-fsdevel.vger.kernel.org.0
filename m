Return-Path: <linux-fsdevel+bounces-45905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A832A7E7F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56A6168003
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9289216E26;
	Mon,  7 Apr 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E07sSCSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDB1C36;
	Mon,  7 Apr 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046132; cv=none; b=ZcHjYoO4HGkZxeMSUEcvbobduSODYvxGXgYtDXrietWbPs+lt2RnVfwwRmyk9CwwQegVTOCQTSHZzmPJdWN7Bmt4BvEJ8V8/1ExPL2Ceirp07IvqJbj2uDCcW2guKzT/TwNcPhk2Sh3gvCVHNDduQVHnD8r5rR8frw+ihBRGLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046132; c=relaxed/simple;
	bh=njTr8RbcFgdvmq7pMd62rzNVCZwMFJrNvhEZS3Hn1pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLTJbYj6C4M2VJ3XqDqlGAROMQ/hoH7tucdwGWN7TMenLOv5A+ZbEP44lggXe0bvMsqMXtTxFpxbIPrtHW7KBtx0nOqzG51hbK7bpUXkv2H0oB3X03YaQ8Zo4InXULbaobehkCelR8OP67Bappd5UZL9YAmDvFq/k6iETEdhGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E07sSCSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF5DC4CEDD;
	Mon,  7 Apr 2025 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744046131;
	bh=njTr8RbcFgdvmq7pMd62rzNVCZwMFJrNvhEZS3Hn1pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E07sSCSAHmYy+HGr343lvKCdv4oMSfWMIniSAvNNlu7zZ7O0aGtRR9NV5Yzb/3Rrt
	 LnRRws/fegpkMeO1wL+Dk3n5Gx7w2u7MFN+oiBYgUXe0KCohZNZaLw+8dNWN3e58qR
	 G5fMXaRR0dSmHtl9vwQzzSqSwZy3YKqdpq5E7w5xv+hMN9kInoUHYIXE2iUwttJADy
	 mY2Ip3+yt8+pVvvqF8shaxuIL9KETesDEo6w/toRNVEoX8iwfrERLU8hxOP35MOoo0
	 6KqosoILviXo1SdpYKMd6kanmUNiKaeuo+OHFuVsX8xO+I6G2XWp9z3/4RQndZdvpz
	 ZgLrWjUnymSRA==
Date: Mon, 7 Apr 2025 19:15:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Cengiz Can <cengiz.can@canonical.com>, 
	Attila Szasz <szasza.contact@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, dutyrok@altlinux.org, 
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com, stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <20250407-kumpel-klirren-ad0db3c77321@brauner>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
 <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
 <2025032404-important-average-9346@gregkh>
 <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>
 <20250407-biegung-furor-e7313ca9d712@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250407-biegung-furor-e7313ca9d712@brauner>

On Mon, Apr 07, 2025 at 12:59:18PM +0200, Christian Brauner wrote:
> On Sun, Apr 06, 2025 at 07:07:57PM +0300, Cengiz Can wrote:
> > On 24-03-25 11:53:51, Greg KH wrote:
> > > On Mon, Mar 24, 2025 at 09:43:18PM +0300, Cengiz Can wrote:
> > > > In the meantime, can we get this fix applied?
> > > 
> > > Please work with the filesystem maintainers to do so.
> > 
> > Hello Christian, hello Alexander
> > 
> > Can you help us with this?
> > 
> > Thanks in advance!
> 
> Filesystem bugs due to corrupt images are not considered a CVE for any
> filesystem that is only mountable by CAP_SYS_ADMIN in the initial user
> namespace. That includes delegated mounting.
> 
> Now, quoting from [1]:
> 
> "So, for the record, the Linux kernel in general only allows mounts for
> those with CAP_SYS_ADMIN, however, it is true that desktop and even
> server environments allow regular non-privileged users to mount and
> automount filesystems.
> 
> In particular, both the latest Ubuntu Desktop and Server versions come
> with default polkit rules that allow users with an active local session
> to create loop devices and mount a range of block filesystems commonly
> found on USB flash drives with udisks2. Inspecting
> /usr/share/polkit-1/actions/org.freedesktop.UDisks2.policy shows:"
> 
> So what this saying is:
> 
> A distribution is shipping tooling that allows unprivileged users to mount
> arbitrary filesystems including hpfsplus. Or to rephrase this: A
> distribution is allowing unprivileged users to mount orphaned
> filesystems. Congratulations on the brave decision to play Russian
> Roulette with a fully-loaded gun.
> 
> The VFS doesn't allow mounting arbitrary filesystems by unprivileged
> users. Every FS_REQUIRES_DEV filesystem requires global CAP_SYS_ADMIN
> privileged at which point you can also do sudo rm -rf --no-preserve-root /
> or a million other destructive things.
> 
> The blogpost is aware that the VFS maintainers don't accept CVEs like
> this. Yet a CVE was still filed against the upstream kernel. IOW,
> someone abused the fact that a distro chose to allow mounting arbitrary
> filesystems including orphaned ones by unprivileged user as an argument
> to gain a kernel CVE.
> 
> Revoke that CVE against the upstream kernel. This is a CVE against a
> distro. There's zero reason for us to hurry with any fix.

Before that gets misinterpreted: This is not intended to either
implicitly or explicitly imply that patch pickup is dependend on the
revocation of this CVE.

Since this isn't a valid CVE there's no reason to hurry-up merging this
into mainline within the next 24 hours. It'll get there whenever the
next fixes pr is ready.

> 
> [1]: https://ssd-disclosure.com/ssd-advisory-linux-kernel-hfsplus-slab-out-of-bounds-write/

