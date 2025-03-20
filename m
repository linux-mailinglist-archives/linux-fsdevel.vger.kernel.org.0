Return-Path: <linux-fsdevel+bounces-44522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56CA6A1A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549657A13A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C652163BD;
	Thu, 20 Mar 2025 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdZTscT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF1213245;
	Thu, 20 Mar 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460241; cv=none; b=Wdj4vU9XCJdzFEDmoBWjGy3hWecf/dOhU6WDNgpFy68EPP/AHGgbzL6D5CzgDgwm/uvBBO8WT+Se+ppJRjmrBy3Wnj516LaozagrJZW9U22Qn4QBgAR+zf7ckyqf8RSoXrGNKP2hAFvWpk34+yuYhkGQsVJwq96UWBsn3A8luj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460241; c=relaxed/simple;
	bh=l0Inw8wFnFNGHArrtx3usBlT263y+Eefj5DbomzJtPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lyd5zuPfAG4w0DDrUpkOoaj2pOgq9IZ4xaAh+TDYuAwLhetJQRjQwbJSHYA1VszeZiV9x1rlGtNTBbEltYmg9vuuvLaErlFYtplj4PDcykVSCJKBedP5pcTpprkPkQiuHqzQ6mxqTQT7ihWuriqnt8sq330Aix63JgLBUhQ4Abs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdZTscT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84C9C4CEDD;
	Thu, 20 Mar 2025 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742460240;
	bh=l0Inw8wFnFNGHArrtx3usBlT263y+Eefj5DbomzJtPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdZTscT+zxfy44Uh9np/8s0nW4N6LOt80yORQJ4xBZ0bZeROtdtyjui32KlnykNhO
	 C/NIwtg9pcdvGrtgqRHzjPv6b+S4GmmoSXzlFOwjL4fCa8IbsRGKnOh2iEXKzx5sIy
	 5VaQdgV6Td1GppXMCBSL+Q5CWrQfVsRvfzWJ1/aY1NxIb8ZXoZctFanRegqFbRu8YR
	 ixfSFQ+IUxJkgJiKGVtkavio+vsGeEJZw26wOlUFhpyPXXps+WrqAyAv1UpGOvBgUd
	 F24zNOLPh0Mk7LPYl+jrs7qOU0mJmiW9fhhfW2rrbYsZhx4NsfClt+tqf5pURT/SAx
	 HdQiGfGnaMK4w==
Date: Thu, 20 Mar 2025 09:43:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+de8b27abd23eac60e15f@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KCSAN: data-race in __lookup_mnt /
 __se_sys_pivot_root (6)
Message-ID: <20250320-anlegen-aussehen-398966105c59@brauner>
References: <67db8b5b.050a0220.31a16b.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67db8b5b.050a0220.31a16b.0001.GAE@google.com>

On Wed, Mar 19, 2025 at 08:28:27PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a7f2e10ecd8f Merge tag 'hwmon-fixes-for-v6.14-rc8/6.14' of..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=166a383f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f33d372c4021745
> dashboard link: https://syzkaller.appspot.com/bug?extid=de8b27abd23eac60e15f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/614aabc71b48/disk-a7f2e10e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d47dd90a010a/vmlinux-a7f2e10e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/418d8cf8782b/bzImage-a7f2e10e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+de8b27abd23eac60e15f@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in __lookup_mnt / __se_sys_pivot_root
> 
> write to 0xffff888118782d98 of 8 bytes by task 20163 on cpu 0:
>  unhash_mnt fs/namespace.c:1030 [inline]
>  __do_sys_pivot_root fs/namespace.c:4456 [inline]
>  __se_sys_pivot_root+0x850/0x1090 fs/namespace.c:4388
>  __x64_sys_pivot_root+0x31/0x40 fs/namespace.c:4388
>  x64_sys_call+0x1abf/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:156
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff888118782d98 of 8 bytes by task 20164 on cpu 1:
>  __lookup_mnt+0xa0/0xf0 fs/namespace.c:839
>  __follow_mount_rcu fs/namei.c:1592 [inline]
>  handle_mounts fs/namei.c:1622 [inline]
>  step_into+0x426/0x820 fs/namei.c:1952
>  walk_component fs/namei.c:2120 [inline]
>  link_path_walk+0x50e/0x830 fs/namei.c:2479
>  path_lookupat+0x72/0x2b0 fs/namei.c:2635
>  filename_lookup+0x150/0x340 fs/namei.c:2665
>  user_path_at+0x3c/0x120 fs/namei.c:3072
>  __do_sys_pivot_root fs/namespace.c:4404 [inline]
>  __se_sys_pivot_root+0x10e/0x1090 fs/namespace.c:4388
>  __x64_sys_pivot_root+0x31/0x40 fs/namespace.c:4388
>  x64_sys_call+0x1abf/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:156
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0xffff888106a31d80 -> 0xffff8881004dccc0

The race is perfectly benign. The change will be detected once the
sequence counter will be read in __follow_mount_rcu() which will cause a
drop-out of RCU into REF mode.

