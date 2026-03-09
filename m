Return-Path: <linux-fsdevel+bounces-79761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CrGEtWqrmntHQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 12:11:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D12237A7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 12:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F241C301AE58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE9396D3A;
	Mon,  9 Mar 2026 11:11:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB60396B9C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054666; cv=none; b=hLi+UMvtMEIAaN9Tsgse1uqrcXCTWueO/TnCxeB4AseoQdHHARREDrvUwrLIvbSZona/UnldCFtIC5rFHeK0MtucpK2bkSekp6quj5cuL4OQ716TYm3GoXz7/FFtNmmFAYOKdovML9cRTzciSCPoFptWby+skG3SI1fAs+jIcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054666; c=relaxed/simple;
	bh=0LCjdvoOHBHiSX4LxIsqUBDb5yBlZUJa0trLXCm/ewE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bx3t2oov0vuhSAKIZykvy8DOnhAyJB8CjF9eqjHsKKFF27mqlJZFC1m2xOlyoPh4X1Ryapihsf8KOqCp1hWgbATKXQzY/UxZo/z6wpSNmiWDlAkY5dY+QtlMrFbJE9M/2O4ySj9Yex4zJEBEYLYj9tzgBaFbm6CsbM3FZ9Yo/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d742bb4003so5081673a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 04:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054663; x=1773659463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z05biv7HDDyvWTAZybrg4/Tgqu8avyuVtSPLUJRGL/Q=;
        b=s+KiRFgxKhHKcH7UNOzZV0HbMY4zT2TZH/q3JLET4pv6qvqa50Lw8l37fL9lgpWNa0
         pS1AARCo5DTxJDzhq9IQZSD5WG7qy3J/xeqsVtAmKhV3GykkOmlqvNsThK0IR6uwQJBd
         lMG/4MQUo+vntlF+AWdrisTxTejPe0s9cAjmxS30O/5nVGhWPRTubQIMjjLDe2ORNCYY
         g00wsIScNH5AvOusK0/dt+TRcxlYdg99fPbupo9D3Ejs9sNHFebmkLzBsV/B0EJRqCBv
         Ray0uXKRpVV/f++On8j/k9rhiwX68oEuU7h6J98eOe3ZhRz4qtgD4QYHvyL2T39nOCAU
         sRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoFIpHRMt2PTUKZwZrzsAAfMHWK5gOXLayxz0jKq1TVFG1tzWxMCit2KMxjuvQH/1D0HR87RdG3A/HJjLb@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNF1OwxXFFlEZWcuSn2FMWdcRBzK9ZTXL0sHu8taJ45DCSGAD
	Gipzu4VZF7L0Y+4QgcaqqJ6Jn6Jdc9wpIHxkdDO7N0ejdDze8juyn7G+gswME23NSy7Bf7yTYWZ
	N4VH2HLALpxtMqspxZe8ro/WzUlmU07HmAe7LRIsuYX6RlEMbQ59A/8lcPJY=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3105:b0:679:92c7:2bfa with SMTP id
 006d021491bc7-67b9bd0fc42mr6325438eaf.45.1773054663271; Mon, 09 Mar 2026
 04:11:03 -0700 (PDT)
Date: Mon, 09 Mar 2026 04:11:03 -0700
In-Reply-To: <aa6lBQDAVnqjz_lk@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69aeaac7.a70a0220.52840.0014.GAE@google.com>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, catalin.marinas@arm.com, chao@kernel.org, 
	hao.li@linux.dev, harry.yoo@oracle.com, jaegeuk@kernel.org, jannh@google.com, 
	liam.howlett@oracle.com, linkinjeon@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	vbabka@kernel.org, vbabka@suse.cz, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E0D12237A7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79761-lists,linux-fsdevel=lfdr.de,cae7809e9dc1459e4e63];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,arm.com,kernel.org,linux.dev,oracle.com,google.com,lists.sourceforge.net,vger.kernel.org,kvack.org,suse.de,samsung.com,googlegroups.com,suse.cz,gmail.com];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.852];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __pcs_replace_empty_main

BUG: memory leak
unreferenced object 0xffff8881008bb900 (size 256):
  comm "swapper/0", pid 0, jiffies 4294937326
  hex dump (first 32 bytes):
    00 e8 54 0b 81 88 ff ff 00 55 bf 0f 81 88 ff ff  ..T......U......
    00 e1 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc e804819c):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2834 [inline]
    __pcs_replace_empty_main+0x1d2/0x260 mm/slub.c:4634
    alloc_from_pcs mm/slub.c:4725 [inline]
    slab_alloc_node mm/slub.c:4859 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x4c5/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __register_sysctl_table+0x4e/0xa60 fs/proc/proc_sysctl.c:1379
    register_sysctl_sz fs/proc/proc_sysctl.c:1436 [inline]
    __register_sysctl_init+0x30/0x70 fs/proc/proc_sysctl.c:1465
    pagecache_init+0x4e/0x70 mm/filemap.c:1095
    start_kernel+0xb33/0xb80 init/main.c:1193
    x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
    x86_64_start_kernel+0xce/0xd0 arch/x86/kernel/head64.c:291
    common_startup_64+0x13e/0x148

