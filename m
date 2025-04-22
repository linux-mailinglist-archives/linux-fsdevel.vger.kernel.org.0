Return-Path: <linux-fsdevel+bounces-46873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D00AA95B66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA3B3A869F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3AA25C70A;
	Tue, 22 Apr 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwCE1ECT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106341DE4E3;
	Tue, 22 Apr 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288240; cv=none; b=jfirSH/Un+dTopRVYwbPSjurtUA3kjad/4xfzPdnJ6ehva0KMkyk+FStX0QzlZNJvIUsGQeQLZWIDxp7bOjW3IoyHJktCB+fdgz19Q5JhcU2OI3w+TggYqdKbMBs49jTYa8nDmVxdlmzGlNP6nPHGV+GIZdmcO71qJyZMB4eYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288240; c=relaxed/simple;
	bh=9E9dmMgwvuECvAjtU3yIQp0H2OoNidOKUWTx6hNHrI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8H/yRb6H8Z80S/ODnvKneFjYKnmlzEO9Q2bH/6uejcF15C/wcSKxZcbg6ITAQLlY6j3Ar6tlKpDsI32t7EDcCEI7SS0xhkN27/qmf1p5C/XAWHB4mbMbcKCiQvmoulZRxvSU/JBQE3P13Aa/OCkgcZ2p9QNVIGXpnGyPZWb/8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwCE1ECT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68701C4CEEC;
	Tue, 22 Apr 2025 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288239;
	bh=9E9dmMgwvuECvAjtU3yIQp0H2OoNidOKUWTx6hNHrI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwCE1ECTt8xl5qpCD+3r3tk5RtoGIZ+ym7gbMXlAFdhG0I5G+/WgVFZZG+LBJPhmU
	 16JtIxrV31ersML5WM084rF/amzqHb57PNgZ6haPzuHQzb2j21L1deCNgGPIiYSFtd
	 KgqPP5fwEwutBm+gRfp6JwYk0dDSwIj4GuBrmJFsBNfvTXpyYSMzEYQGE9V4X7CnjG
	 +qWvCKyjs5TUxDOTrHWaJ+ltpVSZ7B1o4glUDA4c6ldj50oLEYSDyxXz6rrEQa0ko5
	 Vq1ooMXgwriFuyopn9JPsqPljl3XVXKLLX4ZdPsVxBEaZyFvfXHlVsE8EOIf+pyU4V
	 pcdEqfXfkeJKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Song Liu <song@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pc@manguebit.com,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 09/23] netfs: Only create /proc/fs/netfs with CONFIG_PROC_FS
Date: Mon, 21 Apr 2025 22:16:49 -0400
Message-Id: <20250422021703.1941244-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
Content-Transfer-Encoding: 8bit

From: Song Liu <song@kernel.org>

[ Upstream commit 40cb48eba3b4b79e110c1a35d33a48cac54507a2 ]

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

Fix this by adding ifdef in netfs_main(), so that /proc/fs/netfs is only
created with CONFIG_PROC_FS.

Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/20250409170015.2651829-1-song@kernel.org
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 6c7be1377ee0e..3a8433e802cc2 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -125,11 +125,13 @@ static int __init netfs_init(void)
 	if (mempool_init_slab_pool(&netfs_subrequest_pool, 100, netfs_subrequest_slab) < 0)
 		goto error_subreqpool;
 
+#ifdef CONFIG_PROC_FS
 	if (!proc_mkdir("fs/netfs", NULL))
 		goto error_proc;
 	if (!proc_create_seq("fs/netfs/requests", S_IFREG | 0444, NULL,
 			     &netfs_requests_seq_ops))
 		goto error_procfile;
+#endif
 #ifdef CONFIG_FSCACHE_STATS
 	if (!proc_create_single("fs/netfs/stats", S_IFREG | 0444, NULL,
 				netfs_stats_show))
@@ -142,9 +144,11 @@ static int __init netfs_init(void)
 	return 0;
 
 error_fscache:
+#ifdef CONFIG_PROC_FS
 error_procfile:
 	remove_proc_subtree("fs/netfs", NULL);
 error_proc:
+#endif
 	mempool_exit(&netfs_subrequest_pool);
 error_subreqpool:
 	kmem_cache_destroy(netfs_subrequest_slab);
-- 
2.39.5


