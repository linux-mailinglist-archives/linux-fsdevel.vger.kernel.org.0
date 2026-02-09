Return-Path: <linux-fsdevel+bounces-76710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLeSLUrxiWnyEgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 15:38:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B1511094E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 15:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D10593033E75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3583793DB;
	Mon,  9 Feb 2026 14:36:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120C37BE81
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647795; cv=none; b=bRcVCTg0qW5jmFWUTA498AEu5xQjQ30a4NJQsjrc+6+cFEKZ8SBYDlZvw0yrLK2Mk9TGhArNAClP5xBiHZmeCsnN8Cgeti03yVNP6pWftFC51jYOCmugiFOmmhkGyJjUAwnD3kiCUbWEqiG/Ju4ARdZW6b5CCOZf4n8Vct2K57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647795; c=relaxed/simple;
	bh=UZnLH0h3kaSf6wIOP8U/qcFKwknQrIn/FGYwyQGaehg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tITlc/G8noERiP08GaF+flzGh95aSGEZ1bqErw9msub+RYNH70LmWqLLMRFDeszw7CI+82NWAKVadeZFlCGhACXkJ3Z8ShLOpQCOKt9nEHJLeG5Ld96RwpwISd9qKscSI2oUAz3gV9QXb+wC3h89+8njgJvZ/Yq6XO/UMYr9T8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7cfd0f67288so7994606a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 06:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770647794; x=1771252594;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lzC3FE5Gg9ui+AagGYjOf20jX4g13SU5kAdfyvpY9U=;
        b=NE9J5PTsrlZRQWmRGD3wSEEYLQ1Qvi3nXAiLw8y+G1O++HIDQ2zCraQGpbkGiKFk3i
         d9UL+oQmOaPKit/x1FlQrZUG3YYitjipLSJFVMG4Un70btIay9Dj5zB71eI+EC0YvlVO
         OZqIZf47i+a77i7FtJS2f30PwbbvCqpza0WxOQoZkspiYKZHr79lp6m+vNQQuUbDO8mb
         P3enq8pE0tX9EbrWKUzp8GKyRUdxsn6TXfrVjiMZ7MTbqQlsWsF1j00jq5fJJR1c73/B
         fTlGRlvccdEP4JJx8NYMHFg9Q1Skdum5gYfNA/I+/HW6uMeEAEhrmAHFU5/M7DXt6Q1x
         p15g==
X-Forwarded-Encrypted: i=1; AJvYcCWy1xRKhge/sCn3G6r43ueNMqWo/nRsYEOMxkFDfyoX9dY1s5XtEmO0In2Gqr/YCvhgGbeeUoHmw0ATCjqH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lkxZsC8OqFOVHdk081j3DGjTUIwlfkcmCrfw9wv0FIvqXxGR
	3LQB3WtNciV2BFrozI74TLvbMbaErrQeR1c91Qiklez5h0xooP4wpw8msA5vLuU93uE4YafRnHW
	+N/Ngpn6DLV3HJseLhwuA4rFuRJ+9UtZuK4Awn4CBMP+FzOXfkqrOdLpMMnc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ae6:b0:663:888:73d1 with SMTP id
 006d021491bc7-66d0c854006mr4808343eaf.60.1770647794068; Mon, 09 Feb 2026
 06:36:34 -0800 (PST)