BUG: memory leak
unreferenced object 0xffff888104417400 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937905
  hex dump (first 32 bytes):
    00 42 a4 1c 81 88 ff ff 00 06 05 00 81 88 ff ff  .B..............
    00 16 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc db9a578f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5730
    free_to_pcs mm/slub.c:5783 [inline]
    slab_free mm/slub.c:6185 [inline]
    kfree+0x352/0x390 mm/slub.c:6498
    vfree.part.0+0x1cd/0x4d0 mm/vmalloc.c:3484
    vfree mm/vmalloc.c:3456 [inline]
    delayed_vfree_work+0x5b/0x90 mm/vmalloc.c:3398
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810ad9d600 (size 512):
  comm "syz-executor", pid 5829, jiffies 4294941807
  hex dump (first 32 bytes):
    00 72 0a 00 81 88 ff ff 00 d2 04 00 81 88 ff ff  .r..............
    00 af 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 57ea7b83):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2834 [inline]
    __pcs_replace_empty_main+0x1d2/0x260 mm/slub.c:4634
    alloc_from_pcs mm/slub.c:4725 [inline]
    slab_alloc_node mm/slub.c:4859 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kvmalloc_node_noprof+0x5a7/0x770 mm/slub.c:6767
    allocate_hook_entries_size net/netfilter/core.c:58 [inline]
    nf_hook_entries_grow+0x178/0x3e0 net/netfilter/core.c:137
    __nf_register_net_hook+0xc4/0x2e0 net/netfilter/core.c:432
    nf_register_net_hook+0x8a/0x110 net/netfilter/core.c:575
    nf_register_net_hooks+0x5d/0xd0 net/netfilter/core.c:591
    ipt_register_table+0x15e/0x220 net/ipv4/netfilter/ip_tables.c:1781
    iptable_security_table_init+0x40/0x60 net/ipv4/netfilter/iptable_security.c:46
    xt_find_table_lock+0x1a3/0x270 net/netfilter/x_tables.c:1260
    xt_request_find_table_lock+0x28/0xb0 net/netfilter/x_tables.c:1285
    get_info+0x101/0x460 net/ipv4/netfilter/ip_tables.c:963
    do_ipt_get_ctl+0x9b/0x5e0 net/ipv4/netfilter/ip_tables.c:1659
    nf_getsockopt+0x61/0xa0 net/netfilter/nf_sockopt.c:116
    ip_getsockopt+0x10a/0x150 net/ipv4/ip_sockglue.c:1777

BUG: memory leak
unreferenced object 0xffff88810fbf5500 (size 256):
  comm "kworker/u8:0", pid 12, jiffies 4294942140
  hex dump (first 32 bytes):
    00 b9 8b 00 81 88 ff ff 00 72 02 01 81 88 ff ff  .........r......
    00 e1 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 88397b4):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5730
    free_to_pcs mm/slub.c:5783 [inline]
    slab_free mm/slub.c:6185 [inline]
    kfree+0x352/0x390 mm/slub.c:6498
    netif_free_tx_queues net/core/dev.c:11206 [inline]
    free_netdev+0x71/0x380 net/core/dev.c:12183
    netdev_run_todo+0x5ec/0x770 net/core/dev.c:11726
    ops_exit_rtnl_list net/core/net_namespace.c:189 [inline]
    ops_undo_list+0x2bd/0x300 net/core/net_namespace.c:248
    cleanup_net+0x287/0x570 net/core/net_namespace.c:704
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810b540200 (size 512):
  comm "kworker/u8:2", pid 34, jiffies 4294942151
  hex dump (first 32 bytes):
    00 8a 51 27 81 88 ff ff 00 2e 7a 2e 81 88 ff ff  ..Q'......z.....
    00 18 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8700e7f7):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5730
    free_to_pcs mm/slub.c:5783 [inline]
    slab_free mm/slub.c:6185 [inline]
    kfree+0x352/0x390 mm/slub.c:6498
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888127522c00 (size 512):
  comm "kworker/u8:7", pid 1176, jiffies 4294942410
  hex dump (first 32 bytes):
    00 7a 54 0b 81 88 ff ff 00 e6 b9 0f 81 88 ff ff  .zT.............
    00 18 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc c4b7e6cc):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5730
    free_to_pcs mm/slub.c:5783 [inline]
    slab_free mm/slub.c:6185 [inline]
    kfree+0x352/0x390 mm/slub.c:6498
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         1f318b96 Linux 7.0-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117b875a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b8375a580000


