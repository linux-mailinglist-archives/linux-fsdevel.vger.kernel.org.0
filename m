Return-Path: <linux-fsdevel+bounces-45912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E45A7EC72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 21:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA9344539A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 19:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D7223701;
	Mon,  7 Apr 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdulYC15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A41223710;
	Mon,  7 Apr 2025 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051661; cv=none; b=s+SSroRYUn5b0j8KY62SxM8BIdHPxXxIsiprZ/jBSUgIThfPj9xhTRppW7nxF3va135Fbwf1C0Wd9WPi1lzqgeOUlEAZV8cabEg5fZ9d2K8HJemkBR4qQE/2++WCLv3Ia/ez1AjGoLdNXWjeliHybfbUW4399L8w9T0BWamUQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051661; c=relaxed/simple;
	bh=iYdKnTLk1c8N6rB1/bxBpjUsc37PO7bqR4dC86w0XcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mnk5c55WzLha5tCBpg1QQheEdQcTglNPzd4pH+DFxTFgXnPpRgI5uiFvxmZO/Bb0DY8/B5tAfj2B3c6YvtMwapa4swpi736T7QFxJaKhkPZhhB6Yq+RvR0asum8cFSTLvfKhxmeN/avoi0Aci6eigTmAmrhS9gmaa1ZtyrB9y8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdulYC15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D851FC4CEDD;
	Mon,  7 Apr 2025 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051660;
	bh=iYdKnTLk1c8N6rB1/bxBpjUsc37PO7bqR4dC86w0XcY=;
	h=From:To:Cc:Subject:Date:From;
	b=SdulYC152hvv73DRAz146h090so5vl3MZFu3A8wzEp4gAkjejjivVdDmVgCMWzYtK
	 Z+Tkg1BFxBA9Un1qtI9dKUScRUxqbKqYKHeOf7aX5PoWLP+bx5KDHeYXFqcpaZB10z
	 fLyBnbKYipVAXUhlbqHP0bK+q/e3qaOTaX8IOsmM6oI7BaF6fLqlNGPzDRPzkK3AFc
	 6BgEhkaObogeTH9W01CPT5EoayCQhBahXIfw/cmyFzbU3m8R/Osd9irZAxuZm0sV1B
	 pklivA89LMSjetm6UW7jE4shw3X/1/FL9MQ8RAPG6lW8T1MYrbF7NdhdbTDy93JckE
	 CMFB38v8lx7EQ==
From: Song Liu <song@kernel.org>
To: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: dhowells@redhat.com,
	pc@manguebit.com,
	kernel-team@fb.com,
	Song Liu <song@kernel.org>
Subject: [PATCH] netfs: Let netfs depends on PROC_FS
Date: Mon,  7 Apr 2025 11:47:30 -0700
Message-ID: <20250407184730.3568147-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing a special config:

CONFIG_NETFS_SUPPORTS=y
CONFIG_PROC_FS=n

The system crashes with something like:

[    3.766197] ------------[ cut here ]------------
[    3.766484] kernel BUG at mm/mempool.c:560!
[    3.766789] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[    3.767123] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W
[    3.767777] Tainted: [W]=WARN
[    3.767968] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
[    3.768523] RIP: 0010:mempool_alloc_slab.cold+0x17/0x19
[    3.768847] Code: 50 fe ff 58 5b 5d 41 5c 41 5d 41 5e 41 5f e9 93 95 13 00
[    3.769977] RSP: 0018:ffffc90000013998 EFLAGS: 00010286
[    3.770315] RAX: 000000000000002f RBX: ffff888100ba8640 RCX: 0000000000000000
[    3.770749] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000ffffffff
[    3.771217] RBP: 0000000000092880 R08: 0000000000000000 R09: ffffc90000013828
[    3.771664] R10: 0000000000000001 R11: 00000000ffffffea R12: 0000000000092cc0
[    3.772117] R13: 0000000000000400 R14: ffff8881004b1620 R15: ffffea0004ef7e40
[    3.772554] FS:  0000000000000000(0000) GS:ffff8881b5f3c000(0000) knlGS:0000000000000000
[    3.773061] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.773443] CR2: ffffffff830901b4 CR3: 0000000004296001 CR4: 0000000000770ef0
[    3.773884] PKRU: 55555554
[    3.774058] Call Trace:
[    3.774232]  <TASK>
[    3.774371]  mempool_alloc_noprof+0x6a/0x190
[    3.774649]  ? _printk+0x57/0x80
[    3.774862]  netfs_alloc_request+0x85/0x2ce
[    3.775147]  netfs_readahead+0x28/0x170
[    3.775395]  read_pages+0x6c/0x350
[    3.775623]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.775928]  page_cache_ra_unbounded+0x1bd/0x2a0
[    3.776247]  filemap_get_pages+0x139/0x970
[    3.776510]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.776820]  filemap_read+0xf9/0x580
[    3.777054]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.777368]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.777674]  ? find_held_lock+0x32/0x90
[    3.777929]  ? netfs_start_io_read+0x19/0x70
[    3.778221]  ? netfs_start_io_read+0x19/0x70
[    3.778489]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.778800]  ? lock_acquired+0x1e6/0x450
[    3.779054]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.779379]  netfs_buffered_read_iter+0x57/0x80
[    3.779670]  __kernel_read+0x158/0x2c0
[    3.779927]  bprm_execve+0x300/0x7a0
[    3.780185]  kernel_execve+0x10c/0x140
[    3.780423]  ? __pfx_kernel_init+0x10/0x10
[    3.780690]  kernel_init+0xd5/0x150
[    3.780910]  ret_from_fork+0x2d/0x50
[    3.781156]  ? __pfx_kernel_init+0x10/0x10
[    3.781414]  ret_from_fork_asm+0x1a/0x30
[    3.781677]  </TASK>
[    3.781823] Modules linked in:
[    3.782065] ---[ end trace 0000000000000000 ]---

This is caused by the following error path in netfs_init():

        if (!proc_mkdir("fs/netfs", NULL))
                goto error_proc;

Fix this by letting netfs depends on PROC_FS.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/netfs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index 7701c037c328..df9d2a8739e7 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -2,6 +2,7 @@
 
 config NETFS_SUPPORT
 	tristate
+	depends on PROC_FS
 	help
 	  This option enables support for network filesystems, including
 	  helpers for high-level buffered I/O, abstracting out read
@@ -9,7 +10,7 @@ config NETFS_SUPPORT
 
 config NETFS_STATS
 	bool "Gather statistical information on local caching"
-	depends on NETFS_SUPPORT && PROC_FS
+	depends on NETFS_SUPPORT
 	help
 	  This option causes statistical information to be gathered on local
 	  caching and exported through file:
-- 
2.47.1


