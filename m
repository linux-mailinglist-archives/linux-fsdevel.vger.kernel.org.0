Return-Path: <linux-fsdevel+bounces-14809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16487FBEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 11:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC38D1C20F7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394556444;
	Tue, 19 Mar 2024 10:40:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6542A82
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844805; cv=none; b=aDpgcdvMJIGzLnf5T5g6lRRcYDkg9EwvYBRrsiTfEcw4Gqs/0sLAw9+Vz1dD2bf8tkNRWYrXQ4vQHRahr10CJcv9LnULGxvBEYRmka6Y4oiOO5QZD6jtklKBfEMwjza89ktF4P9vaOlXiAs8/qTHBnMk5vH4fcJEgHV6mjE9XEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844805; c=relaxed/simple;
	bh=YDzUh/eQl+mEnGxwe5Gug0b7tbo2rKGScA/OLfLsBeo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ynt6N4x9TPXiGLeXbL36ugtdsEBuSg1E+CsmferseDnf8HruuUoDwFP0UEI/EsgqlfNZdAAeDE52cMjNiRc3plmZAGAyFS0V0+WQTKa/AhIZKdmCJWhHMWHYwPBPFt+UGt654GFS+F28XQcYiqaC+3yqLo6npRA0j/lPEWJ8XDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3684b6a0c94so4826465ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 03:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710844803; x=1711449603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cP3VvSaVvmQglW2lPvq1ZHeDi+uTFdnhbYpShcSJcJE=;
        b=kcJGP9+ult9+KVEB6C8/F7u6WoekF7CIgk/Q3NIjoqH1llphwVALPSsVREUb2rDyR9
         pAHE0gwE0G7Dfie0lsieUREYv/rO182qLPm/Ig9xrOdtC4YevirBnwWSc0RbVam5OieC
         jW0O5Z8JgA+gAd4rzaTwvgyUL9c4xeLhp66cMYjMn4s73kBmFYdscPwkjzxPn0p/ihdW
         /gNqvsSvFH7UA6lZTGw1c8MzN9RIeBu4+1fzOsVE1u/JhXJRpQ+PoDD8Gg8fifLCz7Vw
         l6yEVEKYZKJXRnFMJTRcunWz84+Lhc8RKNX7DYXbpzl8Ki3X8e6htMmo7vTTusMfSlDb
         uylA==
X-Forwarded-Encrypted: i=1; AJvYcCWJVwnM8tP0GvZs71w2ZS7bfuF+AThOVq89Mu/GN16f3jpXIbTRBPhQjHJc/kUEI388lHF+ON0RGGNoLEz35YtTVCIpE18fCoNDm2A4Xw==
X-Gm-Message-State: AOJu0Yy0Uhe57tG6i5x36eMjKHLa4sru4m3ROcyCtCWmc0y06muC9lz3
	3XNU6pCuKEYNPLtADt97ZCDnyyuDS8M2m/OfS087xZhrFpao/3zV+PtXQINtHM9AhritGrAEmj8
	CaSUmcJn8Pen8n31sI/ymb8aIZoXg9JZOmMsldtLVT5auHcLF8yUq/6A=
X-Google-Smtp-Source: AGHT+IFvsG5IdN9U7xP8X/k7Ypy7CjsO9580BstBbgc142+jM/jkuItQhABSrMzWqAurMfaURsFZoIxDt80B92I2eh947/VIKpm9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:368:4274:71c4 with SMTP id
 g7-20020a92cda7000000b00368427471c4mr177919ild.3.1710844803105; Tue, 19 Mar
 2024 03:40:03 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:40:03 -0700
In-Reply-To: <m27chy8qz8.fsf@Charalamposs-MacBook-Pro.local.mail-host-address-is-not-set>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c15e4306140118c9@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, charmitro@posteo.net, ericvh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in v9fs_evict_inode

=====================================================
BUG: KMSAN: uninit-value in v9fs_evict_inode+0x109/0x130 fs/9p/vfs_inode.c:356
 v9fs_evict_inode+0x109/0x130 fs/9p/vfs_inode.c:356
 evict+0x3ae/0xa60 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput+0x9ca/0xe10 fs/inode.c:1767
 iget_failed+0x15e/0x180 fs/bad_inode.c:248
 v9fs_fid_iget_dotl+0x375/0x570 fs/9p/vfs_inode_dotl.c:96
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0xc02/0x12b0 fs/9p/vfs_super.c:142
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

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
 kmem_cache_alloc_lru+0x6d7/0xbe0 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3089 [inline]
 v9fs_alloc_inode+0x62/0x130 fs/9p/vfs_inode.c:228
 alloc_inode+0x86/0x460 fs/inode.c:261
 iget_locked+0x2bf/0xee0 fs/inode.c:1280
 v9fs_fid_iget_dotl+0x7f/0x570 fs/9p/vfs_inode_dotl.c:62
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0xc02/0x12b0 fs/9p/vfs_super.c:142
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5499 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-11567-gb3603fcb79b1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


Tested on:

commit:         b3603fcb Merge tag 'dlm-6.9' of git://git.kernel.org/p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=175f8006180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d08e4cfe8c38e605
dashboard link: https://syzkaller.appspot.com/bug?extid=eb83fe1cce5833cd66a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1250b481180000


