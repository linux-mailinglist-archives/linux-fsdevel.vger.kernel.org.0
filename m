Return-Path: <linux-fsdevel+bounces-74105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB6DD2FB42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDC01306D510
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7923612FF;
	Fri, 16 Jan 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y79y+PRf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D835B12C;
	Fri, 16 Jan 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560010; cv=none; b=Oznb8qH764Rja+SEIO9/UlCdlJFnWq0APbQQ+tMnEjRvljR3ATFRpieGnYby0NQQdFBwzLPEZ2a5RjVbiprrBPP27yZzQJpuQnpsETGTzqw+dkkggbenw2H6LfcdYpjMrTDJ1uJ+bFKkAAcudWkSVB7DvOKGr9iUWDST0Sitalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560010; c=relaxed/simple;
	bh=GovwpZisxUo/QnZKXcwFXzUaw1ZE8Va6rJR7Ac5hpRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAzksddmDPoNBg3akQinJN61vsfkMgdIvfuJe1cEuKDMFJDzhYV0Eb7HXmgJPkVTKXteWxLXajdrmTiSdNubyjkdhqt4rFt+d6Kau1BXyGau/wVDGXHCEXIUKZpPyztERYxr70nuZx939bh5tND+O9QPlKIRTEvsVyB9giUVne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y79y+PRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7670C19422;
	Fri, 16 Jan 2026 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768560010;
	bh=GovwpZisxUo/QnZKXcwFXzUaw1ZE8Va6rJR7Ac5hpRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y79y+PRf1Ta3o21/dGtT0hIFKsYkysg3yvaKWH3pTIjnn3490lYgTxg1st0Edjn4H
	 uKV3LzNruqJbAwQ7xFtYuKoI5+0idj1fCVp5R0lvG0oTaK5GhWyJWNFMImr5j3QI26
	 MeYzzKZhRL8FYAh5K0Hz4YCSsKAWNzY9vULyt652TeLRMClisjqZaRLg3zkqwg1ze5
	 wsyouJJxhd2xcDzDQnFVNCOHaB5tbluQ5m01PASlDHUeQcXk8/fXDmBOUE94rP0LW4
	 1aOnZ9lnX6vcdDgJMgS0n82skrjCUVJa7tkiA76ZXia3jyZKlBFAUDLhIY2zfxAa6z
	 qQkCUOpDr8Mmg==
Date: Fri, 16 Jan 2026 11:40:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+55fd613012e606d75d45@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] possible deadlock in put_mnt_ns
Message-ID: <20260116-diebstahl-anmachen-546a1209101c@brauner>
References: <6968b860.050a0220.58bed.0018.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6968b860.050a0220.58bed.0018.GAE@google.com>

On Thu, Jan 15, 2026 at 01:50:24AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0f853ca2a798 Add linux-next specific files for 20260113
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1386f99a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=789b351b8a4cafe1
> dashboard link: https://syzkaller.appspot.com/bug?extid=55fd613012e606d75d45
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1482859a580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13402052580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9c7778b6d6be/disk-0f853ca2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ea278b0d6aff/vmlinux-0f853ca2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/60b94236c918/bzImage-0f853ca2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+55fd613012e606d75d45@syzkaller.appspotmail.com
> 
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fca229e5fa0 R14: 00007fca229e5fa0 R15: 0000000000000003
>  </TASK>
> ============================================
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> syz.0.23/6026 is trying to acquire lock:
> ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: namespace_lock fs/namespace.c:1730 [inline]
> ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: class_namespace_excl_constructor fs/namespace.c:101 [inline]
> ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: put_mnt_ns+0x170/0x2f0 fs/namespace.c:6241
> 
> but task is already holding lock:
> ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: namespace_lock fs/namespace.c:1730 [inline]
> ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: lock_mount_exact+0x89/0x630 fs/namespace.c:3852
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(namespace_sem);
>   lock(namespace_sem);

Groan, simple fix. opening nsfs fd must be done outside of the lock as
it would drop the mntns reference. Fixing.

