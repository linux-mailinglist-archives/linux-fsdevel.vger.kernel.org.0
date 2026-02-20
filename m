Return-Path: <linux-fsdevel+bounces-77762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EdZEpmyl2mb6QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 02:02:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6939164100
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 02:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD400301809A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E181A256B;
	Fri, 20 Feb 2026 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8Ve/rPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3BE2AD2C;
	Fri, 20 Feb 2026 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549325; cv=none; b=oD/fhLgTO4sRBPaicTouw9FA/V+iYcZj6dSqpFyeYjoE1q2+yaB8FM/Z8jQUztUh2l3/mIVaDdRB7Rf48wbgNsbrZ4uc9Dk7nxwXVKpdEY+EbJ/jlK03tWFtQdK8Vk5S4xpbb4f7r7MUvvU6dXVqKM2DR3HHH0sc/g2Q7pz/vb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549325; c=relaxed/simple;
	bh=yaHAX6Xx1SaBmdGNesRQKsSdD6Ia5hfAIINgbudg2UU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYj0MGGCCF2Apgl/C8etK52J+VONYhdTC4SRcORJPOQkiFGIOOQhuZyhkOwowvJJZLazWWytvrTUkgJwSpZ8Eg9/uxznRQ5Jjs/Hn3ir4yxGxKN1sfVBus1vZcK8Ac6YQJ+E8pXTp7z6OQwKkaJjkFjJVdA819AV7r30JKoGnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8Ve/rPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71925C4CEF7;
	Fri, 20 Feb 2026 01:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771549325;
	bh=yaHAX6Xx1SaBmdGNesRQKsSdD6Ia5hfAIINgbudg2UU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=f8Ve/rPKynS1etF6BCUHukQmxfLbhq7PB3/O+7pHFw0UWNj0a48QoZ0THNX7UjJKN
	 YrgGD2szHSe7wEcqllDxanINZ9jz4XTClXCHL3Fgb2Ke4rnHujnK+s1tb5ARs1RiJu
	 h2JslpL4s1FtEpm5J4GOO0hRCcKAT2xlezBeGwKMJs9Lq6ZLxbjB88B1BslBm+7hxF
	 k9nnYcZ3Ga2MaaUzrff2XG7JH5nGrDvJQ6Yra7JKcE+MyzG9sukXMF6H1bNgCPC6hl
	 PyO8QTAI/hRh1Ls9RCIlt/jETzN8tUKa9/L59NNkFA5f4s8NjXE6Fdj1FUKDBFo1eL
	 yP9ARb2zh+tXg==
Date: Thu, 19 Feb 2026 17:02:05 -0800
Subject: [PATCH 2/2] fserror: fix lockdep complaint when igrabbing inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: hch@infradead.org, hch@lst.de, linux-xfs@vger.kernel.org,
 brauner@kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <177154904047.1351989.1087153602279831695.stgit@frogsfrogsfrogs>