Date: Mon, 09 Feb 2026 06:36:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6989f0f2.a00a0220.34fa92.0047.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] possible deadlock in writeout_period
From: syzbot <syzbot+d38b792a5cbd941006fc@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8a8594efdc14f07a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76710-lists,linux-fsdevel=lfdr.de,d38b792a5cbd941006fc];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,storage.googleapis.com:url,appspotmail.com:email,googlegroups.com:email]
X-Rspamd-Queue-Id: 21B1511094E
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    59e4d31a0470 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14454b22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a8594efdc14f07a
dashboard link: https://syzkaller.appspot.com/bug?extid=d38b792a5cbd941006fc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/746a1d5c4188/disk-59e4d31a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2eefade79f10/vmlinux-59e4d31a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/140624ef24ed/Image-59e4d31a.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d38b792a5cbd941006fc@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor/6572 just changed the state of lock:
ffff800097626150 (&p->sequence){+.-.}-{0:0}, at: writeout_period+0x94/0x11c mm/page-writeback.c:615
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&xa->xa_lock#10){-.-.}-{3:3}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->sequence);
                               local_irq_disable();
                               lock(&xa->xa_lock#10);
                               lock(&p->sequence);
  <Interrupt>
    lock(&xa->xa_lock#10);

 *** DEADLOCK ***

1 lock held by syz-executor/6572:
 #0: ffff800097bd7c40 ((&dom->period_timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:41 [inline]
 #0: ffff800097bd7c40 ((&dom->period_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd4/0x814 kernel/time/timer.c:1738

the shortest dependencies between 2nd lock and 1st lock:
 -> (&xa->xa_lock#10){-.-.}-{3:3} {
    IN-HARDIRQ-W at:
                      lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
                      __folio_end_writeback+0x10c/0x6f8 mm/page-writeback.c:2990
                      folio_end_writeback_no_dropbehind+0xd0/0x204 mm/filemap.c:1661
                      folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
                      end_buffer_async_write+0x20c/0x350 fs/buffer.c:419
                      end_bio_bh_io_sync+0xb0/0x184 fs/buffer.c:2776
                      bio_endio+0x8d4/0x910 block/bio.c:1675
                      blk_complete_request block/blk-mq.c:908 [inline]
                      blk_mq_end_request_batch+0x49c/0x105c block/blk-mq.c:1202
                      nvme_complete_batch drivers/nvme/host/nvme.h:802 [inline]
                      nvme_pci_complete_batch drivers/nvme/host/pci.c:1348 [inline]
                      nvme_irq+0x1ec/0x240 drivers/nvme/host/pci.c:1450
                      __handle_irq_event_percpu+0x20c/0x8e4 kernel/irq/handle.c:211
                      handle_irq_event_percpu kernel/irq/handle.c:248 [inline]
                      handle_irq_event+0x9c/0x1d0 kernel/irq/handle.c:265
                      handle_fasteoi_irq+0x328/0x8d8 kernel/irq/chip.c:764
                      generic_handle_irq_desc include/linux/irqdesc.h:172 [inline]
                      handle_irq_desc kernel/irq/irqdesc.c:669 [inline]
                      generic_handle_domain_irq+0xe0/0x140 kernel/irq/irqdesc.c:725
                      __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
                      __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:876 [inline]
                      gic_handle_irq+0x6c/0x18c drivers/irqchip/irq-gic-v3.c:920
                      call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
                      do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:135
                      __el1_irq arch/arm64/kernel/entry-common.c:497 [inline]
                      el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:510
                      el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                      el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                      __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline]
                      arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
                      kasan_quarantine_put+0xbc/0x1c8 mm/kasan/quarantine.c:234
                      __kasan_slab_free+0x8c/0xa4 mm/kasan/common.c:295
                      kasan_slab_free include/linux/kasan.h:235 [inline]
                      slab_free_hook mm/slub.c:2540 [inline]
                      slab_free_after_rcu_debug+0x120/0x2f8 mm/slub.c:6729
                      rcu_do_batch kernel/rcu/tree.c:2605 [inline]
                      rcu_core+0x848/0x1774 kernel/rcu/tree.c:2857
                      rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2874
                      handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
                      run_ksoftirqd+0x70/0xc0 kernel/softirq.c:1063
                      smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
                      kthread+0x5fc/0x75c kernel/kthread.c:463
                      ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
    IN-SOFTIRQ-W at:
                      lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
                      __folio_end_writeback+0x10c/0x6f8 mm/page-writeback.c:2990
                      folio_end_writeback_no_dropbehind+0xd0/0x204 mm/filemap.c:1661
                      folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
                      end_buffer_async_write+0x20c/0x350 fs/buffer.c:419
                      end_bio_bh_io_sync+0xb0/0x184 fs/buffer.c:2776
                      bio_endio+0x8d4/0x910 block/bio.c:1675
                      blk_complete_request block/blk-mq.c:908 [inline]
                      blk_mq_end_request_batch+0x49c/0x105c block/blk-mq.c:1202
                      nvme_complete_batch drivers/nvme/host/nvme.h:802 [inline]
                      nvme_pci_complete_batch drivers/nvme/host/pci.c:1348 [inline]
                      nvme_irq+0x1ec/0x240 drivers/nvme/host/pci.c:1450
                      __handle_irq_event_percpu+0x20c/0x8e4 kernel/irq/handle.c:211
                      handle_irq_event_percpu kernel/irq/handle.c:248 [inline]
                      handle_irq_event+0x9c/0x1d0 kernel/irq/handle.c:265
                      handle_fasteoi_irq+0x328/0x8d8 kernel/irq/chip.c:764
                      generic_handle_irq_desc include/linux/irqdesc.h:172 [inline]
                      handle_irq_desc kernel/irq/irqdesc.c:669 [inline]
                      generic_handle_domain_irq+0xe0/0x140 kernel/irq/irqdesc.c:725
                      __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
                      __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:876 [inline]
                      gic_handle_irq+0x6c/0x18c drivers/irqchip/irq-gic-v3.c:920
                      call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
                      do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:135
                      __el1_irq arch/arm64/kernel/entry-common.c:497 [inline]
                      el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:510
                      el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                      el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                      __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline]
                      arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
                      kasan_quarantine_put+0xbc/0x1c8 mm/kasan/quarantine.c:234
                      __kasan_slab_free+0x8c/0xa4 mm/kasan/common.c:295
                      kasan_slab_free include/linux/kasan.h:235 [inline]
                      slab_free_hook mm/slub.c:2540 [inline]
                      slab_free_after_rcu_debug+0x120/0x2f8 mm/slub.c:6729
                      rcu_do_batch kernel/rcu/tree.c:2605 [inline]
                      rcu_core+0x848/0x1774 kernel/rcu/tree.c:2857
                      rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2874
                      handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
                      run_ksoftirqd+0x70/0xc0 kernel/softirq.c:1063
                      smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
                      kthread+0x5fc/0x75c kernel/kthread.c:463
                      ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
    INITIAL USE at:
                     lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                     __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                     _raw_spin_lock_irq+0x58/0x70 kernel/locking/spinlock.c:170
                     spin_lock_irq include/linux/spinlock.h:376 [inline]
                     shmem_add_to_page_cache+0x564/0xa24 mm/shmem.c:904
                     shmem_alloc_and_add_folio+0x758/0x10c4 mm/shmem.c:1958
                     shmem_get_folio_gfp+0x4d4/0x159c mm/shmem.c:2556
                     shmem_read_folio_gfp+0x8c/0xf0 mm/shmem.c:5970
                     drm_gem_get_pages+0x1cc/0x7c0 drivers/gpu/drm/drm_gem.c:654
                     drm_gem_shmem_get_pages_locked+0x1d4/0x364 drivers/gpu/drm/drm_gem_shmem_helper.c:240
                     drm_gem_shmem_pin_locked+0x1f8/0x410 drivers/gpu/drm/drm_gem_shmem_helper.c:301
                     drm_gem_shmem_vmap_locked+0x3cc/0x658 drivers/gpu/drm/drm_gem_shmem_helper.c:405
                     drm_gem_shmem_object_vmap+0x28/0x38 include/drm/drm_gem_shmem_helper.h:245
                     drm_gem_vmap_locked drivers/gpu/drm/drm_gem.c:1273 [inline]
                     drm_gem_vmap+0x104/0x1d8 drivers/gpu/drm/drm_gem.c:1315
                     drm_client_buffer_vmap+0x68/0xb0 drivers/gpu/drm/drm_client.c:355
                     drm_fbdev_shmem_driver_fbdev_probe+0x1f4/0x700 drivers/gpu/drm/drm_fbdev_shmem.c:159
                     drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb_helper.c:1562 [inline]
                     __drm_fb_helper_initial_config_and_unlock+0x108c/0x1728 drivers/gpu/drm/drm_fb_helper.c:1741
                     drm_fb_helper_initial_config+0x3c/0x58 drivers/gpu/drm/drm_fb_helper.c:1828
                     drm_fbdev_client_hotplug+0x154/0x22c drivers/gpu/drm/clients/drm_fbdev_client.c:66
                     drm_client_register+0x13c/0x1d4 drivers/gpu/drm/drm_client.c:143
                     drm_fbdev_client_setup+0x194/0x3d0 drivers/gpu/drm/clients/drm_fbdev_client.c:168
                     drm_client_setup+0x114/0x228 drivers/gpu/drm/clients/drm_client_setup.c:46
                     vkms_create+0x370/0x420 drivers/gpu/drm/vkms/vkms_drv.c:211
                     vkms_init+0x64/0x9c drivers/gpu/drm/vkms/vkms_drv.c:239
                     do_one_initcall+0x248/0x9b4 init/main.c:1378
                     do_initcall_level+0x128/0x1c4 init/main.c:1440
                     do_initcalls+0x70/0xd0 init/main.c:1456
                     do_basic_setup+0x78/0x8c init/main.c:1475
                     kernel_init_freeable+0x268/0x39c init/main.c:1688
                     kernel_init+0x24/0x1dc init/main.c:1578
                     ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
  }
  ... key      at: [<ffff80009764a620>] xa_init_flags.__key+0x0/0x20
  ... acquired at:
   seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
   fprop_fraction_percpu+0xf0/0x270 lib/flex_proportions.c:155
   __fprop_add_percpu_max+0x130/0x1f4 lib/flex_proportions.c:186
   wb_domain_writeout_add mm/page-writeback.c:562 [inline]
   __wb_writeout_add+0xbc/0x27c mm/page-writeback.c:586
   __folio_end_writeback+0x380/0x6f8 mm/page-writeback.c:2997
   folio_end_writeback_no_dropbehind+0xd0/0x204 mm/filemap.c:1661
   folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
   iomap_finish_folio_write+0x1c0/0x2a4 fs/iomap/buffered-io.c:1713
   fuse_writepage_finish fs/fuse/file.c:1903 [inline]
   fuse_writepage_end+0x238/0x454 fs/fuse/file.c:2003
   fuse_request_end+0x898/0xc10 fs/fuse/dev.c:507
   fuse_dev_end_requests fs/fuse/dev.c:2415 [inline]
   fuse_abort_conn+0xe88/0x10a0 fs/fuse/dev.c:2513
   fuse_dev_release+0x430/0x4c8 fs/fuse/dev.c:2556
   __fput+0x340/0x75c fs/file_table.c:468
   fput_close_sync+0x100/0x264 fs/file_table.c:573
   __do_sys_close fs/open.c:1573 [inline]
   __se_sys_close fs/open.c:1558 [inline]
   __arm64_sys_close+0x7c/0x118 fs/open.c:1558
   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
   invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
   el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
   el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
   el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
   el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

