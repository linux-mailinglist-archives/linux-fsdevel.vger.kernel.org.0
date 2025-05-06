Return-Path: <linux-fsdevel+bounces-48291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701C6AACE23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703901C2415E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058F51F3FF8;
	Tue,  6 May 2025 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lERTZh/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D31C4A10;
	Tue,  6 May 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560073; cv=none; b=bggdSzqBnZgkzEZnY5avDOvjQq+d07YgcKD4pGY6K+AUbnmULmQE0f3e4t4h+mLzrwrF8TWnnBg+OsIlKKcX5OrTnEWF96jghfFviJvglkF3z/gZiWb2FUUZ1OBh91i6BfW2p89Axz+lPE9dWq5ja5sfI7q6xwW/xrTBPQcrPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560073; c=relaxed/simple;
	bh=CmdWlfic3PP4kSQKqHKzllGPnGD1s7RqoLI1rPpqmv0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KGQQ4w6Pg893bR0yfCczEiP/gGjj6etzcaDXmxUNueN+e+YhjUKWepgXHufgs0x/eHpaIIhDFJ2ZqY+uFndHs0WArEsBRrcRrHkDqN7EkmLniL5XEPrdGKATjbH+qh7gFQ1aQ4+Kw2lVRiM8DyzfCGYsD6ctTrTIfO5AeuNAijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lERTZh/0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso59702861fa.3;
        Tue, 06 May 2025 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560069; x=1747164869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LBugIdQbV0RCYxuq1ERIB/AjLAqA1GWLEAYeXLim2Yo=;
        b=lERTZh/0fQ7T1HeDLNj5Ly8VI2gIsy9Nea/k0etHOUEHG+bkpgC9yLLxTAIqA7MQk4
         OTivi419zKphRfM9XvJEhLerW8qpU6UL4Z1wmuox0AaTbtFlSO/icbM7swQlxBmilsDF
         sW78AbukNnIsxC/Gs3SChLDDkwHkpWrpiprI2vkeax2fLIuLU3olC1wFth//JNputJla
         VA8ABtwAmCXopiPyeLx538Kik04twvF/iBqXowJ+t3EF8456QaSB/A1hl5dO+6mWgMGL
         aG19QamLr+59Vq9+emuIZJpcw0U91L3sl6hbEDbOsQ0X1fYlGFbJrS9WamOXGf/JfOfL
         jvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560069; x=1747164869;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBugIdQbV0RCYxuq1ERIB/AjLAqA1GWLEAYeXLim2Yo=;
        b=pdxyHl/LXCVbB0fL+1VK+porWaUaEmLy17cl+HO4/mUN6JASKm6LRfEfH6Vb5rLMEi
         9/lWgXqioSjUogKf6nJR0CqnhY99+43rHD5XCzJow98eTEhyrMRWcCel8La5zdshyfOt
         lGbHY0t26wYeZLVkz/C/g9yitGcHvJ83SCLPYt647YbZTfXSqvC5fzqnhc1LNCNGZR8M
         zazeTH+tD5X+bVvEn0Pnuec2nleA/Gb9EiAHMvU1hd5ixInjy3fprHmX20NttZ7sTMAN
         FXSJOYY9BTEZSCgpxMKgpFqp0c0L6N/QTqLK2d/ofZMEnrvHb6o5fKNFVXWHJ8KwACL/
         5law==
X-Forwarded-Encrypted: i=1; AJvYcCUpqy+oA7Epj27qi8nP03jd+QZERhajNu6K8wasx9a8SSO1RaY3huyIWHXqaya1vUCczfojkFe019OY@vger.kernel.org, AJvYcCUzsTzSEv3flahavhE7GEVLc5PrG6jKA5s22NFwQqoyLLAdkxbdg/L3o681QaXSQvmHgt2/rw7SEv8or1jkDA==@vger.kernel.org, AJvYcCWG4szjfEQ1Ua50dHKUdZ+YmFZ1eE22PxQoygtFou5oDhLXFWXyD99Llhei0+Im95Rppyie7zarfqFAFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5HR72MHqh873c/7HROYuLq47qUaE/yRoorCB+gLGGBZj9waLm
	RiP6r/Tlawl4ZGVgh5fGRElR13gcTwqrjj7gjt1Mbaxm5l+jeGid7FkNuH7IEWSzrrb3F8JhB1c
	xKK87IATBgETir0lXFdzh000RSznmu+5f
