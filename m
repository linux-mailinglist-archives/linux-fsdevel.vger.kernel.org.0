Return-Path: <linux-fsdevel+bounces-18771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3E98BC307
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC1E2817BC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F56BFCF;
	Sun,  5 May 2024 18:26:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1DF6BFC2
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714933591; cv=none; b=btYiUzuxTUpOWJALL7F7FwtXan05yE2zm+Diirdn8K5KOKtmAv8tTkvASt4v5sYwjNALoULfTLk3Ihkgz9jQcmffYAL7ARNAd04cEugYQw0iiK1wqfMCCSUpfHt/kQanqPY42Up2hJ0zawildTUXnFT3cbf6Rcg9qo1HVhgbut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714933591; c=relaxed/simple;
	bh=l/S4nQ1pIW2Ij8sC1Uo9tcK0oWrlQ//6XS9mT3J8X74=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IcMOA/eBhBs8iNVGyS3vsfSJtTOdTqCavLzGWkcOCDqM0gi32ZPGypVyaMQbsGoPkeJZhJjcKzRsyUsp49MgSHOmzjd+l2pca7BcuyA0UwbhxDtaaKIyvbRF+K1SWtVkeXgURctOy5Ab5Te3RLYzVKJd+mTZkOkStxxnx2QHgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7dec4e29827so151953339f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 11:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714933589; x=1715538389;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdYsccC/HNyua52hFYRvexwjK07J9vziqNok1+F3NAA=;
        b=DfQzjT5au0tSfExsrE6MsWxyTkFiz0JYQFeT0J68hBWNnUtpjuUDau510Wto5Kq4TQ
         d7p43BMHOUQHqfTGj0YQDWhNm3TBMAdPsuWBu8LknFk1YA6FL95I3KC8cmU6CP8TeonS
         G8BhbY/a8D/Y3i+/T8toT1O9gcdcFfhlc0gw5C0UDYiOtOEKNzh/INcyHuu39KyTDUyb
         nI4a0Vh4FkPVBgsMM4MZY30RN1O+tfrWXx0c+htLyeCboaQpdoiC/g44iHdj3HX9coR3
         yCS1zII9MVsAwauV50FfxA+9FRPo04qIP41Is+amIWiXrt9o99EFc4OySnnabUE1n1HF
         mdzg==
X-Forwarded-Encrypted: i=1; AJvYcCURUd1o1CmSvgZwM1q2CbcyjD3dtesy1WVtGnUqJrBXwYi3nf2KlrV28CPsz7SXsR8EWC5vVV/r798sLJRSdkUC1CllXLZNoeJ+yDrt5Q==
X-Gm-Message-State: AOJu0YzaQDvXAChoC7dGeUnaeK7b6vBlKu5Bvew+6F/s8BnpE14jYyNK
	rmAaFJlMlnOv3M18VaDpN/9HurGFF2ysG0Qc+B2vmGCq2IYirwysTvC9K6jXEtcQQzXepox+jv/
	vMXVhFMcMYehyS7nHoDmgyYQnfVA/kbTGUmra4c3CMQHuVA3zPEdf7GU=
X-Google-Smtp-Source: AGHT+IHh9ROchKz630HeGwxM3ewa1uUyKI9Cmjhs6ZKY2zoApC9TkquDqFWyaxwR7qsy4JY0h+HngpfvljVl154YMjZXzXfJAOnJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8419:b0:488:77ea:f191 with SMTP id
 iq25-20020a056638841900b0048877eaf191mr154849jab.2.1714933588861; Sun, 05 May
 2024 11:26:28 -0700 (PDT)
Date: Sun, 05 May 2024 11:26:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060adac0617b917ab@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_inode_unpack
From: syzbot <syzbot+c123a98c7445baffb168@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1553b31f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=c123a98c7445baffb168
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44fb709c4e9c/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d25971073eca/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a327aa91b63e/bzImage-7367539a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c123a98c7445baffb168@syzkaller.appspotmail.com

