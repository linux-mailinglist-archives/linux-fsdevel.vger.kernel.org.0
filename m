Return-Path: <linux-fsdevel+bounces-52650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF5BAE571B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 00:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB72D3AB110
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05C2253B0;
	Mon, 23 Jun 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n+6MKKIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57015ADB4
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717402; cv=none; b=Dt/exEIy8wOKrQNCgdADzuNFOKbegFWmvWRVKop6y/M1QUSDkz8LHVqa7Y6wO/phcLpMinWPg7c02Wa8opJKunok2aS0qUNFtWp/Brb4VAj/JbeLlKsI4aX8fuE3ft3WZ9SJe+aylRa+65hjkR2EQEafx3F8aEKI627g96JBKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717402; c=relaxed/simple;
	bh=jEobdDy/hJlHDDUFWxXm1oGZzLdO79kNql9jBCWwQk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqjV1tsl1LXx9AW9TzccKenpOjiyzxgKItGHB28BZarvJotGFlPa4yqxGVbJOxw/v8Qo/LEKxTfq4L2Jy1e5eFxPhLfuVXMOrBOuRSXNay1/gLZUZzS90TQImVcK0chCsNyeSMj6T/DHfp9/M6bBH5u16Nd6MXbtECrXH9Q5mHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=n+6MKKIV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DJhCzgrhXDPMIqZ39xUK33VeRWPminImEiObxGzUjLw=; b=n+6MKKIVXRKxXyFe7sVWL2WcyA
	++SV3x0cFBjM+lWtr4T1CzAvJ9l79HLLVQp2Y3yQgGpz7eXRPjHOELQMEZvWLVGdS3BKGvlwDes0v
	uabDT17VjzLuvIG1i6fwRJLP22fJx3IxcaDFZoNoWFX+yuWy7rwe3BRJ+7MepXSSKM9mBV9Z8p+vN
	mk6y5DlraELLPdr1MtiJ9tBe2ww4sVsBk+oDTdcSQlKsHcVuxnXbReMekNhPFKoIsYYl3yrN3aUDX
	aisJ94Wq9QreBD4sOV3xPuzaBXiFWhz8QkpnSql/glQuM3+uonRBY17ADzIL0GE83ppy+rTD5F7dt
	uFXeRaRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTpZM-00000001OZw-0iIM;
	Mon, 23 Jun 2025 22:23:16 +0000
Date: Mon, 23 Jun 2025 23:23:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: John Johansen <john@apparmor.net>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][BUG] ns_mkdir_op() locking is FUBAR
Message-ID: <20250623222316.GK1880847@ZenIV>
References: <20250623213747.GJ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623213747.GJ1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 23, 2025 at 10:37:47PM +0100, Al Viro wrote:

> Could you explain what exclusion are you trying to get there?
> The mechanism is currently broken, but what is it trying to achieve?

While we are at it:

root@kvm1:~# cd /sys/kernel/security/apparmor/policy
root@kvm1:/sys/kernel/security/apparmor/policy# (for i in `seq 270`; do mkdir namespaces/$i; cd namespaces/$i; done)
root@kvm1:/sys/kernel/security/apparmor/policy# rmdir namespaces/1
[   40.980453] Oops: stack guard page: 0000 [#1] PREEMPT SMP NOPTI
[   40.980457] CPU: 3 UID: 0 PID: 2223 Comm: rmdir Not tainted 6.12.27-amd64 #11
[   40.980459] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.164
[   40.980460] RIP: 0010:inode_set_ctime_current+0x2c/0x100
[   40.980490] Code: 1e fa 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 53 31 db 48 8f
[   40.980491] RSP: 0018:ffffc1cbc2cfbff8 EFLAGS: 00010292
[   40.980493] RAX: 0000000000400000 RBX: 0000000000000000 RCX: ffff9dbcc358ac70
[   40.980494] RDX: 0000000000000001 RSI: ffff9dbcc48c0300 RDI: ffffc1cbc2cfbff8
[   40.980495] RBP: ffffc1cbc2cfc028 R08: 0000000000000000 R09: ffffffffa484c6c0
[   40.980495] R10: ffff9dbcc0729cc0 R11: 0000000000000002 R12: ffff9dbcc4a75b28
[   40.980496] R13: ffff9dbcc4a75b28 R14: ffff9dbcc01fe600 R15: ffff9dbcc51a9e00
[   40.980498] FS:  00007ffb70ea4740(0000) GS:ffff9dbfefd80000(0000) knlGS:00000
[   40.980499] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.980499] CR2: ffffc1cbc2cfbfe8 CR3: 000000010619a000 CR4: 00000000000006f0
[   40.980501] Call Trace:
[   40.980510]  <TASK>
[   40.980513]  simple_unlink+0x24/0x50
[   40.980526]  aafs_remove+0x9a/0xb0
[   40.980543]  __aafs_ns_rmdir+0x2ec/0x3b0
[   40.980548]  destroy_ns.part.0+0x9f/0xc0
[   40.980558]  __aa_remove_ns+0x44/0x90
[   40.980560]  destroy_ns.part.0+0x40/0xc0
[   40.980562]  __aa_remove_ns+0x44/0x90
[   40.980563]  destroy_ns.part.0+0x40/0xc0
.....
[   40.981324]  ns_rmdir_op+0x189/0x300
[   40.981327]  vfs_rmdir+0x9b/0x200
[   40.981335]  do_rmdir+0x1ac/0x1c0
[   40.981340]  __x64_sys_rmdir+0x3f/0x70
[   40.981342]  do_syscall_64+0x82/0x190
[   40.981360]  ? do_fault+0x31a/0x550
[   40.981372]  ? __handle_mm_fault+0x7c2/0xf70
[   40.981373]  ? syscall_exit_to_user_mode_prepare+0x149/0x170
[   40.981388]  ? __count_memcg_events+0x53/0xf0
[   40.981392]  ? count_memcg_events.constprop.0+0x1a/0x30
[   40.981394]  ? handle_mm_fault+0x1bb/0x2c0
[   40.981396]  ? do_user_addr_fault+0x36c/0x620
[   40.981408]  ? exc_page_fault+0x7e/0x180
[   40.981412]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
.....
[   40.981486] Kernel panic - not syncing: Fatal exception in interrupt

I realize that anyone who can play with apparmor config can screw the
box into the ground in a lot of ways, but... when you have a recursion
kernel-side, it would be nice to have its depth bounded.  Not even root
should be able to panic the box with a single call of rmdir(2)...