X-Gm-Gg: ASbGncvbHgJLuRd5fYJjChFDDnm+rby0DjTtI3z+xUnYQ0nHbBTwqVaOU824Clcf2t5
	A2/hzz4urbdU0pLstesB7HxaE8MmCkuOf2jSscHQIvaSFHHXEYbP1bFlQJQihTIlWTv0EEMHak4
	9JM/0PAmmc6JcyQeHE53YWU9d1h0QQzlQPvT0eyp6wDhI9dRJvcX4IzZU=
X-Google-Smtp-Source: AGHT+IHldZYDf9QLcRbH0e5/tttAqbQH5tDJvvraJEK0Jq135rRbfi1nNXCqXuA+nUycTxn20/WTH/OKBn7zN3YKSrk=
X-Received: by 2002:a05:651c:150e:b0:30b:f2d6:8aab with SMTP id
 38308e7fff4ca-326ad2ffa4amr1151731fa.32.1746560069006; Tue, 06 May 2025
 12:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 6 May 2025 14:34:16 -0500
X-Gm-Features: ATxdqUF94DCX8GVfH16VhkK28uIdhJdzi5245F5dCTmO129qc0kriXVlp_1JPsA
Message-ID: <CAH2r5muWLPLO2soz3dNVjn7qRv2o28fdKNyjXCYFDGz9Jms1Mw@mail.gmail.com>
Subject: xfstest failure in generic/349 starting with 6.15-rc1 due to scsi
 circular locking
To: Hannes Reinecke <hare@suse.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	SCSI development list <linux-scsi@vger.kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"

Since 6.15-rc1 I have been seeing this xfstest failure running
generic/349, but looks like a local I/O issue (scsi or xfs).  I still
see it with 6.15-rc5  (see e.g.
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/builds/465/steps/205/logs/stdio)

