Return-Path: <linux-fsdevel+bounces-67472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88401C41779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 20:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5A34F8A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 19:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CDB3396E6;
	Fri,  7 Nov 2025 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ns+Bx5p1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ns+Bx5p1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07A335085
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544891; cv=none; b=IR7aTkbATcBD3ArYMT817uVnLxp8Rf/He875tkmKvnketwcPoktzNLiQD2UQjER+KoAKNzsQFvSGuIgw5aA7tNrRSBcBXsZ6gjABH3K6knXppxxJR6N5cCe5+GKaTOsAGXE4ns62cVcBM2L6ReHa4eIjWGI9oq/20sFRFSE9sIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544891; c=relaxed/simple;
	bh=JPgQ4PPNWInTyQN0H21nHGy+hxtj58xyh+XhTT6tekw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mexPgZCUSl42AepqBCZ3WPIVR+tjS/HyRx/tZ/cUY5lbUxuDlFvzbGRmvw9393K+NLVnZVJBPe4s81WyIduQnZ8jLa4p3X0eacLFubgYsn41EDvSb1RUKuM6BwFWdFqrCAFyF76HVgIFRtJunTPUE5Ux4X9uEw427URRoa6XwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ns+Bx5p1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ns+Bx5p1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id A75842059A;
	Fri,  7 Nov 2025 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762544887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCm57iJlWE7P7gu5yDATRJEwRxn6l7H+dz4ZPVl+5T0=;
	b=Ns+Bx5p1S3ltzua2qyVYYvSXO4mKVXFIYkODGFm82L8JeD5JU6ptminUPf3czh6W5o7mK/
	weNwYb4ojpor+Sa0a80penJlvzA3ry+r7yuC/JgDNbSK+L37ULIPkHlUvgI8bOTTJt1OrK
	78izb42rkoj5Zkqk6QnS+gNzy4HnJsU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762544887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCm57iJlWE7P7gu5yDATRJEwRxn6l7H+dz4ZPVl+5T0=;
	b=Ns+Bx5p1S3ltzua2qyVYYvSXO4mKVXFIYkODGFm82L8JeD5JU6ptminUPf3czh6W5o7mK/
	weNwYb4ojpor+Sa0a80penJlvzA3ry+r7yuC/JgDNbSK+L37ULIPkHlUvgI8bOTTJt1OrK
	78izb42rkoj5Zkqk6QnS+gNzy4HnJsU=
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	"amurray @ thegoodpenguin . co . uk" <amurray@thegoodpenguin.co.uk>,
	brauner@kernel.org,
	chao@kernel.org,
	djwong@kernel.org,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] printk_ringbuffer: Fix check of valid data size when blk_lpos overflows
Date: Fri,  7 Nov 2025 20:47:19 +0100
Message-ID: <20251107194720.1231457-2-pmladek@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107194720.1231457-1-pmladek@suse.com>
References: <20251107194720.1231457-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.79 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.933];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,thegoodpenguin.co.uk,kernel.org,lists.sourceforge.net,vger.kernel.org,googlegroups.com,suse.com];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -6.79

The commit 67e1b0052f6bb8 ("printk_ringbuffer: don't needlessly wrap
data blocks around") allows to use the last 4 bytes of the ring buffer.

But the check for the @data_size was not properly updated in get_data().
It fails when "blk_lpos->next" overflows to "0". In this case:

  + is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)
    returns "false" because it checks "blk_lpos->next - 1".

  + "blk_lpos->begin < blk_lpos->next" fails because "blk_lpos->next"
    is already 0.

  + is_blk_wrapped(data_ring, blk_lpos->begin + DATA_SIZE(data_ring),
    blk_lpos->next) returns "false" because "begin_lpos" is from
    the next wrap but "next_lpos - 1" is from the previous one.

As a result, get_data() triggers the WARN_ON_ONCE() for "Illegal
block description", for example:

