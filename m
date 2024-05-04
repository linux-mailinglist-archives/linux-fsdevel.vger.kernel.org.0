Return-Path: <linux-fsdevel+bounces-18712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84878BB9E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 09:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD88B21B9D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A313ACC;
	Sat,  4 May 2024 07:58:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3B101D4
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714809509; cv=none; b=gIeXj/Z7jB6xE6i7Xfh2mVvPaqTWgvN+/7xxoEuo9z0EAL8sl70nfrPDHk/EhpfdGmPwjQSzd24m6J4AlpVOj77iMQ1LG57cw+SEungn/N2INirP7TOa0xFav5cnYCI3ZgLU/zxtEVfWL91evEh4mfFGRGG5xeaIMQOQtdZYiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714809509; c=relaxed/simple;
	bh=v0LckRLJCLiur/uhpA1uWvTOvmBkqghkuV1G/cLqbYk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X9OfmGTMQWmZXEX+3nHIhszH01wMLBKm0+dacRuJzLSDMUKpoM55pZlg5lMPZ4hhXzxrH+cAZgFmmXz/N4XzVtUkhr2MLmwP8wyYDMt+sDQSqbkQUVL4cni9Aiu7dblTBvvTmWId/HxENlLdPoT9nA3dN7IKFQcBAS/N5W4mTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da4360bbacso48291139f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 00:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714809507; x=1715414307;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ws0qQ7R8pFUGop3gD0bCH+kqYozjp/S0RlrQQzNV8Bc=;
        b=Ykdh5FKjByRl1T1R2p4HB8TjmwSIeCR8m4p7Ca6ehgTnVz9jA7MJzIbktTCeyc/Lfd
         IZuE7DiLQ4JmsTurp7cg/TFIyyTr1j9NdwWbOhlsIK31P8xlHugZ9L4aBWdNUmWDTxM2
         CxP6GKzi96EV6A+klXWEyH1twQzdOD161PG20wEZswGJheZxI1t9D3BEC/aZwsrDS9vi
         jfpyXj7TXGRSjhXO3YqIHzUDKIs8a8xC7HcA1tp/NPxVQIhwxSbSiPsKeuDwNAl9C02D
         CNLL3VKnFw/fePuBPAnOeHvANVt41xekQQYYAI7ecQMgxS3AacQh+p6GSpd1CNoDfqyl
         48Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWCs3kwCNF4QrUX5bFzjOaslyRdAnKtgpiWJeGAZHYqob4jncPOohs64LnczFWOmeBsrCw75nNGy3xnlMpUO6peFjixMta4e3w2Ap0o/w==
X-Gm-Message-State: AOJu0YyLKwRZdmoWoOocEXO6akZSHOi/e7OcJ3UPlt32kRaG3/Sjqct/
	obgklTwG6KHazbKdqPLy5IUnoTWxu9JTHKusNkSDgs90tdvUvZXK5pU8XI0CgdXj1ZEDLeWf4ds
	1B4axwgtbYPp2dYIcBK93oGnA8Se2fqj8PlpwLU6UMegIy4PcwE9YIZY=
X-Google-Smtp-Source: AGHT+IEYg8J2GUKXNfvCRk9sHvPlUpMwVqElyM4IoTpZg4vUepdiXvrYai5z16l98I6HAguIRsU98uTP63uj9k1Slhn1iAkyCrFn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c13:b0:7de:a1dc:bf36 with SMTP id
 ik19-20020a0566026c1300b007dea1dcbf36mr145723iob.4.1714809507237; Sat, 04 May
 2024 00:58:27 -0700 (PDT)
Date: Sat, 04 May 2024 00:58:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000895ef206179c33e3@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in __bch2_write_index
From: syzbot <syzbot+fd3ccb331eb21f05d13b@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1206a590980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=fd3ccb331eb21f05d13b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c64084cbf7db/disk-3d25a941.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8250d04a440c/vmlinux-3d25a941.xz
kernel image: https://storage.googleapis.com/syzbot-assets/244d4cfb55f3/bzImage-3d25a941.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd3ccb331eb21f05d13b@syzkaller.appspotmail.com

bcachefs (loop2): snapshots_read... done
bcachefs (loop2): journal_replay... done
bcachefs (loop2): resume_logged_ops... done
bcachefs (loop2): going read-write
bcachefs (loop2): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in find_next_bit include/linux/find.h:64 [inline]
BUG: KMSAN: uninit-value in __bch2_write_index+0x277b/0x2bd0 fs/bcachefs/io_write.c:543
 find_next_bit include/linux/find.h:64 [inline]
 __bch2_write_index+0x277b/0x2bd0 fs/bcachefs/io_write.c:543
 bch2_write_data_inline fs/bcachefs/io_write.c:1538 [inline]
 bch2_write+0x1a13/0x1b40 fs/bcachefs/io_write.c:1606
 closure_queue include/linux/closure.h:257 [inline]
 closure_call include/linux/closure.h:390 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:468 [inline]
 bch2_writepages+0x24a/0x3c0 fs/bcachefs/fs-io-buffered.c:660
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_write_and_wait_range+0x169/0x420 mm/filemap.c:685
 bchfs_truncate+0xa58/0x1420
 bch2_setattr+0x29f/0x2f0 fs/bcachefs/fs.c:882
 notify_change+0x1a07/0x1af0 fs/attr.c:497
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x107/0x250 fs/open.c:134
 __do_compat_sys_truncate fs/open.c:152 [inline]
 __se_compat_sys_truncate fs/open.c:150 [inline]
 __ia32_compat_sys_truncate+0x6c/0xa0 fs/open.c:150
 ia32_sys_call+0x24d4/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:93
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
 mempool_alloc_slab+0x36/0x50 mm/mempool.c:565
 mempool_init_node+0x202/0x4d0 mm/mempool.c:217
 mempool_init+0x57/0x70 mm/mempool.c:246
 mempool_init_slab_pool include/linux/mempool.h:68 [inline]
 bioset_init+0x271/0xac0 block/bio.c:1752
 bch2_fs_fs_io_buffered_init+0x4a/0xc0 fs/bcachefs/fs-io-buffered.c:1156
 bch2_fs_alloc+0x3c71/0x4210 fs/bcachefs/super.c:937
 bch2_fs_open+0xdde/0x1670 fs/bcachefs/super.c:2081
 bch2_mount+0x90d/0x1d90 fs/bcachefs/fs.c:1903
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3875
 ia32_sys_call+0x3a9a/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:22
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 PID: 17163 Comm: syz-executor.2 Not tainted 6.9.0-rc6-syzkaller-00227-g3d25a941ea50 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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