bcachefs (loop4): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in bch2_inode_unpack_v3 fs/bcachefs/inode.c:270 [inline]
BUG: KMSAN: uninit-value in bch2_inode_unpack+0xaf0/0x4c40 fs/bcachefs/inode.c:323
 bch2_inode_unpack_v3 fs/bcachefs/inode.c:270 [inline]
 bch2_inode_unpack+0xaf0/0x4c40 fs/bcachefs/inode.c:323
 bch2_inode_peek_nowarn+0x4ec/0x5a0 fs/bcachefs/inode.c:351
 bch2_inode_peek fs/bcachefs/inode.c:366 [inline]
 bch2_inode_find_by_inum_trans+0xb3/0x3d0 fs/bcachefs/inode.c:949
 bch2_inode_find_by_inum+0x17b/0x4f0 fs/bcachefs/inode.c:958
 bchfs_truncate+0x437/0x1420 fs/bcachefs/fs-io.c:421
 bch2_setattr+0x29f/0x2f0 fs/bcachefs/fs.c:882
 notify_change+0x1a07/0x1af0 fs/attr.c:497
 do_truncate+0x22a/0x2b0 fs/open.c:65
 handle_truncate fs/namei.c:3300 [inline]
 do_open fs/namei.c:3646 [inline]
 path_openat+0x50d9/0x5b00 fs/namei.c:3799
 do_filp_open+0x20e/0x590 fs/namei.c:3826
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1432
 x64_sys_call+0x3a64/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:511 [inline]
 bkey_reassemble fs/bcachefs/bkey.h:505 [inline]
 btree_key_cache_fill fs/bcachefs/btree_key_cache.c:454 [inline]
 bch2_btree_path_traverse_cached_slowpath+0x5f02/0x79f0 fs/bcachefs/btree_key_cache.c:530
 bch2_btree_path_traverse_cached+0xd1a/0x1140
 bch2_btree_path_traverse_one+0x737/0x5290 fs/bcachefs/btree_iter.c:1155
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:225 [inline]
 bch2_btree_iter_peek_slot+0x128c/0x3840 fs/bcachefs/btree_iter.c:2473
 __bch2_bkey_get_iter fs/bcachefs/btree_iter.h:549 [inline]
 bch2_bkey_get_iter fs/bcachefs/btree_iter.h:563 [inline]
 bch2_inode_peek_nowarn+0x208/0x5a0 fs/bcachefs/inode.c:340
 bch2_inode_peek fs/bcachefs/inode.c:366 [inline]
 bch2_inode_find_by_inum_trans+0xb3/0x3d0 fs/bcachefs/inode.c:949
 bch2_inode_find_by_inum+0x17b/0x4f0 fs/bcachefs/inode.c:958
 bchfs_truncate+0x437/0x1420 fs/bcachefs/fs-io.c:421
 bch2_setattr+0x29f/0x2f0 fs/bcachefs/fs.c:882
 notify_change+0x1a07/0x1af0 fs/attr.c:497
 do_truncate+0x22a/0x2b0 fs/open.c:65
 handle_truncate fs/namei.c:3300 [inline]
 do_open fs/namei.c:3646 [inline]
 path_openat+0x50d9/0x5b00 fs/namei.c:3799
 do_filp_open+0x20e/0x590 fs/namei.c:3826
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1432
 x64_sys_call+0x3a64/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0xc0/0x2d0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 btree_bounce_alloc fs/bcachefs/btree_io.c:118 [inline]
 bch2_btree_node_read_done+0x4e68/0x75e0 fs/bcachefs/btree_io.c:1185
 btree_node_read_work+0x8a5/0x1eb0 fs/bcachefs/btree_io.c:1324
 bch2_btree_node_read+0x3d42/0x4b50
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1748 [inline]
 bch2_btree_root_read+0xa6c/0x13d0 fs/bcachefs/btree_io.c:1772
 read_btree_roots+0x454/0xee0 fs/bcachefs/recovery.c:457
 bch2_fs_recovery+0x7adb/0x9310 fs/bcachefs/recovery.c:785
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1043
 bch2_fs_open+0x135f/0x1670 fs/bcachefs/super.c:2102
 bch2_mount+0x90d/0x1d90 fs/bcachefs/fs.c:1903
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 x64_sys_call+0x2bf4/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 9730 Comm: syz-executor.4 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
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