[  216.317316][ T7652] loop0: detected capacity change from 0 to 16
** 1 printk messages dropped **
[  216.327750][ T7652] ------------[ cut here ]------------
[  216.327789][ T7652] WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840, CPU#1: syz.0.585/7652
[  216.327848][ T7652] Modules linked in:
[  216.327907][ T7652] CPU: 1 UID: 0 PID: 7652 Comm: syz.0.585 Not tainted syzkaller #0 PREEMPT(full)
[  216.327933][ T7652] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
[  216.327953][ T7652] RIP: 0010:get_data+0x48a/0x840
[  216.327986][ T7652] Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 a7 19 1f 00 90 <0f> 0b 90 eb 05 e8 9c 19 1f 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
[  216.328007][ T7652] RSP: 0018:ffffc900035170e0 EFLAGS: 00010293
[  216.328029][ T7652] RAX: ffffffff81a1eee9 RBX: 00003fffffffffff RCX: ffff888033255b80
[  216.328048][ T7652] RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
[  216.328063][ T7652] RBP: 0000000000000012 R08: 0000000000000e55 R09: 000000325e213cc7
[  216.328079][ T7652] R10: 000000325e213cc7 R11: 00001de4c2000037 R12: 0000000000000012
[  216.328095][ T7652] R13: 0000000000000000 R14: ffffc90003517228 R15: 1ffffffff1bca646
[  216.328111][ T7652] FS:  00007f44eb8da6c0(0000) GS:ffff888125fda000(0000) knlGS:0000000000000000
[  216.328131][ T7652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  216.328147][ T7652] CR2: 00007f44ea9722e0 CR3: 0000000066344000 CR4: 00000000003526f0
[  216.328168][ T7652] Call Trace:
[  216.328178][ T7652]  <TASK>
[  216.328199][ T7652]  _prb_read_valid+0x672/0xa90
[  216.328328][ T7652]  ? desc_read+0x1b8/0x3f0
[  216.328381][ T7652]  ? __pfx__prb_read_valid+0x10/0x10
[  216.328422][ T7652]  ? panic_on_this_cpu+0x32/0x40
[  216.328450][ T7652]  prb_read_valid+0x3c/0x60
[  216.328482][ T7652]  printk_get_next_message+0x15c/0x7b0
[  216.328526][ T7652]  ? __pfx_printk_get_next_message+0x10/0x10
[  216.328561][ T7652]  ? __lock_acquire+0xab9/0xd20
[  216.328595][ T7652]  ? console_flush_all+0x131/0xb10
[  216.328621][ T7652]  ? console_flush_all+0x478/0xb10
[  216.328648][ T7652]  console_flush_all+0x4cc/0xb10
[  216.328673][ T7652]  ? console_flush_all+0x131/0xb10
[  216.328704][ T7652]  ? __pfx_console_flush_all+0x10/0x10
[  216.328748][ T7652]  ? is_printk_cpu_sync_owner+0x32/0x40
[  216.328781][ T7652]  console_unlock+0xbb/0x190
[  216.328815][ T7652]  ? __pfx___down_trylock_console_sem+0x10/0x10
[  216.328853][ T7652]  ? __pfx_console_unlock+0x10/0x10
[  216.328899][ T7652]  vprintk_emit+0x4c5/0x590
[  216.328935][ T7652]  ? __pfx_vprintk_emit+0x10/0x10
[  216.328993][ T7652]  _printk+0xcf/0x120
[  216.329028][ T7652]  ? __pfx__printk+0x10/0x10
[  216.329051][ T7652]  ? kernfs_get+0x5a/0x90
[  216.329090][ T7652]  _erofs_printk+0x349/0x410
[  216.329130][ T7652]  ? __pfx__erofs_printk+0x10/0x10
[  216.329161][ T7652]  ? __raw_spin_lock_init+0x45/0x100
[  216.329186][ T7652]  ? __init_swait_queue_head+0xa9/0x150
[  216.329231][ T7652]  erofs_fc_fill_super+0x1591/0x1b20
[  216.329285][ T7652]  ? __pfx_erofs_fc_fill_super+0x10/0x10
[  216.329324][ T7652]  ? sb_set_blocksize+0x104/0x180
[  216.329356][ T7652]  ? setup_bdev_super+0x4c1/0x5b0
[  216.329385][ T7652]  get_tree_bdev_flags+0x40e/0x4d0
[  216.329410][ T7652]  ? __pfx_erofs_fc_fill_super+0x10/0x10
[  216.329444][ T7652]  ? __pfx_get_tree_bdev_flags+0x10/0x10
[  216.329483][ T7652]  vfs_get_tree+0x92/0x2b0
[  216.329512][ T7652]  do_new_mount+0x302/0xa10
[  216.329537][ T7652]  ? apparmor_capable+0x137/0x1b0
[  216.329576][ T7652]  ? __pfx_do_new_mount+0x10/0x10
[  216.329605][ T7652]  ? ns_capable+0x8a/0xf0
[  216.329637][ T7652]  ? kmem_cache_free+0x19b/0x690
[  216.329682][ T7652]  __se_sys_mount+0x313/0x410
[  216.329717][ T7652]  ? __pfx___se_sys_mount+0x10/0x10
[  216.329836][ T7652]  ? do_syscall_64+0xbe/0xfa0
[  216.329869][ T7652]  ? __x64_sys_mount+0x20/0xc0
[  216.329901][ T7652]  do_syscall_64+0xfa/0xfa0
[  216.329932][ T7652]  ? lockdep_hardirqs_on+0x9c/0x150
[  216.329964][ T7652]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  216.329988][ T7652]  ? clear_bhb_loop+0x60/0xb0
[  216.330017][ T7652]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  216.330040][ T7652] RIP: 0033:0x7f44ea99076a
[  216.330080][ T7652] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
[  216.330100][ T7652] RSP: 002b:00007f44eb8d9e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  216.330128][ T7652] RAX: ffffffffffffffda RBX: 00007f44eb8d9ef0 RCX: 00007f44ea99076a
[  216.330146][ T7652] RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f44eb8d9eb0
[  216.330164][ T7652] RBP: 0000200000000180 R08: 00007f44eb8d9ef0 R09: 0000000000000000
[  216.330181][ T7652] R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000001c0
[  216.330196][ T7652] R13: 00007f44eb8d9eb0 R14: 00000000000001a1 R15: 0000200000000080
[  216.330233][ T7652]  </TASK>

