Return-Path: <linux-fsdevel+bounces-77075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GecMqbBjmkMEgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:16:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD80133346
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DB3A30347A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F325487B;
	Fri, 13 Feb 2026 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BoE/4weF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD954758;
	Fri, 13 Feb 2026 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963363; cv=none; b=AjpAbljYpQBLsAJfG6l32FTJLuwnno5bZVujQTp73wGThpSH7txMJIfo7muusevV7x5qK/dWQKMpIHndDIWMepCJHoeH3wo4XFXXGNZvCRmNwOHOoIOlAUtuIhiwlIYzhSPRhGBUQLaaShwzXYeG0GY+lzKuDo7X4s77XXt4tCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963363; c=relaxed/simple;
	bh=W3RxpfxwjDUi/lf+ieDlNq3xonQWusqmMpzBKFNmLHg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dC7UPs3QBvs0KPME647+424tYeLCFKQGCxleGKvQlP7PwwjIISq5wGj7inSrnGAUwFA1v2xo0rNZY3ty5o1x4pcHBuii6G/XZkgXtLVYsu0I7sTiB9bhJgO8If2i8yWKu099FOGhgKPKxajIqRN5ChhkJi8kK6rQXsnTjTXO38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BoE/4weF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=R6MCeCQIudUdCJb7W2+7m3UWEQYipLV/JlJeNx6RuHo=; b=BoE/4weFlLW3aMCXhE/uNIrPeM
	vDqI6KW5PP287EtCGKpN5M30UZW1S8cP5jqOE3NT5ock4zwYy8+PG8V7qjNsa/35UpuKyl84lSf7p
	61rVZzDB4XIxPyaD/VFsxlpKBxyff4iii4vxTjSWhwSMKxwBJiQUzaT/ESfX9BCzjFxfT3yL0r8TX
	OiYA6TOpOHqs4qWzt8kBhgqjiw73A2h+Fw+B+M5mleFNLBVnzWivj+wuYMZadrbULzlWYHelxYL3/
	Kee9rC7bm9T5hGNEfEKP5/ZReptflYgdmI1y3AgMZEVyhEdJfB1V9jC91jH+hutxqDhN7cHTU/vSp
	wjo2h49Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqmT7-000000033Xv-3Pfl;
	Fri, 13 Feb 2026 06:16:00 +0000
Date: Thu, 12 Feb 2026 22:15:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: inconsistent lock state in the new fserror code
Message-ID: <aY7BndIgQg3ci_6s@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77075-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 8DD80133346
X-Rspamd-Action: no action

xfstests generic/108 makes lockdep unhappy with the new fserror code
in Linus' tree, see the trace below.  The problem seems to be that
igrab takes i_lock to protect against a inode that is beeing freed.
Error reporting doesn't care about that, but we don't really have
a good interface to just grab a reference.

