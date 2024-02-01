Return-Path: <linux-fsdevel+bounces-9900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D7E845D16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33430286208
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C569163A82;
	Thu,  1 Feb 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U11+ZD4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358315F30B;
	Thu,  1 Feb 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804247; cv=none; b=TYIog0o04BvbeduiwX8gR0vPXPB54z2UnJH+6Fnb8BU5i8+0KW8kyi8U8iYslh2ct1Oef6UKZh9by9f6R0fYZFkvyIHpXjFyr39IzhTTYKKLCgkSar1oFSQ0xLOkN91oPGv6VzknVE5GZOIBVNXATaid3kIN/TPKvvR9yvAroAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804247; c=relaxed/simple;
	bh=FJgkQVpXkRvRQ621Ln/It3q7wwblzfQ0VFl9xWIWv+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZknqytN7CCzUC/zlsqZCuvgb46svNSvfVK7ZlPMZt8kYqZxFzHcTvegZs1VMizI3eiv2g8/DZ+5zRlDG+pAfr8Dm3/UACgnBcZ5AoaP5mQSzhHL0j9Wgj3A7//vgMH4zncSvUlM71Zf/pirl9QAC9Zrezfh0BQukjwOueAeYGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U11+ZD4e; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706804242; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cm/eFbz4XfijP54MPgdDLidFOy+ZhjrvAa2lZZXlN0A=;
	b=U11+ZD4eY4LjAE+Hz0qvQ3V42a71HltiQQVsOE8yC2u+PPFaxddfVHT1Ta6d4HYL/Ww1JdDqfbB0oHefFjGjV7sLor5Yf1g0hLKUDvvjbOFrZAdsE0zX0TcEVx2Jmn/xTdbzhSm+Q5p5BXLr6WXIAplZBL+tzOr7JaJfUkXJcr8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W.u9Fza_1706804239;
Received: from 192.168.68.52(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.u9Fza_1706804239)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 00:17:21 +0800
Message-ID: <ad9354d4-be00-4de4-aec8-ec9d56a9676c@linux.alibaba.com>
Date: Fri, 2 Feb 2024 00:17:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress
 (3)
To: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>,
 chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 xiang@kernel.org
References: <000000000000d1668406104ff51e@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000d1668406104ff51e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

On 2024/2/1 19:04, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13d26b1fe80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
> dashboard link: https://syzkaller.appspot.com/bug?extid=88ad8b0517a9d3bb9dc8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11377218180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111fd038180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/79d9f2f4b065/disk-9f8413c4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cbc68430d9c6/vmlinux-9f8413c4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9740ad9fc172/bzImage-9f8413c4.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/2f79f30d7608/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com
> 
> erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -42 in[46, 0] out[9000]
> =====================================================
> BUG: KMSAN: uninit-value in hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
>   hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
>   print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
>   z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:252 [inline]
>   z_erofs_lz4_decompress+0x257e/0x2a70 fs/erofs/decompressor.c:311
>   z_erofs_decompress_pcluster fs/erofs/zdata.c:1290 [inline]
>   z_erofs_decompress_queue+0x338c/0x6460 fs/erofs/zdata.c:1372
>   z_erofs_decompressqueue_work+0x57/0x70 fs/erofs/zdata.c:1387
>   process_one_work kernel/workqueue.c:2633 [inline]
>   process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2706
>   worker_thread+0xf45/0x1490 kernel/workqueue.c:2787
>   kthread+0x3ed/0x540 kernel/kthread.c:388
>   ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> 
> Uninit was created at:
>   __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
>   alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
>   alloc_pages mm/mempolicy.c:2204 [inline]
>   folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
>   filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
>   page_cache_ra_unbounded+0x2cc/0x960 mm/readahead.c:247
>   do_page_cache_ra mm/readahead.c:299 [inline]
>   page_cache_ra_order+0xfeb/0x10a0 mm/readahead.c:546
>   ondemand_readahead+0x132b/0x1710 mm/readahead.c:668
>   page_cache_sync_ra+0x724/0x760 mm/readahead.c:695
>   page_cache_sync_readahead include/linux/pagemap.h:1283 [inline]
>   filemap_get_pages+0x4c7/0x2c90 mm/filemap.c:2497
>   filemap_read+0x59e/0x14d0 mm/filemap.c:2593
>   generic_file_read_iter+0x136/0xad0 mm/filemap.c:2781
>   __kernel_read+0x3bb/0x9e0 fs/read_write.c:434
>   integrity_kernel_read+0x77/0x90 security/integrity/iint.c:221
>   ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
>   ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>   ima_calc_file_hash+0x1743/0x3cc0 security/integrity/ima/ima_crypto.c:573
>   ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
>   process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
>   ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>   do_open fs/namei.c:3624 [inline]
>   path_openat+0x4d05/0x5ac0 fs/namei.c:3779
>   do_filp_open+0x20d/0x590 fs/namei.c:3806
>   do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>   do_sys_open fs/open.c:1419 [inline]
>   __do_sys_open fs/open.c:1427 [inline]
>   __se_sys_open fs/open.c:1423 [inline]
>   __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> CPU: 0 PID: 4393 Comm: kworker/u5:1 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Workqueue: erofs_worker z_erofs_decompressqueue_work
> =====================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