Solve the problem by moving and fixing the sanity check. The problematic
if-else-if-else code will just distinguish three basic scenarios:
"regular" vs. "wrapped" vs. "too many times wrapped" block.

The new sanity check is more precise. A valid "data_size" must be
lower than half of the data buffer size. Also it must not be zero at
this stage. It allows to catch problematic "data_size" even for wrapped
blocks.

Closes: https://lore.kernel.org/all/69096836.a70a0220.88fb8.0006.GAE@google.com/
Closes: https://lore.kernel.org/all/69078fb6.050a0220.29fc44.0029.GAE@google.com/
Fixes: 67e1b0052f6bb82 ("printk_ringbuffer: don't needlessly wrap data blocks around")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 839f504db6d3..3e6fd8d6fa9f 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1260,9 +1260,8 @@ static const char *get_data(struct prb_data_ring *data_ring,
 		return NULL;
 	}
 
-	/* Regular data block: @begin less than @next and in same wrap. */
-	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
-	    blk_lpos->begin < blk_lpos->next) {
+	/* Regular data block: @begin and @next in the same wrap. */
+	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)) {
 		db = to_block(data_ring, blk_lpos->begin);
 		*data_size = blk_lpos->next - blk_lpos->begin;
 
@@ -1279,6 +1278,10 @@ static const char *get_data(struct prb_data_ring *data_ring,
 		return NULL;
 	}
 
+	/* Sanity check. Data-less blocks were handled earlier. */
+	if (WARN_ON_ONCE(!data_check_size(data_ring, *data_size) || !*data_size))
+		return NULL;
+
 	/* A valid data block will always be aligned to the ID size. */
 	if (WARN_ON_ONCE(blk_lpos->begin != ALIGN(blk_lpos->begin, sizeof(db->id))) ||
 	    WARN_ON_ONCE(blk_lpos->next != ALIGN(blk_lpos->next, sizeof(db->id)))) {
-- 
2.51.1


