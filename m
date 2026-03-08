Return-Path: <linux-fsdevel+bounces-79719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cxyDNRJsrWl82wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 13:31:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F314230329
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 13:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5721C30087D4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D901454654;
	Sun,  8 Mar 2026 12:31:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DA28FC
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2026 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973068; cv=none; b=aoGVpgxlEnwIqW1gqi6RjPKm31k/weSwDVJrFYuZKBNqkWX1gX6WSbf5wJTFV4TqNQawwi1eRmJKlToz0U/0KGlV0FIE7SIp/Wd364C53EeifgetbujBvQgeSHfq1vd3pjJ1BYyoENp3+n9Q2AERZCFR4yhiePBh7pkiPP8rYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973068; c=relaxed/simple;
	bh=PNENyXzmoOuSqWD9nuOR+Gyb//rlOybeaA14aE+hzTg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ixtoUoslnYp6bAUYLqw1CLDFaK+Uow2EpvYZcgMjpUzfjxfH+2MGG1Z9BkeETJtinKZmi4KAMusUY0v0b7rtElUTO+r1mMUAKMKTWPzDi0E6tDUh+oQ48SSMymD22v1OZLVZnavK+oe4VLocjMZiIXspBxlkFJP2yr/prPakcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67bb368c757so1039764eaf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 05:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772973066; x=1773577866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eExMXBnXM4peFMhhjLeKZOOSaw7IwpgqnEj+UrfzQhQ=;
        b=oWCAbCuL+rUVhY9zDOLAglxpXFNFFtuzhGF3QFaEskaoURbblhzwOnc6/HHfP6fqhS
         cGce49dkyokuy0/Aw+Vp2iPUuPIxIFRSVgmQjPdCt6GwS3EqSYzdh10z/t4StXIxhWmk
         nT6if2kW/A0pYNbZX1f0XRrKwEERryvRXMpICZV0zOHYqLtQJiCBOEEO7WMdrZ3a9sQ6
         goyuMc6ez5GVqJaslqwMypyMkb/bUsQ6qLKGsmWZI7ecLoUWpOJz7dgpW2gQdVef8LnD
         yADJJR1ZExypZ0J84XRITvS3lmZ6emd47yuj7/um12nYPRfnNE1eZqTgx+6jvIa0dqJN
         GEAg==
X-Forwarded-Encrypted: i=1; AJvYcCUXwVz1c+Obp64f1ybATa3ZbR49+S892e6gtciBr/vLrsNUrPtlaUv5sb+pRzgEvPWM1Ois4HRuQnxB3Z+j@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4Jp8weoKOK+zf8HGCsaXrk3hh+gekY72cf9O0wnWw0+Mc/1b
	mksfTb95hjm/rWPmZ771grRIgqsJbPGf55zjx27m1EQLxYAEBqXIlE1lUqpYnEzlIfzikXf3iu1
	Zqt+tBkxYO4LuZDC4gteIdgl6CPVjer5OSqdlFoFfWZW8pGMxLANNvtD1AOU=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b05:b0:67a:4fe9:a4ba with SMTP id
 006d021491bc7-67b9bd49644mr4828247eaf.63.1772973066145; Sun, 08 Mar 2026
 05:31:06 -0700 (PDT)
Date: Sun, 08 Mar 2026 05:31:06 -0700
In-Reply-To: <aa1XX2ZXo-hc6LHG@arm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ad6c0a.a00a0220.b130.0000.GAE@google.com>
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
X-Rspamd-Queue-Id: 5F314230329
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79719-lists,linux-fsdevel=lfdr.de,cae7809e9dc1459e4e63];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,arm.com,kernel.org,linux.dev,oracle.com,google.com,lists.sourceforge.net,vger.kernel.org,kvack.org,suse.de,samsung.com,googlegroups.com,suse.cz,gmail.com];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.852];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __pcs_replace_full_main