In-Reply-To: <177154903995.1351989.7277473944406826383.stgit@frogsfrogsfrogs>
References: <177154903995.1351989.7277473944406826383.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77762-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,lst.de:email]
X-Rspamd-Queue-Id: D6939164100
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Christoph Hellwig reported a lockdep splat in generic/108:

 ================================
 WARNING: inconsistent lock state
 6.19.0+ #4827 Tainted: G                 N
 --------------------------------
 inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
 swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 ffff88811ed1b140 (&sb->s_type->i_lock_key#33){?.+.}-{3:3}, at: igrab+0x1a/0xb0
 {HARDIRQ-ON-W} state was registered at:
   lock_acquire+0xca/0x2c0
   _raw_spin_lock+0x2e/0x40
   unlock_new_inode+0x2c/0xc0
   xfs_iget+0xcf4/0x1080
   xfs_trans_metafile_iget+0x3d/0x100
   xfs_metafile_iget+0x2b/0x50
   xfs_mount_setup_metadir+0x20/0x60
   xfs_mountfs+0x457/0xa60
   xfs_fs_fill_super+0x6b3/0xa90
   get_tree_bdev_flags+0x13c/0x1e0
   vfs_get_tree+0x27/0xe0
   vfs_cmd_create+0x54/0xe0
   __do_sys_fsconfig+0x309/0x620
   do_syscall_64+0x8b/0xf80
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
 irq event stamp: 139080
 hardirqs last  enabled at (139079): [<ffffffff813a923c>] do_idle+0x1ec/0x270
 hardirqs last disabled at (139080): [<ffffffff828a8d09>] common_interrupt+0x19/0xe0
 softirqs last  enabled at (139032): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120
 softirqs last disabled at (139025): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&sb->s_type->i_lock_key#33);
   <Interrupt>
     lock(&sb->s_type->i_lock_key#33);

  *** DEADLOCK ***

 1 lock held by swapper/1/0:
  #0: ffff8881052c81a0 (&vblk->vqs[i].lock){-.-.}-{3:3}, at: virtblk_done+0x4b/0x110

 stack backtrace:
 CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G                 N  6.19.0+ #4827 PREEMPT(full)
 Tainted: [N]=TEST
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x5b/0x80
  print_usage_bug.part.0+0x22c/0x2c0
  mark_lock+0xa6f/0xe90
  __lock_acquire+0x10b6/0x25e0
  lock_acquire+0xca/0x2c0
  _raw_spin_lock+0x2e/0x40
  igrab+0x1a/0xb0
  fserror_report+0x135/0x260
  iomap_finish_ioend_buffered+0x170/0x210
  clone_endio+0x8f/0x1c0
  blk_update_request+0x1e4/0x4d0
  blk_mq_end_request+0x1b/0x100
  virtblk_done+0x6f/0x110
  vring_interrupt+0x59/0x80
  __handle_irq_event_percpu+0x8a/0x2e0
  handle_irq_event+0x33/0x70
  handle_edge_irq+0xdd/0x1e0
  __common_interrupt+0x6f/0x180
  common_interrupt+0xb7/0xe0
  </IRQ>

It looks like the concern here is that inode::i_lock is sometimes taken
in IRQ context, and sometimes it is held when going to IRQ context,
though it's a little difficult to tell since I think this is a kernel
from after the actual 6.19 release but before 7.0-rc1.

Either way, we don't need to take i_lock, because filesystems should
not report files to fserror if they're about to be freed or have not
yet been exposed to other threads, because the resulting fsnotify report
will be meaningless.

Therefore, add the ioend to a queue and get an async worker to chug
through the error events from process context with no filesystem locks
already held.

Link: https://lore.kernel.org/linux-fsdevel/aY7BndIgQg3ci_6s@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/ioend.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)


diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index e4d57cb969f1bb..4d1ef8a2cee90b 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -69,11 +69,57 @@ static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
 	return folio_count;
 }
 
+static DEFINE_SPINLOCK(failed_ioend_lock);
+static LIST_HEAD(failed_ioend_list);
+
+static void
+iomap_fail_ioends(
+	struct work_struct	*work)
+{
+	struct iomap_ioend	*ioend;
+	struct list_head	tmp;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&failed_ioend_lock, flags);
+	list_replace_init(&failed_ioend_list, &tmp);
+	spin_unlock_irqrestore(&failed_ioend_lock, flags);
+
+	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
+			io_list))) {
+		list_del_init(&ioend->io_list);
+		iomap_finish_ioend_buffered(ioend);
+		cond_resched();
+	}
+}
+
+static DECLARE_WORK(failed_ioend_work, iomap_fail_ioends);
+
+static void iomap_fail_ioend_buffered(struct iomap_ioend *ioend)
+{
+	unsigned long flags;
+
+	/*
+	 * Bounce I/O errors to a workqueue to avoid nested i_lock acquisitions
+	 * in the fserror code.  The caller no longer owns the ioend reference
+	 * after the spinlock drops.
+	 */
+	spin_lock_irqsave(&failed_ioend_lock, flags);
+	if (list_empty(&failed_ioend_list))
+		WARN_ON_ONCE(!schedule_work(&failed_ioend_work));
+	list_add_tail(&ioend->io_list, &failed_ioend_list);
+	spin_unlock_irqrestore(&failed_ioend_lock, flags);
+}
+
 static void ioend_writeback_end_bio(struct bio *bio)
 {
 	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
 
 	ioend->io_error = blk_status_to_errno(bio->bi_status);
+	if (ioend->io_error) {
+		iomap_fail_ioend_buffered(ioend);
+		return;
+	}
+
 	iomap_finish_ioend_buffered(ioend);
 }
 