[Tue May 6 09:45:35 2025] run fstests generic/349 at 2025-05-06 09:45:35
[Tue May 6 09:45:36 2025] scsi_debug:sdebug_add_store: 8192 provisioning blocks
[Tue May 6 09:45:36 2025] scsi_debug:sdebug_driver_probe: scsi_debug:
trim poll_queues to 0. poll_q/nr_hw = (0/1)
[Tue May 6 09:45:36 2025] scsi host0: scsi_debug: version 0191 [20210520]
dev_size_mb=4, opts=0x0, submit_queues=1, statistics=0
[Tue May 6 09:45:36 2025] scsi 0:0:0:0: Direct-Access Linux scsi_debug
0191 PQ: 0 ANSI: 7
[Tue May 6 09:45:36 2025] scsi 0:0:0:0: Power-on or device reset occurred
[Tue May 6 09:45:36 2025] sd 0:0:0:0: [sda] 8192 512-byte logical
blocks: (4.19 MB/4.00 MiB)
[Tue May 6 09:45:36 2025] sd 0:0:0:0: Attached scsi generic sg0 type 0
[Tue May 6 09:45:36 2025] sd 0:0:0:0: [sda] Write Protect is off
[Tue May 6 09:45:36 2025] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[Tue May 6 09:45:36 2025] sd 0:0:0:0: [sda] Write cache: enabled, read
cache: enabled, supports DPO and FUA
[Tue May 6 09:45:36 2025] sd 0:0:0:0: [sda] permanent stream count = 5
[Tue May 6 09:45:36 2025] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[Tue May 6 09:45:36 2025] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
[Tue May 6 09:45:36 2025] sd 0:0:0:0: [sda] Attached SCSI disk
[Tue May 6 09:45:36 2025] ======================================================
[Tue May 6 09:45:36 2025] WARNING: possible circular locking dependency detected
[Tue May 6 09:45:36 2025] 6.15.0-rc5 #1 Tainted: G E
[Tue May 6 09:45:36 2025] ------------------------------------------------------
[Tue May 6 09:45:36 2025] (udev-worker)/424019 is trying to acquire lock:
[Tue May 6 09:45:36 2025] ff1100012e44c058
(&q->elevator_lock){+.+.}-{4:4}, at: elv_iosched_store+0x13b/0x370
[Tue May 6 09:45:36 2025]
but task is already holding lock:
[Tue May 6 09:45:36 2025] ff1100012e44bb28
(&q->q_usage_counter(io)#13){++++}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0x12/0x20
[Tue May 6 09:45:36 2025]
which lock already depends on the new lock.
[Tue May 6 09:45:36 2025]
the existing dependency chain (in reverse order) is:
[Tue May 6 09:45:36 2025]
-> #2 (&q->q_usage_counter(io)#13){++++}-{0:0}:
[Tue May 6 09:45:36 2025] blk_alloc_queue+0x3f4/0x440
[Tue May 6 09:45:36 2025] blk_mq_alloc_queue+0xd6/0x160
[Tue May 6 09:45:36 2025] scsi_alloc_sdev+0x4c0/0x660
[Tue May 6 09:45:36 2025] scsi_probe_and_add_lun+0x2f4/0x690
[Tue May 6 09:45:36 2025] __scsi_scan_target+0x13c/0x2b0
[Tue May 6 09:45:36 2025] scsi_scan_channel+0x92/0xe0
[Tue May 6 09:45:36 2025] scsi_scan_host_selected+0x13a/0x1b0
[Tue May 6 09:45:36 2025] do_scan_async+0x2b/0x260
[Tue May 6 09:45:36 2025] async_run_entry_fn+0x66/0x230
[Tue May 6 09:45:36 2025] process_one_work+0x4bf/0xb40
[Tue May 6 09:45:36 2025] worker_thread+0x2c9/0x550
[Tue May 6 09:45:36 2025] kthread+0x216/0x3e0
[Tue May 6 09:45:36 2025] ret_from_fork+0x34/0x60
[Tue May 6 09:45:36 2025] ret_from_fork_asm+0x1a/0x30
[Tue May 6 09:45:36 2025]
-> #1 (fs_reclaim){+.+.}-{0:0}:
[Tue May 6 09:45:36 2025] fs_reclaim_acquire+0xb9/0xf0
[Tue May 6 09:45:36 2025] kmem_cache_alloc_noprof+0x3b/0x3f0
[Tue May 6 09:45:36 2025] __kernfs_new_node+0xae/0x410
[Tue May 6 09:45:36 2025] kernfs_new_node+0x9a/0x100
[Tue May 6 09:45:36 2025] kernfs_create_dir_ns+0x2b/0xd0
[Tue May 6 09:45:36 2025] sysfs_create_dir_ns+0xcc/0x160
[Tue May 6 09:45:36 2025] kobject_add_internal+0x153/0x3f0
[Tue May 6 09:45:36 2025] kobject_add+0xdd/0x160
[Tue May 6 09:45:36 2025] elv_register_queue+0x6c/0x130
[Tue May 6 09:45:36 2025] blk_register_queue+0x25d/0x2f0
[Tue May 6 09:45:36 2025] add_disk_fwnode+0x4a7/0x860
[Tue May 6 09:45:36 2025] virtblk_probe+0x900/0x1320 [virtio_blk]
[Tue May 6 09:45:36 2025] virtio_dev_probe+0x2d9/0x400
[Tue May 6 09:45:36 2025] really_probe+0x148/0x4e0
[Tue May 6 09:45:36 2025] __driver_probe_device+0xc7/0x1e0
[Tue May 6 09:45:36 2025] driver_probe_device+0x49/0xf0
[Tue May 6 09:45:36 2025] __driver_attach+0x139/0x290
[Tue May 6 09:45:36 2025] bus_for_each_dev+0xc7/0x110
[Tue May 6 09:45:36 2025] bus_add_driver+0x19e/0x320
[Tue May 6 09:45:36 2025] driver_register+0xa5/0x1d0
[Tue May 6 09:45:36 2025] __connect+0x57/0xf0 [irqbypass]
[Tue May 6 09:45:36 2025] do_one_initcall+0xc3/0x410
[Tue May 6 09:45:36 2025] do_init_module+0x13a/0x3d0
[Tue May 6 09:45:36 2025] load_module+0x3833/0x3990
[Tue May 6 09:45:36 2025] init_module_from_file+0xd9/0x130
[Tue May 6 09:45:36 2025] idempotent_init_module+0x242/0x390
[Tue May 6 09:45:36 2025] __x64_sys_finit_module+0x90/0x100
[Tue May 6 09:45:36 2025] do_syscall_64+0x75/0x180
[Tue May 6 09:45:36 2025] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[Tue May 6 09:45:36 2025]
-> #0 (&q->elevator_lock){+.+.}-{4:4}:
[Tue May 6 09:45:36 2025] __lock_acquire+0x1444/0x21f0
[Tue May 6 09:45:36 2025] lock_acquire+0x143/0x2d0
[Tue May 6 09:45:36 2025] __mutex_lock+0x12c/0xe40
[Tue May 6 09:45:36 2025] elv_iosched_store+0x13b/0x370
[Tue May 6 09:45:36 2025] queue_attr_store+0x17a/0x1a0
[Tue May 6 09:45:36 2025] kernfs_fop_write_iter+0x1f7/0x2c0
[Tue May 6 09:45:36 2025] vfs_write+0x5c6/0x7b0
[Tue May 6 09:45:36 2025] ksys_write+0xba/0x140
[Tue May 6 09:45:36 2025] do_syscall_64+0x75/0x180
[Tue May 6 09:45:36 2025] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[Tue May 6 09:45:36 2025]
other info that might help us debug this:
[Tue May 6 09:45:36 2025] Chain exists of:
&q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#13
[Tue May 6 09:45:36 2025] Possible unsafe locking scenario:
[Tue May 6 09:45:36 2025] CPU0 CPU1
[Tue May 6 09:45:36 2025] ---- ----
[Tue May 6 09:45:36 2025] lock(&q->q_usage_counter(io)#13);
[Tue May 6 09:45:36 2025] lock(fs_reclaim);
[Tue May 6 09:45:36 2025] lock(&q->q_usage_counter(io)#13);
[Tue May 6 09:45:36 2025] lock(&q->elevator_lock);
[Tue May 6 09:45:36 2025]
*** DEADLOCK ***
[Tue May 6 09:45:36 2025] 5 locks held by (udev-worker)/424019:
[Tue May 6 09:45:36 2025] #0: ff11000113f04420
(sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xba/0x140
[Tue May 6 09:45:36 2025] #1: ff1100011cefc088
(&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x166/0x2c0
[Tue May 6 09:45:36 2025] #2: ff1100011027e698
(kn->active#112){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x176/0x2c0
[Tue May 6 09:45:36 2025] #3: ff1100012e44bb28
(&q->q_usage_counter(io)#13){++++}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0x12/0x20
[Tue May 6 09:45:36 2025] #4: ff1100012e44bb60
(&q->q_usage_counter(queue)#2){++++}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0x12/0x20
[Tue May 6 09:45:36 2025]
stack backtrace:
[Tue May 6 09:45:36 2025] CPU: 7 UID: 0 PID: 424019 Comm:
(udev-worker) Tainted: G E 6.15.0-rc5 #1 PREEMPT(voluntary)
[Tue May 6 09:45:36 2025] Tainted: [E]=UNSIGNED_MODULE
[Tue May 6 09:45:36 2025] Hardware name: Red Hat KVM, BIOS
1.16.3-2.el9_5.1 04/01/2014
[Tue May 6 09:45:36 2025] Call Trace:
[Tue May 6 09:45:36 2025] <TASK>
[Tue May 6 09:45:36 2025] dump_stack_lvl+0x79/0xb0
[Tue May 6 09:45:36 2025] print_circular_bug+0x274/0x340
[Tue May 6 09:45:36 2025] check_noncircular+0x10a/0x120
[Tue May 6 09:45:36 2025] __lock_acquire+0x1444/0x21f0
[Tue May 6 09:45:36 2025] ? finish_task_switch.isra.0+0x19f/0x500
[Tue May 6 09:45:36 2025] lock_acquire+0x143/0x2d0
[Tue May 6 09:45:36 2025] ? elv_iosched_store+0x13b/0x370
[Tue May 6 09:45:36 2025] __mutex_lock+0x12c/0xe40
[Tue May 6 09:45:36 2025] ? elv_iosched_store+0x13b/0x370
[Tue May 6 09:45:36 2025] ? elv_iosched_store+0x13b/0x370
[Tue May 6 09:45:36 2025] ? mark_held_locks+0x49/0x80
[Tue May 6 09:45:36 2025] ? __pfx___mutex_lock+0x10/0x10
[Tue May 6 09:45:36 2025] ? finish_wait+0xef/0x110
[Tue May 6 09:45:36 2025] ? _raw_spin_unlock_irqrestore+0x31/0x60
[Tue May 6 09:45:36 2025] ? blk_mq_freeze_queue_wait+0xef/0x100
[Tue May 6 09:45:36 2025] ? __pfx_blk_mq_freeze_queue_wait+0x10/0x10
[Tue May 6 09:45:36 2025] ? __pfx_autoremove_wake_function+0x10/0x10
[Tue May 6 09:45:36 2025] ? elv_iosched_store+0x13b/0x370
[Tue May 6 09:45:36 2025] elv_iosched_store+0x13b/0x370
[Tue May 6 09:45:36 2025] ? __pfx_elv_iosched_store+0x10/0x10
[Tue May 6 09:45:36 2025] ? kernfs_fop_write_iter+0x166/0x2c0
[Tue May 6 09:45:36 2025] queue_attr_store+0x17a/0x1a0
[Tue May 6 09:45:36 2025] ? __pfx_queue_attr_store+0x10/0x10
[Tue May 6 09:45:36 2025] ? lock_acquire+0x143/0x2d0
[Tue May 6 09:45:36 2025] ? sysfs_file_kobj+0x1f/0x170
[Tue May 6 09:45:36 2025] ? find_held_lock+0x2b/0x80
[Tue May 6 09:45:36 2025] ? sysfs_file_kobj+0x85/0x170
[Tue May 6 09:45:36 2025] ? lock_release+0xc4/0x270
[Tue May 6 09:45:36 2025] ? __rcu_read_unlock+0x6f/0x2a0
[Tue May 6 09:45:36 2025] ? sysfs_file_kobj+0x8f/0x170
[Tue May 6 09:45:36 2025] ? __pfx_sysfs_kf_write+0x10/0x10
[Tue May 6 09:45:36 2025] kernfs_fop_write_iter+0x1f7/0x2c0
[Tue May 6 09:45:36 2025] ? __pfx_kernfs_fop_write_iter+0x10/0x10
[Tue May 6 09:45:36 2025] vfs_write+0x5c6/0x7b0
[Tue May 6 09:45:36 2025] ? __pfx_vfs_write+0x10/0x10
[Tue May 6 09:45:36 2025] ? populate_seccomp_data+0x181/0x220
[Tue May 6 09:45:36 2025] ? __seccomp_filter+0xdc/0x780
[Tue May 6 09:45:36 2025] ? __pfx___seccomp_filter+0x10/0x10
[Tue May 6 09:45:36 2025] ksys_write+0xba/0x140
[Tue May 6 09:45:36 2025] ? __pfx_ksys_write+0x10/0x10
[Tue May 6 09:45:36 2025] do_syscall_64+0x75/0x180
[Tue May 6 09:45:36 2025] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[Tue May 6 09:45:36 2025] RIP: 0033:0x7f1b5f898984
[Tue May 6 09:45:36 2025] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66
2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8
01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48
83 ec 20 48 89
[Tue May 6 09:45:36 2025] RSP: 002b:00007fffa5dc7608 EFLAGS: 00000202
ORIG_RAX: 0000000000000001
[Tue May 6 09:45:36 2025] RAX: ffffffffffffffda RBX: 0000000000000003
RCX: 00007f1b5f898984
[Tue May 6 09:45:36 2025] RDX: 0000000000000003 RSI: 00007fffa5dc7910
RDI: 0000000000000014
[Tue May 6 09:45:36 2025] RBP: 00007fffa5dc7630 R08: 00007f1b5f970248
R09: 00007fffa5dc76d0
[Tue May 6 09:45:36 2025] R10: 0000000000000000 R11: 0000000000000202
R12: 0000000000000003
[Tue May 6 09:45:36 2025] R13: 00007fffa5dc7910 R14: 000055f230c53990
R15: 00007f1b5f96ff00
[Tue May 6 09:45:36 2025] </TASK>
[Tue May 6 09:45:37 2025] sd 0:0:0:0: [sda] Synchronizing SCSI cache
program finished with exit code 1
elapsedTime=4.386769

-- 
Thanks,

Steve