-> (&p->sequence){+.-.}-{0:0} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                    do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
                    do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
                    fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
                    writeout_period+0x94/0x11c mm/page-writeback.c:615
                    call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
                    expire_timers kernel/time/timer.c:1799 [inline]
                    __run_timers kernel/time/timer.c:2373 [inline]
                    __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
                    run_timer_base kernel/time/timer.c:2394 [inline]
                    run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
                    handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
                    __do_softirq+0x14/0x20 kernel/softirq.c:656
                    ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
                    call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
                    do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
                    invoke_softirq kernel/softirq.c:503 [inline]
                    __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
                    irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
                    __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
                    el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
                    el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                    el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                    __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline]
                    arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline]
                    preempt_schedule_irq+0x78/0x188 kernel/sched/core.c:7189
                    raw_irqentry_exit_cond_resched+0x30/0x44 kernel/entry/common.c:173
                    irqentry_exit+0x1b0/0x308 kernel/entry/common.c:216
                    exit_to_kernel_mode+0x10/0x1c arch/arm64/kernel/entry-common.c:58
                    __el1_irq arch/arm64/kernel/entry-common.c:500 [inline]
                    el1_interrupt+0x4c/0x60 arch/arm64/kernel/entry-common.c:510
                    el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                    el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                    __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline]
                    arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
                    class_irqsave_destructor include/linux/irqflags.h:266 [inline]
                    __free_object+0x514/0x720 lib/debugobjects.c:524
                    free_object lib/debugobjects.c:532 [inline]
                    debug_object_free+0x298/0x3e4 lib/debugobjects.c:976
                    destroy_hrtimer_on_stack kernel/time/hrtimer.c:448 [inline]
                    hrtimer_nanosleep+0x214/0x2a4 kernel/time/hrtimer.c:2178
                    common_nsleep+0xa0/0xb8 kernel/time/posix-timers.c:1352
                    __do_sys_clock_nanosleep kernel/time/posix-timers.c:1398 [inline]
                    __se_sys_clock_nanosleep kernel/time/posix-timers.c:1375 [inline]
                    __arm64_sys_clock_nanosleep+0x334/0x370 kernel/time/posix-timers.c:1375
                    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
                    invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
                    el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
                    do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
                    el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
                    el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
                    el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
   IN-SOFTIRQ-W at:
                    lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                    do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
                    do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
                    fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
                    writeout_period+0x94/0x11c mm/page-writeback.c:615
                    call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
                    expire_timers kernel/time/timer.c:1799 [inline]
                    __run_timers kernel/time/timer.c:2373 [inline]
                    __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
                    run_timer_base kernel/time/timer.c:2394 [inline]
                    run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
                    handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
                    __do_softirq+0x14/0x20 kernel/softirq.c:656
                    ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
                    call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
                    do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
                    invoke_softirq kernel/softirq.c:503 [inline]
                    __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
                    irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
                    __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
                    el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
                    el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                    el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                    __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline]
                    arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline]
                    preempt_schedule_irq+0x78/0x188 kernel/sched/core.c:7189
                    raw_irqentry_exit_cond_resched+0x30/0x44 kernel/entry/common.c:173
                    irqentry_exit+0x1b0/0x308 kernel/entry/common.c:216
                    exit_to_kernel_mode+0x10/0x1c arch/arm64/kernel/entry-common.c:58
                    __el1_irq arch/arm64/kernel/entry-common.c:500 [inline]
                    el1_interrupt+0x4c/0x60 arch/arm64/kernel/entry-common.c:510
                    el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                    el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                    __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline]
                    arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
                    class_irqsave_destructor include/linux/irqflags.h:266 [inline]
                    __free_object+0x514/0x720 lib/debugobjects.c:524
                    free_object lib/debugobjects.c:532 [inline]
                    debug_object_free+0x298/0x3e4 lib/debugobjects.c:976
                    destroy_hrtimer_on_stack kernel/time/hrtimer.c:448 [inline]
                    hrtimer_nanosleep+0x214/0x2a4 kernel/time/hrtimer.c:2178
                    common_nsleep+0xa0/0xb8 kernel/time/posix-timers.c:1352
                    __do_sys_clock_nanosleep kernel/time/posix-timers.c:1398 [inline]
                    __se_sys_clock_nanosleep kernel/time/posix-timers.c:1375 [inline]
                    __arm64_sys_clock_nanosleep+0x334/0x370 kernel/time/posix-timers.c:1375
                    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
                    invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
                    el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
                    do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
                    el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
                    el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
                    el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
   INITIAL READ USE at:
                        lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                        seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
                        fprop_fraction_percpu+0xac/0x270 lib/flex_proportions.c:155
                        __wb_calc_thresh+0xfc/0x3b0 mm/page-writeback.c:913
                        wb_bg_dirty_limits mm/page-writeback.c:2130 [inline]
                        domain_over_bg_thresh+0xb8/0x1f0 mm/page-writeback.c:2144
                        wb_over_bg_thresh+0xf8/0x17c mm/page-writeback.c:2165
                        wb_check_background_flush fs/fs-writeback.c:2278 [inline]
                        wb_do_writeback fs/fs-writeback.c:2376 [inline]
                        wb_workfn+0xa30/0xdc0 fs/fs-writeback.c:2403
                        process_one_work+0x7c0/0x1558 kernel/workqueue.c:3257
                        process_scheduled_works kernel/workqueue.c:3340 [inline]
                        worker_thread+0x958/0xed8 kernel/workqueue.c:3421
                        kthread+0x5fc/0x75c kernel/kthread.c:463
                        ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
 }
 ... key      at: [<ffff800097b9a340>] fprop_global_init.__key.1+0x0/0x20
 ... acquired at:
   mark_lock+0x170/0x1d0 kernel/locking/lockdep.c:4753
   mark_usage kernel/locking/lockdep.c:4662 [inline]
   __lock_acquire+0x9a0/0x30a4 kernel/locking/lockdep.c:5191
   lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
   do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
   do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
   fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
   writeout_period+0x94/0x11c mm/page-writeback.c:615
   call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
   expire_timers kernel/time/timer.c:1799 [inline]
   __run_timers kernel/time/timer.c:2373 [inline]
   __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
   run_timer_base kernel/time/timer.c:2394 [inline]
   run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
   handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
   __do_softirq+0x14/0x20 kernel/softirq.c:656
   ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
   call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
   do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
   invoke_softirq kernel/softirq.c:503 [inline]
   __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
   irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
   __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
   el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
   el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
   el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
   __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline]
   arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline]
   preempt_schedule_irq+0x78/0x188 kernel/sched/core.c:7189
   raw_irqentry_exit_cond_resched+0x30/0x44 kernel/entry/common.c:173
   irqentry_exit+0x1b0/0x308 kernel/entry/common.c:216
   exit_to_kernel_mode+0x10/0x1c arch/arm64/kernel/entry-common.c:58
   __el1_irq arch/arm64/kernel/entry-common.c:500 [inline]
   el1_interrupt+0x4c/0x60 arch/arm64/kernel/entry-common.c:510
   el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
   el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
   __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline]
   arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
   class_irqsave_destructor include/linux/irqflags.h:266 [inline]
   __free_object+0x514/0x720 lib/debugobjects.c:524
   free_object lib/debugobjects.c:532 [inline]
   debug_object_free+0x298/0x3e4 lib/debugobjects.c:976
   destroy_hrtimer_on_stack kernel/time/hrtimer.c:448 [inline]
   hrtimer_nanosleep+0x214/0x2a4 kernel/time/hrtimer.c:2178
   common_nsleep+0xa0/0xb8 kernel/time/posix-timers.c:1352
   __do_sys_clock_nanosleep kernel/time/posix-timers.c:1398 [inline]
   __se_sys_clock_nanosleep kernel/time/posix-timers.c:1375 [inline]
   __arm64_sys_clock_nanosleep+0x334/0x370 kernel/time/posix-timers.c:1375
   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
   invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
   el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
   el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
   el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
   el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596


