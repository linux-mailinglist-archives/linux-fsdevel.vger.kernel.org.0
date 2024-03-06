Return-Path: <linux-fsdevel+bounces-13757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B22873712
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B7028107D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A80012C81D;
	Wed,  6 Mar 2024 12:56:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864383CBA
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729780; cv=none; b=kzmkllW8ferLmz92XHX4GrwfRD10T3fxk6SQzD43sx7Dbzdg0JlHGCjY4yQpcc9nhwx+jcTD1LimecUPKdHw5QsmSifT7DvqQ44A/KUK7sptuWdZX8kQJEG0oyPcnJFS/ejz3uFGdI7VwogbYH0wC9uwFw8gk/O3PnItEVjAPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729780; c=relaxed/simple;
	bh=iV+b2WCFfpAq36zmD0vXtSrw1Y2hWxPvV+XWX+9BGuw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qnN8W2meN4Gxe3XrMgdekIikFiG0UHNaprd7gxRGC9vS7viDIpPzQWBTv+al9mI+DZnFtUT29rMl31So4bvvmFW4+ZMhlvcBhpdlm32zIRzgH5dRXTezOjvx9Yp8c8vPVn/iltO+wQIPstil2JHHcHOpPTohgbk4qiLhg+fEEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8440b33b6so106674239f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 04:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729778; x=1710334578;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWMpILfk7U93cwoBQiReCwBHB6q77sTx0PV/rHUpa68=;
        b=AsrYZNQl/8fKu0pc2QqO43e0UPzpoBzy4g3AlkZ1DKtIecYu7FPN2orhio2fxm6+rY
         JJUVlgBk/Mam6fPFlaiMGhBmCiw3l+7snJUUIUOiPluTifPV85IJ4eNS1dBfKQY7CBpX
         w5pUxDXS8aqhdklqwsT5UJ8OGlvX8xv714dsn5McI8+iqSsy0qZbE4SHp2V3X8w2ZWUW
         qPsP+bpibyzD/q7eFphXPebVhAB/xhuhPu+HRIBcMpmn5jgNKo3qq0v5v9tVy83oHgXM
         giVGGyRr1xOUb+3W54bldyfIhlfX15+ZieRpmkMACK7LdhqciuPi1sdtoMFqAlmGvl8s
         pS3Q==
X-Gm-Message-State: AOJu0YwDhP3xju5+KX/xwLEyLNF6SHirV4Cikj327VTAc8rb48cIBIaN
	rx5JsetOLkPtJBwx0XkSkhkwq9N3KBBnBJFb0lLngP4yIjAJJIPcXx9vaCvQz6VPF11st4jNRUR
	D3a0AJKQiBPS1huWoSRFKdwxzVW55w7HA3xg2RIuE3t38T1Sf2I9dNTFIGw==
X-Google-Smtp-Source: AGHT+IH5+gVM7kgcXEzIZVhyrS8wtXgOYU/LtAfD3ZRdexn7TasWyN1Vc5KxzLwlLvg+wM6eeDgoQyRjekWXaaUkIv3Fwu+CkB0r
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c9:b0:474:f25a:6fb with SMTP id
 l9-20020a05663814c900b00474f25a06fbmr539563jak.3.1709729778517; Wed, 06 Mar
 2024 04:56:18 -0800 (PST)
Date: Wed, 06 Mar 2024 04:56:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c59010612fd7c60@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_strcasecmp
From: syzbot <syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5ad3cb0ed525 Merge tag 'for-v6.8-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1687d706180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=e126b819d8187b282d44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b865f2727884/disk-5ad3cb0e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1c7b0d47f5c/vmlinux-5ad3cb0e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21afab19a0ed/bzImage-5ad3cb0e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in case_fold fs/hfsplus/unicode.c:23 [inline]
BUG: KMSAN: uninit-value in hfsplus_strcasecmp+0x1ca/0x770 fs/hfsplus/unicode.c:47
 case_fold fs/hfsplus/unicode.c:23 [inline]
 hfsplus_strcasecmp+0x1ca/0x770 fs/hfsplus/unicode.c:47
 hfsplus_cat_case_cmp_key+0xde/0x190 fs/hfsplus/catalog.c:26
 hfs_find_rec_by_key+0xb0/0x240 fs/hfsplus/bfind.c:100
 __hfsplus_brec_find+0x26b/0x7b0 fs/hfsplus/bfind.c:135
 hfsplus_brec_find+0x445/0x970 fs/hfsplus/bfind.c:195
 hfsplus_brec_read+0x46/0x1a0 fs/hfsplus/bfind.c:222
 hfsplus_fill_super+0x199a/0x26f0 fs/hfsplus/super.c:531
 mount_bdev+0x38f/0x510 fs/super.c:1658
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:647
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x560 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x73d/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x919/0xf80 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 hfsplus_find_init+0x91/0x250 fs/hfsplus/bfind.c:21
 hfsplus_fill_super+0x1688/0x26f0 fs/hfsplus/super.c:525
 mount_bdev+0x38f/0x510 fs/super.c:1658
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:647
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x560 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x73d/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

CPU: 0 PID: 5298 Comm: syz-executor.4 Not tainted 6.8.0-rc6-syzkaller-00238-g5ad3cb0ed525 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
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

