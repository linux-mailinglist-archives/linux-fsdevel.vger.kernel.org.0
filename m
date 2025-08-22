Return-Path: <linux-fsdevel+bounces-58856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B067B322D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 21:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A29B640E36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FEC2D130C;
	Fri, 22 Aug 2025 19:28:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9012D12F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890906; cv=none; b=TWe8jX2+TQbKCySF2KAp/EVQdOyeMEjojOgoxTcs6sajcPJSRiM+jHutqphZAPtmBVqvuw7QlZ4hxz37W5dk2+lAZ/VM0qFsrVjNiG8JJ3lmz6+AUAQsTE4WxWNddhRmrA9/8Y5VZSkI4Rg7jWw1fJM2dgi/xckJBqeEoJzAIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890906; c=relaxed/simple;
	bh=35igRbOXzOT+aygBasJmYZRDoSWiSChONhMzreTISto=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bCQ+EphSN5O16hGdzI/8S0SGgEW7inKTS4KWGfi+AoG8hW5xOYqbq3vFkwqJMWhtvDxyLTPx5hFCEfvxCddd62viM/qZ7ZuyJvFeiai6/uISevFrIe2xqQBsBvOAzPQp9eEAsj7J9bqGk2IL27+DfwsWVaq0eL6nHXAqY7OxVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e6670d5bafso57024115ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 12:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890904; x=1756495704;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4R3au6CNsIn/pqv5n1ncdda6pzTzrRFDv2YWrqK32g=;
        b=WA+VZY9oPXnzD7HVjFCFi39XjQK+4tJJ4g8CXvwFdS7luXEMoMO4BkpbcAZAWXFJPb
         97JU8qViY4WsMz7RvqwCpFqCRohcHv4fIOnBK3pGejWjV2nvOY/CUbyMITJhqIRldX0O
         6BzoyS+AdvdBoRpyNUy4qYwgOMW9TVni+SEGEy+rmTLEWWPVE3957MAJNgmFYXN2l0Ge
         VOYW2nvn39dac+bcFTTymCgyjNw2H89mRUwvFS1cSti7xMjMG6CYcXitCYsFEwJkQDdy
         NEcdSjeH8/3sw950+JZ3lhYYjUgcdIbEB4Zcb2woSNBgw1Ubwt46Qfc2mjIVTvE16vZE
         9tGw==
X-Forwarded-Encrypted: i=1; AJvYcCU7s8av/k3wxEAwnXO7MhTMXgOcve+gmBpYBVZbPYzBbRk4dC1Zr/RxS957Jbl+M2l3TOgoA4FWjdguvy+o@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOitBkSU8xRB0yGvtIsF0G+qA+eEMGwN//BUKLk4khpFs2NvA
	Gvh7Yich5XNfd7RlKFvq5nL3bdE849awt0IKLO8PDhdnx9EtghhKdqAdLZVRyfHMxsv+Q8m3GYH
	QrDNMWY55VbMcVciqV/Upygl1Z2dHN+QtgUCQkpsgN1FXPP8OtNFPn36cgrs=
X-Google-Smtp-Source: AGHT+IG3U36EMnJ1g2gMt2B8U8DuDa3xFIgQkIPGGoFgSqtFehP53nVfp0x16ED8BLcY8flXUeXz6TWMwbwRdSbl8hZUTfb7NWqK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:3e5:5937:e576 with SMTP id
 e9e14a558f8ab-3e921581390mr67420845ab.13.1755890903892; Fri, 22 Aug 2025
 12:28:23 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:28:23 -0700
In-Reply-To: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a8c4d7.050a0220.37038e.005c.GAE@google.com>
Subject: [syzbot ci] Re: ovl: Enable support for casefold layers
From: syzbot ci <syzbot+cie307097d7feb4e34@syzkaller.appspotmail.com>
To: amir73il@gmail.com, andrealmeid@igalia.com, brauner@kernel.org, 
	jack@suse.cz, kernel-dev@igalia.com, krisman@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, tytso@mit.edu, 
	viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v6] ovl: Enable support for casefold layers