[  149.494670] ================================
[  149.494871] WARNING: inconsistent lock state
[  149.495073] 6.19.0+ #4827 Tainted: G                 N 
[  149.495336] --------------------------------
[  149.495560] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[  149.495857] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  149.496111] ffff88811ed1b140 (&sb->s_type->i_lock_key#33){?.+.}-{3:3}, at: igrab+0x1a/0xb0
[  149.496543] {HARDIRQ-ON-W} state was registered at:
[  149.496853]   lock_acquire+0xca/0x2c0
[  149.497057]   _raw_spin_lock+0x2e/0x40
[  149.497257]   unlock_new_inode+0x2c/0xc0
[  149.497460]   xfs_iget+0xcf4/0x1080
[  149.497643]   xfs_trans_metafile_iget+0x3d/0x100
[  149.497882]   xfs_metafile_iget+0x2b/0x50
[  149.498144]   xfs_mount_setup_metadir+0x20/0x60
[  149.498163]   xfs_mountfs+0x457/0xa60
[  149.498163]   xfs_fs_fill_super+0x6b3/0xa90
[  149.498163]   get_tree_bdev_flags+0x13c/0x1e0
[  149.498163]   vfs_get_tree+0x27/0xe0
[  149.498163]   vfs_cmd_create+0x54/0xe0
[  149.498163]   __do_sys_fsconfig+0x309/0x620
[  149.498163]   do_syscall_64+0x8b/0xf80
[  149.498163]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  149.498163] irq event stamp: 139080
[  149.498163] hardirqs last  enabled at (139079): [<ffffffff813a923c>] do_idle+0x1ec/0x270
[  149.498163] hardirqs last disabled at (139080): [<ffffffff828a8d09>] common_interrupt+0x19/0xe0
[  149.498163] softirqs last  enabled at (139032): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120
[  149.498163] softirqs last disabled at (139025): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120
[  149.498163] 
[  149.498163] other info that might help us debug this:
[  149.498163]  Possible unsafe locking scenario:
[  149.498163] 
[  149.498163]        CPU0
[  149.498163]        ----
[  149.498163]   lock(&sb->s_type->i_lock_key#33);
[  149.498163]   <Interrupt>
[  149.498163]     lock(&sb->s_type->i_lock_key#33);
[  149.498163] 
[  149.498163]  *** DEADLOCK ***
[  149.498163] 
[  149.498163] 1 lock held by swapper/1/0:
[  149.498163]  #0: ffff8881052c81a0 (&vblk->vqs[i].lock){-.-.}-{3:3}, at: virtblk_done+0x4b/0x110
[  149.498163] 
[  149.498163] stack backtrace:
[  149.498163] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G                 N  6.19.0+ #4827 PREEMPT(full) 
[  149.498163] Tainted: [N]=TEST
[  149.498163] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[  149.498163] Call Trace:
[  149.498163]  <IRQ>
[  149.498163]  dump_stack_lvl+0x5b/0x80
[  149.498163]  print_usage_bug.part.0+0x22c/0x2c0
[  149.498163]  mark_lock+0xa6f/0xe90
[  149.498163]  ? mempool_alloc_noprof+0x91/0x130
[  149.498163]  ? set_track_prepare+0x39/0x60
[  149.498163]  ? mempool_alloc_noprof+0x91/0x130
[  149.498163]  ? fserror_report+0x8a/0x260
[  149.498163]  ? iomap_finish_ioend_buffered+0x170/0x210
[  149.498163]  ? clone_endio+0x8f/0x1c0
[  149.498163]  ? blk_update_request+0x1e4/0x4d0
[  149.498163]  ? blk_mq_end_request+0x1b/0x100
[  149.498163]  ? virtblk_done+0x6f/0x110
[  149.498163]  ? vring_interrupt+0x59/0x80
[  149.498163]  ? __handle_irq_event_percpu+0x8a/0x2e0
[  149.498163]  ? handle_irq_event+0x33/0x70
[  149.498163]  ? handle_edge_irq+0xdd/0x1e0
[  149.498163]  __lock_acquire+0x10b6/0x25e0
[  149.498163]  ? __pcs_replace_empty_main+0x369/0x510
[  149.498163]  ? __pcs_replace_empty_main+0x369/0x510
[  149.498163]  lock_acquire+0xca/0x2c0
[  149.498163]  ? igrab+0x1a/0xb0
[  149.498163]  ? rcu_is_watching+0x11/0x50
[  149.498163]  ? __kmalloc_noprof+0x3ab/0x5a0
[  149.498163]  _raw_spin_lock+0x2e/0x40
[  149.498163]  ? igrab+0x1a/0xb0
[  149.498163]  igrab+0x1a/0xb0
[  149.498163]  fserror_report+0x135/0x260
[  149.498163]  iomap_finish_ioend_buffered+0x170/0x210
[  149.498163]  ? __pfx_stripe_end_io+0x10/0x10
[  149.498163]  clone_endio+0x8f/0x1c0
[  149.498163]  blk_update_request+0x1e4/0x4d0
[  149.498163]  ? __pfx_sg_pool_free+0x10/0x10
[  149.498163]  ? mempool_free+0x3d/0x50
[  149.498163]  blk_mq_end_request+0x1b/0x100
[  149.498163]  virtblk_done+0x6f/0x110
[  149.498163]  vring_interrupt+0x59/0x80
[  149.498163]  __handle_irq_event_percpu+0x8a/0x2e0
[  149.498163]  handle_irq_event+0x33/0x70
[  149.498163]  handle_edge_irq+0xdd/0x1e0
[  149.498163]  __common_interrupt+0x6f/0x180
[  149.498163]  common_interrupt+0xb7/0xe0
[  149.498163]  </IRQ>
[  149.498163]  <TASK>
[  149.498163]  asm_common_interrupt+0x26/0x40
[  149.498163] RIP: 0010:default_idle+0xf/0x20
[  149.498163] Code: 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d a9 88 15 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[  149.498163] RSP: 0018:ffffc9000009fed8 EFLAGS: 00000206
[  149.498163] RAX: 0000000000021f47 RBX: ffff888100ad53c0 RCX: 0000000000000000
[  149.498163] RDX: 0000000000000000 RSI: ffffffff83278fb9 RDI: ffffffff8329090b
[  149.498163] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[  149.498163] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  149.498163] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  149.498163]  default_idle_call+0x7e/0x1a0
[  149.498163]  do_idle+0x1ec/0x270
[  149.498163]  cpu_startup_entry+0x24/0x30
[  149.498163]  start_secondary+0xf7/0x100
[  149.498163]  common_startup_64+0x13e/0x148
[  149.498163]  </TASK>

