Return-Path: <linux-fsdevel+bounces-74113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5011D2FF0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A87A30D2D05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779803612E0;
	Fri, 16 Jan 2026 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srlq/N00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0565636166E;
	Fri, 16 Jan 2026 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560761; cv=none; b=EEoeRcu5ojr/vWyXWUv952+sJbd38uIA5/no9JaLFh3TD7dKf3l45XeC8o5vMbnyIHhTwXjFkSwcb8BgKAwnXcXYyt/m3CGjimQfE/OkumfQgntSD2bzD2qA8+gPS25K5QC4+E0CVg4iMjqpeCDRKwL+vfhxrTkZIZ0mOwC35Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560761; c=relaxed/simple;
	bh=VDOcIvvLRZuDhWYmq9H6ijTK7RL2GxLYLQ641E+v3Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4q2S8r/gNyKr1OLP8xQEeXKna3h5aNDhseAGBuVxHY+N3UUrlLPDu0bI67QD5RN1nQ9NFBtxpB1LqOD1aKJePPuJU+9AqJ6tpLBx5vOQXXCiex/GwTQ/02q2OIP2je2QGgSkM1OW7fmrmFCdxtjPbYFWMDPfBD2rl8nbkf+zZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srlq/N00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6244FC116C6;
	Fri, 16 Jan 2026 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768560760;
	bh=VDOcIvvLRZuDhWYmq9H6ijTK7RL2GxLYLQ641E+v3Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srlq/N0082UOBMHA+6XUDvi58/t4hG7RaIn2UEPcSzs5MlqDD54tfLpDoot8E03VB
	 6PrKz8dN4PxQvrbH6P9/K5KesIH0mU3SVP5irRDlluwQZhKxHpaQp5Y74QIv98KVZ5
	 Fv08wchWWstyA2sM6yl2BK6W7Hp/LtYGgMEgZGblBhfm70hTNoa/mRQbFYcCqqHdAd
	 HED6iLMLsWv9ie7nBNqhm/CAbg1p9wHHN99JXptRV2HS9ThmzCPAFIRysMF00vtfif
	 nOxnApqEpGxp3+IpCsAKuh9GlVS9chJCTaY7gr4pODUMC2e9HcUdOP3cgZuaZn9xbt
	 KdNfZE7k+BBTw==
Date: Fri, 16 Jan 2026 11:52:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+55fd613012e606d75d45@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] possible deadlock in put_mnt_ns
Message-ID: <20260116-kostbar-blass-171a72be1845@brauner>
References: <6968b860.050a0220.58bed.0018.GAE@google.com>
 <20260116-diebstahl-anmachen-546a1209101c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260116-diebstahl-anmachen-546a1209101c@brauner>

On Fri, Jan 16, 2026 at 11:40:06AM +0100, Christian Brauner wrote:
> On Thu, Jan 15, 2026 at 01:50:24AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    0f853ca2a798 Add linux-next specific files for 20260113
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1386f99a580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=789b351b8a4cafe1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=55fd613012e606d75d45
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1482859a580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13402052580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9c7778b6d6be/disk-0f853ca2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/ea278b0d6aff/vmlinux-0f853ca2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/60b94236c918/bzImage-0f853ca2.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+55fd613012e606d75d45@syzkaller.appspotmail.com
> > 
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007fca229e5fa0 R14: 00007fca229e5fa0 R15: 0000000000000003
> >  </TASK>
> > ============================================
> > WARNING: possible recursive locking detected
> > syzkaller #0 Not tainted
> > --------------------------------------------
> > syz.0.23/6026 is trying to acquire lock:
> > ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: namespace_lock fs/namespace.c:1730 [inline]
> > ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: class_namespace_excl_constructor fs/namespace.c:101 [inline]
> > ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: put_mnt_ns+0x170/0x2f0 fs/namespace.c:6241
> > 
> > but task is already holding lock:
> > ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: namespace_lock fs/namespace.c:1730 [inline]
> > ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: lock_mount_exact+0x89/0x630 fs/namespace.c:3852
> > 
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> > 
> >        CPU0
> >        ----
> >   lock(namespace_sem);
> >   lock(namespace_sem);
> 
> Groan, simple fix. opening nsfs fd must be done outside of the lock as
> it would drop the mntns reference. Fixing.

#syz test: https://github.com/brauner/linux.git vfs-7.0.namespace


