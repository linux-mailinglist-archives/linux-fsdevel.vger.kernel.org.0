Return-Path: <linux-fsdevel+bounces-36471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B347F9E3D04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB4F1638F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4120A5ED;
	Wed,  4 Dec 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0U3yzt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E020A5D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323406; cv=none; b=DI+aj7YLAi3sC2aS/KA7k9veL2s2EaF3jcS+SdgT1NKAJ1ZemvFMLKfvQuslhYDWLehXKdB3Gg7GE1SiAieogjARaqzD4nx0+Pp/tmdunbF9qZOs7gtgO2aZyfswfgvJRgSMQv+zv/DRf6Z8/sJySq+H0V7zfbdtF4f7vGbX2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323406; c=relaxed/simple;
	bh=kvFdArL1ZY74UgL0StTd3arSWzQkhQzPAtiY5apGJKg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ajphMMGxmsAfrYKZmB95O14st1+XEzxyn1opM1lTTPngo2df0TzzRWh/4y2+DDWBI468Q5MHrDLgz3E9//IcdDhHE8VDwP4Bb6ebGqaeJiO54WzS1LagNQsiVJcrQKaykNzlWP+ZUWCGtKJisz4hHj8jRxRAcnG8cCfe8mm0Zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0U3yzt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733323403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zS0GUTcXAW8C5l6NDquyV5IGiwNX/D1m1BEkvfj9tDg=;
	b=L0U3yzt/YJDkB+aS2qUrglgg53uEm+SQRt7ADaODQEAyg3EggsBxL2AuPFfFg2mgQ9ccQ2
	cm555irM/yCKSBmIEH74dJjS7S6yNubuUBVX1A03THUbGGulL9uaPMQMhOLajbAE4xf9UC
	v/MDjNcIVP3NuUn8l9ItWUwWHkgzL4g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-eKNXhUbnNBiYHoyN_JsVJg-1; Wed,
 04 Dec 2024 09:43:22 -0500
X-MC-Unique: eKNXhUbnNBiYHoyN_JsVJg-1
X-Mimecast-MFC-AGG-ID: eKNXhUbnNBiYHoyN_JsVJg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F1311955DA4;
	Wed,  4 Dec 2024 14:43:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59466195609D;
	Wed,  4 Dec 2024 14:43:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <67506987.050a0220.17bd51.006f.GAE@google.com>
References: <67506987.050a0220.17bd51.006f.GAE@google.com>
To: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1203229.1733323398.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Dec 2024 14:43:18 +0000
Message-ID: <1203250.1733323398@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This looks like it's probably a separate bug.

David

syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com> wrote:

> syzbot has tested the proposed patch but the reproducer is still trigger=
ing an issue:
> possible deadlock in __submit_bio
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.13.0-rc1-syzkaller-dirty #0 Not tainted
> ------------------------------------------------------
> kswapd0/75 is trying to acquire lock:
> ffff888034c41438 (&q->q_usage_counter(io)#37){++++}-{0:0}, at: __submit_=
bio+0x2c6/0x560 block/blk-core.c:629
> =

> but task is already holding lock:
> ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c=
:6864 [inline]
> ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 mm/vm=
scan.c:7246
> =

> which lock already depends on the new lock.
> =

> =

> the existing dependency chain (in reverse order) is:
> =

> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
>        fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        slab_pre_alloc_hook mm/slub.c:4055 [inline]
>        slab_alloc_node mm/slub.c:4133 [inline]
>        __do_kmalloc_node mm/slub.c:4282 [inline]
>        __kmalloc_node_noprof+0xb2/0x4d0 mm/slub.c:4289
>        __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
>        sbitmap_init_node+0x2d4/0x670 lib/sbitmap.c:132
>        scsi_realloc_sdev_budget_map+0x2a7/0x460 drivers/scsi/scsi_scan.c=
:246
>        scsi_add_lun drivers/scsi/scsi_scan.c:1106 [inline]
>        scsi_probe_and_add_lun+0x3173/0x4bd0 drivers/scsi/scsi_scan.c:128=
7
>        __scsi_add_device+0x228/0x2f0 drivers/scsi/scsi_scan.c:1622
>        ata_scsi_scan_host+0x236/0x740 drivers/ata/libata-scsi.c:4575
>        async_run_entry_fn+0xa8/0x420 kernel/async.c:129
>        process_one_work kernel/workqueue.c:3229 [inline]
>        process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
>        worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>        kthread+0x2f0/0x390 kernel/kthread.c:389
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> =

> -> #0 (&q->q_usage_counter(io)#37){++++}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        bio_queue_enter block/blk.h:75 [inline]
>        blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
>        __submit_bio+0x2c6/0x560 block/blk-core.c:629
>        __submit_bio_noacct_mq block/blk-core.c:710 [inline]
>        submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
>        swap_writepage_bdev_async mm/page_io.c:451 [inline]
>        __swap_writepage+0x5fc/0x1400 mm/page_io.c:474
>        swap_writepage+0x8f4/0x1170 mm/page_io.c:289
>        pageout mm/vmscan.c:689 [inline]
>        shrink_folio_list+0x3c0e/0x8cb0 mm/vmscan.c:1367
>        evict_folios+0x5568/0x7be0 mm/vmscan.c:4593
>        try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
>        shrink_one+0x3b9/0x850 mm/vmscan.c:4834
>        shrink_many mm/vmscan.c:4897 [inline]
>        lru_gen_shrink_node mm/vmscan.c:4975 [inline]
>        shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
>        kswapd_shrink_node mm/vmscan.c:6785 [inline]
>        balance_pgdat mm/vmscan.c:6977 [inline]
>        kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
>        kthread+0x2f0/0x390 kernel/kthread.c:389
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> =

> other info that might help us debug this:
> =

>  Possible unsafe locking scenario:
> =

>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(&q->q_usage_counter(io)#37);
>                                lock(fs_reclaim);
>   rlock(&q->q_usage_counter(io)#37);
> =

>  *** DEADLOCK ***
> =

> 1 lock held by kswapd0/75:
>  #0: ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vms=
can.c:6864 [inline]
>  #0: ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 =
mm/vmscan.c:7246
> =

> stack backtrace:
> CPU: 0 UID: 0 PID: 75 Comm: kswapd0 Not tainted 6.13.0-rc1-syzkaller-dir=
ty #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1=
.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
>  check_prev_add kernel/locking/lockdep.c:3161 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>  bio_queue_enter block/blk.h:75 [inline]
>  blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
>  __submit_bio+0x2c6/0x560 block/blk-core.c:629
>  __submit_bio_noacct_mq block/blk-core.c:710 [inline]
>  submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
>  swap_writepage_bdev_async mm/page_io.c:451 [inline]
>  __swap_writepage+0x5fc/0x1400 mm/page_io.c:474
>  swap_writepage+0x8f4/0x1170 mm/page_io.c:289
>  pageout mm/vmscan.c:689 [inline]
>  shrink_folio_list+0x3c0e/0x8cb0 mm/vmscan.c:1367
>  evict_folios+0x5568/0x7be0 mm/vmscan.c:4593
>  try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
>  shrink_one+0x3b9/0x850 mm/vmscan.c:4834
>  shrink_many mm/vmscan.c:4897 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4975 [inline]
>  shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
>  kswapd_shrink_node mm/vmscan.c:6785 [inline]
>  balance_pgdat mm/vmscan.c:6977 [inline]
>  kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>