BUG: memory leak
unreferenced object 0xffff888101d79200 (size 512):
  comm "kworker/u8:5", pid 182, jiffies 4294937433
  hex dump (first 32 bytes):
    e0 22 eb 30 81 88 ff ff b0 b7 ad 81 ff ff ff ff  .".0............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 3ee28017):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __do_kmalloc_node mm/slub.c:5262 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5275
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5725
    free_to_pcs mm/slub.c:5778 [inline]
    slab_free mm/slub.c:6173 [inline]
    kfree+0x352/0x390 mm/slub.c:6486
    call_usermodehelper_freeinfo kernel/umh.c:43 [inline]
    umh_complete kernel/umh.c:57 [inline]
    call_usermodehelper_exec_async+0x1c7/0x1f0 kernel/umh.c:119
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888101fa6c00 (size 512):
  comm "kworker/1:1", pid 41, jiffies 4294937441
  hex dump (first 32 bytes):
    b0 1e fc 11 81 88 ff ff b0 b7 ad 81 ff ff ff ff  ................
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc a295f059):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __do_kmalloc_node mm/slub.c:5262 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5275
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5725
    free_to_pcs mm/slub.c:5778 [inline]
    slab_free mm/slub.c:6173 [inline]
    kfree+0x352/0x390 mm/slub.c:6486
    vfree.part.0+0x1d5/0x4d0 mm/vmalloc.c:3485
    vfree mm/vmalloc.c:3456 [inline]
    delayed_vfree_work+0x5b/0x90 mm/vmalloc.c:3398
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888109d31a00 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937949
  hex dump (first 32 bytes):
    c0 fa 74 29 81 88 ff ff b0 b7 ad 81 ff ff ff ff  ..t)............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc e073aa0b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __do_kmalloc_node mm/slub.c:5262 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5275
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5725
    free_to_pcs mm/slub.c:5778 [inline]
    slab_free mm/slub.c:6173 [inline]
    kfree+0x352/0x390 mm/slub.c:6486
    vfree.part.0+0x1d5/0x4d0 mm/vmalloc.c:3485
    vfree mm/vmalloc.c:3456 [inline]
    delayed_vfree_work+0x5b/0x90 mm/vmalloc.c:3398
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888109d3d800 (size 512):
  comm "udevadm", pid 5179, jiffies 4294938390
  hex dump (first 32 bytes):
    88 43 58 27 81 88 ff ff b0 b7 ad 81 ff ff ff ff  .CX'............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 37e3920):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __do_kmalloc_node mm/slub.c:5262 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5275
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2834 [inline]
    __pcs_replace_empty_main+0x1d2/0x260 mm/slub.c:4629
    alloc_from_pcs mm/slub.c:4720 [inline]
    slab_alloc_node mm/slub.c:4854 [inline]
    __kmalloc_cache_noprof+0x3ac/0x480 mm/slub.c:5378
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    kernfs_get_open_node fs/kernfs/file.c:543 [inline]
    kernfs_fop_open+0x4f3/0x580 fs/kernfs/file.c:718
    do_dentry_open+0x202/0x8d0 fs/open.c:949
    vfs_open+0x3d/0x1b0 fs/open.c:1081
    do_open fs/namei.c:4671 [inline]
    path_openat+0x154d/0x1e20 fs/namei.c:4830
    do_file_open+0x121/0x200 fs/namei.c:4859
    do_sys_openat2+0xa5/0x140 fs/open.c:1366
    do_sys_open fs/open.c:1372 [inline]
    __do_sys_openat fs/open.c:1388 [inline]
    __se_sys_openat fs/open.c:1383 [inline]
    __x64_sys_openat+0x82/0xf0 fs/open.c:1383
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810b5a5000 (size 512):
  comm "udevd", pid 5178, jiffies 4294938454
  hex dump (first 32 bytes):
    80 c5 8e 2b 81 88 ff ff b0 b7 ad 81 ff ff ff ff  ...+............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc bce89c59):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __do_kmalloc_node mm/slub.c:5262 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5275
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2834 [inline]
    __pcs_replace_empty_main+0x1d2/0x260 mm/slub.c:4629
    alloc_from_pcs mm/slub.c:4720 [inline]
    slab_alloc_node mm/slub.c:4854 [inline]
    __kmalloc_cache_noprof+0x3ac/0x480 mm/slub.c:5378
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    kernfs_get_open_node fs/kernfs/file.c:543 [inline]
    kernfs_fop_open+0x4f3/0x580 fs/kernfs/file.c:718
    do_dentry_open+0x202/0x8d0 fs/open.c:949
    vfs_open+0x3d/0x1b0 fs/open.c:1081
    do_open fs/namei.c:4671 [inline]
    path_openat+0x154d/0x1e20 fs/namei.c:4830
    do_file_open+0x121/0x200 fs/namei.c:4859
    do_sys_openat2+0xa5/0x140 fs/open.c:1366
    do_sys_open fs/open.c:1372 [inline]
    __do_sys_openat fs/open.c:1388 [inline]
    __se_sys_openat fs/open.c:1383 [inline]
    __x64_sys_openat+0x82/0xf0 fs/open.c:1383
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888109d3ce00 (size 512):
  comm "udevd", pid 5189, jiffies 4294938454
  hex dump (first 32 bytes):
    b0 4e 89 2b 81 88 ff ff b0 b7 ad 81 ff ff ff ff  .N.+............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc e7e352bb):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __do_kmalloc_node mm/slub.c:5262 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5275
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2834 [inline]
    __pcs_replace_empty_main+0x1d2/0x260 mm/slub.c:4629
    alloc_from_pcs mm/slub.c:4720 [inline]
    slab_alloc_node mm/slub.c:4854 [inline]
    __do_kmalloc_node mm/slub.c:5262 [inline]
    __kmalloc_noprof+0x4c5/0x560 mm/slub.c:5275
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    tomoyo_encode2+0xd0/0x1e0 security/tomoyo/realpath.c:45
    tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
    tomoyo_realpath_from_path+0xc4/0x2c0 security/tomoyo/realpath.c:283
    tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
    tomoyo_path_perm+0x12c/0x290 security/tomoyo/file.c:827
    security_inode_getattr+0xaa/0x200 security/security.c:1869
    vfs_getattr fs/stat.c:259 [inline]
    vfs_fstat+0x48/0xe0 fs/stat.c:281
    __do_sys_newfstat+0x42/0xa0 fs/stat.c:551
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         c23719ab Merge tag 'x86-urgent-2026-03-08' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1228e75a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1310e75a580000


