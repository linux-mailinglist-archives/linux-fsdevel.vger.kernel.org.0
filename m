Return-Path: <linux-fsdevel+bounces-54438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC09AFFB2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62851C48234
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1F28B3E7;
	Thu, 10 Jul 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRavN8q+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33928A1CC;
	Thu, 10 Jul 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133339; cv=none; b=EAwbdVfQT6RobVR0hSqNdKBLYMNLhN1DGWLXRygG+vnN3oVdTKLFyr2Rq4/YcskDXcrK7S8s6bEE4Gwvsr4hk8tdXuXIs+SC9W9u4vWmwE8ahDHOMUo3C/+7blnZWrRXdiaF+8xLzyyyLKvFNgbdXx9PFoNkR69+kv1OTXHr6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133339; c=relaxed/simple;
	bh=5HRCIqpzoAh0WXlu0yZBnyBN2sSTIllnMwkUl+dRio4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFGvqXbd0RIKNL2osxKK162ZZms1kqJs7D5vP+X7Dj82IdHKxSRqaf/HmuIg5+aDkrAJSGybQ7jFy/tF1XsOTjnCOdlHrSKDL2vvGd+LYSQT8u1M5YMz2eJsD10J8aABnkHZb72+uxuP9GWIaSqxJoGGjb522V7EOg5rVs8kCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRavN8q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ABAC4CEE3;
	Thu, 10 Jul 2025 07:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752133339;
	bh=5HRCIqpzoAh0WXlu0yZBnyBN2sSTIllnMwkUl+dRio4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRavN8q+200eZihwvBuXy+p6Yd11P7b3U0n8eZwyaoiShn+t9JXXPAQ5Y253hDyqT
	 GhaS7V//zKvEN8EGuh5P5FRlL6LlSV90ia7TbemMqDTZZ5MK3RQqxxn6mdPBr/2/MY
	 +WdtKlYfkRPZpSKh7pOxF0yQ57i51p3EQnKDyVUFYwLgWjl8fdzKDWXGXhG2viBUxh
	 U/VRFE9EbXmHupE4x1u+gtPN3gXYfi2tG/p8amSgfjdYcNTfUeOGPZh7pdOOvJdJFW
	 ueoHDoApOKisedgJCmPmY/G7QWUTAwLLDvuQ5tr46xaUcVtUMXCQi3C6FOCXOIdoFz
	 a28AcikNG37Mg==
Date: Thu, 10 Jul 2025 09:42:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>, 
	konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, mjguzik@gmail.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	ntfs3@lists.linux.dev, Dave Kleikamp <shaggy@kernel.org>, 
	jfs-discussion@lists.sourceforge.net
Subject: Re: [syzbot] [nilfs?] kernel BUG in may_open (2)
Message-ID: <20250710-getrunken-fazit-74e068b05c16@brauner>
References: <686d5a9f.050a0220.1ffab7.0015.GAE@google.com>
 <xrpmf6yj32iirfaumpbal6qxph7mkmgwtra7p4hpbvzozlp4zr@2bzl4p5ejgfj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xrpmf6yj32iirfaumpbal6qxph7mkmgwtra7p4hpbvzozlp4zr@2bzl4p5ejgfj>

On Wed, Jul 09, 2025 at 10:30:12AM +0200, Jan Kara wrote:
> Hi!
> 
> On Tue 08-07-25 10:51:27, syzbot wrote:
> > syzbot found the following issue on:
> > 
> > HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=107e728c580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=72aa0474e3c3b9ac
> > dashboard link: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11305582580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10952bd4580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/605b3edeb031/disk-d7b8f8e2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/a3cb6f3ea4a9/vmlinux-d7b8f8e2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/cd9e0c6a9926/bzImage-d7b8f8e2.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/2a7ab270a8da/mount_0.gz
> > 
> > The issue was bisected to:
> > 
> > commit af153bb63a336a7ca0d9c8ef4ca98119c5020030
> > Author: Mateusz Guzik <mjguzik@gmail.com>
> > Date:   Sun Feb 9 18:55:21 2025 +0000
> > 
> >     vfs: catch invalid modes in may_open()
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f94a8c580000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=14054a8c580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10054a8c580000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com
> > Fixes: af153bb63a33 ("vfs: catch invalid modes in may_open()")
> > 
> > VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)) encountered for inode ffff8880724735b8
> 
> FWIW the reproducer just mounts a filesystem image and opens a file there
> which crashes because the inode type is invalid. Which suggests there's
> insufficient validation of inode metadata (in particular the inode mode)
> being loaded from the disk... There are reproducers in the syzbot dashboard
> for nilfs2, ntfs3, isofs, jfs. I'll take care of isofs, added other
> filesystem maintainers to CC.

I'm certainly happy to have added that assert.