stack backtrace:
CPU: 1 UID: 0 PID: 6572 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_irq_inversion_bug+0x1f8/0x1fc kernel/locking/lockdep.c:4125
 mark_lock_irq+0x3b4/0x47c kernel/locking/lockdep.c:-1
 mark_lock+0x170/0x1d0 kernel/locking/lockdep.c:4753
 mark_usage kernel/locking/lockdep.c:4662 [inline]
 __lock_acquire+0x9a0/0x30a4 kernel/locking/lockdep.c:5191
 lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
 do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
 do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
 fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
 writeout_period+0x94/0x11c mm/page-writeback.c:615
 call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
 handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
 invoke_softirq kernel/softirq.c:503 [inline]
 __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
 __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
 el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
 preempt_schedule_irq+0x78/0x188 kernel/sched/core.c:7189 (P)
 raw_irqentry_exit_cond_resched+0x30/0x44 kernel/entry/common.c:173
 irqentry_exit+0x1b0/0x308 kernel/entry/common.c:216
 exit_to_kernel_mode+0x10/0x1c arch/arm64/kernel/entry-common.c:58
 __el1_irq arch/arm64/kernel/entry-common.c:500 [inline]
 el1_interrupt+0x4c/0x60 arch/arm64/kernel/entry-common.c:510
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 class_irqsave_destructor include/linux/irqflags.h:266 [inline] (P)
 __free_object+0x514/0x720 lib/debugobjects.c:524 (P)
 free_object lib/debugobjects.c:532 [inline]
 debug_object_free+0x298/0x3e4 lib/debugobjects.c:976
 destroy_hrtimer_on_stack kernel/time/hrtimer.c:448 [inline]
 hrtimer_nanosleep+0x214/0x2a4 kernel/time/hrtimer.c:2178
 common_nsleep+0xa0/0xb8 kernel/time/posix-timers.c:1352
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1398 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1375 [inline]
 __arm64_sys_clock_nanosleep+0x334/0x370 kernel/time/posix-timers.c:1375
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

