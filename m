Return-Path: <linux-fsdevel+bounces-45858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D3A7DBBC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD673B63A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA323908C;
	Mon,  7 Apr 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrqLyh0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5C21E098;
	Mon,  7 Apr 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023564; cv=none; b=PeAQMp/JW51CT2yDyMyWu/rFdfxuCH4xRQgFBbO54MtTRrzCkcUvLmGWQ9yndQZjOIicPX9Jq8PimzJ/JAH+w5ubf6MHS3E1GPN8pjhQd3YpA71FBzdYlq4YPxYxzq9wGNNackVHC7pbv4vHafn1rUXqlXDhk6Vs/Vdn5kQpPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023564; c=relaxed/simple;
	bh=zylTLIN0qUpLoPTgkIgrGalrS9zEVqUvpzxrYi2gcVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is7qiQFycxTVdNP5P6z3J67ko0KwNADk7p74KdojN5bB/xed9moG3iG/F8rbvJjQbKmUUZzoDrtJSSxfS3CXigGwxJnf6CaIUBcXxjX44mmLLPnQlltlv+kVGrzI7NiBU3ZGWl0RkSyonbbC5KLQHfnz7txErIYamchc22GuGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrqLyh0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEA2C4CEDD;
	Mon,  7 Apr 2025 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744023563;
	bh=zylTLIN0qUpLoPTgkIgrGalrS9zEVqUvpzxrYi2gcVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XrqLyh0wT0ExUkwKa097cUipLfCYdPndBjwXJMAmVk/1TmkR8GnslLCv8dvO5NtNJ
	 O/gx+O+az3b+TCC05Vdx82BjU2pE2y6Rl4qcGv3bVgSmX0jxJtTg7SYKhT/TKbbutb
	 4AHr4qYTKrYoBg73kIpD8AMREoMihES7MzVGqmiHplpIjB+AUFel53Xlw0zXdWVt42
	 bfICta+Mq8hntLEtjCM19UKbXzqJpKMBt1CRu4XzftRIexl8UVr6ACIMqWhJ04wzNj
	 gHXSJAl+hmzcAtnTF/BiZ6CNJkJzndjjVMPfXizbI37cDzctnQeJYSieSknJBaEVYz
	 hHTPLTfXk08gg==
Date: Mon, 7 Apr 2025 12:59:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Cengiz Can <cengiz.can@canonical.com>, 
	Attila Szasz <szasza.contact@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, dutyrok@altlinux.org, 
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com, stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <20250407-biegung-furor-e7313ca9d712@brauner>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
 <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
 <2025032404-important-average-9346@gregkh>
 <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>

On Sun, Apr 06, 2025 at 07:07:57PM +0300, Cengiz Can wrote:
> On 24-03-25 11:53:51, Greg KH wrote:
> > On Mon, Mar 24, 2025 at 09:43:18PM +0300, Cengiz Can wrote:
> > > In the meantime, can we get this fix applied?
> > 
> > Please work with the filesystem maintainers to do so.
> 
> Hello Christian, hello Alexander
> 
> Can you help us with this?
> 
> Thanks in advance!

Filesystem bugs due to corrupt images are not considered a CVE for any
filesystem that is only mountable by CAP_SYS_ADMIN in the initial user
namespace. That includes delegated mounting.

Now, quoting from [1]:

"So, for the record, the Linux kernel in general only allows mounts for
those with CAP_SYS_ADMIN, however, it is true that desktop and even
server environments allow regular non-privileged users to mount and
automount filesystems.

In particular, both the latest Ubuntu Desktop and Server versions come
with default polkit rules that allow users with an active local session
to create loop devices and mount a range of block filesystems commonly
found on USB flash drives with udisks2. Inspecting
/usr/share/polkit-1/actions/org.freedesktop.UDisks2.policy shows:"

So what this saying is:

A distribution is shipping tooling that allows unprivileged users to mount
arbitrary filesystems including hpfsplus. Or to rephrase this: A
distribution is allowing unprivileged users to mount orphaned
filesystems. Congratulations on the brave decision to play Russian
Roulette with a fully-loaded gun.

The VFS doesn't allow mounting arbitrary filesystems by unprivileged
users. Every FS_REQUIRES_DEV filesystem requires global CAP_SYS_ADMIN
privileged at which point you can also do sudo rm -rf --no-preserve-root /
or a million other destructive things.

The blogpost is aware that the VFS maintainers don't accept CVEs like
this. Yet a CVE was still filed against the upstream kernel. IOW,
someone abused the fact that a distro chose to allow mounting arbitrary
filesystems including orphaned ones by unprivileged user as an argument
to gain a kernel CVE.

Revoke that CVE against the upstream kernel. This is a CVE against a
distro. There's zero reason for us to hurry with any fix.

[1]: https://ssd-disclosure.com/ssd-advisory-linux-kernel-hfsplus-slab-out-of-bounds-write/