https://lore.kernel.org/all/20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com
* [PATCH v6 1/9] fs: Create sb_encoding() helper
* [PATCH v6 2/9] fs: Create sb_same_encoding() helper
* [PATCH v6 3/9] ovl: Prepare for mounting case-insensitive enabled layers
* [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded strncmp()
* [PATCH v6 5/9] ovl: Ensure that all layers have the same encoding
* [PATCH v6 6/9] ovl: Set case-insensitive dentry operations for ovl sb
* [PATCH v6 7/9] ovl: Add S_CASEFOLD as part of the inode flag to be copied
* [PATCH v6 8/9] ovl: Check for casefold consistency when creating new dentries
* [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers

and found the following issue:
WARNING in ovl_dentry_weird

Full report is available here:
https://ci.syzbot.org/series/efd002b5-e585-4cf8-86e7-4f24ba2247c7

***

WARNING in ovl_dentry_weird

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      068a56e56fa81e42fc5f08dff34fab149bb60a09
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/039eb31b-2b45-4207-b63e-71a25ed89f00/config
C repro:   https://ci.syzbot.org/findings/726ae90b-83b6-49e2-a496-9bfe444dc24f/c_repro
syz repro: https://ci.syzbot.org/findings/726ae90b-83b6-49e2-a496-9bfe444dc24f/syz_repro

EXT4-fs (loop0): 1 orphan inode deleted
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6001 at fs/overlayfs/ovl_entry.h:118 OVL_FS fs/overlayfs/ovl_entry.h:118 [inline]
WARNING: CPU: 0 PID: 6001 at fs/overlayfs/ovl_entry.h:118 ovl_dentry_weird+0x15a/0x1a0 fs/overlayfs/util.c:206
Modules linked in:
CPU: 0 UID: 0 PID: 6001 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:OVL_FS fs/overlayfs/ovl_entry.h:118 [inline]
RIP: 0010:ovl_dentry_weird+0x15a/0x1a0 fs/overlayfs/util.c:206
Code: e8 6b f9 8f fe 83 e5 03 0f 95 c3 31 ff 89 ee e8 9c fd 8f fe 89 d8 5b 41 5c 41 5e 41 5f 5d e9 3d b9 4c 08 cc e8 47 f9 8f fe 90 <0f> 0b 90 e9 08 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 0b
RSP: 0018:ffffc90002caf9c8 EFLAGS: 00010293
RAX: ffffffff832fb1e9 RBX: ffff888109730000 RCX: ffff888023295640
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802b624a48
RBP: dffffc0000000000 R08: 0000000030656c69 R09: 1ffff110048d0ce0
R10: dffffc0000000000 R11: ffffed10048d0ce1 R12: dffffc0000000000
R13: 0000000000000003 R14: ffff88802b624a48 R15: ffff888109730028
FS:  0000555581e17500(0000) GS:ffff8880b861b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 00000000242f4000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ovl_mount_dir_check fs/overlayfs/params.c:300 [inline]
 ovl_do_parse_layer+0x307/0xbb0 fs/overlayfs/params.c:422
 ovl_parse_layer fs/overlayfs/params.c:448 [inline]
 ovl_parse_param+0xb62/0xee0 fs/overlayfs/params.c:633
 vfs_parse_fs_param+0x1a9/0x420 fs/fs_context.c:146
 vfs_parse_fs_string fs/fs_context.c:188 [inline]
 vfs_parse_monolithic_sep+0x24d/0x310 fs/fs_context.c:230
 do_new_mount+0x273/0x9e0 fs/namespace.c:3804
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0c2558ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd67150878 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0c257b5fa0 RCX: 00007f0c2558ebe9
RDX: 0000200000000b80 RSI: 0000200000000100 RDI: 0000000000000000
RBP: 00007f0c25611e19 R08: 0000200000000180 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0c257b5fa0 R14: 00007f0c257b5fa0 R15: 0000000000000005
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

